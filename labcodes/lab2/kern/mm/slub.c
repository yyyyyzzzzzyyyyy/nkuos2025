//SLUB核心逻辑：第一层：复用ucore已有的伙伴分配器（buddy_pmm），分配连续物理页（如 1 页、2 页，称为 “slab 块”）；第二层：在每个slab块中，按固定大小的小对象（如 16B、32B、64B）拆分，用链表管理空闲对象，实现 “按需分配 / 释放”。
//对象缓存：为每种大小的对象创建一个 “缓存池”，避免频繁拆分不同大小的块，提升效率。
//无元数据块：不单独存储slab元数据（如Linux的struct slab），而是将元数据（空闲链表头、对象大小）嵌入到slab块的头部，减少内存开销。
//只支持固定大小的对象，每个slab块仅包含一种大小的对象
//不支持slab块的合并（释放对象时仅放回空闲链表， slab 块满时不归还伙伴系统，简化回收逻辑）
//SLUB算法实现

#include <pmm.h>
#include <list.h>
#include <stdio.h>
#include <string.h>
#include <buddy_pmm.h>
#include <memlayout.h>
#include <mmu.h>
#include <slub.h>

//计算一个slab块（1页）能容纳的对象数：（页大小-头部大小）/对象大小
#define CALC_OBJS_PER_SLAB(cache)((PAGE_SIZE-SLAB_HEADER_SIZE)/cache->obj_size)
//对象缓存池的实现
//定义支持的对象大小
#define SLUB_OBJ_SIZES {8,16,32,64,128,256}
#define SLUB_OBJ_CNT 6//支持6种对象大小
//全局缓存池数组
kmem_cache_t slub_caches[SLUB_OBJ_CNT];
//常量定义
#define PAGE_SIZE 4096//页大小
#define SLAB_HEADER_SIZE sizeof(slab_header_t)//slab头部大小
//静态函数声明
static int slab_alloc(kmem_cache_t *cache);
static int slub_get_cache_idx(size_t req_size);
static void *page2va(struct Page *page);


//两层架构的实现：第一层（slab块分配）+第二层（对象分配）
//1.初始化slub_init
//为预设的6种对象大小创建对应的kmem_cache_t（缓存池）实例
//初始化每个缓存池的空闲对象链表、slab链表，计算obj_per_slab（每个slab块的对象数）
//注意：初始化时不分配slab块（按需分配，第一次分配对象时再从伙伴系统拿页）
//定义预设的对象大小数组
static const size_t g_obj_sizes[SLUB_OBJ_CNT]=SLUB_OBJ_SIZES;

