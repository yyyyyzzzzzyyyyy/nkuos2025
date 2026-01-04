
obj/__user_fifo_test.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <_start>:
    # move down the esp register
    # since it may cause page fault in backtrace
    // subl $0x20, %esp

    # call user-program function
    call umain
  800020:	0ca000ef          	jal	ra,8000ea <umain>
1:  j 1b
  800024:	a001                	j	800024 <_start+0x4>

0000000000800026 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  800026:	1141                	addi	sp,sp,-16
  800028:	e022                	sd	s0,0(sp)
  80002a:	e406                	sd	ra,8(sp)
  80002c:	842e                	mv	s0,a1
    sys_putc(c);
  80002e:	096000ef          	jal	ra,8000c4 <sys_putc>
    (*cnt) ++;
  800032:	401c                	lw	a5,0(s0)
}
  800034:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
  800036:	2785                	addiw	a5,a5,1
  800038:	c01c                	sw	a5,0(s0)
}
  80003a:	6402                	ld	s0,0(sp)
  80003c:	0141                	addi	sp,sp,16
  80003e:	8082                	ret

0000000000800040 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  800040:	711d                	addi	sp,sp,-96
    va_list ap;

    va_start(ap, fmt);
  800042:	02810313          	addi	t1,sp,40
cprintf(const char *fmt, ...) {
  800046:	8e2a                	mv	t3,a0
  800048:	f42e                	sd	a1,40(sp)
  80004a:	f832                	sd	a2,48(sp)
  80004c:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80004e:	00000517          	auipc	a0,0x0
  800052:	fd850513          	addi	a0,a0,-40 # 800026 <cputch>
  800056:	004c                	addi	a1,sp,4
  800058:	869a                	mv	a3,t1
  80005a:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
  80005c:	ec06                	sd	ra,24(sp)
  80005e:	e0ba                	sd	a4,64(sp)
  800060:	e4be                	sd	a5,72(sp)
  800062:	e8c2                	sd	a6,80(sp)
  800064:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
  800066:	e41a                	sd	t1,8(sp)
    int cnt = 0;
  800068:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80006a:	0f8000ef          	jal	ra,800162 <vprintfmt>
    int cnt = vcprintf(fmt, ap);
    va_end(ap);

    return cnt;
}
  80006e:	60e2                	ld	ra,24(sp)
  800070:	4512                	lw	a0,4(sp)
  800072:	6125                	addi	sp,sp,96
  800074:	8082                	ret

0000000000800076 <syscall>:
#include <syscall.h>

#define MAX_ARGS            5

static inline int
syscall(int64_t num, ...) {
  800076:	7175                	addi	sp,sp,-144
  800078:	f8ba                	sd	a4,112(sp)
    va_list ap;
    va_start(ap, num);
    uint64_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
        a[i] = va_arg(ap, uint64_t);
  80007a:	e0ba                	sd	a4,64(sp)
  80007c:	0118                	addi	a4,sp,128
syscall(int64_t num, ...) {
  80007e:	e42a                	sd	a0,8(sp)
  800080:	ecae                	sd	a1,88(sp)
  800082:	f0b2                	sd	a2,96(sp)
  800084:	f4b6                	sd	a3,104(sp)
  800086:	fcbe                	sd	a5,120(sp)
  800088:	e142                	sd	a6,128(sp)
  80008a:	e546                	sd	a7,136(sp)
        a[i] = va_arg(ap, uint64_t);
  80008c:	f42e                	sd	a1,40(sp)
  80008e:	f832                	sd	a2,48(sp)
  800090:	fc36                	sd	a3,56(sp)
  800092:	f03a                	sd	a4,32(sp)
  800094:	e4be                	sd	a5,72(sp)
    }
    va_end(ap);
    asm volatile (
  800096:	4522                	lw	a0,8(sp)
  800098:	55a2                	lw	a1,40(sp)
  80009a:	5642                	lw	a2,48(sp)
  80009c:	56e2                	lw	a3,56(sp)
  80009e:	4706                	lw	a4,64(sp)
  8000a0:	47a6                	lw	a5,72(sp)
  8000a2:	00000073          	ecall
  8000a6:	ce2a                	sw	a0,28(sp)
          "m" (a[3]),
          "m" (a[4])
        : "memory"
      );
    return ret;
}
  8000a8:	4572                	lw	a0,28(sp)
  8000aa:	6149                	addi	sp,sp,144
  8000ac:	8082                	ret

