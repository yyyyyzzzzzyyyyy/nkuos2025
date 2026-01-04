
obj/__user_sjf_test.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <_start>:
    # move down the esp register
    # since it may cause page fault in backtrace
    // subl $0x20, %esp

    # call user-program function
    call umain
  800020:	0c4000ef          	jal	ra,8000e4 <umain>
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
  80002e:	092000ef          	jal	ra,8000c0 <sys_putc>
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
  80006a:	0f2000ef          	jal	ra,80015c <vprintfmt>
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

00000000008000c0 <sys_putc>:
sys_getpid(void) {
    return syscall(SYS_getpid);
}

int
sys_putc(int64_t c) {
  8000c0:	85aa                	mv	a1,a0
    return syscall(SYS_putc, c);
  8000c2:	4579                	li	a0,30
  8000c4:	bf4d                	j	800076 <syscall>

00000000008000c6 <exit>:
#include <syscall.h>
#include <stdio.h>
#include <ulib.h>

void
exit(int error_code) {
  8000c6:	1141                	addi	sp,sp,-16
  8000c8:	e406                	sd	ra,8(sp)
    sys_exit(error_code);
  8000ca:	fe5ff0ef          	jal	ra,8000ae <sys_exit>
    cprintf("BUG: exit failed.\n");
  8000ce:	00000517          	auipc	a0,0x0
  8000d2:	51250513          	addi	a0,a0,1298 # 8005e0 <main+0xe6>
  8000d6:	f6bff0ef          	jal	ra,800040 <cprintf>
    while (1);
  8000da:	a001                	j	8000da <exit+0x14>

00000000008000dc <fork>:
}

int
fork(void) {
    return sys_fork();
  8000dc:	bfe1                	j	8000b4 <sys_fork>

00000000008000de <wait>:
}

int
wait(void) {
    return sys_wait(0, NULL);
  8000de:	4581                	li	a1,0
  8000e0:	4501                	li	a0,0
  8000e2:	bfd9                	j	8000b8 <sys_wait>

00000000008000e4 <umain>:
#include <ulib.h>

int main(void);

void
umain(void) {
  8000e4:	1141                	addi	sp,sp,-16
  8000e6:	e406                	sd	ra,8(sp)
    int ret = main();
  8000e8:	412000ef          	jal	ra,8004fa <main>
    exit(ret);
  8000ec:	fdbff0ef          	jal	ra,8000c6 <exit>

00000000008000f0 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
  8000f0:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  8000f4:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
  8000f6:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  8000fa:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
  8000fc:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
  800100:	f022                	sd	s0,32(sp)
  800102:	ec26                	sd	s1,24(sp)
  800104:	e84a                	sd	s2,16(sp)
  800106:	f406                	sd	ra,40(sp)
  800108:	e44e                	sd	s3,8(sp)
  80010a:	84aa                	mv	s1,a0
  80010c:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  80010e:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
  800112:	2a01                	sext.w	s4,s4
    if (num >= base) {
  800114:	03067e63          	bgeu	a2,a6,800150 <printnum+0x60>
  800118:	89be                	mv	s3,a5
        while (-- width > 0)
  80011a:	00805763          	blez	s0,800128 <printnum+0x38>
  80011e:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
  800120:	85ca                	mv	a1,s2
  800122:	854e                	mv	a0,s3
  800124:	9482                	jalr	s1
        while (-- width > 0)
  800126:	fc65                	bnez	s0,80011e <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  800128:	1a02                	slli	s4,s4,0x20
  80012a:	00000797          	auipc	a5,0x0
  80012e:	4ce78793          	addi	a5,a5,1230 # 8005f8 <main+0xfe>
  800132:	020a5a13          	srli	s4,s4,0x20
  800136:	9a3e                	add	s4,s4,a5
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
  800138:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
  80013a:	000a4503          	lbu	a0,0(s4)
}
  80013e:	70a2                	ld	ra,40(sp)
  800140:	69a2                	ld	s3,8(sp)
  800142:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
  800144:	85ca                	mv	a1,s2
  800146:	87a6                	mv	a5,s1
}
  800148:	6942                	ld	s2,16(sp)
  80014a:	64e2                	ld	s1,24(sp)
  80014c:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
  80014e:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
  800150:	03065633          	divu	a2,a2,a6
  800154:	8722                	mv	a4,s0
  800156:	f9bff0ef          	jal	ra,8000f0 <printnum>
  80015a:	b7f9                	j	800128 <printnum+0x38>

000000000080015c <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  80015c:	7119                	addi	sp,sp,-128
  80015e:	f4a6                	sd	s1,104(sp)
  800160:	f0ca                	sd	s2,96(sp)
  800162:	ecce                	sd	s3,88(sp)
  800164:	e8d2                	sd	s4,80(sp)
  800166:	e4d6                	sd	s5,72(sp)
  800168:	e0da                	sd	s6,64(sp)
  80016a:	fc5e                	sd	s7,56(sp)
  80016c:	f06a                	sd	s10,32(sp)
  80016e:	fc86                	sd	ra,120(sp)
  800170:	f8a2                	sd	s0,112(sp)
  800172:	f862                	sd	s8,48(sp)
  800174:	f466                	sd	s9,40(sp)
  800176:	ec6e                	sd	s11,24(sp)
  800178:	892a                	mv	s2,a0
  80017a:	84ae                	mv	s1,a1
  80017c:	8d32                	mv	s10,a2
  80017e:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800180:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
  800184:	5b7d                	li	s6,-1
  800186:	00000a97          	auipc	s5,0x0
  80018a:	4a6a8a93          	addi	s5,s5,1190 # 80062c <main+0x132>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  80018e:	00000b97          	auipc	s7,0x0
  800192:	6bab8b93          	addi	s7,s7,1722 # 800848 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800196:	000d4503          	lbu	a0,0(s10)
  80019a:	001d0413          	addi	s0,s10,1
  80019e:	01350a63          	beq	a0,s3,8001b2 <vprintfmt+0x56>
            if (ch == '\0') {
  8001a2:	c121                	beqz	a0,8001e2 <vprintfmt+0x86>
            putch(ch, putdat);
  8001a4:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001a6:	0405                	addi	s0,s0,1
            putch(ch, putdat);
  8001a8:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001aa:	fff44503          	lbu	a0,-1(s0)
  8001ae:	ff351ae3          	bne	a0,s3,8001a2 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
  8001b2:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
  8001b6:	02000793          	li	a5,32
        lflag = altflag = 0;
  8001ba:	4c81                	li	s9,0
  8001bc:	4881                	li	a7,0
        width = precision = -1;
  8001be:	5c7d                	li	s8,-1
  8001c0:	5dfd                	li	s11,-1
  8001c2:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
  8001c6:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
  8001c8:	fdd6059b          	addiw	a1,a2,-35
  8001cc:	0ff5f593          	zext.b	a1,a1
  8001d0:	00140d13          	addi	s10,s0,1
  8001d4:	04b56263          	bltu	a0,a1,800218 <vprintfmt+0xbc>
  8001d8:	058a                	slli	a1,a1,0x2
  8001da:	95d6                	add	a1,a1,s5
  8001dc:	4194                	lw	a3,0(a1)
  8001de:	96d6                	add	a3,a3,s5
  8001e0:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  8001e2:	70e6                	ld	ra,120(sp)
  8001e4:	7446                	ld	s0,112(sp)
  8001e6:	74a6                	ld	s1,104(sp)
  8001e8:	7906                	ld	s2,96(sp)
  8001ea:	69e6                	ld	s3,88(sp)
  8001ec:	6a46                	ld	s4,80(sp)
  8001ee:	6aa6                	ld	s5,72(sp)
  8001f0:	6b06                	ld	s6,64(sp)
  8001f2:	7be2                	ld	s7,56(sp)
  8001f4:	7c42                	ld	s8,48(sp)
  8001f6:	7ca2                	ld	s9,40(sp)
  8001f8:	7d02                	ld	s10,32(sp)
  8001fa:	6de2                	ld	s11,24(sp)
  8001fc:	6109                	addi	sp,sp,128
  8001fe:	8082                	ret
            padc = '0';
  800200:	87b2                	mv	a5,a2
            goto reswitch;
  800202:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  800206:	846a                	mv	s0,s10
  800208:	00140d13          	addi	s10,s0,1
  80020c:	fdd6059b          	addiw	a1,a2,-35
  800210:	0ff5f593          	zext.b	a1,a1
  800214:	fcb572e3          	bgeu	a0,a1,8001d8 <vprintfmt+0x7c>
            putch('%', putdat);
  800218:	85a6                	mv	a1,s1
  80021a:	02500513          	li	a0,37
  80021e:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
  800220:	fff44783          	lbu	a5,-1(s0)
  800224:	8d22                	mv	s10,s0
  800226:	f73788e3          	beq	a5,s3,800196 <vprintfmt+0x3a>
  80022a:	ffed4783          	lbu	a5,-2(s10)
  80022e:	1d7d                	addi	s10,s10,-1
  800230:	ff379de3          	bne	a5,s3,80022a <vprintfmt+0xce>
  800234:	b78d                	j	800196 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
  800236:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
  80023a:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  80023e:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
  800240:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
  800244:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  800248:	02d86463          	bltu	a6,a3,800270 <vprintfmt+0x114>
                ch = *fmt;
  80024c:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
  800250:	002c169b          	slliw	a3,s8,0x2
  800254:	0186873b          	addw	a4,a3,s8
  800258:	0017171b          	slliw	a4,a4,0x1
  80025c:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
  80025e:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
  800262:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
  800264:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
  800268:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  80026c:	fed870e3          	bgeu	a6,a3,80024c <vprintfmt+0xf0>
            if (width < 0)
  800270:	f40ddce3          	bgez	s11,8001c8 <vprintfmt+0x6c>
                width = precision, precision = -1;
  800274:	8de2                	mv	s11,s8
  800276:	5c7d                	li	s8,-1
  800278:	bf81                	j	8001c8 <vprintfmt+0x6c>
            if (width < 0)
  80027a:	fffdc693          	not	a3,s11
  80027e:	96fd                	srai	a3,a3,0x3f
  800280:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
  800284:	00144603          	lbu	a2,1(s0)
  800288:	2d81                	sext.w	s11,s11
  80028a:	846a                	mv	s0,s10
            goto reswitch;
  80028c:	bf35                	j	8001c8 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
  80028e:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
  800292:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
  800296:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
  800298:	846a                	mv	s0,s10
            goto process_precision;
  80029a:	bfd9                	j	800270 <vprintfmt+0x114>
    if (lflag >= 2) {
  80029c:	4705                	li	a4,1
            precision = va_arg(ap, int);
  80029e:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  8002a2:	01174463          	blt	a4,a7,8002aa <vprintfmt+0x14e>
    else if (lflag) {
  8002a6:	1a088e63          	beqz	a7,800462 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
  8002aa:	000a3603          	ld	a2,0(s4)
  8002ae:	46c1                	li	a3,16
  8002b0:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
  8002b2:	2781                	sext.w	a5,a5
  8002b4:	876e                	mv	a4,s11
  8002b6:	85a6                	mv	a1,s1
  8002b8:	854a                	mv	a0,s2
  8002ba:	e37ff0ef          	jal	ra,8000f0 <printnum>
            break;
  8002be:	bde1                	j	800196 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
  8002c0:	000a2503          	lw	a0,0(s4)
  8002c4:	85a6                	mv	a1,s1
  8002c6:	0a21                	addi	s4,s4,8
  8002c8:	9902                	jalr	s2
            break;
  8002ca:	b5f1                	j	800196 <vprintfmt+0x3a>
    if (lflag >= 2) {
  8002cc:	4705                	li	a4,1
            precision = va_arg(ap, int);
  8002ce:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  8002d2:	01174463          	blt	a4,a7,8002da <vprintfmt+0x17e>
    else if (lflag) {
  8002d6:	18088163          	beqz	a7,800458 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
  8002da:	000a3603          	ld	a2,0(s4)
  8002de:	46a9                	li	a3,10
  8002e0:	8a2e                	mv	s4,a1
  8002e2:	bfc1                	j	8002b2 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
  8002e4:	00144603          	lbu	a2,1(s0)
            altflag = 1;
  8002e8:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
  8002ea:	846a                	mv	s0,s10
            goto reswitch;
  8002ec:	bdf1                	j	8001c8 <vprintfmt+0x6c>
            putch(ch, putdat);
  8002ee:	85a6                	mv	a1,s1
  8002f0:	02500513          	li	a0,37
  8002f4:	9902                	jalr	s2
            break;
  8002f6:	b545                	j	800196 <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
  8002f8:	00144603          	lbu	a2,1(s0)
            lflag ++;
  8002fc:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
  8002fe:	846a                	mv	s0,s10
            goto reswitch;
  800300:	b5e1                	j	8001c8 <vprintfmt+0x6c>
    if (lflag >= 2) {
  800302:	4705                	li	a4,1
            precision = va_arg(ap, int);
  800304:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  800308:	01174463          	blt	a4,a7,800310 <vprintfmt+0x1b4>
    else if (lflag) {
  80030c:	14088163          	beqz	a7,80044e <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
  800310:	000a3603          	ld	a2,0(s4)
  800314:	46a1                	li	a3,8
  800316:	8a2e                	mv	s4,a1
  800318:	bf69                	j	8002b2 <vprintfmt+0x156>
            putch('0', putdat);
  80031a:	03000513          	li	a0,48
  80031e:	85a6                	mv	a1,s1
  800320:	e03e                	sd	a5,0(sp)
  800322:	9902                	jalr	s2
            putch('x', putdat);
  800324:	85a6                	mv	a1,s1
  800326:	07800513          	li	a0,120
  80032a:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  80032c:	0a21                	addi	s4,s4,8
            goto number;
  80032e:	6782                	ld	a5,0(sp)
  800330:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  800332:	ff8a3603          	ld	a2,-8(s4)
            goto number;
  800336:	bfb5                	j	8002b2 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
  800338:	000a3403          	ld	s0,0(s4)
  80033c:	008a0713          	addi	a4,s4,8
  800340:	e03a                	sd	a4,0(sp)
  800342:	14040263          	beqz	s0,800486 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
  800346:	0fb05763          	blez	s11,800434 <vprintfmt+0x2d8>
  80034a:	02d00693          	li	a3,45
  80034e:	0cd79163          	bne	a5,a3,800410 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800352:	00044783          	lbu	a5,0(s0)
  800356:	0007851b          	sext.w	a0,a5
  80035a:	cf85                	beqz	a5,800392 <vprintfmt+0x236>
  80035c:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
  800360:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800364:	000c4563          	bltz	s8,80036e <vprintfmt+0x212>
  800368:	3c7d                	addiw	s8,s8,-1
  80036a:	036c0263          	beq	s8,s6,80038e <vprintfmt+0x232>
                    putch('?', putdat);
  80036e:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
  800370:	0e0c8e63          	beqz	s9,80046c <vprintfmt+0x310>
  800374:	3781                	addiw	a5,a5,-32
  800376:	0ef47b63          	bgeu	s0,a5,80046c <vprintfmt+0x310>
                    putch('?', putdat);
  80037a:	03f00513          	li	a0,63
  80037e:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800380:	000a4783          	lbu	a5,0(s4)
  800384:	3dfd                	addiw	s11,s11,-1
  800386:	0a05                	addi	s4,s4,1
  800388:	0007851b          	sext.w	a0,a5
  80038c:	ffe1                	bnez	a5,800364 <vprintfmt+0x208>
            for (; width > 0; width --) {
  80038e:	01b05963          	blez	s11,8003a0 <vprintfmt+0x244>
  800392:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
  800394:	85a6                	mv	a1,s1
  800396:	02000513          	li	a0,32
  80039a:	9902                	jalr	s2
            for (; width > 0; width --) {
  80039c:	fe0d9be3          	bnez	s11,800392 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
  8003a0:	6a02                	ld	s4,0(sp)
  8003a2:	bbd5                	j	800196 <vprintfmt+0x3a>
    if (lflag >= 2) {
  8003a4:	4705                	li	a4,1
            precision = va_arg(ap, int);
  8003a6:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
  8003aa:	01174463          	blt	a4,a7,8003b2 <vprintfmt+0x256>
    else if (lflag) {
  8003ae:	08088d63          	beqz	a7,800448 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
  8003b2:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
  8003b6:	0a044d63          	bltz	s0,800470 <vprintfmt+0x314>
            num = getint(&ap, lflag);
  8003ba:	8622                	mv	a2,s0
  8003bc:	8a66                	mv	s4,s9
  8003be:	46a9                	li	a3,10
  8003c0:	bdcd                	j	8002b2 <vprintfmt+0x156>
            err = va_arg(ap, int);
  8003c2:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  8003c6:	4761                	li	a4,24
            err = va_arg(ap, int);
  8003c8:	0a21                	addi	s4,s4,8
            if (err < 0) {
  8003ca:	41f7d69b          	sraiw	a3,a5,0x1f
  8003ce:	8fb5                	xor	a5,a5,a3
  8003d0:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  8003d4:	02d74163          	blt	a4,a3,8003f6 <vprintfmt+0x29a>
  8003d8:	00369793          	slli	a5,a3,0x3
  8003dc:	97de                	add	a5,a5,s7
  8003de:	639c                	ld	a5,0(a5)
  8003e0:	cb99                	beqz	a5,8003f6 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
  8003e2:	86be                	mv	a3,a5
  8003e4:	00000617          	auipc	a2,0x0
  8003e8:	24460613          	addi	a2,a2,580 # 800628 <main+0x12e>
  8003ec:	85a6                	mv	a1,s1
  8003ee:	854a                	mv	a0,s2
  8003f0:	0ce000ef          	jal	ra,8004be <printfmt>
  8003f4:	b34d                	j	800196 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
  8003f6:	00000617          	auipc	a2,0x0
  8003fa:	22260613          	addi	a2,a2,546 # 800618 <main+0x11e>
  8003fe:	85a6                	mv	a1,s1
  800400:	854a                	mv	a0,s2
  800402:	0bc000ef          	jal	ra,8004be <printfmt>
  800406:	bb41                	j	800196 <vprintfmt+0x3a>
                p = "(null)";
  800408:	00000417          	auipc	s0,0x0
  80040c:	20840413          	addi	s0,s0,520 # 800610 <main+0x116>
                for (width -= strnlen(p, precision); width > 0; width --) {
  800410:	85e2                	mv	a1,s8
  800412:	8522                	mv	a0,s0
  800414:	e43e                	sd	a5,8(sp)
  800416:	0c8000ef          	jal	ra,8004de <strnlen>
  80041a:	40ad8dbb          	subw	s11,s11,a0
  80041e:	01b05b63          	blez	s11,800434 <vprintfmt+0x2d8>
                    putch(padc, putdat);
  800422:	67a2                	ld	a5,8(sp)
  800424:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
  800428:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
  80042a:	85a6                	mv	a1,s1
  80042c:	8552                	mv	a0,s4
  80042e:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
  800430:	fe0d9ce3          	bnez	s11,800428 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800434:	00044783          	lbu	a5,0(s0)
  800438:	00140a13          	addi	s4,s0,1
  80043c:	0007851b          	sext.w	a0,a5
  800440:	d3a5                	beqz	a5,8003a0 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
  800442:	05e00413          	li	s0,94
  800446:	bf39                	j	800364 <vprintfmt+0x208>
        return va_arg(*ap, int);
  800448:	000a2403          	lw	s0,0(s4)
  80044c:	b7ad                	j	8003b6 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
  80044e:	000a6603          	lwu	a2,0(s4)
  800452:	46a1                	li	a3,8
  800454:	8a2e                	mv	s4,a1
  800456:	bdb1                	j	8002b2 <vprintfmt+0x156>
  800458:	000a6603          	lwu	a2,0(s4)
  80045c:	46a9                	li	a3,10
  80045e:	8a2e                	mv	s4,a1
  800460:	bd89                	j	8002b2 <vprintfmt+0x156>
  800462:	000a6603          	lwu	a2,0(s4)
  800466:	46c1                	li	a3,16
  800468:	8a2e                	mv	s4,a1
  80046a:	b5a1                	j	8002b2 <vprintfmt+0x156>
                    putch(ch, putdat);
  80046c:	9902                	jalr	s2
  80046e:	bf09                	j	800380 <vprintfmt+0x224>
                putch('-', putdat);
  800470:	85a6                	mv	a1,s1
  800472:	02d00513          	li	a0,45
  800476:	e03e                	sd	a5,0(sp)
  800478:	9902                	jalr	s2
                num = -(long long)num;
  80047a:	6782                	ld	a5,0(sp)
  80047c:	8a66                	mv	s4,s9
  80047e:	40800633          	neg	a2,s0
  800482:	46a9                	li	a3,10
  800484:	b53d                	j	8002b2 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
  800486:	03b05163          	blez	s11,8004a8 <vprintfmt+0x34c>
  80048a:	02d00693          	li	a3,45
  80048e:	f6d79de3          	bne	a5,a3,800408 <vprintfmt+0x2ac>
                p = "(null)";
  800492:	00000417          	auipc	s0,0x0
  800496:	17e40413          	addi	s0,s0,382 # 800610 <main+0x116>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  80049a:	02800793          	li	a5,40
  80049e:	02800513          	li	a0,40
  8004a2:	00140a13          	addi	s4,s0,1
  8004a6:	bd6d                	j	800360 <vprintfmt+0x204>
  8004a8:	00000a17          	auipc	s4,0x0
  8004ac:	169a0a13          	addi	s4,s4,361 # 800611 <main+0x117>
  8004b0:	02800513          	li	a0,40
  8004b4:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
  8004b8:	05e00413          	li	s0,94
  8004bc:	b565                	j	800364 <vprintfmt+0x208>

00000000008004be <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004be:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
  8004c0:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004c4:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
  8004c6:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004c8:	ec06                	sd	ra,24(sp)
  8004ca:	f83a                	sd	a4,48(sp)
  8004cc:	fc3e                	sd	a5,56(sp)
  8004ce:	e0c2                	sd	a6,64(sp)
  8004d0:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  8004d2:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
  8004d4:	c89ff0ef          	jal	ra,80015c <vprintfmt>
}
  8004d8:	60e2                	ld	ra,24(sp)
  8004da:	6161                	addi	sp,sp,80
  8004dc:	8082                	ret

00000000008004de <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
  8004de:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
  8004e0:	e589                	bnez	a1,8004ea <strnlen+0xc>
  8004e2:	a811                	j	8004f6 <strnlen+0x18>
        cnt ++;
  8004e4:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
  8004e6:	00f58863          	beq	a1,a5,8004f6 <strnlen+0x18>
  8004ea:	00f50733          	add	a4,a0,a5
  8004ee:	00074703          	lbu	a4,0(a4)
  8004f2:	fb6d                	bnez	a4,8004e4 <strnlen+0x6>
  8004f4:	85be                	mv	a1,a5
    }
    return cnt;
}
  8004f6:	852e                	mv	a0,a1
  8004f8:	8082                	ret

00000000008004fa <main>:
    volatile unsigned long i;
    for (i = 0; i < cnt; i++);
}

int
main(void) {
  8004fa:	1101                	addi	sp,sp,-32
    int pid;

    cprintf("\n===== SJF TEST START =====\n");
  8004fc:	00000517          	auipc	a0,0x0
  800500:	41450513          	addi	a0,a0,1044 # 800910 <error_string+0xc8>
main(void) {
  800504:	ec06                	sd	ra,24(sp)
    cprintf("\n===== SJF TEST START =====\n");
  800506:	b3bff0ef          	jal	ra,800040 <cprintf>

    /* 三个进程几乎同时到达 */

    /* P1：长作业 */
    if ((pid = fork()) == 0) {
  80050a:	bd3ff0ef          	jal	ra,8000dc <fork>
  80050e:	c50d                	beqz	a0,800538 <main+0x3e>
        cprintf("[P1] long job finish\n");
        exit(0);
    }

    /* P2：短作业 */
    if ((pid = fork()) == 0) {
  800510:	bcdff0ef          	jal	ra,8000dc <fork>
  800514:	c941                	beqz	a0,8005a4 <main+0xaa>
        cprintf("[P2] short job finish\n");
        exit(0);
    }

    /* P3：中等作业 */
    if ((pid = fork()) == 0) {
  800516:	bc7ff0ef          	jal	ra,8000dc <fork>
  80051a:	c931                	beqz	a0,80056e <main+0x74>
        busy_loop(50000000);
        cprintf("[P3] medium job finish\n");
        exit(0);
    }

    while (wait() > 0);
  80051c:	bc3ff0ef          	jal	ra,8000de <wait>
  800520:	fea04ee3          	bgtz	a0,80051c <main+0x22>
    cprintf("===== SJF TEST END =====\n\n");
  800524:	00000517          	auipc	a0,0x0
  800528:	49c50513          	addi	a0,a0,1180 # 8009c0 <error_string+0x178>
  80052c:	b15ff0ef          	jal	ra,800040 <cprintf>

    return 0;
}
  800530:	60e2                	ld	ra,24(sp)
  800532:	4501                	li	a0,0
  800534:	6105                	addi	sp,sp,32
  800536:	8082                	ret
        cprintf("[P1] long job start\n");
  800538:	00000517          	auipc	a0,0x0
  80053c:	3f850513          	addi	a0,a0,1016 # 800930 <error_string+0xe8>
  800540:	b01ff0ef          	jal	ra,800040 <cprintf>
    for (i = 0; i < cnt; i++);
  800544:	04c4b7b7          	lui	a5,0x4c4b
  800548:	e402                	sd	zero,8(sp)
  80054a:	3ff78793          	addi	a5,a5,1023 # 4c4b3ff <error_string+0x444abb7>
  80054e:	a021                	j	800556 <main+0x5c>
  800550:	6722                	ld	a4,8(sp)
  800552:	0705                	addi	a4,a4,1
  800554:	e43a                	sd	a4,8(sp)
  800556:	6722                	ld	a4,8(sp)
  800558:	fee7fce3          	bgeu	a5,a4,800550 <main+0x56>
        cprintf("[P1] long job finish\n");
  80055c:	00000517          	auipc	a0,0x0
  800560:	3ec50513          	addi	a0,a0,1004 # 800948 <error_string+0x100>
  800564:	addff0ef          	jal	ra,800040 <cprintf>
        exit(0);
  800568:	4501                	li	a0,0
  80056a:	b5dff0ef          	jal	ra,8000c6 <exit>
        cprintf("[P3] medium job start\n");
  80056e:	00000517          	auipc	a0,0x0
  800572:	42250513          	addi	a0,a0,1058 # 800990 <error_string+0x148>
  800576:	acbff0ef          	jal	ra,800040 <cprintf>
    for (i = 0; i < cnt; i++);
  80057a:	02faf7b7          	lui	a5,0x2faf
  80057e:	e402                	sd	zero,8(sp)
  800580:	07f78793          	addi	a5,a5,127 # 2faf07f <error_string+0x27ae837>
  800584:	a021                	j	80058c <main+0x92>
  800586:	6722                	ld	a4,8(sp)
  800588:	0705                	addi	a4,a4,1
  80058a:	e43a                	sd	a4,8(sp)
  80058c:	6722                	ld	a4,8(sp)
  80058e:	fee7fce3          	bgeu	a5,a4,800586 <main+0x8c>
        cprintf("[P3] medium job finish\n");
  800592:	00000517          	auipc	a0,0x0
  800596:	41650513          	addi	a0,a0,1046 # 8009a8 <error_string+0x160>
  80059a:	aa7ff0ef          	jal	ra,800040 <cprintf>
        exit(0);
  80059e:	4501                	li	a0,0
  8005a0:	b27ff0ef          	jal	ra,8000c6 <exit>
        cprintf("[P2] short job start\n");
  8005a4:	00000517          	auipc	a0,0x0
  8005a8:	3bc50513          	addi	a0,a0,956 # 800960 <error_string+0x118>
  8005ac:	a95ff0ef          	jal	ra,800040 <cprintf>
    for (i = 0; i < cnt; i++);
  8005b0:	013137b7          	lui	a5,0x1313
  8005b4:	e402                	sd	zero,8(sp)
  8005b6:	cff78793          	addi	a5,a5,-769 # 1312cff <error_string+0xb124b7>
  8005ba:	a021                	j	8005c2 <main+0xc8>
  8005bc:	6722                	ld	a4,8(sp)
  8005be:	0705                	addi	a4,a4,1
  8005c0:	e43a                	sd	a4,8(sp)
  8005c2:	6722                	ld	a4,8(sp)
  8005c4:	fee7fce3          	bgeu	a5,a4,8005bc <main+0xc2>
        cprintf("[P2] short job finish\n");
  8005c8:	00000517          	auipc	a0,0x0
  8005cc:	3b050513          	addi	a0,a0,944 # 800978 <error_string+0x130>
  8005d0:	a71ff0ef          	jal	ra,800040 <cprintf>
        exit(0);
  8005d4:	4501                	li	a0,0
  8005d6:	af1ff0ef          	jal	ra,8000c6 <exit>
