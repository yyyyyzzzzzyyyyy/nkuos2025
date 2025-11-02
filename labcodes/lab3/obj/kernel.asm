
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
    .globl kern_entry
kern_entry:
    # a0: hartid
    # a1: dtb physical address
    # save hartid and dtb address
    la t0, boot_hartid
ffffffffc0200000:	00007297          	auipc	t0,0x7
ffffffffc0200004:	00028293          	mv	t0,t0
    sd a0, 0(t0)
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0207000 <boot_hartid>
    la t0, boot_dtb
ffffffffc020000c:	00007297          	auipc	t0,0x7
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0207008 <boot_dtb>
    sd a1, 0(t0)
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)

    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200018:	c02062b7          	lui	t0,0xc0206
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
ffffffffc020003c:	c0206137          	lui	sp,0xc0206

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 1. 使用临时寄存器 t1 计算栈顶的精确地址
    lui t1, %hi(bootstacktop)
ffffffffc0200040:	c0206337          	lui	t1,0xc0206
    addi t1, t1, %lo(bootstacktop)
ffffffffc0200044:	00030313          	mv	t1,t1
    # 2. 将精确地址一次性地、安全地传给 sp
    mv sp, t1
ffffffffc0200048:	811a                	mv	sp,t1
    # 现在栈指针已经完美设置，可以安全地调用任何C函数了
    # 然后跳转到 kern_init (不再返回)
    lui t0, %hi(kern_init)
ffffffffc020004a:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc020004e:	05428293          	addi	t0,t0,84 # ffffffffc0200054 <kern_init>
    jr t0
ffffffffc0200052:	8282                	jr	t0

ffffffffc0200054 <kern_init>:
void grade_backtrace(void);

int kern_init(void) {
    extern char edata[], end[];
    // 先清零 BSS，再读取并保存 DTB 的内存信息，避免被清零覆盖（为了解释变化 正式上传时我觉得应该删去这句话）
    memset(edata, 0, end - edata);
ffffffffc0200054:	00007517          	auipc	a0,0x7
ffffffffc0200058:	fd450513          	addi	a0,a0,-44 # ffffffffc0207028 <free_area>
ffffffffc020005c:	00007617          	auipc	a2,0x7
ffffffffc0200060:	44460613          	addi	a2,a2,1092 # ffffffffc02074a0 <end>
int kern_init(void) {
ffffffffc0200064:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc0200066:	8e09                	sub	a2,a2,a0
ffffffffc0200068:	4581                	li	a1,0
int kern_init(void) {
ffffffffc020006a:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc020006c:	763010ef          	jal	ra,ffffffffc0201fce <memset>
    dtb_init();
ffffffffc0200070:	43a000ef          	jal	ra,ffffffffc02004aa <dtb_init>
    cons_init();  // init the console
ffffffffc0200074:	428000ef          	jal	ra,ffffffffc020049c <cons_init>
    const char *message = "(THU.CST) os is loading ...\0";
    //cprintf("%s\n\n", message);
    cputs(message);
ffffffffc0200078:	00002517          	auipc	a0,0x2
ffffffffc020007c:	fd850513          	addi	a0,a0,-40 # ffffffffc0202050 <etext+0x70>
ffffffffc0200080:	0bc000ef          	jal	ra,ffffffffc020013c <cputs>

    print_kerninfo();
ffffffffc0200084:	108000ef          	jal	ra,ffffffffc020018c <print_kerninfo>

    // grade_backtrace();
    idt_init();  // init interrupt descriptor table
ffffffffc0200088:	7de000ef          	jal	ra,ffffffffc0200866 <idt_init>

    pmm_init();  // init physical memory management
ffffffffc020008c:	7c6010ef          	jal	ra,ffffffffc0201852 <pmm_init>
    
    idt_init();  // init interrupt descriptor table
ffffffffc0200090:	7d6000ef          	jal	ra,ffffffffc0200866 <idt_init>

    clock_init();   // init clock interrupt
ffffffffc0200094:	3c6000ef          	jal	ra,ffffffffc020045a <clock_init>
    intr_enable();  // enable irq interrupt
ffffffffc0200098:	7c2000ef          	jal	ra,ffffffffc020085a <intr_enable>
    // trap.c 功能测试
    cprintf("=== Lab3 trap test start ===\n");
ffffffffc020009c:	00002517          	auipc	a0,0x2
ffffffffc02000a0:	f4450513          	addi	a0,a0,-188 # ffffffffc0201fe0 <etext>
ffffffffc02000a4:	060000ef          	jal	ra,ffffffffc0200104 <cprintf>

    // 1️⃣ 测试非法指令异常
    cprintf("[Test] Trigger illegal instruction...\n");
ffffffffc02000a8:	00002517          	auipc	a0,0x2
ffffffffc02000ac:	f5850513          	addi	a0,a0,-168 # ffffffffc0202000 <etext+0x20>
ffffffffc02000b0:	054000ef          	jal	ra,ffffffffc0200104 <cprintf>
ffffffffc02000b4:	ffff                	0xffff
ffffffffc02000b6:	ffff                	0xffff
        ".word 0xffffffff\n" // 插入非法指令编码
        );


    // 2️⃣ 测试断点异常
    cprintf("[Test] Trigger breakpoint (ebreak)...\n");
ffffffffc02000b8:	00002517          	auipc	a0,0x2
ffffffffc02000bc:	f7050513          	addi	a0,a0,-144 # ffffffffc0202028 <etext+0x48>
ffffffffc02000c0:	044000ef          	jal	ra,ffffffffc0200104 <cprintf>
    asm volatile("ebreak");
ffffffffc02000c4:	9002                	ebreak

    /* do nothing */
    while (1)
ffffffffc02000c6:	a001                	j	ffffffffc02000c6 <kern_init+0x72>
	...

ffffffffc02000ca <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
ffffffffc02000ca:	1141                	addi	sp,sp,-16
ffffffffc02000cc:	e022                	sd	s0,0(sp)
ffffffffc02000ce:	e406                	sd	ra,8(sp)
ffffffffc02000d0:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc02000d2:	3cc000ef          	jal	ra,ffffffffc020049e <cons_putc>
    (*cnt) ++;
ffffffffc02000d6:	401c                	lw	a5,0(s0)
}
ffffffffc02000d8:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
ffffffffc02000da:	2785                	addiw	a5,a5,1
ffffffffc02000dc:	c01c                	sw	a5,0(s0)
}
ffffffffc02000de:	6402                	ld	s0,0(sp)
ffffffffc02000e0:	0141                	addi	sp,sp,16
ffffffffc02000e2:	8082                	ret

ffffffffc02000e4 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000e4:	1101                	addi	sp,sp,-32
ffffffffc02000e6:	862a                	mv	a2,a0
ffffffffc02000e8:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000ea:	00000517          	auipc	a0,0x0
ffffffffc02000ee:	fe050513          	addi	a0,a0,-32 # ffffffffc02000ca <cputch>
ffffffffc02000f2:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000f4:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc02000f6:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000f8:	1a7010ef          	jal	ra,ffffffffc0201a9e <vprintfmt>
    return cnt;
}
ffffffffc02000fc:	60e2                	ld	ra,24(sp)
ffffffffc02000fe:	4532                	lw	a0,12(sp)
ffffffffc0200100:	6105                	addi	sp,sp,32
ffffffffc0200102:	8082                	ret

ffffffffc0200104 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
ffffffffc0200104:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc0200106:	02810313          	addi	t1,sp,40 # ffffffffc0206028 <boot_page_table_sv39+0x28>
cprintf(const char *fmt, ...) {
ffffffffc020010a:	8e2a                	mv	t3,a0
ffffffffc020010c:	f42e                	sd	a1,40(sp)
ffffffffc020010e:	f832                	sd	a2,48(sp)
ffffffffc0200110:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc0200112:	00000517          	auipc	a0,0x0
ffffffffc0200116:	fb850513          	addi	a0,a0,-72 # ffffffffc02000ca <cputch>
ffffffffc020011a:	004c                	addi	a1,sp,4
ffffffffc020011c:	869a                	mv	a3,t1
ffffffffc020011e:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
ffffffffc0200120:	ec06                	sd	ra,24(sp)
ffffffffc0200122:	e0ba                	sd	a4,64(sp)
ffffffffc0200124:	e4be                	sd	a5,72(sp)
ffffffffc0200126:	e8c2                	sd	a6,80(sp)
ffffffffc0200128:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc020012a:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc020012c:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc020012e:	171010ef          	jal	ra,ffffffffc0201a9e <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc0200132:	60e2                	ld	ra,24(sp)
ffffffffc0200134:	4512                	lw	a0,4(sp)
ffffffffc0200136:	6125                	addi	sp,sp,96
ffffffffc0200138:	8082                	ret

ffffffffc020013a <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
    cons_putc(c);
ffffffffc020013a:	a695                	j	ffffffffc020049e <cons_putc>

ffffffffc020013c <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
ffffffffc020013c:	1101                	addi	sp,sp,-32
ffffffffc020013e:	e822                	sd	s0,16(sp)
ffffffffc0200140:	ec06                	sd	ra,24(sp)
ffffffffc0200142:	e426                	sd	s1,8(sp)
ffffffffc0200144:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
ffffffffc0200146:	00054503          	lbu	a0,0(a0)
ffffffffc020014a:	c51d                	beqz	a0,ffffffffc0200178 <cputs+0x3c>
ffffffffc020014c:	0405                	addi	s0,s0,1
ffffffffc020014e:	4485                	li	s1,1
ffffffffc0200150:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc0200152:	34c000ef          	jal	ra,ffffffffc020049e <cons_putc>
    while ((c = *str ++) != '\0') {
ffffffffc0200156:	00044503          	lbu	a0,0(s0)
ffffffffc020015a:	008487bb          	addw	a5,s1,s0
ffffffffc020015e:	0405                	addi	s0,s0,1
ffffffffc0200160:	f96d                	bnez	a0,ffffffffc0200152 <cputs+0x16>
    (*cnt) ++;
ffffffffc0200162:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc0200166:	4529                	li	a0,10
ffffffffc0200168:	336000ef          	jal	ra,ffffffffc020049e <cons_putc>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc020016c:	60e2                	ld	ra,24(sp)
ffffffffc020016e:	8522                	mv	a0,s0
ffffffffc0200170:	6442                	ld	s0,16(sp)
ffffffffc0200172:	64a2                	ld	s1,8(sp)
ffffffffc0200174:	6105                	addi	sp,sp,32
ffffffffc0200176:	8082                	ret
    while ((c = *str ++) != '\0') {
ffffffffc0200178:	4405                	li	s0,1
ffffffffc020017a:	b7f5                	j	ffffffffc0200166 <cputs+0x2a>

ffffffffc020017c <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
ffffffffc020017c:	1141                	addi	sp,sp,-16
ffffffffc020017e:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc0200180:	326000ef          	jal	ra,ffffffffc02004a6 <cons_getc>
ffffffffc0200184:	dd75                	beqz	a0,ffffffffc0200180 <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc0200186:	60a2                	ld	ra,8(sp)
ffffffffc0200188:	0141                	addi	sp,sp,16
ffffffffc020018a:	8082                	ret

ffffffffc020018c <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
ffffffffc020018c:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc020018e:	00002517          	auipc	a0,0x2
ffffffffc0200192:	ee250513          	addi	a0,a0,-286 # ffffffffc0202070 <etext+0x90>
void print_kerninfo(void) {
ffffffffc0200196:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc0200198:	f6dff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  entry  0x%016lx (virtual)\n", kern_init);
ffffffffc020019c:	00000597          	auipc	a1,0x0
ffffffffc02001a0:	eb858593          	addi	a1,a1,-328 # ffffffffc0200054 <kern_init>
ffffffffc02001a4:	00002517          	auipc	a0,0x2
ffffffffc02001a8:	eec50513          	addi	a0,a0,-276 # ffffffffc0202090 <etext+0xb0>
ffffffffc02001ac:	f59ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  etext  0x%016lx (virtual)\n", etext);
ffffffffc02001b0:	00002597          	auipc	a1,0x2
ffffffffc02001b4:	e3058593          	addi	a1,a1,-464 # ffffffffc0201fe0 <etext>
ffffffffc02001b8:	00002517          	auipc	a0,0x2
ffffffffc02001bc:	ef850513          	addi	a0,a0,-264 # ffffffffc02020b0 <etext+0xd0>
ffffffffc02001c0:	f45ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  edata  0x%016lx (virtual)\n", edata);
ffffffffc02001c4:	00007597          	auipc	a1,0x7
ffffffffc02001c8:	e6458593          	addi	a1,a1,-412 # ffffffffc0207028 <free_area>
ffffffffc02001cc:	00002517          	auipc	a0,0x2
ffffffffc02001d0:	f0450513          	addi	a0,a0,-252 # ffffffffc02020d0 <etext+0xf0>
ffffffffc02001d4:	f31ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  end    0x%016lx (virtual)\n", end);
ffffffffc02001d8:	00007597          	auipc	a1,0x7
ffffffffc02001dc:	2c858593          	addi	a1,a1,712 # ffffffffc02074a0 <end>
ffffffffc02001e0:	00002517          	auipc	a0,0x2
ffffffffc02001e4:	f1050513          	addi	a0,a0,-240 # ffffffffc02020f0 <etext+0x110>
ffffffffc02001e8:	f1dff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc02001ec:	00007597          	auipc	a1,0x7
ffffffffc02001f0:	6b358593          	addi	a1,a1,1715 # ffffffffc020789f <end+0x3ff>
ffffffffc02001f4:	00000797          	auipc	a5,0x0
ffffffffc02001f8:	e6078793          	addi	a5,a5,-416 # ffffffffc0200054 <kern_init>
ffffffffc02001fc:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200200:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc0200204:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200206:	3ff5f593          	andi	a1,a1,1023
ffffffffc020020a:	95be                	add	a1,a1,a5
ffffffffc020020c:	85a9                	srai	a1,a1,0xa
ffffffffc020020e:	00002517          	auipc	a0,0x2
ffffffffc0200212:	f0250513          	addi	a0,a0,-254 # ffffffffc0202110 <etext+0x130>
}
ffffffffc0200216:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200218:	b5f5                	j	ffffffffc0200104 <cprintf>

ffffffffc020021a <print_stackframe>:
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void) {
ffffffffc020021a:	1141                	addi	sp,sp,-16
    panic("Not Implemented!");
ffffffffc020021c:	00002617          	auipc	a2,0x2
ffffffffc0200220:	f2460613          	addi	a2,a2,-220 # ffffffffc0202140 <etext+0x160>
ffffffffc0200224:	04d00593          	li	a1,77
ffffffffc0200228:	00002517          	auipc	a0,0x2
ffffffffc020022c:	f3050513          	addi	a0,a0,-208 # ffffffffc0202158 <etext+0x178>
void print_stackframe(void) {
ffffffffc0200230:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc0200232:	1cc000ef          	jal	ra,ffffffffc02003fe <__panic>

ffffffffc0200236 <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200236:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc0200238:	00002617          	auipc	a2,0x2
ffffffffc020023c:	f3860613          	addi	a2,a2,-200 # ffffffffc0202170 <etext+0x190>
ffffffffc0200240:	00002597          	auipc	a1,0x2
ffffffffc0200244:	f5058593          	addi	a1,a1,-176 # ffffffffc0202190 <etext+0x1b0>
ffffffffc0200248:	00002517          	auipc	a0,0x2
ffffffffc020024c:	f5050513          	addi	a0,a0,-176 # ffffffffc0202198 <etext+0x1b8>
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200250:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc0200252:	eb3ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
ffffffffc0200256:	00002617          	auipc	a2,0x2
ffffffffc020025a:	f5260613          	addi	a2,a2,-174 # ffffffffc02021a8 <etext+0x1c8>
ffffffffc020025e:	00002597          	auipc	a1,0x2
ffffffffc0200262:	f7258593          	addi	a1,a1,-142 # ffffffffc02021d0 <etext+0x1f0>
ffffffffc0200266:	00002517          	auipc	a0,0x2
ffffffffc020026a:	f3250513          	addi	a0,a0,-206 # ffffffffc0202198 <etext+0x1b8>
ffffffffc020026e:	e97ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
ffffffffc0200272:	00002617          	auipc	a2,0x2
ffffffffc0200276:	f6e60613          	addi	a2,a2,-146 # ffffffffc02021e0 <etext+0x200>
ffffffffc020027a:	00002597          	auipc	a1,0x2
ffffffffc020027e:	f8658593          	addi	a1,a1,-122 # ffffffffc0202200 <etext+0x220>
ffffffffc0200282:	00002517          	auipc	a0,0x2
ffffffffc0200286:	f1650513          	addi	a0,a0,-234 # ffffffffc0202198 <etext+0x1b8>
ffffffffc020028a:	e7bff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    }
    return 0;
}
ffffffffc020028e:	60a2                	ld	ra,8(sp)
ffffffffc0200290:	4501                	li	a0,0
ffffffffc0200292:	0141                	addi	sp,sp,16
ffffffffc0200294:	8082                	ret

ffffffffc0200296 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200296:	1141                	addi	sp,sp,-16
ffffffffc0200298:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc020029a:	ef3ff0ef          	jal	ra,ffffffffc020018c <print_kerninfo>
    return 0;
}
ffffffffc020029e:	60a2                	ld	ra,8(sp)
ffffffffc02002a0:	4501                	li	a0,0
ffffffffc02002a2:	0141                	addi	sp,sp,16
ffffffffc02002a4:	8082                	ret

ffffffffc02002a6 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
ffffffffc02002a6:	1141                	addi	sp,sp,-16
ffffffffc02002a8:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc02002aa:	f71ff0ef          	jal	ra,ffffffffc020021a <print_stackframe>
    return 0;
}
ffffffffc02002ae:	60a2                	ld	ra,8(sp)
ffffffffc02002b0:	4501                	li	a0,0
ffffffffc02002b2:	0141                	addi	sp,sp,16
ffffffffc02002b4:	8082                	ret