//slub_init函数实现
void slub_init(void) {
    cprintf("SLUB: slub_init() called - starting initialization\n");

    //元数据初始化
    for (int i = 0;i < SLUB_OBJ_CNT;i++) {
        kmem_cache_t* cache = &slub_caches[i];
        cache->obj_size = g_obj_sizes[i];
        cache->obj_align = g_obj_sizes[i];
        cache->objs_per_slab = (PAGE_SIZE - SLAB_HEADER_SIZE) / cache->obj_size;

        cprintf("SLUB_DEBUG: initializing cache %d: obj_size=%d, objs_per_slab=%d\n",
            i, cache->obj_size, cache->objs_per_slab);

        //初始化链表（空闲对象链表、slab链表均为空）
        list_init(&cache->free_obj_list);
        list_init(&cache->slab_list);
        //初始状态：无空闲对象，需分配slab块
        cache->state = CACHE_NEED_SLAB;
    }
    cprintf("SLUB init done: %d cache pools (sizes: 8B,16B,32B,64B,128B,256B)\n", SLUB_OBJ_CNT);

    // 验证初始化结果
    cprintf("SLUB_DEBUG: verification - slub_caches address: %p\n", slub_caches);
    for (int i = 0;i < SLUB_OBJ_CNT;i++) {
        cprintf("SLUB_DEBUG: cache[%d] at %p, obj_size=%d\n",
            i, &slub_caches[i], slub_caches[i].obj_size);
    }
}
//2.第一层分配（slab块基于buddy系统的分配）
//调用buddy系统的alloc_pages(1)，获取1个连续物理页（返回struct Page*）
//将物理页地址转换为虚拟地址，在页的起始位置创建slab_header_t元数据
//拆分该页的剩余空间为”固定大小的对象“，用单链表链接所有空闲对象，挂到缓存池的free_obj_list
//工具函数page2va的实现
//物理页转虚拟地址
static void* page2va(struct Page* page) {
    return (void*)(page2pa(page) + PHYSICAL_MEMORY_OFFSET);
}
//函数slab_alloc的实现
//从buddy系统分配1个slab块（1页），并初始化给指定缓存池
static int slab_alloc(kmem_cache_t* cache) {
    cprintf("SLUB_DEBUG: slab_alloc called for cache size=%d\n", cache->obj_size);

    //用buddy分配器分配1页
    cprintf("SLUB_DEBUG: calling alloc_pages(1)...\n");
    struct Page* slab_page = alloc_pages(1);//分配1页
    if (slab_page == NULL) {
        cprintf("slab_alloc: buddy alloc failed (no free pages)\n");
        return -1;  // 分配失败
    }
    cprintf("SLUB_DEBUG: alloc_pages returned page=%p\n", slab_page);

    //验证slab_page是合法物理页（在pages数组范围内）
    cprintf("SLUB_DEBUG: checking page validity...\n");
    if (slab_page < pages || slab_page >= pages + npage) {
        cprintf("slab_alloc: invalid slab_page (%p)\n", slab_page);
        return -1;
    }
    cprintf("SLUB_DEBUG: page is valid\n");

    //转换为虚拟地址，初始化slab头部
    cprintf("SLUB_DEBUG: converting to virtual address...\n");
    void* slab_va = page2va(slab_page);//物理页转换为虚拟地址
    cprintf("SLUB_DEBUG: slab_va=%p\n", slab_va);

    slab_header_t* slab_hdr = (slab_header_t*)slab_va;
    slab_hdr->cache = cache;
    slab_hdr->slab_size = PAGE_SIZE;
    slab_hdr->free_obj_cnt = cache->objs_per_slab;
    cprintf("SLUB_DEBUG: slab header initialized\n");

    //将该slab块加入缓存池的slab链表
    cprintf("SLUB_DEBUG: adding to slab_list...\n");
    list_add(&cache->slab_list, &slab_hdr->slab_link);

    //拆分slab块为对象，构建空闲链表
    cprintf("SLUB_DEBUG: splitting slab into objects...\n");
    char* obj_va = (char*)slab_va + SLAB_HEADER_SIZE;//第一个对象地址
    list_entry_t* free_list = &cache->free_obj_list;

    cprintf("SLUB_DEBUG: creating %d objects...\n", cache->objs_per_slab);
    for (size_t i = 0;i < cache->objs_per_slab;i++) {
        //空闲对象的前4B作为链表节点（存储下一个对象地址）
        list_entry_t* obj_node = (list_entry_t*)obj_va;
        //将当前对象加入空闲链表
        list_add(free_list, obj_node);
        //移动到下一个对象
        obj_va += cache->obj_size;
    }

    //更新缓存池状态（存在空闲对象）
    cache->state = CACHE_AVAILABLE;
    cprintf("slab_alloc: success (cache=%dB, objs=%d, slab_va=%p)\n",
        cache->obj_size, cache->objs_per_slab, slab_va);
    return 0;
}
//3.第二层分配（任意大小的对象分配）
//用户申请任意大小的内存时，先向上对齐到最近的预设对象大小，再从对应缓存池的空闲链表中取一个对象，完成分配
//对象大小对齐：如用户申请20B，向上对齐到32B，找到32B对应的缓存池
//检查缓存池的状态：若缓存池无空闲对象，先调用slab_alloc分配新的slab块
//分配对象：从缓存池的free_obj_list中取下一个空闲对象，从链表中删除，返回对象的虚拟地址
//实现工具函数slub_get_cache_idx函数，用于将用户申请的大小向上对齐到预设的对象大小，返回对应的缓存池索引
static int slub_get_cache_idx(size_t req_size){
//遍历预设大小，找到第一个>=req_size的大小
for(int i=0;i<SLUB_OBJ_CNT;i++){
if(g_obj_sizes[i]>=req_size){
return i;
}
}
return -1;//超过最大对象大小，分配失败
}
//实现kmalloc函数用于对象分配
//SLUB对外接口：分配任意大小的内存
void* kmalloc(size_t size) {
    cprintf("SLUB_DEBUG: kmalloc(%d) called\n", size);

    //参数检查
    if (size == 0 || size > g_obj_sizes[SLUB_OBJ_CNT - 1]) {
        cprintf("kmalloc: invalid size (%dB, max=%dB)\n", size, g_obj_sizes[SLUB_OBJ_CNT - 1]);
        return NULL;
    }

    //找到对应的缓存池
    int cache_idx = slub_get_cache_idx(size);
    if (cache_idx == -1) {
        cprintf("SLUB_DEBUG: no suitable cache found\n");
        return NULL;
    }
    kmem_cache_t* cache = &slub_caches[cache_idx];
    cprintf("kmalloc: req=%dB → align=%dB (cache_idx=%d)\n", size, cache->obj_size, cache_idx);

    //若缓存池无空闲对象，先分配新的slab块
    if (cache->state == CACHE_NEED_SLAB || list_empty(&cache->free_obj_list)) {
        cprintf("SLUB_DEBUG: cache needs new slab, calling slab_alloc...\n");
        if (slab_alloc(cache) != 0) {
            cprintf("SLUB_DEBUG: slab_alloc failed\n");
            return NULL;//slab分配失败，对象分配也失败
        }
        cprintf("SLUB_DEBUG: slab_alloc succeeded\n");
    }

    //从空闲链表中取出一个对象
    cprintf("SLUB_DEBUG: getting object from free list...\n");
    list_entry_t* free_obj_node = list_next(&cache->free_obj_list);
    list_del(free_obj_node);//从链表中删除，标记为已分配

    //验证slab_list非空
    if (list_empty(&cache->slab_list)) {
        cprintf("kmalloc: no slab in cache (%dB)\n", cache->obj_size);
        return NULL;
    }

    //找到该对象所属的slab块，更新空闲对象计数
    list_entry_t* slab_le = cache->slab_list.next;
    slab_header_t* slab_hdr = list_entry(slab_le, slab_header_t, slab_link);//取第一个slab块
    slab_hdr->free_obj_cnt--;

    //返回对象的虚拟地址（链表节点的地址为虚拟地址）
    void* obj_va = (void*)free_obj_node;
    cprintf("kmalloc: success (obj_va=%p, size=%dB)\n", obj_va, cache->obj_size);
    return obj_va;
}
//4.对象释放kfree
//直接将对象放回对应的缓存池空闲链表，不回收slab块
//找到对象所属的缓存池：通过对象地址计算其所在的slab块，obj_va向下对齐到页大小，得到slab块头部地址
//检查对象合法性：确保对象地址正确在slab块内且未重复释放
//放回空闲链表：将对象的地址作为链表节点，插入缓存池的free_obj_list,更新slab块的空闲对象计数
//SLUB对外接口：释放kmalloc分配的内存
void kfree(void *obj_va){
//参数检查
if(obj_va==NULL){
return;
}
//找到对象所属的slab块
uintptr_t slab_va=(uintptr_t)obj_va & ~(PAGE_SIZE - 1);
slab_header_t *slab_hdr=(slab_header_t *)slab_va;
//验证slab_hdr的cache字段是合法缓存池（在slub_caches数组范围内）
if (slab_hdr->cache < slub_caches || slab_hdr->cache >= slub_caches + SLUB_OBJ_CNT) {
cprintf("kfree: invalid cache for slab_hdr (%p)\n", slab_hdr);
return;
}
kmem_cache_t *cache=slab_hdr->cache;
//验证对象合法性
uintptr_t obj_min_va = slab_va + SLAB_HEADER_SIZE;
uintptr_t obj_max_va = slab_va + PAGE_SIZE;
if ((uintptr_t)obj_va < obj_min_va || (uintptr_t)obj_va >= obj_max_va) {
cprintf("kfree: invalid obj_va (%p, slab_va=%p)\n", obj_va, (void *)slab_va);
return;
}
//将对象放回缓存池的空闲链表
list_entry_t *obj_node=(list_entry_t*)obj_va;
list_add(&cache->free_obj_list,obj_node);
//更新slab块的空闲对象计数
slab_hdr->free_obj_cnt++;
cprintf("kfree: success (obj_va=%p, cache=%dB)\n", obj_va, cache->obj_size);
}


