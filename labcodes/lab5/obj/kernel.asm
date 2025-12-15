
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
    .globl kern_entry
kern_entry:
    # a0: hartid
    # a1: dtb physical address
    # save hartid and dtb address
    la t0, boot_hartid
ffffffffc0200000:	0000b297          	auipc	t0,0xb
ffffffffc0200004:	00028293          	mv	t0,t0
    sd a0, 0(t0)
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc020b000 <boot_hartid>
    la t0, boot_dtb
ffffffffc020000c:	0000b297          	auipc	t0,0xb
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc020b008 <boot_dtb>
    sd a1, 0(t0)
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)
    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200018:	c020a2b7          	lui	t0,0xc020a
    # t1 := 0xffffffff40000000 即虚实映射偏移量
    li      t1, 0xffffffffc0000000 - 0x80000000
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
    # t0 减去虚实映射偏移量 0xffffffff40000000，变为三级页表的物理地址
    sub     t0, t0, t1
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
    # t0 >>= 12，变为三级页表的物理页号
    srli    t0, t0, 12
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc

    # t1 := 8 << 60，设置 satp 的 MODE 字段为 Sv39
    li      t1, 8 << 60
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
    # 将刚才计算出的预设三级页表物理页号附加到 satp 中
    or      t0, t0, t1
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
    # 将算出的 t0(即新的MODE|页表基址物理页号) 覆盖到 satp 中
    csrw    satp, t0
ffffffffc0200034:	18029073          	csrw	satp,t0
    # 使用 sfence.vma 指令刷新 TLB
    sfence.vma
ffffffffc0200038:	12000073          	sfence.vma
    # 从此，我们给内核搭建出了一个完美的虚拟内存空间！
    #nop # 可能映射的位置有些bug。。插入一个nop
    
    # 我们在虚拟内存空间中：随意将 sp 设置为虚拟地址！
    lui sp, %hi(bootstacktop)
ffffffffc020003c:	c020a137          	lui	sp,0xc020a

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 跳转到 kern_init
    lui t0, %hi(kern_init)
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc0200044:	04a28293          	addi	t0,t0,74 # ffffffffc020004a <kern_init>
    jr t0
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <kern_init>:
void grade_backtrace(void);

int kern_init(void)
{
    extern char edata[], end[];
    memset(edata, 0, end - edata);
ffffffffc020004a:	000a6517          	auipc	a0,0xa6
ffffffffc020004e:	19e50513          	addi	a0,a0,414 # ffffffffc02a61e8 <buf>
ffffffffc0200052:	000aa617          	auipc	a2,0xaa
ffffffffc0200056:	63a60613          	addi	a2,a2,1594 # ffffffffc02aa68c <end>
{
ffffffffc020005a:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
{
ffffffffc0200060:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc0200062:	622050ef          	jal	ra,ffffffffc0205684 <memset>
    dtb_init();
ffffffffc0200066:	598000ef          	jal	ra,ffffffffc02005fe <dtb_init>
    cons_init(); // init the console
ffffffffc020006a:	522000ef          	jal	ra,ffffffffc020058c <cons_init>

    const char *message = "(THU.CST) os is loading ...";
    cprintf("%s\n\n", message);
ffffffffc020006e:	00005597          	auipc	a1,0x5
ffffffffc0200072:	64258593          	addi	a1,a1,1602 # ffffffffc02056b0 <etext+0x2>
ffffffffc0200076:	00005517          	auipc	a0,0x5
ffffffffc020007a:	65a50513          	addi	a0,a0,1626 # ffffffffc02056d0 <etext+0x22>
ffffffffc020007e:	116000ef          	jal	ra,ffffffffc0200194 <cprintf>

    print_kerninfo();
ffffffffc0200082:	19a000ef          	jal	ra,ffffffffc020021c <print_kerninfo>

    // grade_backtrace();

    pmm_init(); // init physical memory management
ffffffffc0200086:	6ac020ef          	jal	ra,ffffffffc0202732 <pmm_init>

    pic_init(); // init interrupt controller
ffffffffc020008a:	131000ef          	jal	ra,ffffffffc02009ba <pic_init>
    idt_init(); // init interrupt descriptor table
ffffffffc020008e:	12f000ef          	jal	ra,ffffffffc02009bc <idt_init>

    vmm_init();  // init virtual memory management
ffffffffc0200092:	157030ef          	jal	ra,ffffffffc02039e8 <vmm_init>
    proc_init(); // init process table
ffffffffc0200096:	541040ef          	jal	ra,ffffffffc0204dd6 <proc_init>

    clock_init();  // init clock interrupt
ffffffffc020009a:	4a0000ef          	jal	ra,ffffffffc020053a <clock_init>
    intr_enable(); // enable irq interrupt
ffffffffc020009e:	111000ef          	jal	ra,ffffffffc02009ae <intr_enable>

    cpu_idle(); // run idle process
ffffffffc02000a2:	6cd040ef          	jal	ra,ffffffffc0204f6e <cpu_idle>

ffffffffc02000a6 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc02000a6:	715d                	addi	sp,sp,-80
ffffffffc02000a8:	e486                	sd	ra,72(sp)
ffffffffc02000aa:	e0a6                	sd	s1,64(sp)
ffffffffc02000ac:	fc4a                	sd	s2,56(sp)
ffffffffc02000ae:	f84e                	sd	s3,48(sp)
ffffffffc02000b0:	f452                	sd	s4,40(sp)
ffffffffc02000b2:	f056                	sd	s5,32(sp)
ffffffffc02000b4:	ec5a                	sd	s6,24(sp)
ffffffffc02000b6:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc02000b8:	c901                	beqz	a0,ffffffffc02000c8 <readline+0x22>
ffffffffc02000ba:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc02000bc:	00005517          	auipc	a0,0x5
ffffffffc02000c0:	61c50513          	addi	a0,a0,1564 # ffffffffc02056d8 <etext+0x2a>
ffffffffc02000c4:	0d0000ef          	jal	ra,ffffffffc0200194 <cprintf>
readline(const char *prompt) {
ffffffffc02000c8:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000ca:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc02000cc:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc02000ce:	4aa9                	li	s5,10
ffffffffc02000d0:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc02000d2:	000a6b97          	auipc	s7,0xa6
ffffffffc02000d6:	116b8b93          	addi	s7,s7,278 # ffffffffc02a61e8 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000da:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc02000de:	12e000ef          	jal	ra,ffffffffc020020c <getchar>
        if (c < 0) {
ffffffffc02000e2:	00054a63          	bltz	a0,ffffffffc02000f6 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000e6:	00a95a63          	bge	s2,a0,ffffffffc02000fa <readline+0x54>
ffffffffc02000ea:	029a5263          	bge	s4,s1,ffffffffc020010e <readline+0x68>
        c = getchar();
ffffffffc02000ee:	11e000ef          	jal	ra,ffffffffc020020c <getchar>
        if (c < 0) {
ffffffffc02000f2:	fe055ae3          	bgez	a0,ffffffffc02000e6 <readline+0x40>
            return NULL;
ffffffffc02000f6:	4501                	li	a0,0
ffffffffc02000f8:	a091                	j	ffffffffc020013c <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc02000fa:	03351463          	bne	a0,s3,ffffffffc0200122 <readline+0x7c>
ffffffffc02000fe:	e8a9                	bnez	s1,ffffffffc0200150 <readline+0xaa>
        c = getchar();
ffffffffc0200100:	10c000ef          	jal	ra,ffffffffc020020c <getchar>
        if (c < 0) {
ffffffffc0200104:	fe0549e3          	bltz	a0,ffffffffc02000f6 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0200108:	fea959e3          	bge	s2,a0,ffffffffc02000fa <readline+0x54>
ffffffffc020010c:	4481                	li	s1,0
            cputchar(c);
ffffffffc020010e:	e42a                	sd	a0,8(sp)
ffffffffc0200110:	0ba000ef          	jal	ra,ffffffffc02001ca <cputchar>
            buf[i ++] = c;
ffffffffc0200114:	6522                	ld	a0,8(sp)
ffffffffc0200116:	009b87b3          	add	a5,s7,s1
ffffffffc020011a:	2485                	addiw	s1,s1,1
ffffffffc020011c:	00a78023          	sb	a0,0(a5)
ffffffffc0200120:	bf7d                	j	ffffffffc02000de <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc0200122:	01550463          	beq	a0,s5,ffffffffc020012a <readline+0x84>
ffffffffc0200126:	fb651ce3          	bne	a0,s6,ffffffffc02000de <readline+0x38>
            cputchar(c);
ffffffffc020012a:	0a0000ef          	jal	ra,ffffffffc02001ca <cputchar>
            buf[i] = '\0';
ffffffffc020012e:	000a6517          	auipc	a0,0xa6
ffffffffc0200132:	0ba50513          	addi	a0,a0,186 # ffffffffc02a61e8 <buf>
ffffffffc0200136:	94aa                	add	s1,s1,a0
ffffffffc0200138:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc020013c:	60a6                	ld	ra,72(sp)
ffffffffc020013e:	6486                	ld	s1,64(sp)
ffffffffc0200140:	7962                	ld	s2,56(sp)
ffffffffc0200142:	79c2                	ld	s3,48(sp)
ffffffffc0200144:	7a22                	ld	s4,40(sp)
ffffffffc0200146:	7a82                	ld	s5,32(sp)
ffffffffc0200148:	6b62                	ld	s6,24(sp)
ffffffffc020014a:	6bc2                	ld	s7,16(sp)
ffffffffc020014c:	6161                	addi	sp,sp,80
ffffffffc020014e:	8082                	ret
            cputchar(c);
ffffffffc0200150:	4521                	li	a0,8
ffffffffc0200152:	078000ef          	jal	ra,ffffffffc02001ca <cputchar>
            i --;
ffffffffc0200156:	34fd                	addiw	s1,s1,-1
ffffffffc0200158:	b759                	j	ffffffffc02000de <readline+0x38>

ffffffffc020015a <cputch>:
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt)
{
ffffffffc020015a:	1141                	addi	sp,sp,-16
ffffffffc020015c:	e022                	sd	s0,0(sp)
ffffffffc020015e:	e406                	sd	ra,8(sp)
ffffffffc0200160:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc0200162:	42c000ef          	jal	ra,ffffffffc020058e <cons_putc>
    (*cnt)++;
ffffffffc0200166:	401c                	lw	a5,0(s0)
}
ffffffffc0200168:	60a2                	ld	ra,8(sp)
    (*cnt)++;
ffffffffc020016a:	2785                	addiw	a5,a5,1
ffffffffc020016c:	c01c                	sw	a5,0(s0)
}
ffffffffc020016e:	6402                	ld	s0,0(sp)
ffffffffc0200170:	0141                	addi	sp,sp,16
ffffffffc0200172:	8082                	ret

ffffffffc0200174 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int vcprintf(const char *fmt, va_list ap)
{
ffffffffc0200174:	1101                	addi	sp,sp,-32
ffffffffc0200176:	862a                	mv	a2,a0
ffffffffc0200178:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc020017a:	00000517          	auipc	a0,0x0
ffffffffc020017e:	fe050513          	addi	a0,a0,-32 # ffffffffc020015a <cputch>
ffffffffc0200182:	006c                	addi	a1,sp,12
{
ffffffffc0200184:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc0200186:	c602                	sw	zero,12(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc0200188:	0d8050ef          	jal	ra,ffffffffc0205260 <vprintfmt>
    return cnt;
}
ffffffffc020018c:	60e2                	ld	ra,24(sp)
ffffffffc020018e:	4532                	lw	a0,12(sp)
ffffffffc0200190:	6105                	addi	sp,sp,32
ffffffffc0200192:	8082                	ret

ffffffffc0200194 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int cprintf(const char *fmt, ...)
{
ffffffffc0200194:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc0200196:	02810313          	addi	t1,sp,40 # ffffffffc020a028 <boot_page_table_sv39+0x28>
{
ffffffffc020019a:	8e2a                	mv	t3,a0
ffffffffc020019c:	f42e                	sd	a1,40(sp)
ffffffffc020019e:	f832                	sd	a2,48(sp)
ffffffffc02001a0:	fc36                	sd	a3,56(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc02001a2:	00000517          	auipc	a0,0x0
ffffffffc02001a6:	fb850513          	addi	a0,a0,-72 # ffffffffc020015a <cputch>
ffffffffc02001aa:	004c                	addi	a1,sp,4
ffffffffc02001ac:	869a                	mv	a3,t1
ffffffffc02001ae:	8672                	mv	a2,t3
{
ffffffffc02001b0:	ec06                	sd	ra,24(sp)
ffffffffc02001b2:	e0ba                	sd	a4,64(sp)
ffffffffc02001b4:	e4be                	sd	a5,72(sp)
ffffffffc02001b6:	e8c2                	sd	a6,80(sp)
ffffffffc02001b8:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc02001ba:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc02001bc:	c202                	sw	zero,4(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc02001be:	0a2050ef          	jal	ra,ffffffffc0205260 <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc02001c2:	60e2                	ld	ra,24(sp)
ffffffffc02001c4:	4512                	lw	a0,4(sp)
ffffffffc02001c6:	6125                	addi	sp,sp,96
ffffffffc02001c8:	8082                	ret

ffffffffc02001ca <cputchar>:

/* cputchar - writes a single character to stdout */
void cputchar(int c)
{
    cons_putc(c);
ffffffffc02001ca:	a6d1                	j	ffffffffc020058e <cons_putc>

ffffffffc02001cc <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int cputs(const char *str)
{
ffffffffc02001cc:	1101                	addi	sp,sp,-32
ffffffffc02001ce:	e822                	sd	s0,16(sp)
ffffffffc02001d0:	ec06                	sd	ra,24(sp)
ffffffffc02001d2:	e426                	sd	s1,8(sp)
ffffffffc02001d4:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str++) != '\0')
ffffffffc02001d6:	00054503          	lbu	a0,0(a0)
ffffffffc02001da:	c51d                	beqz	a0,ffffffffc0200208 <cputs+0x3c>
ffffffffc02001dc:	0405                	addi	s0,s0,1
ffffffffc02001de:	4485                	li	s1,1
ffffffffc02001e0:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc02001e2:	3ac000ef          	jal	ra,ffffffffc020058e <cons_putc>
    while ((c = *str++) != '\0')
ffffffffc02001e6:	00044503          	lbu	a0,0(s0)
ffffffffc02001ea:	008487bb          	addw	a5,s1,s0
ffffffffc02001ee:	0405                	addi	s0,s0,1
ffffffffc02001f0:	f96d                	bnez	a0,ffffffffc02001e2 <cputs+0x16>
    (*cnt)++;
ffffffffc02001f2:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc02001f6:	4529                	li	a0,10
ffffffffc02001f8:	396000ef          	jal	ra,ffffffffc020058e <cons_putc>
    {
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc02001fc:	60e2                	ld	ra,24(sp)
ffffffffc02001fe:	8522                	mv	a0,s0
ffffffffc0200200:	6442                	ld	s0,16(sp)
ffffffffc0200202:	64a2                	ld	s1,8(sp)
ffffffffc0200204:	6105                	addi	sp,sp,32
ffffffffc0200206:	8082                	ret
    while ((c = *str++) != '\0')
ffffffffc0200208:	4405                	li	s0,1
ffffffffc020020a:	b7f5                	j	ffffffffc02001f6 <cputs+0x2a>

ffffffffc020020c <getchar>:

/* getchar - reads a single non-zero character from stdin */
int getchar(void)
{
ffffffffc020020c:	1141                	addi	sp,sp,-16
ffffffffc020020e:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc0200210:	3b2000ef          	jal	ra,ffffffffc02005c2 <cons_getc>
ffffffffc0200214:	dd75                	beqz	a0,ffffffffc0200210 <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc0200216:	60a2                	ld	ra,8(sp)
ffffffffc0200218:	0141                	addi	sp,sp,16
ffffffffc020021a:	8082                	ret

ffffffffc020021c <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void)
{
ffffffffc020021c:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc020021e:	00005517          	auipc	a0,0x5
ffffffffc0200222:	4c250513          	addi	a0,a0,1218 # ffffffffc02056e0 <etext+0x32>
{
ffffffffc0200226:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc0200228:	f6dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  entry  0x%08x (virtual)\n", kern_init);
ffffffffc020022c:	00000597          	auipc	a1,0x0
ffffffffc0200230:	e1e58593          	addi	a1,a1,-482 # ffffffffc020004a <kern_init>
ffffffffc0200234:	00005517          	auipc	a0,0x5
ffffffffc0200238:	4cc50513          	addi	a0,a0,1228 # ffffffffc0205700 <etext+0x52>
ffffffffc020023c:	f59ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  etext  0x%08x (virtual)\n", etext);
ffffffffc0200240:	00005597          	auipc	a1,0x5
ffffffffc0200244:	46e58593          	addi	a1,a1,1134 # ffffffffc02056ae <etext>
ffffffffc0200248:	00005517          	auipc	a0,0x5
ffffffffc020024c:	4d850513          	addi	a0,a0,1240 # ffffffffc0205720 <etext+0x72>
ffffffffc0200250:	f45ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  edata  0x%08x (virtual)\n", edata);
ffffffffc0200254:	000a6597          	auipc	a1,0xa6
ffffffffc0200258:	f9458593          	addi	a1,a1,-108 # ffffffffc02a61e8 <buf>
ffffffffc020025c:	00005517          	auipc	a0,0x5
ffffffffc0200260:	4e450513          	addi	a0,a0,1252 # ffffffffc0205740 <etext+0x92>
ffffffffc0200264:	f31ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  end    0x%08x (virtual)\n", end);
ffffffffc0200268:	000aa597          	auipc	a1,0xaa
ffffffffc020026c:	42458593          	addi	a1,a1,1060 # ffffffffc02aa68c <end>
ffffffffc0200270:	00005517          	auipc	a0,0x5
ffffffffc0200274:	4f050513          	addi	a0,a0,1264 # ffffffffc0205760 <etext+0xb2>
ffffffffc0200278:	f1dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc020027c:	000ab597          	auipc	a1,0xab
ffffffffc0200280:	80f58593          	addi	a1,a1,-2033 # ffffffffc02aaa8b <end+0x3ff>
ffffffffc0200284:	00000797          	auipc	a5,0x0
ffffffffc0200288:	dc678793          	addi	a5,a5,-570 # ffffffffc020004a <kern_init>
ffffffffc020028c:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200290:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc0200294:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200296:	3ff5f593          	andi	a1,a1,1023
ffffffffc020029a:	95be                	add	a1,a1,a5
ffffffffc020029c:	85a9                	srai	a1,a1,0xa
ffffffffc020029e:	00005517          	auipc	a0,0x5
ffffffffc02002a2:	4e250513          	addi	a0,a0,1250 # ffffffffc0205780 <etext+0xd2>
}
ffffffffc02002a6:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02002a8:	b5f5                	j	ffffffffc0200194 <cprintf>

ffffffffc02002aa <print_stackframe>:
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void)
{
ffffffffc02002aa:	1141                	addi	sp,sp,-16
    panic("Not Implemented!");
ffffffffc02002ac:	00005617          	auipc	a2,0x5
ffffffffc02002b0:	50460613          	addi	a2,a2,1284 # ffffffffc02057b0 <etext+0x102>
ffffffffc02002b4:	04f00593          	li	a1,79
ffffffffc02002b8:	00005517          	auipc	a0,0x5
ffffffffc02002bc:	51050513          	addi	a0,a0,1296 # ffffffffc02057c8 <etext+0x11a>
{
ffffffffc02002c0:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc02002c2:	1cc000ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02002c6 <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int mon_help(int argc, char **argv, struct trapframe *tf)
{
ffffffffc02002c6:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i++)
    {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc02002c8:	00005617          	auipc	a2,0x5
ffffffffc02002cc:	51860613          	addi	a2,a2,1304 # ffffffffc02057e0 <etext+0x132>
ffffffffc02002d0:	00005597          	auipc	a1,0x5
ffffffffc02002d4:	53058593          	addi	a1,a1,1328 # ffffffffc0205800 <etext+0x152>
ffffffffc02002d8:	00005517          	auipc	a0,0x5
ffffffffc02002dc:	53050513          	addi	a0,a0,1328 # ffffffffc0205808 <etext+0x15a>
{
ffffffffc02002e0:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc02002e2:	eb3ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc02002e6:	00005617          	auipc	a2,0x5
ffffffffc02002ea:	53260613          	addi	a2,a2,1330 # ffffffffc0205818 <etext+0x16a>
ffffffffc02002ee:	00005597          	auipc	a1,0x5
ffffffffc02002f2:	55258593          	addi	a1,a1,1362 # ffffffffc0205840 <etext+0x192>
ffffffffc02002f6:	00005517          	auipc	a0,0x5
ffffffffc02002fa:	51250513          	addi	a0,a0,1298 # ffffffffc0205808 <etext+0x15a>
ffffffffc02002fe:	e97ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc0200302:	00005617          	auipc	a2,0x5
ffffffffc0200306:	54e60613          	addi	a2,a2,1358 # ffffffffc0205850 <etext+0x1a2>
ffffffffc020030a:	00005597          	auipc	a1,0x5
ffffffffc020030e:	56658593          	addi	a1,a1,1382 # ffffffffc0205870 <etext+0x1c2>
ffffffffc0200312:	00005517          	auipc	a0,0x5
ffffffffc0200316:	4f650513          	addi	a0,a0,1270 # ffffffffc0205808 <etext+0x15a>
ffffffffc020031a:	e7bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    }
    return 0;
}
ffffffffc020031e:	60a2                	ld	ra,8(sp)
ffffffffc0200320:	4501                	li	a0,0
ffffffffc0200322:	0141                	addi	sp,sp,16
ffffffffc0200324:	8082                	ret

ffffffffc0200326 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int mon_kerninfo(int argc, char **argv, struct trapframe *tf)
{
ffffffffc0200326:	1141                	addi	sp,sp,-16
ffffffffc0200328:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc020032a:	ef3ff0ef          	jal	ra,ffffffffc020021c <print_kerninfo>
    return 0;
}
ffffffffc020032e:	60a2                	ld	ra,8(sp)
ffffffffc0200330:	4501                	li	a0,0
ffffffffc0200332:	0141                	addi	sp,sp,16
ffffffffc0200334:	8082                	ret

ffffffffc0200336 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int mon_backtrace(int argc, char **argv, struct trapframe *tf)
{
ffffffffc0200336:	1141                	addi	sp,sp,-16
ffffffffc0200338:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc020033a:	f71ff0ef          	jal	ra,ffffffffc02002aa <print_stackframe>
    return 0;
}
ffffffffc020033e:	60a2                	ld	ra,8(sp)
ffffffffc0200340:	4501                	li	a0,0
ffffffffc0200342:	0141                	addi	sp,sp,16
ffffffffc0200344:	8082                	ret

ffffffffc0200346 <kmonitor>:
{
ffffffffc0200346:	7115                	addi	sp,sp,-224
ffffffffc0200348:	ed5e                	sd	s7,152(sp)
ffffffffc020034a:	8baa                	mv	s7,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc020034c:	00005517          	auipc	a0,0x5
ffffffffc0200350:	53450513          	addi	a0,a0,1332 # ffffffffc0205880 <etext+0x1d2>
{
ffffffffc0200354:	ed86                	sd	ra,216(sp)
ffffffffc0200356:	e9a2                	sd	s0,208(sp)
ffffffffc0200358:	e5a6                	sd	s1,200(sp)
ffffffffc020035a:	e1ca                	sd	s2,192(sp)
ffffffffc020035c:	fd4e                	sd	s3,184(sp)
ffffffffc020035e:	f952                	sd	s4,176(sp)
ffffffffc0200360:	f556                	sd	s5,168(sp)
ffffffffc0200362:	f15a                	sd	s6,160(sp)
ffffffffc0200364:	e962                	sd	s8,144(sp)
ffffffffc0200366:	e566                	sd	s9,136(sp)
ffffffffc0200368:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc020036a:	e2bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc020036e:	00005517          	auipc	a0,0x5
ffffffffc0200372:	53a50513          	addi	a0,a0,1338 # ffffffffc02058a8 <etext+0x1fa>
ffffffffc0200376:	e1fff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    if (tf != NULL)
ffffffffc020037a:	000b8563          	beqz	s7,ffffffffc0200384 <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc020037e:	855e                	mv	a0,s7
ffffffffc0200380:	025000ef          	jal	ra,ffffffffc0200ba4 <print_trapframe>
ffffffffc0200384:	00005c17          	auipc	s8,0x5
ffffffffc0200388:	594c0c13          	addi	s8,s8,1428 # ffffffffc0205918 <commands>
        if ((buf = readline("K> ")) != NULL)
ffffffffc020038c:	00005917          	auipc	s2,0x5
ffffffffc0200390:	54490913          	addi	s2,s2,1348 # ffffffffc02058d0 <etext+0x222>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc0200394:	00005497          	auipc	s1,0x5
ffffffffc0200398:	54448493          	addi	s1,s1,1348 # ffffffffc02058d8 <etext+0x22a>
        if (argc == MAXARGS - 1)
ffffffffc020039c:	49bd                	li	s3,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc020039e:	00005b17          	auipc	s6,0x5
ffffffffc02003a2:	542b0b13          	addi	s6,s6,1346 # ffffffffc02058e0 <etext+0x232>
        argv[argc++] = buf;
ffffffffc02003a6:	00005a17          	auipc	s4,0x5
ffffffffc02003aa:	45aa0a13          	addi	s4,s4,1114 # ffffffffc0205800 <etext+0x152>
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc02003ae:	4a8d                	li	s5,3
        if ((buf = readline("K> ")) != NULL)
ffffffffc02003b0:	854a                	mv	a0,s2
ffffffffc02003b2:	cf5ff0ef          	jal	ra,ffffffffc02000a6 <readline>
ffffffffc02003b6:	842a                	mv	s0,a0
ffffffffc02003b8:	dd65                	beqz	a0,ffffffffc02003b0 <kmonitor+0x6a>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc02003ba:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc02003be:	4c81                	li	s9,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc02003c0:	e1bd                	bnez	a1,ffffffffc0200426 <kmonitor+0xe0>
    if (argc == 0)
ffffffffc02003c2:	fe0c87e3          	beqz	s9,ffffffffc02003b0 <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc02003c6:	6582                	ld	a1,0(sp)
ffffffffc02003c8:	00005d17          	auipc	s10,0x5
ffffffffc02003cc:	550d0d13          	addi	s10,s10,1360 # ffffffffc0205918 <commands>
        argv[argc++] = buf;
ffffffffc02003d0:	8552                	mv	a0,s4
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc02003d2:	4401                	li	s0,0
ffffffffc02003d4:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc02003d6:	254050ef          	jal	ra,ffffffffc020562a <strcmp>
ffffffffc02003da:	c919                	beqz	a0,ffffffffc02003f0 <kmonitor+0xaa>
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc02003dc:	2405                	addiw	s0,s0,1
ffffffffc02003de:	0b540063          	beq	s0,s5,ffffffffc020047e <kmonitor+0x138>
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc02003e2:	000d3503          	ld	a0,0(s10)
ffffffffc02003e6:	6582                	ld	a1,0(sp)
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc02003e8:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc02003ea:	240050ef          	jal	ra,ffffffffc020562a <strcmp>
ffffffffc02003ee:	f57d                	bnez	a0,ffffffffc02003dc <kmonitor+0x96>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc02003f0:	00141793          	slli	a5,s0,0x1
ffffffffc02003f4:	97a2                	add	a5,a5,s0
ffffffffc02003f6:	078e                	slli	a5,a5,0x3
ffffffffc02003f8:	97e2                	add	a5,a5,s8
ffffffffc02003fa:	6b9c                	ld	a5,16(a5)
ffffffffc02003fc:	865e                	mv	a2,s7
ffffffffc02003fe:	002c                	addi	a1,sp,8
ffffffffc0200400:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200404:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0)
ffffffffc0200406:	fa0555e3          	bgez	a0,ffffffffc02003b0 <kmonitor+0x6a>
}
ffffffffc020040a:	60ee                	ld	ra,216(sp)
ffffffffc020040c:	644e                	ld	s0,208(sp)
ffffffffc020040e:	64ae                	ld	s1,200(sp)
ffffffffc0200410:	690e                	ld	s2,192(sp)
ffffffffc0200412:	79ea                	ld	s3,184(sp)
ffffffffc0200414:	7a4a                	ld	s4,176(sp)
ffffffffc0200416:	7aaa                	ld	s5,168(sp)
ffffffffc0200418:	7b0a                	ld	s6,160(sp)
ffffffffc020041a:	6bea                	ld	s7,152(sp)
ffffffffc020041c:	6c4a                	ld	s8,144(sp)
ffffffffc020041e:	6caa                	ld	s9,136(sp)
ffffffffc0200420:	6d0a                	ld	s10,128(sp)
ffffffffc0200422:	612d                	addi	sp,sp,224
ffffffffc0200424:	8082                	ret
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc0200426:	8526                	mv	a0,s1
ffffffffc0200428:	246050ef          	jal	ra,ffffffffc020566e <strchr>
ffffffffc020042c:	c901                	beqz	a0,ffffffffc020043c <kmonitor+0xf6>
ffffffffc020042e:	00144583          	lbu	a1,1(s0)
            *buf++ = '\0';
ffffffffc0200432:	00040023          	sb	zero,0(s0)
ffffffffc0200436:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc0200438:	d5c9                	beqz	a1,ffffffffc02003c2 <kmonitor+0x7c>
ffffffffc020043a:	b7f5                	j	ffffffffc0200426 <kmonitor+0xe0>
        if (*buf == '\0')
ffffffffc020043c:	00044783          	lbu	a5,0(s0)
ffffffffc0200440:	d3c9                	beqz	a5,ffffffffc02003c2 <kmonitor+0x7c>
        if (argc == MAXARGS - 1)
ffffffffc0200442:	033c8963          	beq	s9,s3,ffffffffc0200474 <kmonitor+0x12e>
        argv[argc++] = buf;
ffffffffc0200446:	003c9793          	slli	a5,s9,0x3
ffffffffc020044a:	0118                	addi	a4,sp,128
ffffffffc020044c:	97ba                	add	a5,a5,a4
ffffffffc020044e:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL)
ffffffffc0200452:	00044583          	lbu	a1,0(s0)
        argv[argc++] = buf;
ffffffffc0200456:	2c85                	addiw	s9,s9,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL)
ffffffffc0200458:	e591                	bnez	a1,ffffffffc0200464 <kmonitor+0x11e>
ffffffffc020045a:	b7b5                	j	ffffffffc02003c6 <kmonitor+0x80>
ffffffffc020045c:	00144583          	lbu	a1,1(s0)
            buf++;
ffffffffc0200460:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL)
ffffffffc0200462:	d1a5                	beqz	a1,ffffffffc02003c2 <kmonitor+0x7c>
ffffffffc0200464:	8526                	mv	a0,s1
ffffffffc0200466:	208050ef          	jal	ra,ffffffffc020566e <strchr>
ffffffffc020046a:	d96d                	beqz	a0,ffffffffc020045c <kmonitor+0x116>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc020046c:	00044583          	lbu	a1,0(s0)
ffffffffc0200470:	d9a9                	beqz	a1,ffffffffc02003c2 <kmonitor+0x7c>
ffffffffc0200472:	bf55                	j	ffffffffc0200426 <kmonitor+0xe0>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc0200474:	45c1                	li	a1,16
ffffffffc0200476:	855a                	mv	a0,s6
ffffffffc0200478:	d1dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc020047c:	b7e9                	j	ffffffffc0200446 <kmonitor+0x100>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc020047e:	6582                	ld	a1,0(sp)
ffffffffc0200480:	00005517          	auipc	a0,0x5
ffffffffc0200484:	48050513          	addi	a0,a0,1152 # ffffffffc0205900 <etext+0x252>
ffffffffc0200488:	d0dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    return 0;
ffffffffc020048c:	b715                	j	ffffffffc02003b0 <kmonitor+0x6a>

ffffffffc020048e <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void __panic(const char *file, int line, const char *fmt, ...)
{
    if (is_panic)
ffffffffc020048e:	000aa317          	auipc	t1,0xaa
ffffffffc0200492:	18230313          	addi	t1,t1,386 # ffffffffc02aa610 <is_panic>
ffffffffc0200496:	00033e03          	ld	t3,0(t1)
{
ffffffffc020049a:	715d                	addi	sp,sp,-80
ffffffffc020049c:	ec06                	sd	ra,24(sp)
ffffffffc020049e:	e822                	sd	s0,16(sp)
ffffffffc02004a0:	f436                	sd	a3,40(sp)
ffffffffc02004a2:	f83a                	sd	a4,48(sp)
ffffffffc02004a4:	fc3e                	sd	a5,56(sp)
ffffffffc02004a6:	e0c2                	sd	a6,64(sp)
ffffffffc02004a8:	e4c6                	sd	a7,72(sp)
    if (is_panic)
ffffffffc02004aa:	020e1a63          	bnez	t3,ffffffffc02004de <__panic+0x50>
    {
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc02004ae:	4785                	li	a5,1
ffffffffc02004b0:	00f33023          	sd	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc02004b4:	8432                	mv	s0,a2
ffffffffc02004b6:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02004b8:	862e                	mv	a2,a1
ffffffffc02004ba:	85aa                	mv	a1,a0
ffffffffc02004bc:	00005517          	auipc	a0,0x5
ffffffffc02004c0:	4a450513          	addi	a0,a0,1188 # ffffffffc0205960 <commands+0x48>
    va_start(ap, fmt);
ffffffffc02004c4:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02004c6:	ccfff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    vcprintf(fmt, ap);
ffffffffc02004ca:	65a2                	ld	a1,8(sp)
ffffffffc02004cc:	8522                	mv	a0,s0
ffffffffc02004ce:	ca7ff0ef          	jal	ra,ffffffffc0200174 <vcprintf>
    cprintf("\n");
ffffffffc02004d2:	00006517          	auipc	a0,0x6
ffffffffc02004d6:	59650513          	addi	a0,a0,1430 # ffffffffc0206a68 <default_pmm_manager+0x578>
ffffffffc02004da:	cbbff0ef          	jal	ra,ffffffffc0200194 <cprintf>
#endif
}

static inline void sbi_shutdown(void)
{
	SBI_CALL_0(SBI_SHUTDOWN);
ffffffffc02004de:	4501                	li	a0,0
ffffffffc02004e0:	4581                	li	a1,0
ffffffffc02004e2:	4601                	li	a2,0
ffffffffc02004e4:	48a1                	li	a7,8
ffffffffc02004e6:	00000073          	ecall
    va_end(ap);

panic_dead:
    // No debug monitor here
    sbi_shutdown();
    intr_disable();
ffffffffc02004ea:	4ca000ef          	jal	ra,ffffffffc02009b4 <intr_disable>
    while (1)
    {
        kmonitor(NULL);
ffffffffc02004ee:	4501                	li	a0,0
ffffffffc02004f0:	e57ff0ef          	jal	ra,ffffffffc0200346 <kmonitor>
    while (1)
ffffffffc02004f4:	bfed                	j	ffffffffc02004ee <__panic+0x60>

ffffffffc02004f6 <__warn>:
    }
}

/* __warn - like panic, but don't */
void __warn(const char *file, int line, const char *fmt, ...)
{
ffffffffc02004f6:	715d                	addi	sp,sp,-80
ffffffffc02004f8:	832e                	mv	t1,a1
ffffffffc02004fa:	e822                	sd	s0,16(sp)
    va_list ap;
    va_start(ap, fmt);
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc02004fc:	85aa                	mv	a1,a0
{
ffffffffc02004fe:	8432                	mv	s0,a2
ffffffffc0200500:	fc3e                	sd	a5,56(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200502:	861a                	mv	a2,t1
    va_start(ap, fmt);
ffffffffc0200504:	103c                	addi	a5,sp,40
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200506:	00005517          	auipc	a0,0x5
ffffffffc020050a:	47a50513          	addi	a0,a0,1146 # ffffffffc0205980 <commands+0x68>
{
ffffffffc020050e:	ec06                	sd	ra,24(sp)
ffffffffc0200510:	f436                	sd	a3,40(sp)
ffffffffc0200512:	f83a                	sd	a4,48(sp)
ffffffffc0200514:	e0c2                	sd	a6,64(sp)
ffffffffc0200516:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0200518:	e43e                	sd	a5,8(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020051a:	c7bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    vcprintf(fmt, ap);
ffffffffc020051e:	65a2                	ld	a1,8(sp)
ffffffffc0200520:	8522                	mv	a0,s0
ffffffffc0200522:	c53ff0ef          	jal	ra,ffffffffc0200174 <vcprintf>
    cprintf("\n");
ffffffffc0200526:	00006517          	auipc	a0,0x6
ffffffffc020052a:	54250513          	addi	a0,a0,1346 # ffffffffc0206a68 <default_pmm_manager+0x578>
ffffffffc020052e:	c67ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    va_end(ap);
}
ffffffffc0200532:	60e2                	ld	ra,24(sp)
ffffffffc0200534:	6442                	ld	s0,16(sp)
ffffffffc0200536:	6161                	addi	sp,sp,80
ffffffffc0200538:	8082                	ret

ffffffffc020053a <clock_init>:
 * and then enable IRQ_TIMER.
 * */
void clock_init(void) {
    // divided by 500 when using Spike(2MHz)
    // divided by 100 when using QEMU(10MHz)
    timebase = 1e7 / 100;
ffffffffc020053a:	67e1                	lui	a5,0x18
ffffffffc020053c:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_exit_out_size+0xd588>
ffffffffc0200540:	000aa717          	auipc	a4,0xaa
ffffffffc0200544:	0ef73023          	sd	a5,224(a4) # ffffffffc02aa620 <timebase>
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200548:	c0102573          	rdtime	a0
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
ffffffffc020054c:	4581                	li	a1,0
    ticks = 0;

    cprintf("++ setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc020054e:	953e                	add	a0,a0,a5
ffffffffc0200550:	4601                	li	a2,0
ffffffffc0200552:	4881                	li	a7,0
ffffffffc0200554:	00000073          	ecall
    set_csr(sie, MIP_STIP);
ffffffffc0200558:	02000793          	li	a5,32
ffffffffc020055c:	1047a7f3          	csrrs	a5,sie,a5
    cprintf("++ setup timer interrupts\n");
ffffffffc0200560:	00005517          	auipc	a0,0x5
ffffffffc0200564:	44050513          	addi	a0,a0,1088 # ffffffffc02059a0 <commands+0x88>
    ticks = 0;
ffffffffc0200568:	000aa797          	auipc	a5,0xaa
ffffffffc020056c:	0a07b823          	sd	zero,176(a5) # ffffffffc02aa618 <ticks>
    cprintf("++ setup timer interrupts\n");
ffffffffc0200570:	b115                	j	ffffffffc0200194 <cprintf>

ffffffffc0200572 <clock_set_next_event>:
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200572:	c0102573          	rdtime	a0
void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc0200576:	000aa797          	auipc	a5,0xaa
ffffffffc020057a:	0aa7b783          	ld	a5,170(a5) # ffffffffc02aa620 <timebase>
ffffffffc020057e:	953e                	add	a0,a0,a5
ffffffffc0200580:	4581                	li	a1,0
ffffffffc0200582:	4601                	li	a2,0
ffffffffc0200584:	4881                	li	a7,0
ffffffffc0200586:	00000073          	ecall
ffffffffc020058a:	8082                	ret

ffffffffc020058c <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc020058c:	8082                	ret

ffffffffc020058e <cons_putc>:
#include <riscv.h>
#include <assert.h>

static inline bool __intr_save(void)
{
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020058e:	100027f3          	csrr	a5,sstatus
ffffffffc0200592:	8b89                	andi	a5,a5,2
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
ffffffffc0200594:	0ff57513          	zext.b	a0,a0
ffffffffc0200598:	e799                	bnez	a5,ffffffffc02005a6 <cons_putc+0x18>
ffffffffc020059a:	4581                	li	a1,0
ffffffffc020059c:	4601                	li	a2,0
ffffffffc020059e:	4885                	li	a7,1
ffffffffc02005a0:	00000073          	ecall
    return 0;
}

static inline void __intr_restore(bool flag)
{
    if (flag)
ffffffffc02005a4:	8082                	ret

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) {
ffffffffc02005a6:	1101                	addi	sp,sp,-32
ffffffffc02005a8:	ec06                	sd	ra,24(sp)
ffffffffc02005aa:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02005ac:	408000ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc02005b0:	6522                	ld	a0,8(sp)
ffffffffc02005b2:	4581                	li	a1,0
ffffffffc02005b4:	4601                	li	a2,0
ffffffffc02005b6:	4885                	li	a7,1
ffffffffc02005b8:	00000073          	ecall
    local_intr_save(intr_flag);
    {
        sbi_console_putchar((unsigned char)c);
    }
    local_intr_restore(intr_flag);
}
ffffffffc02005bc:	60e2                	ld	ra,24(sp)
ffffffffc02005be:	6105                	addi	sp,sp,32
    {
        intr_enable();
ffffffffc02005c0:	a6fd                	j	ffffffffc02009ae <intr_enable>

ffffffffc02005c2 <cons_getc>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02005c2:	100027f3          	csrr	a5,sstatus
ffffffffc02005c6:	8b89                	andi	a5,a5,2
ffffffffc02005c8:	eb89                	bnez	a5,ffffffffc02005da <cons_getc+0x18>
	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
ffffffffc02005ca:	4501                	li	a0,0
ffffffffc02005cc:	4581                	li	a1,0
ffffffffc02005ce:	4601                	li	a2,0
ffffffffc02005d0:	4889                	li	a7,2
ffffffffc02005d2:	00000073          	ecall
ffffffffc02005d6:	2501                	sext.w	a0,a0
    {
        c = sbi_console_getchar();
    }
    local_intr_restore(intr_flag);
    return c;
}
ffffffffc02005d8:	8082                	ret
int cons_getc(void) {
ffffffffc02005da:	1101                	addi	sp,sp,-32
ffffffffc02005dc:	ec06                	sd	ra,24(sp)
        intr_disable();
ffffffffc02005de:	3d6000ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc02005e2:	4501                	li	a0,0
ffffffffc02005e4:	4581                	li	a1,0
ffffffffc02005e6:	4601                	li	a2,0
ffffffffc02005e8:	4889                	li	a7,2
ffffffffc02005ea:	00000073          	ecall
ffffffffc02005ee:	2501                	sext.w	a0,a0
ffffffffc02005f0:	e42a                	sd	a0,8(sp)
        intr_enable();
ffffffffc02005f2:	3bc000ef          	jal	ra,ffffffffc02009ae <intr_enable>
}
ffffffffc02005f6:	60e2                	ld	ra,24(sp)
ffffffffc02005f8:	6522                	ld	a0,8(sp)
ffffffffc02005fa:	6105                	addi	sp,sp,32
ffffffffc02005fc:	8082                	ret

ffffffffc02005fe <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc02005fe:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc0200600:	00005517          	auipc	a0,0x5
ffffffffc0200604:	3c050513          	addi	a0,a0,960 # ffffffffc02059c0 <commands+0xa8>
void dtb_init(void) {
ffffffffc0200608:	fc86                	sd	ra,120(sp)
ffffffffc020060a:	f8a2                	sd	s0,112(sp)
ffffffffc020060c:	e8d2                	sd	s4,80(sp)
ffffffffc020060e:	f4a6                	sd	s1,104(sp)
ffffffffc0200610:	f0ca                	sd	s2,96(sp)
ffffffffc0200612:	ecce                	sd	s3,88(sp)
ffffffffc0200614:	e4d6                	sd	s5,72(sp)
ffffffffc0200616:	e0da                	sd	s6,64(sp)
ffffffffc0200618:	fc5e                	sd	s7,56(sp)
ffffffffc020061a:	f862                	sd	s8,48(sp)
ffffffffc020061c:	f466                	sd	s9,40(sp)
ffffffffc020061e:	f06a                	sd	s10,32(sp)
ffffffffc0200620:	ec6e                	sd	s11,24(sp)
    cprintf("DTB Init\n");
ffffffffc0200622:	b73ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("HartID: %ld\n", boot_hartid);
ffffffffc0200626:	0000b597          	auipc	a1,0xb
ffffffffc020062a:	9da5b583          	ld	a1,-1574(a1) # ffffffffc020b000 <boot_hartid>
ffffffffc020062e:	00005517          	auipc	a0,0x5
ffffffffc0200632:	3a250513          	addi	a0,a0,930 # ffffffffc02059d0 <commands+0xb8>
ffffffffc0200636:	b5fff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc020063a:	0000b417          	auipc	s0,0xb
ffffffffc020063e:	9ce40413          	addi	s0,s0,-1586 # ffffffffc020b008 <boot_dtb>
ffffffffc0200642:	600c                	ld	a1,0(s0)
ffffffffc0200644:	00005517          	auipc	a0,0x5
ffffffffc0200648:	39c50513          	addi	a0,a0,924 # ffffffffc02059e0 <commands+0xc8>
ffffffffc020064c:	b49ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc0200650:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc0200654:	00005517          	auipc	a0,0x5
ffffffffc0200658:	3a450513          	addi	a0,a0,932 # ffffffffc02059f8 <commands+0xe0>
    if (boot_dtb == 0) {
ffffffffc020065c:	120a0463          	beqz	s4,ffffffffc0200784 <dtb_init+0x186>
        return;
    }
    
    // 转换为虚拟地址
    uintptr_t dtb_vaddr = boot_dtb + PHYSICAL_MEMORY_OFFSET;
ffffffffc0200660:	57f5                	li	a5,-3
ffffffffc0200662:	07fa                	slli	a5,a5,0x1e
ffffffffc0200664:	00fa0733          	add	a4,s4,a5
    const struct fdt_header *header = (const struct fdt_header *)dtb_vaddr;
    
    // 验证DTB
    uint32_t magic = fdt32_to_cpu(header->magic);
ffffffffc0200668:	431c                	lw	a5,0(a4)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020066a:	00ff0637          	lui	a2,0xff0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020066e:	6b41                	lui	s6,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200670:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200674:	0187969b          	slliw	a3,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200678:	0187d51b          	srliw	a0,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020067c:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200680:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200684:	8df1                	and	a1,a1,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200686:	8ec9                	or	a3,a3,a0
ffffffffc0200688:	0087979b          	slliw	a5,a5,0x8
ffffffffc020068c:	1b7d                	addi	s6,s6,-1
ffffffffc020068e:	0167f7b3          	and	a5,a5,s6
ffffffffc0200692:	8dd5                	or	a1,a1,a3
ffffffffc0200694:	8ddd                	or	a1,a1,a5
    if (magic != 0xd00dfeed) {
ffffffffc0200696:	d00e07b7          	lui	a5,0xd00e0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020069a:	2581                	sext.w	a1,a1
    if (magic != 0xd00dfeed) {
ffffffffc020069c:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfe35861>
ffffffffc02006a0:	10f59163          	bne	a1,a5,ffffffffc02007a2 <dtb_init+0x1a4>
        return;
    }
    
    // 提取内存信息
    uint64_t mem_base, mem_size;
    if (extract_memory_info(dtb_vaddr, header, &mem_base, &mem_size) == 0) {
ffffffffc02006a4:	471c                	lw	a5,8(a4)
ffffffffc02006a6:	4754                	lw	a3,12(a4)
    int in_memory_node = 0;
ffffffffc02006a8:	4c81                	li	s9,0
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006aa:	0087d59b          	srliw	a1,a5,0x8
ffffffffc02006ae:	0086d51b          	srliw	a0,a3,0x8
ffffffffc02006b2:	0186941b          	slliw	s0,a3,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006b6:	0186d89b          	srliw	a7,a3,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006ba:	01879a1b          	slliw	s4,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006be:	0187d81b          	srliw	a6,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006c2:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006c6:	0106d69b          	srliw	a3,a3,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006ca:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006ce:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006d2:	8d71                	and	a0,a0,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006d4:	01146433          	or	s0,s0,a7
ffffffffc02006d8:	0086969b          	slliw	a3,a3,0x8
ffffffffc02006dc:	010a6a33          	or	s4,s4,a6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006e0:	8e6d                	and	a2,a2,a1
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006e2:	0087979b          	slliw	a5,a5,0x8
ffffffffc02006e6:	8c49                	or	s0,s0,a0
ffffffffc02006e8:	0166f6b3          	and	a3,a3,s6
ffffffffc02006ec:	00ca6a33          	or	s4,s4,a2
ffffffffc02006f0:	0167f7b3          	and	a5,a5,s6
ffffffffc02006f4:	8c55                	or	s0,s0,a3
ffffffffc02006f6:	00fa6a33          	or	s4,s4,a5
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02006fa:	1402                	slli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02006fc:	1a02                	slli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02006fe:	9001                	srli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200700:	020a5a13          	srli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc0200704:	943a                	add	s0,s0,a4
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200706:	9a3a                	add	s4,s4,a4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200708:	00ff0c37          	lui	s8,0xff0
        switch (token) {
ffffffffc020070c:	4b8d                	li	s7,3
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020070e:	00005917          	auipc	s2,0x5
ffffffffc0200712:	33a90913          	addi	s2,s2,826 # ffffffffc0205a48 <commands+0x130>
ffffffffc0200716:	49bd                	li	s3,15
        switch (token) {
ffffffffc0200718:	4d91                	li	s11,4
ffffffffc020071a:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020071c:	00005497          	auipc	s1,0x5
ffffffffc0200720:	32448493          	addi	s1,s1,804 # ffffffffc0205a40 <commands+0x128>
        uint32_t token = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200724:	000a2703          	lw	a4,0(s4)
ffffffffc0200728:	004a0a93          	addi	s5,s4,4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020072c:	0087569b          	srliw	a3,a4,0x8
ffffffffc0200730:	0187179b          	slliw	a5,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200734:	0187561b          	srliw	a2,a4,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200738:	0106969b          	slliw	a3,a3,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020073c:	0107571b          	srliw	a4,a4,0x10
ffffffffc0200740:	8fd1                	or	a5,a5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200742:	0186f6b3          	and	a3,a3,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200746:	0087171b          	slliw	a4,a4,0x8
ffffffffc020074a:	8fd5                	or	a5,a5,a3
ffffffffc020074c:	00eb7733          	and	a4,s6,a4
ffffffffc0200750:	8fd9                	or	a5,a5,a4
ffffffffc0200752:	2781                	sext.w	a5,a5
        switch (token) {
ffffffffc0200754:	09778c63          	beq	a5,s7,ffffffffc02007ec <dtb_init+0x1ee>
ffffffffc0200758:	00fbea63          	bltu	s7,a5,ffffffffc020076c <dtb_init+0x16e>
ffffffffc020075c:	07a78663          	beq	a5,s10,ffffffffc02007c8 <dtb_init+0x1ca>
ffffffffc0200760:	4709                	li	a4,2
ffffffffc0200762:	00e79763          	bne	a5,a4,ffffffffc0200770 <dtb_init+0x172>
ffffffffc0200766:	4c81                	li	s9,0
ffffffffc0200768:	8a56                	mv	s4,s5
ffffffffc020076a:	bf6d                	j	ffffffffc0200724 <dtb_init+0x126>
ffffffffc020076c:	ffb78ee3          	beq	a5,s11,ffffffffc0200768 <dtb_init+0x16a>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
        // 保存到全局变量，供 PMM 查询
        memory_base = mem_base;
        memory_size = mem_size;
    } else {
        cprintf("Warning: Could not extract memory info from DTB\n");
ffffffffc0200770:	00005517          	auipc	a0,0x5
ffffffffc0200774:	35050513          	addi	a0,a0,848 # ffffffffc0205ac0 <commands+0x1a8>
ffffffffc0200778:	a1dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc020077c:	00005517          	auipc	a0,0x5
ffffffffc0200780:	37c50513          	addi	a0,a0,892 # ffffffffc0205af8 <commands+0x1e0>
}
ffffffffc0200784:	7446                	ld	s0,112(sp)
ffffffffc0200786:	70e6                	ld	ra,120(sp)
ffffffffc0200788:	74a6                	ld	s1,104(sp)
ffffffffc020078a:	7906                	ld	s2,96(sp)
ffffffffc020078c:	69e6                	ld	s3,88(sp)
ffffffffc020078e:	6a46                	ld	s4,80(sp)
ffffffffc0200790:	6aa6                	ld	s5,72(sp)
ffffffffc0200792:	6b06                	ld	s6,64(sp)
ffffffffc0200794:	7be2                	ld	s7,56(sp)
ffffffffc0200796:	7c42                	ld	s8,48(sp)
ffffffffc0200798:	7ca2                	ld	s9,40(sp)
ffffffffc020079a:	7d02                	ld	s10,32(sp)
ffffffffc020079c:	6de2                	ld	s11,24(sp)
ffffffffc020079e:	6109                	addi	sp,sp,128
    cprintf("DTB init completed\n");
ffffffffc02007a0:	bad5                	j	ffffffffc0200194 <cprintf>
}
ffffffffc02007a2:	7446                	ld	s0,112(sp)
ffffffffc02007a4:	70e6                	ld	ra,120(sp)
ffffffffc02007a6:	74a6                	ld	s1,104(sp)
ffffffffc02007a8:	7906                	ld	s2,96(sp)
ffffffffc02007aa:	69e6                	ld	s3,88(sp)
ffffffffc02007ac:	6a46                	ld	s4,80(sp)
ffffffffc02007ae:	6aa6                	ld	s5,72(sp)
ffffffffc02007b0:	6b06                	ld	s6,64(sp)
ffffffffc02007b2:	7be2                	ld	s7,56(sp)
ffffffffc02007b4:	7c42                	ld	s8,48(sp)
ffffffffc02007b6:	7ca2                	ld	s9,40(sp)
ffffffffc02007b8:	7d02                	ld	s10,32(sp)
ffffffffc02007ba:	6de2                	ld	s11,24(sp)
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02007bc:	00005517          	auipc	a0,0x5
ffffffffc02007c0:	25c50513          	addi	a0,a0,604 # ffffffffc0205a18 <commands+0x100>
}
ffffffffc02007c4:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02007c6:	b2f9                	j	ffffffffc0200194 <cprintf>
                int name_len = strlen(name);
ffffffffc02007c8:	8556                	mv	a0,s5
ffffffffc02007ca:	619040ef          	jal	ra,ffffffffc02055e2 <strlen>
ffffffffc02007ce:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02007d0:	4619                	li	a2,6
ffffffffc02007d2:	85a6                	mv	a1,s1
ffffffffc02007d4:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc02007d6:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02007d8:	671040ef          	jal	ra,ffffffffc0205648 <strncmp>
ffffffffc02007dc:	e111                	bnez	a0,ffffffffc02007e0 <dtb_init+0x1e2>
                    in_memory_node = 1;
ffffffffc02007de:	4c85                	li	s9,1
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + name_len + 4) & ~3);
ffffffffc02007e0:	0a91                	addi	s5,s5,4
ffffffffc02007e2:	9ad2                	add	s5,s5,s4
ffffffffc02007e4:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc02007e8:	8a56                	mv	s4,s5
ffffffffc02007ea:	bf2d                	j	ffffffffc0200724 <dtb_init+0x126>
                uint32_t prop_len = fdt32_to_cpu(*struct_ptr++);
ffffffffc02007ec:	004a2783          	lw	a5,4(s4)
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc02007f0:	00ca0693          	addi	a3,s4,12
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007f4:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02007f8:	01879a9b          	slliw	s5,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007fc:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200800:	0107171b          	slliw	a4,a4,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200804:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200808:	00caeab3          	or	s5,s5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020080c:	01877733          	and	a4,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200810:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200814:	00eaeab3          	or	s5,s5,a4
ffffffffc0200818:	00fb77b3          	and	a5,s6,a5
ffffffffc020081c:	00faeab3          	or	s5,s5,a5
ffffffffc0200820:	2a81                	sext.w	s5,s5
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200822:	000c9c63          	bnez	s9,ffffffffc020083a <dtb_init+0x23c>
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + prop_len + 3) & ~3);
ffffffffc0200826:	1a82                	slli	s5,s5,0x20
ffffffffc0200828:	00368793          	addi	a5,a3,3
ffffffffc020082c:	020ada93          	srli	s5,s5,0x20
ffffffffc0200830:	9abe                	add	s5,s5,a5
ffffffffc0200832:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc0200836:	8a56                	mv	s4,s5
ffffffffc0200838:	b5f5                	j	ffffffffc0200724 <dtb_init+0x126>
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc020083a:	008a2783          	lw	a5,8(s4)
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020083e:	85ca                	mv	a1,s2
ffffffffc0200840:	e436                	sd	a3,8(sp)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200842:	0087d51b          	srliw	a0,a5,0x8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200846:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020084a:	0187971b          	slliw	a4,a5,0x18
ffffffffc020084e:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200852:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200856:	8f51                	or	a4,a4,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200858:	01857533          	and	a0,a0,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020085c:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200860:	8d59                	or	a0,a0,a4
ffffffffc0200862:	00fb77b3          	and	a5,s6,a5
ffffffffc0200866:	8d5d                	or	a0,a0,a5
                const char *prop_name = strings_base + prop_nameoff;
ffffffffc0200868:	1502                	slli	a0,a0,0x20
ffffffffc020086a:	9101                	srli	a0,a0,0x20
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020086c:	9522                	add	a0,a0,s0
ffffffffc020086e:	5bd040ef          	jal	ra,ffffffffc020562a <strcmp>
ffffffffc0200872:	66a2                	ld	a3,8(sp)
ffffffffc0200874:	f94d                	bnez	a0,ffffffffc0200826 <dtb_init+0x228>
ffffffffc0200876:	fb59f8e3          	bgeu	s3,s5,ffffffffc0200826 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc020087a:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc020087e:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc0200882:	00005517          	auipc	a0,0x5
ffffffffc0200886:	1ce50513          	addi	a0,a0,462 # ffffffffc0205a50 <commands+0x138>
           fdt32_to_cpu(x >> 32);
ffffffffc020088a:	4207d613          	srai	a2,a5,0x20
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020088e:	0087d31b          	srliw	t1,a5,0x8
           fdt32_to_cpu(x >> 32);
ffffffffc0200892:	42075593          	srai	a1,a4,0x20
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200896:	0187de1b          	srliw	t3,a5,0x18
ffffffffc020089a:	0186581b          	srliw	a6,a2,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020089e:	0187941b          	slliw	s0,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008a2:	0107d89b          	srliw	a7,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008a6:	0187d693          	srli	a3,a5,0x18
ffffffffc02008aa:	01861f1b          	slliw	t5,a2,0x18
ffffffffc02008ae:	0087579b          	srliw	a5,a4,0x8
ffffffffc02008b2:	0103131b          	slliw	t1,t1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008b6:	0106561b          	srliw	a2,a2,0x10
ffffffffc02008ba:	010f6f33          	or	t5,t5,a6
ffffffffc02008be:	0187529b          	srliw	t0,a4,0x18
ffffffffc02008c2:	0185df9b          	srliw	t6,a1,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008c6:	01837333          	and	t1,t1,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008ca:	01c46433          	or	s0,s0,t3
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008ce:	0186f6b3          	and	a3,a3,s8
ffffffffc02008d2:	01859e1b          	slliw	t3,a1,0x18
ffffffffc02008d6:	01871e9b          	slliw	t4,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008da:	0107581b          	srliw	a6,a4,0x10
ffffffffc02008de:	0086161b          	slliw	a2,a2,0x8
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008e2:	8361                	srli	a4,a4,0x18
ffffffffc02008e4:	0107979b          	slliw	a5,a5,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008e8:	0105d59b          	srliw	a1,a1,0x10
ffffffffc02008ec:	01e6e6b3          	or	a3,a3,t5
ffffffffc02008f0:	00cb7633          	and	a2,s6,a2
ffffffffc02008f4:	0088181b          	slliw	a6,a6,0x8
ffffffffc02008f8:	0085959b          	slliw	a1,a1,0x8
ffffffffc02008fc:	00646433          	or	s0,s0,t1
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200900:	0187f7b3          	and	a5,a5,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200904:	01fe6333          	or	t1,t3,t6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200908:	01877c33          	and	s8,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020090c:	0088989b          	slliw	a7,a7,0x8
ffffffffc0200910:	011b78b3          	and	a7,s6,a7
ffffffffc0200914:	005eeeb3          	or	t4,t4,t0
ffffffffc0200918:	00c6e733          	or	a4,a3,a2
ffffffffc020091c:	006c6c33          	or	s8,s8,t1
ffffffffc0200920:	010b76b3          	and	a3,s6,a6
ffffffffc0200924:	00bb7b33          	and	s6,s6,a1
ffffffffc0200928:	01d7e7b3          	or	a5,a5,t4
ffffffffc020092c:	016c6b33          	or	s6,s8,s6
ffffffffc0200930:	01146433          	or	s0,s0,a7
ffffffffc0200934:	8fd5                	or	a5,a5,a3
           fdt32_to_cpu(x >> 32);
ffffffffc0200936:	1702                	slli	a4,a4,0x20
ffffffffc0200938:	1b02                	slli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc020093a:	1782                	slli	a5,a5,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc020093c:	9301                	srli	a4,a4,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc020093e:	1402                	slli	s0,s0,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc0200940:	020b5b13          	srli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200944:	0167eb33          	or	s6,a5,s6
ffffffffc0200948:	8c59                	or	s0,s0,a4
        cprintf("Physical Memory from DTB:\n");
ffffffffc020094a:	84bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        cprintf("  Base: 0x%016lx\n", mem_base);
ffffffffc020094e:	85a2                	mv	a1,s0
ffffffffc0200950:	00005517          	auipc	a0,0x5
ffffffffc0200954:	12050513          	addi	a0,a0,288 # ffffffffc0205a70 <commands+0x158>
ffffffffc0200958:	83dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc020095c:	014b5613          	srli	a2,s6,0x14
ffffffffc0200960:	85da                	mv	a1,s6
ffffffffc0200962:	00005517          	auipc	a0,0x5
ffffffffc0200966:	12650513          	addi	a0,a0,294 # ffffffffc0205a88 <commands+0x170>
ffffffffc020096a:	82bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc020096e:	008b05b3          	add	a1,s6,s0
ffffffffc0200972:	15fd                	addi	a1,a1,-1
ffffffffc0200974:	00005517          	auipc	a0,0x5
ffffffffc0200978:	13450513          	addi	a0,a0,308 # ffffffffc0205aa8 <commands+0x190>
ffffffffc020097c:	819ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("DTB init completed\n");
ffffffffc0200980:	00005517          	auipc	a0,0x5
ffffffffc0200984:	17850513          	addi	a0,a0,376 # ffffffffc0205af8 <commands+0x1e0>
        memory_base = mem_base;
ffffffffc0200988:	000aa797          	auipc	a5,0xaa
ffffffffc020098c:	ca87b023          	sd	s0,-864(a5) # ffffffffc02aa628 <memory_base>
        memory_size = mem_size;
ffffffffc0200990:	000aa797          	auipc	a5,0xaa
ffffffffc0200994:	cb67b023          	sd	s6,-864(a5) # ffffffffc02aa630 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc0200998:	b3f5                	j	ffffffffc0200784 <dtb_init+0x186>

ffffffffc020099a <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc020099a:	000aa517          	auipc	a0,0xaa
ffffffffc020099e:	c8e53503          	ld	a0,-882(a0) # ffffffffc02aa628 <memory_base>
ffffffffc02009a2:	8082                	ret

ffffffffc02009a4 <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
}
ffffffffc02009a4:	000aa517          	auipc	a0,0xaa
ffffffffc02009a8:	c8c53503          	ld	a0,-884(a0) # ffffffffc02aa630 <memory_size>
ffffffffc02009ac:	8082                	ret

ffffffffc02009ae <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc02009ae:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc02009b2:	8082                	ret

ffffffffc02009b4 <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc02009b4:	100177f3          	csrrci	a5,sstatus,2
ffffffffc02009b8:	8082                	ret

ffffffffc02009ba <pic_init>:
#include <picirq.h>

void pic_enable(unsigned int irq) {}

/* pic_init - initialize the 8259A interrupt controllers */
void pic_init(void) {}
ffffffffc02009ba:	8082                	ret

ffffffffc02009bc <idt_init>:
void idt_init(void)
{
    extern void __alltraps(void);
    /* Set sscratch register to 0, indicating to exception vector that we are
     * presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc02009bc:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc02009c0:	00000797          	auipc	a5,0x0
ffffffffc02009c4:	4a078793          	addi	a5,a5,1184 # ffffffffc0200e60 <__alltraps>
ffffffffc02009c8:	10579073          	csrw	stvec,a5
    /* Allow kernel to access user memory */
    set_csr(sstatus, SSTATUS_SUM);
ffffffffc02009cc:	000407b7          	lui	a5,0x40
ffffffffc02009d0:	1007a7f3          	csrrs	a5,sstatus,a5
}
ffffffffc02009d4:	8082                	ret

ffffffffc02009d6 <print_regs>:
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs *gpr)
{
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009d6:	610c                	ld	a1,0(a0)
{
ffffffffc02009d8:	1141                	addi	sp,sp,-16
ffffffffc02009da:	e022                	sd	s0,0(sp)
ffffffffc02009dc:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009de:	00005517          	auipc	a0,0x5
ffffffffc02009e2:	13250513          	addi	a0,a0,306 # ffffffffc0205b10 <commands+0x1f8>
{
ffffffffc02009e6:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009e8:	facff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc02009ec:	640c                	ld	a1,8(s0)
ffffffffc02009ee:	00005517          	auipc	a0,0x5
ffffffffc02009f2:	13a50513          	addi	a0,a0,314 # ffffffffc0205b28 <commands+0x210>
ffffffffc02009f6:	f9eff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc02009fa:	680c                	ld	a1,16(s0)
ffffffffc02009fc:	00005517          	auipc	a0,0x5
ffffffffc0200a00:	14450513          	addi	a0,a0,324 # ffffffffc0205b40 <commands+0x228>
ffffffffc0200a04:	f90ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc0200a08:	6c0c                	ld	a1,24(s0)
ffffffffc0200a0a:	00005517          	auipc	a0,0x5
ffffffffc0200a0e:	14e50513          	addi	a0,a0,334 # ffffffffc0205b58 <commands+0x240>
ffffffffc0200a12:	f82ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc0200a16:	700c                	ld	a1,32(s0)
ffffffffc0200a18:	00005517          	auipc	a0,0x5
ffffffffc0200a1c:	15850513          	addi	a0,a0,344 # ffffffffc0205b70 <commands+0x258>
ffffffffc0200a20:	f74ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc0200a24:	740c                	ld	a1,40(s0)
ffffffffc0200a26:	00005517          	auipc	a0,0x5
ffffffffc0200a2a:	16250513          	addi	a0,a0,354 # ffffffffc0205b88 <commands+0x270>
ffffffffc0200a2e:	f66ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc0200a32:	780c                	ld	a1,48(s0)
ffffffffc0200a34:	00005517          	auipc	a0,0x5
ffffffffc0200a38:	16c50513          	addi	a0,a0,364 # ffffffffc0205ba0 <commands+0x288>
ffffffffc0200a3c:	f58ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc0200a40:	7c0c                	ld	a1,56(s0)
ffffffffc0200a42:	00005517          	auipc	a0,0x5
ffffffffc0200a46:	17650513          	addi	a0,a0,374 # ffffffffc0205bb8 <commands+0x2a0>
ffffffffc0200a4a:	f4aff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc0200a4e:	602c                	ld	a1,64(s0)
ffffffffc0200a50:	00005517          	auipc	a0,0x5
ffffffffc0200a54:	18050513          	addi	a0,a0,384 # ffffffffc0205bd0 <commands+0x2b8>
ffffffffc0200a58:	f3cff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc0200a5c:	642c                	ld	a1,72(s0)
ffffffffc0200a5e:	00005517          	auipc	a0,0x5
ffffffffc0200a62:	18a50513          	addi	a0,a0,394 # ffffffffc0205be8 <commands+0x2d0>
ffffffffc0200a66:	f2eff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc0200a6a:	682c                	ld	a1,80(s0)
ffffffffc0200a6c:	00005517          	auipc	a0,0x5
ffffffffc0200a70:	19450513          	addi	a0,a0,404 # ffffffffc0205c00 <commands+0x2e8>
ffffffffc0200a74:	f20ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc0200a78:	6c2c                	ld	a1,88(s0)
ffffffffc0200a7a:	00005517          	auipc	a0,0x5
ffffffffc0200a7e:	19e50513          	addi	a0,a0,414 # ffffffffc0205c18 <commands+0x300>
ffffffffc0200a82:	f12ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc0200a86:	702c                	ld	a1,96(s0)
ffffffffc0200a88:	00005517          	auipc	a0,0x5
ffffffffc0200a8c:	1a850513          	addi	a0,a0,424 # ffffffffc0205c30 <commands+0x318>
ffffffffc0200a90:	f04ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc0200a94:	742c                	ld	a1,104(s0)
ffffffffc0200a96:	00005517          	auipc	a0,0x5
ffffffffc0200a9a:	1b250513          	addi	a0,a0,434 # ffffffffc0205c48 <commands+0x330>
ffffffffc0200a9e:	ef6ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc0200aa2:	782c                	ld	a1,112(s0)
ffffffffc0200aa4:	00005517          	auipc	a0,0x5
ffffffffc0200aa8:	1bc50513          	addi	a0,a0,444 # ffffffffc0205c60 <commands+0x348>
ffffffffc0200aac:	ee8ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc0200ab0:	7c2c                	ld	a1,120(s0)
ffffffffc0200ab2:	00005517          	auipc	a0,0x5
ffffffffc0200ab6:	1c650513          	addi	a0,a0,454 # ffffffffc0205c78 <commands+0x360>
ffffffffc0200aba:	edaff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc0200abe:	604c                	ld	a1,128(s0)
ffffffffc0200ac0:	00005517          	auipc	a0,0x5
ffffffffc0200ac4:	1d050513          	addi	a0,a0,464 # ffffffffc0205c90 <commands+0x378>
ffffffffc0200ac8:	eccff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc0200acc:	644c                	ld	a1,136(s0)
ffffffffc0200ace:	00005517          	auipc	a0,0x5
ffffffffc0200ad2:	1da50513          	addi	a0,a0,474 # ffffffffc0205ca8 <commands+0x390>
ffffffffc0200ad6:	ebeff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc0200ada:	684c                	ld	a1,144(s0)
ffffffffc0200adc:	00005517          	auipc	a0,0x5
ffffffffc0200ae0:	1e450513          	addi	a0,a0,484 # ffffffffc0205cc0 <commands+0x3a8>
ffffffffc0200ae4:	eb0ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc0200ae8:	6c4c                	ld	a1,152(s0)
ffffffffc0200aea:	00005517          	auipc	a0,0x5
ffffffffc0200aee:	1ee50513          	addi	a0,a0,494 # ffffffffc0205cd8 <commands+0x3c0>
ffffffffc0200af2:	ea2ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc0200af6:	704c                	ld	a1,160(s0)
ffffffffc0200af8:	00005517          	auipc	a0,0x5
ffffffffc0200afc:	1f850513          	addi	a0,a0,504 # ffffffffc0205cf0 <commands+0x3d8>
ffffffffc0200b00:	e94ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc0200b04:	744c                	ld	a1,168(s0)
ffffffffc0200b06:	00005517          	auipc	a0,0x5
ffffffffc0200b0a:	20250513          	addi	a0,a0,514 # ffffffffc0205d08 <commands+0x3f0>
ffffffffc0200b0e:	e86ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc0200b12:	784c                	ld	a1,176(s0)
ffffffffc0200b14:	00005517          	auipc	a0,0x5
ffffffffc0200b18:	20c50513          	addi	a0,a0,524 # ffffffffc0205d20 <commands+0x408>
ffffffffc0200b1c:	e78ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc0200b20:	7c4c                	ld	a1,184(s0)
ffffffffc0200b22:	00005517          	auipc	a0,0x5
ffffffffc0200b26:	21650513          	addi	a0,a0,534 # ffffffffc0205d38 <commands+0x420>
ffffffffc0200b2a:	e6aff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc0200b2e:	606c                	ld	a1,192(s0)
ffffffffc0200b30:	00005517          	auipc	a0,0x5
ffffffffc0200b34:	22050513          	addi	a0,a0,544 # ffffffffc0205d50 <commands+0x438>
ffffffffc0200b38:	e5cff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc0200b3c:	646c                	ld	a1,200(s0)
ffffffffc0200b3e:	00005517          	auipc	a0,0x5
ffffffffc0200b42:	22a50513          	addi	a0,a0,554 # ffffffffc0205d68 <commands+0x450>
ffffffffc0200b46:	e4eff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc0200b4a:	686c                	ld	a1,208(s0)
ffffffffc0200b4c:	00005517          	auipc	a0,0x5
ffffffffc0200b50:	23450513          	addi	a0,a0,564 # ffffffffc0205d80 <commands+0x468>
ffffffffc0200b54:	e40ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc0200b58:	6c6c                	ld	a1,216(s0)
ffffffffc0200b5a:	00005517          	auipc	a0,0x5
ffffffffc0200b5e:	23e50513          	addi	a0,a0,574 # ffffffffc0205d98 <commands+0x480>
ffffffffc0200b62:	e32ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc0200b66:	706c                	ld	a1,224(s0)
ffffffffc0200b68:	00005517          	auipc	a0,0x5
ffffffffc0200b6c:	24850513          	addi	a0,a0,584 # ffffffffc0205db0 <commands+0x498>
ffffffffc0200b70:	e24ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc0200b74:	746c                	ld	a1,232(s0)
ffffffffc0200b76:	00005517          	auipc	a0,0x5
ffffffffc0200b7a:	25250513          	addi	a0,a0,594 # ffffffffc0205dc8 <commands+0x4b0>
ffffffffc0200b7e:	e16ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc0200b82:	786c                	ld	a1,240(s0)
ffffffffc0200b84:	00005517          	auipc	a0,0x5
ffffffffc0200b88:	25c50513          	addi	a0,a0,604 # ffffffffc0205de0 <commands+0x4c8>
ffffffffc0200b8c:	e08ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b90:	7c6c                	ld	a1,248(s0)
}
ffffffffc0200b92:	6402                	ld	s0,0(sp)
ffffffffc0200b94:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b96:	00005517          	auipc	a0,0x5
ffffffffc0200b9a:	26250513          	addi	a0,a0,610 # ffffffffc0205df8 <commands+0x4e0>
}
ffffffffc0200b9e:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200ba0:	df4ff06f          	j	ffffffffc0200194 <cprintf>

ffffffffc0200ba4 <print_trapframe>:
{
ffffffffc0200ba4:	1141                	addi	sp,sp,-16
ffffffffc0200ba6:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200ba8:	85aa                	mv	a1,a0
{
ffffffffc0200baa:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc0200bac:	00005517          	auipc	a0,0x5
ffffffffc0200bb0:	26450513          	addi	a0,a0,612 # ffffffffc0205e10 <commands+0x4f8>
{
ffffffffc0200bb4:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200bb6:	ddeff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200bba:	8522                	mv	a0,s0
ffffffffc0200bbc:	e1bff0ef          	jal	ra,ffffffffc02009d6 <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc0200bc0:	10043583          	ld	a1,256(s0)
ffffffffc0200bc4:	00005517          	auipc	a0,0x5
ffffffffc0200bc8:	26450513          	addi	a0,a0,612 # ffffffffc0205e28 <commands+0x510>
ffffffffc0200bcc:	dc8ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc0200bd0:	10843583          	ld	a1,264(s0)
ffffffffc0200bd4:	00005517          	auipc	a0,0x5
ffffffffc0200bd8:	26c50513          	addi	a0,a0,620 # ffffffffc0205e40 <commands+0x528>
ffffffffc0200bdc:	db8ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  tval 0x%08x\n", tf->tval);
ffffffffc0200be0:	11043583          	ld	a1,272(s0)
ffffffffc0200be4:	00005517          	auipc	a0,0x5
ffffffffc0200be8:	27450513          	addi	a0,a0,628 # ffffffffc0205e58 <commands+0x540>
ffffffffc0200bec:	da8ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bf0:	11843583          	ld	a1,280(s0)
}
ffffffffc0200bf4:	6402                	ld	s0,0(sp)
ffffffffc0200bf6:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bf8:	00005517          	auipc	a0,0x5
ffffffffc0200bfc:	27050513          	addi	a0,a0,624 # ffffffffc0205e68 <commands+0x550>
}
ffffffffc0200c00:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200c02:	d92ff06f          	j	ffffffffc0200194 <cprintf>

ffffffffc0200c06 <interrupt_handler>:

extern struct mm_struct *check_mm_struct;

void interrupt_handler(struct trapframe *tf)
{
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc0200c06:	11853783          	ld	a5,280(a0)
ffffffffc0200c0a:	472d                	li	a4,11
ffffffffc0200c0c:	0786                	slli	a5,a5,0x1
ffffffffc0200c0e:	8385                	srli	a5,a5,0x1
ffffffffc0200c10:	08f76a63          	bltu	a4,a5,ffffffffc0200ca4 <interrupt_handler+0x9e>
ffffffffc0200c14:	00005717          	auipc	a4,0x5
ffffffffc0200c18:	31c70713          	addi	a4,a4,796 # ffffffffc0205f30 <commands+0x618>
ffffffffc0200c1c:	078a                	slli	a5,a5,0x2
ffffffffc0200c1e:	97ba                	add	a5,a5,a4
ffffffffc0200c20:	439c                	lw	a5,0(a5)
ffffffffc0200c22:	97ba                	add	a5,a5,a4
ffffffffc0200c24:	8782                	jr	a5
        break;
    case IRQ_H_SOFT:
        cprintf("Hypervisor software interrupt\n");
        break;
    case IRQ_M_SOFT:
        cprintf("Machine software interrupt\n");
ffffffffc0200c26:	00005517          	auipc	a0,0x5
ffffffffc0200c2a:	2ba50513          	addi	a0,a0,698 # ffffffffc0205ee0 <commands+0x5c8>
ffffffffc0200c2e:	d66ff06f          	j	ffffffffc0200194 <cprintf>
        cprintf("Hypervisor software interrupt\n");
ffffffffc0200c32:	00005517          	auipc	a0,0x5
ffffffffc0200c36:	28e50513          	addi	a0,a0,654 # ffffffffc0205ec0 <commands+0x5a8>
ffffffffc0200c3a:	d5aff06f          	j	ffffffffc0200194 <cprintf>
        cprintf("User software interrupt\n");
ffffffffc0200c3e:	00005517          	auipc	a0,0x5
ffffffffc0200c42:	24250513          	addi	a0,a0,578 # ffffffffc0205e80 <commands+0x568>
ffffffffc0200c46:	d4eff06f          	j	ffffffffc0200194 <cprintf>
        cprintf("Supervisor software interrupt\n");
ffffffffc0200c4a:	00005517          	auipc	a0,0x5
ffffffffc0200c4e:	25650513          	addi	a0,a0,598 # ffffffffc0205ea0 <commands+0x588>
ffffffffc0200c52:	d42ff06f          	j	ffffffffc0200194 <cprintf>
{
ffffffffc0200c56:	1141                	addi	sp,sp,-16
ffffffffc0200c58:	e406                	sd	ra,8(sp)
        *(2) ticks 计数器自增
        *(3) 每 TICK_NUM 次中断（如 100 次），进行判断当前是否有进程正在运行，如果有则标记该进程需要被重新调度（current->need_resched）
        */

        //设置下一次时钟事件
        clock_set_next_event();
ffffffffc0200c5a:	919ff0ef          	jal	ra,ffffffffc0200572 <clock_set_next_event>
        //ticks 自增
        ticks++;
ffffffffc0200c5e:	000aa797          	auipc	a5,0xaa
ffffffffc0200c62:	9ba78793          	addi	a5,a5,-1606 # ffffffffc02aa618 <ticks>
ffffffffc0200c66:	6398                	ld	a4,0(a5)
ffffffffc0200c68:	0705                	addi	a4,a4,1
ffffffffc0200c6a:	e398                	sd	a4,0(a5)
        //每 TICK_NUM 次执行一次 print_ticks()
        if (ticks % TICK_NUM == 0)
ffffffffc0200c6c:	639c                	ld	a5,0(a5)
ffffffffc0200c6e:	06400713          	li	a4,100
ffffffffc0200c72:	02e7f7b3          	remu	a5,a5,a4
ffffffffc0200c76:	cb85                	beqz	a5,ffffffffc0200ca6 <interrupt_handler+0xa0>
        {
            print_ticks();
        }
        //若当前进程不是 idleproc，标记重新调度
        if (current != NULL && current != idleproc)
ffffffffc0200c78:	000aa797          	auipc	a5,0xaa
ffffffffc0200c7c:	9f87b783          	ld	a5,-1544(a5) # ffffffffc02aa670 <current>
ffffffffc0200c80:	cb89                	beqz	a5,ffffffffc0200c92 <interrupt_handler+0x8c>
ffffffffc0200c82:	000aa717          	auipc	a4,0xaa
ffffffffc0200c86:	9f673703          	ld	a4,-1546(a4) # ffffffffc02aa678 <idleproc>
ffffffffc0200c8a:	00e78463          	beq	a5,a4,ffffffffc0200c92 <interrupt_handler+0x8c>
        {
            current->need_resched = 1;
ffffffffc0200c8e:	4705                	li	a4,1
ffffffffc0200c90:	ef98                	sd	a4,24(a5)
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200c92:	60a2                	ld	ra,8(sp)
ffffffffc0200c94:	0141                	addi	sp,sp,16
ffffffffc0200c96:	8082                	ret
        cprintf("Supervisor external interrupt\n");
ffffffffc0200c98:	00005517          	auipc	a0,0x5
ffffffffc0200c9c:	27850513          	addi	a0,a0,632 # ffffffffc0205f10 <commands+0x5f8>
ffffffffc0200ca0:	cf4ff06f          	j	ffffffffc0200194 <cprintf>
        print_trapframe(tf);
ffffffffc0200ca4:	b701                	j	ffffffffc0200ba4 <print_trapframe>
    cprintf("%d ticks\n", TICK_NUM);
ffffffffc0200ca6:	06400593          	li	a1,100
ffffffffc0200caa:	00005517          	auipc	a0,0x5
ffffffffc0200cae:	25650513          	addi	a0,a0,598 # ffffffffc0205f00 <commands+0x5e8>
ffffffffc0200cb2:	ce2ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
}
ffffffffc0200cb6:	b7c9                	j	ffffffffc0200c78 <interrupt_handler+0x72>

ffffffffc0200cb8 <exception_handler>:
void kernel_execve_ret(struct trapframe *tf, uintptr_t kstacktop);
void exception_handler(struct trapframe *tf)
{
    int ret;
    switch (tf->cause)
ffffffffc0200cb8:	11853783          	ld	a5,280(a0)
{
ffffffffc0200cbc:	1141                	addi	sp,sp,-16
ffffffffc0200cbe:	e022                	sd	s0,0(sp)
ffffffffc0200cc0:	e406                	sd	ra,8(sp)
ffffffffc0200cc2:	473d                	li	a4,15
ffffffffc0200cc4:	842a                	mv	s0,a0
ffffffffc0200cc6:	0cf76463          	bltu	a4,a5,ffffffffc0200d8e <exception_handler+0xd6>
ffffffffc0200cca:	00005717          	auipc	a4,0x5
ffffffffc0200cce:	42670713          	addi	a4,a4,1062 # ffffffffc02060f0 <commands+0x7d8>
ffffffffc0200cd2:	078a                	slli	a5,a5,0x2
ffffffffc0200cd4:	97ba                	add	a5,a5,a4
ffffffffc0200cd6:	439c                	lw	a5,0(a5)
ffffffffc0200cd8:	97ba                	add	a5,a5,a4
ffffffffc0200cda:	8782                	jr	a5
        // cprintf("Environment call from U-mode\n");
        tf->epc += 4;
        syscall();
        break;
    case CAUSE_SUPERVISOR_ECALL:
        cprintf("Environment call from S-mode\n");
ffffffffc0200cdc:	00005517          	auipc	a0,0x5
ffffffffc0200ce0:	36c50513          	addi	a0,a0,876 # ffffffffc0206048 <commands+0x730>
ffffffffc0200ce4:	cb0ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        tf->epc += 4;
ffffffffc0200ce8:	10843783          	ld	a5,264(s0)
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200cec:	60a2                	ld	ra,8(sp)
        tf->epc += 4;
ffffffffc0200cee:	0791                	addi	a5,a5,4
ffffffffc0200cf0:	10f43423          	sd	a5,264(s0)
}
ffffffffc0200cf4:	6402                	ld	s0,0(sp)
ffffffffc0200cf6:	0141                	addi	sp,sp,16
        syscall();
ffffffffc0200cf8:	4660406f          	j	ffffffffc020515e <syscall>
        cprintf("Environment call from H-mode\n");
ffffffffc0200cfc:	00005517          	auipc	a0,0x5
ffffffffc0200d00:	36c50513          	addi	a0,a0,876 # ffffffffc0206068 <commands+0x750>
}
ffffffffc0200d04:	6402                	ld	s0,0(sp)
ffffffffc0200d06:	60a2                	ld	ra,8(sp)
ffffffffc0200d08:	0141                	addi	sp,sp,16
        cprintf("Instruction access fault\n");
ffffffffc0200d0a:	c8aff06f          	j	ffffffffc0200194 <cprintf>
        cprintf("Environment call from M-mode\n");
ffffffffc0200d0e:	00005517          	auipc	a0,0x5
ffffffffc0200d12:	37a50513          	addi	a0,a0,890 # ffffffffc0206088 <commands+0x770>
ffffffffc0200d16:	b7fd                	j	ffffffffc0200d04 <exception_handler+0x4c>
        cprintf("Instruction page fault\n");
ffffffffc0200d18:	00005517          	auipc	a0,0x5
ffffffffc0200d1c:	39050513          	addi	a0,a0,912 # ffffffffc02060a8 <commands+0x790>
ffffffffc0200d20:	b7d5                	j	ffffffffc0200d04 <exception_handler+0x4c>
        cprintf("Load page fault\n");
ffffffffc0200d22:	00005517          	auipc	a0,0x5
ffffffffc0200d26:	39e50513          	addi	a0,a0,926 # ffffffffc02060c0 <commands+0x7a8>
ffffffffc0200d2a:	bfe9                	j	ffffffffc0200d04 <exception_handler+0x4c>
        cprintf("Store/AMO page fault\n");
ffffffffc0200d2c:	00005517          	auipc	a0,0x5
ffffffffc0200d30:	3ac50513          	addi	a0,a0,940 # ffffffffc02060d8 <commands+0x7c0>
ffffffffc0200d34:	bfc1                	j	ffffffffc0200d04 <exception_handler+0x4c>
        cprintf("Instruction address misaligned\n");
ffffffffc0200d36:	00005517          	auipc	a0,0x5
ffffffffc0200d3a:	22a50513          	addi	a0,a0,554 # ffffffffc0205f60 <commands+0x648>
ffffffffc0200d3e:	b7d9                	j	ffffffffc0200d04 <exception_handler+0x4c>
        cprintf("Instruction access fault\n");
ffffffffc0200d40:	00005517          	auipc	a0,0x5
ffffffffc0200d44:	24050513          	addi	a0,a0,576 # ffffffffc0205f80 <commands+0x668>
ffffffffc0200d48:	bf75                	j	ffffffffc0200d04 <exception_handler+0x4c>
        cprintf("Illegal instruction\n");
ffffffffc0200d4a:	00005517          	auipc	a0,0x5
ffffffffc0200d4e:	25650513          	addi	a0,a0,598 # ffffffffc0205fa0 <commands+0x688>
ffffffffc0200d52:	bf4d                	j	ffffffffc0200d04 <exception_handler+0x4c>
        cprintf("Breakpoint\n");
ffffffffc0200d54:	00005517          	auipc	a0,0x5
ffffffffc0200d58:	26450513          	addi	a0,a0,612 # ffffffffc0205fb8 <commands+0x6a0>
ffffffffc0200d5c:	c38ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        if (tf->gpr.a7 == 10)
ffffffffc0200d60:	6458                	ld	a4,136(s0)
ffffffffc0200d62:	47a9                	li	a5,10
ffffffffc0200d64:	04f70663          	beq	a4,a5,ffffffffc0200db0 <exception_handler+0xf8>
}
ffffffffc0200d68:	60a2                	ld	ra,8(sp)
ffffffffc0200d6a:	6402                	ld	s0,0(sp)
ffffffffc0200d6c:	0141                	addi	sp,sp,16
ffffffffc0200d6e:	8082                	ret
        cprintf("Load address misaligned\n");
ffffffffc0200d70:	00005517          	auipc	a0,0x5
ffffffffc0200d74:	25850513          	addi	a0,a0,600 # ffffffffc0205fc8 <commands+0x6b0>
ffffffffc0200d78:	b771                	j	ffffffffc0200d04 <exception_handler+0x4c>
        cprintf("Load access fault\n");
ffffffffc0200d7a:	00005517          	auipc	a0,0x5
ffffffffc0200d7e:	26e50513          	addi	a0,a0,622 # ffffffffc0205fe8 <commands+0x6d0>
ffffffffc0200d82:	b749                	j	ffffffffc0200d04 <exception_handler+0x4c>
        cprintf("Store/AMO access fault\n");
ffffffffc0200d84:	00005517          	auipc	a0,0x5
ffffffffc0200d88:	2ac50513          	addi	a0,a0,684 # ffffffffc0206030 <commands+0x718>
ffffffffc0200d8c:	bfa5                	j	ffffffffc0200d04 <exception_handler+0x4c>
        print_trapframe(tf);
ffffffffc0200d8e:	8522                	mv	a0,s0
}
ffffffffc0200d90:	6402                	ld	s0,0(sp)
ffffffffc0200d92:	60a2                	ld	ra,8(sp)
ffffffffc0200d94:	0141                	addi	sp,sp,16
        print_trapframe(tf);
ffffffffc0200d96:	b539                	j	ffffffffc0200ba4 <print_trapframe>
        panic("AMO address misaligned\n");
ffffffffc0200d98:	00005617          	auipc	a2,0x5
ffffffffc0200d9c:	26860613          	addi	a2,a2,616 # ffffffffc0206000 <commands+0x6e8>
ffffffffc0200da0:	0c800593          	li	a1,200
ffffffffc0200da4:	00005517          	auipc	a0,0x5
ffffffffc0200da8:	27450513          	addi	a0,a0,628 # ffffffffc0206018 <commands+0x700>
ffffffffc0200dac:	ee2ff0ef          	jal	ra,ffffffffc020048e <__panic>
            tf->epc += 4;
ffffffffc0200db0:	10843783          	ld	a5,264(s0)
ffffffffc0200db4:	0791                	addi	a5,a5,4
ffffffffc0200db6:	10f43423          	sd	a5,264(s0)
            syscall();
ffffffffc0200dba:	3a4040ef          	jal	ra,ffffffffc020515e <syscall>
            kernel_execve_ret(tf, current->kstack + KSTACKSIZE);
ffffffffc0200dbe:	000aa797          	auipc	a5,0xaa
ffffffffc0200dc2:	8b27b783          	ld	a5,-1870(a5) # ffffffffc02aa670 <current>
ffffffffc0200dc6:	6b9c                	ld	a5,16(a5)
ffffffffc0200dc8:	8522                	mv	a0,s0
}
ffffffffc0200dca:	6402                	ld	s0,0(sp)
ffffffffc0200dcc:	60a2                	ld	ra,8(sp)
            kernel_execve_ret(tf, current->kstack + KSTACKSIZE);
ffffffffc0200dce:	6589                	lui	a1,0x2
ffffffffc0200dd0:	95be                	add	a1,a1,a5
}
ffffffffc0200dd2:	0141                	addi	sp,sp,16
            kernel_execve_ret(tf, current->kstack + KSTACKSIZE);
ffffffffc0200dd4:	aaa9                	j	ffffffffc0200f2e <kernel_execve_ret>

ffffffffc0200dd6 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void trap(struct trapframe *tf)
{
ffffffffc0200dd6:	1101                	addi	sp,sp,-32
ffffffffc0200dd8:	e822                	sd	s0,16(sp)
    // dispatch based on what type of trap occurred
    //    cputs("some trap");
    if (current == NULL)
ffffffffc0200dda:	000aa417          	auipc	s0,0xaa
ffffffffc0200dde:	89640413          	addi	s0,s0,-1898 # ffffffffc02aa670 <current>
ffffffffc0200de2:	6018                	ld	a4,0(s0)
{
ffffffffc0200de4:	ec06                	sd	ra,24(sp)
ffffffffc0200de6:	e426                	sd	s1,8(sp)
ffffffffc0200de8:	e04a                	sd	s2,0(sp)
    if ((intptr_t)tf->cause < 0)
ffffffffc0200dea:	11853683          	ld	a3,280(a0)
    if (current == NULL)
ffffffffc0200dee:	cf1d                	beqz	a4,ffffffffc0200e2c <trap+0x56>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200df0:	10053483          	ld	s1,256(a0)
    {
        trap_dispatch(tf);
    }
    else
    {
        struct trapframe *otf = current->tf;
ffffffffc0200df4:	0a073903          	ld	s2,160(a4)
        current->tf = tf;
ffffffffc0200df8:	f348                	sd	a0,160(a4)
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200dfa:	1004f493          	andi	s1,s1,256
    if ((intptr_t)tf->cause < 0)
ffffffffc0200dfe:	0206c463          	bltz	a3,ffffffffc0200e26 <trap+0x50>
        exception_handler(tf);
ffffffffc0200e02:	eb7ff0ef          	jal	ra,ffffffffc0200cb8 <exception_handler>

        bool in_kernel = trap_in_kernel(tf);

        trap_dispatch(tf);

        current->tf = otf;
ffffffffc0200e06:	601c                	ld	a5,0(s0)
ffffffffc0200e08:	0b27b023          	sd	s2,160(a5)
        if (!in_kernel)
ffffffffc0200e0c:	e499                	bnez	s1,ffffffffc0200e1a <trap+0x44>
        {
            if (current->flags & PF_EXITING)
ffffffffc0200e0e:	0b07a703          	lw	a4,176(a5)
ffffffffc0200e12:	8b05                	andi	a4,a4,1
ffffffffc0200e14:	e329                	bnez	a4,ffffffffc0200e56 <trap+0x80>
            {
                do_exit(-E_KILLED);
            }
            if (current->need_resched)
ffffffffc0200e16:	6f9c                	ld	a5,24(a5)
ffffffffc0200e18:	eb85                	bnez	a5,ffffffffc0200e48 <trap+0x72>
            {
                schedule();
            }
        }
    }
}
ffffffffc0200e1a:	60e2                	ld	ra,24(sp)
ffffffffc0200e1c:	6442                	ld	s0,16(sp)
ffffffffc0200e1e:	64a2                	ld	s1,8(sp)
ffffffffc0200e20:	6902                	ld	s2,0(sp)
ffffffffc0200e22:	6105                	addi	sp,sp,32
ffffffffc0200e24:	8082                	ret
        interrupt_handler(tf);
ffffffffc0200e26:	de1ff0ef          	jal	ra,ffffffffc0200c06 <interrupt_handler>
ffffffffc0200e2a:	bff1                	j	ffffffffc0200e06 <trap+0x30>
    if ((intptr_t)tf->cause < 0)
ffffffffc0200e2c:	0006c863          	bltz	a3,ffffffffc0200e3c <trap+0x66>
}
ffffffffc0200e30:	6442                	ld	s0,16(sp)
ffffffffc0200e32:	60e2                	ld	ra,24(sp)
ffffffffc0200e34:	64a2                	ld	s1,8(sp)
ffffffffc0200e36:	6902                	ld	s2,0(sp)
ffffffffc0200e38:	6105                	addi	sp,sp,32
        exception_handler(tf);
ffffffffc0200e3a:	bdbd                	j	ffffffffc0200cb8 <exception_handler>
}
ffffffffc0200e3c:	6442                	ld	s0,16(sp)
ffffffffc0200e3e:	60e2                	ld	ra,24(sp)
ffffffffc0200e40:	64a2                	ld	s1,8(sp)
ffffffffc0200e42:	6902                	ld	s2,0(sp)
ffffffffc0200e44:	6105                	addi	sp,sp,32
        interrupt_handler(tf);
ffffffffc0200e46:	b3c1                	j	ffffffffc0200c06 <interrupt_handler>
}
ffffffffc0200e48:	6442                	ld	s0,16(sp)
ffffffffc0200e4a:	60e2                	ld	ra,24(sp)
ffffffffc0200e4c:	64a2                	ld	s1,8(sp)
ffffffffc0200e4e:	6902                	ld	s2,0(sp)
ffffffffc0200e50:	6105                	addi	sp,sp,32
                schedule();
ffffffffc0200e52:	2200406f          	j	ffffffffc0205072 <schedule>
                do_exit(-E_KILLED);
ffffffffc0200e56:	555d                	li	a0,-9
ffffffffc0200e58:	560030ef          	jal	ra,ffffffffc02043b8 <do_exit>
            if (current->need_resched)
ffffffffc0200e5c:	601c                	ld	a5,0(s0)
ffffffffc0200e5e:	bf65                	j	ffffffffc0200e16 <trap+0x40>

ffffffffc0200e60 <__alltraps>:
    LOAD x2, 2*REGBYTES(sp)
    .endm

    .globl __alltraps
__alltraps:
    SAVE_ALL
ffffffffc0200e60:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0200e64:	00011463          	bnez	sp,ffffffffc0200e6c <__alltraps+0xc>
ffffffffc0200e68:	14002173          	csrr	sp,sscratch
ffffffffc0200e6c:	712d                	addi	sp,sp,-288
ffffffffc0200e6e:	e002                	sd	zero,0(sp)
ffffffffc0200e70:	e406                	sd	ra,8(sp)
ffffffffc0200e72:	ec0e                	sd	gp,24(sp)
ffffffffc0200e74:	f012                	sd	tp,32(sp)
ffffffffc0200e76:	f416                	sd	t0,40(sp)
ffffffffc0200e78:	f81a                	sd	t1,48(sp)
ffffffffc0200e7a:	fc1e                	sd	t2,56(sp)
ffffffffc0200e7c:	e0a2                	sd	s0,64(sp)
ffffffffc0200e7e:	e4a6                	sd	s1,72(sp)
ffffffffc0200e80:	e8aa                	sd	a0,80(sp)
ffffffffc0200e82:	ecae                	sd	a1,88(sp)
ffffffffc0200e84:	f0b2                	sd	a2,96(sp)
ffffffffc0200e86:	f4b6                	sd	a3,104(sp)
ffffffffc0200e88:	f8ba                	sd	a4,112(sp)
ffffffffc0200e8a:	fcbe                	sd	a5,120(sp)
ffffffffc0200e8c:	e142                	sd	a6,128(sp)
ffffffffc0200e8e:	e546                	sd	a7,136(sp)
ffffffffc0200e90:	e94a                	sd	s2,144(sp)
ffffffffc0200e92:	ed4e                	sd	s3,152(sp)
ffffffffc0200e94:	f152                	sd	s4,160(sp)
ffffffffc0200e96:	f556                	sd	s5,168(sp)
ffffffffc0200e98:	f95a                	sd	s6,176(sp)
ffffffffc0200e9a:	fd5e                	sd	s7,184(sp)
ffffffffc0200e9c:	e1e2                	sd	s8,192(sp)
ffffffffc0200e9e:	e5e6                	sd	s9,200(sp)
ffffffffc0200ea0:	e9ea                	sd	s10,208(sp)
ffffffffc0200ea2:	edee                	sd	s11,216(sp)
ffffffffc0200ea4:	f1f2                	sd	t3,224(sp)
ffffffffc0200ea6:	f5f6                	sd	t4,232(sp)
ffffffffc0200ea8:	f9fa                	sd	t5,240(sp)
ffffffffc0200eaa:	fdfe                	sd	t6,248(sp)
ffffffffc0200eac:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200eb0:	100024f3          	csrr	s1,sstatus
ffffffffc0200eb4:	14102973          	csrr	s2,sepc
ffffffffc0200eb8:	143029f3          	csrr	s3,stval
ffffffffc0200ebc:	14202a73          	csrr	s4,scause
ffffffffc0200ec0:	e822                	sd	s0,16(sp)
ffffffffc0200ec2:	e226                	sd	s1,256(sp)
ffffffffc0200ec4:	e64a                	sd	s2,264(sp)
ffffffffc0200ec6:	ea4e                	sd	s3,272(sp)
ffffffffc0200ec8:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200eca:	850a                	mv	a0,sp
    jal trap
ffffffffc0200ecc:	f0bff0ef          	jal	ra,ffffffffc0200dd6 <trap>

ffffffffc0200ed0 <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200ed0:	6492                	ld	s1,256(sp)
ffffffffc0200ed2:	6932                	ld	s2,264(sp)
ffffffffc0200ed4:	1004f413          	andi	s0,s1,256
ffffffffc0200ed8:	e401                	bnez	s0,ffffffffc0200ee0 <__trapret+0x10>
ffffffffc0200eda:	1200                	addi	s0,sp,288
ffffffffc0200edc:	14041073          	csrw	sscratch,s0
ffffffffc0200ee0:	10049073          	csrw	sstatus,s1
ffffffffc0200ee4:	14191073          	csrw	sepc,s2
ffffffffc0200ee8:	60a2                	ld	ra,8(sp)
ffffffffc0200eea:	61e2                	ld	gp,24(sp)
ffffffffc0200eec:	7202                	ld	tp,32(sp)
ffffffffc0200eee:	72a2                	ld	t0,40(sp)
ffffffffc0200ef0:	7342                	ld	t1,48(sp)
ffffffffc0200ef2:	73e2                	ld	t2,56(sp)
ffffffffc0200ef4:	6406                	ld	s0,64(sp)
ffffffffc0200ef6:	64a6                	ld	s1,72(sp)
ffffffffc0200ef8:	6546                	ld	a0,80(sp)
ffffffffc0200efa:	65e6                	ld	a1,88(sp)
ffffffffc0200efc:	7606                	ld	a2,96(sp)
ffffffffc0200efe:	76a6                	ld	a3,104(sp)
ffffffffc0200f00:	7746                	ld	a4,112(sp)
ffffffffc0200f02:	77e6                	ld	a5,120(sp)
ffffffffc0200f04:	680a                	ld	a6,128(sp)
ffffffffc0200f06:	68aa                	ld	a7,136(sp)
ffffffffc0200f08:	694a                	ld	s2,144(sp)
ffffffffc0200f0a:	69ea                	ld	s3,152(sp)
ffffffffc0200f0c:	7a0a                	ld	s4,160(sp)
ffffffffc0200f0e:	7aaa                	ld	s5,168(sp)
ffffffffc0200f10:	7b4a                	ld	s6,176(sp)
ffffffffc0200f12:	7bea                	ld	s7,184(sp)
ffffffffc0200f14:	6c0e                	ld	s8,192(sp)
ffffffffc0200f16:	6cae                	ld	s9,200(sp)
ffffffffc0200f18:	6d4e                	ld	s10,208(sp)
ffffffffc0200f1a:	6dee                	ld	s11,216(sp)
ffffffffc0200f1c:	7e0e                	ld	t3,224(sp)
ffffffffc0200f1e:	7eae                	ld	t4,232(sp)
ffffffffc0200f20:	7f4e                	ld	t5,240(sp)
ffffffffc0200f22:	7fee                	ld	t6,248(sp)
ffffffffc0200f24:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200f26:	10200073          	sret

ffffffffc0200f2a <forkrets>:
 
    .globl forkrets
forkrets:
    # set stack to this new process's trapframe
    move sp, a0
ffffffffc0200f2a:	812a                	mv	sp,a0
    j __trapret
ffffffffc0200f2c:	b755                	j	ffffffffc0200ed0 <__trapret>

ffffffffc0200f2e <kernel_execve_ret>:

    .global kernel_execve_ret
kernel_execve_ret:
    // adjust sp to beneath kstacktop of current process
    addi a1, a1, -36*REGBYTES
ffffffffc0200f2e:	ee058593          	addi	a1,a1,-288 # 1ee0 <_binary_obj___user_faultread_out_size-0x7cc0>

    // copy from previous trapframe to new trapframe
    LOAD s1, 35*REGBYTES(a0)
ffffffffc0200f32:	11853483          	ld	s1,280(a0)
    STORE s1, 35*REGBYTES(a1)
ffffffffc0200f36:	1095bc23          	sd	s1,280(a1)
    LOAD s1, 34*REGBYTES(a0)
ffffffffc0200f3a:	11053483          	ld	s1,272(a0)
    STORE s1, 34*REGBYTES(a1)
ffffffffc0200f3e:	1095b823          	sd	s1,272(a1)
    LOAD s1, 33*REGBYTES(a0)
ffffffffc0200f42:	10853483          	ld	s1,264(a0)
    STORE s1, 33*REGBYTES(a1)
ffffffffc0200f46:	1095b423          	sd	s1,264(a1)
    LOAD s1, 32*REGBYTES(a0)
ffffffffc0200f4a:	10053483          	ld	s1,256(a0)
    STORE s1, 32*REGBYTES(a1)
ffffffffc0200f4e:	1095b023          	sd	s1,256(a1)
    LOAD s1, 31*REGBYTES(a0)
ffffffffc0200f52:	7d64                	ld	s1,248(a0)
    STORE s1, 31*REGBYTES(a1)
ffffffffc0200f54:	fde4                	sd	s1,248(a1)
    LOAD s1, 30*REGBYTES(a0)
ffffffffc0200f56:	7964                	ld	s1,240(a0)
    STORE s1, 30*REGBYTES(a1)
ffffffffc0200f58:	f9e4                	sd	s1,240(a1)
    LOAD s1, 29*REGBYTES(a0)
ffffffffc0200f5a:	7564                	ld	s1,232(a0)
    STORE s1, 29*REGBYTES(a1)
ffffffffc0200f5c:	f5e4                	sd	s1,232(a1)
    LOAD s1, 28*REGBYTES(a0)
ffffffffc0200f5e:	7164                	ld	s1,224(a0)
    STORE s1, 28*REGBYTES(a1)
ffffffffc0200f60:	f1e4                	sd	s1,224(a1)
    LOAD s1, 27*REGBYTES(a0)
ffffffffc0200f62:	6d64                	ld	s1,216(a0)
    STORE s1, 27*REGBYTES(a1)
ffffffffc0200f64:	ede4                	sd	s1,216(a1)
    LOAD s1, 26*REGBYTES(a0)
ffffffffc0200f66:	6964                	ld	s1,208(a0)
    STORE s1, 26*REGBYTES(a1)
ffffffffc0200f68:	e9e4                	sd	s1,208(a1)
    LOAD s1, 25*REGBYTES(a0)
ffffffffc0200f6a:	6564                	ld	s1,200(a0)
    STORE s1, 25*REGBYTES(a1)
ffffffffc0200f6c:	e5e4                	sd	s1,200(a1)
    LOAD s1, 24*REGBYTES(a0)
ffffffffc0200f6e:	6164                	ld	s1,192(a0)
    STORE s1, 24*REGBYTES(a1)
ffffffffc0200f70:	e1e4                	sd	s1,192(a1)
    LOAD s1, 23*REGBYTES(a0)
ffffffffc0200f72:	7d44                	ld	s1,184(a0)
    STORE s1, 23*REGBYTES(a1)
ffffffffc0200f74:	fdc4                	sd	s1,184(a1)
    LOAD s1, 22*REGBYTES(a0)
ffffffffc0200f76:	7944                	ld	s1,176(a0)
    STORE s1, 22*REGBYTES(a1)
ffffffffc0200f78:	f9c4                	sd	s1,176(a1)
    LOAD s1, 21*REGBYTES(a0)
ffffffffc0200f7a:	7544                	ld	s1,168(a0)
    STORE s1, 21*REGBYTES(a1)
ffffffffc0200f7c:	f5c4                	sd	s1,168(a1)
    LOAD s1, 20*REGBYTES(a0)
ffffffffc0200f7e:	7144                	ld	s1,160(a0)
    STORE s1, 20*REGBYTES(a1)
ffffffffc0200f80:	f1c4                	sd	s1,160(a1)
    LOAD s1, 19*REGBYTES(a0)
ffffffffc0200f82:	6d44                	ld	s1,152(a0)
    STORE s1, 19*REGBYTES(a1)
ffffffffc0200f84:	edc4                	sd	s1,152(a1)
    LOAD s1, 18*REGBYTES(a0)
ffffffffc0200f86:	6944                	ld	s1,144(a0)
    STORE s1, 18*REGBYTES(a1)
ffffffffc0200f88:	e9c4                	sd	s1,144(a1)
    LOAD s1, 17*REGBYTES(a0)
ffffffffc0200f8a:	6544                	ld	s1,136(a0)
    STORE s1, 17*REGBYTES(a1)
ffffffffc0200f8c:	e5c4                	sd	s1,136(a1)
    LOAD s1, 16*REGBYTES(a0)
ffffffffc0200f8e:	6144                	ld	s1,128(a0)
    STORE s1, 16*REGBYTES(a1)
ffffffffc0200f90:	e1c4                	sd	s1,128(a1)
    LOAD s1, 15*REGBYTES(a0)
ffffffffc0200f92:	7d24                	ld	s1,120(a0)
    STORE s1, 15*REGBYTES(a1)
ffffffffc0200f94:	fda4                	sd	s1,120(a1)
    LOAD s1, 14*REGBYTES(a0)
ffffffffc0200f96:	7924                	ld	s1,112(a0)
    STORE s1, 14*REGBYTES(a1)
ffffffffc0200f98:	f9a4                	sd	s1,112(a1)
    LOAD s1, 13*REGBYTES(a0)
ffffffffc0200f9a:	7524                	ld	s1,104(a0)
    STORE s1, 13*REGBYTES(a1)
ffffffffc0200f9c:	f5a4                	sd	s1,104(a1)
    LOAD s1, 12*REGBYTES(a0)
ffffffffc0200f9e:	7124                	ld	s1,96(a0)
    STORE s1, 12*REGBYTES(a1)
ffffffffc0200fa0:	f1a4                	sd	s1,96(a1)
    LOAD s1, 11*REGBYTES(a0)
ffffffffc0200fa2:	6d24                	ld	s1,88(a0)
    STORE s1, 11*REGBYTES(a1)
ffffffffc0200fa4:	eda4                	sd	s1,88(a1)
    LOAD s1, 10*REGBYTES(a0)
ffffffffc0200fa6:	6924                	ld	s1,80(a0)
    STORE s1, 10*REGBYTES(a1)
ffffffffc0200fa8:	e9a4                	sd	s1,80(a1)
    LOAD s1, 9*REGBYTES(a0)
ffffffffc0200faa:	6524                	ld	s1,72(a0)
    STORE s1, 9*REGBYTES(a1)
ffffffffc0200fac:	e5a4                	sd	s1,72(a1)
    LOAD s1, 8*REGBYTES(a0)
ffffffffc0200fae:	6124                	ld	s1,64(a0)
    STORE s1, 8*REGBYTES(a1)
ffffffffc0200fb0:	e1a4                	sd	s1,64(a1)
    LOAD s1, 7*REGBYTES(a0)
ffffffffc0200fb2:	7d04                	ld	s1,56(a0)
    STORE s1, 7*REGBYTES(a1)
ffffffffc0200fb4:	fd84                	sd	s1,56(a1)
    LOAD s1, 6*REGBYTES(a0)
ffffffffc0200fb6:	7904                	ld	s1,48(a0)
    STORE s1, 6*REGBYTES(a1)
ffffffffc0200fb8:	f984                	sd	s1,48(a1)
    LOAD s1, 5*REGBYTES(a0)
ffffffffc0200fba:	7504                	ld	s1,40(a0)
    STORE s1, 5*REGBYTES(a1)
ffffffffc0200fbc:	f584                	sd	s1,40(a1)
    LOAD s1, 4*REGBYTES(a0)
ffffffffc0200fbe:	7104                	ld	s1,32(a0)
    STORE s1, 4*REGBYTES(a1)
ffffffffc0200fc0:	f184                	sd	s1,32(a1)
    LOAD s1, 3*REGBYTES(a0)
ffffffffc0200fc2:	6d04                	ld	s1,24(a0)
    STORE s1, 3*REGBYTES(a1)
ffffffffc0200fc4:	ed84                	sd	s1,24(a1)
    LOAD s1, 2*REGBYTES(a0)
ffffffffc0200fc6:	6904                	ld	s1,16(a0)
    STORE s1, 2*REGBYTES(a1)
ffffffffc0200fc8:	e984                	sd	s1,16(a1)
    LOAD s1, 1*REGBYTES(a0)
ffffffffc0200fca:	6504                	ld	s1,8(a0)
    STORE s1, 1*REGBYTES(a1)
ffffffffc0200fcc:	e584                	sd	s1,8(a1)
    LOAD s1, 0*REGBYTES(a0)
ffffffffc0200fce:	6104                	ld	s1,0(a0)
    STORE s1, 0*REGBYTES(a1)
ffffffffc0200fd0:	e184                	sd	s1,0(a1)

    // acutually adjust sp
    move sp, a1
ffffffffc0200fd2:	812e                	mv	sp,a1
ffffffffc0200fd4:	bdf5                	j	ffffffffc0200ed0 <__trapret>

ffffffffc0200fd6 <default_init>:
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc0200fd6:	000a5797          	auipc	a5,0xa5
ffffffffc0200fda:	61278793          	addi	a5,a5,1554 # ffffffffc02a65e8 <free_area>
ffffffffc0200fde:	e79c                	sd	a5,8(a5)
ffffffffc0200fe0:	e39c                	sd	a5,0(a5)

static void
default_init(void)
{
    list_init(&free_list);
    nr_free = 0;
ffffffffc0200fe2:	0007a823          	sw	zero,16(a5)
}
ffffffffc0200fe6:	8082                	ret

ffffffffc0200fe8 <default_nr_free_pages>:

static size_t
default_nr_free_pages(void)
{
    return nr_free;
}
ffffffffc0200fe8:	000a5517          	auipc	a0,0xa5
ffffffffc0200fec:	61056503          	lwu	a0,1552(a0) # ffffffffc02a65f8 <free_area+0x10>
ffffffffc0200ff0:	8082                	ret

ffffffffc0200ff2 <default_check>:

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1)
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void)
{
ffffffffc0200ff2:	715d                	addi	sp,sp,-80
ffffffffc0200ff4:	e0a2                	sd	s0,64(sp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0200ff6:	000a5417          	auipc	s0,0xa5
ffffffffc0200ffa:	5f240413          	addi	s0,s0,1522 # ffffffffc02a65e8 <free_area>
ffffffffc0200ffe:	641c                	ld	a5,8(s0)
ffffffffc0201000:	e486                	sd	ra,72(sp)
ffffffffc0201002:	fc26                	sd	s1,56(sp)
ffffffffc0201004:	f84a                	sd	s2,48(sp)
ffffffffc0201006:	f44e                	sd	s3,40(sp)
ffffffffc0201008:	f052                	sd	s4,32(sp)
ffffffffc020100a:	ec56                	sd	s5,24(sp)
ffffffffc020100c:	e85a                	sd	s6,16(sp)
ffffffffc020100e:	e45e                	sd	s7,8(sp)
ffffffffc0201010:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list)
ffffffffc0201012:	2a878d63          	beq	a5,s0,ffffffffc02012cc <default_check+0x2da>
    int count = 0, total = 0;
ffffffffc0201016:	4481                	li	s1,0
ffffffffc0201018:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc020101a:	ff07b703          	ld	a4,-16(a5)
    {
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc020101e:	8b09                	andi	a4,a4,2
ffffffffc0201020:	2a070a63          	beqz	a4,ffffffffc02012d4 <default_check+0x2e2>
        count++, total += p->property;
ffffffffc0201024:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201028:	679c                	ld	a5,8(a5)
ffffffffc020102a:	2905                	addiw	s2,s2,1
ffffffffc020102c:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list)
ffffffffc020102e:	fe8796e3          	bne	a5,s0,ffffffffc020101a <default_check+0x28>
    }
    assert(total == nr_free_pages());
ffffffffc0201032:	89a6                	mv	s3,s1
ffffffffc0201034:	6df000ef          	jal	ra,ffffffffc0201f12 <nr_free_pages>
ffffffffc0201038:	6f351e63          	bne	a0,s3,ffffffffc0201734 <default_check+0x742>
    assert((p0 = alloc_page()) != NULL);
ffffffffc020103c:	4505                	li	a0,1
ffffffffc020103e:	657000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc0201042:	8aaa                	mv	s5,a0
ffffffffc0201044:	42050863          	beqz	a0,ffffffffc0201474 <default_check+0x482>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201048:	4505                	li	a0,1
ffffffffc020104a:	64b000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc020104e:	89aa                	mv	s3,a0
ffffffffc0201050:	70050263          	beqz	a0,ffffffffc0201754 <default_check+0x762>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201054:	4505                	li	a0,1
ffffffffc0201056:	63f000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc020105a:	8a2a                	mv	s4,a0
ffffffffc020105c:	48050c63          	beqz	a0,ffffffffc02014f4 <default_check+0x502>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0201060:	293a8a63          	beq	s5,s3,ffffffffc02012f4 <default_check+0x302>
ffffffffc0201064:	28aa8863          	beq	s5,a0,ffffffffc02012f4 <default_check+0x302>
ffffffffc0201068:	28a98663          	beq	s3,a0,ffffffffc02012f4 <default_check+0x302>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc020106c:	000aa783          	lw	a5,0(s5)
ffffffffc0201070:	2a079263          	bnez	a5,ffffffffc0201314 <default_check+0x322>
ffffffffc0201074:	0009a783          	lw	a5,0(s3)
ffffffffc0201078:	28079e63          	bnez	a5,ffffffffc0201314 <default_check+0x322>
ffffffffc020107c:	411c                	lw	a5,0(a0)
ffffffffc020107e:	28079b63          	bnez	a5,ffffffffc0201314 <default_check+0x322>
extern uint_t va_pa_offset;

static inline ppn_t
page2ppn(struct Page *page)
{
    return page - pages + nbase;
ffffffffc0201082:	000a9797          	auipc	a5,0xa9
ffffffffc0201086:	5d67b783          	ld	a5,1494(a5) # ffffffffc02aa658 <pages>
ffffffffc020108a:	40fa8733          	sub	a4,s5,a5
ffffffffc020108e:	00006617          	auipc	a2,0x6
ffffffffc0201092:	75a63603          	ld	a2,1882(a2) # ffffffffc02077e8 <nbase>
ffffffffc0201096:	8719                	srai	a4,a4,0x6
ffffffffc0201098:	9732                	add	a4,a4,a2
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc020109a:	000a9697          	auipc	a3,0xa9
ffffffffc020109e:	5b66b683          	ld	a3,1462(a3) # ffffffffc02aa650 <npage>
ffffffffc02010a2:	06b2                	slli	a3,a3,0xc
}

static inline uintptr_t
page2pa(struct Page *page)
{
    return page2ppn(page) << PGSHIFT;
ffffffffc02010a4:	0732                	slli	a4,a4,0xc
ffffffffc02010a6:	28d77763          	bgeu	a4,a3,ffffffffc0201334 <default_check+0x342>
    return page - pages + nbase;
ffffffffc02010aa:	40f98733          	sub	a4,s3,a5
ffffffffc02010ae:	8719                	srai	a4,a4,0x6
ffffffffc02010b0:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc02010b2:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc02010b4:	4cd77063          	bgeu	a4,a3,ffffffffc0201574 <default_check+0x582>
    return page - pages + nbase;
ffffffffc02010b8:	40f507b3          	sub	a5,a0,a5
ffffffffc02010bc:	8799                	srai	a5,a5,0x6
ffffffffc02010be:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc02010c0:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02010c2:	30d7f963          	bgeu	a5,a3,ffffffffc02013d4 <default_check+0x3e2>
    assert(alloc_page() == NULL);
ffffffffc02010c6:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc02010c8:	00043c03          	ld	s8,0(s0)
ffffffffc02010cc:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc02010d0:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc02010d4:	e400                	sd	s0,8(s0)
ffffffffc02010d6:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc02010d8:	000a5797          	auipc	a5,0xa5
ffffffffc02010dc:	5207a023          	sw	zero,1312(a5) # ffffffffc02a65f8 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc02010e0:	5b5000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc02010e4:	2c051863          	bnez	a0,ffffffffc02013b4 <default_check+0x3c2>
    free_page(p0);
ffffffffc02010e8:	4585                	li	a1,1
ffffffffc02010ea:	8556                	mv	a0,s5
ffffffffc02010ec:	5e7000ef          	jal	ra,ffffffffc0201ed2 <free_pages>
    free_page(p1);
ffffffffc02010f0:	4585                	li	a1,1
ffffffffc02010f2:	854e                	mv	a0,s3
ffffffffc02010f4:	5df000ef          	jal	ra,ffffffffc0201ed2 <free_pages>
    free_page(p2);
ffffffffc02010f8:	4585                	li	a1,1
ffffffffc02010fa:	8552                	mv	a0,s4
ffffffffc02010fc:	5d7000ef          	jal	ra,ffffffffc0201ed2 <free_pages>
    assert(nr_free == 3);
ffffffffc0201100:	4818                	lw	a4,16(s0)
ffffffffc0201102:	478d                	li	a5,3
ffffffffc0201104:	28f71863          	bne	a4,a5,ffffffffc0201394 <default_check+0x3a2>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201108:	4505                	li	a0,1
ffffffffc020110a:	58b000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc020110e:	89aa                	mv	s3,a0
ffffffffc0201110:	26050263          	beqz	a0,ffffffffc0201374 <default_check+0x382>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201114:	4505                	li	a0,1
ffffffffc0201116:	57f000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc020111a:	8aaa                	mv	s5,a0
ffffffffc020111c:	3a050c63          	beqz	a0,ffffffffc02014d4 <default_check+0x4e2>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201120:	4505                	li	a0,1
ffffffffc0201122:	573000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc0201126:	8a2a                	mv	s4,a0
ffffffffc0201128:	38050663          	beqz	a0,ffffffffc02014b4 <default_check+0x4c2>
    assert(alloc_page() == NULL);
ffffffffc020112c:	4505                	li	a0,1
ffffffffc020112e:	567000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc0201132:	36051163          	bnez	a0,ffffffffc0201494 <default_check+0x4a2>
    free_page(p0);
ffffffffc0201136:	4585                	li	a1,1
ffffffffc0201138:	854e                	mv	a0,s3
ffffffffc020113a:	599000ef          	jal	ra,ffffffffc0201ed2 <free_pages>
    assert(!list_empty(&free_list));
ffffffffc020113e:	641c                	ld	a5,8(s0)
ffffffffc0201140:	20878a63          	beq	a5,s0,ffffffffc0201354 <default_check+0x362>
    assert((p = alloc_page()) == p0);
ffffffffc0201144:	4505                	li	a0,1
ffffffffc0201146:	54f000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc020114a:	30a99563          	bne	s3,a0,ffffffffc0201454 <default_check+0x462>
    assert(alloc_page() == NULL);
ffffffffc020114e:	4505                	li	a0,1
ffffffffc0201150:	545000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc0201154:	2e051063          	bnez	a0,ffffffffc0201434 <default_check+0x442>
    assert(nr_free == 0);
ffffffffc0201158:	481c                	lw	a5,16(s0)
ffffffffc020115a:	2a079d63          	bnez	a5,ffffffffc0201414 <default_check+0x422>
    free_page(p);
ffffffffc020115e:	854e                	mv	a0,s3
ffffffffc0201160:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc0201162:	01843023          	sd	s8,0(s0)
ffffffffc0201166:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc020116a:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc020116e:	565000ef          	jal	ra,ffffffffc0201ed2 <free_pages>
    free_page(p1);
ffffffffc0201172:	4585                	li	a1,1
ffffffffc0201174:	8556                	mv	a0,s5
ffffffffc0201176:	55d000ef          	jal	ra,ffffffffc0201ed2 <free_pages>
    free_page(p2);
ffffffffc020117a:	4585                	li	a1,1
ffffffffc020117c:	8552                	mv	a0,s4
ffffffffc020117e:	555000ef          	jal	ra,ffffffffc0201ed2 <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc0201182:	4515                	li	a0,5
ffffffffc0201184:	511000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc0201188:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc020118a:	26050563          	beqz	a0,ffffffffc02013f4 <default_check+0x402>
ffffffffc020118e:	651c                	ld	a5,8(a0)
ffffffffc0201190:	8385                	srli	a5,a5,0x1
ffffffffc0201192:	8b85                	andi	a5,a5,1
    assert(!PageProperty(p0));
ffffffffc0201194:	54079063          	bnez	a5,ffffffffc02016d4 <default_check+0x6e2>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc0201198:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc020119a:	00043b03          	ld	s6,0(s0)
ffffffffc020119e:	00843a83          	ld	s5,8(s0)
ffffffffc02011a2:	e000                	sd	s0,0(s0)
ffffffffc02011a4:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc02011a6:	4ef000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc02011aa:	50051563          	bnez	a0,ffffffffc02016b4 <default_check+0x6c2>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc02011ae:	08098a13          	addi	s4,s3,128
ffffffffc02011b2:	8552                	mv	a0,s4
ffffffffc02011b4:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc02011b6:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc02011ba:	000a5797          	auipc	a5,0xa5
ffffffffc02011be:	4207af23          	sw	zero,1086(a5) # ffffffffc02a65f8 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc02011c2:	511000ef          	jal	ra,ffffffffc0201ed2 <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc02011c6:	4511                	li	a0,4
ffffffffc02011c8:	4cd000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc02011cc:	4c051463          	bnez	a0,ffffffffc0201694 <default_check+0x6a2>
ffffffffc02011d0:	0889b783          	ld	a5,136(s3)
ffffffffc02011d4:	8385                	srli	a5,a5,0x1
ffffffffc02011d6:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc02011d8:	48078e63          	beqz	a5,ffffffffc0201674 <default_check+0x682>
ffffffffc02011dc:	0909a703          	lw	a4,144(s3)
ffffffffc02011e0:	478d                	li	a5,3
ffffffffc02011e2:	48f71963          	bne	a4,a5,ffffffffc0201674 <default_check+0x682>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc02011e6:	450d                	li	a0,3
ffffffffc02011e8:	4ad000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc02011ec:	8c2a                	mv	s8,a0
ffffffffc02011ee:	46050363          	beqz	a0,ffffffffc0201654 <default_check+0x662>
    assert(alloc_page() == NULL);
ffffffffc02011f2:	4505                	li	a0,1
ffffffffc02011f4:	4a1000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc02011f8:	42051e63          	bnez	a0,ffffffffc0201634 <default_check+0x642>
    assert(p0 + 2 == p1);
ffffffffc02011fc:	418a1c63          	bne	s4,s8,ffffffffc0201614 <default_check+0x622>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc0201200:	4585                	li	a1,1
ffffffffc0201202:	854e                	mv	a0,s3
ffffffffc0201204:	4cf000ef          	jal	ra,ffffffffc0201ed2 <free_pages>
    free_pages(p1, 3);
ffffffffc0201208:	458d                	li	a1,3
ffffffffc020120a:	8552                	mv	a0,s4
ffffffffc020120c:	4c7000ef          	jal	ra,ffffffffc0201ed2 <free_pages>
ffffffffc0201210:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc0201214:	04098c13          	addi	s8,s3,64
ffffffffc0201218:	8385                	srli	a5,a5,0x1
ffffffffc020121a:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc020121c:	3c078c63          	beqz	a5,ffffffffc02015f4 <default_check+0x602>
ffffffffc0201220:	0109a703          	lw	a4,16(s3)
ffffffffc0201224:	4785                	li	a5,1
ffffffffc0201226:	3cf71763          	bne	a4,a5,ffffffffc02015f4 <default_check+0x602>
ffffffffc020122a:	008a3783          	ld	a5,8(s4)
ffffffffc020122e:	8385                	srli	a5,a5,0x1
ffffffffc0201230:	8b85                	andi	a5,a5,1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0201232:	3a078163          	beqz	a5,ffffffffc02015d4 <default_check+0x5e2>
ffffffffc0201236:	010a2703          	lw	a4,16(s4)
ffffffffc020123a:	478d                	li	a5,3
ffffffffc020123c:	38f71c63          	bne	a4,a5,ffffffffc02015d4 <default_check+0x5e2>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0201240:	4505                	li	a0,1
ffffffffc0201242:	453000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc0201246:	36a99763          	bne	s3,a0,ffffffffc02015b4 <default_check+0x5c2>
    free_page(p0);
ffffffffc020124a:	4585                	li	a1,1
ffffffffc020124c:	487000ef          	jal	ra,ffffffffc0201ed2 <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0201250:	4509                	li	a0,2
ffffffffc0201252:	443000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc0201256:	32aa1f63          	bne	s4,a0,ffffffffc0201594 <default_check+0x5a2>

    free_pages(p0, 2);
ffffffffc020125a:	4589                	li	a1,2
ffffffffc020125c:	477000ef          	jal	ra,ffffffffc0201ed2 <free_pages>
    free_page(p2);
ffffffffc0201260:	4585                	li	a1,1
ffffffffc0201262:	8562                	mv	a0,s8
ffffffffc0201264:	46f000ef          	jal	ra,ffffffffc0201ed2 <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0201268:	4515                	li	a0,5
ffffffffc020126a:	42b000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc020126e:	89aa                	mv	s3,a0
ffffffffc0201270:	48050263          	beqz	a0,ffffffffc02016f4 <default_check+0x702>
    assert(alloc_page() == NULL);
ffffffffc0201274:	4505                	li	a0,1
ffffffffc0201276:	41f000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc020127a:	2c051d63          	bnez	a0,ffffffffc0201554 <default_check+0x562>

    assert(nr_free == 0);
ffffffffc020127e:	481c                	lw	a5,16(s0)
ffffffffc0201280:	2a079a63          	bnez	a5,ffffffffc0201534 <default_check+0x542>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc0201284:	4595                	li	a1,5
ffffffffc0201286:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc0201288:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc020128c:	01643023          	sd	s6,0(s0)
ffffffffc0201290:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc0201294:	43f000ef          	jal	ra,ffffffffc0201ed2 <free_pages>
    return listelm->next;
ffffffffc0201298:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list)
ffffffffc020129a:	00878963          	beq	a5,s0,ffffffffc02012ac <default_check+0x2ba>
    {
        struct Page *p = le2page(le, page_link);
        count--, total -= p->property;
ffffffffc020129e:	ff87a703          	lw	a4,-8(a5)
ffffffffc02012a2:	679c                	ld	a5,8(a5)
ffffffffc02012a4:	397d                	addiw	s2,s2,-1
ffffffffc02012a6:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list)
ffffffffc02012a8:	fe879be3          	bne	a5,s0,ffffffffc020129e <default_check+0x2ac>
    }
    assert(count == 0);
ffffffffc02012ac:	26091463          	bnez	s2,ffffffffc0201514 <default_check+0x522>
    assert(total == 0);
ffffffffc02012b0:	46049263          	bnez	s1,ffffffffc0201714 <default_check+0x722>
}
ffffffffc02012b4:	60a6                	ld	ra,72(sp)
ffffffffc02012b6:	6406                	ld	s0,64(sp)
ffffffffc02012b8:	74e2                	ld	s1,56(sp)
ffffffffc02012ba:	7942                	ld	s2,48(sp)
ffffffffc02012bc:	79a2                	ld	s3,40(sp)
ffffffffc02012be:	7a02                	ld	s4,32(sp)
ffffffffc02012c0:	6ae2                	ld	s5,24(sp)
ffffffffc02012c2:	6b42                	ld	s6,16(sp)
ffffffffc02012c4:	6ba2                	ld	s7,8(sp)
ffffffffc02012c6:	6c02                	ld	s8,0(sp)
ffffffffc02012c8:	6161                	addi	sp,sp,80
ffffffffc02012ca:	8082                	ret
    while ((le = list_next(le)) != &free_list)
ffffffffc02012cc:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc02012ce:	4481                	li	s1,0
ffffffffc02012d0:	4901                	li	s2,0
ffffffffc02012d2:	b38d                	j	ffffffffc0201034 <default_check+0x42>
        assert(PageProperty(p));
ffffffffc02012d4:	00005697          	auipc	a3,0x5
ffffffffc02012d8:	e5c68693          	addi	a3,a3,-420 # ffffffffc0206130 <commands+0x818>
ffffffffc02012dc:	00005617          	auipc	a2,0x5
ffffffffc02012e0:	e6460613          	addi	a2,a2,-412 # ffffffffc0206140 <commands+0x828>
ffffffffc02012e4:	11000593          	li	a1,272
ffffffffc02012e8:	00005517          	auipc	a0,0x5
ffffffffc02012ec:	e7050513          	addi	a0,a0,-400 # ffffffffc0206158 <commands+0x840>
ffffffffc02012f0:	99eff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc02012f4:	00005697          	auipc	a3,0x5
ffffffffc02012f8:	efc68693          	addi	a3,a3,-260 # ffffffffc02061f0 <commands+0x8d8>
ffffffffc02012fc:	00005617          	auipc	a2,0x5
ffffffffc0201300:	e4460613          	addi	a2,a2,-444 # ffffffffc0206140 <commands+0x828>
ffffffffc0201304:	0db00593          	li	a1,219
ffffffffc0201308:	00005517          	auipc	a0,0x5
ffffffffc020130c:	e5050513          	addi	a0,a0,-432 # ffffffffc0206158 <commands+0x840>
ffffffffc0201310:	97eff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0201314:	00005697          	auipc	a3,0x5
ffffffffc0201318:	f0468693          	addi	a3,a3,-252 # ffffffffc0206218 <commands+0x900>
ffffffffc020131c:	00005617          	auipc	a2,0x5
ffffffffc0201320:	e2460613          	addi	a2,a2,-476 # ffffffffc0206140 <commands+0x828>
ffffffffc0201324:	0dc00593          	li	a1,220
ffffffffc0201328:	00005517          	auipc	a0,0x5
ffffffffc020132c:	e3050513          	addi	a0,a0,-464 # ffffffffc0206158 <commands+0x840>
ffffffffc0201330:	95eff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0201334:	00005697          	auipc	a3,0x5
ffffffffc0201338:	f2468693          	addi	a3,a3,-220 # ffffffffc0206258 <commands+0x940>
ffffffffc020133c:	00005617          	auipc	a2,0x5
ffffffffc0201340:	e0460613          	addi	a2,a2,-508 # ffffffffc0206140 <commands+0x828>
ffffffffc0201344:	0de00593          	li	a1,222
ffffffffc0201348:	00005517          	auipc	a0,0x5
ffffffffc020134c:	e1050513          	addi	a0,a0,-496 # ffffffffc0206158 <commands+0x840>
ffffffffc0201350:	93eff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(!list_empty(&free_list));
ffffffffc0201354:	00005697          	auipc	a3,0x5
ffffffffc0201358:	f8c68693          	addi	a3,a3,-116 # ffffffffc02062e0 <commands+0x9c8>
ffffffffc020135c:	00005617          	auipc	a2,0x5
ffffffffc0201360:	de460613          	addi	a2,a2,-540 # ffffffffc0206140 <commands+0x828>
ffffffffc0201364:	0f700593          	li	a1,247
ffffffffc0201368:	00005517          	auipc	a0,0x5
ffffffffc020136c:	df050513          	addi	a0,a0,-528 # ffffffffc0206158 <commands+0x840>
ffffffffc0201370:	91eff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201374:	00005697          	auipc	a3,0x5
ffffffffc0201378:	e1c68693          	addi	a3,a3,-484 # ffffffffc0206190 <commands+0x878>
ffffffffc020137c:	00005617          	auipc	a2,0x5
ffffffffc0201380:	dc460613          	addi	a2,a2,-572 # ffffffffc0206140 <commands+0x828>
ffffffffc0201384:	0f000593          	li	a1,240
ffffffffc0201388:	00005517          	auipc	a0,0x5
ffffffffc020138c:	dd050513          	addi	a0,a0,-560 # ffffffffc0206158 <commands+0x840>
ffffffffc0201390:	8feff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free == 3);
ffffffffc0201394:	00005697          	auipc	a3,0x5
ffffffffc0201398:	f3c68693          	addi	a3,a3,-196 # ffffffffc02062d0 <commands+0x9b8>
ffffffffc020139c:	00005617          	auipc	a2,0x5
ffffffffc02013a0:	da460613          	addi	a2,a2,-604 # ffffffffc0206140 <commands+0x828>
ffffffffc02013a4:	0ee00593          	li	a1,238
ffffffffc02013a8:	00005517          	auipc	a0,0x5
ffffffffc02013ac:	db050513          	addi	a0,a0,-592 # ffffffffc0206158 <commands+0x840>
ffffffffc02013b0:	8deff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc02013b4:	00005697          	auipc	a3,0x5
ffffffffc02013b8:	f0468693          	addi	a3,a3,-252 # ffffffffc02062b8 <commands+0x9a0>
ffffffffc02013bc:	00005617          	auipc	a2,0x5
ffffffffc02013c0:	d8460613          	addi	a2,a2,-636 # ffffffffc0206140 <commands+0x828>
ffffffffc02013c4:	0e900593          	li	a1,233
ffffffffc02013c8:	00005517          	auipc	a0,0x5
ffffffffc02013cc:	d9050513          	addi	a0,a0,-624 # ffffffffc0206158 <commands+0x840>
ffffffffc02013d0:	8beff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02013d4:	00005697          	auipc	a3,0x5
ffffffffc02013d8:	ec468693          	addi	a3,a3,-316 # ffffffffc0206298 <commands+0x980>
ffffffffc02013dc:	00005617          	auipc	a2,0x5
ffffffffc02013e0:	d6460613          	addi	a2,a2,-668 # ffffffffc0206140 <commands+0x828>
ffffffffc02013e4:	0e000593          	li	a1,224
ffffffffc02013e8:	00005517          	auipc	a0,0x5
ffffffffc02013ec:	d7050513          	addi	a0,a0,-656 # ffffffffc0206158 <commands+0x840>
ffffffffc02013f0:	89eff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(p0 != NULL);
ffffffffc02013f4:	00005697          	auipc	a3,0x5
ffffffffc02013f8:	f3468693          	addi	a3,a3,-204 # ffffffffc0206328 <commands+0xa10>
ffffffffc02013fc:	00005617          	auipc	a2,0x5
ffffffffc0201400:	d4460613          	addi	a2,a2,-700 # ffffffffc0206140 <commands+0x828>
ffffffffc0201404:	11800593          	li	a1,280
ffffffffc0201408:	00005517          	auipc	a0,0x5
ffffffffc020140c:	d5050513          	addi	a0,a0,-688 # ffffffffc0206158 <commands+0x840>
ffffffffc0201410:	87eff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free == 0);
ffffffffc0201414:	00005697          	auipc	a3,0x5
ffffffffc0201418:	f0468693          	addi	a3,a3,-252 # ffffffffc0206318 <commands+0xa00>
ffffffffc020141c:	00005617          	auipc	a2,0x5
ffffffffc0201420:	d2460613          	addi	a2,a2,-732 # ffffffffc0206140 <commands+0x828>
ffffffffc0201424:	0fd00593          	li	a1,253
ffffffffc0201428:	00005517          	auipc	a0,0x5
ffffffffc020142c:	d3050513          	addi	a0,a0,-720 # ffffffffc0206158 <commands+0x840>
ffffffffc0201430:	85eff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201434:	00005697          	auipc	a3,0x5
ffffffffc0201438:	e8468693          	addi	a3,a3,-380 # ffffffffc02062b8 <commands+0x9a0>
ffffffffc020143c:	00005617          	auipc	a2,0x5
ffffffffc0201440:	d0460613          	addi	a2,a2,-764 # ffffffffc0206140 <commands+0x828>
ffffffffc0201444:	0fb00593          	li	a1,251
ffffffffc0201448:	00005517          	auipc	a0,0x5
ffffffffc020144c:	d1050513          	addi	a0,a0,-752 # ffffffffc0206158 <commands+0x840>
ffffffffc0201450:	83eff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc0201454:	00005697          	auipc	a3,0x5
ffffffffc0201458:	ea468693          	addi	a3,a3,-348 # ffffffffc02062f8 <commands+0x9e0>
ffffffffc020145c:	00005617          	auipc	a2,0x5
ffffffffc0201460:	ce460613          	addi	a2,a2,-796 # ffffffffc0206140 <commands+0x828>
ffffffffc0201464:	0fa00593          	li	a1,250
ffffffffc0201468:	00005517          	auipc	a0,0x5
ffffffffc020146c:	cf050513          	addi	a0,a0,-784 # ffffffffc0206158 <commands+0x840>
ffffffffc0201470:	81eff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201474:	00005697          	auipc	a3,0x5
ffffffffc0201478:	d1c68693          	addi	a3,a3,-740 # ffffffffc0206190 <commands+0x878>
ffffffffc020147c:	00005617          	auipc	a2,0x5
ffffffffc0201480:	cc460613          	addi	a2,a2,-828 # ffffffffc0206140 <commands+0x828>
ffffffffc0201484:	0d700593          	li	a1,215
ffffffffc0201488:	00005517          	auipc	a0,0x5
ffffffffc020148c:	cd050513          	addi	a0,a0,-816 # ffffffffc0206158 <commands+0x840>
ffffffffc0201490:	ffffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201494:	00005697          	auipc	a3,0x5
ffffffffc0201498:	e2468693          	addi	a3,a3,-476 # ffffffffc02062b8 <commands+0x9a0>
ffffffffc020149c:	00005617          	auipc	a2,0x5
ffffffffc02014a0:	ca460613          	addi	a2,a2,-860 # ffffffffc0206140 <commands+0x828>
ffffffffc02014a4:	0f400593          	li	a1,244
ffffffffc02014a8:	00005517          	auipc	a0,0x5
ffffffffc02014ac:	cb050513          	addi	a0,a0,-848 # ffffffffc0206158 <commands+0x840>
ffffffffc02014b0:	fdffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02014b4:	00005697          	auipc	a3,0x5
ffffffffc02014b8:	d1c68693          	addi	a3,a3,-740 # ffffffffc02061d0 <commands+0x8b8>
ffffffffc02014bc:	00005617          	auipc	a2,0x5
ffffffffc02014c0:	c8460613          	addi	a2,a2,-892 # ffffffffc0206140 <commands+0x828>
ffffffffc02014c4:	0f200593          	li	a1,242
ffffffffc02014c8:	00005517          	auipc	a0,0x5
ffffffffc02014cc:	c9050513          	addi	a0,a0,-880 # ffffffffc0206158 <commands+0x840>
ffffffffc02014d0:	fbffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc02014d4:	00005697          	auipc	a3,0x5
ffffffffc02014d8:	cdc68693          	addi	a3,a3,-804 # ffffffffc02061b0 <commands+0x898>
ffffffffc02014dc:	00005617          	auipc	a2,0x5
ffffffffc02014e0:	c6460613          	addi	a2,a2,-924 # ffffffffc0206140 <commands+0x828>
ffffffffc02014e4:	0f100593          	li	a1,241
ffffffffc02014e8:	00005517          	auipc	a0,0x5
ffffffffc02014ec:	c7050513          	addi	a0,a0,-912 # ffffffffc0206158 <commands+0x840>
ffffffffc02014f0:	f9ffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02014f4:	00005697          	auipc	a3,0x5
ffffffffc02014f8:	cdc68693          	addi	a3,a3,-804 # ffffffffc02061d0 <commands+0x8b8>
ffffffffc02014fc:	00005617          	auipc	a2,0x5
ffffffffc0201500:	c4460613          	addi	a2,a2,-956 # ffffffffc0206140 <commands+0x828>
ffffffffc0201504:	0d900593          	li	a1,217
ffffffffc0201508:	00005517          	auipc	a0,0x5
ffffffffc020150c:	c5050513          	addi	a0,a0,-944 # ffffffffc0206158 <commands+0x840>
ffffffffc0201510:	f7ffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(count == 0);
ffffffffc0201514:	00005697          	auipc	a3,0x5
ffffffffc0201518:	f6468693          	addi	a3,a3,-156 # ffffffffc0206478 <commands+0xb60>
ffffffffc020151c:	00005617          	auipc	a2,0x5
ffffffffc0201520:	c2460613          	addi	a2,a2,-988 # ffffffffc0206140 <commands+0x828>
ffffffffc0201524:	14600593          	li	a1,326
ffffffffc0201528:	00005517          	auipc	a0,0x5
ffffffffc020152c:	c3050513          	addi	a0,a0,-976 # ffffffffc0206158 <commands+0x840>
ffffffffc0201530:	f5ffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free == 0);
ffffffffc0201534:	00005697          	auipc	a3,0x5
ffffffffc0201538:	de468693          	addi	a3,a3,-540 # ffffffffc0206318 <commands+0xa00>
ffffffffc020153c:	00005617          	auipc	a2,0x5
ffffffffc0201540:	c0460613          	addi	a2,a2,-1020 # ffffffffc0206140 <commands+0x828>
ffffffffc0201544:	13a00593          	li	a1,314
ffffffffc0201548:	00005517          	auipc	a0,0x5
ffffffffc020154c:	c1050513          	addi	a0,a0,-1008 # ffffffffc0206158 <commands+0x840>
ffffffffc0201550:	f3ffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201554:	00005697          	auipc	a3,0x5
ffffffffc0201558:	d6468693          	addi	a3,a3,-668 # ffffffffc02062b8 <commands+0x9a0>
ffffffffc020155c:	00005617          	auipc	a2,0x5
ffffffffc0201560:	be460613          	addi	a2,a2,-1052 # ffffffffc0206140 <commands+0x828>
ffffffffc0201564:	13800593          	li	a1,312
ffffffffc0201568:	00005517          	auipc	a0,0x5
ffffffffc020156c:	bf050513          	addi	a0,a0,-1040 # ffffffffc0206158 <commands+0x840>
ffffffffc0201570:	f1ffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0201574:	00005697          	auipc	a3,0x5
ffffffffc0201578:	d0468693          	addi	a3,a3,-764 # ffffffffc0206278 <commands+0x960>
ffffffffc020157c:	00005617          	auipc	a2,0x5
ffffffffc0201580:	bc460613          	addi	a2,a2,-1084 # ffffffffc0206140 <commands+0x828>
ffffffffc0201584:	0df00593          	li	a1,223
ffffffffc0201588:	00005517          	auipc	a0,0x5
ffffffffc020158c:	bd050513          	addi	a0,a0,-1072 # ffffffffc0206158 <commands+0x840>
ffffffffc0201590:	efffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0201594:	00005697          	auipc	a3,0x5
ffffffffc0201598:	ea468693          	addi	a3,a3,-348 # ffffffffc0206438 <commands+0xb20>
ffffffffc020159c:	00005617          	auipc	a2,0x5
ffffffffc02015a0:	ba460613          	addi	a2,a2,-1116 # ffffffffc0206140 <commands+0x828>
ffffffffc02015a4:	13200593          	li	a1,306
ffffffffc02015a8:	00005517          	auipc	a0,0x5
ffffffffc02015ac:	bb050513          	addi	a0,a0,-1104 # ffffffffc0206158 <commands+0x840>
ffffffffc02015b0:	edffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc02015b4:	00005697          	auipc	a3,0x5
ffffffffc02015b8:	e6468693          	addi	a3,a3,-412 # ffffffffc0206418 <commands+0xb00>
ffffffffc02015bc:	00005617          	auipc	a2,0x5
ffffffffc02015c0:	b8460613          	addi	a2,a2,-1148 # ffffffffc0206140 <commands+0x828>
ffffffffc02015c4:	13000593          	li	a1,304
ffffffffc02015c8:	00005517          	auipc	a0,0x5
ffffffffc02015cc:	b9050513          	addi	a0,a0,-1136 # ffffffffc0206158 <commands+0x840>
ffffffffc02015d0:	ebffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc02015d4:	00005697          	auipc	a3,0x5
ffffffffc02015d8:	e1c68693          	addi	a3,a3,-484 # ffffffffc02063f0 <commands+0xad8>
ffffffffc02015dc:	00005617          	auipc	a2,0x5
ffffffffc02015e0:	b6460613          	addi	a2,a2,-1180 # ffffffffc0206140 <commands+0x828>
ffffffffc02015e4:	12e00593          	li	a1,302
ffffffffc02015e8:	00005517          	auipc	a0,0x5
ffffffffc02015ec:	b7050513          	addi	a0,a0,-1168 # ffffffffc0206158 <commands+0x840>
ffffffffc02015f0:	e9ffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc02015f4:	00005697          	auipc	a3,0x5
ffffffffc02015f8:	dd468693          	addi	a3,a3,-556 # ffffffffc02063c8 <commands+0xab0>
ffffffffc02015fc:	00005617          	auipc	a2,0x5
ffffffffc0201600:	b4460613          	addi	a2,a2,-1212 # ffffffffc0206140 <commands+0x828>
ffffffffc0201604:	12d00593          	li	a1,301
ffffffffc0201608:	00005517          	auipc	a0,0x5
ffffffffc020160c:	b5050513          	addi	a0,a0,-1200 # ffffffffc0206158 <commands+0x840>
ffffffffc0201610:	e7ffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(p0 + 2 == p1);
ffffffffc0201614:	00005697          	auipc	a3,0x5
ffffffffc0201618:	da468693          	addi	a3,a3,-604 # ffffffffc02063b8 <commands+0xaa0>
ffffffffc020161c:	00005617          	auipc	a2,0x5
ffffffffc0201620:	b2460613          	addi	a2,a2,-1244 # ffffffffc0206140 <commands+0x828>
ffffffffc0201624:	12800593          	li	a1,296
ffffffffc0201628:	00005517          	auipc	a0,0x5
ffffffffc020162c:	b3050513          	addi	a0,a0,-1232 # ffffffffc0206158 <commands+0x840>
ffffffffc0201630:	e5ffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201634:	00005697          	auipc	a3,0x5
ffffffffc0201638:	c8468693          	addi	a3,a3,-892 # ffffffffc02062b8 <commands+0x9a0>
ffffffffc020163c:	00005617          	auipc	a2,0x5
ffffffffc0201640:	b0460613          	addi	a2,a2,-1276 # ffffffffc0206140 <commands+0x828>
ffffffffc0201644:	12700593          	li	a1,295
ffffffffc0201648:	00005517          	auipc	a0,0x5
ffffffffc020164c:	b1050513          	addi	a0,a0,-1264 # ffffffffc0206158 <commands+0x840>
ffffffffc0201650:	e3ffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0201654:	00005697          	auipc	a3,0x5
ffffffffc0201658:	d4468693          	addi	a3,a3,-700 # ffffffffc0206398 <commands+0xa80>
ffffffffc020165c:	00005617          	auipc	a2,0x5
ffffffffc0201660:	ae460613          	addi	a2,a2,-1308 # ffffffffc0206140 <commands+0x828>
ffffffffc0201664:	12600593          	li	a1,294
ffffffffc0201668:	00005517          	auipc	a0,0x5
ffffffffc020166c:	af050513          	addi	a0,a0,-1296 # ffffffffc0206158 <commands+0x840>
ffffffffc0201670:	e1ffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0201674:	00005697          	auipc	a3,0x5
ffffffffc0201678:	cf468693          	addi	a3,a3,-780 # ffffffffc0206368 <commands+0xa50>
ffffffffc020167c:	00005617          	auipc	a2,0x5
ffffffffc0201680:	ac460613          	addi	a2,a2,-1340 # ffffffffc0206140 <commands+0x828>
ffffffffc0201684:	12500593          	li	a1,293
ffffffffc0201688:	00005517          	auipc	a0,0x5
ffffffffc020168c:	ad050513          	addi	a0,a0,-1328 # ffffffffc0206158 <commands+0x840>
ffffffffc0201690:	dfffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc0201694:	00005697          	auipc	a3,0x5
ffffffffc0201698:	cbc68693          	addi	a3,a3,-836 # ffffffffc0206350 <commands+0xa38>
ffffffffc020169c:	00005617          	auipc	a2,0x5
ffffffffc02016a0:	aa460613          	addi	a2,a2,-1372 # ffffffffc0206140 <commands+0x828>
ffffffffc02016a4:	12400593          	li	a1,292
ffffffffc02016a8:	00005517          	auipc	a0,0x5
ffffffffc02016ac:	ab050513          	addi	a0,a0,-1360 # ffffffffc0206158 <commands+0x840>
ffffffffc02016b0:	ddffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc02016b4:	00005697          	auipc	a3,0x5
ffffffffc02016b8:	c0468693          	addi	a3,a3,-1020 # ffffffffc02062b8 <commands+0x9a0>
ffffffffc02016bc:	00005617          	auipc	a2,0x5
ffffffffc02016c0:	a8460613          	addi	a2,a2,-1404 # ffffffffc0206140 <commands+0x828>
ffffffffc02016c4:	11e00593          	li	a1,286
ffffffffc02016c8:	00005517          	auipc	a0,0x5
ffffffffc02016cc:	a9050513          	addi	a0,a0,-1392 # ffffffffc0206158 <commands+0x840>
ffffffffc02016d0:	dbffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(!PageProperty(p0));
ffffffffc02016d4:	00005697          	auipc	a3,0x5
ffffffffc02016d8:	c6468693          	addi	a3,a3,-924 # ffffffffc0206338 <commands+0xa20>
ffffffffc02016dc:	00005617          	auipc	a2,0x5
ffffffffc02016e0:	a6460613          	addi	a2,a2,-1436 # ffffffffc0206140 <commands+0x828>
ffffffffc02016e4:	11900593          	li	a1,281
ffffffffc02016e8:	00005517          	auipc	a0,0x5
ffffffffc02016ec:	a7050513          	addi	a0,a0,-1424 # ffffffffc0206158 <commands+0x840>
ffffffffc02016f0:	d9ffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc02016f4:	00005697          	auipc	a3,0x5
ffffffffc02016f8:	d6468693          	addi	a3,a3,-668 # ffffffffc0206458 <commands+0xb40>
ffffffffc02016fc:	00005617          	auipc	a2,0x5
ffffffffc0201700:	a4460613          	addi	a2,a2,-1468 # ffffffffc0206140 <commands+0x828>
ffffffffc0201704:	13700593          	li	a1,311
ffffffffc0201708:	00005517          	auipc	a0,0x5
ffffffffc020170c:	a5050513          	addi	a0,a0,-1456 # ffffffffc0206158 <commands+0x840>
ffffffffc0201710:	d7ffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(total == 0);
ffffffffc0201714:	00005697          	auipc	a3,0x5
ffffffffc0201718:	d7468693          	addi	a3,a3,-652 # ffffffffc0206488 <commands+0xb70>
ffffffffc020171c:	00005617          	auipc	a2,0x5
ffffffffc0201720:	a2460613          	addi	a2,a2,-1500 # ffffffffc0206140 <commands+0x828>
ffffffffc0201724:	14700593          	li	a1,327
ffffffffc0201728:	00005517          	auipc	a0,0x5
ffffffffc020172c:	a3050513          	addi	a0,a0,-1488 # ffffffffc0206158 <commands+0x840>
ffffffffc0201730:	d5ffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(total == nr_free_pages());
ffffffffc0201734:	00005697          	auipc	a3,0x5
ffffffffc0201738:	a3c68693          	addi	a3,a3,-1476 # ffffffffc0206170 <commands+0x858>
ffffffffc020173c:	00005617          	auipc	a2,0x5
ffffffffc0201740:	a0460613          	addi	a2,a2,-1532 # ffffffffc0206140 <commands+0x828>
ffffffffc0201744:	11300593          	li	a1,275
ffffffffc0201748:	00005517          	auipc	a0,0x5
ffffffffc020174c:	a1050513          	addi	a0,a0,-1520 # ffffffffc0206158 <commands+0x840>
ffffffffc0201750:	d3ffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201754:	00005697          	auipc	a3,0x5
ffffffffc0201758:	a5c68693          	addi	a3,a3,-1444 # ffffffffc02061b0 <commands+0x898>
ffffffffc020175c:	00005617          	auipc	a2,0x5
ffffffffc0201760:	9e460613          	addi	a2,a2,-1564 # ffffffffc0206140 <commands+0x828>
ffffffffc0201764:	0d800593          	li	a1,216
ffffffffc0201768:	00005517          	auipc	a0,0x5
ffffffffc020176c:	9f050513          	addi	a0,a0,-1552 # ffffffffc0206158 <commands+0x840>
ffffffffc0201770:	d1ffe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201774 <default_free_pages>:
{
ffffffffc0201774:	1141                	addi	sp,sp,-16
ffffffffc0201776:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0201778:	14058463          	beqz	a1,ffffffffc02018c0 <default_free_pages+0x14c>
    for (; p != base + n; p++)
ffffffffc020177c:	00659693          	slli	a3,a1,0x6
ffffffffc0201780:	96aa                	add	a3,a3,a0
ffffffffc0201782:	87aa                	mv	a5,a0
ffffffffc0201784:	02d50263          	beq	a0,a3,ffffffffc02017a8 <default_free_pages+0x34>
ffffffffc0201788:	6798                	ld	a4,8(a5)
ffffffffc020178a:	8b05                	andi	a4,a4,1
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc020178c:	10071a63          	bnez	a4,ffffffffc02018a0 <default_free_pages+0x12c>
ffffffffc0201790:	6798                	ld	a4,8(a5)
ffffffffc0201792:	8b09                	andi	a4,a4,2
ffffffffc0201794:	10071663          	bnez	a4,ffffffffc02018a0 <default_free_pages+0x12c>
        p->flags = 0;
ffffffffc0201798:	0007b423          	sd	zero,8(a5)
}

static inline void
set_page_ref(struct Page *page, int val)
{
    page->ref = val;
ffffffffc020179c:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc02017a0:	04078793          	addi	a5,a5,64
ffffffffc02017a4:	fed792e3          	bne	a5,a3,ffffffffc0201788 <default_free_pages+0x14>
    base->property = n;
ffffffffc02017a8:	2581                	sext.w	a1,a1
ffffffffc02017aa:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc02017ac:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02017b0:	4789                	li	a5,2
ffffffffc02017b2:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc02017b6:	000a5697          	auipc	a3,0xa5
ffffffffc02017ba:	e3268693          	addi	a3,a3,-462 # ffffffffc02a65e8 <free_area>
ffffffffc02017be:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02017c0:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02017c2:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02017c6:	9db9                	addw	a1,a1,a4
ffffffffc02017c8:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list))
ffffffffc02017ca:	0ad78463          	beq	a5,a3,ffffffffc0201872 <default_free_pages+0xfe>
            struct Page *page = le2page(le, page_link);
ffffffffc02017ce:	fe878713          	addi	a4,a5,-24
ffffffffc02017d2:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list))
ffffffffc02017d6:	4581                	li	a1,0
            if (base < page)
ffffffffc02017d8:	00e56a63          	bltu	a0,a4,ffffffffc02017ec <default_free_pages+0x78>
    return listelm->next;
ffffffffc02017dc:	6798                	ld	a4,8(a5)
            else if (list_next(le) == &free_list)
ffffffffc02017de:	04d70c63          	beq	a4,a3,ffffffffc0201836 <default_free_pages+0xc2>
    for (; p != base + n; p++)
ffffffffc02017e2:	87ba                	mv	a5,a4
            struct Page *page = le2page(le, page_link);
ffffffffc02017e4:	fe878713          	addi	a4,a5,-24
            if (base < page)
ffffffffc02017e8:	fee57ae3          	bgeu	a0,a4,ffffffffc02017dc <default_free_pages+0x68>
ffffffffc02017ec:	c199                	beqz	a1,ffffffffc02017f2 <default_free_pages+0x7e>
ffffffffc02017ee:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc02017f2:	6398                	ld	a4,0(a5)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc02017f4:	e390                	sd	a2,0(a5)
ffffffffc02017f6:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc02017f8:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc02017fa:	ed18                	sd	a4,24(a0)
    if (le != &free_list)
ffffffffc02017fc:	00d70d63          	beq	a4,a3,ffffffffc0201816 <default_free_pages+0xa2>
        if (p + p->property == base)
ffffffffc0201800:	ff872583          	lw	a1,-8(a4)
        p = le2page(le, page_link);
ffffffffc0201804:	fe870613          	addi	a2,a4,-24
        if (p + p->property == base)
ffffffffc0201808:	02059813          	slli	a6,a1,0x20
ffffffffc020180c:	01a85793          	srli	a5,a6,0x1a
ffffffffc0201810:	97b2                	add	a5,a5,a2
ffffffffc0201812:	02f50c63          	beq	a0,a5,ffffffffc020184a <default_free_pages+0xd6>
    return listelm->next;
ffffffffc0201816:	711c                	ld	a5,32(a0)
    if (le != &free_list)
ffffffffc0201818:	00d78c63          	beq	a5,a3,ffffffffc0201830 <default_free_pages+0xbc>
        if (base + base->property == p)
ffffffffc020181c:	4910                	lw	a2,16(a0)
        p = le2page(le, page_link);
ffffffffc020181e:	fe878693          	addi	a3,a5,-24
        if (base + base->property == p)
ffffffffc0201822:	02061593          	slli	a1,a2,0x20
ffffffffc0201826:	01a5d713          	srli	a4,a1,0x1a
ffffffffc020182a:	972a                	add	a4,a4,a0
ffffffffc020182c:	04e68a63          	beq	a3,a4,ffffffffc0201880 <default_free_pages+0x10c>
}
ffffffffc0201830:	60a2                	ld	ra,8(sp)
ffffffffc0201832:	0141                	addi	sp,sp,16
ffffffffc0201834:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0201836:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201838:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc020183a:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc020183c:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list)
ffffffffc020183e:	02d70763          	beq	a4,a3,ffffffffc020186c <default_free_pages+0xf8>
    prev->next = next->prev = elm;
ffffffffc0201842:	8832                	mv	a6,a2
ffffffffc0201844:	4585                	li	a1,1
    for (; p != base + n; p++)
ffffffffc0201846:	87ba                	mv	a5,a4
ffffffffc0201848:	bf71                	j	ffffffffc02017e4 <default_free_pages+0x70>
            p->property += base->property;
ffffffffc020184a:	491c                	lw	a5,16(a0)
ffffffffc020184c:	9dbd                	addw	a1,a1,a5
ffffffffc020184e:	feb72c23          	sw	a1,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0201852:	57f5                	li	a5,-3
ffffffffc0201854:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc0201858:	01853803          	ld	a6,24(a0)
ffffffffc020185c:	710c                	ld	a1,32(a0)
            base = p;
ffffffffc020185e:	8532                	mv	a0,a2
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc0201860:	00b83423          	sd	a1,8(a6)
    return listelm->next;
ffffffffc0201864:	671c                	ld	a5,8(a4)
    next->prev = prev;
ffffffffc0201866:	0105b023          	sd	a6,0(a1)
ffffffffc020186a:	b77d                	j	ffffffffc0201818 <default_free_pages+0xa4>
ffffffffc020186c:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list)
ffffffffc020186e:	873e                	mv	a4,a5
ffffffffc0201870:	bf41                	j	ffffffffc0201800 <default_free_pages+0x8c>
}
ffffffffc0201872:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0201874:	e390                	sd	a2,0(a5)
ffffffffc0201876:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201878:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc020187a:	ed1c                	sd	a5,24(a0)
ffffffffc020187c:	0141                	addi	sp,sp,16
ffffffffc020187e:	8082                	ret
            base->property += p->property;
ffffffffc0201880:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201884:	ff078693          	addi	a3,a5,-16
ffffffffc0201888:	9e39                	addw	a2,a2,a4
ffffffffc020188a:	c910                	sw	a2,16(a0)
ffffffffc020188c:	5775                	li	a4,-3
ffffffffc020188e:	60e6b02f          	amoand.d	zero,a4,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc0201892:	6398                	ld	a4,0(a5)
ffffffffc0201894:	679c                	ld	a5,8(a5)
}
ffffffffc0201896:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc0201898:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc020189a:	e398                	sd	a4,0(a5)
ffffffffc020189c:	0141                	addi	sp,sp,16
ffffffffc020189e:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02018a0:	00005697          	auipc	a3,0x5
ffffffffc02018a4:	c0068693          	addi	a3,a3,-1024 # ffffffffc02064a0 <commands+0xb88>
ffffffffc02018a8:	00005617          	auipc	a2,0x5
ffffffffc02018ac:	89860613          	addi	a2,a2,-1896 # ffffffffc0206140 <commands+0x828>
ffffffffc02018b0:	09400593          	li	a1,148
ffffffffc02018b4:	00005517          	auipc	a0,0x5
ffffffffc02018b8:	8a450513          	addi	a0,a0,-1884 # ffffffffc0206158 <commands+0x840>
ffffffffc02018bc:	bd3fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(n > 0);
ffffffffc02018c0:	00005697          	auipc	a3,0x5
ffffffffc02018c4:	bd868693          	addi	a3,a3,-1064 # ffffffffc0206498 <commands+0xb80>
ffffffffc02018c8:	00005617          	auipc	a2,0x5
ffffffffc02018cc:	87860613          	addi	a2,a2,-1928 # ffffffffc0206140 <commands+0x828>
ffffffffc02018d0:	09000593          	li	a1,144
ffffffffc02018d4:	00005517          	auipc	a0,0x5
ffffffffc02018d8:	88450513          	addi	a0,a0,-1916 # ffffffffc0206158 <commands+0x840>
ffffffffc02018dc:	bb3fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02018e0 <default_alloc_pages>:
    assert(n > 0);
ffffffffc02018e0:	c941                	beqz	a0,ffffffffc0201970 <default_alloc_pages+0x90>
    if (n > nr_free)
ffffffffc02018e2:	000a5597          	auipc	a1,0xa5
ffffffffc02018e6:	d0658593          	addi	a1,a1,-762 # ffffffffc02a65e8 <free_area>
ffffffffc02018ea:	0105a803          	lw	a6,16(a1)
ffffffffc02018ee:	872a                	mv	a4,a0
ffffffffc02018f0:	02081793          	slli	a5,a6,0x20
ffffffffc02018f4:	9381                	srli	a5,a5,0x20
ffffffffc02018f6:	00a7ee63          	bltu	a5,a0,ffffffffc0201912 <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc02018fa:	87ae                	mv	a5,a1
ffffffffc02018fc:	a801                	j	ffffffffc020190c <default_alloc_pages+0x2c>
        if (p->property >= n)
ffffffffc02018fe:	ff87a683          	lw	a3,-8(a5)
ffffffffc0201902:	02069613          	slli	a2,a3,0x20
ffffffffc0201906:	9201                	srli	a2,a2,0x20
ffffffffc0201908:	00e67763          	bgeu	a2,a4,ffffffffc0201916 <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc020190c:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list)
ffffffffc020190e:	feb798e3          	bne	a5,a1,ffffffffc02018fe <default_alloc_pages+0x1e>
        return NULL;
ffffffffc0201912:	4501                	li	a0,0
}
ffffffffc0201914:	8082                	ret
    return listelm->prev;
ffffffffc0201916:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc020191a:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc020191e:	fe878513          	addi	a0,a5,-24
            p->property = page->property - n;
ffffffffc0201922:	00070e1b          	sext.w	t3,a4
    prev->next = next;
ffffffffc0201926:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc020192a:	01133023          	sd	a7,0(t1)
        if (page->property > n)
ffffffffc020192e:	02c77863          	bgeu	a4,a2,ffffffffc020195e <default_alloc_pages+0x7e>
            struct Page *p = page + n;
ffffffffc0201932:	071a                	slli	a4,a4,0x6
ffffffffc0201934:	972a                	add	a4,a4,a0
            p->property = page->property - n;
ffffffffc0201936:	41c686bb          	subw	a3,a3,t3
ffffffffc020193a:	cb14                	sw	a3,16(a4)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc020193c:	00870613          	addi	a2,a4,8
ffffffffc0201940:	4689                	li	a3,2
ffffffffc0201942:	40d6302f          	amoor.d	zero,a3,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc0201946:	0088b683          	ld	a3,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc020194a:	01870613          	addi	a2,a4,24
        nr_free -= n;
ffffffffc020194e:	0105a803          	lw	a6,16(a1)
    prev->next = next->prev = elm;
ffffffffc0201952:	e290                	sd	a2,0(a3)
ffffffffc0201954:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc0201958:	f314                	sd	a3,32(a4)
    elm->prev = prev;
ffffffffc020195a:	01173c23          	sd	a7,24(a4)
ffffffffc020195e:	41c8083b          	subw	a6,a6,t3
ffffffffc0201962:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0201966:	5775                	li	a4,-3
ffffffffc0201968:	17c1                	addi	a5,a5,-16
ffffffffc020196a:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc020196e:	8082                	ret
{
ffffffffc0201970:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc0201972:	00005697          	auipc	a3,0x5
ffffffffc0201976:	b2668693          	addi	a3,a3,-1242 # ffffffffc0206498 <commands+0xb80>
ffffffffc020197a:	00004617          	auipc	a2,0x4
ffffffffc020197e:	7c660613          	addi	a2,a2,1990 # ffffffffc0206140 <commands+0x828>
ffffffffc0201982:	06c00593          	li	a1,108
ffffffffc0201986:	00004517          	auipc	a0,0x4
ffffffffc020198a:	7d250513          	addi	a0,a0,2002 # ffffffffc0206158 <commands+0x840>
{
ffffffffc020198e:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0201990:	afffe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201994 <default_init_memmap>:
{
ffffffffc0201994:	1141                	addi	sp,sp,-16
ffffffffc0201996:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0201998:	c5f1                	beqz	a1,ffffffffc0201a64 <default_init_memmap+0xd0>
    for (; p != base + n; p++)
ffffffffc020199a:	00659693          	slli	a3,a1,0x6
ffffffffc020199e:	96aa                	add	a3,a3,a0
ffffffffc02019a0:	87aa                	mv	a5,a0
ffffffffc02019a2:	00d50f63          	beq	a0,a3,ffffffffc02019c0 <default_init_memmap+0x2c>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc02019a6:	6798                	ld	a4,8(a5)
ffffffffc02019a8:	8b05                	andi	a4,a4,1
        assert(PageReserved(p));
ffffffffc02019aa:	cf49                	beqz	a4,ffffffffc0201a44 <default_init_memmap+0xb0>
        p->flags = p->property = 0;
ffffffffc02019ac:	0007a823          	sw	zero,16(a5)
ffffffffc02019b0:	0007b423          	sd	zero,8(a5)
ffffffffc02019b4:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc02019b8:	04078793          	addi	a5,a5,64
ffffffffc02019bc:	fed795e3          	bne	a5,a3,ffffffffc02019a6 <default_init_memmap+0x12>
    base->property = n;
ffffffffc02019c0:	2581                	sext.w	a1,a1
ffffffffc02019c2:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02019c4:	4789                	li	a5,2
ffffffffc02019c6:	00850713          	addi	a4,a0,8
ffffffffc02019ca:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc02019ce:	000a5697          	auipc	a3,0xa5
ffffffffc02019d2:	c1a68693          	addi	a3,a3,-998 # ffffffffc02a65e8 <free_area>
ffffffffc02019d6:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02019d8:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02019da:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02019de:	9db9                	addw	a1,a1,a4
ffffffffc02019e0:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list))
ffffffffc02019e2:	04d78a63          	beq	a5,a3,ffffffffc0201a36 <default_init_memmap+0xa2>
            struct Page *page = le2page(le, page_link);
ffffffffc02019e6:	fe878713          	addi	a4,a5,-24
ffffffffc02019ea:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list))
ffffffffc02019ee:	4581                	li	a1,0
            if (base < page)
ffffffffc02019f0:	00e56a63          	bltu	a0,a4,ffffffffc0201a04 <default_init_memmap+0x70>
    return listelm->next;
ffffffffc02019f4:	6798                	ld	a4,8(a5)
            else if (list_next(le) == &free_list)
ffffffffc02019f6:	02d70263          	beq	a4,a3,ffffffffc0201a1a <default_init_memmap+0x86>
    for (; p != base + n; p++)
ffffffffc02019fa:	87ba                	mv	a5,a4
            struct Page *page = le2page(le, page_link);
ffffffffc02019fc:	fe878713          	addi	a4,a5,-24
            if (base < page)
ffffffffc0201a00:	fee57ae3          	bgeu	a0,a4,ffffffffc02019f4 <default_init_memmap+0x60>
ffffffffc0201a04:	c199                	beqz	a1,ffffffffc0201a0a <default_init_memmap+0x76>
ffffffffc0201a06:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc0201a0a:	6398                	ld	a4,0(a5)
}
ffffffffc0201a0c:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0201a0e:	e390                	sd	a2,0(a5)
ffffffffc0201a10:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0201a12:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201a14:	ed18                	sd	a4,24(a0)
ffffffffc0201a16:	0141                	addi	sp,sp,16
ffffffffc0201a18:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0201a1a:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201a1c:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0201a1e:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0201a20:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list)
ffffffffc0201a22:	00d70663          	beq	a4,a3,ffffffffc0201a2e <default_init_memmap+0x9a>
    prev->next = next->prev = elm;
ffffffffc0201a26:	8832                	mv	a6,a2
ffffffffc0201a28:	4585                	li	a1,1
    for (; p != base + n; p++)
ffffffffc0201a2a:	87ba                	mv	a5,a4
ffffffffc0201a2c:	bfc1                	j	ffffffffc02019fc <default_init_memmap+0x68>
}
ffffffffc0201a2e:	60a2                	ld	ra,8(sp)
ffffffffc0201a30:	e290                	sd	a2,0(a3)
ffffffffc0201a32:	0141                	addi	sp,sp,16
ffffffffc0201a34:	8082                	ret
ffffffffc0201a36:	60a2                	ld	ra,8(sp)
ffffffffc0201a38:	e390                	sd	a2,0(a5)
ffffffffc0201a3a:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201a3c:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201a3e:	ed1c                	sd	a5,24(a0)
ffffffffc0201a40:	0141                	addi	sp,sp,16
ffffffffc0201a42:	8082                	ret
        assert(PageReserved(p));
ffffffffc0201a44:	00005697          	auipc	a3,0x5
ffffffffc0201a48:	a8468693          	addi	a3,a3,-1404 # ffffffffc02064c8 <commands+0xbb0>
ffffffffc0201a4c:	00004617          	auipc	a2,0x4
ffffffffc0201a50:	6f460613          	addi	a2,a2,1780 # ffffffffc0206140 <commands+0x828>
ffffffffc0201a54:	04b00593          	li	a1,75
ffffffffc0201a58:	00004517          	auipc	a0,0x4
ffffffffc0201a5c:	70050513          	addi	a0,a0,1792 # ffffffffc0206158 <commands+0x840>
ffffffffc0201a60:	a2ffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(n > 0);
ffffffffc0201a64:	00005697          	auipc	a3,0x5
ffffffffc0201a68:	a3468693          	addi	a3,a3,-1484 # ffffffffc0206498 <commands+0xb80>
ffffffffc0201a6c:	00004617          	auipc	a2,0x4
ffffffffc0201a70:	6d460613          	addi	a2,a2,1748 # ffffffffc0206140 <commands+0x828>
ffffffffc0201a74:	04700593          	li	a1,71
ffffffffc0201a78:	00004517          	auipc	a0,0x4
ffffffffc0201a7c:	6e050513          	addi	a0,a0,1760 # ffffffffc0206158 <commands+0x840>
ffffffffc0201a80:	a0ffe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201a84 <slob_free>:
static void slob_free(void *block, int size)
{
	slob_t *cur, *b = (slob_t *)block;
	unsigned long flags;

	if (!block)
ffffffffc0201a84:	c94d                	beqz	a0,ffffffffc0201b36 <slob_free+0xb2>
{
ffffffffc0201a86:	1141                	addi	sp,sp,-16
ffffffffc0201a88:	e022                	sd	s0,0(sp)
ffffffffc0201a8a:	e406                	sd	ra,8(sp)
ffffffffc0201a8c:	842a                	mv	s0,a0
		return;

	if (size)
ffffffffc0201a8e:	e9c1                	bnez	a1,ffffffffc0201b1e <slob_free+0x9a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201a90:	100027f3          	csrr	a5,sstatus
ffffffffc0201a94:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0201a96:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201a98:	ebd9                	bnez	a5,ffffffffc0201b2e <slob_free+0xaa>
		b->units = SLOB_UNITS(size);

	/* Find reinsertion point */
	spin_lock_irqsave(&slob_lock, flags);
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0201a9a:	000a4617          	auipc	a2,0xa4
ffffffffc0201a9e:	73e60613          	addi	a2,a2,1854 # ffffffffc02a61d8 <slobfree>
ffffffffc0201aa2:	621c                	ld	a5,0(a2)
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201aa4:	873e                	mv	a4,a5
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0201aa6:	679c                	ld	a5,8(a5)
ffffffffc0201aa8:	02877a63          	bgeu	a4,s0,ffffffffc0201adc <slob_free+0x58>
ffffffffc0201aac:	00f46463          	bltu	s0,a5,ffffffffc0201ab4 <slob_free+0x30>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201ab0:	fef76ae3          	bltu	a4,a5,ffffffffc0201aa4 <slob_free+0x20>
			break;

	if (b + b->units == cur->next)
ffffffffc0201ab4:	400c                	lw	a1,0(s0)
ffffffffc0201ab6:	00459693          	slli	a3,a1,0x4
ffffffffc0201aba:	96a2                	add	a3,a3,s0
ffffffffc0201abc:	02d78a63          	beq	a5,a3,ffffffffc0201af0 <slob_free+0x6c>
		b->next = cur->next->next;
	}
	else
		b->next = cur->next;

	if (cur + cur->units == b)
ffffffffc0201ac0:	4314                	lw	a3,0(a4)
		b->next = cur->next;
ffffffffc0201ac2:	e41c                	sd	a5,8(s0)
	if (cur + cur->units == b)
ffffffffc0201ac4:	00469793          	slli	a5,a3,0x4
ffffffffc0201ac8:	97ba                	add	a5,a5,a4
ffffffffc0201aca:	02f40e63          	beq	s0,a5,ffffffffc0201b06 <slob_free+0x82>
	{
		cur->units += b->units;
		cur->next = b->next;
	}
	else
		cur->next = b;
ffffffffc0201ace:	e700                	sd	s0,8(a4)

	slobfree = cur;
ffffffffc0201ad0:	e218                	sd	a4,0(a2)
    if (flag)
ffffffffc0201ad2:	e129                	bnez	a0,ffffffffc0201b14 <slob_free+0x90>

	spin_unlock_irqrestore(&slob_lock, flags);
}
ffffffffc0201ad4:	60a2                	ld	ra,8(sp)
ffffffffc0201ad6:	6402                	ld	s0,0(sp)
ffffffffc0201ad8:	0141                	addi	sp,sp,16
ffffffffc0201ada:	8082                	ret
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201adc:	fcf764e3          	bltu	a4,a5,ffffffffc0201aa4 <slob_free+0x20>
ffffffffc0201ae0:	fcf472e3          	bgeu	s0,a5,ffffffffc0201aa4 <slob_free+0x20>
	if (b + b->units == cur->next)
ffffffffc0201ae4:	400c                	lw	a1,0(s0)
ffffffffc0201ae6:	00459693          	slli	a3,a1,0x4
ffffffffc0201aea:	96a2                	add	a3,a3,s0
ffffffffc0201aec:	fcd79ae3          	bne	a5,a3,ffffffffc0201ac0 <slob_free+0x3c>
		b->units += cur->next->units;
ffffffffc0201af0:	4394                	lw	a3,0(a5)
		b->next = cur->next->next;
ffffffffc0201af2:	679c                	ld	a5,8(a5)
		b->units += cur->next->units;
ffffffffc0201af4:	9db5                	addw	a1,a1,a3
ffffffffc0201af6:	c00c                	sw	a1,0(s0)
	if (cur + cur->units == b)
ffffffffc0201af8:	4314                	lw	a3,0(a4)
		b->next = cur->next->next;
ffffffffc0201afa:	e41c                	sd	a5,8(s0)
	if (cur + cur->units == b)
ffffffffc0201afc:	00469793          	slli	a5,a3,0x4
ffffffffc0201b00:	97ba                	add	a5,a5,a4
ffffffffc0201b02:	fcf416e3          	bne	s0,a5,ffffffffc0201ace <slob_free+0x4a>
		cur->units += b->units;
ffffffffc0201b06:	401c                	lw	a5,0(s0)
		cur->next = b->next;
ffffffffc0201b08:	640c                	ld	a1,8(s0)
	slobfree = cur;
ffffffffc0201b0a:	e218                	sd	a4,0(a2)
		cur->units += b->units;
ffffffffc0201b0c:	9ebd                	addw	a3,a3,a5
ffffffffc0201b0e:	c314                	sw	a3,0(a4)
		cur->next = b->next;
ffffffffc0201b10:	e70c                	sd	a1,8(a4)
ffffffffc0201b12:	d169                	beqz	a0,ffffffffc0201ad4 <slob_free+0x50>
}
ffffffffc0201b14:	6402                	ld	s0,0(sp)
ffffffffc0201b16:	60a2                	ld	ra,8(sp)
ffffffffc0201b18:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc0201b1a:	e95fe06f          	j	ffffffffc02009ae <intr_enable>
		b->units = SLOB_UNITS(size);
ffffffffc0201b1e:	25bd                	addiw	a1,a1,15
ffffffffc0201b20:	8191                	srli	a1,a1,0x4
ffffffffc0201b22:	c10c                	sw	a1,0(a0)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201b24:	100027f3          	csrr	a5,sstatus
ffffffffc0201b28:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0201b2a:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201b2c:	d7bd                	beqz	a5,ffffffffc0201a9a <slob_free+0x16>
        intr_disable();
ffffffffc0201b2e:	e87fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc0201b32:	4505                	li	a0,1
ffffffffc0201b34:	b79d                	j	ffffffffc0201a9a <slob_free+0x16>
ffffffffc0201b36:	8082                	ret

ffffffffc0201b38 <__slob_get_free_pages.constprop.0>:
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201b38:	4785                	li	a5,1
static void *__slob_get_free_pages(gfp_t gfp, int order)
ffffffffc0201b3a:	1141                	addi	sp,sp,-16
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201b3c:	00a7953b          	sllw	a0,a5,a0
static void *__slob_get_free_pages(gfp_t gfp, int order)
ffffffffc0201b40:	e406                	sd	ra,8(sp)
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201b42:	352000ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
	if (!page)
ffffffffc0201b46:	c91d                	beqz	a0,ffffffffc0201b7c <__slob_get_free_pages.constprop.0+0x44>
    return page - pages + nbase;
ffffffffc0201b48:	000a9697          	auipc	a3,0xa9
ffffffffc0201b4c:	b106b683          	ld	a3,-1264(a3) # ffffffffc02aa658 <pages>
ffffffffc0201b50:	8d15                	sub	a0,a0,a3
ffffffffc0201b52:	8519                	srai	a0,a0,0x6
ffffffffc0201b54:	00006697          	auipc	a3,0x6
ffffffffc0201b58:	c946b683          	ld	a3,-876(a3) # ffffffffc02077e8 <nbase>
ffffffffc0201b5c:	9536                	add	a0,a0,a3
    return KADDR(page2pa(page));
ffffffffc0201b5e:	00c51793          	slli	a5,a0,0xc
ffffffffc0201b62:	83b1                	srli	a5,a5,0xc
ffffffffc0201b64:	000a9717          	auipc	a4,0xa9
ffffffffc0201b68:	aec73703          	ld	a4,-1300(a4) # ffffffffc02aa650 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc0201b6c:	0532                	slli	a0,a0,0xc
    return KADDR(page2pa(page));
ffffffffc0201b6e:	00e7fa63          	bgeu	a5,a4,ffffffffc0201b82 <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201b72:	000a9697          	auipc	a3,0xa9
ffffffffc0201b76:	af66b683          	ld	a3,-1290(a3) # ffffffffc02aa668 <va_pa_offset>
ffffffffc0201b7a:	9536                	add	a0,a0,a3
}
ffffffffc0201b7c:	60a2                	ld	ra,8(sp)
ffffffffc0201b7e:	0141                	addi	sp,sp,16
ffffffffc0201b80:	8082                	ret
ffffffffc0201b82:	86aa                	mv	a3,a0
ffffffffc0201b84:	00005617          	auipc	a2,0x5
ffffffffc0201b88:	9a460613          	addi	a2,a2,-1628 # ffffffffc0206528 <default_pmm_manager+0x38>
ffffffffc0201b8c:	07100593          	li	a1,113
ffffffffc0201b90:	00005517          	auipc	a0,0x5
ffffffffc0201b94:	9c050513          	addi	a0,a0,-1600 # ffffffffc0206550 <default_pmm_manager+0x60>
ffffffffc0201b98:	8f7fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201b9c <slob_alloc.constprop.0>:
static void *slob_alloc(size_t size, gfp_t gfp, int align)
ffffffffc0201b9c:	1101                	addi	sp,sp,-32
ffffffffc0201b9e:	ec06                	sd	ra,24(sp)
ffffffffc0201ba0:	e822                	sd	s0,16(sp)
ffffffffc0201ba2:	e426                	sd	s1,8(sp)
ffffffffc0201ba4:	e04a                	sd	s2,0(sp)
	assert((size + SLOB_UNIT) < PAGE_SIZE);
ffffffffc0201ba6:	01050713          	addi	a4,a0,16
ffffffffc0201baa:	6785                	lui	a5,0x1
ffffffffc0201bac:	0cf77363          	bgeu	a4,a5,ffffffffc0201c72 <slob_alloc.constprop.0+0xd6>
	int delta = 0, units = SLOB_UNITS(size);
ffffffffc0201bb0:	00f50493          	addi	s1,a0,15
ffffffffc0201bb4:	8091                	srli	s1,s1,0x4
ffffffffc0201bb6:	2481                	sext.w	s1,s1
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201bb8:	10002673          	csrr	a2,sstatus
ffffffffc0201bbc:	8a09                	andi	a2,a2,2
ffffffffc0201bbe:	e25d                	bnez	a2,ffffffffc0201c64 <slob_alloc.constprop.0+0xc8>
	prev = slobfree;
ffffffffc0201bc0:	000a4917          	auipc	s2,0xa4
ffffffffc0201bc4:	61890913          	addi	s2,s2,1560 # ffffffffc02a61d8 <slobfree>
ffffffffc0201bc8:	00093683          	ld	a3,0(s2)
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201bcc:	669c                	ld	a5,8(a3)
		if (cur->units >= units + delta)
ffffffffc0201bce:	4398                	lw	a4,0(a5)
ffffffffc0201bd0:	08975e63          	bge	a4,s1,ffffffffc0201c6c <slob_alloc.constprop.0+0xd0>
		if (cur == slobfree)
ffffffffc0201bd4:	00f68b63          	beq	a3,a5,ffffffffc0201bea <slob_alloc.constprop.0+0x4e>
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201bd8:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta)
ffffffffc0201bda:	4018                	lw	a4,0(s0)
ffffffffc0201bdc:	02975a63          	bge	a4,s1,ffffffffc0201c10 <slob_alloc.constprop.0+0x74>
		if (cur == slobfree)
ffffffffc0201be0:	00093683          	ld	a3,0(s2)
ffffffffc0201be4:	87a2                	mv	a5,s0
ffffffffc0201be6:	fef699e3          	bne	a3,a5,ffffffffc0201bd8 <slob_alloc.constprop.0+0x3c>
    if (flag)
ffffffffc0201bea:	ee31                	bnez	a2,ffffffffc0201c46 <slob_alloc.constprop.0+0xaa>
			cur = (slob_t *)__slob_get_free_page(gfp);
ffffffffc0201bec:	4501                	li	a0,0
ffffffffc0201bee:	f4bff0ef          	jal	ra,ffffffffc0201b38 <__slob_get_free_pages.constprop.0>
ffffffffc0201bf2:	842a                	mv	s0,a0
			if (!cur)
ffffffffc0201bf4:	cd05                	beqz	a0,ffffffffc0201c2c <slob_alloc.constprop.0+0x90>
			slob_free(cur, PAGE_SIZE);
ffffffffc0201bf6:	6585                	lui	a1,0x1
ffffffffc0201bf8:	e8dff0ef          	jal	ra,ffffffffc0201a84 <slob_free>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201bfc:	10002673          	csrr	a2,sstatus
ffffffffc0201c00:	8a09                	andi	a2,a2,2
ffffffffc0201c02:	ee05                	bnez	a2,ffffffffc0201c3a <slob_alloc.constprop.0+0x9e>
			cur = slobfree;
ffffffffc0201c04:	00093783          	ld	a5,0(s2)
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201c08:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta)
ffffffffc0201c0a:	4018                	lw	a4,0(s0)
ffffffffc0201c0c:	fc974ae3          	blt	a4,s1,ffffffffc0201be0 <slob_alloc.constprop.0+0x44>
			if (cur->units == units)	/* exact fit? */
ffffffffc0201c10:	04e48763          	beq	s1,a4,ffffffffc0201c5e <slob_alloc.constprop.0+0xc2>
				prev->next = cur + units;
ffffffffc0201c14:	00449693          	slli	a3,s1,0x4
ffffffffc0201c18:	96a2                	add	a3,a3,s0
ffffffffc0201c1a:	e794                	sd	a3,8(a5)
				prev->next->next = cur->next;
ffffffffc0201c1c:	640c                	ld	a1,8(s0)
				prev->next->units = cur->units - units;
ffffffffc0201c1e:	9f05                	subw	a4,a4,s1
ffffffffc0201c20:	c298                	sw	a4,0(a3)
				prev->next->next = cur->next;
ffffffffc0201c22:	e68c                	sd	a1,8(a3)
				cur->units = units;
ffffffffc0201c24:	c004                	sw	s1,0(s0)
			slobfree = prev;
ffffffffc0201c26:	00f93023          	sd	a5,0(s2)
    if (flag)
ffffffffc0201c2a:	e20d                	bnez	a2,ffffffffc0201c4c <slob_alloc.constprop.0+0xb0>
}
ffffffffc0201c2c:	60e2                	ld	ra,24(sp)
ffffffffc0201c2e:	8522                	mv	a0,s0
ffffffffc0201c30:	6442                	ld	s0,16(sp)
ffffffffc0201c32:	64a2                	ld	s1,8(sp)
ffffffffc0201c34:	6902                	ld	s2,0(sp)
ffffffffc0201c36:	6105                	addi	sp,sp,32
ffffffffc0201c38:	8082                	ret
        intr_disable();
ffffffffc0201c3a:	d7bfe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
			cur = slobfree;
ffffffffc0201c3e:	00093783          	ld	a5,0(s2)
        return 1;
ffffffffc0201c42:	4605                	li	a2,1
ffffffffc0201c44:	b7d1                	j	ffffffffc0201c08 <slob_alloc.constprop.0+0x6c>
        intr_enable();
ffffffffc0201c46:	d69fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0201c4a:	b74d                	j	ffffffffc0201bec <slob_alloc.constprop.0+0x50>
ffffffffc0201c4c:	d63fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
}
ffffffffc0201c50:	60e2                	ld	ra,24(sp)
ffffffffc0201c52:	8522                	mv	a0,s0
ffffffffc0201c54:	6442                	ld	s0,16(sp)
ffffffffc0201c56:	64a2                	ld	s1,8(sp)
ffffffffc0201c58:	6902                	ld	s2,0(sp)
ffffffffc0201c5a:	6105                	addi	sp,sp,32
ffffffffc0201c5c:	8082                	ret
				prev->next = cur->next; /* unlink */
ffffffffc0201c5e:	6418                	ld	a4,8(s0)
ffffffffc0201c60:	e798                	sd	a4,8(a5)
ffffffffc0201c62:	b7d1                	j	ffffffffc0201c26 <slob_alloc.constprop.0+0x8a>
        intr_disable();
ffffffffc0201c64:	d51fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc0201c68:	4605                	li	a2,1
ffffffffc0201c6a:	bf99                	j	ffffffffc0201bc0 <slob_alloc.constprop.0+0x24>
		if (cur->units >= units + delta)
ffffffffc0201c6c:	843e                	mv	s0,a5
ffffffffc0201c6e:	87b6                	mv	a5,a3
ffffffffc0201c70:	b745                	j	ffffffffc0201c10 <slob_alloc.constprop.0+0x74>
	assert((size + SLOB_UNIT) < PAGE_SIZE);
ffffffffc0201c72:	00005697          	auipc	a3,0x5
ffffffffc0201c76:	8ee68693          	addi	a3,a3,-1810 # ffffffffc0206560 <default_pmm_manager+0x70>
ffffffffc0201c7a:	00004617          	auipc	a2,0x4
ffffffffc0201c7e:	4c660613          	addi	a2,a2,1222 # ffffffffc0206140 <commands+0x828>
ffffffffc0201c82:	06300593          	li	a1,99
ffffffffc0201c86:	00005517          	auipc	a0,0x5
ffffffffc0201c8a:	8fa50513          	addi	a0,a0,-1798 # ffffffffc0206580 <default_pmm_manager+0x90>
ffffffffc0201c8e:	801fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201c92 <kmalloc_init>:
	cprintf("use SLOB allocator\n");
}

inline void
kmalloc_init(void)
{
ffffffffc0201c92:	1141                	addi	sp,sp,-16
	cprintf("use SLOB allocator\n");
ffffffffc0201c94:	00005517          	auipc	a0,0x5
ffffffffc0201c98:	90450513          	addi	a0,a0,-1788 # ffffffffc0206598 <default_pmm_manager+0xa8>
{
ffffffffc0201c9c:	e406                	sd	ra,8(sp)
	cprintf("use SLOB allocator\n");
ffffffffc0201c9e:	cf6fe0ef          	jal	ra,ffffffffc0200194 <cprintf>
	slob_init();
	cprintf("kmalloc_init() succeeded!\n");
}
ffffffffc0201ca2:	60a2                	ld	ra,8(sp)
	cprintf("kmalloc_init() succeeded!\n");
ffffffffc0201ca4:	00005517          	auipc	a0,0x5
ffffffffc0201ca8:	90c50513          	addi	a0,a0,-1780 # ffffffffc02065b0 <default_pmm_manager+0xc0>
}
ffffffffc0201cac:	0141                	addi	sp,sp,16
	cprintf("kmalloc_init() succeeded!\n");
ffffffffc0201cae:	ce6fe06f          	j	ffffffffc0200194 <cprintf>

ffffffffc0201cb2 <kallocated>:

size_t
kallocated(void)
{
	return slob_allocated();
}
ffffffffc0201cb2:	4501                	li	a0,0
ffffffffc0201cb4:	8082                	ret

ffffffffc0201cb6 <kmalloc>:
	return 0;
}

void *
kmalloc(size_t size)
{
ffffffffc0201cb6:	1101                	addi	sp,sp,-32
ffffffffc0201cb8:	e04a                	sd	s2,0(sp)
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201cba:	6905                	lui	s2,0x1
{
ffffffffc0201cbc:	e822                	sd	s0,16(sp)
ffffffffc0201cbe:	ec06                	sd	ra,24(sp)
ffffffffc0201cc0:	e426                	sd	s1,8(sp)
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201cc2:	fef90793          	addi	a5,s2,-17 # fef <_binary_obj___user_faultread_out_size-0x8bb1>
{
ffffffffc0201cc6:	842a                	mv	s0,a0
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201cc8:	04a7f963          	bgeu	a5,a0,ffffffffc0201d1a <kmalloc+0x64>
	bb = slob_alloc(sizeof(bigblock_t), gfp, 0);
ffffffffc0201ccc:	4561                	li	a0,24
ffffffffc0201cce:	ecfff0ef          	jal	ra,ffffffffc0201b9c <slob_alloc.constprop.0>
ffffffffc0201cd2:	84aa                	mv	s1,a0
	if (!bb)
ffffffffc0201cd4:	c929                	beqz	a0,ffffffffc0201d26 <kmalloc+0x70>
	bb->order = find_order(size);
ffffffffc0201cd6:	0004079b          	sext.w	a5,s0
	int order = 0;
ffffffffc0201cda:	4501                	li	a0,0
	for (; size > 4096; size >>= 1)
ffffffffc0201cdc:	00f95763          	bge	s2,a5,ffffffffc0201cea <kmalloc+0x34>
ffffffffc0201ce0:	6705                	lui	a4,0x1
ffffffffc0201ce2:	8785                	srai	a5,a5,0x1
		order++;
ffffffffc0201ce4:	2505                	addiw	a0,a0,1
	for (; size > 4096; size >>= 1)
ffffffffc0201ce6:	fef74ee3          	blt	a4,a5,ffffffffc0201ce2 <kmalloc+0x2c>
	bb->order = find_order(size);
ffffffffc0201cea:	c088                	sw	a0,0(s1)
	bb->pages = (void *)__slob_get_free_pages(gfp, bb->order);
ffffffffc0201cec:	e4dff0ef          	jal	ra,ffffffffc0201b38 <__slob_get_free_pages.constprop.0>
ffffffffc0201cf0:	e488                	sd	a0,8(s1)
ffffffffc0201cf2:	842a                	mv	s0,a0
	if (bb->pages)
ffffffffc0201cf4:	c525                	beqz	a0,ffffffffc0201d5c <kmalloc+0xa6>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201cf6:	100027f3          	csrr	a5,sstatus
ffffffffc0201cfa:	8b89                	andi	a5,a5,2
ffffffffc0201cfc:	ef8d                	bnez	a5,ffffffffc0201d36 <kmalloc+0x80>
		bb->next = bigblocks;
ffffffffc0201cfe:	000a9797          	auipc	a5,0xa9
ffffffffc0201d02:	93a78793          	addi	a5,a5,-1734 # ffffffffc02aa638 <bigblocks>
ffffffffc0201d06:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc0201d08:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc0201d0a:	e898                	sd	a4,16(s1)
	return __kmalloc(size, 0);
}
ffffffffc0201d0c:	60e2                	ld	ra,24(sp)
ffffffffc0201d0e:	8522                	mv	a0,s0
ffffffffc0201d10:	6442                	ld	s0,16(sp)
ffffffffc0201d12:	64a2                	ld	s1,8(sp)
ffffffffc0201d14:	6902                	ld	s2,0(sp)
ffffffffc0201d16:	6105                	addi	sp,sp,32
ffffffffc0201d18:	8082                	ret
		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
ffffffffc0201d1a:	0541                	addi	a0,a0,16
ffffffffc0201d1c:	e81ff0ef          	jal	ra,ffffffffc0201b9c <slob_alloc.constprop.0>
		return m ? (void *)(m + 1) : 0;
ffffffffc0201d20:	01050413          	addi	s0,a0,16
ffffffffc0201d24:	f565                	bnez	a0,ffffffffc0201d0c <kmalloc+0x56>
ffffffffc0201d26:	4401                	li	s0,0
}
ffffffffc0201d28:	60e2                	ld	ra,24(sp)
ffffffffc0201d2a:	8522                	mv	a0,s0
ffffffffc0201d2c:	6442                	ld	s0,16(sp)
ffffffffc0201d2e:	64a2                	ld	s1,8(sp)
ffffffffc0201d30:	6902                	ld	s2,0(sp)
ffffffffc0201d32:	6105                	addi	sp,sp,32
ffffffffc0201d34:	8082                	ret
        intr_disable();
ffffffffc0201d36:	c7ffe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
		bb->next = bigblocks;
ffffffffc0201d3a:	000a9797          	auipc	a5,0xa9
ffffffffc0201d3e:	8fe78793          	addi	a5,a5,-1794 # ffffffffc02aa638 <bigblocks>
ffffffffc0201d42:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc0201d44:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc0201d46:	e898                	sd	a4,16(s1)
        intr_enable();
ffffffffc0201d48:	c67fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
		return bb->pages;
ffffffffc0201d4c:	6480                	ld	s0,8(s1)
}
ffffffffc0201d4e:	60e2                	ld	ra,24(sp)
ffffffffc0201d50:	64a2                	ld	s1,8(sp)
ffffffffc0201d52:	8522                	mv	a0,s0
ffffffffc0201d54:	6442                	ld	s0,16(sp)
ffffffffc0201d56:	6902                	ld	s2,0(sp)
ffffffffc0201d58:	6105                	addi	sp,sp,32
ffffffffc0201d5a:	8082                	ret
	slob_free(bb, sizeof(bigblock_t));
ffffffffc0201d5c:	45e1                	li	a1,24
ffffffffc0201d5e:	8526                	mv	a0,s1
ffffffffc0201d60:	d25ff0ef          	jal	ra,ffffffffc0201a84 <slob_free>
	return __kmalloc(size, 0);
ffffffffc0201d64:	b765                	j	ffffffffc0201d0c <kmalloc+0x56>

ffffffffc0201d66 <kfree>:
void kfree(void *block)
{
	bigblock_t *bb, **last = &bigblocks;
	unsigned long flags;

	if (!block)
ffffffffc0201d66:	c169                	beqz	a0,ffffffffc0201e28 <kfree+0xc2>
{
ffffffffc0201d68:	1101                	addi	sp,sp,-32
ffffffffc0201d6a:	e822                	sd	s0,16(sp)
ffffffffc0201d6c:	ec06                	sd	ra,24(sp)
ffffffffc0201d6e:	e426                	sd	s1,8(sp)
		return;

	if (!((unsigned long)block & (PAGE_SIZE - 1)))
ffffffffc0201d70:	03451793          	slli	a5,a0,0x34
ffffffffc0201d74:	842a                	mv	s0,a0
ffffffffc0201d76:	e3d9                	bnez	a5,ffffffffc0201dfc <kfree+0x96>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201d78:	100027f3          	csrr	a5,sstatus
ffffffffc0201d7c:	8b89                	andi	a5,a5,2
ffffffffc0201d7e:	e7d9                	bnez	a5,ffffffffc0201e0c <kfree+0xa6>
	{
		/* might be on the big block list */
		spin_lock_irqsave(&block_lock, flags);
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201d80:	000a9797          	auipc	a5,0xa9
ffffffffc0201d84:	8b87b783          	ld	a5,-1864(a5) # ffffffffc02aa638 <bigblocks>
    return 0;
ffffffffc0201d88:	4601                	li	a2,0
ffffffffc0201d8a:	cbad                	beqz	a5,ffffffffc0201dfc <kfree+0x96>
	bigblock_t *bb, **last = &bigblocks;
ffffffffc0201d8c:	000a9697          	auipc	a3,0xa9
ffffffffc0201d90:	8ac68693          	addi	a3,a3,-1876 # ffffffffc02aa638 <bigblocks>
ffffffffc0201d94:	a021                	j	ffffffffc0201d9c <kfree+0x36>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201d96:	01048693          	addi	a3,s1,16
ffffffffc0201d9a:	c3a5                	beqz	a5,ffffffffc0201dfa <kfree+0x94>
		{
			if (bb->pages == block)
ffffffffc0201d9c:	6798                	ld	a4,8(a5)
ffffffffc0201d9e:	84be                	mv	s1,a5
			{
				*last = bb->next;
ffffffffc0201da0:	6b9c                	ld	a5,16(a5)
			if (bb->pages == block)
ffffffffc0201da2:	fe871ae3          	bne	a4,s0,ffffffffc0201d96 <kfree+0x30>
				*last = bb->next;
ffffffffc0201da6:	e29c                	sd	a5,0(a3)
    if (flag)
ffffffffc0201da8:	ee2d                	bnez	a2,ffffffffc0201e22 <kfree+0xbc>
    return pa2page(PADDR(kva));
ffffffffc0201daa:	c02007b7          	lui	a5,0xc0200
				spin_unlock_irqrestore(&block_lock, flags);
				__slob_free_pages((unsigned long)block, bb->order);
ffffffffc0201dae:	4098                	lw	a4,0(s1)
ffffffffc0201db0:	08f46963          	bltu	s0,a5,ffffffffc0201e42 <kfree+0xdc>
ffffffffc0201db4:	000a9697          	auipc	a3,0xa9
ffffffffc0201db8:	8b46b683          	ld	a3,-1868(a3) # ffffffffc02aa668 <va_pa_offset>
ffffffffc0201dbc:	8c15                	sub	s0,s0,a3
    if (PPN(pa) >= npage)
ffffffffc0201dbe:	8031                	srli	s0,s0,0xc
ffffffffc0201dc0:	000a9797          	auipc	a5,0xa9
ffffffffc0201dc4:	8907b783          	ld	a5,-1904(a5) # ffffffffc02aa650 <npage>
ffffffffc0201dc8:	06f47163          	bgeu	s0,a5,ffffffffc0201e2a <kfree+0xc4>
    return &pages[PPN(pa) - nbase];
ffffffffc0201dcc:	00006517          	auipc	a0,0x6
ffffffffc0201dd0:	a1c53503          	ld	a0,-1508(a0) # ffffffffc02077e8 <nbase>
ffffffffc0201dd4:	8c09                	sub	s0,s0,a0
ffffffffc0201dd6:	041a                	slli	s0,s0,0x6
	free_pages(kva2page(kva), 1 << order);
ffffffffc0201dd8:	000a9517          	auipc	a0,0xa9
ffffffffc0201ddc:	88053503          	ld	a0,-1920(a0) # ffffffffc02aa658 <pages>
ffffffffc0201de0:	4585                	li	a1,1
ffffffffc0201de2:	9522                	add	a0,a0,s0
ffffffffc0201de4:	00e595bb          	sllw	a1,a1,a4
ffffffffc0201de8:	0ea000ef          	jal	ra,ffffffffc0201ed2 <free_pages>
		spin_unlock_irqrestore(&block_lock, flags);
	}

	slob_free((slob_t *)block - 1, 0);
	return;
}
ffffffffc0201dec:	6442                	ld	s0,16(sp)
ffffffffc0201dee:	60e2                	ld	ra,24(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201df0:	8526                	mv	a0,s1
}
ffffffffc0201df2:	64a2                	ld	s1,8(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201df4:	45e1                	li	a1,24
}
ffffffffc0201df6:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201df8:	b171                	j	ffffffffc0201a84 <slob_free>
ffffffffc0201dfa:	e20d                	bnez	a2,ffffffffc0201e1c <kfree+0xb6>
ffffffffc0201dfc:	ff040513          	addi	a0,s0,-16
}
ffffffffc0201e00:	6442                	ld	s0,16(sp)
ffffffffc0201e02:	60e2                	ld	ra,24(sp)
ffffffffc0201e04:	64a2                	ld	s1,8(sp)
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201e06:	4581                	li	a1,0
}
ffffffffc0201e08:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201e0a:	b9ad                	j	ffffffffc0201a84 <slob_free>
        intr_disable();
ffffffffc0201e0c:	ba9fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201e10:	000a9797          	auipc	a5,0xa9
ffffffffc0201e14:	8287b783          	ld	a5,-2008(a5) # ffffffffc02aa638 <bigblocks>
        return 1;
ffffffffc0201e18:	4605                	li	a2,1
ffffffffc0201e1a:	fbad                	bnez	a5,ffffffffc0201d8c <kfree+0x26>
        intr_enable();
ffffffffc0201e1c:	b93fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0201e20:	bff1                	j	ffffffffc0201dfc <kfree+0x96>
ffffffffc0201e22:	b8dfe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0201e26:	b751                	j	ffffffffc0201daa <kfree+0x44>
ffffffffc0201e28:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc0201e2a:	00004617          	auipc	a2,0x4
ffffffffc0201e2e:	7ce60613          	addi	a2,a2,1998 # ffffffffc02065f8 <default_pmm_manager+0x108>
ffffffffc0201e32:	06900593          	li	a1,105
ffffffffc0201e36:	00004517          	auipc	a0,0x4
ffffffffc0201e3a:	71a50513          	addi	a0,a0,1818 # ffffffffc0206550 <default_pmm_manager+0x60>
ffffffffc0201e3e:	e50fe0ef          	jal	ra,ffffffffc020048e <__panic>
    return pa2page(PADDR(kva));
ffffffffc0201e42:	86a2                	mv	a3,s0
ffffffffc0201e44:	00004617          	auipc	a2,0x4
ffffffffc0201e48:	78c60613          	addi	a2,a2,1932 # ffffffffc02065d0 <default_pmm_manager+0xe0>
ffffffffc0201e4c:	07700593          	li	a1,119
ffffffffc0201e50:	00004517          	auipc	a0,0x4
ffffffffc0201e54:	70050513          	addi	a0,a0,1792 # ffffffffc0206550 <default_pmm_manager+0x60>
ffffffffc0201e58:	e36fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201e5c <pa2page.part.0>:
pa2page(uintptr_t pa)
ffffffffc0201e5c:	1141                	addi	sp,sp,-16
        panic("pa2page called with invalid pa");
ffffffffc0201e5e:	00004617          	auipc	a2,0x4
ffffffffc0201e62:	79a60613          	addi	a2,a2,1946 # ffffffffc02065f8 <default_pmm_manager+0x108>
ffffffffc0201e66:	06900593          	li	a1,105
ffffffffc0201e6a:	00004517          	auipc	a0,0x4
ffffffffc0201e6e:	6e650513          	addi	a0,a0,1766 # ffffffffc0206550 <default_pmm_manager+0x60>
pa2page(uintptr_t pa)
ffffffffc0201e72:	e406                	sd	ra,8(sp)
        panic("pa2page called with invalid pa");
ffffffffc0201e74:	e1afe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201e78 <pte2page.part.0>:
pte2page(pte_t pte)
ffffffffc0201e78:	1141                	addi	sp,sp,-16
        panic("pte2page called with invalid pte");
ffffffffc0201e7a:	00004617          	auipc	a2,0x4
ffffffffc0201e7e:	79e60613          	addi	a2,a2,1950 # ffffffffc0206618 <default_pmm_manager+0x128>
ffffffffc0201e82:	07f00593          	li	a1,127
ffffffffc0201e86:	00004517          	auipc	a0,0x4
ffffffffc0201e8a:	6ca50513          	addi	a0,a0,1738 # ffffffffc0206550 <default_pmm_manager+0x60>
pte2page(pte_t pte)
ffffffffc0201e8e:	e406                	sd	ra,8(sp)
        panic("pte2page called with invalid pte");
ffffffffc0201e90:	dfefe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201e94 <alloc_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201e94:	100027f3          	csrr	a5,sstatus
ffffffffc0201e98:	8b89                	andi	a5,a5,2
ffffffffc0201e9a:	e799                	bnez	a5,ffffffffc0201ea8 <alloc_pages+0x14>
{
    struct Page *page = NULL;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        page = pmm_manager->alloc_pages(n);
ffffffffc0201e9c:	000a8797          	auipc	a5,0xa8
ffffffffc0201ea0:	7c47b783          	ld	a5,1988(a5) # ffffffffc02aa660 <pmm_manager>
ffffffffc0201ea4:	6f9c                	ld	a5,24(a5)
ffffffffc0201ea6:	8782                	jr	a5
{
ffffffffc0201ea8:	1141                	addi	sp,sp,-16
ffffffffc0201eaa:	e406                	sd	ra,8(sp)
ffffffffc0201eac:	e022                	sd	s0,0(sp)
ffffffffc0201eae:	842a                	mv	s0,a0
        intr_disable();
ffffffffc0201eb0:	b05fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201eb4:	000a8797          	auipc	a5,0xa8
ffffffffc0201eb8:	7ac7b783          	ld	a5,1964(a5) # ffffffffc02aa660 <pmm_manager>
ffffffffc0201ebc:	6f9c                	ld	a5,24(a5)
ffffffffc0201ebe:	8522                	mv	a0,s0
ffffffffc0201ec0:	9782                	jalr	a5
ffffffffc0201ec2:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201ec4:	aebfe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
    }
    local_intr_restore(intr_flag);
    return page;
}
ffffffffc0201ec8:	60a2                	ld	ra,8(sp)
ffffffffc0201eca:	8522                	mv	a0,s0
ffffffffc0201ecc:	6402                	ld	s0,0(sp)
ffffffffc0201ece:	0141                	addi	sp,sp,16
ffffffffc0201ed0:	8082                	ret

ffffffffc0201ed2 <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201ed2:	100027f3          	csrr	a5,sstatus
ffffffffc0201ed6:	8b89                	andi	a5,a5,2
ffffffffc0201ed8:	e799                	bnez	a5,ffffffffc0201ee6 <free_pages+0x14>
void free_pages(struct Page *base, size_t n)
{
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc0201eda:	000a8797          	auipc	a5,0xa8
ffffffffc0201ede:	7867b783          	ld	a5,1926(a5) # ffffffffc02aa660 <pmm_manager>
ffffffffc0201ee2:	739c                	ld	a5,32(a5)
ffffffffc0201ee4:	8782                	jr	a5
{
ffffffffc0201ee6:	1101                	addi	sp,sp,-32
ffffffffc0201ee8:	ec06                	sd	ra,24(sp)
ffffffffc0201eea:	e822                	sd	s0,16(sp)
ffffffffc0201eec:	e426                	sd	s1,8(sp)
ffffffffc0201eee:	842a                	mv	s0,a0
ffffffffc0201ef0:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc0201ef2:	ac3fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0201ef6:	000a8797          	auipc	a5,0xa8
ffffffffc0201efa:	76a7b783          	ld	a5,1898(a5) # ffffffffc02aa660 <pmm_manager>
ffffffffc0201efe:	739c                	ld	a5,32(a5)
ffffffffc0201f00:	85a6                	mv	a1,s1
ffffffffc0201f02:	8522                	mv	a0,s0
ffffffffc0201f04:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc0201f06:	6442                	ld	s0,16(sp)
ffffffffc0201f08:	60e2                	ld	ra,24(sp)
ffffffffc0201f0a:	64a2                	ld	s1,8(sp)
ffffffffc0201f0c:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0201f0e:	aa1fe06f          	j	ffffffffc02009ae <intr_enable>

ffffffffc0201f12 <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201f12:	100027f3          	csrr	a5,sstatus
ffffffffc0201f16:	8b89                	andi	a5,a5,2
ffffffffc0201f18:	e799                	bnez	a5,ffffffffc0201f26 <nr_free_pages+0x14>
{
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc0201f1a:	000a8797          	auipc	a5,0xa8
ffffffffc0201f1e:	7467b783          	ld	a5,1862(a5) # ffffffffc02aa660 <pmm_manager>
ffffffffc0201f22:	779c                	ld	a5,40(a5)
ffffffffc0201f24:	8782                	jr	a5
{
ffffffffc0201f26:	1141                	addi	sp,sp,-16
ffffffffc0201f28:	e406                	sd	ra,8(sp)
ffffffffc0201f2a:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc0201f2c:	a89fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0201f30:	000a8797          	auipc	a5,0xa8
ffffffffc0201f34:	7307b783          	ld	a5,1840(a5) # ffffffffc02aa660 <pmm_manager>
ffffffffc0201f38:	779c                	ld	a5,40(a5)
ffffffffc0201f3a:	9782                	jalr	a5
ffffffffc0201f3c:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201f3e:	a71fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc0201f42:	60a2                	ld	ra,8(sp)
ffffffffc0201f44:	8522                	mv	a0,s0
ffffffffc0201f46:	6402                	ld	s0,0(sp)
ffffffffc0201f48:	0141                	addi	sp,sp,16
ffffffffc0201f4a:	8082                	ret

ffffffffc0201f4c <get_pte>:
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create)
{
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201f4c:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0201f50:	1ff7f793          	andi	a5,a5,511
{
ffffffffc0201f54:	7139                	addi	sp,sp,-64
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201f56:	078e                	slli	a5,a5,0x3
{
ffffffffc0201f58:	f426                	sd	s1,40(sp)
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201f5a:	00f504b3          	add	s1,a0,a5
    if (!(*pdep1 & PTE_V))
ffffffffc0201f5e:	6094                	ld	a3,0(s1)
{
ffffffffc0201f60:	f04a                	sd	s2,32(sp)
ffffffffc0201f62:	ec4e                	sd	s3,24(sp)
ffffffffc0201f64:	e852                	sd	s4,16(sp)
ffffffffc0201f66:	fc06                	sd	ra,56(sp)
ffffffffc0201f68:	f822                	sd	s0,48(sp)
ffffffffc0201f6a:	e456                	sd	s5,8(sp)
ffffffffc0201f6c:	e05a                	sd	s6,0(sp)
    if (!(*pdep1 & PTE_V))
ffffffffc0201f6e:	0016f793          	andi	a5,a3,1
{
ffffffffc0201f72:	892e                	mv	s2,a1
ffffffffc0201f74:	8a32                	mv	s4,a2
ffffffffc0201f76:	000a8997          	auipc	s3,0xa8
ffffffffc0201f7a:	6da98993          	addi	s3,s3,1754 # ffffffffc02aa650 <npage>
    if (!(*pdep1 & PTE_V))
ffffffffc0201f7e:	efbd                	bnez	a5,ffffffffc0201ffc <get_pte+0xb0>
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201f80:	14060c63          	beqz	a2,ffffffffc02020d8 <get_pte+0x18c>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201f84:	100027f3          	csrr	a5,sstatus
ffffffffc0201f88:	8b89                	andi	a5,a5,2
ffffffffc0201f8a:	14079963          	bnez	a5,ffffffffc02020dc <get_pte+0x190>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201f8e:	000a8797          	auipc	a5,0xa8
ffffffffc0201f92:	6d27b783          	ld	a5,1746(a5) # ffffffffc02aa660 <pmm_manager>
ffffffffc0201f96:	6f9c                	ld	a5,24(a5)
ffffffffc0201f98:	4505                	li	a0,1
ffffffffc0201f9a:	9782                	jalr	a5
ffffffffc0201f9c:	842a                	mv	s0,a0
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201f9e:	12040d63          	beqz	s0,ffffffffc02020d8 <get_pte+0x18c>
    return page - pages + nbase;
ffffffffc0201fa2:	000a8b17          	auipc	s6,0xa8
ffffffffc0201fa6:	6b6b0b13          	addi	s6,s6,1718 # ffffffffc02aa658 <pages>
ffffffffc0201faa:	000b3503          	ld	a0,0(s6)
ffffffffc0201fae:	00080ab7          	lui	s5,0x80
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0201fb2:	000a8997          	auipc	s3,0xa8
ffffffffc0201fb6:	69e98993          	addi	s3,s3,1694 # ffffffffc02aa650 <npage>
ffffffffc0201fba:	40a40533          	sub	a0,s0,a0
ffffffffc0201fbe:	8519                	srai	a0,a0,0x6
ffffffffc0201fc0:	9556                	add	a0,a0,s5
ffffffffc0201fc2:	0009b703          	ld	a4,0(s3)
ffffffffc0201fc6:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0201fca:	4685                	li	a3,1
ffffffffc0201fcc:	c014                	sw	a3,0(s0)
ffffffffc0201fce:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0201fd0:	0532                	slli	a0,a0,0xc
ffffffffc0201fd2:	16e7f763          	bgeu	a5,a4,ffffffffc0202140 <get_pte+0x1f4>
ffffffffc0201fd6:	000a8797          	auipc	a5,0xa8
ffffffffc0201fda:	6927b783          	ld	a5,1682(a5) # ffffffffc02aa668 <va_pa_offset>
ffffffffc0201fde:	6605                	lui	a2,0x1
ffffffffc0201fe0:	4581                	li	a1,0
ffffffffc0201fe2:	953e                	add	a0,a0,a5
ffffffffc0201fe4:	6a0030ef          	jal	ra,ffffffffc0205684 <memset>
    return page - pages + nbase;
ffffffffc0201fe8:	000b3683          	ld	a3,0(s6)
ffffffffc0201fec:	40d406b3          	sub	a3,s0,a3
ffffffffc0201ff0:	8699                	srai	a3,a3,0x6
ffffffffc0201ff2:	96d6                	add	a3,a3,s5
}

// construct PTE from a page and permission bits
static inline pte_t pte_create(uintptr_t ppn, int type)
{
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0201ff4:	06aa                	slli	a3,a3,0xa
ffffffffc0201ff6:	0116e693          	ori	a3,a3,17
        *pdep1 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc0201ffa:	e094                	sd	a3,0(s1)
    }

    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0201ffc:	77fd                	lui	a5,0xfffff
ffffffffc0201ffe:	068a                	slli	a3,a3,0x2
ffffffffc0202000:	0009b703          	ld	a4,0(s3)
ffffffffc0202004:	8efd                	and	a3,a3,a5
ffffffffc0202006:	00c6d793          	srli	a5,a3,0xc
ffffffffc020200a:	10e7ff63          	bgeu	a5,a4,ffffffffc0202128 <get_pte+0x1dc>
ffffffffc020200e:	000a8a97          	auipc	s5,0xa8
ffffffffc0202012:	65aa8a93          	addi	s5,s5,1626 # ffffffffc02aa668 <va_pa_offset>
ffffffffc0202016:	000ab403          	ld	s0,0(s5)
ffffffffc020201a:	01595793          	srli	a5,s2,0x15
ffffffffc020201e:	1ff7f793          	andi	a5,a5,511
ffffffffc0202022:	96a2                	add	a3,a3,s0
ffffffffc0202024:	00379413          	slli	s0,a5,0x3
ffffffffc0202028:	9436                	add	s0,s0,a3
    if (!(*pdep0 & PTE_V))
ffffffffc020202a:	6014                	ld	a3,0(s0)
ffffffffc020202c:	0016f793          	andi	a5,a3,1
ffffffffc0202030:	ebad                	bnez	a5,ffffffffc02020a2 <get_pte+0x156>
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0202032:	0a0a0363          	beqz	s4,ffffffffc02020d8 <get_pte+0x18c>
ffffffffc0202036:	100027f3          	csrr	a5,sstatus
ffffffffc020203a:	8b89                	andi	a5,a5,2
ffffffffc020203c:	efcd                	bnez	a5,ffffffffc02020f6 <get_pte+0x1aa>
        page = pmm_manager->alloc_pages(n);
ffffffffc020203e:	000a8797          	auipc	a5,0xa8
ffffffffc0202042:	6227b783          	ld	a5,1570(a5) # ffffffffc02aa660 <pmm_manager>
ffffffffc0202046:	6f9c                	ld	a5,24(a5)
ffffffffc0202048:	4505                	li	a0,1
ffffffffc020204a:	9782                	jalr	a5
ffffffffc020204c:	84aa                	mv	s1,a0
        if (!create || (page = alloc_page()) == NULL)
ffffffffc020204e:	c4c9                	beqz	s1,ffffffffc02020d8 <get_pte+0x18c>
    return page - pages + nbase;
ffffffffc0202050:	000a8b17          	auipc	s6,0xa8
ffffffffc0202054:	608b0b13          	addi	s6,s6,1544 # ffffffffc02aa658 <pages>
ffffffffc0202058:	000b3503          	ld	a0,0(s6)
ffffffffc020205c:	00080a37          	lui	s4,0x80
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202060:	0009b703          	ld	a4,0(s3)
ffffffffc0202064:	40a48533          	sub	a0,s1,a0
ffffffffc0202068:	8519                	srai	a0,a0,0x6
ffffffffc020206a:	9552                	add	a0,a0,s4
ffffffffc020206c:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0202070:	4685                	li	a3,1
ffffffffc0202072:	c094                	sw	a3,0(s1)
ffffffffc0202074:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0202076:	0532                	slli	a0,a0,0xc
ffffffffc0202078:	0ee7f163          	bgeu	a5,a4,ffffffffc020215a <get_pte+0x20e>
ffffffffc020207c:	000ab783          	ld	a5,0(s5)
ffffffffc0202080:	6605                	lui	a2,0x1
ffffffffc0202082:	4581                	li	a1,0
ffffffffc0202084:	953e                	add	a0,a0,a5
ffffffffc0202086:	5fe030ef          	jal	ra,ffffffffc0205684 <memset>
    return page - pages + nbase;
ffffffffc020208a:	000b3683          	ld	a3,0(s6)
ffffffffc020208e:	40d486b3          	sub	a3,s1,a3
ffffffffc0202092:	8699                	srai	a3,a3,0x6
ffffffffc0202094:	96d2                	add	a3,a3,s4
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0202096:	06aa                	slli	a3,a3,0xa
ffffffffc0202098:	0116e693          	ori	a3,a3,17
        *pdep0 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc020209c:	e014                	sd	a3,0(s0)
    }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc020209e:	0009b703          	ld	a4,0(s3)
ffffffffc02020a2:	068a                	slli	a3,a3,0x2
ffffffffc02020a4:	757d                	lui	a0,0xfffff
ffffffffc02020a6:	8ee9                	and	a3,a3,a0
ffffffffc02020a8:	00c6d793          	srli	a5,a3,0xc
ffffffffc02020ac:	06e7f263          	bgeu	a5,a4,ffffffffc0202110 <get_pte+0x1c4>
ffffffffc02020b0:	000ab503          	ld	a0,0(s5)
ffffffffc02020b4:	00c95913          	srli	s2,s2,0xc
ffffffffc02020b8:	1ff97913          	andi	s2,s2,511
ffffffffc02020bc:	96aa                	add	a3,a3,a0
ffffffffc02020be:	00391513          	slli	a0,s2,0x3
ffffffffc02020c2:	9536                	add	a0,a0,a3
}
ffffffffc02020c4:	70e2                	ld	ra,56(sp)
ffffffffc02020c6:	7442                	ld	s0,48(sp)
ffffffffc02020c8:	74a2                	ld	s1,40(sp)
ffffffffc02020ca:	7902                	ld	s2,32(sp)
ffffffffc02020cc:	69e2                	ld	s3,24(sp)
ffffffffc02020ce:	6a42                	ld	s4,16(sp)
ffffffffc02020d0:	6aa2                	ld	s5,8(sp)
ffffffffc02020d2:	6b02                	ld	s6,0(sp)
ffffffffc02020d4:	6121                	addi	sp,sp,64
ffffffffc02020d6:	8082                	ret
            return NULL;
ffffffffc02020d8:	4501                	li	a0,0
ffffffffc02020da:	b7ed                	j	ffffffffc02020c4 <get_pte+0x178>
        intr_disable();
ffffffffc02020dc:	8d9fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc02020e0:	000a8797          	auipc	a5,0xa8
ffffffffc02020e4:	5807b783          	ld	a5,1408(a5) # ffffffffc02aa660 <pmm_manager>
ffffffffc02020e8:	6f9c                	ld	a5,24(a5)
ffffffffc02020ea:	4505                	li	a0,1
ffffffffc02020ec:	9782                	jalr	a5
ffffffffc02020ee:	842a                	mv	s0,a0
        intr_enable();
ffffffffc02020f0:	8bffe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc02020f4:	b56d                	j	ffffffffc0201f9e <get_pte+0x52>
        intr_disable();
ffffffffc02020f6:	8bffe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc02020fa:	000a8797          	auipc	a5,0xa8
ffffffffc02020fe:	5667b783          	ld	a5,1382(a5) # ffffffffc02aa660 <pmm_manager>
ffffffffc0202102:	6f9c                	ld	a5,24(a5)
ffffffffc0202104:	4505                	li	a0,1
ffffffffc0202106:	9782                	jalr	a5
ffffffffc0202108:	84aa                	mv	s1,a0
        intr_enable();
ffffffffc020210a:	8a5fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020210e:	b781                	j	ffffffffc020204e <get_pte+0x102>
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc0202110:	00004617          	auipc	a2,0x4
ffffffffc0202114:	41860613          	addi	a2,a2,1048 # ffffffffc0206528 <default_pmm_manager+0x38>
ffffffffc0202118:	0fa00593          	li	a1,250
ffffffffc020211c:	00004517          	auipc	a0,0x4
ffffffffc0202120:	52450513          	addi	a0,a0,1316 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202124:	b6afe0ef          	jal	ra,ffffffffc020048e <__panic>
    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0202128:	00004617          	auipc	a2,0x4
ffffffffc020212c:	40060613          	addi	a2,a2,1024 # ffffffffc0206528 <default_pmm_manager+0x38>
ffffffffc0202130:	0ed00593          	li	a1,237
ffffffffc0202134:	00004517          	auipc	a0,0x4
ffffffffc0202138:	50c50513          	addi	a0,a0,1292 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc020213c:	b52fe0ef          	jal	ra,ffffffffc020048e <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202140:	86aa                	mv	a3,a0
ffffffffc0202142:	00004617          	auipc	a2,0x4
ffffffffc0202146:	3e660613          	addi	a2,a2,998 # ffffffffc0206528 <default_pmm_manager+0x38>
ffffffffc020214a:	0e900593          	li	a1,233
ffffffffc020214e:	00004517          	auipc	a0,0x4
ffffffffc0202152:	4f250513          	addi	a0,a0,1266 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202156:	b38fe0ef          	jal	ra,ffffffffc020048e <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc020215a:	86aa                	mv	a3,a0
ffffffffc020215c:	00004617          	auipc	a2,0x4
ffffffffc0202160:	3cc60613          	addi	a2,a2,972 # ffffffffc0206528 <default_pmm_manager+0x38>
ffffffffc0202164:	0f700593          	li	a1,247
ffffffffc0202168:	00004517          	auipc	a0,0x4
ffffffffc020216c:	4d850513          	addi	a0,a0,1240 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202170:	b1efe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0202174 <get_page>:

// get_page - get related Page struct for linear address la using PDT pgdir
struct Page *get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store)
{
ffffffffc0202174:	1141                	addi	sp,sp,-16
ffffffffc0202176:	e022                	sd	s0,0(sp)
ffffffffc0202178:	8432                	mv	s0,a2
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc020217a:	4601                	li	a2,0
{
ffffffffc020217c:	e406                	sd	ra,8(sp)
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc020217e:	dcfff0ef          	jal	ra,ffffffffc0201f4c <get_pte>
    if (ptep_store != NULL)
ffffffffc0202182:	c011                	beqz	s0,ffffffffc0202186 <get_page+0x12>
    {
        *ptep_store = ptep;
ffffffffc0202184:	e008                	sd	a0,0(s0)
    }
    if (ptep != NULL && *ptep & PTE_V)
ffffffffc0202186:	c511                	beqz	a0,ffffffffc0202192 <get_page+0x1e>
ffffffffc0202188:	611c                	ld	a5,0(a0)
    {
        return pte2page(*ptep);
    }
    return NULL;
ffffffffc020218a:	4501                	li	a0,0
    if (ptep != NULL && *ptep & PTE_V)
ffffffffc020218c:	0017f713          	andi	a4,a5,1
ffffffffc0202190:	e709                	bnez	a4,ffffffffc020219a <get_page+0x26>
}
ffffffffc0202192:	60a2                	ld	ra,8(sp)
ffffffffc0202194:	6402                	ld	s0,0(sp)
ffffffffc0202196:	0141                	addi	sp,sp,16
ffffffffc0202198:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc020219a:	078a                	slli	a5,a5,0x2
ffffffffc020219c:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc020219e:	000a8717          	auipc	a4,0xa8
ffffffffc02021a2:	4b273703          	ld	a4,1202(a4) # ffffffffc02aa650 <npage>
ffffffffc02021a6:	00e7ff63          	bgeu	a5,a4,ffffffffc02021c4 <get_page+0x50>
ffffffffc02021aa:	60a2                	ld	ra,8(sp)
ffffffffc02021ac:	6402                	ld	s0,0(sp)
    return &pages[PPN(pa) - nbase];
ffffffffc02021ae:	fff80537          	lui	a0,0xfff80
ffffffffc02021b2:	97aa                	add	a5,a5,a0
ffffffffc02021b4:	079a                	slli	a5,a5,0x6
ffffffffc02021b6:	000a8517          	auipc	a0,0xa8
ffffffffc02021ba:	4a253503          	ld	a0,1186(a0) # ffffffffc02aa658 <pages>
ffffffffc02021be:	953e                	add	a0,a0,a5
ffffffffc02021c0:	0141                	addi	sp,sp,16
ffffffffc02021c2:	8082                	ret
ffffffffc02021c4:	c99ff0ef          	jal	ra,ffffffffc0201e5c <pa2page.part.0>

ffffffffc02021c8 <unmap_range>:
        tlb_invalidate(pgdir, la);
    }
}

void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end)
{
ffffffffc02021c8:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02021ca:	00c5e7b3          	or	a5,a1,a2
{
ffffffffc02021ce:	f486                	sd	ra,104(sp)
ffffffffc02021d0:	f0a2                	sd	s0,96(sp)
ffffffffc02021d2:	eca6                	sd	s1,88(sp)
ffffffffc02021d4:	e8ca                	sd	s2,80(sp)
ffffffffc02021d6:	e4ce                	sd	s3,72(sp)
ffffffffc02021d8:	e0d2                	sd	s4,64(sp)
ffffffffc02021da:	fc56                	sd	s5,56(sp)
ffffffffc02021dc:	f85a                	sd	s6,48(sp)
ffffffffc02021de:	f45e                	sd	s7,40(sp)
ffffffffc02021e0:	f062                	sd	s8,32(sp)
ffffffffc02021e2:	ec66                	sd	s9,24(sp)
ffffffffc02021e4:	e86a                	sd	s10,16(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02021e6:	17d2                	slli	a5,a5,0x34
ffffffffc02021e8:	e3ed                	bnez	a5,ffffffffc02022ca <unmap_range+0x102>
    assert(USER_ACCESS(start, end));
ffffffffc02021ea:	002007b7          	lui	a5,0x200
ffffffffc02021ee:	842e                	mv	s0,a1
ffffffffc02021f0:	0ef5ed63          	bltu	a1,a5,ffffffffc02022ea <unmap_range+0x122>
ffffffffc02021f4:	8932                	mv	s2,a2
ffffffffc02021f6:	0ec5fa63          	bgeu	a1,a2,ffffffffc02022ea <unmap_range+0x122>
ffffffffc02021fa:	4785                	li	a5,1
ffffffffc02021fc:	07fe                	slli	a5,a5,0x1f
ffffffffc02021fe:	0ec7e663          	bltu	a5,a2,ffffffffc02022ea <unmap_range+0x122>
ffffffffc0202202:	89aa                	mv	s3,a0
        }
        if (*ptep != 0)
        {
            page_remove_pte(pgdir, start, ptep);
        }
        start += PGSIZE;
ffffffffc0202204:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage)
ffffffffc0202206:	000a8c97          	auipc	s9,0xa8
ffffffffc020220a:	44ac8c93          	addi	s9,s9,1098 # ffffffffc02aa650 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc020220e:	000a8c17          	auipc	s8,0xa8
ffffffffc0202212:	44ac0c13          	addi	s8,s8,1098 # ffffffffc02aa658 <pages>
ffffffffc0202216:	fff80bb7          	lui	s7,0xfff80
        pmm_manager->free_pages(base, n);
ffffffffc020221a:	000a8d17          	auipc	s10,0xa8
ffffffffc020221e:	446d0d13          	addi	s10,s10,1094 # ffffffffc02aa660 <pmm_manager>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0202222:	00200b37          	lui	s6,0x200
ffffffffc0202226:	ffe00ab7          	lui	s5,0xffe00
        pte_t *ptep = get_pte(pgdir, start, 0);
ffffffffc020222a:	4601                	li	a2,0
ffffffffc020222c:	85a2                	mv	a1,s0
ffffffffc020222e:	854e                	mv	a0,s3
ffffffffc0202230:	d1dff0ef          	jal	ra,ffffffffc0201f4c <get_pte>
ffffffffc0202234:	84aa                	mv	s1,a0
        if (ptep == NULL)
ffffffffc0202236:	cd29                	beqz	a0,ffffffffc0202290 <unmap_range+0xc8>
        if (*ptep != 0)
ffffffffc0202238:	611c                	ld	a5,0(a0)
ffffffffc020223a:	e395                	bnez	a5,ffffffffc020225e <unmap_range+0x96>
        start += PGSIZE;
ffffffffc020223c:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc020223e:	ff2466e3          	bltu	s0,s2,ffffffffc020222a <unmap_range+0x62>
}
ffffffffc0202242:	70a6                	ld	ra,104(sp)
ffffffffc0202244:	7406                	ld	s0,96(sp)
ffffffffc0202246:	64e6                	ld	s1,88(sp)
ffffffffc0202248:	6946                	ld	s2,80(sp)
ffffffffc020224a:	69a6                	ld	s3,72(sp)
ffffffffc020224c:	6a06                	ld	s4,64(sp)
ffffffffc020224e:	7ae2                	ld	s5,56(sp)
ffffffffc0202250:	7b42                	ld	s6,48(sp)
ffffffffc0202252:	7ba2                	ld	s7,40(sp)
ffffffffc0202254:	7c02                	ld	s8,32(sp)
ffffffffc0202256:	6ce2                	ld	s9,24(sp)
ffffffffc0202258:	6d42                	ld	s10,16(sp)
ffffffffc020225a:	6165                	addi	sp,sp,112
ffffffffc020225c:	8082                	ret
    if (*ptep & PTE_V)
ffffffffc020225e:	0017f713          	andi	a4,a5,1
ffffffffc0202262:	df69                	beqz	a4,ffffffffc020223c <unmap_range+0x74>
    if (PPN(pa) >= npage)
ffffffffc0202264:	000cb703          	ld	a4,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc0202268:	078a                	slli	a5,a5,0x2
ffffffffc020226a:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc020226c:	08e7ff63          	bgeu	a5,a4,ffffffffc020230a <unmap_range+0x142>
    return &pages[PPN(pa) - nbase];
ffffffffc0202270:	000c3503          	ld	a0,0(s8)
ffffffffc0202274:	97de                	add	a5,a5,s7
ffffffffc0202276:	079a                	slli	a5,a5,0x6
ffffffffc0202278:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc020227a:	411c                	lw	a5,0(a0)
ffffffffc020227c:	fff7871b          	addiw	a4,a5,-1
ffffffffc0202280:	c118                	sw	a4,0(a0)
        if (page_ref(page) == 0)
ffffffffc0202282:	cf11                	beqz	a4,ffffffffc020229e <unmap_range+0xd6>
        *ptep = 0;
ffffffffc0202284:	0004b023          	sd	zero,0(s1)

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void tlb_invalidate(pde_t *pgdir, uintptr_t la)
{
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202288:	12040073          	sfence.vma	s0
        start += PGSIZE;
ffffffffc020228c:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc020228e:	bf45                	j	ffffffffc020223e <unmap_range+0x76>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0202290:	945a                	add	s0,s0,s6
ffffffffc0202292:	01547433          	and	s0,s0,s5
    } while (start != 0 && start < end);
ffffffffc0202296:	d455                	beqz	s0,ffffffffc0202242 <unmap_range+0x7a>
ffffffffc0202298:	f92469e3          	bltu	s0,s2,ffffffffc020222a <unmap_range+0x62>
ffffffffc020229c:	b75d                	j	ffffffffc0202242 <unmap_range+0x7a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020229e:	100027f3          	csrr	a5,sstatus
ffffffffc02022a2:	8b89                	andi	a5,a5,2
ffffffffc02022a4:	e799                	bnez	a5,ffffffffc02022b2 <unmap_range+0xea>
        pmm_manager->free_pages(base, n);
ffffffffc02022a6:	000d3783          	ld	a5,0(s10)
ffffffffc02022aa:	4585                	li	a1,1
ffffffffc02022ac:	739c                	ld	a5,32(a5)
ffffffffc02022ae:	9782                	jalr	a5
    if (flag)
ffffffffc02022b0:	bfd1                	j	ffffffffc0202284 <unmap_range+0xbc>
ffffffffc02022b2:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02022b4:	f00fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc02022b8:	000d3783          	ld	a5,0(s10)
ffffffffc02022bc:	6522                	ld	a0,8(sp)
ffffffffc02022be:	4585                	li	a1,1
ffffffffc02022c0:	739c                	ld	a5,32(a5)
ffffffffc02022c2:	9782                	jalr	a5
        intr_enable();
ffffffffc02022c4:	eeafe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc02022c8:	bf75                	j	ffffffffc0202284 <unmap_range+0xbc>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02022ca:	00004697          	auipc	a3,0x4
ffffffffc02022ce:	38668693          	addi	a3,a3,902 # ffffffffc0206650 <default_pmm_manager+0x160>
ffffffffc02022d2:	00004617          	auipc	a2,0x4
ffffffffc02022d6:	e6e60613          	addi	a2,a2,-402 # ffffffffc0206140 <commands+0x828>
ffffffffc02022da:	12000593          	li	a1,288
ffffffffc02022de:	00004517          	auipc	a0,0x4
ffffffffc02022e2:	36250513          	addi	a0,a0,866 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc02022e6:	9a8fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc02022ea:	00004697          	auipc	a3,0x4
ffffffffc02022ee:	39668693          	addi	a3,a3,918 # ffffffffc0206680 <default_pmm_manager+0x190>
ffffffffc02022f2:	00004617          	auipc	a2,0x4
ffffffffc02022f6:	e4e60613          	addi	a2,a2,-434 # ffffffffc0206140 <commands+0x828>
ffffffffc02022fa:	12100593          	li	a1,289
ffffffffc02022fe:	00004517          	auipc	a0,0x4
ffffffffc0202302:	34250513          	addi	a0,a0,834 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202306:	988fe0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc020230a:	b53ff0ef          	jal	ra,ffffffffc0201e5c <pa2page.part.0>

ffffffffc020230e <exit_range>:
{
ffffffffc020230e:	7119                	addi	sp,sp,-128
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202310:	00c5e7b3          	or	a5,a1,a2
{
ffffffffc0202314:	fc86                	sd	ra,120(sp)
ffffffffc0202316:	f8a2                	sd	s0,112(sp)
ffffffffc0202318:	f4a6                	sd	s1,104(sp)
ffffffffc020231a:	f0ca                	sd	s2,96(sp)
ffffffffc020231c:	ecce                	sd	s3,88(sp)
ffffffffc020231e:	e8d2                	sd	s4,80(sp)
ffffffffc0202320:	e4d6                	sd	s5,72(sp)
ffffffffc0202322:	e0da                	sd	s6,64(sp)
ffffffffc0202324:	fc5e                	sd	s7,56(sp)
ffffffffc0202326:	f862                	sd	s8,48(sp)
ffffffffc0202328:	f466                	sd	s9,40(sp)
ffffffffc020232a:	f06a                	sd	s10,32(sp)
ffffffffc020232c:	ec6e                	sd	s11,24(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020232e:	17d2                	slli	a5,a5,0x34
ffffffffc0202330:	20079a63          	bnez	a5,ffffffffc0202544 <exit_range+0x236>
    assert(USER_ACCESS(start, end));
ffffffffc0202334:	002007b7          	lui	a5,0x200
ffffffffc0202338:	24f5e463          	bltu	a1,a5,ffffffffc0202580 <exit_range+0x272>
ffffffffc020233c:	8ab2                	mv	s5,a2
ffffffffc020233e:	24c5f163          	bgeu	a1,a2,ffffffffc0202580 <exit_range+0x272>
ffffffffc0202342:	4785                	li	a5,1
ffffffffc0202344:	07fe                	slli	a5,a5,0x1f
ffffffffc0202346:	22c7ed63          	bltu	a5,a2,ffffffffc0202580 <exit_range+0x272>
    d1start = ROUNDDOWN(start, PDSIZE);
ffffffffc020234a:	c00009b7          	lui	s3,0xc0000
ffffffffc020234e:	0135f9b3          	and	s3,a1,s3
    d0start = ROUNDDOWN(start, PTSIZE);
ffffffffc0202352:	ffe00937          	lui	s2,0xffe00
ffffffffc0202356:	400007b7          	lui	a5,0x40000
    return KADDR(page2pa(page));
ffffffffc020235a:	5cfd                	li	s9,-1
ffffffffc020235c:	8c2a                	mv	s8,a0
ffffffffc020235e:	0125f933          	and	s2,a1,s2
ffffffffc0202362:	99be                	add	s3,s3,a5
    if (PPN(pa) >= npage)
ffffffffc0202364:	000a8d17          	auipc	s10,0xa8
ffffffffc0202368:	2ecd0d13          	addi	s10,s10,748 # ffffffffc02aa650 <npage>
    return KADDR(page2pa(page));
ffffffffc020236c:	00ccdc93          	srli	s9,s9,0xc
    return &pages[PPN(pa) - nbase];
ffffffffc0202370:	000a8717          	auipc	a4,0xa8
ffffffffc0202374:	2e870713          	addi	a4,a4,744 # ffffffffc02aa658 <pages>
        pmm_manager->free_pages(base, n);
ffffffffc0202378:	000a8d97          	auipc	s11,0xa8
ffffffffc020237c:	2e8d8d93          	addi	s11,s11,744 # ffffffffc02aa660 <pmm_manager>
        pde1 = pgdir[PDX1(d1start)];
ffffffffc0202380:	c0000437          	lui	s0,0xc0000
ffffffffc0202384:	944e                	add	s0,s0,s3
ffffffffc0202386:	8079                	srli	s0,s0,0x1e
ffffffffc0202388:	1ff47413          	andi	s0,s0,511
ffffffffc020238c:	040e                	slli	s0,s0,0x3
ffffffffc020238e:	9462                	add	s0,s0,s8
ffffffffc0202390:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_obj___user_exit_out_size+0xffffffffbfff4ee8>
        if (pde1 & PTE_V)
ffffffffc0202394:	001a7793          	andi	a5,s4,1
ffffffffc0202398:	eb99                	bnez	a5,ffffffffc02023ae <exit_range+0xa0>
    } while (d1start != 0 && d1start < end);
ffffffffc020239a:	12098463          	beqz	s3,ffffffffc02024c2 <exit_range+0x1b4>
ffffffffc020239e:	400007b7          	lui	a5,0x40000
ffffffffc02023a2:	97ce                	add	a5,a5,s3
ffffffffc02023a4:	894e                	mv	s2,s3
ffffffffc02023a6:	1159fe63          	bgeu	s3,s5,ffffffffc02024c2 <exit_range+0x1b4>
ffffffffc02023aa:	89be                	mv	s3,a5
ffffffffc02023ac:	bfd1                	j	ffffffffc0202380 <exit_range+0x72>
    if (PPN(pa) >= npage)
ffffffffc02023ae:	000d3783          	ld	a5,0(s10)
    return pa2page(PDE_ADDR(pde));
ffffffffc02023b2:	0a0a                	slli	s4,s4,0x2
ffffffffc02023b4:	00ca5a13          	srli	s4,s4,0xc
    if (PPN(pa) >= npage)
ffffffffc02023b8:	1cfa7263          	bgeu	s4,a5,ffffffffc020257c <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc02023bc:	fff80637          	lui	a2,0xfff80
ffffffffc02023c0:	9652                	add	a2,a2,s4
    return page - pages + nbase;
ffffffffc02023c2:	000806b7          	lui	a3,0x80
ffffffffc02023c6:	96b2                	add	a3,a3,a2
    return KADDR(page2pa(page));
ffffffffc02023c8:	0196f5b3          	and	a1,a3,s9
    return &pages[PPN(pa) - nbase];
ffffffffc02023cc:	061a                	slli	a2,a2,0x6
    return page2ppn(page) << PGSHIFT;
ffffffffc02023ce:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02023d0:	18f5fa63          	bgeu	a1,a5,ffffffffc0202564 <exit_range+0x256>
ffffffffc02023d4:	000a8817          	auipc	a6,0xa8
ffffffffc02023d8:	29480813          	addi	a6,a6,660 # ffffffffc02aa668 <va_pa_offset>
ffffffffc02023dc:	00083b03          	ld	s6,0(a6)
            free_pd0 = 1;
ffffffffc02023e0:	4b85                	li	s7,1
    return &pages[PPN(pa) - nbase];
ffffffffc02023e2:	fff80e37          	lui	t3,0xfff80
    return KADDR(page2pa(page));
ffffffffc02023e6:	9b36                	add	s6,s6,a3
    return page - pages + nbase;
ffffffffc02023e8:	00080337          	lui	t1,0x80
ffffffffc02023ec:	6885                	lui	a7,0x1
ffffffffc02023ee:	a819                	j	ffffffffc0202404 <exit_range+0xf6>
                    free_pd0 = 0;
ffffffffc02023f0:	4b81                	li	s7,0
                d0start += PTSIZE;
ffffffffc02023f2:	002007b7          	lui	a5,0x200
ffffffffc02023f6:	993e                	add	s2,s2,a5
            } while (d0start != 0 && d0start < d1start + PDSIZE && d0start < end);
ffffffffc02023f8:	08090c63          	beqz	s2,ffffffffc0202490 <exit_range+0x182>
ffffffffc02023fc:	09397a63          	bgeu	s2,s3,ffffffffc0202490 <exit_range+0x182>
ffffffffc0202400:	0f597063          	bgeu	s2,s5,ffffffffc02024e0 <exit_range+0x1d2>
                pde0 = pd0[PDX0(d0start)];
ffffffffc0202404:	01595493          	srli	s1,s2,0x15
ffffffffc0202408:	1ff4f493          	andi	s1,s1,511
ffffffffc020240c:	048e                	slli	s1,s1,0x3
ffffffffc020240e:	94da                	add	s1,s1,s6
ffffffffc0202410:	609c                	ld	a5,0(s1)
                if (pde0 & PTE_V)
ffffffffc0202412:	0017f693          	andi	a3,a5,1
ffffffffc0202416:	dee9                	beqz	a3,ffffffffc02023f0 <exit_range+0xe2>
    if (PPN(pa) >= npage)
ffffffffc0202418:	000d3583          	ld	a1,0(s10)
    return pa2page(PDE_ADDR(pde));
ffffffffc020241c:	078a                	slli	a5,a5,0x2
ffffffffc020241e:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202420:	14b7fe63          	bgeu	a5,a1,ffffffffc020257c <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc0202424:	97f2                	add	a5,a5,t3
    return page - pages + nbase;
ffffffffc0202426:	006786b3          	add	a3,a5,t1
    return KADDR(page2pa(page));
ffffffffc020242a:	0196feb3          	and	t4,a3,s9
    return &pages[PPN(pa) - nbase];
ffffffffc020242e:	00679513          	slli	a0,a5,0x6
    return page2ppn(page) << PGSHIFT;
ffffffffc0202432:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202434:	12bef863          	bgeu	t4,a1,ffffffffc0202564 <exit_range+0x256>
ffffffffc0202438:	00083783          	ld	a5,0(a6)
ffffffffc020243c:	96be                	add	a3,a3,a5
                    for (int i = 0; i < NPTEENTRY; i++)
ffffffffc020243e:	011685b3          	add	a1,a3,a7
                        if (pt[i] & PTE_V)
ffffffffc0202442:	629c                	ld	a5,0(a3)
ffffffffc0202444:	8b85                	andi	a5,a5,1
ffffffffc0202446:	f7d5                	bnez	a5,ffffffffc02023f2 <exit_range+0xe4>
                    for (int i = 0; i < NPTEENTRY; i++)
ffffffffc0202448:	06a1                	addi	a3,a3,8
ffffffffc020244a:	fed59ce3          	bne	a1,a3,ffffffffc0202442 <exit_range+0x134>
    return &pages[PPN(pa) - nbase];
ffffffffc020244e:	631c                	ld	a5,0(a4)
ffffffffc0202450:	953e                	add	a0,a0,a5
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202452:	100027f3          	csrr	a5,sstatus
ffffffffc0202456:	8b89                	andi	a5,a5,2
ffffffffc0202458:	e7d9                	bnez	a5,ffffffffc02024e6 <exit_range+0x1d8>
        pmm_manager->free_pages(base, n);
ffffffffc020245a:	000db783          	ld	a5,0(s11)
ffffffffc020245e:	4585                	li	a1,1
ffffffffc0202460:	e032                	sd	a2,0(sp)
ffffffffc0202462:	739c                	ld	a5,32(a5)
ffffffffc0202464:	9782                	jalr	a5
    if (flag)
ffffffffc0202466:	6602                	ld	a2,0(sp)
ffffffffc0202468:	000a8817          	auipc	a6,0xa8
ffffffffc020246c:	20080813          	addi	a6,a6,512 # ffffffffc02aa668 <va_pa_offset>
ffffffffc0202470:	fff80e37          	lui	t3,0xfff80
ffffffffc0202474:	00080337          	lui	t1,0x80
ffffffffc0202478:	6885                	lui	a7,0x1
ffffffffc020247a:	000a8717          	auipc	a4,0xa8
ffffffffc020247e:	1de70713          	addi	a4,a4,478 # ffffffffc02aa658 <pages>
                        pd0[PDX0(d0start)] = 0;
ffffffffc0202482:	0004b023          	sd	zero,0(s1)
                d0start += PTSIZE;
ffffffffc0202486:	002007b7          	lui	a5,0x200
ffffffffc020248a:	993e                	add	s2,s2,a5
            } while (d0start != 0 && d0start < d1start + PDSIZE && d0start < end);
ffffffffc020248c:	f60918e3          	bnez	s2,ffffffffc02023fc <exit_range+0xee>
            if (free_pd0)
ffffffffc0202490:	f00b85e3          	beqz	s7,ffffffffc020239a <exit_range+0x8c>
    if (PPN(pa) >= npage)
ffffffffc0202494:	000d3783          	ld	a5,0(s10)
ffffffffc0202498:	0efa7263          	bgeu	s4,a5,ffffffffc020257c <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc020249c:	6308                	ld	a0,0(a4)
ffffffffc020249e:	9532                	add	a0,a0,a2
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02024a0:	100027f3          	csrr	a5,sstatus
ffffffffc02024a4:	8b89                	andi	a5,a5,2
ffffffffc02024a6:	efad                	bnez	a5,ffffffffc0202520 <exit_range+0x212>
        pmm_manager->free_pages(base, n);
ffffffffc02024a8:	000db783          	ld	a5,0(s11)
ffffffffc02024ac:	4585                	li	a1,1
ffffffffc02024ae:	739c                	ld	a5,32(a5)
ffffffffc02024b0:	9782                	jalr	a5
ffffffffc02024b2:	000a8717          	auipc	a4,0xa8
ffffffffc02024b6:	1a670713          	addi	a4,a4,422 # ffffffffc02aa658 <pages>
                pgdir[PDX1(d1start)] = 0;
ffffffffc02024ba:	00043023          	sd	zero,0(s0)
    } while (d1start != 0 && d1start < end);
ffffffffc02024be:	ee0990e3          	bnez	s3,ffffffffc020239e <exit_range+0x90>
}
ffffffffc02024c2:	70e6                	ld	ra,120(sp)
ffffffffc02024c4:	7446                	ld	s0,112(sp)
ffffffffc02024c6:	74a6                	ld	s1,104(sp)
ffffffffc02024c8:	7906                	ld	s2,96(sp)
ffffffffc02024ca:	69e6                	ld	s3,88(sp)
ffffffffc02024cc:	6a46                	ld	s4,80(sp)
ffffffffc02024ce:	6aa6                	ld	s5,72(sp)
ffffffffc02024d0:	6b06                	ld	s6,64(sp)
ffffffffc02024d2:	7be2                	ld	s7,56(sp)
ffffffffc02024d4:	7c42                	ld	s8,48(sp)
ffffffffc02024d6:	7ca2                	ld	s9,40(sp)
ffffffffc02024d8:	7d02                	ld	s10,32(sp)
ffffffffc02024da:	6de2                	ld	s11,24(sp)
ffffffffc02024dc:	6109                	addi	sp,sp,128
ffffffffc02024de:	8082                	ret
            if (free_pd0)
ffffffffc02024e0:	ea0b8fe3          	beqz	s7,ffffffffc020239e <exit_range+0x90>
ffffffffc02024e4:	bf45                	j	ffffffffc0202494 <exit_range+0x186>
ffffffffc02024e6:	e032                	sd	a2,0(sp)
        intr_disable();
ffffffffc02024e8:	e42a                	sd	a0,8(sp)
ffffffffc02024ea:	ccafe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc02024ee:	000db783          	ld	a5,0(s11)
ffffffffc02024f2:	6522                	ld	a0,8(sp)
ffffffffc02024f4:	4585                	li	a1,1
ffffffffc02024f6:	739c                	ld	a5,32(a5)
ffffffffc02024f8:	9782                	jalr	a5
        intr_enable();
ffffffffc02024fa:	cb4fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc02024fe:	6602                	ld	a2,0(sp)
ffffffffc0202500:	000a8717          	auipc	a4,0xa8
ffffffffc0202504:	15870713          	addi	a4,a4,344 # ffffffffc02aa658 <pages>
ffffffffc0202508:	6885                	lui	a7,0x1
ffffffffc020250a:	00080337          	lui	t1,0x80
ffffffffc020250e:	fff80e37          	lui	t3,0xfff80
ffffffffc0202512:	000a8817          	auipc	a6,0xa8
ffffffffc0202516:	15680813          	addi	a6,a6,342 # ffffffffc02aa668 <va_pa_offset>
                        pd0[PDX0(d0start)] = 0;
ffffffffc020251a:	0004b023          	sd	zero,0(s1)
ffffffffc020251e:	b7a5                	j	ffffffffc0202486 <exit_range+0x178>
ffffffffc0202520:	e02a                	sd	a0,0(sp)
        intr_disable();
ffffffffc0202522:	c92fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202526:	000db783          	ld	a5,0(s11)
ffffffffc020252a:	6502                	ld	a0,0(sp)
ffffffffc020252c:	4585                	li	a1,1
ffffffffc020252e:	739c                	ld	a5,32(a5)
ffffffffc0202530:	9782                	jalr	a5
        intr_enable();
ffffffffc0202532:	c7cfe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202536:	000a8717          	auipc	a4,0xa8
ffffffffc020253a:	12270713          	addi	a4,a4,290 # ffffffffc02aa658 <pages>
                pgdir[PDX1(d1start)] = 0;
ffffffffc020253e:	00043023          	sd	zero,0(s0)
ffffffffc0202542:	bfb5                	j	ffffffffc02024be <exit_range+0x1b0>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202544:	00004697          	auipc	a3,0x4
ffffffffc0202548:	10c68693          	addi	a3,a3,268 # ffffffffc0206650 <default_pmm_manager+0x160>
ffffffffc020254c:	00004617          	auipc	a2,0x4
ffffffffc0202550:	bf460613          	addi	a2,a2,-1036 # ffffffffc0206140 <commands+0x828>
ffffffffc0202554:	13500593          	li	a1,309
ffffffffc0202558:	00004517          	auipc	a0,0x4
ffffffffc020255c:	0e850513          	addi	a0,a0,232 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202560:	f2ffd0ef          	jal	ra,ffffffffc020048e <__panic>
    return KADDR(page2pa(page));
ffffffffc0202564:	00004617          	auipc	a2,0x4
ffffffffc0202568:	fc460613          	addi	a2,a2,-60 # ffffffffc0206528 <default_pmm_manager+0x38>
ffffffffc020256c:	07100593          	li	a1,113
ffffffffc0202570:	00004517          	auipc	a0,0x4
ffffffffc0202574:	fe050513          	addi	a0,a0,-32 # ffffffffc0206550 <default_pmm_manager+0x60>
ffffffffc0202578:	f17fd0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc020257c:	8e1ff0ef          	jal	ra,ffffffffc0201e5c <pa2page.part.0>
    assert(USER_ACCESS(start, end));
ffffffffc0202580:	00004697          	auipc	a3,0x4
ffffffffc0202584:	10068693          	addi	a3,a3,256 # ffffffffc0206680 <default_pmm_manager+0x190>
ffffffffc0202588:	00004617          	auipc	a2,0x4
ffffffffc020258c:	bb860613          	addi	a2,a2,-1096 # ffffffffc0206140 <commands+0x828>
ffffffffc0202590:	13600593          	li	a1,310
ffffffffc0202594:	00004517          	auipc	a0,0x4
ffffffffc0202598:	0ac50513          	addi	a0,a0,172 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc020259c:	ef3fd0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02025a0 <page_remove>:
{
ffffffffc02025a0:	7179                	addi	sp,sp,-48
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc02025a2:	4601                	li	a2,0
{
ffffffffc02025a4:	ec26                	sd	s1,24(sp)
ffffffffc02025a6:	f406                	sd	ra,40(sp)
ffffffffc02025a8:	f022                	sd	s0,32(sp)
ffffffffc02025aa:	84ae                	mv	s1,a1
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc02025ac:	9a1ff0ef          	jal	ra,ffffffffc0201f4c <get_pte>
    if (ptep != NULL)
ffffffffc02025b0:	c511                	beqz	a0,ffffffffc02025bc <page_remove+0x1c>
    if (*ptep & PTE_V)
ffffffffc02025b2:	611c                	ld	a5,0(a0)
ffffffffc02025b4:	842a                	mv	s0,a0
ffffffffc02025b6:	0017f713          	andi	a4,a5,1
ffffffffc02025ba:	e711                	bnez	a4,ffffffffc02025c6 <page_remove+0x26>
}
ffffffffc02025bc:	70a2                	ld	ra,40(sp)
ffffffffc02025be:	7402                	ld	s0,32(sp)
ffffffffc02025c0:	64e2                	ld	s1,24(sp)
ffffffffc02025c2:	6145                	addi	sp,sp,48
ffffffffc02025c4:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02025c6:	078a                	slli	a5,a5,0x2
ffffffffc02025c8:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02025ca:	000a8717          	auipc	a4,0xa8
ffffffffc02025ce:	08673703          	ld	a4,134(a4) # ffffffffc02aa650 <npage>
ffffffffc02025d2:	06e7f363          	bgeu	a5,a4,ffffffffc0202638 <page_remove+0x98>
    return &pages[PPN(pa) - nbase];
ffffffffc02025d6:	fff80537          	lui	a0,0xfff80
ffffffffc02025da:	97aa                	add	a5,a5,a0
ffffffffc02025dc:	079a                	slli	a5,a5,0x6
ffffffffc02025de:	000a8517          	auipc	a0,0xa8
ffffffffc02025e2:	07a53503          	ld	a0,122(a0) # ffffffffc02aa658 <pages>
ffffffffc02025e6:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc02025e8:	411c                	lw	a5,0(a0)
ffffffffc02025ea:	fff7871b          	addiw	a4,a5,-1
ffffffffc02025ee:	c118                	sw	a4,0(a0)
        if (page_ref(page) == 0)
ffffffffc02025f0:	cb11                	beqz	a4,ffffffffc0202604 <page_remove+0x64>
        *ptep = 0;
ffffffffc02025f2:	00043023          	sd	zero,0(s0)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02025f6:	12048073          	sfence.vma	s1
}
ffffffffc02025fa:	70a2                	ld	ra,40(sp)
ffffffffc02025fc:	7402                	ld	s0,32(sp)
ffffffffc02025fe:	64e2                	ld	s1,24(sp)
ffffffffc0202600:	6145                	addi	sp,sp,48
ffffffffc0202602:	8082                	ret
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202604:	100027f3          	csrr	a5,sstatus
ffffffffc0202608:	8b89                	andi	a5,a5,2
ffffffffc020260a:	eb89                	bnez	a5,ffffffffc020261c <page_remove+0x7c>
        pmm_manager->free_pages(base, n);
ffffffffc020260c:	000a8797          	auipc	a5,0xa8
ffffffffc0202610:	0547b783          	ld	a5,84(a5) # ffffffffc02aa660 <pmm_manager>
ffffffffc0202614:	739c                	ld	a5,32(a5)
ffffffffc0202616:	4585                	li	a1,1
ffffffffc0202618:	9782                	jalr	a5
    if (flag)
ffffffffc020261a:	bfe1                	j	ffffffffc02025f2 <page_remove+0x52>
        intr_disable();
ffffffffc020261c:	e42a                	sd	a0,8(sp)
ffffffffc020261e:	b96fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202622:	000a8797          	auipc	a5,0xa8
ffffffffc0202626:	03e7b783          	ld	a5,62(a5) # ffffffffc02aa660 <pmm_manager>
ffffffffc020262a:	739c                	ld	a5,32(a5)
ffffffffc020262c:	6522                	ld	a0,8(sp)
ffffffffc020262e:	4585                	li	a1,1
ffffffffc0202630:	9782                	jalr	a5
        intr_enable();
ffffffffc0202632:	b7cfe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202636:	bf75                	j	ffffffffc02025f2 <page_remove+0x52>
ffffffffc0202638:	825ff0ef          	jal	ra,ffffffffc0201e5c <pa2page.part.0>

ffffffffc020263c <page_insert>:
{
ffffffffc020263c:	7139                	addi	sp,sp,-64
ffffffffc020263e:	e852                	sd	s4,16(sp)
ffffffffc0202640:	8a32                	mv	s4,a2
ffffffffc0202642:	f822                	sd	s0,48(sp)
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202644:	4605                	li	a2,1
{
ffffffffc0202646:	842e                	mv	s0,a1
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202648:	85d2                	mv	a1,s4
{
ffffffffc020264a:	f426                	sd	s1,40(sp)
ffffffffc020264c:	fc06                	sd	ra,56(sp)
ffffffffc020264e:	f04a                	sd	s2,32(sp)
ffffffffc0202650:	ec4e                	sd	s3,24(sp)
ffffffffc0202652:	e456                	sd	s5,8(sp)
ffffffffc0202654:	84b6                	mv	s1,a3
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202656:	8f7ff0ef          	jal	ra,ffffffffc0201f4c <get_pte>
    if (ptep == NULL)
ffffffffc020265a:	c961                	beqz	a0,ffffffffc020272a <page_insert+0xee>
    page->ref += 1;
ffffffffc020265c:	4014                	lw	a3,0(s0)
    if (*ptep & PTE_V)
ffffffffc020265e:	611c                	ld	a5,0(a0)
ffffffffc0202660:	89aa                	mv	s3,a0
ffffffffc0202662:	0016871b          	addiw	a4,a3,1
ffffffffc0202666:	c018                	sw	a4,0(s0)
ffffffffc0202668:	0017f713          	andi	a4,a5,1
ffffffffc020266c:	ef05                	bnez	a4,ffffffffc02026a4 <page_insert+0x68>
    return page - pages + nbase;
ffffffffc020266e:	000a8717          	auipc	a4,0xa8
ffffffffc0202672:	fea73703          	ld	a4,-22(a4) # ffffffffc02aa658 <pages>
ffffffffc0202676:	8c19                	sub	s0,s0,a4
ffffffffc0202678:	000807b7          	lui	a5,0x80
ffffffffc020267c:	8419                	srai	s0,s0,0x6
ffffffffc020267e:	943e                	add	s0,s0,a5
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0202680:	042a                	slli	s0,s0,0xa
ffffffffc0202682:	8cc1                	or	s1,s1,s0
ffffffffc0202684:	0014e493          	ori	s1,s1,1
    *ptep = pte_create(page2ppn(page), PTE_V | perm);
ffffffffc0202688:	0099b023          	sd	s1,0(s3) # ffffffffc0000000 <_binary_obj___user_exit_out_size+0xffffffffbfff4ee8>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc020268c:	120a0073          	sfence.vma	s4
    return 0;
ffffffffc0202690:	4501                	li	a0,0
}
ffffffffc0202692:	70e2                	ld	ra,56(sp)
ffffffffc0202694:	7442                	ld	s0,48(sp)
ffffffffc0202696:	74a2                	ld	s1,40(sp)
ffffffffc0202698:	7902                	ld	s2,32(sp)
ffffffffc020269a:	69e2                	ld	s3,24(sp)
ffffffffc020269c:	6a42                	ld	s4,16(sp)
ffffffffc020269e:	6aa2                	ld	s5,8(sp)
ffffffffc02026a0:	6121                	addi	sp,sp,64
ffffffffc02026a2:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02026a4:	078a                	slli	a5,a5,0x2
ffffffffc02026a6:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02026a8:	000a8717          	auipc	a4,0xa8
ffffffffc02026ac:	fa873703          	ld	a4,-88(a4) # ffffffffc02aa650 <npage>
ffffffffc02026b0:	06e7ff63          	bgeu	a5,a4,ffffffffc020272e <page_insert+0xf2>
    return &pages[PPN(pa) - nbase];
ffffffffc02026b4:	000a8a97          	auipc	s5,0xa8
ffffffffc02026b8:	fa4a8a93          	addi	s5,s5,-92 # ffffffffc02aa658 <pages>
ffffffffc02026bc:	000ab703          	ld	a4,0(s5)
ffffffffc02026c0:	fff80937          	lui	s2,0xfff80
ffffffffc02026c4:	993e                	add	s2,s2,a5
ffffffffc02026c6:	091a                	slli	s2,s2,0x6
ffffffffc02026c8:	993a                	add	s2,s2,a4
        if (p == page)
ffffffffc02026ca:	01240c63          	beq	s0,s2,ffffffffc02026e2 <page_insert+0xa6>
    page->ref -= 1;
ffffffffc02026ce:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fcd5974>
ffffffffc02026d2:	fff7869b          	addiw	a3,a5,-1
ffffffffc02026d6:	00d92023          	sw	a3,0(s2)
        if (page_ref(page) == 0)
ffffffffc02026da:	c691                	beqz	a3,ffffffffc02026e6 <page_insert+0xaa>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02026dc:	120a0073          	sfence.vma	s4
}
ffffffffc02026e0:	bf59                	j	ffffffffc0202676 <page_insert+0x3a>
ffffffffc02026e2:	c014                	sw	a3,0(s0)
    return page->ref;
ffffffffc02026e4:	bf49                	j	ffffffffc0202676 <page_insert+0x3a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02026e6:	100027f3          	csrr	a5,sstatus
ffffffffc02026ea:	8b89                	andi	a5,a5,2
ffffffffc02026ec:	ef91                	bnez	a5,ffffffffc0202708 <page_insert+0xcc>
        pmm_manager->free_pages(base, n);
ffffffffc02026ee:	000a8797          	auipc	a5,0xa8
ffffffffc02026f2:	f727b783          	ld	a5,-142(a5) # ffffffffc02aa660 <pmm_manager>
ffffffffc02026f6:	739c                	ld	a5,32(a5)
ffffffffc02026f8:	4585                	li	a1,1
ffffffffc02026fa:	854a                	mv	a0,s2
ffffffffc02026fc:	9782                	jalr	a5
    return page - pages + nbase;
ffffffffc02026fe:	000ab703          	ld	a4,0(s5)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202702:	120a0073          	sfence.vma	s4
ffffffffc0202706:	bf85                	j	ffffffffc0202676 <page_insert+0x3a>
        intr_disable();
ffffffffc0202708:	aacfe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc020270c:	000a8797          	auipc	a5,0xa8
ffffffffc0202710:	f547b783          	ld	a5,-172(a5) # ffffffffc02aa660 <pmm_manager>
ffffffffc0202714:	739c                	ld	a5,32(a5)
ffffffffc0202716:	4585                	li	a1,1
ffffffffc0202718:	854a                	mv	a0,s2
ffffffffc020271a:	9782                	jalr	a5
        intr_enable();
ffffffffc020271c:	a92fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202720:	000ab703          	ld	a4,0(s5)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202724:	120a0073          	sfence.vma	s4
ffffffffc0202728:	b7b9                	j	ffffffffc0202676 <page_insert+0x3a>
        return -E_NO_MEM;
ffffffffc020272a:	5571                	li	a0,-4
ffffffffc020272c:	b79d                	j	ffffffffc0202692 <page_insert+0x56>
ffffffffc020272e:	f2eff0ef          	jal	ra,ffffffffc0201e5c <pa2page.part.0>

ffffffffc0202732 <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc0202732:	00004797          	auipc	a5,0x4
ffffffffc0202736:	dbe78793          	addi	a5,a5,-578 # ffffffffc02064f0 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc020273a:	638c                	ld	a1,0(a5)
{
ffffffffc020273c:	7159                	addi	sp,sp,-112
ffffffffc020273e:	f85a                	sd	s6,48(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202740:	00004517          	auipc	a0,0x4
ffffffffc0202744:	f5850513          	addi	a0,a0,-168 # ffffffffc0206698 <default_pmm_manager+0x1a8>
    pmm_manager = &default_pmm_manager;
ffffffffc0202748:	000a8b17          	auipc	s6,0xa8
ffffffffc020274c:	f18b0b13          	addi	s6,s6,-232 # ffffffffc02aa660 <pmm_manager>
{
ffffffffc0202750:	f486                	sd	ra,104(sp)
ffffffffc0202752:	e8ca                	sd	s2,80(sp)
ffffffffc0202754:	e4ce                	sd	s3,72(sp)
ffffffffc0202756:	f0a2                	sd	s0,96(sp)
ffffffffc0202758:	eca6                	sd	s1,88(sp)
ffffffffc020275a:	e0d2                	sd	s4,64(sp)
ffffffffc020275c:	fc56                	sd	s5,56(sp)
ffffffffc020275e:	f45e                	sd	s7,40(sp)
ffffffffc0202760:	f062                	sd	s8,32(sp)
ffffffffc0202762:	ec66                	sd	s9,24(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc0202764:	00fb3023          	sd	a5,0(s6)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202768:	a2dfd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    pmm_manager->init();
ffffffffc020276c:	000b3783          	ld	a5,0(s6)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0202770:	000a8997          	auipc	s3,0xa8
ffffffffc0202774:	ef898993          	addi	s3,s3,-264 # ffffffffc02aa668 <va_pa_offset>
    pmm_manager->init();
ffffffffc0202778:	679c                	ld	a5,8(a5)
ffffffffc020277a:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc020277c:	57f5                	li	a5,-3
ffffffffc020277e:	07fa                	slli	a5,a5,0x1e
ffffffffc0202780:	00f9b023          	sd	a5,0(s3)
    uint64_t mem_begin = get_memory_base();
ffffffffc0202784:	a16fe0ef          	jal	ra,ffffffffc020099a <get_memory_base>
ffffffffc0202788:	892a                	mv	s2,a0
    uint64_t mem_size = get_memory_size();
ffffffffc020278a:	a1afe0ef          	jal	ra,ffffffffc02009a4 <get_memory_size>
    if (mem_size == 0)
ffffffffc020278e:	200505e3          	beqz	a0,ffffffffc0203198 <pmm_init+0xa66>
    uint64_t mem_end = mem_begin + mem_size;
ffffffffc0202792:	84aa                	mv	s1,a0
    cprintf("physcial memory map:\n");
ffffffffc0202794:	00004517          	auipc	a0,0x4
ffffffffc0202798:	f3c50513          	addi	a0,a0,-196 # ffffffffc02066d0 <default_pmm_manager+0x1e0>
ffffffffc020279c:	9f9fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    uint64_t mem_end = mem_begin + mem_size;
ffffffffc02027a0:	00990433          	add	s0,s2,s1
    cprintf("  memory: 0x%08lx, [0x%08lx, 0x%08lx].\n", mem_size, mem_begin,
ffffffffc02027a4:	fff40693          	addi	a3,s0,-1
ffffffffc02027a8:	864a                	mv	a2,s2
ffffffffc02027aa:	85a6                	mv	a1,s1
ffffffffc02027ac:	00004517          	auipc	a0,0x4
ffffffffc02027b0:	f3c50513          	addi	a0,a0,-196 # ffffffffc02066e8 <default_pmm_manager+0x1f8>
ffffffffc02027b4:	9e1fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc02027b8:	c8000737          	lui	a4,0xc8000
ffffffffc02027bc:	87a2                	mv	a5,s0
ffffffffc02027be:	54876163          	bltu	a4,s0,ffffffffc0202d00 <pmm_init+0x5ce>
ffffffffc02027c2:	757d                	lui	a0,0xfffff
ffffffffc02027c4:	000a9617          	auipc	a2,0xa9
ffffffffc02027c8:	ec760613          	addi	a2,a2,-313 # ffffffffc02ab68b <end+0xfff>
ffffffffc02027cc:	8e69                	and	a2,a2,a0
ffffffffc02027ce:	000a8497          	auipc	s1,0xa8
ffffffffc02027d2:	e8248493          	addi	s1,s1,-382 # ffffffffc02aa650 <npage>
ffffffffc02027d6:	00c7d513          	srli	a0,a5,0xc
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02027da:	000a8b97          	auipc	s7,0xa8
ffffffffc02027de:	e7eb8b93          	addi	s7,s7,-386 # ffffffffc02aa658 <pages>
    npage = maxpa / PGSIZE;
ffffffffc02027e2:	e088                	sd	a0,0(s1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02027e4:	00cbb023          	sd	a2,0(s7)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc02027e8:	000807b7          	lui	a5,0x80
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02027ec:	86b2                	mv	a3,a2
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc02027ee:	02f50863          	beq	a0,a5,ffffffffc020281e <pmm_init+0xec>
ffffffffc02027f2:	4781                	li	a5,0
ffffffffc02027f4:	4585                	li	a1,1
ffffffffc02027f6:	fff806b7          	lui	a3,0xfff80
        SetPageReserved(pages + i);
ffffffffc02027fa:	00679513          	slli	a0,a5,0x6
ffffffffc02027fe:	9532                	add	a0,a0,a2
ffffffffc0202800:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd5497c>
ffffffffc0202804:	40b7302f          	amoor.d	zero,a1,(a4)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc0202808:	6088                	ld	a0,0(s1)
ffffffffc020280a:	0785                	addi	a5,a5,1
        SetPageReserved(pages + i);
ffffffffc020280c:	000bb603          	ld	a2,0(s7)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc0202810:	00d50733          	add	a4,a0,a3
ffffffffc0202814:	fee7e3e3          	bltu	a5,a4,ffffffffc02027fa <pmm_init+0xc8>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0202818:	071a                	slli	a4,a4,0x6
ffffffffc020281a:	00e606b3          	add	a3,a2,a4
ffffffffc020281e:	c02007b7          	lui	a5,0xc0200
ffffffffc0202822:	2ef6ece3          	bltu	a3,a5,ffffffffc020331a <pmm_init+0xbe8>
ffffffffc0202826:	0009b583          	ld	a1,0(s3)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc020282a:	77fd                	lui	a5,0xfffff
ffffffffc020282c:	8c7d                	and	s0,s0,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc020282e:	8e8d                	sub	a3,a3,a1
    if (freemem < mem_end)
ffffffffc0202830:	5086eb63          	bltu	a3,s0,ffffffffc0202d46 <pmm_init+0x614>
    cprintf("vapaofset is %llu\n", va_pa_offset);
ffffffffc0202834:	00004517          	auipc	a0,0x4
ffffffffc0202838:	edc50513          	addi	a0,a0,-292 # ffffffffc0206710 <default_pmm_manager+0x220>
ffffffffc020283c:	959fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    return page;
}

static void check_alloc_page(void)
{
    pmm_manager->check();
ffffffffc0202840:	000b3783          	ld	a5,0(s6)
    boot_pgdir_va = (pte_t *)boot_page_table_sv39;
ffffffffc0202844:	000a8917          	auipc	s2,0xa8
ffffffffc0202848:	e0490913          	addi	s2,s2,-508 # ffffffffc02aa648 <boot_pgdir_va>
    pmm_manager->check();
ffffffffc020284c:	7b9c                	ld	a5,48(a5)
ffffffffc020284e:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc0202850:	00004517          	auipc	a0,0x4
ffffffffc0202854:	ed850513          	addi	a0,a0,-296 # ffffffffc0206728 <default_pmm_manager+0x238>
ffffffffc0202858:	93dfd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    boot_pgdir_va = (pte_t *)boot_page_table_sv39;
ffffffffc020285c:	00007697          	auipc	a3,0x7
ffffffffc0202860:	7a468693          	addi	a3,a3,1956 # ffffffffc020a000 <boot_page_table_sv39>
ffffffffc0202864:	00d93023          	sd	a3,0(s2)
    boot_pgdir_pa = PADDR(boot_pgdir_va);
ffffffffc0202868:	c02007b7          	lui	a5,0xc0200
ffffffffc020286c:	28f6ebe3          	bltu	a3,a5,ffffffffc0203302 <pmm_init+0xbd0>
ffffffffc0202870:	0009b783          	ld	a5,0(s3)
ffffffffc0202874:	8e9d                	sub	a3,a3,a5
ffffffffc0202876:	000a8797          	auipc	a5,0xa8
ffffffffc020287a:	dcd7b523          	sd	a3,-566(a5) # ffffffffc02aa640 <boot_pgdir_pa>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020287e:	100027f3          	csrr	a5,sstatus
ffffffffc0202882:	8b89                	andi	a5,a5,2
ffffffffc0202884:	4a079763          	bnez	a5,ffffffffc0202d32 <pmm_init+0x600>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202888:	000b3783          	ld	a5,0(s6)
ffffffffc020288c:	779c                	ld	a5,40(a5)
ffffffffc020288e:	9782                	jalr	a5
ffffffffc0202890:	842a                	mv	s0,a0
    // so npage is always larger than KMEMSIZE / PGSIZE
    size_t nr_free_store;

    nr_free_store = nr_free_pages();

    assert(npage <= KERNTOP / PGSIZE);
ffffffffc0202892:	6098                	ld	a4,0(s1)
ffffffffc0202894:	c80007b7          	lui	a5,0xc8000
ffffffffc0202898:	83b1                	srli	a5,a5,0xc
ffffffffc020289a:	66e7e363          	bltu	a5,a4,ffffffffc0202f00 <pmm_init+0x7ce>
    assert(boot_pgdir_va != NULL && (uint32_t)PGOFF(boot_pgdir_va) == 0);
ffffffffc020289e:	00093503          	ld	a0,0(s2)
ffffffffc02028a2:	62050f63          	beqz	a0,ffffffffc0202ee0 <pmm_init+0x7ae>
ffffffffc02028a6:	03451793          	slli	a5,a0,0x34
ffffffffc02028aa:	62079b63          	bnez	a5,ffffffffc0202ee0 <pmm_init+0x7ae>
    assert(get_page(boot_pgdir_va, 0x0, NULL) == NULL);
ffffffffc02028ae:	4601                	li	a2,0
ffffffffc02028b0:	4581                	li	a1,0
ffffffffc02028b2:	8c3ff0ef          	jal	ra,ffffffffc0202174 <get_page>
ffffffffc02028b6:	60051563          	bnez	a0,ffffffffc0202ec0 <pmm_init+0x78e>
ffffffffc02028ba:	100027f3          	csrr	a5,sstatus
ffffffffc02028be:	8b89                	andi	a5,a5,2
ffffffffc02028c0:	44079e63          	bnez	a5,ffffffffc0202d1c <pmm_init+0x5ea>
        page = pmm_manager->alloc_pages(n);
ffffffffc02028c4:	000b3783          	ld	a5,0(s6)
ffffffffc02028c8:	4505                	li	a0,1
ffffffffc02028ca:	6f9c                	ld	a5,24(a5)
ffffffffc02028cc:	9782                	jalr	a5
ffffffffc02028ce:	8a2a                	mv	s4,a0

    struct Page *p1, *p2;
    p1 = alloc_page();
    assert(page_insert(boot_pgdir_va, p1, 0x0, 0) == 0);
ffffffffc02028d0:	00093503          	ld	a0,0(s2)
ffffffffc02028d4:	4681                	li	a3,0
ffffffffc02028d6:	4601                	li	a2,0
ffffffffc02028d8:	85d2                	mv	a1,s4
ffffffffc02028da:	d63ff0ef          	jal	ra,ffffffffc020263c <page_insert>
ffffffffc02028de:	26051ae3          	bnez	a0,ffffffffc0203352 <pmm_init+0xc20>

    pte_t *ptep;
    assert((ptep = get_pte(boot_pgdir_va, 0x0, 0)) != NULL);
ffffffffc02028e2:	00093503          	ld	a0,0(s2)
ffffffffc02028e6:	4601                	li	a2,0
ffffffffc02028e8:	4581                	li	a1,0
ffffffffc02028ea:	e62ff0ef          	jal	ra,ffffffffc0201f4c <get_pte>
ffffffffc02028ee:	240502e3          	beqz	a0,ffffffffc0203332 <pmm_init+0xc00>
    assert(pte2page(*ptep) == p1);
ffffffffc02028f2:	611c                	ld	a5,0(a0)
    if (!(pte & PTE_V))
ffffffffc02028f4:	0017f713          	andi	a4,a5,1
ffffffffc02028f8:	5a070263          	beqz	a4,ffffffffc0202e9c <pmm_init+0x76a>
    if (PPN(pa) >= npage)
ffffffffc02028fc:	6098                	ld	a4,0(s1)
    return pa2page(PTE_ADDR(pte));
ffffffffc02028fe:	078a                	slli	a5,a5,0x2
ffffffffc0202900:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202902:	58e7fb63          	bgeu	a5,a4,ffffffffc0202e98 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202906:	000bb683          	ld	a3,0(s7)
ffffffffc020290a:	fff80637          	lui	a2,0xfff80
ffffffffc020290e:	97b2                	add	a5,a5,a2
ffffffffc0202910:	079a                	slli	a5,a5,0x6
ffffffffc0202912:	97b6                	add	a5,a5,a3
ffffffffc0202914:	14fa17e3          	bne	s4,a5,ffffffffc0203262 <pmm_init+0xb30>
    assert(page_ref(p1) == 1);
ffffffffc0202918:	000a2683          	lw	a3,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8ba0>
ffffffffc020291c:	4785                	li	a5,1
ffffffffc020291e:	12f692e3          	bne	a3,a5,ffffffffc0203242 <pmm_init+0xb10>

    ptep = (pte_t *)KADDR(PDE_ADDR(boot_pgdir_va[0]));
ffffffffc0202922:	00093503          	ld	a0,0(s2)
ffffffffc0202926:	77fd                	lui	a5,0xfffff
ffffffffc0202928:	6114                	ld	a3,0(a0)
ffffffffc020292a:	068a                	slli	a3,a3,0x2
ffffffffc020292c:	8efd                	and	a3,a3,a5
ffffffffc020292e:	00c6d613          	srli	a2,a3,0xc
ffffffffc0202932:	0ee67ce3          	bgeu	a2,a4,ffffffffc020322a <pmm_init+0xaf8>
ffffffffc0202936:	0009bc03          	ld	s8,0(s3)
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc020293a:	96e2                	add	a3,a3,s8
ffffffffc020293c:	0006ba83          	ld	s5,0(a3)
ffffffffc0202940:	0a8a                	slli	s5,s5,0x2
ffffffffc0202942:	00fafab3          	and	s5,s5,a5
ffffffffc0202946:	00cad793          	srli	a5,s5,0xc
ffffffffc020294a:	0ce7f3e3          	bgeu	a5,a4,ffffffffc0203210 <pmm_init+0xade>
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc020294e:	4601                	li	a2,0
ffffffffc0202950:	6585                	lui	a1,0x1
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc0202952:	9ae2                	add	s5,s5,s8
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202954:	df8ff0ef          	jal	ra,ffffffffc0201f4c <get_pte>
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc0202958:	0aa1                	addi	s5,s5,8
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc020295a:	55551363          	bne	a0,s5,ffffffffc0202ea0 <pmm_init+0x76e>
ffffffffc020295e:	100027f3          	csrr	a5,sstatus
ffffffffc0202962:	8b89                	andi	a5,a5,2
ffffffffc0202964:	3a079163          	bnez	a5,ffffffffc0202d06 <pmm_init+0x5d4>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202968:	000b3783          	ld	a5,0(s6)
ffffffffc020296c:	4505                	li	a0,1
ffffffffc020296e:	6f9c                	ld	a5,24(a5)
ffffffffc0202970:	9782                	jalr	a5
ffffffffc0202972:	8c2a                	mv	s8,a0

    p2 = alloc_page();
    assert(page_insert(boot_pgdir_va, p2, PGSIZE, PTE_U | PTE_W) == 0);
ffffffffc0202974:	00093503          	ld	a0,0(s2)
ffffffffc0202978:	46d1                	li	a3,20
ffffffffc020297a:	6605                	lui	a2,0x1
ffffffffc020297c:	85e2                	mv	a1,s8
ffffffffc020297e:	cbfff0ef          	jal	ra,ffffffffc020263c <page_insert>
ffffffffc0202982:	060517e3          	bnez	a0,ffffffffc02031f0 <pmm_init+0xabe>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc0202986:	00093503          	ld	a0,0(s2)
ffffffffc020298a:	4601                	li	a2,0
ffffffffc020298c:	6585                	lui	a1,0x1
ffffffffc020298e:	dbeff0ef          	jal	ra,ffffffffc0201f4c <get_pte>
ffffffffc0202992:	02050fe3          	beqz	a0,ffffffffc02031d0 <pmm_init+0xa9e>
    assert(*ptep & PTE_U);
ffffffffc0202996:	611c                	ld	a5,0(a0)
ffffffffc0202998:	0107f713          	andi	a4,a5,16
ffffffffc020299c:	7c070e63          	beqz	a4,ffffffffc0203178 <pmm_init+0xa46>
    assert(*ptep & PTE_W);
ffffffffc02029a0:	8b91                	andi	a5,a5,4
ffffffffc02029a2:	7a078b63          	beqz	a5,ffffffffc0203158 <pmm_init+0xa26>
    assert(boot_pgdir_va[0] & PTE_U);
ffffffffc02029a6:	00093503          	ld	a0,0(s2)
ffffffffc02029aa:	611c                	ld	a5,0(a0)
ffffffffc02029ac:	8bc1                	andi	a5,a5,16
ffffffffc02029ae:	78078563          	beqz	a5,ffffffffc0203138 <pmm_init+0xa06>
    assert(page_ref(p2) == 1);
ffffffffc02029b2:	000c2703          	lw	a4,0(s8)
ffffffffc02029b6:	4785                	li	a5,1
ffffffffc02029b8:	76f71063          	bne	a4,a5,ffffffffc0203118 <pmm_init+0x9e6>

    assert(page_insert(boot_pgdir_va, p1, PGSIZE, 0) == 0);
ffffffffc02029bc:	4681                	li	a3,0
ffffffffc02029be:	6605                	lui	a2,0x1
ffffffffc02029c0:	85d2                	mv	a1,s4
ffffffffc02029c2:	c7bff0ef          	jal	ra,ffffffffc020263c <page_insert>
ffffffffc02029c6:	72051963          	bnez	a0,ffffffffc02030f8 <pmm_init+0x9c6>
    assert(page_ref(p1) == 2);
ffffffffc02029ca:	000a2703          	lw	a4,0(s4)
ffffffffc02029ce:	4789                	li	a5,2
ffffffffc02029d0:	70f71463          	bne	a4,a5,ffffffffc02030d8 <pmm_init+0x9a6>
    assert(page_ref(p2) == 0);
ffffffffc02029d4:	000c2783          	lw	a5,0(s8)
ffffffffc02029d8:	6e079063          	bnez	a5,ffffffffc02030b8 <pmm_init+0x986>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02029dc:	00093503          	ld	a0,0(s2)
ffffffffc02029e0:	4601                	li	a2,0
ffffffffc02029e2:	6585                	lui	a1,0x1
ffffffffc02029e4:	d68ff0ef          	jal	ra,ffffffffc0201f4c <get_pte>
ffffffffc02029e8:	6a050863          	beqz	a0,ffffffffc0203098 <pmm_init+0x966>
    assert(pte2page(*ptep) == p1);
ffffffffc02029ec:	6118                	ld	a4,0(a0)
    if (!(pte & PTE_V))
ffffffffc02029ee:	00177793          	andi	a5,a4,1
ffffffffc02029f2:	4a078563          	beqz	a5,ffffffffc0202e9c <pmm_init+0x76a>
    if (PPN(pa) >= npage)
ffffffffc02029f6:	6094                	ld	a3,0(s1)
    return pa2page(PTE_ADDR(pte));
ffffffffc02029f8:	00271793          	slli	a5,a4,0x2
ffffffffc02029fc:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02029fe:	48d7fd63          	bgeu	a5,a3,ffffffffc0202e98 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202a02:	000bb683          	ld	a3,0(s7)
ffffffffc0202a06:	fff80ab7          	lui	s5,0xfff80
ffffffffc0202a0a:	97d6                	add	a5,a5,s5
ffffffffc0202a0c:	079a                	slli	a5,a5,0x6
ffffffffc0202a0e:	97b6                	add	a5,a5,a3
ffffffffc0202a10:	66fa1463          	bne	s4,a5,ffffffffc0203078 <pmm_init+0x946>
    assert((*ptep & PTE_U) == 0);
ffffffffc0202a14:	8b41                	andi	a4,a4,16
ffffffffc0202a16:	64071163          	bnez	a4,ffffffffc0203058 <pmm_init+0x926>

    page_remove(boot_pgdir_va, 0x0);
ffffffffc0202a1a:	00093503          	ld	a0,0(s2)
ffffffffc0202a1e:	4581                	li	a1,0
ffffffffc0202a20:	b81ff0ef          	jal	ra,ffffffffc02025a0 <page_remove>
    assert(page_ref(p1) == 1);
ffffffffc0202a24:	000a2c83          	lw	s9,0(s4)
ffffffffc0202a28:	4785                	li	a5,1
ffffffffc0202a2a:	60fc9763          	bne	s9,a5,ffffffffc0203038 <pmm_init+0x906>
    assert(page_ref(p2) == 0);
ffffffffc0202a2e:	000c2783          	lw	a5,0(s8)
ffffffffc0202a32:	5e079363          	bnez	a5,ffffffffc0203018 <pmm_init+0x8e6>

    page_remove(boot_pgdir_va, PGSIZE);
ffffffffc0202a36:	00093503          	ld	a0,0(s2)
ffffffffc0202a3a:	6585                	lui	a1,0x1
ffffffffc0202a3c:	b65ff0ef          	jal	ra,ffffffffc02025a0 <page_remove>
    assert(page_ref(p1) == 0);
ffffffffc0202a40:	000a2783          	lw	a5,0(s4)
ffffffffc0202a44:	52079a63          	bnez	a5,ffffffffc0202f78 <pmm_init+0x846>
    assert(page_ref(p2) == 0);
ffffffffc0202a48:	000c2783          	lw	a5,0(s8)
ffffffffc0202a4c:	50079663          	bnez	a5,ffffffffc0202f58 <pmm_init+0x826>

    assert(page_ref(pde2page(boot_pgdir_va[0])) == 1);
ffffffffc0202a50:	00093a03          	ld	s4,0(s2)
    if (PPN(pa) >= npage)
ffffffffc0202a54:	608c                	ld	a1,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202a56:	000a3683          	ld	a3,0(s4)
ffffffffc0202a5a:	068a                	slli	a3,a3,0x2
ffffffffc0202a5c:	82b1                	srli	a3,a3,0xc
    if (PPN(pa) >= npage)
ffffffffc0202a5e:	42b6fd63          	bgeu	a3,a1,ffffffffc0202e98 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202a62:	000bb503          	ld	a0,0(s7)
ffffffffc0202a66:	96d6                	add	a3,a3,s5
ffffffffc0202a68:	069a                	slli	a3,a3,0x6
    return page->ref;
ffffffffc0202a6a:	00d507b3          	add	a5,a0,a3
ffffffffc0202a6e:	439c                	lw	a5,0(a5)
ffffffffc0202a70:	4d979463          	bne	a5,s9,ffffffffc0202f38 <pmm_init+0x806>
    return page - pages + nbase;
ffffffffc0202a74:	8699                	srai	a3,a3,0x6
ffffffffc0202a76:	00080637          	lui	a2,0x80
ffffffffc0202a7a:	96b2                	add	a3,a3,a2
    return KADDR(page2pa(page));
ffffffffc0202a7c:	00c69713          	slli	a4,a3,0xc
ffffffffc0202a80:	8331                	srli	a4,a4,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0202a82:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202a84:	48b77e63          	bgeu	a4,a1,ffffffffc0202f20 <pmm_init+0x7ee>

    pde_t *pd1 = boot_pgdir_va, *pd0 = page2kva(pde2page(boot_pgdir_va[0]));
    free_page(pde2page(pd0[0]));
ffffffffc0202a88:	0009b703          	ld	a4,0(s3)
ffffffffc0202a8c:	96ba                	add	a3,a3,a4
    return pa2page(PDE_ADDR(pde));
ffffffffc0202a8e:	629c                	ld	a5,0(a3)
ffffffffc0202a90:	078a                	slli	a5,a5,0x2
ffffffffc0202a92:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202a94:	40b7f263          	bgeu	a5,a1,ffffffffc0202e98 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202a98:	8f91                	sub	a5,a5,a2
ffffffffc0202a9a:	079a                	slli	a5,a5,0x6
ffffffffc0202a9c:	953e                	add	a0,a0,a5
ffffffffc0202a9e:	100027f3          	csrr	a5,sstatus
ffffffffc0202aa2:	8b89                	andi	a5,a5,2
ffffffffc0202aa4:	30079963          	bnez	a5,ffffffffc0202db6 <pmm_init+0x684>
        pmm_manager->free_pages(base, n);
ffffffffc0202aa8:	000b3783          	ld	a5,0(s6)
ffffffffc0202aac:	4585                	li	a1,1
ffffffffc0202aae:	739c                	ld	a5,32(a5)
ffffffffc0202ab0:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202ab2:	000a3783          	ld	a5,0(s4)
    if (PPN(pa) >= npage)
ffffffffc0202ab6:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202ab8:	078a                	slli	a5,a5,0x2
ffffffffc0202aba:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202abc:	3ce7fe63          	bgeu	a5,a4,ffffffffc0202e98 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202ac0:	000bb503          	ld	a0,0(s7)
ffffffffc0202ac4:	fff80737          	lui	a4,0xfff80
ffffffffc0202ac8:	97ba                	add	a5,a5,a4
ffffffffc0202aca:	079a                	slli	a5,a5,0x6
ffffffffc0202acc:	953e                	add	a0,a0,a5
ffffffffc0202ace:	100027f3          	csrr	a5,sstatus
ffffffffc0202ad2:	8b89                	andi	a5,a5,2
ffffffffc0202ad4:	2c079563          	bnez	a5,ffffffffc0202d9e <pmm_init+0x66c>
ffffffffc0202ad8:	000b3783          	ld	a5,0(s6)
ffffffffc0202adc:	4585                	li	a1,1
ffffffffc0202ade:	739c                	ld	a5,32(a5)
ffffffffc0202ae0:	9782                	jalr	a5
    free_page(pde2page(pd1[0]));
    boot_pgdir_va[0] = 0;
ffffffffc0202ae2:	00093783          	ld	a5,0(s2)
ffffffffc0202ae6:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd54974>
    asm volatile("sfence.vma");
ffffffffc0202aea:	12000073          	sfence.vma
ffffffffc0202aee:	100027f3          	csrr	a5,sstatus
ffffffffc0202af2:	8b89                	andi	a5,a5,2
ffffffffc0202af4:	28079b63          	bnez	a5,ffffffffc0202d8a <pmm_init+0x658>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202af8:	000b3783          	ld	a5,0(s6)
ffffffffc0202afc:	779c                	ld	a5,40(a5)
ffffffffc0202afe:	9782                	jalr	a5
ffffffffc0202b00:	8a2a                	mv	s4,a0
    flush_tlb();

    assert(nr_free_store == nr_free_pages());
ffffffffc0202b02:	4b441b63          	bne	s0,s4,ffffffffc0202fb8 <pmm_init+0x886>

    cprintf("check_pgdir() succeeded!\n");
ffffffffc0202b06:	00004517          	auipc	a0,0x4
ffffffffc0202b0a:	f4a50513          	addi	a0,a0,-182 # ffffffffc0206a50 <default_pmm_manager+0x560>
ffffffffc0202b0e:	e86fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc0202b12:	100027f3          	csrr	a5,sstatus
ffffffffc0202b16:	8b89                	andi	a5,a5,2
ffffffffc0202b18:	24079f63          	bnez	a5,ffffffffc0202d76 <pmm_init+0x644>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202b1c:	000b3783          	ld	a5,0(s6)
ffffffffc0202b20:	779c                	ld	a5,40(a5)
ffffffffc0202b22:	9782                	jalr	a5
ffffffffc0202b24:	8c2a                	mv	s8,a0
    pte_t *ptep;
    int i;

    nr_free_store = nr_free_pages();

    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202b26:	6098                	ld	a4,0(s1)
ffffffffc0202b28:	c0200437          	lui	s0,0xc0200
    {
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202b2c:	7afd                	lui	s5,0xfffff
    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202b2e:	00c71793          	slli	a5,a4,0xc
ffffffffc0202b32:	6a05                	lui	s4,0x1
ffffffffc0202b34:	02f47c63          	bgeu	s0,a5,ffffffffc0202b6c <pmm_init+0x43a>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202b38:	00c45793          	srli	a5,s0,0xc
ffffffffc0202b3c:	00093503          	ld	a0,0(s2)
ffffffffc0202b40:	2ee7ff63          	bgeu	a5,a4,ffffffffc0202e3e <pmm_init+0x70c>
ffffffffc0202b44:	0009b583          	ld	a1,0(s3)
ffffffffc0202b48:	4601                	li	a2,0
ffffffffc0202b4a:	95a2                	add	a1,a1,s0
ffffffffc0202b4c:	c00ff0ef          	jal	ra,ffffffffc0201f4c <get_pte>
ffffffffc0202b50:	32050463          	beqz	a0,ffffffffc0202e78 <pmm_init+0x746>
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202b54:	611c                	ld	a5,0(a0)
ffffffffc0202b56:	078a                	slli	a5,a5,0x2
ffffffffc0202b58:	0157f7b3          	and	a5,a5,s5
ffffffffc0202b5c:	2e879e63          	bne	a5,s0,ffffffffc0202e58 <pmm_init+0x726>
    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202b60:	6098                	ld	a4,0(s1)
ffffffffc0202b62:	9452                	add	s0,s0,s4
ffffffffc0202b64:	00c71793          	slli	a5,a4,0xc
ffffffffc0202b68:	fcf468e3          	bltu	s0,a5,ffffffffc0202b38 <pmm_init+0x406>
    }

    assert(boot_pgdir_va[0] == 0);
ffffffffc0202b6c:	00093783          	ld	a5,0(s2)
ffffffffc0202b70:	639c                	ld	a5,0(a5)
ffffffffc0202b72:	42079363          	bnez	a5,ffffffffc0202f98 <pmm_init+0x866>
ffffffffc0202b76:	100027f3          	csrr	a5,sstatus
ffffffffc0202b7a:	8b89                	andi	a5,a5,2
ffffffffc0202b7c:	24079963          	bnez	a5,ffffffffc0202dce <pmm_init+0x69c>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202b80:	000b3783          	ld	a5,0(s6)
ffffffffc0202b84:	4505                	li	a0,1
ffffffffc0202b86:	6f9c                	ld	a5,24(a5)
ffffffffc0202b88:	9782                	jalr	a5
ffffffffc0202b8a:	8a2a                	mv	s4,a0

    struct Page *p;
    p = alloc_page();
    assert(page_insert(boot_pgdir_va, p, 0x100, PTE_W | PTE_R) == 0);
ffffffffc0202b8c:	00093503          	ld	a0,0(s2)
ffffffffc0202b90:	4699                	li	a3,6
ffffffffc0202b92:	10000613          	li	a2,256
ffffffffc0202b96:	85d2                	mv	a1,s4
ffffffffc0202b98:	aa5ff0ef          	jal	ra,ffffffffc020263c <page_insert>
ffffffffc0202b9c:	44051e63          	bnez	a0,ffffffffc0202ff8 <pmm_init+0x8c6>
    assert(page_ref(p) == 1);
ffffffffc0202ba0:	000a2703          	lw	a4,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8ba0>
ffffffffc0202ba4:	4785                	li	a5,1
ffffffffc0202ba6:	42f71963          	bne	a4,a5,ffffffffc0202fd8 <pmm_init+0x8a6>
    assert(page_insert(boot_pgdir_va, p, 0x100 + PGSIZE, PTE_W | PTE_R) == 0);
ffffffffc0202baa:	00093503          	ld	a0,0(s2)
ffffffffc0202bae:	6405                	lui	s0,0x1
ffffffffc0202bb0:	4699                	li	a3,6
ffffffffc0202bb2:	10040613          	addi	a2,s0,256 # 1100 <_binary_obj___user_faultread_out_size-0x8aa0>
ffffffffc0202bb6:	85d2                	mv	a1,s4
ffffffffc0202bb8:	a85ff0ef          	jal	ra,ffffffffc020263c <page_insert>
ffffffffc0202bbc:	72051363          	bnez	a0,ffffffffc02032e2 <pmm_init+0xbb0>
    assert(page_ref(p) == 2);
ffffffffc0202bc0:	000a2703          	lw	a4,0(s4)
ffffffffc0202bc4:	4789                	li	a5,2
ffffffffc0202bc6:	6ef71e63          	bne	a4,a5,ffffffffc02032c2 <pmm_init+0xb90>

    const char *str = "ucore: Hello world!!";
    strcpy((void *)0x100, str);
ffffffffc0202bca:	00004597          	auipc	a1,0x4
ffffffffc0202bce:	fce58593          	addi	a1,a1,-50 # ffffffffc0206b98 <default_pmm_manager+0x6a8>
ffffffffc0202bd2:	10000513          	li	a0,256
ffffffffc0202bd6:	243020ef          	jal	ra,ffffffffc0205618 <strcpy>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
ffffffffc0202bda:	10040593          	addi	a1,s0,256
ffffffffc0202bde:	10000513          	li	a0,256
ffffffffc0202be2:	249020ef          	jal	ra,ffffffffc020562a <strcmp>
ffffffffc0202be6:	6a051e63          	bnez	a0,ffffffffc02032a2 <pmm_init+0xb70>
    return page - pages + nbase;
ffffffffc0202bea:	000bb683          	ld	a3,0(s7)
ffffffffc0202bee:	00080737          	lui	a4,0x80
    return KADDR(page2pa(page));
ffffffffc0202bf2:	547d                	li	s0,-1
    return page - pages + nbase;
ffffffffc0202bf4:	40da06b3          	sub	a3,s4,a3
ffffffffc0202bf8:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0202bfa:	609c                	ld	a5,0(s1)
    return page - pages + nbase;
ffffffffc0202bfc:	96ba                	add	a3,a3,a4
    return KADDR(page2pa(page));
ffffffffc0202bfe:	8031                	srli	s0,s0,0xc
ffffffffc0202c00:	0086f733          	and	a4,a3,s0
    return page2ppn(page) << PGSHIFT;
ffffffffc0202c04:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202c06:	30f77d63          	bgeu	a4,a5,ffffffffc0202f20 <pmm_init+0x7ee>

    *(char *)(page2kva(p) + 0x100) = '\0';
ffffffffc0202c0a:	0009b783          	ld	a5,0(s3)
    assert(strlen((const char *)0x100) == 0);
ffffffffc0202c0e:	10000513          	li	a0,256
    *(char *)(page2kva(p) + 0x100) = '\0';
ffffffffc0202c12:	96be                	add	a3,a3,a5
ffffffffc0202c14:	10068023          	sb	zero,256(a3)
    assert(strlen((const char *)0x100) == 0);
ffffffffc0202c18:	1cb020ef          	jal	ra,ffffffffc02055e2 <strlen>
ffffffffc0202c1c:	66051363          	bnez	a0,ffffffffc0203282 <pmm_init+0xb50>

    pde_t *pd1 = boot_pgdir_va, *pd0 = page2kva(pde2page(boot_pgdir_va[0]));
ffffffffc0202c20:	00093a83          	ld	s5,0(s2)
    if (PPN(pa) >= npage)
ffffffffc0202c24:	609c                	ld	a5,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c26:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd54974>
ffffffffc0202c2a:	068a                	slli	a3,a3,0x2
ffffffffc0202c2c:	82b1                	srli	a3,a3,0xc
    if (PPN(pa) >= npage)
ffffffffc0202c2e:	26f6f563          	bgeu	a3,a5,ffffffffc0202e98 <pmm_init+0x766>
    return KADDR(page2pa(page));
ffffffffc0202c32:	8c75                	and	s0,s0,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc0202c34:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202c36:	2ef47563          	bgeu	s0,a5,ffffffffc0202f20 <pmm_init+0x7ee>
ffffffffc0202c3a:	0009b403          	ld	s0,0(s3)
ffffffffc0202c3e:	9436                	add	s0,s0,a3
ffffffffc0202c40:	100027f3          	csrr	a5,sstatus
ffffffffc0202c44:	8b89                	andi	a5,a5,2
ffffffffc0202c46:	1e079163          	bnez	a5,ffffffffc0202e28 <pmm_init+0x6f6>
        pmm_manager->free_pages(base, n);
ffffffffc0202c4a:	000b3783          	ld	a5,0(s6)
ffffffffc0202c4e:	4585                	li	a1,1
ffffffffc0202c50:	8552                	mv	a0,s4
ffffffffc0202c52:	739c                	ld	a5,32(a5)
ffffffffc0202c54:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c56:	601c                	ld	a5,0(s0)
    if (PPN(pa) >= npage)
ffffffffc0202c58:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c5a:	078a                	slli	a5,a5,0x2
ffffffffc0202c5c:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202c5e:	22e7fd63          	bgeu	a5,a4,ffffffffc0202e98 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202c62:	000bb503          	ld	a0,0(s7)
ffffffffc0202c66:	fff80737          	lui	a4,0xfff80
ffffffffc0202c6a:	97ba                	add	a5,a5,a4
ffffffffc0202c6c:	079a                	slli	a5,a5,0x6
ffffffffc0202c6e:	953e                	add	a0,a0,a5
ffffffffc0202c70:	100027f3          	csrr	a5,sstatus
ffffffffc0202c74:	8b89                	andi	a5,a5,2
ffffffffc0202c76:	18079d63          	bnez	a5,ffffffffc0202e10 <pmm_init+0x6de>
ffffffffc0202c7a:	000b3783          	ld	a5,0(s6)
ffffffffc0202c7e:	4585                	li	a1,1
ffffffffc0202c80:	739c                	ld	a5,32(a5)
ffffffffc0202c82:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c84:	000ab783          	ld	a5,0(s5)
    if (PPN(pa) >= npage)
ffffffffc0202c88:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c8a:	078a                	slli	a5,a5,0x2
ffffffffc0202c8c:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202c8e:	20e7f563          	bgeu	a5,a4,ffffffffc0202e98 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202c92:	000bb503          	ld	a0,0(s7)
ffffffffc0202c96:	fff80737          	lui	a4,0xfff80
ffffffffc0202c9a:	97ba                	add	a5,a5,a4
ffffffffc0202c9c:	079a                	slli	a5,a5,0x6
ffffffffc0202c9e:	953e                	add	a0,a0,a5
ffffffffc0202ca0:	100027f3          	csrr	a5,sstatus
ffffffffc0202ca4:	8b89                	andi	a5,a5,2
ffffffffc0202ca6:	14079963          	bnez	a5,ffffffffc0202df8 <pmm_init+0x6c6>
ffffffffc0202caa:	000b3783          	ld	a5,0(s6)
ffffffffc0202cae:	4585                	li	a1,1
ffffffffc0202cb0:	739c                	ld	a5,32(a5)
ffffffffc0202cb2:	9782                	jalr	a5
    free_page(p);
    free_page(pde2page(pd0[0]));
    free_page(pde2page(pd1[0]));
    boot_pgdir_va[0] = 0;
ffffffffc0202cb4:	00093783          	ld	a5,0(s2)
ffffffffc0202cb8:	0007b023          	sd	zero,0(a5)
    asm volatile("sfence.vma");
ffffffffc0202cbc:	12000073          	sfence.vma
ffffffffc0202cc0:	100027f3          	csrr	a5,sstatus
ffffffffc0202cc4:	8b89                	andi	a5,a5,2
ffffffffc0202cc6:	10079f63          	bnez	a5,ffffffffc0202de4 <pmm_init+0x6b2>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202cca:	000b3783          	ld	a5,0(s6)
ffffffffc0202cce:	779c                	ld	a5,40(a5)
ffffffffc0202cd0:	9782                	jalr	a5
ffffffffc0202cd2:	842a                	mv	s0,a0
    flush_tlb();

    assert(nr_free_store == nr_free_pages());
ffffffffc0202cd4:	4c8c1e63          	bne	s8,s0,ffffffffc02031b0 <pmm_init+0xa7e>

    cprintf("check_boot_pgdir() succeeded!\n");
ffffffffc0202cd8:	00004517          	auipc	a0,0x4
ffffffffc0202cdc:	f3850513          	addi	a0,a0,-200 # ffffffffc0206c10 <default_pmm_manager+0x720>
ffffffffc0202ce0:	cb4fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
}
ffffffffc0202ce4:	7406                	ld	s0,96(sp)
ffffffffc0202ce6:	70a6                	ld	ra,104(sp)
ffffffffc0202ce8:	64e6                	ld	s1,88(sp)
ffffffffc0202cea:	6946                	ld	s2,80(sp)
ffffffffc0202cec:	69a6                	ld	s3,72(sp)
ffffffffc0202cee:	6a06                	ld	s4,64(sp)
ffffffffc0202cf0:	7ae2                	ld	s5,56(sp)
ffffffffc0202cf2:	7b42                	ld	s6,48(sp)
ffffffffc0202cf4:	7ba2                	ld	s7,40(sp)
ffffffffc0202cf6:	7c02                	ld	s8,32(sp)
ffffffffc0202cf8:	6ce2                	ld	s9,24(sp)
ffffffffc0202cfa:	6165                	addi	sp,sp,112
    kmalloc_init();
ffffffffc0202cfc:	f97fe06f          	j	ffffffffc0201c92 <kmalloc_init>
    npage = maxpa / PGSIZE;
ffffffffc0202d00:	c80007b7          	lui	a5,0xc8000
ffffffffc0202d04:	bc7d                	j	ffffffffc02027c2 <pmm_init+0x90>
        intr_disable();
ffffffffc0202d06:	caffd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202d0a:	000b3783          	ld	a5,0(s6)
ffffffffc0202d0e:	4505                	li	a0,1
ffffffffc0202d10:	6f9c                	ld	a5,24(a5)
ffffffffc0202d12:	9782                	jalr	a5
ffffffffc0202d14:	8c2a                	mv	s8,a0
        intr_enable();
ffffffffc0202d16:	c99fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202d1a:	b9a9                	j	ffffffffc0202974 <pmm_init+0x242>
        intr_disable();
ffffffffc0202d1c:	c99fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202d20:	000b3783          	ld	a5,0(s6)
ffffffffc0202d24:	4505                	li	a0,1
ffffffffc0202d26:	6f9c                	ld	a5,24(a5)
ffffffffc0202d28:	9782                	jalr	a5
ffffffffc0202d2a:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202d2c:	c83fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202d30:	b645                	j	ffffffffc02028d0 <pmm_init+0x19e>
        intr_disable();
ffffffffc0202d32:	c83fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202d36:	000b3783          	ld	a5,0(s6)
ffffffffc0202d3a:	779c                	ld	a5,40(a5)
ffffffffc0202d3c:	9782                	jalr	a5
ffffffffc0202d3e:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202d40:	c6ffd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202d44:	b6b9                	j	ffffffffc0202892 <pmm_init+0x160>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0202d46:	6705                	lui	a4,0x1
ffffffffc0202d48:	177d                	addi	a4,a4,-1
ffffffffc0202d4a:	96ba                	add	a3,a3,a4
ffffffffc0202d4c:	8ff5                	and	a5,a5,a3
    if (PPN(pa) >= npage)
ffffffffc0202d4e:	00c7d713          	srli	a4,a5,0xc
ffffffffc0202d52:	14a77363          	bgeu	a4,a0,ffffffffc0202e98 <pmm_init+0x766>
    pmm_manager->init_memmap(base, n);
ffffffffc0202d56:	000b3683          	ld	a3,0(s6)
    return &pages[PPN(pa) - nbase];
ffffffffc0202d5a:	fff80537          	lui	a0,0xfff80
ffffffffc0202d5e:	972a                	add	a4,a4,a0
ffffffffc0202d60:	6a94                	ld	a3,16(a3)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0202d62:	8c1d                	sub	s0,s0,a5
ffffffffc0202d64:	00671513          	slli	a0,a4,0x6
    pmm_manager->init_memmap(base, n);
ffffffffc0202d68:	00c45593          	srli	a1,s0,0xc
ffffffffc0202d6c:	9532                	add	a0,a0,a2
ffffffffc0202d6e:	9682                	jalr	a3
    cprintf("vapaofset is %llu\n", va_pa_offset);
ffffffffc0202d70:	0009b583          	ld	a1,0(s3)
}
ffffffffc0202d74:	b4c1                	j	ffffffffc0202834 <pmm_init+0x102>
        intr_disable();
ffffffffc0202d76:	c3ffd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202d7a:	000b3783          	ld	a5,0(s6)
ffffffffc0202d7e:	779c                	ld	a5,40(a5)
ffffffffc0202d80:	9782                	jalr	a5
ffffffffc0202d82:	8c2a                	mv	s8,a0
        intr_enable();
ffffffffc0202d84:	c2bfd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202d88:	bb79                	j	ffffffffc0202b26 <pmm_init+0x3f4>
        intr_disable();
ffffffffc0202d8a:	c2bfd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202d8e:	000b3783          	ld	a5,0(s6)
ffffffffc0202d92:	779c                	ld	a5,40(a5)
ffffffffc0202d94:	9782                	jalr	a5
ffffffffc0202d96:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202d98:	c17fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202d9c:	b39d                	j	ffffffffc0202b02 <pmm_init+0x3d0>
ffffffffc0202d9e:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202da0:	c15fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202da4:	000b3783          	ld	a5,0(s6)
ffffffffc0202da8:	6522                	ld	a0,8(sp)
ffffffffc0202daa:	4585                	li	a1,1
ffffffffc0202dac:	739c                	ld	a5,32(a5)
ffffffffc0202dae:	9782                	jalr	a5
        intr_enable();
ffffffffc0202db0:	bfffd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202db4:	b33d                	j	ffffffffc0202ae2 <pmm_init+0x3b0>
ffffffffc0202db6:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202db8:	bfdfd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202dbc:	000b3783          	ld	a5,0(s6)
ffffffffc0202dc0:	6522                	ld	a0,8(sp)
ffffffffc0202dc2:	4585                	li	a1,1
ffffffffc0202dc4:	739c                	ld	a5,32(a5)
ffffffffc0202dc6:	9782                	jalr	a5
        intr_enable();
ffffffffc0202dc8:	be7fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202dcc:	b1dd                	j	ffffffffc0202ab2 <pmm_init+0x380>
        intr_disable();
ffffffffc0202dce:	be7fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202dd2:	000b3783          	ld	a5,0(s6)
ffffffffc0202dd6:	4505                	li	a0,1
ffffffffc0202dd8:	6f9c                	ld	a5,24(a5)
ffffffffc0202dda:	9782                	jalr	a5
ffffffffc0202ddc:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202dde:	bd1fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202de2:	b36d                	j	ffffffffc0202b8c <pmm_init+0x45a>
        intr_disable();
ffffffffc0202de4:	bd1fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202de8:	000b3783          	ld	a5,0(s6)
ffffffffc0202dec:	779c                	ld	a5,40(a5)
ffffffffc0202dee:	9782                	jalr	a5
ffffffffc0202df0:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202df2:	bbdfd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202df6:	bdf9                	j	ffffffffc0202cd4 <pmm_init+0x5a2>
ffffffffc0202df8:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202dfa:	bbbfd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202dfe:	000b3783          	ld	a5,0(s6)
ffffffffc0202e02:	6522                	ld	a0,8(sp)
ffffffffc0202e04:	4585                	li	a1,1
ffffffffc0202e06:	739c                	ld	a5,32(a5)
ffffffffc0202e08:	9782                	jalr	a5
        intr_enable();
ffffffffc0202e0a:	ba5fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202e0e:	b55d                	j	ffffffffc0202cb4 <pmm_init+0x582>
ffffffffc0202e10:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202e12:	ba3fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202e16:	000b3783          	ld	a5,0(s6)
ffffffffc0202e1a:	6522                	ld	a0,8(sp)
ffffffffc0202e1c:	4585                	li	a1,1
ffffffffc0202e1e:	739c                	ld	a5,32(a5)
ffffffffc0202e20:	9782                	jalr	a5
        intr_enable();
ffffffffc0202e22:	b8dfd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202e26:	bdb9                	j	ffffffffc0202c84 <pmm_init+0x552>
        intr_disable();
ffffffffc0202e28:	b8dfd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202e2c:	000b3783          	ld	a5,0(s6)
ffffffffc0202e30:	4585                	li	a1,1
ffffffffc0202e32:	8552                	mv	a0,s4
ffffffffc0202e34:	739c                	ld	a5,32(a5)
ffffffffc0202e36:	9782                	jalr	a5
        intr_enable();
ffffffffc0202e38:	b77fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202e3c:	bd29                	j	ffffffffc0202c56 <pmm_init+0x524>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202e3e:	86a2                	mv	a3,s0
ffffffffc0202e40:	00003617          	auipc	a2,0x3
ffffffffc0202e44:	6e860613          	addi	a2,a2,1768 # ffffffffc0206528 <default_pmm_manager+0x38>
ffffffffc0202e48:	25600593          	li	a1,598
ffffffffc0202e4c:	00003517          	auipc	a0,0x3
ffffffffc0202e50:	7f450513          	addi	a0,a0,2036 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202e54:	e3afd0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202e58:	00004697          	auipc	a3,0x4
ffffffffc0202e5c:	c5868693          	addi	a3,a3,-936 # ffffffffc0206ab0 <default_pmm_manager+0x5c0>
ffffffffc0202e60:	00003617          	auipc	a2,0x3
ffffffffc0202e64:	2e060613          	addi	a2,a2,736 # ffffffffc0206140 <commands+0x828>
ffffffffc0202e68:	25700593          	li	a1,599
ffffffffc0202e6c:	00003517          	auipc	a0,0x3
ffffffffc0202e70:	7d450513          	addi	a0,a0,2004 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202e74:	e1afd0ef          	jal	ra,ffffffffc020048e <__panic>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202e78:	00004697          	auipc	a3,0x4
ffffffffc0202e7c:	bf868693          	addi	a3,a3,-1032 # ffffffffc0206a70 <default_pmm_manager+0x580>
ffffffffc0202e80:	00003617          	auipc	a2,0x3
ffffffffc0202e84:	2c060613          	addi	a2,a2,704 # ffffffffc0206140 <commands+0x828>
ffffffffc0202e88:	25600593          	li	a1,598
ffffffffc0202e8c:	00003517          	auipc	a0,0x3
ffffffffc0202e90:	7b450513          	addi	a0,a0,1972 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202e94:	dfafd0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc0202e98:	fc5fe0ef          	jal	ra,ffffffffc0201e5c <pa2page.part.0>
ffffffffc0202e9c:	fddfe0ef          	jal	ra,ffffffffc0201e78 <pte2page.part.0>
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202ea0:	00004697          	auipc	a3,0x4
ffffffffc0202ea4:	9c868693          	addi	a3,a3,-1592 # ffffffffc0206868 <default_pmm_manager+0x378>
ffffffffc0202ea8:	00003617          	auipc	a2,0x3
ffffffffc0202eac:	29860613          	addi	a2,a2,664 # ffffffffc0206140 <commands+0x828>
ffffffffc0202eb0:	22600593          	li	a1,550
ffffffffc0202eb4:	00003517          	auipc	a0,0x3
ffffffffc0202eb8:	78c50513          	addi	a0,a0,1932 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202ebc:	dd2fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(get_page(boot_pgdir_va, 0x0, NULL) == NULL);
ffffffffc0202ec0:	00004697          	auipc	a3,0x4
ffffffffc0202ec4:	8e868693          	addi	a3,a3,-1816 # ffffffffc02067a8 <default_pmm_manager+0x2b8>
ffffffffc0202ec8:	00003617          	auipc	a2,0x3
ffffffffc0202ecc:	27860613          	addi	a2,a2,632 # ffffffffc0206140 <commands+0x828>
ffffffffc0202ed0:	21900593          	li	a1,537
ffffffffc0202ed4:	00003517          	auipc	a0,0x3
ffffffffc0202ed8:	76c50513          	addi	a0,a0,1900 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202edc:	db2fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(boot_pgdir_va != NULL && (uint32_t)PGOFF(boot_pgdir_va) == 0);
ffffffffc0202ee0:	00004697          	auipc	a3,0x4
ffffffffc0202ee4:	88868693          	addi	a3,a3,-1912 # ffffffffc0206768 <default_pmm_manager+0x278>
ffffffffc0202ee8:	00003617          	auipc	a2,0x3
ffffffffc0202eec:	25860613          	addi	a2,a2,600 # ffffffffc0206140 <commands+0x828>
ffffffffc0202ef0:	21800593          	li	a1,536
ffffffffc0202ef4:	00003517          	auipc	a0,0x3
ffffffffc0202ef8:	74c50513          	addi	a0,a0,1868 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202efc:	d92fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(npage <= KERNTOP / PGSIZE);
ffffffffc0202f00:	00004697          	auipc	a3,0x4
ffffffffc0202f04:	84868693          	addi	a3,a3,-1976 # ffffffffc0206748 <default_pmm_manager+0x258>
ffffffffc0202f08:	00003617          	auipc	a2,0x3
ffffffffc0202f0c:	23860613          	addi	a2,a2,568 # ffffffffc0206140 <commands+0x828>
ffffffffc0202f10:	21700593          	li	a1,535
ffffffffc0202f14:	00003517          	auipc	a0,0x3
ffffffffc0202f18:	72c50513          	addi	a0,a0,1836 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202f1c:	d72fd0ef          	jal	ra,ffffffffc020048e <__panic>
    return KADDR(page2pa(page));
ffffffffc0202f20:	00003617          	auipc	a2,0x3
ffffffffc0202f24:	60860613          	addi	a2,a2,1544 # ffffffffc0206528 <default_pmm_manager+0x38>
ffffffffc0202f28:	07100593          	li	a1,113
ffffffffc0202f2c:	00003517          	auipc	a0,0x3
ffffffffc0202f30:	62450513          	addi	a0,a0,1572 # ffffffffc0206550 <default_pmm_manager+0x60>
ffffffffc0202f34:	d5afd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(pde2page(boot_pgdir_va[0])) == 1);
ffffffffc0202f38:	00004697          	auipc	a3,0x4
ffffffffc0202f3c:	ac068693          	addi	a3,a3,-1344 # ffffffffc02069f8 <default_pmm_manager+0x508>
ffffffffc0202f40:	00003617          	auipc	a2,0x3
ffffffffc0202f44:	20060613          	addi	a2,a2,512 # ffffffffc0206140 <commands+0x828>
ffffffffc0202f48:	23f00593          	li	a1,575
ffffffffc0202f4c:	00003517          	auipc	a0,0x3
ffffffffc0202f50:	6f450513          	addi	a0,a0,1780 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202f54:	d3afd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p2) == 0);
ffffffffc0202f58:	00004697          	auipc	a3,0x4
ffffffffc0202f5c:	a5868693          	addi	a3,a3,-1448 # ffffffffc02069b0 <default_pmm_manager+0x4c0>
ffffffffc0202f60:	00003617          	auipc	a2,0x3
ffffffffc0202f64:	1e060613          	addi	a2,a2,480 # ffffffffc0206140 <commands+0x828>
ffffffffc0202f68:	23d00593          	li	a1,573
ffffffffc0202f6c:	00003517          	auipc	a0,0x3
ffffffffc0202f70:	6d450513          	addi	a0,a0,1748 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202f74:	d1afd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p1) == 0);
ffffffffc0202f78:	00004697          	auipc	a3,0x4
ffffffffc0202f7c:	a6868693          	addi	a3,a3,-1432 # ffffffffc02069e0 <default_pmm_manager+0x4f0>
ffffffffc0202f80:	00003617          	auipc	a2,0x3
ffffffffc0202f84:	1c060613          	addi	a2,a2,448 # ffffffffc0206140 <commands+0x828>
ffffffffc0202f88:	23c00593          	li	a1,572
ffffffffc0202f8c:	00003517          	auipc	a0,0x3
ffffffffc0202f90:	6b450513          	addi	a0,a0,1716 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202f94:	cfafd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(boot_pgdir_va[0] == 0);
ffffffffc0202f98:	00004697          	auipc	a3,0x4
ffffffffc0202f9c:	b3068693          	addi	a3,a3,-1232 # ffffffffc0206ac8 <default_pmm_manager+0x5d8>
ffffffffc0202fa0:	00003617          	auipc	a2,0x3
ffffffffc0202fa4:	1a060613          	addi	a2,a2,416 # ffffffffc0206140 <commands+0x828>
ffffffffc0202fa8:	25a00593          	li	a1,602
ffffffffc0202fac:	00003517          	auipc	a0,0x3
ffffffffc0202fb0:	69450513          	addi	a0,a0,1684 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202fb4:	cdafd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free_store == nr_free_pages());
ffffffffc0202fb8:	00004697          	auipc	a3,0x4
ffffffffc0202fbc:	a7068693          	addi	a3,a3,-1424 # ffffffffc0206a28 <default_pmm_manager+0x538>
ffffffffc0202fc0:	00003617          	auipc	a2,0x3
ffffffffc0202fc4:	18060613          	addi	a2,a2,384 # ffffffffc0206140 <commands+0x828>
ffffffffc0202fc8:	24700593          	li	a1,583
ffffffffc0202fcc:	00003517          	auipc	a0,0x3
ffffffffc0202fd0:	67450513          	addi	a0,a0,1652 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202fd4:	cbafd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p) == 1);
ffffffffc0202fd8:	00004697          	auipc	a3,0x4
ffffffffc0202fdc:	b4868693          	addi	a3,a3,-1208 # ffffffffc0206b20 <default_pmm_manager+0x630>
ffffffffc0202fe0:	00003617          	auipc	a2,0x3
ffffffffc0202fe4:	16060613          	addi	a2,a2,352 # ffffffffc0206140 <commands+0x828>
ffffffffc0202fe8:	25f00593          	li	a1,607
ffffffffc0202fec:	00003517          	auipc	a0,0x3
ffffffffc0202ff0:	65450513          	addi	a0,a0,1620 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0202ff4:	c9afd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p, 0x100, PTE_W | PTE_R) == 0);
ffffffffc0202ff8:	00004697          	auipc	a3,0x4
ffffffffc0202ffc:	ae868693          	addi	a3,a3,-1304 # ffffffffc0206ae0 <default_pmm_manager+0x5f0>
ffffffffc0203000:	00003617          	auipc	a2,0x3
ffffffffc0203004:	14060613          	addi	a2,a2,320 # ffffffffc0206140 <commands+0x828>
ffffffffc0203008:	25e00593          	li	a1,606
ffffffffc020300c:	00003517          	auipc	a0,0x3
ffffffffc0203010:	63450513          	addi	a0,a0,1588 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0203014:	c7afd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p2) == 0);
ffffffffc0203018:	00004697          	auipc	a3,0x4
ffffffffc020301c:	99868693          	addi	a3,a3,-1640 # ffffffffc02069b0 <default_pmm_manager+0x4c0>
ffffffffc0203020:	00003617          	auipc	a2,0x3
ffffffffc0203024:	12060613          	addi	a2,a2,288 # ffffffffc0206140 <commands+0x828>
ffffffffc0203028:	23900593          	li	a1,569
ffffffffc020302c:	00003517          	auipc	a0,0x3
ffffffffc0203030:	61450513          	addi	a0,a0,1556 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0203034:	c5afd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p1) == 1);
ffffffffc0203038:	00004697          	auipc	a3,0x4
ffffffffc020303c:	81868693          	addi	a3,a3,-2024 # ffffffffc0206850 <default_pmm_manager+0x360>
ffffffffc0203040:	00003617          	auipc	a2,0x3
ffffffffc0203044:	10060613          	addi	a2,a2,256 # ffffffffc0206140 <commands+0x828>
ffffffffc0203048:	23800593          	li	a1,568
ffffffffc020304c:	00003517          	auipc	a0,0x3
ffffffffc0203050:	5f450513          	addi	a0,a0,1524 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0203054:	c3afd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((*ptep & PTE_U) == 0);
ffffffffc0203058:	00004697          	auipc	a3,0x4
ffffffffc020305c:	97068693          	addi	a3,a3,-1680 # ffffffffc02069c8 <default_pmm_manager+0x4d8>
ffffffffc0203060:	00003617          	auipc	a2,0x3
ffffffffc0203064:	0e060613          	addi	a2,a2,224 # ffffffffc0206140 <commands+0x828>
ffffffffc0203068:	23500593          	li	a1,565
ffffffffc020306c:	00003517          	auipc	a0,0x3
ffffffffc0203070:	5d450513          	addi	a0,a0,1492 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0203074:	c1afd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pte2page(*ptep) == p1);
ffffffffc0203078:	00003697          	auipc	a3,0x3
ffffffffc020307c:	7c068693          	addi	a3,a3,1984 # ffffffffc0206838 <default_pmm_manager+0x348>
ffffffffc0203080:	00003617          	auipc	a2,0x3
ffffffffc0203084:	0c060613          	addi	a2,a2,192 # ffffffffc0206140 <commands+0x828>
ffffffffc0203088:	23400593          	li	a1,564
ffffffffc020308c:	00003517          	auipc	a0,0x3
ffffffffc0203090:	5b450513          	addi	a0,a0,1460 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0203094:	bfafd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc0203098:	00004697          	auipc	a3,0x4
ffffffffc020309c:	84068693          	addi	a3,a3,-1984 # ffffffffc02068d8 <default_pmm_manager+0x3e8>
ffffffffc02030a0:	00003617          	auipc	a2,0x3
ffffffffc02030a4:	0a060613          	addi	a2,a2,160 # ffffffffc0206140 <commands+0x828>
ffffffffc02030a8:	23300593          	li	a1,563
ffffffffc02030ac:	00003517          	auipc	a0,0x3
ffffffffc02030b0:	59450513          	addi	a0,a0,1428 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc02030b4:	bdafd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p2) == 0);
ffffffffc02030b8:	00004697          	auipc	a3,0x4
ffffffffc02030bc:	8f868693          	addi	a3,a3,-1800 # ffffffffc02069b0 <default_pmm_manager+0x4c0>
ffffffffc02030c0:	00003617          	auipc	a2,0x3
ffffffffc02030c4:	08060613          	addi	a2,a2,128 # ffffffffc0206140 <commands+0x828>
ffffffffc02030c8:	23200593          	li	a1,562
ffffffffc02030cc:	00003517          	auipc	a0,0x3
ffffffffc02030d0:	57450513          	addi	a0,a0,1396 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc02030d4:	bbafd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p1) == 2);
ffffffffc02030d8:	00004697          	auipc	a3,0x4
ffffffffc02030dc:	8c068693          	addi	a3,a3,-1856 # ffffffffc0206998 <default_pmm_manager+0x4a8>
ffffffffc02030e0:	00003617          	auipc	a2,0x3
ffffffffc02030e4:	06060613          	addi	a2,a2,96 # ffffffffc0206140 <commands+0x828>
ffffffffc02030e8:	23100593          	li	a1,561
ffffffffc02030ec:	00003517          	auipc	a0,0x3
ffffffffc02030f0:	55450513          	addi	a0,a0,1364 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc02030f4:	b9afd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p1, PGSIZE, 0) == 0);
ffffffffc02030f8:	00004697          	auipc	a3,0x4
ffffffffc02030fc:	87068693          	addi	a3,a3,-1936 # ffffffffc0206968 <default_pmm_manager+0x478>
ffffffffc0203100:	00003617          	auipc	a2,0x3
ffffffffc0203104:	04060613          	addi	a2,a2,64 # ffffffffc0206140 <commands+0x828>
ffffffffc0203108:	23000593          	li	a1,560
ffffffffc020310c:	00003517          	auipc	a0,0x3
ffffffffc0203110:	53450513          	addi	a0,a0,1332 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0203114:	b7afd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p2) == 1);
ffffffffc0203118:	00004697          	auipc	a3,0x4
ffffffffc020311c:	83868693          	addi	a3,a3,-1992 # ffffffffc0206950 <default_pmm_manager+0x460>
ffffffffc0203120:	00003617          	auipc	a2,0x3
ffffffffc0203124:	02060613          	addi	a2,a2,32 # ffffffffc0206140 <commands+0x828>
ffffffffc0203128:	22e00593          	li	a1,558
ffffffffc020312c:	00003517          	auipc	a0,0x3
ffffffffc0203130:	51450513          	addi	a0,a0,1300 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0203134:	b5afd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(boot_pgdir_va[0] & PTE_U);
ffffffffc0203138:	00003697          	auipc	a3,0x3
ffffffffc020313c:	7f868693          	addi	a3,a3,2040 # ffffffffc0206930 <default_pmm_manager+0x440>
ffffffffc0203140:	00003617          	auipc	a2,0x3
ffffffffc0203144:	00060613          	mv	a2,a2
ffffffffc0203148:	22d00593          	li	a1,557
ffffffffc020314c:	00003517          	auipc	a0,0x3
ffffffffc0203150:	4f450513          	addi	a0,a0,1268 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0203154:	b3afd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(*ptep & PTE_W);
ffffffffc0203158:	00003697          	auipc	a3,0x3
ffffffffc020315c:	7c868693          	addi	a3,a3,1992 # ffffffffc0206920 <default_pmm_manager+0x430>
ffffffffc0203160:	00003617          	auipc	a2,0x3
ffffffffc0203164:	fe060613          	addi	a2,a2,-32 # ffffffffc0206140 <commands+0x828>
ffffffffc0203168:	22c00593          	li	a1,556
ffffffffc020316c:	00003517          	auipc	a0,0x3
ffffffffc0203170:	4d450513          	addi	a0,a0,1236 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0203174:	b1afd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(*ptep & PTE_U);
ffffffffc0203178:	00003697          	auipc	a3,0x3
ffffffffc020317c:	79868693          	addi	a3,a3,1944 # ffffffffc0206910 <default_pmm_manager+0x420>
ffffffffc0203180:	00003617          	auipc	a2,0x3
ffffffffc0203184:	fc060613          	addi	a2,a2,-64 # ffffffffc0206140 <commands+0x828>
ffffffffc0203188:	22b00593          	li	a1,555
ffffffffc020318c:	00003517          	auipc	a0,0x3
ffffffffc0203190:	4b450513          	addi	a0,a0,1204 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0203194:	afafd0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("DTB memory info not available");
ffffffffc0203198:	00003617          	auipc	a2,0x3
ffffffffc020319c:	51860613          	addi	a2,a2,1304 # ffffffffc02066b0 <default_pmm_manager+0x1c0>
ffffffffc02031a0:	06500593          	li	a1,101
ffffffffc02031a4:	00003517          	auipc	a0,0x3
ffffffffc02031a8:	49c50513          	addi	a0,a0,1180 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc02031ac:	ae2fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free_store == nr_free_pages());
ffffffffc02031b0:	00004697          	auipc	a3,0x4
ffffffffc02031b4:	87868693          	addi	a3,a3,-1928 # ffffffffc0206a28 <default_pmm_manager+0x538>
ffffffffc02031b8:	00003617          	auipc	a2,0x3
ffffffffc02031bc:	f8860613          	addi	a2,a2,-120 # ffffffffc0206140 <commands+0x828>
ffffffffc02031c0:	27100593          	li	a1,625
ffffffffc02031c4:	00003517          	auipc	a0,0x3
ffffffffc02031c8:	47c50513          	addi	a0,a0,1148 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc02031cc:	ac2fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02031d0:	00003697          	auipc	a3,0x3
ffffffffc02031d4:	70868693          	addi	a3,a3,1800 # ffffffffc02068d8 <default_pmm_manager+0x3e8>
ffffffffc02031d8:	00003617          	auipc	a2,0x3
ffffffffc02031dc:	f6860613          	addi	a2,a2,-152 # ffffffffc0206140 <commands+0x828>
ffffffffc02031e0:	22a00593          	li	a1,554
ffffffffc02031e4:	00003517          	auipc	a0,0x3
ffffffffc02031e8:	45c50513          	addi	a0,a0,1116 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc02031ec:	aa2fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p2, PGSIZE, PTE_U | PTE_W) == 0);
ffffffffc02031f0:	00003697          	auipc	a3,0x3
ffffffffc02031f4:	6a868693          	addi	a3,a3,1704 # ffffffffc0206898 <default_pmm_manager+0x3a8>
ffffffffc02031f8:	00003617          	auipc	a2,0x3
ffffffffc02031fc:	f4860613          	addi	a2,a2,-184 # ffffffffc0206140 <commands+0x828>
ffffffffc0203200:	22900593          	li	a1,553
ffffffffc0203204:	00003517          	auipc	a0,0x3
ffffffffc0203208:	43c50513          	addi	a0,a0,1084 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc020320c:	a82fd0ef          	jal	ra,ffffffffc020048e <__panic>
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc0203210:	86d6                	mv	a3,s5
ffffffffc0203212:	00003617          	auipc	a2,0x3
ffffffffc0203216:	31660613          	addi	a2,a2,790 # ffffffffc0206528 <default_pmm_manager+0x38>
ffffffffc020321a:	22500593          	li	a1,549
ffffffffc020321e:	00003517          	auipc	a0,0x3
ffffffffc0203222:	42250513          	addi	a0,a0,1058 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0203226:	a68fd0ef          	jal	ra,ffffffffc020048e <__panic>
    ptep = (pte_t *)KADDR(PDE_ADDR(boot_pgdir_va[0]));
ffffffffc020322a:	00003617          	auipc	a2,0x3
ffffffffc020322e:	2fe60613          	addi	a2,a2,766 # ffffffffc0206528 <default_pmm_manager+0x38>
ffffffffc0203232:	22400593          	li	a1,548
ffffffffc0203236:	00003517          	auipc	a0,0x3
ffffffffc020323a:	40a50513          	addi	a0,a0,1034 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc020323e:	a50fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p1) == 1);
ffffffffc0203242:	00003697          	auipc	a3,0x3
ffffffffc0203246:	60e68693          	addi	a3,a3,1550 # ffffffffc0206850 <default_pmm_manager+0x360>
ffffffffc020324a:	00003617          	auipc	a2,0x3
ffffffffc020324e:	ef660613          	addi	a2,a2,-266 # ffffffffc0206140 <commands+0x828>
ffffffffc0203252:	22200593          	li	a1,546
ffffffffc0203256:	00003517          	auipc	a0,0x3
ffffffffc020325a:	3ea50513          	addi	a0,a0,1002 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc020325e:	a30fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pte2page(*ptep) == p1);
ffffffffc0203262:	00003697          	auipc	a3,0x3
ffffffffc0203266:	5d668693          	addi	a3,a3,1494 # ffffffffc0206838 <default_pmm_manager+0x348>
ffffffffc020326a:	00003617          	auipc	a2,0x3
ffffffffc020326e:	ed660613          	addi	a2,a2,-298 # ffffffffc0206140 <commands+0x828>
ffffffffc0203272:	22100593          	li	a1,545
ffffffffc0203276:	00003517          	auipc	a0,0x3
ffffffffc020327a:	3ca50513          	addi	a0,a0,970 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc020327e:	a10fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(strlen((const char *)0x100) == 0);
ffffffffc0203282:	00004697          	auipc	a3,0x4
ffffffffc0203286:	96668693          	addi	a3,a3,-1690 # ffffffffc0206be8 <default_pmm_manager+0x6f8>
ffffffffc020328a:	00003617          	auipc	a2,0x3
ffffffffc020328e:	eb660613          	addi	a2,a2,-330 # ffffffffc0206140 <commands+0x828>
ffffffffc0203292:	26800593          	li	a1,616
ffffffffc0203296:	00003517          	auipc	a0,0x3
ffffffffc020329a:	3aa50513          	addi	a0,a0,938 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc020329e:	9f0fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
ffffffffc02032a2:	00004697          	auipc	a3,0x4
ffffffffc02032a6:	90e68693          	addi	a3,a3,-1778 # ffffffffc0206bb0 <default_pmm_manager+0x6c0>
ffffffffc02032aa:	00003617          	auipc	a2,0x3
ffffffffc02032ae:	e9660613          	addi	a2,a2,-362 # ffffffffc0206140 <commands+0x828>
ffffffffc02032b2:	26500593          	li	a1,613
ffffffffc02032b6:	00003517          	auipc	a0,0x3
ffffffffc02032ba:	38a50513          	addi	a0,a0,906 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc02032be:	9d0fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p) == 2);
ffffffffc02032c2:	00004697          	auipc	a3,0x4
ffffffffc02032c6:	8be68693          	addi	a3,a3,-1858 # ffffffffc0206b80 <default_pmm_manager+0x690>
ffffffffc02032ca:	00003617          	auipc	a2,0x3
ffffffffc02032ce:	e7660613          	addi	a2,a2,-394 # ffffffffc0206140 <commands+0x828>
ffffffffc02032d2:	26100593          	li	a1,609
ffffffffc02032d6:	00003517          	auipc	a0,0x3
ffffffffc02032da:	36a50513          	addi	a0,a0,874 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc02032de:	9b0fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p, 0x100 + PGSIZE, PTE_W | PTE_R) == 0);
ffffffffc02032e2:	00004697          	auipc	a3,0x4
ffffffffc02032e6:	85668693          	addi	a3,a3,-1962 # ffffffffc0206b38 <default_pmm_manager+0x648>
ffffffffc02032ea:	00003617          	auipc	a2,0x3
ffffffffc02032ee:	e5660613          	addi	a2,a2,-426 # ffffffffc0206140 <commands+0x828>
ffffffffc02032f2:	26000593          	li	a1,608
ffffffffc02032f6:	00003517          	auipc	a0,0x3
ffffffffc02032fa:	34a50513          	addi	a0,a0,842 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc02032fe:	990fd0ef          	jal	ra,ffffffffc020048e <__panic>
    boot_pgdir_pa = PADDR(boot_pgdir_va);
ffffffffc0203302:	00003617          	auipc	a2,0x3
ffffffffc0203306:	2ce60613          	addi	a2,a2,718 # ffffffffc02065d0 <default_pmm_manager+0xe0>
ffffffffc020330a:	0c900593          	li	a1,201
ffffffffc020330e:	00003517          	auipc	a0,0x3
ffffffffc0203312:	33250513          	addi	a0,a0,818 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc0203316:	978fd0ef          	jal	ra,ffffffffc020048e <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc020331a:	00003617          	auipc	a2,0x3
ffffffffc020331e:	2b660613          	addi	a2,a2,694 # ffffffffc02065d0 <default_pmm_manager+0xe0>
ffffffffc0203322:	08100593          	li	a1,129
ffffffffc0203326:	00003517          	auipc	a0,0x3
ffffffffc020332a:	31a50513          	addi	a0,a0,794 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc020332e:	960fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((ptep = get_pte(boot_pgdir_va, 0x0, 0)) != NULL);
ffffffffc0203332:	00003697          	auipc	a3,0x3
ffffffffc0203336:	4d668693          	addi	a3,a3,1238 # ffffffffc0206808 <default_pmm_manager+0x318>
ffffffffc020333a:	00003617          	auipc	a2,0x3
ffffffffc020333e:	e0660613          	addi	a2,a2,-506 # ffffffffc0206140 <commands+0x828>
ffffffffc0203342:	22000593          	li	a1,544
ffffffffc0203346:	00003517          	auipc	a0,0x3
ffffffffc020334a:	2fa50513          	addi	a0,a0,762 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc020334e:	940fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p1, 0x0, 0) == 0);
ffffffffc0203352:	00003697          	auipc	a3,0x3
ffffffffc0203356:	48668693          	addi	a3,a3,1158 # ffffffffc02067d8 <default_pmm_manager+0x2e8>
ffffffffc020335a:	00003617          	auipc	a2,0x3
ffffffffc020335e:	de660613          	addi	a2,a2,-538 # ffffffffc0206140 <commands+0x828>
ffffffffc0203362:	21d00593          	li	a1,541
ffffffffc0203366:	00003517          	auipc	a0,0x3
ffffffffc020336a:	2da50513          	addi	a0,a0,730 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc020336e:	920fd0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203372 <copy_range>:
{
ffffffffc0203372:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0203374:	00d667b3          	or	a5,a2,a3
{
ffffffffc0203378:	f486                	sd	ra,104(sp)
ffffffffc020337a:	f0a2                	sd	s0,96(sp)
ffffffffc020337c:	eca6                	sd	s1,88(sp)
ffffffffc020337e:	e8ca                	sd	s2,80(sp)
ffffffffc0203380:	e4ce                	sd	s3,72(sp)
ffffffffc0203382:	e0d2                	sd	s4,64(sp)
ffffffffc0203384:	fc56                	sd	s5,56(sp)
ffffffffc0203386:	f85a                	sd	s6,48(sp)
ffffffffc0203388:	f45e                	sd	s7,40(sp)
ffffffffc020338a:	f062                	sd	s8,32(sp)
ffffffffc020338c:	ec66                	sd	s9,24(sp)
ffffffffc020338e:	e86a                	sd	s10,16(sp)
ffffffffc0203390:	e46e                	sd	s11,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0203392:	17d2                	slli	a5,a5,0x34
ffffffffc0203394:	1e079e63          	bnez	a5,ffffffffc0203590 <copy_range+0x21e>
    assert(USER_ACCESS(start, end));
ffffffffc0203398:	002007b7          	lui	a5,0x200
ffffffffc020339c:	8432                	mv	s0,a2
ffffffffc020339e:	1af66963          	bltu	a2,a5,ffffffffc0203550 <copy_range+0x1de>
ffffffffc02033a2:	8936                	mv	s2,a3
ffffffffc02033a4:	1ad67663          	bgeu	a2,a3,ffffffffc0203550 <copy_range+0x1de>
ffffffffc02033a8:	4785                	li	a5,1
ffffffffc02033aa:	07fe                	slli	a5,a5,0x1f
ffffffffc02033ac:	1ad7e263          	bltu	a5,a3,ffffffffc0203550 <copy_range+0x1de>
ffffffffc02033b0:	5afd                	li	s5,-1
ffffffffc02033b2:	8a2a                	mv	s4,a0
ffffffffc02033b4:	89ae                	mv	s3,a1
    if (PPN(pa) >= npage)
ffffffffc02033b6:	000a7c17          	auipc	s8,0xa7
ffffffffc02033ba:	29ac0c13          	addi	s8,s8,666 # ffffffffc02aa650 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc02033be:	000a7b97          	auipc	s7,0xa7
ffffffffc02033c2:	29ab8b93          	addi	s7,s7,666 # ffffffffc02aa658 <pages>
    return page - pages + nbase;
ffffffffc02033c6:	00080b37          	lui	s6,0x80
    return KADDR(page2pa(page));
ffffffffc02033ca:	00cada93          	srli	s5,s5,0xc
        page = pmm_manager->alloc_pages(n);
ffffffffc02033ce:	000a7c97          	auipc	s9,0xa7
ffffffffc02033d2:	292c8c93          	addi	s9,s9,658 # ffffffffc02aa660 <pmm_manager>
        pte_t *ptep = get_pte(from, start, 0), *nptep;
ffffffffc02033d6:	4601                	li	a2,0
ffffffffc02033d8:	85a2                	mv	a1,s0
ffffffffc02033da:	854e                	mv	a0,s3
ffffffffc02033dc:	b71fe0ef          	jal	ra,ffffffffc0201f4c <get_pte>
ffffffffc02033e0:	84aa                	mv	s1,a0
        if (ptep == NULL)
ffffffffc02033e2:	c979                	beqz	a0,ffffffffc02034b8 <copy_range+0x146>
        if (*ptep & PTE_V)
ffffffffc02033e4:	611c                	ld	a5,0(a0)
ffffffffc02033e6:	8b85                	andi	a5,a5,1
ffffffffc02033e8:	e78d                	bnez	a5,ffffffffc0203412 <copy_range+0xa0>
        start += PGSIZE;
ffffffffc02033ea:	6785                	lui	a5,0x1
ffffffffc02033ec:	943e                	add	s0,s0,a5
    } while (start != 0 && start < end);
ffffffffc02033ee:	ff2464e3          	bltu	s0,s2,ffffffffc02033d6 <copy_range+0x64>
    return 0;
ffffffffc02033f2:	4501                	li	a0,0
}
ffffffffc02033f4:	70a6                	ld	ra,104(sp)
ffffffffc02033f6:	7406                	ld	s0,96(sp)
ffffffffc02033f8:	64e6                	ld	s1,88(sp)
ffffffffc02033fa:	6946                	ld	s2,80(sp)
ffffffffc02033fc:	69a6                	ld	s3,72(sp)
ffffffffc02033fe:	6a06                	ld	s4,64(sp)
ffffffffc0203400:	7ae2                	ld	s5,56(sp)
ffffffffc0203402:	7b42                	ld	s6,48(sp)
ffffffffc0203404:	7ba2                	ld	s7,40(sp)
ffffffffc0203406:	7c02                	ld	s8,32(sp)
ffffffffc0203408:	6ce2                	ld	s9,24(sp)
ffffffffc020340a:	6d42                	ld	s10,16(sp)
ffffffffc020340c:	6da2                	ld	s11,8(sp)
ffffffffc020340e:	6165                	addi	sp,sp,112
ffffffffc0203410:	8082                	ret
            if ((nptep = get_pte(to, start, 1)) == NULL)
ffffffffc0203412:	4605                	li	a2,1
ffffffffc0203414:	85a2                	mv	a1,s0
ffffffffc0203416:	8552                	mv	a0,s4
ffffffffc0203418:	b35fe0ef          	jal	ra,ffffffffc0201f4c <get_pte>
ffffffffc020341c:	c179                	beqz	a0,ffffffffc02034e2 <copy_range+0x170>
            uint32_t perm = (*ptep & PTE_USER);
ffffffffc020341e:	609c                	ld	a5,0(s1)
    if (!(pte & PTE_V))
ffffffffc0203420:	0017f713          	andi	a4,a5,1
ffffffffc0203424:	01f7f493          	andi	s1,a5,31
ffffffffc0203428:	10070863          	beqz	a4,ffffffffc0203538 <copy_range+0x1c6>
    if (PPN(pa) >= npage)
ffffffffc020342c:	000c3683          	ld	a3,0(s8)
    return pa2page(PTE_ADDR(pte));
ffffffffc0203430:	078a                	slli	a5,a5,0x2
ffffffffc0203432:	00c7d713          	srli	a4,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0203436:	0ed77563          	bgeu	a4,a3,ffffffffc0203520 <copy_range+0x1ae>
    return &pages[PPN(pa) - nbase];
ffffffffc020343a:	000bb783          	ld	a5,0(s7)
ffffffffc020343e:	fff806b7          	lui	a3,0xfff80
ffffffffc0203442:	9736                	add	a4,a4,a3
ffffffffc0203444:	071a                	slli	a4,a4,0x6
ffffffffc0203446:	00e78db3          	add	s11,a5,a4
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020344a:	10002773          	csrr	a4,sstatus
ffffffffc020344e:	8b09                	andi	a4,a4,2
ffffffffc0203450:	ef35                	bnez	a4,ffffffffc02034cc <copy_range+0x15a>
        page = pmm_manager->alloc_pages(n);
ffffffffc0203452:	000cb703          	ld	a4,0(s9)
ffffffffc0203456:	4505                	li	a0,1
ffffffffc0203458:	6f18                	ld	a4,24(a4)
ffffffffc020345a:	9702                	jalr	a4
ffffffffc020345c:	8d2a                	mv	s10,a0
            assert(page != NULL);
ffffffffc020345e:	0a0d8163          	beqz	s11,ffffffffc0203500 <copy_range+0x18e>
            assert(npage != NULL);
ffffffffc0203462:	100d0763          	beqz	s10,ffffffffc0203570 <copy_range+0x1fe>
    return page - pages + nbase;
ffffffffc0203466:	000bb703          	ld	a4,0(s7)
    return KADDR(page2pa(page));
ffffffffc020346a:	000c3603          	ld	a2,0(s8)
    return page - pages + nbase;
ffffffffc020346e:	40ed86b3          	sub	a3,s11,a4
ffffffffc0203472:	8699                	srai	a3,a3,0x6
ffffffffc0203474:	96da                	add	a3,a3,s6
    return KADDR(page2pa(page));
ffffffffc0203476:	0156f7b3          	and	a5,a3,s5
    return page2ppn(page) << PGSHIFT;
ffffffffc020347a:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc020347c:	06c7f663          	bgeu	a5,a2,ffffffffc02034e8 <copy_range+0x176>
    return page - pages + nbase;
ffffffffc0203480:	40ed07b3          	sub	a5,s10,a4
    return KADDR(page2pa(page));
ffffffffc0203484:	000a7717          	auipc	a4,0xa7
ffffffffc0203488:	1e470713          	addi	a4,a4,484 # ffffffffc02aa668 <va_pa_offset>
ffffffffc020348c:	6308                	ld	a0,0(a4)
    return page - pages + nbase;
ffffffffc020348e:	8799                	srai	a5,a5,0x6
ffffffffc0203490:	97da                	add	a5,a5,s6
    return KADDR(page2pa(page));
ffffffffc0203492:	0157f733          	and	a4,a5,s5
ffffffffc0203496:	00a685b3          	add	a1,a3,a0
    return page2ppn(page) << PGSHIFT;
ffffffffc020349a:	07b2                	slli	a5,a5,0xc
    return KADDR(page2pa(page));
ffffffffc020349c:	04c77563          	bgeu	a4,a2,ffffffffc02034e6 <copy_range+0x174>
            memcpy((void*)dst_kvaddr, (void*)src_kvaddr, PGSIZE);
ffffffffc02034a0:	6605                	lui	a2,0x1
ffffffffc02034a2:	953e                	add	a0,a0,a5
ffffffffc02034a4:	1f2020ef          	jal	ra,ffffffffc0205696 <memcpy>
            ret = page_insert(to, npage, start, perm);
ffffffffc02034a8:	86a6                	mv	a3,s1
ffffffffc02034aa:	8622                	mv	a2,s0
ffffffffc02034ac:	85ea                	mv	a1,s10
ffffffffc02034ae:	8552                	mv	a0,s4
ffffffffc02034b0:	98cff0ef          	jal	ra,ffffffffc020263c <page_insert>
            if (ret != 0) {
ffffffffc02034b4:	d91d                	beqz	a0,ffffffffc02033ea <copy_range+0x78>
ffffffffc02034b6:	bf3d                	j	ffffffffc02033f4 <copy_range+0x82>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc02034b8:	00200637          	lui	a2,0x200
ffffffffc02034bc:	9432                	add	s0,s0,a2
ffffffffc02034be:	ffe00637          	lui	a2,0xffe00
ffffffffc02034c2:	8c71                	and	s0,s0,a2
    } while (start != 0 && start < end);
ffffffffc02034c4:	d41d                	beqz	s0,ffffffffc02033f2 <copy_range+0x80>
ffffffffc02034c6:	f12468e3          	bltu	s0,s2,ffffffffc02033d6 <copy_range+0x64>
ffffffffc02034ca:	b725                	j	ffffffffc02033f2 <copy_range+0x80>
        intr_disable();
ffffffffc02034cc:	ce8fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc02034d0:	000cb703          	ld	a4,0(s9)
ffffffffc02034d4:	4505                	li	a0,1
ffffffffc02034d6:	6f18                	ld	a4,24(a4)
ffffffffc02034d8:	9702                	jalr	a4
ffffffffc02034da:	8d2a                	mv	s10,a0
        intr_enable();
ffffffffc02034dc:	cd2fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc02034e0:	bfbd                	j	ffffffffc020345e <copy_range+0xec>
                return -E_NO_MEM;
ffffffffc02034e2:	5571                	li	a0,-4
ffffffffc02034e4:	bf01                	j	ffffffffc02033f4 <copy_range+0x82>
ffffffffc02034e6:	86be                	mv	a3,a5
ffffffffc02034e8:	00003617          	auipc	a2,0x3
ffffffffc02034ec:	04060613          	addi	a2,a2,64 # ffffffffc0206528 <default_pmm_manager+0x38>
ffffffffc02034f0:	07100593          	li	a1,113
ffffffffc02034f4:	00003517          	auipc	a0,0x3
ffffffffc02034f8:	05c50513          	addi	a0,a0,92 # ffffffffc0206550 <default_pmm_manager+0x60>
ffffffffc02034fc:	f93fc0ef          	jal	ra,ffffffffc020048e <__panic>
            assert(page != NULL);
ffffffffc0203500:	00003697          	auipc	a3,0x3
ffffffffc0203504:	73068693          	addi	a3,a3,1840 # ffffffffc0206c30 <default_pmm_manager+0x740>
ffffffffc0203508:	00003617          	auipc	a2,0x3
ffffffffc020350c:	c3860613          	addi	a2,a2,-968 # ffffffffc0206140 <commands+0x828>
ffffffffc0203510:	19400593          	li	a1,404
ffffffffc0203514:	00003517          	auipc	a0,0x3
ffffffffc0203518:	12c50513          	addi	a0,a0,300 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc020351c:	f73fc0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0203520:	00003617          	auipc	a2,0x3
ffffffffc0203524:	0d860613          	addi	a2,a2,216 # ffffffffc02065f8 <default_pmm_manager+0x108>
ffffffffc0203528:	06900593          	li	a1,105
ffffffffc020352c:	00003517          	auipc	a0,0x3
ffffffffc0203530:	02450513          	addi	a0,a0,36 # ffffffffc0206550 <default_pmm_manager+0x60>
ffffffffc0203534:	f5bfc0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pte2page called with invalid pte");
ffffffffc0203538:	00003617          	auipc	a2,0x3
ffffffffc020353c:	0e060613          	addi	a2,a2,224 # ffffffffc0206618 <default_pmm_manager+0x128>
ffffffffc0203540:	07f00593          	li	a1,127
ffffffffc0203544:	00003517          	auipc	a0,0x3
ffffffffc0203548:	00c50513          	addi	a0,a0,12 # ffffffffc0206550 <default_pmm_manager+0x60>
ffffffffc020354c:	f43fc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc0203550:	00003697          	auipc	a3,0x3
ffffffffc0203554:	13068693          	addi	a3,a3,304 # ffffffffc0206680 <default_pmm_manager+0x190>
ffffffffc0203558:	00003617          	auipc	a2,0x3
ffffffffc020355c:	be860613          	addi	a2,a2,-1048 # ffffffffc0206140 <commands+0x828>
ffffffffc0203560:	17c00593          	li	a1,380
ffffffffc0203564:	00003517          	auipc	a0,0x3
ffffffffc0203568:	0dc50513          	addi	a0,a0,220 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc020356c:	f23fc0ef          	jal	ra,ffffffffc020048e <__panic>
            assert(npage != NULL);
ffffffffc0203570:	00003697          	auipc	a3,0x3
ffffffffc0203574:	6d068693          	addi	a3,a3,1744 # ffffffffc0206c40 <default_pmm_manager+0x750>
ffffffffc0203578:	00003617          	auipc	a2,0x3
ffffffffc020357c:	bc860613          	addi	a2,a2,-1080 # ffffffffc0206140 <commands+0x828>
ffffffffc0203580:	19500593          	li	a1,405
ffffffffc0203584:	00003517          	auipc	a0,0x3
ffffffffc0203588:	0bc50513          	addi	a0,a0,188 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc020358c:	f03fc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0203590:	00003697          	auipc	a3,0x3
ffffffffc0203594:	0c068693          	addi	a3,a3,192 # ffffffffc0206650 <default_pmm_manager+0x160>
ffffffffc0203598:	00003617          	auipc	a2,0x3
ffffffffc020359c:	ba860613          	addi	a2,a2,-1112 # ffffffffc0206140 <commands+0x828>
ffffffffc02035a0:	17b00593          	li	a1,379
ffffffffc02035a4:	00003517          	auipc	a0,0x3
ffffffffc02035a8:	09c50513          	addi	a0,a0,156 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc02035ac:	ee3fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02035b0 <pgdir_alloc_page>:
{
ffffffffc02035b0:	7179                	addi	sp,sp,-48
ffffffffc02035b2:	ec26                	sd	s1,24(sp)
ffffffffc02035b4:	e84a                	sd	s2,16(sp)
ffffffffc02035b6:	e052                	sd	s4,0(sp)
ffffffffc02035b8:	f406                	sd	ra,40(sp)
ffffffffc02035ba:	f022                	sd	s0,32(sp)
ffffffffc02035bc:	e44e                	sd	s3,8(sp)
ffffffffc02035be:	8a2a                	mv	s4,a0
ffffffffc02035c0:	84ae                	mv	s1,a1
ffffffffc02035c2:	8932                	mv	s2,a2
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02035c4:	100027f3          	csrr	a5,sstatus
ffffffffc02035c8:	8b89                	andi	a5,a5,2
        page = pmm_manager->alloc_pages(n);
ffffffffc02035ca:	000a7997          	auipc	s3,0xa7
ffffffffc02035ce:	09698993          	addi	s3,s3,150 # ffffffffc02aa660 <pmm_manager>
ffffffffc02035d2:	ef8d                	bnez	a5,ffffffffc020360c <pgdir_alloc_page+0x5c>
ffffffffc02035d4:	0009b783          	ld	a5,0(s3)
ffffffffc02035d8:	4505                	li	a0,1
ffffffffc02035da:	6f9c                	ld	a5,24(a5)
ffffffffc02035dc:	9782                	jalr	a5
ffffffffc02035de:	842a                	mv	s0,a0
    if (page != NULL)
ffffffffc02035e0:	cc09                	beqz	s0,ffffffffc02035fa <pgdir_alloc_page+0x4a>
        if (page_insert(pgdir, page, la, perm) != 0)
ffffffffc02035e2:	86ca                	mv	a3,s2
ffffffffc02035e4:	8626                	mv	a2,s1
ffffffffc02035e6:	85a2                	mv	a1,s0
ffffffffc02035e8:	8552                	mv	a0,s4
ffffffffc02035ea:	852ff0ef          	jal	ra,ffffffffc020263c <page_insert>
ffffffffc02035ee:	e915                	bnez	a0,ffffffffc0203622 <pgdir_alloc_page+0x72>
        assert(page_ref(page) == 1);
ffffffffc02035f0:	4018                	lw	a4,0(s0)
        page->pra_vaddr = la;
ffffffffc02035f2:	fc04                	sd	s1,56(s0)
        assert(page_ref(page) == 1);
ffffffffc02035f4:	4785                	li	a5,1
ffffffffc02035f6:	04f71e63          	bne	a4,a5,ffffffffc0203652 <pgdir_alloc_page+0xa2>
}
ffffffffc02035fa:	70a2                	ld	ra,40(sp)
ffffffffc02035fc:	8522                	mv	a0,s0
ffffffffc02035fe:	7402                	ld	s0,32(sp)
ffffffffc0203600:	64e2                	ld	s1,24(sp)
ffffffffc0203602:	6942                	ld	s2,16(sp)
ffffffffc0203604:	69a2                	ld	s3,8(sp)
ffffffffc0203606:	6a02                	ld	s4,0(sp)
ffffffffc0203608:	6145                	addi	sp,sp,48
ffffffffc020360a:	8082                	ret
        intr_disable();
ffffffffc020360c:	ba8fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0203610:	0009b783          	ld	a5,0(s3)
ffffffffc0203614:	4505                	li	a0,1
ffffffffc0203616:	6f9c                	ld	a5,24(a5)
ffffffffc0203618:	9782                	jalr	a5
ffffffffc020361a:	842a                	mv	s0,a0
        intr_enable();
ffffffffc020361c:	b92fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0203620:	b7c1                	j	ffffffffc02035e0 <pgdir_alloc_page+0x30>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203622:	100027f3          	csrr	a5,sstatus
ffffffffc0203626:	8b89                	andi	a5,a5,2
ffffffffc0203628:	eb89                	bnez	a5,ffffffffc020363a <pgdir_alloc_page+0x8a>
        pmm_manager->free_pages(base, n);
ffffffffc020362a:	0009b783          	ld	a5,0(s3)
ffffffffc020362e:	8522                	mv	a0,s0
ffffffffc0203630:	4585                	li	a1,1
ffffffffc0203632:	739c                	ld	a5,32(a5)
            return NULL;
ffffffffc0203634:	4401                	li	s0,0
        pmm_manager->free_pages(base, n);
ffffffffc0203636:	9782                	jalr	a5
    if (flag)
ffffffffc0203638:	b7c9                	j	ffffffffc02035fa <pgdir_alloc_page+0x4a>
        intr_disable();
ffffffffc020363a:	b7afd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc020363e:	0009b783          	ld	a5,0(s3)
ffffffffc0203642:	8522                	mv	a0,s0
ffffffffc0203644:	4585                	li	a1,1
ffffffffc0203646:	739c                	ld	a5,32(a5)
            return NULL;
ffffffffc0203648:	4401                	li	s0,0
        pmm_manager->free_pages(base, n);
ffffffffc020364a:	9782                	jalr	a5
        intr_enable();
ffffffffc020364c:	b62fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0203650:	b76d                	j	ffffffffc02035fa <pgdir_alloc_page+0x4a>
        assert(page_ref(page) == 1);
ffffffffc0203652:	00003697          	auipc	a3,0x3
ffffffffc0203656:	5fe68693          	addi	a3,a3,1534 # ffffffffc0206c50 <default_pmm_manager+0x760>
ffffffffc020365a:	00003617          	auipc	a2,0x3
ffffffffc020365e:	ae660613          	addi	a2,a2,-1306 # ffffffffc0206140 <commands+0x828>
ffffffffc0203662:	1fe00593          	li	a1,510
ffffffffc0203666:	00003517          	auipc	a0,0x3
ffffffffc020366a:	fda50513          	addi	a0,a0,-38 # ffffffffc0206640 <default_pmm_manager+0x150>
ffffffffc020366e:	e21fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203672 <check_vma_overlap.part.0>:
    return vma;
}

// check_vma_overlap - check if vma1 overlaps vma2 ?
static inline void
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
ffffffffc0203672:	1141                	addi	sp,sp,-16
{
    assert(prev->vm_start < prev->vm_end);
    assert(prev->vm_end <= next->vm_start);
    assert(next->vm_start < next->vm_end);
ffffffffc0203674:	00003697          	auipc	a3,0x3
ffffffffc0203678:	5f468693          	addi	a3,a3,1524 # ffffffffc0206c68 <default_pmm_manager+0x778>
ffffffffc020367c:	00003617          	auipc	a2,0x3
ffffffffc0203680:	ac460613          	addi	a2,a2,-1340 # ffffffffc0206140 <commands+0x828>
ffffffffc0203684:	07400593          	li	a1,116
ffffffffc0203688:	00003517          	auipc	a0,0x3
ffffffffc020368c:	60050513          	addi	a0,a0,1536 # ffffffffc0206c88 <default_pmm_manager+0x798>
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
ffffffffc0203690:	e406                	sd	ra,8(sp)
    assert(next->vm_start < next->vm_end);
ffffffffc0203692:	dfdfc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203696 <mm_create>:
{
ffffffffc0203696:	1141                	addi	sp,sp,-16
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0203698:	04000513          	li	a0,64
{
ffffffffc020369c:	e406                	sd	ra,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc020369e:	e18fe0ef          	jal	ra,ffffffffc0201cb6 <kmalloc>
    if (mm != NULL)
ffffffffc02036a2:	cd19                	beqz	a0,ffffffffc02036c0 <mm_create+0x2a>
    elm->prev = elm->next = elm;
ffffffffc02036a4:	e508                	sd	a0,8(a0)
ffffffffc02036a6:	e108                	sd	a0,0(a0)
        mm->mmap_cache = NULL;
ffffffffc02036a8:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc02036ac:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc02036b0:	02052023          	sw	zero,32(a0)
        mm->sm_priv = NULL;
ffffffffc02036b4:	02053423          	sd	zero,40(a0)
}

static inline void
set_mm_count(struct mm_struct *mm, int val)
{
    mm->mm_count = val;
ffffffffc02036b8:	02052823          	sw	zero,48(a0)
typedef volatile bool lock_t;

static inline void
lock_init(lock_t *lock)
{
    *lock = 0;
ffffffffc02036bc:	02053c23          	sd	zero,56(a0)
}
ffffffffc02036c0:	60a2                	ld	ra,8(sp)
ffffffffc02036c2:	0141                	addi	sp,sp,16
ffffffffc02036c4:	8082                	ret

ffffffffc02036c6 <find_vma>:
{
ffffffffc02036c6:	86aa                	mv	a3,a0
    if (mm != NULL)
ffffffffc02036c8:	c505                	beqz	a0,ffffffffc02036f0 <find_vma+0x2a>
        vma = mm->mmap_cache;
ffffffffc02036ca:	6908                	ld	a0,16(a0)
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr))
ffffffffc02036cc:	c501                	beqz	a0,ffffffffc02036d4 <find_vma+0xe>
ffffffffc02036ce:	651c                	ld	a5,8(a0)
ffffffffc02036d0:	02f5f263          	bgeu	a1,a5,ffffffffc02036f4 <find_vma+0x2e>
    return listelm->next;
ffffffffc02036d4:	669c                	ld	a5,8(a3)
            while ((le = list_next(le)) != list)
ffffffffc02036d6:	00f68d63          	beq	a3,a5,ffffffffc02036f0 <find_vma+0x2a>
                if (vma->vm_start <= addr && addr < vma->vm_end)
ffffffffc02036da:	fe87b703          	ld	a4,-24(a5) # fe8 <_binary_obj___user_faultread_out_size-0x8bb8>
ffffffffc02036de:	00e5e663          	bltu	a1,a4,ffffffffc02036ea <find_vma+0x24>
ffffffffc02036e2:	ff07b703          	ld	a4,-16(a5)
ffffffffc02036e6:	00e5ec63          	bltu	a1,a4,ffffffffc02036fe <find_vma+0x38>
ffffffffc02036ea:	679c                	ld	a5,8(a5)
            while ((le = list_next(le)) != list)
ffffffffc02036ec:	fef697e3          	bne	a3,a5,ffffffffc02036da <find_vma+0x14>
    struct vma_struct *vma = NULL;
ffffffffc02036f0:	4501                	li	a0,0
}
ffffffffc02036f2:	8082                	ret
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr))
ffffffffc02036f4:	691c                	ld	a5,16(a0)
ffffffffc02036f6:	fcf5ffe3          	bgeu	a1,a5,ffffffffc02036d4 <find_vma+0xe>
            mm->mmap_cache = vma;
ffffffffc02036fa:	ea88                	sd	a0,16(a3)
ffffffffc02036fc:	8082                	ret
                vma = le2vma(le, list_link);
ffffffffc02036fe:	fe078513          	addi	a0,a5,-32
            mm->mmap_cache = vma;
ffffffffc0203702:	ea88                	sd	a0,16(a3)
ffffffffc0203704:	8082                	ret

ffffffffc0203706 <insert_vma_struct>:
}

// insert_vma_struct -insert vma in mm's list link
void insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma)
{
    assert(vma->vm_start < vma->vm_end);
ffffffffc0203706:	6590                	ld	a2,8(a1)
ffffffffc0203708:	0105b803          	ld	a6,16(a1)
{
ffffffffc020370c:	1141                	addi	sp,sp,-16
ffffffffc020370e:	e406                	sd	ra,8(sp)
ffffffffc0203710:	87aa                	mv	a5,a0
    assert(vma->vm_start < vma->vm_end);
ffffffffc0203712:	01066763          	bltu	a2,a6,ffffffffc0203720 <insert_vma_struct+0x1a>
ffffffffc0203716:	a085                	j	ffffffffc0203776 <insert_vma_struct+0x70>

    list_entry_t *le = list;
    while ((le = list_next(le)) != list)
    {
        struct vma_struct *mmap_prev = le2vma(le, list_link);
        if (mmap_prev->vm_start > vma->vm_start)
ffffffffc0203718:	fe87b703          	ld	a4,-24(a5)
ffffffffc020371c:	04e66863          	bltu	a2,a4,ffffffffc020376c <insert_vma_struct+0x66>
ffffffffc0203720:	86be                	mv	a3,a5
ffffffffc0203722:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != list)
ffffffffc0203724:	fef51ae3          	bne	a0,a5,ffffffffc0203718 <insert_vma_struct+0x12>
    }

    le_next = list_next(le_prev);

    /* check overlap */
    if (le_prev != list)
ffffffffc0203728:	02a68463          	beq	a3,a0,ffffffffc0203750 <insert_vma_struct+0x4a>
    {
        check_vma_overlap(le2vma(le_prev, list_link), vma);
ffffffffc020372c:	ff06b703          	ld	a4,-16(a3)
    assert(prev->vm_start < prev->vm_end);
ffffffffc0203730:	fe86b883          	ld	a7,-24(a3)
ffffffffc0203734:	08e8f163          	bgeu	a7,a4,ffffffffc02037b6 <insert_vma_struct+0xb0>
    assert(prev->vm_end <= next->vm_start);
ffffffffc0203738:	04e66f63          	bltu	a2,a4,ffffffffc0203796 <insert_vma_struct+0x90>
    }
    if (le_next != list)
ffffffffc020373c:	00f50a63          	beq	a0,a5,ffffffffc0203750 <insert_vma_struct+0x4a>
        if (mmap_prev->vm_start > vma->vm_start)
ffffffffc0203740:	fe87b703          	ld	a4,-24(a5)
    assert(prev->vm_end <= next->vm_start);
ffffffffc0203744:	05076963          	bltu	a4,a6,ffffffffc0203796 <insert_vma_struct+0x90>
    assert(next->vm_start < next->vm_end);
ffffffffc0203748:	ff07b603          	ld	a2,-16(a5)
ffffffffc020374c:	02c77363          	bgeu	a4,a2,ffffffffc0203772 <insert_vma_struct+0x6c>
    }

    vma->vm_mm = mm;
    list_add_after(le_prev, &(vma->list_link));

    mm->map_count++;
ffffffffc0203750:	5118                	lw	a4,32(a0)
    vma->vm_mm = mm;
ffffffffc0203752:	e188                	sd	a0,0(a1)
    list_add_after(le_prev, &(vma->list_link));
ffffffffc0203754:	02058613          	addi	a2,a1,32
    prev->next = next->prev = elm;
ffffffffc0203758:	e390                	sd	a2,0(a5)
ffffffffc020375a:	e690                	sd	a2,8(a3)
}
ffffffffc020375c:	60a2                	ld	ra,8(sp)
    elm->next = next;
ffffffffc020375e:	f59c                	sd	a5,40(a1)
    elm->prev = prev;
ffffffffc0203760:	f194                	sd	a3,32(a1)
    mm->map_count++;
ffffffffc0203762:	0017079b          	addiw	a5,a4,1
ffffffffc0203766:	d11c                	sw	a5,32(a0)
}
ffffffffc0203768:	0141                	addi	sp,sp,16
ffffffffc020376a:	8082                	ret
    if (le_prev != list)
ffffffffc020376c:	fca690e3          	bne	a3,a0,ffffffffc020372c <insert_vma_struct+0x26>
ffffffffc0203770:	bfd1                	j	ffffffffc0203744 <insert_vma_struct+0x3e>
ffffffffc0203772:	f01ff0ef          	jal	ra,ffffffffc0203672 <check_vma_overlap.part.0>
    assert(vma->vm_start < vma->vm_end);
ffffffffc0203776:	00003697          	auipc	a3,0x3
ffffffffc020377a:	52268693          	addi	a3,a3,1314 # ffffffffc0206c98 <default_pmm_manager+0x7a8>
ffffffffc020377e:	00003617          	auipc	a2,0x3
ffffffffc0203782:	9c260613          	addi	a2,a2,-1598 # ffffffffc0206140 <commands+0x828>
ffffffffc0203786:	07a00593          	li	a1,122
ffffffffc020378a:	00003517          	auipc	a0,0x3
ffffffffc020378e:	4fe50513          	addi	a0,a0,1278 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc0203792:	cfdfc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(prev->vm_end <= next->vm_start);
ffffffffc0203796:	00003697          	auipc	a3,0x3
ffffffffc020379a:	54268693          	addi	a3,a3,1346 # ffffffffc0206cd8 <default_pmm_manager+0x7e8>
ffffffffc020379e:	00003617          	auipc	a2,0x3
ffffffffc02037a2:	9a260613          	addi	a2,a2,-1630 # ffffffffc0206140 <commands+0x828>
ffffffffc02037a6:	07300593          	li	a1,115
ffffffffc02037aa:	00003517          	auipc	a0,0x3
ffffffffc02037ae:	4de50513          	addi	a0,a0,1246 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc02037b2:	cddfc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(prev->vm_start < prev->vm_end);
ffffffffc02037b6:	00003697          	auipc	a3,0x3
ffffffffc02037ba:	50268693          	addi	a3,a3,1282 # ffffffffc0206cb8 <default_pmm_manager+0x7c8>
ffffffffc02037be:	00003617          	auipc	a2,0x3
ffffffffc02037c2:	98260613          	addi	a2,a2,-1662 # ffffffffc0206140 <commands+0x828>
ffffffffc02037c6:	07200593          	li	a1,114
ffffffffc02037ca:	00003517          	auipc	a0,0x3
ffffffffc02037ce:	4be50513          	addi	a0,a0,1214 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc02037d2:	cbdfc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02037d6 <mm_destroy>:

// mm_destroy - free mm and mm internal fields
void mm_destroy(struct mm_struct *mm)
{
    assert(mm_count(mm) == 0);
ffffffffc02037d6:	591c                	lw	a5,48(a0)
{
ffffffffc02037d8:	1141                	addi	sp,sp,-16
ffffffffc02037da:	e406                	sd	ra,8(sp)
ffffffffc02037dc:	e022                	sd	s0,0(sp)
    assert(mm_count(mm) == 0);
ffffffffc02037de:	e78d                	bnez	a5,ffffffffc0203808 <mm_destroy+0x32>
ffffffffc02037e0:	842a                	mv	s0,a0
    return listelm->next;
ffffffffc02037e2:	6508                	ld	a0,8(a0)

    list_entry_t *list = &(mm->mmap_list), *le;
    while ((le = list_next(list)) != list)
ffffffffc02037e4:	00a40c63          	beq	s0,a0,ffffffffc02037fc <mm_destroy+0x26>
    __list_del(listelm->prev, listelm->next);
ffffffffc02037e8:	6118                	ld	a4,0(a0)
ffffffffc02037ea:	651c                	ld	a5,8(a0)
    {
        list_del(le);
        kfree(le2vma(le, list_link)); // kfree vma
ffffffffc02037ec:	1501                	addi	a0,a0,-32
    prev->next = next;
ffffffffc02037ee:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc02037f0:	e398                	sd	a4,0(a5)
ffffffffc02037f2:	d74fe0ef          	jal	ra,ffffffffc0201d66 <kfree>
    return listelm->next;
ffffffffc02037f6:	6408                	ld	a0,8(s0)
    while ((le = list_next(list)) != list)
ffffffffc02037f8:	fea418e3          	bne	s0,a0,ffffffffc02037e8 <mm_destroy+0x12>
    }
    kfree(mm); // kfree mm
ffffffffc02037fc:	8522                	mv	a0,s0
    mm = NULL;
}
ffffffffc02037fe:	6402                	ld	s0,0(sp)
ffffffffc0203800:	60a2                	ld	ra,8(sp)
ffffffffc0203802:	0141                	addi	sp,sp,16
    kfree(mm); // kfree mm
ffffffffc0203804:	d62fe06f          	j	ffffffffc0201d66 <kfree>
    assert(mm_count(mm) == 0);
ffffffffc0203808:	00003697          	auipc	a3,0x3
ffffffffc020380c:	4f068693          	addi	a3,a3,1264 # ffffffffc0206cf8 <default_pmm_manager+0x808>
ffffffffc0203810:	00003617          	auipc	a2,0x3
ffffffffc0203814:	93060613          	addi	a2,a2,-1744 # ffffffffc0206140 <commands+0x828>
ffffffffc0203818:	09e00593          	li	a1,158
ffffffffc020381c:	00003517          	auipc	a0,0x3
ffffffffc0203820:	46c50513          	addi	a0,a0,1132 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc0203824:	c6bfc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203828 <mm_map>:

int mm_map(struct mm_struct *mm, uintptr_t addr, size_t len, uint32_t vm_flags,
           struct vma_struct **vma_store)
{
ffffffffc0203828:	7139                	addi	sp,sp,-64
ffffffffc020382a:	f822                	sd	s0,48(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc020382c:	6405                	lui	s0,0x1
ffffffffc020382e:	147d                	addi	s0,s0,-1
ffffffffc0203830:	77fd                	lui	a5,0xfffff
ffffffffc0203832:	9622                	add	a2,a2,s0
ffffffffc0203834:	962e                	add	a2,a2,a1
{
ffffffffc0203836:	f426                	sd	s1,40(sp)
ffffffffc0203838:	fc06                	sd	ra,56(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc020383a:	00f5f4b3          	and	s1,a1,a5
{
ffffffffc020383e:	f04a                	sd	s2,32(sp)
ffffffffc0203840:	ec4e                	sd	s3,24(sp)
ffffffffc0203842:	e852                	sd	s4,16(sp)
ffffffffc0203844:	e456                	sd	s5,8(sp)
    if (!USER_ACCESS(start, end))
ffffffffc0203846:	002005b7          	lui	a1,0x200
ffffffffc020384a:	00f67433          	and	s0,a2,a5
ffffffffc020384e:	06b4e363          	bltu	s1,a1,ffffffffc02038b4 <mm_map+0x8c>
ffffffffc0203852:	0684f163          	bgeu	s1,s0,ffffffffc02038b4 <mm_map+0x8c>
ffffffffc0203856:	4785                	li	a5,1
ffffffffc0203858:	07fe                	slli	a5,a5,0x1f
ffffffffc020385a:	0487ed63          	bltu	a5,s0,ffffffffc02038b4 <mm_map+0x8c>
ffffffffc020385e:	89aa                	mv	s3,a0
    {
        return -E_INVAL;
    }

    assert(mm != NULL);
ffffffffc0203860:	cd21                	beqz	a0,ffffffffc02038b8 <mm_map+0x90>

    int ret = -E_INVAL;

    struct vma_struct *vma;
    if ((vma = find_vma(mm, start)) != NULL && end > vma->vm_start)
ffffffffc0203862:	85a6                	mv	a1,s1
ffffffffc0203864:	8ab6                	mv	s5,a3
ffffffffc0203866:	8a3a                	mv	s4,a4
ffffffffc0203868:	e5fff0ef          	jal	ra,ffffffffc02036c6 <find_vma>
ffffffffc020386c:	c501                	beqz	a0,ffffffffc0203874 <mm_map+0x4c>
ffffffffc020386e:	651c                	ld	a5,8(a0)
ffffffffc0203870:	0487e263          	bltu	a5,s0,ffffffffc02038b4 <mm_map+0x8c>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203874:	03000513          	li	a0,48
ffffffffc0203878:	c3efe0ef          	jal	ra,ffffffffc0201cb6 <kmalloc>
ffffffffc020387c:	892a                	mv	s2,a0
    {
        goto out;
    }
    ret = -E_NO_MEM;
ffffffffc020387e:	5571                	li	a0,-4
    if (vma != NULL)
ffffffffc0203880:	02090163          	beqz	s2,ffffffffc02038a2 <mm_map+0x7a>

    if ((vma = vma_create(start, end, vm_flags)) == NULL)
    {
        goto out;
    }
    insert_vma_struct(mm, vma);
ffffffffc0203884:	854e                	mv	a0,s3
        vma->vm_start = vm_start;
ffffffffc0203886:	00993423          	sd	s1,8(s2)
        vma->vm_end = vm_end;
ffffffffc020388a:	00893823          	sd	s0,16(s2)
        vma->vm_flags = vm_flags;
ffffffffc020388e:	01592c23          	sw	s5,24(s2)
    insert_vma_struct(mm, vma);
ffffffffc0203892:	85ca                	mv	a1,s2
ffffffffc0203894:	e73ff0ef          	jal	ra,ffffffffc0203706 <insert_vma_struct>
    if (vma_store != NULL)
    {
        *vma_store = vma;
    }
    ret = 0;
ffffffffc0203898:	4501                	li	a0,0
    if (vma_store != NULL)
ffffffffc020389a:	000a0463          	beqz	s4,ffffffffc02038a2 <mm_map+0x7a>
        *vma_store = vma;
ffffffffc020389e:	012a3023          	sd	s2,0(s4)

out:
    return ret;
}
ffffffffc02038a2:	70e2                	ld	ra,56(sp)
ffffffffc02038a4:	7442                	ld	s0,48(sp)
ffffffffc02038a6:	74a2                	ld	s1,40(sp)
ffffffffc02038a8:	7902                	ld	s2,32(sp)
ffffffffc02038aa:	69e2                	ld	s3,24(sp)
ffffffffc02038ac:	6a42                	ld	s4,16(sp)
ffffffffc02038ae:	6aa2                	ld	s5,8(sp)
ffffffffc02038b0:	6121                	addi	sp,sp,64
ffffffffc02038b2:	8082                	ret
        return -E_INVAL;
ffffffffc02038b4:	5575                	li	a0,-3
ffffffffc02038b6:	b7f5                	j	ffffffffc02038a2 <mm_map+0x7a>
    assert(mm != NULL);
ffffffffc02038b8:	00003697          	auipc	a3,0x3
ffffffffc02038bc:	45868693          	addi	a3,a3,1112 # ffffffffc0206d10 <default_pmm_manager+0x820>
ffffffffc02038c0:	00003617          	auipc	a2,0x3
ffffffffc02038c4:	88060613          	addi	a2,a2,-1920 # ffffffffc0206140 <commands+0x828>
ffffffffc02038c8:	0b300593          	li	a1,179
ffffffffc02038cc:	00003517          	auipc	a0,0x3
ffffffffc02038d0:	3bc50513          	addi	a0,a0,956 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc02038d4:	bbbfc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02038d8 <dup_mmap>:

int dup_mmap(struct mm_struct *to, struct mm_struct *from)
{
ffffffffc02038d8:	7139                	addi	sp,sp,-64
ffffffffc02038da:	fc06                	sd	ra,56(sp)
ffffffffc02038dc:	f822                	sd	s0,48(sp)
ffffffffc02038de:	f426                	sd	s1,40(sp)
ffffffffc02038e0:	f04a                	sd	s2,32(sp)
ffffffffc02038e2:	ec4e                	sd	s3,24(sp)
ffffffffc02038e4:	e852                	sd	s4,16(sp)
ffffffffc02038e6:	e456                	sd	s5,8(sp)
    assert(to != NULL && from != NULL);
ffffffffc02038e8:	c52d                	beqz	a0,ffffffffc0203952 <dup_mmap+0x7a>
ffffffffc02038ea:	892a                	mv	s2,a0
ffffffffc02038ec:	84ae                	mv	s1,a1
    list_entry_t *list = &(from->mmap_list), *le = list;
ffffffffc02038ee:	842e                	mv	s0,a1
    assert(to != NULL && from != NULL);
ffffffffc02038f0:	e595                	bnez	a1,ffffffffc020391c <dup_mmap+0x44>
ffffffffc02038f2:	a085                	j	ffffffffc0203952 <dup_mmap+0x7a>
        if (nvma == NULL)
        {
            return -E_NO_MEM;
        }

        insert_vma_struct(to, nvma);
ffffffffc02038f4:	854a                	mv	a0,s2
        vma->vm_start = vm_start;
ffffffffc02038f6:	0155b423          	sd	s5,8(a1) # 200008 <_binary_obj___user_exit_out_size+0x1f4ef0>
        vma->vm_end = vm_end;
ffffffffc02038fa:	0145b823          	sd	s4,16(a1)
        vma->vm_flags = vm_flags;
ffffffffc02038fe:	0135ac23          	sw	s3,24(a1)
        insert_vma_struct(to, nvma);
ffffffffc0203902:	e05ff0ef          	jal	ra,ffffffffc0203706 <insert_vma_struct>

        bool share = 0;
        if (copy_range(to->pgdir, from->pgdir, vma->vm_start, vma->vm_end, share) != 0)
ffffffffc0203906:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_obj___user_faultread_out_size-0x8bb0>
ffffffffc020390a:	fe843603          	ld	a2,-24(s0)
ffffffffc020390e:	6c8c                	ld	a1,24(s1)
ffffffffc0203910:	01893503          	ld	a0,24(s2)
ffffffffc0203914:	4701                	li	a4,0
ffffffffc0203916:	a5dff0ef          	jal	ra,ffffffffc0203372 <copy_range>
ffffffffc020391a:	e105                	bnez	a0,ffffffffc020393a <dup_mmap+0x62>
    return listelm->prev;
ffffffffc020391c:	6000                	ld	s0,0(s0)
    while ((le = list_prev(le)) != list)
ffffffffc020391e:	02848863          	beq	s1,s0,ffffffffc020394e <dup_mmap+0x76>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203922:	03000513          	li	a0,48
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
ffffffffc0203926:	fe843a83          	ld	s5,-24(s0)
ffffffffc020392a:	ff043a03          	ld	s4,-16(s0)
ffffffffc020392e:	ff842983          	lw	s3,-8(s0)
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203932:	b84fe0ef          	jal	ra,ffffffffc0201cb6 <kmalloc>
ffffffffc0203936:	85aa                	mv	a1,a0
    if (vma != NULL)
ffffffffc0203938:	fd55                	bnez	a0,ffffffffc02038f4 <dup_mmap+0x1c>
            return -E_NO_MEM;
ffffffffc020393a:	5571                	li	a0,-4
        {
            return -E_NO_MEM;
        }
    }
    return 0;
}
ffffffffc020393c:	70e2                	ld	ra,56(sp)
ffffffffc020393e:	7442                	ld	s0,48(sp)
ffffffffc0203940:	74a2                	ld	s1,40(sp)
ffffffffc0203942:	7902                	ld	s2,32(sp)
ffffffffc0203944:	69e2                	ld	s3,24(sp)
ffffffffc0203946:	6a42                	ld	s4,16(sp)
ffffffffc0203948:	6aa2                	ld	s5,8(sp)
ffffffffc020394a:	6121                	addi	sp,sp,64
ffffffffc020394c:	8082                	ret
    return 0;
ffffffffc020394e:	4501                	li	a0,0
ffffffffc0203950:	b7f5                	j	ffffffffc020393c <dup_mmap+0x64>
    assert(to != NULL && from != NULL);
ffffffffc0203952:	00003697          	auipc	a3,0x3
ffffffffc0203956:	3ce68693          	addi	a3,a3,974 # ffffffffc0206d20 <default_pmm_manager+0x830>
ffffffffc020395a:	00002617          	auipc	a2,0x2
ffffffffc020395e:	7e660613          	addi	a2,a2,2022 # ffffffffc0206140 <commands+0x828>
ffffffffc0203962:	0cf00593          	li	a1,207
ffffffffc0203966:	00003517          	auipc	a0,0x3
ffffffffc020396a:	32250513          	addi	a0,a0,802 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc020396e:	b21fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203972 <exit_mmap>:

void exit_mmap(struct mm_struct *mm)
{
ffffffffc0203972:	1101                	addi	sp,sp,-32
ffffffffc0203974:	ec06                	sd	ra,24(sp)
ffffffffc0203976:	e822                	sd	s0,16(sp)
ffffffffc0203978:	e426                	sd	s1,8(sp)
ffffffffc020397a:	e04a                	sd	s2,0(sp)
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc020397c:	c531                	beqz	a0,ffffffffc02039c8 <exit_mmap+0x56>
ffffffffc020397e:	591c                	lw	a5,48(a0)
ffffffffc0203980:	84aa                	mv	s1,a0
ffffffffc0203982:	e3b9                	bnez	a5,ffffffffc02039c8 <exit_mmap+0x56>
    return listelm->next;
ffffffffc0203984:	6500                	ld	s0,8(a0)
    pde_t *pgdir = mm->pgdir;
ffffffffc0203986:	01853903          	ld	s2,24(a0)
    list_entry_t *list = &(mm->mmap_list), *le = list;
    while ((le = list_next(le)) != list)
ffffffffc020398a:	02850663          	beq	a0,s0,ffffffffc02039b6 <exit_mmap+0x44>
    {
        struct vma_struct *vma = le2vma(le, list_link);
        unmap_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc020398e:	ff043603          	ld	a2,-16(s0)
ffffffffc0203992:	fe843583          	ld	a1,-24(s0)
ffffffffc0203996:	854a                	mv	a0,s2
ffffffffc0203998:	831fe0ef          	jal	ra,ffffffffc02021c8 <unmap_range>
ffffffffc020399c:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list)
ffffffffc020399e:	fe8498e3          	bne	s1,s0,ffffffffc020398e <exit_mmap+0x1c>
ffffffffc02039a2:	6400                	ld	s0,8(s0)
    }
    while ((le = list_next(le)) != list)
ffffffffc02039a4:	00848c63          	beq	s1,s0,ffffffffc02039bc <exit_mmap+0x4a>
    {
        struct vma_struct *vma = le2vma(le, list_link);
        exit_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc02039a8:	ff043603          	ld	a2,-16(s0)
ffffffffc02039ac:	fe843583          	ld	a1,-24(s0)
ffffffffc02039b0:	854a                	mv	a0,s2
ffffffffc02039b2:	95dfe0ef          	jal	ra,ffffffffc020230e <exit_range>
ffffffffc02039b6:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list)
ffffffffc02039b8:	fe8498e3          	bne	s1,s0,ffffffffc02039a8 <exit_mmap+0x36>
    }
}
ffffffffc02039bc:	60e2                	ld	ra,24(sp)
ffffffffc02039be:	6442                	ld	s0,16(sp)
ffffffffc02039c0:	64a2                	ld	s1,8(sp)
ffffffffc02039c2:	6902                	ld	s2,0(sp)
ffffffffc02039c4:	6105                	addi	sp,sp,32
ffffffffc02039c6:	8082                	ret
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc02039c8:	00003697          	auipc	a3,0x3
ffffffffc02039cc:	37868693          	addi	a3,a3,888 # ffffffffc0206d40 <default_pmm_manager+0x850>
ffffffffc02039d0:	00002617          	auipc	a2,0x2
ffffffffc02039d4:	77060613          	addi	a2,a2,1904 # ffffffffc0206140 <commands+0x828>
ffffffffc02039d8:	0e800593          	li	a1,232
ffffffffc02039dc:	00003517          	auipc	a0,0x3
ffffffffc02039e0:	2ac50513          	addi	a0,a0,684 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc02039e4:	aabfc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02039e8 <vmm_init>:
}

// vmm_init - initialize virtual memory management
//          - now just call check_vmm to check correctness of vmm
void vmm_init(void)
{
ffffffffc02039e8:	7139                	addi	sp,sp,-64
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc02039ea:	04000513          	li	a0,64
{
ffffffffc02039ee:	fc06                	sd	ra,56(sp)
ffffffffc02039f0:	f822                	sd	s0,48(sp)
ffffffffc02039f2:	f426                	sd	s1,40(sp)
ffffffffc02039f4:	f04a                	sd	s2,32(sp)
ffffffffc02039f6:	ec4e                	sd	s3,24(sp)
ffffffffc02039f8:	e852                	sd	s4,16(sp)
ffffffffc02039fa:	e456                	sd	s5,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc02039fc:	abafe0ef          	jal	ra,ffffffffc0201cb6 <kmalloc>
    if (mm != NULL)
ffffffffc0203a00:	2e050663          	beqz	a0,ffffffffc0203cec <vmm_init+0x304>
ffffffffc0203a04:	84aa                	mv	s1,a0
    elm->prev = elm->next = elm;
ffffffffc0203a06:	e508                	sd	a0,8(a0)
ffffffffc0203a08:	e108                	sd	a0,0(a0)
        mm->mmap_cache = NULL;
ffffffffc0203a0a:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc0203a0e:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc0203a12:	02052023          	sw	zero,32(a0)
        mm->sm_priv = NULL;
ffffffffc0203a16:	02053423          	sd	zero,40(a0)
ffffffffc0203a1a:	02052823          	sw	zero,48(a0)
ffffffffc0203a1e:	02053c23          	sd	zero,56(a0)
ffffffffc0203a22:	03200413          	li	s0,50
ffffffffc0203a26:	a811                	j	ffffffffc0203a3a <vmm_init+0x52>
        vma->vm_start = vm_start;
ffffffffc0203a28:	e500                	sd	s0,8(a0)
        vma->vm_end = vm_end;
ffffffffc0203a2a:	e91c                	sd	a5,16(a0)
        vma->vm_flags = vm_flags;
ffffffffc0203a2c:	00052c23          	sw	zero,24(a0)
    assert(mm != NULL);

    int step1 = 10, step2 = step1 * 10;

    int i;
    for (i = step1; i >= 1; i--)
ffffffffc0203a30:	146d                	addi	s0,s0,-5
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
ffffffffc0203a32:	8526                	mv	a0,s1
ffffffffc0203a34:	cd3ff0ef          	jal	ra,ffffffffc0203706 <insert_vma_struct>
    for (i = step1; i >= 1; i--)
ffffffffc0203a38:	c80d                	beqz	s0,ffffffffc0203a6a <vmm_init+0x82>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203a3a:	03000513          	li	a0,48
ffffffffc0203a3e:	a78fe0ef          	jal	ra,ffffffffc0201cb6 <kmalloc>
ffffffffc0203a42:	85aa                	mv	a1,a0
ffffffffc0203a44:	00240793          	addi	a5,s0,2
    if (vma != NULL)
ffffffffc0203a48:	f165                	bnez	a0,ffffffffc0203a28 <vmm_init+0x40>
        assert(vma != NULL);
ffffffffc0203a4a:	00003697          	auipc	a3,0x3
ffffffffc0203a4e:	48e68693          	addi	a3,a3,1166 # ffffffffc0206ed8 <default_pmm_manager+0x9e8>
ffffffffc0203a52:	00002617          	auipc	a2,0x2
ffffffffc0203a56:	6ee60613          	addi	a2,a2,1774 # ffffffffc0206140 <commands+0x828>
ffffffffc0203a5a:	12c00593          	li	a1,300
ffffffffc0203a5e:	00003517          	auipc	a0,0x3
ffffffffc0203a62:	22a50513          	addi	a0,a0,554 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc0203a66:	a29fc0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc0203a6a:	03700413          	li	s0,55
    }

    for (i = step1 + 1; i <= step2; i++)
ffffffffc0203a6e:	1f900913          	li	s2,505
ffffffffc0203a72:	a819                	j	ffffffffc0203a88 <vmm_init+0xa0>
        vma->vm_start = vm_start;
ffffffffc0203a74:	e500                	sd	s0,8(a0)
        vma->vm_end = vm_end;
ffffffffc0203a76:	e91c                	sd	a5,16(a0)
        vma->vm_flags = vm_flags;
ffffffffc0203a78:	00052c23          	sw	zero,24(a0)
    for (i = step1 + 1; i <= step2; i++)
ffffffffc0203a7c:	0415                	addi	s0,s0,5
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
ffffffffc0203a7e:	8526                	mv	a0,s1
ffffffffc0203a80:	c87ff0ef          	jal	ra,ffffffffc0203706 <insert_vma_struct>
    for (i = step1 + 1; i <= step2; i++)
ffffffffc0203a84:	03240a63          	beq	s0,s2,ffffffffc0203ab8 <vmm_init+0xd0>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203a88:	03000513          	li	a0,48
ffffffffc0203a8c:	a2afe0ef          	jal	ra,ffffffffc0201cb6 <kmalloc>
ffffffffc0203a90:	85aa                	mv	a1,a0
ffffffffc0203a92:	00240793          	addi	a5,s0,2
    if (vma != NULL)
ffffffffc0203a96:	fd79                	bnez	a0,ffffffffc0203a74 <vmm_init+0x8c>
        assert(vma != NULL);
ffffffffc0203a98:	00003697          	auipc	a3,0x3
ffffffffc0203a9c:	44068693          	addi	a3,a3,1088 # ffffffffc0206ed8 <default_pmm_manager+0x9e8>
ffffffffc0203aa0:	00002617          	auipc	a2,0x2
ffffffffc0203aa4:	6a060613          	addi	a2,a2,1696 # ffffffffc0206140 <commands+0x828>
ffffffffc0203aa8:	13300593          	li	a1,307
ffffffffc0203aac:	00003517          	auipc	a0,0x3
ffffffffc0203ab0:	1dc50513          	addi	a0,a0,476 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc0203ab4:	9dbfc0ef          	jal	ra,ffffffffc020048e <__panic>
    return listelm->next;
ffffffffc0203ab8:	649c                	ld	a5,8(s1)
ffffffffc0203aba:	471d                	li	a4,7
    }

    list_entry_t *le = list_next(&(mm->mmap_list));

    for (i = 1; i <= step2; i++)
ffffffffc0203abc:	1fb00593          	li	a1,507
    {
        assert(le != &(mm->mmap_list));
ffffffffc0203ac0:	16f48663          	beq	s1,a5,ffffffffc0203c2c <vmm_init+0x244>
        struct vma_struct *mmap = le2vma(le, list_link);
        assert(mmap->vm_start == i * 5 && mmap->vm_end == i * 5 + 2);
ffffffffc0203ac4:	fe87b603          	ld	a2,-24(a5) # ffffffffffffefe8 <end+0x3fd5495c>
ffffffffc0203ac8:	ffe70693          	addi	a3,a4,-2
ffffffffc0203acc:	10d61063          	bne	a2,a3,ffffffffc0203bcc <vmm_init+0x1e4>
ffffffffc0203ad0:	ff07b683          	ld	a3,-16(a5)
ffffffffc0203ad4:	0ed71c63          	bne	a4,a3,ffffffffc0203bcc <vmm_init+0x1e4>
    for (i = 1; i <= step2; i++)
ffffffffc0203ad8:	0715                	addi	a4,a4,5
ffffffffc0203ada:	679c                	ld	a5,8(a5)
ffffffffc0203adc:	feb712e3          	bne	a4,a1,ffffffffc0203ac0 <vmm_init+0xd8>
ffffffffc0203ae0:	4a1d                	li	s4,7
ffffffffc0203ae2:	4415                	li	s0,5
        le = list_next(le);
    }

    for (i = 5; i <= 5 * step2; i += 5)
ffffffffc0203ae4:	1f900a93          	li	s5,505
    {
        struct vma_struct *vma1 = find_vma(mm, i);
ffffffffc0203ae8:	85a2                	mv	a1,s0
ffffffffc0203aea:	8526                	mv	a0,s1
ffffffffc0203aec:	bdbff0ef          	jal	ra,ffffffffc02036c6 <find_vma>
ffffffffc0203af0:	892a                	mv	s2,a0
        assert(vma1 != NULL);
ffffffffc0203af2:	16050d63          	beqz	a0,ffffffffc0203c6c <vmm_init+0x284>
        struct vma_struct *vma2 = find_vma(mm, i + 1);
ffffffffc0203af6:	00140593          	addi	a1,s0,1
ffffffffc0203afa:	8526                	mv	a0,s1
ffffffffc0203afc:	bcbff0ef          	jal	ra,ffffffffc02036c6 <find_vma>
ffffffffc0203b00:	89aa                	mv	s3,a0
        assert(vma2 != NULL);
ffffffffc0203b02:	14050563          	beqz	a0,ffffffffc0203c4c <vmm_init+0x264>
        struct vma_struct *vma3 = find_vma(mm, i + 2);
ffffffffc0203b06:	85d2                	mv	a1,s4
ffffffffc0203b08:	8526                	mv	a0,s1
ffffffffc0203b0a:	bbdff0ef          	jal	ra,ffffffffc02036c6 <find_vma>
        assert(vma3 == NULL);
ffffffffc0203b0e:	16051f63          	bnez	a0,ffffffffc0203c8c <vmm_init+0x2a4>
        struct vma_struct *vma4 = find_vma(mm, i + 3);
ffffffffc0203b12:	00340593          	addi	a1,s0,3
ffffffffc0203b16:	8526                	mv	a0,s1
ffffffffc0203b18:	bafff0ef          	jal	ra,ffffffffc02036c6 <find_vma>
        assert(vma4 == NULL);
ffffffffc0203b1c:	1a051863          	bnez	a0,ffffffffc0203ccc <vmm_init+0x2e4>
        struct vma_struct *vma5 = find_vma(mm, i + 4);
ffffffffc0203b20:	00440593          	addi	a1,s0,4
ffffffffc0203b24:	8526                	mv	a0,s1
ffffffffc0203b26:	ba1ff0ef          	jal	ra,ffffffffc02036c6 <find_vma>
        assert(vma5 == NULL);
ffffffffc0203b2a:	18051163          	bnez	a0,ffffffffc0203cac <vmm_init+0x2c4>

        assert(vma1->vm_start == i && vma1->vm_end == i + 2);
ffffffffc0203b2e:	00893783          	ld	a5,8(s2)
ffffffffc0203b32:	0a879d63          	bne	a5,s0,ffffffffc0203bec <vmm_init+0x204>
ffffffffc0203b36:	01093783          	ld	a5,16(s2)
ffffffffc0203b3a:	0b479963          	bne	a5,s4,ffffffffc0203bec <vmm_init+0x204>
        assert(vma2->vm_start == i && vma2->vm_end == i + 2);
ffffffffc0203b3e:	0089b783          	ld	a5,8(s3)
ffffffffc0203b42:	0c879563          	bne	a5,s0,ffffffffc0203c0c <vmm_init+0x224>
ffffffffc0203b46:	0109b783          	ld	a5,16(s3)
ffffffffc0203b4a:	0d479163          	bne	a5,s4,ffffffffc0203c0c <vmm_init+0x224>
    for (i = 5; i <= 5 * step2; i += 5)
ffffffffc0203b4e:	0415                	addi	s0,s0,5
ffffffffc0203b50:	0a15                	addi	s4,s4,5
ffffffffc0203b52:	f9541be3          	bne	s0,s5,ffffffffc0203ae8 <vmm_init+0x100>
ffffffffc0203b56:	4411                	li	s0,4
    }

    for (i = 4; i >= 0; i--)
ffffffffc0203b58:	597d                	li	s2,-1
    {
        struct vma_struct *vma_below_5 = find_vma(mm, i);
ffffffffc0203b5a:	85a2                	mv	a1,s0
ffffffffc0203b5c:	8526                	mv	a0,s1
ffffffffc0203b5e:	b69ff0ef          	jal	ra,ffffffffc02036c6 <find_vma>
ffffffffc0203b62:	0004059b          	sext.w	a1,s0
        if (vma_below_5 != NULL)
ffffffffc0203b66:	c90d                	beqz	a0,ffffffffc0203b98 <vmm_init+0x1b0>
        {
            cprintf("vma_below_5: i %x, start %x, end %x\n", i, vma_below_5->vm_start, vma_below_5->vm_end);
ffffffffc0203b68:	6914                	ld	a3,16(a0)
ffffffffc0203b6a:	6510                	ld	a2,8(a0)
ffffffffc0203b6c:	00003517          	auipc	a0,0x3
ffffffffc0203b70:	2f450513          	addi	a0,a0,756 # ffffffffc0206e60 <default_pmm_manager+0x970>
ffffffffc0203b74:	e20fc0ef          	jal	ra,ffffffffc0200194 <cprintf>
        }
        assert(vma_below_5 == NULL);
ffffffffc0203b78:	00003697          	auipc	a3,0x3
ffffffffc0203b7c:	31068693          	addi	a3,a3,784 # ffffffffc0206e88 <default_pmm_manager+0x998>
ffffffffc0203b80:	00002617          	auipc	a2,0x2
ffffffffc0203b84:	5c060613          	addi	a2,a2,1472 # ffffffffc0206140 <commands+0x828>
ffffffffc0203b88:	15900593          	li	a1,345
ffffffffc0203b8c:	00003517          	auipc	a0,0x3
ffffffffc0203b90:	0fc50513          	addi	a0,a0,252 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc0203b94:	8fbfc0ef          	jal	ra,ffffffffc020048e <__panic>
    for (i = 4; i >= 0; i--)
ffffffffc0203b98:	147d                	addi	s0,s0,-1
ffffffffc0203b9a:	fd2410e3          	bne	s0,s2,ffffffffc0203b5a <vmm_init+0x172>
    }

    mm_destroy(mm);
ffffffffc0203b9e:	8526                	mv	a0,s1
ffffffffc0203ba0:	c37ff0ef          	jal	ra,ffffffffc02037d6 <mm_destroy>

    cprintf("check_vma_struct() succeeded!\n");
ffffffffc0203ba4:	00003517          	auipc	a0,0x3
ffffffffc0203ba8:	2fc50513          	addi	a0,a0,764 # ffffffffc0206ea0 <default_pmm_manager+0x9b0>
ffffffffc0203bac:	de8fc0ef          	jal	ra,ffffffffc0200194 <cprintf>
}
ffffffffc0203bb0:	7442                	ld	s0,48(sp)
ffffffffc0203bb2:	70e2                	ld	ra,56(sp)
ffffffffc0203bb4:	74a2                	ld	s1,40(sp)
ffffffffc0203bb6:	7902                	ld	s2,32(sp)
ffffffffc0203bb8:	69e2                	ld	s3,24(sp)
ffffffffc0203bba:	6a42                	ld	s4,16(sp)
ffffffffc0203bbc:	6aa2                	ld	s5,8(sp)
    cprintf("check_vmm() succeeded.\n");
ffffffffc0203bbe:	00003517          	auipc	a0,0x3
ffffffffc0203bc2:	30250513          	addi	a0,a0,770 # ffffffffc0206ec0 <default_pmm_manager+0x9d0>
}
ffffffffc0203bc6:	6121                	addi	sp,sp,64
    cprintf("check_vmm() succeeded.\n");
ffffffffc0203bc8:	dccfc06f          	j	ffffffffc0200194 <cprintf>
        assert(mmap->vm_start == i * 5 && mmap->vm_end == i * 5 + 2);
ffffffffc0203bcc:	00003697          	auipc	a3,0x3
ffffffffc0203bd0:	1ac68693          	addi	a3,a3,428 # ffffffffc0206d78 <default_pmm_manager+0x888>
ffffffffc0203bd4:	00002617          	auipc	a2,0x2
ffffffffc0203bd8:	56c60613          	addi	a2,a2,1388 # ffffffffc0206140 <commands+0x828>
ffffffffc0203bdc:	13d00593          	li	a1,317
ffffffffc0203be0:	00003517          	auipc	a0,0x3
ffffffffc0203be4:	0a850513          	addi	a0,a0,168 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc0203be8:	8a7fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma1->vm_start == i && vma1->vm_end == i + 2);
ffffffffc0203bec:	00003697          	auipc	a3,0x3
ffffffffc0203bf0:	21468693          	addi	a3,a3,532 # ffffffffc0206e00 <default_pmm_manager+0x910>
ffffffffc0203bf4:	00002617          	auipc	a2,0x2
ffffffffc0203bf8:	54c60613          	addi	a2,a2,1356 # ffffffffc0206140 <commands+0x828>
ffffffffc0203bfc:	14e00593          	li	a1,334
ffffffffc0203c00:	00003517          	auipc	a0,0x3
ffffffffc0203c04:	08850513          	addi	a0,a0,136 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc0203c08:	887fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma2->vm_start == i && vma2->vm_end == i + 2);
ffffffffc0203c0c:	00003697          	auipc	a3,0x3
ffffffffc0203c10:	22468693          	addi	a3,a3,548 # ffffffffc0206e30 <default_pmm_manager+0x940>
ffffffffc0203c14:	00002617          	auipc	a2,0x2
ffffffffc0203c18:	52c60613          	addi	a2,a2,1324 # ffffffffc0206140 <commands+0x828>
ffffffffc0203c1c:	14f00593          	li	a1,335
ffffffffc0203c20:	00003517          	auipc	a0,0x3
ffffffffc0203c24:	06850513          	addi	a0,a0,104 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc0203c28:	867fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(le != &(mm->mmap_list));
ffffffffc0203c2c:	00003697          	auipc	a3,0x3
ffffffffc0203c30:	13468693          	addi	a3,a3,308 # ffffffffc0206d60 <default_pmm_manager+0x870>
ffffffffc0203c34:	00002617          	auipc	a2,0x2
ffffffffc0203c38:	50c60613          	addi	a2,a2,1292 # ffffffffc0206140 <commands+0x828>
ffffffffc0203c3c:	13b00593          	li	a1,315
ffffffffc0203c40:	00003517          	auipc	a0,0x3
ffffffffc0203c44:	04850513          	addi	a0,a0,72 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc0203c48:	847fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma2 != NULL);
ffffffffc0203c4c:	00003697          	auipc	a3,0x3
ffffffffc0203c50:	17468693          	addi	a3,a3,372 # ffffffffc0206dc0 <default_pmm_manager+0x8d0>
ffffffffc0203c54:	00002617          	auipc	a2,0x2
ffffffffc0203c58:	4ec60613          	addi	a2,a2,1260 # ffffffffc0206140 <commands+0x828>
ffffffffc0203c5c:	14600593          	li	a1,326
ffffffffc0203c60:	00003517          	auipc	a0,0x3
ffffffffc0203c64:	02850513          	addi	a0,a0,40 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc0203c68:	827fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma1 != NULL);
ffffffffc0203c6c:	00003697          	auipc	a3,0x3
ffffffffc0203c70:	14468693          	addi	a3,a3,324 # ffffffffc0206db0 <default_pmm_manager+0x8c0>
ffffffffc0203c74:	00002617          	auipc	a2,0x2
ffffffffc0203c78:	4cc60613          	addi	a2,a2,1228 # ffffffffc0206140 <commands+0x828>
ffffffffc0203c7c:	14400593          	li	a1,324
ffffffffc0203c80:	00003517          	auipc	a0,0x3
ffffffffc0203c84:	00850513          	addi	a0,a0,8 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc0203c88:	807fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma3 == NULL);
ffffffffc0203c8c:	00003697          	auipc	a3,0x3
ffffffffc0203c90:	14468693          	addi	a3,a3,324 # ffffffffc0206dd0 <default_pmm_manager+0x8e0>
ffffffffc0203c94:	00002617          	auipc	a2,0x2
ffffffffc0203c98:	4ac60613          	addi	a2,a2,1196 # ffffffffc0206140 <commands+0x828>
ffffffffc0203c9c:	14800593          	li	a1,328
ffffffffc0203ca0:	00003517          	auipc	a0,0x3
ffffffffc0203ca4:	fe850513          	addi	a0,a0,-24 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc0203ca8:	fe6fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma5 == NULL);
ffffffffc0203cac:	00003697          	auipc	a3,0x3
ffffffffc0203cb0:	14468693          	addi	a3,a3,324 # ffffffffc0206df0 <default_pmm_manager+0x900>
ffffffffc0203cb4:	00002617          	auipc	a2,0x2
ffffffffc0203cb8:	48c60613          	addi	a2,a2,1164 # ffffffffc0206140 <commands+0x828>
ffffffffc0203cbc:	14c00593          	li	a1,332
ffffffffc0203cc0:	00003517          	auipc	a0,0x3
ffffffffc0203cc4:	fc850513          	addi	a0,a0,-56 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc0203cc8:	fc6fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma4 == NULL);
ffffffffc0203ccc:	00003697          	auipc	a3,0x3
ffffffffc0203cd0:	11468693          	addi	a3,a3,276 # ffffffffc0206de0 <default_pmm_manager+0x8f0>
ffffffffc0203cd4:	00002617          	auipc	a2,0x2
ffffffffc0203cd8:	46c60613          	addi	a2,a2,1132 # ffffffffc0206140 <commands+0x828>
ffffffffc0203cdc:	14a00593          	li	a1,330
ffffffffc0203ce0:	00003517          	auipc	a0,0x3
ffffffffc0203ce4:	fa850513          	addi	a0,a0,-88 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc0203ce8:	fa6fc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(mm != NULL);
ffffffffc0203cec:	00003697          	auipc	a3,0x3
ffffffffc0203cf0:	02468693          	addi	a3,a3,36 # ffffffffc0206d10 <default_pmm_manager+0x820>
ffffffffc0203cf4:	00002617          	auipc	a2,0x2
ffffffffc0203cf8:	44c60613          	addi	a2,a2,1100 # ffffffffc0206140 <commands+0x828>
ffffffffc0203cfc:	12400593          	li	a1,292
ffffffffc0203d00:	00003517          	auipc	a0,0x3
ffffffffc0203d04:	f8850513          	addi	a0,a0,-120 # ffffffffc0206c88 <default_pmm_manager+0x798>
ffffffffc0203d08:	f86fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203d0c <user_mem_check>:
}
bool user_mem_check(struct mm_struct *mm, uintptr_t addr, size_t len, bool write)
{
ffffffffc0203d0c:	7179                	addi	sp,sp,-48
ffffffffc0203d0e:	f022                	sd	s0,32(sp)
ffffffffc0203d10:	f406                	sd	ra,40(sp)
ffffffffc0203d12:	ec26                	sd	s1,24(sp)
ffffffffc0203d14:	e84a                	sd	s2,16(sp)
ffffffffc0203d16:	e44e                	sd	s3,8(sp)
ffffffffc0203d18:	e052                	sd	s4,0(sp)
ffffffffc0203d1a:	842e                	mv	s0,a1
    if (mm != NULL)
ffffffffc0203d1c:	c135                	beqz	a0,ffffffffc0203d80 <user_mem_check+0x74>
    {
        if (!USER_ACCESS(addr, addr + len))
ffffffffc0203d1e:	002007b7          	lui	a5,0x200
ffffffffc0203d22:	04f5e663          	bltu	a1,a5,ffffffffc0203d6e <user_mem_check+0x62>
ffffffffc0203d26:	00c584b3          	add	s1,a1,a2
ffffffffc0203d2a:	0495f263          	bgeu	a1,s1,ffffffffc0203d6e <user_mem_check+0x62>
ffffffffc0203d2e:	4785                	li	a5,1
ffffffffc0203d30:	07fe                	slli	a5,a5,0x1f
ffffffffc0203d32:	0297ee63          	bltu	a5,s1,ffffffffc0203d6e <user_mem_check+0x62>
ffffffffc0203d36:	892a                	mv	s2,a0
ffffffffc0203d38:	89b6                	mv	s3,a3
            {
                return 0;
            }
            if (write && (vma->vm_flags & VM_STACK))
            {
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203d3a:	6a05                	lui	s4,0x1
ffffffffc0203d3c:	a821                	j	ffffffffc0203d54 <user_mem_check+0x48>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203d3e:	0027f693          	andi	a3,a5,2
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203d42:	9752                	add	a4,a4,s4
            if (write && (vma->vm_flags & VM_STACK))
ffffffffc0203d44:	8ba1                	andi	a5,a5,8
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203d46:	c685                	beqz	a3,ffffffffc0203d6e <user_mem_check+0x62>
            if (write && (vma->vm_flags & VM_STACK))
ffffffffc0203d48:	c399                	beqz	a5,ffffffffc0203d4e <user_mem_check+0x42>
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203d4a:	02e46263          	bltu	s0,a4,ffffffffc0203d6e <user_mem_check+0x62>
                { // check stack start & size
                    return 0;
                }
            }
            start = vma->vm_end;
ffffffffc0203d4e:	6900                	ld	s0,16(a0)
        while (start < end)
ffffffffc0203d50:	04947663          	bgeu	s0,s1,ffffffffc0203d9c <user_mem_check+0x90>
            if ((vma = find_vma(mm, start)) == NULL || start < vma->vm_start)
ffffffffc0203d54:	85a2                	mv	a1,s0
ffffffffc0203d56:	854a                	mv	a0,s2
ffffffffc0203d58:	96fff0ef          	jal	ra,ffffffffc02036c6 <find_vma>
ffffffffc0203d5c:	c909                	beqz	a0,ffffffffc0203d6e <user_mem_check+0x62>
ffffffffc0203d5e:	6518                	ld	a4,8(a0)
ffffffffc0203d60:	00e46763          	bltu	s0,a4,ffffffffc0203d6e <user_mem_check+0x62>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203d64:	4d1c                	lw	a5,24(a0)
ffffffffc0203d66:	fc099ce3          	bnez	s3,ffffffffc0203d3e <user_mem_check+0x32>
ffffffffc0203d6a:	8b85                	andi	a5,a5,1
ffffffffc0203d6c:	f3ed                	bnez	a5,ffffffffc0203d4e <user_mem_check+0x42>
            return 0;
ffffffffc0203d6e:	4501                	li	a0,0
        }
        return 1;
    }
    return KERN_ACCESS(addr, addr + len);
ffffffffc0203d70:	70a2                	ld	ra,40(sp)
ffffffffc0203d72:	7402                	ld	s0,32(sp)
ffffffffc0203d74:	64e2                	ld	s1,24(sp)
ffffffffc0203d76:	6942                	ld	s2,16(sp)
ffffffffc0203d78:	69a2                	ld	s3,8(sp)
ffffffffc0203d7a:	6a02                	ld	s4,0(sp)
ffffffffc0203d7c:	6145                	addi	sp,sp,48
ffffffffc0203d7e:	8082                	ret
    return KERN_ACCESS(addr, addr + len);
ffffffffc0203d80:	c02007b7          	lui	a5,0xc0200
ffffffffc0203d84:	4501                	li	a0,0
ffffffffc0203d86:	fef5e5e3          	bltu	a1,a5,ffffffffc0203d70 <user_mem_check+0x64>
ffffffffc0203d8a:	962e                	add	a2,a2,a1
ffffffffc0203d8c:	fec5f2e3          	bgeu	a1,a2,ffffffffc0203d70 <user_mem_check+0x64>
ffffffffc0203d90:	c8000537          	lui	a0,0xc8000
ffffffffc0203d94:	0505                	addi	a0,a0,1
ffffffffc0203d96:	00a63533          	sltu	a0,a2,a0
ffffffffc0203d9a:	bfd9                	j	ffffffffc0203d70 <user_mem_check+0x64>
        return 1;
ffffffffc0203d9c:	4505                	li	a0,1
ffffffffc0203d9e:	bfc9                	j	ffffffffc0203d70 <user_mem_check+0x64>

ffffffffc0203da0 <kernel_thread_entry>:
.text
.globl kernel_thread_entry
kernel_thread_entry:        # void kernel_thread(void)
	move a0, s1
ffffffffc0203da0:	8526                	mv	a0,s1
	jalr s0
ffffffffc0203da2:	9402                	jalr	s0

	jal do_exit
ffffffffc0203da4:	614000ef          	jal	ra,ffffffffc02043b8 <do_exit>

ffffffffc0203da8 <alloc_proc>:
void switch_to(struct context *from, struct context *to);

// alloc_proc - alloc a proc_struct and init all fields of proc_struct
static struct proc_struct *
alloc_proc(void)
{
ffffffffc0203da8:	1141                	addi	sp,sp,-16
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203daa:	10800513          	li	a0,264
{
ffffffffc0203dae:	e022                	sd	s0,0(sp)
ffffffffc0203db0:	e406                	sd	ra,8(sp)
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203db2:	f05fd0ef          	jal	ra,ffffffffc0201cb6 <kmalloc>
ffffffffc0203db6:	842a                	mv	s0,a0
    if (proc != NULL)
ffffffffc0203db8:	cd31                	beqz	a0,ffffffffc0203e14 <alloc_proc+0x6c>
         *       uintptr_t pgdir;                            // the base addr of Page Directroy Table(PDT)
         *       uint32_t flags;                             // Process flag
         *       char name[PROC_NAME_LEN + 1];               // Process name
         */
         //���������ṹ�壬ȷ�������ֶ���ȷ����ʼֵ
        memset(proc, 0, sizeof(struct proc_struct));
ffffffffc0203dba:	10800613          	li	a2,264
ffffffffc0203dbe:	4581                	li	a1,0
ffffffffc0203dc0:	0c5010ef          	jal	ra,ffffffffc0205684 <memset>

        //����״̬���ʶ
        proc->state = PROC_UNINIT;   //δ��ʼ��
ffffffffc0203dc4:	57fd                	li	a5,-1
ffffffffc0203dc6:	1782                	slli	a5,a5,0x20
ffffffffc0203dc8:	e01c                	sd	a5,0(s0)
        //��־�����ֵ�
        proc->flags = 0;
        proc->name[0] = '\0';

        //��ʼ��������㣬����ֱ�Ӳ���
        list_init(&proc->list_link);
ffffffffc0203dca:	0c840713          	addi	a4,s0,200
        list_init(&proc->hash_link);
ffffffffc0203dce:	0d840793          	addi	a5,s0,216
        proc->pgdir = boot_pgdir_pa;
ffffffffc0203dd2:	000a7697          	auipc	a3,0xa7
ffffffffc0203dd6:	86e6b683          	ld	a3,-1938(a3) # ffffffffc02aa640 <boot_pgdir_pa>
        proc->runs = 0;              //���м�������
ffffffffc0203dda:	00042423          	sw	zero,8(s0)
        proc->kstack = 0;            //�ں�ջ��ַ����� setup_kstack ����
ffffffffc0203dde:	00043823          	sd	zero,16(s0)
        proc->need_resched = 0;      //Ĭ�ϲ���Ҫ���µ���
ffffffffc0203de2:	00043c23          	sd	zero,24(s0)
        proc->parent = NULL;         //���޸�����
ffffffffc0203de6:	02043023          	sd	zero,32(s0)
        proc->mm = NULL;             //���޶���mm
ffffffffc0203dea:	02043423          	sd	zero,40(s0)
        proc->tf = NULL;
ffffffffc0203dee:	0a043023          	sd	zero,160(s0)
        proc->pgdir = boot_pgdir_pa;
ffffffffc0203df2:	f454                	sd	a3,168(s0)
        proc->flags = 0;
ffffffffc0203df4:	0a042823          	sw	zero,176(s0)
        proc->name[0] = '\0';
ffffffffc0203df8:	0a040a23          	sb	zero,180(s0)
    elm->prev = elm->next = elm;
ffffffffc0203dfc:	e878                	sd	a4,208(s0)
ffffffffc0203dfe:	e478                	sd	a4,200(s0)
ffffffffc0203e00:	f07c                	sd	a5,224(s0)
ffffffffc0203e02:	ec7c                	sd	a5,216(s0)
        /*
         * below fields(add in LAB5) in proc_struct need to be initialized
         *       uint32_t wait_state;                        // waiting state
         *       struct proc_struct *cptr, *yptr, *optr;     // relations between processes
         */
        proc->wait_state = 0;
ffffffffc0203e04:	0e042623          	sw	zero,236(s0)
        proc->cptr = proc->yptr = proc->optr = NULL;
ffffffffc0203e08:	10043023          	sd	zero,256(s0)
ffffffffc0203e0c:	0e043c23          	sd	zero,248(s0)
ffffffffc0203e10:	0e043823          	sd	zero,240(s0)
    }
    return proc;
}
ffffffffc0203e14:	60a2                	ld	ra,8(sp)
ffffffffc0203e16:	8522                	mv	a0,s0
ffffffffc0203e18:	6402                	ld	s0,0(sp)
ffffffffc0203e1a:	0141                	addi	sp,sp,16
ffffffffc0203e1c:	8082                	ret

ffffffffc0203e1e <forkret>:
// NOTE: the addr of forkret is setted in copy_thread function
//       after switch_to, the current proc will execute here.
static void
forkret(void)
{
    forkrets(current->tf);
ffffffffc0203e1e:	000a7797          	auipc	a5,0xa7
ffffffffc0203e22:	8527b783          	ld	a5,-1966(a5) # ffffffffc02aa670 <current>
ffffffffc0203e26:	73c8                	ld	a0,160(a5)
ffffffffc0203e28:	902fd06f          	j	ffffffffc0200f2a <forkrets>

ffffffffc0203e2c <user_main>:
// user_main - kernel thread used to exec a user program
static int
user_main(void *arg)
{
#ifdef TEST
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
ffffffffc0203e2c:	000a7797          	auipc	a5,0xa7
ffffffffc0203e30:	8447b783          	ld	a5,-1980(a5) # ffffffffc02aa670 <current>
ffffffffc0203e34:	43cc                	lw	a1,4(a5)
{
ffffffffc0203e36:	7139                	addi	sp,sp,-64
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
ffffffffc0203e38:	00003617          	auipc	a2,0x3
ffffffffc0203e3c:	0b060613          	addi	a2,a2,176 # ffffffffc0206ee8 <default_pmm_manager+0x9f8>
ffffffffc0203e40:	00003517          	auipc	a0,0x3
ffffffffc0203e44:	0b850513          	addi	a0,a0,184 # ffffffffc0206ef8 <default_pmm_manager+0xa08>
{
ffffffffc0203e48:	fc06                	sd	ra,56(sp)
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
ffffffffc0203e4a:	b4afc0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc0203e4e:	3fe07797          	auipc	a5,0x3fe07
ffffffffc0203e52:	b0a78793          	addi	a5,a5,-1270 # a958 <_binary_obj___user_forktest_out_size>
ffffffffc0203e56:	e43e                	sd	a5,8(sp)
ffffffffc0203e58:	00003517          	auipc	a0,0x3
ffffffffc0203e5c:	09050513          	addi	a0,a0,144 # ffffffffc0206ee8 <default_pmm_manager+0x9f8>
ffffffffc0203e60:	00046797          	auipc	a5,0x46
ffffffffc0203e64:	85878793          	addi	a5,a5,-1960 # ffffffffc02496b8 <_binary_obj___user_forktest_out_start>
ffffffffc0203e68:	f03e                	sd	a5,32(sp)
ffffffffc0203e6a:	f42a                	sd	a0,40(sp)
    int64_t ret = 0, len = strlen(name);
ffffffffc0203e6c:	e802                	sd	zero,16(sp)
ffffffffc0203e6e:	774010ef          	jal	ra,ffffffffc02055e2 <strlen>
ffffffffc0203e72:	ec2a                	sd	a0,24(sp)
    asm volatile(
ffffffffc0203e74:	4511                	li	a0,4
ffffffffc0203e76:	55a2                	lw	a1,40(sp)
ffffffffc0203e78:	4662                	lw	a2,24(sp)
ffffffffc0203e7a:	5682                	lw	a3,32(sp)
ffffffffc0203e7c:	4722                	lw	a4,8(sp)
ffffffffc0203e7e:	48a9                	li	a7,10
ffffffffc0203e80:	9002                	ebreak
ffffffffc0203e82:	c82a                	sw	a0,16(sp)
    cprintf("ret = %d\n", ret);
ffffffffc0203e84:	65c2                	ld	a1,16(sp)
ffffffffc0203e86:	00003517          	auipc	a0,0x3
ffffffffc0203e8a:	09a50513          	addi	a0,a0,154 # ffffffffc0206f20 <default_pmm_manager+0xa30>
ffffffffc0203e8e:	b06fc0ef          	jal	ra,ffffffffc0200194 <cprintf>
#else
    KERNEL_EXECVE(exit);
#endif
    panic("user_main execve failed.\n");
ffffffffc0203e92:	00003617          	auipc	a2,0x3
ffffffffc0203e96:	09e60613          	addi	a2,a2,158 # ffffffffc0206f30 <default_pmm_manager+0xa40>
ffffffffc0203e9a:	3d600593          	li	a1,982
ffffffffc0203e9e:	00003517          	auipc	a0,0x3
ffffffffc0203ea2:	0b250513          	addi	a0,a0,178 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc0203ea6:	de8fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203eaa <put_pgdir>:
    return pa2page(PADDR(kva));
ffffffffc0203eaa:	6d14                	ld	a3,24(a0)
{
ffffffffc0203eac:	1141                	addi	sp,sp,-16
ffffffffc0203eae:	e406                	sd	ra,8(sp)
ffffffffc0203eb0:	c02007b7          	lui	a5,0xc0200
ffffffffc0203eb4:	02f6ee63          	bltu	a3,a5,ffffffffc0203ef0 <put_pgdir+0x46>
ffffffffc0203eb8:	000a6517          	auipc	a0,0xa6
ffffffffc0203ebc:	7b053503          	ld	a0,1968(a0) # ffffffffc02aa668 <va_pa_offset>
ffffffffc0203ec0:	8e89                	sub	a3,a3,a0
    if (PPN(pa) >= npage)
ffffffffc0203ec2:	82b1                	srli	a3,a3,0xc
ffffffffc0203ec4:	000a6797          	auipc	a5,0xa6
ffffffffc0203ec8:	78c7b783          	ld	a5,1932(a5) # ffffffffc02aa650 <npage>
ffffffffc0203ecc:	02f6fe63          	bgeu	a3,a5,ffffffffc0203f08 <put_pgdir+0x5e>
    return &pages[PPN(pa) - nbase];
ffffffffc0203ed0:	00004517          	auipc	a0,0x4
ffffffffc0203ed4:	91853503          	ld	a0,-1768(a0) # ffffffffc02077e8 <nbase>
}
ffffffffc0203ed8:	60a2                	ld	ra,8(sp)
ffffffffc0203eda:	8e89                	sub	a3,a3,a0
ffffffffc0203edc:	069a                	slli	a3,a3,0x6
    free_page(kva2page(mm->pgdir));
ffffffffc0203ede:	000a6517          	auipc	a0,0xa6
ffffffffc0203ee2:	77a53503          	ld	a0,1914(a0) # ffffffffc02aa658 <pages>
ffffffffc0203ee6:	4585                	li	a1,1
ffffffffc0203ee8:	9536                	add	a0,a0,a3
}
ffffffffc0203eea:	0141                	addi	sp,sp,16
    free_page(kva2page(mm->pgdir));
ffffffffc0203eec:	fe7fd06f          	j	ffffffffc0201ed2 <free_pages>
    return pa2page(PADDR(kva));
ffffffffc0203ef0:	00002617          	auipc	a2,0x2
ffffffffc0203ef4:	6e060613          	addi	a2,a2,1760 # ffffffffc02065d0 <default_pmm_manager+0xe0>
ffffffffc0203ef8:	07700593          	li	a1,119
ffffffffc0203efc:	00002517          	auipc	a0,0x2
ffffffffc0203f00:	65450513          	addi	a0,a0,1620 # ffffffffc0206550 <default_pmm_manager+0x60>
ffffffffc0203f04:	d8afc0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0203f08:	00002617          	auipc	a2,0x2
ffffffffc0203f0c:	6f060613          	addi	a2,a2,1776 # ffffffffc02065f8 <default_pmm_manager+0x108>
ffffffffc0203f10:	06900593          	li	a1,105
ffffffffc0203f14:	00002517          	auipc	a0,0x2
ffffffffc0203f18:	63c50513          	addi	a0,a0,1596 # ffffffffc0206550 <default_pmm_manager+0x60>
ffffffffc0203f1c:	d72fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203f20 <proc_run>:
{
ffffffffc0203f20:	7179                	addi	sp,sp,-48
ffffffffc0203f22:	f026                	sd	s1,32(sp)
    if (proc != current)
ffffffffc0203f24:	000a6497          	auipc	s1,0xa6
ffffffffc0203f28:	74c48493          	addi	s1,s1,1868 # ffffffffc02aa670 <current>
ffffffffc0203f2c:	6098                	ld	a4,0(s1)
{
ffffffffc0203f2e:	f406                	sd	ra,40(sp)
ffffffffc0203f30:	ec4a                	sd	s2,24(sp)
    if (proc != current)
ffffffffc0203f32:	02a70a63          	beq	a4,a0,ffffffffc0203f66 <proc_run+0x46>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203f36:	100027f3          	csrr	a5,sstatus
ffffffffc0203f3a:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203f3c:	4901                	li	s2,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203f3e:	ef9d                	bnez	a5,ffffffffc0203f7c <proc_run+0x5c>
        current->runs++;
ffffffffc0203f40:	4514                	lw	a3,8(a0)
#define barrier() __asm__ __volatile__("fence" ::: "memory")

static inline void
lsatp(unsigned long pgdir)
{
  write_csr(satp, 0x8000000000000000 | (pgdir >> RISCV_PGSHIFT));
ffffffffc0203f42:	755c                	ld	a5,168(a0)
        current = proc;
ffffffffc0203f44:	e088                	sd	a0,0(s1)
        current->runs++;
ffffffffc0203f46:	2685                	addiw	a3,a3,1
ffffffffc0203f48:	c514                	sw	a3,8(a0)
ffffffffc0203f4a:	56fd                	li	a3,-1
ffffffffc0203f4c:	16fe                	slli	a3,a3,0x3f
ffffffffc0203f4e:	83b1                	srli	a5,a5,0xc
ffffffffc0203f50:	8fd5                	or	a5,a5,a3
ffffffffc0203f52:	18079073          	csrw	satp,a5
        switch_to(&prev->context, &proc->context);
ffffffffc0203f56:	03050593          	addi	a1,a0,48
ffffffffc0203f5a:	03070513          	addi	a0,a4,48
ffffffffc0203f5e:	02a010ef          	jal	ra,ffffffffc0204f88 <switch_to>
    if (flag)
ffffffffc0203f62:	00091763          	bnez	s2,ffffffffc0203f70 <proc_run+0x50>
}
ffffffffc0203f66:	70a2                	ld	ra,40(sp)
ffffffffc0203f68:	7482                	ld	s1,32(sp)
ffffffffc0203f6a:	6962                	ld	s2,24(sp)
ffffffffc0203f6c:	6145                	addi	sp,sp,48
ffffffffc0203f6e:	8082                	ret
ffffffffc0203f70:	70a2                	ld	ra,40(sp)
ffffffffc0203f72:	7482                	ld	s1,32(sp)
ffffffffc0203f74:	6962                	ld	s2,24(sp)
ffffffffc0203f76:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc0203f78:	a37fc06f          	j	ffffffffc02009ae <intr_enable>
ffffffffc0203f7c:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0203f7e:	a37fc0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        struct proc_struct* prev = current;
ffffffffc0203f82:	6098                	ld	a4,0(s1)
        return 1;
ffffffffc0203f84:	6522                	ld	a0,8(sp)
ffffffffc0203f86:	4905                	li	s2,1
ffffffffc0203f88:	bf65                	j	ffffffffc0203f40 <proc_run+0x20>

ffffffffc0203f8a <do_fork>:
{
ffffffffc0203f8a:	7119                	addi	sp,sp,-128
ffffffffc0203f8c:	f4a6                	sd	s1,104(sp)
    if (nr_process >= MAX_PROCESS)
ffffffffc0203f8e:	000a6497          	auipc	s1,0xa6
ffffffffc0203f92:	6fa48493          	addi	s1,s1,1786 # ffffffffc02aa688 <nr_process>
ffffffffc0203f96:	4098                	lw	a4,0(s1)
{
ffffffffc0203f98:	fc86                	sd	ra,120(sp)
ffffffffc0203f9a:	f8a2                	sd	s0,112(sp)
ffffffffc0203f9c:	f0ca                	sd	s2,96(sp)
ffffffffc0203f9e:	ecce                	sd	s3,88(sp)
ffffffffc0203fa0:	e8d2                	sd	s4,80(sp)
ffffffffc0203fa2:	e4d6                	sd	s5,72(sp)
ffffffffc0203fa4:	e0da                	sd	s6,64(sp)
ffffffffc0203fa6:	fc5e                	sd	s7,56(sp)
ffffffffc0203fa8:	f862                	sd	s8,48(sp)
ffffffffc0203faa:	f466                	sd	s9,40(sp)
ffffffffc0203fac:	f06a                	sd	s10,32(sp)
ffffffffc0203fae:	ec6e                	sd	s11,24(sp)
    if (nr_process >= MAX_PROCESS)
ffffffffc0203fb0:	6785                	lui	a5,0x1
ffffffffc0203fb2:	32f75063          	bge	a4,a5,ffffffffc02042d2 <do_fork+0x348>
ffffffffc0203fb6:	8a2a                	mv	s4,a0
ffffffffc0203fb8:	892e                	mv	s2,a1
ffffffffc0203fba:	89b2                	mv	s3,a2
    if ((proc = alloc_proc()) == NULL) {
ffffffffc0203fbc:	dedff0ef          	jal	ra,ffffffffc0203da8 <alloc_proc>
ffffffffc0203fc0:	842a                	mv	s0,a0
ffffffffc0203fc2:	30050f63          	beqz	a0,ffffffffc02042e0 <do_fork+0x356>
    proc->parent = current;
ffffffffc0203fc6:	000a6b97          	auipc	s7,0xa6
ffffffffc0203fca:	6aab8b93          	addi	s7,s7,1706 # ffffffffc02aa670 <current>
ffffffffc0203fce:	000bb783          	ld	a5,0(s7)
    struct Page *page = alloc_pages(KSTACKPAGE);
ffffffffc0203fd2:	4509                	li	a0,2
    proc->parent = current;
ffffffffc0203fd4:	f01c                	sd	a5,32(s0)
    current->wait_state = 0;
ffffffffc0203fd6:	0e07a623          	sw	zero,236(a5) # 10ec <_binary_obj___user_faultread_out_size-0x8ab4>
    struct Page *page = alloc_pages(KSTACKPAGE);
ffffffffc0203fda:	ebbfd0ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
    if (page != NULL)
ffffffffc0203fde:	2e050863          	beqz	a0,ffffffffc02042ce <do_fork+0x344>
    return page - pages + nbase;
ffffffffc0203fe2:	000a6c97          	auipc	s9,0xa6
ffffffffc0203fe6:	676c8c93          	addi	s9,s9,1654 # ffffffffc02aa658 <pages>
ffffffffc0203fea:	000cb683          	ld	a3,0(s9)
ffffffffc0203fee:	00003a97          	auipc	s5,0x3
ffffffffc0203ff2:	7faa8a93          	addi	s5,s5,2042 # ffffffffc02077e8 <nbase>
ffffffffc0203ff6:	000ab703          	ld	a4,0(s5)
ffffffffc0203ffa:	40d506b3          	sub	a3,a0,a3
    return KADDR(page2pa(page));
ffffffffc0203ffe:	000a6d17          	auipc	s10,0xa6
ffffffffc0204002:	652d0d13          	addi	s10,s10,1618 # ffffffffc02aa650 <npage>
    return page - pages + nbase;
ffffffffc0204006:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0204008:	5b7d                	li	s6,-1
ffffffffc020400a:	000d3783          	ld	a5,0(s10)
    return page - pages + nbase;
ffffffffc020400e:	96ba                	add	a3,a3,a4
    return KADDR(page2pa(page));
ffffffffc0204010:	00cb5b13          	srli	s6,s6,0xc
ffffffffc0204014:	0166f633          	and	a2,a3,s6
    return page2ppn(page) << PGSHIFT;
ffffffffc0204018:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc020401a:	2cf67a63          	bgeu	a2,a5,ffffffffc02042ee <do_fork+0x364>
    struct mm_struct *mm, *oldmm = current->mm;
ffffffffc020401e:	000bb603          	ld	a2,0(s7)
ffffffffc0204022:	000a6d97          	auipc	s11,0xa6
ffffffffc0204026:	646d8d93          	addi	s11,s11,1606 # ffffffffc02aa668 <va_pa_offset>
ffffffffc020402a:	000db783          	ld	a5,0(s11)
ffffffffc020402e:	02863b83          	ld	s7,40(a2)
ffffffffc0204032:	e43a                	sd	a4,8(sp)
ffffffffc0204034:	96be                	add	a3,a3,a5
        proc->kstack = (uintptr_t)page2kva(page);
ffffffffc0204036:	e814                	sd	a3,16(s0)
    if (oldmm == NULL)
ffffffffc0204038:	020b8863          	beqz	s7,ffffffffc0204068 <do_fork+0xde>
    if (clone_flags & CLONE_VM)
ffffffffc020403c:	100a7a13          	andi	s4,s4,256
ffffffffc0204040:	1a0a0163          	beqz	s4,ffffffffc02041e2 <do_fork+0x258>
}

static inline int
mm_count_inc(struct mm_struct *mm)
{
    mm->mm_count += 1;
ffffffffc0204044:	030ba703          	lw	a4,48(s7)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0204048:	018bb783          	ld	a5,24(s7)
ffffffffc020404c:	c02006b7          	lui	a3,0xc0200
ffffffffc0204050:	2705                	addiw	a4,a4,1
ffffffffc0204052:	02eba823          	sw	a4,48(s7)
    proc->mm = mm;
ffffffffc0204056:	03743423          	sd	s7,40(s0)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc020405a:	2cd7e263          	bltu	a5,a3,ffffffffc020431e <do_fork+0x394>
ffffffffc020405e:	000db703          	ld	a4,0(s11)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0204062:	6814                	ld	a3,16(s0)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0204064:	8f99                	sub	a5,a5,a4
ffffffffc0204066:	f45c                	sd	a5,168(s0)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0204068:	6789                	lui	a5,0x2
ffffffffc020406a:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_obj___user_faultread_out_size-0x7cc0>
ffffffffc020406e:	96be                	add	a3,a3,a5
    *(proc->tf) = *tf;
ffffffffc0204070:	864e                	mv	a2,s3
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0204072:	f054                	sd	a3,160(s0)
    *(proc->tf) = *tf;
ffffffffc0204074:	87b6                	mv	a5,a3
ffffffffc0204076:	12098893          	addi	a7,s3,288
ffffffffc020407a:	00063803          	ld	a6,0(a2)
ffffffffc020407e:	6608                	ld	a0,8(a2)
ffffffffc0204080:	6a0c                	ld	a1,16(a2)
ffffffffc0204082:	6e18                	ld	a4,24(a2)
ffffffffc0204084:	0107b023          	sd	a6,0(a5)
ffffffffc0204088:	e788                	sd	a0,8(a5)
ffffffffc020408a:	eb8c                	sd	a1,16(a5)
ffffffffc020408c:	ef98                	sd	a4,24(a5)
ffffffffc020408e:	02060613          	addi	a2,a2,32
ffffffffc0204092:	02078793          	addi	a5,a5,32
ffffffffc0204096:	ff1612e3          	bne	a2,a7,ffffffffc020407a <do_fork+0xf0>
    proc->tf->gpr.a0 = 0;
ffffffffc020409a:	0406b823          	sd	zero,80(a3) # ffffffffc0200050 <kern_init+0x6>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc020409e:	1c090b63          	beqz	s2,ffffffffc0204274 <do_fork+0x2ea>
ffffffffc02040a2:	0126b823          	sd	s2,16(a3)
    proc->context.ra = (uintptr_t)forkret;
ffffffffc02040a6:	00000797          	auipc	a5,0x0
ffffffffc02040aa:	d7878793          	addi	a5,a5,-648 # ffffffffc0203e1e <forkret>
ffffffffc02040ae:	f81c                	sd	a5,48(s0)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc02040b0:	fc14                	sd	a3,56(s0)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02040b2:	100027f3          	csrr	a5,sstatus
ffffffffc02040b6:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02040b8:	4981                	li	s3,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02040ba:	20079663          	bnez	a5,ffffffffc02042c6 <do_fork+0x33c>
    if (++last_pid >= MAX_PID)
ffffffffc02040be:	000a2817          	auipc	a6,0xa2
ffffffffc02040c2:	12280813          	addi	a6,a6,290 # ffffffffc02a61e0 <last_pid.1>
ffffffffc02040c6:	00082783          	lw	a5,0(a6)
ffffffffc02040ca:	6709                	lui	a4,0x2
ffffffffc02040cc:	0017851b          	addiw	a0,a5,1
ffffffffc02040d0:	00a82023          	sw	a0,0(a6)
ffffffffc02040d4:	0ae55063          	bge	a0,a4,ffffffffc0204174 <do_fork+0x1ea>
    if (last_pid >= next_safe)
ffffffffc02040d8:	000a2317          	auipc	t1,0xa2
ffffffffc02040dc:	10c30313          	addi	t1,t1,268 # ffffffffc02a61e4 <next_safe.0>
ffffffffc02040e0:	00032783          	lw	a5,0(t1)
ffffffffc02040e4:	000a6917          	auipc	s2,0xa6
ffffffffc02040e8:	51c90913          	addi	s2,s2,1308 # ffffffffc02aa600 <proc_list>
ffffffffc02040ec:	08f55c63          	bge	a0,a5,ffffffffc0204184 <do_fork+0x1fa>
        proc->pid = get_pid();
ffffffffc02040f0:	c048                	sw	a0,4(s0)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc02040f2:	45a9                	li	a1,10
ffffffffc02040f4:	2501                	sext.w	a0,a0
ffffffffc02040f6:	0e8010ef          	jal	ra,ffffffffc02051de <hash32>
ffffffffc02040fa:	02051793          	slli	a5,a0,0x20
ffffffffc02040fe:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0204102:	000a2797          	auipc	a5,0xa2
ffffffffc0204106:	4fe78793          	addi	a5,a5,1278 # ffffffffc02a6600 <hash_list>
ffffffffc020410a:	953e                	add	a0,a0,a5
    __list_add(elm, listelm, listelm->next);
ffffffffc020410c:	650c                	ld	a1,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc020410e:	7014                	ld	a3,32(s0)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc0204110:	0d840793          	addi	a5,s0,216
    prev->next = next->prev = elm;
ffffffffc0204114:	e19c                	sd	a5,0(a1)
    __list_add(elm, listelm, listelm->next);
ffffffffc0204116:	00893603          	ld	a2,8(s2)
    prev->next = next->prev = elm;
ffffffffc020411a:	e51c                	sd	a5,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc020411c:	7af8                	ld	a4,240(a3)
    list_add(&proc_list, &(proc->list_link));
ffffffffc020411e:	0c840793          	addi	a5,s0,200
    elm->next = next;
ffffffffc0204122:	f06c                	sd	a1,224(s0)
    elm->prev = prev;
ffffffffc0204124:	ec68                	sd	a0,216(s0)
    prev->next = next->prev = elm;
ffffffffc0204126:	e21c                	sd	a5,0(a2)
ffffffffc0204128:	00f93423          	sd	a5,8(s2)
    elm->next = next;
ffffffffc020412c:	e870                	sd	a2,208(s0)
    elm->prev = prev;
ffffffffc020412e:	0d243423          	sd	s2,200(s0)
    proc->yptr = NULL;
ffffffffc0204132:	0e043c23          	sd	zero,248(s0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc0204136:	10e43023          	sd	a4,256(s0)
ffffffffc020413a:	c311                	beqz	a4,ffffffffc020413e <do_fork+0x1b4>
        proc->optr->yptr = proc;
ffffffffc020413c:	ff60                	sd	s0,248(a4)
    nr_process++;
ffffffffc020413e:	409c                	lw	a5,0(s1)
    proc->parent->cptr = proc;
ffffffffc0204140:	fae0                	sd	s0,240(a3)
    nr_process++;
ffffffffc0204142:	2785                	addiw	a5,a5,1
ffffffffc0204144:	c09c                	sw	a5,0(s1)
    if (flag)
ffffffffc0204146:	12099963          	bnez	s3,ffffffffc0204278 <do_fork+0x2ee>
    wakeup_proc(proc);
ffffffffc020414a:	8522                	mv	a0,s0
ffffffffc020414c:	6a7000ef          	jal	ra,ffffffffc0204ff2 <wakeup_proc>
    ret = proc->pid;
ffffffffc0204150:	00442a03          	lw	s4,4(s0)
}
ffffffffc0204154:	70e6                	ld	ra,120(sp)
ffffffffc0204156:	7446                	ld	s0,112(sp)
ffffffffc0204158:	74a6                	ld	s1,104(sp)
ffffffffc020415a:	7906                	ld	s2,96(sp)
ffffffffc020415c:	69e6                	ld	s3,88(sp)
ffffffffc020415e:	6aa6                	ld	s5,72(sp)
ffffffffc0204160:	6b06                	ld	s6,64(sp)
ffffffffc0204162:	7be2                	ld	s7,56(sp)
ffffffffc0204164:	7c42                	ld	s8,48(sp)
ffffffffc0204166:	7ca2                	ld	s9,40(sp)
ffffffffc0204168:	7d02                	ld	s10,32(sp)
ffffffffc020416a:	6de2                	ld	s11,24(sp)
ffffffffc020416c:	8552                	mv	a0,s4
ffffffffc020416e:	6a46                	ld	s4,80(sp)
ffffffffc0204170:	6109                	addi	sp,sp,128
ffffffffc0204172:	8082                	ret
        last_pid = 1;
ffffffffc0204174:	4785                	li	a5,1
ffffffffc0204176:	00f82023          	sw	a5,0(a6)
        goto inside;
ffffffffc020417a:	4505                	li	a0,1
ffffffffc020417c:	000a2317          	auipc	t1,0xa2
ffffffffc0204180:	06830313          	addi	t1,t1,104 # ffffffffc02a61e4 <next_safe.0>
    return listelm->next;
ffffffffc0204184:	000a6917          	auipc	s2,0xa6
ffffffffc0204188:	47c90913          	addi	s2,s2,1148 # ffffffffc02aa600 <proc_list>
ffffffffc020418c:	00893e03          	ld	t3,8(s2)
        next_safe = MAX_PID;
ffffffffc0204190:	6789                	lui	a5,0x2
ffffffffc0204192:	00f32023          	sw	a5,0(t1)
ffffffffc0204196:	86aa                	mv	a3,a0
ffffffffc0204198:	4581                	li	a1,0
        while ((le = list_next(le)) != list)
ffffffffc020419a:	6e89                	lui	t4,0x2
ffffffffc020419c:	132e0d63          	beq	t3,s2,ffffffffc02042d6 <do_fork+0x34c>
ffffffffc02041a0:	88ae                	mv	a7,a1
ffffffffc02041a2:	87f2                	mv	a5,t3
ffffffffc02041a4:	6609                	lui	a2,0x2
ffffffffc02041a6:	a811                	j	ffffffffc02041ba <do_fork+0x230>
            else if (proc->pid > last_pid && next_safe > proc->pid)
ffffffffc02041a8:	00e6d663          	bge	a3,a4,ffffffffc02041b4 <do_fork+0x22a>
ffffffffc02041ac:	00c75463          	bge	a4,a2,ffffffffc02041b4 <do_fork+0x22a>
ffffffffc02041b0:	863a                	mv	a2,a4
ffffffffc02041b2:	4885                	li	a7,1
ffffffffc02041b4:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc02041b6:	01278d63          	beq	a5,s2,ffffffffc02041d0 <do_fork+0x246>
            if (proc->pid == last_pid)
ffffffffc02041ba:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_obj___user_faultread_out_size-0x7c64>
ffffffffc02041be:	fed715e3          	bne	a4,a3,ffffffffc02041a8 <do_fork+0x21e>
                if (++last_pid >= next_safe)
ffffffffc02041c2:	2685                	addiw	a3,a3,1
ffffffffc02041c4:	0ec6dc63          	bge	a3,a2,ffffffffc02042bc <do_fork+0x332>
ffffffffc02041c8:	679c                	ld	a5,8(a5)
ffffffffc02041ca:	4585                	li	a1,1
        while ((le = list_next(le)) != list)
ffffffffc02041cc:	ff2797e3          	bne	a5,s2,ffffffffc02041ba <do_fork+0x230>
ffffffffc02041d0:	c581                	beqz	a1,ffffffffc02041d8 <do_fork+0x24e>
ffffffffc02041d2:	00d82023          	sw	a3,0(a6)
ffffffffc02041d6:	8536                	mv	a0,a3
ffffffffc02041d8:	f0088ce3          	beqz	a7,ffffffffc02040f0 <do_fork+0x166>
ffffffffc02041dc:	00c32023          	sw	a2,0(t1)
ffffffffc02041e0:	bf01                	j	ffffffffc02040f0 <do_fork+0x166>
    if ((mm = mm_create()) == NULL)
ffffffffc02041e2:	cb4ff0ef          	jal	ra,ffffffffc0203696 <mm_create>
ffffffffc02041e6:	8c2a                	mv	s8,a0
ffffffffc02041e8:	10050163          	beqz	a0,ffffffffc02042ea <do_fork+0x360>
    if ((page = alloc_page()) == NULL)
ffffffffc02041ec:	4505                	li	a0,1
ffffffffc02041ee:	ca7fd0ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc02041f2:	c551                	beqz	a0,ffffffffc020427e <do_fork+0x2f4>
    return page - pages + nbase;
ffffffffc02041f4:	000cb683          	ld	a3,0(s9)
ffffffffc02041f8:	6722                	ld	a4,8(sp)
    return KADDR(page2pa(page));
ffffffffc02041fa:	000d3783          	ld	a5,0(s10)
    return page - pages + nbase;
ffffffffc02041fe:	40d506b3          	sub	a3,a0,a3
ffffffffc0204202:	8699                	srai	a3,a3,0x6
ffffffffc0204204:	96ba                	add	a3,a3,a4
    return KADDR(page2pa(page));
ffffffffc0204206:	0166fb33          	and	s6,a3,s6
    return page2ppn(page) << PGSHIFT;
ffffffffc020420a:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc020420c:	0efb7163          	bgeu	s6,a5,ffffffffc02042ee <do_fork+0x364>
ffffffffc0204210:	000dba03          	ld	s4,0(s11)
    memcpy(pgdir, boot_pgdir_va, PGSIZE);
ffffffffc0204214:	6605                	lui	a2,0x1
ffffffffc0204216:	000a6597          	auipc	a1,0xa6
ffffffffc020421a:	4325b583          	ld	a1,1074(a1) # ffffffffc02aa648 <boot_pgdir_va>
ffffffffc020421e:	9a36                	add	s4,s4,a3
ffffffffc0204220:	8552                	mv	a0,s4
ffffffffc0204222:	474010ef          	jal	ra,ffffffffc0205696 <memcpy>
static inline void
lock_mm(struct mm_struct *mm)
{
    if (mm != NULL)
    {
        lock(&(mm->mm_lock));
ffffffffc0204226:	038b8b13          	addi	s6,s7,56
    mm->pgdir = pgdir;
ffffffffc020422a:	014c3c23          	sd	s4,24(s8)
 * test_and_set_bit - Atomically set a bit and return its old value
 * @nr:     the bit to set
 * @addr:   the address to count from
 * */
static inline bool test_and_set_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc020422e:	4785                	li	a5,1
ffffffffc0204230:	40fb37af          	amoor.d	a5,a5,(s6)
}

static inline void
lock(lock_t *lock)
{
    while (!try_lock(lock))
ffffffffc0204234:	8b85                	andi	a5,a5,1
ffffffffc0204236:	4a05                	li	s4,1
ffffffffc0204238:	c799                	beqz	a5,ffffffffc0204246 <do_fork+0x2bc>
    {
        schedule();
ffffffffc020423a:	639000ef          	jal	ra,ffffffffc0205072 <schedule>
ffffffffc020423e:	414b37af          	amoor.d	a5,s4,(s6)
    while (!try_lock(lock))
ffffffffc0204242:	8b85                	andi	a5,a5,1
ffffffffc0204244:	fbfd                	bnez	a5,ffffffffc020423a <do_fork+0x2b0>
        ret = dup_mmap(mm, oldmm);
ffffffffc0204246:	85de                	mv	a1,s7
ffffffffc0204248:	8562                	mv	a0,s8
ffffffffc020424a:	e8eff0ef          	jal	ra,ffffffffc02038d8 <dup_mmap>
ffffffffc020424e:	8a2a                	mv	s4,a0
 * test_and_clear_bit - Atomically clear a bit and return its old value
 * @nr:     the bit to clear
 * @addr:   the address to count from
 * */
static inline bool test_and_clear_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0204250:	57f9                	li	a5,-2
ffffffffc0204252:	60fb37af          	amoand.d	a5,a5,(s6)
ffffffffc0204256:	8b85                	andi	a5,a5,1
}

static inline void
unlock(lock_t *lock)
{
    if (!test_and_clear_bit(0, lock))
ffffffffc0204258:	c7dd                	beqz	a5,ffffffffc0204306 <do_fork+0x37c>
good_mm:
ffffffffc020425a:	8be2                	mv	s7,s8
    if (ret != 0)
ffffffffc020425c:	de0504e3          	beqz	a0,ffffffffc0204044 <do_fork+0xba>
    exit_mmap(mm);
ffffffffc0204260:	8562                	mv	a0,s8
ffffffffc0204262:	f10ff0ef          	jal	ra,ffffffffc0203972 <exit_mmap>
    put_pgdir(mm);
ffffffffc0204266:	8562                	mv	a0,s8
ffffffffc0204268:	c43ff0ef          	jal	ra,ffffffffc0203eaa <put_pgdir>
    mm_destroy(mm);
ffffffffc020426c:	8562                	mv	a0,s8
ffffffffc020426e:	d68ff0ef          	jal	ra,ffffffffc02037d6 <mm_destroy>
ffffffffc0204272:	a811                	j	ffffffffc0204286 <do_fork+0x2fc>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc0204274:	8936                	mv	s2,a3
ffffffffc0204276:	b535                	j	ffffffffc02040a2 <do_fork+0x118>
        intr_enable();
ffffffffc0204278:	f36fc0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020427c:	b5f9                	j	ffffffffc020414a <do_fork+0x1c0>
    mm_destroy(mm);
ffffffffc020427e:	8562                	mv	a0,s8
ffffffffc0204280:	d56ff0ef          	jal	ra,ffffffffc02037d6 <mm_destroy>
    int ret = -E_NO_MEM;
ffffffffc0204284:	5a71                	li	s4,-4
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc0204286:	6814                	ld	a3,16(s0)
    return pa2page(PADDR(kva));
ffffffffc0204288:	c02007b7          	lui	a5,0xc0200
ffffffffc020428c:	0cf6e263          	bltu	a3,a5,ffffffffc0204350 <do_fork+0x3c6>
ffffffffc0204290:	000db703          	ld	a4,0(s11)
    if (PPN(pa) >= npage)
ffffffffc0204294:	000d3783          	ld	a5,0(s10)
    return pa2page(PADDR(kva));
ffffffffc0204298:	8e99                	sub	a3,a3,a4
    if (PPN(pa) >= npage)
ffffffffc020429a:	82b1                	srli	a3,a3,0xc
ffffffffc020429c:	08f6fe63          	bgeu	a3,a5,ffffffffc0204338 <do_fork+0x3ae>
    return &pages[PPN(pa) - nbase];
ffffffffc02042a0:	000ab783          	ld	a5,0(s5)
ffffffffc02042a4:	000cb503          	ld	a0,0(s9)
ffffffffc02042a8:	4589                	li	a1,2
ffffffffc02042aa:	8e9d                	sub	a3,a3,a5
ffffffffc02042ac:	069a                	slli	a3,a3,0x6
ffffffffc02042ae:	9536                	add	a0,a0,a3
ffffffffc02042b0:	c23fd0ef          	jal	ra,ffffffffc0201ed2 <free_pages>
    kfree(proc);
ffffffffc02042b4:	8522                	mv	a0,s0
ffffffffc02042b6:	ab1fd0ef          	jal	ra,ffffffffc0201d66 <kfree>
    goto fork_out;
ffffffffc02042ba:	bd69                	j	ffffffffc0204154 <do_fork+0x1ca>
                    if (last_pid >= MAX_PID)
ffffffffc02042bc:	01d6c363          	blt	a3,t4,ffffffffc02042c2 <do_fork+0x338>
                        last_pid = 1;
ffffffffc02042c0:	4685                	li	a3,1
                    goto repeat;
ffffffffc02042c2:	4585                	li	a1,1
ffffffffc02042c4:	bde1                	j	ffffffffc020419c <do_fork+0x212>
        intr_disable();
ffffffffc02042c6:	eeefc0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc02042ca:	4985                	li	s3,1
ffffffffc02042cc:	bbcd                	j	ffffffffc02040be <do_fork+0x134>
    return -E_NO_MEM;
ffffffffc02042ce:	5a71                	li	s4,-4
ffffffffc02042d0:	b7d5                	j	ffffffffc02042b4 <do_fork+0x32a>
    int ret = -E_NO_FREE_PROC;
ffffffffc02042d2:	5a6d                	li	s4,-5
ffffffffc02042d4:	b541                	j	ffffffffc0204154 <do_fork+0x1ca>
ffffffffc02042d6:	c599                	beqz	a1,ffffffffc02042e4 <do_fork+0x35a>
ffffffffc02042d8:	00d82023          	sw	a3,0(a6)
    return last_pid;
ffffffffc02042dc:	8536                	mv	a0,a3
ffffffffc02042de:	bd09                	j	ffffffffc02040f0 <do_fork+0x166>
    ret = -E_NO_MEM;
ffffffffc02042e0:	5a71                	li	s4,-4
ffffffffc02042e2:	bd8d                	j	ffffffffc0204154 <do_fork+0x1ca>
    return last_pid;
ffffffffc02042e4:	00082503          	lw	a0,0(a6)
ffffffffc02042e8:	b521                	j	ffffffffc02040f0 <do_fork+0x166>
    int ret = -E_NO_MEM;
ffffffffc02042ea:	5a71                	li	s4,-4
ffffffffc02042ec:	bf69                	j	ffffffffc0204286 <do_fork+0x2fc>
    return KADDR(page2pa(page));
ffffffffc02042ee:	00002617          	auipc	a2,0x2
ffffffffc02042f2:	23a60613          	addi	a2,a2,570 # ffffffffc0206528 <default_pmm_manager+0x38>
ffffffffc02042f6:	07100593          	li	a1,113
ffffffffc02042fa:	00002517          	auipc	a0,0x2
ffffffffc02042fe:	25650513          	addi	a0,a0,598 # ffffffffc0206550 <default_pmm_manager+0x60>
ffffffffc0204302:	98cfc0ef          	jal	ra,ffffffffc020048e <__panic>
    {
        panic("Unlock failed.\n");
ffffffffc0204306:	00003617          	auipc	a2,0x3
ffffffffc020430a:	c6260613          	addi	a2,a2,-926 # ffffffffc0206f68 <default_pmm_manager+0xa78>
ffffffffc020430e:	03f00593          	li	a1,63
ffffffffc0204312:	00003517          	auipc	a0,0x3
ffffffffc0204316:	c6650513          	addi	a0,a0,-922 # ffffffffc0206f78 <default_pmm_manager+0xa88>
ffffffffc020431a:	974fc0ef          	jal	ra,ffffffffc020048e <__panic>
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc020431e:	86be                	mv	a3,a5
ffffffffc0204320:	00002617          	auipc	a2,0x2
ffffffffc0204324:	2b060613          	addi	a2,a2,688 # ffffffffc02065d0 <default_pmm_manager+0xe0>
ffffffffc0204328:	1a700593          	li	a1,423
ffffffffc020432c:	00003517          	auipc	a0,0x3
ffffffffc0204330:	c2450513          	addi	a0,a0,-988 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc0204334:	95afc0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0204338:	00002617          	auipc	a2,0x2
ffffffffc020433c:	2c060613          	addi	a2,a2,704 # ffffffffc02065f8 <default_pmm_manager+0x108>
ffffffffc0204340:	06900593          	li	a1,105
ffffffffc0204344:	00002517          	auipc	a0,0x2
ffffffffc0204348:	20c50513          	addi	a0,a0,524 # ffffffffc0206550 <default_pmm_manager+0x60>
ffffffffc020434c:	942fc0ef          	jal	ra,ffffffffc020048e <__panic>
    return pa2page(PADDR(kva));
ffffffffc0204350:	00002617          	auipc	a2,0x2
ffffffffc0204354:	28060613          	addi	a2,a2,640 # ffffffffc02065d0 <default_pmm_manager+0xe0>
ffffffffc0204358:	07700593          	li	a1,119
ffffffffc020435c:	00002517          	auipc	a0,0x2
ffffffffc0204360:	1f450513          	addi	a0,a0,500 # ffffffffc0206550 <default_pmm_manager+0x60>
ffffffffc0204364:	92afc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0204368 <kernel_thread>:
{
ffffffffc0204368:	7129                	addi	sp,sp,-320
ffffffffc020436a:	fa22                	sd	s0,304(sp)
ffffffffc020436c:	f626                	sd	s1,296(sp)
ffffffffc020436e:	f24a                	sd	s2,288(sp)
ffffffffc0204370:	84ae                	mv	s1,a1
ffffffffc0204372:	892a                	mv	s2,a0
ffffffffc0204374:	8432                	mv	s0,a2
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc0204376:	4581                	li	a1,0
ffffffffc0204378:	12000613          	li	a2,288
ffffffffc020437c:	850a                	mv	a0,sp
{
ffffffffc020437e:	fe06                	sd	ra,312(sp)
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc0204380:	304010ef          	jal	ra,ffffffffc0205684 <memset>
    tf.gpr.s0 = (uintptr_t)fn;
ffffffffc0204384:	e0ca                	sd	s2,64(sp)
    tf.gpr.s1 = (uintptr_t)arg;
ffffffffc0204386:	e4a6                	sd	s1,72(sp)
    tf.status = (read_csr(sstatus) | SSTATUS_SPP | SSTATUS_SPIE) & ~SSTATUS_SIE;
ffffffffc0204388:	100027f3          	csrr	a5,sstatus
ffffffffc020438c:	edd7f793          	andi	a5,a5,-291
ffffffffc0204390:	1207e793          	ori	a5,a5,288
ffffffffc0204394:	e23e                	sd	a5,256(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc0204396:	860a                	mv	a2,sp
ffffffffc0204398:	10046513          	ori	a0,s0,256
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc020439c:	00000797          	auipc	a5,0x0
ffffffffc02043a0:	a0478793          	addi	a5,a5,-1532 # ffffffffc0203da0 <kernel_thread_entry>
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc02043a4:	4581                	li	a1,0
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc02043a6:	e63e                	sd	a5,264(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc02043a8:	be3ff0ef          	jal	ra,ffffffffc0203f8a <do_fork>
}
ffffffffc02043ac:	70f2                	ld	ra,312(sp)
ffffffffc02043ae:	7452                	ld	s0,304(sp)
ffffffffc02043b0:	74b2                	ld	s1,296(sp)
ffffffffc02043b2:	7912                	ld	s2,288(sp)
ffffffffc02043b4:	6131                	addi	sp,sp,320
ffffffffc02043b6:	8082                	ret

ffffffffc02043b8 <do_exit>:
{
ffffffffc02043b8:	7179                	addi	sp,sp,-48
ffffffffc02043ba:	f022                	sd	s0,32(sp)
    if (current == idleproc)
ffffffffc02043bc:	000a6417          	auipc	s0,0xa6
ffffffffc02043c0:	2b440413          	addi	s0,s0,692 # ffffffffc02aa670 <current>
ffffffffc02043c4:	601c                	ld	a5,0(s0)
{
ffffffffc02043c6:	f406                	sd	ra,40(sp)
ffffffffc02043c8:	ec26                	sd	s1,24(sp)
ffffffffc02043ca:	e84a                	sd	s2,16(sp)
ffffffffc02043cc:	e44e                	sd	s3,8(sp)
ffffffffc02043ce:	e052                	sd	s4,0(sp)
    if (current == idleproc)
ffffffffc02043d0:	000a6717          	auipc	a4,0xa6
ffffffffc02043d4:	2a873703          	ld	a4,680(a4) # ffffffffc02aa678 <idleproc>
ffffffffc02043d8:	0ce78c63          	beq	a5,a4,ffffffffc02044b0 <do_exit+0xf8>
    if (current == initproc)
ffffffffc02043dc:	000a6497          	auipc	s1,0xa6
ffffffffc02043e0:	2a448493          	addi	s1,s1,676 # ffffffffc02aa680 <initproc>
ffffffffc02043e4:	6098                	ld	a4,0(s1)
ffffffffc02043e6:	0ee78b63          	beq	a5,a4,ffffffffc02044dc <do_exit+0x124>
    struct mm_struct *mm = current->mm;
ffffffffc02043ea:	0287b983          	ld	s3,40(a5)
ffffffffc02043ee:	892a                	mv	s2,a0
    if (mm != NULL)
ffffffffc02043f0:	02098663          	beqz	s3,ffffffffc020441c <do_exit+0x64>
ffffffffc02043f4:	000a6797          	auipc	a5,0xa6
ffffffffc02043f8:	24c7b783          	ld	a5,588(a5) # ffffffffc02aa640 <boot_pgdir_pa>
ffffffffc02043fc:	577d                	li	a4,-1
ffffffffc02043fe:	177e                	slli	a4,a4,0x3f
ffffffffc0204400:	83b1                	srli	a5,a5,0xc
ffffffffc0204402:	8fd9                	or	a5,a5,a4
ffffffffc0204404:	18079073          	csrw	satp,a5
    mm->mm_count -= 1;
ffffffffc0204408:	0309a783          	lw	a5,48(s3)
ffffffffc020440c:	fff7871b          	addiw	a4,a5,-1
ffffffffc0204410:	02e9a823          	sw	a4,48(s3)
        if (mm_count_dec(mm) == 0)
ffffffffc0204414:	cb55                	beqz	a4,ffffffffc02044c8 <do_exit+0x110>
        current->mm = NULL;
ffffffffc0204416:	601c                	ld	a5,0(s0)
ffffffffc0204418:	0207b423          	sd	zero,40(a5)
    current->state = PROC_ZOMBIE;
ffffffffc020441c:	601c                	ld	a5,0(s0)
ffffffffc020441e:	470d                	li	a4,3
ffffffffc0204420:	c398                	sw	a4,0(a5)
    current->exit_code = error_code;
ffffffffc0204422:	0f27a423          	sw	s2,232(a5)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204426:	100027f3          	csrr	a5,sstatus
ffffffffc020442a:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020442c:	4a01                	li	s4,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020442e:	e3f9                	bnez	a5,ffffffffc02044f4 <do_exit+0x13c>
        proc = current->parent;
ffffffffc0204430:	6018                	ld	a4,0(s0)
        if (proc->wait_state == WT_CHILD)
ffffffffc0204432:	800007b7          	lui	a5,0x80000
ffffffffc0204436:	0785                	addi	a5,a5,1
        proc = current->parent;
ffffffffc0204438:	7308                	ld	a0,32(a4)
        if (proc->wait_state == WT_CHILD)
ffffffffc020443a:	0ec52703          	lw	a4,236(a0)
ffffffffc020443e:	0af70f63          	beq	a4,a5,ffffffffc02044fc <do_exit+0x144>
        while (current->cptr != NULL)
ffffffffc0204442:	6018                	ld	a4,0(s0)
ffffffffc0204444:	7b7c                	ld	a5,240(a4)
ffffffffc0204446:	c3a1                	beqz	a5,ffffffffc0204486 <do_exit+0xce>
                if (initproc->wait_state == WT_CHILD)
ffffffffc0204448:	800009b7          	lui	s3,0x80000
            if (proc->state == PROC_ZOMBIE)
ffffffffc020444c:	490d                	li	s2,3
                if (initproc->wait_state == WT_CHILD)
ffffffffc020444e:	0985                	addi	s3,s3,1
ffffffffc0204450:	a021                	j	ffffffffc0204458 <do_exit+0xa0>
        while (current->cptr != NULL)
ffffffffc0204452:	6018                	ld	a4,0(s0)
ffffffffc0204454:	7b7c                	ld	a5,240(a4)
ffffffffc0204456:	cb85                	beqz	a5,ffffffffc0204486 <do_exit+0xce>
            current->cptr = proc->optr;
ffffffffc0204458:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_obj___user_exit_out_size+0xffffffff7fff4fe8>
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc020445c:	6088                	ld	a0,0(s1)
            current->cptr = proc->optr;
ffffffffc020445e:	fb74                	sd	a3,240(a4)
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc0204460:	7978                	ld	a4,240(a0)
            proc->yptr = NULL;
ffffffffc0204462:	0e07bc23          	sd	zero,248(a5)
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc0204466:	10e7b023          	sd	a4,256(a5)
ffffffffc020446a:	c311                	beqz	a4,ffffffffc020446e <do_exit+0xb6>
                initproc->cptr->yptr = proc;
ffffffffc020446c:	ff7c                	sd	a5,248(a4)
            if (proc->state == PROC_ZOMBIE)
ffffffffc020446e:	4398                	lw	a4,0(a5)
            proc->parent = initproc;
ffffffffc0204470:	f388                	sd	a0,32(a5)
            initproc->cptr = proc;
ffffffffc0204472:	f97c                	sd	a5,240(a0)
            if (proc->state == PROC_ZOMBIE)
ffffffffc0204474:	fd271fe3          	bne	a4,s2,ffffffffc0204452 <do_exit+0x9a>
                if (initproc->wait_state == WT_CHILD)
ffffffffc0204478:	0ec52783          	lw	a5,236(a0)
ffffffffc020447c:	fd379be3          	bne	a5,s3,ffffffffc0204452 <do_exit+0x9a>
                    wakeup_proc(initproc);
ffffffffc0204480:	373000ef          	jal	ra,ffffffffc0204ff2 <wakeup_proc>
ffffffffc0204484:	b7f9                	j	ffffffffc0204452 <do_exit+0x9a>
    if (flag)
ffffffffc0204486:	020a1263          	bnez	s4,ffffffffc02044aa <do_exit+0xf2>
    schedule();
ffffffffc020448a:	3e9000ef          	jal	ra,ffffffffc0205072 <schedule>
    panic("do_exit will not return!! %d.\n", current->pid);
ffffffffc020448e:	601c                	ld	a5,0(s0)
ffffffffc0204490:	00003617          	auipc	a2,0x3
ffffffffc0204494:	b2060613          	addi	a2,a2,-1248 # ffffffffc0206fb0 <default_pmm_manager+0xac0>
ffffffffc0204498:	25d00593          	li	a1,605
ffffffffc020449c:	43d4                	lw	a3,4(a5)
ffffffffc020449e:	00003517          	auipc	a0,0x3
ffffffffc02044a2:	ab250513          	addi	a0,a0,-1358 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc02044a6:	fe9fb0ef          	jal	ra,ffffffffc020048e <__panic>
        intr_enable();
ffffffffc02044aa:	d04fc0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc02044ae:	bff1                	j	ffffffffc020448a <do_exit+0xd2>
        panic("idleproc exit.\n");
ffffffffc02044b0:	00003617          	auipc	a2,0x3
ffffffffc02044b4:	ae060613          	addi	a2,a2,-1312 # ffffffffc0206f90 <default_pmm_manager+0xaa0>
ffffffffc02044b8:	22900593          	li	a1,553
ffffffffc02044bc:	00003517          	auipc	a0,0x3
ffffffffc02044c0:	a9450513          	addi	a0,a0,-1388 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc02044c4:	fcbfb0ef          	jal	ra,ffffffffc020048e <__panic>
            exit_mmap(mm);
ffffffffc02044c8:	854e                	mv	a0,s3
ffffffffc02044ca:	ca8ff0ef          	jal	ra,ffffffffc0203972 <exit_mmap>
            put_pgdir(mm);
ffffffffc02044ce:	854e                	mv	a0,s3
ffffffffc02044d0:	9dbff0ef          	jal	ra,ffffffffc0203eaa <put_pgdir>
            mm_destroy(mm);
ffffffffc02044d4:	854e                	mv	a0,s3
ffffffffc02044d6:	b00ff0ef          	jal	ra,ffffffffc02037d6 <mm_destroy>
ffffffffc02044da:	bf35                	j	ffffffffc0204416 <do_exit+0x5e>
        panic("initproc exit.\n");
ffffffffc02044dc:	00003617          	auipc	a2,0x3
ffffffffc02044e0:	ac460613          	addi	a2,a2,-1340 # ffffffffc0206fa0 <default_pmm_manager+0xab0>
ffffffffc02044e4:	22d00593          	li	a1,557
ffffffffc02044e8:	00003517          	auipc	a0,0x3
ffffffffc02044ec:	a6850513          	addi	a0,a0,-1432 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc02044f0:	f9ffb0ef          	jal	ra,ffffffffc020048e <__panic>
        intr_disable();
ffffffffc02044f4:	cc0fc0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc02044f8:	4a05                	li	s4,1
ffffffffc02044fa:	bf1d                	j	ffffffffc0204430 <do_exit+0x78>
            wakeup_proc(proc);
ffffffffc02044fc:	2f7000ef          	jal	ra,ffffffffc0204ff2 <wakeup_proc>
ffffffffc0204500:	b789                	j	ffffffffc0204442 <do_exit+0x8a>

ffffffffc0204502 <do_wait.part.0>:
int do_wait(int pid, int *code_store)
ffffffffc0204502:	715d                	addi	sp,sp,-80
ffffffffc0204504:	f84a                	sd	s2,48(sp)
ffffffffc0204506:	f44e                	sd	s3,40(sp)
        current->wait_state = WT_CHILD;
ffffffffc0204508:	80000937          	lui	s2,0x80000
    if (0 < pid && pid < MAX_PID)
ffffffffc020450c:	6989                	lui	s3,0x2
int do_wait(int pid, int *code_store)
ffffffffc020450e:	fc26                	sd	s1,56(sp)
ffffffffc0204510:	f052                	sd	s4,32(sp)
ffffffffc0204512:	ec56                	sd	s5,24(sp)
ffffffffc0204514:	e85a                	sd	s6,16(sp)
ffffffffc0204516:	e45e                	sd	s7,8(sp)
ffffffffc0204518:	e486                	sd	ra,72(sp)
ffffffffc020451a:	e0a2                	sd	s0,64(sp)
ffffffffc020451c:	84aa                	mv	s1,a0
ffffffffc020451e:	8a2e                	mv	s4,a1
        proc = current->cptr;
ffffffffc0204520:	000a6b97          	auipc	s7,0xa6
ffffffffc0204524:	150b8b93          	addi	s7,s7,336 # ffffffffc02aa670 <current>
    if (0 < pid && pid < MAX_PID)
ffffffffc0204528:	00050b1b          	sext.w	s6,a0
ffffffffc020452c:	fff50a9b          	addiw	s5,a0,-1
ffffffffc0204530:	19f9                	addi	s3,s3,-2
        current->wait_state = WT_CHILD;
ffffffffc0204532:	0905                	addi	s2,s2,1
    if (pid != 0)
ffffffffc0204534:	ccbd                	beqz	s1,ffffffffc02045b2 <do_wait.part.0+0xb0>
    if (0 < pid && pid < MAX_PID)
ffffffffc0204536:	0359e863          	bltu	s3,s5,ffffffffc0204566 <do_wait.part.0+0x64>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc020453a:	45a9                	li	a1,10
ffffffffc020453c:	855a                	mv	a0,s6
ffffffffc020453e:	4a1000ef          	jal	ra,ffffffffc02051de <hash32>
ffffffffc0204542:	02051793          	slli	a5,a0,0x20
ffffffffc0204546:	01c7d513          	srli	a0,a5,0x1c
ffffffffc020454a:	000a2797          	auipc	a5,0xa2
ffffffffc020454e:	0b678793          	addi	a5,a5,182 # ffffffffc02a6600 <hash_list>
ffffffffc0204552:	953e                	add	a0,a0,a5
ffffffffc0204554:	842a                	mv	s0,a0
        while ((le = list_next(le)) != list)
ffffffffc0204556:	a029                	j	ffffffffc0204560 <do_wait.part.0+0x5e>
            if (proc->pid == pid)
ffffffffc0204558:	f2c42783          	lw	a5,-212(s0)
ffffffffc020455c:	02978163          	beq	a5,s1,ffffffffc020457e <do_wait.part.0+0x7c>
ffffffffc0204560:	6400                	ld	s0,8(s0)
        while ((le = list_next(le)) != list)
ffffffffc0204562:	fe851be3          	bne	a0,s0,ffffffffc0204558 <do_wait.part.0+0x56>
    return -E_BAD_PROC;
ffffffffc0204566:	5579                	li	a0,-2
}
ffffffffc0204568:	60a6                	ld	ra,72(sp)
ffffffffc020456a:	6406                	ld	s0,64(sp)
ffffffffc020456c:	74e2                	ld	s1,56(sp)
ffffffffc020456e:	7942                	ld	s2,48(sp)
ffffffffc0204570:	79a2                	ld	s3,40(sp)
ffffffffc0204572:	7a02                	ld	s4,32(sp)
ffffffffc0204574:	6ae2                	ld	s5,24(sp)
ffffffffc0204576:	6b42                	ld	s6,16(sp)
ffffffffc0204578:	6ba2                	ld	s7,8(sp)
ffffffffc020457a:	6161                	addi	sp,sp,80
ffffffffc020457c:	8082                	ret
        if (proc != NULL && proc->parent == current)
ffffffffc020457e:	000bb683          	ld	a3,0(s7)
ffffffffc0204582:	f4843783          	ld	a5,-184(s0)
ffffffffc0204586:	fed790e3          	bne	a5,a3,ffffffffc0204566 <do_wait.part.0+0x64>
            if (proc->state == PROC_ZOMBIE)
ffffffffc020458a:	f2842703          	lw	a4,-216(s0)
ffffffffc020458e:	478d                	li	a5,3
ffffffffc0204590:	0ef70b63          	beq	a4,a5,ffffffffc0204686 <do_wait.part.0+0x184>
        current->state = PROC_SLEEPING;
ffffffffc0204594:	4785                	li	a5,1
ffffffffc0204596:	c29c                	sw	a5,0(a3)
        current->wait_state = WT_CHILD;
ffffffffc0204598:	0f26a623          	sw	s2,236(a3)
        schedule();
ffffffffc020459c:	2d7000ef          	jal	ra,ffffffffc0205072 <schedule>
        if (current->flags & PF_EXITING)
ffffffffc02045a0:	000bb783          	ld	a5,0(s7)
ffffffffc02045a4:	0b07a783          	lw	a5,176(a5)
ffffffffc02045a8:	8b85                	andi	a5,a5,1
ffffffffc02045aa:	d7c9                	beqz	a5,ffffffffc0204534 <do_wait.part.0+0x32>
            do_exit(-E_KILLED);
ffffffffc02045ac:	555d                	li	a0,-9
ffffffffc02045ae:	e0bff0ef          	jal	ra,ffffffffc02043b8 <do_exit>
        proc = current->cptr;
ffffffffc02045b2:	000bb683          	ld	a3,0(s7)
ffffffffc02045b6:	7ae0                	ld	s0,240(a3)
        for (; proc != NULL; proc = proc->optr)
ffffffffc02045b8:	d45d                	beqz	s0,ffffffffc0204566 <do_wait.part.0+0x64>
            if (proc->state == PROC_ZOMBIE)
ffffffffc02045ba:	470d                	li	a4,3
ffffffffc02045bc:	a021                	j	ffffffffc02045c4 <do_wait.part.0+0xc2>
        for (; proc != NULL; proc = proc->optr)
ffffffffc02045be:	10043403          	ld	s0,256(s0)
ffffffffc02045c2:	d869                	beqz	s0,ffffffffc0204594 <do_wait.part.0+0x92>
            if (proc->state == PROC_ZOMBIE)
ffffffffc02045c4:	401c                	lw	a5,0(s0)
ffffffffc02045c6:	fee79ce3          	bne	a5,a4,ffffffffc02045be <do_wait.part.0+0xbc>
    if (proc == idleproc || proc == initproc)
ffffffffc02045ca:	000a6797          	auipc	a5,0xa6
ffffffffc02045ce:	0ae7b783          	ld	a5,174(a5) # ffffffffc02aa678 <idleproc>
ffffffffc02045d2:	0c878963          	beq	a5,s0,ffffffffc02046a4 <do_wait.part.0+0x1a2>
ffffffffc02045d6:	000a6797          	auipc	a5,0xa6
ffffffffc02045da:	0aa7b783          	ld	a5,170(a5) # ffffffffc02aa680 <initproc>
ffffffffc02045de:	0cf40363          	beq	s0,a5,ffffffffc02046a4 <do_wait.part.0+0x1a2>
    if (code_store != NULL)
ffffffffc02045e2:	000a0663          	beqz	s4,ffffffffc02045ee <do_wait.part.0+0xec>
        *code_store = proc->exit_code;
ffffffffc02045e6:	0e842783          	lw	a5,232(s0)
ffffffffc02045ea:	00fa2023          	sw	a5,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8ba0>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02045ee:	100027f3          	csrr	a5,sstatus
ffffffffc02045f2:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02045f4:	4581                	li	a1,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02045f6:	e7c1                	bnez	a5,ffffffffc020467e <do_wait.part.0+0x17c>
    __list_del(listelm->prev, listelm->next);
ffffffffc02045f8:	6c70                	ld	a2,216(s0)
ffffffffc02045fa:	7074                	ld	a3,224(s0)
    if (proc->optr != NULL)
ffffffffc02045fc:	10043703          	ld	a4,256(s0)
        proc->optr->yptr = proc->yptr;
ffffffffc0204600:	7c7c                	ld	a5,248(s0)
    prev->next = next;
ffffffffc0204602:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0204604:	e290                	sd	a2,0(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc0204606:	6470                	ld	a2,200(s0)
ffffffffc0204608:	6874                	ld	a3,208(s0)
    prev->next = next;
ffffffffc020460a:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc020460c:	e290                	sd	a2,0(a3)
    if (proc->optr != NULL)
ffffffffc020460e:	c319                	beqz	a4,ffffffffc0204614 <do_wait.part.0+0x112>
        proc->optr->yptr = proc->yptr;
ffffffffc0204610:	ff7c                	sd	a5,248(a4)
    if (proc->yptr != NULL)
ffffffffc0204612:	7c7c                	ld	a5,248(s0)
ffffffffc0204614:	c3b5                	beqz	a5,ffffffffc0204678 <do_wait.part.0+0x176>
        proc->yptr->optr = proc->optr;
ffffffffc0204616:	10e7b023          	sd	a4,256(a5)
    nr_process--;
ffffffffc020461a:	000a6717          	auipc	a4,0xa6
ffffffffc020461e:	06e70713          	addi	a4,a4,110 # ffffffffc02aa688 <nr_process>
ffffffffc0204622:	431c                	lw	a5,0(a4)
ffffffffc0204624:	37fd                	addiw	a5,a5,-1
ffffffffc0204626:	c31c                	sw	a5,0(a4)
    if (flag)
ffffffffc0204628:	e5a9                	bnez	a1,ffffffffc0204672 <do_wait.part.0+0x170>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc020462a:	6814                	ld	a3,16(s0)
ffffffffc020462c:	c02007b7          	lui	a5,0xc0200
ffffffffc0204630:	04f6ee63          	bltu	a3,a5,ffffffffc020468c <do_wait.part.0+0x18a>
ffffffffc0204634:	000a6797          	auipc	a5,0xa6
ffffffffc0204638:	0347b783          	ld	a5,52(a5) # ffffffffc02aa668 <va_pa_offset>
ffffffffc020463c:	8e9d                	sub	a3,a3,a5
    if (PPN(pa) >= npage)
ffffffffc020463e:	82b1                	srli	a3,a3,0xc
ffffffffc0204640:	000a6797          	auipc	a5,0xa6
ffffffffc0204644:	0107b783          	ld	a5,16(a5) # ffffffffc02aa650 <npage>
ffffffffc0204648:	06f6fa63          	bgeu	a3,a5,ffffffffc02046bc <do_wait.part.0+0x1ba>
    return &pages[PPN(pa) - nbase];
ffffffffc020464c:	00003517          	auipc	a0,0x3
ffffffffc0204650:	19c53503          	ld	a0,412(a0) # ffffffffc02077e8 <nbase>
ffffffffc0204654:	8e89                	sub	a3,a3,a0
ffffffffc0204656:	069a                	slli	a3,a3,0x6
ffffffffc0204658:	000a6517          	auipc	a0,0xa6
ffffffffc020465c:	00053503          	ld	a0,0(a0) # ffffffffc02aa658 <pages>
ffffffffc0204660:	9536                	add	a0,a0,a3
ffffffffc0204662:	4589                	li	a1,2
ffffffffc0204664:	86ffd0ef          	jal	ra,ffffffffc0201ed2 <free_pages>
    kfree(proc);
ffffffffc0204668:	8522                	mv	a0,s0
ffffffffc020466a:	efcfd0ef          	jal	ra,ffffffffc0201d66 <kfree>
    return 0;
ffffffffc020466e:	4501                	li	a0,0
ffffffffc0204670:	bde5                	j	ffffffffc0204568 <do_wait.part.0+0x66>
        intr_enable();
ffffffffc0204672:	b3cfc0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0204676:	bf55                	j	ffffffffc020462a <do_wait.part.0+0x128>
        proc->parent->cptr = proc->optr;
ffffffffc0204678:	701c                	ld	a5,32(s0)
ffffffffc020467a:	fbf8                	sd	a4,240(a5)
ffffffffc020467c:	bf79                	j	ffffffffc020461a <do_wait.part.0+0x118>
        intr_disable();
ffffffffc020467e:	b36fc0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc0204682:	4585                	li	a1,1
ffffffffc0204684:	bf95                	j	ffffffffc02045f8 <do_wait.part.0+0xf6>
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc0204686:	f2840413          	addi	s0,s0,-216
ffffffffc020468a:	b781                	j	ffffffffc02045ca <do_wait.part.0+0xc8>
    return pa2page(PADDR(kva));
ffffffffc020468c:	00002617          	auipc	a2,0x2
ffffffffc0204690:	f4460613          	addi	a2,a2,-188 # ffffffffc02065d0 <default_pmm_manager+0xe0>
ffffffffc0204694:	07700593          	li	a1,119
ffffffffc0204698:	00002517          	auipc	a0,0x2
ffffffffc020469c:	eb850513          	addi	a0,a0,-328 # ffffffffc0206550 <default_pmm_manager+0x60>
ffffffffc02046a0:	deffb0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("wait idleproc or initproc.\n");
ffffffffc02046a4:	00003617          	auipc	a2,0x3
ffffffffc02046a8:	92c60613          	addi	a2,a2,-1748 # ffffffffc0206fd0 <default_pmm_manager+0xae0>
ffffffffc02046ac:	37e00593          	li	a1,894
ffffffffc02046b0:	00003517          	auipc	a0,0x3
ffffffffc02046b4:	8a050513          	addi	a0,a0,-1888 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc02046b8:	dd7fb0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02046bc:	00002617          	auipc	a2,0x2
ffffffffc02046c0:	f3c60613          	addi	a2,a2,-196 # ffffffffc02065f8 <default_pmm_manager+0x108>
ffffffffc02046c4:	06900593          	li	a1,105
ffffffffc02046c8:	00002517          	auipc	a0,0x2
ffffffffc02046cc:	e8850513          	addi	a0,a0,-376 # ffffffffc0206550 <default_pmm_manager+0x60>
ffffffffc02046d0:	dbffb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02046d4 <init_main>:
}

// init_main - the second kernel thread used to create user_main kernel threads
static int
init_main(void *arg)
{
ffffffffc02046d4:	1141                	addi	sp,sp,-16
ffffffffc02046d6:	e406                	sd	ra,8(sp)
    size_t nr_free_pages_store = nr_free_pages();
ffffffffc02046d8:	83bfd0ef          	jal	ra,ffffffffc0201f12 <nr_free_pages>
    size_t kernel_allocated_store = kallocated();
ffffffffc02046dc:	dd6fd0ef          	jal	ra,ffffffffc0201cb2 <kallocated>

    int pid = kernel_thread(user_main, NULL, 0);
ffffffffc02046e0:	4601                	li	a2,0
ffffffffc02046e2:	4581                	li	a1,0
ffffffffc02046e4:	fffff517          	auipc	a0,0xfffff
ffffffffc02046e8:	74850513          	addi	a0,a0,1864 # ffffffffc0203e2c <user_main>
ffffffffc02046ec:	c7dff0ef          	jal	ra,ffffffffc0204368 <kernel_thread>
    if (pid <= 0)
ffffffffc02046f0:	00a04563          	bgtz	a0,ffffffffc02046fa <init_main+0x26>
ffffffffc02046f4:	a071                	j	ffffffffc0204780 <init_main+0xac>
        panic("create user_main failed.\n");
    }

    while (do_wait(0, NULL) == 0)
    {
        schedule();
ffffffffc02046f6:	17d000ef          	jal	ra,ffffffffc0205072 <schedule>
    if (code_store != NULL)
ffffffffc02046fa:	4581                	li	a1,0
ffffffffc02046fc:	4501                	li	a0,0
ffffffffc02046fe:	e05ff0ef          	jal	ra,ffffffffc0204502 <do_wait.part.0>
    while (do_wait(0, NULL) == 0)
ffffffffc0204702:	d975                	beqz	a0,ffffffffc02046f6 <init_main+0x22>
    }

    cprintf("all user-mode processes have quit.\n");
ffffffffc0204704:	00003517          	auipc	a0,0x3
ffffffffc0204708:	90c50513          	addi	a0,a0,-1780 # ffffffffc0207010 <default_pmm_manager+0xb20>
ffffffffc020470c:	a89fb0ef          	jal	ra,ffffffffc0200194 <cprintf>
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0204710:	000a6797          	auipc	a5,0xa6
ffffffffc0204714:	f707b783          	ld	a5,-144(a5) # ffffffffc02aa680 <initproc>
ffffffffc0204718:	7bf8                	ld	a4,240(a5)
ffffffffc020471a:	e339                	bnez	a4,ffffffffc0204760 <init_main+0x8c>
ffffffffc020471c:	7ff8                	ld	a4,248(a5)
ffffffffc020471e:	e329                	bnez	a4,ffffffffc0204760 <init_main+0x8c>
ffffffffc0204720:	1007b703          	ld	a4,256(a5)
ffffffffc0204724:	ef15                	bnez	a4,ffffffffc0204760 <init_main+0x8c>
    assert(nr_process == 2);
ffffffffc0204726:	000a6697          	auipc	a3,0xa6
ffffffffc020472a:	f626a683          	lw	a3,-158(a3) # ffffffffc02aa688 <nr_process>
ffffffffc020472e:	4709                	li	a4,2
ffffffffc0204730:	0ae69463          	bne	a3,a4,ffffffffc02047d8 <init_main+0x104>
    return listelm->next;
ffffffffc0204734:	000a6697          	auipc	a3,0xa6
ffffffffc0204738:	ecc68693          	addi	a3,a3,-308 # ffffffffc02aa600 <proc_list>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc020473c:	6698                	ld	a4,8(a3)
ffffffffc020473e:	0c878793          	addi	a5,a5,200
ffffffffc0204742:	06f71b63          	bne	a4,a5,ffffffffc02047b8 <init_main+0xe4>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc0204746:	629c                	ld	a5,0(a3)
ffffffffc0204748:	04f71863          	bne	a4,a5,ffffffffc0204798 <init_main+0xc4>

    cprintf("init check memory pass.\n");
ffffffffc020474c:	00003517          	auipc	a0,0x3
ffffffffc0204750:	9ac50513          	addi	a0,a0,-1620 # ffffffffc02070f8 <default_pmm_manager+0xc08>
ffffffffc0204754:	a41fb0ef          	jal	ra,ffffffffc0200194 <cprintf>
    return 0;
}
ffffffffc0204758:	60a2                	ld	ra,8(sp)
ffffffffc020475a:	4501                	li	a0,0
ffffffffc020475c:	0141                	addi	sp,sp,16
ffffffffc020475e:	8082                	ret
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0204760:	00003697          	auipc	a3,0x3
ffffffffc0204764:	8d868693          	addi	a3,a3,-1832 # ffffffffc0207038 <default_pmm_manager+0xb48>
ffffffffc0204768:	00002617          	auipc	a2,0x2
ffffffffc020476c:	9d860613          	addi	a2,a2,-1576 # ffffffffc0206140 <commands+0x828>
ffffffffc0204770:	3ec00593          	li	a1,1004
ffffffffc0204774:	00002517          	auipc	a0,0x2
ffffffffc0204778:	7dc50513          	addi	a0,a0,2012 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc020477c:	d13fb0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("create user_main failed.\n");
ffffffffc0204780:	00003617          	auipc	a2,0x3
ffffffffc0204784:	87060613          	addi	a2,a2,-1936 # ffffffffc0206ff0 <default_pmm_manager+0xb00>
ffffffffc0204788:	3e300593          	li	a1,995
ffffffffc020478c:	00002517          	auipc	a0,0x2
ffffffffc0204790:	7c450513          	addi	a0,a0,1988 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc0204794:	cfbfb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc0204798:	00003697          	auipc	a3,0x3
ffffffffc020479c:	93068693          	addi	a3,a3,-1744 # ffffffffc02070c8 <default_pmm_manager+0xbd8>
ffffffffc02047a0:	00002617          	auipc	a2,0x2
ffffffffc02047a4:	9a060613          	addi	a2,a2,-1632 # ffffffffc0206140 <commands+0x828>
ffffffffc02047a8:	3ef00593          	li	a1,1007
ffffffffc02047ac:	00002517          	auipc	a0,0x2
ffffffffc02047b0:	7a450513          	addi	a0,a0,1956 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc02047b4:	cdbfb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc02047b8:	00003697          	auipc	a3,0x3
ffffffffc02047bc:	8e068693          	addi	a3,a3,-1824 # ffffffffc0207098 <default_pmm_manager+0xba8>
ffffffffc02047c0:	00002617          	auipc	a2,0x2
ffffffffc02047c4:	98060613          	addi	a2,a2,-1664 # ffffffffc0206140 <commands+0x828>
ffffffffc02047c8:	3ee00593          	li	a1,1006
ffffffffc02047cc:	00002517          	auipc	a0,0x2
ffffffffc02047d0:	78450513          	addi	a0,a0,1924 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc02047d4:	cbbfb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_process == 2);
ffffffffc02047d8:	00003697          	auipc	a3,0x3
ffffffffc02047dc:	8b068693          	addi	a3,a3,-1872 # ffffffffc0207088 <default_pmm_manager+0xb98>
ffffffffc02047e0:	00002617          	auipc	a2,0x2
ffffffffc02047e4:	96060613          	addi	a2,a2,-1696 # ffffffffc0206140 <commands+0x828>
ffffffffc02047e8:	3ed00593          	li	a1,1005
ffffffffc02047ec:	00002517          	auipc	a0,0x2
ffffffffc02047f0:	76450513          	addi	a0,a0,1892 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc02047f4:	c9bfb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02047f8 <do_execve>:
{
ffffffffc02047f8:	7171                	addi	sp,sp,-176
ffffffffc02047fa:	e4ee                	sd	s11,72(sp)
    struct mm_struct *mm = current->mm;
ffffffffc02047fc:	000a6d97          	auipc	s11,0xa6
ffffffffc0204800:	e74d8d93          	addi	s11,s11,-396 # ffffffffc02aa670 <current>
ffffffffc0204804:	000db783          	ld	a5,0(s11)
{
ffffffffc0204808:	e54e                	sd	s3,136(sp)
ffffffffc020480a:	ed26                	sd	s1,152(sp)
    struct mm_struct *mm = current->mm;
ffffffffc020480c:	0287b983          	ld	s3,40(a5)
{
ffffffffc0204810:	e94a                	sd	s2,144(sp)
ffffffffc0204812:	f4de                	sd	s7,104(sp)
ffffffffc0204814:	892a                	mv	s2,a0
ffffffffc0204816:	8bb2                	mv	s7,a2
ffffffffc0204818:	84ae                	mv	s1,a1
    if (!user_mem_check(mm, (uintptr_t)name, len, 0))
ffffffffc020481a:	862e                	mv	a2,a1
ffffffffc020481c:	4681                	li	a3,0
ffffffffc020481e:	85aa                	mv	a1,a0
ffffffffc0204820:	854e                	mv	a0,s3
{
ffffffffc0204822:	f506                	sd	ra,168(sp)
ffffffffc0204824:	f122                	sd	s0,160(sp)
ffffffffc0204826:	e152                	sd	s4,128(sp)
ffffffffc0204828:	fcd6                	sd	s5,120(sp)
ffffffffc020482a:	f8da                	sd	s6,112(sp)
ffffffffc020482c:	f0e2                	sd	s8,96(sp)
ffffffffc020482e:	ece6                	sd	s9,88(sp)
ffffffffc0204830:	e8ea                	sd	s10,80(sp)
ffffffffc0204832:	f05e                	sd	s7,32(sp)
    if (!user_mem_check(mm, (uintptr_t)name, len, 0))
ffffffffc0204834:	cd8ff0ef          	jal	ra,ffffffffc0203d0c <user_mem_check>
ffffffffc0204838:	40050a63          	beqz	a0,ffffffffc0204c4c <do_execve+0x454>
    memset(local_name, 0, sizeof(local_name));
ffffffffc020483c:	4641                	li	a2,16
ffffffffc020483e:	4581                	li	a1,0
ffffffffc0204840:	1808                	addi	a0,sp,48
ffffffffc0204842:	643000ef          	jal	ra,ffffffffc0205684 <memset>
    memcpy(local_name, name, len);
ffffffffc0204846:	47bd                	li	a5,15
ffffffffc0204848:	8626                	mv	a2,s1
ffffffffc020484a:	1e97e263          	bltu	a5,s1,ffffffffc0204a2e <do_execve+0x236>
ffffffffc020484e:	85ca                	mv	a1,s2
ffffffffc0204850:	1808                	addi	a0,sp,48
ffffffffc0204852:	645000ef          	jal	ra,ffffffffc0205696 <memcpy>
    if (mm != NULL)
ffffffffc0204856:	1e098363          	beqz	s3,ffffffffc0204a3c <do_execve+0x244>
        cputs("mm != NULL");
ffffffffc020485a:	00002517          	auipc	a0,0x2
ffffffffc020485e:	4b650513          	addi	a0,a0,1206 # ffffffffc0206d10 <default_pmm_manager+0x820>
ffffffffc0204862:	96bfb0ef          	jal	ra,ffffffffc02001cc <cputs>
ffffffffc0204866:	000a6797          	auipc	a5,0xa6
ffffffffc020486a:	dda7b783          	ld	a5,-550(a5) # ffffffffc02aa640 <boot_pgdir_pa>
ffffffffc020486e:	577d                	li	a4,-1
ffffffffc0204870:	177e                	slli	a4,a4,0x3f
ffffffffc0204872:	83b1                	srli	a5,a5,0xc
ffffffffc0204874:	8fd9                	or	a5,a5,a4
ffffffffc0204876:	18079073          	csrw	satp,a5
ffffffffc020487a:	0309a783          	lw	a5,48(s3) # 2030 <_binary_obj___user_faultread_out_size-0x7b70>
ffffffffc020487e:	fff7871b          	addiw	a4,a5,-1
ffffffffc0204882:	02e9a823          	sw	a4,48(s3)
        if (mm_count_dec(mm) == 0)
ffffffffc0204886:	2c070463          	beqz	a4,ffffffffc0204b4e <do_execve+0x356>
        current->mm = NULL;
ffffffffc020488a:	000db783          	ld	a5,0(s11)
ffffffffc020488e:	0207b423          	sd	zero,40(a5)
    if ((mm = mm_create()) == NULL)
ffffffffc0204892:	e05fe0ef          	jal	ra,ffffffffc0203696 <mm_create>
ffffffffc0204896:	84aa                	mv	s1,a0
ffffffffc0204898:	1c050d63          	beqz	a0,ffffffffc0204a72 <do_execve+0x27a>
    if ((page = alloc_page()) == NULL)
ffffffffc020489c:	4505                	li	a0,1
ffffffffc020489e:	df6fd0ef          	jal	ra,ffffffffc0201e94 <alloc_pages>
ffffffffc02048a2:	3a050963          	beqz	a0,ffffffffc0204c54 <do_execve+0x45c>
    return page - pages + nbase;
ffffffffc02048a6:	000a6c97          	auipc	s9,0xa6
ffffffffc02048aa:	db2c8c93          	addi	s9,s9,-590 # ffffffffc02aa658 <pages>
ffffffffc02048ae:	000cb683          	ld	a3,0(s9)
    return KADDR(page2pa(page));
ffffffffc02048b2:	000a6c17          	auipc	s8,0xa6
ffffffffc02048b6:	d9ec0c13          	addi	s8,s8,-610 # ffffffffc02aa650 <npage>
    return page - pages + nbase;
ffffffffc02048ba:	00003717          	auipc	a4,0x3
ffffffffc02048be:	f2e73703          	ld	a4,-210(a4) # ffffffffc02077e8 <nbase>
ffffffffc02048c2:	40d506b3          	sub	a3,a0,a3
ffffffffc02048c6:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc02048c8:	5afd                	li	s5,-1
ffffffffc02048ca:	000c3783          	ld	a5,0(s8)
    return page - pages + nbase;
ffffffffc02048ce:	96ba                	add	a3,a3,a4
ffffffffc02048d0:	e83a                	sd	a4,16(sp)
    return KADDR(page2pa(page));
ffffffffc02048d2:	00cad713          	srli	a4,s5,0xc
ffffffffc02048d6:	ec3a                	sd	a4,24(sp)
ffffffffc02048d8:	8f75                	and	a4,a4,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc02048da:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02048dc:	38f77063          	bgeu	a4,a5,ffffffffc0204c5c <do_execve+0x464>
ffffffffc02048e0:	000a6b17          	auipc	s6,0xa6
ffffffffc02048e4:	d88b0b13          	addi	s6,s6,-632 # ffffffffc02aa668 <va_pa_offset>
ffffffffc02048e8:	000b3903          	ld	s2,0(s6)
    memcpy(pgdir, boot_pgdir_va, PGSIZE);
ffffffffc02048ec:	6605                	lui	a2,0x1
ffffffffc02048ee:	000a6597          	auipc	a1,0xa6
ffffffffc02048f2:	d5a5b583          	ld	a1,-678(a1) # ffffffffc02aa648 <boot_pgdir_va>
ffffffffc02048f6:	9936                	add	s2,s2,a3
ffffffffc02048f8:	854a                	mv	a0,s2
ffffffffc02048fa:	59d000ef          	jal	ra,ffffffffc0205696 <memcpy>
    if (elf->e_magic != ELF_MAGIC)
ffffffffc02048fe:	7782                	ld	a5,32(sp)
ffffffffc0204900:	4398                	lw	a4,0(a5)
ffffffffc0204902:	464c47b7          	lui	a5,0x464c4
    mm->pgdir = pgdir;
ffffffffc0204906:	0124bc23          	sd	s2,24(s1)
    if (elf->e_magic != ELF_MAGIC)
ffffffffc020490a:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_obj___user_exit_out_size+0x464b9467>
ffffffffc020490e:	14f71863          	bne	a4,a5,ffffffffc0204a5e <do_execve+0x266>
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0204912:	7682                	ld	a3,32(sp)
ffffffffc0204914:	0386d703          	lhu	a4,56(a3)
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0204918:	0206b983          	ld	s3,32(a3)
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc020491c:	00371793          	slli	a5,a4,0x3
ffffffffc0204920:	8f99                	sub	a5,a5,a4
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0204922:	99b6                	add	s3,s3,a3
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0204924:	078e                	slli	a5,a5,0x3
ffffffffc0204926:	97ce                	add	a5,a5,s3
ffffffffc0204928:	f43e                	sd	a5,40(sp)
    for (; ph < ph_end; ph++)
ffffffffc020492a:	00f9fc63          	bgeu	s3,a5,ffffffffc0204942 <do_execve+0x14a>
        if (ph->p_type != ELF_PT_LOAD)
ffffffffc020492e:	0009a783          	lw	a5,0(s3)
ffffffffc0204932:	4705                	li	a4,1
ffffffffc0204934:	14e78163          	beq	a5,a4,ffffffffc0204a76 <do_execve+0x27e>
    for (; ph < ph_end; ph++)
ffffffffc0204938:	77a2                	ld	a5,40(sp)
ffffffffc020493a:	03898993          	addi	s3,s3,56
ffffffffc020493e:	fef9e8e3          	bltu	s3,a5,ffffffffc020492e <do_execve+0x136>
    if ((ret = mm_map(mm, USTACKTOP - USTACKSIZE, USTACKSIZE, vm_flags, NULL)) != 0)
ffffffffc0204942:	4701                	li	a4,0
ffffffffc0204944:	46ad                	li	a3,11
ffffffffc0204946:	00100637          	lui	a2,0x100
ffffffffc020494a:	7ff005b7          	lui	a1,0x7ff00
ffffffffc020494e:	8526                	mv	a0,s1
ffffffffc0204950:	ed9fe0ef          	jal	ra,ffffffffc0203828 <mm_map>
ffffffffc0204954:	8a2a                	mv	s4,a0
ffffffffc0204956:	1e051263          	bnez	a0,ffffffffc0204b3a <do_execve+0x342>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - PGSIZE, PTE_USER) != NULL);
ffffffffc020495a:	6c88                	ld	a0,24(s1)
ffffffffc020495c:	467d                	li	a2,31
ffffffffc020495e:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc0204962:	c4ffe0ef          	jal	ra,ffffffffc02035b0 <pgdir_alloc_page>
ffffffffc0204966:	38050363          	beqz	a0,ffffffffc0204cec <do_execve+0x4f4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 2 * PGSIZE, PTE_USER) != NULL);
ffffffffc020496a:	6c88                	ld	a0,24(s1)
ffffffffc020496c:	467d                	li	a2,31
ffffffffc020496e:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc0204972:	c3ffe0ef          	jal	ra,ffffffffc02035b0 <pgdir_alloc_page>
ffffffffc0204976:	34050b63          	beqz	a0,ffffffffc0204ccc <do_execve+0x4d4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 3 * PGSIZE, PTE_USER) != NULL);
ffffffffc020497a:	6c88                	ld	a0,24(s1)
ffffffffc020497c:	467d                	li	a2,31
ffffffffc020497e:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc0204982:	c2ffe0ef          	jal	ra,ffffffffc02035b0 <pgdir_alloc_page>
ffffffffc0204986:	32050363          	beqz	a0,ffffffffc0204cac <do_execve+0x4b4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 4 * PGSIZE, PTE_USER) != NULL);
ffffffffc020498a:	6c88                	ld	a0,24(s1)
ffffffffc020498c:	467d                	li	a2,31
ffffffffc020498e:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc0204992:	c1ffe0ef          	jal	ra,ffffffffc02035b0 <pgdir_alloc_page>
ffffffffc0204996:	2e050b63          	beqz	a0,ffffffffc0204c8c <do_execve+0x494>
    mm->mm_count += 1;
ffffffffc020499a:	589c                	lw	a5,48(s1)
    current->mm = mm;
ffffffffc020499c:	000db603          	ld	a2,0(s11)
    current->pgdir = PADDR(mm->pgdir);
ffffffffc02049a0:	6c94                	ld	a3,24(s1)
ffffffffc02049a2:	2785                	addiw	a5,a5,1
ffffffffc02049a4:	d89c                	sw	a5,48(s1)
    current->mm = mm;
ffffffffc02049a6:	f604                	sd	s1,40(a2)
    current->pgdir = PADDR(mm->pgdir);
ffffffffc02049a8:	c02007b7          	lui	a5,0xc0200
ffffffffc02049ac:	2cf6e463          	bltu	a3,a5,ffffffffc0204c74 <do_execve+0x47c>
ffffffffc02049b0:	000b3783          	ld	a5,0(s6)
ffffffffc02049b4:	577d                	li	a4,-1
ffffffffc02049b6:	177e                	slli	a4,a4,0x3f
ffffffffc02049b8:	8e9d                	sub	a3,a3,a5
ffffffffc02049ba:	00c6d793          	srli	a5,a3,0xc
ffffffffc02049be:	f654                	sd	a3,168(a2)
ffffffffc02049c0:	8fd9                	or	a5,a5,a4
ffffffffc02049c2:	18079073          	csrw	satp,a5
    struct trapframe *tf = current->tf;
ffffffffc02049c6:	7240                	ld	s0,160(a2)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc02049c8:	4581                	li	a1,0
ffffffffc02049ca:	12000613          	li	a2,288
ffffffffc02049ce:	8522                	mv	a0,s0
    uintptr_t sstatus = tf->status;
ffffffffc02049d0:	10043483          	ld	s1,256(s0)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc02049d4:	4b1000ef          	jal	ra,ffffffffc0205684 <memset>
    tf->epc = (uintptr_t)elf->e_entry;
ffffffffc02049d8:	7782                	ld	a5,32(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02049da:	000db903          	ld	s2,0(s11)
    tf->status = (sstatus & ~SSTATUS_SPP) | SSTATUS_SPIE;
ffffffffc02049de:	edf4f493          	andi	s1,s1,-289
    tf->epc = (uintptr_t)elf->e_entry;
ffffffffc02049e2:	6f98                	ld	a4,24(a5)
    tf->gpr.sp = USTACKTOP;
ffffffffc02049e4:	4785                	li	a5,1
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02049e6:	0b490913          	addi	s2,s2,180 # ffffffff800000b4 <_binary_obj___user_exit_out_size+0xffffffff7fff4f9c>
    tf->gpr.sp = USTACKTOP;
ffffffffc02049ea:	07fe                	slli	a5,a5,0x1f
    tf->status = (sstatus & ~SSTATUS_SPP) | SSTATUS_SPIE;
ffffffffc02049ec:	0204e493          	ori	s1,s1,32
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02049f0:	4641                	li	a2,16
ffffffffc02049f2:	4581                	li	a1,0
    tf->gpr.sp = USTACKTOP;
ffffffffc02049f4:	e81c                	sd	a5,16(s0)
    tf->epc = (uintptr_t)elf->e_entry;
ffffffffc02049f6:	10e43423          	sd	a4,264(s0)
    tf->status = (sstatus & ~SSTATUS_SPP) | SSTATUS_SPIE;
ffffffffc02049fa:	10943023          	sd	s1,256(s0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02049fe:	854a                	mv	a0,s2
ffffffffc0204a00:	485000ef          	jal	ra,ffffffffc0205684 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204a04:	463d                	li	a2,15
ffffffffc0204a06:	180c                	addi	a1,sp,48
ffffffffc0204a08:	854a                	mv	a0,s2
ffffffffc0204a0a:	48d000ef          	jal	ra,ffffffffc0205696 <memcpy>
}
ffffffffc0204a0e:	70aa                	ld	ra,168(sp)
ffffffffc0204a10:	740a                	ld	s0,160(sp)
ffffffffc0204a12:	64ea                	ld	s1,152(sp)
ffffffffc0204a14:	694a                	ld	s2,144(sp)
ffffffffc0204a16:	69aa                	ld	s3,136(sp)
ffffffffc0204a18:	7ae6                	ld	s5,120(sp)
ffffffffc0204a1a:	7b46                	ld	s6,112(sp)
ffffffffc0204a1c:	7ba6                	ld	s7,104(sp)
ffffffffc0204a1e:	7c06                	ld	s8,96(sp)
ffffffffc0204a20:	6ce6                	ld	s9,88(sp)
ffffffffc0204a22:	6d46                	ld	s10,80(sp)
ffffffffc0204a24:	6da6                	ld	s11,72(sp)
ffffffffc0204a26:	8552                	mv	a0,s4
ffffffffc0204a28:	6a0a                	ld	s4,128(sp)
ffffffffc0204a2a:	614d                	addi	sp,sp,176
ffffffffc0204a2c:	8082                	ret
    memcpy(local_name, name, len);
ffffffffc0204a2e:	463d                	li	a2,15
ffffffffc0204a30:	85ca                	mv	a1,s2
ffffffffc0204a32:	1808                	addi	a0,sp,48
ffffffffc0204a34:	463000ef          	jal	ra,ffffffffc0205696 <memcpy>
    if (mm != NULL)
ffffffffc0204a38:	e20991e3          	bnez	s3,ffffffffc020485a <do_execve+0x62>
    if (current->mm != NULL)
ffffffffc0204a3c:	000db783          	ld	a5,0(s11)
ffffffffc0204a40:	779c                	ld	a5,40(a5)
ffffffffc0204a42:	e40788e3          	beqz	a5,ffffffffc0204892 <do_execve+0x9a>
        panic("load_icode: current->mm must be empty.\n");
ffffffffc0204a46:	00002617          	auipc	a2,0x2
ffffffffc0204a4a:	6d260613          	addi	a2,a2,1746 # ffffffffc0207118 <default_pmm_manager+0xc28>
ffffffffc0204a4e:	26900593          	li	a1,617
ffffffffc0204a52:	00002517          	auipc	a0,0x2
ffffffffc0204a56:	4fe50513          	addi	a0,a0,1278 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc0204a5a:	a35fb0ef          	jal	ra,ffffffffc020048e <__panic>
    put_pgdir(mm);
ffffffffc0204a5e:	8526                	mv	a0,s1
ffffffffc0204a60:	c4aff0ef          	jal	ra,ffffffffc0203eaa <put_pgdir>
    mm_destroy(mm);
ffffffffc0204a64:	8526                	mv	a0,s1
ffffffffc0204a66:	d71fe0ef          	jal	ra,ffffffffc02037d6 <mm_destroy>
        ret = -E_INVAL_ELF;
ffffffffc0204a6a:	5a61                	li	s4,-8
    do_exit(ret);
ffffffffc0204a6c:	8552                	mv	a0,s4
ffffffffc0204a6e:	94bff0ef          	jal	ra,ffffffffc02043b8 <do_exit>
    int ret = -E_NO_MEM;
ffffffffc0204a72:	5a71                	li	s4,-4
ffffffffc0204a74:	bfe5                	j	ffffffffc0204a6c <do_execve+0x274>
        if (ph->p_filesz > ph->p_memsz)
ffffffffc0204a76:	0289b603          	ld	a2,40(s3)
ffffffffc0204a7a:	0209b783          	ld	a5,32(s3)
ffffffffc0204a7e:	1cf66d63          	bltu	a2,a5,ffffffffc0204c58 <do_execve+0x460>
        if (ph->p_flags & ELF_PF_X)
ffffffffc0204a82:	0049a783          	lw	a5,4(s3)
ffffffffc0204a86:	0017f693          	andi	a3,a5,1
ffffffffc0204a8a:	c291                	beqz	a3,ffffffffc0204a8e <do_execve+0x296>
            vm_flags |= VM_EXEC;
ffffffffc0204a8c:	4691                	li	a3,4
        if (ph->p_flags & ELF_PF_W)
ffffffffc0204a8e:	0027f713          	andi	a4,a5,2
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204a92:	8b91                	andi	a5,a5,4
        if (ph->p_flags & ELF_PF_W)
ffffffffc0204a94:	e779                	bnez	a4,ffffffffc0204b62 <do_execve+0x36a>
        vm_flags = 0, perm = PTE_U | PTE_V;
ffffffffc0204a96:	4d45                	li	s10,17
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204a98:	c781                	beqz	a5,ffffffffc0204aa0 <do_execve+0x2a8>
            vm_flags |= VM_READ;
ffffffffc0204a9a:	0016e693          	ori	a3,a3,1
            perm |= PTE_R;
ffffffffc0204a9e:	4d4d                	li	s10,19
        if (vm_flags & VM_WRITE)
ffffffffc0204aa0:	0026f793          	andi	a5,a3,2
ffffffffc0204aa4:	e3f1                	bnez	a5,ffffffffc0204b68 <do_execve+0x370>
        if (vm_flags & VM_EXEC)
ffffffffc0204aa6:	0046f793          	andi	a5,a3,4
ffffffffc0204aaa:	c399                	beqz	a5,ffffffffc0204ab0 <do_execve+0x2b8>
            perm |= PTE_X;
ffffffffc0204aac:	008d6d13          	ori	s10,s10,8
        if ((ret = mm_map(mm, ph->p_va, ph->p_memsz, vm_flags, NULL)) != 0)
ffffffffc0204ab0:	0109b583          	ld	a1,16(s3)
ffffffffc0204ab4:	4701                	li	a4,0
ffffffffc0204ab6:	8526                	mv	a0,s1
ffffffffc0204ab8:	d71fe0ef          	jal	ra,ffffffffc0203828 <mm_map>
ffffffffc0204abc:	8a2a                	mv	s4,a0
ffffffffc0204abe:	ed35                	bnez	a0,ffffffffc0204b3a <do_execve+0x342>
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204ac0:	0109bb83          	ld	s7,16(s3)
ffffffffc0204ac4:	77fd                	lui	a5,0xfffff
        end = ph->p_va + ph->p_filesz;
ffffffffc0204ac6:	0209ba03          	ld	s4,32(s3)
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204aca:	0089b903          	ld	s2,8(s3)
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204ace:	00fbfab3          	and	s5,s7,a5
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204ad2:	7782                	ld	a5,32(sp)
        end = ph->p_va + ph->p_filesz;
ffffffffc0204ad4:	9a5e                	add	s4,s4,s7
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204ad6:	993e                	add	s2,s2,a5
        while (start < end)
ffffffffc0204ad8:	054be963          	bltu	s7,s4,ffffffffc0204b2a <do_execve+0x332>
ffffffffc0204adc:	aa95                	j	ffffffffc0204c50 <do_execve+0x458>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204ade:	6785                	lui	a5,0x1
ffffffffc0204ae0:	415b8533          	sub	a0,s7,s5
ffffffffc0204ae4:	9abe                	add	s5,s5,a5
ffffffffc0204ae6:	417a8633          	sub	a2,s5,s7
            if (end < la)
ffffffffc0204aea:	015a7463          	bgeu	s4,s5,ffffffffc0204af2 <do_execve+0x2fa>
                size -= la - end;
ffffffffc0204aee:	417a0633          	sub	a2,s4,s7
    return page - pages + nbase;
ffffffffc0204af2:	000cb683          	ld	a3,0(s9)
ffffffffc0204af6:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204af8:	000c3583          	ld	a1,0(s8)
    return page - pages + nbase;
ffffffffc0204afc:	40d406b3          	sub	a3,s0,a3
ffffffffc0204b00:	8699                	srai	a3,a3,0x6
ffffffffc0204b02:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204b04:	67e2                	ld	a5,24(sp)
ffffffffc0204b06:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204b0a:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204b0c:	14b87863          	bgeu	a6,a1,ffffffffc0204c5c <do_execve+0x464>
ffffffffc0204b10:	000b3803          	ld	a6,0(s6)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204b14:	85ca                	mv	a1,s2
            start += size, from += size;
ffffffffc0204b16:	9bb2                	add	s7,s7,a2
ffffffffc0204b18:	96c2                	add	a3,a3,a6
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204b1a:	9536                	add	a0,a0,a3
            start += size, from += size;
ffffffffc0204b1c:	e432                	sd	a2,8(sp)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204b1e:	379000ef          	jal	ra,ffffffffc0205696 <memcpy>
            start += size, from += size;
ffffffffc0204b22:	6622                	ld	a2,8(sp)
ffffffffc0204b24:	9932                	add	s2,s2,a2
        while (start < end)
ffffffffc0204b26:	054bf363          	bgeu	s7,s4,ffffffffc0204b6c <do_execve+0x374>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
ffffffffc0204b2a:	6c88                	ld	a0,24(s1)
ffffffffc0204b2c:	866a                	mv	a2,s10
ffffffffc0204b2e:	85d6                	mv	a1,s5
ffffffffc0204b30:	a81fe0ef          	jal	ra,ffffffffc02035b0 <pgdir_alloc_page>
ffffffffc0204b34:	842a                	mv	s0,a0
ffffffffc0204b36:	f545                	bnez	a0,ffffffffc0204ade <do_execve+0x2e6>
        ret = -E_NO_MEM;
ffffffffc0204b38:	5a71                	li	s4,-4
    exit_mmap(mm);
ffffffffc0204b3a:	8526                	mv	a0,s1
ffffffffc0204b3c:	e37fe0ef          	jal	ra,ffffffffc0203972 <exit_mmap>
    put_pgdir(mm);
ffffffffc0204b40:	8526                	mv	a0,s1
ffffffffc0204b42:	b68ff0ef          	jal	ra,ffffffffc0203eaa <put_pgdir>
    mm_destroy(mm);
ffffffffc0204b46:	8526                	mv	a0,s1
ffffffffc0204b48:	c8ffe0ef          	jal	ra,ffffffffc02037d6 <mm_destroy>
    return ret;
ffffffffc0204b4c:	b705                	j	ffffffffc0204a6c <do_execve+0x274>
            exit_mmap(mm);
ffffffffc0204b4e:	854e                	mv	a0,s3
ffffffffc0204b50:	e23fe0ef          	jal	ra,ffffffffc0203972 <exit_mmap>
            put_pgdir(mm);
ffffffffc0204b54:	854e                	mv	a0,s3
ffffffffc0204b56:	b54ff0ef          	jal	ra,ffffffffc0203eaa <put_pgdir>
            mm_destroy(mm);
ffffffffc0204b5a:	854e                	mv	a0,s3
ffffffffc0204b5c:	c7bfe0ef          	jal	ra,ffffffffc02037d6 <mm_destroy>
ffffffffc0204b60:	b32d                	j	ffffffffc020488a <do_execve+0x92>
            vm_flags |= VM_WRITE;
ffffffffc0204b62:	0026e693          	ori	a3,a3,2
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204b66:	fb95                	bnez	a5,ffffffffc0204a9a <do_execve+0x2a2>
            perm |= (PTE_W | PTE_R);
ffffffffc0204b68:	4d5d                	li	s10,23
ffffffffc0204b6a:	bf35                	j	ffffffffc0204aa6 <do_execve+0x2ae>
        end = ph->p_va + ph->p_memsz;
ffffffffc0204b6c:	0109b683          	ld	a3,16(s3)
ffffffffc0204b70:	0289b903          	ld	s2,40(s3)
ffffffffc0204b74:	9936                	add	s2,s2,a3
        if (start < la)
ffffffffc0204b76:	075bfd63          	bgeu	s7,s5,ffffffffc0204bf0 <do_execve+0x3f8>
            if (start == end)
ffffffffc0204b7a:	db790fe3          	beq	s2,s7,ffffffffc0204938 <do_execve+0x140>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204b7e:	6785                	lui	a5,0x1
ffffffffc0204b80:	00fb8533          	add	a0,s7,a5
ffffffffc0204b84:	41550533          	sub	a0,a0,s5
                size -= la - end;
ffffffffc0204b88:	41790a33          	sub	s4,s2,s7
            if (end < la)
ffffffffc0204b8c:	0b597d63          	bgeu	s2,s5,ffffffffc0204c46 <do_execve+0x44e>
    return page - pages + nbase;
ffffffffc0204b90:	000cb683          	ld	a3,0(s9)
ffffffffc0204b94:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204b96:	000c3603          	ld	a2,0(s8)
    return page - pages + nbase;
ffffffffc0204b9a:	40d406b3          	sub	a3,s0,a3
ffffffffc0204b9e:	8699                	srai	a3,a3,0x6
ffffffffc0204ba0:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204ba2:	67e2                	ld	a5,24(sp)
ffffffffc0204ba4:	00f6f5b3          	and	a1,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204ba8:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204baa:	0ac5f963          	bgeu	a1,a2,ffffffffc0204c5c <do_execve+0x464>
ffffffffc0204bae:	000b3803          	ld	a6,0(s6)
            memset(page2kva(page) + off, 0, size);
ffffffffc0204bb2:	8652                	mv	a2,s4
ffffffffc0204bb4:	4581                	li	a1,0
ffffffffc0204bb6:	96c2                	add	a3,a3,a6
ffffffffc0204bb8:	9536                	add	a0,a0,a3
ffffffffc0204bba:	2cb000ef          	jal	ra,ffffffffc0205684 <memset>
            start += size;
ffffffffc0204bbe:	017a0733          	add	a4,s4,s7
            assert((end < la && start == end) || (end >= la && start == la));
ffffffffc0204bc2:	03597463          	bgeu	s2,s5,ffffffffc0204bea <do_execve+0x3f2>
ffffffffc0204bc6:	d6e909e3          	beq	s2,a4,ffffffffc0204938 <do_execve+0x140>
ffffffffc0204bca:	00002697          	auipc	a3,0x2
ffffffffc0204bce:	57668693          	addi	a3,a3,1398 # ffffffffc0207140 <default_pmm_manager+0xc50>
ffffffffc0204bd2:	00001617          	auipc	a2,0x1
ffffffffc0204bd6:	56e60613          	addi	a2,a2,1390 # ffffffffc0206140 <commands+0x828>
ffffffffc0204bda:	2d200593          	li	a1,722
ffffffffc0204bde:	00002517          	auipc	a0,0x2
ffffffffc0204be2:	37250513          	addi	a0,a0,882 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc0204be6:	8a9fb0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc0204bea:	ff5710e3          	bne	a4,s5,ffffffffc0204bca <do_execve+0x3d2>
ffffffffc0204bee:	8bd6                	mv	s7,s5
        while (start < end)
ffffffffc0204bf0:	d52bf4e3          	bgeu	s7,s2,ffffffffc0204938 <do_execve+0x140>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
ffffffffc0204bf4:	6c88                	ld	a0,24(s1)
ffffffffc0204bf6:	866a                	mv	a2,s10
ffffffffc0204bf8:	85d6                	mv	a1,s5
ffffffffc0204bfa:	9b7fe0ef          	jal	ra,ffffffffc02035b0 <pgdir_alloc_page>
ffffffffc0204bfe:	842a                	mv	s0,a0
ffffffffc0204c00:	dd05                	beqz	a0,ffffffffc0204b38 <do_execve+0x340>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204c02:	6785                	lui	a5,0x1
ffffffffc0204c04:	415b8533          	sub	a0,s7,s5
ffffffffc0204c08:	9abe                	add	s5,s5,a5
ffffffffc0204c0a:	417a8633          	sub	a2,s5,s7
            if (end < la)
ffffffffc0204c0e:	01597463          	bgeu	s2,s5,ffffffffc0204c16 <do_execve+0x41e>
                size -= la - end;
ffffffffc0204c12:	41790633          	sub	a2,s2,s7
    return page - pages + nbase;
ffffffffc0204c16:	000cb683          	ld	a3,0(s9)
ffffffffc0204c1a:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204c1c:	000c3583          	ld	a1,0(s8)
    return page - pages + nbase;
ffffffffc0204c20:	40d406b3          	sub	a3,s0,a3
ffffffffc0204c24:	8699                	srai	a3,a3,0x6
ffffffffc0204c26:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204c28:	67e2                	ld	a5,24(sp)
ffffffffc0204c2a:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204c2e:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204c30:	02b87663          	bgeu	a6,a1,ffffffffc0204c5c <do_execve+0x464>
ffffffffc0204c34:	000b3803          	ld	a6,0(s6)
            memset(page2kva(page) + off, 0, size);
ffffffffc0204c38:	4581                	li	a1,0
            start += size;
ffffffffc0204c3a:	9bb2                	add	s7,s7,a2
ffffffffc0204c3c:	96c2                	add	a3,a3,a6
            memset(page2kva(page) + off, 0, size);
ffffffffc0204c3e:	9536                	add	a0,a0,a3
ffffffffc0204c40:	245000ef          	jal	ra,ffffffffc0205684 <memset>
ffffffffc0204c44:	b775                	j	ffffffffc0204bf0 <do_execve+0x3f8>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204c46:	417a8a33          	sub	s4,s5,s7
ffffffffc0204c4a:	b799                	j	ffffffffc0204b90 <do_execve+0x398>
        return -E_INVAL;
ffffffffc0204c4c:	5a75                	li	s4,-3
ffffffffc0204c4e:	b3c1                	j	ffffffffc0204a0e <do_execve+0x216>
        while (start < end)
ffffffffc0204c50:	86de                	mv	a3,s7
ffffffffc0204c52:	bf39                	j	ffffffffc0204b70 <do_execve+0x378>
    int ret = -E_NO_MEM;
ffffffffc0204c54:	5a71                	li	s4,-4
ffffffffc0204c56:	bdc5                	j	ffffffffc0204b46 <do_execve+0x34e>
            ret = -E_INVAL_ELF;
ffffffffc0204c58:	5a61                	li	s4,-8
ffffffffc0204c5a:	b5c5                	j	ffffffffc0204b3a <do_execve+0x342>
ffffffffc0204c5c:	00002617          	auipc	a2,0x2
ffffffffc0204c60:	8cc60613          	addi	a2,a2,-1844 # ffffffffc0206528 <default_pmm_manager+0x38>
ffffffffc0204c64:	07100593          	li	a1,113
ffffffffc0204c68:	00002517          	auipc	a0,0x2
ffffffffc0204c6c:	8e850513          	addi	a0,a0,-1816 # ffffffffc0206550 <default_pmm_manager+0x60>
ffffffffc0204c70:	81ffb0ef          	jal	ra,ffffffffc020048e <__panic>
    current->pgdir = PADDR(mm->pgdir);
ffffffffc0204c74:	00002617          	auipc	a2,0x2
ffffffffc0204c78:	95c60613          	addi	a2,a2,-1700 # ffffffffc02065d0 <default_pmm_manager+0xe0>
ffffffffc0204c7c:	2f100593          	li	a1,753
ffffffffc0204c80:	00002517          	auipc	a0,0x2
ffffffffc0204c84:	2d050513          	addi	a0,a0,720 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc0204c88:	807fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 4 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204c8c:	00002697          	auipc	a3,0x2
ffffffffc0204c90:	5cc68693          	addi	a3,a3,1484 # ffffffffc0207258 <default_pmm_manager+0xd68>
ffffffffc0204c94:	00001617          	auipc	a2,0x1
ffffffffc0204c98:	4ac60613          	addi	a2,a2,1196 # ffffffffc0206140 <commands+0x828>
ffffffffc0204c9c:	2ec00593          	li	a1,748
ffffffffc0204ca0:	00002517          	auipc	a0,0x2
ffffffffc0204ca4:	2b050513          	addi	a0,a0,688 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc0204ca8:	fe6fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 3 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204cac:	00002697          	auipc	a3,0x2
ffffffffc0204cb0:	56468693          	addi	a3,a3,1380 # ffffffffc0207210 <default_pmm_manager+0xd20>
ffffffffc0204cb4:	00001617          	auipc	a2,0x1
ffffffffc0204cb8:	48c60613          	addi	a2,a2,1164 # ffffffffc0206140 <commands+0x828>
ffffffffc0204cbc:	2eb00593          	li	a1,747
ffffffffc0204cc0:	00002517          	auipc	a0,0x2
ffffffffc0204cc4:	29050513          	addi	a0,a0,656 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc0204cc8:	fc6fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 2 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204ccc:	00002697          	auipc	a3,0x2
ffffffffc0204cd0:	4fc68693          	addi	a3,a3,1276 # ffffffffc02071c8 <default_pmm_manager+0xcd8>
ffffffffc0204cd4:	00001617          	auipc	a2,0x1
ffffffffc0204cd8:	46c60613          	addi	a2,a2,1132 # ffffffffc0206140 <commands+0x828>
ffffffffc0204cdc:	2ea00593          	li	a1,746
ffffffffc0204ce0:	00002517          	auipc	a0,0x2
ffffffffc0204ce4:	27050513          	addi	a0,a0,624 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc0204ce8:	fa6fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - PGSIZE, PTE_USER) != NULL);
ffffffffc0204cec:	00002697          	auipc	a3,0x2
ffffffffc0204cf0:	49468693          	addi	a3,a3,1172 # ffffffffc0207180 <default_pmm_manager+0xc90>
ffffffffc0204cf4:	00001617          	auipc	a2,0x1
ffffffffc0204cf8:	44c60613          	addi	a2,a2,1100 # ffffffffc0206140 <commands+0x828>
ffffffffc0204cfc:	2e900593          	li	a1,745
ffffffffc0204d00:	00002517          	auipc	a0,0x2
ffffffffc0204d04:	25050513          	addi	a0,a0,592 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc0204d08:	f86fb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0204d0c <do_yield>:
    current->need_resched = 1;
ffffffffc0204d0c:	000a6797          	auipc	a5,0xa6
ffffffffc0204d10:	9647b783          	ld	a5,-1692(a5) # ffffffffc02aa670 <current>
ffffffffc0204d14:	4705                	li	a4,1
ffffffffc0204d16:	ef98                	sd	a4,24(a5)
}
ffffffffc0204d18:	4501                	li	a0,0
ffffffffc0204d1a:	8082                	ret

ffffffffc0204d1c <do_wait>:
{
ffffffffc0204d1c:	1101                	addi	sp,sp,-32
ffffffffc0204d1e:	e822                	sd	s0,16(sp)
ffffffffc0204d20:	e426                	sd	s1,8(sp)
ffffffffc0204d22:	ec06                	sd	ra,24(sp)
ffffffffc0204d24:	842e                	mv	s0,a1
ffffffffc0204d26:	84aa                	mv	s1,a0
    if (code_store != NULL)
ffffffffc0204d28:	c999                	beqz	a1,ffffffffc0204d3e <do_wait+0x22>
    struct mm_struct *mm = current->mm;
ffffffffc0204d2a:	000a6797          	auipc	a5,0xa6
ffffffffc0204d2e:	9467b783          	ld	a5,-1722(a5) # ffffffffc02aa670 <current>
        if (!user_mem_check(mm, (uintptr_t)code_store, sizeof(int), 1))
ffffffffc0204d32:	7788                	ld	a0,40(a5)
ffffffffc0204d34:	4685                	li	a3,1
ffffffffc0204d36:	4611                	li	a2,4
ffffffffc0204d38:	fd5fe0ef          	jal	ra,ffffffffc0203d0c <user_mem_check>
ffffffffc0204d3c:	c909                	beqz	a0,ffffffffc0204d4e <do_wait+0x32>
ffffffffc0204d3e:	85a2                	mv	a1,s0
}
ffffffffc0204d40:	6442                	ld	s0,16(sp)
ffffffffc0204d42:	60e2                	ld	ra,24(sp)
ffffffffc0204d44:	8526                	mv	a0,s1
ffffffffc0204d46:	64a2                	ld	s1,8(sp)
ffffffffc0204d48:	6105                	addi	sp,sp,32
ffffffffc0204d4a:	fb8ff06f          	j	ffffffffc0204502 <do_wait.part.0>
ffffffffc0204d4e:	60e2                	ld	ra,24(sp)
ffffffffc0204d50:	6442                	ld	s0,16(sp)
ffffffffc0204d52:	64a2                	ld	s1,8(sp)
ffffffffc0204d54:	5575                	li	a0,-3
ffffffffc0204d56:	6105                	addi	sp,sp,32
ffffffffc0204d58:	8082                	ret

ffffffffc0204d5a <do_kill>:
{
ffffffffc0204d5a:	1141                	addi	sp,sp,-16
    if (0 < pid && pid < MAX_PID)
ffffffffc0204d5c:	6789                	lui	a5,0x2
{
ffffffffc0204d5e:	e406                	sd	ra,8(sp)
ffffffffc0204d60:	e022                	sd	s0,0(sp)
    if (0 < pid && pid < MAX_PID)
ffffffffc0204d62:	fff5071b          	addiw	a4,a0,-1
ffffffffc0204d66:	17f9                	addi	a5,a5,-2
ffffffffc0204d68:	02e7e963          	bltu	a5,a4,ffffffffc0204d9a <do_kill+0x40>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204d6c:	842a                	mv	s0,a0
ffffffffc0204d6e:	45a9                	li	a1,10
ffffffffc0204d70:	2501                	sext.w	a0,a0
ffffffffc0204d72:	46c000ef          	jal	ra,ffffffffc02051de <hash32>
ffffffffc0204d76:	02051793          	slli	a5,a0,0x20
ffffffffc0204d7a:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0204d7e:	000a2797          	auipc	a5,0xa2
ffffffffc0204d82:	88278793          	addi	a5,a5,-1918 # ffffffffc02a6600 <hash_list>
ffffffffc0204d86:	953e                	add	a0,a0,a5
ffffffffc0204d88:	87aa                	mv	a5,a0
        while ((le = list_next(le)) != list)
ffffffffc0204d8a:	a029                	j	ffffffffc0204d94 <do_kill+0x3a>
            if (proc->pid == pid)
ffffffffc0204d8c:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0204d90:	00870b63          	beq	a4,s0,ffffffffc0204da6 <do_kill+0x4c>
ffffffffc0204d94:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204d96:	fef51be3          	bne	a0,a5,ffffffffc0204d8c <do_kill+0x32>
    return -E_INVAL;
ffffffffc0204d9a:	5475                	li	s0,-3
}
ffffffffc0204d9c:	60a2                	ld	ra,8(sp)
ffffffffc0204d9e:	8522                	mv	a0,s0
ffffffffc0204da0:	6402                	ld	s0,0(sp)
ffffffffc0204da2:	0141                	addi	sp,sp,16
ffffffffc0204da4:	8082                	ret
        if (!(proc->flags & PF_EXITING))
ffffffffc0204da6:	fd87a703          	lw	a4,-40(a5)
ffffffffc0204daa:	00177693          	andi	a3,a4,1
ffffffffc0204dae:	e295                	bnez	a3,ffffffffc0204dd2 <do_kill+0x78>
            if (proc->wait_state & WT_INTERRUPTED)
ffffffffc0204db0:	4bd4                	lw	a3,20(a5)
            proc->flags |= PF_EXITING;
ffffffffc0204db2:	00176713          	ori	a4,a4,1
ffffffffc0204db6:	fce7ac23          	sw	a4,-40(a5)
            return 0;
ffffffffc0204dba:	4401                	li	s0,0
            if (proc->wait_state & WT_INTERRUPTED)
ffffffffc0204dbc:	fe06d0e3          	bgez	a3,ffffffffc0204d9c <do_kill+0x42>
                wakeup_proc(proc);
ffffffffc0204dc0:	f2878513          	addi	a0,a5,-216
ffffffffc0204dc4:	22e000ef          	jal	ra,ffffffffc0204ff2 <wakeup_proc>
}
ffffffffc0204dc8:	60a2                	ld	ra,8(sp)
ffffffffc0204dca:	8522                	mv	a0,s0
ffffffffc0204dcc:	6402                	ld	s0,0(sp)
ffffffffc0204dce:	0141                	addi	sp,sp,16
ffffffffc0204dd0:	8082                	ret
        return -E_KILLED;
ffffffffc0204dd2:	545d                	li	s0,-9
ffffffffc0204dd4:	b7e1                	j	ffffffffc0204d9c <do_kill+0x42>

ffffffffc0204dd6 <proc_init>:

// proc_init - set up the first kernel thread idleproc "idle" by itself and
//           - create the second kernel thread init_main
void proc_init(void)
{
ffffffffc0204dd6:	1101                	addi	sp,sp,-32
ffffffffc0204dd8:	e426                	sd	s1,8(sp)
    elm->prev = elm->next = elm;
ffffffffc0204dda:	000a6797          	auipc	a5,0xa6
ffffffffc0204dde:	82678793          	addi	a5,a5,-2010 # ffffffffc02aa600 <proc_list>
ffffffffc0204de2:	ec06                	sd	ra,24(sp)
ffffffffc0204de4:	e822                	sd	s0,16(sp)
ffffffffc0204de6:	e04a                	sd	s2,0(sp)
ffffffffc0204de8:	000a2497          	auipc	s1,0xa2
ffffffffc0204dec:	81848493          	addi	s1,s1,-2024 # ffffffffc02a6600 <hash_list>
ffffffffc0204df0:	e79c                	sd	a5,8(a5)
ffffffffc0204df2:	e39c                	sd	a5,0(a5)
    int i;

    list_init(&proc_list);
    for (i = 0; i < HASH_LIST_SIZE; i++)
ffffffffc0204df4:	000a6717          	auipc	a4,0xa6
ffffffffc0204df8:	80c70713          	addi	a4,a4,-2036 # ffffffffc02aa600 <proc_list>
ffffffffc0204dfc:	87a6                	mv	a5,s1
ffffffffc0204dfe:	e79c                	sd	a5,8(a5)
ffffffffc0204e00:	e39c                	sd	a5,0(a5)
ffffffffc0204e02:	07c1                	addi	a5,a5,16
ffffffffc0204e04:	fef71de3          	bne	a4,a5,ffffffffc0204dfe <proc_init+0x28>
    {
        list_init(hash_list + i);
    }

    if ((idleproc = alloc_proc()) == NULL)
ffffffffc0204e08:	fa1fe0ef          	jal	ra,ffffffffc0203da8 <alloc_proc>
ffffffffc0204e0c:	000a6917          	auipc	s2,0xa6
ffffffffc0204e10:	86c90913          	addi	s2,s2,-1940 # ffffffffc02aa678 <idleproc>
ffffffffc0204e14:	00a93023          	sd	a0,0(s2)
ffffffffc0204e18:	0e050f63          	beqz	a0,ffffffffc0204f16 <proc_init+0x140>
    {
        panic("cannot alloc idleproc.\n");
    }

    idleproc->pid = 0;
    idleproc->state = PROC_RUNNABLE;
ffffffffc0204e1c:	4789                	li	a5,2
ffffffffc0204e1e:	e11c                	sd	a5,0(a0)
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204e20:	00003797          	auipc	a5,0x3
ffffffffc0204e24:	1e078793          	addi	a5,a5,480 # ffffffffc0208000 <bootstack>
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204e28:	0b450413          	addi	s0,a0,180
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204e2c:	e91c                	sd	a5,16(a0)
    idleproc->need_resched = 1;
ffffffffc0204e2e:	4785                	li	a5,1
ffffffffc0204e30:	ed1c                	sd	a5,24(a0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204e32:	4641                	li	a2,16
ffffffffc0204e34:	4581                	li	a1,0
ffffffffc0204e36:	8522                	mv	a0,s0
ffffffffc0204e38:	04d000ef          	jal	ra,ffffffffc0205684 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204e3c:	463d                	li	a2,15
ffffffffc0204e3e:	00002597          	auipc	a1,0x2
ffffffffc0204e42:	47a58593          	addi	a1,a1,1146 # ffffffffc02072b8 <default_pmm_manager+0xdc8>
ffffffffc0204e46:	8522                	mv	a0,s0
ffffffffc0204e48:	04f000ef          	jal	ra,ffffffffc0205696 <memcpy>
    set_proc_name(idleproc, "idle");
    nr_process++;
ffffffffc0204e4c:	000a6717          	auipc	a4,0xa6
ffffffffc0204e50:	83c70713          	addi	a4,a4,-1988 # ffffffffc02aa688 <nr_process>
ffffffffc0204e54:	431c                	lw	a5,0(a4)

    current = idleproc;
ffffffffc0204e56:	00093683          	ld	a3,0(s2)

    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204e5a:	4601                	li	a2,0
    nr_process++;
ffffffffc0204e5c:	2785                	addiw	a5,a5,1
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204e5e:	4581                	li	a1,0
ffffffffc0204e60:	00000517          	auipc	a0,0x0
ffffffffc0204e64:	87450513          	addi	a0,a0,-1932 # ffffffffc02046d4 <init_main>
    nr_process++;
ffffffffc0204e68:	c31c                	sw	a5,0(a4)
    current = idleproc;
ffffffffc0204e6a:	000a6797          	auipc	a5,0xa6
ffffffffc0204e6e:	80d7b323          	sd	a3,-2042(a5) # ffffffffc02aa670 <current>
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204e72:	cf6ff0ef          	jal	ra,ffffffffc0204368 <kernel_thread>
ffffffffc0204e76:	842a                	mv	s0,a0
    if (pid <= 0)
ffffffffc0204e78:	08a05363          	blez	a0,ffffffffc0204efe <proc_init+0x128>
    if (0 < pid && pid < MAX_PID)
ffffffffc0204e7c:	6789                	lui	a5,0x2
ffffffffc0204e7e:	fff5071b          	addiw	a4,a0,-1
ffffffffc0204e82:	17f9                	addi	a5,a5,-2
ffffffffc0204e84:	2501                	sext.w	a0,a0
ffffffffc0204e86:	02e7e363          	bltu	a5,a4,ffffffffc0204eac <proc_init+0xd6>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204e8a:	45a9                	li	a1,10
ffffffffc0204e8c:	352000ef          	jal	ra,ffffffffc02051de <hash32>
ffffffffc0204e90:	02051793          	slli	a5,a0,0x20
ffffffffc0204e94:	01c7d693          	srli	a3,a5,0x1c
ffffffffc0204e98:	96a6                	add	a3,a3,s1
ffffffffc0204e9a:	87b6                	mv	a5,a3
        while ((le = list_next(le)) != list)
ffffffffc0204e9c:	a029                	j	ffffffffc0204ea6 <proc_init+0xd0>
            if (proc->pid == pid)
ffffffffc0204e9e:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_obj___user_faultread_out_size-0x7c74>
ffffffffc0204ea2:	04870b63          	beq	a4,s0,ffffffffc0204ef8 <proc_init+0x122>
    return listelm->next;
ffffffffc0204ea6:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204ea8:	fef69be3          	bne	a3,a5,ffffffffc0204e9e <proc_init+0xc8>
    return NULL;
ffffffffc0204eac:	4781                	li	a5,0
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204eae:	0b478493          	addi	s1,a5,180
ffffffffc0204eb2:	4641                	li	a2,16
ffffffffc0204eb4:	4581                	li	a1,0
    {
        panic("create init_main failed.\n");
    }

    initproc = find_proc(pid);
ffffffffc0204eb6:	000a5417          	auipc	s0,0xa5
ffffffffc0204eba:	7ca40413          	addi	s0,s0,1994 # ffffffffc02aa680 <initproc>
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204ebe:	8526                	mv	a0,s1
    initproc = find_proc(pid);
ffffffffc0204ec0:	e01c                	sd	a5,0(s0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204ec2:	7c2000ef          	jal	ra,ffffffffc0205684 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204ec6:	463d                	li	a2,15
ffffffffc0204ec8:	00002597          	auipc	a1,0x2
ffffffffc0204ecc:	41858593          	addi	a1,a1,1048 # ffffffffc02072e0 <default_pmm_manager+0xdf0>
ffffffffc0204ed0:	8526                	mv	a0,s1
ffffffffc0204ed2:	7c4000ef          	jal	ra,ffffffffc0205696 <memcpy>
    set_proc_name(initproc, "init");

    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc0204ed6:	00093783          	ld	a5,0(s2)
ffffffffc0204eda:	cbb5                	beqz	a5,ffffffffc0204f4e <proc_init+0x178>
ffffffffc0204edc:	43dc                	lw	a5,4(a5)
ffffffffc0204ede:	eba5                	bnez	a5,ffffffffc0204f4e <proc_init+0x178>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204ee0:	601c                	ld	a5,0(s0)
ffffffffc0204ee2:	c7b1                	beqz	a5,ffffffffc0204f2e <proc_init+0x158>
ffffffffc0204ee4:	43d8                	lw	a4,4(a5)
ffffffffc0204ee6:	4785                	li	a5,1
ffffffffc0204ee8:	04f71363          	bne	a4,a5,ffffffffc0204f2e <proc_init+0x158>
}
ffffffffc0204eec:	60e2                	ld	ra,24(sp)
ffffffffc0204eee:	6442                	ld	s0,16(sp)
ffffffffc0204ef0:	64a2                	ld	s1,8(sp)
ffffffffc0204ef2:	6902                	ld	s2,0(sp)
ffffffffc0204ef4:	6105                	addi	sp,sp,32
ffffffffc0204ef6:	8082                	ret
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc0204ef8:	f2878793          	addi	a5,a5,-216
ffffffffc0204efc:	bf4d                	j	ffffffffc0204eae <proc_init+0xd8>
        panic("create init_main failed.\n");
ffffffffc0204efe:	00002617          	auipc	a2,0x2
ffffffffc0204f02:	3c260613          	addi	a2,a2,962 # ffffffffc02072c0 <default_pmm_manager+0xdd0>
ffffffffc0204f06:	41200593          	li	a1,1042
ffffffffc0204f0a:	00002517          	auipc	a0,0x2
ffffffffc0204f0e:	04650513          	addi	a0,a0,70 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc0204f12:	d7cfb0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("cannot alloc idleproc.\n");
ffffffffc0204f16:	00002617          	auipc	a2,0x2
ffffffffc0204f1a:	38a60613          	addi	a2,a2,906 # ffffffffc02072a0 <default_pmm_manager+0xdb0>
ffffffffc0204f1e:	40300593          	li	a1,1027
ffffffffc0204f22:	00002517          	auipc	a0,0x2
ffffffffc0204f26:	02e50513          	addi	a0,a0,46 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc0204f2a:	d64fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204f2e:	00002697          	auipc	a3,0x2
ffffffffc0204f32:	3e268693          	addi	a3,a3,994 # ffffffffc0207310 <default_pmm_manager+0xe20>
ffffffffc0204f36:	00001617          	auipc	a2,0x1
ffffffffc0204f3a:	20a60613          	addi	a2,a2,522 # ffffffffc0206140 <commands+0x828>
ffffffffc0204f3e:	41900593          	li	a1,1049
ffffffffc0204f42:	00002517          	auipc	a0,0x2
ffffffffc0204f46:	00e50513          	addi	a0,a0,14 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc0204f4a:	d44fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc0204f4e:	00002697          	auipc	a3,0x2
ffffffffc0204f52:	39a68693          	addi	a3,a3,922 # ffffffffc02072e8 <default_pmm_manager+0xdf8>
ffffffffc0204f56:	00001617          	auipc	a2,0x1
ffffffffc0204f5a:	1ea60613          	addi	a2,a2,490 # ffffffffc0206140 <commands+0x828>
ffffffffc0204f5e:	41800593          	li	a1,1048
ffffffffc0204f62:	00002517          	auipc	a0,0x2
ffffffffc0204f66:	fee50513          	addi	a0,a0,-18 # ffffffffc0206f50 <default_pmm_manager+0xa60>
ffffffffc0204f6a:	d24fb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0204f6e <cpu_idle>:

// cpu_idle - at the end of kern_init, the first kernel thread idleproc will do below works
void cpu_idle(void)
{
ffffffffc0204f6e:	1141                	addi	sp,sp,-16
ffffffffc0204f70:	e022                	sd	s0,0(sp)
ffffffffc0204f72:	e406                	sd	ra,8(sp)
ffffffffc0204f74:	000a5417          	auipc	s0,0xa5
ffffffffc0204f78:	6fc40413          	addi	s0,s0,1788 # ffffffffc02aa670 <current>
    while (1)
    {
        if (current->need_resched)
ffffffffc0204f7c:	6018                	ld	a4,0(s0)
ffffffffc0204f7e:	6f1c                	ld	a5,24(a4)
ffffffffc0204f80:	dffd                	beqz	a5,ffffffffc0204f7e <cpu_idle+0x10>
        {
            schedule();
ffffffffc0204f82:	0f0000ef          	jal	ra,ffffffffc0205072 <schedule>
ffffffffc0204f86:	bfdd                	j	ffffffffc0204f7c <cpu_idle+0xe>

ffffffffc0204f88 <switch_to>:
.text
# void switch_to(struct proc_struct* from, struct proc_struct* to)
.globl switch_to
switch_to:
    # save from's registers
    STORE ra, 0*REGBYTES(a0)
ffffffffc0204f88:	00153023          	sd	ra,0(a0)
    STORE sp, 1*REGBYTES(a0)
ffffffffc0204f8c:	00253423          	sd	sp,8(a0)
    STORE s0, 2*REGBYTES(a0)
ffffffffc0204f90:	e900                	sd	s0,16(a0)
    STORE s1, 3*REGBYTES(a0)
ffffffffc0204f92:	ed04                	sd	s1,24(a0)
    STORE s2, 4*REGBYTES(a0)
ffffffffc0204f94:	03253023          	sd	s2,32(a0)
    STORE s3, 5*REGBYTES(a0)
ffffffffc0204f98:	03353423          	sd	s3,40(a0)
    STORE s4, 6*REGBYTES(a0)
ffffffffc0204f9c:	03453823          	sd	s4,48(a0)
    STORE s5, 7*REGBYTES(a0)
ffffffffc0204fa0:	03553c23          	sd	s5,56(a0)
    STORE s6, 8*REGBYTES(a0)
ffffffffc0204fa4:	05653023          	sd	s6,64(a0)
    STORE s7, 9*REGBYTES(a0)
ffffffffc0204fa8:	05753423          	sd	s7,72(a0)
    STORE s8, 10*REGBYTES(a0)
ffffffffc0204fac:	05853823          	sd	s8,80(a0)
    STORE s9, 11*REGBYTES(a0)
ffffffffc0204fb0:	05953c23          	sd	s9,88(a0)
    STORE s10, 12*REGBYTES(a0)
ffffffffc0204fb4:	07a53023          	sd	s10,96(a0)
    STORE s11, 13*REGBYTES(a0)
ffffffffc0204fb8:	07b53423          	sd	s11,104(a0)

    # restore to's registers
    LOAD ra, 0*REGBYTES(a1)
ffffffffc0204fbc:	0005b083          	ld	ra,0(a1)
    LOAD sp, 1*REGBYTES(a1)
ffffffffc0204fc0:	0085b103          	ld	sp,8(a1)
    LOAD s0, 2*REGBYTES(a1)
ffffffffc0204fc4:	6980                	ld	s0,16(a1)
    LOAD s1, 3*REGBYTES(a1)
ffffffffc0204fc6:	6d84                	ld	s1,24(a1)
    LOAD s2, 4*REGBYTES(a1)
ffffffffc0204fc8:	0205b903          	ld	s2,32(a1)
    LOAD s3, 5*REGBYTES(a1)
ffffffffc0204fcc:	0285b983          	ld	s3,40(a1)
    LOAD s4, 6*REGBYTES(a1)
ffffffffc0204fd0:	0305ba03          	ld	s4,48(a1)
    LOAD s5, 7*REGBYTES(a1)
ffffffffc0204fd4:	0385ba83          	ld	s5,56(a1)
    LOAD s6, 8*REGBYTES(a1)
ffffffffc0204fd8:	0405bb03          	ld	s6,64(a1)
    LOAD s7, 9*REGBYTES(a1)
ffffffffc0204fdc:	0485bb83          	ld	s7,72(a1)
    LOAD s8, 10*REGBYTES(a1)
ffffffffc0204fe0:	0505bc03          	ld	s8,80(a1)
    LOAD s9, 11*REGBYTES(a1)
ffffffffc0204fe4:	0585bc83          	ld	s9,88(a1)
    LOAD s10, 12*REGBYTES(a1)
ffffffffc0204fe8:	0605bd03          	ld	s10,96(a1)
    LOAD s11, 13*REGBYTES(a1)
ffffffffc0204fec:	0685bd83          	ld	s11,104(a1)

    ret
ffffffffc0204ff0:	8082                	ret

ffffffffc0204ff2 <wakeup_proc>:
#include <sched.h>
#include <assert.h>

void wakeup_proc(struct proc_struct *proc)
{
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0204ff2:	4118                	lw	a4,0(a0)
{
ffffffffc0204ff4:	1101                	addi	sp,sp,-32
ffffffffc0204ff6:	ec06                	sd	ra,24(sp)
ffffffffc0204ff8:	e822                	sd	s0,16(sp)
ffffffffc0204ffa:	e426                	sd	s1,8(sp)
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0204ffc:	478d                	li	a5,3
ffffffffc0204ffe:	04f70b63          	beq	a4,a5,ffffffffc0205054 <wakeup_proc+0x62>
ffffffffc0205002:	842a                	mv	s0,a0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0205004:	100027f3          	csrr	a5,sstatus
ffffffffc0205008:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020500a:	4481                	li	s1,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020500c:	ef9d                	bnez	a5,ffffffffc020504a <wakeup_proc+0x58>
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        if (proc->state != PROC_RUNNABLE)
ffffffffc020500e:	4789                	li	a5,2
ffffffffc0205010:	02f70163          	beq	a4,a5,ffffffffc0205032 <wakeup_proc+0x40>
        {
            proc->state = PROC_RUNNABLE;
ffffffffc0205014:	c01c                	sw	a5,0(s0)
            proc->wait_state = 0;
ffffffffc0205016:	0e042623          	sw	zero,236(s0)
    if (flag)
ffffffffc020501a:	e491                	bnez	s1,ffffffffc0205026 <wakeup_proc+0x34>
        {
            warn("wakeup runnable process.\n");
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc020501c:	60e2                	ld	ra,24(sp)
ffffffffc020501e:	6442                	ld	s0,16(sp)
ffffffffc0205020:	64a2                	ld	s1,8(sp)
ffffffffc0205022:	6105                	addi	sp,sp,32
ffffffffc0205024:	8082                	ret
ffffffffc0205026:	6442                	ld	s0,16(sp)
ffffffffc0205028:	60e2                	ld	ra,24(sp)
ffffffffc020502a:	64a2                	ld	s1,8(sp)
ffffffffc020502c:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc020502e:	981fb06f          	j	ffffffffc02009ae <intr_enable>
            warn("wakeup runnable process.\n");
ffffffffc0205032:	00002617          	auipc	a2,0x2
ffffffffc0205036:	33e60613          	addi	a2,a2,830 # ffffffffc0207370 <default_pmm_manager+0xe80>
ffffffffc020503a:	45d1                	li	a1,20
ffffffffc020503c:	00002517          	auipc	a0,0x2
ffffffffc0205040:	31c50513          	addi	a0,a0,796 # ffffffffc0207358 <default_pmm_manager+0xe68>
ffffffffc0205044:	cb2fb0ef          	jal	ra,ffffffffc02004f6 <__warn>
ffffffffc0205048:	bfc9                	j	ffffffffc020501a <wakeup_proc+0x28>
        intr_disable();
ffffffffc020504a:	96bfb0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        if (proc->state != PROC_RUNNABLE)
ffffffffc020504e:	4018                	lw	a4,0(s0)
        return 1;
ffffffffc0205050:	4485                	li	s1,1
ffffffffc0205052:	bf75                	j	ffffffffc020500e <wakeup_proc+0x1c>
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0205054:	00002697          	auipc	a3,0x2
ffffffffc0205058:	2e468693          	addi	a3,a3,740 # ffffffffc0207338 <default_pmm_manager+0xe48>
ffffffffc020505c:	00001617          	auipc	a2,0x1
ffffffffc0205060:	0e460613          	addi	a2,a2,228 # ffffffffc0206140 <commands+0x828>
ffffffffc0205064:	45a5                	li	a1,9
ffffffffc0205066:	00002517          	auipc	a0,0x2
ffffffffc020506a:	2f250513          	addi	a0,a0,754 # ffffffffc0207358 <default_pmm_manager+0xe68>
ffffffffc020506e:	c20fb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0205072 <schedule>:

void schedule(void)
{
ffffffffc0205072:	1141                	addi	sp,sp,-16
ffffffffc0205074:	e406                	sd	ra,8(sp)
ffffffffc0205076:	e022                	sd	s0,0(sp)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0205078:	100027f3          	csrr	a5,sstatus
ffffffffc020507c:	8b89                	andi	a5,a5,2
ffffffffc020507e:	4401                	li	s0,0
ffffffffc0205080:	efbd                	bnez	a5,ffffffffc02050fe <schedule+0x8c>
    bool intr_flag;
    list_entry_t *le, *last;
    struct proc_struct *next = NULL;
    local_intr_save(intr_flag);
    {
        current->need_resched = 0;
ffffffffc0205082:	000a5897          	auipc	a7,0xa5
ffffffffc0205086:	5ee8b883          	ld	a7,1518(a7) # ffffffffc02aa670 <current>
ffffffffc020508a:	0008bc23          	sd	zero,24(a7)
        last = (current == idleproc) ? &proc_list : &(current->list_link);
ffffffffc020508e:	000a5517          	auipc	a0,0xa5
ffffffffc0205092:	5ea53503          	ld	a0,1514(a0) # ffffffffc02aa678 <idleproc>
ffffffffc0205096:	04a88e63          	beq	a7,a0,ffffffffc02050f2 <schedule+0x80>
ffffffffc020509a:	0c888693          	addi	a3,a7,200
ffffffffc020509e:	000a5617          	auipc	a2,0xa5
ffffffffc02050a2:	56260613          	addi	a2,a2,1378 # ffffffffc02aa600 <proc_list>
        le = last;
ffffffffc02050a6:	87b6                	mv	a5,a3
    struct proc_struct *next = NULL;
ffffffffc02050a8:	4581                	li	a1,0
        do
        {
            if ((le = list_next(le)) != &proc_list)
            {
                next = le2proc(le, list_link);
                if (next->state == PROC_RUNNABLE)
ffffffffc02050aa:	4809                	li	a6,2
ffffffffc02050ac:	679c                	ld	a5,8(a5)
            if ((le = list_next(le)) != &proc_list)
ffffffffc02050ae:	00c78863          	beq	a5,a2,ffffffffc02050be <schedule+0x4c>
                if (next->state == PROC_RUNNABLE)
ffffffffc02050b2:	f387a703          	lw	a4,-200(a5)
                next = le2proc(le, list_link);
ffffffffc02050b6:	f3878593          	addi	a1,a5,-200
                if (next->state == PROC_RUNNABLE)
ffffffffc02050ba:	03070163          	beq	a4,a6,ffffffffc02050dc <schedule+0x6a>
                {
                    break;
                }
            }
        } while (le != last);
ffffffffc02050be:	fef697e3          	bne	a3,a5,ffffffffc02050ac <schedule+0x3a>
        if (next == NULL || next->state != PROC_RUNNABLE)
ffffffffc02050c2:	ed89                	bnez	a1,ffffffffc02050dc <schedule+0x6a>
        {
            next = idleproc;
        }
        next->runs++;
ffffffffc02050c4:	451c                	lw	a5,8(a0)
ffffffffc02050c6:	2785                	addiw	a5,a5,1
ffffffffc02050c8:	c51c                	sw	a5,8(a0)
        if (next != current)
ffffffffc02050ca:	00a88463          	beq	a7,a0,ffffffffc02050d2 <schedule+0x60>
        {
            proc_run(next);
ffffffffc02050ce:	e53fe0ef          	jal	ra,ffffffffc0203f20 <proc_run>
    if (flag)
ffffffffc02050d2:	e819                	bnez	s0,ffffffffc02050e8 <schedule+0x76>
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc02050d4:	60a2                	ld	ra,8(sp)
ffffffffc02050d6:	6402                	ld	s0,0(sp)
ffffffffc02050d8:	0141                	addi	sp,sp,16
ffffffffc02050da:	8082                	ret
        if (next == NULL || next->state != PROC_RUNNABLE)
ffffffffc02050dc:	4198                	lw	a4,0(a1)
ffffffffc02050de:	4789                	li	a5,2
ffffffffc02050e0:	fef712e3          	bne	a4,a5,ffffffffc02050c4 <schedule+0x52>
ffffffffc02050e4:	852e                	mv	a0,a1
ffffffffc02050e6:	bff9                	j	ffffffffc02050c4 <schedule+0x52>
}
ffffffffc02050e8:	6402                	ld	s0,0(sp)
ffffffffc02050ea:	60a2                	ld	ra,8(sp)
ffffffffc02050ec:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc02050ee:	8c1fb06f          	j	ffffffffc02009ae <intr_enable>
        last = (current == idleproc) ? &proc_list : &(current->list_link);
ffffffffc02050f2:	000a5617          	auipc	a2,0xa5
ffffffffc02050f6:	50e60613          	addi	a2,a2,1294 # ffffffffc02aa600 <proc_list>
ffffffffc02050fa:	86b2                	mv	a3,a2
ffffffffc02050fc:	b76d                	j	ffffffffc02050a6 <schedule+0x34>
        intr_disable();
ffffffffc02050fe:	8b7fb0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc0205102:	4405                	li	s0,1
ffffffffc0205104:	bfbd                	j	ffffffffc0205082 <schedule+0x10>

ffffffffc0205106 <sys_getpid>:
    return do_kill(pid);
}

static int
sys_getpid(uint64_t arg[]) {
    return current->pid;
ffffffffc0205106:	000a5797          	auipc	a5,0xa5
ffffffffc020510a:	56a7b783          	ld	a5,1386(a5) # ffffffffc02aa670 <current>
}
ffffffffc020510e:	43c8                	lw	a0,4(a5)
ffffffffc0205110:	8082                	ret

ffffffffc0205112 <sys_pgdir>:

static int
sys_pgdir(uint64_t arg[]) {
    //print_pgdir();
    return 0;
}
ffffffffc0205112:	4501                	li	a0,0
ffffffffc0205114:	8082                	ret

ffffffffc0205116 <sys_putc>:
    cputchar(c);
ffffffffc0205116:	4108                	lw	a0,0(a0)
sys_putc(uint64_t arg[]) {
ffffffffc0205118:	1141                	addi	sp,sp,-16
ffffffffc020511a:	e406                	sd	ra,8(sp)
    cputchar(c);
ffffffffc020511c:	8aefb0ef          	jal	ra,ffffffffc02001ca <cputchar>
}
ffffffffc0205120:	60a2                	ld	ra,8(sp)
ffffffffc0205122:	4501                	li	a0,0
ffffffffc0205124:	0141                	addi	sp,sp,16
ffffffffc0205126:	8082                	ret

ffffffffc0205128 <sys_kill>:
    return do_kill(pid);
ffffffffc0205128:	4108                	lw	a0,0(a0)
ffffffffc020512a:	c31ff06f          	j	ffffffffc0204d5a <do_kill>

ffffffffc020512e <sys_yield>:
    return do_yield();
ffffffffc020512e:	bdfff06f          	j	ffffffffc0204d0c <do_yield>

ffffffffc0205132 <sys_exec>:
    return do_execve(name, len, binary, size);
ffffffffc0205132:	6d14                	ld	a3,24(a0)
ffffffffc0205134:	6910                	ld	a2,16(a0)
ffffffffc0205136:	650c                	ld	a1,8(a0)
ffffffffc0205138:	6108                	ld	a0,0(a0)
ffffffffc020513a:	ebeff06f          	j	ffffffffc02047f8 <do_execve>

ffffffffc020513e <sys_wait>:
    return do_wait(pid, store);
ffffffffc020513e:	650c                	ld	a1,8(a0)
ffffffffc0205140:	4108                	lw	a0,0(a0)
ffffffffc0205142:	bdbff06f          	j	ffffffffc0204d1c <do_wait>

ffffffffc0205146 <sys_fork>:
    struct trapframe *tf = current->tf;
ffffffffc0205146:	000a5797          	auipc	a5,0xa5
ffffffffc020514a:	52a7b783          	ld	a5,1322(a5) # ffffffffc02aa670 <current>
ffffffffc020514e:	73d0                	ld	a2,160(a5)
    return do_fork(0, stack, tf);
ffffffffc0205150:	4501                	li	a0,0
ffffffffc0205152:	6a0c                	ld	a1,16(a2)
ffffffffc0205154:	e37fe06f          	j	ffffffffc0203f8a <do_fork>

ffffffffc0205158 <sys_exit>:
    return do_exit(error_code);
ffffffffc0205158:	4108                	lw	a0,0(a0)
ffffffffc020515a:	a5eff06f          	j	ffffffffc02043b8 <do_exit>

ffffffffc020515e <syscall>:
};

#define NUM_SYSCALLS        ((sizeof(syscalls)) / (sizeof(syscalls[0])))

void
syscall(void) {
ffffffffc020515e:	715d                	addi	sp,sp,-80
ffffffffc0205160:	fc26                	sd	s1,56(sp)
    struct trapframe *tf = current->tf;
ffffffffc0205162:	000a5497          	auipc	s1,0xa5
ffffffffc0205166:	50e48493          	addi	s1,s1,1294 # ffffffffc02aa670 <current>
ffffffffc020516a:	6098                	ld	a4,0(s1)
syscall(void) {
ffffffffc020516c:	e0a2                	sd	s0,64(sp)
ffffffffc020516e:	f84a                	sd	s2,48(sp)
    struct trapframe *tf = current->tf;
ffffffffc0205170:	7340                	ld	s0,160(a4)
syscall(void) {
ffffffffc0205172:	e486                	sd	ra,72(sp)
    uint64_t arg[5];
    int num = tf->gpr.a0;
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc0205174:	47fd                	li	a5,31
    int num = tf->gpr.a0;
ffffffffc0205176:	05042903          	lw	s2,80(s0)
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc020517a:	0327ee63          	bltu	a5,s2,ffffffffc02051b6 <syscall+0x58>
        if (syscalls[num] != NULL) {
ffffffffc020517e:	00391713          	slli	a4,s2,0x3
ffffffffc0205182:	00002797          	auipc	a5,0x2
ffffffffc0205186:	25678793          	addi	a5,a5,598 # ffffffffc02073d8 <syscalls>
ffffffffc020518a:	97ba                	add	a5,a5,a4
ffffffffc020518c:	639c                	ld	a5,0(a5)
ffffffffc020518e:	c785                	beqz	a5,ffffffffc02051b6 <syscall+0x58>
            arg[0] = tf->gpr.a1;
ffffffffc0205190:	6c28                	ld	a0,88(s0)
            arg[1] = tf->gpr.a2;
ffffffffc0205192:	702c                	ld	a1,96(s0)
            arg[2] = tf->gpr.a3;
ffffffffc0205194:	7430                	ld	a2,104(s0)
            arg[3] = tf->gpr.a4;
ffffffffc0205196:	7834                	ld	a3,112(s0)
            arg[4] = tf->gpr.a5;
ffffffffc0205198:	7c38                	ld	a4,120(s0)
            arg[0] = tf->gpr.a1;
ffffffffc020519a:	e42a                	sd	a0,8(sp)
            arg[1] = tf->gpr.a2;
ffffffffc020519c:	e82e                	sd	a1,16(sp)
            arg[2] = tf->gpr.a3;
ffffffffc020519e:	ec32                	sd	a2,24(sp)
            arg[3] = tf->gpr.a4;
ffffffffc02051a0:	f036                	sd	a3,32(sp)
            arg[4] = tf->gpr.a5;
ffffffffc02051a2:	f43a                	sd	a4,40(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02051a4:	0028                	addi	a0,sp,8
ffffffffc02051a6:	9782                	jalr	a5
        }
    }
    print_trapframe(tf);
    panic("undefined syscall %d, pid = %d, name = %s.\n",
            num, current->pid, current->name);
}
ffffffffc02051a8:	60a6                	ld	ra,72(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02051aa:	e828                	sd	a0,80(s0)
}
ffffffffc02051ac:	6406                	ld	s0,64(sp)
ffffffffc02051ae:	74e2                	ld	s1,56(sp)
ffffffffc02051b0:	7942                	ld	s2,48(sp)
ffffffffc02051b2:	6161                	addi	sp,sp,80
ffffffffc02051b4:	8082                	ret
    print_trapframe(tf);
ffffffffc02051b6:	8522                	mv	a0,s0
ffffffffc02051b8:	9edfb0ef          	jal	ra,ffffffffc0200ba4 <print_trapframe>
    panic("undefined syscall %d, pid = %d, name = %s.\n",
ffffffffc02051bc:	609c                	ld	a5,0(s1)
ffffffffc02051be:	86ca                	mv	a3,s2
ffffffffc02051c0:	00002617          	auipc	a2,0x2
ffffffffc02051c4:	1d060613          	addi	a2,a2,464 # ffffffffc0207390 <default_pmm_manager+0xea0>
ffffffffc02051c8:	43d8                	lw	a4,4(a5)
ffffffffc02051ca:	06200593          	li	a1,98
ffffffffc02051ce:	0b478793          	addi	a5,a5,180
ffffffffc02051d2:	00002517          	auipc	a0,0x2
ffffffffc02051d6:	1ee50513          	addi	a0,a0,494 # ffffffffc02073c0 <default_pmm_manager+0xed0>
ffffffffc02051da:	ab4fb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02051de <hash32>:
 *
 * High bits are more random, so we use them.
 * */
uint32_t
hash32(uint32_t val, unsigned int bits) {
    uint32_t hash = val * GOLDEN_RATIO_PRIME_32;
ffffffffc02051de:	9e3707b7          	lui	a5,0x9e370
ffffffffc02051e2:	2785                	addiw	a5,a5,1
ffffffffc02051e4:	02a7853b          	mulw	a0,a5,a0
    return (hash >> (32 - bits));
ffffffffc02051e8:	02000793          	li	a5,32
ffffffffc02051ec:	9f8d                	subw	a5,a5,a1
}
ffffffffc02051ee:	00f5553b          	srlw	a0,a0,a5
ffffffffc02051f2:	8082                	ret

ffffffffc02051f4 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc02051f4:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02051f8:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc02051fa:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02051fe:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc0205200:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0205204:	f022                	sd	s0,32(sp)
ffffffffc0205206:	ec26                	sd	s1,24(sp)
ffffffffc0205208:	e84a                	sd	s2,16(sp)
ffffffffc020520a:	f406                	sd	ra,40(sp)
ffffffffc020520c:	e44e                	sd	s3,8(sp)
ffffffffc020520e:	84aa                	mv	s1,a0
ffffffffc0205210:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc0205212:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc0205216:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc0205218:	03067e63          	bgeu	a2,a6,ffffffffc0205254 <printnum+0x60>
ffffffffc020521c:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc020521e:	00805763          	blez	s0,ffffffffc020522c <printnum+0x38>
ffffffffc0205222:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc0205224:	85ca                	mv	a1,s2
ffffffffc0205226:	854e                	mv	a0,s3
ffffffffc0205228:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc020522a:	fc65                	bnez	s0,ffffffffc0205222 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc020522c:	1a02                	slli	s4,s4,0x20
ffffffffc020522e:	00002797          	auipc	a5,0x2
ffffffffc0205232:	2aa78793          	addi	a5,a5,682 # ffffffffc02074d8 <syscalls+0x100>
ffffffffc0205236:	020a5a13          	srli	s4,s4,0x20
ffffffffc020523a:	9a3e                	add	s4,s4,a5
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
ffffffffc020523c:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc020523e:	000a4503          	lbu	a0,0(s4)
}
ffffffffc0205242:	70a2                	ld	ra,40(sp)
ffffffffc0205244:	69a2                	ld	s3,8(sp)
ffffffffc0205246:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0205248:	85ca                	mv	a1,s2
ffffffffc020524a:	87a6                	mv	a5,s1
}
ffffffffc020524c:	6942                	ld	s2,16(sp)
ffffffffc020524e:	64e2                	ld	s1,24(sp)
ffffffffc0205250:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0205252:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc0205254:	03065633          	divu	a2,a2,a6
ffffffffc0205258:	8722                	mv	a4,s0
ffffffffc020525a:	f9bff0ef          	jal	ra,ffffffffc02051f4 <printnum>
ffffffffc020525e:	b7f9                	j	ffffffffc020522c <printnum+0x38>

ffffffffc0205260 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0205260:	7119                	addi	sp,sp,-128
ffffffffc0205262:	f4a6                	sd	s1,104(sp)
ffffffffc0205264:	f0ca                	sd	s2,96(sp)
ffffffffc0205266:	ecce                	sd	s3,88(sp)
ffffffffc0205268:	e8d2                	sd	s4,80(sp)
ffffffffc020526a:	e4d6                	sd	s5,72(sp)
ffffffffc020526c:	e0da                	sd	s6,64(sp)
ffffffffc020526e:	fc5e                	sd	s7,56(sp)
ffffffffc0205270:	f06a                	sd	s10,32(sp)
ffffffffc0205272:	fc86                	sd	ra,120(sp)
ffffffffc0205274:	f8a2                	sd	s0,112(sp)
ffffffffc0205276:	f862                	sd	s8,48(sp)
ffffffffc0205278:	f466                	sd	s9,40(sp)
ffffffffc020527a:	ec6e                	sd	s11,24(sp)
ffffffffc020527c:	892a                	mv	s2,a0
ffffffffc020527e:	84ae                	mv	s1,a1
ffffffffc0205280:	8d32                	mv	s10,a2
ffffffffc0205282:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0205284:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0205288:	5b7d                	li	s6,-1
ffffffffc020528a:	00002a97          	auipc	s5,0x2
ffffffffc020528e:	27aa8a93          	addi	s5,s5,634 # ffffffffc0207504 <syscalls+0x12c>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0205292:	00002b97          	auipc	s7,0x2
ffffffffc0205296:	48eb8b93          	addi	s7,s7,1166 # ffffffffc0207720 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020529a:	000d4503          	lbu	a0,0(s10)
ffffffffc020529e:	001d0413          	addi	s0,s10,1
ffffffffc02052a2:	01350a63          	beq	a0,s3,ffffffffc02052b6 <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc02052a6:	c121                	beqz	a0,ffffffffc02052e6 <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc02052a8:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02052aa:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc02052ac:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02052ae:	fff44503          	lbu	a0,-1(s0)
ffffffffc02052b2:	ff351ae3          	bne	a0,s3,ffffffffc02052a6 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02052b6:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc02052ba:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc02052be:	4c81                	li	s9,0
ffffffffc02052c0:	4881                	li	a7,0
        width = precision = -1;
ffffffffc02052c2:	5c7d                	li	s8,-1
ffffffffc02052c4:	5dfd                	li	s11,-1
ffffffffc02052c6:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc02052ca:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02052cc:	fdd6059b          	addiw	a1,a2,-35
ffffffffc02052d0:	0ff5f593          	zext.b	a1,a1
ffffffffc02052d4:	00140d13          	addi	s10,s0,1
ffffffffc02052d8:	04b56263          	bltu	a0,a1,ffffffffc020531c <vprintfmt+0xbc>
ffffffffc02052dc:	058a                	slli	a1,a1,0x2
ffffffffc02052de:	95d6                	add	a1,a1,s5
ffffffffc02052e0:	4194                	lw	a3,0(a1)
ffffffffc02052e2:	96d6                	add	a3,a3,s5
ffffffffc02052e4:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc02052e6:	70e6                	ld	ra,120(sp)
ffffffffc02052e8:	7446                	ld	s0,112(sp)
ffffffffc02052ea:	74a6                	ld	s1,104(sp)
ffffffffc02052ec:	7906                	ld	s2,96(sp)
ffffffffc02052ee:	69e6                	ld	s3,88(sp)
ffffffffc02052f0:	6a46                	ld	s4,80(sp)
ffffffffc02052f2:	6aa6                	ld	s5,72(sp)
ffffffffc02052f4:	6b06                	ld	s6,64(sp)
ffffffffc02052f6:	7be2                	ld	s7,56(sp)
ffffffffc02052f8:	7c42                	ld	s8,48(sp)
ffffffffc02052fa:	7ca2                	ld	s9,40(sp)
ffffffffc02052fc:	7d02                	ld	s10,32(sp)
ffffffffc02052fe:	6de2                	ld	s11,24(sp)
ffffffffc0205300:	6109                	addi	sp,sp,128
ffffffffc0205302:	8082                	ret
            padc = '0';
ffffffffc0205304:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc0205306:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020530a:	846a                	mv	s0,s10
ffffffffc020530c:	00140d13          	addi	s10,s0,1
ffffffffc0205310:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0205314:	0ff5f593          	zext.b	a1,a1
ffffffffc0205318:	fcb572e3          	bgeu	a0,a1,ffffffffc02052dc <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc020531c:	85a6                	mv	a1,s1
ffffffffc020531e:	02500513          	li	a0,37
ffffffffc0205322:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc0205324:	fff44783          	lbu	a5,-1(s0)
ffffffffc0205328:	8d22                	mv	s10,s0
ffffffffc020532a:	f73788e3          	beq	a5,s3,ffffffffc020529a <vprintfmt+0x3a>
ffffffffc020532e:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0205332:	1d7d                	addi	s10,s10,-1
ffffffffc0205334:	ff379de3          	bne	a5,s3,ffffffffc020532e <vprintfmt+0xce>
ffffffffc0205338:	b78d                	j	ffffffffc020529a <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc020533a:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc020533e:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205342:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc0205344:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc0205348:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc020534c:	02d86463          	bltu	a6,a3,ffffffffc0205374 <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0205350:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0205354:	002c169b          	slliw	a3,s8,0x2
ffffffffc0205358:	0186873b          	addw	a4,a3,s8
ffffffffc020535c:	0017171b          	slliw	a4,a4,0x1
ffffffffc0205360:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc0205362:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc0205366:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc0205368:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc020536c:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0205370:	fed870e3          	bgeu	a6,a3,ffffffffc0205350 <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0205374:	f40ddce3          	bgez	s11,ffffffffc02052cc <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0205378:	8de2                	mv	s11,s8
ffffffffc020537a:	5c7d                	li	s8,-1
ffffffffc020537c:	bf81                	j	ffffffffc02052cc <vprintfmt+0x6c>
            if (width < 0)
ffffffffc020537e:	fffdc693          	not	a3,s11
ffffffffc0205382:	96fd                	srai	a3,a3,0x3f
ffffffffc0205384:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205388:	00144603          	lbu	a2,1(s0)
ffffffffc020538c:	2d81                	sext.w	s11,s11
ffffffffc020538e:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0205390:	bf35                	j	ffffffffc02052cc <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0205392:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205396:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc020539a:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020539c:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc020539e:	bfd9                	j	ffffffffc0205374 <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc02053a0:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02053a2:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc02053a6:	01174463          	blt	a4,a7,ffffffffc02053ae <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc02053aa:	1a088e63          	beqz	a7,ffffffffc0205566 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc02053ae:	000a3603          	ld	a2,0(s4)
ffffffffc02053b2:	46c1                	li	a3,16
ffffffffc02053b4:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc02053b6:	2781                	sext.w	a5,a5
ffffffffc02053b8:	876e                	mv	a4,s11
ffffffffc02053ba:	85a6                	mv	a1,s1
ffffffffc02053bc:	854a                	mv	a0,s2
ffffffffc02053be:	e37ff0ef          	jal	ra,ffffffffc02051f4 <printnum>
            break;
ffffffffc02053c2:	bde1                	j	ffffffffc020529a <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc02053c4:	000a2503          	lw	a0,0(s4)
ffffffffc02053c8:	85a6                	mv	a1,s1
ffffffffc02053ca:	0a21                	addi	s4,s4,8
ffffffffc02053cc:	9902                	jalr	s2
            break;
ffffffffc02053ce:	b5f1                	j	ffffffffc020529a <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc02053d0:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02053d2:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc02053d6:	01174463          	blt	a4,a7,ffffffffc02053de <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc02053da:	18088163          	beqz	a7,ffffffffc020555c <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc02053de:	000a3603          	ld	a2,0(s4)
ffffffffc02053e2:	46a9                	li	a3,10
ffffffffc02053e4:	8a2e                	mv	s4,a1
ffffffffc02053e6:	bfc1                	j	ffffffffc02053b6 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02053e8:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc02053ec:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02053ee:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc02053f0:	bdf1                	j	ffffffffc02052cc <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc02053f2:	85a6                	mv	a1,s1
ffffffffc02053f4:	02500513          	li	a0,37
ffffffffc02053f8:	9902                	jalr	s2
            break;
ffffffffc02053fa:	b545                	j	ffffffffc020529a <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02053fc:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc0205400:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205402:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0205404:	b5e1                	j	ffffffffc02052cc <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0205406:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0205408:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc020540c:	01174463          	blt	a4,a7,ffffffffc0205414 <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0205410:	14088163          	beqz	a7,ffffffffc0205552 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0205414:	000a3603          	ld	a2,0(s4)
ffffffffc0205418:	46a1                	li	a3,8
ffffffffc020541a:	8a2e                	mv	s4,a1
ffffffffc020541c:	bf69                	j	ffffffffc02053b6 <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc020541e:	03000513          	li	a0,48
ffffffffc0205422:	85a6                	mv	a1,s1
ffffffffc0205424:	e03e                	sd	a5,0(sp)
ffffffffc0205426:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc0205428:	85a6                	mv	a1,s1
ffffffffc020542a:	07800513          	li	a0,120
ffffffffc020542e:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0205430:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0205432:	6782                	ld	a5,0(sp)
ffffffffc0205434:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0205436:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc020543a:	bfb5                	j	ffffffffc02053b6 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc020543c:	000a3403          	ld	s0,0(s4)
ffffffffc0205440:	008a0713          	addi	a4,s4,8
ffffffffc0205444:	e03a                	sd	a4,0(sp)
ffffffffc0205446:	14040263          	beqz	s0,ffffffffc020558a <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc020544a:	0fb05763          	blez	s11,ffffffffc0205538 <vprintfmt+0x2d8>
ffffffffc020544e:	02d00693          	li	a3,45
ffffffffc0205452:	0cd79163          	bne	a5,a3,ffffffffc0205514 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205456:	00044783          	lbu	a5,0(s0)
ffffffffc020545a:	0007851b          	sext.w	a0,a5
ffffffffc020545e:	cf85                	beqz	a5,ffffffffc0205496 <vprintfmt+0x236>
ffffffffc0205460:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205464:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205468:	000c4563          	bltz	s8,ffffffffc0205472 <vprintfmt+0x212>
ffffffffc020546c:	3c7d                	addiw	s8,s8,-1
ffffffffc020546e:	036c0263          	beq	s8,s6,ffffffffc0205492 <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0205472:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205474:	0e0c8e63          	beqz	s9,ffffffffc0205570 <vprintfmt+0x310>
ffffffffc0205478:	3781                	addiw	a5,a5,-32
ffffffffc020547a:	0ef47b63          	bgeu	s0,a5,ffffffffc0205570 <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc020547e:	03f00513          	li	a0,63
ffffffffc0205482:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205484:	000a4783          	lbu	a5,0(s4)
ffffffffc0205488:	3dfd                	addiw	s11,s11,-1
ffffffffc020548a:	0a05                	addi	s4,s4,1
ffffffffc020548c:	0007851b          	sext.w	a0,a5
ffffffffc0205490:	ffe1                	bnez	a5,ffffffffc0205468 <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0205492:	01b05963          	blez	s11,ffffffffc02054a4 <vprintfmt+0x244>
ffffffffc0205496:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0205498:	85a6                	mv	a1,s1
ffffffffc020549a:	02000513          	li	a0,32
ffffffffc020549e:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc02054a0:	fe0d9be3          	bnez	s11,ffffffffc0205496 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc02054a4:	6a02                	ld	s4,0(sp)
ffffffffc02054a6:	bbd5                	j	ffffffffc020529a <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc02054a8:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02054aa:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc02054ae:	01174463          	blt	a4,a7,ffffffffc02054b6 <vprintfmt+0x256>
    else if (lflag) {
ffffffffc02054b2:	08088d63          	beqz	a7,ffffffffc020554c <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc02054b6:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc02054ba:	0a044d63          	bltz	s0,ffffffffc0205574 <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc02054be:	8622                	mv	a2,s0
ffffffffc02054c0:	8a66                	mv	s4,s9
ffffffffc02054c2:	46a9                	li	a3,10
ffffffffc02054c4:	bdcd                	j	ffffffffc02053b6 <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc02054c6:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc02054ca:	4761                	li	a4,24
            err = va_arg(ap, int);
ffffffffc02054cc:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc02054ce:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc02054d2:	8fb5                	xor	a5,a5,a3
ffffffffc02054d4:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc02054d8:	02d74163          	blt	a4,a3,ffffffffc02054fa <vprintfmt+0x29a>
ffffffffc02054dc:	00369793          	slli	a5,a3,0x3
ffffffffc02054e0:	97de                	add	a5,a5,s7
ffffffffc02054e2:	639c                	ld	a5,0(a5)
ffffffffc02054e4:	cb99                	beqz	a5,ffffffffc02054fa <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc02054e6:	86be                	mv	a3,a5
ffffffffc02054e8:	00000617          	auipc	a2,0x0
ffffffffc02054ec:	1f060613          	addi	a2,a2,496 # ffffffffc02056d8 <etext+0x2a>
ffffffffc02054f0:	85a6                	mv	a1,s1
ffffffffc02054f2:	854a                	mv	a0,s2
ffffffffc02054f4:	0ce000ef          	jal	ra,ffffffffc02055c2 <printfmt>
ffffffffc02054f8:	b34d                	j	ffffffffc020529a <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc02054fa:	00002617          	auipc	a2,0x2
ffffffffc02054fe:	ffe60613          	addi	a2,a2,-2 # ffffffffc02074f8 <syscalls+0x120>
ffffffffc0205502:	85a6                	mv	a1,s1
ffffffffc0205504:	854a                	mv	a0,s2
ffffffffc0205506:	0bc000ef          	jal	ra,ffffffffc02055c2 <printfmt>
ffffffffc020550a:	bb41                	j	ffffffffc020529a <vprintfmt+0x3a>
                p = "(null)";
ffffffffc020550c:	00002417          	auipc	s0,0x2
ffffffffc0205510:	fe440413          	addi	s0,s0,-28 # ffffffffc02074f0 <syscalls+0x118>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0205514:	85e2                	mv	a1,s8
ffffffffc0205516:	8522                	mv	a0,s0
ffffffffc0205518:	e43e                	sd	a5,8(sp)
ffffffffc020551a:	0e2000ef          	jal	ra,ffffffffc02055fc <strnlen>
ffffffffc020551e:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0205522:	01b05b63          	blez	s11,ffffffffc0205538 <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc0205526:	67a2                	ld	a5,8(sp)
ffffffffc0205528:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc020552c:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc020552e:	85a6                	mv	a1,s1
ffffffffc0205530:	8552                	mv	a0,s4
ffffffffc0205532:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0205534:	fe0d9ce3          	bnez	s11,ffffffffc020552c <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205538:	00044783          	lbu	a5,0(s0)
ffffffffc020553c:	00140a13          	addi	s4,s0,1
ffffffffc0205540:	0007851b          	sext.w	a0,a5
ffffffffc0205544:	d3a5                	beqz	a5,ffffffffc02054a4 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205546:	05e00413          	li	s0,94
ffffffffc020554a:	bf39                	j	ffffffffc0205468 <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc020554c:	000a2403          	lw	s0,0(s4)
ffffffffc0205550:	b7ad                	j	ffffffffc02054ba <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0205552:	000a6603          	lwu	a2,0(s4)
ffffffffc0205556:	46a1                	li	a3,8
ffffffffc0205558:	8a2e                	mv	s4,a1
ffffffffc020555a:	bdb1                	j	ffffffffc02053b6 <vprintfmt+0x156>
ffffffffc020555c:	000a6603          	lwu	a2,0(s4)
ffffffffc0205560:	46a9                	li	a3,10
ffffffffc0205562:	8a2e                	mv	s4,a1
ffffffffc0205564:	bd89                	j	ffffffffc02053b6 <vprintfmt+0x156>
ffffffffc0205566:	000a6603          	lwu	a2,0(s4)
ffffffffc020556a:	46c1                	li	a3,16
ffffffffc020556c:	8a2e                	mv	s4,a1
ffffffffc020556e:	b5a1                	j	ffffffffc02053b6 <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0205570:	9902                	jalr	s2
ffffffffc0205572:	bf09                	j	ffffffffc0205484 <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0205574:	85a6                	mv	a1,s1
ffffffffc0205576:	02d00513          	li	a0,45
ffffffffc020557a:	e03e                	sd	a5,0(sp)
ffffffffc020557c:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc020557e:	6782                	ld	a5,0(sp)
ffffffffc0205580:	8a66                	mv	s4,s9
ffffffffc0205582:	40800633          	neg	a2,s0
ffffffffc0205586:	46a9                	li	a3,10
ffffffffc0205588:	b53d                	j	ffffffffc02053b6 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc020558a:	03b05163          	blez	s11,ffffffffc02055ac <vprintfmt+0x34c>
ffffffffc020558e:	02d00693          	li	a3,45
ffffffffc0205592:	f6d79de3          	bne	a5,a3,ffffffffc020550c <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0205596:	00002417          	auipc	s0,0x2
ffffffffc020559a:	f5a40413          	addi	s0,s0,-166 # ffffffffc02074f0 <syscalls+0x118>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc020559e:	02800793          	li	a5,40
ffffffffc02055a2:	02800513          	li	a0,40
ffffffffc02055a6:	00140a13          	addi	s4,s0,1
ffffffffc02055aa:	bd6d                	j	ffffffffc0205464 <vprintfmt+0x204>
ffffffffc02055ac:	00002a17          	auipc	s4,0x2
ffffffffc02055b0:	f45a0a13          	addi	s4,s4,-187 # ffffffffc02074f1 <syscalls+0x119>
ffffffffc02055b4:	02800513          	li	a0,40
ffffffffc02055b8:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc02055bc:	05e00413          	li	s0,94
ffffffffc02055c0:	b565                	j	ffffffffc0205468 <vprintfmt+0x208>

ffffffffc02055c2 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02055c2:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc02055c4:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02055c8:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc02055ca:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02055cc:	ec06                	sd	ra,24(sp)
ffffffffc02055ce:	f83a                	sd	a4,48(sp)
ffffffffc02055d0:	fc3e                	sd	a5,56(sp)
ffffffffc02055d2:	e0c2                	sd	a6,64(sp)
ffffffffc02055d4:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc02055d6:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc02055d8:	c89ff0ef          	jal	ra,ffffffffc0205260 <vprintfmt>
}
ffffffffc02055dc:	60e2                	ld	ra,24(sp)
ffffffffc02055de:	6161                	addi	sp,sp,80
ffffffffc02055e0:	8082                	ret

ffffffffc02055e2 <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc02055e2:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc02055e6:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc02055e8:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc02055ea:	cb81                	beqz	a5,ffffffffc02055fa <strlen+0x18>
        cnt ++;
ffffffffc02055ec:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc02055ee:	00a707b3          	add	a5,a4,a0
ffffffffc02055f2:	0007c783          	lbu	a5,0(a5)
ffffffffc02055f6:	fbfd                	bnez	a5,ffffffffc02055ec <strlen+0xa>
ffffffffc02055f8:	8082                	ret
    }
    return cnt;
}
ffffffffc02055fa:	8082                	ret

ffffffffc02055fc <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc02055fc:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc02055fe:	e589                	bnez	a1,ffffffffc0205608 <strnlen+0xc>
ffffffffc0205600:	a811                	j	ffffffffc0205614 <strnlen+0x18>
        cnt ++;
ffffffffc0205602:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc0205604:	00f58863          	beq	a1,a5,ffffffffc0205614 <strnlen+0x18>
ffffffffc0205608:	00f50733          	add	a4,a0,a5
ffffffffc020560c:	00074703          	lbu	a4,0(a4)
ffffffffc0205610:	fb6d                	bnez	a4,ffffffffc0205602 <strnlen+0x6>
ffffffffc0205612:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc0205614:	852e                	mv	a0,a1
ffffffffc0205616:	8082                	ret

ffffffffc0205618 <strcpy>:
char *
strcpy(char *dst, const char *src) {
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
#else
    char *p = dst;
ffffffffc0205618:	87aa                	mv	a5,a0
    while ((*p ++ = *src ++) != '\0')
ffffffffc020561a:	0005c703          	lbu	a4,0(a1)
ffffffffc020561e:	0785                	addi	a5,a5,1
ffffffffc0205620:	0585                	addi	a1,a1,1
ffffffffc0205622:	fee78fa3          	sb	a4,-1(a5)
ffffffffc0205626:	fb75                	bnez	a4,ffffffffc020561a <strcpy+0x2>
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
ffffffffc0205628:	8082                	ret

ffffffffc020562a <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc020562a:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc020562e:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0205632:	cb89                	beqz	a5,ffffffffc0205644 <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc0205634:	0505                	addi	a0,a0,1
ffffffffc0205636:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0205638:	fee789e3          	beq	a5,a4,ffffffffc020562a <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc020563c:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc0205640:	9d19                	subw	a0,a0,a4
ffffffffc0205642:	8082                	ret
ffffffffc0205644:	4501                	li	a0,0
ffffffffc0205646:	bfed                	j	ffffffffc0205640 <strcmp+0x16>

ffffffffc0205648 <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0205648:	c20d                	beqz	a2,ffffffffc020566a <strncmp+0x22>
ffffffffc020564a:	962e                	add	a2,a2,a1
ffffffffc020564c:	a031                	j	ffffffffc0205658 <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc020564e:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0205650:	00e79a63          	bne	a5,a4,ffffffffc0205664 <strncmp+0x1c>
ffffffffc0205654:	00b60b63          	beq	a2,a1,ffffffffc020566a <strncmp+0x22>
ffffffffc0205658:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc020565c:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc020565e:	fff5c703          	lbu	a4,-1(a1)
ffffffffc0205662:	f7f5                	bnez	a5,ffffffffc020564e <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0205664:	40e7853b          	subw	a0,a5,a4
}
ffffffffc0205668:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc020566a:	4501                	li	a0,0
ffffffffc020566c:	8082                	ret

ffffffffc020566e <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc020566e:	00054783          	lbu	a5,0(a0)
ffffffffc0205672:	c799                	beqz	a5,ffffffffc0205680 <strchr+0x12>
        if (*s == c) {
ffffffffc0205674:	00f58763          	beq	a1,a5,ffffffffc0205682 <strchr+0x14>
    while (*s != '\0') {
ffffffffc0205678:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc020567c:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc020567e:	fbfd                	bnez	a5,ffffffffc0205674 <strchr+0x6>
    }
    return NULL;
ffffffffc0205680:	4501                	li	a0,0
}
ffffffffc0205682:	8082                	ret

ffffffffc0205684 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0205684:	ca01                	beqz	a2,ffffffffc0205694 <memset+0x10>
ffffffffc0205686:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc0205688:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc020568a:	0785                	addi	a5,a5,1
ffffffffc020568c:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0205690:	fec79de3          	bne	a5,a2,ffffffffc020568a <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0205694:	8082                	ret

ffffffffc0205696 <memcpy>:
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
#else
    const char *s = src;
    char *d = dst;
    while (n -- > 0) {
ffffffffc0205696:	ca19                	beqz	a2,ffffffffc02056ac <memcpy+0x16>
ffffffffc0205698:	962e                	add	a2,a2,a1
    char *d = dst;
ffffffffc020569a:	87aa                	mv	a5,a0
        *d ++ = *s ++;
ffffffffc020569c:	0005c703          	lbu	a4,0(a1)
ffffffffc02056a0:	0585                	addi	a1,a1,1
ffffffffc02056a2:	0785                	addi	a5,a5,1
ffffffffc02056a4:	fee78fa3          	sb	a4,-1(a5)
    while (n -- > 0) {
ffffffffc02056a8:	fec59ae3          	bne	a1,a2,ffffffffc020569c <memcpy+0x6>
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
ffffffffc02056ac:	8082                	ret
