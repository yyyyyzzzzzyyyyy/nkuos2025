
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
    # 跳转到 kern_init
    lui t0, %hi(kern_init)
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc0200044:	0d828293          	addi	t0,t0,216 # ffffffffc02000d8 <kern_init>
    jr t0
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
ffffffffc020004a:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[];
    cprintf("Special kernel symbols:\n");
ffffffffc020004c:	00002517          	auipc	a0,0x2
ffffffffc0200050:	f9c50513          	addi	a0,a0,-100 # ffffffffc0201fe8 <etext+0x2>
void print_kerninfo(void) {
ffffffffc0200054:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc0200056:	12e000ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("  entry  0x%016lx (virtual)\n", (uintptr_t)kern_init);
ffffffffc020005a:	00000597          	auipc	a1,0x0
ffffffffc020005e:	07e58593          	addi	a1,a1,126 # ffffffffc02000d8 <kern_init>
ffffffffc0200062:	00002517          	auipc	a0,0x2
ffffffffc0200066:	fa650513          	addi	a0,a0,-90 # ffffffffc0202008 <etext+0x22>
ffffffffc020006a:	11a000ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("  etext  0x%016lx (virtual)\n", etext);
ffffffffc020006e:	00002597          	auipc	a1,0x2
ffffffffc0200072:	f7858593          	addi	a1,a1,-136 # ffffffffc0201fe6 <etext>
ffffffffc0200076:	00002517          	auipc	a0,0x2
ffffffffc020007a:	fb250513          	addi	a0,a0,-78 # ffffffffc0202028 <etext+0x42>
ffffffffc020007e:	106000ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("  edata  0x%016lx (virtual)\n", edata);
ffffffffc0200082:	00007597          	auipc	a1,0x7
ffffffffc0200086:	f9658593          	addi	a1,a1,-106 # ffffffffc0207018 <buddy_free_area>
ffffffffc020008a:	00002517          	auipc	a0,0x2
ffffffffc020008e:	fbe50513          	addi	a0,a0,-66 # ffffffffc0202048 <etext+0x62>
ffffffffc0200092:	0f2000ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("  end    0x%016lx (virtual)\n", end);
ffffffffc0200096:	00007597          	auipc	a1,0x7
ffffffffc020009a:	23a58593          	addi	a1,a1,570 # ffffffffc02072d0 <end>
ffffffffc020009e:	00002517          	auipc	a0,0x2
ffffffffc02000a2:	fca50513          	addi	a0,a0,-54 # ffffffffc0202068 <etext+0x82>
ffffffffc02000a6:	0de000ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - (char*)kern_init + 1023) / 1024);
ffffffffc02000aa:	00007597          	auipc	a1,0x7
ffffffffc02000ae:	62558593          	addi	a1,a1,1573 # ffffffffc02076cf <end+0x3ff>
ffffffffc02000b2:	00000797          	auipc	a5,0x0
ffffffffc02000b6:	02678793          	addi	a5,a5,38 # ffffffffc02000d8 <kern_init>
ffffffffc02000ba:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02000be:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc02000c2:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02000c4:	3ff5f593          	andi	a1,a1,1023
ffffffffc02000c8:	95be                	add	a1,a1,a5
ffffffffc02000ca:	85a9                	srai	a1,a1,0xa
ffffffffc02000cc:	00002517          	auipc	a0,0x2
ffffffffc02000d0:	fbc50513          	addi	a0,a0,-68 # ffffffffc0202088 <etext+0xa2>
}
ffffffffc02000d4:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02000d6:	a07d                	j	ffffffffc0200184 <cprintf>

ffffffffc02000d8 <kern_init>:

int kern_init(void) {
    extern char edata[], end[];
    memset(edata, 0, end - edata);
ffffffffc02000d8:	00007517          	auipc	a0,0x7
ffffffffc02000dc:	f4050513          	addi	a0,a0,-192 # ffffffffc0207018 <buddy_free_area>
ffffffffc02000e0:	00007617          	auipc	a2,0x7
ffffffffc02000e4:	1f060613          	addi	a2,a2,496 # ffffffffc02072d0 <end>
int kern_init(void) {
ffffffffc02000e8:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc02000ea:	8e09                	sub	a2,a2,a0
ffffffffc02000ec:	4581                	li	a1,0
int kern_init(void) {
ffffffffc02000ee:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc02000f0:	6e5010ef          	jal	ra,ffffffffc0201fd4 <memset>
    dtb_init();
ffffffffc02000f4:	164000ef          	jal	ra,ffffffffc0200258 <dtb_init>
    cons_init();  // init the console
ffffffffc02000f8:	156000ef          	jal	ra,ffffffffc020024e <cons_init>
    const char *message = "(THU.CST) os is loading ...\0";
    //cprintf("%s\n\n", message);
    cputs(message);
ffffffffc02000fc:	00002517          	auipc	a0,0x2
ffffffffc0200100:	02450513          	addi	a0,a0,36 # ffffffffc0202120 <etext+0x13a>
ffffffffc0200104:	0b6000ef          	jal	ra,ffffffffc02001ba <cputs>

    print_kerninfo();
ffffffffc0200108:	f43ff0ef          	jal	ra,ffffffffc020004a <print_kerninfo>

    // grade_backtrace();
    pmm_init();  // init physical memory management
ffffffffc020010c:	08e010ef          	jal	ra,ffffffffc020119a <pmm_init>

    //���ɲ���
// SLUB����������
    cprintf("\n");
ffffffffc0200110:	00003517          	auipc	a0,0x3
ffffffffc0200114:	a9850513          	addi	a0,a0,-1384 # ffffffffc0202ba8 <etext+0xbc2>
ffffffffc0200118:	06c000ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("Initializing SLUB allocator...\n");
ffffffffc020011c:	00002517          	auipc	a0,0x2
ffffffffc0200120:	f9c50513          	addi	a0,a0,-100 # ffffffffc02020b8 <etext+0xd2>
ffffffffc0200124:	060000ef          	jal	ra,ffffffffc0200184 <cprintf>
    slub_init();  // ��ʼ�� SLUB
ffffffffc0200128:	4da010ef          	jal	ra,ffffffffc0201602 <slub_init>
    //�����ͷŲ��Ժ���
    slub_alloc_free_verification();
ffffffffc020012c:	62a010ef          	jal	ra,ffffffffc0201756 <slub_alloc_free_verification>

    cprintf("\n All SLUB Tests Passed! \n");
ffffffffc0200130:	00002517          	auipc	a0,0x2
ffffffffc0200134:	fa850513          	addi	a0,a0,-88 # ffffffffc02020d8 <etext+0xf2>
ffffffffc0200138:	04c000ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("SLUB allocator is working correctly.\n");
ffffffffc020013c:	00002517          	auipc	a0,0x2
ffffffffc0200140:	fbc50513          	addi	a0,a0,-68 # ffffffffc02020f8 <etext+0x112>
ffffffffc0200144:	040000ef          	jal	ra,ffffffffc0200184 <cprintf>
    /* do nothing */
    while (1)
ffffffffc0200148:	a001                	j	ffffffffc0200148 <kern_init+0x70>

ffffffffc020014a <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
ffffffffc020014a:	1141                	addi	sp,sp,-16
ffffffffc020014c:	e022                	sd	s0,0(sp)
ffffffffc020014e:	e406                	sd	ra,8(sp)
ffffffffc0200150:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc0200152:	0fe000ef          	jal	ra,ffffffffc0200250 <cons_putc>
    (*cnt) ++;
ffffffffc0200156:	401c                	lw	a5,0(s0)
}
ffffffffc0200158:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
ffffffffc020015a:	2785                	addiw	a5,a5,1
ffffffffc020015c:	c01c                	sw	a5,0(s0)
}
ffffffffc020015e:	6402                	ld	s0,0(sp)
ffffffffc0200160:	0141                	addi	sp,sp,16
ffffffffc0200162:	8082                	ret

ffffffffc0200164 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
ffffffffc0200164:	1101                	addi	sp,sp,-32
ffffffffc0200166:	862a                	mv	a2,a0
ffffffffc0200168:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc020016a:	00000517          	auipc	a0,0x0
ffffffffc020016e:	fe050513          	addi	a0,a0,-32 # ffffffffc020014a <cputch>
ffffffffc0200172:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
ffffffffc0200174:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc0200176:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc0200178:	235010ef          	jal	ra,ffffffffc0201bac <vprintfmt>
    return cnt;
}
ffffffffc020017c:	60e2                	ld	ra,24(sp)
ffffffffc020017e:	4532                	lw	a0,12(sp)
ffffffffc0200180:	6105                	addi	sp,sp,32
ffffffffc0200182:	8082                	ret

