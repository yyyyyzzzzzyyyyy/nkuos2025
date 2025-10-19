#include<pmm.h>
#include<list.h>
//1.定义最大块大小的指数（根据系统总页数npage计算）
#define MAX_ORDER 10//假设为10
#define PAGE_SIZE 4096//假设页大小与ucore相同即4KB
//2.按块大小管理空闲块：每一个order对应一个free_area_t
typedef struct{
free_area_t free_areas[MAX_ORDER];//free_areas[order]管理2^order页的空闲块
}buddy_free_area_t;
//3.声明全局伙伴分配器管理结构
extern buddy_free_area_t buddy_free_area;
//4.声明伙伴分配器函数
extern const struct pmm_manager buddy_pmm_manager;