00000000008000ae <sys_exit>:

int
sys_exit(int64_t error_code) {
  8000ae:	85aa                	mv	a1,a0
    return syscall(SYS_exit, error_code);
  8000b0:	4505                	li	a0,1
  8000b2:	b7d1                	j	800076 <syscall>

00000000008000b4 <sys_fork>:
}

int
sys_fork(void) {
    return syscall(SYS_fork);
  8000b4:	4509                	li	a0,2
  8000b6:	b7c1                	j	800076 <syscall>

00000000008000b8 <sys_wait>:
}

int
sys_wait(int64_t pid, int *store) {
  8000b8:	862e                	mv	a2,a1
    return syscall(SYS_wait, pid, store);
  8000ba:	85aa                	mv	a1,a0
  8000bc:	450d                	li	a0,3
  8000be:	bf65                	j	800076 <syscall>

00000000008000c0 <sys_yield>:
}

int
sys_yield(void) {
    return syscall(SYS_yield);
  8000c0:	4529                	li	a0,10
  8000c2:	bf55                	j	800076 <syscall>

00000000008000c4 <sys_putc>:
sys_getpid(void) {
    return syscall(SYS_getpid);
}

int
sys_putc(int64_t c) {
  8000c4:	85aa                	mv	a1,a0
    return syscall(SYS_putc, c);
  8000c6:	4579                	li	a0,30
  8000c8:	b77d                	j	800076 <syscall>

00000000008000ca <exit>:
#include <syscall.h>
#include <stdio.h>
#include <ulib.h>

void
exit(int error_code) {
  8000ca:	1141                	addi	sp,sp,-16
  8000cc:	e406                	sd	ra,8(sp)
    sys_exit(error_code);
  8000ce:	fe1ff0ef          	jal	ra,8000ae <sys_exit>
    cprintf("BUG: exit failed.\n");
  8000d2:	00000517          	auipc	a0,0x0
  8000d6:	51650513          	addi	a0,a0,1302 # 8005e8 <main+0xe8>
  8000da:	f67ff0ef          	jal	ra,800040 <cprintf>
    while (1);
  8000de:	a001                	j	8000de <exit+0x14>

00000000008000e0 <fork>:
}

int
fork(void) {
    return sys_fork();
  8000e0:	bfd1                	j	8000b4 <sys_fork>

00000000008000e2 <wait>:
}

int
wait(void) {
    return sys_wait(0, NULL);
  8000e2:	4581                	li	a1,0
  8000e4:	4501                	li	a0,0
  8000e6:	bfc9                	j	8000b8 <sys_wait>

00000000008000e8 <yield>:
    return sys_wait(pid, store);
}

void
yield(void) {
    sys_yield();
  8000e8:	bfe1                	j	8000c0 <sys_yield>

00000000008000ea <umain>:
#include <ulib.h>

int main(void);

void
umain(void) {
  8000ea:	1141                	addi	sp,sp,-16
  8000ec:	e406                	sd	ra,8(sp)
    int ret = main();
  8000ee:	412000ef          	jal	ra,800500 <main>
    exit(ret);
  8000f2:	fd9ff0ef          	jal	ra,8000ca <exit>

00000000008000f6 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
  8000f6:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  8000fa:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
  8000fc:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  800100:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
  800102:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
  800106:	f022                	sd	s0,32(sp)
  800108:	ec26                	sd	s1,24(sp)
  80010a:	e84a                	sd	s2,16(sp)
  80010c:	f406                	sd	ra,40(sp)
  80010e:	e44e                	sd	s3,8(sp)
  800110:	84aa                	mv	s1,a0
  800112:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  800114:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
  800118:	2a01                	sext.w	s4,s4
    if (num >= base) {
  80011a:	03067e63          	bgeu	a2,a6,800156 <printnum+0x60>
  80011e:	89be                	mv	s3,a5
        while (-- width > 0)
  800120:	00805763          	blez	s0,80012e <printnum+0x38>
  800124:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
  800126:	85ca                	mv	a1,s2
  800128:	854e                	mv	a0,s3
  80012a:	9482                	jalr	s1
        while (-- width > 0)
  80012c:	fc65                	bnez	s0,800124 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  80012e:	1a02                	slli	s4,s4,0x20
  800130:	00000797          	auipc	a5,0x0
  800134:	4d078793          	addi	a5,a5,1232 # 800600 <main+0x100>
  800138:	020a5a13          	srli	s4,s4,0x20
  80013c:	9a3e                	add	s4,s4,a5
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
  80013e:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
  800140:	000a4503          	lbu	a0,0(s4)
}
  800144:	70a2                	ld	ra,40(sp)
  800146:	69a2                	ld	s3,8(sp)
  800148:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
  80014a:	85ca                	mv	a1,s2
  80014c:	87a6                	mv	a5,s1
}
  80014e:	6942                	ld	s2,16(sp)
  800150:	64e2                	ld	s1,24(sp)
  800152:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
  800154:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
  800156:	03065633          	divu	a2,a2,a6
  80015a:	8722                	mv	a4,s0
  80015c:	f9bff0ef          	jal	ra,8000f6 <printnum>
  800160:	b7f9                	j	80012e <printnum+0x38>

0000000000800162 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  800162:	7119                	addi	sp,sp,-128
  800164:	f4a6                	sd	s1,104(sp)
  800166:	f0ca                	sd	s2,96(sp)
  800168:	ecce                	sd	s3,88(sp)
  80016a:	e8d2                	sd	s4,80(sp)
  80016c:	e4d6                	sd	s5,72(sp)
  80016e:	e0da                	sd	s6,64(sp)
  800170:	fc5e                	sd	s7,56(sp)
  800172:	f06a                	sd	s10,32(sp)
  800174:	fc86                	sd	ra,120(sp)
  800176:	f8a2                	sd	s0,112(sp)
  800178:	f862                	sd	s8,48(sp)
  80017a:	f466                	sd	s9,40(sp)
  80017c:	ec6e                	sd	s11,24(sp)
  80017e:	892a                	mv	s2,a0
  800180:	84ae                	mv	s1,a1
  800182:	8d32                	mv	s10,a2
  800184:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800186:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
  80018a:	5b7d                	li	s6,-1
  80018c:	00000a97          	auipc	s5,0x0
  800190:	4a8a8a93          	addi	s5,s5,1192 # 800634 <main+0x134>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800194:	00000b97          	auipc	s7,0x0
  800198:	6bcb8b93          	addi	s7,s7,1724 # 800850 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  80019c:	000d4503          	lbu	a0,0(s10)
  8001a0:	001d0413          	addi	s0,s10,1
  8001a4:	01350a63          	beq	a0,s3,8001b8 <vprintfmt+0x56>
            if (ch == '\0') {
  8001a8:	c121                	beqz	a0,8001e8 <vprintfmt+0x86>
            putch(ch, putdat);
  8001aa:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001ac:	0405                	addi	s0,s0,1
            putch(ch, putdat);
  8001ae:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001b0:	fff44503          	lbu	a0,-1(s0)
  8001b4:	ff351ae3          	bne	a0,s3,8001a8 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
  8001b8:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
  8001bc:	02000793          	li	a5,32
        lflag = altflag = 0;
  8001c0:	4c81                	li	s9,0
  8001c2:	4881                	li	a7,0
        width = precision = -1;
  8001c4:	5c7d                	li	s8,-1
  8001c6:	5dfd                	li	s11,-1
  8001c8:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
  8001cc:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
  8001ce:	fdd6059b          	addiw	a1,a2,-35
  8001d2:	0ff5f593          	zext.b	a1,a1
  8001d6:	00140d13          	addi	s10,s0,1
  8001da:	04b56263          	bltu	a0,a1,80021e <vprintfmt+0xbc>
  8001de:	058a                	slli	a1,a1,0x2
  8001e0:	95d6                	add	a1,a1,s5
  8001e2:	4194                	lw	a3,0(a1)
  8001e4:	96d6                	add	a3,a3,s5
  8001e6:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  8001e8:	70e6                	ld	ra,120(sp)
  8001ea:	7446                	ld	s0,112(sp)
  8001ec:	74a6                	ld	s1,104(sp)
  8001ee:	7906                	ld	s2,96(sp)
  8001f0:	69e6                	ld	s3,88(sp)
  8001f2:	6a46                	ld	s4,80(sp)
  8001f4:	6aa6                	ld	s5,72(sp)
  8001f6:	6b06                	ld	s6,64(sp)
  8001f8:	7be2                	ld	s7,56(sp)
  8001fa:	7c42                	ld	s8,48(sp)
  8001fc:	7ca2                	ld	s9,40(sp)
  8001fe:	7d02                	ld	s10,32(sp)
  800200:	6de2                	ld	s11,24(sp)
  800202:	6109                	addi	sp,sp,128
  800204:	8082                	ret
            padc = '0';
  800206:	87b2                	mv	a5,a2
            goto reswitch;
  800208:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  80020c:	846a                	mv	s0,s10
  80020e:	00140d13          	addi	s10,s0,1
  800212:	fdd6059b          	addiw	a1,a2,-35
  800216:	0ff5f593          	zext.b	a1,a1
  80021a:	fcb572e3          	bgeu	a0,a1,8001de <vprintfmt+0x7c>
            putch('%', putdat);
  80021e:	85a6                	mv	a1,s1
  800220:	02500513          	li	a0,37
  800224:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
  800226:	fff44783          	lbu	a5,-1(s0)
  80022a:	8d22                	mv	s10,s0
  80022c:	f73788e3          	beq	a5,s3,80019c <vprintfmt+0x3a>
  800230:	ffed4783          	lbu	a5,-2(s10)
  800234:	1d7d                	addi	s10,s10,-1
  800236:	ff379de3          	bne	a5,s3,800230 <vprintfmt+0xce>
  80023a:	b78d                	j	80019c <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
  80023c:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
  800240:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  800244:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
  800246:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
  80024a:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  80024e:	02d86463          	bltu	a6,a3,800276 <vprintfmt+0x114>
                ch = *fmt;
  800252:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
  800256:	002c169b          	slliw	a3,s8,0x2
  80025a:	0186873b          	addw	a4,a3,s8
  80025e:	0017171b          	slliw	a4,a4,0x1
  800262:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
  800264:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
  800268:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
  80026a:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
  80026e:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  800272:	fed870e3          	bgeu	a6,a3,800252 <vprintfmt+0xf0>
            if (width < 0)
  800276:	f40ddce3          	bgez	s11,8001ce <vprintfmt+0x6c>
                width = precision, precision = -1;
  80027a:	8de2                	mv	s11,s8
  80027c:	5c7d                	li	s8,-1
  80027e:	bf81                	j	8001ce <vprintfmt+0x6c>
            if (width < 0)
  800280:	fffdc693          	not	a3,s11
  800284:	96fd                	srai	a3,a3,0x3f
  800286:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
  80028a:	00144603          	lbu	a2,1(s0)
  80028e:	2d81                	sext.w	s11,s11
  800290:	846a                	mv	s0,s10
            goto reswitch;
  800292:	bf35                	j	8001ce <vprintfmt+0x6c>
            precision = va_arg(ap, int);
  800294:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
  800298:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
  80029c:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
  80029e:	846a                	mv	s0,s10
            goto process_precision;
  8002a0:	bfd9                	j	800276 <vprintfmt+0x114>
    if (lflag >= 2) {
  8002a2:	4705                	li	a4,1
            precision = va_arg(ap, int);
  8002a4:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  8002a8:	01174463          	blt	a4,a7,8002b0 <vprintfmt+0x14e>
    else if (lflag) {
  8002ac:	1a088e63          	beqz	a7,800468 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
  8002b0:	000a3603          	ld	a2,0(s4)
  8002b4:	46c1                	li	a3,16
  8002b6:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
  8002b8:	2781                	sext.w	a5,a5
  8002ba:	876e                	mv	a4,s11
  8002bc:	85a6                	mv	a1,s1
  8002be:	854a                	mv	a0,s2
  8002c0:	e37ff0ef          	jal	ra,8000f6 <printnum>
            break;
  8002c4:	bde1                	j	80019c <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
  8002c6:	000a2503          	lw	a0,0(s4)
  8002ca:	85a6                	mv	a1,s1
  8002cc:	0a21                	addi	s4,s4,8
  8002ce:	9902                	jalr	s2
            break;
  8002d0:	b5f1                	j	80019c <vprintfmt+0x3a>
    if (lflag >= 2) {
  8002d2:	4705                	li	a4,1
            precision = va_arg(ap, int);
  8002d4:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  8002d8:	01174463          	blt	a4,a7,8002e0 <vprintfmt+0x17e>
    else if (lflag) {
  8002dc:	18088163          	beqz	a7,80045e <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
  8002e0:	000a3603          	ld	a2,0(s4)
  8002e4:	46a9                	li	a3,10
  8002e6:	8a2e                	mv	s4,a1
  8002e8:	bfc1                	j	8002b8 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
  8002ea:	00144603          	lbu	a2,1(s0)
            altflag = 1;
  8002ee:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
  8002f0:	846a                	mv	s0,s10
            goto reswitch;
  8002f2:	bdf1                	j	8001ce <vprintfmt+0x6c>
            putch(ch, putdat);
  8002f4:	85a6                	mv	a1,s1
  8002f6:	02500513          	li	a0,37
  8002fa:	9902                	jalr	s2
            break;
  8002fc:	b545                	j	80019c <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
  8002fe:	00144603          	lbu	a2,1(s0)
            lflag ++;
  800302:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
  800304:	846a                	mv	s0,s10
            goto reswitch;
  800306:	b5e1                	j	8001ce <vprintfmt+0x6c>
    if (lflag >= 2) {
  800308:	4705                	li	a4,1
            precision = va_arg(ap, int);
  80030a:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  80030e:	01174463          	blt	a4,a7,800316 <vprintfmt+0x1b4>
    else if (lflag) {
  800312:	14088163          	beqz	a7,800454 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
  800316:	000a3603          	ld	a2,0(s4)
  80031a:	46a1                	li	a3,8
  80031c:	8a2e                	mv	s4,a1
  80031e:	bf69                	j	8002b8 <vprintfmt+0x156>
            putch('0', putdat);
  800320:	03000513          	li	a0,48
  800324:	85a6                	mv	a1,s1
  800326:	e03e                	sd	a5,0(sp)
  800328:	9902                	jalr	s2
            putch('x', putdat);
  80032a:	85a6                	mv	a1,s1
  80032c:	07800513          	li	a0,120
  800330:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  800332:	0a21                	addi	s4,s4,8
            goto number;
  800334:	6782                	ld	a5,0(sp)
  800336:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  800338:	ff8a3603          	ld	a2,-8(s4)
            goto number;
  80033c:	bfb5                	j	8002b8 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
  80033e:	000a3403          	ld	s0,0(s4)
  800342:	008a0713          	addi	a4,s4,8
  800346:	e03a                	sd	a4,0(sp)
  800348:	14040263          	beqz	s0,80048c <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
  80034c:	0fb05763          	blez	s11,80043a <vprintfmt+0x2d8>
  800350:	02d00693          	li	a3,45
  800354:	0cd79163          	bne	a5,a3,800416 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800358:	00044783          	lbu	a5,0(s0)
  80035c:	0007851b          	sext.w	a0,a5
  800360:	cf85                	beqz	a5,800398 <vprintfmt+0x236>
  800362:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
  800366:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  80036a:	000c4563          	bltz	s8,800374 <vprintfmt+0x212>
  80036e:	3c7d                	addiw	s8,s8,-1
  800370:	036c0263          	beq	s8,s6,800394 <vprintfmt+0x232>
                    putch('?', putdat);
  800374:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
  800376:	0e0c8e63          	beqz	s9,800472 <vprintfmt+0x310>
  80037a:	3781                	addiw	a5,a5,-32
  80037c:	0ef47b63          	bgeu	s0,a5,800472 <vprintfmt+0x310>
                    putch('?', putdat);
  800380:	03f00513          	li	a0,63
  800384:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800386:	000a4783          	lbu	a5,0(s4)
  80038a:	3dfd                	addiw	s11,s11,-1
  80038c:	0a05                	addi	s4,s4,1
  80038e:	0007851b          	sext.w	a0,a5
  800392:	ffe1                	bnez	a5,80036a <vprintfmt+0x208>
            for (; width > 0; width --) {
  800394:	01b05963          	blez	s11,8003a6 <vprintfmt+0x244>
  800398:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
  80039a:	85a6                	mv	a1,s1
  80039c:	02000513          	li	a0,32
  8003a0:	9902                	jalr	s2
            for (; width > 0; width --) {
  8003a2:	fe0d9be3          	bnez	s11,800398 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
  8003a6:	6a02                	ld	s4,0(sp)
  8003a8:	bbd5                	j	80019c <vprintfmt+0x3a>
    if (lflag >= 2) {
  8003aa:	4705                	li	a4,1
            precision = va_arg(ap, int);
  8003ac:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
  8003b0:	01174463          	blt	a4,a7,8003b8 <vprintfmt+0x256>
    else if (lflag) {
  8003b4:	08088d63          	beqz	a7,80044e <vprintfmt+0x2ec>
        return va_arg(*ap, long);
  8003b8:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
  8003bc:	0a044d63          	bltz	s0,800476 <vprintfmt+0x314>
            num = getint(&ap, lflag);
  8003c0:	8622                	mv	a2,s0
  8003c2:	8a66                	mv	s4,s9
  8003c4:	46a9                	li	a3,10
  8003c6:	bdcd                	j	8002b8 <vprintfmt+0x156>
            err = va_arg(ap, int);
  8003c8:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  8003cc:	4761                	li	a4,24
            err = va_arg(ap, int);
  8003ce:	0a21                	addi	s4,s4,8
            if (err < 0) {
  8003d0:	41f7d69b          	sraiw	a3,a5,0x1f
  8003d4:	8fb5                	xor	a5,a5,a3
  8003d6:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  8003da:	02d74163          	blt	a4,a3,8003fc <vprintfmt+0x29a>
  8003de:	00369793          	slli	a5,a3,0x3
  8003e2:	97de                	add	a5,a5,s7
  8003e4:	639c                	ld	a5,0(a5)
  8003e6:	cb99                	beqz	a5,8003fc <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
  8003e8:	86be                	mv	a3,a5
  8003ea:	00000617          	auipc	a2,0x0
  8003ee:	24660613          	addi	a2,a2,582 # 800630 <main+0x130>
  8003f2:	85a6                	mv	a1,s1
  8003f4:	854a                	mv	a0,s2
  8003f6:	0ce000ef          	jal	ra,8004c4 <printfmt>
  8003fa:	b34d                	j	80019c <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
  8003fc:	00000617          	auipc	a2,0x0
  800400:	22460613          	addi	a2,a2,548 # 800620 <main+0x120>
  800404:	85a6                	mv	a1,s1
  800406:	854a                	mv	a0,s2
  800408:	0bc000ef          	jal	ra,8004c4 <printfmt>
  80040c:	bb41                	j	80019c <vprintfmt+0x3a>
                p = "(null)";
  80040e:	00000417          	auipc	s0,0x0
  800412:	20a40413          	addi	s0,s0,522 # 800618 <main+0x118>
                for (width -= strnlen(p, precision); width > 0; width --) {
  800416:	85e2                	mv	a1,s8
  800418:	8522                	mv	a0,s0
  80041a:	e43e                	sd	a5,8(sp)
  80041c:	0c8000ef          	jal	ra,8004e4 <strnlen>
  800420:	40ad8dbb          	subw	s11,s11,a0
  800424:	01b05b63          	blez	s11,80043a <vprintfmt+0x2d8>
                    putch(padc, putdat);
  800428:	67a2                	ld	a5,8(sp)
  80042a:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
  80042e:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
  800430:	85a6                	mv	a1,s1
  800432:	8552                	mv	a0,s4
  800434:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
  800436:	fe0d9ce3          	bnez	s11,80042e <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  80043a:	00044783          	lbu	a5,0(s0)
  80043e:	00140a13          	addi	s4,s0,1
  800442:	0007851b          	sext.w	a0,a5
  800446:	d3a5                	beqz	a5,8003a6 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
  800448:	05e00413          	li	s0,94
  80044c:	bf39                	j	80036a <vprintfmt+0x208>
        return va_arg(*ap, int);
  80044e:	000a2403          	lw	s0,0(s4)
  800452:	b7ad                	j	8003bc <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
  800454:	000a6603          	lwu	a2,0(s4)
  800458:	46a1                	li	a3,8
  80045a:	8a2e                	mv	s4,a1
  80045c:	bdb1                	j	8002b8 <vprintfmt+0x156>
  80045e:	000a6603          	lwu	a2,0(s4)
  800462:	46a9                	li	a3,10
  800464:	8a2e                	mv	s4,a1
  800466:	bd89                	j	8002b8 <vprintfmt+0x156>
  800468:	000a6603          	lwu	a2,0(s4)
  80046c:	46c1                	li	a3,16
  80046e:	8a2e                	mv	s4,a1
  800470:	b5a1                	j	8002b8 <vprintfmt+0x156>
                    putch(ch, putdat);
  800472:	9902                	jalr	s2
  800474:	bf09                	j	800386 <vprintfmt+0x224>
                putch('-', putdat);
  800476:	85a6                	mv	a1,s1
  800478:	02d00513          	li	a0,45
  80047c:	e03e                	sd	a5,0(sp)
  80047e:	9902                	jalr	s2
                num = -(long long)num;
  800480:	6782                	ld	a5,0(sp)
  800482:	8a66                	mv	s4,s9
  800484:	40800633          	neg	a2,s0
  800488:	46a9                	li	a3,10
  80048a:	b53d                	j	8002b8 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
  80048c:	03b05163          	blez	s11,8004ae <vprintfmt+0x34c>
  800490:	02d00693          	li	a3,45
  800494:	f6d79de3          	bne	a5,a3,80040e <vprintfmt+0x2ac>
                p = "(null)";
  800498:	00000417          	auipc	s0,0x0
  80049c:	18040413          	addi	s0,s0,384 # 800618 <main+0x118>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8004a0:	02800793          	li	a5,40
  8004a4:	02800513          	li	a0,40
  8004a8:	00140a13          	addi	s4,s0,1
  8004ac:	bd6d                	j	800366 <vprintfmt+0x204>
  8004ae:	00000a17          	auipc	s4,0x0
  8004b2:	16ba0a13          	addi	s4,s4,363 # 800619 <main+0x119>
  8004b6:	02800513          	li	a0,40
  8004ba:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
  8004be:	05e00413          	li	s0,94
  8004c2:	b565                	j	80036a <vprintfmt+0x208>

00000000008004c4 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004c4:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
  8004c6:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004ca:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
  8004cc:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004ce:	ec06                	sd	ra,24(sp)
  8004d0:	f83a                	sd	a4,48(sp)
  8004d2:	fc3e                	sd	a5,56(sp)
  8004d4:	e0c2                	sd	a6,64(sp)
  8004d6:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  8004d8:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
  8004da:	c89ff0ef          	jal	ra,800162 <vprintfmt>
}
  8004de:	60e2                	ld	ra,24(sp)
  8004e0:	6161                	addi	sp,sp,80
  8004e2:	8082                	ret

00000000008004e4 <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
  8004e4:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
  8004e6:	e589                	bnez	a1,8004f0 <strnlen+0xc>
  8004e8:	a811                	j	8004fc <strnlen+0x18>
        cnt ++;
  8004ea:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
  8004ec:	00f58863          	beq	a1,a5,8004fc <strnlen+0x18>
  8004f0:	00f50733          	add	a4,a0,a5
  8004f4:	00074703          	lbu	a4,0(a4)
  8004f8:	fb6d                	bnez	a4,8004ea <strnlen+0x6>
  8004fa:	85be                	mv	a1,a5
    }
    return cnt;
}
  8004fc:	852e                	mv	a0,a1
  8004fe:	8082                	ret

0000000000800500 <main>:
    volatile unsigned long i;
    for (i = 0; i < cnt; i++);
}

int
main(void) {
  800500:	1101                	addi	sp,sp,-32
    int pid;

    cprintf("\n===== FIFO TEST START =====\n");
  800502:	00000517          	auipc	a0,0x0
  800506:	41650513          	addi	a0,a0,1046 # 800918 <error_string+0xc8>
main(void) {
  80050a:	ec06                	sd	ra,24(sp)
    cprintf("\n===== FIFO TEST START =====\n");
  80050c:	b35ff0ef          	jal	ra,800040 <cprintf>

    /* P1：最先到达，长作业 */
    if ((pid = fork()) == 0) {
  800510:	bd1ff0ef          	jal	ra,8000e0 <fork>
  800514:	c90d                	beqz	a0,800546 <main+0x46>
        cprintf("[P1] long job finish\n");
        exit(0);
    }

    /* 主动让出 CPU，保证 P1 先进入就绪队列 */
    yield();
  800516:	bd3ff0ef          	jal	ra,8000e8 <yield>

    /* P2：短作业 */
    if ((pid = fork()) == 0) {
  80051a:	bc7ff0ef          	jal	ra,8000e0 <fork>
  80051e:	c951                	beqz	a0,8005b2 <main+0xb2>
        busy_loop(20000000);
        cprintf("[P2] short job finish\n");
        exit(0);
    }

    yield();
  800520:	bc9ff0ef          	jal	ra,8000e8 <yield>

    /* P3：中等作业 */
    if ((pid = fork()) == 0) {
  800524:	bbdff0ef          	jal	ra,8000e0 <fork>
  800528:	c931                	beqz	a0,80057c <main+0x7c>
        busy_loop(50000000);
        cprintf("[P3] medium job finish\n");
        exit(0);
    }

    while (wait() > 0);
  80052a:	bb9ff0ef          	jal	ra,8000e2 <wait>
  80052e:	fea04ee3          	bgtz	a0,80052a <main+0x2a>
    cprintf("===== FIFO TEST END =====\n");
  800532:	00000517          	auipc	a0,0x0
  800536:	49650513          	addi	a0,a0,1174 # 8009c8 <error_string+0x178>
  80053a:	b07ff0ef          	jal	ra,800040 <cprintf>

    return 0;
}
  80053e:	60e2                	ld	ra,24(sp)
  800540:	4501                	li	a0,0
  800542:	6105                	addi	sp,sp,32
  800544:	8082                	ret
        cprintf("[P1] long job start\n");
  800546:	00000517          	auipc	a0,0x0
  80054a:	3f250513          	addi	a0,a0,1010 # 800938 <error_string+0xe8>
  80054e:	af3ff0ef          	jal	ra,800040 <cprintf>
    for (i = 0; i < cnt; i++);
  800552:	04c4b7b7          	lui	a5,0x4c4b
  800556:	e402                	sd	zero,8(sp)
  800558:	3ff78793          	addi	a5,a5,1023 # 4c4b3ff <error_string+0x444abaf>
  80055c:	a021                	j	800564 <main+0x64>
  80055e:	6722                	ld	a4,8(sp)
  800560:	0705                	addi	a4,a4,1
  800562:	e43a                	sd	a4,8(sp)
  800564:	6722                	ld	a4,8(sp)
  800566:	fee7fce3          	bgeu	a5,a4,80055e <main+0x5e>
        cprintf("[P1] long job finish\n");
  80056a:	00000517          	auipc	a0,0x0
  80056e:	3e650513          	addi	a0,a0,998 # 800950 <error_string+0x100>
  800572:	acfff0ef          	jal	ra,800040 <cprintf>
        exit(0);
  800576:	4501                	li	a0,0
  800578:	b53ff0ef          	jal	ra,8000ca <exit>
        cprintf("[P3] medium job start\n");
  80057c:	00000517          	auipc	a0,0x0
  800580:	41c50513          	addi	a0,a0,1052 # 800998 <error_string+0x148>
  800584:	abdff0ef          	jal	ra,800040 <cprintf>
    for (i = 0; i < cnt; i++);
  800588:	02faf7b7          	lui	a5,0x2faf
  80058c:	e402                	sd	zero,8(sp)
  80058e:	07f78793          	addi	a5,a5,127 # 2faf07f <error_string+0x27ae82f>
  800592:	a021                	j	80059a <main+0x9a>
  800594:	6722                	ld	a4,8(sp)
  800596:	0705                	addi	a4,a4,1
  800598:	e43a                	sd	a4,8(sp)
  80059a:	6722                	ld	a4,8(sp)
  80059c:	fee7fce3          	bgeu	a5,a4,800594 <main+0x94>
        cprintf("[P3] medium job finish\n");
  8005a0:	00000517          	auipc	a0,0x0
  8005a4:	41050513          	addi	a0,a0,1040 # 8009b0 <error_string+0x160>
  8005a8:	a99ff0ef          	jal	ra,800040 <cprintf>
        exit(0);
  8005ac:	4501                	li	a0,0
  8005ae:	b1dff0ef          	jal	ra,8000ca <exit>
        cprintf("[P2] short job start\n");
  8005b2:	00000517          	auipc	a0,0x0
  8005b6:	3b650513          	addi	a0,a0,950 # 800968 <error_string+0x118>
  8005ba:	a87ff0ef          	jal	ra,800040 <cprintf>
    for (i = 0; i < cnt; i++);
  8005be:	013137b7          	lui	a5,0x1313
  8005c2:	e402                	sd	zero,8(sp)
  8005c4:	cff78793          	addi	a5,a5,-769 # 1312cff <error_string+0xb124af>
  8005c8:	a021                	j	8005d0 <main+0xd0>
  8005ca:	6722                	ld	a4,8(sp)
  8005cc:	0705                	addi	a4,a4,1
  8005ce:	e43a                	sd	a4,8(sp)
  8005d0:	6722                	ld	a4,8(sp)
  8005d2:	fee7fce3          	bgeu	a5,a4,8005ca <main+0xca>
        cprintf("[P2] short job finish\n");
  8005d6:	00000517          	auipc	a0,0x0
  8005da:	3aa50513          	addi	a0,a0,938 # 800980 <error_string+0x130>
  8005de:	a63ff0ef          	jal	ra,800040 <cprintf>
        exit(0);
  8005e2:	4501                	li	a0,0
  8005e4:	ae7ff0ef          	jal	ra,8000ca <exit>
