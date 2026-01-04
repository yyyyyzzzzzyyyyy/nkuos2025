#include <ulib.h>
#include <stdio.h>
#include <unistd.h>

static void
busy_loop(unsigned long cnt) {
    volatile unsigned long i;
    for (i = 0; i < cnt; i++);
}

int
main(void) {
    int pid;

    cprintf("\n===== SJF TEST START =====\n");

    /* 三个进程几乎同时到达 */

    /* P1：长作业 */
    if ((pid = fork()) == 0) {
        cprintf("[P1] long job start\n");
        busy_loop(80000000);
        cprintf("[P1] long job finish\n");
        exit(0);
    }

    /* P2：短作业 */
    if ((pid = fork()) == 0) {
        cprintf("[P2] short job start\n");
        busy_loop(20000000);
        cprintf("[P2] short job finish\n");
        exit(0);
    }

    /* P3：中等作业 */
    if ((pid = fork()) == 0) {
        cprintf("[P3] medium job start\n");
        busy_loop(50000000);
        cprintf("[P3] medium job finish\n");
        exit(0);
    }

    while (wait() > 0);
    cprintf("===== SJF TEST END =====\n\n");

    return 0;
}
