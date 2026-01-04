#include <defs.h>
#include <list.h>
#include <proc.h>
#include <sched.h>
#include <stdio.h>
#include <assert.h>
#include <default_sched.h>

/* FIFO 调度器初始化 */
static void
fifo_init(struct run_queue *rq)
{
    /* 初始化就绪队列 */
    list_init(&rq->run_list);
    rq->proc_num = 0;
}

/* FIFO 调度器入队操作 */
static void
fifo_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
    /* 将进程加入队列尾部 */
    list_add_before(&rq->run_list, &proc->run_link);
    rq->proc_num++;
}

/* FIFO 调度器出队操作 */
static void
fifo_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
    /* 从队列头部移除进程 */
    list_del_init(&proc->run_link);
    rq->proc_num--;
}

/* FIFO 调度器选择下一个进程 */
static struct proc_struct *
fifo_pick_next(struct run_queue *rq)
{
    /* 返回队列头部的进程 */
    if (list_empty(&rq->run_list)) {
        return NULL;
    }
    return le2proc(rq->run_list.next, run_link);
}

/* FIFO 调度器进程时间片处理 */
static void
fifo_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    /* FIFO 中不需要特别处理时间片 */
    proc->need_resched = 1;
}

/* FIFO 调度器 */
struct sched_class fifo_sched_class = {
    .name = "FIFO_scheduler",
    .init = fifo_init,
    .enqueue = fifo_enqueue,
    .dequeue = fifo_dequeue,
    .pick_next = fifo_pick_next,
    .proc_tick = fifo_proc_tick,
};
