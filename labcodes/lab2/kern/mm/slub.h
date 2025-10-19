#ifndef __KERN_MM_SLUB_H__
#define __KERN_MM_SLUB_H__

#include <defs.h>
#include <list.h>
#include <stdio.h>


// 1. 声明缓存池状态枚举
//缓存池状态：区分”有空闲对象“”无空闲需重新分配slab块“
typedef enum {
    CACHE_AVAILABLE,
    CACHE_NEED_SLAB
} kmem_cache_state_t;

// 2. 前向声明缓存池结构体（避免循环依赖）
typedef struct kmem_cache kmem_cache_t;

//Slab块元数据
//每个从伙伴系统分配的”连续页块“，头部需存储元数据，记录该slab块的归属和对象管理信息
// 3. 声明 slab 块头部结构体
typedef struct slab_header{
kmem_cache_t *cache;//指向该slab所属的缓存池
size_t slab_size;//slab块的总大小
size_t free_obj_cnt;//该slab块中剩余的空闲对象数
list_entry_t slab_link;//链接到所属缓存池的slab_list链表
}slab_header_t;

// 4. 声明缓存池结构体
//对象缓存池结构体
typedef struct kmem_cache{
size_t obj_size;//该缓存池管理的对象大小
size_t obj_align;//对象对齐要求
size_t objs_per_slab;//每个slab块能容纳的对象数（= 页大小 / 对象大小，需扣除元数据）
list_entry_t free_obj_list;//空闲对象链表（存储对象的物理地址或指针）
list_entry_t slab_list;//该缓存池管理的所有slab块链表（存储slab块头部地址）
kmem_cache_state_t state;//缓存池状态
}kmem_cache_t;

// 5. 声明 SLUB 对外接口函数（供其他文件调用）
void slub_init(void);                  // SLUB 初始化
// 对外接口声明
void *kmalloc(size_t size);            // 对象分配
void kfree(void *obj_va);              // 对象释放
// 测试函数声明
void slub_alloc_free_verification(void);

#endif /* __KERN_MM_SLUB_H__ */