ffffffffc0200184 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
ffffffffc0200184:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc0200186:	02810313          	addi	t1,sp,40 # ffffffffc0206028 <boot_page_table_sv39+0x28>
cprintf(const char *fmt, ...) {
ffffffffc020018a:	8e2a                	mv	t3,a0
ffffffffc020018c:	f42e                	sd	a1,40(sp)
ffffffffc020018e:	f832                	sd	a2,48(sp)
ffffffffc0200190:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc0200192:	00000517          	auipc	a0,0x0
ffffffffc0200196:	fb850513          	addi	a0,a0,-72 # ffffffffc020014a <cputch>
ffffffffc020019a:	004c                	addi	a1,sp,4
ffffffffc020019c:	869a                	mv	a3,t1
ffffffffc020019e:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
ffffffffc02001a0:	ec06                	sd	ra,24(sp)
ffffffffc02001a2:	e0ba                	sd	a4,64(sp)
ffffffffc02001a4:	e4be                	sd	a5,72(sp)
ffffffffc02001a6:	e8c2                	sd	a6,80(sp)
ffffffffc02001a8:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc02001aa:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc02001ac:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02001ae:	1ff010ef          	jal	ra,ffffffffc0201bac <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc02001b2:	60e2                	ld	ra,24(sp)
ffffffffc02001b4:	4512                	lw	a0,4(sp)
ffffffffc02001b6:	6125                	addi	sp,sp,96
ffffffffc02001b8:	8082                	ret

ffffffffc02001ba <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
ffffffffc02001ba:	1101                	addi	sp,sp,-32
ffffffffc02001bc:	e822                	sd	s0,16(sp)
ffffffffc02001be:	ec06                	sd	ra,24(sp)
ffffffffc02001c0:	e426                	sd	s1,8(sp)
ffffffffc02001c2:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
ffffffffc02001c4:	00054503          	lbu	a0,0(a0)
ffffffffc02001c8:	c51d                	beqz	a0,ffffffffc02001f6 <cputs+0x3c>
ffffffffc02001ca:	0405                	addi	s0,s0,1
ffffffffc02001cc:	4485                	li	s1,1
ffffffffc02001ce:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc02001d0:	080000ef          	jal	ra,ffffffffc0200250 <cons_putc>
    while ((c = *str ++) != '\0') {
ffffffffc02001d4:	00044503          	lbu	a0,0(s0)
ffffffffc02001d8:	008487bb          	addw	a5,s1,s0
ffffffffc02001dc:	0405                	addi	s0,s0,1
ffffffffc02001de:	f96d                	bnez	a0,ffffffffc02001d0 <cputs+0x16>
    (*cnt) ++;
ffffffffc02001e0:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc02001e4:	4529                	li	a0,10
ffffffffc02001e6:	06a000ef          	jal	ra,ffffffffc0200250 <cons_putc>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc02001ea:	60e2                	ld	ra,24(sp)
ffffffffc02001ec:	8522                	mv	a0,s0
ffffffffc02001ee:	6442                	ld	s0,16(sp)
ffffffffc02001f0:	64a2                	ld	s1,8(sp)
ffffffffc02001f2:	6105                	addi	sp,sp,32
ffffffffc02001f4:	8082                	ret
    while ((c = *str ++) != '\0') {
ffffffffc02001f6:	4405                	li	s0,1
ffffffffc02001f8:	b7f5                	j	ffffffffc02001e4 <cputs+0x2a>

ffffffffc02001fa <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
ffffffffc02001fa:	00007317          	auipc	t1,0x7
ffffffffc02001fe:	08e30313          	addi	t1,t1,142 # ffffffffc0207288 <is_panic>
ffffffffc0200202:	00032e03          	lw	t3,0(t1)
__panic(const char *file, int line, const char *fmt, ...) {
ffffffffc0200206:	715d                	addi	sp,sp,-80
ffffffffc0200208:	ec06                	sd	ra,24(sp)
ffffffffc020020a:	e822                	sd	s0,16(sp)
ffffffffc020020c:	f436                	sd	a3,40(sp)
ffffffffc020020e:	f83a                	sd	a4,48(sp)
ffffffffc0200210:	fc3e                	sd	a5,56(sp)
ffffffffc0200212:	e0c2                	sd	a6,64(sp)
ffffffffc0200214:	e4c6                	sd	a7,72(sp)
    if (is_panic) {
ffffffffc0200216:	000e0363          	beqz	t3,ffffffffc020021c <__panic+0x22>
    vcprintf(fmt, ap);
    cprintf("\n");
    va_end(ap);

panic_dead:
    while (1) {
ffffffffc020021a:	a001                	j	ffffffffc020021a <__panic+0x20>
    is_panic = 1;
ffffffffc020021c:	4785                	li	a5,1
ffffffffc020021e:	00f32023          	sw	a5,0(t1)
    va_start(ap, fmt);
ffffffffc0200222:	8432                	mv	s0,a2
ffffffffc0200224:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc0200226:	862e                	mv	a2,a1
ffffffffc0200228:	85aa                	mv	a1,a0
ffffffffc020022a:	00002517          	auipc	a0,0x2
ffffffffc020022e:	f1650513          	addi	a0,a0,-234 # ffffffffc0202140 <etext+0x15a>
    va_start(ap, fmt);
ffffffffc0200232:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc0200234:	f51ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200238:	65a2                	ld	a1,8(sp)
ffffffffc020023a:	8522                	mv	a0,s0
ffffffffc020023c:	f29ff0ef          	jal	ra,ffffffffc0200164 <vcprintf>
    cprintf("\n");
ffffffffc0200240:	00003517          	auipc	a0,0x3
ffffffffc0200244:	96850513          	addi	a0,a0,-1688 # ffffffffc0202ba8 <etext+0xbc2>
ffffffffc0200248:	f3dff0ef          	jal	ra,ffffffffc0200184 <cprintf>
ffffffffc020024c:	b7f9                	j	ffffffffc020021a <__panic+0x20>

ffffffffc020024e <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc020024e:	8082                	ret

ffffffffc0200250 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) { sbi_console_putchar((unsigned char)c); }
ffffffffc0200250:	0ff57513          	zext.b	a0,a0
ffffffffc0200254:	4db0106f          	j	ffffffffc0201f2e <sbi_console_putchar>

ffffffffc0200258 <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc0200258:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc020025a:	00002517          	auipc	a0,0x2
ffffffffc020025e:	f0650513          	addi	a0,a0,-250 # ffffffffc0202160 <etext+0x17a>
void dtb_init(void) {
ffffffffc0200262:	fc86                	sd	ra,120(sp)
ffffffffc0200264:	f8a2                	sd	s0,112(sp)
ffffffffc0200266:	e8d2                	sd	s4,80(sp)
ffffffffc0200268:	f4a6                	sd	s1,104(sp)
ffffffffc020026a:	f0ca                	sd	s2,96(sp)
ffffffffc020026c:	ecce                	sd	s3,88(sp)
ffffffffc020026e:	e4d6                	sd	s5,72(sp)
ffffffffc0200270:	e0da                	sd	s6,64(sp)
ffffffffc0200272:	fc5e                	sd	s7,56(sp)
ffffffffc0200274:	f862                	sd	s8,48(sp)
ffffffffc0200276:	f466                	sd	s9,40(sp)
ffffffffc0200278:	f06a                	sd	s10,32(sp)
ffffffffc020027a:	ec6e                	sd	s11,24(sp)
    cprintf("DTB Init\n");
ffffffffc020027c:	f09ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("HartID: %ld\n", boot_hartid);
ffffffffc0200280:	00007597          	auipc	a1,0x7
ffffffffc0200284:	d805b583          	ld	a1,-640(a1) # ffffffffc0207000 <boot_hartid>
ffffffffc0200288:	00002517          	auipc	a0,0x2
ffffffffc020028c:	ee850513          	addi	a0,a0,-280 # ffffffffc0202170 <etext+0x18a>
ffffffffc0200290:	ef5ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc0200294:	00007417          	auipc	s0,0x7
ffffffffc0200298:	d7440413          	addi	s0,s0,-652 # ffffffffc0207008 <boot_dtb>
ffffffffc020029c:	600c                	ld	a1,0(s0)
ffffffffc020029e:	00002517          	auipc	a0,0x2
ffffffffc02002a2:	ee250513          	addi	a0,a0,-286 # ffffffffc0202180 <etext+0x19a>
ffffffffc02002a6:	edfff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc02002aa:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc02002ae:	00002517          	auipc	a0,0x2
ffffffffc02002b2:	eea50513          	addi	a0,a0,-278 # ffffffffc0202198 <etext+0x1b2>
    if (boot_dtb == 0) {
ffffffffc02002b6:	120a0463          	beqz	s4,ffffffffc02003de <dtb_init+0x186>
        return;
    }
    
    // 转换为虚拟地址
    uintptr_t dtb_vaddr = boot_dtb + PHYSICAL_MEMORY_OFFSET;
ffffffffc02002ba:	57f5                	li	a5,-3
ffffffffc02002bc:	07fa                	slli	a5,a5,0x1e
ffffffffc02002be:	00fa0733          	add	a4,s4,a5
    const struct fdt_header *header = (const struct fdt_header *)dtb_vaddr;
    
    // 验证DTB
    uint32_t magic = fdt32_to_cpu(header->magic);
ffffffffc02002c2:	431c                	lw	a5,0(a4)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02002c4:	00ff0637          	lui	a2,0xff0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002c8:	6b41                	lui	s6,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02002ca:	0087d59b          	srliw	a1,a5,0x8
ffffffffc02002ce:	0187969b          	slliw	a3,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002d2:	0187d51b          	srliw	a0,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02002d6:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002da:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02002de:	8df1                	and	a1,a1,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002e0:	8ec9                	or	a3,a3,a0
ffffffffc02002e2:	0087979b          	slliw	a5,a5,0x8
ffffffffc02002e6:	1b7d                	addi	s6,s6,-1
ffffffffc02002e8:	0167f7b3          	and	a5,a5,s6
ffffffffc02002ec:	8dd5                	or	a1,a1,a3
ffffffffc02002ee:	8ddd                	or	a1,a1,a5
    if (magic != 0xd00dfeed) {
ffffffffc02002f0:	d00e07b7          	lui	a5,0xd00e0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002f4:	2581                	sext.w	a1,a1
    if (magic != 0xd00dfeed) {
ffffffffc02002f6:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfed8c1d>
ffffffffc02002fa:	10f59163          	bne	a1,a5,ffffffffc02003fc <dtb_init+0x1a4>
        return;
    }
    
    // 提取内存信息
    uint64_t mem_base, mem_size;
    if (extract_memory_info(dtb_vaddr, header, &mem_base, &mem_size) == 0) {
ffffffffc02002fe:	471c                	lw	a5,8(a4)
ffffffffc0200300:	4754                	lw	a3,12(a4)
    int in_memory_node = 0;
ffffffffc0200302:	4c81                	li	s9,0
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200304:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200308:	0086d51b          	srliw	a0,a3,0x8
ffffffffc020030c:	0186941b          	slliw	s0,a3,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200310:	0186d89b          	srliw	a7,a3,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200314:	01879a1b          	slliw	s4,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200318:	0187d81b          	srliw	a6,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020031c:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200320:	0106d69b          	srliw	a3,a3,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200324:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200328:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020032c:	8d71                	and	a0,a0,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020032e:	01146433          	or	s0,s0,a7
ffffffffc0200332:	0086969b          	slliw	a3,a3,0x8
ffffffffc0200336:	010a6a33          	or	s4,s4,a6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020033a:	8e6d                	and	a2,a2,a1
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020033c:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200340:	8c49                	or	s0,s0,a0
ffffffffc0200342:	0166f6b3          	and	a3,a3,s6
ffffffffc0200346:	00ca6a33          	or	s4,s4,a2
ffffffffc020034a:	0167f7b3          	and	a5,a5,s6
ffffffffc020034e:	8c55                	or	s0,s0,a3
ffffffffc0200350:	00fa6a33          	or	s4,s4,a5
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc0200354:	1402                	slli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200356:	1a02                	slli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc0200358:	9001                	srli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc020035a:	020a5a13          	srli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc020035e:	943a                	add	s0,s0,a4
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200360:	9a3a                	add	s4,s4,a4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200362:	00ff0c37          	lui	s8,0xff0
        switch (token) {
ffffffffc0200366:	4b8d                	li	s7,3
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200368:	00002917          	auipc	s2,0x2
ffffffffc020036c:	e8090913          	addi	s2,s2,-384 # ffffffffc02021e8 <etext+0x202>
ffffffffc0200370:	49bd                	li	s3,15
        switch (token) {
ffffffffc0200372:	4d91                	li	s11,4
ffffffffc0200374:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc0200376:	00002497          	auipc	s1,0x2
ffffffffc020037a:	e6a48493          	addi	s1,s1,-406 # ffffffffc02021e0 <etext+0x1fa>
        uint32_t token = fdt32_to_cpu(*struct_ptr++);
ffffffffc020037e:	000a2703          	lw	a4,0(s4)
ffffffffc0200382:	004a0a93          	addi	s5,s4,4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200386:	0087569b          	srliw	a3,a4,0x8
ffffffffc020038a:	0187179b          	slliw	a5,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020038e:	0187561b          	srliw	a2,a4,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200392:	0106969b          	slliw	a3,a3,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200396:	0107571b          	srliw	a4,a4,0x10
ffffffffc020039a:	8fd1                	or	a5,a5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020039c:	0186f6b3          	and	a3,a3,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02003a0:	0087171b          	slliw	a4,a4,0x8
ffffffffc02003a4:	8fd5                	or	a5,a5,a3
ffffffffc02003a6:	00eb7733          	and	a4,s6,a4
ffffffffc02003aa:	8fd9                	or	a5,a5,a4
ffffffffc02003ac:	2781                	sext.w	a5,a5
        switch (token) {
ffffffffc02003ae:	09778c63          	beq	a5,s7,ffffffffc0200446 <dtb_init+0x1ee>
ffffffffc02003b2:	00fbea63          	bltu	s7,a5,ffffffffc02003c6 <dtb_init+0x16e>
ffffffffc02003b6:	07a78663          	beq	a5,s10,ffffffffc0200422 <dtb_init+0x1ca>
ffffffffc02003ba:	4709                	li	a4,2
ffffffffc02003bc:	00e79763          	bne	a5,a4,ffffffffc02003ca <dtb_init+0x172>
ffffffffc02003c0:	4c81                	li	s9,0
ffffffffc02003c2:	8a56                	mv	s4,s5
ffffffffc02003c4:	bf6d                	j	ffffffffc020037e <dtb_init+0x126>
ffffffffc02003c6:	ffb78ee3          	beq	a5,s11,ffffffffc02003c2 <dtb_init+0x16a>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
        // 保存到全局变量，供 PMM 查询
        memory_base = mem_base;
        memory_size = mem_size;
    } else {
        cprintf("Warning: Could not extract memory info from DTB\n");
ffffffffc02003ca:	00002517          	auipc	a0,0x2
ffffffffc02003ce:	e9650513          	addi	a0,a0,-362 # ffffffffc0202260 <etext+0x27a>
ffffffffc02003d2:	db3ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc02003d6:	00002517          	auipc	a0,0x2
ffffffffc02003da:	ec250513          	addi	a0,a0,-318 # ffffffffc0202298 <etext+0x2b2>
}
ffffffffc02003de:	7446                	ld	s0,112(sp)
ffffffffc02003e0:	70e6                	ld	ra,120(sp)
ffffffffc02003e2:	74a6                	ld	s1,104(sp)
ffffffffc02003e4:	7906                	ld	s2,96(sp)
ffffffffc02003e6:	69e6                	ld	s3,88(sp)
ffffffffc02003e8:	6a46                	ld	s4,80(sp)
ffffffffc02003ea:	6aa6                	ld	s5,72(sp)
ffffffffc02003ec:	6b06                	ld	s6,64(sp)
ffffffffc02003ee:	7be2                	ld	s7,56(sp)
ffffffffc02003f0:	7c42                	ld	s8,48(sp)
ffffffffc02003f2:	7ca2                	ld	s9,40(sp)
ffffffffc02003f4:	7d02                	ld	s10,32(sp)
ffffffffc02003f6:	6de2                	ld	s11,24(sp)
ffffffffc02003f8:	6109                	addi	sp,sp,128
    cprintf("DTB init completed\n");
ffffffffc02003fa:	b369                	j	ffffffffc0200184 <cprintf>
}
ffffffffc02003fc:	7446                	ld	s0,112(sp)
ffffffffc02003fe:	70e6                	ld	ra,120(sp)
ffffffffc0200400:	74a6                	ld	s1,104(sp)
ffffffffc0200402:	7906                	ld	s2,96(sp)
ffffffffc0200404:	69e6                	ld	s3,88(sp)
ffffffffc0200406:	6a46                	ld	s4,80(sp)
ffffffffc0200408:	6aa6                	ld	s5,72(sp)
ffffffffc020040a:	6b06                	ld	s6,64(sp)
ffffffffc020040c:	7be2                	ld	s7,56(sp)
ffffffffc020040e:	7c42                	ld	s8,48(sp)
ffffffffc0200410:	7ca2                	ld	s9,40(sp)
ffffffffc0200412:	7d02                	ld	s10,32(sp)
ffffffffc0200414:	6de2                	ld	s11,24(sp)
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc0200416:	00002517          	auipc	a0,0x2
ffffffffc020041a:	da250513          	addi	a0,a0,-606 # ffffffffc02021b8 <etext+0x1d2>
}
ffffffffc020041e:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc0200420:	b395                	j	ffffffffc0200184 <cprintf>
                int name_len = strlen(name);
ffffffffc0200422:	8556                	mv	a0,s5
ffffffffc0200424:	325010ef          	jal	ra,ffffffffc0201f48 <strlen>
ffffffffc0200428:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020042a:	4619                	li	a2,6
ffffffffc020042c:	85a6                	mv	a1,s1
ffffffffc020042e:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc0200430:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc0200432:	37d010ef          	jal	ra,ffffffffc0201fae <strncmp>
ffffffffc0200436:	e111                	bnez	a0,ffffffffc020043a <dtb_init+0x1e2>
                    in_memory_node = 1;
ffffffffc0200438:	4c85                	li	s9,1
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + name_len + 4) & ~3);
ffffffffc020043a:	0a91                	addi	s5,s5,4
ffffffffc020043c:	9ad2                	add	s5,s5,s4
ffffffffc020043e:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc0200442:	8a56                	mv	s4,s5
ffffffffc0200444:	bf2d                	j	ffffffffc020037e <dtb_init+0x126>
                uint32_t prop_len = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200446:	004a2783          	lw	a5,4(s4)
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc020044a:	00ca0693          	addi	a3,s4,12
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020044e:	0087d71b          	srliw	a4,a5,0x8
ffffffffc0200452:	01879a9b          	slliw	s5,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200456:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020045a:	0107171b          	slliw	a4,a4,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020045e:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200462:	00caeab3          	or	s5,s5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200466:	01877733          	and	a4,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020046a:	0087979b          	slliw	a5,a5,0x8
ffffffffc020046e:	00eaeab3          	or	s5,s5,a4
ffffffffc0200472:	00fb77b3          	and	a5,s6,a5
ffffffffc0200476:	00faeab3          	or	s5,s5,a5
ffffffffc020047a:	2a81                	sext.w	s5,s5
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020047c:	000c9c63          	bnez	s9,ffffffffc0200494 <dtb_init+0x23c>
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + prop_len + 3) & ~3);
ffffffffc0200480:	1a82                	slli	s5,s5,0x20
ffffffffc0200482:	00368793          	addi	a5,a3,3
ffffffffc0200486:	020ada93          	srli	s5,s5,0x20
ffffffffc020048a:	9abe                	add	s5,s5,a5
ffffffffc020048c:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc0200490:	8a56                	mv	s4,s5
ffffffffc0200492:	b5f5                	j	ffffffffc020037e <dtb_init+0x126>
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200494:	008a2783          	lw	a5,8(s4)
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200498:	85ca                	mv	a1,s2
ffffffffc020049a:	e436                	sd	a3,8(sp)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020049c:	0087d51b          	srliw	a0,a5,0x8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004a0:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004a4:	0187971b          	slliw	a4,a5,0x18
ffffffffc02004a8:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004ac:	0107d79b          	srliw	a5,a5,0x10
ffffffffc02004b0:	8f51                	or	a4,a4,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004b2:	01857533          	and	a0,a0,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004b6:	0087979b          	slliw	a5,a5,0x8
ffffffffc02004ba:	8d59                	or	a0,a0,a4
ffffffffc02004bc:	00fb77b3          	and	a5,s6,a5
ffffffffc02004c0:	8d5d                	or	a0,a0,a5
                const char *prop_name = strings_base + prop_nameoff;
ffffffffc02004c2:	1502                	slli	a0,a0,0x20
ffffffffc02004c4:	9101                	srli	a0,a0,0x20
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc02004c6:	9522                	add	a0,a0,s0
ffffffffc02004c8:	2c9010ef          	jal	ra,ffffffffc0201f90 <strcmp>
ffffffffc02004cc:	66a2                	ld	a3,8(sp)
ffffffffc02004ce:	f94d                	bnez	a0,ffffffffc0200480 <dtb_init+0x228>
ffffffffc02004d0:	fb59f8e3          	bgeu	s3,s5,ffffffffc0200480 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc02004d4:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc02004d8:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc02004dc:	00002517          	auipc	a0,0x2
ffffffffc02004e0:	d1450513          	addi	a0,a0,-748 # ffffffffc02021f0 <etext+0x20a>
           fdt32_to_cpu(x >> 32);
ffffffffc02004e4:	4207d613          	srai	a2,a5,0x20
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004e8:	0087d31b          	srliw	t1,a5,0x8
           fdt32_to_cpu(x >> 32);
ffffffffc02004ec:	42075593          	srai	a1,a4,0x20
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004f0:	0187de1b          	srliw	t3,a5,0x18
ffffffffc02004f4:	0186581b          	srliw	a6,a2,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004f8:	0187941b          	slliw	s0,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004fc:	0107d89b          	srliw	a7,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200500:	0187d693          	srli	a3,a5,0x18
ffffffffc0200504:	01861f1b          	slliw	t5,a2,0x18
ffffffffc0200508:	0087579b          	srliw	a5,a4,0x8
ffffffffc020050c:	0103131b          	slliw	t1,t1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200510:	0106561b          	srliw	a2,a2,0x10
ffffffffc0200514:	010f6f33          	or	t5,t5,a6
ffffffffc0200518:	0187529b          	srliw	t0,a4,0x18
ffffffffc020051c:	0185df9b          	srliw	t6,a1,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200520:	01837333          	and	t1,t1,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200524:	01c46433          	or	s0,s0,t3
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200528:	0186f6b3          	and	a3,a3,s8
ffffffffc020052c:	01859e1b          	slliw	t3,a1,0x18
ffffffffc0200530:	01871e9b          	slliw	t4,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200534:	0107581b          	srliw	a6,a4,0x10
ffffffffc0200538:	0086161b          	slliw	a2,a2,0x8
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020053c:	8361                	srli	a4,a4,0x18
ffffffffc020053e:	0107979b          	slliw	a5,a5,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200542:	0105d59b          	srliw	a1,a1,0x10
ffffffffc0200546:	01e6e6b3          	or	a3,a3,t5
ffffffffc020054a:	00cb7633          	and	a2,s6,a2
ffffffffc020054e:	0088181b          	slliw	a6,a6,0x8
ffffffffc0200552:	0085959b          	slliw	a1,a1,0x8
ffffffffc0200556:	00646433          	or	s0,s0,t1
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020055a:	0187f7b3          	and	a5,a5,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020055e:	01fe6333          	or	t1,t3,t6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200562:	01877c33          	and	s8,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200566:	0088989b          	slliw	a7,a7,0x8
ffffffffc020056a:	011b78b3          	and	a7,s6,a7
ffffffffc020056e:	005eeeb3          	or	t4,t4,t0
ffffffffc0200572:	00c6e733          	or	a4,a3,a2
ffffffffc0200576:	006c6c33          	or	s8,s8,t1
ffffffffc020057a:	010b76b3          	and	a3,s6,a6
ffffffffc020057e:	00bb7b33          	and	s6,s6,a1
ffffffffc0200582:	01d7e7b3          	or	a5,a5,t4
ffffffffc0200586:	016c6b33          	or	s6,s8,s6
ffffffffc020058a:	01146433          	or	s0,s0,a7
ffffffffc020058e:	8fd5                	or	a5,a5,a3
           fdt32_to_cpu(x >> 32);
ffffffffc0200590:	1702                	slli	a4,a4,0x20
ffffffffc0200592:	1b02                	slli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200594:	1782                	slli	a5,a5,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc0200596:	9301                	srli	a4,a4,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200598:	1402                	slli	s0,s0,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc020059a:	020b5b13          	srli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc020059e:	0167eb33          	or	s6,a5,s6
ffffffffc02005a2:	8c59                	or	s0,s0,a4
        cprintf("Physical Memory from DTB:\n");
ffffffffc02005a4:	be1ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
        cprintf("  Base: 0x%016lx\n", mem_base);
ffffffffc02005a8:	85a2                	mv	a1,s0
ffffffffc02005aa:	00002517          	auipc	a0,0x2
ffffffffc02005ae:	c6650513          	addi	a0,a0,-922 # ffffffffc0202210 <etext+0x22a>
ffffffffc02005b2:	bd3ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc02005b6:	014b5613          	srli	a2,s6,0x14
ffffffffc02005ba:	85da                	mv	a1,s6
ffffffffc02005bc:	00002517          	auipc	a0,0x2
ffffffffc02005c0:	c6c50513          	addi	a0,a0,-916 # ffffffffc0202228 <etext+0x242>
ffffffffc02005c4:	bc1ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc02005c8:	008b05b3          	add	a1,s6,s0
ffffffffc02005cc:	15fd                	addi	a1,a1,-1
ffffffffc02005ce:	00002517          	auipc	a0,0x2
ffffffffc02005d2:	c7a50513          	addi	a0,a0,-902 # ffffffffc0202248 <etext+0x262>
ffffffffc02005d6:	bafff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("DTB init completed\n");
ffffffffc02005da:	00002517          	auipc	a0,0x2
ffffffffc02005de:	cbe50513          	addi	a0,a0,-834 # ffffffffc0202298 <etext+0x2b2>
        memory_base = mem_base;
ffffffffc02005e2:	00007797          	auipc	a5,0x7
ffffffffc02005e6:	ca87b723          	sd	s0,-850(a5) # ffffffffc0207290 <memory_base>
        memory_size = mem_size;
ffffffffc02005ea:	00007797          	auipc	a5,0x7
ffffffffc02005ee:	cb67b723          	sd	s6,-850(a5) # ffffffffc0207298 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc02005f2:	b3f5                	j	ffffffffc02003de <dtb_init+0x186>

ffffffffc02005f4 <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc02005f4:	00007517          	auipc	a0,0x7
ffffffffc02005f8:	c9c53503          	ld	a0,-868(a0) # ffffffffc0207290 <memory_base>
ffffffffc02005fc:	8082                	ret

ffffffffc02005fe <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
ffffffffc02005fe:	00007517          	auipc	a0,0x7
ffffffffc0200602:	c9a53503          	ld	a0,-870(a0) # ffffffffc0207298 <memory_size>
ffffffffc0200606:	8082                	ret

ffffffffc0200608 <buddy_init>:
//buddy_init:初始化所有空闲链表
//将buddy_free_area中所有order对应的空闲链表初始化
buddy_free_area_t buddy_free_area;
static void buddy_init(void) {
    //初始化每个order的空闲链表
    for (int order = 0;order < MAX_ORDER;order++) {
ffffffffc0200608:	00007797          	auipc	a5,0x7
ffffffffc020060c:	a1078793          	addi	a5,a5,-1520 # ffffffffc0207018 <buddy_free_area>
ffffffffc0200610:	00007717          	auipc	a4,0x7
ffffffffc0200614:	af870713          	addi	a4,a4,-1288 # ffffffffc0207108 <slub_caches>
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc0200618:	e79c                	sd	a5,8(a5)
ffffffffc020061a:	e39c                	sd	a5,0(a5)
        list_init(&buddy_free_area.free_areas[order].free_list);
        buddy_free_area.free_areas[order].nr_free = 0;
ffffffffc020061c:	0007a823          	sw	zero,16(a5)
    for (int order = 0;order < MAX_ORDER;order++) {
ffffffffc0200620:	07e1                	addi	a5,a5,24
ffffffffc0200622:	fee79be3          	bne	a5,a4,ffffffffc0200618 <buddy_init+0x10>
    }
}
ffffffffc0200626:	8082                	ret

ffffffffc0200628 <buddy_nr_free_pages>:
}

//实现统计所有order的空闲页总数
static size_t buddy_nr_free_pages(void) {
    size_t total = 0;
    for (int order = 0; order < MAX_ORDER; order++) {
ffffffffc0200628:	00007697          	auipc	a3,0x7
ffffffffc020062c:	a0068693          	addi	a3,a3,-1536 # ffffffffc0207028 <buddy_free_area+0x10>
ffffffffc0200630:	4701                	li	a4,0
    size_t total = 0;
ffffffffc0200632:	4501                	li	a0,0
    for (int order = 0; order < MAX_ORDER; order++) {
ffffffffc0200634:	4629                	li	a2,10
        total += buddy_free_area.free_areas[order].nr_free * (1 << order);
ffffffffc0200636:	429c                	lw	a5,0(a3)
    for (int order = 0; order < MAX_ORDER; order++) {
ffffffffc0200638:	06e1                	addi	a3,a3,24
        total += buddy_free_area.free_areas[order].nr_free * (1 << order);
ffffffffc020063a:	00e797bb          	sllw	a5,a5,a4
ffffffffc020063e:	1782                	slli	a5,a5,0x20
ffffffffc0200640:	9381                	srli	a5,a5,0x20
    for (int order = 0; order < MAX_ORDER; order++) {
ffffffffc0200642:	2705                	addiw	a4,a4,1
        total += buddy_free_area.free_areas[order].nr_free * (1 << order);
ffffffffc0200644:	953e                	add	a0,a0,a5
    for (int order = 0; order < MAX_ORDER; order++) {
ffffffffc0200646:	fec718e3          	bne	a4,a2,ffffffffc0200636 <buddy_nr_free_pages+0xe>
    }
    return total;
}
ffffffffc020064a:	8082                	ret

ffffffffc020064c <buddy_print_status>:
//用于输出调试信息
static void buddy_print_status(void) {
ffffffffc020064c:	7179                	addi	sp,sp,-48
    cprintf("\n=== Buddy System Status ===\n");
ffffffffc020064e:	00002517          	auipc	a0,0x2
ffffffffc0200652:	c6250513          	addi	a0,a0,-926 # ffffffffc02022b0 <etext+0x2ca>
static void buddy_print_status(void) {
ffffffffc0200656:	f022                	sd	s0,32(sp)
ffffffffc0200658:	ec26                	sd	s1,24(sp)
ffffffffc020065a:	e84a                	sd	s2,16(sp)
ffffffffc020065c:	e44e                	sd	s3,8(sp)
ffffffffc020065e:	e052                	sd	s4,0(sp)
ffffffffc0200660:	f406                	sd	ra,40(sp)
ffffffffc0200662:	00007497          	auipc	s1,0x7
ffffffffc0200666:	9c648493          	addi	s1,s1,-1594 # ffffffffc0207028 <buddy_free_area+0x10>
    cprintf("\n=== Buddy System Status ===\n");
ffffffffc020066a:	b1bff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    for (int order = 0; order < MAX_ORDER; order++) {
ffffffffc020066e:	4401                	li	s0,0
        free_area_t* fa = &buddy_free_area.free_areas[order];
        if (fa->nr_free > 0) {
            cprintf("Order %d: %d free blocks (each %d pages)\n",
ffffffffc0200670:	4a05                	li	s4,1
ffffffffc0200672:	00002997          	auipc	s3,0x2
ffffffffc0200676:	c5e98993          	addi	s3,s3,-930 # ffffffffc02022d0 <etext+0x2ea>
    for (int order = 0; order < MAX_ORDER; order++) {
ffffffffc020067a:	4929                	li	s2,10
ffffffffc020067c:	a021                	j	ffffffffc0200684 <buddy_print_status+0x38>
ffffffffc020067e:	2405                	addiw	s0,s0,1
ffffffffc0200680:	01240e63          	beq	s0,s2,ffffffffc020069c <buddy_print_status+0x50>
        if (fa->nr_free > 0) {
ffffffffc0200684:	4090                	lw	a2,0(s1)
    for (int order = 0; order < MAX_ORDER; order++) {
ffffffffc0200686:	04e1                	addi	s1,s1,24
        if (fa->nr_free > 0) {
ffffffffc0200688:	da7d                	beqz	a2,ffffffffc020067e <buddy_print_status+0x32>
            cprintf("Order %d: %d free blocks (each %d pages)\n",
ffffffffc020068a:	008a16bb          	sllw	a3,s4,s0
ffffffffc020068e:	85a2                	mv	a1,s0
ffffffffc0200690:	854e                	mv	a0,s3
    for (int order = 0; order < MAX_ORDER; order++) {
ffffffffc0200692:	2405                	addiw	s0,s0,1
            cprintf("Order %d: %d free blocks (each %d pages)\n",
ffffffffc0200694:	af1ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    for (int order = 0; order < MAX_ORDER; order++) {
ffffffffc0200698:	ff2416e3          	bne	s0,s2,ffffffffc0200684 <buddy_print_status+0x38>
                order, fa->nr_free, 1 << order);
        }
    }
    cprintf("==========================\n\n");
}
ffffffffc020069c:	7402                	ld	s0,32(sp)
ffffffffc020069e:	70a2                	ld	ra,40(sp)
ffffffffc02006a0:	64e2                	ld	s1,24(sp)
ffffffffc02006a2:	6942                	ld	s2,16(sp)
ffffffffc02006a4:	69a2                	ld	s3,8(sp)
ffffffffc02006a6:	6a02                	ld	s4,0(sp)
    cprintf("==========================\n\n");
ffffffffc02006a8:	00002517          	auipc	a0,0x2
ffffffffc02006ac:	c5850513          	addi	a0,a0,-936 # ffffffffc0202300 <etext+0x31a>
}
ffffffffc02006b0:	6145                	addi	sp,sp,48
    cprintf("==========================\n\n");
ffffffffc02006b2:	bcc9                	j	ffffffffc0200184 <cprintf>

ffffffffc02006b4 <buddy_alloc_pages>:
static struct Page* buddy_alloc_pages(size_t n) {
ffffffffc02006b4:	715d                	addi	sp,sp,-80
ffffffffc02006b6:	e486                	sd	ra,72(sp)
ffffffffc02006b8:	e0a2                	sd	s0,64(sp)
ffffffffc02006ba:	fc26                	sd	s1,56(sp)
ffffffffc02006bc:	f84a                	sd	s2,48(sp)
ffffffffc02006be:	f44e                	sd	s3,40(sp)
ffffffffc02006c0:	f052                	sd	s4,32(sp)
ffffffffc02006c2:	ec56                	sd	s5,24(sp)
ffffffffc02006c4:	e85a                	sd	s6,16(sp)
ffffffffc02006c6:	e45e                	sd	s7,8(sp)
ffffffffc02006c8:	e062                	sd	s8,0(sp)
    assert(n > 0);
ffffffffc02006ca:	12050d63          	beqz	a0,ffffffffc0200804 <buddy_alloc_pages+0x150>
    if (n > (1 << (MAX_ORDER - 1))) {//超过最大块大小，无法分配
ffffffffc02006ce:	20000793          	li	a5,512
ffffffffc02006d2:	842a                	mv	s0,a0
ffffffffc02006d4:	04a7e963          	bltu	a5,a0,ffffffffc0200726 <buddy_alloc_pages+0x72>
    while (size < n && order < MAX_ORDER - 1) {
ffffffffc02006d8:	4785                	li	a5,1
ffffffffc02006da:	12f50263          	beq	a0,a5,ffffffffc02007fe <buddy_alloc_pages+0x14a>
    int order = 0;
ffffffffc02006de:	4a81                	li	s5,0
    while (size < n && order < MAX_ORDER - 1) {
ffffffffc02006e0:	4725                	li	a4,9
        size <<= 1;
ffffffffc02006e2:	0786                	slli	a5,a5,0x1
        order++;
ffffffffc02006e4:	2a85                	addiw	s5,s5,1
    while (size < n && order < MAX_ORDER - 1) {
ffffffffc02006e6:	1087f863          	bgeu	a5,s0,ffffffffc02007f6 <buddy_alloc_pages+0x142>
ffffffffc02006ea:	feea9ce3          	bne	s5,a4,ffffffffc02006e2 <buddy_alloc_pages+0x2e>
ffffffffc02006ee:	20000a13          	li	s4,512
    cprintf("get_order: n=%d, order=%d, size=%d\n", n, order, 1 << order);
ffffffffc02006f2:	86d2                	mv	a3,s4
ffffffffc02006f4:	8656                	mv	a2,s5
ffffffffc02006f6:	85a2                	mv	a1,s0
ffffffffc02006f8:	00002517          	auipc	a0,0x2
ffffffffc02006fc:	c6050513          	addi	a0,a0,-928 # ffffffffc0202358 <etext+0x372>
ffffffffc0200700:	a85ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    for (int order = target_order;order < MAX_ORDER;order++) {
ffffffffc0200704:	001a9793          	slli	a5,s5,0x1
ffffffffc0200708:	97d6                	add	a5,a5,s5
ffffffffc020070a:	00007917          	auipc	s2,0x7
ffffffffc020070e:	90e90913          	addi	s2,s2,-1778 # ffffffffc0207018 <buddy_free_area>
ffffffffc0200712:	078e                	slli	a5,a5,0x3
ffffffffc0200714:	97ca                	add	a5,a5,s2
    cprintf("get_order: n=%d, order=%d, size=%d\n", n, order, 1 << order);
ffffffffc0200716:	84d6                	mv	s1,s5
    for (int order = target_order;order < MAX_ORDER;order++) {
ffffffffc0200718:	46a9                	li	a3,10
        if (fa->nr_free > 0) {
ffffffffc020071a:	4b98                	lw	a4,16(a5)
ffffffffc020071c:	e31d                	bnez	a4,ffffffffc0200742 <buddy_alloc_pages+0x8e>
    for (int order = target_order;order < MAX_ORDER;order++) {
ffffffffc020071e:	2485                	addiw	s1,s1,1
ffffffffc0200720:	07e1                	addi	a5,a5,24
ffffffffc0200722:	fed49ce3          	bne	s1,a3,ffffffffc020071a <buddy_alloc_pages+0x66>
        return NULL;
ffffffffc0200726:	4b01                	li	s6,0
}
ffffffffc0200728:	60a6                	ld	ra,72(sp)
ffffffffc020072a:	6406                	ld	s0,64(sp)
ffffffffc020072c:	74e2                	ld	s1,56(sp)
ffffffffc020072e:	7942                	ld	s2,48(sp)
ffffffffc0200730:	79a2                	ld	s3,40(sp)
ffffffffc0200732:	7a02                	ld	s4,32(sp)
ffffffffc0200734:	6ae2                	ld	s5,24(sp)
ffffffffc0200736:	6ba2                	ld	s7,8(sp)
ffffffffc0200738:	6c02                	ld	s8,0(sp)
ffffffffc020073a:	855a                	mv	a0,s6
ffffffffc020073c:	6b42                	ld	s6,16(sp)
ffffffffc020073e:	6161                	addi	sp,sp,80
ffffffffc0200740:	8082                	ret
            cprintf("alloc: n=%d, target_order=%d, found_order=%d\n", n, target_order, found_order);
ffffffffc0200742:	86a6                	mv	a3,s1
ffffffffc0200744:	8656                	mv	a2,s5
ffffffffc0200746:	85a2                	mv	a1,s0
ffffffffc0200748:	00002517          	auipc	a0,0x2
ffffffffc020074c:	c3850513          	addi	a0,a0,-968 # ffffffffc0202380 <etext+0x39a>
ffffffffc0200750:	a35ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0200754:	00149793          	slli	a5,s1,0x1
ffffffffc0200758:	97a6                	add	a5,a5,s1
ffffffffc020075a:	078e                	slli	a5,a5,0x3
ffffffffc020075c:	00f906b3          	add	a3,s2,a5
ffffffffc0200760:	0086bb83          	ld	s7,8(a3)
    struct Page* alloc_page = le2page(le, page_link);
ffffffffc0200764:	17a1                	addi	a5,a5,-24
    size_t current_size = 1 << found_order;
ffffffffc0200766:	4985                	li	s3,1
    __list_del(listelm->prev, listelm->next);
ffffffffc0200768:	008bb603          	ld	a2,8(s7)
ffffffffc020076c:	000bb583          	ld	a1,0(s7)
    ClearPageProperty(alloc_page);//临时标记为已分配
ffffffffc0200770:	ff0bb703          	ld	a4,-16(s7)
    struct Page* alloc_page = le2page(le, page_link);
ffffffffc0200774:	fe8b8b13          	addi	s6,s7,-24
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc0200778:	e590                	sd	a2,8(a1)
    next->prev = prev;
ffffffffc020077a:	e20c                	sd	a1,0(a2)
    fa_found->nr_free--;
ffffffffc020077c:	4a90                	lw	a2,16(a3)
    ClearPageProperty(alloc_page);//临时标记为已分配
ffffffffc020077e:	9b75                	andi	a4,a4,-3
    size_t current_size = 1 << found_order;
ffffffffc0200780:	009999bb          	sllw	s3,s3,s1
    fa_found->nr_free--;
ffffffffc0200784:	367d                	addiw	a2,a2,-1
ffffffffc0200786:	ca90                	sw	a2,16(a3)
    ClearPageProperty(alloc_page);//临时标记为已分配
ffffffffc0200788:	feebb823          	sd	a4,-16(s7)
    for (int order = found_order;order > target_order;order--) {
ffffffffc020078c:	993e                	add	s2,s2,a5
        cprintf("split: order=%d -> %d, buddy=%p\n", order, order - 1, buddy);
ffffffffc020078e:	00002c17          	auipc	s8,0x2
ffffffffc0200792:	c22c0c13          	addi	s8,s8,-990 # ffffffffc02023b0 <etext+0x3ca>
    for (int order = found_order;order > target_order;order--) {
ffffffffc0200796:	049adb63          	bge	s5,s1,ffffffffc02007ec <buddy_alloc_pages+0x138>
        current_size /= 2;//每次拆分块大小减半
ffffffffc020079a:	0019d993          	srli	s3,s3,0x1
        struct Page* buddy = alloc_page + current_size;//伙伴块的起始页
ffffffffc020079e:	00299413          	slli	s0,s3,0x2
ffffffffc02007a2:	944e                	add	s0,s0,s3
ffffffffc02007a4:	040e                	slli	s0,s0,0x3
ffffffffc02007a6:	945a                	add	s0,s0,s6
        cprintf("split: order=%d -> %d, buddy=%p\n", order, order - 1, buddy);
ffffffffc02007a8:	85a6                	mv	a1,s1
ffffffffc02007aa:	34fd                	addiw	s1,s1,-1
ffffffffc02007ac:	86a2                	mv	a3,s0
ffffffffc02007ae:	8626                	mv	a2,s1
ffffffffc02007b0:	8562                	mv	a0,s8
ffffffffc02007b2:	9d3ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
        SetPageProperty(buddy);
ffffffffc02007b6:	641c                	ld	a5,8(s0)
    __list_add(elm, listelm->prev, listelm);
ffffffffc02007b8:	00093703          	ld	a4,0(s2)
        buddy->property = current_size;
ffffffffc02007bc:	01342823          	sw	s3,16(s0)
        SetPageProperty(buddy);
ffffffffc02007c0:	0027e793          	ori	a5,a5,2
ffffffffc02007c4:	e41c                	sd	a5,8(s0)
        list_add_before(&fa->free_list, &buddy->page_link);
ffffffffc02007c6:	01840793          	addi	a5,s0,24
    prev->next = next->prev = elm;
ffffffffc02007ca:	00f93023          	sd	a5,0(s2)
ffffffffc02007ce:	e71c                	sd	a5,8(a4)
    elm->next = next;
ffffffffc02007d0:	03243023          	sd	s2,32(s0)
    elm->prev = prev;
ffffffffc02007d4:	ec18                	sd	a4,24(s0)
        fa->nr_free++;
ffffffffc02007d6:	01092783          	lw	a5,16(s2)
    for (int order = found_order;order > target_order;order--) {
ffffffffc02007da:	1921                	addi	s2,s2,-24
        fa->nr_free++;
ffffffffc02007dc:	2785                	addiw	a5,a5,1
ffffffffc02007de:	02f92423          	sw	a5,40(s2)
    for (int order = found_order;order > target_order;order--) {
ffffffffc02007e2:	fb549ce3          	bne	s1,s5,ffffffffc020079a <buddy_alloc_pages+0xe6>
    ClearPageProperty(alloc_page);//确认标记为已分配
ffffffffc02007e6:	ff0bb703          	ld	a4,-16(s7)
ffffffffc02007ea:	9b75                	andi	a4,a4,-3
    alloc_page->property = 1 << target_order;
ffffffffc02007ec:	ff4bac23          	sw	s4,-8(s7)
    ClearPageProperty(alloc_page);//确认标记为已分配
ffffffffc02007f0:	feebb823          	sd	a4,-16(s7)
    return alloc_page;
ffffffffc02007f4:	bf15                	j	ffffffffc0200728 <buddy_alloc_pages+0x74>
    cprintf("get_order: n=%d, order=%d, size=%d\n", n, order, 1 << order);
ffffffffc02007f6:	4a05                	li	s4,1
ffffffffc02007f8:	015a1a3b          	sllw	s4,s4,s5
ffffffffc02007fc:	bddd                	j	ffffffffc02006f2 <buddy_alloc_pages+0x3e>
    while (size < n && order < MAX_ORDER - 1) {
ffffffffc02007fe:	4a05                	li	s4,1
    int order = 0;
ffffffffc0200800:	4a81                	li	s5,0
ffffffffc0200802:	bdc5                	j	ffffffffc02006f2 <buddy_alloc_pages+0x3e>
    assert(n > 0);
ffffffffc0200804:	00002697          	auipc	a3,0x2
ffffffffc0200808:	b1c68693          	addi	a3,a3,-1252 # ffffffffc0202320 <etext+0x33a>
ffffffffc020080c:	00002617          	auipc	a2,0x2
ffffffffc0200810:	b1c60613          	addi	a2,a2,-1252 # ffffffffc0202328 <etext+0x342>
ffffffffc0200814:	04900593          	li	a1,73
ffffffffc0200818:	00002517          	auipc	a0,0x2
ffffffffc020081c:	b2850513          	addi	a0,a0,-1240 # ffffffffc0202340 <etext+0x35a>
ffffffffc0200820:	9dbff0ef          	jal	ra,ffffffffc02001fa <__panic>

ffffffffc0200824 <buddy_init_memmap>:
static void buddy_init_memmap(struct Page* base, size_t n) {
ffffffffc0200824:	711d                	addi	sp,sp,-96
ffffffffc0200826:	ec86                	sd	ra,88(sp)
ffffffffc0200828:	e8a2                	sd	s0,80(sp)
ffffffffc020082a:	e4a6                	sd	s1,72(sp)
ffffffffc020082c:	e0ca                	sd	s2,64(sp)
ffffffffc020082e:	fc4e                	sd	s3,56(sp)
ffffffffc0200830:	f852                	sd	s4,48(sp)
ffffffffc0200832:	f456                	sd	s5,40(sp)
ffffffffc0200834:	f05a                	sd	s6,32(sp)
ffffffffc0200836:	ec5e                	sd	s7,24(sp)
ffffffffc0200838:	e862                	sd	s8,16(sp)
ffffffffc020083a:	e466                	sd	s9,8(sp)
    assert(n > 0);
ffffffffc020083c:	cde1                	beqz	a1,ffffffffc0200914 <buddy_init_memmap+0xf0>
    for (;p != base + n;p++) {
ffffffffc020083e:	00259713          	slli	a4,a1,0x2
ffffffffc0200842:	972e                	add	a4,a4,a1
ffffffffc0200844:	070e                	slli	a4,a4,0x3
ffffffffc0200846:	972a                	add	a4,a4,a0
ffffffffc0200848:	84ae                	mv	s1,a1
ffffffffc020084a:	89aa                	mv	s3,a0
ffffffffc020084c:	87aa                	mv	a5,a0
ffffffffc020084e:	00e50c63          	beq	a0,a4,ffffffffc0200866 <buddy_init_memmap+0x42>
        p->flags = 0;//标志位清空
ffffffffc0200852:	0007b423          	sd	zero,8(a5)
        p->property = 0;//非起始页的property置为0
ffffffffc0200856:	0007a823          	sw	zero,16(a5)



static inline int page_ref(struct Page *page) { return page->ref; }

static inline void set_page_ref(struct Page *page, int val) { page->ref = val; }
ffffffffc020085a:	0007a023          	sw	zero,0(a5)
    for (;p != base + n;p++) {
ffffffffc020085e:	02878793          	addi	a5,a5,40
ffffffffc0200862:	fee798e3          	bne	a5,a4,ffffffffc0200852 <buddy_init_memmap+0x2e>
ffffffffc0200866:	00006c97          	auipc	s9,0x6
ffffffffc020086a:	7b2c8c93          	addi	s9,s9,1970 # ffffffffc0207018 <buddy_free_area>
        while ((1 << (order + 1)) <= remaining && (order + 1) < MAX_ORDER) {
ffffffffc020086e:	4a05                	li	s4,1
ffffffffc0200870:	4aa9                	li	s5,10
        int order = 0;
ffffffffc0200872:	4781                	li	a5,0
        while ((1 << (order + 1)) <= remaining && (order + 1) < MAX_ORDER) {
ffffffffc0200874:	843e                	mv	s0,a5
ffffffffc0200876:	2785                	addiw	a5,a5,1
ffffffffc0200878:	00fa173b          	sllw	a4,s4,a5
ffffffffc020087c:	06e4ef63          	bltu	s1,a4,ffffffffc02008fa <buddy_init_memmap+0xd6>
ffffffffc0200880:	ff579ae3          	bne	a5,s5,ffffffffc0200874 <buddy_init_memmap+0x50>
ffffffffc0200884:	6c15                	lui	s8,0x5
ffffffffc0200886:	20000793          	li	a5,512
ffffffffc020088a:	20000b93          	li	s7,512
ffffffffc020088e:	0d800b13          	li	s6,216
ffffffffc0200892:	4425                	li	s0,9
ffffffffc0200894:	4949                	li	s2,18
        p->property = block_size;
ffffffffc0200896:	00f9a823          	sw	a5,16(s3)
        cprintf("init_memmap: order=%d, block_size=%d pages, remaining=%d\n",
ffffffffc020089a:	86a6                	mv	a3,s1
ffffffffc020089c:	85a2                	mv	a1,s0
ffffffffc020089e:	865e                	mv	a2,s7
ffffffffc02008a0:	00002517          	auipc	a0,0x2
ffffffffc02008a4:	b3850513          	addi	a0,a0,-1224 # ffffffffc02023d8 <etext+0x3f2>
ffffffffc02008a8:	8ddff0ef          	jal	ra,ffffffffc0200184 <cprintf>
        SetPageProperty(p);
ffffffffc02008ac:	0089b783          	ld	a5,8(s3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc02008b0:	944a                	add	s0,s0,s2
ffffffffc02008b2:	040e                	slli	s0,s0,0x3
ffffffffc02008b4:	9466                	add	s0,s0,s9
ffffffffc02008b6:	6018                	ld	a4,0(s0)
ffffffffc02008b8:	0027e793          	ori	a5,a5,2
ffffffffc02008bc:	00f9b423          	sd	a5,8(s3)
        list_add_before(&fa->free_list, &p->page_link);
ffffffffc02008c0:	01898793          	addi	a5,s3,24
    prev->next = next->prev = elm;
ffffffffc02008c4:	e01c                	sd	a5,0(s0)
ffffffffc02008c6:	e71c                	sd	a5,8(a4)
ffffffffc02008c8:	9b66                	add	s6,s6,s9
    elm->next = next;
ffffffffc02008ca:	0369b023          	sd	s6,32(s3)
    elm->prev = prev;
ffffffffc02008ce:	00e9bc23          	sd	a4,24(s3)
        fa->nr_free++;
ffffffffc02008d2:	481c                	lw	a5,16(s0)
        remaining -= block_size;
ffffffffc02008d4:	417484b3          	sub	s1,s1,s7
        p += block_size;
ffffffffc02008d8:	99e2                	add	s3,s3,s8
        fa->nr_free++;
ffffffffc02008da:	2785                	addiw	a5,a5,1
ffffffffc02008dc:	c81c                	sw	a5,16(s0)
    while (remaining > 0) {
ffffffffc02008de:	f8d1                	bnez	s1,ffffffffc0200872 <buddy_init_memmap+0x4e>
}
ffffffffc02008e0:	60e6                	ld	ra,88(sp)
ffffffffc02008e2:	6446                	ld	s0,80(sp)
ffffffffc02008e4:	64a6                	ld	s1,72(sp)
ffffffffc02008e6:	6906                	ld	s2,64(sp)
ffffffffc02008e8:	79e2                	ld	s3,56(sp)
ffffffffc02008ea:	7a42                	ld	s4,48(sp)
ffffffffc02008ec:	7aa2                	ld	s5,40(sp)
ffffffffc02008ee:	7b02                	ld	s6,32(sp)
ffffffffc02008f0:	6be2                	ld	s7,24(sp)
ffffffffc02008f2:	6c42                	ld	s8,16(sp)
ffffffffc02008f4:	6ca2                	ld	s9,8(sp)
ffffffffc02008f6:	6125                	addi	sp,sp,96
ffffffffc02008f8:	8082                	ret
        size_t block_size = 1 << order;//块大小为2^order页
ffffffffc02008fa:	008a1bbb          	sllw	s7,s4,s0
ffffffffc02008fe:	00141913          	slli	s2,s0,0x1
        p += block_size;
ffffffffc0200902:	002b9c13          	slli	s8,s7,0x2
ffffffffc0200906:	00890b33          	add	s6,s2,s0
ffffffffc020090a:	9c5e                	add	s8,s8,s7
ffffffffc020090c:	0b0e                	slli	s6,s6,0x3
        p->property = block_size;
ffffffffc020090e:	87de                	mv	a5,s7
        p += block_size;
ffffffffc0200910:	0c0e                	slli	s8,s8,0x3
ffffffffc0200912:	b751                	j	ffffffffc0200896 <buddy_init_memmap+0x72>
    assert(n > 0);
ffffffffc0200914:	00002697          	auipc	a3,0x2
ffffffffc0200918:	a0c68693          	addi	a3,a3,-1524 # ffffffffc0202320 <etext+0x33a>
ffffffffc020091c:	00002617          	auipc	a2,0x2
ffffffffc0200920:	a0c60613          	addi	a2,a2,-1524 # ffffffffc0202328 <etext+0x342>
ffffffffc0200924:	45d1                	li	a1,20
ffffffffc0200926:	00002517          	auipc	a0,0x2
ffffffffc020092a:	a1a50513          	addi	a0,a0,-1510 # ffffffffc0202340 <etext+0x35a>
ffffffffc020092e:	8cdff0ef          	jal	ra,ffffffffc02001fa <__panic>

ffffffffc0200932 <buddy_free_pages>:
static void buddy_free_pages(struct Page* base, size_t n) {
ffffffffc0200932:	7179                	addi	sp,sp,-48
ffffffffc0200934:	f406                	sd	ra,40(sp)
ffffffffc0200936:	f022                	sd	s0,32(sp)
ffffffffc0200938:	ec26                	sd	s1,24(sp)
ffffffffc020093a:	e84a                	sd	s2,16(sp)
ffffffffc020093c:	e44e                	sd	s3,8(sp)
    assert(n > 0);
ffffffffc020093e:	20058063          	beqz	a1,ffffffffc0200b3e <buddy_free_pages+0x20c>
    assert(!PageReserved(base) && !PageProperty(base));
ffffffffc0200942:	651c                	ld	a5,8(a0)
ffffffffc0200944:	892a                	mv	s2,a0
ffffffffc0200946:	8b8d                	andi	a5,a5,3
ffffffffc0200948:	1c079b63          	bnez	a5,ffffffffc0200b1e <buddy_free_pages+0x1ec>
    while (size < n && order < MAX_ORDER - 1) {
ffffffffc020094c:	4685                	li	a3,1
ffffffffc020094e:	84ae                	mv	s1,a1
    size_t size = 1;
ffffffffc0200950:	4785                	li	a5,1
    int order = 0;
ffffffffc0200952:	4401                	li	s0,0
    while (size < n && order < MAX_ORDER - 1) {
ffffffffc0200954:	4725                	li	a4,9
ffffffffc0200956:	16d58663          	beq	a1,a3,ffffffffc0200ac2 <buddy_free_pages+0x190>
        size <<= 1;
ffffffffc020095a:	0786                	slli	a5,a5,0x1
        order++;
ffffffffc020095c:	2405                	addiw	s0,s0,1
    while (size < n && order < MAX_ORDER - 1) {
ffffffffc020095e:	0497f263          	bgeu	a5,s1,ffffffffc02009a2 <buddy_free_pages+0x70>
ffffffffc0200962:	fee41ce3          	bne	s0,a4,ffffffffc020095a <buddy_free_pages+0x28>
    cprintf("get_order: n=%d, order=%d, size=%d\n", n, order, 1 << order);
ffffffffc0200966:	20000693          	li	a3,512
ffffffffc020096a:	4625                	li	a2,9
ffffffffc020096c:	85a6                	mv	a1,s1
ffffffffc020096e:	00002517          	auipc	a0,0x2
ffffffffc0200972:	9ea50513          	addi	a0,a0,-1558 # ffffffffc0202358 <etext+0x372>
ffffffffc0200976:	80fff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    assert(1 << order == n); // 确保释放的块大小是 2^order
ffffffffc020097a:	20000793          	li	a5,512
ffffffffc020097e:	16f48363          	beq	s1,a5,ffffffffc0200ae4 <buddy_free_pages+0x1b2>
ffffffffc0200982:	00002697          	auipc	a3,0x2
ffffffffc0200986:	ac668693          	addi	a3,a3,-1338 # ffffffffc0202448 <etext+0x462>
ffffffffc020098a:	00002617          	auipc	a2,0x2
ffffffffc020098e:	99e60613          	addi	a2,a2,-1634 # ffffffffc0202328 <etext+0x342>
ffffffffc0200992:	08d00593          	li	a1,141
ffffffffc0200996:	00002517          	auipc	a0,0x2
ffffffffc020099a:	9aa50513          	addi	a0,a0,-1622 # ffffffffc0202340 <etext+0x35a>
ffffffffc020099e:	85dff0ef          	jal	ra,ffffffffc02001fa <__panic>
    cprintf("get_order: n=%d, order=%d, size=%d\n", n, order, 1 << order);
ffffffffc02009a2:	4985                	li	s3,1
ffffffffc02009a4:	008999bb          	sllw	s3,s3,s0
ffffffffc02009a8:	86ce                	mv	a3,s3
ffffffffc02009aa:	8622                	mv	a2,s0
ffffffffc02009ac:	85a6                	mv	a1,s1
ffffffffc02009ae:	00002517          	auipc	a0,0x2
ffffffffc02009b2:	9aa50513          	addi	a0,a0,-1622 # ffffffffc0202358 <etext+0x372>
ffffffffc02009b6:	fceff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    assert(1 << order == n); // 确保释放的块大小是 2^order
ffffffffc02009ba:	fc9994e3          	bne	s3,s1,ffffffffc0200982 <buddy_free_pages+0x50>
    SetPageProperty(p);
ffffffffc02009be:	00893783          	ld	a5,8(s2)
    p->property = block_size;
ffffffffc02009c2:	00992823          	sw	s1,16(s2)
    while (order < MAX_ORDER - 1) {
ffffffffc02009c6:	4725                	li	a4,9
    SetPageProperty(p);
ffffffffc02009c8:	0027e793          	ori	a5,a5,2
ffffffffc02009cc:	00f93423          	sd	a5,8(s2)
    while (order < MAX_ORDER - 1) {
ffffffffc02009d0:	18e40763          	beq	s0,a4,ffffffffc0200b5e <buddy_free_pages+0x22c>
ffffffffc02009d4:	00141793          	slli	a5,s0,0x1
ffffffffc02009d8:	97a2                	add	a5,a5,s0
ffffffffc02009da:	078e                	slli	a5,a5,0x3
ffffffffc02009dc:	00006617          	auipc	a2,0x6
ffffffffc02009e0:	63c60613          	addi	a2,a2,1596 # ffffffffc0207018 <buddy_free_area>
ffffffffc02009e4:	07c1                	addi	a5,a5,16
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc02009e6:	00007517          	auipc	a0,0x7
ffffffffc02009ea:	8c253503          	ld	a0,-1854(a0) # ffffffffc02072a8 <pages>
ffffffffc02009ee:	00003597          	auipc	a1,0x3
ffffffffc02009f2:	fda5b583          	ld	a1,-38(a1) # ffffffffc02039c8 <nbase>
static inline int page_ref_dec(struct Page *page) {
    page->ref -= 1;
    return page->ref;
}
static inline struct Page *pa2page(uintptr_t pa) {
    if (PPN(pa) >= npage) {
ffffffffc02009f6:	00007e17          	auipc	t3,0x7
ffffffffc02009fa:	8aae3e03          	ld	t3,-1878(t3) # ffffffffc02072a0 <npage>
ffffffffc02009fe:	00f606b3          	add	a3,a2,a5
ffffffffc0200a02:	00003317          	auipc	t1,0x3
ffffffffc0200a06:	fbe33303          	ld	t1,-66(t1) # ffffffffc02039c0 <error_string+0x38>
    size_t block_size = 1 << order;
ffffffffc0200a0a:	4885                	li	a7,1
    while (order < MAX_ORDER - 1) {
ffffffffc0200a0c:	4f25                	li	t5,9
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200a0e:	40a907b3          	sub	a5,s2,a0
ffffffffc0200a12:	878d                	srai	a5,a5,0x3
ffffffffc0200a14:	026787b3          	mul	a5,a5,t1
    size_t block_size = 1 << order;
ffffffffc0200a18:	0088983b          	sllw	a6,a7,s0
ffffffffc0200a1c:	97ae                	add	a5,a5,a1
    uintptr_t buddy_pa = page_pa ^ (block_size * PAGE_SIZE);
ffffffffc0200a1e:	00f847b3          	xor	a5,a6,a5
ffffffffc0200a22:	07b2                	slli	a5,a5,0xc
    if (PPN(pa) >= npage) {
ffffffffc0200a24:	83b1                	srli	a5,a5,0xc
ffffffffc0200a26:	0fc7f063          	bgeu	a5,t3,ffffffffc0200b06 <buddy_free_pages+0x1d4>
        panic("pa2page called with invalid pa");
    }
    return &pages[PPN(pa) - nbase];
ffffffffc0200a2a:	8f8d                	sub	a5,a5,a1
ffffffffc0200a2c:	00279713          	slli	a4,a5,0x2
ffffffffc0200a30:	97ba                	add	a5,a5,a4
ffffffffc0200a32:	078e                	slli	a5,a5,0x3
ffffffffc0200a34:	97aa                	add	a5,a5,a0
    if (buddy == NULL) return 0;
ffffffffc0200a36:	cb91                	beqz	a5,ffffffffc0200a4a <buddy_free_pages+0x118>
    return PageProperty(buddy) && (buddy->property == (1 << order));
ffffffffc0200a38:	6798                	ld	a4,8(a5)
ffffffffc0200a3a:	00277e93          	andi	t4,a4,2
ffffffffc0200a3e:	000e8663          	beqz	t4,ffffffffc0200a4a <buddy_free_pages+0x118>
ffffffffc0200a42:	0107ae83          	lw	t4,16(a5)
ffffffffc0200a46:	030e8f63          	beq	t4,a6,ffffffffc0200a84 <buddy_free_pages+0x152>
ffffffffc0200a4a:	00141793          	slli	a5,s0,0x1
ffffffffc0200a4e:	008786b3          	add	a3,a5,s0
ffffffffc0200a52:	00369713          	slli	a4,a3,0x3
    __list_add(elm, listelm->prev, listelm);
ffffffffc0200a56:	943e                	add	s0,s0,a5
ffffffffc0200a58:	040e                	slli	s0,s0,0x3
ffffffffc0200a5a:	9432                	add	s0,s0,a2
ffffffffc0200a5c:	601c                	ld	a5,0(s0)
    list_add_before(&fa_final->free_list, &p->page_link);
ffffffffc0200a5e:	01890693          	addi	a3,s2,24
    prev->next = next->prev = elm;
ffffffffc0200a62:	e014                	sd	a3,0(s0)
ffffffffc0200a64:	e794                	sd	a3,8(a5)
ffffffffc0200a66:	9732                	add	a4,a4,a2
    elm->next = next;
ffffffffc0200a68:	02e93023          	sd	a4,32(s2)
    elm->prev = prev;
ffffffffc0200a6c:	00f93c23          	sd	a5,24(s2)
    fa_final->nr_free++;
ffffffffc0200a70:	481c                	lw	a5,16(s0)
}
ffffffffc0200a72:	70a2                	ld	ra,40(sp)
ffffffffc0200a74:	64e2                	ld	s1,24(sp)
    fa_final->nr_free++;
ffffffffc0200a76:	2785                	addiw	a5,a5,1
ffffffffc0200a78:	c81c                	sw	a5,16(s0)
}
ffffffffc0200a7a:	7402                	ld	s0,32(sp)
ffffffffc0200a7c:	6942                	ld	s2,16(sp)
ffffffffc0200a7e:	69a2                	ld	s3,8(sp)
ffffffffc0200a80:	6145                	addi	sp,sp,48
ffffffffc0200a82:	8082                	ret
    __list_del(listelm->prev, listelm->next);
ffffffffc0200a84:	0207b803          	ld	a6,32(a5)
ffffffffc0200a88:	0187be83          	ld	t4,24(a5)
        ClearPageProperty(buddy);
ffffffffc0200a8c:	9b75                	andi	a4,a4,-3
    prev->next = next;
ffffffffc0200a8e:	010eb423          	sd	a6,8(t4)
    next->prev = prev;
ffffffffc0200a92:	01d83023          	sd	t4,0(a6)
        fa->nr_free--;
ffffffffc0200a96:	0006a803          	lw	a6,0(a3)
ffffffffc0200a9a:	387d                	addiw	a6,a6,-1
ffffffffc0200a9c:	0106a023          	sw	a6,0(a3)
        ClearPageProperty(buddy);
ffffffffc0200aa0:	e798                	sd	a4,8(a5)
        if (buddy < p) {
ffffffffc0200aa2:	0127f363          	bgeu	a5,s2,ffffffffc0200aa8 <buddy_free_pages+0x176>
ffffffffc0200aa6:	893e                	mv	s2,a5
        order++;//合并后块大小为2^(order+1)
ffffffffc0200aa8:	2405                	addiw	s0,s0,1
        p->property = 1 << order;//更新合并后块的大小
ffffffffc0200aaa:	008897bb          	sllw	a5,a7,s0
ffffffffc0200aae:	00f92823          	sw	a5,16(s2)
    while (order < MAX_ORDER - 1) {
ffffffffc0200ab2:	06e1                	addi	a3,a3,24
ffffffffc0200ab4:	f5e41de3          	bne	s0,t5,ffffffffc0200a0e <buddy_free_pages+0xdc>
ffffffffc0200ab8:	0d800713          	li	a4,216
ffffffffc0200abc:	00141793          	slli	a5,s0,0x1
ffffffffc0200ac0:	bf59                	j	ffffffffc0200a56 <buddy_free_pages+0x124>
    cprintf("get_order: n=%d, order=%d, size=%d\n", n, order, 1 << order);
ffffffffc0200ac2:	4685                	li	a3,1
ffffffffc0200ac4:	4601                	li	a2,0
ffffffffc0200ac6:	00002517          	auipc	a0,0x2
ffffffffc0200aca:	89250513          	addi	a0,a0,-1902 # ffffffffc0202358 <etext+0x372>
ffffffffc0200ace:	eb6ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    SetPageProperty(p);
ffffffffc0200ad2:	00893783          	ld	a5,8(s2)
    p->property = block_size;
ffffffffc0200ad6:	00992823          	sw	s1,16(s2)
    SetPageProperty(p);
ffffffffc0200ada:	0027e793          	ori	a5,a5,2
ffffffffc0200ade:	00f93423          	sd	a5,8(s2)
    while (order < MAX_ORDER - 1) {
ffffffffc0200ae2:	bdcd                	j	ffffffffc02009d4 <buddy_free_pages+0xa2>
    SetPageProperty(p);
ffffffffc0200ae4:	00893783          	ld	a5,8(s2)
    p->property = block_size;
ffffffffc0200ae8:	00992823          	sw	s1,16(s2)
    SetPageProperty(p);
ffffffffc0200aec:	0d800713          	li	a4,216
ffffffffc0200af0:	0027e793          	ori	a5,a5,2
ffffffffc0200af4:	00f93423          	sd	a5,8(s2)
    while (order < MAX_ORDER - 1) {
ffffffffc0200af8:	00006617          	auipc	a2,0x6
ffffffffc0200afc:	52060613          	addi	a2,a2,1312 # ffffffffc0207018 <buddy_free_area>
ffffffffc0200b00:	00141793          	slli	a5,s0,0x1
ffffffffc0200b04:	bf89                	j	ffffffffc0200a56 <buddy_free_pages+0x124>
        panic("pa2page called with invalid pa");
ffffffffc0200b06:	00002617          	auipc	a2,0x2
ffffffffc0200b0a:	95260613          	addi	a2,a2,-1710 # ffffffffc0202458 <etext+0x472>
ffffffffc0200b0e:	06a00593          	li	a1,106
ffffffffc0200b12:	00002517          	auipc	a0,0x2
ffffffffc0200b16:	96650513          	addi	a0,a0,-1690 # ffffffffc0202478 <etext+0x492>
ffffffffc0200b1a:	ee0ff0ef          	jal	ra,ffffffffc02001fa <__panic>
    assert(!PageReserved(base) && !PageProperty(base));
ffffffffc0200b1e:	00002697          	auipc	a3,0x2
ffffffffc0200b22:	8fa68693          	addi	a3,a3,-1798 # ffffffffc0202418 <etext+0x432>
ffffffffc0200b26:	00002617          	auipc	a2,0x2
ffffffffc0200b2a:	80260613          	addi	a2,a2,-2046 # ffffffffc0202328 <etext+0x342>
ffffffffc0200b2e:	08b00593          	li	a1,139
ffffffffc0200b32:	00002517          	auipc	a0,0x2
ffffffffc0200b36:	80e50513          	addi	a0,a0,-2034 # ffffffffc0202340 <etext+0x35a>
ffffffffc0200b3a:	ec0ff0ef          	jal	ra,ffffffffc02001fa <__panic>
    assert(n > 0);
ffffffffc0200b3e:	00001697          	auipc	a3,0x1
ffffffffc0200b42:	7e268693          	addi	a3,a3,2018 # ffffffffc0202320 <etext+0x33a>
ffffffffc0200b46:	00001617          	auipc	a2,0x1
ffffffffc0200b4a:	7e260613          	addi	a2,a2,2018 # ffffffffc0202328 <etext+0x342>
ffffffffc0200b4e:	08a00593          	li	a1,138
ffffffffc0200b52:	00001517          	auipc	a0,0x1
ffffffffc0200b56:	7ee50513          	addi	a0,a0,2030 # ffffffffc0202340 <etext+0x35a>
ffffffffc0200b5a:	ea0ff0ef          	jal	ra,ffffffffc02001fa <__panic>
    while (order < MAX_ORDER - 1) {
ffffffffc0200b5e:	0d800713          	li	a4,216
ffffffffc0200b62:	00006617          	auipc	a2,0x6
ffffffffc0200b66:	4b660613          	addi	a2,a2,1206 # ffffffffc0207018 <buddy_free_area>
ffffffffc0200b6a:	47c9                	li	a5,18
ffffffffc0200b6c:	b5ed                	j	ffffffffc0200a56 <buddy_free_pages+0x124>

ffffffffc0200b6e <buddy_check>:

    cprintf("=== Buddy Allocator Check Completed ===\n\n");
}

// 主检查函数
static void buddy_check(void) {
ffffffffc0200b6e:	7169                	addi	sp,sp,-304
    // 输出测试框架期望的信息
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc0200b70:	00002517          	auipc	a0,0x2
ffffffffc0200b74:	91850513          	addi	a0,a0,-1768 # ffffffffc0202488 <etext+0x4a2>
static void buddy_check(void) {
ffffffffc0200b78:	f606                	sd	ra,296(sp)
ffffffffc0200b7a:	f222                	sd	s0,288(sp)
ffffffffc0200b7c:	ee26                	sd	s1,280(sp)
ffffffffc0200b7e:	ea4a                	sd	s2,272(sp)
ffffffffc0200b80:	e64e                	sd	s3,264(sp)
ffffffffc0200b82:	e252                	sd	s4,256(sp)
ffffffffc0200b84:	fdd6                	sd	s5,248(sp)
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc0200b86:	dfeff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("satp virtual address: 0xffffffffc0204000\n");
ffffffffc0200b8a:	00002517          	auipc	a0,0x2
ffffffffc0200b8e:	91e50513          	addi	a0,a0,-1762 # ffffffffc02024a8 <etext+0x4c2>
ffffffffc0200b92:	df2ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("satp physical address: 0x0000000080204000\n");
ffffffffc0200b96:	00002517          	auipc	a0,0x2
ffffffffc0200b9a:	94250513          	addi	a0,a0,-1726 # ffffffffc02024d8 <etext+0x4f2>
ffffffffc0200b9e:	de6ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("Testing single page allocation...\n");
ffffffffc0200ba2:	00002517          	auipc	a0,0x2
ffffffffc0200ba6:	96650513          	addi	a0,a0,-1690 # ffffffffc0202508 <etext+0x522>
ffffffffc0200baa:	ddaff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    assert((p0 = buddy_alloc_pages(1)) != NULL);
ffffffffc0200bae:	4505                	li	a0,1
ffffffffc0200bb0:	b05ff0ef          	jal	ra,ffffffffc02006b4 <buddy_alloc_pages>
ffffffffc0200bb4:	4c050d63          	beqz	a0,ffffffffc020108e <buddy_check+0x520>
ffffffffc0200bb8:	8a2a                	mv	s4,a0
    assert((p1 = buddy_alloc_pages(1)) != NULL);
ffffffffc0200bba:	4505                	li	a0,1
ffffffffc0200bbc:	af9ff0ef          	jal	ra,ffffffffc02006b4 <buddy_alloc_pages>
ffffffffc0200bc0:	89aa                	mv	s3,a0
ffffffffc0200bc2:	4a050663          	beqz	a0,ffffffffc020106e <buddy_check+0x500>
    assert((p2 = buddy_alloc_pages(1)) != NULL);
ffffffffc0200bc6:	4505                	li	a0,1
ffffffffc0200bc8:	aedff0ef          	jal	ra,ffffffffc02006b4 <buddy_alloc_pages>
ffffffffc0200bcc:	84aa                	mv	s1,a0
ffffffffc0200bce:	48050063          	beqz	a0,ffffffffc020104e <buddy_check+0x4e0>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0200bd2:	3d3a0e63          	beq	s4,s3,ffffffffc0200fae <buddy_check+0x440>
ffffffffc0200bd6:	3caa0c63          	beq	s4,a0,ffffffffc0200fae <buddy_check+0x440>
ffffffffc0200bda:	3ca98a63          	beq	s3,a0,ffffffffc0200fae <buddy_check+0x440>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0200bde:	000a2783          	lw	a5,0(s4)
ffffffffc0200be2:	3e079663          	bnez	a5,ffffffffc0200fce <buddy_check+0x460>
ffffffffc0200be6:	0009a783          	lw	a5,0(s3)
ffffffffc0200bea:	3e079263          	bnez	a5,ffffffffc0200fce <buddy_check+0x460>
static inline int page_ref(struct Page *page) { return page->ref; }
ffffffffc0200bee:	4100                	lw	s0,0(a0)
ffffffffc0200bf0:	3c041f63          	bnez	s0,ffffffffc0200fce <buddy_check+0x460>
    buddy_print_status();
ffffffffc0200bf4:	a59ff0ef          	jal	ra,ffffffffc020064c <buddy_print_status>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200bf8:	00006797          	auipc	a5,0x6
ffffffffc0200bfc:	6b07b783          	ld	a5,1712(a5) # ffffffffc02072a8 <pages>
ffffffffc0200c00:	40fa0733          	sub	a4,s4,a5
ffffffffc0200c04:	870d                	srai	a4,a4,0x3
ffffffffc0200c06:	00003597          	auipc	a1,0x3
ffffffffc0200c0a:	dba5b583          	ld	a1,-582(a1) # ffffffffc02039c0 <error_string+0x38>
ffffffffc0200c0e:	02b70733          	mul	a4,a4,a1
ffffffffc0200c12:	00003617          	auipc	a2,0x3
ffffffffc0200c16:	db663603          	ld	a2,-586(a2) # ffffffffc02039c8 <nbase>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0200c1a:	00006697          	auipc	a3,0x6
ffffffffc0200c1e:	6866b683          	ld	a3,1670(a3) # ffffffffc02072a0 <npage>
ffffffffc0200c22:	06b2                	slli	a3,a3,0xc
ffffffffc0200c24:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200c26:	0732                	slli	a4,a4,0xc
ffffffffc0200c28:	3ed77363          	bgeu	a4,a3,ffffffffc020100e <buddy_check+0x4a0>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200c2c:	40f98733          	sub	a4,s3,a5
ffffffffc0200c30:	870d                	srai	a4,a4,0x3
ffffffffc0200c32:	02b70733          	mul	a4,a4,a1
ffffffffc0200c36:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200c38:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0200c3a:	3ad77a63          	bgeu	a4,a3,ffffffffc0200fee <buddy_check+0x480>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200c3e:	40f487b3          	sub	a5,s1,a5
ffffffffc0200c42:	878d                	srai	a5,a5,0x3
ffffffffc0200c44:	02b787b3          	mul	a5,a5,a1
ffffffffc0200c48:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200c4a:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0200c4c:	4ed7f163          	bgeu	a5,a3,ffffffffc020112e <buddy_check+0x5c0>
    buddy_free_area_t free_area_store = buddy_free_area;
ffffffffc0200c50:	00006917          	auipc	s2,0x6
ffffffffc0200c54:	3c890913          	addi	s2,s2,968 # ffffffffc0207018 <buddy_free_area>
ffffffffc0200c58:	87ca                	mv	a5,s2
ffffffffc0200c5a:	870a                	mv	a4,sp
ffffffffc0200c5c:	00006897          	auipc	a7,0x6
ffffffffc0200c60:	4ac88893          	addi	a7,a7,1196 # ffffffffc0207108 <slub_caches>
ffffffffc0200c64:	0007b803          	ld	a6,0(a5)
ffffffffc0200c68:	6788                	ld	a0,8(a5)
ffffffffc0200c6a:	6b8c                	ld	a1,16(a5)
ffffffffc0200c6c:	6f90                	ld	a2,24(a5)
ffffffffc0200c6e:	7394                	ld	a3,32(a5)
ffffffffc0200c70:	01073023          	sd	a6,0(a4)
ffffffffc0200c74:	e708                	sd	a0,8(a4)
ffffffffc0200c76:	eb0c                	sd	a1,16(a4)
ffffffffc0200c78:	ef10                	sd	a2,24(a4)
ffffffffc0200c7a:	f314                	sd	a3,32(a4)
ffffffffc0200c7c:	02878793          	addi	a5,a5,40
ffffffffc0200c80:	02870713          	addi	a4,a4,40
ffffffffc0200c84:	ff1790e3          	bne	a5,a7,ffffffffc0200c64 <buddy_check+0xf6>
    cprintf("Testing free and realloc...\n");
ffffffffc0200c88:	00002517          	auipc	a0,0x2
ffffffffc0200c8c:	9e850513          	addi	a0,a0,-1560 # ffffffffc0202670 <etext+0x68a>
ffffffffc0200c90:	cf4ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    buddy_free_pages(p0, 1);
ffffffffc0200c94:	4585                	li	a1,1
ffffffffc0200c96:	8552                	mv	a0,s4
ffffffffc0200c98:	c9bff0ef          	jal	ra,ffffffffc0200932 <buddy_free_pages>
    assert(!list_empty(&buddy_free_area.free_areas[0].free_list));
ffffffffc0200c9c:	00893783          	ld	a5,8(s2)
ffffffffc0200ca0:	47278763          	beq	a5,s2,ffffffffc020110e <buddy_check+0x5a0>
    assert((p = buddy_alloc_pages(1)) != NULL);
ffffffffc0200ca4:	4505                	li	a0,1
ffffffffc0200ca6:	a0fff0ef          	jal	ra,ffffffffc02006b4 <buddy_alloc_pages>
ffffffffc0200caa:	8aaa                	mv	s5,a0
ffffffffc0200cac:	44050163          	beqz	a0,ffffffffc02010ee <buddy_check+0x580>
    cprintf("Reallocated 1 page at %p (original p0 was at %p)\n", p, p0);
ffffffffc0200cb0:	85aa                	mv	a1,a0
ffffffffc0200cb2:	8652                	mv	a2,s4
ffffffffc0200cb4:	00002517          	auipc	a0,0x2
ffffffffc0200cb8:	a3c50513          	addi	a0,a0,-1476 # ffffffffc02026f0 <etext+0x70a>
ffffffffc0200cbc:	cc8ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    buddy_free_area = free_area_store;
ffffffffc0200cc0:	878a                	mv	a5,sp
ffffffffc0200cc2:	00006717          	auipc	a4,0x6
ffffffffc0200cc6:	35670713          	addi	a4,a4,854 # ffffffffc0207018 <buddy_free_area>
ffffffffc0200cca:	198c                	addi	a1,sp,240
ffffffffc0200ccc:	0007b303          	ld	t1,0(a5)
ffffffffc0200cd0:	0087b883          	ld	a7,8(a5)
ffffffffc0200cd4:	0107b803          	ld	a6,16(a5)
ffffffffc0200cd8:	6f90                	ld	a2,24(a5)
ffffffffc0200cda:	7394                	ld	a3,32(a5)
ffffffffc0200cdc:	00673023          	sd	t1,0(a4)
ffffffffc0200ce0:	01173423          	sd	a7,8(a4)
ffffffffc0200ce4:	01073823          	sd	a6,16(a4)
ffffffffc0200ce8:	ef10                	sd	a2,24(a4)
ffffffffc0200cea:	f314                	sd	a3,32(a4)
ffffffffc0200cec:	02878793          	addi	a5,a5,40
ffffffffc0200cf0:	02870713          	addi	a4,a4,40
ffffffffc0200cf4:	fcb79ce3          	bne	a5,a1,ffffffffc0200ccc <buddy_check+0x15e>
    buddy_free_pages(p, 1);
ffffffffc0200cf8:	4585                	li	a1,1
ffffffffc0200cfa:	8556                	mv	a0,s5
ffffffffc0200cfc:	c37ff0ef          	jal	ra,ffffffffc0200932 <buddy_free_pages>
    buddy_free_pages(p1, 1);
ffffffffc0200d00:	4585                	li	a1,1
ffffffffc0200d02:	854e                	mv	a0,s3
ffffffffc0200d04:	c2fff0ef          	jal	ra,ffffffffc0200932 <buddy_free_pages>
    buddy_free_pages(p2, 1);
ffffffffc0200d08:	4585                	li	a1,1
ffffffffc0200d0a:	8526                	mv	a0,s1
ffffffffc0200d0c:	c27ff0ef          	jal	ra,ffffffffc0200932 <buddy_free_pages>
    cprintf("basic_buddy_check passed!\n");
ffffffffc0200d10:	00002517          	auipc	a0,0x2
ffffffffc0200d14:	a1850513          	addi	a0,a0,-1512 # ffffffffc0202728 <etext+0x742>
ffffffffc0200d18:	c6cff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("\n");
ffffffffc0200d1c:	00002517          	auipc	a0,0x2
ffffffffc0200d20:	e8c50513          	addi	a0,a0,-372 # ffffffffc0202ba8 <etext+0xbc2>
ffffffffc0200d24:	c60ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("=== Starting Buddy Allocator Check ===\n");
ffffffffc0200d28:	00002517          	auipc	a0,0x2
ffffffffc0200d2c:	a2050513          	addi	a0,a0,-1504 # ffffffffc0202748 <etext+0x762>
ffffffffc0200d30:	c54ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    for (int order = 0; order < MAX_ORDER; order++) {
ffffffffc0200d34:	00006717          	auipc	a4,0x6
ffffffffc0200d38:	2f470713          	addi	a4,a4,756 # ffffffffc0207028 <buddy_free_area+0x10>
    size_t total = 0;
ffffffffc0200d3c:	4581                	li	a1,0
    for (int order = 0; order < MAX_ORDER; order++) {
ffffffffc0200d3e:	46a9                	li	a3,10
        total += buddy_free_area.free_areas[order].nr_free * (1 << order);
ffffffffc0200d40:	431c                	lw	a5,0(a4)
    for (int order = 0; order < MAX_ORDER; order++) {
ffffffffc0200d42:	0761                	addi	a4,a4,24
        total += buddy_free_area.free_areas[order].nr_free * (1 << order);
ffffffffc0200d44:	008797bb          	sllw	a5,a5,s0
ffffffffc0200d48:	1782                	slli	a5,a5,0x20
ffffffffc0200d4a:	9381                	srli	a5,a5,0x20
    for (int order = 0; order < MAX_ORDER; order++) {
ffffffffc0200d4c:	2405                	addiw	s0,s0,1
        total += buddy_free_area.free_areas[order].nr_free * (1 << order);
ffffffffc0200d4e:	95be                	add	a1,a1,a5
    for (int order = 0; order < MAX_ORDER; order++) {
ffffffffc0200d50:	fed418e3          	bne	s0,a3,ffffffffc0200d40 <buddy_check+0x1d2>
    cprintf("Initial free pages: %d\n", initial_free_pages);
ffffffffc0200d54:	00002517          	auipc	a0,0x2
ffffffffc0200d58:	a1c50513          	addi	a0,a0,-1508 # ffffffffc0202770 <etext+0x78a>
ffffffffc0200d5c:	c28ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("\n[Test 1] Single page allocation and free\n");
ffffffffc0200d60:	00002517          	auipc	a0,0x2
ffffffffc0200d64:	a2850513          	addi	a0,a0,-1496 # ffffffffc0202788 <etext+0x7a2>
ffffffffc0200d68:	c1cff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    struct Page* p1 = buddy_alloc_pages(1);
ffffffffc0200d6c:	4505                	li	a0,1
ffffffffc0200d6e:	947ff0ef          	jal	ra,ffffffffc02006b4 <buddy_alloc_pages>
ffffffffc0200d72:	842a                	mv	s0,a0
    if (p1 != NULL) {
ffffffffc0200d74:	20050863          	beqz	a0,ffffffffc0200f84 <buddy_check+0x416>
        cprintf(" Allocated 1 page at %p\n", p1);
ffffffffc0200d78:	85aa                	mv	a1,a0
ffffffffc0200d7a:	00002517          	auipc	a0,0x2
ffffffffc0200d7e:	a3e50513          	addi	a0,a0,-1474 # ffffffffc02027b8 <etext+0x7d2>
ffffffffc0200d82:	c02ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
        assert(p1->property == 1);
ffffffffc0200d86:	4818                	lw	a4,16(s0)
ffffffffc0200d88:	4785                	li	a5,1
ffffffffc0200d8a:	2af71263          	bne	a4,a5,ffffffffc020102e <buddy_check+0x4c0>
        assert(!PageProperty(p1)); // 分配后应该清除PageProperty标志
ffffffffc0200d8e:	641c                	ld	a5,8(s0)
ffffffffc0200d90:	8b89                	andi	a5,a5,2
ffffffffc0200d92:	32079e63          	bnez	a5,ffffffffc02010ce <buddy_check+0x560>
        buddy_print_status();
ffffffffc0200d96:	8b7ff0ef          	jal	ra,ffffffffc020064c <buddy_print_status>
        buddy_free_pages(p1, 1);
ffffffffc0200d9a:	4585                	li	a1,1
ffffffffc0200d9c:	8522                	mv	a0,s0
ffffffffc0200d9e:	b95ff0ef          	jal	ra,ffffffffc0200932 <buddy_free_pages>
        cprintf(" Freed 1 page\n");
ffffffffc0200da2:	00002517          	auipc	a0,0x2
ffffffffc0200da6:	a6650513          	addi	a0,a0,-1434 # ffffffffc0202808 <etext+0x822>
ffffffffc0200daa:	bdaff0ef          	jal	ra,ffffffffc0200184 <cprintf>
        buddy_print_status();
ffffffffc0200dae:	89fff0ef          	jal	ra,ffffffffc020064c <buddy_print_status>
    cprintf("\n[Test 2] Multi-page allocation and free\n");
ffffffffc0200db2:	00002517          	auipc	a0,0x2
ffffffffc0200db6:	a8650513          	addi	a0,a0,-1402 # ffffffffc0202838 <etext+0x852>
ffffffffc0200dba:	bcaff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    struct Page* p4 = buddy_alloc_pages(4);
ffffffffc0200dbe:	4511                	li	a0,4
ffffffffc0200dc0:	8f5ff0ef          	jal	ra,ffffffffc02006b4 <buddy_alloc_pages>
ffffffffc0200dc4:	842a                	mv	s0,a0
    if (p4 != NULL) {
ffffffffc0200dc6:	18050663          	beqz	a0,ffffffffc0200f52 <buddy_check+0x3e4>
        cprintf(" Allocated 4 pages at %p\n", p4);
ffffffffc0200dca:	85aa                	mv	a1,a0
ffffffffc0200dcc:	00002517          	auipc	a0,0x2
ffffffffc0200dd0:	a9c50513          	addi	a0,a0,-1380 # ffffffffc0202868 <etext+0x882>
ffffffffc0200dd4:	bb0ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
        assert(p4->property == 4);
ffffffffc0200dd8:	4818                	lw	a4,16(s0)
ffffffffc0200dda:	4791                	li	a5,4
ffffffffc0200ddc:	36f71963          	bne	a4,a5,ffffffffc020114e <buddy_check+0x5e0>
        buddy_print_status();
ffffffffc0200de0:	86dff0ef          	jal	ra,ffffffffc020064c <buddy_print_status>
        buddy_free_pages(p4, 4);
ffffffffc0200de4:	4591                	li	a1,4
ffffffffc0200de6:	8522                	mv	a0,s0
ffffffffc0200de8:	b4bff0ef          	jal	ra,ffffffffc0200932 <buddy_free_pages>
        cprintf(" Freed 4 pages\n");
ffffffffc0200dec:	00002517          	auipc	a0,0x2
ffffffffc0200df0:	ab450513          	addi	a0,a0,-1356 # ffffffffc02028a0 <etext+0x8ba>
ffffffffc0200df4:	b90ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
        buddy_print_status();
ffffffffc0200df8:	855ff0ef          	jal	ra,ffffffffc020064c <buddy_print_status>
    cprintf("\n[Test 3] Non-power-of-two allocation (3 pages)\n");
ffffffffc0200dfc:	00002517          	auipc	a0,0x2
ffffffffc0200e00:	ad450513          	addi	a0,a0,-1324 # ffffffffc02028d0 <etext+0x8ea>
ffffffffc0200e04:	b80ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    struct Page* p3 = buddy_alloc_pages(3);
ffffffffc0200e08:	450d                	li	a0,3
ffffffffc0200e0a:	8abff0ef          	jal	ra,ffffffffc02006b4 <buddy_alloc_pages>
ffffffffc0200e0e:	842a                	mv	s0,a0
    if (p3 != NULL) {
ffffffffc0200e10:	16050363          	beqz	a0,ffffffffc0200f76 <buddy_check+0x408>
        cprintf(" Allocated 3 pages (actually got %d pages) at %p\n", p3->property, p3);
ffffffffc0200e14:	490c                	lw	a1,16(a0)
ffffffffc0200e16:	862a                	mv	a2,a0
ffffffffc0200e18:	00002517          	auipc	a0,0x2
ffffffffc0200e1c:	af050513          	addi	a0,a0,-1296 # ffffffffc0202908 <etext+0x922>
ffffffffc0200e20:	b64ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
        assert(p3->property == 4); // 3页应该分配4页
ffffffffc0200e24:	4818                	lw	a4,16(s0)
ffffffffc0200e26:	4791                	li	a5,4
ffffffffc0200e28:	34f71363          	bne	a4,a5,ffffffffc020116e <buddy_check+0x600>
        buddy_print_status();
ffffffffc0200e2c:	821ff0ef          	jal	ra,ffffffffc020064c <buddy_print_status>
        buddy_free_pages(p3, 4); // 释放时需要按实际分配的大小
ffffffffc0200e30:	4591                	li	a1,4
ffffffffc0200e32:	8522                	mv	a0,s0
ffffffffc0200e34:	affff0ef          	jal	ra,ffffffffc0200932 <buddy_free_pages>
        cprintf(" Freed the allocated block\n");
ffffffffc0200e38:	00002517          	auipc	a0,0x2
ffffffffc0200e3c:	b2050513          	addi	a0,a0,-1248 # ffffffffc0202958 <etext+0x972>
ffffffffc0200e40:	b44ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
        buddy_print_status();
ffffffffc0200e44:	809ff0ef          	jal	ra,ffffffffc020064c <buddy_print_status>
    cprintf("\n[Test 4] Buddy merge functionality\n");
ffffffffc0200e48:	00002517          	auipc	a0,0x2
ffffffffc0200e4c:	b5050513          	addi	a0,a0,-1200 # ffffffffc0202998 <etext+0x9b2>
ffffffffc0200e50:	b34ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    struct Page* partner1 = buddy_alloc_pages(2);
ffffffffc0200e54:	4509                	li	a0,2
ffffffffc0200e56:	85fff0ef          	jal	ra,ffffffffc02006b4 <buddy_alloc_pages>
ffffffffc0200e5a:	842a                	mv	s0,a0
    struct Page* partner2 = buddy_alloc_pages(2);
ffffffffc0200e5c:	4509                	li	a0,2
ffffffffc0200e5e:	857ff0ef          	jal	ra,ffffffffc02006b4 <buddy_alloc_pages>
ffffffffc0200e62:	84aa                	mv	s1,a0
    if (partner1 != NULL && partner2 != NULL) {
ffffffffc0200e64:	c425                	beqz	s0,ffffffffc0200ecc <buddy_check+0x35e>
ffffffffc0200e66:	c13d                	beqz	a0,ffffffffc0200ecc <buddy_check+0x35e>
        cprintf(" Allocated two 2-page blocks: %p and %p\n", partner1, partner2);
ffffffffc0200e68:	862a                	mv	a2,a0
ffffffffc0200e6a:	85a2                	mv	a1,s0
ffffffffc0200e6c:	00002517          	auipc	a0,0x2
ffffffffc0200e70:	b5450513          	addi	a0,a0,-1196 # ffffffffc02029c0 <etext+0x9da>
ffffffffc0200e74:	b10ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
        if ((partner2 - partner1) == 2) {
ffffffffc0200e78:	fb048793          	addi	a5,s1,-80
ffffffffc0200e7c:	12878263          	beq	a5,s0,ffffffffc0200fa0 <buddy_check+0x432>
        buddy_print_status();
ffffffffc0200e80:	fccff0ef          	jal	ra,ffffffffc020064c <buddy_print_status>
        buddy_free_pages(partner1, 2);
ffffffffc0200e84:	4589                	li	a1,2
ffffffffc0200e86:	8522                	mv	a0,s0
ffffffffc0200e88:	aabff0ef          	jal	ra,ffffffffc0200932 <buddy_free_pages>
        cprintf(" Freed first buddy\n");
ffffffffc0200e8c:	00002517          	auipc	a0,0x2
ffffffffc0200e90:	b8450513          	addi	a0,a0,-1148 # ffffffffc0202a10 <etext+0xa2a>
ffffffffc0200e94:	af0ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
        buddy_print_status();
ffffffffc0200e98:	fb4ff0ef          	jal	ra,ffffffffc020064c <buddy_print_status>
        buddy_free_pages(partner2, 2);
ffffffffc0200e9c:	4589                	li	a1,2
ffffffffc0200e9e:	8526                	mv	a0,s1
ffffffffc0200ea0:	a93ff0ef          	jal	ra,ffffffffc0200932 <buddy_free_pages>
        cprintf(" Freed second buddy - should merge into 4-page block\n");
ffffffffc0200ea4:	00002517          	auipc	a0,0x2
ffffffffc0200ea8:	b8450513          	addi	a0,a0,-1148 # ffffffffc0202a28 <etext+0xa42>
ffffffffc0200eac:	ad8ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
        buddy_print_status();
ffffffffc0200eb0:	f9cff0ef          	jal	ra,ffffffffc020064c <buddy_print_status>
        if (buddy_free_area.free_areas[2].nr_free == 1) {
ffffffffc0200eb4:	04092703          	lw	a4,64(s2)
ffffffffc0200eb8:	4785                	li	a5,1
ffffffffc0200eba:	00f71f63          	bne	a4,a5,ffffffffc0200ed8 <buddy_check+0x36a>
            cprintf(" Successfully merged into order-2 block (4 pages)\n");
ffffffffc0200ebe:	00002517          	auipc	a0,0x2
ffffffffc0200ec2:	ba250513          	addi	a0,a0,-1118 # ffffffffc0202a60 <etext+0xa7a>
ffffffffc0200ec6:	abeff0ef          	jal	ra,ffffffffc0200184 <cprintf>
ffffffffc0200eca:	a039                	j	ffffffffc0200ed8 <buddy_check+0x36a>
        cprintf(" Failed to allocate buddy blocks\n");
ffffffffc0200ecc:	00002517          	auipc	a0,0x2
ffffffffc0200ed0:	bcc50513          	addi	a0,a0,-1076 # ffffffffc0202a98 <etext+0xab2>
ffffffffc0200ed4:	ab0ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("\n[Test 5] Maximum block allocation\n");
ffffffffc0200ed8:	00002517          	auipc	a0,0x2
ffffffffc0200edc:	be850513          	addi	a0,a0,-1048 # ffffffffc0202ac0 <etext+0xada>
ffffffffc0200ee0:	aa4ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    struct Page* max_block = buddy_alloc_pages(max_order_pages);
ffffffffc0200ee4:	20000513          	li	a0,512
ffffffffc0200ee8:	fccff0ef          	jal	ra,ffffffffc02006b4 <buddy_alloc_pages>
ffffffffc0200eec:	842a                	mv	s0,a0
    if (max_block != NULL) {
ffffffffc0200eee:	c155                	beqz	a0,ffffffffc0200f92 <buddy_check+0x424>
        cprintf(" Allocated maximum block (%d pages) at %p\n", max_order_pages, max_block);
ffffffffc0200ef0:	862a                	mv	a2,a0
ffffffffc0200ef2:	20000593          	li	a1,512
ffffffffc0200ef6:	00002517          	auipc	a0,0x2
ffffffffc0200efa:	bf250513          	addi	a0,a0,-1038 # ffffffffc0202ae8 <etext+0xb02>
ffffffffc0200efe:	a86ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
        assert(max_block->property == max_order_pages);
ffffffffc0200f02:	4818                	lw	a4,16(s0)
ffffffffc0200f04:	20000793          	li	a5,512
ffffffffc0200f08:	1af71363          	bne	a4,a5,ffffffffc02010ae <buddy_check+0x540>
        buddy_print_status();
ffffffffc0200f0c:	f40ff0ef          	jal	ra,ffffffffc020064c <buddy_print_status>
        buddy_free_pages(max_block, max_order_pages);
ffffffffc0200f10:	20000593          	li	a1,512
ffffffffc0200f14:	8522                	mv	a0,s0
ffffffffc0200f16:	a1dff0ef          	jal	ra,ffffffffc0200932 <buddy_free_pages>
        cprintf(" Freed maximum block\n");
ffffffffc0200f1a:	00002517          	auipc	a0,0x2
ffffffffc0200f1e:	c2650513          	addi	a0,a0,-986 # ffffffffc0202b40 <etext+0xb5a>
ffffffffc0200f22:	a62ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
        buddy_print_status();
ffffffffc0200f26:	f26ff0ef          	jal	ra,ffffffffc020064c <buddy_print_status>
    cprintf("=== Buddy Allocator Check Completed ===\n\n");
ffffffffc0200f2a:	00002517          	auipc	a0,0x2
ffffffffc0200f2e:	c5650513          	addi	a0,a0,-938 # ffffffffc0202b80 <etext+0xb9a>
ffffffffc0200f32:	a52ff0ef          	jal	ra,ffffffffc0200184 <cprintf>

    // 运行所有测试
    basic_buddy_check();
    buddy_alloc_free_check();
    cprintf("All buddy system tests passed!\n");
}
ffffffffc0200f36:	7412                	ld	s0,288(sp)
ffffffffc0200f38:	70b2                	ld	ra,296(sp)
ffffffffc0200f3a:	64f2                	ld	s1,280(sp)
ffffffffc0200f3c:	6952                	ld	s2,272(sp)
ffffffffc0200f3e:	69b2                	ld	s3,264(sp)
ffffffffc0200f40:	6a12                	ld	s4,256(sp)
ffffffffc0200f42:	7aee                	ld	s5,248(sp)
    cprintf("All buddy system tests passed!\n");
ffffffffc0200f44:	00002517          	auipc	a0,0x2
ffffffffc0200f48:	c6c50513          	addi	a0,a0,-916 # ffffffffc0202bb0 <etext+0xbca>
}
ffffffffc0200f4c:	6155                	addi	sp,sp,304
    cprintf("All buddy system tests passed!\n");
ffffffffc0200f4e:	a36ff06f          	j	ffffffffc0200184 <cprintf>
        cprintf(" Failed to allocate 4 pages\n");
ffffffffc0200f52:	00002517          	auipc	a0,0x2
ffffffffc0200f56:	95e50513          	addi	a0,a0,-1698 # ffffffffc02028b0 <etext+0x8ca>
ffffffffc0200f5a:	a2aff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("\n[Test 3] Non-power-of-two allocation (3 pages)\n");
ffffffffc0200f5e:	00002517          	auipc	a0,0x2
ffffffffc0200f62:	97250513          	addi	a0,a0,-1678 # ffffffffc02028d0 <etext+0x8ea>
ffffffffc0200f66:	a1eff0ef          	jal	ra,ffffffffc0200184 <cprintf>
    struct Page* p3 = buddy_alloc_pages(3);
ffffffffc0200f6a:	450d                	li	a0,3
ffffffffc0200f6c:	f48ff0ef          	jal	ra,ffffffffc02006b4 <buddy_alloc_pages>
ffffffffc0200f70:	842a                	mv	s0,a0
    if (p3 != NULL) {
ffffffffc0200f72:	ea0511e3          	bnez	a0,ffffffffc0200e14 <buddy_check+0x2a6>
        cprintf(" Failed to allocate 3 pages\n");
ffffffffc0200f76:	00002517          	auipc	a0,0x2
ffffffffc0200f7a:	a0250513          	addi	a0,a0,-1534 # ffffffffc0202978 <etext+0x992>
ffffffffc0200f7e:	a06ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
ffffffffc0200f82:	b5d9                	j	ffffffffc0200e48 <buddy_check+0x2da>
        cprintf(" Failed to allocate 1 page\n");
ffffffffc0200f84:	00002517          	auipc	a0,0x2
ffffffffc0200f88:	89450513          	addi	a0,a0,-1900 # ffffffffc0202818 <etext+0x832>
ffffffffc0200f8c:	9f8ff0ef          	jal	ra,ffffffffc0200184 <cprintf>
ffffffffc0200f90:	b50d                	j	ffffffffc0200db2 <buddy_check+0x244>
        cprintf(" Failed to allocate maximum block\n");
ffffffffc0200f92:	00002517          	auipc	a0,0x2
ffffffffc0200f96:	bc650513          	addi	a0,a0,-1082 # ffffffffc0202b58 <etext+0xb72>
ffffffffc0200f9a:	9eaff0ef          	jal	ra,ffffffffc0200184 <cprintf>
ffffffffc0200f9e:	b771                	j	ffffffffc0200f2a <buddy_check+0x3bc>
            cprintf(" Confirmed: blocks are buddies\n");
ffffffffc0200fa0:	00002517          	auipc	a0,0x2
ffffffffc0200fa4:	a5050513          	addi	a0,a0,-1456 # ffffffffc02029f0 <etext+0xa0a>
ffffffffc0200fa8:	9dcff0ef          	jal	ra,ffffffffc0200184 <cprintf>
ffffffffc0200fac:	bdd1                	j	ffffffffc0200e80 <buddy_check+0x312>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0200fae:	00001697          	auipc	a3,0x1
ffffffffc0200fb2:	5fa68693          	addi	a3,a3,1530 # ffffffffc02025a8 <etext+0x5c2>
ffffffffc0200fb6:	00001617          	auipc	a2,0x1
ffffffffc0200fba:	37260613          	addi	a2,a2,882 # ffffffffc0202328 <etext+0x342>
ffffffffc0200fbe:	0d500593          	li	a1,213
ffffffffc0200fc2:	00001517          	auipc	a0,0x1
ffffffffc0200fc6:	37e50513          	addi	a0,a0,894 # ffffffffc0202340 <etext+0x35a>
ffffffffc0200fca:	a30ff0ef          	jal	ra,ffffffffc02001fa <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0200fce:	00001697          	auipc	a3,0x1
ffffffffc0200fd2:	60268693          	addi	a3,a3,1538 # ffffffffc02025d0 <etext+0x5ea>
ffffffffc0200fd6:	00001617          	auipc	a2,0x1
ffffffffc0200fda:	35260613          	addi	a2,a2,850 # ffffffffc0202328 <etext+0x342>
ffffffffc0200fde:	0d600593          	li	a1,214
ffffffffc0200fe2:	00001517          	auipc	a0,0x1
ffffffffc0200fe6:	35e50513          	addi	a0,a0,862 # ffffffffc0202340 <etext+0x35a>
ffffffffc0200fea:	a10ff0ef          	jal	ra,ffffffffc02001fa <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0200fee:	00001697          	auipc	a3,0x1
ffffffffc0200ff2:	64268693          	addi	a3,a3,1602 # ffffffffc0202630 <etext+0x64a>
ffffffffc0200ff6:	00001617          	auipc	a2,0x1
ffffffffc0200ffa:	33260613          	addi	a2,a2,818 # ffffffffc0202328 <etext+0x342>
ffffffffc0200ffe:	0db00593          	li	a1,219
ffffffffc0201002:	00001517          	auipc	a0,0x1
ffffffffc0201006:	33e50513          	addi	a0,a0,830 # ffffffffc0202340 <etext+0x35a>
ffffffffc020100a:	9f0ff0ef          	jal	ra,ffffffffc02001fa <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc020100e:	00001697          	auipc	a3,0x1
ffffffffc0201012:	60268693          	addi	a3,a3,1538 # ffffffffc0202610 <etext+0x62a>
ffffffffc0201016:	00001617          	auipc	a2,0x1
ffffffffc020101a:	31260613          	addi	a2,a2,786 # ffffffffc0202328 <etext+0x342>
ffffffffc020101e:	0da00593          	li	a1,218
ffffffffc0201022:	00001517          	auipc	a0,0x1
ffffffffc0201026:	31e50513          	addi	a0,a0,798 # ffffffffc0202340 <etext+0x35a>
ffffffffc020102a:	9d0ff0ef          	jal	ra,ffffffffc02001fa <__panic>
        assert(p1->property == 1);
ffffffffc020102e:	00001697          	auipc	a3,0x1
ffffffffc0201032:	7aa68693          	addi	a3,a3,1962 # ffffffffc02027d8 <etext+0x7f2>
ffffffffc0201036:	00001617          	auipc	a2,0x1
ffffffffc020103a:	2f260613          	addi	a2,a2,754 # ffffffffc0202328 <etext+0x342>
ffffffffc020103e:	10400593          	li	a1,260
ffffffffc0201042:	00001517          	auipc	a0,0x1
ffffffffc0201046:	2fe50513          	addi	a0,a0,766 # ffffffffc0202340 <etext+0x35a>
ffffffffc020104a:	9b0ff0ef          	jal	ra,ffffffffc02001fa <__panic>
    assert((p2 = buddy_alloc_pages(1)) != NULL);
ffffffffc020104e:	00001697          	auipc	a3,0x1
ffffffffc0201052:	53268693          	addi	a3,a3,1330 # ffffffffc0202580 <etext+0x59a>
ffffffffc0201056:	00001617          	auipc	a2,0x1
ffffffffc020105a:	2d260613          	addi	a2,a2,722 # ffffffffc0202328 <etext+0x342>
ffffffffc020105e:	0d400593          	li	a1,212
ffffffffc0201062:	00001517          	auipc	a0,0x1
ffffffffc0201066:	2de50513          	addi	a0,a0,734 # ffffffffc0202340 <etext+0x35a>
ffffffffc020106a:	990ff0ef          	jal	ra,ffffffffc02001fa <__panic>
    assert((p1 = buddy_alloc_pages(1)) != NULL);
ffffffffc020106e:	00001697          	auipc	a3,0x1
ffffffffc0201072:	4ea68693          	addi	a3,a3,1258 # ffffffffc0202558 <etext+0x572>
ffffffffc0201076:	00001617          	auipc	a2,0x1
ffffffffc020107a:	2b260613          	addi	a2,a2,690 # ffffffffc0202328 <etext+0x342>
ffffffffc020107e:	0d300593          	li	a1,211
ffffffffc0201082:	00001517          	auipc	a0,0x1
ffffffffc0201086:	2be50513          	addi	a0,a0,702 # ffffffffc0202340 <etext+0x35a>
ffffffffc020108a:	970ff0ef          	jal	ra,ffffffffc02001fa <__panic>
    assert((p0 = buddy_alloc_pages(1)) != NULL);
ffffffffc020108e:	00001697          	auipc	a3,0x1
ffffffffc0201092:	4a268693          	addi	a3,a3,1186 # ffffffffc0202530 <etext+0x54a>
ffffffffc0201096:	00001617          	auipc	a2,0x1
ffffffffc020109a:	29260613          	addi	a2,a2,658 # ffffffffc0202328 <etext+0x342>
ffffffffc020109e:	0d200593          	li	a1,210
ffffffffc02010a2:	00001517          	auipc	a0,0x1
ffffffffc02010a6:	29e50513          	addi	a0,a0,670 # ffffffffc0202340 <etext+0x35a>
ffffffffc02010aa:	950ff0ef          	jal	ra,ffffffffc02001fa <__panic>
        assert(max_block->property == max_order_pages);
ffffffffc02010ae:	00002697          	auipc	a3,0x2
ffffffffc02010b2:	a6a68693          	addi	a3,a3,-1430 # ffffffffc0202b18 <etext+0xb32>
ffffffffc02010b6:	00001617          	auipc	a2,0x1
ffffffffc02010ba:	27260613          	addi	a2,a2,626 # ffffffffc0202328 <etext+0x342>
ffffffffc02010be:	15b00593          	li	a1,347
ffffffffc02010c2:	00001517          	auipc	a0,0x1
ffffffffc02010c6:	27e50513          	addi	a0,a0,638 # ffffffffc0202340 <etext+0x35a>
ffffffffc02010ca:	930ff0ef          	jal	ra,ffffffffc02001fa <__panic>
        assert(!PageProperty(p1)); // 分配后应该清除PageProperty标志
ffffffffc02010ce:	00001697          	auipc	a3,0x1
ffffffffc02010d2:	72268693          	addi	a3,a3,1826 # ffffffffc02027f0 <etext+0x80a>
ffffffffc02010d6:	00001617          	auipc	a2,0x1
ffffffffc02010da:	25260613          	addi	a2,a2,594 # ffffffffc0202328 <etext+0x342>
ffffffffc02010de:	10500593          	li	a1,261
ffffffffc02010e2:	00001517          	auipc	a0,0x1
ffffffffc02010e6:	25e50513          	addi	a0,a0,606 # ffffffffc0202340 <etext+0x35a>
ffffffffc02010ea:	910ff0ef          	jal	ra,ffffffffc02001fa <__panic>
    assert((p = buddy_alloc_pages(1)) != NULL);
ffffffffc02010ee:	00001697          	auipc	a3,0x1
ffffffffc02010f2:	5da68693          	addi	a3,a3,1498 # ffffffffc02026c8 <etext+0x6e2>
ffffffffc02010f6:	00001617          	auipc	a2,0x1
ffffffffc02010fa:	23260613          	addi	a2,a2,562 # ffffffffc0202328 <etext+0x342>
ffffffffc02010fe:	0e800593          	li	a1,232
ffffffffc0201102:	00001517          	auipc	a0,0x1
ffffffffc0201106:	23e50513          	addi	a0,a0,574 # ffffffffc0202340 <etext+0x35a>
ffffffffc020110a:	8f0ff0ef          	jal	ra,ffffffffc02001fa <__panic>
    assert(!list_empty(&buddy_free_area.free_areas[0].free_list));
ffffffffc020110e:	00001697          	auipc	a3,0x1
ffffffffc0201112:	58268693          	addi	a3,a3,1410 # ffffffffc0202690 <etext+0x6aa>
ffffffffc0201116:	00001617          	auipc	a2,0x1
ffffffffc020111a:	21260613          	addi	a2,a2,530 # ffffffffc0202328 <etext+0x342>
ffffffffc020111e:	0e500593          	li	a1,229
ffffffffc0201122:	00001517          	auipc	a0,0x1
ffffffffc0201126:	21e50513          	addi	a0,a0,542 # ffffffffc0202340 <etext+0x35a>
ffffffffc020112a:	8d0ff0ef          	jal	ra,ffffffffc02001fa <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc020112e:	00001697          	auipc	a3,0x1
ffffffffc0201132:	52268693          	addi	a3,a3,1314 # ffffffffc0202650 <etext+0x66a>
ffffffffc0201136:	00001617          	auipc	a2,0x1
ffffffffc020113a:	1f260613          	addi	a2,a2,498 # ffffffffc0202328 <etext+0x342>
ffffffffc020113e:	0dc00593          	li	a1,220
ffffffffc0201142:	00001517          	auipc	a0,0x1
ffffffffc0201146:	1fe50513          	addi	a0,a0,510 # ffffffffc0202340 <etext+0x35a>
ffffffffc020114a:	8b0ff0ef          	jal	ra,ffffffffc02001fa <__panic>
        assert(p4->property == 4);
ffffffffc020114e:	00001697          	auipc	a3,0x1
ffffffffc0201152:	73a68693          	addi	a3,a3,1850 # ffffffffc0202888 <etext+0x8a2>
ffffffffc0201156:	00001617          	auipc	a2,0x1
ffffffffc020115a:	1d260613          	addi	a2,a2,466 # ffffffffc0202328 <etext+0x342>
ffffffffc020115e:	11600593          	li	a1,278
ffffffffc0201162:	00001517          	auipc	a0,0x1
ffffffffc0201166:	1de50513          	addi	a0,a0,478 # ffffffffc0202340 <etext+0x35a>
ffffffffc020116a:	890ff0ef          	jal	ra,ffffffffc02001fa <__panic>
        assert(p3->property == 4); // 3页应该分配4页
ffffffffc020116e:	00001697          	auipc	a3,0x1
ffffffffc0201172:	7d268693          	addi	a3,a3,2002 # ffffffffc0202940 <etext+0x95a>
ffffffffc0201176:	00001617          	auipc	a2,0x1
ffffffffc020117a:	1b260613          	addi	a2,a2,434 # ffffffffc0202328 <etext+0x342>
ffffffffc020117e:	12700593          	li	a1,295
ffffffffc0201182:	00001517          	auipc	a0,0x1
ffffffffc0201186:	1be50513          	addi	a0,a0,446 # ffffffffc0202340 <etext+0x35a>
ffffffffc020118a:	870ff0ef          	jal	ra,ffffffffc02001fa <__panic>

ffffffffc020118e <alloc_pages>:
}

// alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE
// memory
struct Page *alloc_pages(size_t n) {
    return pmm_manager->alloc_pages(n);
ffffffffc020118e:	00006797          	auipc	a5,0x6
ffffffffc0201192:	1227b783          	ld	a5,290(a5) # ffffffffc02072b0 <pmm_manager>
ffffffffc0201196:	6f9c                	ld	a5,24(a5)
ffffffffc0201198:	8782                	jr	a5

ffffffffc020119a <pmm_init>:
    pmm_manager = &buddy_pmm_manager;
ffffffffc020119a:	00002797          	auipc	a5,0x2
ffffffffc020119e:	a4e78793          	addi	a5,a5,-1458 # ffffffffc0202be8 <buddy_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc02011a2:	638c                	ld	a1,0(a5)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
    }
}

/* pmm_init - initialize the physical memory management */
void pmm_init(void) {
ffffffffc02011a4:	7179                	addi	sp,sp,-48
ffffffffc02011a6:	f022                	sd	s0,32(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc02011a8:	00002517          	auipc	a0,0x2
ffffffffc02011ac:	a7850513          	addi	a0,a0,-1416 # ffffffffc0202c20 <buddy_pmm_manager+0x38>
    pmm_manager = &buddy_pmm_manager;
ffffffffc02011b0:	00006417          	auipc	s0,0x6
ffffffffc02011b4:	10040413          	addi	s0,s0,256 # ffffffffc02072b0 <pmm_manager>
void pmm_init(void) {
ffffffffc02011b8:	f406                	sd	ra,40(sp)
ffffffffc02011ba:	ec26                	sd	s1,24(sp)
ffffffffc02011bc:	e44e                	sd	s3,8(sp)
ffffffffc02011be:	e84a                	sd	s2,16(sp)
ffffffffc02011c0:	e052                	sd	s4,0(sp)
    pmm_manager = &buddy_pmm_manager;
ffffffffc02011c2:	e01c                	sd	a5,0(s0)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc02011c4:	fc1fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    pmm_manager->init();
ffffffffc02011c8:	601c                	ld	a5,0(s0)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc02011ca:	00006497          	auipc	s1,0x6
ffffffffc02011ce:	0fe48493          	addi	s1,s1,254 # ffffffffc02072c8 <va_pa_offset>
    pmm_manager->init();
ffffffffc02011d2:	679c                	ld	a5,8(a5)
ffffffffc02011d4:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc02011d6:	57f5                	li	a5,-3
ffffffffc02011d8:	07fa                	slli	a5,a5,0x1e
ffffffffc02011da:	e09c                	sd	a5,0(s1)
    uint64_t mem_begin = get_memory_base();
ffffffffc02011dc:	c18ff0ef          	jal	ra,ffffffffc02005f4 <get_memory_base>
ffffffffc02011e0:	89aa                	mv	s3,a0
    uint64_t mem_size  = get_memory_size();
ffffffffc02011e2:	c1cff0ef          	jal	ra,ffffffffc02005fe <get_memory_size>
    if (mem_size == 0) {
ffffffffc02011e6:	14050d63          	beqz	a0,ffffffffc0201340 <pmm_init+0x1a6>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc02011ea:	892a                	mv	s2,a0
    cprintf("physcial memory map:\n");
ffffffffc02011ec:	00002517          	auipc	a0,0x2
ffffffffc02011f0:	a7c50513          	addi	a0,a0,-1412 # ffffffffc0202c68 <buddy_pmm_manager+0x80>
ffffffffc02011f4:	f91fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc02011f8:	01298a33          	add	s4,s3,s2
    cprintf("  memory: 0x%016lx, [0x%016lx, 0x%016lx].\n", mem_size, mem_begin,
ffffffffc02011fc:	864e                	mv	a2,s3
ffffffffc02011fe:	fffa0693          	addi	a3,s4,-1
ffffffffc0201202:	85ca                	mv	a1,s2
ffffffffc0201204:	00002517          	auipc	a0,0x2
ffffffffc0201208:	a7c50513          	addi	a0,a0,-1412 # ffffffffc0202c80 <buddy_pmm_manager+0x98>
ffffffffc020120c:	f79fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc0201210:	c80007b7          	lui	a5,0xc8000
ffffffffc0201214:	8652                	mv	a2,s4
ffffffffc0201216:	0d47e463          	bltu	a5,s4,ffffffffc02012de <pmm_init+0x144>
ffffffffc020121a:	00007797          	auipc	a5,0x7
ffffffffc020121e:	0b578793          	addi	a5,a5,181 # ffffffffc02082cf <end+0xfff>
ffffffffc0201222:	757d                	lui	a0,0xfffff
ffffffffc0201224:	8d7d                	and	a0,a0,a5
ffffffffc0201226:	8231                	srli	a2,a2,0xc
ffffffffc0201228:	00006797          	auipc	a5,0x6
ffffffffc020122c:	06c7bc23          	sd	a2,120(a5) # ffffffffc02072a0 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0201230:	00006797          	auipc	a5,0x6
ffffffffc0201234:	06a7bc23          	sd	a0,120(a5) # ffffffffc02072a8 <pages>
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0201238:	000807b7          	lui	a5,0x80
ffffffffc020123c:	002005b7          	lui	a1,0x200
ffffffffc0201240:	02f60563          	beq	a2,a5,ffffffffc020126a <pmm_init+0xd0>
ffffffffc0201244:	00261593          	slli	a1,a2,0x2
ffffffffc0201248:	00c586b3          	add	a3,a1,a2
ffffffffc020124c:	fec007b7          	lui	a5,0xfec00
ffffffffc0201250:	97aa                	add	a5,a5,a0
ffffffffc0201252:	068e                	slli	a3,a3,0x3
ffffffffc0201254:	96be                	add	a3,a3,a5
ffffffffc0201256:	87aa                	mv	a5,a0
        SetPageReserved(pages + i);
ffffffffc0201258:	6798                	ld	a4,8(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc020125a:	02878793          	addi	a5,a5,40 # fffffffffec00028 <end+0x3e9f8d58>
        SetPageReserved(pages + i);
ffffffffc020125e:	00176713          	ori	a4,a4,1
ffffffffc0201262:	fee7b023          	sd	a4,-32(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0201266:	fef699e3          	bne	a3,a5,ffffffffc0201258 <pmm_init+0xbe>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc020126a:	95b2                	add	a1,a1,a2
ffffffffc020126c:	fec006b7          	lui	a3,0xfec00
ffffffffc0201270:	96aa                	add	a3,a3,a0
ffffffffc0201272:	058e                	slli	a1,a1,0x3
ffffffffc0201274:	96ae                	add	a3,a3,a1
ffffffffc0201276:	c02007b7          	lui	a5,0xc0200
ffffffffc020127a:	0af6e763          	bltu	a3,a5,ffffffffc0201328 <pmm_init+0x18e>
ffffffffc020127e:	6098                	ld	a4,0(s1)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc0201280:	77fd                	lui	a5,0xfffff
ffffffffc0201282:	00fa75b3          	and	a1,s4,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0201286:	8e99                	sub	a3,a3,a4
    if (freemem < mem_end) {
ffffffffc0201288:	04b6ee63          	bltu	a3,a1,ffffffffc02012e4 <pmm_init+0x14a>
    satp_physical = PADDR(satp_virtual);
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
}

static void check_alloc_page(void) {
    pmm_manager->check();
ffffffffc020128c:	601c                	ld	a5,0(s0)
ffffffffc020128e:	7b9c                	ld	a5,48(a5)
ffffffffc0201290:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc0201292:	00001517          	auipc	a0,0x1
ffffffffc0201296:	1f650513          	addi	a0,a0,502 # ffffffffc0202488 <etext+0x4a2>
ffffffffc020129a:	eebfe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    satp_virtual = (pte_t*)boot_page_table_sv39;
ffffffffc020129e:	00005597          	auipc	a1,0x5
ffffffffc02012a2:	d6258593          	addi	a1,a1,-670 # ffffffffc0206000 <boot_page_table_sv39>
ffffffffc02012a6:	00006797          	auipc	a5,0x6
ffffffffc02012aa:	00b7bd23          	sd	a1,26(a5) # ffffffffc02072c0 <satp_virtual>
    satp_physical = PADDR(satp_virtual);
ffffffffc02012ae:	c02007b7          	lui	a5,0xc0200
ffffffffc02012b2:	0af5e363          	bltu	a1,a5,ffffffffc0201358 <pmm_init+0x1be>
ffffffffc02012b6:	6090                	ld	a2,0(s1)
}
ffffffffc02012b8:	7402                	ld	s0,32(sp)
ffffffffc02012ba:	70a2                	ld	ra,40(sp)
ffffffffc02012bc:	64e2                	ld	s1,24(sp)
ffffffffc02012be:	6942                	ld	s2,16(sp)
ffffffffc02012c0:	69a2                	ld	s3,8(sp)
ffffffffc02012c2:	6a02                	ld	s4,0(sp)
    satp_physical = PADDR(satp_virtual);
ffffffffc02012c4:	40c58633          	sub	a2,a1,a2
ffffffffc02012c8:	00006797          	auipc	a5,0x6
ffffffffc02012cc:	fec7b823          	sd	a2,-16(a5) # ffffffffc02072b8 <satp_physical>
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc02012d0:	00002517          	auipc	a0,0x2
ffffffffc02012d4:	a0850513          	addi	a0,a0,-1528 # ffffffffc0202cd8 <buddy_pmm_manager+0xf0>
}
ffffffffc02012d8:	6145                	addi	sp,sp,48
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc02012da:	eabfe06f          	j	ffffffffc0200184 <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc02012de:	c8000637          	lui	a2,0xc8000
ffffffffc02012e2:	bf25                	j	ffffffffc020121a <pmm_init+0x80>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc02012e4:	6705                	lui	a4,0x1
ffffffffc02012e6:	177d                	addi	a4,a4,-1
ffffffffc02012e8:	96ba                	add	a3,a3,a4
ffffffffc02012ea:	8efd                	and	a3,a3,a5
    if (PPN(pa) >= npage) {
ffffffffc02012ec:	00c6d793          	srli	a5,a3,0xc
ffffffffc02012f0:	02c7f063          	bgeu	a5,a2,ffffffffc0201310 <pmm_init+0x176>
    pmm_manager->init_memmap(base, n);
ffffffffc02012f4:	6010                	ld	a2,0(s0)
    return &pages[PPN(pa) - nbase];
ffffffffc02012f6:	fff80737          	lui	a4,0xfff80
ffffffffc02012fa:	973e                	add	a4,a4,a5
ffffffffc02012fc:	00271793          	slli	a5,a4,0x2
ffffffffc0201300:	97ba                	add	a5,a5,a4
ffffffffc0201302:	6a18                	ld	a4,16(a2)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0201304:	8d95                	sub	a1,a1,a3
ffffffffc0201306:	078e                	slli	a5,a5,0x3
    pmm_manager->init_memmap(base, n);
ffffffffc0201308:	81b1                	srli	a1,a1,0xc
ffffffffc020130a:	953e                	add	a0,a0,a5
ffffffffc020130c:	9702                	jalr	a4
}
ffffffffc020130e:	bfbd                	j	ffffffffc020128c <pmm_init+0xf2>
        panic("pa2page called with invalid pa");
ffffffffc0201310:	00001617          	auipc	a2,0x1
ffffffffc0201314:	14860613          	addi	a2,a2,328 # ffffffffc0202458 <etext+0x472>
ffffffffc0201318:	06a00593          	li	a1,106
ffffffffc020131c:	00001517          	auipc	a0,0x1
ffffffffc0201320:	15c50513          	addi	a0,a0,348 # ffffffffc0202478 <etext+0x492>
ffffffffc0201324:	ed7fe0ef          	jal	ra,ffffffffc02001fa <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0201328:	00002617          	auipc	a2,0x2
ffffffffc020132c:	98860613          	addi	a2,a2,-1656 # ffffffffc0202cb0 <buddy_pmm_manager+0xc8>
ffffffffc0201330:	05f00593          	li	a1,95
ffffffffc0201334:	00002517          	auipc	a0,0x2
ffffffffc0201338:	92450513          	addi	a0,a0,-1756 # ffffffffc0202c58 <buddy_pmm_manager+0x70>
ffffffffc020133c:	ebffe0ef          	jal	ra,ffffffffc02001fa <__panic>
        panic("DTB memory info not available");
ffffffffc0201340:	00002617          	auipc	a2,0x2
ffffffffc0201344:	8f860613          	addi	a2,a2,-1800 # ffffffffc0202c38 <buddy_pmm_manager+0x50>
ffffffffc0201348:	04700593          	li	a1,71
ffffffffc020134c:	00002517          	auipc	a0,0x2
ffffffffc0201350:	90c50513          	addi	a0,a0,-1780 # ffffffffc0202c58 <buddy_pmm_manager+0x70>
ffffffffc0201354:	ea7fe0ef          	jal	ra,ffffffffc02001fa <__panic>
    satp_physical = PADDR(satp_virtual);
ffffffffc0201358:	86ae                	mv	a3,a1
ffffffffc020135a:	00002617          	auipc	a2,0x2
ffffffffc020135e:	95660613          	addi	a2,a2,-1706 # ffffffffc0202cb0 <buddy_pmm_manager+0xc8>
ffffffffc0201362:	07a00593          	li	a1,122
ffffffffc0201366:	00002517          	auipc	a0,0x2
ffffffffc020136a:	8f250513          	addi	a0,a0,-1806 # ffffffffc0202c58 <buddy_pmm_manager+0x70>
ffffffffc020136e:	e8dfe0ef          	jal	ra,ffffffffc02001fa <__panic>

ffffffffc0201372 <kmalloc.part.0>:
}
return -1;//超过最大对象大小，分配失败
}
//实现kmalloc函数用于对象分配
//SLUB对外接口：分配任意大小的内存
void* kmalloc(size_t size) {
ffffffffc0201372:	7139                	addi	sp,sp,-64
ffffffffc0201374:	fc06                	sd	ra,56(sp)
ffffffffc0201376:	f822                	sd	s0,48(sp)
ffffffffc0201378:	f426                	sd	s1,40(sp)
ffffffffc020137a:	f04a                	sd	s2,32(sp)
ffffffffc020137c:	ec4e                	sd	s3,24(sp)
ffffffffc020137e:	e852                	sd	s4,16(sp)
ffffffffc0201380:	e456                	sd	s5,8(sp)
if(g_obj_sizes[i]>=req_size){
ffffffffc0201382:	47a1                	li	a5,8
void* kmalloc(size_t size) {
ffffffffc0201384:	85aa                	mv	a1,a0
if(g_obj_sizes[i]>=req_size){
ffffffffc0201386:	04a7f663          	bgeu	a5,a0,ffffffffc02013d2 <kmalloc.part.0+0x60>
ffffffffc020138a:	47c1                	li	a5,16
ffffffffc020138c:	22a7fb63          	bgeu	a5,a0,ffffffffc02015c2 <kmalloc.part.0+0x250>
ffffffffc0201390:	02000793          	li	a5,32
ffffffffc0201394:	22a7f963          	bgeu	a5,a0,ffffffffc02015c6 <kmalloc.part.0+0x254>
ffffffffc0201398:	04000793          	li	a5,64
ffffffffc020139c:	22a7f763          	bgeu	a5,a0,ffffffffc02015ca <kmalloc.part.0+0x258>
ffffffffc02013a0:	08000793          	li	a5,128
ffffffffc02013a4:	22a7f563          	bgeu	a5,a0,ffffffffc02015ce <kmalloc.part.0+0x25c>
ffffffffc02013a8:	10000793          	li	a5,256
ffffffffc02013ac:	22a7f363          	bgeu	a5,a0,ffffffffc02015d2 <kmalloc.part.0+0x260>
    }

    //找到对应的缓存池
    int cache_idx = slub_get_cache_idx(size);
    if (cache_idx == -1) {
        cprintf("SLUB_DEBUG: no suitable cache found\n");
ffffffffc02013b0:	00002517          	auipc	a0,0x2
ffffffffc02013b4:	96850513          	addi	a0,a0,-1688 # ffffffffc0202d18 <buddy_pmm_manager+0x130>
ffffffffc02013b8:	dcdfe0ef          	jal	ra,ffffffffc0200184 <cprintf>
        return NULL;
ffffffffc02013bc:	4401                	li	s0,0

    //返回对象的虚拟地址（链表节点的地址为虚拟地址）
    void* obj_va = (void*)free_obj_node;
    cprintf("kmalloc: success (obj_va=%p, size=%dB)\n", obj_va, cache->obj_size);
    return obj_va;
}
ffffffffc02013be:	70e2                	ld	ra,56(sp)
ffffffffc02013c0:	8522                	mv	a0,s0
ffffffffc02013c2:	7442                	ld	s0,48(sp)
ffffffffc02013c4:	74a2                	ld	s1,40(sp)
ffffffffc02013c6:	7902                	ld	s2,32(sp)
ffffffffc02013c8:	69e2                	ld	s3,24(sp)
ffffffffc02013ca:	6a42                	ld	s4,16(sp)
ffffffffc02013cc:	6aa2                	ld	s5,8(sp)
ffffffffc02013ce:	6121                	addi	sp,sp,64
ffffffffc02013d0:	8082                	ret
for(int i=0;i<SLUB_OBJ_CNT;i++){
ffffffffc02013d2:	4681                	li	a3,0
    kmem_cache_t* cache = &slub_caches[cache_idx];
ffffffffc02013d4:	00669993          	slli	s3,a3,0x6
    cprintf("kmalloc: req=%dB → align=%dB (cache_idx=%d)\n", size, cache->obj_size, cache_idx);
ffffffffc02013d8:	00006917          	auipc	s2,0x6
ffffffffc02013dc:	d3090913          	addi	s2,s2,-720 # ffffffffc0207108 <slub_caches>
ffffffffc02013e0:	01390433          	add	s0,s2,s3
ffffffffc02013e4:	6010                	ld	a2,0(s0)
ffffffffc02013e6:	00002517          	auipc	a0,0x2
ffffffffc02013ea:	cba50513          	addi	a0,a0,-838 # ffffffffc02030a0 <buddy_pmm_manager+0x4b8>
ffffffffc02013ee:	d97fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    if (cache->state == CACHE_NEED_SLAB || list_empty(&cache->free_obj_list)) {
ffffffffc02013f2:	5c18                	lw	a4,56(s0)
ffffffffc02013f4:	4785                	li	a5,1
ffffffffc02013f6:	04f70b63          	beq	a4,a5,ffffffffc020144c <kmalloc.part.0+0xda>
ffffffffc02013fa:	7018                	ld	a4,32(s0)
ffffffffc02013fc:	01898793          	addi	a5,s3,24
    list_add(&cache->slab_list, &slab_hdr->slab_link);
ffffffffc0201400:	02898a13          	addi	s4,s3,40
    if (cache->state == CACHE_NEED_SLAB || list_empty(&cache->free_obj_list)) {
ffffffffc0201404:	97ca                	add	a5,a5,s2
    list_add(&cache->slab_list, &slab_hdr->slab_link);
ffffffffc0201406:	9a4a                	add	s4,s4,s2
    if (cache->state == CACHE_NEED_SLAB || list_empty(&cache->free_obj_list)) {
ffffffffc0201408:	04f70263          	beq	a4,a5,ffffffffc020144c <kmalloc.part.0+0xda>
    return listelm->next;
ffffffffc020140c:	994e                	add	s2,s2,s3
    cprintf("SLUB_DEBUG: getting object from free list...\n");
ffffffffc020140e:	00002517          	auipc	a0,0x2
ffffffffc0201412:	c1250513          	addi	a0,a0,-1006 # ffffffffc0203020 <buddy_pmm_manager+0x438>
ffffffffc0201416:	d6ffe0ef          	jal	ra,ffffffffc0200184 <cprintf>
ffffffffc020141a:	02093403          	ld	s0,32(s2)
    __list_del(listelm->prev, listelm->next);
ffffffffc020141e:	641c                	ld	a5,8(s0)
ffffffffc0201420:	6018                	ld	a4,0(s0)
    prev->next = next;
ffffffffc0201422:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc0201424:	e398                	sd	a4,0(a5)
    return list->next == list;
ffffffffc0201426:	03093783          	ld	a5,48(s2)
    if (list_empty(&cache->slab_list)) {
ffffffffc020142a:	19478263          	beq	a5,s4,ffffffffc02015ae <kmalloc.part.0+0x23c>
    slab_hdr->free_obj_cnt--;
ffffffffc020142e:	ff87b703          	ld	a4,-8(a5)
    cprintf("kmalloc: success (obj_va=%p, size=%dB)\n", obj_va, cache->obj_size);
ffffffffc0201432:	00093603          	ld	a2,0(s2)
ffffffffc0201436:	85a2                	mv	a1,s0
    slab_hdr->free_obj_cnt--;
ffffffffc0201438:	177d                	addi	a4,a4,-1
ffffffffc020143a:	fee7bc23          	sd	a4,-8(a5)
    cprintf("kmalloc: success (obj_va=%p, size=%dB)\n", obj_va, cache->obj_size);
ffffffffc020143e:	00002517          	auipc	a0,0x2
ffffffffc0201442:	c3a50513          	addi	a0,a0,-966 # ffffffffc0203078 <buddy_pmm_manager+0x490>
ffffffffc0201446:	d3ffe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    return obj_va;
ffffffffc020144a:	bf95                	j	ffffffffc02013be <kmalloc.part.0+0x4c>
        cprintf("SLUB_DEBUG: cache needs new slab, calling slab_alloc...\n");
ffffffffc020144c:	00002517          	auipc	a0,0x2
ffffffffc0201450:	8f450513          	addi	a0,a0,-1804 # ffffffffc0202d40 <buddy_pmm_manager+0x158>
ffffffffc0201454:	d31fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("SLUB_DEBUG: slab_alloc called for cache size=%d\n", cache->obj_size);
ffffffffc0201458:	01390433          	add	s0,s2,s3
ffffffffc020145c:	600c                	ld	a1,0(s0)
ffffffffc020145e:	00002517          	auipc	a0,0x2
ffffffffc0201462:	92250513          	addi	a0,a0,-1758 # ffffffffc0202d80 <buddy_pmm_manager+0x198>
ffffffffc0201466:	d1ffe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("SLUB_DEBUG: calling alloc_pages(1)...\n");
ffffffffc020146a:	00002517          	auipc	a0,0x2
ffffffffc020146e:	94e50513          	addi	a0,a0,-1714 # ffffffffc0202db8 <buddy_pmm_manager+0x1d0>
ffffffffc0201472:	d13fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    struct Page* slab_page = alloc_pages(1);//分配1页
ffffffffc0201476:	4505                	li	a0,1
ffffffffc0201478:	d17ff0ef          	jal	ra,ffffffffc020118e <alloc_pages>
ffffffffc020147c:	84aa                	mv	s1,a0
    if (slab_page == NULL) {
ffffffffc020147e:	16050b63          	beqz	a0,ffffffffc02015f4 <kmalloc.part.0+0x282>
    cprintf("SLUB_DEBUG: alloc_pages returned page=%p\n", slab_page);
ffffffffc0201482:	85aa                	mv	a1,a0
ffffffffc0201484:	00002517          	auipc	a0,0x2
ffffffffc0201488:	98c50513          	addi	a0,a0,-1652 # ffffffffc0202e10 <buddy_pmm_manager+0x228>
ffffffffc020148c:	cf9fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("SLUB_DEBUG: checking page validity...\n");
ffffffffc0201490:	00002517          	auipc	a0,0x2
ffffffffc0201494:	9b050513          	addi	a0,a0,-1616 # ffffffffc0202e40 <buddy_pmm_manager+0x258>
    if (slab_page < pages || slab_page >= pages + npage) {
ffffffffc0201498:	00006a17          	auipc	s4,0x6
ffffffffc020149c:	e10a0a13          	addi	s4,s4,-496 # ffffffffc02072a8 <pages>
    cprintf("SLUB_DEBUG: checking page validity...\n");
ffffffffc02014a0:	ce5fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    if (slab_page < pages || slab_page >= pages + npage) {
ffffffffc02014a4:	000a3703          	ld	a4,0(s4)
ffffffffc02014a8:	12e4e763          	bltu	s1,a4,ffffffffc02015d6 <kmalloc.part.0+0x264>
ffffffffc02014ac:	00006697          	auipc	a3,0x6
ffffffffc02014b0:	df46b683          	ld	a3,-524(a3) # ffffffffc02072a0 <npage>
ffffffffc02014b4:	00269793          	slli	a5,a3,0x2
ffffffffc02014b8:	97b6                	add	a5,a5,a3
ffffffffc02014ba:	078e                	slli	a5,a5,0x3
ffffffffc02014bc:	97ba                	add	a5,a5,a4
ffffffffc02014be:	10f4fc63          	bgeu	s1,a5,ffffffffc02015d6 <kmalloc.part.0+0x264>
    cprintf("SLUB_DEBUG: page is valid\n");
ffffffffc02014c2:	00002517          	auipc	a0,0x2
ffffffffc02014c6:	9ce50513          	addi	a0,a0,-1586 # ffffffffc0202e90 <buddy_pmm_manager+0x2a8>
ffffffffc02014ca:	cbbfe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("SLUB_DEBUG: converting to virtual address...\n");
ffffffffc02014ce:	00002517          	auipc	a0,0x2
ffffffffc02014d2:	9e250513          	addi	a0,a0,-1566 # ffffffffc0202eb0 <buddy_pmm_manager+0x2c8>
ffffffffc02014d6:	caffe0ef          	jal	ra,ffffffffc0200184 <cprintf>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc02014da:	000a3583          	ld	a1,0(s4)
ffffffffc02014de:	00002797          	auipc	a5,0x2
ffffffffc02014e2:	4e27b783          	ld	a5,1250(a5) # ffffffffc02039c0 <error_string+0x38>
ffffffffc02014e6:	00002697          	auipc	a3,0x2
ffffffffc02014ea:	4e26b683          	ld	a3,1250(a3) # ffffffffc02039c8 <nbase>
ffffffffc02014ee:	8c8d                	sub	s1,s1,a1
ffffffffc02014f0:	848d                	srai	s1,s1,0x3
ffffffffc02014f2:	02f484b3          	mul	s1,s1,a5
    cprintf("SLUB_DEBUG: slab_va=%p\n", slab_va);
ffffffffc02014f6:	00002517          	auipc	a0,0x2
ffffffffc02014fa:	9ea50513          	addi	a0,a0,-1558 # ffffffffc0202ee0 <buddy_pmm_manager+0x2f8>
    list_add(&cache->slab_list, &slab_hdr->slab_link);
ffffffffc02014fe:	02898a13          	addi	s4,s3,40
ffffffffc0201502:	9a4a                	add	s4,s4,s2
    list_entry_t* free_list = &cache->free_obj_list;
ffffffffc0201504:	01898a93          	addi	s5,s3,24
ffffffffc0201508:	9aca                	add	s5,s5,s2
ffffffffc020150a:	94b6                	add	s1,s1,a3
    return (void*)(page2pa(page) + PHYSICAL_MEMORY_OFFSET);
ffffffffc020150c:	56f5                	li	a3,-3
ffffffffc020150e:	06fa                	slli	a3,a3,0x1e
    return page2ppn(page) << PGSHIFT;
ffffffffc0201510:	04b2                	slli	s1,s1,0xc
ffffffffc0201512:	94b6                	add	s1,s1,a3
    cprintf("SLUB_DEBUG: slab_va=%p\n", slab_va);
ffffffffc0201514:	85a6                	mv	a1,s1
ffffffffc0201516:	c6ffe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    slab_hdr->free_obj_cnt = cache->objs_per_slab;
ffffffffc020151a:	681c                	ld	a5,16(s0)
    slab_hdr->slab_size = PAGE_SIZE;
ffffffffc020151c:	6705                	lui	a4,0x1
ffffffffc020151e:	e498                	sd	a4,8(s1)
    slab_hdr->free_obj_cnt = cache->objs_per_slab;
ffffffffc0201520:	e89c                	sd	a5,16(s1)
    slab_hdr->cache = cache;
ffffffffc0201522:	e080                	sd	s0,0(s1)
    cprintf("SLUB_DEBUG: slab header initialized\n");
ffffffffc0201524:	00002517          	auipc	a0,0x2
ffffffffc0201528:	9d450513          	addi	a0,a0,-1580 # ffffffffc0202ef8 <buddy_pmm_manager+0x310>
ffffffffc020152c:	c59fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("SLUB_DEBUG: adding to slab_list...\n");
ffffffffc0201530:	00002517          	auipc	a0,0x2
ffffffffc0201534:	9f050513          	addi	a0,a0,-1552 # ffffffffc0202f20 <buddy_pmm_manager+0x338>
ffffffffc0201538:	c4dfe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    __list_add(elm, listelm, listelm->next);
ffffffffc020153c:	781c                	ld	a5,48(s0)
    list_add(&cache->slab_list, &slab_hdr->slab_link);
ffffffffc020153e:	01848713          	addi	a4,s1,24
    cprintf("SLUB_DEBUG: splitting slab into objects...\n");
ffffffffc0201542:	00002517          	auipc	a0,0x2
ffffffffc0201546:	a0650513          	addi	a0,a0,-1530 # ffffffffc0202f48 <buddy_pmm_manager+0x360>
    prev->next = next->prev = elm;
ffffffffc020154a:	e398                	sd	a4,0(a5)
ffffffffc020154c:	f818                	sd	a4,48(s0)
    elm->next = next;
ffffffffc020154e:	f09c                	sd	a5,32(s1)
    elm->prev = prev;
ffffffffc0201550:	0144bc23          	sd	s4,24(s1)
ffffffffc0201554:	c31fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("SLUB_DEBUG: creating %d objects...\n", cache->objs_per_slab);
ffffffffc0201558:	680c                	ld	a1,16(s0)
ffffffffc020155a:	00002517          	auipc	a0,0x2
ffffffffc020155e:	a1e50513          	addi	a0,a0,-1506 # ffffffffc0202f78 <buddy_pmm_manager+0x390>
ffffffffc0201562:	c23fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    for (size_t i = 0;i < cache->objs_per_slab;i++) {
ffffffffc0201566:	6810                	ld	a2,16(s0)
    char* obj_va = (char*)slab_va + SLAB_HEADER_SIZE;//第一个对象地址
ffffffffc0201568:	02848793          	addi	a5,s1,40
    for (size_t i = 0;i < cache->objs_per_slab;i++) {
ffffffffc020156c:	ce11                	beqz	a2,ffffffffc0201588 <kmalloc.part.0+0x216>
ffffffffc020156e:	4701                	li	a4,0
    __list_add(elm, listelm, listelm->next);
ffffffffc0201570:	7014                	ld	a3,32(s0)
ffffffffc0201572:	0705                	addi	a4,a4,1
    prev->next = next->prev = elm;
ffffffffc0201574:	e29c                	sd	a5,0(a3)
ffffffffc0201576:	f01c                	sd	a5,32(s0)
    elm->next = next;
ffffffffc0201578:	e794                	sd	a3,8(a5)
    elm->prev = prev;
ffffffffc020157a:	0157b023          	sd	s5,0(a5)
        obj_va += cache->obj_size;
ffffffffc020157e:	6014                	ld	a3,0(s0)
    for (size_t i = 0;i < cache->objs_per_slab;i++) {
ffffffffc0201580:	6810                	ld	a2,16(s0)
        obj_va += cache->obj_size;
ffffffffc0201582:	97b6                	add	a5,a5,a3
    for (size_t i = 0;i < cache->objs_per_slab;i++) {
ffffffffc0201584:	fec766e3          	bltu	a4,a2,ffffffffc0201570 <kmalloc.part.0+0x1fe>
    cache->state = CACHE_AVAILABLE;
ffffffffc0201588:	013907b3          	add	a5,s2,s3
    cprintf("slab_alloc: success (cache=%dB, objs=%d, slab_va=%p)\n",
ffffffffc020158c:	638c                	ld	a1,0(a5)
ffffffffc020158e:	86a6                	mv	a3,s1
    cache->state = CACHE_AVAILABLE;
ffffffffc0201590:	0207ac23          	sw	zero,56(a5)
    cprintf("slab_alloc: success (cache=%dB, objs=%d, slab_va=%p)\n",
ffffffffc0201594:	00002517          	auipc	a0,0x2
ffffffffc0201598:	a0c50513          	addi	a0,a0,-1524 # ffffffffc0202fa0 <buddy_pmm_manager+0x3b8>
ffffffffc020159c:	be9fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
        cprintf("SLUB_DEBUG: slab_alloc succeeded\n");
ffffffffc02015a0:	00002517          	auipc	a0,0x2
ffffffffc02015a4:	a3850513          	addi	a0,a0,-1480 # ffffffffc0202fd8 <buddy_pmm_manager+0x3f0>
ffffffffc02015a8:	bddfe0ef          	jal	ra,ffffffffc0200184 <cprintf>
ffffffffc02015ac:	b585                	j	ffffffffc020140c <kmalloc.part.0+0x9a>
        cprintf("kmalloc: no slab in cache (%dB)\n", cache->obj_size);
ffffffffc02015ae:	00093583          	ld	a1,0(s2)
ffffffffc02015b2:	00002517          	auipc	a0,0x2
ffffffffc02015b6:	a9e50513          	addi	a0,a0,-1378 # ffffffffc0203050 <buddy_pmm_manager+0x468>
        return NULL;
ffffffffc02015ba:	4401                	li	s0,0
        cprintf("kmalloc: no slab in cache (%dB)\n", cache->obj_size);
ffffffffc02015bc:	bc9fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
        return NULL;
ffffffffc02015c0:	bbfd                	j	ffffffffc02013be <kmalloc.part.0+0x4c>
for(int i=0;i<SLUB_OBJ_CNT;i++){
ffffffffc02015c2:	4685                	li	a3,1
ffffffffc02015c4:	bd01                	j	ffffffffc02013d4 <kmalloc.part.0+0x62>
ffffffffc02015c6:	4689                	li	a3,2
ffffffffc02015c8:	b531                	j	ffffffffc02013d4 <kmalloc.part.0+0x62>
ffffffffc02015ca:	468d                	li	a3,3
ffffffffc02015cc:	b521                	j	ffffffffc02013d4 <kmalloc.part.0+0x62>
ffffffffc02015ce:	4691                	li	a3,4
ffffffffc02015d0:	b511                	j	ffffffffc02013d4 <kmalloc.part.0+0x62>
ffffffffc02015d2:	4695                	li	a3,5
ffffffffc02015d4:	b501                	j	ffffffffc02013d4 <kmalloc.part.0+0x62>
        cprintf("slab_alloc: invalid slab_page (%p)\n", slab_page);
ffffffffc02015d6:	85a6                	mv	a1,s1
ffffffffc02015d8:	00002517          	auipc	a0,0x2
ffffffffc02015dc:	89050513          	addi	a0,a0,-1904 # ffffffffc0202e68 <buddy_pmm_manager+0x280>
ffffffffc02015e0:	ba5fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
            cprintf("SLUB_DEBUG: slab_alloc failed\n");
ffffffffc02015e4:	00002517          	auipc	a0,0x2
ffffffffc02015e8:	a1c50513          	addi	a0,a0,-1508 # ffffffffc0203000 <buddy_pmm_manager+0x418>
ffffffffc02015ec:	b99fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
            return NULL;//slab分配失败，对象分配也失败
ffffffffc02015f0:	4401                	li	s0,0
ffffffffc02015f2:	b3f1                	j	ffffffffc02013be <kmalloc.part.0+0x4c>
        cprintf("slab_alloc: buddy alloc failed (no free pages)\n");
ffffffffc02015f4:	00001517          	auipc	a0,0x1
ffffffffc02015f8:	7ec50513          	addi	a0,a0,2028 # ffffffffc0202de0 <buddy_pmm_manager+0x1f8>
ffffffffc02015fc:	b89fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
        return -1;  // 分配失败
ffffffffc0201600:	b7d5                	j	ffffffffc02015e4 <kmalloc.part.0+0x272>

ffffffffc0201602 <slub_init>:
void slub_init(void) {
ffffffffc0201602:	7139                	addi	sp,sp,-64
    cprintf("SLUB: slub_init() called - starting initialization\n");
ffffffffc0201604:	00002517          	auipc	a0,0x2
ffffffffc0201608:	acc50513          	addi	a0,a0,-1332 # ffffffffc02030d0 <buddy_pmm_manager+0x4e8>
void slub_init(void) {
ffffffffc020160c:	f822                	sd	s0,48(sp)
ffffffffc020160e:	f426                	sd	s1,40(sp)
ffffffffc0201610:	f04a                	sd	s2,32(sp)
ffffffffc0201612:	ec4e                	sd	s3,24(sp)
ffffffffc0201614:	e852                	sd	s4,16(sp)
ffffffffc0201616:	e456                	sd	s5,8(sp)
ffffffffc0201618:	e05a                	sd	s6,0(sp)
ffffffffc020161a:	fc06                	sd	ra,56(sp)
        cache->objs_per_slab = (PAGE_SIZE - SLAB_HEADER_SIZE) / cache->obj_size;
ffffffffc020161c:	6985                	lui	s3,0x1
    cprintf("SLUB: slub_init() called - starting initialization\n");
ffffffffc020161e:	b67fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    for (int i = 0;i < SLUB_OBJ_CNT;i++) {
ffffffffc0201622:	00006417          	auipc	s0,0x6
ffffffffc0201626:	afe40413          	addi	s0,s0,-1282 # ffffffffc0207120 <slub_caches+0x18>
ffffffffc020162a:	00002917          	auipc	s2,0x2
ffffffffc020162e:	11e90913          	addi	s2,s2,286 # ffffffffc0203748 <g_obj_sizes>
    cprintf("SLUB: slub_init() called - starting initialization\n");
ffffffffc0201632:	4621                	li	a2,8
    for (int i = 0;i < SLUB_OBJ_CNT;i++) {
ffffffffc0201634:	4481                	li	s1,0
        cache->objs_per_slab = (PAGE_SIZE - SLAB_HEADER_SIZE) / cache->obj_size;
ffffffffc0201636:	fd898993          	addi	s3,s3,-40 # fd8 <kern_entry-0xffffffffc01ff028>
        cprintf("SLUB_DEBUG: initializing cache %d: obj_size=%d, objs_per_slab=%d\n",
ffffffffc020163a:	00002b17          	auipc	s6,0x2
ffffffffc020163e:	aceb0b13          	addi	s6,s6,-1330 # ffffffffc0203108 <buddy_pmm_manager+0x520>
        cache->state = CACHE_NEED_SLAB;
ffffffffc0201642:	4a85                	li	s5,1
    for (int i = 0;i < SLUB_OBJ_CNT;i++) {
ffffffffc0201644:	4a19                	li	s4,6
ffffffffc0201646:	a019                	j	ffffffffc020164c <slub_init+0x4a>
        cache->obj_size = g_obj_sizes[i];
ffffffffc0201648:	00093603          	ld	a2,0(s2)
        cache->objs_per_slab = (PAGE_SIZE - SLAB_HEADER_SIZE) / cache->obj_size;
ffffffffc020164c:	02c9d6b3          	divu	a3,s3,a2
        cprintf("SLUB_DEBUG: initializing cache %d: obj_size=%d, objs_per_slab=%d\n",
ffffffffc0201650:	85a6                	mv	a1,s1
        cache->obj_size = g_obj_sizes[i];
ffffffffc0201652:	fec43423          	sd	a2,-24(s0)
        cache->obj_align = g_obj_sizes[i];
ffffffffc0201656:	fec43823          	sd	a2,-16(s0)
        cprintf("SLUB_DEBUG: initializing cache %d: obj_size=%d, objs_per_slab=%d\n",
ffffffffc020165a:	855a                	mv	a0,s6
    for (int i = 0;i < SLUB_OBJ_CNT;i++) {
ffffffffc020165c:	2485                	addiw	s1,s1,1
ffffffffc020165e:	0921                	addi	s2,s2,8
        cache->objs_per_slab = (PAGE_SIZE - SLAB_HEADER_SIZE) / cache->obj_size;
ffffffffc0201660:	fed43c23          	sd	a3,-8(s0)
        cprintf("SLUB_DEBUG: initializing cache %d: obj_size=%d, objs_per_slab=%d\n",
ffffffffc0201664:	b21fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    elm->prev = elm->next = elm;
ffffffffc0201668:	01040793          	addi	a5,s0,16
ffffffffc020166c:	e400                	sd	s0,8(s0)
ffffffffc020166e:	e000                	sd	s0,0(s0)
ffffffffc0201670:	ec1c                	sd	a5,24(s0)
ffffffffc0201672:	e81c                	sd	a5,16(s0)
        cache->state = CACHE_NEED_SLAB;
ffffffffc0201674:	03542023          	sw	s5,32(s0)
    for (int i = 0;i < SLUB_OBJ_CNT;i++) {
ffffffffc0201678:	04040413          	addi	s0,s0,64
ffffffffc020167c:	fd4496e3          	bne	s1,s4,ffffffffc0201648 <slub_init+0x46>
    cprintf("SLUB init done: %d cache pools (sizes: 8B,16B,32B,64B,128B,256B)\n", SLUB_OBJ_CNT);
ffffffffc0201680:	4599                	li	a1,6
ffffffffc0201682:	00002517          	auipc	a0,0x2
ffffffffc0201686:	ace50513          	addi	a0,a0,-1330 # ffffffffc0203150 <buddy_pmm_manager+0x568>
ffffffffc020168a:	afbfe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("SLUB_DEBUG: verification - slub_caches address: %p\n", slub_caches);
ffffffffc020168e:	00006597          	auipc	a1,0x6
ffffffffc0201692:	a7a58593          	addi	a1,a1,-1414 # ffffffffc0207108 <slub_caches>
ffffffffc0201696:	00002517          	auipc	a0,0x2
ffffffffc020169a:	b0250513          	addi	a0,a0,-1278 # ffffffffc0203198 <buddy_pmm_manager+0x5b0>
ffffffffc020169e:	ae7fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    for (int i = 0;i < SLUB_OBJ_CNT;i++) {
ffffffffc02016a2:	00006497          	auipc	s1,0x6
ffffffffc02016a6:	a6648493          	addi	s1,s1,-1434 # ffffffffc0207108 <slub_caches>
ffffffffc02016aa:	4401                	li	s0,0
        cprintf("SLUB_DEBUG: cache[%d] at %p, obj_size=%d\n",
ffffffffc02016ac:	00002997          	auipc	s3,0x2
ffffffffc02016b0:	b2498993          	addi	s3,s3,-1244 # ffffffffc02031d0 <buddy_pmm_manager+0x5e8>
    for (int i = 0;i < SLUB_OBJ_CNT;i++) {
ffffffffc02016b4:	4919                	li	s2,6
        cprintf("SLUB_DEBUG: cache[%d] at %p, obj_size=%d\n",
ffffffffc02016b6:	6094                	ld	a3,0(s1)
ffffffffc02016b8:	8626                	mv	a2,s1
ffffffffc02016ba:	85a2                	mv	a1,s0
ffffffffc02016bc:	854e                	mv	a0,s3
    for (int i = 0;i < SLUB_OBJ_CNT;i++) {
ffffffffc02016be:	2405                	addiw	s0,s0,1
        cprintf("SLUB_DEBUG: cache[%d] at %p, obj_size=%d\n",
ffffffffc02016c0:	ac5fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    for (int i = 0;i < SLUB_OBJ_CNT;i++) {
ffffffffc02016c4:	04048493          	addi	s1,s1,64
ffffffffc02016c8:	ff2417e3          	bne	s0,s2,ffffffffc02016b6 <slub_init+0xb4>
}
ffffffffc02016cc:	70e2                	ld	ra,56(sp)
ffffffffc02016ce:	7442                	ld	s0,48(sp)
ffffffffc02016d0:	74a2                	ld	s1,40(sp)
ffffffffc02016d2:	7902                	ld	s2,32(sp)
ffffffffc02016d4:	69e2                	ld	s3,24(sp)
ffffffffc02016d6:	6a42                	ld	s4,16(sp)
ffffffffc02016d8:	6aa2                	ld	s5,8(sp)
ffffffffc02016da:	6b02                	ld	s6,0(sp)
ffffffffc02016dc:	6121                	addi	sp,sp,64
ffffffffc02016de:	8082                	ret

ffffffffc02016e0 <kfree>:
//检查对象合法性：确保对象地址正确在slab块内且未重复释放
//放回空闲链表：将对象的地址作为链表节点，插入缓存池的free_obj_list,更新slab块的空闲对象计数
//SLUB对外接口：释放kmalloc分配的内存
void kfree(void *obj_va){
//参数检查
if(obj_va==NULL){
ffffffffc02016e0:	c935                	beqz	a0,ffffffffc0201754 <kfree+0x74>
return;
}
//找到对象所属的slab块
uintptr_t slab_va=(uintptr_t)obj_va & ~(PAGE_SIZE - 1);
ffffffffc02016e2:	75fd                	lui	a1,0xfffff
ffffffffc02016e4:	8de9                	and	a1,a1,a0
slab_header_t *slab_hdr=(slab_header_t *)slab_va;
//验证slab_hdr的cache字段是合法缓存池（在slub_caches数组范围内）
if (slab_hdr->cache < slub_caches || slab_hdr->cache >= slub_caches + SLUB_OBJ_CNT) {
ffffffffc02016e6:	619c                	ld	a5,0(a1)
ffffffffc02016e8:	00006717          	auipc	a4,0x6
ffffffffc02016ec:	a2070713          	addi	a4,a4,-1504 # ffffffffc0207108 <slub_caches>
ffffffffc02016f0:	02e7e863          	bltu	a5,a4,ffffffffc0201720 <kfree+0x40>
ffffffffc02016f4:	00006717          	auipc	a4,0x6
ffffffffc02016f8:	b9470713          	addi	a4,a4,-1132 # ffffffffc0207288 <is_panic>
ffffffffc02016fc:	02e7f263          	bgeu	a5,a4,ffffffffc0201720 <kfree+0x40>
return;
}
kmem_cache_t *cache=slab_hdr->cache;
//验证对象合法性
uintptr_t obj_min_va = slab_va + SLAB_HEADER_SIZE;
uintptr_t obj_max_va = slab_va + PAGE_SIZE;
ffffffffc0201700:	6685                	lui	a3,0x1
uintptr_t obj_min_va = slab_va + SLAB_HEADER_SIZE;
ffffffffc0201702:	02858713          	addi	a4,a1,40 # fffffffffffff028 <end+0x3fdf7d58>
uintptr_t obj_max_va = slab_va + PAGE_SIZE;
ffffffffc0201706:	96ae                	add	a3,a3,a1
if ((uintptr_t)obj_va < obj_min_va || (uintptr_t)obj_va >= obj_max_va) {
ffffffffc0201708:	00e56463          	bltu	a0,a4,ffffffffc0201710 <kfree+0x30>
ffffffffc020170c:	02d56063          	bltu	a0,a3,ffffffffc020172c <kfree+0x4c>
cprintf("kfree: invalid obj_va (%p, slab_va=%p)\n", obj_va, (void *)slab_va);
ffffffffc0201710:	862e                	mv	a2,a1
ffffffffc0201712:	85aa                	mv	a1,a0
ffffffffc0201714:	00002517          	auipc	a0,0x2
ffffffffc0201718:	b5c50513          	addi	a0,a0,-1188 # ffffffffc0203270 <buddy_pmm_manager+0x688>
ffffffffc020171c:	a69fe06f          	j	ffffffffc0200184 <cprintf>
cprintf("kfree: invalid cache for slab_hdr (%p)\n", slab_hdr);
ffffffffc0201720:	00002517          	auipc	a0,0x2
ffffffffc0201724:	b2850513          	addi	a0,a0,-1240 # ffffffffc0203248 <buddy_pmm_manager+0x660>
ffffffffc0201728:	a5dfe06f          	j	ffffffffc0200184 <cprintf>
    __list_add(elm, listelm, listelm->next);
ffffffffc020172c:	7394                	ld	a3,32(a5)
}
//将对象放回缓存池的空闲链表
list_entry_t *obj_node=(list_entry_t*)obj_va;
list_add(&cache->free_obj_list,obj_node);
//更新slab块的空闲对象计数
slab_hdr->free_obj_cnt++;
ffffffffc020172e:	6998                	ld	a4,16(a1)
cprintf("kfree: success (obj_va=%p, cache=%dB)\n", obj_va, cache->obj_size);
ffffffffc0201730:	6390                	ld	a2,0(a5)
    prev->next = next->prev = elm;
ffffffffc0201732:	e288                	sd	a0,0(a3)
ffffffffc0201734:	f388                	sd	a0,32(a5)
list_add(&cache->free_obj_list,obj_node);
ffffffffc0201736:	01878813          	addi	a6,a5,24
    elm->next = next;
ffffffffc020173a:	e514                	sd	a3,8(a0)
    elm->prev = prev;
ffffffffc020173c:	01053023          	sd	a6,0(a0)
slab_hdr->free_obj_cnt++;
ffffffffc0201740:	00170793          	addi	a5,a4,1
ffffffffc0201744:	e99c                	sd	a5,16(a1)
cprintf("kfree: success (obj_va=%p, cache=%dB)\n", obj_va, cache->obj_size);
ffffffffc0201746:	85aa                	mv	a1,a0
ffffffffc0201748:	00002517          	auipc	a0,0x2
ffffffffc020174c:	b5050513          	addi	a0,a0,-1200 # ffffffffc0203298 <buddy_pmm_manager+0x6b0>
ffffffffc0201750:	a35fe06f          	j	ffffffffc0200184 <cprintf>
}
ffffffffc0201754:	8082                	ret

ffffffffc0201756 <slub_alloc_free_verification>:


//测试用例
void slub_alloc_free_verification(void) {
ffffffffc0201756:	7151                	addi	sp,sp,-240
    cprintf("\n=== Starting SLUB Allocator Verification ===\n");
ffffffffc0201758:	00002517          	auipc	a0,0x2
ffffffffc020175c:	b6850513          	addi	a0,a0,-1176 # ffffffffc02032c0 <buddy_pmm_manager+0x6d8>
void slub_alloc_free_verification(void) {
ffffffffc0201760:	f586                	sd	ra,232(sp)
ffffffffc0201762:	f1a2                	sd	s0,224(sp)
ffffffffc0201764:	eda6                	sd	s1,216(sp)
ffffffffc0201766:	e9ca                	sd	s2,208(sp)
ffffffffc0201768:	e5ce                	sd	s3,200(sp)
ffffffffc020176a:	e1d2                	sd	s4,192(sp)
ffffffffc020176c:	fd56                	sd	s5,184(sp)
ffffffffc020176e:	f95a                	sd	s6,176(sp)
ffffffffc0201770:	f55e                	sd	s7,168(sp)
ffffffffc0201772:	f162                	sd	s8,160(sp)
ffffffffc0201774:	ed66                	sd	s9,152(sp)
ffffffffc0201776:	e96a                	sd	s10,144(sp)
ffffffffc0201778:	e56e                	sd	s11,136(sp)
    cprintf("\n=== Starting SLUB Allocator Verification ===\n");
ffffffffc020177a:	a0bfe0ef          	jal	ra,ffffffffc0200184 <cprintf>

    // 测试1: 基本分配释放
    cprintf("\n[Test 1] Basic allocation and free\n");
ffffffffc020177e:	00002517          	auipc	a0,0x2
ffffffffc0201782:	b7250513          	addi	a0,a0,-1166 # ffffffffc02032f0 <buddy_pmm_manager+0x708>
ffffffffc0201786:	9fffe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("SLUB_DEBUG: kmalloc(%d) called\n", size);
ffffffffc020178a:	02000593          	li	a1,32
ffffffffc020178e:	00002517          	auipc	a0,0x2
ffffffffc0201792:	a7250513          	addi	a0,a0,-1422 # ffffffffc0203200 <buddy_pmm_manager+0x618>
ffffffffc0201796:	9effe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    if (size == 0 || size > g_obj_sizes[SLUB_OBJ_CNT - 1]) {
ffffffffc020179a:	02000513          	li	a0,32
ffffffffc020179e:	bd5ff0ef          	jal	ra,ffffffffc0201372 <kmalloc.part.0>
    void* ptr1 = kmalloc(32);
    if (ptr1 != NULL) {
ffffffffc02017a2:	34050863          	beqz	a0,ffffffffc0201af2 <slub_alloc_free_verification+0x39c>
ffffffffc02017a6:	842a                	mv	s0,a0
        cprintf(" Allocated 32 bytes at %p\n", ptr1);
ffffffffc02017a8:	85aa                	mv	a1,a0
ffffffffc02017aa:	00002517          	auipc	a0,0x2
ffffffffc02017ae:	b6e50513          	addi	a0,a0,-1170 # ffffffffc0203318 <buddy_pmm_manager+0x730>
ffffffffc02017b2:	9d3fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
        // 写入测试数据
        memset(ptr1, 0xAA, 32);
ffffffffc02017b6:	02000613          	li	a2,32
ffffffffc02017ba:	0aa00593          	li	a1,170
ffffffffc02017be:	8522                	mv	a0,s0
ffffffffc02017c0:	015000ef          	jal	ra,ffffffffc0201fd4 <memset>
        cprintf(" Successfully wrote test pattern to allocated memory\n");
ffffffffc02017c4:	00002517          	auipc	a0,0x2
ffffffffc02017c8:	b7450513          	addi	a0,a0,-1164 # ffffffffc0203338 <buddy_pmm_manager+0x750>
ffffffffc02017cc:	9b9fe0ef          	jal	ra,ffffffffc0200184 <cprintf>

        kfree(ptr1);
ffffffffc02017d0:	8522                	mv	a0,s0
ffffffffc02017d2:	f0fff0ef          	jal	ra,ffffffffc02016e0 <kfree>
        cprintf(" Freed 32 bytes\n");
ffffffffc02017d6:	00002517          	auipc	a0,0x2
ffffffffc02017da:	b9a50513          	addi	a0,a0,-1126 # ffffffffc0203370 <buddy_pmm_manager+0x788>
ffffffffc02017de:	9a7fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    else {
        cprintf(" Failed to allocate 32 bytes\n");
    }

    // 测试2: 不同大小的分配
    cprintf("\n[Test 2] Different size allocations\n");
ffffffffc02017e2:	00002517          	auipc	a0,0x2
ffffffffc02017e6:	bc650513          	addi	a0,a0,-1082 # ffffffffc02033a8 <buddy_pmm_manager+0x7c0>
ffffffffc02017ea:	99bfe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    size_t sizes[] = { 8, 16, 32, 64, 128, 256, 512, 1024 };
ffffffffc02017ee:	00002797          	auipc	a5,0x2
ffffffffc02017f2:	f1a78793          	addi	a5,a5,-230 # ffffffffc0203708 <buddy_pmm_manager+0xb20>
ffffffffc02017f6:	0007b883          	ld	a7,0(a5)
ffffffffc02017fa:	0087b803          	ld	a6,8(a5)
ffffffffc02017fe:	6b88                	ld	a0,16(a5)
ffffffffc0201800:	6f8c                	ld	a1,24(a5)
ffffffffc0201802:	7390                	ld	a2,32(a5)
ffffffffc0201804:	7794                	ld	a3,40(a5)
ffffffffc0201806:	7b98                	ld	a4,48(a5)
ffffffffc0201808:	7f9c                	ld	a5,56(a5)
ffffffffc020180a:	8a8a                	mv	s5,sp
ffffffffc020180c:	04010913          	addi	s2,sp,64
ffffffffc0201810:	e046                	sd	a7,0(sp)
ffffffffc0201812:	e442                	sd	a6,8(sp)
ffffffffc0201814:	e82a                	sd	a0,16(sp)
ffffffffc0201816:	ec2e                	sd	a1,24(sp)
ffffffffc0201818:	f032                	sd	a2,32(sp)
ffffffffc020181a:	f436                	sd	a3,40(sp)
ffffffffc020181c:	f83a                	sd	a4,48(sp)
ffffffffc020181e:	fc3e                	sd	a5,56(sp)
ffffffffc0201820:	8a4a                	mv	s4,s2
ffffffffc0201822:	89d6                	mv	s3,s5
ffffffffc0201824:	0a000413          	li	s0,160
    cprintf("SLUB_DEBUG: kmalloc(%d) called\n", size);
ffffffffc0201828:	00002c17          	auipc	s8,0x2
ffffffffc020182c:	9d8c0c13          	addi	s8,s8,-1576 # ffffffffc0203200 <buddy_pmm_manager+0x618>
    if (size == 0 || size > g_obj_sizes[SLUB_OBJ_CNT - 1]) {
ffffffffc0201830:	0ff00b93          	li	s7,255
            cprintf(" Allocated %d bytes at %p\n", sizes[i], pointers[i]);
            // 写入唯一模式以便验证
            memset(pointers[i], 0xA0 + i, sizes[i]);
        }
        else {
            cprintf(" Failed to allocate %d bytes\n", sizes[i]);
ffffffffc0201834:	00002d17          	auipc	s10,0x2
ffffffffc0201838:	bbcd0d13          	addi	s10,s10,-1092 # ffffffffc02033f0 <buddy_pmm_manager+0x808>
            cprintf(" Allocated %d bytes at %p\n", sizes[i], pointers[i]);
ffffffffc020183c:	00002c97          	auipc	s9,0x2
ffffffffc0201840:	b94c8c93          	addi	s9,s9,-1132 # ffffffffc02033d0 <buddy_pmm_manager+0x7e8>
    for (int i = 0; i < 8; i++) {
ffffffffc0201844:	0a800b13          	li	s6,168
        pointers[i] = kmalloc(sizes[i]);
ffffffffc0201848:	0009b483          	ld	s1,0(s3)
    cprintf("SLUB_DEBUG: kmalloc(%d) called\n", size);
ffffffffc020184c:	8562                	mv	a0,s8
ffffffffc020184e:	85a6                	mv	a1,s1
ffffffffc0201850:	935fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    if (size == 0 || size > g_obj_sizes[SLUB_OBJ_CNT - 1]) {
ffffffffc0201854:	fff48793          	addi	a5,s1,-1
ffffffffc0201858:	26fbed63          	bltu	s7,a5,ffffffffc0201ad2 <slub_alloc_free_verification+0x37c>
ffffffffc020185c:	8526                	mv	a0,s1
ffffffffc020185e:	b15ff0ef          	jal	ra,ffffffffc0201372 <kmalloc.part.0>
        pointers[i] = kmalloc(sizes[i]);
ffffffffc0201862:	00aa3023          	sd	a0,0(s4)
ffffffffc0201866:	8daa                	mv	s11,a0
        if (pointers[i] != NULL) {
ffffffffc0201868:	28050063          	beqz	a0,ffffffffc0201ae8 <slub_alloc_free_verification+0x392>
            cprintf(" Allocated %d bytes at %p\n", sizes[i], pointers[i]);
ffffffffc020186c:	862a                	mv	a2,a0
ffffffffc020186e:	85a6                	mv	a1,s1
ffffffffc0201870:	8566                	mv	a0,s9
ffffffffc0201872:	913fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
            memset(pointers[i], 0xA0 + i, sizes[i]);
ffffffffc0201876:	8626                	mv	a2,s1
ffffffffc0201878:	85a2                	mv	a1,s0
ffffffffc020187a:	856e                	mv	a0,s11
ffffffffc020187c:	758000ef          	jal	ra,ffffffffc0201fd4 <memset>
    for (int i = 0; i < 8; i++) {
ffffffffc0201880:	2405                	addiw	s0,s0,1
ffffffffc0201882:	0ff47413          	zext.b	s0,s0
ffffffffc0201886:	09a1                	addi	s3,s3,8
ffffffffc0201888:	0a21                	addi	s4,s4,8
ffffffffc020188a:	fb641fe3          	bne	s0,s6,ffffffffc0201848 <slub_alloc_free_verification+0xf2>
        }
    }

    // 验证数据完整性
    cprintf("\n[Test 3] Data integrity check\n");
ffffffffc020188e:	00002517          	auipc	a0,0x2
ffffffffc0201892:	b8250513          	addi	a0,a0,-1150 # ffffffffc0203410 <buddy_pmm_manager+0x828>
ffffffffc0201896:	8effe0ef          	jal	ra,ffffffffc0200184 <cprintf>
ffffffffc020189a:	89d6                	mv	s3,s5
ffffffffc020189c:	84ca                	mv	s1,s2
ffffffffc020189e:	0a000413          	li	s0,160
            // 检查第一个字节是否正确
            if (*((char*)pointers[i]) == (char)(0xA0 + i)) {
                cprintf(" Data integrity verified for %d bytes block\n", sizes[i]);
            }
            else {
                cprintf(" Data corruption detected for %d bytes block\n", sizes[i]);
ffffffffc02018a2:	00002b17          	auipc	s6,0x2
ffffffffc02018a6:	bbeb0b13          	addi	s6,s6,-1090 # ffffffffc0203460 <buddy_pmm_manager+0x878>
                cprintf(" Data integrity verified for %d bytes block\n", sizes[i]);
ffffffffc02018aa:	00002b97          	auipc	s7,0x2
ffffffffc02018ae:	b86b8b93          	addi	s7,s7,-1146 # ffffffffc0203430 <buddy_pmm_manager+0x848>
    for (int i = 0; i < 8; i++) {
ffffffffc02018b2:	0a800a13          	li	s4,168
ffffffffc02018b6:	a819                	j	ffffffffc02018cc <slub_alloc_free_verification+0x176>
                cprintf(" Data corruption detected for %d bytes block\n", sizes[i]);
ffffffffc02018b8:	855a                	mv	a0,s6
ffffffffc02018ba:	8cbfe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    for (int i = 0; i < 8; i++) {
ffffffffc02018be:	2405                	addiw	s0,s0,1
ffffffffc02018c0:	0ff47413          	zext.b	s0,s0
ffffffffc02018c4:	04a1                	addi	s1,s1,8
ffffffffc02018c6:	09a1                	addi	s3,s3,8
ffffffffc02018c8:	03440463          	beq	s0,s4,ffffffffc02018f0 <slub_alloc_free_verification+0x19a>
        if (pointers[i] != NULL) {
ffffffffc02018cc:	609c                	ld	a5,0(s1)
ffffffffc02018ce:	dbe5                	beqz	a5,ffffffffc02018be <slub_alloc_free_verification+0x168>
            if (*((char*)pointers[i]) == (char)(0xA0 + i)) {
ffffffffc02018d0:	0007c783          	lbu	a5,0(a5)
                cprintf(" Data integrity verified for %d bytes block\n", sizes[i]);
ffffffffc02018d4:	0009b583          	ld	a1,0(s3)
            if (*((char*)pointers[i]) == (char)(0xA0 + i)) {
ffffffffc02018d8:	fe8790e3          	bne	a5,s0,ffffffffc02018b8 <slub_alloc_free_verification+0x162>
    for (int i = 0; i < 8; i++) {
ffffffffc02018dc:	2405                	addiw	s0,s0,1
                cprintf(" Data integrity verified for %d bytes block\n", sizes[i]);
ffffffffc02018de:	855e                	mv	a0,s7
    for (int i = 0; i < 8; i++) {
ffffffffc02018e0:	0ff47413          	zext.b	s0,s0
                cprintf(" Data integrity verified for %d bytes block\n", sizes[i]);
ffffffffc02018e4:	8a1fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    for (int i = 0; i < 8; i++) {
ffffffffc02018e8:	04a1                	addi	s1,s1,8
ffffffffc02018ea:	09a1                	addi	s3,s3,8
ffffffffc02018ec:	ff4410e3          	bne	s0,s4,ffffffffc02018cc <slub_alloc_free_verification+0x176>
            }
        }
    }

    // 测试4: 释放所有分配的内存
    cprintf("\n[Test 4] Free all allocated blocks\n");
ffffffffc02018f0:	00002517          	auipc	a0,0x2
ffffffffc02018f4:	ba050513          	addi	a0,a0,-1120 # ffffffffc0203490 <buddy_pmm_manager+0x8a8>
ffffffffc02018f8:	88dfe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    for (int i = 0; i < 8; i++) {
ffffffffc02018fc:	04090413          	addi	s0,s2,64
        if (pointers[i] != NULL) {
            kfree(pointers[i]);
            cprintf(" Freed %d bytes block\n", sizes[i]);
ffffffffc0201900:	00002497          	auipc	s1,0x2
ffffffffc0201904:	bb848493          	addi	s1,s1,-1096 # ffffffffc02034b8 <buddy_pmm_manager+0x8d0>
        if (pointers[i] != NULL) {
ffffffffc0201908:	00093503          	ld	a0,0(s2)
ffffffffc020190c:	c901                	beqz	a0,ffffffffc020191c <slub_alloc_free_verification+0x1c6>
            kfree(pointers[i]);
ffffffffc020190e:	dd3ff0ef          	jal	ra,ffffffffc02016e0 <kfree>
            cprintf(" Freed %d bytes block\n", sizes[i]);
ffffffffc0201912:	000ab583          	ld	a1,0(s5)
ffffffffc0201916:	8526                	mv	a0,s1
ffffffffc0201918:	86dfe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    for (int i = 0; i < 8; i++) {
ffffffffc020191c:	0921                	addi	s2,s2,8
ffffffffc020191e:	0aa1                	addi	s5,s5,8
ffffffffc0201920:	fe8914e3          	bne	s2,s0,ffffffffc0201908 <slub_alloc_free_verification+0x1b2>
        }
    }

    // 测试5: 重复分配释放测试（检测内存泄漏）
    cprintf("\n[Test 5] Repeated allocation/free cycle\n");
ffffffffc0201924:	00002517          	auipc	a0,0x2
ffffffffc0201928:	bac50513          	addi	a0,a0,-1108 # ffffffffc02034d0 <buddy_pmm_manager+0x8e8>
ffffffffc020192c:	859fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    for (int cycle = 0; cycle < 3; cycle++) {
ffffffffc0201930:	4481                	li	s1,0
    cprintf("SLUB_DEBUG: kmalloc(%d) called\n", size);
ffffffffc0201932:	00002997          	auipc	s3,0x2
ffffffffc0201936:	8ce98993          	addi	s3,s3,-1842 # ffffffffc0203200 <buddy_pmm_manager+0x618>
        void* temp_ptr = kmalloc(128);
        if (temp_ptr != NULL) {
            memset(temp_ptr, 0xCC, 128);
            kfree(temp_ptr);
            cprintf(" Cycle %d: 128 bytes allocated and freed\n", cycle + 1);
ffffffffc020193a:	00002a17          	auipc	s4,0x2
ffffffffc020193e:	bc6a0a13          	addi	s4,s4,-1082 # ffffffffc0203500 <buddy_pmm_manager+0x918>
    for (int cycle = 0; cycle < 3; cycle++) {
ffffffffc0201942:	490d                	li	s2,3
    cprintf("SLUB_DEBUG: kmalloc(%d) called\n", size);
ffffffffc0201944:	08000593          	li	a1,128
ffffffffc0201948:	854e                	mv	a0,s3
ffffffffc020194a:	83bfe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    if (size == 0 || size > g_obj_sizes[SLUB_OBJ_CNT - 1]) {
ffffffffc020194e:	08000513          	li	a0,128
ffffffffc0201952:	a21ff0ef          	jal	ra,ffffffffc0201372 <kmalloc.part.0>
ffffffffc0201956:	842a                	mv	s0,a0
            cprintf(" Cycle %d: 128 bytes allocated and freed\n", cycle + 1);
ffffffffc0201958:	2485                	addiw	s1,s1,1
        if (temp_ptr != NULL) {
ffffffffc020195a:	cd11                	beqz	a0,ffffffffc0201976 <slub_alloc_free_verification+0x220>
            memset(temp_ptr, 0xCC, 128);
ffffffffc020195c:	0cc00593          	li	a1,204
ffffffffc0201960:	08000613          	li	a2,128
ffffffffc0201964:	670000ef          	jal	ra,ffffffffc0201fd4 <memset>
            kfree(temp_ptr);
ffffffffc0201968:	8522                	mv	a0,s0
ffffffffc020196a:	d77ff0ef          	jal	ra,ffffffffc02016e0 <kfree>
            cprintf(" Cycle %d: 128 bytes allocated and freed\n", cycle + 1);
ffffffffc020196e:	85a6                	mv	a1,s1
ffffffffc0201970:	8552                	mv	a0,s4
ffffffffc0201972:	813fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    for (int cycle = 0; cycle < 3; cycle++) {
ffffffffc0201976:	fd2497e3          	bne	s1,s2,ffffffffc0201944 <slub_alloc_free_verification+0x1ee>
        }
    }

    // 测试6: 边界情况测试
    cprintf("\n[Test 6] Boundary cases\n");
ffffffffc020197a:	00002517          	auipc	a0,0x2
ffffffffc020197e:	bb650513          	addi	a0,a0,-1098 # ffffffffc0203530 <buddy_pmm_manager+0x948>
ffffffffc0201982:	803fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("SLUB_DEBUG: kmalloc(%d) called\n", size);
ffffffffc0201986:	4581                	li	a1,0
ffffffffc0201988:	00002517          	auipc	a0,0x2
ffffffffc020198c:	87850513          	addi	a0,a0,-1928 # ffffffffc0203200 <buddy_pmm_manager+0x618>
ffffffffc0201990:	ff4fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
        cprintf("kmalloc: invalid size (%dB, max=%dB)\n", size, g_obj_sizes[SLUB_OBJ_CNT - 1]);
ffffffffc0201994:	10000613          	li	a2,256
ffffffffc0201998:	4581                	li	a1,0
ffffffffc020199a:	00002517          	auipc	a0,0x2
ffffffffc020199e:	88650513          	addi	a0,a0,-1914 # ffffffffc0203220 <buddy_pmm_manager+0x638>
ffffffffc02019a2:	fe2fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    // 测试0字节分配（应该返回NULL或有效指针，取决于实现）
    void* zero_alloc = kmalloc(0);
    cprintf("Zero byte allocation: %p\n", zero_alloc);
ffffffffc02019a6:	4581                	li	a1,0
ffffffffc02019a8:	00002517          	auipc	a0,0x2
ffffffffc02019ac:	ba850513          	addi	a0,a0,-1112 # ffffffffc0203550 <buddy_pmm_manager+0x968>
ffffffffc02019b0:	fd4fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("SLUB_DEBUG: kmalloc(%d) called\n", size);
ffffffffc02019b4:	6405                	lui	s0,0x1
ffffffffc02019b6:	80040593          	addi	a1,s0,-2048 # 800 <kern_entry-0xffffffffc01ff800>
ffffffffc02019ba:	00002517          	auipc	a0,0x2
ffffffffc02019be:	84650513          	addi	a0,a0,-1978 # ffffffffc0203200 <buddy_pmm_manager+0x618>
ffffffffc02019c2:	fc2fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
        cprintf("kmalloc: invalid size (%dB, max=%dB)\n", size, g_obj_sizes[SLUB_OBJ_CNT - 1]);
ffffffffc02019c6:	10000613          	li	a2,256
ffffffffc02019ca:	80040593          	addi	a1,s0,-2048
ffffffffc02019ce:	00002517          	auipc	a0,0x2
ffffffffc02019d2:	85250513          	addi	a0,a0,-1966 # ffffffffc0203220 <buddy_pmm_manager+0x638>
ffffffffc02019d6:	faefe0ef          	jal	ra,ffffffffc0200184 <cprintf>
        cprintf(" Large allocation (2048 bytes) successful at %p\n", large_alloc);
        kfree(large_alloc);
        cprintf(" Large allocation freed\n");
    }
    else {
        cprintf(" Large allocation failed\n");
ffffffffc02019da:	00002517          	auipc	a0,0x2
ffffffffc02019de:	b9650513          	addi	a0,a0,-1130 # ffffffffc0203570 <buddy_pmm_manager+0x988>
ffffffffc02019e2:	fa2fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    }

    // 测试7: 集成功能测试
    cprintf("\n[Test 7] Integrated functionality test\n");
ffffffffc02019e6:	00002517          	auipc	a0,0x2
ffffffffc02019ea:	baa50513          	addi	a0,a0,-1110 # ffffffffc0203590 <buddy_pmm_manager+0x9a8>
ffffffffc02019ee:	f96fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    cprintf("SLUB_DEBUG: kmalloc(%d) called\n", size);
ffffffffc02019f2:	03200593          	li	a1,50
ffffffffc02019f6:	00002517          	auipc	a0,0x2
ffffffffc02019fa:	80a50513          	addi	a0,a0,-2038 # ffffffffc0203200 <buddy_pmm_manager+0x618>
ffffffffc02019fe:	f86fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    if (size == 0 || size > g_obj_sizes[SLUB_OBJ_CNT - 1]) {
ffffffffc0201a02:	03200513          	li	a0,50
ffffffffc0201a06:	96dff0ef          	jal	ra,ffffffffc0201372 <kmalloc.part.0>
    cprintf("SLUB_DEBUG: kmalloc(%d) called\n", size);
ffffffffc0201a0a:	03200593          	li	a1,50
ffffffffc0201a0e:	842a                	mv	s0,a0
ffffffffc0201a10:	00001517          	auipc	a0,0x1
ffffffffc0201a14:	7f050513          	addi	a0,a0,2032 # ffffffffc0203200 <buddy_pmm_manager+0x618>
ffffffffc0201a18:	f6cfe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    if (size == 0 || size > g_obj_sizes[SLUB_OBJ_CNT - 1]) {
ffffffffc0201a1c:	03200513          	li	a0,50
ffffffffc0201a20:	953ff0ef          	jal	ra,ffffffffc0201372 <kmalloc.part.0>
ffffffffc0201a24:	84aa                	mv	s1,a0
    char* str1 = (char*)kmalloc(50);
    char* str2 = (char*)kmalloc(50);

    if (str1 && str2) {
ffffffffc0201a26:	c051                	beqz	s0,ffffffffc0201aaa <slub_alloc_free_verification+0x354>
ffffffffc0201a28:	c149                	beqz	a0,ffffffffc0201aaa <slub_alloc_free_verification+0x354>
        strcpy(str1, "Hello SLUB Allocator");
ffffffffc0201a2a:	00002597          	auipc	a1,0x2
ffffffffc0201a2e:	b9658593          	addi	a1,a1,-1130 # ffffffffc02035c0 <buddy_pmm_manager+0x9d8>
ffffffffc0201a32:	8522                	mv	a0,s0
ffffffffc0201a34:	54a000ef          	jal	ra,ffffffffc0201f7e <strcpy>
        strcpy(str2, "Memory Management Test");
ffffffffc0201a38:	00002597          	auipc	a1,0x2
ffffffffc0201a3c:	ba058593          	addi	a1,a1,-1120 # ffffffffc02035d8 <buddy_pmm_manager+0x9f0>
ffffffffc0201a40:	8526                	mv	a0,s1
ffffffffc0201a42:	53c000ef          	jal	ra,ffffffffc0201f7e <strcpy>

        cprintf(" String 1: '%s' at %p\n", str1, str1);
ffffffffc0201a46:	8622                	mv	a2,s0
ffffffffc0201a48:	85a2                	mv	a1,s0
ffffffffc0201a4a:	00002517          	auipc	a0,0x2
ffffffffc0201a4e:	ba650513          	addi	a0,a0,-1114 # ffffffffc02035f0 <buddy_pmm_manager+0xa08>
ffffffffc0201a52:	f32fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
        cprintf(" String 2: '%s' at %p\n", str2, str2);
ffffffffc0201a56:	85a6                	mv	a1,s1
ffffffffc0201a58:	8626                	mv	a2,s1
ffffffffc0201a5a:	00002517          	auipc	a0,0x2
ffffffffc0201a5e:	bae50513          	addi	a0,a0,-1106 # ffffffffc0203608 <buddy_pmm_manager+0xa20>
ffffffffc0201a62:	f22fe0ef          	jal	ra,ffffffffc0200184 <cprintf>

        // 验证字符串内容
        assert(strcmp(str1, "Hello SLUB Allocator") == 0);
ffffffffc0201a66:	00002597          	auipc	a1,0x2
ffffffffc0201a6a:	b5a58593          	addi	a1,a1,-1190 # ffffffffc02035c0 <buddy_pmm_manager+0x9d8>
ffffffffc0201a6e:	8522                	mv	a0,s0
ffffffffc0201a70:	520000ef          	jal	ra,ffffffffc0201f90 <strcmp>
ffffffffc0201a74:	e551                	bnez	a0,ffffffffc0201b00 <slub_alloc_free_verification+0x3aa>
        assert(strcmp(str2, "Memory Management Test") == 0);
ffffffffc0201a76:	00002597          	auipc	a1,0x2
ffffffffc0201a7a:	b6258593          	addi	a1,a1,-1182 # ffffffffc02035d8 <buddy_pmm_manager+0x9f0>
ffffffffc0201a7e:	8526                	mv	a0,s1
ffffffffc0201a80:	510000ef          	jal	ra,ffffffffc0201f90 <strcmp>
ffffffffc0201a84:	ed51                	bnez	a0,ffffffffc0201b20 <slub_alloc_free_verification+0x3ca>
        cprintf(" String content verification passed\n");
ffffffffc0201a86:	00002517          	auipc	a0,0x2
ffffffffc0201a8a:	c0a50513          	addi	a0,a0,-1014 # ffffffffc0203690 <buddy_pmm_manager+0xaa8>
ffffffffc0201a8e:	ef6fe0ef          	jal	ra,ffffffffc0200184 <cprintf>

        kfree(str1);
ffffffffc0201a92:	8522                	mv	a0,s0
ffffffffc0201a94:	c4dff0ef          	jal	ra,ffffffffc02016e0 <kfree>
        kfree(str2);
ffffffffc0201a98:	8526                	mv	a0,s1
ffffffffc0201a9a:	c47ff0ef          	jal	ra,ffffffffc02016e0 <kfree>
        cprintf(" Integrated test blocks freed\n");
ffffffffc0201a9e:	00002517          	auipc	a0,0x2
ffffffffc0201aa2:	c1a50513          	addi	a0,a0,-998 # ffffffffc02036b8 <buddy_pmm_manager+0xad0>
ffffffffc0201aa6:	edefe0ef          	jal	ra,ffffffffc0200184 <cprintf>
    }

    cprintf("\n=== SLUB Allocator Verification Completed ===\n");
ffffffffc0201aaa:	740e                	ld	s0,224(sp)
ffffffffc0201aac:	70ae                	ld	ra,232(sp)
ffffffffc0201aae:	64ee                	ld	s1,216(sp)
ffffffffc0201ab0:	694e                	ld	s2,208(sp)
ffffffffc0201ab2:	69ae                	ld	s3,200(sp)
ffffffffc0201ab4:	6a0e                	ld	s4,192(sp)
ffffffffc0201ab6:	7aea                	ld	s5,184(sp)
ffffffffc0201ab8:	7b4a                	ld	s6,176(sp)
ffffffffc0201aba:	7baa                	ld	s7,168(sp)
ffffffffc0201abc:	7c0a                	ld	s8,160(sp)
ffffffffc0201abe:	6cea                	ld	s9,152(sp)
ffffffffc0201ac0:	6d4a                	ld	s10,144(sp)
ffffffffc0201ac2:	6daa                	ld	s11,136(sp)
    cprintf("\n=== SLUB Allocator Verification Completed ===\n");
ffffffffc0201ac4:	00002517          	auipc	a0,0x2
ffffffffc0201ac8:	c1450513          	addi	a0,a0,-1004 # ffffffffc02036d8 <buddy_pmm_manager+0xaf0>
ffffffffc0201acc:	616d                	addi	sp,sp,240
    cprintf("\n=== SLUB Allocator Verification Completed ===\n");
ffffffffc0201ace:	eb6fe06f          	j	ffffffffc0200184 <cprintf>
        cprintf("kmalloc: invalid size (%dB, max=%dB)\n", size, g_obj_sizes[SLUB_OBJ_CNT - 1]);
ffffffffc0201ad2:	10000613          	li	a2,256
ffffffffc0201ad6:	85a6                	mv	a1,s1
ffffffffc0201ad8:	00001517          	auipc	a0,0x1
ffffffffc0201adc:	74850513          	addi	a0,a0,1864 # ffffffffc0203220 <buddy_pmm_manager+0x638>
ffffffffc0201ae0:	ea4fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
        pointers[i] = kmalloc(sizes[i]);
ffffffffc0201ae4:	000a3023          	sd	zero,0(s4)
            cprintf(" Failed to allocate %d bytes\n", sizes[i]);
ffffffffc0201ae8:	85a6                	mv	a1,s1
ffffffffc0201aea:	856a                	mv	a0,s10
ffffffffc0201aec:	e98fe0ef          	jal	ra,ffffffffc0200184 <cprintf>
ffffffffc0201af0:	bb41                	j	ffffffffc0201880 <slub_alloc_free_verification+0x12a>
        cprintf(" Failed to allocate 32 bytes\n");
ffffffffc0201af2:	00002517          	auipc	a0,0x2
ffffffffc0201af6:	89650513          	addi	a0,a0,-1898 # ffffffffc0203388 <buddy_pmm_manager+0x7a0>
ffffffffc0201afa:	e8afe0ef          	jal	ra,ffffffffc0200184 <cprintf>
ffffffffc0201afe:	b1d5                	j	ffffffffc02017e2 <slub_alloc_free_verification+0x8c>
        assert(strcmp(str1, "Hello SLUB Allocator") == 0);
ffffffffc0201b00:	00002697          	auipc	a3,0x2
ffffffffc0201b04:	b2068693          	addi	a3,a3,-1248 # ffffffffc0203620 <buddy_pmm_manager+0xa38>
ffffffffc0201b08:	00001617          	auipc	a2,0x1
ffffffffc0201b0c:	82060613          	addi	a2,a2,-2016 # ffffffffc0202328 <etext+0x342>
ffffffffc0201b10:	15800593          	li	a1,344
ffffffffc0201b14:	00002517          	auipc	a0,0x2
ffffffffc0201b18:	b3c50513          	addi	a0,a0,-1220 # ffffffffc0203650 <buddy_pmm_manager+0xa68>
ffffffffc0201b1c:	edefe0ef          	jal	ra,ffffffffc02001fa <__panic>
        assert(strcmp(str2, "Memory Management Test") == 0);
ffffffffc0201b20:	00002697          	auipc	a3,0x2
ffffffffc0201b24:	b4068693          	addi	a3,a3,-1216 # ffffffffc0203660 <buddy_pmm_manager+0xa78>
ffffffffc0201b28:	00001617          	auipc	a2,0x1
ffffffffc0201b2c:	80060613          	addi	a2,a2,-2048 # ffffffffc0202328 <etext+0x342>
ffffffffc0201b30:	15900593          	li	a1,345
ffffffffc0201b34:	00002517          	auipc	a0,0x2
ffffffffc0201b38:	b1c50513          	addi	a0,a0,-1252 # ffffffffc0203650 <buddy_pmm_manager+0xa68>
ffffffffc0201b3c:	ebefe0ef          	jal	ra,ffffffffc02001fa <__panic>

ffffffffc0201b40 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc0201b40:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201b44:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc0201b46:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201b4a:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc0201b4c:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201b50:	f022                	sd	s0,32(sp)
ffffffffc0201b52:	ec26                	sd	s1,24(sp)
ffffffffc0201b54:	e84a                	sd	s2,16(sp)
ffffffffc0201b56:	f406                	sd	ra,40(sp)
ffffffffc0201b58:	e44e                	sd	s3,8(sp)
ffffffffc0201b5a:	84aa                	mv	s1,a0
ffffffffc0201b5c:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc0201b5e:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc0201b62:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc0201b64:	03067e63          	bgeu	a2,a6,ffffffffc0201ba0 <printnum+0x60>
ffffffffc0201b68:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc0201b6a:	00805763          	blez	s0,ffffffffc0201b78 <printnum+0x38>
ffffffffc0201b6e:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc0201b70:	85ca                	mv	a1,s2
ffffffffc0201b72:	854e                	mv	a0,s3
ffffffffc0201b74:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc0201b76:	fc65                	bnez	s0,ffffffffc0201b6e <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201b78:	1a02                	slli	s4,s4,0x20
ffffffffc0201b7a:	00002797          	auipc	a5,0x2
ffffffffc0201b7e:	bfe78793          	addi	a5,a5,-1026 # ffffffffc0203778 <g_obj_sizes+0x30>
ffffffffc0201b82:	020a5a13          	srli	s4,s4,0x20
ffffffffc0201b86:	9a3e                	add	s4,s4,a5
}
ffffffffc0201b88:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201b8a:	000a4503          	lbu	a0,0(s4)
}
ffffffffc0201b8e:	70a2                	ld	ra,40(sp)
ffffffffc0201b90:	69a2                	ld	s3,8(sp)
ffffffffc0201b92:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201b94:	85ca                	mv	a1,s2
ffffffffc0201b96:	87a6                	mv	a5,s1
}
ffffffffc0201b98:	6942                	ld	s2,16(sp)
ffffffffc0201b9a:	64e2                	ld	s1,24(sp)
ffffffffc0201b9c:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201b9e:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc0201ba0:	03065633          	divu	a2,a2,a6
ffffffffc0201ba4:	8722                	mv	a4,s0
ffffffffc0201ba6:	f9bff0ef          	jal	ra,ffffffffc0201b40 <printnum>
ffffffffc0201baa:	b7f9                	j	ffffffffc0201b78 <printnum+0x38>

ffffffffc0201bac <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0201bac:	7119                	addi	sp,sp,-128
ffffffffc0201bae:	f4a6                	sd	s1,104(sp)
ffffffffc0201bb0:	f0ca                	sd	s2,96(sp)
ffffffffc0201bb2:	ecce                	sd	s3,88(sp)
ffffffffc0201bb4:	e8d2                	sd	s4,80(sp)
ffffffffc0201bb6:	e4d6                	sd	s5,72(sp)
ffffffffc0201bb8:	e0da                	sd	s6,64(sp)
ffffffffc0201bba:	fc5e                	sd	s7,56(sp)
ffffffffc0201bbc:	f06a                	sd	s10,32(sp)
ffffffffc0201bbe:	fc86                	sd	ra,120(sp)
ffffffffc0201bc0:	f8a2                	sd	s0,112(sp)
ffffffffc0201bc2:	f862                	sd	s8,48(sp)
ffffffffc0201bc4:	f466                	sd	s9,40(sp)
ffffffffc0201bc6:	ec6e                	sd	s11,24(sp)
ffffffffc0201bc8:	892a                	mv	s2,a0
ffffffffc0201bca:	84ae                	mv	s1,a1
ffffffffc0201bcc:	8d32                	mv	s10,a2
ffffffffc0201bce:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201bd0:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0201bd4:	5b7d                	li	s6,-1
ffffffffc0201bd6:	00002a97          	auipc	s5,0x2
ffffffffc0201bda:	bd6a8a93          	addi	s5,s5,-1066 # ffffffffc02037ac <g_obj_sizes+0x64>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201bde:	00002b97          	auipc	s7,0x2
ffffffffc0201be2:	daab8b93          	addi	s7,s7,-598 # ffffffffc0203988 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201be6:	000d4503          	lbu	a0,0(s10)
ffffffffc0201bea:	001d0413          	addi	s0,s10,1
ffffffffc0201bee:	01350a63          	beq	a0,s3,ffffffffc0201c02 <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc0201bf2:	c121                	beqz	a0,ffffffffc0201c32 <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc0201bf4:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201bf6:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc0201bf8:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201bfa:	fff44503          	lbu	a0,-1(s0)
ffffffffc0201bfe:	ff351ae3          	bne	a0,s3,ffffffffc0201bf2 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c02:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0201c06:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc0201c0a:	4c81                	li	s9,0
ffffffffc0201c0c:	4881                	li	a7,0
        width = precision = -1;
ffffffffc0201c0e:	5c7d                	li	s8,-1
ffffffffc0201c10:	5dfd                	li	s11,-1
ffffffffc0201c12:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc0201c16:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c18:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0201c1c:	0ff5f593          	zext.b	a1,a1
ffffffffc0201c20:	00140d13          	addi	s10,s0,1
ffffffffc0201c24:	04b56263          	bltu	a0,a1,ffffffffc0201c68 <vprintfmt+0xbc>
ffffffffc0201c28:	058a                	slli	a1,a1,0x2
ffffffffc0201c2a:	95d6                	add	a1,a1,s5
ffffffffc0201c2c:	4194                	lw	a3,0(a1)
ffffffffc0201c2e:	96d6                	add	a3,a3,s5
ffffffffc0201c30:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc0201c32:	70e6                	ld	ra,120(sp)
ffffffffc0201c34:	7446                	ld	s0,112(sp)
ffffffffc0201c36:	74a6                	ld	s1,104(sp)
ffffffffc0201c38:	7906                	ld	s2,96(sp)
ffffffffc0201c3a:	69e6                	ld	s3,88(sp)
ffffffffc0201c3c:	6a46                	ld	s4,80(sp)
ffffffffc0201c3e:	6aa6                	ld	s5,72(sp)
ffffffffc0201c40:	6b06                	ld	s6,64(sp)
ffffffffc0201c42:	7be2                	ld	s7,56(sp)
ffffffffc0201c44:	7c42                	ld	s8,48(sp)
ffffffffc0201c46:	7ca2                	ld	s9,40(sp)
ffffffffc0201c48:	7d02                	ld	s10,32(sp)
ffffffffc0201c4a:	6de2                	ld	s11,24(sp)
ffffffffc0201c4c:	6109                	addi	sp,sp,128
ffffffffc0201c4e:	8082                	ret
            padc = '0';
ffffffffc0201c50:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc0201c52:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c56:	846a                	mv	s0,s10
ffffffffc0201c58:	00140d13          	addi	s10,s0,1
ffffffffc0201c5c:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0201c60:	0ff5f593          	zext.b	a1,a1
ffffffffc0201c64:	fcb572e3          	bgeu	a0,a1,ffffffffc0201c28 <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc0201c68:	85a6                	mv	a1,s1
ffffffffc0201c6a:	02500513          	li	a0,37
ffffffffc0201c6e:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc0201c70:	fff44783          	lbu	a5,-1(s0)
ffffffffc0201c74:	8d22                	mv	s10,s0
ffffffffc0201c76:	f73788e3          	beq	a5,s3,ffffffffc0201be6 <vprintfmt+0x3a>
ffffffffc0201c7a:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0201c7e:	1d7d                	addi	s10,s10,-1
ffffffffc0201c80:	ff379de3          	bne	a5,s3,ffffffffc0201c7a <vprintfmt+0xce>
ffffffffc0201c84:	b78d                	j	ffffffffc0201be6 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc0201c86:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc0201c8a:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c8e:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc0201c90:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc0201c94:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0201c98:	02d86463          	bltu	a6,a3,ffffffffc0201cc0 <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0201c9c:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0201ca0:	002c169b          	slliw	a3,s8,0x2
ffffffffc0201ca4:	0186873b          	addw	a4,a3,s8
ffffffffc0201ca8:	0017171b          	slliw	a4,a4,0x1
ffffffffc0201cac:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc0201cae:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc0201cb2:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc0201cb4:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc0201cb8:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0201cbc:	fed870e3          	bgeu	a6,a3,ffffffffc0201c9c <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0201cc0:	f40ddce3          	bgez	s11,ffffffffc0201c18 <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0201cc4:	8de2                	mv	s11,s8
ffffffffc0201cc6:	5c7d                	li	s8,-1
ffffffffc0201cc8:	bf81                	j	ffffffffc0201c18 <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0201cca:	fffdc693          	not	a3,s11
ffffffffc0201cce:	96fd                	srai	a3,a3,0x3f
ffffffffc0201cd0:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201cd4:	00144603          	lbu	a2,1(s0)
ffffffffc0201cd8:	2d81                	sext.w	s11,s11
ffffffffc0201cda:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201cdc:	bf35                	j	ffffffffc0201c18 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0201cde:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201ce2:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0201ce6:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201ce8:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0201cea:	bfd9                	j	ffffffffc0201cc0 <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0201cec:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201cee:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201cf2:	01174463          	blt	a4,a7,ffffffffc0201cfa <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0201cf6:	1a088e63          	beqz	a7,ffffffffc0201eb2 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0201cfa:	000a3603          	ld	a2,0(s4)
ffffffffc0201cfe:	46c1                	li	a3,16
ffffffffc0201d00:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc0201d02:	2781                	sext.w	a5,a5
ffffffffc0201d04:	876e                	mv	a4,s11
ffffffffc0201d06:	85a6                	mv	a1,s1
ffffffffc0201d08:	854a                	mv	a0,s2
ffffffffc0201d0a:	e37ff0ef          	jal	ra,ffffffffc0201b40 <printnum>
            break;
ffffffffc0201d0e:	bde1                	j	ffffffffc0201be6 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc0201d10:	000a2503          	lw	a0,0(s4)
ffffffffc0201d14:	85a6                	mv	a1,s1
ffffffffc0201d16:	0a21                	addi	s4,s4,8
ffffffffc0201d18:	9902                	jalr	s2
            break;
ffffffffc0201d1a:	b5f1                	j	ffffffffc0201be6 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0201d1c:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201d1e:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201d22:	01174463          	blt	a4,a7,ffffffffc0201d2a <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0201d26:	18088163          	beqz	a7,ffffffffc0201ea8 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc0201d2a:	000a3603          	ld	a2,0(s4)
ffffffffc0201d2e:	46a9                	li	a3,10
ffffffffc0201d30:	8a2e                	mv	s4,a1
ffffffffc0201d32:	bfc1                	j	ffffffffc0201d02 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201d34:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0201d38:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201d3a:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201d3c:	bdf1                	j	ffffffffc0201c18 <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc0201d3e:	85a6                	mv	a1,s1
ffffffffc0201d40:	02500513          	li	a0,37
ffffffffc0201d44:	9902                	jalr	s2
            break;
ffffffffc0201d46:	b545                	j	ffffffffc0201be6 <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201d48:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc0201d4c:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201d4e:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201d50:	b5e1                	j	ffffffffc0201c18 <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0201d52:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201d54:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201d58:	01174463          	blt	a4,a7,ffffffffc0201d60 <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0201d5c:	14088163          	beqz	a7,ffffffffc0201e9e <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0201d60:	000a3603          	ld	a2,0(s4)
ffffffffc0201d64:	46a1                	li	a3,8
ffffffffc0201d66:	8a2e                	mv	s4,a1
ffffffffc0201d68:	bf69                	j	ffffffffc0201d02 <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0201d6a:	03000513          	li	a0,48
ffffffffc0201d6e:	85a6                	mv	a1,s1
ffffffffc0201d70:	e03e                	sd	a5,0(sp)
ffffffffc0201d72:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc0201d74:	85a6                	mv	a1,s1
ffffffffc0201d76:	07800513          	li	a0,120
ffffffffc0201d7a:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0201d7c:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0201d7e:	6782                	ld	a5,0(sp)
ffffffffc0201d80:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0201d82:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc0201d86:	bfb5                	j	ffffffffc0201d02 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0201d88:	000a3403          	ld	s0,0(s4)
ffffffffc0201d8c:	008a0713          	addi	a4,s4,8
ffffffffc0201d90:	e03a                	sd	a4,0(sp)
ffffffffc0201d92:	14040263          	beqz	s0,ffffffffc0201ed6 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc0201d96:	0fb05763          	blez	s11,ffffffffc0201e84 <vprintfmt+0x2d8>
ffffffffc0201d9a:	02d00693          	li	a3,45
ffffffffc0201d9e:	0cd79163          	bne	a5,a3,ffffffffc0201e60 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201da2:	00044783          	lbu	a5,0(s0)
ffffffffc0201da6:	0007851b          	sext.w	a0,a5
ffffffffc0201daa:	cf85                	beqz	a5,ffffffffc0201de2 <vprintfmt+0x236>
ffffffffc0201dac:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201db0:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201db4:	000c4563          	bltz	s8,ffffffffc0201dbe <vprintfmt+0x212>
ffffffffc0201db8:	3c7d                	addiw	s8,s8,-1
ffffffffc0201dba:	036c0263          	beq	s8,s6,ffffffffc0201dde <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0201dbe:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201dc0:	0e0c8e63          	beqz	s9,ffffffffc0201ebc <vprintfmt+0x310>
ffffffffc0201dc4:	3781                	addiw	a5,a5,-32
ffffffffc0201dc6:	0ef47b63          	bgeu	s0,a5,ffffffffc0201ebc <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0201dca:	03f00513          	li	a0,63
ffffffffc0201dce:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201dd0:	000a4783          	lbu	a5,0(s4)
ffffffffc0201dd4:	3dfd                	addiw	s11,s11,-1
ffffffffc0201dd6:	0a05                	addi	s4,s4,1
ffffffffc0201dd8:	0007851b          	sext.w	a0,a5
ffffffffc0201ddc:	ffe1                	bnez	a5,ffffffffc0201db4 <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0201dde:	01b05963          	blez	s11,ffffffffc0201df0 <vprintfmt+0x244>
ffffffffc0201de2:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0201de4:	85a6                	mv	a1,s1
ffffffffc0201de6:	02000513          	li	a0,32
ffffffffc0201dea:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0201dec:	fe0d9be3          	bnez	s11,ffffffffc0201de2 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0201df0:	6a02                	ld	s4,0(sp)
ffffffffc0201df2:	bbd5                	j	ffffffffc0201be6 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0201df4:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201df6:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc0201dfa:	01174463          	blt	a4,a7,ffffffffc0201e02 <vprintfmt+0x256>
    else if (lflag) {
ffffffffc0201dfe:	08088d63          	beqz	a7,ffffffffc0201e98 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc0201e02:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0201e06:	0a044d63          	bltz	s0,ffffffffc0201ec0 <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0201e0a:	8622                	mv	a2,s0
ffffffffc0201e0c:	8a66                	mv	s4,s9
ffffffffc0201e0e:	46a9                	li	a3,10
ffffffffc0201e10:	bdcd                	j	ffffffffc0201d02 <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc0201e12:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201e16:	4719                	li	a4,6
            err = va_arg(ap, int);
ffffffffc0201e18:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc0201e1a:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0201e1e:	8fb5                	xor	a5,a5,a3
ffffffffc0201e20:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201e24:	02d74163          	blt	a4,a3,ffffffffc0201e46 <vprintfmt+0x29a>
ffffffffc0201e28:	00369793          	slli	a5,a3,0x3
ffffffffc0201e2c:	97de                	add	a5,a5,s7
ffffffffc0201e2e:	639c                	ld	a5,0(a5)
ffffffffc0201e30:	cb99                	beqz	a5,ffffffffc0201e46 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc0201e32:	86be                	mv	a3,a5
ffffffffc0201e34:	00002617          	auipc	a2,0x2
ffffffffc0201e38:	97460613          	addi	a2,a2,-1676 # ffffffffc02037a8 <g_obj_sizes+0x60>
ffffffffc0201e3c:	85a6                	mv	a1,s1
ffffffffc0201e3e:	854a                	mv	a0,s2
ffffffffc0201e40:	0ce000ef          	jal	ra,ffffffffc0201f0e <printfmt>
ffffffffc0201e44:	b34d                	j	ffffffffc0201be6 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc0201e46:	00002617          	auipc	a2,0x2
ffffffffc0201e4a:	95260613          	addi	a2,a2,-1710 # ffffffffc0203798 <g_obj_sizes+0x50>
ffffffffc0201e4e:	85a6                	mv	a1,s1
ffffffffc0201e50:	854a                	mv	a0,s2
ffffffffc0201e52:	0bc000ef          	jal	ra,ffffffffc0201f0e <printfmt>
ffffffffc0201e56:	bb41                	j	ffffffffc0201be6 <vprintfmt+0x3a>
                p = "(null)";
ffffffffc0201e58:	00002417          	auipc	s0,0x2
ffffffffc0201e5c:	93840413          	addi	s0,s0,-1736 # ffffffffc0203790 <g_obj_sizes+0x48>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201e60:	85e2                	mv	a1,s8
ffffffffc0201e62:	8522                	mv	a0,s0
ffffffffc0201e64:	e43e                	sd	a5,8(sp)
ffffffffc0201e66:	0fc000ef          	jal	ra,ffffffffc0201f62 <strnlen>
ffffffffc0201e6a:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0201e6e:	01b05b63          	blez	s11,ffffffffc0201e84 <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc0201e72:	67a2                	ld	a5,8(sp)
ffffffffc0201e74:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201e78:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0201e7a:	85a6                	mv	a1,s1
ffffffffc0201e7c:	8552                	mv	a0,s4
ffffffffc0201e7e:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201e80:	fe0d9ce3          	bnez	s11,ffffffffc0201e78 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201e84:	00044783          	lbu	a5,0(s0)
ffffffffc0201e88:	00140a13          	addi	s4,s0,1
ffffffffc0201e8c:	0007851b          	sext.w	a0,a5
ffffffffc0201e90:	d3a5                	beqz	a5,ffffffffc0201df0 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201e92:	05e00413          	li	s0,94
ffffffffc0201e96:	bf39                	j	ffffffffc0201db4 <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc0201e98:	000a2403          	lw	s0,0(s4)
ffffffffc0201e9c:	b7ad                	j	ffffffffc0201e06 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0201e9e:	000a6603          	lwu	a2,0(s4)
ffffffffc0201ea2:	46a1                	li	a3,8
ffffffffc0201ea4:	8a2e                	mv	s4,a1
ffffffffc0201ea6:	bdb1                	j	ffffffffc0201d02 <vprintfmt+0x156>
ffffffffc0201ea8:	000a6603          	lwu	a2,0(s4)
ffffffffc0201eac:	46a9                	li	a3,10
ffffffffc0201eae:	8a2e                	mv	s4,a1
ffffffffc0201eb0:	bd89                	j	ffffffffc0201d02 <vprintfmt+0x156>
ffffffffc0201eb2:	000a6603          	lwu	a2,0(s4)
ffffffffc0201eb6:	46c1                	li	a3,16
ffffffffc0201eb8:	8a2e                	mv	s4,a1
ffffffffc0201eba:	b5a1                	j	ffffffffc0201d02 <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0201ebc:	9902                	jalr	s2
ffffffffc0201ebe:	bf09                	j	ffffffffc0201dd0 <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0201ec0:	85a6                	mv	a1,s1
ffffffffc0201ec2:	02d00513          	li	a0,45
ffffffffc0201ec6:	e03e                	sd	a5,0(sp)
ffffffffc0201ec8:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0201eca:	6782                	ld	a5,0(sp)
ffffffffc0201ecc:	8a66                	mv	s4,s9
ffffffffc0201ece:	40800633          	neg	a2,s0
ffffffffc0201ed2:	46a9                	li	a3,10
ffffffffc0201ed4:	b53d                	j	ffffffffc0201d02 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0201ed6:	03b05163          	blez	s11,ffffffffc0201ef8 <vprintfmt+0x34c>
ffffffffc0201eda:	02d00693          	li	a3,45
ffffffffc0201ede:	f6d79de3          	bne	a5,a3,ffffffffc0201e58 <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0201ee2:	00002417          	auipc	s0,0x2
ffffffffc0201ee6:	8ae40413          	addi	s0,s0,-1874 # ffffffffc0203790 <g_obj_sizes+0x48>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201eea:	02800793          	li	a5,40
ffffffffc0201eee:	02800513          	li	a0,40
ffffffffc0201ef2:	00140a13          	addi	s4,s0,1
ffffffffc0201ef6:	bd6d                	j	ffffffffc0201db0 <vprintfmt+0x204>
ffffffffc0201ef8:	00002a17          	auipc	s4,0x2
ffffffffc0201efc:	899a0a13          	addi	s4,s4,-1895 # ffffffffc0203791 <g_obj_sizes+0x49>
ffffffffc0201f00:	02800513          	li	a0,40
ffffffffc0201f04:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201f08:	05e00413          	li	s0,94
ffffffffc0201f0c:	b565                	j	ffffffffc0201db4 <vprintfmt+0x208>

ffffffffc0201f0e <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201f0e:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc0201f10:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201f14:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0201f16:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201f18:	ec06                	sd	ra,24(sp)
ffffffffc0201f1a:	f83a                	sd	a4,48(sp)
ffffffffc0201f1c:	fc3e                	sd	a5,56(sp)
ffffffffc0201f1e:	e0c2                	sd	a6,64(sp)
ffffffffc0201f20:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0201f22:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0201f24:	c89ff0ef          	jal	ra,ffffffffc0201bac <vprintfmt>
}
ffffffffc0201f28:	60e2                	ld	ra,24(sp)
ffffffffc0201f2a:	6161                	addi	sp,sp,80
ffffffffc0201f2c:	8082                	ret

ffffffffc0201f2e <sbi_console_putchar>:
uint64_t SBI_REMOTE_SFENCE_VMA_ASID = 7;
uint64_t SBI_SHUTDOWN = 8;

uint64_t sbi_call(uint64_t sbi_type, uint64_t arg0, uint64_t arg1, uint64_t arg2) {
    uint64_t ret_val;
    __asm__ volatile (
ffffffffc0201f2e:	4781                	li	a5,0
ffffffffc0201f30:	00005717          	auipc	a4,0x5
ffffffffc0201f34:	0e073703          	ld	a4,224(a4) # ffffffffc0207010 <SBI_CONSOLE_PUTCHAR>
ffffffffc0201f38:	88ba                	mv	a7,a4
ffffffffc0201f3a:	852a                	mv	a0,a0
ffffffffc0201f3c:	85be                	mv	a1,a5
ffffffffc0201f3e:	863e                	mv	a2,a5
ffffffffc0201f40:	00000073          	ecall
ffffffffc0201f44:	87aa                	mv	a5,a0
    return ret_val;
}

void sbi_console_putchar(unsigned char ch) {
    sbi_call(SBI_CONSOLE_PUTCHAR, ch, 0, 0);
}
ffffffffc0201f46:	8082                	ret

ffffffffc0201f48 <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc0201f48:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc0201f4c:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc0201f4e:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc0201f50:	cb81                	beqz	a5,ffffffffc0201f60 <strlen+0x18>
        cnt ++;
ffffffffc0201f52:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc0201f54:	00a707b3          	add	a5,a4,a0
ffffffffc0201f58:	0007c783          	lbu	a5,0(a5)
ffffffffc0201f5c:	fbfd                	bnez	a5,ffffffffc0201f52 <strlen+0xa>
ffffffffc0201f5e:	8082                	ret
    }
    return cnt;
}
ffffffffc0201f60:	8082                	ret

ffffffffc0201f62 <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc0201f62:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc0201f64:	e589                	bnez	a1,ffffffffc0201f6e <strnlen+0xc>
ffffffffc0201f66:	a811                	j	ffffffffc0201f7a <strnlen+0x18>
        cnt ++;
ffffffffc0201f68:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc0201f6a:	00f58863          	beq	a1,a5,ffffffffc0201f7a <strnlen+0x18>
ffffffffc0201f6e:	00f50733          	add	a4,a0,a5
ffffffffc0201f72:	00074703          	lbu	a4,0(a4)
ffffffffc0201f76:	fb6d                	bnez	a4,ffffffffc0201f68 <strnlen+0x6>
ffffffffc0201f78:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc0201f7a:	852e                	mv	a0,a1
ffffffffc0201f7c:	8082                	ret

ffffffffc0201f7e <strcpy>:
char *
strcpy(char *dst, const char *src) {
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
#else
    char *p = dst;
ffffffffc0201f7e:	87aa                	mv	a5,a0
    while ((*p ++ = *src ++) != '\0')
ffffffffc0201f80:	0005c703          	lbu	a4,0(a1)
ffffffffc0201f84:	0785                	addi	a5,a5,1
ffffffffc0201f86:	0585                	addi	a1,a1,1
ffffffffc0201f88:	fee78fa3          	sb	a4,-1(a5)
ffffffffc0201f8c:	fb75                	bnez	a4,ffffffffc0201f80 <strcpy+0x2>
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
ffffffffc0201f8e:	8082                	ret

ffffffffc0201f90 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201f90:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201f94:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201f98:	cb89                	beqz	a5,ffffffffc0201faa <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc0201f9a:	0505                	addi	a0,a0,1
ffffffffc0201f9c:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201f9e:	fee789e3          	beq	a5,a4,ffffffffc0201f90 <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201fa2:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc0201fa6:	9d19                	subw	a0,a0,a4
ffffffffc0201fa8:	8082                	ret
ffffffffc0201faa:	4501                	li	a0,0
ffffffffc0201fac:	bfed                	j	ffffffffc0201fa6 <strcmp+0x16>

ffffffffc0201fae <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201fae:	c20d                	beqz	a2,ffffffffc0201fd0 <strncmp+0x22>
ffffffffc0201fb0:	962e                	add	a2,a2,a1
ffffffffc0201fb2:	a031                	j	ffffffffc0201fbe <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc0201fb4:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201fb6:	00e79a63          	bne	a5,a4,ffffffffc0201fca <strncmp+0x1c>
ffffffffc0201fba:	00b60b63          	beq	a2,a1,ffffffffc0201fd0 <strncmp+0x22>
ffffffffc0201fbe:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc0201fc2:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201fc4:	fff5c703          	lbu	a4,-1(a1)
ffffffffc0201fc8:	f7f5                	bnez	a5,ffffffffc0201fb4 <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201fca:	40e7853b          	subw	a0,a5,a4
}
ffffffffc0201fce:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201fd0:	4501                	li	a0,0
ffffffffc0201fd2:	8082                	ret

ffffffffc0201fd4 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0201fd4:	ca01                	beqz	a2,ffffffffc0201fe4 <memset+0x10>
ffffffffc0201fd6:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc0201fd8:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc0201fda:	0785                	addi	a5,a5,1
ffffffffc0201fdc:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0201fe0:	fec79de3          	bne	a5,a2,ffffffffc0201fda <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0201fe4:	8082                	ret