//测试用例
void slub_alloc_free_verification(void) {
    cprintf("\n=== Starting SLUB Allocator Verification ===\n");

    // 测试1: 基本分配释放
    cprintf("\n[Test 1] Basic allocation and free\n");
    void* ptr1 = kmalloc(32);
    if (ptr1 != NULL) {
        cprintf(" Allocated 32 bytes at %p\n", ptr1);
        // 写入测试数据
        memset(ptr1, 0xAA, 32);
        cprintf(" Successfully wrote test pattern to allocated memory\n");

        kfree(ptr1);
        cprintf(" Freed 32 bytes\n");
    }
    else {
        cprintf(" Failed to allocate 32 bytes\n");
    }

    // 测试2: 不同大小的分配
    cprintf("\n[Test 2] Different size allocations\n");
    size_t sizes[] = { 8, 16, 32, 64, 128, 256, 512, 1024 };
    void* pointers[8];

    for (int i = 0; i < 8; i++) {
        pointers[i] = kmalloc(sizes[i]);
        if (pointers[i] != NULL) {
            cprintf(" Allocated %d bytes at %p\n", sizes[i], pointers[i]);
            // 写入唯一模式以便验证
            memset(pointers[i], 0xA0 + i, sizes[i]);
        }
        else {
            cprintf(" Failed to allocate %d bytes\n", sizes[i]);
        }
    }

    // 验证数据完整性
    cprintf("\n[Test 3] Data integrity check\n");
    for (int i = 0; i < 8; i++) {
        if (pointers[i] != NULL) {
            // 检查第一个字节是否正确
            if (*((char*)pointers[i]) == (char)(0xA0 + i)) {
                cprintf(" Data integrity verified for %d bytes block\n", sizes[i]);
            }
            else {
                cprintf(" Data corruption detected for %d bytes block\n", sizes[i]);
            }
        }
    }

    // 测试4: 释放所有分配的内存
    cprintf("\n[Test 4] Free all allocated blocks\n");
    for (int i = 0; i < 8; i++) {
        if (pointers[i] != NULL) {
            kfree(pointers[i]);
            cprintf(" Freed %d bytes block\n", sizes[i]);
        }
    }

    // 测试5: 重复分配释放测试（检测内存泄漏）
    cprintf("\n[Test 5] Repeated allocation/free cycle\n");
    for (int cycle = 0; cycle < 3; cycle++) {
        void* temp_ptr = kmalloc(128);
        if (temp_ptr != NULL) {
            memset(temp_ptr, 0xCC, 128);
            kfree(temp_ptr);
            cprintf(" Cycle %d: 128 bytes allocated and freed\n", cycle + 1);
        }
    }

    // 测试6: 边界情况测试
    cprintf("\n[Test 6] Boundary cases\n");
    // 测试0字节分配（应该返回NULL或有效指针，取决于实现）
    void* zero_alloc = kmalloc(0);
    cprintf("Zero byte allocation: %p\n", zero_alloc);
    if (zero_alloc != NULL) {
        kfree(zero_alloc);
    }

    // 测试大分配
    void* large_alloc = kmalloc(2048);
    if (large_alloc != NULL) {
        cprintf(" Large allocation (2048 bytes) successful at %p\n", large_alloc);
        kfree(large_alloc);
        cprintf(" Large allocation freed\n");
    }
    else {
        cprintf(" Large allocation failed\n");
    }

    // 测试7: 集成功能测试
    cprintf("\n[Test 7] Integrated functionality test\n");
    char* str1 = (char*)kmalloc(50);
    char* str2 = (char*)kmalloc(50);

    if (str1 && str2) {
        strcpy(str1, "Hello SLUB Allocator");
        strcpy(str2, "Memory Management Test");

        cprintf(" String 1: '%s' at %p\n", str1, str1);
        cprintf(" String 2: '%s' at %p\n", str2, str2);

        // 验证字符串内容
        assert(strcmp(str1, "Hello SLUB Allocator") == 0);
        assert(strcmp(str2, "Memory Management Test") == 0);
        cprintf(" String content verification passed\n");

        kfree(str1);
        kfree(str2);
        cprintf(" Integrated test blocks freed\n");
    }

    cprintf("\n=== SLUB Allocator Verification Completed ===\n");
}