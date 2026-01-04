#include <defs.h>
#include <list.h>
#include <proc.h>
#include <assert.h>
#include <default_sched.h>
#include <stdio.h>

// 定义宏，将闲置的lab6_priority字段映射为predicted_burst_time，增强代码可读性
#define predicted_burst_time lab6_priority

/* SJF 调度器初始化 */
static void
sjf_init(struct run_queue* rq)
{
    /* 初始化就绪队列 */
    list_init(&rq->run_list);
    rq->proc_num = 0;
}

/* SJF 调度器入队操作，按照进程估计运行时间排序 */
static void
sjf_enqueue(struct run_queue* rq, struct proc_struct* proc)
{
    // 初始化：如果进程的预测时间未设置，赋予默认值（比如5）
    if (proc->predicted_burst_time == 0) {
        proc->predicted_burst_time = 5; // 默认预测运行时间，可根据需求调整
    }

    list_entry_t* le = rq->run_list.next;  // 从头开始遍历链表
    struct proc_struct* p;

    /* 遍历队列，找到插入位置（按预计执行时间升序） */
    while (le != &rq->run_list) {
        p = le2proc(le, run_link);
        if (proc->predicted_burst_time < p->predicted_burst_time) {
            break;
        }
        le = list_next(le);  // 移动到下一个节点
    }

    /* 在找到的插入位置插入 */
    list_add_before(le, &proc->run_link);
    rq->proc_num++;
}

/* SJF 调度器出队操作 */
static void
sjf_dequeue(struct run_queue* rq, struct proc_struct* proc)
{
    /* 从队列中移除进程 */
    list_del_init(&proc->run_link);
    rq->proc_num--;
}

/* SJF 调度器选择下一个进程 */
static struct proc_struct*
sjf_pick_next(struct run_queue* rq)
{
    /* 返回队列头部的进程（最短预测时间） */
    if (list_empty(&rq->run_list)) {
        return NULL;
    }
    return le2proc(rq->run_list.next, run_link);
}

/* SJF 调度器进程时间片处理 */
static void
sjf_proc_tick(struct run_queue* rq, struct proc_struct* proc)
{
    /* 非抢占式SJF：这里可以根据实际需求调整，比如统计实际运行时间后更新预测值 */
    proc->predicted_burst_time--; // 模拟运行时间消耗
    proc->need_resched = 1;
}

/* SJF 调度器 */
struct sched_class sjf_sched_class = {
    .name = "RR_scheduler",
    .init = sjf_init,
    .enqueue = sjf_enqueue,
    .dequeue = sjf_dequeue,
    .pick_next = sjf_pick_next,
    .proc_tick = sjf_proc_tick,
};