ffffffffc02002b6 <kmonitor>:
kmonitor(struct trapframe *tf) {
ffffffffc02002b6:	7115                	addi	sp,sp,-224
ffffffffc02002b8:	ed5e                	sd	s7,152(sp)
ffffffffc02002ba:	8baa                	mv	s7,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02002bc:	00002517          	auipc	a0,0x2
ffffffffc02002c0:	f5450513          	addi	a0,a0,-172 # ffffffffc0202210 <etext+0x230>
kmonitor(struct trapframe *tf) {
ffffffffc02002c4:	ed86                	sd	ra,216(sp)
ffffffffc02002c6:	e9a2                	sd	s0,208(sp)
ffffffffc02002c8:	e5a6                	sd	s1,200(sp)
ffffffffc02002ca:	e1ca                	sd	s2,192(sp)
ffffffffc02002cc:	fd4e                	sd	s3,184(sp)
ffffffffc02002ce:	f952                	sd	s4,176(sp)
ffffffffc02002d0:	f556                	sd	s5,168(sp)
ffffffffc02002d2:	f15a                	sd	s6,160(sp)
ffffffffc02002d4:	e962                	sd	s8,144(sp)
ffffffffc02002d6:	e566                	sd	s9,136(sp)
ffffffffc02002d8:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02002da:	e2bff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc02002de:	00002517          	auipc	a0,0x2
ffffffffc02002e2:	f5a50513          	addi	a0,a0,-166 # ffffffffc0202238 <etext+0x258>
ffffffffc02002e6:	e1fff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    if (tf != NULL) {
ffffffffc02002ea:	000b8563          	beqz	s7,ffffffffc02002f4 <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc02002ee:	855e                	mv	a0,s7
ffffffffc02002f0:	756000ef          	jal	ra,ffffffffc0200a46 <print_trapframe>
ffffffffc02002f4:	00002c17          	auipc	s8,0x2
ffffffffc02002f8:	fb4c0c13          	addi	s8,s8,-76 # ffffffffc02022a8 <commands>
        if ((buf = readline("K> ")) != NULL) {
ffffffffc02002fc:	00002917          	auipc	s2,0x2
ffffffffc0200300:	f6490913          	addi	s2,s2,-156 # ffffffffc0202260 <etext+0x280>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200304:	00002497          	auipc	s1,0x2
ffffffffc0200308:	f6448493          	addi	s1,s1,-156 # ffffffffc0202268 <etext+0x288>
        if (argc == MAXARGS - 1) {
ffffffffc020030c:	49bd                	li	s3,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc020030e:	00002b17          	auipc	s6,0x2
ffffffffc0200312:	f62b0b13          	addi	s6,s6,-158 # ffffffffc0202270 <etext+0x290>
        argv[argc ++] = buf;
ffffffffc0200316:	00002a17          	auipc	s4,0x2
ffffffffc020031a:	e7aa0a13          	addi	s4,s4,-390 # ffffffffc0202190 <etext+0x1b0>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc020031e:	4a8d                	li	s5,3
        if ((buf = readline("K> ")) != NULL) {
ffffffffc0200320:	854a                	mv	a0,s2
ffffffffc0200322:	2ff010ef          	jal	ra,ffffffffc0201e20 <readline>
ffffffffc0200326:	842a                	mv	s0,a0
ffffffffc0200328:	dd65                	beqz	a0,ffffffffc0200320 <kmonitor+0x6a>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc020032a:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc020032e:	4c81                	li	s9,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200330:	e1bd                	bnez	a1,ffffffffc0200396 <kmonitor+0xe0>
    if (argc == 0) {
ffffffffc0200332:	fe0c87e3          	beqz	s9,ffffffffc0200320 <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200336:	6582                	ld	a1,0(sp)
ffffffffc0200338:	00002d17          	auipc	s10,0x2
ffffffffc020033c:	f70d0d13          	addi	s10,s10,-144 # ffffffffc02022a8 <commands>
        argv[argc ++] = buf;
ffffffffc0200340:	8552                	mv	a0,s4
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200342:	4401                	li	s0,0
ffffffffc0200344:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200346:	42f010ef          	jal	ra,ffffffffc0201f74 <strcmp>
ffffffffc020034a:	c919                	beqz	a0,ffffffffc0200360 <kmonitor+0xaa>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc020034c:	2405                	addiw	s0,s0,1
ffffffffc020034e:	0b540063          	beq	s0,s5,ffffffffc02003ee <kmonitor+0x138>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200352:	000d3503          	ld	a0,0(s10)
ffffffffc0200356:	6582                	ld	a1,0(sp)
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200358:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc020035a:	41b010ef          	jal	ra,ffffffffc0201f74 <strcmp>
ffffffffc020035e:	f57d                	bnez	a0,ffffffffc020034c <kmonitor+0x96>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc0200360:	00141793          	slli	a5,s0,0x1
ffffffffc0200364:	97a2                	add	a5,a5,s0
ffffffffc0200366:	078e                	slli	a5,a5,0x3
ffffffffc0200368:	97e2                	add	a5,a5,s8
ffffffffc020036a:	6b9c                	ld	a5,16(a5)
ffffffffc020036c:	865e                	mv	a2,s7
ffffffffc020036e:	002c                	addi	a1,sp,8
ffffffffc0200370:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200374:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0) {
ffffffffc0200376:	fa0555e3          	bgez	a0,ffffffffc0200320 <kmonitor+0x6a>
}
ffffffffc020037a:	60ee                	ld	ra,216(sp)
ffffffffc020037c:	644e                	ld	s0,208(sp)
ffffffffc020037e:	64ae                	ld	s1,200(sp)
ffffffffc0200380:	690e                	ld	s2,192(sp)
ffffffffc0200382:	79ea                	ld	s3,184(sp)
ffffffffc0200384:	7a4a                	ld	s4,176(sp)
ffffffffc0200386:	7aaa                	ld	s5,168(sp)
ffffffffc0200388:	7b0a                	ld	s6,160(sp)
ffffffffc020038a:	6bea                	ld	s7,152(sp)
ffffffffc020038c:	6c4a                	ld	s8,144(sp)
ffffffffc020038e:	6caa                	ld	s9,136(sp)
ffffffffc0200390:	6d0a                	ld	s10,128(sp)
ffffffffc0200392:	612d                	addi	sp,sp,224
ffffffffc0200394:	8082                	ret
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200396:	8526                	mv	a0,s1
ffffffffc0200398:	421010ef          	jal	ra,ffffffffc0201fb8 <strchr>
ffffffffc020039c:	c901                	beqz	a0,ffffffffc02003ac <kmonitor+0xf6>
ffffffffc020039e:	00144583          	lbu	a1,1(s0)
            *buf ++ = '\0';
ffffffffc02003a2:	00040023          	sb	zero,0(s0)
ffffffffc02003a6:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02003a8:	d5c9                	beqz	a1,ffffffffc0200332 <kmonitor+0x7c>
ffffffffc02003aa:	b7f5                	j	ffffffffc0200396 <kmonitor+0xe0>
        if (*buf == '\0') {
ffffffffc02003ac:	00044783          	lbu	a5,0(s0)
ffffffffc02003b0:	d3c9                	beqz	a5,ffffffffc0200332 <kmonitor+0x7c>
        if (argc == MAXARGS - 1) {
ffffffffc02003b2:	033c8963          	beq	s9,s3,ffffffffc02003e4 <kmonitor+0x12e>
        argv[argc ++] = buf;
ffffffffc02003b6:	003c9793          	slli	a5,s9,0x3
ffffffffc02003ba:	0118                	addi	a4,sp,128
ffffffffc02003bc:	97ba                	add	a5,a5,a4
ffffffffc02003be:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02003c2:	00044583          	lbu	a1,0(s0)
        argv[argc ++] = buf;
ffffffffc02003c6:	2c85                	addiw	s9,s9,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02003c8:	e591                	bnez	a1,ffffffffc02003d4 <kmonitor+0x11e>
ffffffffc02003ca:	b7b5                	j	ffffffffc0200336 <kmonitor+0x80>
ffffffffc02003cc:	00144583          	lbu	a1,1(s0)
            buf ++;
ffffffffc02003d0:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02003d2:	d1a5                	beqz	a1,ffffffffc0200332 <kmonitor+0x7c>
ffffffffc02003d4:	8526                	mv	a0,s1
ffffffffc02003d6:	3e3010ef          	jal	ra,ffffffffc0201fb8 <strchr>
ffffffffc02003da:	d96d                	beqz	a0,ffffffffc02003cc <kmonitor+0x116>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02003dc:	00044583          	lbu	a1,0(s0)
ffffffffc02003e0:	d9a9                	beqz	a1,ffffffffc0200332 <kmonitor+0x7c>
ffffffffc02003e2:	bf55                	j	ffffffffc0200396 <kmonitor+0xe0>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc02003e4:	45c1                	li	a1,16
ffffffffc02003e6:	855a                	mv	a0,s6
ffffffffc02003e8:	d1dff0ef          	jal	ra,ffffffffc0200104 <cprintf>
ffffffffc02003ec:	b7e9                	j	ffffffffc02003b6 <kmonitor+0x100>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc02003ee:	6582                	ld	a1,0(sp)
ffffffffc02003f0:	00002517          	auipc	a0,0x2
ffffffffc02003f4:	ea050513          	addi	a0,a0,-352 # ffffffffc0202290 <etext+0x2b0>
ffffffffc02003f8:	d0dff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    return 0;
ffffffffc02003fc:	b715                	j	ffffffffc0200320 <kmonitor+0x6a>

ffffffffc02003fe <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
ffffffffc02003fe:	00007317          	auipc	t1,0x7
ffffffffc0200402:	04230313          	addi	t1,t1,66 # ffffffffc0207440 <is_panic>
ffffffffc0200406:	00032e03          	lw	t3,0(t1)
__panic(const char *file, int line, const char *fmt, ...) {
ffffffffc020040a:	715d                	addi	sp,sp,-80
ffffffffc020040c:	ec06                	sd	ra,24(sp)
ffffffffc020040e:	e822                	sd	s0,16(sp)
ffffffffc0200410:	f436                	sd	a3,40(sp)
ffffffffc0200412:	f83a                	sd	a4,48(sp)
ffffffffc0200414:	fc3e                	sd	a5,56(sp)
ffffffffc0200416:	e0c2                	sd	a6,64(sp)
ffffffffc0200418:	e4c6                	sd	a7,72(sp)
    if (is_panic) {
ffffffffc020041a:	020e1a63          	bnez	t3,ffffffffc020044e <__panic+0x50>
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc020041e:	4785                	li	a5,1
ffffffffc0200420:	00f32023          	sw	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc0200424:	8432                	mv	s0,a2
ffffffffc0200426:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc0200428:	862e                	mv	a2,a1
ffffffffc020042a:	85aa                	mv	a1,a0
ffffffffc020042c:	00002517          	auipc	a0,0x2
ffffffffc0200430:	ec450513          	addi	a0,a0,-316 # ffffffffc02022f0 <commands+0x48>
    va_start(ap, fmt);
ffffffffc0200434:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc0200436:	ccfff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    vcprintf(fmt, ap);
ffffffffc020043a:	65a2                	ld	a1,8(sp)
ffffffffc020043c:	8522                	mv	a0,s0
ffffffffc020043e:	ca7ff0ef          	jal	ra,ffffffffc02000e4 <vcprintf>
    cprintf("\n");
ffffffffc0200442:	00002517          	auipc	a0,0x2
ffffffffc0200446:	cf650513          	addi	a0,a0,-778 # ffffffffc0202138 <etext+0x158>
ffffffffc020044a:	cbbff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    va_end(ap);

panic_dead:
    intr_disable();
ffffffffc020044e:	412000ef          	jal	ra,ffffffffc0200860 <intr_disable>
    while (1) {
        kmonitor(NULL);
ffffffffc0200452:	4501                	li	a0,0
ffffffffc0200454:	e63ff0ef          	jal	ra,ffffffffc02002b6 <kmonitor>
    while (1) {
ffffffffc0200458:	bfed                	j	ffffffffc0200452 <__panic+0x54>

ffffffffc020045a <clock_init>:

/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void clock_init(void) {
ffffffffc020045a:	1141                	addi	sp,sp,-16
ffffffffc020045c:	e406                	sd	ra,8(sp)
    // enable timer interrupt in sie
    set_csr(sie, MIP_STIP);
ffffffffc020045e:	02000793          	li	a5,32
ffffffffc0200462:	1047a7f3          	csrrs	a5,sie,a5
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200466:	c0102573          	rdtime	a0
    ticks = 0;

    cprintf("++ setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc020046a:	67e1                	lui	a5,0x18
ffffffffc020046c:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0xffffffffc01e7960>
ffffffffc0200470:	953e                	add	a0,a0,a5
ffffffffc0200472:	27d010ef          	jal	ra,ffffffffc0201eee <sbi_set_timer>
}
ffffffffc0200476:	60a2                	ld	ra,8(sp)
    ticks = 0;
ffffffffc0200478:	00007797          	auipc	a5,0x7
ffffffffc020047c:	fc07b823          	sd	zero,-48(a5) # ffffffffc0207448 <ticks>
    cprintf("++ setup timer interrupts\n");
ffffffffc0200480:	00002517          	auipc	a0,0x2
ffffffffc0200484:	e9050513          	addi	a0,a0,-368 # ffffffffc0202310 <commands+0x68>
}
ffffffffc0200488:	0141                	addi	sp,sp,16
    cprintf("++ setup timer interrupts\n");
ffffffffc020048a:	b9ad                	j	ffffffffc0200104 <cprintf>

ffffffffc020048c <clock_set_next_event>:
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc020048c:	c0102573          	rdtime	a0
void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc0200490:	67e1                	lui	a5,0x18
ffffffffc0200492:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0xffffffffc01e7960>
ffffffffc0200496:	953e                	add	a0,a0,a5
ffffffffc0200498:	2570106f          	j	ffffffffc0201eee <sbi_set_timer>

ffffffffc020049c <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc020049c:	8082                	ret

ffffffffc020049e <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) { sbi_console_putchar((unsigned char)c); }
ffffffffc020049e:	0ff57513          	zext.b	a0,a0
ffffffffc02004a2:	2330106f          	j	ffffffffc0201ed4 <sbi_console_putchar>

ffffffffc02004a6 <cons_getc>:
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int cons_getc(void) {
    int c = 0;
    c = sbi_console_getchar();
ffffffffc02004a6:	2630106f          	j	ffffffffc0201f08 <sbi_console_getchar>

ffffffffc02004aa <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc02004aa:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc02004ac:	00002517          	auipc	a0,0x2
ffffffffc02004b0:	e8450513          	addi	a0,a0,-380 # ffffffffc0202330 <commands+0x88>
void dtb_init(void) {
ffffffffc02004b4:	fc86                	sd	ra,120(sp)
ffffffffc02004b6:	f8a2                	sd	s0,112(sp)
ffffffffc02004b8:	e8d2                	sd	s4,80(sp)
ffffffffc02004ba:	f4a6                	sd	s1,104(sp)
ffffffffc02004bc:	f0ca                	sd	s2,96(sp)
ffffffffc02004be:	ecce                	sd	s3,88(sp)
ffffffffc02004c0:	e4d6                	sd	s5,72(sp)
ffffffffc02004c2:	e0da                	sd	s6,64(sp)
ffffffffc02004c4:	fc5e                	sd	s7,56(sp)
ffffffffc02004c6:	f862                	sd	s8,48(sp)
ffffffffc02004c8:	f466                	sd	s9,40(sp)
ffffffffc02004ca:	f06a                	sd	s10,32(sp)
ffffffffc02004cc:	ec6e                	sd	s11,24(sp)
    cprintf("DTB Init\n");
ffffffffc02004ce:	c37ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("HartID: %ld\n", boot_hartid);
ffffffffc02004d2:	00007597          	auipc	a1,0x7
ffffffffc02004d6:	b2e5b583          	ld	a1,-1234(a1) # ffffffffc0207000 <boot_hartid>
ffffffffc02004da:	00002517          	auipc	a0,0x2
ffffffffc02004de:	e6650513          	addi	a0,a0,-410 # ffffffffc0202340 <commands+0x98>
ffffffffc02004e2:	c23ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc02004e6:	00007417          	auipc	s0,0x7
ffffffffc02004ea:	b2240413          	addi	s0,s0,-1246 # ffffffffc0207008 <boot_dtb>
ffffffffc02004ee:	600c                	ld	a1,0(s0)
ffffffffc02004f0:	00002517          	auipc	a0,0x2
ffffffffc02004f4:	e6050513          	addi	a0,a0,-416 # ffffffffc0202350 <commands+0xa8>
ffffffffc02004f8:	c0dff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc02004fc:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc0200500:	00002517          	auipc	a0,0x2
ffffffffc0200504:	e6850513          	addi	a0,a0,-408 # ffffffffc0202368 <commands+0xc0>
    if (boot_dtb == 0) {
ffffffffc0200508:	120a0463          	beqz	s4,ffffffffc0200630 <dtb_init+0x186>
        return;
    }
    
    // 转换为虚拟地址
    uintptr_t dtb_vaddr = boot_dtb + PHYSICAL_MEMORY_OFFSET;
ffffffffc020050c:	57f5                	li	a5,-3
ffffffffc020050e:	07fa                	slli	a5,a5,0x1e
ffffffffc0200510:	00fa0733          	add	a4,s4,a5
    const struct fdt_header *header = (const struct fdt_header *)dtb_vaddr;
    
    // 验证DTB
    uint32_t magic = fdt32_to_cpu(header->magic);
ffffffffc0200514:	431c                	lw	a5,0(a4)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200516:	00ff0637          	lui	a2,0xff0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020051a:	6b41                	lui	s6,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020051c:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200520:	0187969b          	slliw	a3,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200524:	0187d51b          	srliw	a0,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200528:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020052c:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200530:	8df1                	and	a1,a1,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200532:	8ec9                	or	a3,a3,a0
ffffffffc0200534:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200538:	1b7d                	addi	s6,s6,-1
ffffffffc020053a:	0167f7b3          	and	a5,a5,s6
ffffffffc020053e:	8dd5                	or	a1,a1,a3
ffffffffc0200540:	8ddd                	or	a1,a1,a5
    if (magic != 0xd00dfeed) {
ffffffffc0200542:	d00e07b7          	lui	a5,0xd00e0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200546:	2581                	sext.w	a1,a1
    if (magic != 0xd00dfeed) {
ffffffffc0200548:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfed8a4d>
ffffffffc020054c:	10f59163          	bne	a1,a5,ffffffffc020064e <dtb_init+0x1a4>
        return;
    }
    
    // 提取内存信息
    uint64_t mem_base, mem_size;
    if (extract_memory_info(dtb_vaddr, header, &mem_base, &mem_size) == 0) {
ffffffffc0200550:	471c                	lw	a5,8(a4)
ffffffffc0200552:	4754                	lw	a3,12(a4)
    int in_memory_node = 0;
ffffffffc0200554:	4c81                	li	s9,0
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200556:	0087d59b          	srliw	a1,a5,0x8
ffffffffc020055a:	0086d51b          	srliw	a0,a3,0x8
ffffffffc020055e:	0186941b          	slliw	s0,a3,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200562:	0186d89b          	srliw	a7,a3,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200566:	01879a1b          	slliw	s4,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020056a:	0187d81b          	srliw	a6,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020056e:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200572:	0106d69b          	srliw	a3,a3,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200576:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020057a:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020057e:	8d71                	and	a0,a0,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200580:	01146433          	or	s0,s0,a7
ffffffffc0200584:	0086969b          	slliw	a3,a3,0x8
ffffffffc0200588:	010a6a33          	or	s4,s4,a6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020058c:	8e6d                	and	a2,a2,a1
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020058e:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200592:	8c49                	or	s0,s0,a0
ffffffffc0200594:	0166f6b3          	and	a3,a3,s6
ffffffffc0200598:	00ca6a33          	or	s4,s4,a2
ffffffffc020059c:	0167f7b3          	and	a5,a5,s6
ffffffffc02005a0:	8c55                	or	s0,s0,a3
ffffffffc02005a2:	00fa6a33          	or	s4,s4,a5
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02005a6:	1402                	slli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02005a8:	1a02                	slli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02005aa:	9001                	srli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02005ac:	020a5a13          	srli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02005b0:	943a                	add	s0,s0,a4
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02005b2:	9a3a                	add	s4,s4,a4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005b4:	00ff0c37          	lui	s8,0xff0
        switch (token) {
ffffffffc02005b8:	4b8d                	li	s7,3
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc02005ba:	00002917          	auipc	s2,0x2
ffffffffc02005be:	dfe90913          	addi	s2,s2,-514 # ffffffffc02023b8 <commands+0x110>
ffffffffc02005c2:	49bd                	li	s3,15
        switch (token) {
ffffffffc02005c4:	4d91                	li	s11,4
ffffffffc02005c6:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02005c8:	00002497          	auipc	s1,0x2
ffffffffc02005cc:	de848493          	addi	s1,s1,-536 # ffffffffc02023b0 <commands+0x108>
        uint32_t token = fdt32_to_cpu(*struct_ptr++);
ffffffffc02005d0:	000a2703          	lw	a4,0(s4)
ffffffffc02005d4:	004a0a93          	addi	s5,s4,4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005d8:	0087569b          	srliw	a3,a4,0x8
ffffffffc02005dc:	0187179b          	slliw	a5,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005e0:	0187561b          	srliw	a2,a4,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005e4:	0106969b          	slliw	a3,a3,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005e8:	0107571b          	srliw	a4,a4,0x10
ffffffffc02005ec:	8fd1                	or	a5,a5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005ee:	0186f6b3          	and	a3,a3,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005f2:	0087171b          	slliw	a4,a4,0x8
ffffffffc02005f6:	8fd5                	or	a5,a5,a3
ffffffffc02005f8:	00eb7733          	and	a4,s6,a4
ffffffffc02005fc:	8fd9                	or	a5,a5,a4
ffffffffc02005fe:	2781                	sext.w	a5,a5
        switch (token) {
ffffffffc0200600:	09778c63          	beq	a5,s7,ffffffffc0200698 <dtb_init+0x1ee>
ffffffffc0200604:	00fbea63          	bltu	s7,a5,ffffffffc0200618 <dtb_init+0x16e>
ffffffffc0200608:	07a78663          	beq	a5,s10,ffffffffc0200674 <dtb_init+0x1ca>
ffffffffc020060c:	4709                	li	a4,2
ffffffffc020060e:	00e79763          	bne	a5,a4,ffffffffc020061c <dtb_init+0x172>
ffffffffc0200612:	4c81                	li	s9,0
ffffffffc0200614:	8a56                	mv	s4,s5
ffffffffc0200616:	bf6d                	j	ffffffffc02005d0 <dtb_init+0x126>
ffffffffc0200618:	ffb78ee3          	beq	a5,s11,ffffffffc0200614 <dtb_init+0x16a>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
        // 保存到全局变量，供 PMM 查询
        memory_base = mem_base;
        memory_size = mem_size;
    } else {
        cprintf("Warning: Could not extract memory info from DTB\n");
ffffffffc020061c:	00002517          	auipc	a0,0x2
ffffffffc0200620:	e1450513          	addi	a0,a0,-492 # ffffffffc0202430 <commands+0x188>
ffffffffc0200624:	ae1ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc0200628:	00002517          	auipc	a0,0x2
ffffffffc020062c:	e4050513          	addi	a0,a0,-448 # ffffffffc0202468 <commands+0x1c0>
}
ffffffffc0200630:	7446                	ld	s0,112(sp)
ffffffffc0200632:	70e6                	ld	ra,120(sp)
ffffffffc0200634:	74a6                	ld	s1,104(sp)
ffffffffc0200636:	7906                	ld	s2,96(sp)
ffffffffc0200638:	69e6                	ld	s3,88(sp)
ffffffffc020063a:	6a46                	ld	s4,80(sp)
ffffffffc020063c:	6aa6                	ld	s5,72(sp)
ffffffffc020063e:	6b06                	ld	s6,64(sp)
ffffffffc0200640:	7be2                	ld	s7,56(sp)
ffffffffc0200642:	7c42                	ld	s8,48(sp)
ffffffffc0200644:	7ca2                	ld	s9,40(sp)
ffffffffc0200646:	7d02                	ld	s10,32(sp)
ffffffffc0200648:	6de2                	ld	s11,24(sp)
ffffffffc020064a:	6109                	addi	sp,sp,128
    cprintf("DTB init completed\n");
ffffffffc020064c:	bc65                	j	ffffffffc0200104 <cprintf>
}
ffffffffc020064e:	7446                	ld	s0,112(sp)
ffffffffc0200650:	70e6                	ld	ra,120(sp)
ffffffffc0200652:	74a6                	ld	s1,104(sp)
ffffffffc0200654:	7906                	ld	s2,96(sp)
ffffffffc0200656:	69e6                	ld	s3,88(sp)
ffffffffc0200658:	6a46                	ld	s4,80(sp)
ffffffffc020065a:	6aa6                	ld	s5,72(sp)
ffffffffc020065c:	6b06                	ld	s6,64(sp)
ffffffffc020065e:	7be2                	ld	s7,56(sp)
ffffffffc0200660:	7c42                	ld	s8,48(sp)
ffffffffc0200662:	7ca2                	ld	s9,40(sp)
ffffffffc0200664:	7d02                	ld	s10,32(sp)
ffffffffc0200666:	6de2                	ld	s11,24(sp)
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc0200668:	00002517          	auipc	a0,0x2
ffffffffc020066c:	d2050513          	addi	a0,a0,-736 # ffffffffc0202388 <commands+0xe0>
}
ffffffffc0200670:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc0200672:	bc49                	j	ffffffffc0200104 <cprintf>
                int name_len = strlen(name);
ffffffffc0200674:	8556                	mv	a0,s5
ffffffffc0200676:	0c9010ef          	jal	ra,ffffffffc0201f3e <strlen>
ffffffffc020067a:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020067c:	4619                	li	a2,6
ffffffffc020067e:	85a6                	mv	a1,s1
ffffffffc0200680:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc0200682:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc0200684:	10f010ef          	jal	ra,ffffffffc0201f92 <strncmp>
ffffffffc0200688:	e111                	bnez	a0,ffffffffc020068c <dtb_init+0x1e2>
                    in_memory_node = 1;
ffffffffc020068a:	4c85                	li	s9,1
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + name_len + 4) & ~3);
ffffffffc020068c:	0a91                	addi	s5,s5,4
ffffffffc020068e:	9ad2                	add	s5,s5,s4
ffffffffc0200690:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc0200694:	8a56                	mv	s4,s5
ffffffffc0200696:	bf2d                	j	ffffffffc02005d0 <dtb_init+0x126>
                uint32_t prop_len = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200698:	004a2783          	lw	a5,4(s4)
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc020069c:	00ca0693          	addi	a3,s4,12
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006a0:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02006a4:	01879a9b          	slliw	s5,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006a8:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006ac:	0107171b          	slliw	a4,a4,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006b0:	0107d79b          	srliw	a5,a5,0x10
ffffffffc02006b4:	00caeab3          	or	s5,s5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006b8:	01877733          	and	a4,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006bc:	0087979b          	slliw	a5,a5,0x8
ffffffffc02006c0:	00eaeab3          	or	s5,s5,a4
ffffffffc02006c4:	00fb77b3          	and	a5,s6,a5
ffffffffc02006c8:	00faeab3          	or	s5,s5,a5
ffffffffc02006cc:	2a81                	sext.w	s5,s5
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc02006ce:	000c9c63          	bnez	s9,ffffffffc02006e6 <dtb_init+0x23c>
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + prop_len + 3) & ~3);
ffffffffc02006d2:	1a82                	slli	s5,s5,0x20
ffffffffc02006d4:	00368793          	addi	a5,a3,3
ffffffffc02006d8:	020ada93          	srli	s5,s5,0x20
ffffffffc02006dc:	9abe                	add	s5,s5,a5
ffffffffc02006de:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc02006e2:	8a56                	mv	s4,s5
ffffffffc02006e4:	b5f5                	j	ffffffffc02005d0 <dtb_init+0x126>
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc02006e6:	008a2783          	lw	a5,8(s4)
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc02006ea:	85ca                	mv	a1,s2
ffffffffc02006ec:	e436                	sd	a3,8(sp)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006ee:	0087d51b          	srliw	a0,a5,0x8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006f2:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006f6:	0187971b          	slliw	a4,a5,0x18
ffffffffc02006fa:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006fe:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200702:	8f51                	or	a4,a4,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200704:	01857533          	and	a0,a0,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200708:	0087979b          	slliw	a5,a5,0x8
ffffffffc020070c:	8d59                	or	a0,a0,a4
ffffffffc020070e:	00fb77b3          	and	a5,s6,a5
ffffffffc0200712:	8d5d                	or	a0,a0,a5
                const char *prop_name = strings_base + prop_nameoff;
ffffffffc0200714:	1502                	slli	a0,a0,0x20
ffffffffc0200716:	9101                	srli	a0,a0,0x20
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200718:	9522                	add	a0,a0,s0
ffffffffc020071a:	05b010ef          	jal	ra,ffffffffc0201f74 <strcmp>
ffffffffc020071e:	66a2                	ld	a3,8(sp)
ffffffffc0200720:	f94d                	bnez	a0,ffffffffc02006d2 <dtb_init+0x228>
ffffffffc0200722:	fb59f8e3          	bgeu	s3,s5,ffffffffc02006d2 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc0200726:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc020072a:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc020072e:	00002517          	auipc	a0,0x2
ffffffffc0200732:	c9250513          	addi	a0,a0,-878 # ffffffffc02023c0 <commands+0x118>
           fdt32_to_cpu(x >> 32);
ffffffffc0200736:	4207d613          	srai	a2,a5,0x20
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020073a:	0087d31b          	srliw	t1,a5,0x8
           fdt32_to_cpu(x >> 32);
ffffffffc020073e:	42075593          	srai	a1,a4,0x20
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200742:	0187de1b          	srliw	t3,a5,0x18
ffffffffc0200746:	0186581b          	srliw	a6,a2,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020074a:	0187941b          	slliw	s0,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020074e:	0107d89b          	srliw	a7,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200752:	0187d693          	srli	a3,a5,0x18
ffffffffc0200756:	01861f1b          	slliw	t5,a2,0x18
ffffffffc020075a:	0087579b          	srliw	a5,a4,0x8
ffffffffc020075e:	0103131b          	slliw	t1,t1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200762:	0106561b          	srliw	a2,a2,0x10
ffffffffc0200766:	010f6f33          	or	t5,t5,a6
ffffffffc020076a:	0187529b          	srliw	t0,a4,0x18
ffffffffc020076e:	0185df9b          	srliw	t6,a1,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200772:	01837333          	and	t1,t1,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200776:	01c46433          	or	s0,s0,t3
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020077a:	0186f6b3          	and	a3,a3,s8
ffffffffc020077e:	01859e1b          	slliw	t3,a1,0x18
ffffffffc0200782:	01871e9b          	slliw	t4,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200786:	0107581b          	srliw	a6,a4,0x10
ffffffffc020078a:	0086161b          	slliw	a2,a2,0x8
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020078e:	8361                	srli	a4,a4,0x18
ffffffffc0200790:	0107979b          	slliw	a5,a5,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200794:	0105d59b          	srliw	a1,a1,0x10
ffffffffc0200798:	01e6e6b3          	or	a3,a3,t5
ffffffffc020079c:	00cb7633          	and	a2,s6,a2
ffffffffc02007a0:	0088181b          	slliw	a6,a6,0x8
ffffffffc02007a4:	0085959b          	slliw	a1,a1,0x8
ffffffffc02007a8:	00646433          	or	s0,s0,t1
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007ac:	0187f7b3          	and	a5,a5,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007b0:	01fe6333          	or	t1,t3,t6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007b4:	01877c33          	and	s8,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007b8:	0088989b          	slliw	a7,a7,0x8
ffffffffc02007bc:	011b78b3          	and	a7,s6,a7
ffffffffc02007c0:	005eeeb3          	or	t4,t4,t0
ffffffffc02007c4:	00c6e733          	or	a4,a3,a2
ffffffffc02007c8:	006c6c33          	or	s8,s8,t1
ffffffffc02007cc:	010b76b3          	and	a3,s6,a6
ffffffffc02007d0:	00bb7b33          	and	s6,s6,a1
ffffffffc02007d4:	01d7e7b3          	or	a5,a5,t4
ffffffffc02007d8:	016c6b33          	or	s6,s8,s6
ffffffffc02007dc:	01146433          	or	s0,s0,a7
ffffffffc02007e0:	8fd5                	or	a5,a5,a3
           fdt32_to_cpu(x >> 32);
ffffffffc02007e2:	1702                	slli	a4,a4,0x20
ffffffffc02007e4:	1b02                	slli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc02007e6:	1782                	slli	a5,a5,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc02007e8:	9301                	srli	a4,a4,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc02007ea:	1402                	slli	s0,s0,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc02007ec:	020b5b13          	srli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc02007f0:	0167eb33          	or	s6,a5,s6
ffffffffc02007f4:	8c59                	or	s0,s0,a4
        cprintf("Physical Memory from DTB:\n");
ffffffffc02007f6:	90fff0ef          	jal	ra,ffffffffc0200104 <cprintf>
        cprintf("  Base: 0x%016lx\n", mem_base);
ffffffffc02007fa:	85a2                	mv	a1,s0
ffffffffc02007fc:	00002517          	auipc	a0,0x2
ffffffffc0200800:	be450513          	addi	a0,a0,-1052 # ffffffffc02023e0 <commands+0x138>
ffffffffc0200804:	901ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc0200808:	014b5613          	srli	a2,s6,0x14
ffffffffc020080c:	85da                	mv	a1,s6
ffffffffc020080e:	00002517          	auipc	a0,0x2
ffffffffc0200812:	bea50513          	addi	a0,a0,-1046 # ffffffffc02023f8 <commands+0x150>
ffffffffc0200816:	8efff0ef          	jal	ra,ffffffffc0200104 <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc020081a:	008b05b3          	add	a1,s6,s0
ffffffffc020081e:	15fd                	addi	a1,a1,-1
ffffffffc0200820:	00002517          	auipc	a0,0x2
ffffffffc0200824:	bf850513          	addi	a0,a0,-1032 # ffffffffc0202418 <commands+0x170>
ffffffffc0200828:	8ddff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("DTB init completed\n");
ffffffffc020082c:	00002517          	auipc	a0,0x2
ffffffffc0200830:	c3c50513          	addi	a0,a0,-964 # ffffffffc0202468 <commands+0x1c0>
        memory_base = mem_base;
ffffffffc0200834:	00007797          	auipc	a5,0x7
ffffffffc0200838:	c087be23          	sd	s0,-996(a5) # ffffffffc0207450 <memory_base>
        memory_size = mem_size;
ffffffffc020083c:	00007797          	auipc	a5,0x7
ffffffffc0200840:	c167be23          	sd	s6,-996(a5) # ffffffffc0207458 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc0200844:	b3f5                	j	ffffffffc0200630 <dtb_init+0x186>

ffffffffc0200846 <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc0200846:	00007517          	auipc	a0,0x7
ffffffffc020084a:	c0a53503          	ld	a0,-1014(a0) # ffffffffc0207450 <memory_base>
ffffffffc020084e:	8082                	ret

ffffffffc0200850 <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
}
ffffffffc0200850:	00007517          	auipc	a0,0x7
ffffffffc0200854:	c0853503          	ld	a0,-1016(a0) # ffffffffc0207458 <memory_size>
ffffffffc0200858:	8082                	ret

ffffffffc020085a <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc020085a:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc020085e:	8082                	ret

ffffffffc0200860 <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc0200860:	100177f3          	csrrci	a5,sstatus,2
ffffffffc0200864:	8082                	ret

ffffffffc0200866 <idt_init>:
     */

    extern void __alltraps(void);
    /* Set sup0 scratch register to 0, indicating to exception vector
       that we are presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc0200866:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc020086a:	00000797          	auipc	a5,0x0
ffffffffc020086e:	3a278793          	addi	a5,a5,930 # ffffffffc0200c0c <__alltraps>
ffffffffc0200872:	10579073          	csrw	stvec,a5
}
ffffffffc0200876:	8082                	ret

ffffffffc0200878 <print_regs>:
    cprintf("  badvaddr 0x%08x\n", tf->badvaddr);
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs* gpr) {
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200878:	610c                	ld	a1,0(a0)
void print_regs(struct pushregs* gpr) {
ffffffffc020087a:	1141                	addi	sp,sp,-16
ffffffffc020087c:	e022                	sd	s0,0(sp)
ffffffffc020087e:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200880:	00002517          	auipc	a0,0x2
ffffffffc0200884:	c0050513          	addi	a0,a0,-1024 # ffffffffc0202480 <commands+0x1d8>
void print_regs(struct pushregs* gpr) {
ffffffffc0200888:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc020088a:	87bff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc020088e:	640c                	ld	a1,8(s0)
ffffffffc0200890:	00002517          	auipc	a0,0x2
ffffffffc0200894:	c0850513          	addi	a0,a0,-1016 # ffffffffc0202498 <commands+0x1f0>
ffffffffc0200898:	86dff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc020089c:	680c                	ld	a1,16(s0)
ffffffffc020089e:	00002517          	auipc	a0,0x2
ffffffffc02008a2:	c1250513          	addi	a0,a0,-1006 # ffffffffc02024b0 <commands+0x208>
ffffffffc02008a6:	85fff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc02008aa:	6c0c                	ld	a1,24(s0)
ffffffffc02008ac:	00002517          	auipc	a0,0x2
ffffffffc02008b0:	c1c50513          	addi	a0,a0,-996 # ffffffffc02024c8 <commands+0x220>
ffffffffc02008b4:	851ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc02008b8:	700c                	ld	a1,32(s0)
ffffffffc02008ba:	00002517          	auipc	a0,0x2
ffffffffc02008be:	c2650513          	addi	a0,a0,-986 # ffffffffc02024e0 <commands+0x238>
ffffffffc02008c2:	843ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc02008c6:	740c                	ld	a1,40(s0)
ffffffffc02008c8:	00002517          	auipc	a0,0x2
ffffffffc02008cc:	c3050513          	addi	a0,a0,-976 # ffffffffc02024f8 <commands+0x250>
ffffffffc02008d0:	835ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc02008d4:	780c                	ld	a1,48(s0)
ffffffffc02008d6:	00002517          	auipc	a0,0x2
ffffffffc02008da:	c3a50513          	addi	a0,a0,-966 # ffffffffc0202510 <commands+0x268>
ffffffffc02008de:	827ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc02008e2:	7c0c                	ld	a1,56(s0)
ffffffffc02008e4:	00002517          	auipc	a0,0x2
ffffffffc02008e8:	c4450513          	addi	a0,a0,-956 # ffffffffc0202528 <commands+0x280>
ffffffffc02008ec:	819ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc02008f0:	602c                	ld	a1,64(s0)
ffffffffc02008f2:	00002517          	auipc	a0,0x2
ffffffffc02008f6:	c4e50513          	addi	a0,a0,-946 # ffffffffc0202540 <commands+0x298>
ffffffffc02008fa:	80bff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc02008fe:	642c                	ld	a1,72(s0)
ffffffffc0200900:	00002517          	auipc	a0,0x2
ffffffffc0200904:	c5850513          	addi	a0,a0,-936 # ffffffffc0202558 <commands+0x2b0>
ffffffffc0200908:	ffcff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc020090c:	682c                	ld	a1,80(s0)
ffffffffc020090e:	00002517          	auipc	a0,0x2
ffffffffc0200912:	c6250513          	addi	a0,a0,-926 # ffffffffc0202570 <commands+0x2c8>
ffffffffc0200916:	feeff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc020091a:	6c2c                	ld	a1,88(s0)
ffffffffc020091c:	00002517          	auipc	a0,0x2
ffffffffc0200920:	c6c50513          	addi	a0,a0,-916 # ffffffffc0202588 <commands+0x2e0>
ffffffffc0200924:	fe0ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc0200928:	702c                	ld	a1,96(s0)
ffffffffc020092a:	00002517          	auipc	a0,0x2
ffffffffc020092e:	c7650513          	addi	a0,a0,-906 # ffffffffc02025a0 <commands+0x2f8>
ffffffffc0200932:	fd2ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc0200936:	742c                	ld	a1,104(s0)
ffffffffc0200938:	00002517          	auipc	a0,0x2
ffffffffc020093c:	c8050513          	addi	a0,a0,-896 # ffffffffc02025b8 <commands+0x310>
ffffffffc0200940:	fc4ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc0200944:	782c                	ld	a1,112(s0)
ffffffffc0200946:	00002517          	auipc	a0,0x2
ffffffffc020094a:	c8a50513          	addi	a0,a0,-886 # ffffffffc02025d0 <commands+0x328>
ffffffffc020094e:	fb6ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc0200952:	7c2c                	ld	a1,120(s0)
ffffffffc0200954:	00002517          	auipc	a0,0x2
ffffffffc0200958:	c9450513          	addi	a0,a0,-876 # ffffffffc02025e8 <commands+0x340>
ffffffffc020095c:	fa8ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc0200960:	604c                	ld	a1,128(s0)
ffffffffc0200962:	00002517          	auipc	a0,0x2
ffffffffc0200966:	c9e50513          	addi	a0,a0,-866 # ffffffffc0202600 <commands+0x358>
ffffffffc020096a:	f9aff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc020096e:	644c                	ld	a1,136(s0)
ffffffffc0200970:	00002517          	auipc	a0,0x2
ffffffffc0200974:	ca850513          	addi	a0,a0,-856 # ffffffffc0202618 <commands+0x370>
ffffffffc0200978:	f8cff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc020097c:	684c                	ld	a1,144(s0)
ffffffffc020097e:	00002517          	auipc	a0,0x2
ffffffffc0200982:	cb250513          	addi	a0,a0,-846 # ffffffffc0202630 <commands+0x388>
ffffffffc0200986:	f7eff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc020098a:	6c4c                	ld	a1,152(s0)
ffffffffc020098c:	00002517          	auipc	a0,0x2
ffffffffc0200990:	cbc50513          	addi	a0,a0,-836 # ffffffffc0202648 <commands+0x3a0>
ffffffffc0200994:	f70ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc0200998:	704c                	ld	a1,160(s0)
ffffffffc020099a:	00002517          	auipc	a0,0x2
ffffffffc020099e:	cc650513          	addi	a0,a0,-826 # ffffffffc0202660 <commands+0x3b8>
ffffffffc02009a2:	f62ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc02009a6:	744c                	ld	a1,168(s0)
ffffffffc02009a8:	00002517          	auipc	a0,0x2
ffffffffc02009ac:	cd050513          	addi	a0,a0,-816 # ffffffffc0202678 <commands+0x3d0>
ffffffffc02009b0:	f54ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc02009b4:	784c                	ld	a1,176(s0)
ffffffffc02009b6:	00002517          	auipc	a0,0x2
ffffffffc02009ba:	cda50513          	addi	a0,a0,-806 # ffffffffc0202690 <commands+0x3e8>
ffffffffc02009be:	f46ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc02009c2:	7c4c                	ld	a1,184(s0)
ffffffffc02009c4:	00002517          	auipc	a0,0x2
ffffffffc02009c8:	ce450513          	addi	a0,a0,-796 # ffffffffc02026a8 <commands+0x400>
ffffffffc02009cc:	f38ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc02009d0:	606c                	ld	a1,192(s0)
ffffffffc02009d2:	00002517          	auipc	a0,0x2
ffffffffc02009d6:	cee50513          	addi	a0,a0,-786 # ffffffffc02026c0 <commands+0x418>
ffffffffc02009da:	f2aff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc02009de:	646c                	ld	a1,200(s0)
ffffffffc02009e0:	00002517          	auipc	a0,0x2
ffffffffc02009e4:	cf850513          	addi	a0,a0,-776 # ffffffffc02026d8 <commands+0x430>
ffffffffc02009e8:	f1cff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc02009ec:	686c                	ld	a1,208(s0)
ffffffffc02009ee:	00002517          	auipc	a0,0x2
ffffffffc02009f2:	d0250513          	addi	a0,a0,-766 # ffffffffc02026f0 <commands+0x448>
ffffffffc02009f6:	f0eff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc02009fa:	6c6c                	ld	a1,216(s0)
ffffffffc02009fc:	00002517          	auipc	a0,0x2
ffffffffc0200a00:	d0c50513          	addi	a0,a0,-756 # ffffffffc0202708 <commands+0x460>
ffffffffc0200a04:	f00ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc0200a08:	706c                	ld	a1,224(s0)
ffffffffc0200a0a:	00002517          	auipc	a0,0x2
ffffffffc0200a0e:	d1650513          	addi	a0,a0,-746 # ffffffffc0202720 <commands+0x478>
ffffffffc0200a12:	ef2ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc0200a16:	746c                	ld	a1,232(s0)
ffffffffc0200a18:	00002517          	auipc	a0,0x2
ffffffffc0200a1c:	d2050513          	addi	a0,a0,-736 # ffffffffc0202738 <commands+0x490>
ffffffffc0200a20:	ee4ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc0200a24:	786c                	ld	a1,240(s0)
ffffffffc0200a26:	00002517          	auipc	a0,0x2
ffffffffc0200a2a:	d2a50513          	addi	a0,a0,-726 # ffffffffc0202750 <commands+0x4a8>
ffffffffc0200a2e:	ed6ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200a32:	7c6c                	ld	a1,248(s0)
}
ffffffffc0200a34:	6402                	ld	s0,0(sp)
ffffffffc0200a36:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200a38:	00002517          	auipc	a0,0x2
ffffffffc0200a3c:	d3050513          	addi	a0,a0,-720 # ffffffffc0202768 <commands+0x4c0>
}
ffffffffc0200a40:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200a42:	ec2ff06f          	j	ffffffffc0200104 <cprintf>

ffffffffc0200a46 <print_trapframe>:
void print_trapframe(struct trapframe* tf) {
ffffffffc0200a46:	1141                	addi	sp,sp,-16
ffffffffc0200a48:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200a4a:	85aa                	mv	a1,a0
void print_trapframe(struct trapframe* tf) {
ffffffffc0200a4c:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc0200a4e:	00002517          	auipc	a0,0x2
ffffffffc0200a52:	d3250513          	addi	a0,a0,-718 # ffffffffc0202780 <commands+0x4d8>
void print_trapframe(struct trapframe* tf) {
ffffffffc0200a56:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200a58:	eacff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200a5c:	8522                	mv	a0,s0
ffffffffc0200a5e:	e1bff0ef          	jal	ra,ffffffffc0200878 <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc0200a62:	10043583          	ld	a1,256(s0)
ffffffffc0200a66:	00002517          	auipc	a0,0x2
ffffffffc0200a6a:	d3250513          	addi	a0,a0,-718 # ffffffffc0202798 <commands+0x4f0>
ffffffffc0200a6e:	e96ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc0200a72:	10843583          	ld	a1,264(s0)
ffffffffc0200a76:	00002517          	auipc	a0,0x2
ffffffffc0200a7a:	d3a50513          	addi	a0,a0,-710 # ffffffffc02027b0 <commands+0x508>
ffffffffc0200a7e:	e86ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  badvaddr 0x%08x\n", tf->badvaddr);
ffffffffc0200a82:	11043583          	ld	a1,272(s0)
ffffffffc0200a86:	00002517          	auipc	a0,0x2
ffffffffc0200a8a:	d4250513          	addi	a0,a0,-702 # ffffffffc02027c8 <commands+0x520>
ffffffffc0200a8e:	e76ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200a92:	11843583          	ld	a1,280(s0)
}
ffffffffc0200a96:	6402                	ld	s0,0(sp)
ffffffffc0200a98:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200a9a:	00002517          	auipc	a0,0x2
ffffffffc0200a9e:	d4650513          	addi	a0,a0,-698 # ffffffffc02027e0 <commands+0x538>
}
ffffffffc0200aa2:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200aa4:	e60ff06f          	j	ffffffffc0200104 <cprintf>

ffffffffc0200aa8 <interrupt_handler>:

void interrupt_handler(struct trapframe* tf) {
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc0200aa8:	11853783          	ld	a5,280(a0)
ffffffffc0200aac:	472d                	li	a4,11
ffffffffc0200aae:	0786                	slli	a5,a5,0x1
ffffffffc0200ab0:	8385                	srli	a5,a5,0x1
ffffffffc0200ab2:	08f76963          	bltu	a4,a5,ffffffffc0200b44 <interrupt_handler+0x9c>
ffffffffc0200ab6:	00002717          	auipc	a4,0x2
ffffffffc0200aba:	e0a70713          	addi	a4,a4,-502 # ffffffffc02028c0 <commands+0x618>
ffffffffc0200abe:	078a                	slli	a5,a5,0x2
ffffffffc0200ac0:	97ba                	add	a5,a5,a4
ffffffffc0200ac2:	439c                	lw	a5,0(a5)
ffffffffc0200ac4:	97ba                	add	a5,a5,a4
ffffffffc0200ac6:	8782                	jr	a5
        break;
    case IRQ_H_SOFT:
        cprintf("Hypervisor software interrupt\n");
        break;
    case IRQ_M_SOFT:
        cprintf("Machine software interrupt\n");
ffffffffc0200ac8:	00002517          	auipc	a0,0x2
ffffffffc0200acc:	d9050513          	addi	a0,a0,-624 # ffffffffc0202858 <commands+0x5b0>
ffffffffc0200ad0:	e34ff06f          	j	ffffffffc0200104 <cprintf>
        cprintf("Hypervisor software interrupt\n");
ffffffffc0200ad4:	00002517          	auipc	a0,0x2
ffffffffc0200ad8:	d6450513          	addi	a0,a0,-668 # ffffffffc0202838 <commands+0x590>
ffffffffc0200adc:	e28ff06f          	j	ffffffffc0200104 <cprintf>
        cprintf("User software interrupt\n");
ffffffffc0200ae0:	00002517          	auipc	a0,0x2
ffffffffc0200ae4:	d1850513          	addi	a0,a0,-744 # ffffffffc02027f8 <commands+0x550>
ffffffffc0200ae8:	e1cff06f          	j	ffffffffc0200104 <cprintf>
        break;
    case IRQ_U_TIMER:
        cprintf("User Timer interrupt\n");
ffffffffc0200aec:	00002517          	auipc	a0,0x2
ffffffffc0200af0:	d8c50513          	addi	a0,a0,-628 # ffffffffc0202878 <commands+0x5d0>
ffffffffc0200af4:	e10ff06f          	j	ffffffffc0200104 <cprintf>
void interrupt_handler(struct trapframe* tf) {
ffffffffc0200af8:	1141                	addi	sp,sp,-16
ffffffffc0200afa:	e406                	sd	ra,8(sp)
        /*(1)设置下次时钟中断- clock_set_next_event()
         *(2)计数器（ticks）加一
         *(3)当计数器加到100的时候，我们会输出一个`100ticks`表示我们触发了100次时钟中断，同时打印次数（num）加一
        * (4)判断打印次数，当打印次数为10时，调用<sbi.h>中的关机函数关机
        */
        clock_set_next_event(); // 安排下一次时钟中断
ffffffffc0200afc:	991ff0ef          	jal	ra,ffffffffc020048c <clock_set_next_event>
        ticks++; // 每次中断，计数+1
ffffffffc0200b00:	00007797          	auipc	a5,0x7
ffffffffc0200b04:	94878793          	addi	a5,a5,-1720 # ffffffffc0207448 <ticks>
ffffffffc0200b08:	6398                	ld	a4,0(a5)
        if (ticks >= TICK_NUM) { // TICK_NUM是宏定义的100
ffffffffc0200b0a:	06300693          	li	a3,99
        ticks++; // 每次中断，计数+1
ffffffffc0200b0e:	0705                	addi	a4,a4,1
ffffffffc0200b10:	e398                	sd	a4,0(a5)
        if (ticks >= TICK_NUM) { // TICK_NUM是宏定义的100
ffffffffc0200b12:	639c                	ld	a5,0(a5)
ffffffffc0200b14:	02f6e963          	bltu	a3,a5,ffffffffc0200b46 <interrupt_handler+0x9e>
            print_ticks();       // 打印"100 ticks"
            ticks = 0;           // 重置计数，重新开始
            print_count++;       // 打印次数+1
        }
        if (print_count >= 10) {
ffffffffc0200b18:	00007717          	auipc	a4,0x7
ffffffffc0200b1c:	94872703          	lw	a4,-1720(a4) # ffffffffc0207460 <print_count>
ffffffffc0200b20:	47a5                	li	a5,9
ffffffffc0200b22:	04e7c763          	blt	a5,a4,ffffffffc0200b70 <interrupt_handler+0xc8>
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200b26:	60a2                	ld	ra,8(sp)
ffffffffc0200b28:	0141                	addi	sp,sp,16
ffffffffc0200b2a:	8082                	ret
        cprintf("Supervisor external interrupt\n");
ffffffffc0200b2c:	00002517          	auipc	a0,0x2
ffffffffc0200b30:	d7450513          	addi	a0,a0,-652 # ffffffffc02028a0 <commands+0x5f8>
ffffffffc0200b34:	dd0ff06f          	j	ffffffffc0200104 <cprintf>
        cprintf("Supervisor software interrupt\n");
ffffffffc0200b38:	00002517          	auipc	a0,0x2
ffffffffc0200b3c:	ce050513          	addi	a0,a0,-800 # ffffffffc0202818 <commands+0x570>
ffffffffc0200b40:	dc4ff06f          	j	ffffffffc0200104 <cprintf>
        print_trapframe(tf);
ffffffffc0200b44:	b709                	j	ffffffffc0200a46 <print_trapframe>
    cprintf("%d ticks\n", TICK_NUM);
ffffffffc0200b46:	06400593          	li	a1,100
ffffffffc0200b4a:	00002517          	auipc	a0,0x2
ffffffffc0200b4e:	d4650513          	addi	a0,a0,-698 # ffffffffc0202890 <commands+0x5e8>
ffffffffc0200b52:	db2ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
            print_count++;       // 打印次数+1
ffffffffc0200b56:	00007697          	auipc	a3,0x7
ffffffffc0200b5a:	90a68693          	addi	a3,a3,-1782 # ffffffffc0207460 <print_count>
ffffffffc0200b5e:	429c                	lw	a5,0(a3)
            ticks = 0;           // 重置计数，重新开始
ffffffffc0200b60:	00007717          	auipc	a4,0x7
ffffffffc0200b64:	8e073423          	sd	zero,-1816(a4) # ffffffffc0207448 <ticks>
            print_count++;       // 打印次数+1
ffffffffc0200b68:	0017871b          	addiw	a4,a5,1
ffffffffc0200b6c:	c298                	sw	a4,0(a3)
ffffffffc0200b6e:	bf4d                	j	ffffffffc0200b20 <interrupt_handler+0x78>
}
ffffffffc0200b70:	60a2                	ld	ra,8(sp)
ffffffffc0200b72:	0141                	addi	sp,sp,16
            sbi_shutdown(); // 打印10行后关机
ffffffffc0200b74:	3b00106f          	j	ffffffffc0201f24 <sbi_shutdown>

ffffffffc0200b78 <exception_handler>:

void exception_handler(struct trapframe* tf) {
    switch (tf->cause) {
ffffffffc0200b78:	11853783          	ld	a5,280(a0)
void exception_handler(struct trapframe* tf) {
ffffffffc0200b7c:	1141                	addi	sp,sp,-16
ffffffffc0200b7e:	e022                	sd	s0,0(sp)
ffffffffc0200b80:	e406                	sd	ra,8(sp)
    switch (tf->cause) {
ffffffffc0200b82:	470d                	li	a4,3
void exception_handler(struct trapframe* tf) {
ffffffffc0200b84:	842a                	mv	s0,a0
    switch (tf->cause) {
ffffffffc0200b86:	04e78663          	beq	a5,a4,ffffffffc0200bd2 <exception_handler+0x5a>
ffffffffc0200b8a:	02f76c63          	bltu	a4,a5,ffffffffc0200bc2 <exception_handler+0x4a>
ffffffffc0200b8e:	4709                	li	a4,2
ffffffffc0200b90:	02e79563          	bne	a5,a4,ffffffffc0200bba <exception_handler+0x42>
       /*(1)输出指令异常类型（ Illegal instruction）
        *(2)输出异常指令地址
        *(3)更新 tf->epc寄存器
       */
       // (1) 输出异常类型
        cprintf("Exception type: Illegal instruction\n");
ffffffffc0200b94:	00002517          	auipc	a0,0x2
ffffffffc0200b98:	d5c50513          	addi	a0,a0,-676 # ffffffffc02028f0 <commands+0x648>
ffffffffc0200b9c:	d68ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
        // (2) 输出异常指令地址
        cprintf("Illegal instruction caught at 0x%08x\n", tf->epc);
ffffffffc0200ba0:	10843583          	ld	a1,264(s0)
ffffffffc0200ba4:	00002517          	auipc	a0,0x2
ffffffffc0200ba8:	d7450513          	addi	a0,a0,-652 # ffffffffc0202918 <commands+0x670>
ffffffffc0200bac:	d58ff0ef          	jal	ra,ffffffffc0200104 <cprintf>
        // (3) 更新epc，跳过当前非法指令
        tf->epc += 4;
ffffffffc0200bb0:	10843783          	ld	a5,264(s0)
ffffffffc0200bb4:	0791                	addi	a5,a5,4
ffffffffc0200bb6:	10f43423          	sd	a5,264(s0)
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200bba:	60a2                	ld	ra,8(sp)
ffffffffc0200bbc:	6402                	ld	s0,0(sp)
ffffffffc0200bbe:	0141                	addi	sp,sp,16
ffffffffc0200bc0:	8082                	ret
    switch (tf->cause) {
ffffffffc0200bc2:	17f1                	addi	a5,a5,-4
ffffffffc0200bc4:	471d                	li	a4,7
ffffffffc0200bc6:	fef77ae3          	bgeu	a4,a5,ffffffffc0200bba <exception_handler+0x42>
}
ffffffffc0200bca:	6402                	ld	s0,0(sp)
ffffffffc0200bcc:	60a2                	ld	ra,8(sp)
ffffffffc0200bce:	0141                	addi	sp,sp,16
        print_trapframe(tf);
ffffffffc0200bd0:	bd9d                	j	ffffffffc0200a46 <print_trapframe>
        cprintf("Exception type: breakpoint\n");
ffffffffc0200bd2:	00002517          	auipc	a0,0x2
ffffffffc0200bd6:	d6e50513          	addi	a0,a0,-658 # ffffffffc0202940 <commands+0x698>
ffffffffc0200bda:	d2aff0ef          	jal	ra,ffffffffc0200104 <cprintf>
        cprintf("ebreak caught at 0x%08x\n", tf->epc);
ffffffffc0200bde:	10843583          	ld	a1,264(s0)
ffffffffc0200be2:	00002517          	auipc	a0,0x2
ffffffffc0200be6:	d7e50513          	addi	a0,a0,-642 # ffffffffc0202960 <commands+0x6b8>
ffffffffc0200bea:	d1aff0ef          	jal	ra,ffffffffc0200104 <cprintf>
        tf->epc += 2;
ffffffffc0200bee:	10843783          	ld	a5,264(s0)
}
ffffffffc0200bf2:	60a2                	ld	ra,8(sp)
        tf->epc += 2;
ffffffffc0200bf4:	0789                	addi	a5,a5,2
ffffffffc0200bf6:	10f43423          	sd	a5,264(s0)
}
ffffffffc0200bfa:	6402                	ld	s0,0(sp)
ffffffffc0200bfc:	0141                	addi	sp,sp,16
ffffffffc0200bfe:	8082                	ret

ffffffffc0200c00 <trap>:

static inline void trap_dispatch(struct trapframe* tf) {
    if ((intptr_t)tf->cause < 0) {
ffffffffc0200c00:	11853783          	ld	a5,280(a0)
ffffffffc0200c04:	0007c363          	bltz	a5,ffffffffc0200c0a <trap+0xa>
        // interrupts
        interrupt_handler(tf);
    }
    else {
        // exceptions
        exception_handler(tf);
ffffffffc0200c08:	bf85                	j	ffffffffc0200b78 <exception_handler>
        interrupt_handler(tf);
ffffffffc0200c0a:	bd79                	j	ffffffffc0200aa8 <interrupt_handler>

ffffffffc0200c0c <__alltraps>:
    .endm

    .globl __alltraps
    .align(2)
__alltraps:
    SAVE_ALL
ffffffffc0200c0c:	14011073          	csrw	sscratch,sp
ffffffffc0200c10:	712d                	addi	sp,sp,-288
ffffffffc0200c12:	e002                	sd	zero,0(sp)
ffffffffc0200c14:	e406                	sd	ra,8(sp)
ffffffffc0200c16:	ec0e                	sd	gp,24(sp)
ffffffffc0200c18:	f012                	sd	tp,32(sp)
ffffffffc0200c1a:	f416                	sd	t0,40(sp)
ffffffffc0200c1c:	f81a                	sd	t1,48(sp)
ffffffffc0200c1e:	fc1e                	sd	t2,56(sp)
ffffffffc0200c20:	e0a2                	sd	s0,64(sp)
ffffffffc0200c22:	e4a6                	sd	s1,72(sp)
ffffffffc0200c24:	e8aa                	sd	a0,80(sp)
ffffffffc0200c26:	ecae                	sd	a1,88(sp)
ffffffffc0200c28:	f0b2                	sd	a2,96(sp)
ffffffffc0200c2a:	f4b6                	sd	a3,104(sp)
ffffffffc0200c2c:	f8ba                	sd	a4,112(sp)
ffffffffc0200c2e:	fcbe                	sd	a5,120(sp)
ffffffffc0200c30:	e142                	sd	a6,128(sp)
ffffffffc0200c32:	e546                	sd	a7,136(sp)
ffffffffc0200c34:	e94a                	sd	s2,144(sp)
ffffffffc0200c36:	ed4e                	sd	s3,152(sp)
ffffffffc0200c38:	f152                	sd	s4,160(sp)
ffffffffc0200c3a:	f556                	sd	s5,168(sp)
ffffffffc0200c3c:	f95a                	sd	s6,176(sp)
ffffffffc0200c3e:	fd5e                	sd	s7,184(sp)
ffffffffc0200c40:	e1e2                	sd	s8,192(sp)
ffffffffc0200c42:	e5e6                	sd	s9,200(sp)
ffffffffc0200c44:	e9ea                	sd	s10,208(sp)
ffffffffc0200c46:	edee                	sd	s11,216(sp)
ffffffffc0200c48:	f1f2                	sd	t3,224(sp)
ffffffffc0200c4a:	f5f6                	sd	t4,232(sp)
ffffffffc0200c4c:	f9fa                	sd	t5,240(sp)
ffffffffc0200c4e:	fdfe                	sd	t6,248(sp)
ffffffffc0200c50:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200c54:	100024f3          	csrr	s1,sstatus
ffffffffc0200c58:	14102973          	csrr	s2,sepc
ffffffffc0200c5c:	143029f3          	csrr	s3,stval
ffffffffc0200c60:	14202a73          	csrr	s4,scause
ffffffffc0200c64:	e822                	sd	s0,16(sp)
ffffffffc0200c66:	e226                	sd	s1,256(sp)
ffffffffc0200c68:	e64a                	sd	s2,264(sp)
ffffffffc0200c6a:	ea4e                	sd	s3,272(sp)
ffffffffc0200c6c:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200c6e:	850a                	mv	a0,sp
    jal trap
ffffffffc0200c70:	f91ff0ef          	jal	ra,ffffffffc0200c00 <trap>

ffffffffc0200c74 <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200c74:	6492                	ld	s1,256(sp)
ffffffffc0200c76:	6932                	ld	s2,264(sp)
ffffffffc0200c78:	10049073          	csrw	sstatus,s1
ffffffffc0200c7c:	14191073          	csrw	sepc,s2
ffffffffc0200c80:	60a2                	ld	ra,8(sp)
ffffffffc0200c82:	61e2                	ld	gp,24(sp)
ffffffffc0200c84:	7202                	ld	tp,32(sp)
ffffffffc0200c86:	72a2                	ld	t0,40(sp)
ffffffffc0200c88:	7342                	ld	t1,48(sp)
ffffffffc0200c8a:	73e2                	ld	t2,56(sp)
ffffffffc0200c8c:	6406                	ld	s0,64(sp)
ffffffffc0200c8e:	64a6                	ld	s1,72(sp)
ffffffffc0200c90:	6546                	ld	a0,80(sp)
ffffffffc0200c92:	65e6                	ld	a1,88(sp)
ffffffffc0200c94:	7606                	ld	a2,96(sp)
ffffffffc0200c96:	76a6                	ld	a3,104(sp)
ffffffffc0200c98:	7746                	ld	a4,112(sp)
ffffffffc0200c9a:	77e6                	ld	a5,120(sp)
ffffffffc0200c9c:	680a                	ld	a6,128(sp)
ffffffffc0200c9e:	68aa                	ld	a7,136(sp)
ffffffffc0200ca0:	694a                	ld	s2,144(sp)
ffffffffc0200ca2:	69ea                	ld	s3,152(sp)
ffffffffc0200ca4:	7a0a                	ld	s4,160(sp)
ffffffffc0200ca6:	7aaa                	ld	s5,168(sp)
ffffffffc0200ca8:	7b4a                	ld	s6,176(sp)
ffffffffc0200caa:	7bea                	ld	s7,184(sp)
ffffffffc0200cac:	6c0e                	ld	s8,192(sp)
ffffffffc0200cae:	6cae                	ld	s9,200(sp)
ffffffffc0200cb0:	6d4e                	ld	s10,208(sp)
ffffffffc0200cb2:	6dee                	ld	s11,216(sp)
ffffffffc0200cb4:	7e0e                	ld	t3,224(sp)
ffffffffc0200cb6:	7eae                	ld	t4,232(sp)
ffffffffc0200cb8:	7f4e                	ld	t5,240(sp)
ffffffffc0200cba:	7fee                	ld	t6,248(sp)
ffffffffc0200cbc:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200cbe:	10200073          	sret

ffffffffc0200cc2 <default_init>:
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc0200cc2:	00006797          	auipc	a5,0x6
ffffffffc0200cc6:	36678793          	addi	a5,a5,870 # ffffffffc0207028 <free_area>
ffffffffc0200cca:	e79c                	sd	a5,8(a5)
ffffffffc0200ccc:	e39c                	sd	a5,0(a5)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
    list_init(&free_list);
    nr_free = 0;
ffffffffc0200cce:	0007a823          	sw	zero,16(a5)
}
ffffffffc0200cd2:	8082                	ret

ffffffffc0200cd4 <default_nr_free_pages>:
}

static size_t
default_nr_free_pages(void) {
    return nr_free;
}
ffffffffc0200cd4:	00006517          	auipc	a0,0x6
ffffffffc0200cd8:	36456503          	lwu	a0,868(a0) # ffffffffc0207038 <free_area+0x10>
ffffffffc0200cdc:	8082                	ret

ffffffffc0200cde <default_check>:
}

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
ffffffffc0200cde:	715d                	addi	sp,sp,-80
ffffffffc0200ce0:	e0a2                	sd	s0,64(sp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0200ce2:	00006417          	auipc	s0,0x6
ffffffffc0200ce6:	34640413          	addi	s0,s0,838 # ffffffffc0207028 <free_area>
ffffffffc0200cea:	641c                	ld	a5,8(s0)
ffffffffc0200cec:	e486                	sd	ra,72(sp)
ffffffffc0200cee:	fc26                	sd	s1,56(sp)
ffffffffc0200cf0:	f84a                	sd	s2,48(sp)
ffffffffc0200cf2:	f44e                	sd	s3,40(sp)
ffffffffc0200cf4:	f052                	sd	s4,32(sp)
ffffffffc0200cf6:	ec56                	sd	s5,24(sp)
ffffffffc0200cf8:	e85a                	sd	s6,16(sp)
ffffffffc0200cfa:	e45e                	sd	s7,8(sp)
ffffffffc0200cfc:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200cfe:	2c878763          	beq	a5,s0,ffffffffc0200fcc <default_check+0x2ee>
    int count = 0, total = 0;
ffffffffc0200d02:	4481                	li	s1,0
ffffffffc0200d04:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0200d06:	ff07b703          	ld	a4,-16(a5)
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc0200d0a:	8b09                	andi	a4,a4,2
ffffffffc0200d0c:	2c070463          	beqz	a4,ffffffffc0200fd4 <default_check+0x2f6>
        count ++, total += p->property;
ffffffffc0200d10:	ff87a703          	lw	a4,-8(a5)
ffffffffc0200d14:	679c                	ld	a5,8(a5)
ffffffffc0200d16:	2905                	addiw	s2,s2,1
ffffffffc0200d18:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200d1a:	fe8796e3          	bne	a5,s0,ffffffffc0200d06 <default_check+0x28>
    }
    assert(total == nr_free_pages());
ffffffffc0200d1e:	89a6                	mv	s3,s1
ffffffffc0200d20:	2f9000ef          	jal	ra,ffffffffc0201818 <nr_free_pages>
ffffffffc0200d24:	71351863          	bne	a0,s3,ffffffffc0201434 <default_check+0x756>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0200d28:	4505                	li	a0,1
ffffffffc0200d2a:	271000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200d2e:	8a2a                	mv	s4,a0
ffffffffc0200d30:	44050263          	beqz	a0,ffffffffc0201174 <default_check+0x496>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0200d34:	4505                	li	a0,1
ffffffffc0200d36:	265000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200d3a:	89aa                	mv	s3,a0
ffffffffc0200d3c:	70050c63          	beqz	a0,ffffffffc0201454 <default_check+0x776>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0200d40:	4505                	li	a0,1
ffffffffc0200d42:	259000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200d46:	8aaa                	mv	s5,a0
ffffffffc0200d48:	4a050663          	beqz	a0,ffffffffc02011f4 <default_check+0x516>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0200d4c:	2b3a0463          	beq	s4,s3,ffffffffc0200ff4 <default_check+0x316>
ffffffffc0200d50:	2aaa0263          	beq	s4,a0,ffffffffc0200ff4 <default_check+0x316>
ffffffffc0200d54:	2aa98063          	beq	s3,a0,ffffffffc0200ff4 <default_check+0x316>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0200d58:	000a2783          	lw	a5,0(s4)
ffffffffc0200d5c:	2a079c63          	bnez	a5,ffffffffc0201014 <default_check+0x336>
ffffffffc0200d60:	0009a783          	lw	a5,0(s3)
ffffffffc0200d64:	2a079863          	bnez	a5,ffffffffc0201014 <default_check+0x336>
ffffffffc0200d68:	411c                	lw	a5,0(a0)
ffffffffc0200d6a:	2a079563          	bnez	a5,ffffffffc0201014 <default_check+0x336>
extern struct Page *pages;
extern size_t npage;
extern const size_t nbase;
extern uint64_t va_pa_offset;

static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200d6e:	00006797          	auipc	a5,0x6
ffffffffc0200d72:	7027b783          	ld	a5,1794(a5) # ffffffffc0207470 <pages>
ffffffffc0200d76:	40fa0733          	sub	a4,s4,a5
ffffffffc0200d7a:	870d                	srai	a4,a4,0x3
ffffffffc0200d7c:	00002597          	auipc	a1,0x2
ffffffffc0200d80:	38c5b583          	ld	a1,908(a1) # ffffffffc0203108 <error_string+0x38>
ffffffffc0200d84:	02b70733          	mul	a4,a4,a1
ffffffffc0200d88:	00002617          	auipc	a2,0x2
ffffffffc0200d8c:	38863603          	ld	a2,904(a2) # ffffffffc0203110 <nbase>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0200d90:	00006697          	auipc	a3,0x6
ffffffffc0200d94:	6d86b683          	ld	a3,1752(a3) # ffffffffc0207468 <npage>
ffffffffc0200d98:	06b2                	slli	a3,a3,0xc
ffffffffc0200d9a:	9732                	add	a4,a4,a2

static inline uintptr_t page2pa(struct Page *page) {
    return page2ppn(page) << PGSHIFT;
ffffffffc0200d9c:	0732                	slli	a4,a4,0xc
ffffffffc0200d9e:	28d77b63          	bgeu	a4,a3,ffffffffc0201034 <default_check+0x356>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200da2:	40f98733          	sub	a4,s3,a5
ffffffffc0200da6:	870d                	srai	a4,a4,0x3
ffffffffc0200da8:	02b70733          	mul	a4,a4,a1
ffffffffc0200dac:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200dae:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0200db0:	4cd77263          	bgeu	a4,a3,ffffffffc0201274 <default_check+0x596>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200db4:	40f507b3          	sub	a5,a0,a5
ffffffffc0200db8:	878d                	srai	a5,a5,0x3
ffffffffc0200dba:	02b787b3          	mul	a5,a5,a1
ffffffffc0200dbe:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200dc0:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0200dc2:	30d7f963          	bgeu	a5,a3,ffffffffc02010d4 <default_check+0x3f6>
    assert(alloc_page() == NULL);
ffffffffc0200dc6:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0200dc8:	00043c03          	ld	s8,0(s0)
ffffffffc0200dcc:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc0200dd0:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc0200dd4:	e400                	sd	s0,8(s0)
ffffffffc0200dd6:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc0200dd8:	00006797          	auipc	a5,0x6
ffffffffc0200ddc:	2607a023          	sw	zero,608(a5) # ffffffffc0207038 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc0200de0:	1bb000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200de4:	2c051863          	bnez	a0,ffffffffc02010b4 <default_check+0x3d6>
    free_page(p0);
ffffffffc0200de8:	4585                	li	a1,1
ffffffffc0200dea:	8552                	mv	a0,s4
ffffffffc0200dec:	1ed000ef          	jal	ra,ffffffffc02017d8 <free_pages>
    free_page(p1);
ffffffffc0200df0:	4585                	li	a1,1
ffffffffc0200df2:	854e                	mv	a0,s3
ffffffffc0200df4:	1e5000ef          	jal	ra,ffffffffc02017d8 <free_pages>
    free_page(p2);
ffffffffc0200df8:	4585                	li	a1,1
ffffffffc0200dfa:	8556                	mv	a0,s5
ffffffffc0200dfc:	1dd000ef          	jal	ra,ffffffffc02017d8 <free_pages>
    assert(nr_free == 3);
ffffffffc0200e00:	4818                	lw	a4,16(s0)
ffffffffc0200e02:	478d                	li	a5,3
ffffffffc0200e04:	28f71863          	bne	a4,a5,ffffffffc0201094 <default_check+0x3b6>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0200e08:	4505                	li	a0,1
ffffffffc0200e0a:	191000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200e0e:	89aa                	mv	s3,a0
ffffffffc0200e10:	26050263          	beqz	a0,ffffffffc0201074 <default_check+0x396>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0200e14:	4505                	li	a0,1
ffffffffc0200e16:	185000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200e1a:	8aaa                	mv	s5,a0
ffffffffc0200e1c:	3a050c63          	beqz	a0,ffffffffc02011d4 <default_check+0x4f6>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0200e20:	4505                	li	a0,1
ffffffffc0200e22:	179000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200e26:	8a2a                	mv	s4,a0
ffffffffc0200e28:	38050663          	beqz	a0,ffffffffc02011b4 <default_check+0x4d6>
    assert(alloc_page() == NULL);
ffffffffc0200e2c:	4505                	li	a0,1
ffffffffc0200e2e:	16d000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200e32:	36051163          	bnez	a0,ffffffffc0201194 <default_check+0x4b6>
    free_page(p0);
ffffffffc0200e36:	4585                	li	a1,1
ffffffffc0200e38:	854e                	mv	a0,s3
ffffffffc0200e3a:	19f000ef          	jal	ra,ffffffffc02017d8 <free_pages>
    assert(!list_empty(&free_list));
ffffffffc0200e3e:	641c                	ld	a5,8(s0)
ffffffffc0200e40:	20878a63          	beq	a5,s0,ffffffffc0201054 <default_check+0x376>
    assert((p = alloc_page()) == p0);
ffffffffc0200e44:	4505                	li	a0,1
ffffffffc0200e46:	155000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200e4a:	30a99563          	bne	s3,a0,ffffffffc0201154 <default_check+0x476>
    assert(alloc_page() == NULL);
ffffffffc0200e4e:	4505                	li	a0,1
ffffffffc0200e50:	14b000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200e54:	2e051063          	bnez	a0,ffffffffc0201134 <default_check+0x456>
    assert(nr_free == 0);
ffffffffc0200e58:	481c                	lw	a5,16(s0)
ffffffffc0200e5a:	2a079d63          	bnez	a5,ffffffffc0201114 <default_check+0x436>
    free_page(p);
ffffffffc0200e5e:	854e                	mv	a0,s3
ffffffffc0200e60:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc0200e62:	01843023          	sd	s8,0(s0)
ffffffffc0200e66:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc0200e6a:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc0200e6e:	16b000ef          	jal	ra,ffffffffc02017d8 <free_pages>
    free_page(p1);
ffffffffc0200e72:	4585                	li	a1,1
ffffffffc0200e74:	8556                	mv	a0,s5
ffffffffc0200e76:	163000ef          	jal	ra,ffffffffc02017d8 <free_pages>
    free_page(p2);
ffffffffc0200e7a:	4585                	li	a1,1
ffffffffc0200e7c:	8552                	mv	a0,s4
ffffffffc0200e7e:	15b000ef          	jal	ra,ffffffffc02017d8 <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc0200e82:	4515                	li	a0,5
ffffffffc0200e84:	117000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200e88:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc0200e8a:	26050563          	beqz	a0,ffffffffc02010f4 <default_check+0x416>
ffffffffc0200e8e:	651c                	ld	a5,8(a0)
ffffffffc0200e90:	8385                	srli	a5,a5,0x1
    assert(!PageProperty(p0));
ffffffffc0200e92:	8b85                	andi	a5,a5,1
ffffffffc0200e94:	54079063          	bnez	a5,ffffffffc02013d4 <default_check+0x6f6>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc0200e98:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0200e9a:	00043b03          	ld	s6,0(s0)
ffffffffc0200e9e:	00843a83          	ld	s5,8(s0)
ffffffffc0200ea2:	e000                	sd	s0,0(s0)
ffffffffc0200ea4:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc0200ea6:	0f5000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200eaa:	50051563          	bnez	a0,ffffffffc02013b4 <default_check+0x6d6>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc0200eae:	05098a13          	addi	s4,s3,80
ffffffffc0200eb2:	8552                	mv	a0,s4
ffffffffc0200eb4:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc0200eb6:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc0200eba:	00006797          	auipc	a5,0x6
ffffffffc0200ebe:	1607af23          	sw	zero,382(a5) # ffffffffc0207038 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc0200ec2:	117000ef          	jal	ra,ffffffffc02017d8 <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc0200ec6:	4511                	li	a0,4
ffffffffc0200ec8:	0d3000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200ecc:	4c051463          	bnez	a0,ffffffffc0201394 <default_check+0x6b6>
ffffffffc0200ed0:	0589b783          	ld	a5,88(s3)
ffffffffc0200ed4:	8385                	srli	a5,a5,0x1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0200ed6:	8b85                	andi	a5,a5,1
ffffffffc0200ed8:	48078e63          	beqz	a5,ffffffffc0201374 <default_check+0x696>
ffffffffc0200edc:	0609a703          	lw	a4,96(s3)
ffffffffc0200ee0:	478d                	li	a5,3
ffffffffc0200ee2:	48f71963          	bne	a4,a5,ffffffffc0201374 <default_check+0x696>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0200ee6:	450d                	li	a0,3
ffffffffc0200ee8:	0b3000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200eec:	8c2a                	mv	s8,a0
ffffffffc0200eee:	46050363          	beqz	a0,ffffffffc0201354 <default_check+0x676>
    assert(alloc_page() == NULL);
ffffffffc0200ef2:	4505                	li	a0,1
ffffffffc0200ef4:	0a7000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200ef8:	42051e63          	bnez	a0,ffffffffc0201334 <default_check+0x656>
    assert(p0 + 2 == p1);
ffffffffc0200efc:	418a1c63          	bne	s4,s8,ffffffffc0201314 <default_check+0x636>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc0200f00:	4585                	li	a1,1
ffffffffc0200f02:	854e                	mv	a0,s3
ffffffffc0200f04:	0d5000ef          	jal	ra,ffffffffc02017d8 <free_pages>
    free_pages(p1, 3);
ffffffffc0200f08:	458d                	li	a1,3
ffffffffc0200f0a:	8552                	mv	a0,s4
ffffffffc0200f0c:	0cd000ef          	jal	ra,ffffffffc02017d8 <free_pages>
ffffffffc0200f10:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc0200f14:	02898c13          	addi	s8,s3,40
ffffffffc0200f18:	8385                	srli	a5,a5,0x1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0200f1a:	8b85                	andi	a5,a5,1
ffffffffc0200f1c:	3c078c63          	beqz	a5,ffffffffc02012f4 <default_check+0x616>
ffffffffc0200f20:	0109a703          	lw	a4,16(s3)
ffffffffc0200f24:	4785                	li	a5,1
ffffffffc0200f26:	3cf71763          	bne	a4,a5,ffffffffc02012f4 <default_check+0x616>
ffffffffc0200f2a:	008a3783          	ld	a5,8(s4)
ffffffffc0200f2e:	8385                	srli	a5,a5,0x1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0200f30:	8b85                	andi	a5,a5,1
ffffffffc0200f32:	3a078163          	beqz	a5,ffffffffc02012d4 <default_check+0x5f6>
ffffffffc0200f36:	010a2703          	lw	a4,16(s4)
ffffffffc0200f3a:	478d                	li	a5,3
ffffffffc0200f3c:	38f71c63          	bne	a4,a5,ffffffffc02012d4 <default_check+0x5f6>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0200f40:	4505                	li	a0,1
ffffffffc0200f42:	059000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200f46:	36a99763          	bne	s3,a0,ffffffffc02012b4 <default_check+0x5d6>
    free_page(p0);
ffffffffc0200f4a:	4585                	li	a1,1
ffffffffc0200f4c:	08d000ef          	jal	ra,ffffffffc02017d8 <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0200f50:	4509                	li	a0,2
ffffffffc0200f52:	049000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200f56:	32aa1f63          	bne	s4,a0,ffffffffc0201294 <default_check+0x5b6>

    free_pages(p0, 2);
ffffffffc0200f5a:	4589                	li	a1,2
ffffffffc0200f5c:	07d000ef          	jal	ra,ffffffffc02017d8 <free_pages>
    free_page(p2);
ffffffffc0200f60:	4585                	li	a1,1
ffffffffc0200f62:	8562                	mv	a0,s8
ffffffffc0200f64:	075000ef          	jal	ra,ffffffffc02017d8 <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0200f68:	4515                	li	a0,5
ffffffffc0200f6a:	031000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200f6e:	89aa                	mv	s3,a0
ffffffffc0200f70:	48050263          	beqz	a0,ffffffffc02013f4 <default_check+0x716>
    assert(alloc_page() == NULL);
ffffffffc0200f74:	4505                	li	a0,1
ffffffffc0200f76:	025000ef          	jal	ra,ffffffffc020179a <alloc_pages>
ffffffffc0200f7a:	2c051d63          	bnez	a0,ffffffffc0201254 <default_check+0x576>

    assert(nr_free == 0);
ffffffffc0200f7e:	481c                	lw	a5,16(s0)
ffffffffc0200f80:	2a079a63          	bnez	a5,ffffffffc0201234 <default_check+0x556>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc0200f84:	4595                	li	a1,5
ffffffffc0200f86:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc0200f88:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc0200f8c:	01643023          	sd	s6,0(s0)
ffffffffc0200f90:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc0200f94:	045000ef          	jal	ra,ffffffffc02017d8 <free_pages>
    return listelm->next;
ffffffffc0200f98:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200f9a:	00878963          	beq	a5,s0,ffffffffc0200fac <default_check+0x2ce>
        struct Page *p = le2page(le, page_link);
        count --, total -= p->property;
ffffffffc0200f9e:	ff87a703          	lw	a4,-8(a5)
ffffffffc0200fa2:	679c                	ld	a5,8(a5)
ffffffffc0200fa4:	397d                	addiw	s2,s2,-1
ffffffffc0200fa6:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200fa8:	fe879be3          	bne	a5,s0,ffffffffc0200f9e <default_check+0x2c0>
    }
    assert(count == 0);
ffffffffc0200fac:	26091463          	bnez	s2,ffffffffc0201214 <default_check+0x536>
    assert(total == 0);
ffffffffc0200fb0:	46049263          	bnez	s1,ffffffffc0201414 <default_check+0x736>
}
ffffffffc0200fb4:	60a6                	ld	ra,72(sp)
ffffffffc0200fb6:	6406                	ld	s0,64(sp)
ffffffffc0200fb8:	74e2                	ld	s1,56(sp)
ffffffffc0200fba:	7942                	ld	s2,48(sp)
ffffffffc0200fbc:	79a2                	ld	s3,40(sp)
ffffffffc0200fbe:	7a02                	ld	s4,32(sp)
ffffffffc0200fc0:	6ae2                	ld	s5,24(sp)
ffffffffc0200fc2:	6b42                	ld	s6,16(sp)
ffffffffc0200fc4:	6ba2                	ld	s7,8(sp)
ffffffffc0200fc6:	6c02                	ld	s8,0(sp)
ffffffffc0200fc8:	6161                	addi	sp,sp,80
ffffffffc0200fca:	8082                	ret
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200fcc:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc0200fce:	4481                	li	s1,0
ffffffffc0200fd0:	4901                	li	s2,0
ffffffffc0200fd2:	b3b9                	j	ffffffffc0200d20 <default_check+0x42>
        assert(PageProperty(p));
ffffffffc0200fd4:	00002697          	auipc	a3,0x2
ffffffffc0200fd8:	9ac68693          	addi	a3,a3,-1620 # ffffffffc0202980 <commands+0x6d8>
ffffffffc0200fdc:	00002617          	auipc	a2,0x2
ffffffffc0200fe0:	9b460613          	addi	a2,a2,-1612 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0200fe4:	0f000593          	li	a1,240
ffffffffc0200fe8:	00002517          	auipc	a0,0x2
ffffffffc0200fec:	9c050513          	addi	a0,a0,-1600 # ffffffffc02029a8 <commands+0x700>
ffffffffc0200ff0:	c0eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0200ff4:	00002697          	auipc	a3,0x2
ffffffffc0200ff8:	a4c68693          	addi	a3,a3,-1460 # ffffffffc0202a40 <commands+0x798>
ffffffffc0200ffc:	00002617          	auipc	a2,0x2
ffffffffc0201000:	99460613          	addi	a2,a2,-1644 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201004:	0bd00593          	li	a1,189
ffffffffc0201008:	00002517          	auipc	a0,0x2
ffffffffc020100c:	9a050513          	addi	a0,a0,-1632 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201010:	beeff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0201014:	00002697          	auipc	a3,0x2
ffffffffc0201018:	a5468693          	addi	a3,a3,-1452 # ffffffffc0202a68 <commands+0x7c0>
ffffffffc020101c:	00002617          	auipc	a2,0x2
ffffffffc0201020:	97460613          	addi	a2,a2,-1676 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201024:	0be00593          	li	a1,190
ffffffffc0201028:	00002517          	auipc	a0,0x2
ffffffffc020102c:	98050513          	addi	a0,a0,-1664 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201030:	bceff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0201034:	00002697          	auipc	a3,0x2
ffffffffc0201038:	a7468693          	addi	a3,a3,-1420 # ffffffffc0202aa8 <commands+0x800>
ffffffffc020103c:	00002617          	auipc	a2,0x2
ffffffffc0201040:	95460613          	addi	a2,a2,-1708 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201044:	0c000593          	li	a1,192
ffffffffc0201048:	00002517          	auipc	a0,0x2
ffffffffc020104c:	96050513          	addi	a0,a0,-1696 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201050:	baeff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(!list_empty(&free_list));
ffffffffc0201054:	00002697          	auipc	a3,0x2
ffffffffc0201058:	adc68693          	addi	a3,a3,-1316 # ffffffffc0202b30 <commands+0x888>
ffffffffc020105c:	00002617          	auipc	a2,0x2
ffffffffc0201060:	93460613          	addi	a2,a2,-1740 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201064:	0d900593          	li	a1,217
ffffffffc0201068:	00002517          	auipc	a0,0x2
ffffffffc020106c:	94050513          	addi	a0,a0,-1728 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201070:	b8eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201074:	00002697          	auipc	a3,0x2
ffffffffc0201078:	96c68693          	addi	a3,a3,-1684 # ffffffffc02029e0 <commands+0x738>
ffffffffc020107c:	00002617          	auipc	a2,0x2
ffffffffc0201080:	91460613          	addi	a2,a2,-1772 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201084:	0d200593          	li	a1,210
ffffffffc0201088:	00002517          	auipc	a0,0x2
ffffffffc020108c:	92050513          	addi	a0,a0,-1760 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201090:	b6eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(nr_free == 3);
ffffffffc0201094:	00002697          	auipc	a3,0x2
ffffffffc0201098:	a8c68693          	addi	a3,a3,-1396 # ffffffffc0202b20 <commands+0x878>
ffffffffc020109c:	00002617          	auipc	a2,0x2
ffffffffc02010a0:	8f460613          	addi	a2,a2,-1804 # ffffffffc0202990 <commands+0x6e8>
ffffffffc02010a4:	0d000593          	li	a1,208
ffffffffc02010a8:	00002517          	auipc	a0,0x2
ffffffffc02010ac:	90050513          	addi	a0,a0,-1792 # ffffffffc02029a8 <commands+0x700>
ffffffffc02010b0:	b4eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(alloc_page() == NULL);
ffffffffc02010b4:	00002697          	auipc	a3,0x2
ffffffffc02010b8:	a5468693          	addi	a3,a3,-1452 # ffffffffc0202b08 <commands+0x860>
ffffffffc02010bc:	00002617          	auipc	a2,0x2
ffffffffc02010c0:	8d460613          	addi	a2,a2,-1836 # ffffffffc0202990 <commands+0x6e8>
ffffffffc02010c4:	0cb00593          	li	a1,203
ffffffffc02010c8:	00002517          	auipc	a0,0x2
ffffffffc02010cc:	8e050513          	addi	a0,a0,-1824 # ffffffffc02029a8 <commands+0x700>
ffffffffc02010d0:	b2eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02010d4:	00002697          	auipc	a3,0x2
ffffffffc02010d8:	a1468693          	addi	a3,a3,-1516 # ffffffffc0202ae8 <commands+0x840>
ffffffffc02010dc:	00002617          	auipc	a2,0x2
ffffffffc02010e0:	8b460613          	addi	a2,a2,-1868 # ffffffffc0202990 <commands+0x6e8>
ffffffffc02010e4:	0c200593          	li	a1,194
ffffffffc02010e8:	00002517          	auipc	a0,0x2
ffffffffc02010ec:	8c050513          	addi	a0,a0,-1856 # ffffffffc02029a8 <commands+0x700>
ffffffffc02010f0:	b0eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(p0 != NULL);
ffffffffc02010f4:	00002697          	auipc	a3,0x2
ffffffffc02010f8:	a8468693          	addi	a3,a3,-1404 # ffffffffc0202b78 <commands+0x8d0>
ffffffffc02010fc:	00002617          	auipc	a2,0x2
ffffffffc0201100:	89460613          	addi	a2,a2,-1900 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201104:	0f800593          	li	a1,248
ffffffffc0201108:	00002517          	auipc	a0,0x2
ffffffffc020110c:	8a050513          	addi	a0,a0,-1888 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201110:	aeeff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(nr_free == 0);
ffffffffc0201114:	00002697          	auipc	a3,0x2
ffffffffc0201118:	a5468693          	addi	a3,a3,-1452 # ffffffffc0202b68 <commands+0x8c0>
ffffffffc020111c:	00002617          	auipc	a2,0x2
ffffffffc0201120:	87460613          	addi	a2,a2,-1932 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201124:	0df00593          	li	a1,223
ffffffffc0201128:	00002517          	auipc	a0,0x2
ffffffffc020112c:	88050513          	addi	a0,a0,-1920 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201130:	aceff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201134:	00002697          	auipc	a3,0x2
ffffffffc0201138:	9d468693          	addi	a3,a3,-1580 # ffffffffc0202b08 <commands+0x860>
ffffffffc020113c:	00002617          	auipc	a2,0x2
ffffffffc0201140:	85460613          	addi	a2,a2,-1964 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201144:	0dd00593          	li	a1,221
ffffffffc0201148:	00002517          	auipc	a0,0x2
ffffffffc020114c:	86050513          	addi	a0,a0,-1952 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201150:	aaeff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc0201154:	00002697          	auipc	a3,0x2
ffffffffc0201158:	9f468693          	addi	a3,a3,-1548 # ffffffffc0202b48 <commands+0x8a0>
ffffffffc020115c:	00002617          	auipc	a2,0x2
ffffffffc0201160:	83460613          	addi	a2,a2,-1996 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201164:	0dc00593          	li	a1,220
ffffffffc0201168:	00002517          	auipc	a0,0x2
ffffffffc020116c:	84050513          	addi	a0,a0,-1984 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201170:	a8eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201174:	00002697          	auipc	a3,0x2
ffffffffc0201178:	86c68693          	addi	a3,a3,-1940 # ffffffffc02029e0 <commands+0x738>
ffffffffc020117c:	00002617          	auipc	a2,0x2
ffffffffc0201180:	81460613          	addi	a2,a2,-2028 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201184:	0b900593          	li	a1,185
ffffffffc0201188:	00002517          	auipc	a0,0x2
ffffffffc020118c:	82050513          	addi	a0,a0,-2016 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201190:	a6eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201194:	00002697          	auipc	a3,0x2
ffffffffc0201198:	97468693          	addi	a3,a3,-1676 # ffffffffc0202b08 <commands+0x860>
ffffffffc020119c:	00001617          	auipc	a2,0x1
ffffffffc02011a0:	7f460613          	addi	a2,a2,2036 # ffffffffc0202990 <commands+0x6e8>
ffffffffc02011a4:	0d600593          	li	a1,214
ffffffffc02011a8:	00002517          	auipc	a0,0x2
ffffffffc02011ac:	80050513          	addi	a0,a0,-2048 # ffffffffc02029a8 <commands+0x700>
ffffffffc02011b0:	a4eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02011b4:	00002697          	auipc	a3,0x2
ffffffffc02011b8:	86c68693          	addi	a3,a3,-1940 # ffffffffc0202a20 <commands+0x778>
ffffffffc02011bc:	00001617          	auipc	a2,0x1
ffffffffc02011c0:	7d460613          	addi	a2,a2,2004 # ffffffffc0202990 <commands+0x6e8>
ffffffffc02011c4:	0d400593          	li	a1,212
ffffffffc02011c8:	00001517          	auipc	a0,0x1
ffffffffc02011cc:	7e050513          	addi	a0,a0,2016 # ffffffffc02029a8 <commands+0x700>
ffffffffc02011d0:	a2eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc02011d4:	00002697          	auipc	a3,0x2
ffffffffc02011d8:	82c68693          	addi	a3,a3,-2004 # ffffffffc0202a00 <commands+0x758>
ffffffffc02011dc:	00001617          	auipc	a2,0x1
ffffffffc02011e0:	7b460613          	addi	a2,a2,1972 # ffffffffc0202990 <commands+0x6e8>
ffffffffc02011e4:	0d300593          	li	a1,211
ffffffffc02011e8:	00001517          	auipc	a0,0x1
ffffffffc02011ec:	7c050513          	addi	a0,a0,1984 # ffffffffc02029a8 <commands+0x700>
ffffffffc02011f0:	a0eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02011f4:	00002697          	auipc	a3,0x2
ffffffffc02011f8:	82c68693          	addi	a3,a3,-2004 # ffffffffc0202a20 <commands+0x778>
ffffffffc02011fc:	00001617          	auipc	a2,0x1
ffffffffc0201200:	79460613          	addi	a2,a2,1940 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201204:	0bb00593          	li	a1,187
ffffffffc0201208:	00001517          	auipc	a0,0x1
ffffffffc020120c:	7a050513          	addi	a0,a0,1952 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201210:	9eeff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(count == 0);
ffffffffc0201214:	00002697          	auipc	a3,0x2
ffffffffc0201218:	ab468693          	addi	a3,a3,-1356 # ffffffffc0202cc8 <commands+0xa20>
ffffffffc020121c:	00001617          	auipc	a2,0x1
ffffffffc0201220:	77460613          	addi	a2,a2,1908 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201224:	12500593          	li	a1,293
ffffffffc0201228:	00001517          	auipc	a0,0x1
ffffffffc020122c:	78050513          	addi	a0,a0,1920 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201230:	9ceff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(nr_free == 0);
ffffffffc0201234:	00002697          	auipc	a3,0x2
ffffffffc0201238:	93468693          	addi	a3,a3,-1740 # ffffffffc0202b68 <commands+0x8c0>
ffffffffc020123c:	00001617          	auipc	a2,0x1
ffffffffc0201240:	75460613          	addi	a2,a2,1876 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201244:	11a00593          	li	a1,282
ffffffffc0201248:	00001517          	auipc	a0,0x1
ffffffffc020124c:	76050513          	addi	a0,a0,1888 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201250:	9aeff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201254:	00002697          	auipc	a3,0x2
ffffffffc0201258:	8b468693          	addi	a3,a3,-1868 # ffffffffc0202b08 <commands+0x860>
ffffffffc020125c:	00001617          	auipc	a2,0x1
ffffffffc0201260:	73460613          	addi	a2,a2,1844 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201264:	11800593          	li	a1,280
ffffffffc0201268:	00001517          	auipc	a0,0x1
ffffffffc020126c:	74050513          	addi	a0,a0,1856 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201270:	98eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0201274:	00002697          	auipc	a3,0x2
ffffffffc0201278:	85468693          	addi	a3,a3,-1964 # ffffffffc0202ac8 <commands+0x820>
ffffffffc020127c:	00001617          	auipc	a2,0x1
ffffffffc0201280:	71460613          	addi	a2,a2,1812 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201284:	0c100593          	li	a1,193
ffffffffc0201288:	00001517          	auipc	a0,0x1
ffffffffc020128c:	72050513          	addi	a0,a0,1824 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201290:	96eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0201294:	00002697          	auipc	a3,0x2
ffffffffc0201298:	9f468693          	addi	a3,a3,-1548 # ffffffffc0202c88 <commands+0x9e0>
ffffffffc020129c:	00001617          	auipc	a2,0x1
ffffffffc02012a0:	6f460613          	addi	a2,a2,1780 # ffffffffc0202990 <commands+0x6e8>
ffffffffc02012a4:	11200593          	li	a1,274
ffffffffc02012a8:	00001517          	auipc	a0,0x1
ffffffffc02012ac:	70050513          	addi	a0,a0,1792 # ffffffffc02029a8 <commands+0x700>
ffffffffc02012b0:	94eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc02012b4:	00002697          	auipc	a3,0x2
ffffffffc02012b8:	9b468693          	addi	a3,a3,-1612 # ffffffffc0202c68 <commands+0x9c0>
ffffffffc02012bc:	00001617          	auipc	a2,0x1
ffffffffc02012c0:	6d460613          	addi	a2,a2,1748 # ffffffffc0202990 <commands+0x6e8>
ffffffffc02012c4:	11000593          	li	a1,272
ffffffffc02012c8:	00001517          	auipc	a0,0x1
ffffffffc02012cc:	6e050513          	addi	a0,a0,1760 # ffffffffc02029a8 <commands+0x700>
ffffffffc02012d0:	92eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc02012d4:	00002697          	auipc	a3,0x2
ffffffffc02012d8:	96c68693          	addi	a3,a3,-1684 # ffffffffc0202c40 <commands+0x998>
ffffffffc02012dc:	00001617          	auipc	a2,0x1
ffffffffc02012e0:	6b460613          	addi	a2,a2,1716 # ffffffffc0202990 <commands+0x6e8>
ffffffffc02012e4:	10e00593          	li	a1,270
ffffffffc02012e8:	00001517          	auipc	a0,0x1
ffffffffc02012ec:	6c050513          	addi	a0,a0,1728 # ffffffffc02029a8 <commands+0x700>
ffffffffc02012f0:	90eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc02012f4:	00002697          	auipc	a3,0x2
ffffffffc02012f8:	92468693          	addi	a3,a3,-1756 # ffffffffc0202c18 <commands+0x970>
ffffffffc02012fc:	00001617          	auipc	a2,0x1
ffffffffc0201300:	69460613          	addi	a2,a2,1684 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201304:	10d00593          	li	a1,269
ffffffffc0201308:	00001517          	auipc	a0,0x1
ffffffffc020130c:	6a050513          	addi	a0,a0,1696 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201310:	8eeff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(p0 + 2 == p1);
ffffffffc0201314:	00002697          	auipc	a3,0x2
ffffffffc0201318:	8f468693          	addi	a3,a3,-1804 # ffffffffc0202c08 <commands+0x960>
ffffffffc020131c:	00001617          	auipc	a2,0x1
ffffffffc0201320:	67460613          	addi	a2,a2,1652 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201324:	10800593          	li	a1,264
ffffffffc0201328:	00001517          	auipc	a0,0x1
ffffffffc020132c:	68050513          	addi	a0,a0,1664 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201330:	8ceff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201334:	00001697          	auipc	a3,0x1
ffffffffc0201338:	7d468693          	addi	a3,a3,2004 # ffffffffc0202b08 <commands+0x860>
ffffffffc020133c:	00001617          	auipc	a2,0x1
ffffffffc0201340:	65460613          	addi	a2,a2,1620 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201344:	10700593          	li	a1,263
ffffffffc0201348:	00001517          	auipc	a0,0x1
ffffffffc020134c:	66050513          	addi	a0,a0,1632 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201350:	8aeff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0201354:	00002697          	auipc	a3,0x2
ffffffffc0201358:	89468693          	addi	a3,a3,-1900 # ffffffffc0202be8 <commands+0x940>
ffffffffc020135c:	00001617          	auipc	a2,0x1
ffffffffc0201360:	63460613          	addi	a2,a2,1588 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201364:	10600593          	li	a1,262
ffffffffc0201368:	00001517          	auipc	a0,0x1
ffffffffc020136c:	64050513          	addi	a0,a0,1600 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201370:	88eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0201374:	00002697          	auipc	a3,0x2
ffffffffc0201378:	84468693          	addi	a3,a3,-1980 # ffffffffc0202bb8 <commands+0x910>
ffffffffc020137c:	00001617          	auipc	a2,0x1
ffffffffc0201380:	61460613          	addi	a2,a2,1556 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201384:	10500593          	li	a1,261
ffffffffc0201388:	00001517          	auipc	a0,0x1
ffffffffc020138c:	62050513          	addi	a0,a0,1568 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201390:	86eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc0201394:	00002697          	auipc	a3,0x2
ffffffffc0201398:	80c68693          	addi	a3,a3,-2036 # ffffffffc0202ba0 <commands+0x8f8>
ffffffffc020139c:	00001617          	auipc	a2,0x1
ffffffffc02013a0:	5f460613          	addi	a2,a2,1524 # ffffffffc0202990 <commands+0x6e8>
ffffffffc02013a4:	10400593          	li	a1,260
ffffffffc02013a8:	00001517          	auipc	a0,0x1
ffffffffc02013ac:	60050513          	addi	a0,a0,1536 # ffffffffc02029a8 <commands+0x700>
ffffffffc02013b0:	84eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(alloc_page() == NULL);
ffffffffc02013b4:	00001697          	auipc	a3,0x1
ffffffffc02013b8:	75468693          	addi	a3,a3,1876 # ffffffffc0202b08 <commands+0x860>
ffffffffc02013bc:	00001617          	auipc	a2,0x1
ffffffffc02013c0:	5d460613          	addi	a2,a2,1492 # ffffffffc0202990 <commands+0x6e8>
ffffffffc02013c4:	0fe00593          	li	a1,254
ffffffffc02013c8:	00001517          	auipc	a0,0x1
ffffffffc02013cc:	5e050513          	addi	a0,a0,1504 # ffffffffc02029a8 <commands+0x700>
ffffffffc02013d0:	82eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(!PageProperty(p0));
ffffffffc02013d4:	00001697          	auipc	a3,0x1
ffffffffc02013d8:	7b468693          	addi	a3,a3,1972 # ffffffffc0202b88 <commands+0x8e0>
ffffffffc02013dc:	00001617          	auipc	a2,0x1
ffffffffc02013e0:	5b460613          	addi	a2,a2,1460 # ffffffffc0202990 <commands+0x6e8>
ffffffffc02013e4:	0f900593          	li	a1,249
ffffffffc02013e8:	00001517          	auipc	a0,0x1
ffffffffc02013ec:	5c050513          	addi	a0,a0,1472 # ffffffffc02029a8 <commands+0x700>
ffffffffc02013f0:	80eff0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc02013f4:	00002697          	auipc	a3,0x2
ffffffffc02013f8:	8b468693          	addi	a3,a3,-1868 # ffffffffc0202ca8 <commands+0xa00>
ffffffffc02013fc:	00001617          	auipc	a2,0x1
ffffffffc0201400:	59460613          	addi	a2,a2,1428 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201404:	11700593          	li	a1,279
ffffffffc0201408:	00001517          	auipc	a0,0x1
ffffffffc020140c:	5a050513          	addi	a0,a0,1440 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201410:	feffe0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(total == 0);
ffffffffc0201414:	00002697          	auipc	a3,0x2
ffffffffc0201418:	8c468693          	addi	a3,a3,-1852 # ffffffffc0202cd8 <commands+0xa30>
ffffffffc020141c:	00001617          	auipc	a2,0x1
ffffffffc0201420:	57460613          	addi	a2,a2,1396 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201424:	12600593          	li	a1,294
ffffffffc0201428:	00001517          	auipc	a0,0x1
ffffffffc020142c:	58050513          	addi	a0,a0,1408 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201430:	fcffe0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(total == nr_free_pages());
ffffffffc0201434:	00001697          	auipc	a3,0x1
ffffffffc0201438:	58c68693          	addi	a3,a3,1420 # ffffffffc02029c0 <commands+0x718>
ffffffffc020143c:	00001617          	auipc	a2,0x1
ffffffffc0201440:	55460613          	addi	a2,a2,1364 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201444:	0f300593          	li	a1,243
ffffffffc0201448:	00001517          	auipc	a0,0x1
ffffffffc020144c:	56050513          	addi	a0,a0,1376 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201450:	faffe0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201454:	00001697          	auipc	a3,0x1
ffffffffc0201458:	5ac68693          	addi	a3,a3,1452 # ffffffffc0202a00 <commands+0x758>
ffffffffc020145c:	00001617          	auipc	a2,0x1
ffffffffc0201460:	53460613          	addi	a2,a2,1332 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201464:	0ba00593          	li	a1,186
ffffffffc0201468:	00001517          	auipc	a0,0x1
ffffffffc020146c:	54050513          	addi	a0,a0,1344 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201470:	f8ffe0ef          	jal	ra,ffffffffc02003fe <__panic>

ffffffffc0201474 <default_free_pages>:
default_free_pages(struct Page *base, size_t n) {
ffffffffc0201474:	1141                	addi	sp,sp,-16
ffffffffc0201476:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0201478:	14058a63          	beqz	a1,ffffffffc02015cc <default_free_pages+0x158>
    for (; p != base + n; p ++) {
ffffffffc020147c:	00259693          	slli	a3,a1,0x2
ffffffffc0201480:	96ae                	add	a3,a3,a1
ffffffffc0201482:	068e                	slli	a3,a3,0x3
ffffffffc0201484:	96aa                	add	a3,a3,a0
ffffffffc0201486:	87aa                	mv	a5,a0
ffffffffc0201488:	02d50263          	beq	a0,a3,ffffffffc02014ac <default_free_pages+0x38>
ffffffffc020148c:	6798                	ld	a4,8(a5)
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc020148e:	8b05                	andi	a4,a4,1
ffffffffc0201490:	10071e63          	bnez	a4,ffffffffc02015ac <default_free_pages+0x138>
ffffffffc0201494:	6798                	ld	a4,8(a5)
ffffffffc0201496:	8b09                	andi	a4,a4,2
ffffffffc0201498:	10071a63          	bnez	a4,ffffffffc02015ac <default_free_pages+0x138>
        p->flags = 0;
ffffffffc020149c:	0007b423          	sd	zero,8(a5)



static inline int page_ref(struct Page *page) { return page->ref; }

static inline void set_page_ref(struct Page *page, int val) { page->ref = val; }
ffffffffc02014a0:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc02014a4:	02878793          	addi	a5,a5,40
ffffffffc02014a8:	fed792e3          	bne	a5,a3,ffffffffc020148c <default_free_pages+0x18>
    base->property = n;
ffffffffc02014ac:	2581                	sext.w	a1,a1
ffffffffc02014ae:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc02014b0:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02014b4:	4789                	li	a5,2
ffffffffc02014b6:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc02014ba:	00006697          	auipc	a3,0x6
ffffffffc02014be:	b6e68693          	addi	a3,a3,-1170 # ffffffffc0207028 <free_area>
ffffffffc02014c2:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02014c4:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02014c6:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02014ca:	9db9                	addw	a1,a1,a4
ffffffffc02014cc:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc02014ce:	0ad78863          	beq	a5,a3,ffffffffc020157e <default_free_pages+0x10a>
            struct Page* page = le2page(le, page_link);
ffffffffc02014d2:	fe878713          	addi	a4,a5,-24
ffffffffc02014d6:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc02014da:	4581                	li	a1,0
            if (base < page) {
ffffffffc02014dc:	00e56a63          	bltu	a0,a4,ffffffffc02014f0 <default_free_pages+0x7c>
    return listelm->next;
ffffffffc02014e0:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc02014e2:	06d70263          	beq	a4,a3,ffffffffc0201546 <default_free_pages+0xd2>
    for (; p != base + n; p ++) {
ffffffffc02014e6:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc02014e8:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc02014ec:	fee57ae3          	bgeu	a0,a4,ffffffffc02014e0 <default_free_pages+0x6c>
ffffffffc02014f0:	c199                	beqz	a1,ffffffffc02014f6 <default_free_pages+0x82>
ffffffffc02014f2:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc02014f6:	6398                	ld	a4,0(a5)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc02014f8:	e390                	sd	a2,0(a5)
ffffffffc02014fa:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc02014fc:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc02014fe:	ed18                	sd	a4,24(a0)
    if (le != &free_list) {
ffffffffc0201500:	02d70063          	beq	a4,a3,ffffffffc0201520 <default_free_pages+0xac>
        if (p + p->property == base) {
ffffffffc0201504:	ff872803          	lw	a6,-8(a4)
        p = le2page(le, page_link);
ffffffffc0201508:	fe870593          	addi	a1,a4,-24
        if (p + p->property == base) {
ffffffffc020150c:	02081613          	slli	a2,a6,0x20
ffffffffc0201510:	9201                	srli	a2,a2,0x20
ffffffffc0201512:	00261793          	slli	a5,a2,0x2
ffffffffc0201516:	97b2                	add	a5,a5,a2
ffffffffc0201518:	078e                	slli	a5,a5,0x3
ffffffffc020151a:	97ae                	add	a5,a5,a1
ffffffffc020151c:	02f50f63          	beq	a0,a5,ffffffffc020155a <default_free_pages+0xe6>
    return listelm->next;
ffffffffc0201520:	7118                	ld	a4,32(a0)
    if (le != &free_list) {
ffffffffc0201522:	00d70f63          	beq	a4,a3,ffffffffc0201540 <default_free_pages+0xcc>
        if (base + base->property == p) {
ffffffffc0201526:	490c                	lw	a1,16(a0)
        p = le2page(le, page_link);
ffffffffc0201528:	fe870693          	addi	a3,a4,-24
        if (base + base->property == p) {
ffffffffc020152c:	02059613          	slli	a2,a1,0x20
ffffffffc0201530:	9201                	srli	a2,a2,0x20
ffffffffc0201532:	00261793          	slli	a5,a2,0x2
ffffffffc0201536:	97b2                	add	a5,a5,a2
ffffffffc0201538:	078e                	slli	a5,a5,0x3
ffffffffc020153a:	97aa                	add	a5,a5,a0
ffffffffc020153c:	04f68863          	beq	a3,a5,ffffffffc020158c <default_free_pages+0x118>
}
ffffffffc0201540:	60a2                	ld	ra,8(sp)
ffffffffc0201542:	0141                	addi	sp,sp,16
ffffffffc0201544:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0201546:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201548:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc020154a:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc020154c:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc020154e:	02d70563          	beq	a4,a3,ffffffffc0201578 <default_free_pages+0x104>
    prev->next = next->prev = elm;
ffffffffc0201552:	8832                	mv	a6,a2
ffffffffc0201554:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc0201556:	87ba                	mv	a5,a4
ffffffffc0201558:	bf41                	j	ffffffffc02014e8 <default_free_pages+0x74>
            p->property += base->property;
ffffffffc020155a:	491c                	lw	a5,16(a0)
ffffffffc020155c:	0107883b          	addw	a6,a5,a6
ffffffffc0201560:	ff072c23          	sw	a6,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0201564:	57f5                	li	a5,-3
ffffffffc0201566:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc020156a:	6d10                	ld	a2,24(a0)
ffffffffc020156c:	711c                	ld	a5,32(a0)
            base = p;
ffffffffc020156e:	852e                	mv	a0,a1
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc0201570:	e61c                	sd	a5,8(a2)
    return listelm->next;
ffffffffc0201572:	6718                	ld	a4,8(a4)
    next->prev = prev;
ffffffffc0201574:	e390                	sd	a2,0(a5)
ffffffffc0201576:	b775                	j	ffffffffc0201522 <default_free_pages+0xae>
ffffffffc0201578:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list) {
ffffffffc020157a:	873e                	mv	a4,a5
ffffffffc020157c:	b761                	j	ffffffffc0201504 <default_free_pages+0x90>
}
ffffffffc020157e:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0201580:	e390                	sd	a2,0(a5)
ffffffffc0201582:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201584:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201586:	ed1c                	sd	a5,24(a0)
ffffffffc0201588:	0141                	addi	sp,sp,16
ffffffffc020158a:	8082                	ret
            base->property += p->property;
ffffffffc020158c:	ff872783          	lw	a5,-8(a4)
ffffffffc0201590:	ff070693          	addi	a3,a4,-16
ffffffffc0201594:	9dbd                	addw	a1,a1,a5
ffffffffc0201596:	c90c                	sw	a1,16(a0)
ffffffffc0201598:	57f5                	li	a5,-3
ffffffffc020159a:	60f6b02f          	amoand.d	zero,a5,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc020159e:	6314                	ld	a3,0(a4)
ffffffffc02015a0:	671c                	ld	a5,8(a4)
}
ffffffffc02015a2:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc02015a4:	e69c                	sd	a5,8(a3)
    next->prev = prev;
ffffffffc02015a6:	e394                	sd	a3,0(a5)
ffffffffc02015a8:	0141                	addi	sp,sp,16
ffffffffc02015aa:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02015ac:	00001697          	auipc	a3,0x1
ffffffffc02015b0:	74468693          	addi	a3,a3,1860 # ffffffffc0202cf0 <commands+0xa48>
ffffffffc02015b4:	00001617          	auipc	a2,0x1
ffffffffc02015b8:	3dc60613          	addi	a2,a2,988 # ffffffffc0202990 <commands+0x6e8>
ffffffffc02015bc:	08300593          	li	a1,131
ffffffffc02015c0:	00001517          	auipc	a0,0x1
ffffffffc02015c4:	3e850513          	addi	a0,a0,1000 # ffffffffc02029a8 <commands+0x700>
ffffffffc02015c8:	e37fe0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(n > 0);
ffffffffc02015cc:	00001697          	auipc	a3,0x1
ffffffffc02015d0:	71c68693          	addi	a3,a3,1820 # ffffffffc0202ce8 <commands+0xa40>
ffffffffc02015d4:	00001617          	auipc	a2,0x1
ffffffffc02015d8:	3bc60613          	addi	a2,a2,956 # ffffffffc0202990 <commands+0x6e8>
ffffffffc02015dc:	08000593          	li	a1,128
ffffffffc02015e0:	00001517          	auipc	a0,0x1
ffffffffc02015e4:	3c850513          	addi	a0,a0,968 # ffffffffc02029a8 <commands+0x700>
ffffffffc02015e8:	e17fe0ef          	jal	ra,ffffffffc02003fe <__panic>

ffffffffc02015ec <default_alloc_pages>:
    assert(n > 0);
ffffffffc02015ec:	c959                	beqz	a0,ffffffffc0201682 <default_alloc_pages+0x96>
    if (n > nr_free) {
ffffffffc02015ee:	00006597          	auipc	a1,0x6
ffffffffc02015f2:	a3a58593          	addi	a1,a1,-1478 # ffffffffc0207028 <free_area>
ffffffffc02015f6:	0105a803          	lw	a6,16(a1)
ffffffffc02015fa:	862a                	mv	a2,a0
ffffffffc02015fc:	02081793          	slli	a5,a6,0x20
ffffffffc0201600:	9381                	srli	a5,a5,0x20
ffffffffc0201602:	00a7ee63          	bltu	a5,a0,ffffffffc020161e <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc0201606:	87ae                	mv	a5,a1
ffffffffc0201608:	a801                	j	ffffffffc0201618 <default_alloc_pages+0x2c>
        if (p->property >= n) {
ffffffffc020160a:	ff87a703          	lw	a4,-8(a5)
ffffffffc020160e:	02071693          	slli	a3,a4,0x20
ffffffffc0201612:	9281                	srli	a3,a3,0x20
ffffffffc0201614:	00c6f763          	bgeu	a3,a2,ffffffffc0201622 <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc0201618:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list) {
ffffffffc020161a:	feb798e3          	bne	a5,a1,ffffffffc020160a <default_alloc_pages+0x1e>
        return NULL;
ffffffffc020161e:	4501                	li	a0,0
}
ffffffffc0201620:	8082                	ret
    return listelm->prev;
ffffffffc0201622:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc0201626:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc020162a:	fe878513          	addi	a0,a5,-24
            p->property = page->property - n;
ffffffffc020162e:	00060e1b          	sext.w	t3,a2
    prev->next = next;
ffffffffc0201632:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc0201636:	01133023          	sd	a7,0(t1)
        if (page->property > n) {
ffffffffc020163a:	02d67b63          	bgeu	a2,a3,ffffffffc0201670 <default_alloc_pages+0x84>
            struct Page *p = page + n;
ffffffffc020163e:	00261693          	slli	a3,a2,0x2
ffffffffc0201642:	96b2                	add	a3,a3,a2
ffffffffc0201644:	068e                	slli	a3,a3,0x3
ffffffffc0201646:	96aa                	add	a3,a3,a0
            p->property = page->property - n;
ffffffffc0201648:	41c7073b          	subw	a4,a4,t3
ffffffffc020164c:	ca98                	sw	a4,16(a3)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc020164e:	00868613          	addi	a2,a3,8
ffffffffc0201652:	4709                	li	a4,2
ffffffffc0201654:	40e6302f          	amoor.d	zero,a4,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc0201658:	0088b703          	ld	a4,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc020165c:	01868613          	addi	a2,a3,24
        nr_free -= n;
ffffffffc0201660:	0105a803          	lw	a6,16(a1)
    prev->next = next->prev = elm;
ffffffffc0201664:	e310                	sd	a2,0(a4)
ffffffffc0201666:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc020166a:	f298                	sd	a4,32(a3)
    elm->prev = prev;
ffffffffc020166c:	0116bc23          	sd	a7,24(a3)
ffffffffc0201670:	41c8083b          	subw	a6,a6,t3
ffffffffc0201674:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0201678:	5775                	li	a4,-3
ffffffffc020167a:	17c1                	addi	a5,a5,-16
ffffffffc020167c:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc0201680:	8082                	ret
default_alloc_pages(size_t n) {
ffffffffc0201682:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc0201684:	00001697          	auipc	a3,0x1
ffffffffc0201688:	66468693          	addi	a3,a3,1636 # ffffffffc0202ce8 <commands+0xa40>
ffffffffc020168c:	00001617          	auipc	a2,0x1
ffffffffc0201690:	30460613          	addi	a2,a2,772 # ffffffffc0202990 <commands+0x6e8>
ffffffffc0201694:	06200593          	li	a1,98
ffffffffc0201698:	00001517          	auipc	a0,0x1
ffffffffc020169c:	31050513          	addi	a0,a0,784 # ffffffffc02029a8 <commands+0x700>
default_alloc_pages(size_t n) {
ffffffffc02016a0:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02016a2:	d5dfe0ef          	jal	ra,ffffffffc02003fe <__panic>

ffffffffc02016a6 <default_init_memmap>:
default_init_memmap(struct Page *base, size_t n) {
ffffffffc02016a6:	1141                	addi	sp,sp,-16
ffffffffc02016a8:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02016aa:	c9e1                	beqz	a1,ffffffffc020177a <default_init_memmap+0xd4>
    for (; p != base + n; p ++) {
ffffffffc02016ac:	00259693          	slli	a3,a1,0x2
ffffffffc02016b0:	96ae                	add	a3,a3,a1
ffffffffc02016b2:	068e                	slli	a3,a3,0x3
ffffffffc02016b4:	96aa                	add	a3,a3,a0
ffffffffc02016b6:	87aa                	mv	a5,a0
ffffffffc02016b8:	00d50f63          	beq	a0,a3,ffffffffc02016d6 <default_init_memmap+0x30>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc02016bc:	6798                	ld	a4,8(a5)
        assert(PageReserved(p));
ffffffffc02016be:	8b05                	andi	a4,a4,1
ffffffffc02016c0:	cf49                	beqz	a4,ffffffffc020175a <default_init_memmap+0xb4>
        p->flags = p->property = 0;
ffffffffc02016c2:	0007a823          	sw	zero,16(a5)
ffffffffc02016c6:	0007b423          	sd	zero,8(a5)
ffffffffc02016ca:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc02016ce:	02878793          	addi	a5,a5,40
ffffffffc02016d2:	fed795e3          	bne	a5,a3,ffffffffc02016bc <default_init_memmap+0x16>
    base->property = n;
ffffffffc02016d6:	2581                	sext.w	a1,a1
ffffffffc02016d8:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02016da:	4789                	li	a5,2
ffffffffc02016dc:	00850713          	addi	a4,a0,8
ffffffffc02016e0:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc02016e4:	00006697          	auipc	a3,0x6
ffffffffc02016e8:	94468693          	addi	a3,a3,-1724 # ffffffffc0207028 <free_area>
ffffffffc02016ec:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02016ee:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02016f0:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02016f4:	9db9                	addw	a1,a1,a4
ffffffffc02016f6:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc02016f8:	04d78a63          	beq	a5,a3,ffffffffc020174c <default_init_memmap+0xa6>
            struct Page* page = le2page(le, page_link);
ffffffffc02016fc:	fe878713          	addi	a4,a5,-24
ffffffffc0201700:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc0201704:	4581                	li	a1,0
            if (base < page) {
ffffffffc0201706:	00e56a63          	bltu	a0,a4,ffffffffc020171a <default_init_memmap+0x74>
    return listelm->next;
ffffffffc020170a:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc020170c:	02d70263          	beq	a4,a3,ffffffffc0201730 <default_init_memmap+0x8a>
    for (; p != base + n; p ++) {
ffffffffc0201710:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc0201712:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc0201716:	fee57ae3          	bgeu	a0,a4,ffffffffc020170a <default_init_memmap+0x64>
ffffffffc020171a:	c199                	beqz	a1,ffffffffc0201720 <default_init_memmap+0x7a>
ffffffffc020171c:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc0201720:	6398                	ld	a4,0(a5)
}
ffffffffc0201722:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0201724:	e390                	sd	a2,0(a5)
ffffffffc0201726:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0201728:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc020172a:	ed18                	sd	a4,24(a0)
ffffffffc020172c:	0141                	addi	sp,sp,16
ffffffffc020172e:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0201730:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201732:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0201734:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0201736:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc0201738:	00d70663          	beq	a4,a3,ffffffffc0201744 <default_init_memmap+0x9e>
    prev->next = next->prev = elm;
ffffffffc020173c:	8832                	mv	a6,a2
ffffffffc020173e:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc0201740:	87ba                	mv	a5,a4
ffffffffc0201742:	bfc1                	j	ffffffffc0201712 <default_init_memmap+0x6c>
}
ffffffffc0201744:	60a2                	ld	ra,8(sp)
ffffffffc0201746:	e290                	sd	a2,0(a3)
ffffffffc0201748:	0141                	addi	sp,sp,16
ffffffffc020174a:	8082                	ret
ffffffffc020174c:	60a2                	ld	ra,8(sp)
ffffffffc020174e:	e390                	sd	a2,0(a5)
ffffffffc0201750:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201752:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201754:	ed1c                	sd	a5,24(a0)
ffffffffc0201756:	0141                	addi	sp,sp,16
ffffffffc0201758:	8082                	ret
        assert(PageReserved(p));
ffffffffc020175a:	00001697          	auipc	a3,0x1
ffffffffc020175e:	5be68693          	addi	a3,a3,1470 # ffffffffc0202d18 <commands+0xa70>
ffffffffc0201762:	00001617          	auipc	a2,0x1
ffffffffc0201766:	22e60613          	addi	a2,a2,558 # ffffffffc0202990 <commands+0x6e8>
ffffffffc020176a:	04900593          	li	a1,73
ffffffffc020176e:	00001517          	auipc	a0,0x1
ffffffffc0201772:	23a50513          	addi	a0,a0,570 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201776:	c89fe0ef          	jal	ra,ffffffffc02003fe <__panic>
    assert(n > 0);
ffffffffc020177a:	00001697          	auipc	a3,0x1
ffffffffc020177e:	56e68693          	addi	a3,a3,1390 # ffffffffc0202ce8 <commands+0xa40>
ffffffffc0201782:	00001617          	auipc	a2,0x1
ffffffffc0201786:	20e60613          	addi	a2,a2,526 # ffffffffc0202990 <commands+0x6e8>
ffffffffc020178a:	04600593          	li	a1,70
ffffffffc020178e:	00001517          	auipc	a0,0x1
ffffffffc0201792:	21a50513          	addi	a0,a0,538 # ffffffffc02029a8 <commands+0x700>
ffffffffc0201796:	c69fe0ef          	jal	ra,ffffffffc02003fe <__panic>

ffffffffc020179a <alloc_pages>:
#include <defs.h>
#include <intr.h>
#include <riscv.h>

static inline bool __intr_save(void) {
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020179a:	100027f3          	csrr	a5,sstatus
ffffffffc020179e:	8b89                	andi	a5,a5,2
ffffffffc02017a0:	e799                	bnez	a5,ffffffffc02017ae <alloc_pages+0x14>
struct Page *alloc_pages(size_t n) {
    struct Page *page = NULL;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        page = pmm_manager->alloc_pages(n);
ffffffffc02017a2:	00006797          	auipc	a5,0x6
ffffffffc02017a6:	cd67b783          	ld	a5,-810(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc02017aa:	6f9c                	ld	a5,24(a5)
ffffffffc02017ac:	8782                	jr	a5
struct Page *alloc_pages(size_t n) {
ffffffffc02017ae:	1141                	addi	sp,sp,-16
ffffffffc02017b0:	e406                	sd	ra,8(sp)
ffffffffc02017b2:	e022                	sd	s0,0(sp)
ffffffffc02017b4:	842a                	mv	s0,a0
        intr_disable();
ffffffffc02017b6:	8aaff0ef          	jal	ra,ffffffffc0200860 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc02017ba:	00006797          	auipc	a5,0x6
ffffffffc02017be:	cbe7b783          	ld	a5,-834(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc02017c2:	6f9c                	ld	a5,24(a5)
ffffffffc02017c4:	8522                	mv	a0,s0
ffffffffc02017c6:	9782                	jalr	a5
ffffffffc02017c8:	842a                	mv	s0,a0
    return 0;
}

static inline void __intr_restore(bool flag) {
    if (flag) {
        intr_enable();
ffffffffc02017ca:	890ff0ef          	jal	ra,ffffffffc020085a <intr_enable>
    }
    local_intr_restore(intr_flag);
    return page;
}
ffffffffc02017ce:	60a2                	ld	ra,8(sp)
ffffffffc02017d0:	8522                	mv	a0,s0
ffffffffc02017d2:	6402                	ld	s0,0(sp)
ffffffffc02017d4:	0141                	addi	sp,sp,16
ffffffffc02017d6:	8082                	ret

ffffffffc02017d8 <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02017d8:	100027f3          	csrr	a5,sstatus
ffffffffc02017dc:	8b89                	andi	a5,a5,2
ffffffffc02017de:	e799                	bnez	a5,ffffffffc02017ec <free_pages+0x14>
// free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory
void free_pages(struct Page *base, size_t n) {
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc02017e0:	00006797          	auipc	a5,0x6
ffffffffc02017e4:	c987b783          	ld	a5,-872(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc02017e8:	739c                	ld	a5,32(a5)
ffffffffc02017ea:	8782                	jr	a5
void free_pages(struct Page *base, size_t n) {
ffffffffc02017ec:	1101                	addi	sp,sp,-32
ffffffffc02017ee:	ec06                	sd	ra,24(sp)
ffffffffc02017f0:	e822                	sd	s0,16(sp)
ffffffffc02017f2:	e426                	sd	s1,8(sp)
ffffffffc02017f4:	842a                	mv	s0,a0
ffffffffc02017f6:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc02017f8:	868ff0ef          	jal	ra,ffffffffc0200860 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc02017fc:	00006797          	auipc	a5,0x6
ffffffffc0201800:	c7c7b783          	ld	a5,-900(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc0201804:	739c                	ld	a5,32(a5)
ffffffffc0201806:	85a6                	mv	a1,s1
ffffffffc0201808:	8522                	mv	a0,s0
ffffffffc020180a:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc020180c:	6442                	ld	s0,16(sp)
ffffffffc020180e:	60e2                	ld	ra,24(sp)
ffffffffc0201810:	64a2                	ld	s1,8(sp)
ffffffffc0201812:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0201814:	846ff06f          	j	ffffffffc020085a <intr_enable>

ffffffffc0201818 <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0201818:	100027f3          	csrr	a5,sstatus
ffffffffc020181c:	8b89                	andi	a5,a5,2
ffffffffc020181e:	e799                	bnez	a5,ffffffffc020182c <nr_free_pages+0x14>
size_t nr_free_pages(void) {
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc0201820:	00006797          	auipc	a5,0x6
ffffffffc0201824:	c587b783          	ld	a5,-936(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc0201828:	779c                	ld	a5,40(a5)
ffffffffc020182a:	8782                	jr	a5
size_t nr_free_pages(void) {
ffffffffc020182c:	1141                	addi	sp,sp,-16
ffffffffc020182e:	e406                	sd	ra,8(sp)
ffffffffc0201830:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc0201832:	82eff0ef          	jal	ra,ffffffffc0200860 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0201836:	00006797          	auipc	a5,0x6
ffffffffc020183a:	c427b783          	ld	a5,-958(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc020183e:	779c                	ld	a5,40(a5)
ffffffffc0201840:	9782                	jalr	a5
ffffffffc0201842:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201844:	816ff0ef          	jal	ra,ffffffffc020085a <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc0201848:	60a2                	ld	ra,8(sp)
ffffffffc020184a:	8522                	mv	a0,s0
ffffffffc020184c:	6402                	ld	s0,0(sp)
ffffffffc020184e:	0141                	addi	sp,sp,16
ffffffffc0201850:	8082                	ret

ffffffffc0201852 <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc0201852:	00001797          	auipc	a5,0x1
ffffffffc0201856:	4ee78793          	addi	a5,a5,1262 # ffffffffc0202d40 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc020185a:	638c                	ld	a1,0(a5)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
    }
}

/* pmm_init - initialize the physical memory management */
void pmm_init(void) {
ffffffffc020185c:	7179                	addi	sp,sp,-48
ffffffffc020185e:	f022                	sd	s0,32(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0201860:	00001517          	auipc	a0,0x1
ffffffffc0201864:	51850513          	addi	a0,a0,1304 # ffffffffc0202d78 <default_pmm_manager+0x38>
    pmm_manager = &default_pmm_manager;
ffffffffc0201868:	00006417          	auipc	s0,0x6
ffffffffc020186c:	c1040413          	addi	s0,s0,-1008 # ffffffffc0207478 <pmm_manager>
void pmm_init(void) {
ffffffffc0201870:	f406                	sd	ra,40(sp)
ffffffffc0201872:	ec26                	sd	s1,24(sp)
ffffffffc0201874:	e44e                	sd	s3,8(sp)
ffffffffc0201876:	e84a                	sd	s2,16(sp)
ffffffffc0201878:	e052                	sd	s4,0(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc020187a:	e01c                	sd	a5,0(s0)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc020187c:	889fe0ef          	jal	ra,ffffffffc0200104 <cprintf>
    pmm_manager->init();
ffffffffc0201880:	601c                	ld	a5,0(s0)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0201882:	00006497          	auipc	s1,0x6
ffffffffc0201886:	c0e48493          	addi	s1,s1,-1010 # ffffffffc0207490 <va_pa_offset>
    pmm_manager->init();
ffffffffc020188a:	679c                	ld	a5,8(a5)
ffffffffc020188c:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc020188e:	57f5                	li	a5,-3
ffffffffc0201890:	07fa                	slli	a5,a5,0x1e
ffffffffc0201892:	e09c                	sd	a5,0(s1)
    uint64_t mem_begin = get_memory_base();
ffffffffc0201894:	fb3fe0ef          	jal	ra,ffffffffc0200846 <get_memory_base>
ffffffffc0201898:	89aa                	mv	s3,a0
    uint64_t mem_size  = get_memory_size();
ffffffffc020189a:	fb7fe0ef          	jal	ra,ffffffffc0200850 <get_memory_size>
    if (mem_size == 0) {
ffffffffc020189e:	16050163          	beqz	a0,ffffffffc0201a00 <pmm_init+0x1ae>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc02018a2:	892a                	mv	s2,a0
    cprintf("physcial memory map:\n");
ffffffffc02018a4:	00001517          	auipc	a0,0x1
ffffffffc02018a8:	51c50513          	addi	a0,a0,1308 # ffffffffc0202dc0 <default_pmm_manager+0x80>
ffffffffc02018ac:	859fe0ef          	jal	ra,ffffffffc0200104 <cprintf>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc02018b0:	01298a33          	add	s4,s3,s2
    cprintf("  memory: 0x%016lx, [0x%016lx, 0x%016lx].\n", mem_size, mem_begin,
ffffffffc02018b4:	864e                	mv	a2,s3
ffffffffc02018b6:	fffa0693          	addi	a3,s4,-1
ffffffffc02018ba:	85ca                	mv	a1,s2
ffffffffc02018bc:	00001517          	auipc	a0,0x1
ffffffffc02018c0:	51c50513          	addi	a0,a0,1308 # ffffffffc0202dd8 <default_pmm_manager+0x98>
ffffffffc02018c4:	841fe0ef          	jal	ra,ffffffffc0200104 <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc02018c8:	c80007b7          	lui	a5,0xc8000
ffffffffc02018cc:	8652                	mv	a2,s4
ffffffffc02018ce:	0d47e863          	bltu	a5,s4,ffffffffc020199e <pmm_init+0x14c>
ffffffffc02018d2:	00007797          	auipc	a5,0x7
ffffffffc02018d6:	bcd78793          	addi	a5,a5,-1075 # ffffffffc020849f <end+0xfff>
ffffffffc02018da:	757d                	lui	a0,0xfffff
ffffffffc02018dc:	8d7d                	and	a0,a0,a5
ffffffffc02018de:	8231                	srli	a2,a2,0xc
ffffffffc02018e0:	00006597          	auipc	a1,0x6
ffffffffc02018e4:	b8858593          	addi	a1,a1,-1144 # ffffffffc0207468 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02018e8:	00006817          	auipc	a6,0x6
ffffffffc02018ec:	b8880813          	addi	a6,a6,-1144 # ffffffffc0207470 <pages>
    npage = maxpa / PGSIZE;
ffffffffc02018f0:	e190                	sd	a2,0(a1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02018f2:	00a83023          	sd	a0,0(a6)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc02018f6:	000807b7          	lui	a5,0x80
ffffffffc02018fa:	02f60663          	beq	a2,a5,ffffffffc0201926 <pmm_init+0xd4>
ffffffffc02018fe:	4701                	li	a4,0
ffffffffc0201900:	4781                	li	a5,0
ffffffffc0201902:	4305                	li	t1,1
ffffffffc0201904:	fff808b7          	lui	a7,0xfff80
        SetPageReserved(pages + i);
ffffffffc0201908:	953a                	add	a0,a0,a4
ffffffffc020190a:	00850693          	addi	a3,a0,8 # fffffffffffff008 <end+0x3fdf7b68>
ffffffffc020190e:	4066b02f          	amoor.d	zero,t1,(a3)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0201912:	6190                	ld	a2,0(a1)
ffffffffc0201914:	0785                	addi	a5,a5,1
        SetPageReserved(pages + i);
ffffffffc0201916:	00083503          	ld	a0,0(a6)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc020191a:	011606b3          	add	a3,a2,a7
ffffffffc020191e:	02870713          	addi	a4,a4,40
ffffffffc0201922:	fed7e3e3          	bltu	a5,a3,ffffffffc0201908 <pmm_init+0xb6>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0201926:	00261693          	slli	a3,a2,0x2
ffffffffc020192a:	96b2                	add	a3,a3,a2
ffffffffc020192c:	fec007b7          	lui	a5,0xfec00
ffffffffc0201930:	97aa                	add	a5,a5,a0
ffffffffc0201932:	068e                	slli	a3,a3,0x3
ffffffffc0201934:	96be                	add	a3,a3,a5
ffffffffc0201936:	c02007b7          	lui	a5,0xc0200
ffffffffc020193a:	0af6e763          	bltu	a3,a5,ffffffffc02019e8 <pmm_init+0x196>
ffffffffc020193e:	6098                	ld	a4,0(s1)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc0201940:	77fd                	lui	a5,0xfffff
ffffffffc0201942:	00fa75b3          	and	a1,s4,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0201946:	8e99                	sub	a3,a3,a4
    if (freemem < mem_end) {
ffffffffc0201948:	04b6ee63          	bltu	a3,a1,ffffffffc02019a4 <pmm_init+0x152>
    satp_physical = PADDR(satp_virtual);
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
}

static void check_alloc_page(void) {
    pmm_manager->check();
ffffffffc020194c:	601c                	ld	a5,0(s0)
ffffffffc020194e:	7b9c                	ld	a5,48(a5)
ffffffffc0201950:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc0201952:	00001517          	auipc	a0,0x1
ffffffffc0201956:	50e50513          	addi	a0,a0,1294 # ffffffffc0202e60 <default_pmm_manager+0x120>
ffffffffc020195a:	faafe0ef          	jal	ra,ffffffffc0200104 <cprintf>
    satp_virtual = (pte_t*)boot_page_table_sv39;
ffffffffc020195e:	00004597          	auipc	a1,0x4
ffffffffc0201962:	6a258593          	addi	a1,a1,1698 # ffffffffc0206000 <boot_page_table_sv39>
ffffffffc0201966:	00006797          	auipc	a5,0x6
ffffffffc020196a:	b2b7b123          	sd	a1,-1246(a5) # ffffffffc0207488 <satp_virtual>
    satp_physical = PADDR(satp_virtual);
ffffffffc020196e:	c02007b7          	lui	a5,0xc0200
ffffffffc0201972:	0af5e363          	bltu	a1,a5,ffffffffc0201a18 <pmm_init+0x1c6>
ffffffffc0201976:	6090                	ld	a2,0(s1)
}
ffffffffc0201978:	7402                	ld	s0,32(sp)
ffffffffc020197a:	70a2                	ld	ra,40(sp)
ffffffffc020197c:	64e2                	ld	s1,24(sp)
ffffffffc020197e:	6942                	ld	s2,16(sp)
ffffffffc0201980:	69a2                	ld	s3,8(sp)
ffffffffc0201982:	6a02                	ld	s4,0(sp)
    satp_physical = PADDR(satp_virtual);
ffffffffc0201984:	40c58633          	sub	a2,a1,a2
ffffffffc0201988:	00006797          	auipc	a5,0x6
ffffffffc020198c:	aec7bc23          	sd	a2,-1288(a5) # ffffffffc0207480 <satp_physical>
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc0201990:	00001517          	auipc	a0,0x1
ffffffffc0201994:	4f050513          	addi	a0,a0,1264 # ffffffffc0202e80 <default_pmm_manager+0x140>
}
ffffffffc0201998:	6145                	addi	sp,sp,48
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc020199a:	f6afe06f          	j	ffffffffc0200104 <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc020199e:	c8000637          	lui	a2,0xc8000
ffffffffc02019a2:	bf05                	j	ffffffffc02018d2 <pmm_init+0x80>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc02019a4:	6705                	lui	a4,0x1
ffffffffc02019a6:	177d                	addi	a4,a4,-1
ffffffffc02019a8:	96ba                	add	a3,a3,a4
ffffffffc02019aa:	8efd                	and	a3,a3,a5
static inline int page_ref_dec(struct Page *page) {
    page->ref -= 1;
    return page->ref;
}
static inline struct Page *pa2page(uintptr_t pa) {
    if (PPN(pa) >= npage) {
ffffffffc02019ac:	00c6d793          	srli	a5,a3,0xc
ffffffffc02019b0:	02c7f063          	bgeu	a5,a2,ffffffffc02019d0 <pmm_init+0x17e>
    pmm_manager->init_memmap(base, n);
ffffffffc02019b4:	6010                	ld	a2,0(s0)
        panic("pa2page called with invalid pa");
    }
    return &pages[PPN(pa) - nbase];
ffffffffc02019b6:	fff80737          	lui	a4,0xfff80
ffffffffc02019ba:	973e                	add	a4,a4,a5
ffffffffc02019bc:	00271793          	slli	a5,a4,0x2
ffffffffc02019c0:	97ba                	add	a5,a5,a4
ffffffffc02019c2:	6a18                	ld	a4,16(a2)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc02019c4:	8d95                	sub	a1,a1,a3
ffffffffc02019c6:	078e                	slli	a5,a5,0x3
    pmm_manager->init_memmap(base, n);
ffffffffc02019c8:	81b1                	srli	a1,a1,0xc
ffffffffc02019ca:	953e                	add	a0,a0,a5
ffffffffc02019cc:	9702                	jalr	a4
}
ffffffffc02019ce:	bfbd                	j	ffffffffc020194c <pmm_init+0xfa>
        panic("pa2page called with invalid pa");
ffffffffc02019d0:	00001617          	auipc	a2,0x1
ffffffffc02019d4:	46060613          	addi	a2,a2,1120 # ffffffffc0202e30 <default_pmm_manager+0xf0>
ffffffffc02019d8:	06b00593          	li	a1,107
ffffffffc02019dc:	00001517          	auipc	a0,0x1
ffffffffc02019e0:	47450513          	addi	a0,a0,1140 # ffffffffc0202e50 <default_pmm_manager+0x110>
ffffffffc02019e4:	a1bfe0ef          	jal	ra,ffffffffc02003fe <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc02019e8:	00001617          	auipc	a2,0x1
ffffffffc02019ec:	42060613          	addi	a2,a2,1056 # ffffffffc0202e08 <default_pmm_manager+0xc8>
ffffffffc02019f0:	07100593          	li	a1,113
ffffffffc02019f4:	00001517          	auipc	a0,0x1
ffffffffc02019f8:	3bc50513          	addi	a0,a0,956 # ffffffffc0202db0 <default_pmm_manager+0x70>
ffffffffc02019fc:	a03fe0ef          	jal	ra,ffffffffc02003fe <__panic>
        panic("DTB memory info not available");
ffffffffc0201a00:	00001617          	auipc	a2,0x1
ffffffffc0201a04:	39060613          	addi	a2,a2,912 # ffffffffc0202d90 <default_pmm_manager+0x50>
ffffffffc0201a08:	05a00593          	li	a1,90
ffffffffc0201a0c:	00001517          	auipc	a0,0x1
ffffffffc0201a10:	3a450513          	addi	a0,a0,932 # ffffffffc0202db0 <default_pmm_manager+0x70>
ffffffffc0201a14:	9ebfe0ef          	jal	ra,ffffffffc02003fe <__panic>
    satp_physical = PADDR(satp_virtual);
ffffffffc0201a18:	86ae                	mv	a3,a1
ffffffffc0201a1a:	00001617          	auipc	a2,0x1
ffffffffc0201a1e:	3ee60613          	addi	a2,a2,1006 # ffffffffc0202e08 <default_pmm_manager+0xc8>
ffffffffc0201a22:	08c00593          	li	a1,140
ffffffffc0201a26:	00001517          	auipc	a0,0x1
ffffffffc0201a2a:	38a50513          	addi	a0,a0,906 # ffffffffc0202db0 <default_pmm_manager+0x70>
ffffffffc0201a2e:	9d1fe0ef          	jal	ra,ffffffffc02003fe <__panic>

ffffffffc0201a32 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc0201a32:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201a36:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc0201a38:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201a3c:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc0201a3e:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201a42:	f022                	sd	s0,32(sp)
ffffffffc0201a44:	ec26                	sd	s1,24(sp)
ffffffffc0201a46:	e84a                	sd	s2,16(sp)
ffffffffc0201a48:	f406                	sd	ra,40(sp)
ffffffffc0201a4a:	e44e                	sd	s3,8(sp)
ffffffffc0201a4c:	84aa                	mv	s1,a0
ffffffffc0201a4e:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc0201a50:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc0201a54:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc0201a56:	03067e63          	bgeu	a2,a6,ffffffffc0201a92 <printnum+0x60>
ffffffffc0201a5a:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc0201a5c:	00805763          	blez	s0,ffffffffc0201a6a <printnum+0x38>
ffffffffc0201a60:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc0201a62:	85ca                	mv	a1,s2
ffffffffc0201a64:	854e                	mv	a0,s3
ffffffffc0201a66:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc0201a68:	fc65                	bnez	s0,ffffffffc0201a60 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201a6a:	1a02                	slli	s4,s4,0x20
ffffffffc0201a6c:	00001797          	auipc	a5,0x1
ffffffffc0201a70:	45478793          	addi	a5,a5,1108 # ffffffffc0202ec0 <default_pmm_manager+0x180>
ffffffffc0201a74:	020a5a13          	srli	s4,s4,0x20
ffffffffc0201a78:	9a3e                	add	s4,s4,a5
}
ffffffffc0201a7a:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201a7c:	000a4503          	lbu	a0,0(s4)
}
ffffffffc0201a80:	70a2                	ld	ra,40(sp)
ffffffffc0201a82:	69a2                	ld	s3,8(sp)
ffffffffc0201a84:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201a86:	85ca                	mv	a1,s2
ffffffffc0201a88:	87a6                	mv	a5,s1
}
ffffffffc0201a8a:	6942                	ld	s2,16(sp)
ffffffffc0201a8c:	64e2                	ld	s1,24(sp)
ffffffffc0201a8e:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201a90:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc0201a92:	03065633          	divu	a2,a2,a6
ffffffffc0201a96:	8722                	mv	a4,s0
ffffffffc0201a98:	f9bff0ef          	jal	ra,ffffffffc0201a32 <printnum>
ffffffffc0201a9c:	b7f9                	j	ffffffffc0201a6a <printnum+0x38>

ffffffffc0201a9e <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0201a9e:	7119                	addi	sp,sp,-128
ffffffffc0201aa0:	f4a6                	sd	s1,104(sp)
ffffffffc0201aa2:	f0ca                	sd	s2,96(sp)
ffffffffc0201aa4:	ecce                	sd	s3,88(sp)
ffffffffc0201aa6:	e8d2                	sd	s4,80(sp)
ffffffffc0201aa8:	e4d6                	sd	s5,72(sp)
ffffffffc0201aaa:	e0da                	sd	s6,64(sp)
ffffffffc0201aac:	fc5e                	sd	s7,56(sp)
ffffffffc0201aae:	f06a                	sd	s10,32(sp)
ffffffffc0201ab0:	fc86                	sd	ra,120(sp)
ffffffffc0201ab2:	f8a2                	sd	s0,112(sp)
ffffffffc0201ab4:	f862                	sd	s8,48(sp)
ffffffffc0201ab6:	f466                	sd	s9,40(sp)
ffffffffc0201ab8:	ec6e                	sd	s11,24(sp)
ffffffffc0201aba:	892a                	mv	s2,a0
ffffffffc0201abc:	84ae                	mv	s1,a1
ffffffffc0201abe:	8d32                	mv	s10,a2
ffffffffc0201ac0:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201ac2:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0201ac6:	5b7d                	li	s6,-1
ffffffffc0201ac8:	00001a97          	auipc	s5,0x1
ffffffffc0201acc:	42ca8a93          	addi	s5,s5,1068 # ffffffffc0202ef4 <default_pmm_manager+0x1b4>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201ad0:	00001b97          	auipc	s7,0x1
ffffffffc0201ad4:	600b8b93          	addi	s7,s7,1536 # ffffffffc02030d0 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201ad8:	000d4503          	lbu	a0,0(s10)
ffffffffc0201adc:	001d0413          	addi	s0,s10,1
ffffffffc0201ae0:	01350a63          	beq	a0,s3,ffffffffc0201af4 <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc0201ae4:	c121                	beqz	a0,ffffffffc0201b24 <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc0201ae6:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201ae8:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc0201aea:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201aec:	fff44503          	lbu	a0,-1(s0)
ffffffffc0201af0:	ff351ae3          	bne	a0,s3,ffffffffc0201ae4 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201af4:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0201af8:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc0201afc:	4c81                	li	s9,0
ffffffffc0201afe:	4881                	li	a7,0
        width = precision = -1;
ffffffffc0201b00:	5c7d                	li	s8,-1
ffffffffc0201b02:	5dfd                	li	s11,-1
ffffffffc0201b04:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc0201b08:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201b0a:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0201b0e:	0ff5f593          	zext.b	a1,a1
ffffffffc0201b12:	00140d13          	addi	s10,s0,1
ffffffffc0201b16:	04b56263          	bltu	a0,a1,ffffffffc0201b5a <vprintfmt+0xbc>
ffffffffc0201b1a:	058a                	slli	a1,a1,0x2
ffffffffc0201b1c:	95d6                	add	a1,a1,s5
ffffffffc0201b1e:	4194                	lw	a3,0(a1)
ffffffffc0201b20:	96d6                	add	a3,a3,s5
ffffffffc0201b22:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc0201b24:	70e6                	ld	ra,120(sp)
ffffffffc0201b26:	7446                	ld	s0,112(sp)
ffffffffc0201b28:	74a6                	ld	s1,104(sp)
ffffffffc0201b2a:	7906                	ld	s2,96(sp)
ffffffffc0201b2c:	69e6                	ld	s3,88(sp)
ffffffffc0201b2e:	6a46                	ld	s4,80(sp)
ffffffffc0201b30:	6aa6                	ld	s5,72(sp)
ffffffffc0201b32:	6b06                	ld	s6,64(sp)
ffffffffc0201b34:	7be2                	ld	s7,56(sp)
ffffffffc0201b36:	7c42                	ld	s8,48(sp)
ffffffffc0201b38:	7ca2                	ld	s9,40(sp)
ffffffffc0201b3a:	7d02                	ld	s10,32(sp)
ffffffffc0201b3c:	6de2                	ld	s11,24(sp)
ffffffffc0201b3e:	6109                	addi	sp,sp,128
ffffffffc0201b40:	8082                	ret
            padc = '0';
ffffffffc0201b42:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc0201b44:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201b48:	846a                	mv	s0,s10
ffffffffc0201b4a:	00140d13          	addi	s10,s0,1
ffffffffc0201b4e:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0201b52:	0ff5f593          	zext.b	a1,a1
ffffffffc0201b56:	fcb572e3          	bgeu	a0,a1,ffffffffc0201b1a <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc0201b5a:	85a6                	mv	a1,s1
ffffffffc0201b5c:	02500513          	li	a0,37
ffffffffc0201b60:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc0201b62:	fff44783          	lbu	a5,-1(s0)
ffffffffc0201b66:	8d22                	mv	s10,s0
ffffffffc0201b68:	f73788e3          	beq	a5,s3,ffffffffc0201ad8 <vprintfmt+0x3a>
ffffffffc0201b6c:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0201b70:	1d7d                	addi	s10,s10,-1
ffffffffc0201b72:	ff379de3          	bne	a5,s3,ffffffffc0201b6c <vprintfmt+0xce>
ffffffffc0201b76:	b78d                	j	ffffffffc0201ad8 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc0201b78:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc0201b7c:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201b80:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc0201b82:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc0201b86:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0201b8a:	02d86463          	bltu	a6,a3,ffffffffc0201bb2 <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0201b8e:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0201b92:	002c169b          	slliw	a3,s8,0x2
ffffffffc0201b96:	0186873b          	addw	a4,a3,s8
ffffffffc0201b9a:	0017171b          	slliw	a4,a4,0x1
ffffffffc0201b9e:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc0201ba0:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc0201ba4:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc0201ba6:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc0201baa:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0201bae:	fed870e3          	bgeu	a6,a3,ffffffffc0201b8e <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0201bb2:	f40ddce3          	bgez	s11,ffffffffc0201b0a <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0201bb6:	8de2                	mv	s11,s8
ffffffffc0201bb8:	5c7d                	li	s8,-1
ffffffffc0201bba:	bf81                	j	ffffffffc0201b0a <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0201bbc:	fffdc693          	not	a3,s11
ffffffffc0201bc0:	96fd                	srai	a3,a3,0x3f
ffffffffc0201bc2:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201bc6:	00144603          	lbu	a2,1(s0)
ffffffffc0201bca:	2d81                	sext.w	s11,s11
ffffffffc0201bcc:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201bce:	bf35                	j	ffffffffc0201b0a <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0201bd0:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201bd4:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0201bd8:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201bda:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0201bdc:	bfd9                	j	ffffffffc0201bb2 <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0201bde:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201be0:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201be4:	01174463          	blt	a4,a7,ffffffffc0201bec <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0201be8:	1a088e63          	beqz	a7,ffffffffc0201da4 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0201bec:	000a3603          	ld	a2,0(s4)
ffffffffc0201bf0:	46c1                	li	a3,16
ffffffffc0201bf2:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc0201bf4:	2781                	sext.w	a5,a5
ffffffffc0201bf6:	876e                	mv	a4,s11
ffffffffc0201bf8:	85a6                	mv	a1,s1
ffffffffc0201bfa:	854a                	mv	a0,s2
ffffffffc0201bfc:	e37ff0ef          	jal	ra,ffffffffc0201a32 <printnum>
            break;
ffffffffc0201c00:	bde1                	j	ffffffffc0201ad8 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc0201c02:	000a2503          	lw	a0,0(s4)
ffffffffc0201c06:	85a6                	mv	a1,s1
ffffffffc0201c08:	0a21                	addi	s4,s4,8
ffffffffc0201c0a:	9902                	jalr	s2
            break;
ffffffffc0201c0c:	b5f1                	j	ffffffffc0201ad8 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0201c0e:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201c10:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201c14:	01174463          	blt	a4,a7,ffffffffc0201c1c <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0201c18:	18088163          	beqz	a7,ffffffffc0201d9a <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc0201c1c:	000a3603          	ld	a2,0(s4)
ffffffffc0201c20:	46a9                	li	a3,10
ffffffffc0201c22:	8a2e                	mv	s4,a1
ffffffffc0201c24:	bfc1                	j	ffffffffc0201bf4 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c26:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0201c2a:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c2c:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201c2e:	bdf1                	j	ffffffffc0201b0a <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc0201c30:	85a6                	mv	a1,s1
ffffffffc0201c32:	02500513          	li	a0,37
ffffffffc0201c36:	9902                	jalr	s2
            break;
ffffffffc0201c38:	b545                	j	ffffffffc0201ad8 <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c3a:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc0201c3e:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c40:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201c42:	b5e1                	j	ffffffffc0201b0a <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0201c44:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201c46:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201c4a:	01174463          	blt	a4,a7,ffffffffc0201c52 <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0201c4e:	14088163          	beqz	a7,ffffffffc0201d90 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0201c52:	000a3603          	ld	a2,0(s4)
ffffffffc0201c56:	46a1                	li	a3,8
ffffffffc0201c58:	8a2e                	mv	s4,a1
ffffffffc0201c5a:	bf69                	j	ffffffffc0201bf4 <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0201c5c:	03000513          	li	a0,48
ffffffffc0201c60:	85a6                	mv	a1,s1
ffffffffc0201c62:	e03e                	sd	a5,0(sp)
ffffffffc0201c64:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc0201c66:	85a6                	mv	a1,s1
ffffffffc0201c68:	07800513          	li	a0,120
ffffffffc0201c6c:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0201c6e:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0201c70:	6782                	ld	a5,0(sp)
ffffffffc0201c72:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0201c74:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc0201c78:	bfb5                	j	ffffffffc0201bf4 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0201c7a:	000a3403          	ld	s0,0(s4)
ffffffffc0201c7e:	008a0713          	addi	a4,s4,8
ffffffffc0201c82:	e03a                	sd	a4,0(sp)
ffffffffc0201c84:	14040263          	beqz	s0,ffffffffc0201dc8 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc0201c88:	0fb05763          	blez	s11,ffffffffc0201d76 <vprintfmt+0x2d8>
ffffffffc0201c8c:	02d00693          	li	a3,45
ffffffffc0201c90:	0cd79163          	bne	a5,a3,ffffffffc0201d52 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201c94:	00044783          	lbu	a5,0(s0)
ffffffffc0201c98:	0007851b          	sext.w	a0,a5
ffffffffc0201c9c:	cf85                	beqz	a5,ffffffffc0201cd4 <vprintfmt+0x236>
ffffffffc0201c9e:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201ca2:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201ca6:	000c4563          	bltz	s8,ffffffffc0201cb0 <vprintfmt+0x212>
ffffffffc0201caa:	3c7d                	addiw	s8,s8,-1
ffffffffc0201cac:	036c0263          	beq	s8,s6,ffffffffc0201cd0 <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0201cb0:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201cb2:	0e0c8e63          	beqz	s9,ffffffffc0201dae <vprintfmt+0x310>
ffffffffc0201cb6:	3781                	addiw	a5,a5,-32
ffffffffc0201cb8:	0ef47b63          	bgeu	s0,a5,ffffffffc0201dae <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0201cbc:	03f00513          	li	a0,63
ffffffffc0201cc0:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201cc2:	000a4783          	lbu	a5,0(s4)
ffffffffc0201cc6:	3dfd                	addiw	s11,s11,-1
ffffffffc0201cc8:	0a05                	addi	s4,s4,1
ffffffffc0201cca:	0007851b          	sext.w	a0,a5
ffffffffc0201cce:	ffe1                	bnez	a5,ffffffffc0201ca6 <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0201cd0:	01b05963          	blez	s11,ffffffffc0201ce2 <vprintfmt+0x244>
ffffffffc0201cd4:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0201cd6:	85a6                	mv	a1,s1
ffffffffc0201cd8:	02000513          	li	a0,32
ffffffffc0201cdc:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0201cde:	fe0d9be3          	bnez	s11,ffffffffc0201cd4 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0201ce2:	6a02                	ld	s4,0(sp)
ffffffffc0201ce4:	bbd5                	j	ffffffffc0201ad8 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0201ce6:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201ce8:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc0201cec:	01174463          	blt	a4,a7,ffffffffc0201cf4 <vprintfmt+0x256>
    else if (lflag) {
ffffffffc0201cf0:	08088d63          	beqz	a7,ffffffffc0201d8a <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc0201cf4:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0201cf8:	0a044d63          	bltz	s0,ffffffffc0201db2 <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0201cfc:	8622                	mv	a2,s0
ffffffffc0201cfe:	8a66                	mv	s4,s9
ffffffffc0201d00:	46a9                	li	a3,10
ffffffffc0201d02:	bdcd                	j	ffffffffc0201bf4 <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc0201d04:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201d08:	4719                	li	a4,6
            err = va_arg(ap, int);
ffffffffc0201d0a:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc0201d0c:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0201d10:	8fb5                	xor	a5,a5,a3
ffffffffc0201d12:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201d16:	02d74163          	blt	a4,a3,ffffffffc0201d38 <vprintfmt+0x29a>
ffffffffc0201d1a:	00369793          	slli	a5,a3,0x3
ffffffffc0201d1e:	97de                	add	a5,a5,s7
ffffffffc0201d20:	639c                	ld	a5,0(a5)
ffffffffc0201d22:	cb99                	beqz	a5,ffffffffc0201d38 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc0201d24:	86be                	mv	a3,a5
ffffffffc0201d26:	00001617          	auipc	a2,0x1
ffffffffc0201d2a:	1ca60613          	addi	a2,a2,458 # ffffffffc0202ef0 <default_pmm_manager+0x1b0>
ffffffffc0201d2e:	85a6                	mv	a1,s1
ffffffffc0201d30:	854a                	mv	a0,s2
ffffffffc0201d32:	0ce000ef          	jal	ra,ffffffffc0201e00 <printfmt>
ffffffffc0201d36:	b34d                	j	ffffffffc0201ad8 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc0201d38:	00001617          	auipc	a2,0x1
ffffffffc0201d3c:	1a860613          	addi	a2,a2,424 # ffffffffc0202ee0 <default_pmm_manager+0x1a0>
ffffffffc0201d40:	85a6                	mv	a1,s1
ffffffffc0201d42:	854a                	mv	a0,s2
ffffffffc0201d44:	0bc000ef          	jal	ra,ffffffffc0201e00 <printfmt>
ffffffffc0201d48:	bb41                	j	ffffffffc0201ad8 <vprintfmt+0x3a>
                p = "(null)";
ffffffffc0201d4a:	00001417          	auipc	s0,0x1
ffffffffc0201d4e:	18e40413          	addi	s0,s0,398 # ffffffffc0202ed8 <default_pmm_manager+0x198>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201d52:	85e2                	mv	a1,s8
ffffffffc0201d54:	8522                	mv	a0,s0
ffffffffc0201d56:	e43e                	sd	a5,8(sp)
ffffffffc0201d58:	200000ef          	jal	ra,ffffffffc0201f58 <strnlen>
ffffffffc0201d5c:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0201d60:	01b05b63          	blez	s11,ffffffffc0201d76 <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc0201d64:	67a2                	ld	a5,8(sp)
ffffffffc0201d66:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201d6a:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0201d6c:	85a6                	mv	a1,s1
ffffffffc0201d6e:	8552                	mv	a0,s4
ffffffffc0201d70:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201d72:	fe0d9ce3          	bnez	s11,ffffffffc0201d6a <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201d76:	00044783          	lbu	a5,0(s0)
ffffffffc0201d7a:	00140a13          	addi	s4,s0,1
ffffffffc0201d7e:	0007851b          	sext.w	a0,a5
ffffffffc0201d82:	d3a5                	beqz	a5,ffffffffc0201ce2 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201d84:	05e00413          	li	s0,94
ffffffffc0201d88:	bf39                	j	ffffffffc0201ca6 <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc0201d8a:	000a2403          	lw	s0,0(s4)
ffffffffc0201d8e:	b7ad                	j	ffffffffc0201cf8 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0201d90:	000a6603          	lwu	a2,0(s4)
ffffffffc0201d94:	46a1                	li	a3,8
ffffffffc0201d96:	8a2e                	mv	s4,a1
ffffffffc0201d98:	bdb1                	j	ffffffffc0201bf4 <vprintfmt+0x156>
ffffffffc0201d9a:	000a6603          	lwu	a2,0(s4)
ffffffffc0201d9e:	46a9                	li	a3,10
ffffffffc0201da0:	8a2e                	mv	s4,a1
ffffffffc0201da2:	bd89                	j	ffffffffc0201bf4 <vprintfmt+0x156>
ffffffffc0201da4:	000a6603          	lwu	a2,0(s4)
ffffffffc0201da8:	46c1                	li	a3,16
ffffffffc0201daa:	8a2e                	mv	s4,a1
ffffffffc0201dac:	b5a1                	j	ffffffffc0201bf4 <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0201dae:	9902                	jalr	s2
ffffffffc0201db0:	bf09                	j	ffffffffc0201cc2 <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0201db2:	85a6                	mv	a1,s1
ffffffffc0201db4:	02d00513          	li	a0,45
ffffffffc0201db8:	e03e                	sd	a5,0(sp)
ffffffffc0201dba:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0201dbc:	6782                	ld	a5,0(sp)
ffffffffc0201dbe:	8a66                	mv	s4,s9
ffffffffc0201dc0:	40800633          	neg	a2,s0
ffffffffc0201dc4:	46a9                	li	a3,10
ffffffffc0201dc6:	b53d                	j	ffffffffc0201bf4 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0201dc8:	03b05163          	blez	s11,ffffffffc0201dea <vprintfmt+0x34c>
ffffffffc0201dcc:	02d00693          	li	a3,45
ffffffffc0201dd0:	f6d79de3          	bne	a5,a3,ffffffffc0201d4a <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0201dd4:	00001417          	auipc	s0,0x1
ffffffffc0201dd8:	10440413          	addi	s0,s0,260 # ffffffffc0202ed8 <default_pmm_manager+0x198>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201ddc:	02800793          	li	a5,40
ffffffffc0201de0:	02800513          	li	a0,40
ffffffffc0201de4:	00140a13          	addi	s4,s0,1
ffffffffc0201de8:	bd6d                	j	ffffffffc0201ca2 <vprintfmt+0x204>
ffffffffc0201dea:	00001a17          	auipc	s4,0x1
ffffffffc0201dee:	0efa0a13          	addi	s4,s4,239 # ffffffffc0202ed9 <default_pmm_manager+0x199>
ffffffffc0201df2:	02800513          	li	a0,40
ffffffffc0201df6:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201dfa:	05e00413          	li	s0,94
ffffffffc0201dfe:	b565                	j	ffffffffc0201ca6 <vprintfmt+0x208>

ffffffffc0201e00 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201e00:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc0201e02:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201e06:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0201e08:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201e0a:	ec06                	sd	ra,24(sp)
ffffffffc0201e0c:	f83a                	sd	a4,48(sp)
ffffffffc0201e0e:	fc3e                	sd	a5,56(sp)
ffffffffc0201e10:	e0c2                	sd	a6,64(sp)
ffffffffc0201e12:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0201e14:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0201e16:	c89ff0ef          	jal	ra,ffffffffc0201a9e <vprintfmt>
}
ffffffffc0201e1a:	60e2                	ld	ra,24(sp)
ffffffffc0201e1c:	6161                	addi	sp,sp,80
ffffffffc0201e1e:	8082                	ret

ffffffffc0201e20 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc0201e20:	715d                	addi	sp,sp,-80
ffffffffc0201e22:	e486                	sd	ra,72(sp)
ffffffffc0201e24:	e0a6                	sd	s1,64(sp)
ffffffffc0201e26:	fc4a                	sd	s2,56(sp)
ffffffffc0201e28:	f84e                	sd	s3,48(sp)
ffffffffc0201e2a:	f452                	sd	s4,40(sp)
ffffffffc0201e2c:	f056                	sd	s5,32(sp)
ffffffffc0201e2e:	ec5a                	sd	s6,24(sp)
ffffffffc0201e30:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc0201e32:	c901                	beqz	a0,ffffffffc0201e42 <readline+0x22>
ffffffffc0201e34:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc0201e36:	00001517          	auipc	a0,0x1
ffffffffc0201e3a:	0ba50513          	addi	a0,a0,186 # ffffffffc0202ef0 <default_pmm_manager+0x1b0>
ffffffffc0201e3e:	ac6fe0ef          	jal	ra,ffffffffc0200104 <cprintf>
readline(const char *prompt) {
ffffffffc0201e42:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e44:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc0201e46:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc0201e48:	4aa9                	li	s5,10
ffffffffc0201e4a:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc0201e4c:	00005b97          	auipc	s7,0x5
ffffffffc0201e50:	1f4b8b93          	addi	s7,s7,500 # ffffffffc0207040 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e54:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc0201e58:	b24fe0ef          	jal	ra,ffffffffc020017c <getchar>
        if (c < 0) {
ffffffffc0201e5c:	00054a63          	bltz	a0,ffffffffc0201e70 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e60:	00a95a63          	bge	s2,a0,ffffffffc0201e74 <readline+0x54>
ffffffffc0201e64:	029a5263          	bge	s4,s1,ffffffffc0201e88 <readline+0x68>
        c = getchar();
ffffffffc0201e68:	b14fe0ef          	jal	ra,ffffffffc020017c <getchar>
        if (c < 0) {
ffffffffc0201e6c:	fe055ae3          	bgez	a0,ffffffffc0201e60 <readline+0x40>
            return NULL;
ffffffffc0201e70:	4501                	li	a0,0
ffffffffc0201e72:	a091                	j	ffffffffc0201eb6 <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc0201e74:	03351463          	bne	a0,s3,ffffffffc0201e9c <readline+0x7c>
ffffffffc0201e78:	e8a9                	bnez	s1,ffffffffc0201eca <readline+0xaa>
        c = getchar();
ffffffffc0201e7a:	b02fe0ef          	jal	ra,ffffffffc020017c <getchar>
        if (c < 0) {
ffffffffc0201e7e:	fe0549e3          	bltz	a0,ffffffffc0201e70 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e82:	fea959e3          	bge	s2,a0,ffffffffc0201e74 <readline+0x54>
ffffffffc0201e86:	4481                	li	s1,0
            cputchar(c);
ffffffffc0201e88:	e42a                	sd	a0,8(sp)
ffffffffc0201e8a:	ab0fe0ef          	jal	ra,ffffffffc020013a <cputchar>
            buf[i ++] = c;
ffffffffc0201e8e:	6522                	ld	a0,8(sp)
ffffffffc0201e90:	009b87b3          	add	a5,s7,s1
ffffffffc0201e94:	2485                	addiw	s1,s1,1
ffffffffc0201e96:	00a78023          	sb	a0,0(a5)
ffffffffc0201e9a:	bf7d                	j	ffffffffc0201e58 <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc0201e9c:	01550463          	beq	a0,s5,ffffffffc0201ea4 <readline+0x84>
ffffffffc0201ea0:	fb651ce3          	bne	a0,s6,ffffffffc0201e58 <readline+0x38>
            cputchar(c);
ffffffffc0201ea4:	a96fe0ef          	jal	ra,ffffffffc020013a <cputchar>
            buf[i] = '\0';
ffffffffc0201ea8:	00005517          	auipc	a0,0x5
ffffffffc0201eac:	19850513          	addi	a0,a0,408 # ffffffffc0207040 <buf>
ffffffffc0201eb0:	94aa                	add	s1,s1,a0
ffffffffc0201eb2:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc0201eb6:	60a6                	ld	ra,72(sp)
ffffffffc0201eb8:	6486                	ld	s1,64(sp)
ffffffffc0201eba:	7962                	ld	s2,56(sp)
ffffffffc0201ebc:	79c2                	ld	s3,48(sp)
ffffffffc0201ebe:	7a22                	ld	s4,40(sp)
ffffffffc0201ec0:	7a82                	ld	s5,32(sp)
ffffffffc0201ec2:	6b62                	ld	s6,24(sp)
ffffffffc0201ec4:	6bc2                	ld	s7,16(sp)
ffffffffc0201ec6:	6161                	addi	sp,sp,80
ffffffffc0201ec8:	8082                	ret
            cputchar(c);
ffffffffc0201eca:	4521                	li	a0,8
ffffffffc0201ecc:	a6efe0ef          	jal	ra,ffffffffc020013a <cputchar>
            i --;
ffffffffc0201ed0:	34fd                	addiw	s1,s1,-1
ffffffffc0201ed2:	b759                	j	ffffffffc0201e58 <readline+0x38>

ffffffffc0201ed4 <sbi_console_putchar>:
uint64_t SBI_REMOTE_SFENCE_VMA_ASID = 7;
uint64_t SBI_SHUTDOWN = 8;

uint64_t sbi_call(uint64_t sbi_type, uint64_t arg0, uint64_t arg1, uint64_t arg2) {
    uint64_t ret_val;
    __asm__ volatile (
ffffffffc0201ed4:	4781                	li	a5,0
ffffffffc0201ed6:	00005717          	auipc	a4,0x5
ffffffffc0201eda:	14273703          	ld	a4,322(a4) # ffffffffc0207018 <SBI_CONSOLE_PUTCHAR>
ffffffffc0201ede:	88ba                	mv	a7,a4
ffffffffc0201ee0:	852a                	mv	a0,a0
ffffffffc0201ee2:	85be                	mv	a1,a5
ffffffffc0201ee4:	863e                	mv	a2,a5
ffffffffc0201ee6:	00000073          	ecall
ffffffffc0201eea:	87aa                	mv	a5,a0
    return ret_val;
}

void sbi_console_putchar(unsigned char ch) {
    sbi_call(SBI_CONSOLE_PUTCHAR, ch, 0, 0);
}
ffffffffc0201eec:	8082                	ret

ffffffffc0201eee <sbi_set_timer>:
    __asm__ volatile (
ffffffffc0201eee:	4781                	li	a5,0
ffffffffc0201ef0:	00005717          	auipc	a4,0x5
ffffffffc0201ef4:	5a873703          	ld	a4,1448(a4) # ffffffffc0207498 <SBI_SET_TIMER>
ffffffffc0201ef8:	88ba                	mv	a7,a4
ffffffffc0201efa:	852a                	mv	a0,a0
ffffffffc0201efc:	85be                	mv	a1,a5
ffffffffc0201efe:	863e                	mv	a2,a5
ffffffffc0201f00:	00000073          	ecall
ffffffffc0201f04:	87aa                	mv	a5,a0

void sbi_set_timer(unsigned long long stime_value) {
    sbi_call(SBI_SET_TIMER, stime_value, 0, 0);
}
ffffffffc0201f06:	8082                	ret

ffffffffc0201f08 <sbi_console_getchar>:
    __asm__ volatile (
ffffffffc0201f08:	4501                	li	a0,0
ffffffffc0201f0a:	00005797          	auipc	a5,0x5
ffffffffc0201f0e:	1067b783          	ld	a5,262(a5) # ffffffffc0207010 <SBI_CONSOLE_GETCHAR>
ffffffffc0201f12:	88be                	mv	a7,a5
ffffffffc0201f14:	852a                	mv	a0,a0
ffffffffc0201f16:	85aa                	mv	a1,a0
ffffffffc0201f18:	862a                	mv	a2,a0
ffffffffc0201f1a:	00000073          	ecall
ffffffffc0201f1e:	852a                	mv	a0,a0

int sbi_console_getchar(void) {
    return sbi_call(SBI_CONSOLE_GETCHAR, 0, 0, 0);
}
ffffffffc0201f20:	2501                	sext.w	a0,a0
ffffffffc0201f22:	8082                	ret

ffffffffc0201f24 <sbi_shutdown>:
    __asm__ volatile (
ffffffffc0201f24:	4781                	li	a5,0
ffffffffc0201f26:	00005717          	auipc	a4,0x5
ffffffffc0201f2a:	0fa73703          	ld	a4,250(a4) # ffffffffc0207020 <SBI_SHUTDOWN>
ffffffffc0201f2e:	88ba                	mv	a7,a4
ffffffffc0201f30:	853e                	mv	a0,a5
ffffffffc0201f32:	85be                	mv	a1,a5
ffffffffc0201f34:	863e                	mv	a2,a5
ffffffffc0201f36:	00000073          	ecall
ffffffffc0201f3a:	87aa                	mv	a5,a0

void sbi_shutdown(void)
{
	sbi_call(SBI_SHUTDOWN, 0, 0, 0);
ffffffffc0201f3c:	8082                	ret

ffffffffc0201f3e <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc0201f3e:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc0201f42:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc0201f44:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc0201f46:	cb81                	beqz	a5,ffffffffc0201f56 <strlen+0x18>
        cnt ++;
ffffffffc0201f48:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc0201f4a:	00a707b3          	add	a5,a4,a0
ffffffffc0201f4e:	0007c783          	lbu	a5,0(a5)
ffffffffc0201f52:	fbfd                	bnez	a5,ffffffffc0201f48 <strlen+0xa>
ffffffffc0201f54:	8082                	ret
    }
    return cnt;
}
ffffffffc0201f56:	8082                	ret

ffffffffc0201f58 <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc0201f58:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc0201f5a:	e589                	bnez	a1,ffffffffc0201f64 <strnlen+0xc>
ffffffffc0201f5c:	a811                	j	ffffffffc0201f70 <strnlen+0x18>
        cnt ++;
ffffffffc0201f5e:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc0201f60:	00f58863          	beq	a1,a5,ffffffffc0201f70 <strnlen+0x18>
ffffffffc0201f64:	00f50733          	add	a4,a0,a5
ffffffffc0201f68:	00074703          	lbu	a4,0(a4)
ffffffffc0201f6c:	fb6d                	bnez	a4,ffffffffc0201f5e <strnlen+0x6>
ffffffffc0201f6e:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc0201f70:	852e                	mv	a0,a1
ffffffffc0201f72:	8082                	ret

ffffffffc0201f74 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201f74:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201f78:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201f7c:	cb89                	beqz	a5,ffffffffc0201f8e <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc0201f7e:	0505                	addi	a0,a0,1
ffffffffc0201f80:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201f82:	fee789e3          	beq	a5,a4,ffffffffc0201f74 <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201f86:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc0201f8a:	9d19                	subw	a0,a0,a4
ffffffffc0201f8c:	8082                	ret
ffffffffc0201f8e:	4501                	li	a0,0
ffffffffc0201f90:	bfed                	j	ffffffffc0201f8a <strcmp+0x16>

ffffffffc0201f92 <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201f92:	c20d                	beqz	a2,ffffffffc0201fb4 <strncmp+0x22>
ffffffffc0201f94:	962e                	add	a2,a2,a1
ffffffffc0201f96:	a031                	j	ffffffffc0201fa2 <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc0201f98:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201f9a:	00e79a63          	bne	a5,a4,ffffffffc0201fae <strncmp+0x1c>
ffffffffc0201f9e:	00b60b63          	beq	a2,a1,ffffffffc0201fb4 <strncmp+0x22>
ffffffffc0201fa2:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc0201fa6:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201fa8:	fff5c703          	lbu	a4,-1(a1)
ffffffffc0201fac:	f7f5                	bnez	a5,ffffffffc0201f98 <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201fae:	40e7853b          	subw	a0,a5,a4
}
ffffffffc0201fb2:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201fb4:	4501                	li	a0,0
ffffffffc0201fb6:	8082                	ret

ffffffffc0201fb8 <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc0201fb8:	00054783          	lbu	a5,0(a0)
ffffffffc0201fbc:	c799                	beqz	a5,ffffffffc0201fca <strchr+0x12>
        if (*s == c) {
ffffffffc0201fbe:	00f58763          	beq	a1,a5,ffffffffc0201fcc <strchr+0x14>
    while (*s != '\0') {
ffffffffc0201fc2:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc0201fc6:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc0201fc8:	fbfd                	bnez	a5,ffffffffc0201fbe <strchr+0x6>
    }
    return NULL;
ffffffffc0201fca:	4501                	li	a0,0
}
ffffffffc0201fcc:	8082                	ret

ffffffffc0201fce <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0201fce:	ca01                	beqz	a2,ffffffffc0201fde <memset+0x10>
ffffffffc0201fd0:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc0201fd2:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc0201fd4:	0785                	addi	a5,a5,1
ffffffffc0201fd6:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0201fda:	fec79de3          	bne	a5,a2,ffffffffc0201fd4 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0201fde:	8082                	ret
