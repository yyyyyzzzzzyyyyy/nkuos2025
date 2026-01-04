#include <ulib.h>
#include <stdio.h>

static void
busy_loop(unsigned long cnt) {
    volatile unsigned long i;
    for (i = 0; i < cnt; i++);
}

int
main(void) {
    int pid;

    cprintf("\n===== FIFO TEST START =====\n");

    /* P1：最先到达，长作业 */
    if ((pid = fork()) == 0) {
        cprintf("[P1] long job start\n");
        busy_loop(80000000);
        cprintf("[P1] long job finish\n");
        exit(0);
    }

    /* 主动让出 CPU，保证 P1 先进入就绪队列 */
    yield();

    /* P2：短作业 */
    if ((pid = fork()) == 0) {
        cprintf("[P2] short job start\n");
        busy_loop(20000000);
        cprintf("[P2] short job finish\n");
        exit(0);
    }

    yield();

    /* P3：中等作业 */
    if ((pid = fork()) == 0) {
        cprintf("[P3] medium job start\n");
        busy_loop(50000000);
        cprintf("[P3] medium job finish\n");
        exit(0);
    }

    while (wait() > 0);
    cprintf("===== FIFO TEST END =====\n");

    return 0;
}
