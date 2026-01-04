
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
ffffffffc0200000:	00014297          	auipc	t0,0x14
ffffffffc0200004:	00028293          	mv	t0,t0
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0214000 <boot_hartid>
ffffffffc020000c:	00014297          	auipc	t0,0x14
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0214008 <boot_dtb>
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)
ffffffffc0200018:	c02132b7          	lui	t0,0xc0213
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
ffffffffc0200034:	18029073          	csrw	satp,t0
ffffffffc0200038:	12000073          	sfence.vma
ffffffffc020003c:	c0213137          	lui	sp,0xc0213
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
ffffffffc0200044:	04a28293          	addi	t0,t0,74 # ffffffffc020004a <kern_init>
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <kern_init>:
ffffffffc020004a:	00091517          	auipc	a0,0x91
ffffffffc020004e:	01650513          	addi	a0,a0,22 # ffffffffc0291060 <buf>
ffffffffc0200052:	00097617          	auipc	a2,0x97
ffffffffc0200056:	8be60613          	addi	a2,a2,-1858 # ffffffffc0296910 <end>
ffffffffc020005a:	1141                	addi	sp,sp,-16
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
ffffffffc0200060:	e406                	sd	ra,8(sp)
ffffffffc0200062:	1320b0ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc0200066:	52c000ef          	jal	ra,ffffffffc0200592 <cons_init>
ffffffffc020006a:	0000b597          	auipc	a1,0xb
ffffffffc020006e:	19658593          	addi	a1,a1,406 # ffffffffc020b200 <etext+0x2>
ffffffffc0200072:	0000b517          	auipc	a0,0xb
ffffffffc0200076:	1ae50513          	addi	a0,a0,430 # ffffffffc020b220 <etext+0x22>
ffffffffc020007a:	12c000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020007e:	1ae000ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc0200082:	62a000ef          	jal	ra,ffffffffc02006ac <dtb_init>
ffffffffc0200086:	24b020ef          	jal	ra,ffffffffc0202ad0 <pmm_init>
ffffffffc020008a:	3ef000ef          	jal	ra,ffffffffc0200c78 <pic_init>
ffffffffc020008e:	515000ef          	jal	ra,ffffffffc0200da2 <idt_init>
ffffffffc0200092:	6b5030ef          	jal	ra,ffffffffc0203f46 <vmm_init>
ffffffffc0200096:	7bf060ef          	jal	ra,ffffffffc0207054 <sched_init>
ffffffffc020009a:	3c5060ef          	jal	ra,ffffffffc0206c5e <proc_init>
ffffffffc020009e:	1bf000ef          	jal	ra,ffffffffc0200a5c <ide_init>
ffffffffc02000a2:	0e6050ef          	jal	ra,ffffffffc0205188 <fs_init>
ffffffffc02000a6:	4a4000ef          	jal	ra,ffffffffc020054a <clock_init>
ffffffffc02000aa:	3c3000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02000ae:	57d060ef          	jal	ra,ffffffffc0206e2a <cpu_idle>

ffffffffc02000b2 <readline>:
ffffffffc02000b2:	715d                	addi	sp,sp,-80
ffffffffc02000b4:	e486                	sd	ra,72(sp)
ffffffffc02000b6:	e0a6                	sd	s1,64(sp)
ffffffffc02000b8:	fc4a                	sd	s2,56(sp)
ffffffffc02000ba:	f84e                	sd	s3,48(sp)
ffffffffc02000bc:	f452                	sd	s4,40(sp)
ffffffffc02000be:	f056                	sd	s5,32(sp)
ffffffffc02000c0:	ec5a                	sd	s6,24(sp)
ffffffffc02000c2:	e85e                	sd	s7,16(sp)
ffffffffc02000c4:	c901                	beqz	a0,ffffffffc02000d4 <readline+0x22>
ffffffffc02000c6:	85aa                	mv	a1,a0
ffffffffc02000c8:	0000b517          	auipc	a0,0xb
ffffffffc02000cc:	16050513          	addi	a0,a0,352 # ffffffffc020b228 <etext+0x2a>
ffffffffc02000d0:	0d6000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02000d4:	4481                	li	s1,0
ffffffffc02000d6:	497d                	li	s2,31
ffffffffc02000d8:	49a1                	li	s3,8
ffffffffc02000da:	4aa9                	li	s5,10
ffffffffc02000dc:	4b35                	li	s6,13
ffffffffc02000de:	00091b97          	auipc	s7,0x91
ffffffffc02000e2:	f82b8b93          	addi	s7,s7,-126 # ffffffffc0291060 <buf>
ffffffffc02000e6:	3fe00a13          	li	s4,1022
ffffffffc02000ea:	0fa000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc02000ee:	00054a63          	bltz	a0,ffffffffc0200102 <readline+0x50>
ffffffffc02000f2:	00a95a63          	bge	s2,a0,ffffffffc0200106 <readline+0x54>
ffffffffc02000f6:	029a5263          	bge	s4,s1,ffffffffc020011a <readline+0x68>
ffffffffc02000fa:	0ea000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc02000fe:	fe055ae3          	bgez	a0,ffffffffc02000f2 <readline+0x40>
ffffffffc0200102:	4501                	li	a0,0
ffffffffc0200104:	a091                	j	ffffffffc0200148 <readline+0x96>
ffffffffc0200106:	03351463          	bne	a0,s3,ffffffffc020012e <readline+0x7c>
ffffffffc020010a:	e8a9                	bnez	s1,ffffffffc020015c <readline+0xaa>
ffffffffc020010c:	0d8000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc0200110:	fe0549e3          	bltz	a0,ffffffffc0200102 <readline+0x50>
ffffffffc0200114:	fea959e3          	bge	s2,a0,ffffffffc0200106 <readline+0x54>
ffffffffc0200118:	4481                	li	s1,0
ffffffffc020011a:	e42a                	sd	a0,8(sp)
ffffffffc020011c:	0c6000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0200120:	6522                	ld	a0,8(sp)
ffffffffc0200122:	009b87b3          	add	a5,s7,s1
ffffffffc0200126:	2485                	addiw	s1,s1,1
ffffffffc0200128:	00a78023          	sb	a0,0(a5)
ffffffffc020012c:	bf7d                	j	ffffffffc02000ea <readline+0x38>
ffffffffc020012e:	01550463          	beq	a0,s5,ffffffffc0200136 <readline+0x84>
ffffffffc0200132:	fb651ce3          	bne	a0,s6,ffffffffc02000ea <readline+0x38>
ffffffffc0200136:	0ac000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc020013a:	00091517          	auipc	a0,0x91
ffffffffc020013e:	f2650513          	addi	a0,a0,-218 # ffffffffc0291060 <buf>
ffffffffc0200142:	94aa                	add	s1,s1,a0
ffffffffc0200144:	00048023          	sb	zero,0(s1)
ffffffffc0200148:	60a6                	ld	ra,72(sp)
ffffffffc020014a:	6486                	ld	s1,64(sp)
ffffffffc020014c:	7962                	ld	s2,56(sp)
ffffffffc020014e:	79c2                	ld	s3,48(sp)
ffffffffc0200150:	7a22                	ld	s4,40(sp)
ffffffffc0200152:	7a82                	ld	s5,32(sp)
ffffffffc0200154:	6b62                	ld	s6,24(sp)
ffffffffc0200156:	6bc2                	ld	s7,16(sp)
ffffffffc0200158:	6161                	addi	sp,sp,80
ffffffffc020015a:	8082                	ret
ffffffffc020015c:	4521                	li	a0,8
ffffffffc020015e:	084000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0200162:	34fd                	addiw	s1,s1,-1
ffffffffc0200164:	b759                	j	ffffffffc02000ea <readline+0x38>

ffffffffc0200166 <cputch>:
ffffffffc0200166:	1141                	addi	sp,sp,-16
ffffffffc0200168:	e022                	sd	s0,0(sp)
ffffffffc020016a:	e406                	sd	ra,8(sp)
ffffffffc020016c:	842e                	mv	s0,a1
ffffffffc020016e:	432000ef          	jal	ra,ffffffffc02005a0 <cons_putc>
ffffffffc0200172:	401c                	lw	a5,0(s0)
ffffffffc0200174:	60a2                	ld	ra,8(sp)
ffffffffc0200176:	2785                	addiw	a5,a5,1
ffffffffc0200178:	c01c                	sw	a5,0(s0)
ffffffffc020017a:	6402                	ld	s0,0(sp)
ffffffffc020017c:	0141                	addi	sp,sp,16
ffffffffc020017e:	8082                	ret

ffffffffc0200180 <vcprintf>:
ffffffffc0200180:	1101                	addi	sp,sp,-32
ffffffffc0200182:	872e                	mv	a4,a1
ffffffffc0200184:	75dd                	lui	a1,0xffff7
ffffffffc0200186:	86aa                	mv	a3,a0
ffffffffc0200188:	0070                	addi	a2,sp,12
ffffffffc020018a:	00000517          	auipc	a0,0x0
ffffffffc020018e:	fdc50513          	addi	a0,a0,-36 # ffffffffc0200166 <cputch>
ffffffffc0200192:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0200196:	ec06                	sd	ra,24(sp)
ffffffffc0200198:	c602                	sw	zero,12(sp)
ffffffffc020019a:	36d0a0ef          	jal	ra,ffffffffc020ad06 <vprintfmt>
ffffffffc020019e:	60e2                	ld	ra,24(sp)
ffffffffc02001a0:	4532                	lw	a0,12(sp)
ffffffffc02001a2:	6105                	addi	sp,sp,32
ffffffffc02001a4:	8082                	ret

ffffffffc02001a6 <cprintf>:
ffffffffc02001a6:	711d                	addi	sp,sp,-96
ffffffffc02001a8:	02810313          	addi	t1,sp,40 # ffffffffc0213028 <boot_page_table_sv39+0x28>
ffffffffc02001ac:	8e2a                	mv	t3,a0
ffffffffc02001ae:	f42e                	sd	a1,40(sp)
ffffffffc02001b0:	75dd                	lui	a1,0xffff7
ffffffffc02001b2:	f832                	sd	a2,48(sp)
ffffffffc02001b4:	fc36                	sd	a3,56(sp)
ffffffffc02001b6:	e0ba                	sd	a4,64(sp)
ffffffffc02001b8:	00000517          	auipc	a0,0x0
ffffffffc02001bc:	fae50513          	addi	a0,a0,-82 # ffffffffc0200166 <cputch>
ffffffffc02001c0:	0050                	addi	a2,sp,4
ffffffffc02001c2:	871a                	mv	a4,t1
ffffffffc02001c4:	86f2                	mv	a3,t3
ffffffffc02001c6:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc02001ca:	ec06                	sd	ra,24(sp)
ffffffffc02001cc:	e4be                	sd	a5,72(sp)
ffffffffc02001ce:	e8c2                	sd	a6,80(sp)
ffffffffc02001d0:	ecc6                	sd	a7,88(sp)
ffffffffc02001d2:	e41a                	sd	t1,8(sp)
ffffffffc02001d4:	c202                	sw	zero,4(sp)
ffffffffc02001d6:	3310a0ef          	jal	ra,ffffffffc020ad06 <vprintfmt>
ffffffffc02001da:	60e2                	ld	ra,24(sp)
ffffffffc02001dc:	4512                	lw	a0,4(sp)
ffffffffc02001de:	6125                	addi	sp,sp,96
ffffffffc02001e0:	8082                	ret

ffffffffc02001e2 <cputchar>:
ffffffffc02001e2:	ae7d                	j	ffffffffc02005a0 <cons_putc>

ffffffffc02001e4 <getchar>:
ffffffffc02001e4:	1141                	addi	sp,sp,-16
ffffffffc02001e6:	e406                	sd	ra,8(sp)
ffffffffc02001e8:	40c000ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc02001ec:	dd75                	beqz	a0,ffffffffc02001e8 <getchar+0x4>
ffffffffc02001ee:	60a2                	ld	ra,8(sp)
ffffffffc02001f0:	0141                	addi	sp,sp,16
ffffffffc02001f2:	8082                	ret

ffffffffc02001f4 <strdup>:
ffffffffc02001f4:	1101                	addi	sp,sp,-32
ffffffffc02001f6:	ec06                	sd	ra,24(sp)
ffffffffc02001f8:	e822                	sd	s0,16(sp)
ffffffffc02001fa:	e426                	sd	s1,8(sp)
ffffffffc02001fc:	e04a                	sd	s2,0(sp)
ffffffffc02001fe:	892a                	mv	s2,a0
ffffffffc0200200:	6f30a0ef          	jal	ra,ffffffffc020b0f2 <strlen>
ffffffffc0200204:	842a                	mv	s0,a0
ffffffffc0200206:	0505                	addi	a0,a0,1
ffffffffc0200208:	587010ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020020c:	84aa                	mv	s1,a0
ffffffffc020020e:	c901                	beqz	a0,ffffffffc020021e <strdup+0x2a>
ffffffffc0200210:	8622                	mv	a2,s0
ffffffffc0200212:	85ca                	mv	a1,s2
ffffffffc0200214:	9426                	add	s0,s0,s1
ffffffffc0200216:	7d10a0ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc020021a:	00040023          	sb	zero,0(s0)
ffffffffc020021e:	60e2                	ld	ra,24(sp)
ffffffffc0200220:	6442                	ld	s0,16(sp)
ffffffffc0200222:	6902                	ld	s2,0(sp)
ffffffffc0200224:	8526                	mv	a0,s1
ffffffffc0200226:	64a2                	ld	s1,8(sp)
ffffffffc0200228:	6105                	addi	sp,sp,32
ffffffffc020022a:	8082                	ret

ffffffffc020022c <print_kerninfo>:
ffffffffc020022c:	1141                	addi	sp,sp,-16
ffffffffc020022e:	0000b517          	auipc	a0,0xb
ffffffffc0200232:	00250513          	addi	a0,a0,2 # ffffffffc020b230 <etext+0x32>
ffffffffc0200236:	e406                	sd	ra,8(sp)
ffffffffc0200238:	f6fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020023c:	00000597          	auipc	a1,0x0
ffffffffc0200240:	e0e58593          	addi	a1,a1,-498 # ffffffffc020004a <kern_init>
ffffffffc0200244:	0000b517          	auipc	a0,0xb
ffffffffc0200248:	00c50513          	addi	a0,a0,12 # ffffffffc020b250 <etext+0x52>
ffffffffc020024c:	f5bff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200250:	0000b597          	auipc	a1,0xb
ffffffffc0200254:	fae58593          	addi	a1,a1,-82 # ffffffffc020b1fe <etext>
ffffffffc0200258:	0000b517          	auipc	a0,0xb
ffffffffc020025c:	01850513          	addi	a0,a0,24 # ffffffffc020b270 <etext+0x72>
ffffffffc0200260:	f47ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200264:	00091597          	auipc	a1,0x91
ffffffffc0200268:	dfc58593          	addi	a1,a1,-516 # ffffffffc0291060 <buf>
ffffffffc020026c:	0000b517          	auipc	a0,0xb
ffffffffc0200270:	02450513          	addi	a0,a0,36 # ffffffffc020b290 <etext+0x92>
ffffffffc0200274:	f33ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200278:	00096597          	auipc	a1,0x96
ffffffffc020027c:	69858593          	addi	a1,a1,1688 # ffffffffc0296910 <end>
ffffffffc0200280:	0000b517          	auipc	a0,0xb
ffffffffc0200284:	03050513          	addi	a0,a0,48 # ffffffffc020b2b0 <etext+0xb2>
ffffffffc0200288:	f1fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020028c:	00097597          	auipc	a1,0x97
ffffffffc0200290:	a8358593          	addi	a1,a1,-1405 # ffffffffc0296d0f <end+0x3ff>
ffffffffc0200294:	00000797          	auipc	a5,0x0
ffffffffc0200298:	db678793          	addi	a5,a5,-586 # ffffffffc020004a <kern_init>
ffffffffc020029c:	40f587b3          	sub	a5,a1,a5
ffffffffc02002a0:	43f7d593          	srai	a1,a5,0x3f
ffffffffc02002a4:	60a2                	ld	ra,8(sp)
ffffffffc02002a6:	3ff5f593          	andi	a1,a1,1023
ffffffffc02002aa:	95be                	add	a1,a1,a5
ffffffffc02002ac:	85a9                	srai	a1,a1,0xa
ffffffffc02002ae:	0000b517          	auipc	a0,0xb
ffffffffc02002b2:	02250513          	addi	a0,a0,34 # ffffffffc020b2d0 <etext+0xd2>
ffffffffc02002b6:	0141                	addi	sp,sp,16
ffffffffc02002b8:	b5fd                	j	ffffffffc02001a6 <cprintf>

ffffffffc02002ba <print_stackframe>:
ffffffffc02002ba:	1141                	addi	sp,sp,-16
ffffffffc02002bc:	0000b617          	auipc	a2,0xb
ffffffffc02002c0:	04460613          	addi	a2,a2,68 # ffffffffc020b300 <etext+0x102>
ffffffffc02002c4:	04e00593          	li	a1,78
ffffffffc02002c8:	0000b517          	auipc	a0,0xb
ffffffffc02002cc:	05050513          	addi	a0,a0,80 # ffffffffc020b318 <etext+0x11a>
ffffffffc02002d0:	e406                	sd	ra,8(sp)
ffffffffc02002d2:	1cc000ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02002d6 <mon_help>:
ffffffffc02002d6:	1141                	addi	sp,sp,-16
ffffffffc02002d8:	0000b617          	auipc	a2,0xb
ffffffffc02002dc:	05860613          	addi	a2,a2,88 # ffffffffc020b330 <etext+0x132>
ffffffffc02002e0:	0000b597          	auipc	a1,0xb
ffffffffc02002e4:	07058593          	addi	a1,a1,112 # ffffffffc020b350 <etext+0x152>
ffffffffc02002e8:	0000b517          	auipc	a0,0xb
ffffffffc02002ec:	07050513          	addi	a0,a0,112 # ffffffffc020b358 <etext+0x15a>
ffffffffc02002f0:	e406                	sd	ra,8(sp)
ffffffffc02002f2:	eb5ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02002f6:	0000b617          	auipc	a2,0xb
ffffffffc02002fa:	07260613          	addi	a2,a2,114 # ffffffffc020b368 <etext+0x16a>
ffffffffc02002fe:	0000b597          	auipc	a1,0xb
ffffffffc0200302:	09258593          	addi	a1,a1,146 # ffffffffc020b390 <etext+0x192>
ffffffffc0200306:	0000b517          	auipc	a0,0xb
ffffffffc020030a:	05250513          	addi	a0,a0,82 # ffffffffc020b358 <etext+0x15a>
ffffffffc020030e:	e99ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200312:	0000b617          	auipc	a2,0xb
ffffffffc0200316:	08e60613          	addi	a2,a2,142 # ffffffffc020b3a0 <etext+0x1a2>
ffffffffc020031a:	0000b597          	auipc	a1,0xb
ffffffffc020031e:	0a658593          	addi	a1,a1,166 # ffffffffc020b3c0 <etext+0x1c2>
ffffffffc0200322:	0000b517          	auipc	a0,0xb
ffffffffc0200326:	03650513          	addi	a0,a0,54 # ffffffffc020b358 <etext+0x15a>
ffffffffc020032a:	e7dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020032e:	60a2                	ld	ra,8(sp)
ffffffffc0200330:	4501                	li	a0,0
ffffffffc0200332:	0141                	addi	sp,sp,16
ffffffffc0200334:	8082                	ret

ffffffffc0200336 <mon_kerninfo>:
ffffffffc0200336:	1141                	addi	sp,sp,-16
ffffffffc0200338:	e406                	sd	ra,8(sp)
ffffffffc020033a:	ef3ff0ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc020033e:	60a2                	ld	ra,8(sp)
ffffffffc0200340:	4501                	li	a0,0
ffffffffc0200342:	0141                	addi	sp,sp,16
ffffffffc0200344:	8082                	ret

ffffffffc0200346 <mon_backtrace>:
ffffffffc0200346:	1141                	addi	sp,sp,-16
ffffffffc0200348:	e406                	sd	ra,8(sp)
ffffffffc020034a:	f71ff0ef          	jal	ra,ffffffffc02002ba <print_stackframe>
ffffffffc020034e:	60a2                	ld	ra,8(sp)
ffffffffc0200350:	4501                	li	a0,0
ffffffffc0200352:	0141                	addi	sp,sp,16
ffffffffc0200354:	8082                	ret

ffffffffc0200356 <kmonitor>:
ffffffffc0200356:	7115                	addi	sp,sp,-224
ffffffffc0200358:	ed5e                	sd	s7,152(sp)
ffffffffc020035a:	8baa                	mv	s7,a0
ffffffffc020035c:	0000b517          	auipc	a0,0xb
ffffffffc0200360:	07450513          	addi	a0,a0,116 # ffffffffc020b3d0 <etext+0x1d2>
ffffffffc0200364:	ed86                	sd	ra,216(sp)
ffffffffc0200366:	e9a2                	sd	s0,208(sp)
ffffffffc0200368:	e5a6                	sd	s1,200(sp)
ffffffffc020036a:	e1ca                	sd	s2,192(sp)
ffffffffc020036c:	fd4e                	sd	s3,184(sp)
ffffffffc020036e:	f952                	sd	s4,176(sp)
ffffffffc0200370:	f556                	sd	s5,168(sp)
ffffffffc0200372:	f15a                	sd	s6,160(sp)
ffffffffc0200374:	e962                	sd	s8,144(sp)
ffffffffc0200376:	e566                	sd	s9,136(sp)
ffffffffc0200378:	e16a                	sd	s10,128(sp)
ffffffffc020037a:	e2dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020037e:	0000b517          	auipc	a0,0xb
ffffffffc0200382:	07a50513          	addi	a0,a0,122 # ffffffffc020b3f8 <etext+0x1fa>
ffffffffc0200386:	e21ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020038a:	000b8563          	beqz	s7,ffffffffc0200394 <kmonitor+0x3e>
ffffffffc020038e:	855e                	mv	a0,s7
ffffffffc0200390:	3fb000ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc0200394:	0000bc17          	auipc	s8,0xb
ffffffffc0200398:	0d4c0c13          	addi	s8,s8,212 # ffffffffc020b468 <commands>
ffffffffc020039c:	0000b917          	auipc	s2,0xb
ffffffffc02003a0:	08490913          	addi	s2,s2,132 # ffffffffc020b420 <etext+0x222>
ffffffffc02003a4:	0000b497          	auipc	s1,0xb
ffffffffc02003a8:	08448493          	addi	s1,s1,132 # ffffffffc020b428 <etext+0x22a>
ffffffffc02003ac:	49bd                	li	s3,15
ffffffffc02003ae:	0000bb17          	auipc	s6,0xb
ffffffffc02003b2:	082b0b13          	addi	s6,s6,130 # ffffffffc020b430 <etext+0x232>
ffffffffc02003b6:	0000ba17          	auipc	s4,0xb
ffffffffc02003ba:	f9aa0a13          	addi	s4,s4,-102 # ffffffffc020b350 <etext+0x152>
ffffffffc02003be:	4a8d                	li	s5,3
ffffffffc02003c0:	854a                	mv	a0,s2
ffffffffc02003c2:	cf1ff0ef          	jal	ra,ffffffffc02000b2 <readline>
ffffffffc02003c6:	842a                	mv	s0,a0
ffffffffc02003c8:	dd65                	beqz	a0,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc02003ca:	00054583          	lbu	a1,0(a0)
ffffffffc02003ce:	4c81                	li	s9,0
ffffffffc02003d0:	e1bd                	bnez	a1,ffffffffc0200436 <kmonitor+0xe0>
ffffffffc02003d2:	fe0c87e3          	beqz	s9,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc02003d6:	6582                	ld	a1,0(sp)
ffffffffc02003d8:	0000bd17          	auipc	s10,0xb
ffffffffc02003dc:	090d0d13          	addi	s10,s10,144 # ffffffffc020b468 <commands>
ffffffffc02003e0:	8552                	mv	a0,s4
ffffffffc02003e2:	4401                	li	s0,0
ffffffffc02003e4:	0d61                	addi	s10,s10,24
ffffffffc02003e6:	5550a0ef          	jal	ra,ffffffffc020b13a <strcmp>
ffffffffc02003ea:	c919                	beqz	a0,ffffffffc0200400 <kmonitor+0xaa>
ffffffffc02003ec:	2405                	addiw	s0,s0,1
ffffffffc02003ee:	0b540063          	beq	s0,s5,ffffffffc020048e <kmonitor+0x138>
ffffffffc02003f2:	000d3503          	ld	a0,0(s10)
ffffffffc02003f6:	6582                	ld	a1,0(sp)
ffffffffc02003f8:	0d61                	addi	s10,s10,24
ffffffffc02003fa:	5410a0ef          	jal	ra,ffffffffc020b13a <strcmp>
ffffffffc02003fe:	f57d                	bnez	a0,ffffffffc02003ec <kmonitor+0x96>
ffffffffc0200400:	00141793          	slli	a5,s0,0x1
ffffffffc0200404:	97a2                	add	a5,a5,s0
ffffffffc0200406:	078e                	slli	a5,a5,0x3
ffffffffc0200408:	97e2                	add	a5,a5,s8
ffffffffc020040a:	6b9c                	ld	a5,16(a5)
ffffffffc020040c:	865e                	mv	a2,s7
ffffffffc020040e:	002c                	addi	a1,sp,8
ffffffffc0200410:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200414:	9782                	jalr	a5
ffffffffc0200416:	fa0555e3          	bgez	a0,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc020041a:	60ee                	ld	ra,216(sp)
ffffffffc020041c:	644e                	ld	s0,208(sp)
ffffffffc020041e:	64ae                	ld	s1,200(sp)
ffffffffc0200420:	690e                	ld	s2,192(sp)
ffffffffc0200422:	79ea                	ld	s3,184(sp)
ffffffffc0200424:	7a4a                	ld	s4,176(sp)
ffffffffc0200426:	7aaa                	ld	s5,168(sp)
ffffffffc0200428:	7b0a                	ld	s6,160(sp)
ffffffffc020042a:	6bea                	ld	s7,152(sp)
ffffffffc020042c:	6c4a                	ld	s8,144(sp)
ffffffffc020042e:	6caa                	ld	s9,136(sp)
ffffffffc0200430:	6d0a                	ld	s10,128(sp)
ffffffffc0200432:	612d                	addi	sp,sp,224
ffffffffc0200434:	8082                	ret
ffffffffc0200436:	8526                	mv	a0,s1
ffffffffc0200438:	5470a0ef          	jal	ra,ffffffffc020b17e <strchr>
ffffffffc020043c:	c901                	beqz	a0,ffffffffc020044c <kmonitor+0xf6>
ffffffffc020043e:	00144583          	lbu	a1,1(s0)
ffffffffc0200442:	00040023          	sb	zero,0(s0)
ffffffffc0200446:	0405                	addi	s0,s0,1
ffffffffc0200448:	d5c9                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc020044a:	b7f5                	j	ffffffffc0200436 <kmonitor+0xe0>
ffffffffc020044c:	00044783          	lbu	a5,0(s0)
ffffffffc0200450:	d3c9                	beqz	a5,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200452:	033c8963          	beq	s9,s3,ffffffffc0200484 <kmonitor+0x12e>
ffffffffc0200456:	003c9793          	slli	a5,s9,0x3
ffffffffc020045a:	0118                	addi	a4,sp,128
ffffffffc020045c:	97ba                	add	a5,a5,a4
ffffffffc020045e:	f887b023          	sd	s0,-128(a5)
ffffffffc0200462:	00044583          	lbu	a1,0(s0)
ffffffffc0200466:	2c85                	addiw	s9,s9,1
ffffffffc0200468:	e591                	bnez	a1,ffffffffc0200474 <kmonitor+0x11e>
ffffffffc020046a:	b7b5                	j	ffffffffc02003d6 <kmonitor+0x80>
ffffffffc020046c:	00144583          	lbu	a1,1(s0)
ffffffffc0200470:	0405                	addi	s0,s0,1
ffffffffc0200472:	d1a5                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200474:	8526                	mv	a0,s1
ffffffffc0200476:	5090a0ef          	jal	ra,ffffffffc020b17e <strchr>
ffffffffc020047a:	d96d                	beqz	a0,ffffffffc020046c <kmonitor+0x116>
ffffffffc020047c:	00044583          	lbu	a1,0(s0)
ffffffffc0200480:	d9a9                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200482:	bf55                	j	ffffffffc0200436 <kmonitor+0xe0>
ffffffffc0200484:	45c1                	li	a1,16
ffffffffc0200486:	855a                	mv	a0,s6
ffffffffc0200488:	d1fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020048c:	b7e9                	j	ffffffffc0200456 <kmonitor+0x100>
ffffffffc020048e:	6582                	ld	a1,0(sp)
ffffffffc0200490:	0000b517          	auipc	a0,0xb
ffffffffc0200494:	fc050513          	addi	a0,a0,-64 # ffffffffc020b450 <etext+0x252>
ffffffffc0200498:	d0fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020049c:	b715                	j	ffffffffc02003c0 <kmonitor+0x6a>

ffffffffc020049e <__panic>:
ffffffffc020049e:	00096317          	auipc	t1,0x96
ffffffffc02004a2:	3ca30313          	addi	t1,t1,970 # ffffffffc0296868 <is_panic>
ffffffffc02004a6:	00033e03          	ld	t3,0(t1)
ffffffffc02004aa:	715d                	addi	sp,sp,-80
ffffffffc02004ac:	ec06                	sd	ra,24(sp)
ffffffffc02004ae:	e822                	sd	s0,16(sp)
ffffffffc02004b0:	f436                	sd	a3,40(sp)
ffffffffc02004b2:	f83a                	sd	a4,48(sp)
ffffffffc02004b4:	fc3e                	sd	a5,56(sp)
ffffffffc02004b6:	e0c2                	sd	a6,64(sp)
ffffffffc02004b8:	e4c6                	sd	a7,72(sp)
ffffffffc02004ba:	020e1a63          	bnez	t3,ffffffffc02004ee <__panic+0x50>
ffffffffc02004be:	4785                	li	a5,1
ffffffffc02004c0:	00f33023          	sd	a5,0(t1)
ffffffffc02004c4:	8432                	mv	s0,a2
ffffffffc02004c6:	103c                	addi	a5,sp,40
ffffffffc02004c8:	862e                	mv	a2,a1
ffffffffc02004ca:	85aa                	mv	a1,a0
ffffffffc02004cc:	0000b517          	auipc	a0,0xb
ffffffffc02004d0:	fe450513          	addi	a0,a0,-28 # ffffffffc020b4b0 <commands+0x48>
ffffffffc02004d4:	e43e                	sd	a5,8(sp)
ffffffffc02004d6:	cd1ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004da:	65a2                	ld	a1,8(sp)
ffffffffc02004dc:	8522                	mv	a0,s0
ffffffffc02004de:	ca3ff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc02004e2:	0000c517          	auipc	a0,0xc
ffffffffc02004e6:	28e50513          	addi	a0,a0,654 # ffffffffc020c770 <default_pmm_manager+0x610>
ffffffffc02004ea:	cbdff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004ee:	4501                	li	a0,0
ffffffffc02004f0:	4581                	li	a1,0
ffffffffc02004f2:	4601                	li	a2,0
ffffffffc02004f4:	48a1                	li	a7,8
ffffffffc02004f6:	00000073          	ecall
ffffffffc02004fa:	778000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02004fe:	4501                	li	a0,0
ffffffffc0200500:	e57ff0ef          	jal	ra,ffffffffc0200356 <kmonitor>
ffffffffc0200504:	bfed                	j	ffffffffc02004fe <__panic+0x60>

ffffffffc0200506 <__warn>:
ffffffffc0200506:	715d                	addi	sp,sp,-80
ffffffffc0200508:	832e                	mv	t1,a1
ffffffffc020050a:	e822                	sd	s0,16(sp)
ffffffffc020050c:	85aa                	mv	a1,a0
ffffffffc020050e:	8432                	mv	s0,a2
ffffffffc0200510:	fc3e                	sd	a5,56(sp)
ffffffffc0200512:	861a                	mv	a2,t1
ffffffffc0200514:	103c                	addi	a5,sp,40
ffffffffc0200516:	0000b517          	auipc	a0,0xb
ffffffffc020051a:	fba50513          	addi	a0,a0,-70 # ffffffffc020b4d0 <commands+0x68>
ffffffffc020051e:	ec06                	sd	ra,24(sp)
ffffffffc0200520:	f436                	sd	a3,40(sp)
ffffffffc0200522:	f83a                	sd	a4,48(sp)
ffffffffc0200524:	e0c2                	sd	a6,64(sp)
ffffffffc0200526:	e4c6                	sd	a7,72(sp)
ffffffffc0200528:	e43e                	sd	a5,8(sp)
ffffffffc020052a:	c7dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020052e:	65a2                	ld	a1,8(sp)
ffffffffc0200530:	8522                	mv	a0,s0
ffffffffc0200532:	c4fff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc0200536:	0000c517          	auipc	a0,0xc
ffffffffc020053a:	23a50513          	addi	a0,a0,570 # ffffffffc020c770 <default_pmm_manager+0x610>
ffffffffc020053e:	c69ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200542:	60e2                	ld	ra,24(sp)
ffffffffc0200544:	6442                	ld	s0,16(sp)
ffffffffc0200546:	6161                	addi	sp,sp,80
ffffffffc0200548:	8082                	ret

ffffffffc020054a <clock_init>:
ffffffffc020054a:	02000793          	li	a5,32
ffffffffc020054e:	1047a7f3          	csrrs	a5,sie,a5
ffffffffc0200552:	c0102573          	rdtime	a0
ffffffffc0200556:	67e1                	lui	a5,0x18
ffffffffc0200558:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc020055c:	953e                	add	a0,a0,a5
ffffffffc020055e:	4581                	li	a1,0
ffffffffc0200560:	4601                	li	a2,0
ffffffffc0200562:	4881                	li	a7,0
ffffffffc0200564:	00000073          	ecall
ffffffffc0200568:	0000b517          	auipc	a0,0xb
ffffffffc020056c:	f8850513          	addi	a0,a0,-120 # ffffffffc020b4f0 <commands+0x88>
ffffffffc0200570:	00096797          	auipc	a5,0x96
ffffffffc0200574:	3007b023          	sd	zero,768(a5) # ffffffffc0296870 <ticks>
ffffffffc0200578:	b13d                	j	ffffffffc02001a6 <cprintf>

ffffffffc020057a <clock_set_next_event>:
ffffffffc020057a:	c0102573          	rdtime	a0
ffffffffc020057e:	67e1                	lui	a5,0x18
ffffffffc0200580:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc0200584:	953e                	add	a0,a0,a5
ffffffffc0200586:	4581                	li	a1,0
ffffffffc0200588:	4601                	li	a2,0
ffffffffc020058a:	4881                	li	a7,0
ffffffffc020058c:	00000073          	ecall
ffffffffc0200590:	8082                	ret

ffffffffc0200592 <cons_init>:
ffffffffc0200592:	4501                	li	a0,0
ffffffffc0200594:	4581                	li	a1,0
ffffffffc0200596:	4601                	li	a2,0
ffffffffc0200598:	4889                	li	a7,2
ffffffffc020059a:	00000073          	ecall
ffffffffc020059e:	8082                	ret

ffffffffc02005a0 <cons_putc>:
ffffffffc02005a0:	1101                	addi	sp,sp,-32
ffffffffc02005a2:	ec06                	sd	ra,24(sp)
ffffffffc02005a4:	100027f3          	csrr	a5,sstatus
ffffffffc02005a8:	8b89                	andi	a5,a5,2
ffffffffc02005aa:	4701                	li	a4,0
ffffffffc02005ac:	ef95                	bnez	a5,ffffffffc02005e8 <cons_putc+0x48>
ffffffffc02005ae:	47a1                	li	a5,8
ffffffffc02005b0:	00f50b63          	beq	a0,a5,ffffffffc02005c6 <cons_putc+0x26>
ffffffffc02005b4:	4581                	li	a1,0
ffffffffc02005b6:	4601                	li	a2,0
ffffffffc02005b8:	4885                	li	a7,1
ffffffffc02005ba:	00000073          	ecall
ffffffffc02005be:	e315                	bnez	a4,ffffffffc02005e2 <cons_putc+0x42>
ffffffffc02005c0:	60e2                	ld	ra,24(sp)
ffffffffc02005c2:	6105                	addi	sp,sp,32
ffffffffc02005c4:	8082                	ret
ffffffffc02005c6:	4521                	li	a0,8
ffffffffc02005c8:	4581                	li	a1,0
ffffffffc02005ca:	4601                	li	a2,0
ffffffffc02005cc:	4885                	li	a7,1
ffffffffc02005ce:	00000073          	ecall
ffffffffc02005d2:	02000513          	li	a0,32
ffffffffc02005d6:	00000073          	ecall
ffffffffc02005da:	4521                	li	a0,8
ffffffffc02005dc:	00000073          	ecall
ffffffffc02005e0:	d365                	beqz	a4,ffffffffc02005c0 <cons_putc+0x20>
ffffffffc02005e2:	60e2                	ld	ra,24(sp)
ffffffffc02005e4:	6105                	addi	sp,sp,32
ffffffffc02005e6:	a559                	j	ffffffffc0200c6c <intr_enable>
ffffffffc02005e8:	e42a                	sd	a0,8(sp)
ffffffffc02005ea:	688000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02005ee:	6522                	ld	a0,8(sp)
ffffffffc02005f0:	4705                	li	a4,1
ffffffffc02005f2:	bf75                	j	ffffffffc02005ae <cons_putc+0xe>

ffffffffc02005f4 <cons_getc>:
ffffffffc02005f4:	1101                	addi	sp,sp,-32
ffffffffc02005f6:	ec06                	sd	ra,24(sp)
ffffffffc02005f8:	100027f3          	csrr	a5,sstatus
ffffffffc02005fc:	8b89                	andi	a5,a5,2
ffffffffc02005fe:	4801                	li	a6,0
ffffffffc0200600:	e3d5                	bnez	a5,ffffffffc02006a4 <cons_getc+0xb0>
ffffffffc0200602:	00091697          	auipc	a3,0x91
ffffffffc0200606:	e5e68693          	addi	a3,a3,-418 # ffffffffc0291460 <cons>
ffffffffc020060a:	07f00713          	li	a4,127
ffffffffc020060e:	20000313          	li	t1,512
ffffffffc0200612:	a021                	j	ffffffffc020061a <cons_getc+0x26>
ffffffffc0200614:	0ff57513          	zext.b	a0,a0
ffffffffc0200618:	ef91                	bnez	a5,ffffffffc0200634 <cons_getc+0x40>
ffffffffc020061a:	4501                	li	a0,0
ffffffffc020061c:	4581                	li	a1,0
ffffffffc020061e:	4601                	li	a2,0
ffffffffc0200620:	4889                	li	a7,2
ffffffffc0200622:	00000073          	ecall
ffffffffc0200626:	0005079b          	sext.w	a5,a0
ffffffffc020062a:	0207c763          	bltz	a5,ffffffffc0200658 <cons_getc+0x64>
ffffffffc020062e:	fee793e3          	bne	a5,a4,ffffffffc0200614 <cons_getc+0x20>
ffffffffc0200632:	4521                	li	a0,8
ffffffffc0200634:	2046a783          	lw	a5,516(a3)
ffffffffc0200638:	02079613          	slli	a2,a5,0x20
ffffffffc020063c:	9201                	srli	a2,a2,0x20
ffffffffc020063e:	2785                	addiw	a5,a5,1
ffffffffc0200640:	9636                	add	a2,a2,a3
ffffffffc0200642:	20f6a223          	sw	a5,516(a3)
ffffffffc0200646:	00a60023          	sb	a0,0(a2)
ffffffffc020064a:	fc6798e3          	bne	a5,t1,ffffffffc020061a <cons_getc+0x26>
ffffffffc020064e:	00091797          	auipc	a5,0x91
ffffffffc0200652:	0007ab23          	sw	zero,22(a5) # ffffffffc0291664 <cons+0x204>
ffffffffc0200656:	b7d1                	j	ffffffffc020061a <cons_getc+0x26>
ffffffffc0200658:	2006a783          	lw	a5,512(a3)
ffffffffc020065c:	2046a703          	lw	a4,516(a3)
ffffffffc0200660:	4501                	li	a0,0
ffffffffc0200662:	00f70f63          	beq	a4,a5,ffffffffc0200680 <cons_getc+0x8c>
ffffffffc0200666:	0017861b          	addiw	a2,a5,1
ffffffffc020066a:	1782                	slli	a5,a5,0x20
ffffffffc020066c:	9381                	srli	a5,a5,0x20
ffffffffc020066e:	97b6                	add	a5,a5,a3
ffffffffc0200670:	20c6a023          	sw	a2,512(a3)
ffffffffc0200674:	20000713          	li	a4,512
ffffffffc0200678:	0007c503          	lbu	a0,0(a5)
ffffffffc020067c:	00e60763          	beq	a2,a4,ffffffffc020068a <cons_getc+0x96>
ffffffffc0200680:	00081b63          	bnez	a6,ffffffffc0200696 <cons_getc+0xa2>
ffffffffc0200684:	60e2                	ld	ra,24(sp)
ffffffffc0200686:	6105                	addi	sp,sp,32
ffffffffc0200688:	8082                	ret
ffffffffc020068a:	00091797          	auipc	a5,0x91
ffffffffc020068e:	fc07ab23          	sw	zero,-42(a5) # ffffffffc0291660 <cons+0x200>
ffffffffc0200692:	fe0809e3          	beqz	a6,ffffffffc0200684 <cons_getc+0x90>
ffffffffc0200696:	e42a                	sd	a0,8(sp)
ffffffffc0200698:	5d4000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020069c:	60e2                	ld	ra,24(sp)
ffffffffc020069e:	6522                	ld	a0,8(sp)
ffffffffc02006a0:	6105                	addi	sp,sp,32
ffffffffc02006a2:	8082                	ret
ffffffffc02006a4:	5ce000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02006a8:	4805                	li	a6,1
ffffffffc02006aa:	bfa1                	j	ffffffffc0200602 <cons_getc+0xe>

ffffffffc02006ac <dtb_init>:
ffffffffc02006ac:	7119                	addi	sp,sp,-128
ffffffffc02006ae:	0000b517          	auipc	a0,0xb
ffffffffc02006b2:	e6250513          	addi	a0,a0,-414 # ffffffffc020b510 <commands+0xa8>
ffffffffc02006b6:	fc86                	sd	ra,120(sp)
ffffffffc02006b8:	f8a2                	sd	s0,112(sp)
ffffffffc02006ba:	e8d2                	sd	s4,80(sp)
ffffffffc02006bc:	f4a6                	sd	s1,104(sp)
ffffffffc02006be:	f0ca                	sd	s2,96(sp)
ffffffffc02006c0:	ecce                	sd	s3,88(sp)
ffffffffc02006c2:	e4d6                	sd	s5,72(sp)
ffffffffc02006c4:	e0da                	sd	s6,64(sp)
ffffffffc02006c6:	fc5e                	sd	s7,56(sp)
ffffffffc02006c8:	f862                	sd	s8,48(sp)
ffffffffc02006ca:	f466                	sd	s9,40(sp)
ffffffffc02006cc:	f06a                	sd	s10,32(sp)
ffffffffc02006ce:	ec6e                	sd	s11,24(sp)
ffffffffc02006d0:	ad7ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006d4:	00014597          	auipc	a1,0x14
ffffffffc02006d8:	92c5b583          	ld	a1,-1748(a1) # ffffffffc0214000 <boot_hartid>
ffffffffc02006dc:	0000b517          	auipc	a0,0xb
ffffffffc02006e0:	e4450513          	addi	a0,a0,-444 # ffffffffc020b520 <commands+0xb8>
ffffffffc02006e4:	ac3ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006e8:	00014417          	auipc	s0,0x14
ffffffffc02006ec:	92040413          	addi	s0,s0,-1760 # ffffffffc0214008 <boot_dtb>
ffffffffc02006f0:	600c                	ld	a1,0(s0)
ffffffffc02006f2:	0000b517          	auipc	a0,0xb
ffffffffc02006f6:	e3e50513          	addi	a0,a0,-450 # ffffffffc020b530 <commands+0xc8>
ffffffffc02006fa:	aadff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006fe:	00043a03          	ld	s4,0(s0)
ffffffffc0200702:	0000b517          	auipc	a0,0xb
ffffffffc0200706:	e4650513          	addi	a0,a0,-442 # ffffffffc020b548 <commands+0xe0>
ffffffffc020070a:	120a0463          	beqz	s4,ffffffffc0200832 <dtb_init+0x186>
ffffffffc020070e:	57f5                	li	a5,-3
ffffffffc0200710:	07fa                	slli	a5,a5,0x1e
ffffffffc0200712:	00fa0733          	add	a4,s4,a5
ffffffffc0200716:	431c                	lw	a5,0(a4)
ffffffffc0200718:	00ff0637          	lui	a2,0xff0
ffffffffc020071c:	6b41                	lui	s6,0x10
ffffffffc020071e:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200722:	0187969b          	slliw	a3,a5,0x18
ffffffffc0200726:	0187d51b          	srliw	a0,a5,0x18
ffffffffc020072a:	0105959b          	slliw	a1,a1,0x10
ffffffffc020072e:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200732:	8df1                	and	a1,a1,a2
ffffffffc0200734:	8ec9                	or	a3,a3,a0
ffffffffc0200736:	0087979b          	slliw	a5,a5,0x8
ffffffffc020073a:	1b7d                	addi	s6,s6,-1
ffffffffc020073c:	0167f7b3          	and	a5,a5,s6
ffffffffc0200740:	8dd5                	or	a1,a1,a3
ffffffffc0200742:	8ddd                	or	a1,a1,a5
ffffffffc0200744:	d00e07b7          	lui	a5,0xd00e0
ffffffffc0200748:	2581                	sext.w	a1,a1
ffffffffc020074a:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfe495dd>
ffffffffc020074e:	10f59163          	bne	a1,a5,ffffffffc0200850 <dtb_init+0x1a4>
ffffffffc0200752:	471c                	lw	a5,8(a4)
ffffffffc0200754:	4754                	lw	a3,12(a4)
ffffffffc0200756:	4c81                	li	s9,0
ffffffffc0200758:	0087d59b          	srliw	a1,a5,0x8
ffffffffc020075c:	0086d51b          	srliw	a0,a3,0x8
ffffffffc0200760:	0186941b          	slliw	s0,a3,0x18
ffffffffc0200764:	0186d89b          	srliw	a7,a3,0x18
ffffffffc0200768:	01879a1b          	slliw	s4,a5,0x18
ffffffffc020076c:	0187d81b          	srliw	a6,a5,0x18
ffffffffc0200770:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200774:	0106d69b          	srliw	a3,a3,0x10
ffffffffc0200778:	0105959b          	slliw	a1,a1,0x10
ffffffffc020077c:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200780:	8d71                	and	a0,a0,a2
ffffffffc0200782:	01146433          	or	s0,s0,a7
ffffffffc0200786:	0086969b          	slliw	a3,a3,0x8
ffffffffc020078a:	010a6a33          	or	s4,s4,a6
ffffffffc020078e:	8e6d                	and	a2,a2,a1
ffffffffc0200790:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200794:	8c49                	or	s0,s0,a0
ffffffffc0200796:	0166f6b3          	and	a3,a3,s6
ffffffffc020079a:	00ca6a33          	or	s4,s4,a2
ffffffffc020079e:	0167f7b3          	and	a5,a5,s6
ffffffffc02007a2:	8c55                	or	s0,s0,a3
ffffffffc02007a4:	00fa6a33          	or	s4,s4,a5
ffffffffc02007a8:	1402                	slli	s0,s0,0x20
ffffffffc02007aa:	1a02                	slli	s4,s4,0x20
ffffffffc02007ac:	9001                	srli	s0,s0,0x20
ffffffffc02007ae:	020a5a13          	srli	s4,s4,0x20
ffffffffc02007b2:	943a                	add	s0,s0,a4
ffffffffc02007b4:	9a3a                	add	s4,s4,a4
ffffffffc02007b6:	00ff0c37          	lui	s8,0xff0
ffffffffc02007ba:	4b8d                	li	s7,3
ffffffffc02007bc:	0000b917          	auipc	s2,0xb
ffffffffc02007c0:	ddc90913          	addi	s2,s2,-548 # ffffffffc020b598 <commands+0x130>
ffffffffc02007c4:	49bd                	li	s3,15
ffffffffc02007c6:	4d91                	li	s11,4
ffffffffc02007c8:	4d05                	li	s10,1
ffffffffc02007ca:	0000b497          	auipc	s1,0xb
ffffffffc02007ce:	dc648493          	addi	s1,s1,-570 # ffffffffc020b590 <commands+0x128>
ffffffffc02007d2:	000a2703          	lw	a4,0(s4)
ffffffffc02007d6:	004a0a93          	addi	s5,s4,4
ffffffffc02007da:	0087569b          	srliw	a3,a4,0x8
ffffffffc02007de:	0187179b          	slliw	a5,a4,0x18
ffffffffc02007e2:	0187561b          	srliw	a2,a4,0x18
ffffffffc02007e6:	0106969b          	slliw	a3,a3,0x10
ffffffffc02007ea:	0107571b          	srliw	a4,a4,0x10
ffffffffc02007ee:	8fd1                	or	a5,a5,a2
ffffffffc02007f0:	0186f6b3          	and	a3,a3,s8
ffffffffc02007f4:	0087171b          	slliw	a4,a4,0x8
ffffffffc02007f8:	8fd5                	or	a5,a5,a3
ffffffffc02007fa:	00eb7733          	and	a4,s6,a4
ffffffffc02007fe:	8fd9                	or	a5,a5,a4
ffffffffc0200800:	2781                	sext.w	a5,a5
ffffffffc0200802:	09778c63          	beq	a5,s7,ffffffffc020089a <dtb_init+0x1ee>
ffffffffc0200806:	00fbea63          	bltu	s7,a5,ffffffffc020081a <dtb_init+0x16e>
ffffffffc020080a:	07a78663          	beq	a5,s10,ffffffffc0200876 <dtb_init+0x1ca>
ffffffffc020080e:	4709                	li	a4,2
ffffffffc0200810:	00e79763          	bne	a5,a4,ffffffffc020081e <dtb_init+0x172>
ffffffffc0200814:	4c81                	li	s9,0
ffffffffc0200816:	8a56                	mv	s4,s5
ffffffffc0200818:	bf6d                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc020081a:	ffb78ee3          	beq	a5,s11,ffffffffc0200816 <dtb_init+0x16a>
ffffffffc020081e:	0000b517          	auipc	a0,0xb
ffffffffc0200822:	df250513          	addi	a0,a0,-526 # ffffffffc020b610 <commands+0x1a8>
ffffffffc0200826:	981ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020082a:	0000b517          	auipc	a0,0xb
ffffffffc020082e:	e1e50513          	addi	a0,a0,-482 # ffffffffc020b648 <commands+0x1e0>
ffffffffc0200832:	7446                	ld	s0,112(sp)
ffffffffc0200834:	70e6                	ld	ra,120(sp)
ffffffffc0200836:	74a6                	ld	s1,104(sp)
ffffffffc0200838:	7906                	ld	s2,96(sp)
ffffffffc020083a:	69e6                	ld	s3,88(sp)
ffffffffc020083c:	6a46                	ld	s4,80(sp)
ffffffffc020083e:	6aa6                	ld	s5,72(sp)
ffffffffc0200840:	6b06                	ld	s6,64(sp)
ffffffffc0200842:	7be2                	ld	s7,56(sp)
ffffffffc0200844:	7c42                	ld	s8,48(sp)
ffffffffc0200846:	7ca2                	ld	s9,40(sp)
ffffffffc0200848:	7d02                	ld	s10,32(sp)
ffffffffc020084a:	6de2                	ld	s11,24(sp)
ffffffffc020084c:	6109                	addi	sp,sp,128
ffffffffc020084e:	baa1                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200850:	7446                	ld	s0,112(sp)
ffffffffc0200852:	70e6                	ld	ra,120(sp)
ffffffffc0200854:	74a6                	ld	s1,104(sp)
ffffffffc0200856:	7906                	ld	s2,96(sp)
ffffffffc0200858:	69e6                	ld	s3,88(sp)
ffffffffc020085a:	6a46                	ld	s4,80(sp)
ffffffffc020085c:	6aa6                	ld	s5,72(sp)
ffffffffc020085e:	6b06                	ld	s6,64(sp)
ffffffffc0200860:	7be2                	ld	s7,56(sp)
ffffffffc0200862:	7c42                	ld	s8,48(sp)
ffffffffc0200864:	7ca2                	ld	s9,40(sp)
ffffffffc0200866:	7d02                	ld	s10,32(sp)
ffffffffc0200868:	6de2                	ld	s11,24(sp)
ffffffffc020086a:	0000b517          	auipc	a0,0xb
ffffffffc020086e:	cfe50513          	addi	a0,a0,-770 # ffffffffc020b568 <commands+0x100>
ffffffffc0200872:	6109                	addi	sp,sp,128
ffffffffc0200874:	ba0d                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200876:	8556                	mv	a0,s5
ffffffffc0200878:	07b0a0ef          	jal	ra,ffffffffc020b0f2 <strlen>
ffffffffc020087c:	8a2a                	mv	s4,a0
ffffffffc020087e:	4619                	li	a2,6
ffffffffc0200880:	85a6                	mv	a1,s1
ffffffffc0200882:	8556                	mv	a0,s5
ffffffffc0200884:	2a01                	sext.w	s4,s4
ffffffffc0200886:	0d30a0ef          	jal	ra,ffffffffc020b158 <strncmp>
ffffffffc020088a:	e111                	bnez	a0,ffffffffc020088e <dtb_init+0x1e2>
ffffffffc020088c:	4c85                	li	s9,1
ffffffffc020088e:	0a91                	addi	s5,s5,4
ffffffffc0200890:	9ad2                	add	s5,s5,s4
ffffffffc0200892:	ffcafa93          	andi	s5,s5,-4
ffffffffc0200896:	8a56                	mv	s4,s5
ffffffffc0200898:	bf2d                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc020089a:	004a2783          	lw	a5,4(s4)
ffffffffc020089e:	00ca0693          	addi	a3,s4,12
ffffffffc02008a2:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02008a6:	01879a9b          	slliw	s5,a5,0x18
ffffffffc02008aa:	0187d61b          	srliw	a2,a5,0x18
ffffffffc02008ae:	0107171b          	slliw	a4,a4,0x10
ffffffffc02008b2:	0107d79b          	srliw	a5,a5,0x10
ffffffffc02008b6:	00caeab3          	or	s5,s5,a2
ffffffffc02008ba:	01877733          	and	a4,a4,s8
ffffffffc02008be:	0087979b          	slliw	a5,a5,0x8
ffffffffc02008c2:	00eaeab3          	or	s5,s5,a4
ffffffffc02008c6:	00fb77b3          	and	a5,s6,a5
ffffffffc02008ca:	00faeab3          	or	s5,s5,a5
ffffffffc02008ce:	2a81                	sext.w	s5,s5
ffffffffc02008d0:	000c9c63          	bnez	s9,ffffffffc02008e8 <dtb_init+0x23c>
ffffffffc02008d4:	1a82                	slli	s5,s5,0x20
ffffffffc02008d6:	00368793          	addi	a5,a3,3
ffffffffc02008da:	020ada93          	srli	s5,s5,0x20
ffffffffc02008de:	9abe                	add	s5,s5,a5
ffffffffc02008e0:	ffcafa93          	andi	s5,s5,-4
ffffffffc02008e4:	8a56                	mv	s4,s5
ffffffffc02008e6:	b5f5                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc02008e8:	008a2783          	lw	a5,8(s4)
ffffffffc02008ec:	85ca                	mv	a1,s2
ffffffffc02008ee:	e436                	sd	a3,8(sp)
ffffffffc02008f0:	0087d51b          	srliw	a0,a5,0x8
ffffffffc02008f4:	0187d61b          	srliw	a2,a5,0x18
ffffffffc02008f8:	0187971b          	slliw	a4,a5,0x18
ffffffffc02008fc:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200900:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200904:	8f51                	or	a4,a4,a2
ffffffffc0200906:	01857533          	and	a0,a0,s8
ffffffffc020090a:	0087979b          	slliw	a5,a5,0x8
ffffffffc020090e:	8d59                	or	a0,a0,a4
ffffffffc0200910:	00fb77b3          	and	a5,s6,a5
ffffffffc0200914:	8d5d                	or	a0,a0,a5
ffffffffc0200916:	1502                	slli	a0,a0,0x20
ffffffffc0200918:	9101                	srli	a0,a0,0x20
ffffffffc020091a:	9522                	add	a0,a0,s0
ffffffffc020091c:	01f0a0ef          	jal	ra,ffffffffc020b13a <strcmp>
ffffffffc0200920:	66a2                	ld	a3,8(sp)
ffffffffc0200922:	f94d                	bnez	a0,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200924:	fb59f8e3          	bgeu	s3,s5,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200928:	00ca3783          	ld	a5,12(s4)
ffffffffc020092c:	014a3703          	ld	a4,20(s4)
ffffffffc0200930:	0000b517          	auipc	a0,0xb
ffffffffc0200934:	c7050513          	addi	a0,a0,-912 # ffffffffc020b5a0 <commands+0x138>
ffffffffc0200938:	4207d613          	srai	a2,a5,0x20
ffffffffc020093c:	0087d31b          	srliw	t1,a5,0x8
ffffffffc0200940:	42075593          	srai	a1,a4,0x20
ffffffffc0200944:	0187de1b          	srliw	t3,a5,0x18
ffffffffc0200948:	0186581b          	srliw	a6,a2,0x18
ffffffffc020094c:	0187941b          	slliw	s0,a5,0x18
ffffffffc0200950:	0107d89b          	srliw	a7,a5,0x10
ffffffffc0200954:	0187d693          	srli	a3,a5,0x18
ffffffffc0200958:	01861f1b          	slliw	t5,a2,0x18
ffffffffc020095c:	0087579b          	srliw	a5,a4,0x8
ffffffffc0200960:	0103131b          	slliw	t1,t1,0x10
ffffffffc0200964:	0106561b          	srliw	a2,a2,0x10
ffffffffc0200968:	010f6f33          	or	t5,t5,a6
ffffffffc020096c:	0187529b          	srliw	t0,a4,0x18
ffffffffc0200970:	0185df9b          	srliw	t6,a1,0x18
ffffffffc0200974:	01837333          	and	t1,t1,s8
ffffffffc0200978:	01c46433          	or	s0,s0,t3
ffffffffc020097c:	0186f6b3          	and	a3,a3,s8
ffffffffc0200980:	01859e1b          	slliw	t3,a1,0x18
ffffffffc0200984:	01871e9b          	slliw	t4,a4,0x18
ffffffffc0200988:	0107581b          	srliw	a6,a4,0x10
ffffffffc020098c:	0086161b          	slliw	a2,a2,0x8
ffffffffc0200990:	8361                	srli	a4,a4,0x18
ffffffffc0200992:	0107979b          	slliw	a5,a5,0x10
ffffffffc0200996:	0105d59b          	srliw	a1,a1,0x10
ffffffffc020099a:	01e6e6b3          	or	a3,a3,t5
ffffffffc020099e:	00cb7633          	and	a2,s6,a2
ffffffffc02009a2:	0088181b          	slliw	a6,a6,0x8
ffffffffc02009a6:	0085959b          	slliw	a1,a1,0x8
ffffffffc02009aa:	00646433          	or	s0,s0,t1
ffffffffc02009ae:	0187f7b3          	and	a5,a5,s8
ffffffffc02009b2:	01fe6333          	or	t1,t3,t6
ffffffffc02009b6:	01877c33          	and	s8,a4,s8
ffffffffc02009ba:	0088989b          	slliw	a7,a7,0x8
ffffffffc02009be:	011b78b3          	and	a7,s6,a7
ffffffffc02009c2:	005eeeb3          	or	t4,t4,t0
ffffffffc02009c6:	00c6e733          	or	a4,a3,a2
ffffffffc02009ca:	006c6c33          	or	s8,s8,t1
ffffffffc02009ce:	010b76b3          	and	a3,s6,a6
ffffffffc02009d2:	00bb7b33          	and	s6,s6,a1
ffffffffc02009d6:	01d7e7b3          	or	a5,a5,t4
ffffffffc02009da:	016c6b33          	or	s6,s8,s6
ffffffffc02009de:	01146433          	or	s0,s0,a7
ffffffffc02009e2:	8fd5                	or	a5,a5,a3
ffffffffc02009e4:	1702                	slli	a4,a4,0x20
ffffffffc02009e6:	1b02                	slli	s6,s6,0x20
ffffffffc02009e8:	1782                	slli	a5,a5,0x20
ffffffffc02009ea:	9301                	srli	a4,a4,0x20
ffffffffc02009ec:	1402                	slli	s0,s0,0x20
ffffffffc02009ee:	020b5b13          	srli	s6,s6,0x20
ffffffffc02009f2:	0167eb33          	or	s6,a5,s6
ffffffffc02009f6:	8c59                	or	s0,s0,a4
ffffffffc02009f8:	faeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02009fc:	85a2                	mv	a1,s0
ffffffffc02009fe:	0000b517          	auipc	a0,0xb
ffffffffc0200a02:	bc250513          	addi	a0,a0,-1086 # ffffffffc020b5c0 <commands+0x158>
ffffffffc0200a06:	fa0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a0a:	014b5613          	srli	a2,s6,0x14
ffffffffc0200a0e:	85da                	mv	a1,s6
ffffffffc0200a10:	0000b517          	auipc	a0,0xb
ffffffffc0200a14:	bc850513          	addi	a0,a0,-1080 # ffffffffc020b5d8 <commands+0x170>
ffffffffc0200a18:	f8eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a1c:	008b05b3          	add	a1,s6,s0
ffffffffc0200a20:	15fd                	addi	a1,a1,-1
ffffffffc0200a22:	0000b517          	auipc	a0,0xb
ffffffffc0200a26:	bd650513          	addi	a0,a0,-1066 # ffffffffc020b5f8 <commands+0x190>
ffffffffc0200a2a:	f7cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a2e:	0000b517          	auipc	a0,0xb
ffffffffc0200a32:	c1a50513          	addi	a0,a0,-998 # ffffffffc020b648 <commands+0x1e0>
ffffffffc0200a36:	00096797          	auipc	a5,0x96
ffffffffc0200a3a:	e487b123          	sd	s0,-446(a5) # ffffffffc0296878 <memory_base>
ffffffffc0200a3e:	00096797          	auipc	a5,0x96
ffffffffc0200a42:	e567b123          	sd	s6,-446(a5) # ffffffffc0296880 <memory_size>
ffffffffc0200a46:	b3f5                	j	ffffffffc0200832 <dtb_init+0x186>

ffffffffc0200a48 <get_memory_base>:
ffffffffc0200a48:	00096517          	auipc	a0,0x96
ffffffffc0200a4c:	e3053503          	ld	a0,-464(a0) # ffffffffc0296878 <memory_base>
ffffffffc0200a50:	8082                	ret

ffffffffc0200a52 <get_memory_size>:
ffffffffc0200a52:	00096517          	auipc	a0,0x96
ffffffffc0200a56:	e2e53503          	ld	a0,-466(a0) # ffffffffc0296880 <memory_size>
ffffffffc0200a5a:	8082                	ret

ffffffffc0200a5c <ide_init>:
ffffffffc0200a5c:	1141                	addi	sp,sp,-16
ffffffffc0200a5e:	00091597          	auipc	a1,0x91
ffffffffc0200a62:	c5a58593          	addi	a1,a1,-934 # ffffffffc02916b8 <ide_devices+0x50>
ffffffffc0200a66:	4505                	li	a0,1
ffffffffc0200a68:	e022                	sd	s0,0(sp)
ffffffffc0200a6a:	00091797          	auipc	a5,0x91
ffffffffc0200a6e:	be07af23          	sw	zero,-1026(a5) # ffffffffc0291668 <ide_devices>
ffffffffc0200a72:	00091797          	auipc	a5,0x91
ffffffffc0200a76:	c407a323          	sw	zero,-954(a5) # ffffffffc02916b8 <ide_devices+0x50>
ffffffffc0200a7a:	00091797          	auipc	a5,0x91
ffffffffc0200a7e:	c807a723          	sw	zero,-882(a5) # ffffffffc0291708 <ide_devices+0xa0>
ffffffffc0200a82:	00091797          	auipc	a5,0x91
ffffffffc0200a86:	cc07ab23          	sw	zero,-810(a5) # ffffffffc0291758 <ide_devices+0xf0>
ffffffffc0200a8a:	e406                	sd	ra,8(sp)
ffffffffc0200a8c:	00091417          	auipc	s0,0x91
ffffffffc0200a90:	bdc40413          	addi	s0,s0,-1060 # ffffffffc0291668 <ide_devices>
ffffffffc0200a94:	23a000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200a98:	483c                	lw	a5,80(s0)
ffffffffc0200a9a:	cf99                	beqz	a5,ffffffffc0200ab8 <ide_init+0x5c>
ffffffffc0200a9c:	00091597          	auipc	a1,0x91
ffffffffc0200aa0:	c6c58593          	addi	a1,a1,-916 # ffffffffc0291708 <ide_devices+0xa0>
ffffffffc0200aa4:	4509                	li	a0,2
ffffffffc0200aa6:	228000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200aaa:	0a042783          	lw	a5,160(s0)
ffffffffc0200aae:	c785                	beqz	a5,ffffffffc0200ad6 <ide_init+0x7a>
ffffffffc0200ab0:	60a2                	ld	ra,8(sp)
ffffffffc0200ab2:	6402                	ld	s0,0(sp)
ffffffffc0200ab4:	0141                	addi	sp,sp,16
ffffffffc0200ab6:	8082                	ret
ffffffffc0200ab8:	0000b697          	auipc	a3,0xb
ffffffffc0200abc:	ba868693          	addi	a3,a3,-1112 # ffffffffc020b660 <commands+0x1f8>
ffffffffc0200ac0:	0000b617          	auipc	a2,0xb
ffffffffc0200ac4:	bb860613          	addi	a2,a2,-1096 # ffffffffc020b678 <commands+0x210>
ffffffffc0200ac8:	45c5                	li	a1,17
ffffffffc0200aca:	0000b517          	auipc	a0,0xb
ffffffffc0200ace:	bc650513          	addi	a0,a0,-1082 # ffffffffc020b690 <commands+0x228>
ffffffffc0200ad2:	9cdff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200ad6:	0000b697          	auipc	a3,0xb
ffffffffc0200ada:	bd268693          	addi	a3,a3,-1070 # ffffffffc020b6a8 <commands+0x240>
ffffffffc0200ade:	0000b617          	auipc	a2,0xb
ffffffffc0200ae2:	b9a60613          	addi	a2,a2,-1126 # ffffffffc020b678 <commands+0x210>
ffffffffc0200ae6:	45d1                	li	a1,20
ffffffffc0200ae8:	0000b517          	auipc	a0,0xb
ffffffffc0200aec:	ba850513          	addi	a0,a0,-1112 # ffffffffc020b690 <commands+0x228>
ffffffffc0200af0:	9afff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200af4 <ide_device_valid>:
ffffffffc0200af4:	478d                	li	a5,3
ffffffffc0200af6:	00a7ef63          	bltu	a5,a0,ffffffffc0200b14 <ide_device_valid+0x20>
ffffffffc0200afa:	00251793          	slli	a5,a0,0x2
ffffffffc0200afe:	953e                	add	a0,a0,a5
ffffffffc0200b00:	0512                	slli	a0,a0,0x4
ffffffffc0200b02:	00091797          	auipc	a5,0x91
ffffffffc0200b06:	b6678793          	addi	a5,a5,-1178 # ffffffffc0291668 <ide_devices>
ffffffffc0200b0a:	953e                	add	a0,a0,a5
ffffffffc0200b0c:	4108                	lw	a0,0(a0)
ffffffffc0200b0e:	00a03533          	snez	a0,a0
ffffffffc0200b12:	8082                	ret
ffffffffc0200b14:	4501                	li	a0,0
ffffffffc0200b16:	8082                	ret

ffffffffc0200b18 <ide_device_size>:
ffffffffc0200b18:	478d                	li	a5,3
ffffffffc0200b1a:	02a7e163          	bltu	a5,a0,ffffffffc0200b3c <ide_device_size+0x24>
ffffffffc0200b1e:	00251793          	slli	a5,a0,0x2
ffffffffc0200b22:	953e                	add	a0,a0,a5
ffffffffc0200b24:	0512                	slli	a0,a0,0x4
ffffffffc0200b26:	00091797          	auipc	a5,0x91
ffffffffc0200b2a:	b4278793          	addi	a5,a5,-1214 # ffffffffc0291668 <ide_devices>
ffffffffc0200b2e:	97aa                	add	a5,a5,a0
ffffffffc0200b30:	4398                	lw	a4,0(a5)
ffffffffc0200b32:	4501                	li	a0,0
ffffffffc0200b34:	c709                	beqz	a4,ffffffffc0200b3e <ide_device_size+0x26>
ffffffffc0200b36:	0087e503          	lwu	a0,8(a5)
ffffffffc0200b3a:	8082                	ret
ffffffffc0200b3c:	4501                	li	a0,0
ffffffffc0200b3e:	8082                	ret

ffffffffc0200b40 <ide_read_secs>:
ffffffffc0200b40:	1141                	addi	sp,sp,-16
ffffffffc0200b42:	e406                	sd	ra,8(sp)
ffffffffc0200b44:	08000793          	li	a5,128
ffffffffc0200b48:	04d7e763          	bltu	a5,a3,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b4c:	478d                	li	a5,3
ffffffffc0200b4e:	0005081b          	sext.w	a6,a0
ffffffffc0200b52:	04a7e263          	bltu	a5,a0,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b56:	00281793          	slli	a5,a6,0x2
ffffffffc0200b5a:	97c2                	add	a5,a5,a6
ffffffffc0200b5c:	0792                	slli	a5,a5,0x4
ffffffffc0200b5e:	00091817          	auipc	a6,0x91
ffffffffc0200b62:	b0a80813          	addi	a6,a6,-1270 # ffffffffc0291668 <ide_devices>
ffffffffc0200b66:	97c2                	add	a5,a5,a6
ffffffffc0200b68:	0007a883          	lw	a7,0(a5)
ffffffffc0200b6c:	02088563          	beqz	a7,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b70:	100008b7          	lui	a7,0x10000
ffffffffc0200b74:	0515f163          	bgeu	a1,a7,ffffffffc0200bb6 <ide_read_secs+0x76>
ffffffffc0200b78:	1582                	slli	a1,a1,0x20
ffffffffc0200b7a:	9181                	srli	a1,a1,0x20
ffffffffc0200b7c:	00d58733          	add	a4,a1,a3
ffffffffc0200b80:	02e8eb63          	bltu	a7,a4,ffffffffc0200bb6 <ide_read_secs+0x76>
ffffffffc0200b84:	00251713          	slli	a4,a0,0x2
ffffffffc0200b88:	60a2                	ld	ra,8(sp)
ffffffffc0200b8a:	63bc                	ld	a5,64(a5)
ffffffffc0200b8c:	953a                	add	a0,a0,a4
ffffffffc0200b8e:	0512                	slli	a0,a0,0x4
ffffffffc0200b90:	9542                	add	a0,a0,a6
ffffffffc0200b92:	0141                	addi	sp,sp,16
ffffffffc0200b94:	8782                	jr	a5
ffffffffc0200b96:	0000b697          	auipc	a3,0xb
ffffffffc0200b9a:	b2a68693          	addi	a3,a3,-1238 # ffffffffc020b6c0 <commands+0x258>
ffffffffc0200b9e:	0000b617          	auipc	a2,0xb
ffffffffc0200ba2:	ada60613          	addi	a2,a2,-1318 # ffffffffc020b678 <commands+0x210>
ffffffffc0200ba6:	02200593          	li	a1,34
ffffffffc0200baa:	0000b517          	auipc	a0,0xb
ffffffffc0200bae:	ae650513          	addi	a0,a0,-1306 # ffffffffc020b690 <commands+0x228>
ffffffffc0200bb2:	8edff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200bb6:	0000b697          	auipc	a3,0xb
ffffffffc0200bba:	b3268693          	addi	a3,a3,-1230 # ffffffffc020b6e8 <commands+0x280>
ffffffffc0200bbe:	0000b617          	auipc	a2,0xb
ffffffffc0200bc2:	aba60613          	addi	a2,a2,-1350 # ffffffffc020b678 <commands+0x210>
ffffffffc0200bc6:	02300593          	li	a1,35
ffffffffc0200bca:	0000b517          	auipc	a0,0xb
ffffffffc0200bce:	ac650513          	addi	a0,a0,-1338 # ffffffffc020b690 <commands+0x228>
ffffffffc0200bd2:	8cdff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200bd6 <ide_write_secs>:
ffffffffc0200bd6:	1141                	addi	sp,sp,-16
ffffffffc0200bd8:	e406                	sd	ra,8(sp)
ffffffffc0200bda:	08000793          	li	a5,128
ffffffffc0200bde:	04d7e763          	bltu	a5,a3,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200be2:	478d                	li	a5,3
ffffffffc0200be4:	0005081b          	sext.w	a6,a0
ffffffffc0200be8:	04a7e263          	bltu	a5,a0,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200bec:	00281793          	slli	a5,a6,0x2
ffffffffc0200bf0:	97c2                	add	a5,a5,a6
ffffffffc0200bf2:	0792                	slli	a5,a5,0x4
ffffffffc0200bf4:	00091817          	auipc	a6,0x91
ffffffffc0200bf8:	a7480813          	addi	a6,a6,-1420 # ffffffffc0291668 <ide_devices>
ffffffffc0200bfc:	97c2                	add	a5,a5,a6
ffffffffc0200bfe:	0007a883          	lw	a7,0(a5)
ffffffffc0200c02:	02088563          	beqz	a7,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200c06:	100008b7          	lui	a7,0x10000
ffffffffc0200c0a:	0515f163          	bgeu	a1,a7,ffffffffc0200c4c <ide_write_secs+0x76>
ffffffffc0200c0e:	1582                	slli	a1,a1,0x20
ffffffffc0200c10:	9181                	srli	a1,a1,0x20
ffffffffc0200c12:	00d58733          	add	a4,a1,a3
ffffffffc0200c16:	02e8eb63          	bltu	a7,a4,ffffffffc0200c4c <ide_write_secs+0x76>
ffffffffc0200c1a:	00251713          	slli	a4,a0,0x2
ffffffffc0200c1e:	60a2                	ld	ra,8(sp)
ffffffffc0200c20:	67bc                	ld	a5,72(a5)
ffffffffc0200c22:	953a                	add	a0,a0,a4
ffffffffc0200c24:	0512                	slli	a0,a0,0x4
ffffffffc0200c26:	9542                	add	a0,a0,a6
ffffffffc0200c28:	0141                	addi	sp,sp,16
ffffffffc0200c2a:	8782                	jr	a5
ffffffffc0200c2c:	0000b697          	auipc	a3,0xb
ffffffffc0200c30:	a9468693          	addi	a3,a3,-1388 # ffffffffc020b6c0 <commands+0x258>
ffffffffc0200c34:	0000b617          	auipc	a2,0xb
ffffffffc0200c38:	a4460613          	addi	a2,a2,-1468 # ffffffffc020b678 <commands+0x210>
ffffffffc0200c3c:	02900593          	li	a1,41
ffffffffc0200c40:	0000b517          	auipc	a0,0xb
ffffffffc0200c44:	a5050513          	addi	a0,a0,-1456 # ffffffffc020b690 <commands+0x228>
ffffffffc0200c48:	857ff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200c4c:	0000b697          	auipc	a3,0xb
ffffffffc0200c50:	a9c68693          	addi	a3,a3,-1380 # ffffffffc020b6e8 <commands+0x280>
ffffffffc0200c54:	0000b617          	auipc	a2,0xb
ffffffffc0200c58:	a2460613          	addi	a2,a2,-1500 # ffffffffc020b678 <commands+0x210>
ffffffffc0200c5c:	02a00593          	li	a1,42
ffffffffc0200c60:	0000b517          	auipc	a0,0xb
ffffffffc0200c64:	a3050513          	addi	a0,a0,-1488 # ffffffffc020b690 <commands+0x228>
ffffffffc0200c68:	837ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200c6c <intr_enable>:
ffffffffc0200c6c:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200c70:	8082                	ret

ffffffffc0200c72 <intr_disable>:
ffffffffc0200c72:	100177f3          	csrrci	a5,sstatus,2
ffffffffc0200c76:	8082                	ret

ffffffffc0200c78 <pic_init>:
ffffffffc0200c78:	8082                	ret

ffffffffc0200c7a <ramdisk_write>:
ffffffffc0200c7a:	00856703          	lwu	a4,8(a0)
ffffffffc0200c7e:	1141                	addi	sp,sp,-16
ffffffffc0200c80:	e406                	sd	ra,8(sp)
ffffffffc0200c82:	8f0d                	sub	a4,a4,a1
ffffffffc0200c84:	87ae                	mv	a5,a1
ffffffffc0200c86:	85b2                	mv	a1,a2
ffffffffc0200c88:	00e6f363          	bgeu	a3,a4,ffffffffc0200c8e <ramdisk_write+0x14>
ffffffffc0200c8c:	8736                	mv	a4,a3
ffffffffc0200c8e:	6908                	ld	a0,16(a0)
ffffffffc0200c90:	07a6                	slli	a5,a5,0x9
ffffffffc0200c92:	00971613          	slli	a2,a4,0x9
ffffffffc0200c96:	953e                	add	a0,a0,a5
ffffffffc0200c98:	54e0a0ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc0200c9c:	60a2                	ld	ra,8(sp)
ffffffffc0200c9e:	4501                	li	a0,0
ffffffffc0200ca0:	0141                	addi	sp,sp,16
ffffffffc0200ca2:	8082                	ret

ffffffffc0200ca4 <ramdisk_read>:
ffffffffc0200ca4:	00856783          	lwu	a5,8(a0)
ffffffffc0200ca8:	1141                	addi	sp,sp,-16
ffffffffc0200caa:	e406                	sd	ra,8(sp)
ffffffffc0200cac:	8f8d                	sub	a5,a5,a1
ffffffffc0200cae:	872a                	mv	a4,a0
ffffffffc0200cb0:	8532                	mv	a0,a2
ffffffffc0200cb2:	00f6f363          	bgeu	a3,a5,ffffffffc0200cb8 <ramdisk_read+0x14>
ffffffffc0200cb6:	87b6                	mv	a5,a3
ffffffffc0200cb8:	6b18                	ld	a4,16(a4)
ffffffffc0200cba:	05a6                	slli	a1,a1,0x9
ffffffffc0200cbc:	00979613          	slli	a2,a5,0x9
ffffffffc0200cc0:	95ba                	add	a1,a1,a4
ffffffffc0200cc2:	5240a0ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc0200cc6:	60a2                	ld	ra,8(sp)
ffffffffc0200cc8:	4501                	li	a0,0
ffffffffc0200cca:	0141                	addi	sp,sp,16
ffffffffc0200ccc:	8082                	ret

ffffffffc0200cce <ramdisk_init>:
ffffffffc0200cce:	1101                	addi	sp,sp,-32
ffffffffc0200cd0:	e822                	sd	s0,16(sp)
ffffffffc0200cd2:	842e                	mv	s0,a1
ffffffffc0200cd4:	e426                	sd	s1,8(sp)
ffffffffc0200cd6:	05000613          	li	a2,80
ffffffffc0200cda:	84aa                	mv	s1,a0
ffffffffc0200cdc:	4581                	li	a1,0
ffffffffc0200cde:	8522                	mv	a0,s0
ffffffffc0200ce0:	ec06                	sd	ra,24(sp)
ffffffffc0200ce2:	e04a                	sd	s2,0(sp)
ffffffffc0200ce4:	4b00a0ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc0200ce8:	4785                	li	a5,1
ffffffffc0200cea:	06f48b63          	beq	s1,a5,ffffffffc0200d60 <ramdisk_init+0x92>
ffffffffc0200cee:	4789                	li	a5,2
ffffffffc0200cf0:	00090617          	auipc	a2,0x90
ffffffffc0200cf4:	32060613          	addi	a2,a2,800 # ffffffffc0291010 <arena>
ffffffffc0200cf8:	0001b917          	auipc	s2,0x1b
ffffffffc0200cfc:	01890913          	addi	s2,s2,24 # ffffffffc021bd10 <_binary_bin_sfs_img_start>
ffffffffc0200d00:	08f49563          	bne	s1,a5,ffffffffc0200d8a <ramdisk_init+0xbc>
ffffffffc0200d04:	06c90863          	beq	s2,a2,ffffffffc0200d74 <ramdisk_init+0xa6>
ffffffffc0200d08:	412604b3          	sub	s1,a2,s2
ffffffffc0200d0c:	86a6                	mv	a3,s1
ffffffffc0200d0e:	85ca                	mv	a1,s2
ffffffffc0200d10:	167d                	addi	a2,a2,-1
ffffffffc0200d12:	0000b517          	auipc	a0,0xb
ffffffffc0200d16:	a2e50513          	addi	a0,a0,-1490 # ffffffffc020b740 <commands+0x2d8>
ffffffffc0200d1a:	c8cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200d1e:	57fd                	li	a5,-1
ffffffffc0200d20:	1782                	slli	a5,a5,0x20
ffffffffc0200d22:	0785                	addi	a5,a5,1
ffffffffc0200d24:	0094d49b          	srliw	s1,s1,0x9
ffffffffc0200d28:	e01c                	sd	a5,0(s0)
ffffffffc0200d2a:	c404                	sw	s1,8(s0)
ffffffffc0200d2c:	01243823          	sd	s2,16(s0)
ffffffffc0200d30:	02040513          	addi	a0,s0,32
ffffffffc0200d34:	0000b597          	auipc	a1,0xb
ffffffffc0200d38:	a6458593          	addi	a1,a1,-1436 # ffffffffc020b798 <commands+0x330>
ffffffffc0200d3c:	3ec0a0ef          	jal	ra,ffffffffc020b128 <strcpy>
ffffffffc0200d40:	00000797          	auipc	a5,0x0
ffffffffc0200d44:	f6478793          	addi	a5,a5,-156 # ffffffffc0200ca4 <ramdisk_read>
ffffffffc0200d48:	e03c                	sd	a5,64(s0)
ffffffffc0200d4a:	00000797          	auipc	a5,0x0
ffffffffc0200d4e:	f3078793          	addi	a5,a5,-208 # ffffffffc0200c7a <ramdisk_write>
ffffffffc0200d52:	60e2                	ld	ra,24(sp)
ffffffffc0200d54:	e43c                	sd	a5,72(s0)
ffffffffc0200d56:	6442                	ld	s0,16(sp)
ffffffffc0200d58:	64a2                	ld	s1,8(sp)
ffffffffc0200d5a:	6902                	ld	s2,0(sp)
ffffffffc0200d5c:	6105                	addi	sp,sp,32
ffffffffc0200d5e:	8082                	ret
ffffffffc0200d60:	0001b617          	auipc	a2,0x1b
ffffffffc0200d64:	fb060613          	addi	a2,a2,-80 # ffffffffc021bd10 <_binary_bin_sfs_img_start>
ffffffffc0200d68:	00013917          	auipc	s2,0x13
ffffffffc0200d6c:	2a890913          	addi	s2,s2,680 # ffffffffc0214010 <_binary_bin_swap_img_start>
ffffffffc0200d70:	f8c91ce3          	bne	s2,a2,ffffffffc0200d08 <ramdisk_init+0x3a>
ffffffffc0200d74:	6442                	ld	s0,16(sp)
ffffffffc0200d76:	60e2                	ld	ra,24(sp)
ffffffffc0200d78:	64a2                	ld	s1,8(sp)
ffffffffc0200d7a:	6902                	ld	s2,0(sp)
ffffffffc0200d7c:	0000b517          	auipc	a0,0xb
ffffffffc0200d80:	9ac50513          	addi	a0,a0,-1620 # ffffffffc020b728 <commands+0x2c0>
ffffffffc0200d84:	6105                	addi	sp,sp,32
ffffffffc0200d86:	c20ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0200d8a:	0000b617          	auipc	a2,0xb
ffffffffc0200d8e:	9de60613          	addi	a2,a2,-1570 # ffffffffc020b768 <commands+0x300>
ffffffffc0200d92:	03200593          	li	a1,50
ffffffffc0200d96:	0000b517          	auipc	a0,0xb
ffffffffc0200d9a:	9ea50513          	addi	a0,a0,-1558 # ffffffffc020b780 <commands+0x318>
ffffffffc0200d9e:	f00ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200da2 <idt_init>:
ffffffffc0200da2:	14005073          	csrwi	sscratch,0
ffffffffc0200da6:	00000797          	auipc	a5,0x0
ffffffffc0200daa:	43a78793          	addi	a5,a5,1082 # ffffffffc02011e0 <__alltraps>
ffffffffc0200dae:	10579073          	csrw	stvec,a5
ffffffffc0200db2:	000407b7          	lui	a5,0x40
ffffffffc0200db6:	1007a7f3          	csrrs	a5,sstatus,a5
ffffffffc0200dba:	8082                	ret

ffffffffc0200dbc <print_regs>:
ffffffffc0200dbc:	610c                	ld	a1,0(a0)
ffffffffc0200dbe:	1141                	addi	sp,sp,-16
ffffffffc0200dc0:	e022                	sd	s0,0(sp)
ffffffffc0200dc2:	842a                	mv	s0,a0
ffffffffc0200dc4:	0000b517          	auipc	a0,0xb
ffffffffc0200dc8:	9e450513          	addi	a0,a0,-1564 # ffffffffc020b7a8 <commands+0x340>
ffffffffc0200dcc:	e406                	sd	ra,8(sp)
ffffffffc0200dce:	bd8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dd2:	640c                	ld	a1,8(s0)
ffffffffc0200dd4:	0000b517          	auipc	a0,0xb
ffffffffc0200dd8:	9ec50513          	addi	a0,a0,-1556 # ffffffffc020b7c0 <commands+0x358>
ffffffffc0200ddc:	bcaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200de0:	680c                	ld	a1,16(s0)
ffffffffc0200de2:	0000b517          	auipc	a0,0xb
ffffffffc0200de6:	9f650513          	addi	a0,a0,-1546 # ffffffffc020b7d8 <commands+0x370>
ffffffffc0200dea:	bbcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dee:	6c0c                	ld	a1,24(s0)
ffffffffc0200df0:	0000b517          	auipc	a0,0xb
ffffffffc0200df4:	a0050513          	addi	a0,a0,-1536 # ffffffffc020b7f0 <commands+0x388>
ffffffffc0200df8:	baeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dfc:	700c                	ld	a1,32(s0)
ffffffffc0200dfe:	0000b517          	auipc	a0,0xb
ffffffffc0200e02:	a0a50513          	addi	a0,a0,-1526 # ffffffffc020b808 <commands+0x3a0>
ffffffffc0200e06:	ba0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e0a:	740c                	ld	a1,40(s0)
ffffffffc0200e0c:	0000b517          	auipc	a0,0xb
ffffffffc0200e10:	a1450513          	addi	a0,a0,-1516 # ffffffffc020b820 <commands+0x3b8>
ffffffffc0200e14:	b92ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e18:	780c                	ld	a1,48(s0)
ffffffffc0200e1a:	0000b517          	auipc	a0,0xb
ffffffffc0200e1e:	a1e50513          	addi	a0,a0,-1506 # ffffffffc020b838 <commands+0x3d0>
ffffffffc0200e22:	b84ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e26:	7c0c                	ld	a1,56(s0)
ffffffffc0200e28:	0000b517          	auipc	a0,0xb
ffffffffc0200e2c:	a2850513          	addi	a0,a0,-1496 # ffffffffc020b850 <commands+0x3e8>
ffffffffc0200e30:	b76ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e34:	602c                	ld	a1,64(s0)
ffffffffc0200e36:	0000b517          	auipc	a0,0xb
ffffffffc0200e3a:	a3250513          	addi	a0,a0,-1486 # ffffffffc020b868 <commands+0x400>
ffffffffc0200e3e:	b68ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e42:	642c                	ld	a1,72(s0)
ffffffffc0200e44:	0000b517          	auipc	a0,0xb
ffffffffc0200e48:	a3c50513          	addi	a0,a0,-1476 # ffffffffc020b880 <commands+0x418>
ffffffffc0200e4c:	b5aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e50:	682c                	ld	a1,80(s0)
ffffffffc0200e52:	0000b517          	auipc	a0,0xb
ffffffffc0200e56:	a4650513          	addi	a0,a0,-1466 # ffffffffc020b898 <commands+0x430>
ffffffffc0200e5a:	b4cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e5e:	6c2c                	ld	a1,88(s0)
ffffffffc0200e60:	0000b517          	auipc	a0,0xb
ffffffffc0200e64:	a5050513          	addi	a0,a0,-1456 # ffffffffc020b8b0 <commands+0x448>
ffffffffc0200e68:	b3eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e6c:	702c                	ld	a1,96(s0)
ffffffffc0200e6e:	0000b517          	auipc	a0,0xb
ffffffffc0200e72:	a5a50513          	addi	a0,a0,-1446 # ffffffffc020b8c8 <commands+0x460>
ffffffffc0200e76:	b30ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e7a:	742c                	ld	a1,104(s0)
ffffffffc0200e7c:	0000b517          	auipc	a0,0xb
ffffffffc0200e80:	a6450513          	addi	a0,a0,-1436 # ffffffffc020b8e0 <commands+0x478>
ffffffffc0200e84:	b22ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e88:	782c                	ld	a1,112(s0)
ffffffffc0200e8a:	0000b517          	auipc	a0,0xb
ffffffffc0200e8e:	a6e50513          	addi	a0,a0,-1426 # ffffffffc020b8f8 <commands+0x490>
ffffffffc0200e92:	b14ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e96:	7c2c                	ld	a1,120(s0)
ffffffffc0200e98:	0000b517          	auipc	a0,0xb
ffffffffc0200e9c:	a7850513          	addi	a0,a0,-1416 # ffffffffc020b910 <commands+0x4a8>
ffffffffc0200ea0:	b06ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ea4:	604c                	ld	a1,128(s0)
ffffffffc0200ea6:	0000b517          	auipc	a0,0xb
ffffffffc0200eaa:	a8250513          	addi	a0,a0,-1406 # ffffffffc020b928 <commands+0x4c0>
ffffffffc0200eae:	af8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eb2:	644c                	ld	a1,136(s0)
ffffffffc0200eb4:	0000b517          	auipc	a0,0xb
ffffffffc0200eb8:	a8c50513          	addi	a0,a0,-1396 # ffffffffc020b940 <commands+0x4d8>
ffffffffc0200ebc:	aeaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ec0:	684c                	ld	a1,144(s0)
ffffffffc0200ec2:	0000b517          	auipc	a0,0xb
ffffffffc0200ec6:	a9650513          	addi	a0,a0,-1386 # ffffffffc020b958 <commands+0x4f0>
ffffffffc0200eca:	adcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ece:	6c4c                	ld	a1,152(s0)
ffffffffc0200ed0:	0000b517          	auipc	a0,0xb
ffffffffc0200ed4:	aa050513          	addi	a0,a0,-1376 # ffffffffc020b970 <commands+0x508>
ffffffffc0200ed8:	aceff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200edc:	704c                	ld	a1,160(s0)
ffffffffc0200ede:	0000b517          	auipc	a0,0xb
ffffffffc0200ee2:	aaa50513          	addi	a0,a0,-1366 # ffffffffc020b988 <commands+0x520>
ffffffffc0200ee6:	ac0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eea:	744c                	ld	a1,168(s0)
ffffffffc0200eec:	0000b517          	auipc	a0,0xb
ffffffffc0200ef0:	ab450513          	addi	a0,a0,-1356 # ffffffffc020b9a0 <commands+0x538>
ffffffffc0200ef4:	ab2ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ef8:	784c                	ld	a1,176(s0)
ffffffffc0200efa:	0000b517          	auipc	a0,0xb
ffffffffc0200efe:	abe50513          	addi	a0,a0,-1346 # ffffffffc020b9b8 <commands+0x550>
ffffffffc0200f02:	aa4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f06:	7c4c                	ld	a1,184(s0)
ffffffffc0200f08:	0000b517          	auipc	a0,0xb
ffffffffc0200f0c:	ac850513          	addi	a0,a0,-1336 # ffffffffc020b9d0 <commands+0x568>
ffffffffc0200f10:	a96ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f14:	606c                	ld	a1,192(s0)
ffffffffc0200f16:	0000b517          	auipc	a0,0xb
ffffffffc0200f1a:	ad250513          	addi	a0,a0,-1326 # ffffffffc020b9e8 <commands+0x580>
ffffffffc0200f1e:	a88ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f22:	646c                	ld	a1,200(s0)
ffffffffc0200f24:	0000b517          	auipc	a0,0xb
ffffffffc0200f28:	adc50513          	addi	a0,a0,-1316 # ffffffffc020ba00 <commands+0x598>
ffffffffc0200f2c:	a7aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f30:	686c                	ld	a1,208(s0)
ffffffffc0200f32:	0000b517          	auipc	a0,0xb
ffffffffc0200f36:	ae650513          	addi	a0,a0,-1306 # ffffffffc020ba18 <commands+0x5b0>
ffffffffc0200f3a:	a6cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f3e:	6c6c                	ld	a1,216(s0)
ffffffffc0200f40:	0000b517          	auipc	a0,0xb
ffffffffc0200f44:	af050513          	addi	a0,a0,-1296 # ffffffffc020ba30 <commands+0x5c8>
ffffffffc0200f48:	a5eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f4c:	706c                	ld	a1,224(s0)
ffffffffc0200f4e:	0000b517          	auipc	a0,0xb
ffffffffc0200f52:	afa50513          	addi	a0,a0,-1286 # ffffffffc020ba48 <commands+0x5e0>
ffffffffc0200f56:	a50ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f5a:	746c                	ld	a1,232(s0)
ffffffffc0200f5c:	0000b517          	auipc	a0,0xb
ffffffffc0200f60:	b0450513          	addi	a0,a0,-1276 # ffffffffc020ba60 <commands+0x5f8>
ffffffffc0200f64:	a42ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f68:	786c                	ld	a1,240(s0)
ffffffffc0200f6a:	0000b517          	auipc	a0,0xb
ffffffffc0200f6e:	b0e50513          	addi	a0,a0,-1266 # ffffffffc020ba78 <commands+0x610>
ffffffffc0200f72:	a34ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f76:	7c6c                	ld	a1,248(s0)
ffffffffc0200f78:	6402                	ld	s0,0(sp)
ffffffffc0200f7a:	60a2                	ld	ra,8(sp)
ffffffffc0200f7c:	0000b517          	auipc	a0,0xb
ffffffffc0200f80:	b1450513          	addi	a0,a0,-1260 # ffffffffc020ba90 <commands+0x628>
ffffffffc0200f84:	0141                	addi	sp,sp,16
ffffffffc0200f86:	a20ff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200f8a <print_trapframe>:
ffffffffc0200f8a:	1141                	addi	sp,sp,-16
ffffffffc0200f8c:	e022                	sd	s0,0(sp)
ffffffffc0200f8e:	85aa                	mv	a1,a0
ffffffffc0200f90:	842a                	mv	s0,a0
ffffffffc0200f92:	0000b517          	auipc	a0,0xb
ffffffffc0200f96:	b1650513          	addi	a0,a0,-1258 # ffffffffc020baa8 <commands+0x640>
ffffffffc0200f9a:	e406                	sd	ra,8(sp)
ffffffffc0200f9c:	a0aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fa0:	8522                	mv	a0,s0
ffffffffc0200fa2:	e1bff0ef          	jal	ra,ffffffffc0200dbc <print_regs>
ffffffffc0200fa6:	10043583          	ld	a1,256(s0)
ffffffffc0200faa:	0000b517          	auipc	a0,0xb
ffffffffc0200fae:	b1650513          	addi	a0,a0,-1258 # ffffffffc020bac0 <commands+0x658>
ffffffffc0200fb2:	9f4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fb6:	10843583          	ld	a1,264(s0)
ffffffffc0200fba:	0000b517          	auipc	a0,0xb
ffffffffc0200fbe:	b1e50513          	addi	a0,a0,-1250 # ffffffffc020bad8 <commands+0x670>
ffffffffc0200fc2:	9e4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fc6:	11043583          	ld	a1,272(s0)
ffffffffc0200fca:	0000b517          	auipc	a0,0xb
ffffffffc0200fce:	b2650513          	addi	a0,a0,-1242 # ffffffffc020baf0 <commands+0x688>
ffffffffc0200fd2:	9d4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fd6:	11843583          	ld	a1,280(s0)
ffffffffc0200fda:	6402                	ld	s0,0(sp)
ffffffffc0200fdc:	60a2                	ld	ra,8(sp)
ffffffffc0200fde:	0000b517          	auipc	a0,0xb
ffffffffc0200fe2:	b2250513          	addi	a0,a0,-1246 # ffffffffc020bb00 <commands+0x698>
ffffffffc0200fe6:	0141                	addi	sp,sp,16
ffffffffc0200fe8:	9beff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200fec <interrupt_handler>:
ffffffffc0200fec:	11853783          	ld	a5,280(a0)
ffffffffc0200ff0:	472d                	li	a4,11
ffffffffc0200ff2:	0786                	slli	a5,a5,0x1
ffffffffc0200ff4:	8385                	srli	a5,a5,0x1
ffffffffc0200ff6:	06f76c63          	bltu	a4,a5,ffffffffc020106e <interrupt_handler+0x82>
ffffffffc0200ffa:	0000b717          	auipc	a4,0xb
ffffffffc0200ffe:	bbe70713          	addi	a4,a4,-1090 # ffffffffc020bbb8 <commands+0x750>
ffffffffc0201002:	078a                	slli	a5,a5,0x2
ffffffffc0201004:	97ba                	add	a5,a5,a4
ffffffffc0201006:	439c                	lw	a5,0(a5)
ffffffffc0201008:	97ba                	add	a5,a5,a4
ffffffffc020100a:	8782                	jr	a5
ffffffffc020100c:	0000b517          	auipc	a0,0xb
ffffffffc0201010:	b6c50513          	addi	a0,a0,-1172 # ffffffffc020bb78 <commands+0x710>
ffffffffc0201014:	992ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201018:	0000b517          	auipc	a0,0xb
ffffffffc020101c:	b4050513          	addi	a0,a0,-1216 # ffffffffc020bb58 <commands+0x6f0>
ffffffffc0201020:	986ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201024:	0000b517          	auipc	a0,0xb
ffffffffc0201028:	af450513          	addi	a0,a0,-1292 # ffffffffc020bb18 <commands+0x6b0>
ffffffffc020102c:	97aff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201030:	0000b517          	auipc	a0,0xb
ffffffffc0201034:	b0850513          	addi	a0,a0,-1272 # ffffffffc020bb38 <commands+0x6d0>
ffffffffc0201038:	96eff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc020103c:	1141                	addi	sp,sp,-16
ffffffffc020103e:	e406                	sd	ra,8(sp)
ffffffffc0201040:	d3aff0ef          	jal	ra,ffffffffc020057a <clock_set_next_event>
ffffffffc0201044:	00096717          	auipc	a4,0x96
ffffffffc0201048:	82c70713          	addi	a4,a4,-2004 # ffffffffc0296870 <ticks>
ffffffffc020104c:	631c                	ld	a5,0(a4)
ffffffffc020104e:	0785                	addi	a5,a5,1
ffffffffc0201050:	e31c                	sd	a5,0(a4)
ffffffffc0201052:	312060ef          	jal	ra,ffffffffc0207364 <run_timer_list>
ffffffffc0201056:	d9eff0ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc020105a:	60a2                	ld	ra,8(sp)
ffffffffc020105c:	0141                	addi	sp,sp,16
ffffffffc020105e:	1d70706f          	j	ffffffffc0208a34 <dev_stdin_write>
ffffffffc0201062:	0000b517          	auipc	a0,0xb
ffffffffc0201066:	b3650513          	addi	a0,a0,-1226 # ffffffffc020bb98 <commands+0x730>
ffffffffc020106a:	93cff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc020106e:	bf31                	j	ffffffffc0200f8a <print_trapframe>

ffffffffc0201070 <exception_handler>:
ffffffffc0201070:	11853783          	ld	a5,280(a0)
ffffffffc0201074:	1141                	addi	sp,sp,-16
ffffffffc0201076:	e022                	sd	s0,0(sp)
ffffffffc0201078:	e406                	sd	ra,8(sp)
ffffffffc020107a:	473d                	li	a4,15
ffffffffc020107c:	842a                	mv	s0,a0
ffffffffc020107e:	0af76b63          	bltu	a4,a5,ffffffffc0201134 <exception_handler+0xc4>
ffffffffc0201082:	0000b717          	auipc	a4,0xb
ffffffffc0201086:	cf670713          	addi	a4,a4,-778 # ffffffffc020bd78 <commands+0x910>
ffffffffc020108a:	078a                	slli	a5,a5,0x2
ffffffffc020108c:	97ba                	add	a5,a5,a4
ffffffffc020108e:	439c                	lw	a5,0(a5)
ffffffffc0201090:	97ba                	add	a5,a5,a4
ffffffffc0201092:	8782                	jr	a5
ffffffffc0201094:	0000b517          	auipc	a0,0xb
ffffffffc0201098:	c3c50513          	addi	a0,a0,-964 # ffffffffc020bcd0 <commands+0x868>
ffffffffc020109c:	90aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02010a0:	10843783          	ld	a5,264(s0)
ffffffffc02010a4:	60a2                	ld	ra,8(sp)
ffffffffc02010a6:	0791                	addi	a5,a5,4
ffffffffc02010a8:	10f43423          	sd	a5,264(s0)
ffffffffc02010ac:	6402                	ld	s0,0(sp)
ffffffffc02010ae:	0141                	addi	sp,sp,16
ffffffffc02010b0:	4ca0606f          	j	ffffffffc020757a <syscall>
ffffffffc02010b4:	0000b517          	auipc	a0,0xb
ffffffffc02010b8:	c3c50513          	addi	a0,a0,-964 # ffffffffc020bcf0 <commands+0x888>
ffffffffc02010bc:	6402                	ld	s0,0(sp)
ffffffffc02010be:	60a2                	ld	ra,8(sp)
ffffffffc02010c0:	0141                	addi	sp,sp,16
ffffffffc02010c2:	8e4ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02010c6:	0000b517          	auipc	a0,0xb
ffffffffc02010ca:	c4a50513          	addi	a0,a0,-950 # ffffffffc020bd10 <commands+0x8a8>
ffffffffc02010ce:	b7fd                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010d0:	0000b517          	auipc	a0,0xb
ffffffffc02010d4:	c6050513          	addi	a0,a0,-928 # ffffffffc020bd30 <commands+0x8c8>
ffffffffc02010d8:	b7d5                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010da:	0000b517          	auipc	a0,0xb
ffffffffc02010de:	c6e50513          	addi	a0,a0,-914 # ffffffffc020bd48 <commands+0x8e0>
ffffffffc02010e2:	bfe9                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010e4:	0000b517          	auipc	a0,0xb
ffffffffc02010e8:	c7c50513          	addi	a0,a0,-900 # ffffffffc020bd60 <commands+0x8f8>
ffffffffc02010ec:	bfc1                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010ee:	0000b517          	auipc	a0,0xb
ffffffffc02010f2:	afa50513          	addi	a0,a0,-1286 # ffffffffc020bbe8 <commands+0x780>
ffffffffc02010f6:	b7d9                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010f8:	0000b517          	auipc	a0,0xb
ffffffffc02010fc:	b1050513          	addi	a0,a0,-1264 # ffffffffc020bc08 <commands+0x7a0>
ffffffffc0201100:	bf75                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201102:	0000b517          	auipc	a0,0xb
ffffffffc0201106:	b2650513          	addi	a0,a0,-1242 # ffffffffc020bc28 <commands+0x7c0>
ffffffffc020110a:	bf4d                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc020110c:	0000b517          	auipc	a0,0xb
ffffffffc0201110:	b3450513          	addi	a0,a0,-1228 # ffffffffc020bc40 <commands+0x7d8>
ffffffffc0201114:	b765                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201116:	0000b517          	auipc	a0,0xb
ffffffffc020111a:	b3a50513          	addi	a0,a0,-1222 # ffffffffc020bc50 <commands+0x7e8>
ffffffffc020111e:	bf79                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201120:	0000b517          	auipc	a0,0xb
ffffffffc0201124:	b5050513          	addi	a0,a0,-1200 # ffffffffc020bc70 <commands+0x808>
ffffffffc0201128:	bf51                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc020112a:	0000b517          	auipc	a0,0xb
ffffffffc020112e:	b8e50513          	addi	a0,a0,-1138 # ffffffffc020bcb8 <commands+0x850>
ffffffffc0201132:	b769                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201134:	8522                	mv	a0,s0
ffffffffc0201136:	6402                	ld	s0,0(sp)
ffffffffc0201138:	60a2                	ld	ra,8(sp)
ffffffffc020113a:	0141                	addi	sp,sp,16
ffffffffc020113c:	b5b9                	j	ffffffffc0200f8a <print_trapframe>
ffffffffc020113e:	0000b617          	auipc	a2,0xb
ffffffffc0201142:	b4a60613          	addi	a2,a2,-1206 # ffffffffc020bc88 <commands+0x820>
ffffffffc0201146:	0b100593          	li	a1,177
ffffffffc020114a:	0000b517          	auipc	a0,0xb
ffffffffc020114e:	b5650513          	addi	a0,a0,-1194 # ffffffffc020bca0 <commands+0x838>
ffffffffc0201152:	b4cff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201156 <trap>:
ffffffffc0201156:	1101                	addi	sp,sp,-32
ffffffffc0201158:	e822                	sd	s0,16(sp)
ffffffffc020115a:	00095417          	auipc	s0,0x95
ffffffffc020115e:	76640413          	addi	s0,s0,1894 # ffffffffc02968c0 <current>
ffffffffc0201162:	6018                	ld	a4,0(s0)
ffffffffc0201164:	ec06                	sd	ra,24(sp)
ffffffffc0201166:	e426                	sd	s1,8(sp)
ffffffffc0201168:	e04a                	sd	s2,0(sp)
ffffffffc020116a:	11853683          	ld	a3,280(a0)
ffffffffc020116e:	cf1d                	beqz	a4,ffffffffc02011ac <trap+0x56>
ffffffffc0201170:	10053483          	ld	s1,256(a0)
ffffffffc0201174:	0a073903          	ld	s2,160(a4)
ffffffffc0201178:	f348                	sd	a0,160(a4)
ffffffffc020117a:	1004f493          	andi	s1,s1,256
ffffffffc020117e:	0206c463          	bltz	a3,ffffffffc02011a6 <trap+0x50>
ffffffffc0201182:	eefff0ef          	jal	ra,ffffffffc0201070 <exception_handler>
ffffffffc0201186:	601c                	ld	a5,0(s0)
ffffffffc0201188:	0b27b023          	sd	s2,160(a5) # 400a0 <_binary_bin_swap_img_size+0x383a0>
ffffffffc020118c:	e499                	bnez	s1,ffffffffc020119a <trap+0x44>
ffffffffc020118e:	0b07a703          	lw	a4,176(a5)
ffffffffc0201192:	8b05                	andi	a4,a4,1
ffffffffc0201194:	e329                	bnez	a4,ffffffffc02011d6 <trap+0x80>
ffffffffc0201196:	6f9c                	ld	a5,24(a5)
ffffffffc0201198:	eb85                	bnez	a5,ffffffffc02011c8 <trap+0x72>
ffffffffc020119a:	60e2                	ld	ra,24(sp)
ffffffffc020119c:	6442                	ld	s0,16(sp)
ffffffffc020119e:	64a2                	ld	s1,8(sp)
ffffffffc02011a0:	6902                	ld	s2,0(sp)
ffffffffc02011a2:	6105                	addi	sp,sp,32
ffffffffc02011a4:	8082                	ret
ffffffffc02011a6:	e47ff0ef          	jal	ra,ffffffffc0200fec <interrupt_handler>
ffffffffc02011aa:	bff1                	j	ffffffffc0201186 <trap+0x30>
ffffffffc02011ac:	0006c863          	bltz	a3,ffffffffc02011bc <trap+0x66>
ffffffffc02011b0:	6442                	ld	s0,16(sp)
ffffffffc02011b2:	60e2                	ld	ra,24(sp)
ffffffffc02011b4:	64a2                	ld	s1,8(sp)
ffffffffc02011b6:	6902                	ld	s2,0(sp)
ffffffffc02011b8:	6105                	addi	sp,sp,32
ffffffffc02011ba:	bd5d                	j	ffffffffc0201070 <exception_handler>
ffffffffc02011bc:	6442                	ld	s0,16(sp)
ffffffffc02011be:	60e2                	ld	ra,24(sp)
ffffffffc02011c0:	64a2                	ld	s1,8(sp)
ffffffffc02011c2:	6902                	ld	s2,0(sp)
ffffffffc02011c4:	6105                	addi	sp,sp,32
ffffffffc02011c6:	b51d                	j	ffffffffc0200fec <interrupt_handler>
ffffffffc02011c8:	6442                	ld	s0,16(sp)
ffffffffc02011ca:	60e2                	ld	ra,24(sp)
ffffffffc02011cc:	64a2                	ld	s1,8(sp)
ffffffffc02011ce:	6902                	ld	s2,0(sp)
ffffffffc02011d0:	6105                	addi	sp,sp,32
ffffffffc02011d2:	7870506f          	j	ffffffffc0207158 <schedule>
ffffffffc02011d6:	555d                	li	a0,-9
ffffffffc02011d8:	623040ef          	jal	ra,ffffffffc0205ffa <do_exit>
ffffffffc02011dc:	601c                	ld	a5,0(s0)
ffffffffc02011de:	bf65                	j	ffffffffc0201196 <trap+0x40>

ffffffffc02011e0 <__alltraps>:
ffffffffc02011e0:	14011173          	csrrw	sp,sscratch,sp
ffffffffc02011e4:	00011463          	bnez	sp,ffffffffc02011ec <__alltraps+0xc>
ffffffffc02011e8:	14002173          	csrr	sp,sscratch
ffffffffc02011ec:	712d                	addi	sp,sp,-288
ffffffffc02011ee:	e002                	sd	zero,0(sp)
ffffffffc02011f0:	e406                	sd	ra,8(sp)
ffffffffc02011f2:	ec0e                	sd	gp,24(sp)
ffffffffc02011f4:	f012                	sd	tp,32(sp)
ffffffffc02011f6:	f416                	sd	t0,40(sp)
ffffffffc02011f8:	f81a                	sd	t1,48(sp)
ffffffffc02011fa:	fc1e                	sd	t2,56(sp)
ffffffffc02011fc:	e0a2                	sd	s0,64(sp)
ffffffffc02011fe:	e4a6                	sd	s1,72(sp)
ffffffffc0201200:	e8aa                	sd	a0,80(sp)
ffffffffc0201202:	ecae                	sd	a1,88(sp)
ffffffffc0201204:	f0b2                	sd	a2,96(sp)
ffffffffc0201206:	f4b6                	sd	a3,104(sp)
ffffffffc0201208:	f8ba                	sd	a4,112(sp)
ffffffffc020120a:	fcbe                	sd	a5,120(sp)
ffffffffc020120c:	e142                	sd	a6,128(sp)
ffffffffc020120e:	e546                	sd	a7,136(sp)
ffffffffc0201210:	e94a                	sd	s2,144(sp)
ffffffffc0201212:	ed4e                	sd	s3,152(sp)
ffffffffc0201214:	f152                	sd	s4,160(sp)
ffffffffc0201216:	f556                	sd	s5,168(sp)
ffffffffc0201218:	f95a                	sd	s6,176(sp)
ffffffffc020121a:	fd5e                	sd	s7,184(sp)
ffffffffc020121c:	e1e2                	sd	s8,192(sp)
ffffffffc020121e:	e5e6                	sd	s9,200(sp)
ffffffffc0201220:	e9ea                	sd	s10,208(sp)
ffffffffc0201222:	edee                	sd	s11,216(sp)
ffffffffc0201224:	f1f2                	sd	t3,224(sp)
ffffffffc0201226:	f5f6                	sd	t4,232(sp)
ffffffffc0201228:	f9fa                	sd	t5,240(sp)
ffffffffc020122a:	fdfe                	sd	t6,248(sp)
ffffffffc020122c:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0201230:	100024f3          	csrr	s1,sstatus
ffffffffc0201234:	14102973          	csrr	s2,sepc
ffffffffc0201238:	143029f3          	csrr	s3,stval
ffffffffc020123c:	14202a73          	csrr	s4,scause
ffffffffc0201240:	e822                	sd	s0,16(sp)
ffffffffc0201242:	e226                	sd	s1,256(sp)
ffffffffc0201244:	e64a                	sd	s2,264(sp)
ffffffffc0201246:	ea4e                	sd	s3,272(sp)
ffffffffc0201248:	ee52                	sd	s4,280(sp)
ffffffffc020124a:	850a                	mv	a0,sp
ffffffffc020124c:	f0bff0ef          	jal	ra,ffffffffc0201156 <trap>

ffffffffc0201250 <__trapret>:
ffffffffc0201250:	6492                	ld	s1,256(sp)
ffffffffc0201252:	6932                	ld	s2,264(sp)
ffffffffc0201254:	1004f413          	andi	s0,s1,256
ffffffffc0201258:	e401                	bnez	s0,ffffffffc0201260 <__trapret+0x10>
ffffffffc020125a:	1200                	addi	s0,sp,288
ffffffffc020125c:	14041073          	csrw	sscratch,s0
ffffffffc0201260:	10049073          	csrw	sstatus,s1
ffffffffc0201264:	14191073          	csrw	sepc,s2
ffffffffc0201268:	60a2                	ld	ra,8(sp)
ffffffffc020126a:	61e2                	ld	gp,24(sp)
ffffffffc020126c:	7202                	ld	tp,32(sp)
ffffffffc020126e:	72a2                	ld	t0,40(sp)
ffffffffc0201270:	7342                	ld	t1,48(sp)
ffffffffc0201272:	73e2                	ld	t2,56(sp)
ffffffffc0201274:	6406                	ld	s0,64(sp)
ffffffffc0201276:	64a6                	ld	s1,72(sp)
ffffffffc0201278:	6546                	ld	a0,80(sp)
ffffffffc020127a:	65e6                	ld	a1,88(sp)
ffffffffc020127c:	7606                	ld	a2,96(sp)
ffffffffc020127e:	76a6                	ld	a3,104(sp)
ffffffffc0201280:	7746                	ld	a4,112(sp)
ffffffffc0201282:	77e6                	ld	a5,120(sp)
ffffffffc0201284:	680a                	ld	a6,128(sp)
ffffffffc0201286:	68aa                	ld	a7,136(sp)
ffffffffc0201288:	694a                	ld	s2,144(sp)
ffffffffc020128a:	69ea                	ld	s3,152(sp)
ffffffffc020128c:	7a0a                	ld	s4,160(sp)
ffffffffc020128e:	7aaa                	ld	s5,168(sp)
ffffffffc0201290:	7b4a                	ld	s6,176(sp)
ffffffffc0201292:	7bea                	ld	s7,184(sp)
ffffffffc0201294:	6c0e                	ld	s8,192(sp)
ffffffffc0201296:	6cae                	ld	s9,200(sp)
ffffffffc0201298:	6d4e                	ld	s10,208(sp)
ffffffffc020129a:	6dee                	ld	s11,216(sp)
ffffffffc020129c:	7e0e                	ld	t3,224(sp)
ffffffffc020129e:	7eae                	ld	t4,232(sp)
ffffffffc02012a0:	7f4e                	ld	t5,240(sp)
ffffffffc02012a2:	7fee                	ld	t6,248(sp)
ffffffffc02012a4:	6142                	ld	sp,16(sp)
ffffffffc02012a6:	10200073          	sret

ffffffffc02012aa <forkrets>:
ffffffffc02012aa:	812a                	mv	sp,a0
ffffffffc02012ac:	b755                	j	ffffffffc0201250 <__trapret>

ffffffffc02012ae <default_init>:
ffffffffc02012ae:	00090797          	auipc	a5,0x90
ffffffffc02012b2:	4fa78793          	addi	a5,a5,1274 # ffffffffc02917a8 <free_area>
ffffffffc02012b6:	e79c                	sd	a5,8(a5)
ffffffffc02012b8:	e39c                	sd	a5,0(a5)
ffffffffc02012ba:	0007a823          	sw	zero,16(a5)
ffffffffc02012be:	8082                	ret

ffffffffc02012c0 <default_nr_free_pages>:
ffffffffc02012c0:	00090517          	auipc	a0,0x90
ffffffffc02012c4:	4f856503          	lwu	a0,1272(a0) # ffffffffc02917b8 <free_area+0x10>
ffffffffc02012c8:	8082                	ret

ffffffffc02012ca <default_check>:
ffffffffc02012ca:	715d                	addi	sp,sp,-80
ffffffffc02012cc:	e0a2                	sd	s0,64(sp)
ffffffffc02012ce:	00090417          	auipc	s0,0x90
ffffffffc02012d2:	4da40413          	addi	s0,s0,1242 # ffffffffc02917a8 <free_area>
ffffffffc02012d6:	641c                	ld	a5,8(s0)
ffffffffc02012d8:	e486                	sd	ra,72(sp)
ffffffffc02012da:	fc26                	sd	s1,56(sp)
ffffffffc02012dc:	f84a                	sd	s2,48(sp)
ffffffffc02012de:	f44e                	sd	s3,40(sp)
ffffffffc02012e0:	f052                	sd	s4,32(sp)
ffffffffc02012e2:	ec56                	sd	s5,24(sp)
ffffffffc02012e4:	e85a                	sd	s6,16(sp)
ffffffffc02012e6:	e45e                	sd	s7,8(sp)
ffffffffc02012e8:	e062                	sd	s8,0(sp)
ffffffffc02012ea:	2a878d63          	beq	a5,s0,ffffffffc02015a4 <default_check+0x2da>
ffffffffc02012ee:	4481                	li	s1,0
ffffffffc02012f0:	4901                	li	s2,0
ffffffffc02012f2:	ff07b703          	ld	a4,-16(a5)
ffffffffc02012f6:	8b09                	andi	a4,a4,2
ffffffffc02012f8:	2a070a63          	beqz	a4,ffffffffc02015ac <default_check+0x2e2>
ffffffffc02012fc:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201300:	679c                	ld	a5,8(a5)
ffffffffc0201302:	2905                	addiw	s2,s2,1
ffffffffc0201304:	9cb9                	addw	s1,s1,a4
ffffffffc0201306:	fe8796e3          	bne	a5,s0,ffffffffc02012f2 <default_check+0x28>
ffffffffc020130a:	89a6                	mv	s3,s1
ffffffffc020130c:	6df000ef          	jal	ra,ffffffffc02021ea <nr_free_pages>
ffffffffc0201310:	6f351e63          	bne	a0,s3,ffffffffc0201a0c <default_check+0x742>
ffffffffc0201314:	4505                	li	a0,1
ffffffffc0201316:	657000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020131a:	8aaa                	mv	s5,a0
ffffffffc020131c:	42050863          	beqz	a0,ffffffffc020174c <default_check+0x482>
ffffffffc0201320:	4505                	li	a0,1
ffffffffc0201322:	64b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201326:	89aa                	mv	s3,a0
ffffffffc0201328:	70050263          	beqz	a0,ffffffffc0201a2c <default_check+0x762>
ffffffffc020132c:	4505                	li	a0,1
ffffffffc020132e:	63f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201332:	8a2a                	mv	s4,a0
ffffffffc0201334:	48050c63          	beqz	a0,ffffffffc02017cc <default_check+0x502>
ffffffffc0201338:	293a8a63          	beq	s5,s3,ffffffffc02015cc <default_check+0x302>
ffffffffc020133c:	28aa8863          	beq	s5,a0,ffffffffc02015cc <default_check+0x302>
ffffffffc0201340:	28a98663          	beq	s3,a0,ffffffffc02015cc <default_check+0x302>
ffffffffc0201344:	000aa783          	lw	a5,0(s5)
ffffffffc0201348:	2a079263          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc020134c:	0009a783          	lw	a5,0(s3)
ffffffffc0201350:	28079e63          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc0201354:	411c                	lw	a5,0(a0)
ffffffffc0201356:	28079b63          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc020135a:	00095797          	auipc	a5,0x95
ffffffffc020135e:	54e7b783          	ld	a5,1358(a5) # ffffffffc02968a8 <pages>
ffffffffc0201362:	40fa8733          	sub	a4,s5,a5
ffffffffc0201366:	0000e617          	auipc	a2,0xe
ffffffffc020136a:	ff263603          	ld	a2,-14(a2) # ffffffffc020f358 <nbase>
ffffffffc020136e:	8719                	srai	a4,a4,0x6
ffffffffc0201370:	9732                	add	a4,a4,a2
ffffffffc0201372:	00095697          	auipc	a3,0x95
ffffffffc0201376:	52e6b683          	ld	a3,1326(a3) # ffffffffc02968a0 <npage>
ffffffffc020137a:	06b2                	slli	a3,a3,0xc
ffffffffc020137c:	0732                	slli	a4,a4,0xc
ffffffffc020137e:	28d77763          	bgeu	a4,a3,ffffffffc020160c <default_check+0x342>
ffffffffc0201382:	40f98733          	sub	a4,s3,a5
ffffffffc0201386:	8719                	srai	a4,a4,0x6
ffffffffc0201388:	9732                	add	a4,a4,a2
ffffffffc020138a:	0732                	slli	a4,a4,0xc
ffffffffc020138c:	4cd77063          	bgeu	a4,a3,ffffffffc020184c <default_check+0x582>
ffffffffc0201390:	40f507b3          	sub	a5,a0,a5
ffffffffc0201394:	8799                	srai	a5,a5,0x6
ffffffffc0201396:	97b2                	add	a5,a5,a2
ffffffffc0201398:	07b2                	slli	a5,a5,0xc
ffffffffc020139a:	30d7f963          	bgeu	a5,a3,ffffffffc02016ac <default_check+0x3e2>
ffffffffc020139e:	4505                	li	a0,1
ffffffffc02013a0:	00043c03          	ld	s8,0(s0)
ffffffffc02013a4:	00843b83          	ld	s7,8(s0)
ffffffffc02013a8:	01042b03          	lw	s6,16(s0)
ffffffffc02013ac:	e400                	sd	s0,8(s0)
ffffffffc02013ae:	e000                	sd	s0,0(s0)
ffffffffc02013b0:	00090797          	auipc	a5,0x90
ffffffffc02013b4:	4007a423          	sw	zero,1032(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc02013b8:	5b5000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013bc:	2c051863          	bnez	a0,ffffffffc020168c <default_check+0x3c2>
ffffffffc02013c0:	4585                	li	a1,1
ffffffffc02013c2:	8556                	mv	a0,s5
ffffffffc02013c4:	5e7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013c8:	4585                	li	a1,1
ffffffffc02013ca:	854e                	mv	a0,s3
ffffffffc02013cc:	5df000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013d0:	4585                	li	a1,1
ffffffffc02013d2:	8552                	mv	a0,s4
ffffffffc02013d4:	5d7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013d8:	4818                	lw	a4,16(s0)
ffffffffc02013da:	478d                	li	a5,3
ffffffffc02013dc:	28f71863          	bne	a4,a5,ffffffffc020166c <default_check+0x3a2>
ffffffffc02013e0:	4505                	li	a0,1
ffffffffc02013e2:	58b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013e6:	89aa                	mv	s3,a0
ffffffffc02013e8:	26050263          	beqz	a0,ffffffffc020164c <default_check+0x382>
ffffffffc02013ec:	4505                	li	a0,1
ffffffffc02013ee:	57f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013f2:	8aaa                	mv	s5,a0
ffffffffc02013f4:	3a050c63          	beqz	a0,ffffffffc02017ac <default_check+0x4e2>
ffffffffc02013f8:	4505                	li	a0,1
ffffffffc02013fa:	573000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013fe:	8a2a                	mv	s4,a0
ffffffffc0201400:	38050663          	beqz	a0,ffffffffc020178c <default_check+0x4c2>
ffffffffc0201404:	4505                	li	a0,1
ffffffffc0201406:	567000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020140a:	36051163          	bnez	a0,ffffffffc020176c <default_check+0x4a2>
ffffffffc020140e:	4585                	li	a1,1
ffffffffc0201410:	854e                	mv	a0,s3
ffffffffc0201412:	599000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201416:	641c                	ld	a5,8(s0)
ffffffffc0201418:	20878a63          	beq	a5,s0,ffffffffc020162c <default_check+0x362>
ffffffffc020141c:	4505                	li	a0,1
ffffffffc020141e:	54f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201422:	30a99563          	bne	s3,a0,ffffffffc020172c <default_check+0x462>
ffffffffc0201426:	4505                	li	a0,1
ffffffffc0201428:	545000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020142c:	2e051063          	bnez	a0,ffffffffc020170c <default_check+0x442>
ffffffffc0201430:	481c                	lw	a5,16(s0)
ffffffffc0201432:	2a079d63          	bnez	a5,ffffffffc02016ec <default_check+0x422>
ffffffffc0201436:	854e                	mv	a0,s3
ffffffffc0201438:	4585                	li	a1,1
ffffffffc020143a:	01843023          	sd	s8,0(s0)
ffffffffc020143e:	01743423          	sd	s7,8(s0)
ffffffffc0201442:	01642823          	sw	s6,16(s0)
ffffffffc0201446:	565000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020144a:	4585                	li	a1,1
ffffffffc020144c:	8556                	mv	a0,s5
ffffffffc020144e:	55d000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201452:	4585                	li	a1,1
ffffffffc0201454:	8552                	mv	a0,s4
ffffffffc0201456:	555000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020145a:	4515                	li	a0,5
ffffffffc020145c:	511000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201460:	89aa                	mv	s3,a0
ffffffffc0201462:	26050563          	beqz	a0,ffffffffc02016cc <default_check+0x402>
ffffffffc0201466:	651c                	ld	a5,8(a0)
ffffffffc0201468:	8385                	srli	a5,a5,0x1
ffffffffc020146a:	8b85                	andi	a5,a5,1
ffffffffc020146c:	54079063          	bnez	a5,ffffffffc02019ac <default_check+0x6e2>
ffffffffc0201470:	4505                	li	a0,1
ffffffffc0201472:	00043b03          	ld	s6,0(s0)
ffffffffc0201476:	00843a83          	ld	s5,8(s0)
ffffffffc020147a:	e000                	sd	s0,0(s0)
ffffffffc020147c:	e400                	sd	s0,8(s0)
ffffffffc020147e:	4ef000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201482:	50051563          	bnez	a0,ffffffffc020198c <default_check+0x6c2>
ffffffffc0201486:	08098a13          	addi	s4,s3,128
ffffffffc020148a:	8552                	mv	a0,s4
ffffffffc020148c:	458d                	li	a1,3
ffffffffc020148e:	01042b83          	lw	s7,16(s0)
ffffffffc0201492:	00090797          	auipc	a5,0x90
ffffffffc0201496:	3207a323          	sw	zero,806(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc020149a:	511000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020149e:	4511                	li	a0,4
ffffffffc02014a0:	4cd000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014a4:	4c051463          	bnez	a0,ffffffffc020196c <default_check+0x6a2>
ffffffffc02014a8:	0889b783          	ld	a5,136(s3)
ffffffffc02014ac:	8385                	srli	a5,a5,0x1
ffffffffc02014ae:	8b85                	andi	a5,a5,1
ffffffffc02014b0:	48078e63          	beqz	a5,ffffffffc020194c <default_check+0x682>
ffffffffc02014b4:	0909a703          	lw	a4,144(s3)
ffffffffc02014b8:	478d                	li	a5,3
ffffffffc02014ba:	48f71963          	bne	a4,a5,ffffffffc020194c <default_check+0x682>
ffffffffc02014be:	450d                	li	a0,3
ffffffffc02014c0:	4ad000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014c4:	8c2a                	mv	s8,a0
ffffffffc02014c6:	46050363          	beqz	a0,ffffffffc020192c <default_check+0x662>
ffffffffc02014ca:	4505                	li	a0,1
ffffffffc02014cc:	4a1000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014d0:	42051e63          	bnez	a0,ffffffffc020190c <default_check+0x642>
ffffffffc02014d4:	418a1c63          	bne	s4,s8,ffffffffc02018ec <default_check+0x622>
ffffffffc02014d8:	4585                	li	a1,1
ffffffffc02014da:	854e                	mv	a0,s3
ffffffffc02014dc:	4cf000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02014e0:	458d                	li	a1,3
ffffffffc02014e2:	8552                	mv	a0,s4
ffffffffc02014e4:	4c7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02014e8:	0089b783          	ld	a5,8(s3)
ffffffffc02014ec:	04098c13          	addi	s8,s3,64
ffffffffc02014f0:	8385                	srli	a5,a5,0x1
ffffffffc02014f2:	8b85                	andi	a5,a5,1
ffffffffc02014f4:	3c078c63          	beqz	a5,ffffffffc02018cc <default_check+0x602>
ffffffffc02014f8:	0109a703          	lw	a4,16(s3)
ffffffffc02014fc:	4785                	li	a5,1
ffffffffc02014fe:	3cf71763          	bne	a4,a5,ffffffffc02018cc <default_check+0x602>
ffffffffc0201502:	008a3783          	ld	a5,8(s4)
ffffffffc0201506:	8385                	srli	a5,a5,0x1
ffffffffc0201508:	8b85                	andi	a5,a5,1
ffffffffc020150a:	3a078163          	beqz	a5,ffffffffc02018ac <default_check+0x5e2>
ffffffffc020150e:	010a2703          	lw	a4,16(s4)
ffffffffc0201512:	478d                	li	a5,3
ffffffffc0201514:	38f71c63          	bne	a4,a5,ffffffffc02018ac <default_check+0x5e2>
ffffffffc0201518:	4505                	li	a0,1
ffffffffc020151a:	453000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020151e:	36a99763          	bne	s3,a0,ffffffffc020188c <default_check+0x5c2>
ffffffffc0201522:	4585                	li	a1,1
ffffffffc0201524:	487000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201528:	4509                	li	a0,2
ffffffffc020152a:	443000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020152e:	32aa1f63          	bne	s4,a0,ffffffffc020186c <default_check+0x5a2>
ffffffffc0201532:	4589                	li	a1,2
ffffffffc0201534:	477000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201538:	4585                	li	a1,1
ffffffffc020153a:	8562                	mv	a0,s8
ffffffffc020153c:	46f000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201540:	4515                	li	a0,5
ffffffffc0201542:	42b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201546:	89aa                	mv	s3,a0
ffffffffc0201548:	48050263          	beqz	a0,ffffffffc02019cc <default_check+0x702>
ffffffffc020154c:	4505                	li	a0,1
ffffffffc020154e:	41f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201552:	2c051d63          	bnez	a0,ffffffffc020182c <default_check+0x562>
ffffffffc0201556:	481c                	lw	a5,16(s0)
ffffffffc0201558:	2a079a63          	bnez	a5,ffffffffc020180c <default_check+0x542>
ffffffffc020155c:	4595                	li	a1,5
ffffffffc020155e:	854e                	mv	a0,s3
ffffffffc0201560:	01742823          	sw	s7,16(s0)
ffffffffc0201564:	01643023          	sd	s6,0(s0)
ffffffffc0201568:	01543423          	sd	s5,8(s0)
ffffffffc020156c:	43f000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201570:	641c                	ld	a5,8(s0)
ffffffffc0201572:	00878963          	beq	a5,s0,ffffffffc0201584 <default_check+0x2ba>
ffffffffc0201576:	ff87a703          	lw	a4,-8(a5)
ffffffffc020157a:	679c                	ld	a5,8(a5)
ffffffffc020157c:	397d                	addiw	s2,s2,-1
ffffffffc020157e:	9c99                	subw	s1,s1,a4
ffffffffc0201580:	fe879be3          	bne	a5,s0,ffffffffc0201576 <default_check+0x2ac>
ffffffffc0201584:	26091463          	bnez	s2,ffffffffc02017ec <default_check+0x522>
ffffffffc0201588:	46049263          	bnez	s1,ffffffffc02019ec <default_check+0x722>
ffffffffc020158c:	60a6                	ld	ra,72(sp)
ffffffffc020158e:	6406                	ld	s0,64(sp)
ffffffffc0201590:	74e2                	ld	s1,56(sp)
ffffffffc0201592:	7942                	ld	s2,48(sp)
ffffffffc0201594:	79a2                	ld	s3,40(sp)
ffffffffc0201596:	7a02                	ld	s4,32(sp)
ffffffffc0201598:	6ae2                	ld	s5,24(sp)
ffffffffc020159a:	6b42                	ld	s6,16(sp)
ffffffffc020159c:	6ba2                	ld	s7,8(sp)
ffffffffc020159e:	6c02                	ld	s8,0(sp)
ffffffffc02015a0:	6161                	addi	sp,sp,80
ffffffffc02015a2:	8082                	ret
ffffffffc02015a4:	4981                	li	s3,0
ffffffffc02015a6:	4481                	li	s1,0
ffffffffc02015a8:	4901                	li	s2,0
ffffffffc02015aa:	b38d                	j	ffffffffc020130c <default_check+0x42>
ffffffffc02015ac:	0000b697          	auipc	a3,0xb
ffffffffc02015b0:	80c68693          	addi	a3,a3,-2036 # ffffffffc020bdb8 <commands+0x950>
ffffffffc02015b4:	0000a617          	auipc	a2,0xa
ffffffffc02015b8:	0c460613          	addi	a2,a2,196 # ffffffffc020b678 <commands+0x210>
ffffffffc02015bc:	0ef00593          	li	a1,239
ffffffffc02015c0:	0000b517          	auipc	a0,0xb
ffffffffc02015c4:	80850513          	addi	a0,a0,-2040 # ffffffffc020bdc8 <commands+0x960>
ffffffffc02015c8:	ed7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02015cc:	0000b697          	auipc	a3,0xb
ffffffffc02015d0:	89468693          	addi	a3,a3,-1900 # ffffffffc020be60 <commands+0x9f8>
ffffffffc02015d4:	0000a617          	auipc	a2,0xa
ffffffffc02015d8:	0a460613          	addi	a2,a2,164 # ffffffffc020b678 <commands+0x210>
ffffffffc02015dc:	0bc00593          	li	a1,188
ffffffffc02015e0:	0000a517          	auipc	a0,0xa
ffffffffc02015e4:	7e850513          	addi	a0,a0,2024 # ffffffffc020bdc8 <commands+0x960>
ffffffffc02015e8:	eb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02015ec:	0000b697          	auipc	a3,0xb
ffffffffc02015f0:	89c68693          	addi	a3,a3,-1892 # ffffffffc020be88 <commands+0xa20>
ffffffffc02015f4:	0000a617          	auipc	a2,0xa
ffffffffc02015f8:	08460613          	addi	a2,a2,132 # ffffffffc020b678 <commands+0x210>
ffffffffc02015fc:	0bd00593          	li	a1,189
ffffffffc0201600:	0000a517          	auipc	a0,0xa
ffffffffc0201604:	7c850513          	addi	a0,a0,1992 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201608:	e97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020160c:	0000b697          	auipc	a3,0xb
ffffffffc0201610:	8bc68693          	addi	a3,a3,-1860 # ffffffffc020bec8 <commands+0xa60>
ffffffffc0201614:	0000a617          	auipc	a2,0xa
ffffffffc0201618:	06460613          	addi	a2,a2,100 # ffffffffc020b678 <commands+0x210>
ffffffffc020161c:	0bf00593          	li	a1,191
ffffffffc0201620:	0000a517          	auipc	a0,0xa
ffffffffc0201624:	7a850513          	addi	a0,a0,1960 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201628:	e77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020162c:	0000b697          	auipc	a3,0xb
ffffffffc0201630:	92468693          	addi	a3,a3,-1756 # ffffffffc020bf50 <commands+0xae8>
ffffffffc0201634:	0000a617          	auipc	a2,0xa
ffffffffc0201638:	04460613          	addi	a2,a2,68 # ffffffffc020b678 <commands+0x210>
ffffffffc020163c:	0d800593          	li	a1,216
ffffffffc0201640:	0000a517          	auipc	a0,0xa
ffffffffc0201644:	78850513          	addi	a0,a0,1928 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201648:	e57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020164c:	0000a697          	auipc	a3,0xa
ffffffffc0201650:	7b468693          	addi	a3,a3,1972 # ffffffffc020be00 <commands+0x998>
ffffffffc0201654:	0000a617          	auipc	a2,0xa
ffffffffc0201658:	02460613          	addi	a2,a2,36 # ffffffffc020b678 <commands+0x210>
ffffffffc020165c:	0d100593          	li	a1,209
ffffffffc0201660:	0000a517          	auipc	a0,0xa
ffffffffc0201664:	76850513          	addi	a0,a0,1896 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201668:	e37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020166c:	0000b697          	auipc	a3,0xb
ffffffffc0201670:	8d468693          	addi	a3,a3,-1836 # ffffffffc020bf40 <commands+0xad8>
ffffffffc0201674:	0000a617          	auipc	a2,0xa
ffffffffc0201678:	00460613          	addi	a2,a2,4 # ffffffffc020b678 <commands+0x210>
ffffffffc020167c:	0cf00593          	li	a1,207
ffffffffc0201680:	0000a517          	auipc	a0,0xa
ffffffffc0201684:	74850513          	addi	a0,a0,1864 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201688:	e17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020168c:	0000b697          	auipc	a3,0xb
ffffffffc0201690:	89c68693          	addi	a3,a3,-1892 # ffffffffc020bf28 <commands+0xac0>
ffffffffc0201694:	0000a617          	auipc	a2,0xa
ffffffffc0201698:	fe460613          	addi	a2,a2,-28 # ffffffffc020b678 <commands+0x210>
ffffffffc020169c:	0ca00593          	li	a1,202
ffffffffc02016a0:	0000a517          	auipc	a0,0xa
ffffffffc02016a4:	72850513          	addi	a0,a0,1832 # ffffffffc020bdc8 <commands+0x960>
ffffffffc02016a8:	df7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016ac:	0000b697          	auipc	a3,0xb
ffffffffc02016b0:	85c68693          	addi	a3,a3,-1956 # ffffffffc020bf08 <commands+0xaa0>
ffffffffc02016b4:	0000a617          	auipc	a2,0xa
ffffffffc02016b8:	fc460613          	addi	a2,a2,-60 # ffffffffc020b678 <commands+0x210>
ffffffffc02016bc:	0c100593          	li	a1,193
ffffffffc02016c0:	0000a517          	auipc	a0,0xa
ffffffffc02016c4:	70850513          	addi	a0,a0,1800 # ffffffffc020bdc8 <commands+0x960>
ffffffffc02016c8:	dd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016cc:	0000b697          	auipc	a3,0xb
ffffffffc02016d0:	8cc68693          	addi	a3,a3,-1844 # ffffffffc020bf98 <commands+0xb30>
ffffffffc02016d4:	0000a617          	auipc	a2,0xa
ffffffffc02016d8:	fa460613          	addi	a2,a2,-92 # ffffffffc020b678 <commands+0x210>
ffffffffc02016dc:	0f700593          	li	a1,247
ffffffffc02016e0:	0000a517          	auipc	a0,0xa
ffffffffc02016e4:	6e850513          	addi	a0,a0,1768 # ffffffffc020bdc8 <commands+0x960>
ffffffffc02016e8:	db7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016ec:	0000b697          	auipc	a3,0xb
ffffffffc02016f0:	89c68693          	addi	a3,a3,-1892 # ffffffffc020bf88 <commands+0xb20>
ffffffffc02016f4:	0000a617          	auipc	a2,0xa
ffffffffc02016f8:	f8460613          	addi	a2,a2,-124 # ffffffffc020b678 <commands+0x210>
ffffffffc02016fc:	0de00593          	li	a1,222
ffffffffc0201700:	0000a517          	auipc	a0,0xa
ffffffffc0201704:	6c850513          	addi	a0,a0,1736 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201708:	d97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020170c:	0000b697          	auipc	a3,0xb
ffffffffc0201710:	81c68693          	addi	a3,a3,-2020 # ffffffffc020bf28 <commands+0xac0>
ffffffffc0201714:	0000a617          	auipc	a2,0xa
ffffffffc0201718:	f6460613          	addi	a2,a2,-156 # ffffffffc020b678 <commands+0x210>
ffffffffc020171c:	0dc00593          	li	a1,220
ffffffffc0201720:	0000a517          	auipc	a0,0xa
ffffffffc0201724:	6a850513          	addi	a0,a0,1704 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201728:	d77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020172c:	0000b697          	auipc	a3,0xb
ffffffffc0201730:	83c68693          	addi	a3,a3,-1988 # ffffffffc020bf68 <commands+0xb00>
ffffffffc0201734:	0000a617          	auipc	a2,0xa
ffffffffc0201738:	f4460613          	addi	a2,a2,-188 # ffffffffc020b678 <commands+0x210>
ffffffffc020173c:	0db00593          	li	a1,219
ffffffffc0201740:	0000a517          	auipc	a0,0xa
ffffffffc0201744:	68850513          	addi	a0,a0,1672 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201748:	d57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020174c:	0000a697          	auipc	a3,0xa
ffffffffc0201750:	6b468693          	addi	a3,a3,1716 # ffffffffc020be00 <commands+0x998>
ffffffffc0201754:	0000a617          	auipc	a2,0xa
ffffffffc0201758:	f2460613          	addi	a2,a2,-220 # ffffffffc020b678 <commands+0x210>
ffffffffc020175c:	0b800593          	li	a1,184
ffffffffc0201760:	0000a517          	auipc	a0,0xa
ffffffffc0201764:	66850513          	addi	a0,a0,1640 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201768:	d37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020176c:	0000a697          	auipc	a3,0xa
ffffffffc0201770:	7bc68693          	addi	a3,a3,1980 # ffffffffc020bf28 <commands+0xac0>
ffffffffc0201774:	0000a617          	auipc	a2,0xa
ffffffffc0201778:	f0460613          	addi	a2,a2,-252 # ffffffffc020b678 <commands+0x210>
ffffffffc020177c:	0d500593          	li	a1,213
ffffffffc0201780:	0000a517          	auipc	a0,0xa
ffffffffc0201784:	64850513          	addi	a0,a0,1608 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201788:	d17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020178c:	0000a697          	auipc	a3,0xa
ffffffffc0201790:	6b468693          	addi	a3,a3,1716 # ffffffffc020be40 <commands+0x9d8>
ffffffffc0201794:	0000a617          	auipc	a2,0xa
ffffffffc0201798:	ee460613          	addi	a2,a2,-284 # ffffffffc020b678 <commands+0x210>
ffffffffc020179c:	0d300593          	li	a1,211
ffffffffc02017a0:	0000a517          	auipc	a0,0xa
ffffffffc02017a4:	62850513          	addi	a0,a0,1576 # ffffffffc020bdc8 <commands+0x960>
ffffffffc02017a8:	cf7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017ac:	0000a697          	auipc	a3,0xa
ffffffffc02017b0:	67468693          	addi	a3,a3,1652 # ffffffffc020be20 <commands+0x9b8>
ffffffffc02017b4:	0000a617          	auipc	a2,0xa
ffffffffc02017b8:	ec460613          	addi	a2,a2,-316 # ffffffffc020b678 <commands+0x210>
ffffffffc02017bc:	0d200593          	li	a1,210
ffffffffc02017c0:	0000a517          	auipc	a0,0xa
ffffffffc02017c4:	60850513          	addi	a0,a0,1544 # ffffffffc020bdc8 <commands+0x960>
ffffffffc02017c8:	cd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017cc:	0000a697          	auipc	a3,0xa
ffffffffc02017d0:	67468693          	addi	a3,a3,1652 # ffffffffc020be40 <commands+0x9d8>
ffffffffc02017d4:	0000a617          	auipc	a2,0xa
ffffffffc02017d8:	ea460613          	addi	a2,a2,-348 # ffffffffc020b678 <commands+0x210>
ffffffffc02017dc:	0ba00593          	li	a1,186
ffffffffc02017e0:	0000a517          	auipc	a0,0xa
ffffffffc02017e4:	5e850513          	addi	a0,a0,1512 # ffffffffc020bdc8 <commands+0x960>
ffffffffc02017e8:	cb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017ec:	0000b697          	auipc	a3,0xb
ffffffffc02017f0:	8fc68693          	addi	a3,a3,-1796 # ffffffffc020c0e8 <commands+0xc80>
ffffffffc02017f4:	0000a617          	auipc	a2,0xa
ffffffffc02017f8:	e8460613          	addi	a2,a2,-380 # ffffffffc020b678 <commands+0x210>
ffffffffc02017fc:	12400593          	li	a1,292
ffffffffc0201800:	0000a517          	auipc	a0,0xa
ffffffffc0201804:	5c850513          	addi	a0,a0,1480 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201808:	c97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020180c:	0000a697          	auipc	a3,0xa
ffffffffc0201810:	77c68693          	addi	a3,a3,1916 # ffffffffc020bf88 <commands+0xb20>
ffffffffc0201814:	0000a617          	auipc	a2,0xa
ffffffffc0201818:	e6460613          	addi	a2,a2,-412 # ffffffffc020b678 <commands+0x210>
ffffffffc020181c:	11900593          	li	a1,281
ffffffffc0201820:	0000a517          	auipc	a0,0xa
ffffffffc0201824:	5a850513          	addi	a0,a0,1448 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201828:	c77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020182c:	0000a697          	auipc	a3,0xa
ffffffffc0201830:	6fc68693          	addi	a3,a3,1788 # ffffffffc020bf28 <commands+0xac0>
ffffffffc0201834:	0000a617          	auipc	a2,0xa
ffffffffc0201838:	e4460613          	addi	a2,a2,-444 # ffffffffc020b678 <commands+0x210>
ffffffffc020183c:	11700593          	li	a1,279
ffffffffc0201840:	0000a517          	auipc	a0,0xa
ffffffffc0201844:	58850513          	addi	a0,a0,1416 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201848:	c57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020184c:	0000a697          	auipc	a3,0xa
ffffffffc0201850:	69c68693          	addi	a3,a3,1692 # ffffffffc020bee8 <commands+0xa80>
ffffffffc0201854:	0000a617          	auipc	a2,0xa
ffffffffc0201858:	e2460613          	addi	a2,a2,-476 # ffffffffc020b678 <commands+0x210>
ffffffffc020185c:	0c000593          	li	a1,192
ffffffffc0201860:	0000a517          	auipc	a0,0xa
ffffffffc0201864:	56850513          	addi	a0,a0,1384 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201868:	c37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020186c:	0000b697          	auipc	a3,0xb
ffffffffc0201870:	83c68693          	addi	a3,a3,-1988 # ffffffffc020c0a8 <commands+0xc40>
ffffffffc0201874:	0000a617          	auipc	a2,0xa
ffffffffc0201878:	e0460613          	addi	a2,a2,-508 # ffffffffc020b678 <commands+0x210>
ffffffffc020187c:	11100593          	li	a1,273
ffffffffc0201880:	0000a517          	auipc	a0,0xa
ffffffffc0201884:	54850513          	addi	a0,a0,1352 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201888:	c17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020188c:	0000a697          	auipc	a3,0xa
ffffffffc0201890:	7fc68693          	addi	a3,a3,2044 # ffffffffc020c088 <commands+0xc20>
ffffffffc0201894:	0000a617          	auipc	a2,0xa
ffffffffc0201898:	de460613          	addi	a2,a2,-540 # ffffffffc020b678 <commands+0x210>
ffffffffc020189c:	10f00593          	li	a1,271
ffffffffc02018a0:	0000a517          	auipc	a0,0xa
ffffffffc02018a4:	52850513          	addi	a0,a0,1320 # ffffffffc020bdc8 <commands+0x960>
ffffffffc02018a8:	bf7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018ac:	0000a697          	auipc	a3,0xa
ffffffffc02018b0:	7b468693          	addi	a3,a3,1972 # ffffffffc020c060 <commands+0xbf8>
ffffffffc02018b4:	0000a617          	auipc	a2,0xa
ffffffffc02018b8:	dc460613          	addi	a2,a2,-572 # ffffffffc020b678 <commands+0x210>
ffffffffc02018bc:	10d00593          	li	a1,269
ffffffffc02018c0:	0000a517          	auipc	a0,0xa
ffffffffc02018c4:	50850513          	addi	a0,a0,1288 # ffffffffc020bdc8 <commands+0x960>
ffffffffc02018c8:	bd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018cc:	0000a697          	auipc	a3,0xa
ffffffffc02018d0:	76c68693          	addi	a3,a3,1900 # ffffffffc020c038 <commands+0xbd0>
ffffffffc02018d4:	0000a617          	auipc	a2,0xa
ffffffffc02018d8:	da460613          	addi	a2,a2,-604 # ffffffffc020b678 <commands+0x210>
ffffffffc02018dc:	10c00593          	li	a1,268
ffffffffc02018e0:	0000a517          	auipc	a0,0xa
ffffffffc02018e4:	4e850513          	addi	a0,a0,1256 # ffffffffc020bdc8 <commands+0x960>
ffffffffc02018e8:	bb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018ec:	0000a697          	auipc	a3,0xa
ffffffffc02018f0:	73c68693          	addi	a3,a3,1852 # ffffffffc020c028 <commands+0xbc0>
ffffffffc02018f4:	0000a617          	auipc	a2,0xa
ffffffffc02018f8:	d8460613          	addi	a2,a2,-636 # ffffffffc020b678 <commands+0x210>
ffffffffc02018fc:	10700593          	li	a1,263
ffffffffc0201900:	0000a517          	auipc	a0,0xa
ffffffffc0201904:	4c850513          	addi	a0,a0,1224 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201908:	b97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020190c:	0000a697          	auipc	a3,0xa
ffffffffc0201910:	61c68693          	addi	a3,a3,1564 # ffffffffc020bf28 <commands+0xac0>
ffffffffc0201914:	0000a617          	auipc	a2,0xa
ffffffffc0201918:	d6460613          	addi	a2,a2,-668 # ffffffffc020b678 <commands+0x210>
ffffffffc020191c:	10600593          	li	a1,262
ffffffffc0201920:	0000a517          	auipc	a0,0xa
ffffffffc0201924:	4a850513          	addi	a0,a0,1192 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201928:	b77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020192c:	0000a697          	auipc	a3,0xa
ffffffffc0201930:	6dc68693          	addi	a3,a3,1756 # ffffffffc020c008 <commands+0xba0>
ffffffffc0201934:	0000a617          	auipc	a2,0xa
ffffffffc0201938:	d4460613          	addi	a2,a2,-700 # ffffffffc020b678 <commands+0x210>
ffffffffc020193c:	10500593          	li	a1,261
ffffffffc0201940:	0000a517          	auipc	a0,0xa
ffffffffc0201944:	48850513          	addi	a0,a0,1160 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201948:	b57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020194c:	0000a697          	auipc	a3,0xa
ffffffffc0201950:	68c68693          	addi	a3,a3,1676 # ffffffffc020bfd8 <commands+0xb70>
ffffffffc0201954:	0000a617          	auipc	a2,0xa
ffffffffc0201958:	d2460613          	addi	a2,a2,-732 # ffffffffc020b678 <commands+0x210>
ffffffffc020195c:	10400593          	li	a1,260
ffffffffc0201960:	0000a517          	auipc	a0,0xa
ffffffffc0201964:	46850513          	addi	a0,a0,1128 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201968:	b37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020196c:	0000a697          	auipc	a3,0xa
ffffffffc0201970:	65468693          	addi	a3,a3,1620 # ffffffffc020bfc0 <commands+0xb58>
ffffffffc0201974:	0000a617          	auipc	a2,0xa
ffffffffc0201978:	d0460613          	addi	a2,a2,-764 # ffffffffc020b678 <commands+0x210>
ffffffffc020197c:	10300593          	li	a1,259
ffffffffc0201980:	0000a517          	auipc	a0,0xa
ffffffffc0201984:	44850513          	addi	a0,a0,1096 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201988:	b17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020198c:	0000a697          	auipc	a3,0xa
ffffffffc0201990:	59c68693          	addi	a3,a3,1436 # ffffffffc020bf28 <commands+0xac0>
ffffffffc0201994:	0000a617          	auipc	a2,0xa
ffffffffc0201998:	ce460613          	addi	a2,a2,-796 # ffffffffc020b678 <commands+0x210>
ffffffffc020199c:	0fd00593          	li	a1,253
ffffffffc02019a0:	0000a517          	auipc	a0,0xa
ffffffffc02019a4:	42850513          	addi	a0,a0,1064 # ffffffffc020bdc8 <commands+0x960>
ffffffffc02019a8:	af7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019ac:	0000a697          	auipc	a3,0xa
ffffffffc02019b0:	5fc68693          	addi	a3,a3,1532 # ffffffffc020bfa8 <commands+0xb40>
ffffffffc02019b4:	0000a617          	auipc	a2,0xa
ffffffffc02019b8:	cc460613          	addi	a2,a2,-828 # ffffffffc020b678 <commands+0x210>
ffffffffc02019bc:	0f800593          	li	a1,248
ffffffffc02019c0:	0000a517          	auipc	a0,0xa
ffffffffc02019c4:	40850513          	addi	a0,a0,1032 # ffffffffc020bdc8 <commands+0x960>
ffffffffc02019c8:	ad7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019cc:	0000a697          	auipc	a3,0xa
ffffffffc02019d0:	6fc68693          	addi	a3,a3,1788 # ffffffffc020c0c8 <commands+0xc60>
ffffffffc02019d4:	0000a617          	auipc	a2,0xa
ffffffffc02019d8:	ca460613          	addi	a2,a2,-860 # ffffffffc020b678 <commands+0x210>
ffffffffc02019dc:	11600593          	li	a1,278
ffffffffc02019e0:	0000a517          	auipc	a0,0xa
ffffffffc02019e4:	3e850513          	addi	a0,a0,1000 # ffffffffc020bdc8 <commands+0x960>
ffffffffc02019e8:	ab7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019ec:	0000a697          	auipc	a3,0xa
ffffffffc02019f0:	70c68693          	addi	a3,a3,1804 # ffffffffc020c0f8 <commands+0xc90>
ffffffffc02019f4:	0000a617          	auipc	a2,0xa
ffffffffc02019f8:	c8460613          	addi	a2,a2,-892 # ffffffffc020b678 <commands+0x210>
ffffffffc02019fc:	12500593          	li	a1,293
ffffffffc0201a00:	0000a517          	auipc	a0,0xa
ffffffffc0201a04:	3c850513          	addi	a0,a0,968 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201a08:	a97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a0c:	0000a697          	auipc	a3,0xa
ffffffffc0201a10:	3d468693          	addi	a3,a3,980 # ffffffffc020bde0 <commands+0x978>
ffffffffc0201a14:	0000a617          	auipc	a2,0xa
ffffffffc0201a18:	c6460613          	addi	a2,a2,-924 # ffffffffc020b678 <commands+0x210>
ffffffffc0201a1c:	0f200593          	li	a1,242
ffffffffc0201a20:	0000a517          	auipc	a0,0xa
ffffffffc0201a24:	3a850513          	addi	a0,a0,936 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201a28:	a77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a2c:	0000a697          	auipc	a3,0xa
ffffffffc0201a30:	3f468693          	addi	a3,a3,1012 # ffffffffc020be20 <commands+0x9b8>
ffffffffc0201a34:	0000a617          	auipc	a2,0xa
ffffffffc0201a38:	c4460613          	addi	a2,a2,-956 # ffffffffc020b678 <commands+0x210>
ffffffffc0201a3c:	0b900593          	li	a1,185
ffffffffc0201a40:	0000a517          	auipc	a0,0xa
ffffffffc0201a44:	38850513          	addi	a0,a0,904 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201a48:	a57fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201a4c <default_free_pages>:
ffffffffc0201a4c:	1141                	addi	sp,sp,-16
ffffffffc0201a4e:	e406                	sd	ra,8(sp)
ffffffffc0201a50:	14058463          	beqz	a1,ffffffffc0201b98 <default_free_pages+0x14c>
ffffffffc0201a54:	00659693          	slli	a3,a1,0x6
ffffffffc0201a58:	96aa                	add	a3,a3,a0
ffffffffc0201a5a:	87aa                	mv	a5,a0
ffffffffc0201a5c:	02d50263          	beq	a0,a3,ffffffffc0201a80 <default_free_pages+0x34>
ffffffffc0201a60:	6798                	ld	a4,8(a5)
ffffffffc0201a62:	8b05                	andi	a4,a4,1
ffffffffc0201a64:	10071a63          	bnez	a4,ffffffffc0201b78 <default_free_pages+0x12c>
ffffffffc0201a68:	6798                	ld	a4,8(a5)
ffffffffc0201a6a:	8b09                	andi	a4,a4,2
ffffffffc0201a6c:	10071663          	bnez	a4,ffffffffc0201b78 <default_free_pages+0x12c>
ffffffffc0201a70:	0007b423          	sd	zero,8(a5)
ffffffffc0201a74:	0007a023          	sw	zero,0(a5)
ffffffffc0201a78:	04078793          	addi	a5,a5,64
ffffffffc0201a7c:	fed792e3          	bne	a5,a3,ffffffffc0201a60 <default_free_pages+0x14>
ffffffffc0201a80:	2581                	sext.w	a1,a1
ffffffffc0201a82:	c90c                	sw	a1,16(a0)
ffffffffc0201a84:	00850893          	addi	a7,a0,8
ffffffffc0201a88:	4789                	li	a5,2
ffffffffc0201a8a:	40f8b02f          	amoor.d	zero,a5,(a7)
ffffffffc0201a8e:	00090697          	auipc	a3,0x90
ffffffffc0201a92:	d1a68693          	addi	a3,a3,-742 # ffffffffc02917a8 <free_area>
ffffffffc0201a96:	4a98                	lw	a4,16(a3)
ffffffffc0201a98:	669c                	ld	a5,8(a3)
ffffffffc0201a9a:	01850613          	addi	a2,a0,24
ffffffffc0201a9e:	9db9                	addw	a1,a1,a4
ffffffffc0201aa0:	ca8c                	sw	a1,16(a3)
ffffffffc0201aa2:	0ad78463          	beq	a5,a3,ffffffffc0201b4a <default_free_pages+0xfe>
ffffffffc0201aa6:	fe878713          	addi	a4,a5,-24
ffffffffc0201aaa:	0006b803          	ld	a6,0(a3)
ffffffffc0201aae:	4581                	li	a1,0
ffffffffc0201ab0:	00e56a63          	bltu	a0,a4,ffffffffc0201ac4 <default_free_pages+0x78>
ffffffffc0201ab4:	6798                	ld	a4,8(a5)
ffffffffc0201ab6:	04d70c63          	beq	a4,a3,ffffffffc0201b0e <default_free_pages+0xc2>
ffffffffc0201aba:	87ba                	mv	a5,a4
ffffffffc0201abc:	fe878713          	addi	a4,a5,-24
ffffffffc0201ac0:	fee57ae3          	bgeu	a0,a4,ffffffffc0201ab4 <default_free_pages+0x68>
ffffffffc0201ac4:	c199                	beqz	a1,ffffffffc0201aca <default_free_pages+0x7e>
ffffffffc0201ac6:	0106b023          	sd	a6,0(a3)
ffffffffc0201aca:	6398                	ld	a4,0(a5)
ffffffffc0201acc:	e390                	sd	a2,0(a5)
ffffffffc0201ace:	e710                	sd	a2,8(a4)
ffffffffc0201ad0:	f11c                	sd	a5,32(a0)
ffffffffc0201ad2:	ed18                	sd	a4,24(a0)
ffffffffc0201ad4:	00d70d63          	beq	a4,a3,ffffffffc0201aee <default_free_pages+0xa2>
ffffffffc0201ad8:	ff872583          	lw	a1,-8(a4)
ffffffffc0201adc:	fe870613          	addi	a2,a4,-24
ffffffffc0201ae0:	02059813          	slli	a6,a1,0x20
ffffffffc0201ae4:	01a85793          	srli	a5,a6,0x1a
ffffffffc0201ae8:	97b2                	add	a5,a5,a2
ffffffffc0201aea:	02f50c63          	beq	a0,a5,ffffffffc0201b22 <default_free_pages+0xd6>
ffffffffc0201aee:	711c                	ld	a5,32(a0)
ffffffffc0201af0:	00d78c63          	beq	a5,a3,ffffffffc0201b08 <default_free_pages+0xbc>
ffffffffc0201af4:	4910                	lw	a2,16(a0)
ffffffffc0201af6:	fe878693          	addi	a3,a5,-24
ffffffffc0201afa:	02061593          	slli	a1,a2,0x20
ffffffffc0201afe:	01a5d713          	srli	a4,a1,0x1a
ffffffffc0201b02:	972a                	add	a4,a4,a0
ffffffffc0201b04:	04e68a63          	beq	a3,a4,ffffffffc0201b58 <default_free_pages+0x10c>
ffffffffc0201b08:	60a2                	ld	ra,8(sp)
ffffffffc0201b0a:	0141                	addi	sp,sp,16
ffffffffc0201b0c:	8082                	ret
ffffffffc0201b0e:	e790                	sd	a2,8(a5)
ffffffffc0201b10:	f114                	sd	a3,32(a0)
ffffffffc0201b12:	6798                	ld	a4,8(a5)
ffffffffc0201b14:	ed1c                	sd	a5,24(a0)
ffffffffc0201b16:	02d70763          	beq	a4,a3,ffffffffc0201b44 <default_free_pages+0xf8>
ffffffffc0201b1a:	8832                	mv	a6,a2
ffffffffc0201b1c:	4585                	li	a1,1
ffffffffc0201b1e:	87ba                	mv	a5,a4
ffffffffc0201b20:	bf71                	j	ffffffffc0201abc <default_free_pages+0x70>
ffffffffc0201b22:	491c                	lw	a5,16(a0)
ffffffffc0201b24:	9dbd                	addw	a1,a1,a5
ffffffffc0201b26:	feb72c23          	sw	a1,-8(a4)
ffffffffc0201b2a:	57f5                	li	a5,-3
ffffffffc0201b2c:	60f8b02f          	amoand.d	zero,a5,(a7)
ffffffffc0201b30:	01853803          	ld	a6,24(a0)
ffffffffc0201b34:	710c                	ld	a1,32(a0)
ffffffffc0201b36:	8532                	mv	a0,a2
ffffffffc0201b38:	00b83423          	sd	a1,8(a6)
ffffffffc0201b3c:	671c                	ld	a5,8(a4)
ffffffffc0201b3e:	0105b023          	sd	a6,0(a1)
ffffffffc0201b42:	b77d                	j	ffffffffc0201af0 <default_free_pages+0xa4>
ffffffffc0201b44:	e290                	sd	a2,0(a3)
ffffffffc0201b46:	873e                	mv	a4,a5
ffffffffc0201b48:	bf41                	j	ffffffffc0201ad8 <default_free_pages+0x8c>
ffffffffc0201b4a:	60a2                	ld	ra,8(sp)
ffffffffc0201b4c:	e390                	sd	a2,0(a5)
ffffffffc0201b4e:	e790                	sd	a2,8(a5)
ffffffffc0201b50:	f11c                	sd	a5,32(a0)
ffffffffc0201b52:	ed1c                	sd	a5,24(a0)
ffffffffc0201b54:	0141                	addi	sp,sp,16
ffffffffc0201b56:	8082                	ret
ffffffffc0201b58:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201b5c:	ff078693          	addi	a3,a5,-16
ffffffffc0201b60:	9e39                	addw	a2,a2,a4
ffffffffc0201b62:	c910                	sw	a2,16(a0)
ffffffffc0201b64:	5775                	li	a4,-3
ffffffffc0201b66:	60e6b02f          	amoand.d	zero,a4,(a3)
ffffffffc0201b6a:	6398                	ld	a4,0(a5)
ffffffffc0201b6c:	679c                	ld	a5,8(a5)
ffffffffc0201b6e:	60a2                	ld	ra,8(sp)
ffffffffc0201b70:	e71c                	sd	a5,8(a4)
ffffffffc0201b72:	e398                	sd	a4,0(a5)
ffffffffc0201b74:	0141                	addi	sp,sp,16
ffffffffc0201b76:	8082                	ret
ffffffffc0201b78:	0000a697          	auipc	a3,0xa
ffffffffc0201b7c:	59868693          	addi	a3,a3,1432 # ffffffffc020c110 <commands+0xca8>
ffffffffc0201b80:	0000a617          	auipc	a2,0xa
ffffffffc0201b84:	af860613          	addi	a2,a2,-1288 # ffffffffc020b678 <commands+0x210>
ffffffffc0201b88:	08200593          	li	a1,130
ffffffffc0201b8c:	0000a517          	auipc	a0,0xa
ffffffffc0201b90:	23c50513          	addi	a0,a0,572 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201b94:	90bfe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201b98:	0000a697          	auipc	a3,0xa
ffffffffc0201b9c:	57068693          	addi	a3,a3,1392 # ffffffffc020c108 <commands+0xca0>
ffffffffc0201ba0:	0000a617          	auipc	a2,0xa
ffffffffc0201ba4:	ad860613          	addi	a2,a2,-1320 # ffffffffc020b678 <commands+0x210>
ffffffffc0201ba8:	07f00593          	li	a1,127
ffffffffc0201bac:	0000a517          	auipc	a0,0xa
ffffffffc0201bb0:	21c50513          	addi	a0,a0,540 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201bb4:	8ebfe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201bb8 <default_alloc_pages>:
ffffffffc0201bb8:	c941                	beqz	a0,ffffffffc0201c48 <default_alloc_pages+0x90>
ffffffffc0201bba:	00090597          	auipc	a1,0x90
ffffffffc0201bbe:	bee58593          	addi	a1,a1,-1042 # ffffffffc02917a8 <free_area>
ffffffffc0201bc2:	0105a803          	lw	a6,16(a1)
ffffffffc0201bc6:	872a                	mv	a4,a0
ffffffffc0201bc8:	02081793          	slli	a5,a6,0x20
ffffffffc0201bcc:	9381                	srli	a5,a5,0x20
ffffffffc0201bce:	00a7ee63          	bltu	a5,a0,ffffffffc0201bea <default_alloc_pages+0x32>
ffffffffc0201bd2:	87ae                	mv	a5,a1
ffffffffc0201bd4:	a801                	j	ffffffffc0201be4 <default_alloc_pages+0x2c>
ffffffffc0201bd6:	ff87a683          	lw	a3,-8(a5)
ffffffffc0201bda:	02069613          	slli	a2,a3,0x20
ffffffffc0201bde:	9201                	srli	a2,a2,0x20
ffffffffc0201be0:	00e67763          	bgeu	a2,a4,ffffffffc0201bee <default_alloc_pages+0x36>
ffffffffc0201be4:	679c                	ld	a5,8(a5)
ffffffffc0201be6:	feb798e3          	bne	a5,a1,ffffffffc0201bd6 <default_alloc_pages+0x1e>
ffffffffc0201bea:	4501                	li	a0,0
ffffffffc0201bec:	8082                	ret
ffffffffc0201bee:	0007b883          	ld	a7,0(a5)
ffffffffc0201bf2:	0087b303          	ld	t1,8(a5)
ffffffffc0201bf6:	fe878513          	addi	a0,a5,-24
ffffffffc0201bfa:	00070e1b          	sext.w	t3,a4
ffffffffc0201bfe:	0068b423          	sd	t1,8(a7) # 10000008 <_binary_bin_sfs_img_size+0xff8ad08>
ffffffffc0201c02:	01133023          	sd	a7,0(t1)
ffffffffc0201c06:	02c77863          	bgeu	a4,a2,ffffffffc0201c36 <default_alloc_pages+0x7e>
ffffffffc0201c0a:	071a                	slli	a4,a4,0x6
ffffffffc0201c0c:	972a                	add	a4,a4,a0
ffffffffc0201c0e:	41c686bb          	subw	a3,a3,t3
ffffffffc0201c12:	cb14                	sw	a3,16(a4)
ffffffffc0201c14:	00870613          	addi	a2,a4,8
ffffffffc0201c18:	4689                	li	a3,2
ffffffffc0201c1a:	40d6302f          	amoor.d	zero,a3,(a2)
ffffffffc0201c1e:	0088b683          	ld	a3,8(a7)
ffffffffc0201c22:	01870613          	addi	a2,a4,24
ffffffffc0201c26:	0105a803          	lw	a6,16(a1)
ffffffffc0201c2a:	e290                	sd	a2,0(a3)
ffffffffc0201c2c:	00c8b423          	sd	a2,8(a7)
ffffffffc0201c30:	f314                	sd	a3,32(a4)
ffffffffc0201c32:	01173c23          	sd	a7,24(a4)
ffffffffc0201c36:	41c8083b          	subw	a6,a6,t3
ffffffffc0201c3a:	0105a823          	sw	a6,16(a1)
ffffffffc0201c3e:	5775                	li	a4,-3
ffffffffc0201c40:	17c1                	addi	a5,a5,-16
ffffffffc0201c42:	60e7b02f          	amoand.d	zero,a4,(a5)
ffffffffc0201c46:	8082                	ret
ffffffffc0201c48:	1141                	addi	sp,sp,-16
ffffffffc0201c4a:	0000a697          	auipc	a3,0xa
ffffffffc0201c4e:	4be68693          	addi	a3,a3,1214 # ffffffffc020c108 <commands+0xca0>
ffffffffc0201c52:	0000a617          	auipc	a2,0xa
ffffffffc0201c56:	a2660613          	addi	a2,a2,-1498 # ffffffffc020b678 <commands+0x210>
ffffffffc0201c5a:	06100593          	li	a1,97
ffffffffc0201c5e:	0000a517          	auipc	a0,0xa
ffffffffc0201c62:	16a50513          	addi	a0,a0,362 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201c66:	e406                	sd	ra,8(sp)
ffffffffc0201c68:	837fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201c6c <default_init_memmap>:
ffffffffc0201c6c:	1141                	addi	sp,sp,-16
ffffffffc0201c6e:	e406                	sd	ra,8(sp)
ffffffffc0201c70:	c5f1                	beqz	a1,ffffffffc0201d3c <default_init_memmap+0xd0>
ffffffffc0201c72:	00659693          	slli	a3,a1,0x6
ffffffffc0201c76:	96aa                	add	a3,a3,a0
ffffffffc0201c78:	87aa                	mv	a5,a0
ffffffffc0201c7a:	00d50f63          	beq	a0,a3,ffffffffc0201c98 <default_init_memmap+0x2c>
ffffffffc0201c7e:	6798                	ld	a4,8(a5)
ffffffffc0201c80:	8b05                	andi	a4,a4,1
ffffffffc0201c82:	cf49                	beqz	a4,ffffffffc0201d1c <default_init_memmap+0xb0>
ffffffffc0201c84:	0007a823          	sw	zero,16(a5)
ffffffffc0201c88:	0007b423          	sd	zero,8(a5)
ffffffffc0201c8c:	0007a023          	sw	zero,0(a5)
ffffffffc0201c90:	04078793          	addi	a5,a5,64
ffffffffc0201c94:	fed795e3          	bne	a5,a3,ffffffffc0201c7e <default_init_memmap+0x12>
ffffffffc0201c98:	2581                	sext.w	a1,a1
ffffffffc0201c9a:	c90c                	sw	a1,16(a0)
ffffffffc0201c9c:	4789                	li	a5,2
ffffffffc0201c9e:	00850713          	addi	a4,a0,8
ffffffffc0201ca2:	40f7302f          	amoor.d	zero,a5,(a4)
ffffffffc0201ca6:	00090697          	auipc	a3,0x90
ffffffffc0201caa:	b0268693          	addi	a3,a3,-1278 # ffffffffc02917a8 <free_area>
ffffffffc0201cae:	4a98                	lw	a4,16(a3)
ffffffffc0201cb0:	669c                	ld	a5,8(a3)
ffffffffc0201cb2:	01850613          	addi	a2,a0,24
ffffffffc0201cb6:	9db9                	addw	a1,a1,a4
ffffffffc0201cb8:	ca8c                	sw	a1,16(a3)
ffffffffc0201cba:	04d78a63          	beq	a5,a3,ffffffffc0201d0e <default_init_memmap+0xa2>
ffffffffc0201cbe:	fe878713          	addi	a4,a5,-24
ffffffffc0201cc2:	0006b803          	ld	a6,0(a3)
ffffffffc0201cc6:	4581                	li	a1,0
ffffffffc0201cc8:	00e56a63          	bltu	a0,a4,ffffffffc0201cdc <default_init_memmap+0x70>
ffffffffc0201ccc:	6798                	ld	a4,8(a5)
ffffffffc0201cce:	02d70263          	beq	a4,a3,ffffffffc0201cf2 <default_init_memmap+0x86>
ffffffffc0201cd2:	87ba                	mv	a5,a4
ffffffffc0201cd4:	fe878713          	addi	a4,a5,-24
ffffffffc0201cd8:	fee57ae3          	bgeu	a0,a4,ffffffffc0201ccc <default_init_memmap+0x60>
ffffffffc0201cdc:	c199                	beqz	a1,ffffffffc0201ce2 <default_init_memmap+0x76>
ffffffffc0201cde:	0106b023          	sd	a6,0(a3)
ffffffffc0201ce2:	6398                	ld	a4,0(a5)
ffffffffc0201ce4:	60a2                	ld	ra,8(sp)
ffffffffc0201ce6:	e390                	sd	a2,0(a5)
ffffffffc0201ce8:	e710                	sd	a2,8(a4)
ffffffffc0201cea:	f11c                	sd	a5,32(a0)
ffffffffc0201cec:	ed18                	sd	a4,24(a0)
ffffffffc0201cee:	0141                	addi	sp,sp,16
ffffffffc0201cf0:	8082                	ret
ffffffffc0201cf2:	e790                	sd	a2,8(a5)
ffffffffc0201cf4:	f114                	sd	a3,32(a0)
ffffffffc0201cf6:	6798                	ld	a4,8(a5)
ffffffffc0201cf8:	ed1c                	sd	a5,24(a0)
ffffffffc0201cfa:	00d70663          	beq	a4,a3,ffffffffc0201d06 <default_init_memmap+0x9a>
ffffffffc0201cfe:	8832                	mv	a6,a2
ffffffffc0201d00:	4585                	li	a1,1
ffffffffc0201d02:	87ba                	mv	a5,a4
ffffffffc0201d04:	bfc1                	j	ffffffffc0201cd4 <default_init_memmap+0x68>
ffffffffc0201d06:	60a2                	ld	ra,8(sp)
ffffffffc0201d08:	e290                	sd	a2,0(a3)
ffffffffc0201d0a:	0141                	addi	sp,sp,16
ffffffffc0201d0c:	8082                	ret
ffffffffc0201d0e:	60a2                	ld	ra,8(sp)
ffffffffc0201d10:	e390                	sd	a2,0(a5)
ffffffffc0201d12:	e790                	sd	a2,8(a5)
ffffffffc0201d14:	f11c                	sd	a5,32(a0)
ffffffffc0201d16:	ed1c                	sd	a5,24(a0)
ffffffffc0201d18:	0141                	addi	sp,sp,16
ffffffffc0201d1a:	8082                	ret
ffffffffc0201d1c:	0000a697          	auipc	a3,0xa
ffffffffc0201d20:	41c68693          	addi	a3,a3,1052 # ffffffffc020c138 <commands+0xcd0>
ffffffffc0201d24:	0000a617          	auipc	a2,0xa
ffffffffc0201d28:	95460613          	addi	a2,a2,-1708 # ffffffffc020b678 <commands+0x210>
ffffffffc0201d2c:	04800593          	li	a1,72
ffffffffc0201d30:	0000a517          	auipc	a0,0xa
ffffffffc0201d34:	09850513          	addi	a0,a0,152 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201d38:	f66fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201d3c:	0000a697          	auipc	a3,0xa
ffffffffc0201d40:	3cc68693          	addi	a3,a3,972 # ffffffffc020c108 <commands+0xca0>
ffffffffc0201d44:	0000a617          	auipc	a2,0xa
ffffffffc0201d48:	93460613          	addi	a2,a2,-1740 # ffffffffc020b678 <commands+0x210>
ffffffffc0201d4c:	04500593          	li	a1,69
ffffffffc0201d50:	0000a517          	auipc	a0,0xa
ffffffffc0201d54:	07850513          	addi	a0,a0,120 # ffffffffc020bdc8 <commands+0x960>
ffffffffc0201d58:	f46fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201d5c <slob_free>:
ffffffffc0201d5c:	c94d                	beqz	a0,ffffffffc0201e0e <slob_free+0xb2>
ffffffffc0201d5e:	1141                	addi	sp,sp,-16
ffffffffc0201d60:	e022                	sd	s0,0(sp)
ffffffffc0201d62:	e406                	sd	ra,8(sp)
ffffffffc0201d64:	842a                	mv	s0,a0
ffffffffc0201d66:	e9c1                	bnez	a1,ffffffffc0201df6 <slob_free+0x9a>
ffffffffc0201d68:	100027f3          	csrr	a5,sstatus
ffffffffc0201d6c:	8b89                	andi	a5,a5,2
ffffffffc0201d6e:	4501                	li	a0,0
ffffffffc0201d70:	ebd9                	bnez	a5,ffffffffc0201e06 <slob_free+0xaa>
ffffffffc0201d72:	0008f617          	auipc	a2,0x8f
ffffffffc0201d76:	2de60613          	addi	a2,a2,734 # ffffffffc0291050 <slobfree>
ffffffffc0201d7a:	621c                	ld	a5,0(a2)
ffffffffc0201d7c:	873e                	mv	a4,a5
ffffffffc0201d7e:	679c                	ld	a5,8(a5)
ffffffffc0201d80:	02877a63          	bgeu	a4,s0,ffffffffc0201db4 <slob_free+0x58>
ffffffffc0201d84:	00f46463          	bltu	s0,a5,ffffffffc0201d8c <slob_free+0x30>
ffffffffc0201d88:	fef76ae3          	bltu	a4,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201d8c:	400c                	lw	a1,0(s0)
ffffffffc0201d8e:	00459693          	slli	a3,a1,0x4
ffffffffc0201d92:	96a2                	add	a3,a3,s0
ffffffffc0201d94:	02d78a63          	beq	a5,a3,ffffffffc0201dc8 <slob_free+0x6c>
ffffffffc0201d98:	4314                	lw	a3,0(a4)
ffffffffc0201d9a:	e41c                	sd	a5,8(s0)
ffffffffc0201d9c:	00469793          	slli	a5,a3,0x4
ffffffffc0201da0:	97ba                	add	a5,a5,a4
ffffffffc0201da2:	02f40e63          	beq	s0,a5,ffffffffc0201dde <slob_free+0x82>
ffffffffc0201da6:	e700                	sd	s0,8(a4)
ffffffffc0201da8:	e218                	sd	a4,0(a2)
ffffffffc0201daa:	e129                	bnez	a0,ffffffffc0201dec <slob_free+0x90>
ffffffffc0201dac:	60a2                	ld	ra,8(sp)
ffffffffc0201dae:	6402                	ld	s0,0(sp)
ffffffffc0201db0:	0141                	addi	sp,sp,16
ffffffffc0201db2:	8082                	ret
ffffffffc0201db4:	fcf764e3          	bltu	a4,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201db8:	fcf472e3          	bgeu	s0,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201dbc:	400c                	lw	a1,0(s0)
ffffffffc0201dbe:	00459693          	slli	a3,a1,0x4
ffffffffc0201dc2:	96a2                	add	a3,a3,s0
ffffffffc0201dc4:	fcd79ae3          	bne	a5,a3,ffffffffc0201d98 <slob_free+0x3c>
ffffffffc0201dc8:	4394                	lw	a3,0(a5)
ffffffffc0201dca:	679c                	ld	a5,8(a5)
ffffffffc0201dcc:	9db5                	addw	a1,a1,a3
ffffffffc0201dce:	c00c                	sw	a1,0(s0)
ffffffffc0201dd0:	4314                	lw	a3,0(a4)
ffffffffc0201dd2:	e41c                	sd	a5,8(s0)
ffffffffc0201dd4:	00469793          	slli	a5,a3,0x4
ffffffffc0201dd8:	97ba                	add	a5,a5,a4
ffffffffc0201dda:	fcf416e3          	bne	s0,a5,ffffffffc0201da6 <slob_free+0x4a>
ffffffffc0201dde:	401c                	lw	a5,0(s0)
ffffffffc0201de0:	640c                	ld	a1,8(s0)
ffffffffc0201de2:	e218                	sd	a4,0(a2)
ffffffffc0201de4:	9ebd                	addw	a3,a3,a5
ffffffffc0201de6:	c314                	sw	a3,0(a4)
ffffffffc0201de8:	e70c                	sd	a1,8(a4)
ffffffffc0201dea:	d169                	beqz	a0,ffffffffc0201dac <slob_free+0x50>
ffffffffc0201dec:	6402                	ld	s0,0(sp)
ffffffffc0201dee:	60a2                	ld	ra,8(sp)
ffffffffc0201df0:	0141                	addi	sp,sp,16
ffffffffc0201df2:	e7bfe06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0201df6:	25bd                	addiw	a1,a1,15
ffffffffc0201df8:	8191                	srli	a1,a1,0x4
ffffffffc0201dfa:	c10c                	sw	a1,0(a0)
ffffffffc0201dfc:	100027f3          	csrr	a5,sstatus
ffffffffc0201e00:	8b89                	andi	a5,a5,2
ffffffffc0201e02:	4501                	li	a0,0
ffffffffc0201e04:	d7bd                	beqz	a5,ffffffffc0201d72 <slob_free+0x16>
ffffffffc0201e06:	e6dfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201e0a:	4505                	li	a0,1
ffffffffc0201e0c:	b79d                	j	ffffffffc0201d72 <slob_free+0x16>
ffffffffc0201e0e:	8082                	ret

ffffffffc0201e10 <__slob_get_free_pages.constprop.0>:
ffffffffc0201e10:	4785                	li	a5,1
ffffffffc0201e12:	1141                	addi	sp,sp,-16
ffffffffc0201e14:	00a7953b          	sllw	a0,a5,a0
ffffffffc0201e18:	e406                	sd	ra,8(sp)
ffffffffc0201e1a:	352000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201e1e:	c91d                	beqz	a0,ffffffffc0201e54 <__slob_get_free_pages.constprop.0+0x44>
ffffffffc0201e20:	00095697          	auipc	a3,0x95
ffffffffc0201e24:	a886b683          	ld	a3,-1400(a3) # ffffffffc02968a8 <pages>
ffffffffc0201e28:	8d15                	sub	a0,a0,a3
ffffffffc0201e2a:	8519                	srai	a0,a0,0x6
ffffffffc0201e2c:	0000d697          	auipc	a3,0xd
ffffffffc0201e30:	52c6b683          	ld	a3,1324(a3) # ffffffffc020f358 <nbase>
ffffffffc0201e34:	9536                	add	a0,a0,a3
ffffffffc0201e36:	00c51793          	slli	a5,a0,0xc
ffffffffc0201e3a:	83b1                	srli	a5,a5,0xc
ffffffffc0201e3c:	00095717          	auipc	a4,0x95
ffffffffc0201e40:	a6473703          	ld	a4,-1436(a4) # ffffffffc02968a0 <npage>
ffffffffc0201e44:	0532                	slli	a0,a0,0xc
ffffffffc0201e46:	00e7fa63          	bgeu	a5,a4,ffffffffc0201e5a <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201e4a:	00095697          	auipc	a3,0x95
ffffffffc0201e4e:	a6e6b683          	ld	a3,-1426(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0201e52:	9536                	add	a0,a0,a3
ffffffffc0201e54:	60a2                	ld	ra,8(sp)
ffffffffc0201e56:	0141                	addi	sp,sp,16
ffffffffc0201e58:	8082                	ret
ffffffffc0201e5a:	86aa                	mv	a3,a0
ffffffffc0201e5c:	0000a617          	auipc	a2,0xa
ffffffffc0201e60:	33c60613          	addi	a2,a2,828 # ffffffffc020c198 <default_pmm_manager+0x38>
ffffffffc0201e64:	07100593          	li	a1,113
ffffffffc0201e68:	0000a517          	auipc	a0,0xa
ffffffffc0201e6c:	35850513          	addi	a0,a0,856 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc0201e70:	e2efe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201e74 <slob_alloc.constprop.0>:
ffffffffc0201e74:	1101                	addi	sp,sp,-32
ffffffffc0201e76:	ec06                	sd	ra,24(sp)
ffffffffc0201e78:	e822                	sd	s0,16(sp)
ffffffffc0201e7a:	e426                	sd	s1,8(sp)
ffffffffc0201e7c:	e04a                	sd	s2,0(sp)
ffffffffc0201e7e:	01050713          	addi	a4,a0,16
ffffffffc0201e82:	6785                	lui	a5,0x1
ffffffffc0201e84:	0cf77363          	bgeu	a4,a5,ffffffffc0201f4a <slob_alloc.constprop.0+0xd6>
ffffffffc0201e88:	00f50493          	addi	s1,a0,15
ffffffffc0201e8c:	8091                	srli	s1,s1,0x4
ffffffffc0201e8e:	2481                	sext.w	s1,s1
ffffffffc0201e90:	10002673          	csrr	a2,sstatus
ffffffffc0201e94:	8a09                	andi	a2,a2,2
ffffffffc0201e96:	e25d                	bnez	a2,ffffffffc0201f3c <slob_alloc.constprop.0+0xc8>
ffffffffc0201e98:	0008f917          	auipc	s2,0x8f
ffffffffc0201e9c:	1b890913          	addi	s2,s2,440 # ffffffffc0291050 <slobfree>
ffffffffc0201ea0:	00093683          	ld	a3,0(s2)
ffffffffc0201ea4:	669c                	ld	a5,8(a3)
ffffffffc0201ea6:	4398                	lw	a4,0(a5)
ffffffffc0201ea8:	08975e63          	bge	a4,s1,ffffffffc0201f44 <slob_alloc.constprop.0+0xd0>
ffffffffc0201eac:	00f68b63          	beq	a3,a5,ffffffffc0201ec2 <slob_alloc.constprop.0+0x4e>
ffffffffc0201eb0:	6780                	ld	s0,8(a5)
ffffffffc0201eb2:	4018                	lw	a4,0(s0)
ffffffffc0201eb4:	02975a63          	bge	a4,s1,ffffffffc0201ee8 <slob_alloc.constprop.0+0x74>
ffffffffc0201eb8:	00093683          	ld	a3,0(s2)
ffffffffc0201ebc:	87a2                	mv	a5,s0
ffffffffc0201ebe:	fef699e3          	bne	a3,a5,ffffffffc0201eb0 <slob_alloc.constprop.0+0x3c>
ffffffffc0201ec2:	ee31                	bnez	a2,ffffffffc0201f1e <slob_alloc.constprop.0+0xaa>
ffffffffc0201ec4:	4501                	li	a0,0
ffffffffc0201ec6:	f4bff0ef          	jal	ra,ffffffffc0201e10 <__slob_get_free_pages.constprop.0>
ffffffffc0201eca:	842a                	mv	s0,a0
ffffffffc0201ecc:	cd05                	beqz	a0,ffffffffc0201f04 <slob_alloc.constprop.0+0x90>
ffffffffc0201ece:	6585                	lui	a1,0x1
ffffffffc0201ed0:	e8dff0ef          	jal	ra,ffffffffc0201d5c <slob_free>
ffffffffc0201ed4:	10002673          	csrr	a2,sstatus
ffffffffc0201ed8:	8a09                	andi	a2,a2,2
ffffffffc0201eda:	ee05                	bnez	a2,ffffffffc0201f12 <slob_alloc.constprop.0+0x9e>
ffffffffc0201edc:	00093783          	ld	a5,0(s2)
ffffffffc0201ee0:	6780                	ld	s0,8(a5)
ffffffffc0201ee2:	4018                	lw	a4,0(s0)
ffffffffc0201ee4:	fc974ae3          	blt	a4,s1,ffffffffc0201eb8 <slob_alloc.constprop.0+0x44>
ffffffffc0201ee8:	04e48763          	beq	s1,a4,ffffffffc0201f36 <slob_alloc.constprop.0+0xc2>
ffffffffc0201eec:	00449693          	slli	a3,s1,0x4
ffffffffc0201ef0:	96a2                	add	a3,a3,s0
ffffffffc0201ef2:	e794                	sd	a3,8(a5)
ffffffffc0201ef4:	640c                	ld	a1,8(s0)
ffffffffc0201ef6:	9f05                	subw	a4,a4,s1
ffffffffc0201ef8:	c298                	sw	a4,0(a3)
ffffffffc0201efa:	e68c                	sd	a1,8(a3)
ffffffffc0201efc:	c004                	sw	s1,0(s0)
ffffffffc0201efe:	00f93023          	sd	a5,0(s2)
ffffffffc0201f02:	e20d                	bnez	a2,ffffffffc0201f24 <slob_alloc.constprop.0+0xb0>
ffffffffc0201f04:	60e2                	ld	ra,24(sp)
ffffffffc0201f06:	8522                	mv	a0,s0
ffffffffc0201f08:	6442                	ld	s0,16(sp)
ffffffffc0201f0a:	64a2                	ld	s1,8(sp)
ffffffffc0201f0c:	6902                	ld	s2,0(sp)
ffffffffc0201f0e:	6105                	addi	sp,sp,32
ffffffffc0201f10:	8082                	ret
ffffffffc0201f12:	d61fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f16:	00093783          	ld	a5,0(s2)
ffffffffc0201f1a:	4605                	li	a2,1
ffffffffc0201f1c:	b7d1                	j	ffffffffc0201ee0 <slob_alloc.constprop.0+0x6c>
ffffffffc0201f1e:	d4ffe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f22:	b74d                	j	ffffffffc0201ec4 <slob_alloc.constprop.0+0x50>
ffffffffc0201f24:	d49fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f28:	60e2                	ld	ra,24(sp)
ffffffffc0201f2a:	8522                	mv	a0,s0
ffffffffc0201f2c:	6442                	ld	s0,16(sp)
ffffffffc0201f2e:	64a2                	ld	s1,8(sp)
ffffffffc0201f30:	6902                	ld	s2,0(sp)
ffffffffc0201f32:	6105                	addi	sp,sp,32
ffffffffc0201f34:	8082                	ret
ffffffffc0201f36:	6418                	ld	a4,8(s0)
ffffffffc0201f38:	e798                	sd	a4,8(a5)
ffffffffc0201f3a:	b7d1                	j	ffffffffc0201efe <slob_alloc.constprop.0+0x8a>
ffffffffc0201f3c:	d37fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f40:	4605                	li	a2,1
ffffffffc0201f42:	bf99                	j	ffffffffc0201e98 <slob_alloc.constprop.0+0x24>
ffffffffc0201f44:	843e                	mv	s0,a5
ffffffffc0201f46:	87b6                	mv	a5,a3
ffffffffc0201f48:	b745                	j	ffffffffc0201ee8 <slob_alloc.constprop.0+0x74>
ffffffffc0201f4a:	0000a697          	auipc	a3,0xa
ffffffffc0201f4e:	28668693          	addi	a3,a3,646 # ffffffffc020c1d0 <default_pmm_manager+0x70>
ffffffffc0201f52:	00009617          	auipc	a2,0x9
ffffffffc0201f56:	72660613          	addi	a2,a2,1830 # ffffffffc020b678 <commands+0x210>
ffffffffc0201f5a:	06300593          	li	a1,99
ffffffffc0201f5e:	0000a517          	auipc	a0,0xa
ffffffffc0201f62:	29250513          	addi	a0,a0,658 # ffffffffc020c1f0 <default_pmm_manager+0x90>
ffffffffc0201f66:	d38fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201f6a <kmalloc_init>:
ffffffffc0201f6a:	1141                	addi	sp,sp,-16
ffffffffc0201f6c:	0000a517          	auipc	a0,0xa
ffffffffc0201f70:	29c50513          	addi	a0,a0,668 # ffffffffc020c208 <default_pmm_manager+0xa8>
ffffffffc0201f74:	e406                	sd	ra,8(sp)
ffffffffc0201f76:	a30fe0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0201f7a:	60a2                	ld	ra,8(sp)
ffffffffc0201f7c:	0000a517          	auipc	a0,0xa
ffffffffc0201f80:	2a450513          	addi	a0,a0,676 # ffffffffc020c220 <default_pmm_manager+0xc0>
ffffffffc0201f84:	0141                	addi	sp,sp,16
ffffffffc0201f86:	a20fe06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0201f8a <kallocated>:
ffffffffc0201f8a:	4501                	li	a0,0
ffffffffc0201f8c:	8082                	ret

ffffffffc0201f8e <kmalloc>:
ffffffffc0201f8e:	1101                	addi	sp,sp,-32
ffffffffc0201f90:	e04a                	sd	s2,0(sp)
ffffffffc0201f92:	6905                	lui	s2,0x1
ffffffffc0201f94:	e822                	sd	s0,16(sp)
ffffffffc0201f96:	ec06                	sd	ra,24(sp)
ffffffffc0201f98:	e426                	sd	s1,8(sp)
ffffffffc0201f9a:	fef90793          	addi	a5,s2,-17 # fef <_binary_bin_swap_img_size-0x6d11>
ffffffffc0201f9e:	842a                	mv	s0,a0
ffffffffc0201fa0:	04a7f963          	bgeu	a5,a0,ffffffffc0201ff2 <kmalloc+0x64>
ffffffffc0201fa4:	4561                	li	a0,24
ffffffffc0201fa6:	ecfff0ef          	jal	ra,ffffffffc0201e74 <slob_alloc.constprop.0>
ffffffffc0201faa:	84aa                	mv	s1,a0
ffffffffc0201fac:	c929                	beqz	a0,ffffffffc0201ffe <kmalloc+0x70>
ffffffffc0201fae:	0004079b          	sext.w	a5,s0
ffffffffc0201fb2:	4501                	li	a0,0
ffffffffc0201fb4:	00f95763          	bge	s2,a5,ffffffffc0201fc2 <kmalloc+0x34>
ffffffffc0201fb8:	6705                	lui	a4,0x1
ffffffffc0201fba:	8785                	srai	a5,a5,0x1
ffffffffc0201fbc:	2505                	addiw	a0,a0,1
ffffffffc0201fbe:	fef74ee3          	blt	a4,a5,ffffffffc0201fba <kmalloc+0x2c>
ffffffffc0201fc2:	c088                	sw	a0,0(s1)
ffffffffc0201fc4:	e4dff0ef          	jal	ra,ffffffffc0201e10 <__slob_get_free_pages.constprop.0>
ffffffffc0201fc8:	e488                	sd	a0,8(s1)
ffffffffc0201fca:	842a                	mv	s0,a0
ffffffffc0201fcc:	c525                	beqz	a0,ffffffffc0202034 <kmalloc+0xa6>
ffffffffc0201fce:	100027f3          	csrr	a5,sstatus
ffffffffc0201fd2:	8b89                	andi	a5,a5,2
ffffffffc0201fd4:	ef8d                	bnez	a5,ffffffffc020200e <kmalloc+0x80>
ffffffffc0201fd6:	00095797          	auipc	a5,0x95
ffffffffc0201fda:	8b278793          	addi	a5,a5,-1870 # ffffffffc0296888 <bigblocks>
ffffffffc0201fde:	6398                	ld	a4,0(a5)
ffffffffc0201fe0:	e384                	sd	s1,0(a5)
ffffffffc0201fe2:	e898                	sd	a4,16(s1)
ffffffffc0201fe4:	60e2                	ld	ra,24(sp)
ffffffffc0201fe6:	8522                	mv	a0,s0
ffffffffc0201fe8:	6442                	ld	s0,16(sp)
ffffffffc0201fea:	64a2                	ld	s1,8(sp)
ffffffffc0201fec:	6902                	ld	s2,0(sp)
ffffffffc0201fee:	6105                	addi	sp,sp,32
ffffffffc0201ff0:	8082                	ret
ffffffffc0201ff2:	0541                	addi	a0,a0,16
ffffffffc0201ff4:	e81ff0ef          	jal	ra,ffffffffc0201e74 <slob_alloc.constprop.0>
ffffffffc0201ff8:	01050413          	addi	s0,a0,16
ffffffffc0201ffc:	f565                	bnez	a0,ffffffffc0201fe4 <kmalloc+0x56>
ffffffffc0201ffe:	4401                	li	s0,0
ffffffffc0202000:	60e2                	ld	ra,24(sp)
ffffffffc0202002:	8522                	mv	a0,s0
ffffffffc0202004:	6442                	ld	s0,16(sp)
ffffffffc0202006:	64a2                	ld	s1,8(sp)
ffffffffc0202008:	6902                	ld	s2,0(sp)
ffffffffc020200a:	6105                	addi	sp,sp,32
ffffffffc020200c:	8082                	ret
ffffffffc020200e:	c65fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202012:	00095797          	auipc	a5,0x95
ffffffffc0202016:	87678793          	addi	a5,a5,-1930 # ffffffffc0296888 <bigblocks>
ffffffffc020201a:	6398                	ld	a4,0(a5)
ffffffffc020201c:	e384                	sd	s1,0(a5)
ffffffffc020201e:	e898                	sd	a4,16(s1)
ffffffffc0202020:	c4dfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202024:	6480                	ld	s0,8(s1)
ffffffffc0202026:	60e2                	ld	ra,24(sp)
ffffffffc0202028:	64a2                	ld	s1,8(sp)
ffffffffc020202a:	8522                	mv	a0,s0
ffffffffc020202c:	6442                	ld	s0,16(sp)
ffffffffc020202e:	6902                	ld	s2,0(sp)
ffffffffc0202030:	6105                	addi	sp,sp,32
ffffffffc0202032:	8082                	ret
ffffffffc0202034:	45e1                	li	a1,24
ffffffffc0202036:	8526                	mv	a0,s1
ffffffffc0202038:	d25ff0ef          	jal	ra,ffffffffc0201d5c <slob_free>
ffffffffc020203c:	b765                	j	ffffffffc0201fe4 <kmalloc+0x56>

ffffffffc020203e <kfree>:
ffffffffc020203e:	c169                	beqz	a0,ffffffffc0202100 <kfree+0xc2>
ffffffffc0202040:	1101                	addi	sp,sp,-32
ffffffffc0202042:	e822                	sd	s0,16(sp)
ffffffffc0202044:	ec06                	sd	ra,24(sp)
ffffffffc0202046:	e426                	sd	s1,8(sp)
ffffffffc0202048:	03451793          	slli	a5,a0,0x34
ffffffffc020204c:	842a                	mv	s0,a0
ffffffffc020204e:	e3d9                	bnez	a5,ffffffffc02020d4 <kfree+0x96>
ffffffffc0202050:	100027f3          	csrr	a5,sstatus
ffffffffc0202054:	8b89                	andi	a5,a5,2
ffffffffc0202056:	e7d9                	bnez	a5,ffffffffc02020e4 <kfree+0xa6>
ffffffffc0202058:	00095797          	auipc	a5,0x95
ffffffffc020205c:	8307b783          	ld	a5,-2000(a5) # ffffffffc0296888 <bigblocks>
ffffffffc0202060:	4601                	li	a2,0
ffffffffc0202062:	cbad                	beqz	a5,ffffffffc02020d4 <kfree+0x96>
ffffffffc0202064:	00095697          	auipc	a3,0x95
ffffffffc0202068:	82468693          	addi	a3,a3,-2012 # ffffffffc0296888 <bigblocks>
ffffffffc020206c:	a021                	j	ffffffffc0202074 <kfree+0x36>
ffffffffc020206e:	01048693          	addi	a3,s1,16
ffffffffc0202072:	c3a5                	beqz	a5,ffffffffc02020d2 <kfree+0x94>
ffffffffc0202074:	6798                	ld	a4,8(a5)
ffffffffc0202076:	84be                	mv	s1,a5
ffffffffc0202078:	6b9c                	ld	a5,16(a5)
ffffffffc020207a:	fe871ae3          	bne	a4,s0,ffffffffc020206e <kfree+0x30>
ffffffffc020207e:	e29c                	sd	a5,0(a3)
ffffffffc0202080:	ee2d                	bnez	a2,ffffffffc02020fa <kfree+0xbc>
ffffffffc0202082:	c02007b7          	lui	a5,0xc0200
ffffffffc0202086:	4098                	lw	a4,0(s1)
ffffffffc0202088:	08f46963          	bltu	s0,a5,ffffffffc020211a <kfree+0xdc>
ffffffffc020208c:	00095697          	auipc	a3,0x95
ffffffffc0202090:	82c6b683          	ld	a3,-2004(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202094:	8c15                	sub	s0,s0,a3
ffffffffc0202096:	8031                	srli	s0,s0,0xc
ffffffffc0202098:	00095797          	auipc	a5,0x95
ffffffffc020209c:	8087b783          	ld	a5,-2040(a5) # ffffffffc02968a0 <npage>
ffffffffc02020a0:	06f47163          	bgeu	s0,a5,ffffffffc0202102 <kfree+0xc4>
ffffffffc02020a4:	0000d517          	auipc	a0,0xd
ffffffffc02020a8:	2b453503          	ld	a0,692(a0) # ffffffffc020f358 <nbase>
ffffffffc02020ac:	8c09                	sub	s0,s0,a0
ffffffffc02020ae:	041a                	slli	s0,s0,0x6
ffffffffc02020b0:	00094517          	auipc	a0,0x94
ffffffffc02020b4:	7f853503          	ld	a0,2040(a0) # ffffffffc02968a8 <pages>
ffffffffc02020b8:	4585                	li	a1,1
ffffffffc02020ba:	9522                	add	a0,a0,s0
ffffffffc02020bc:	00e595bb          	sllw	a1,a1,a4
ffffffffc02020c0:	0ea000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02020c4:	6442                	ld	s0,16(sp)
ffffffffc02020c6:	60e2                	ld	ra,24(sp)
ffffffffc02020c8:	8526                	mv	a0,s1
ffffffffc02020ca:	64a2                	ld	s1,8(sp)
ffffffffc02020cc:	45e1                	li	a1,24
ffffffffc02020ce:	6105                	addi	sp,sp,32
ffffffffc02020d0:	b171                	j	ffffffffc0201d5c <slob_free>
ffffffffc02020d2:	e20d                	bnez	a2,ffffffffc02020f4 <kfree+0xb6>
ffffffffc02020d4:	ff040513          	addi	a0,s0,-16
ffffffffc02020d8:	6442                	ld	s0,16(sp)
ffffffffc02020da:	60e2                	ld	ra,24(sp)
ffffffffc02020dc:	64a2                	ld	s1,8(sp)
ffffffffc02020de:	4581                	li	a1,0
ffffffffc02020e0:	6105                	addi	sp,sp,32
ffffffffc02020e2:	b9ad                	j	ffffffffc0201d5c <slob_free>
ffffffffc02020e4:	b8ffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02020e8:	00094797          	auipc	a5,0x94
ffffffffc02020ec:	7a07b783          	ld	a5,1952(a5) # ffffffffc0296888 <bigblocks>
ffffffffc02020f0:	4605                	li	a2,1
ffffffffc02020f2:	fbad                	bnez	a5,ffffffffc0202064 <kfree+0x26>
ffffffffc02020f4:	b79fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02020f8:	bff1                	j	ffffffffc02020d4 <kfree+0x96>
ffffffffc02020fa:	b73fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02020fe:	b751                	j	ffffffffc0202082 <kfree+0x44>
ffffffffc0202100:	8082                	ret
ffffffffc0202102:	0000a617          	auipc	a2,0xa
ffffffffc0202106:	16660613          	addi	a2,a2,358 # ffffffffc020c268 <default_pmm_manager+0x108>
ffffffffc020210a:	06900593          	li	a1,105
ffffffffc020210e:	0000a517          	auipc	a0,0xa
ffffffffc0202112:	0b250513          	addi	a0,a0,178 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc0202116:	b88fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020211a:	86a2                	mv	a3,s0
ffffffffc020211c:	0000a617          	auipc	a2,0xa
ffffffffc0202120:	12460613          	addi	a2,a2,292 # ffffffffc020c240 <default_pmm_manager+0xe0>
ffffffffc0202124:	07700593          	li	a1,119
ffffffffc0202128:	0000a517          	auipc	a0,0xa
ffffffffc020212c:	09850513          	addi	a0,a0,152 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc0202130:	b6efe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202134 <pa2page.part.0>:
ffffffffc0202134:	1141                	addi	sp,sp,-16
ffffffffc0202136:	0000a617          	auipc	a2,0xa
ffffffffc020213a:	13260613          	addi	a2,a2,306 # ffffffffc020c268 <default_pmm_manager+0x108>
ffffffffc020213e:	06900593          	li	a1,105
ffffffffc0202142:	0000a517          	auipc	a0,0xa
ffffffffc0202146:	07e50513          	addi	a0,a0,126 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc020214a:	e406                	sd	ra,8(sp)
ffffffffc020214c:	b52fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202150 <pte2page.part.0>:
ffffffffc0202150:	1141                	addi	sp,sp,-16
ffffffffc0202152:	0000a617          	auipc	a2,0xa
ffffffffc0202156:	13660613          	addi	a2,a2,310 # ffffffffc020c288 <default_pmm_manager+0x128>
ffffffffc020215a:	07f00593          	li	a1,127
ffffffffc020215e:	0000a517          	auipc	a0,0xa
ffffffffc0202162:	06250513          	addi	a0,a0,98 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc0202166:	e406                	sd	ra,8(sp)
ffffffffc0202168:	b36fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020216c <alloc_pages>:
ffffffffc020216c:	100027f3          	csrr	a5,sstatus
ffffffffc0202170:	8b89                	andi	a5,a5,2
ffffffffc0202172:	e799                	bnez	a5,ffffffffc0202180 <alloc_pages+0x14>
ffffffffc0202174:	00094797          	auipc	a5,0x94
ffffffffc0202178:	73c7b783          	ld	a5,1852(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020217c:	6f9c                	ld	a5,24(a5)
ffffffffc020217e:	8782                	jr	a5
ffffffffc0202180:	1141                	addi	sp,sp,-16
ffffffffc0202182:	e406                	sd	ra,8(sp)
ffffffffc0202184:	e022                	sd	s0,0(sp)
ffffffffc0202186:	842a                	mv	s0,a0
ffffffffc0202188:	aebfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020218c:	00094797          	auipc	a5,0x94
ffffffffc0202190:	7247b783          	ld	a5,1828(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202194:	6f9c                	ld	a5,24(a5)
ffffffffc0202196:	8522                	mv	a0,s0
ffffffffc0202198:	9782                	jalr	a5
ffffffffc020219a:	842a                	mv	s0,a0
ffffffffc020219c:	ad1fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02021a0:	60a2                	ld	ra,8(sp)
ffffffffc02021a2:	8522                	mv	a0,s0
ffffffffc02021a4:	6402                	ld	s0,0(sp)
ffffffffc02021a6:	0141                	addi	sp,sp,16
ffffffffc02021a8:	8082                	ret

ffffffffc02021aa <free_pages>:
ffffffffc02021aa:	100027f3          	csrr	a5,sstatus
ffffffffc02021ae:	8b89                	andi	a5,a5,2
ffffffffc02021b0:	e799                	bnez	a5,ffffffffc02021be <free_pages+0x14>
ffffffffc02021b2:	00094797          	auipc	a5,0x94
ffffffffc02021b6:	6fe7b783          	ld	a5,1790(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021ba:	739c                	ld	a5,32(a5)
ffffffffc02021bc:	8782                	jr	a5
ffffffffc02021be:	1101                	addi	sp,sp,-32
ffffffffc02021c0:	ec06                	sd	ra,24(sp)
ffffffffc02021c2:	e822                	sd	s0,16(sp)
ffffffffc02021c4:	e426                	sd	s1,8(sp)
ffffffffc02021c6:	842a                	mv	s0,a0
ffffffffc02021c8:	84ae                	mv	s1,a1
ffffffffc02021ca:	aa9fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02021ce:	00094797          	auipc	a5,0x94
ffffffffc02021d2:	6e27b783          	ld	a5,1762(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021d6:	739c                	ld	a5,32(a5)
ffffffffc02021d8:	85a6                	mv	a1,s1
ffffffffc02021da:	8522                	mv	a0,s0
ffffffffc02021dc:	9782                	jalr	a5
ffffffffc02021de:	6442                	ld	s0,16(sp)
ffffffffc02021e0:	60e2                	ld	ra,24(sp)
ffffffffc02021e2:	64a2                	ld	s1,8(sp)
ffffffffc02021e4:	6105                	addi	sp,sp,32
ffffffffc02021e6:	a87fe06f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc02021ea <nr_free_pages>:
ffffffffc02021ea:	100027f3          	csrr	a5,sstatus
ffffffffc02021ee:	8b89                	andi	a5,a5,2
ffffffffc02021f0:	e799                	bnez	a5,ffffffffc02021fe <nr_free_pages+0x14>
ffffffffc02021f2:	00094797          	auipc	a5,0x94
ffffffffc02021f6:	6be7b783          	ld	a5,1726(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021fa:	779c                	ld	a5,40(a5)
ffffffffc02021fc:	8782                	jr	a5
ffffffffc02021fe:	1141                	addi	sp,sp,-16
ffffffffc0202200:	e406                	sd	ra,8(sp)
ffffffffc0202202:	e022                	sd	s0,0(sp)
ffffffffc0202204:	a6ffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202208:	00094797          	auipc	a5,0x94
ffffffffc020220c:	6a87b783          	ld	a5,1704(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202210:	779c                	ld	a5,40(a5)
ffffffffc0202212:	9782                	jalr	a5
ffffffffc0202214:	842a                	mv	s0,a0
ffffffffc0202216:	a57fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020221a:	60a2                	ld	ra,8(sp)
ffffffffc020221c:	8522                	mv	a0,s0
ffffffffc020221e:	6402                	ld	s0,0(sp)
ffffffffc0202220:	0141                	addi	sp,sp,16
ffffffffc0202222:	8082                	ret

ffffffffc0202224 <get_pte>:
ffffffffc0202224:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0202228:	1ff7f793          	andi	a5,a5,511
ffffffffc020222c:	7139                	addi	sp,sp,-64
ffffffffc020222e:	078e                	slli	a5,a5,0x3
ffffffffc0202230:	f426                	sd	s1,40(sp)
ffffffffc0202232:	00f504b3          	add	s1,a0,a5
ffffffffc0202236:	6094                	ld	a3,0(s1)
ffffffffc0202238:	f04a                	sd	s2,32(sp)
ffffffffc020223a:	ec4e                	sd	s3,24(sp)
ffffffffc020223c:	e852                	sd	s4,16(sp)
ffffffffc020223e:	fc06                	sd	ra,56(sp)
ffffffffc0202240:	f822                	sd	s0,48(sp)
ffffffffc0202242:	e456                	sd	s5,8(sp)
ffffffffc0202244:	e05a                	sd	s6,0(sp)
ffffffffc0202246:	0016f793          	andi	a5,a3,1
ffffffffc020224a:	892e                	mv	s2,a1
ffffffffc020224c:	8a32                	mv	s4,a2
ffffffffc020224e:	00094997          	auipc	s3,0x94
ffffffffc0202252:	65298993          	addi	s3,s3,1618 # ffffffffc02968a0 <npage>
ffffffffc0202256:	efbd                	bnez	a5,ffffffffc02022d4 <get_pte+0xb0>
ffffffffc0202258:	14060c63          	beqz	a2,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020225c:	100027f3          	csrr	a5,sstatus
ffffffffc0202260:	8b89                	andi	a5,a5,2
ffffffffc0202262:	14079963          	bnez	a5,ffffffffc02023b4 <get_pte+0x190>
ffffffffc0202266:	00094797          	auipc	a5,0x94
ffffffffc020226a:	64a7b783          	ld	a5,1610(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020226e:	6f9c                	ld	a5,24(a5)
ffffffffc0202270:	4505                	li	a0,1
ffffffffc0202272:	9782                	jalr	a5
ffffffffc0202274:	842a                	mv	s0,a0
ffffffffc0202276:	12040d63          	beqz	s0,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020227a:	00094b17          	auipc	s6,0x94
ffffffffc020227e:	62eb0b13          	addi	s6,s6,1582 # ffffffffc02968a8 <pages>
ffffffffc0202282:	000b3503          	ld	a0,0(s6)
ffffffffc0202286:	00080ab7          	lui	s5,0x80
ffffffffc020228a:	00094997          	auipc	s3,0x94
ffffffffc020228e:	61698993          	addi	s3,s3,1558 # ffffffffc02968a0 <npage>
ffffffffc0202292:	40a40533          	sub	a0,s0,a0
ffffffffc0202296:	8519                	srai	a0,a0,0x6
ffffffffc0202298:	9556                	add	a0,a0,s5
ffffffffc020229a:	0009b703          	ld	a4,0(s3)
ffffffffc020229e:	00c51793          	slli	a5,a0,0xc
ffffffffc02022a2:	4685                	li	a3,1
ffffffffc02022a4:	c014                	sw	a3,0(s0)
ffffffffc02022a6:	83b1                	srli	a5,a5,0xc
ffffffffc02022a8:	0532                	slli	a0,a0,0xc
ffffffffc02022aa:	16e7f763          	bgeu	a5,a4,ffffffffc0202418 <get_pte+0x1f4>
ffffffffc02022ae:	00094797          	auipc	a5,0x94
ffffffffc02022b2:	60a7b783          	ld	a5,1546(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc02022b6:	6605                	lui	a2,0x1
ffffffffc02022b8:	4581                	li	a1,0
ffffffffc02022ba:	953e                	add	a0,a0,a5
ffffffffc02022bc:	6d9080ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc02022c0:	000b3683          	ld	a3,0(s6)
ffffffffc02022c4:	40d406b3          	sub	a3,s0,a3
ffffffffc02022c8:	8699                	srai	a3,a3,0x6
ffffffffc02022ca:	96d6                	add	a3,a3,s5
ffffffffc02022cc:	06aa                	slli	a3,a3,0xa
ffffffffc02022ce:	0116e693          	ori	a3,a3,17
ffffffffc02022d2:	e094                	sd	a3,0(s1)
ffffffffc02022d4:	77fd                	lui	a5,0xfffff
ffffffffc02022d6:	068a                	slli	a3,a3,0x2
ffffffffc02022d8:	0009b703          	ld	a4,0(s3)
ffffffffc02022dc:	8efd                	and	a3,a3,a5
ffffffffc02022de:	00c6d793          	srli	a5,a3,0xc
ffffffffc02022e2:	10e7ff63          	bgeu	a5,a4,ffffffffc0202400 <get_pte+0x1dc>
ffffffffc02022e6:	00094a97          	auipc	s5,0x94
ffffffffc02022ea:	5d2a8a93          	addi	s5,s5,1490 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02022ee:	000ab403          	ld	s0,0(s5)
ffffffffc02022f2:	01595793          	srli	a5,s2,0x15
ffffffffc02022f6:	1ff7f793          	andi	a5,a5,511
ffffffffc02022fa:	96a2                	add	a3,a3,s0
ffffffffc02022fc:	00379413          	slli	s0,a5,0x3
ffffffffc0202300:	9436                	add	s0,s0,a3
ffffffffc0202302:	6014                	ld	a3,0(s0)
ffffffffc0202304:	0016f793          	andi	a5,a3,1
ffffffffc0202308:	ebad                	bnez	a5,ffffffffc020237a <get_pte+0x156>
ffffffffc020230a:	0a0a0363          	beqz	s4,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020230e:	100027f3          	csrr	a5,sstatus
ffffffffc0202312:	8b89                	andi	a5,a5,2
ffffffffc0202314:	efcd                	bnez	a5,ffffffffc02023ce <get_pte+0x1aa>
ffffffffc0202316:	00094797          	auipc	a5,0x94
ffffffffc020231a:	59a7b783          	ld	a5,1434(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020231e:	6f9c                	ld	a5,24(a5)
ffffffffc0202320:	4505                	li	a0,1
ffffffffc0202322:	9782                	jalr	a5
ffffffffc0202324:	84aa                	mv	s1,a0
ffffffffc0202326:	c4c9                	beqz	s1,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc0202328:	00094b17          	auipc	s6,0x94
ffffffffc020232c:	580b0b13          	addi	s6,s6,1408 # ffffffffc02968a8 <pages>
ffffffffc0202330:	000b3503          	ld	a0,0(s6)
ffffffffc0202334:	00080a37          	lui	s4,0x80
ffffffffc0202338:	0009b703          	ld	a4,0(s3)
ffffffffc020233c:	40a48533          	sub	a0,s1,a0
ffffffffc0202340:	8519                	srai	a0,a0,0x6
ffffffffc0202342:	9552                	add	a0,a0,s4
ffffffffc0202344:	00c51793          	slli	a5,a0,0xc
ffffffffc0202348:	4685                	li	a3,1
ffffffffc020234a:	c094                	sw	a3,0(s1)
ffffffffc020234c:	83b1                	srli	a5,a5,0xc
ffffffffc020234e:	0532                	slli	a0,a0,0xc
ffffffffc0202350:	0ee7f163          	bgeu	a5,a4,ffffffffc0202432 <get_pte+0x20e>
ffffffffc0202354:	000ab783          	ld	a5,0(s5)
ffffffffc0202358:	6605                	lui	a2,0x1
ffffffffc020235a:	4581                	li	a1,0
ffffffffc020235c:	953e                	add	a0,a0,a5
ffffffffc020235e:	637080ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc0202362:	000b3683          	ld	a3,0(s6)
ffffffffc0202366:	40d486b3          	sub	a3,s1,a3
ffffffffc020236a:	8699                	srai	a3,a3,0x6
ffffffffc020236c:	96d2                	add	a3,a3,s4
ffffffffc020236e:	06aa                	slli	a3,a3,0xa
ffffffffc0202370:	0116e693          	ori	a3,a3,17
ffffffffc0202374:	e014                	sd	a3,0(s0)
ffffffffc0202376:	0009b703          	ld	a4,0(s3)
ffffffffc020237a:	068a                	slli	a3,a3,0x2
ffffffffc020237c:	757d                	lui	a0,0xfffff
ffffffffc020237e:	8ee9                	and	a3,a3,a0
ffffffffc0202380:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202384:	06e7f263          	bgeu	a5,a4,ffffffffc02023e8 <get_pte+0x1c4>
ffffffffc0202388:	000ab503          	ld	a0,0(s5)
ffffffffc020238c:	00c95913          	srli	s2,s2,0xc
ffffffffc0202390:	1ff97913          	andi	s2,s2,511
ffffffffc0202394:	96aa                	add	a3,a3,a0
ffffffffc0202396:	00391513          	slli	a0,s2,0x3
ffffffffc020239a:	9536                	add	a0,a0,a3
ffffffffc020239c:	70e2                	ld	ra,56(sp)
ffffffffc020239e:	7442                	ld	s0,48(sp)
ffffffffc02023a0:	74a2                	ld	s1,40(sp)
ffffffffc02023a2:	7902                	ld	s2,32(sp)
ffffffffc02023a4:	69e2                	ld	s3,24(sp)
ffffffffc02023a6:	6a42                	ld	s4,16(sp)
ffffffffc02023a8:	6aa2                	ld	s5,8(sp)
ffffffffc02023aa:	6b02                	ld	s6,0(sp)
ffffffffc02023ac:	6121                	addi	sp,sp,64
ffffffffc02023ae:	8082                	ret
ffffffffc02023b0:	4501                	li	a0,0
ffffffffc02023b2:	b7ed                	j	ffffffffc020239c <get_pte+0x178>
ffffffffc02023b4:	8bffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02023b8:	00094797          	auipc	a5,0x94
ffffffffc02023bc:	4f87b783          	ld	a5,1272(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02023c0:	6f9c                	ld	a5,24(a5)
ffffffffc02023c2:	4505                	li	a0,1
ffffffffc02023c4:	9782                	jalr	a5
ffffffffc02023c6:	842a                	mv	s0,a0
ffffffffc02023c8:	8a5fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02023cc:	b56d                	j	ffffffffc0202276 <get_pte+0x52>
ffffffffc02023ce:	8a5fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02023d2:	00094797          	auipc	a5,0x94
ffffffffc02023d6:	4de7b783          	ld	a5,1246(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02023da:	6f9c                	ld	a5,24(a5)
ffffffffc02023dc:	4505                	li	a0,1
ffffffffc02023de:	9782                	jalr	a5
ffffffffc02023e0:	84aa                	mv	s1,a0
ffffffffc02023e2:	88bfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02023e6:	b781                	j	ffffffffc0202326 <get_pte+0x102>
ffffffffc02023e8:	0000a617          	auipc	a2,0xa
ffffffffc02023ec:	db060613          	addi	a2,a2,-592 # ffffffffc020c198 <default_pmm_manager+0x38>
ffffffffc02023f0:	13200593          	li	a1,306
ffffffffc02023f4:	0000a517          	auipc	a0,0xa
ffffffffc02023f8:	ebc50513          	addi	a0,a0,-324 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02023fc:	8a2fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202400:	0000a617          	auipc	a2,0xa
ffffffffc0202404:	d9860613          	addi	a2,a2,-616 # ffffffffc020c198 <default_pmm_manager+0x38>
ffffffffc0202408:	12500593          	li	a1,293
ffffffffc020240c:	0000a517          	auipc	a0,0xa
ffffffffc0202410:	ea450513          	addi	a0,a0,-348 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0202414:	88afe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202418:	86aa                	mv	a3,a0
ffffffffc020241a:	0000a617          	auipc	a2,0xa
ffffffffc020241e:	d7e60613          	addi	a2,a2,-642 # ffffffffc020c198 <default_pmm_manager+0x38>
ffffffffc0202422:	12100593          	li	a1,289
ffffffffc0202426:	0000a517          	auipc	a0,0xa
ffffffffc020242a:	e8a50513          	addi	a0,a0,-374 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc020242e:	870fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202432:	86aa                	mv	a3,a0
ffffffffc0202434:	0000a617          	auipc	a2,0xa
ffffffffc0202438:	d6460613          	addi	a2,a2,-668 # ffffffffc020c198 <default_pmm_manager+0x38>
ffffffffc020243c:	12f00593          	li	a1,303
ffffffffc0202440:	0000a517          	auipc	a0,0xa
ffffffffc0202444:	e7050513          	addi	a0,a0,-400 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0202448:	856fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020244c <boot_map_segment>:
ffffffffc020244c:	6785                	lui	a5,0x1
ffffffffc020244e:	7139                	addi	sp,sp,-64
ffffffffc0202450:	00d5c833          	xor	a6,a1,a3
ffffffffc0202454:	17fd                	addi	a5,a5,-1
ffffffffc0202456:	fc06                	sd	ra,56(sp)
ffffffffc0202458:	f822                	sd	s0,48(sp)
ffffffffc020245a:	f426                	sd	s1,40(sp)
ffffffffc020245c:	f04a                	sd	s2,32(sp)
ffffffffc020245e:	ec4e                	sd	s3,24(sp)
ffffffffc0202460:	e852                	sd	s4,16(sp)
ffffffffc0202462:	e456                	sd	s5,8(sp)
ffffffffc0202464:	00f87833          	and	a6,a6,a5
ffffffffc0202468:	08081563          	bnez	a6,ffffffffc02024f2 <boot_map_segment+0xa6>
ffffffffc020246c:	00f5f4b3          	and	s1,a1,a5
ffffffffc0202470:	963e                	add	a2,a2,a5
ffffffffc0202472:	94b2                	add	s1,s1,a2
ffffffffc0202474:	797d                	lui	s2,0xfffff
ffffffffc0202476:	80b1                	srli	s1,s1,0xc
ffffffffc0202478:	0125f5b3          	and	a1,a1,s2
ffffffffc020247c:	0126f6b3          	and	a3,a3,s2
ffffffffc0202480:	c0a1                	beqz	s1,ffffffffc02024c0 <boot_map_segment+0x74>
ffffffffc0202482:	00176713          	ori	a4,a4,1
ffffffffc0202486:	04b2                	slli	s1,s1,0xc
ffffffffc0202488:	02071993          	slli	s3,a4,0x20
ffffffffc020248c:	8a2a                	mv	s4,a0
ffffffffc020248e:	842e                	mv	s0,a1
ffffffffc0202490:	94ae                	add	s1,s1,a1
ffffffffc0202492:	40b68933          	sub	s2,a3,a1
ffffffffc0202496:	0209d993          	srli	s3,s3,0x20
ffffffffc020249a:	6a85                	lui	s5,0x1
ffffffffc020249c:	4605                	li	a2,1
ffffffffc020249e:	85a2                	mv	a1,s0
ffffffffc02024a0:	8552                	mv	a0,s4
ffffffffc02024a2:	d83ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02024a6:	008907b3          	add	a5,s2,s0
ffffffffc02024aa:	c505                	beqz	a0,ffffffffc02024d2 <boot_map_segment+0x86>
ffffffffc02024ac:	83b1                	srli	a5,a5,0xc
ffffffffc02024ae:	07aa                	slli	a5,a5,0xa
ffffffffc02024b0:	0137e7b3          	or	a5,a5,s3
ffffffffc02024b4:	0017e793          	ori	a5,a5,1
ffffffffc02024b8:	e11c                	sd	a5,0(a0)
ffffffffc02024ba:	9456                	add	s0,s0,s5
ffffffffc02024bc:	fe8490e3          	bne	s1,s0,ffffffffc020249c <boot_map_segment+0x50>
ffffffffc02024c0:	70e2                	ld	ra,56(sp)
ffffffffc02024c2:	7442                	ld	s0,48(sp)
ffffffffc02024c4:	74a2                	ld	s1,40(sp)
ffffffffc02024c6:	7902                	ld	s2,32(sp)
ffffffffc02024c8:	69e2                	ld	s3,24(sp)
ffffffffc02024ca:	6a42                	ld	s4,16(sp)
ffffffffc02024cc:	6aa2                	ld	s5,8(sp)
ffffffffc02024ce:	6121                	addi	sp,sp,64
ffffffffc02024d0:	8082                	ret
ffffffffc02024d2:	0000a697          	auipc	a3,0xa
ffffffffc02024d6:	e0668693          	addi	a3,a3,-506 # ffffffffc020c2d8 <default_pmm_manager+0x178>
ffffffffc02024da:	00009617          	auipc	a2,0x9
ffffffffc02024de:	19e60613          	addi	a2,a2,414 # ffffffffc020b678 <commands+0x210>
ffffffffc02024e2:	09c00593          	li	a1,156
ffffffffc02024e6:	0000a517          	auipc	a0,0xa
ffffffffc02024ea:	dca50513          	addi	a0,a0,-566 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02024ee:	fb1fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02024f2:	0000a697          	auipc	a3,0xa
ffffffffc02024f6:	dce68693          	addi	a3,a3,-562 # ffffffffc020c2c0 <default_pmm_manager+0x160>
ffffffffc02024fa:	00009617          	auipc	a2,0x9
ffffffffc02024fe:	17e60613          	addi	a2,a2,382 # ffffffffc020b678 <commands+0x210>
ffffffffc0202502:	09500593          	li	a1,149
ffffffffc0202506:	0000a517          	auipc	a0,0xa
ffffffffc020250a:	daa50513          	addi	a0,a0,-598 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc020250e:	f91fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202512 <get_page>:
ffffffffc0202512:	1141                	addi	sp,sp,-16
ffffffffc0202514:	e022                	sd	s0,0(sp)
ffffffffc0202516:	8432                	mv	s0,a2
ffffffffc0202518:	4601                	li	a2,0
ffffffffc020251a:	e406                	sd	ra,8(sp)
ffffffffc020251c:	d09ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202520:	c011                	beqz	s0,ffffffffc0202524 <get_page+0x12>
ffffffffc0202522:	e008                	sd	a0,0(s0)
ffffffffc0202524:	c511                	beqz	a0,ffffffffc0202530 <get_page+0x1e>
ffffffffc0202526:	611c                	ld	a5,0(a0)
ffffffffc0202528:	4501                	li	a0,0
ffffffffc020252a:	0017f713          	andi	a4,a5,1
ffffffffc020252e:	e709                	bnez	a4,ffffffffc0202538 <get_page+0x26>
ffffffffc0202530:	60a2                	ld	ra,8(sp)
ffffffffc0202532:	6402                	ld	s0,0(sp)
ffffffffc0202534:	0141                	addi	sp,sp,16
ffffffffc0202536:	8082                	ret
ffffffffc0202538:	078a                	slli	a5,a5,0x2
ffffffffc020253a:	83b1                	srli	a5,a5,0xc
ffffffffc020253c:	00094717          	auipc	a4,0x94
ffffffffc0202540:	36473703          	ld	a4,868(a4) # ffffffffc02968a0 <npage>
ffffffffc0202544:	00e7ff63          	bgeu	a5,a4,ffffffffc0202562 <get_page+0x50>
ffffffffc0202548:	60a2                	ld	ra,8(sp)
ffffffffc020254a:	6402                	ld	s0,0(sp)
ffffffffc020254c:	fff80537          	lui	a0,0xfff80
ffffffffc0202550:	97aa                	add	a5,a5,a0
ffffffffc0202552:	079a                	slli	a5,a5,0x6
ffffffffc0202554:	00094517          	auipc	a0,0x94
ffffffffc0202558:	35453503          	ld	a0,852(a0) # ffffffffc02968a8 <pages>
ffffffffc020255c:	953e                	add	a0,a0,a5
ffffffffc020255e:	0141                	addi	sp,sp,16
ffffffffc0202560:	8082                	ret
ffffffffc0202562:	bd3ff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc0202566 <unmap_range>:
ffffffffc0202566:	7159                	addi	sp,sp,-112
ffffffffc0202568:	00c5e7b3          	or	a5,a1,a2
ffffffffc020256c:	f486                	sd	ra,104(sp)
ffffffffc020256e:	f0a2                	sd	s0,96(sp)
ffffffffc0202570:	eca6                	sd	s1,88(sp)
ffffffffc0202572:	e8ca                	sd	s2,80(sp)
ffffffffc0202574:	e4ce                	sd	s3,72(sp)
ffffffffc0202576:	e0d2                	sd	s4,64(sp)
ffffffffc0202578:	fc56                	sd	s5,56(sp)
ffffffffc020257a:	f85a                	sd	s6,48(sp)
ffffffffc020257c:	f45e                	sd	s7,40(sp)
ffffffffc020257e:	f062                	sd	s8,32(sp)
ffffffffc0202580:	ec66                	sd	s9,24(sp)
ffffffffc0202582:	e86a                	sd	s10,16(sp)
ffffffffc0202584:	17d2                	slli	a5,a5,0x34
ffffffffc0202586:	e3ed                	bnez	a5,ffffffffc0202668 <unmap_range+0x102>
ffffffffc0202588:	002007b7          	lui	a5,0x200
ffffffffc020258c:	842e                	mv	s0,a1
ffffffffc020258e:	0ef5ed63          	bltu	a1,a5,ffffffffc0202688 <unmap_range+0x122>
ffffffffc0202592:	8932                	mv	s2,a2
ffffffffc0202594:	0ec5fa63          	bgeu	a1,a2,ffffffffc0202688 <unmap_range+0x122>
ffffffffc0202598:	4785                	li	a5,1
ffffffffc020259a:	07fe                	slli	a5,a5,0x1f
ffffffffc020259c:	0ec7e663          	bltu	a5,a2,ffffffffc0202688 <unmap_range+0x122>
ffffffffc02025a0:	89aa                	mv	s3,a0
ffffffffc02025a2:	6a05                	lui	s4,0x1
ffffffffc02025a4:	00094c97          	auipc	s9,0x94
ffffffffc02025a8:	2fcc8c93          	addi	s9,s9,764 # ffffffffc02968a0 <npage>
ffffffffc02025ac:	00094c17          	auipc	s8,0x94
ffffffffc02025b0:	2fcc0c13          	addi	s8,s8,764 # ffffffffc02968a8 <pages>
ffffffffc02025b4:	fff80bb7          	lui	s7,0xfff80
ffffffffc02025b8:	00094d17          	auipc	s10,0x94
ffffffffc02025bc:	2f8d0d13          	addi	s10,s10,760 # ffffffffc02968b0 <pmm_manager>
ffffffffc02025c0:	00200b37          	lui	s6,0x200
ffffffffc02025c4:	ffe00ab7          	lui	s5,0xffe00
ffffffffc02025c8:	4601                	li	a2,0
ffffffffc02025ca:	85a2                	mv	a1,s0
ffffffffc02025cc:	854e                	mv	a0,s3
ffffffffc02025ce:	c57ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02025d2:	84aa                	mv	s1,a0
ffffffffc02025d4:	cd29                	beqz	a0,ffffffffc020262e <unmap_range+0xc8>
ffffffffc02025d6:	611c                	ld	a5,0(a0)
ffffffffc02025d8:	e395                	bnez	a5,ffffffffc02025fc <unmap_range+0x96>
ffffffffc02025da:	9452                	add	s0,s0,s4
ffffffffc02025dc:	ff2466e3          	bltu	s0,s2,ffffffffc02025c8 <unmap_range+0x62>
ffffffffc02025e0:	70a6                	ld	ra,104(sp)
ffffffffc02025e2:	7406                	ld	s0,96(sp)
ffffffffc02025e4:	64e6                	ld	s1,88(sp)
ffffffffc02025e6:	6946                	ld	s2,80(sp)
ffffffffc02025e8:	69a6                	ld	s3,72(sp)
ffffffffc02025ea:	6a06                	ld	s4,64(sp)
ffffffffc02025ec:	7ae2                	ld	s5,56(sp)
ffffffffc02025ee:	7b42                	ld	s6,48(sp)
ffffffffc02025f0:	7ba2                	ld	s7,40(sp)
ffffffffc02025f2:	7c02                	ld	s8,32(sp)
ffffffffc02025f4:	6ce2                	ld	s9,24(sp)
ffffffffc02025f6:	6d42                	ld	s10,16(sp)
ffffffffc02025f8:	6165                	addi	sp,sp,112
ffffffffc02025fa:	8082                	ret
ffffffffc02025fc:	0017f713          	andi	a4,a5,1
ffffffffc0202600:	df69                	beqz	a4,ffffffffc02025da <unmap_range+0x74>
ffffffffc0202602:	000cb703          	ld	a4,0(s9)
ffffffffc0202606:	078a                	slli	a5,a5,0x2
ffffffffc0202608:	83b1                	srli	a5,a5,0xc
ffffffffc020260a:	08e7ff63          	bgeu	a5,a4,ffffffffc02026a8 <unmap_range+0x142>
ffffffffc020260e:	000c3503          	ld	a0,0(s8)
ffffffffc0202612:	97de                	add	a5,a5,s7
ffffffffc0202614:	079a                	slli	a5,a5,0x6
ffffffffc0202616:	953e                	add	a0,a0,a5
ffffffffc0202618:	411c                	lw	a5,0(a0)
ffffffffc020261a:	fff7871b          	addiw	a4,a5,-1
ffffffffc020261e:	c118                	sw	a4,0(a0)
ffffffffc0202620:	cf11                	beqz	a4,ffffffffc020263c <unmap_range+0xd6>
ffffffffc0202622:	0004b023          	sd	zero,0(s1)
ffffffffc0202626:	12040073          	sfence.vma	s0
ffffffffc020262a:	9452                	add	s0,s0,s4
ffffffffc020262c:	bf45                	j	ffffffffc02025dc <unmap_range+0x76>
ffffffffc020262e:	945a                	add	s0,s0,s6
ffffffffc0202630:	01547433          	and	s0,s0,s5
ffffffffc0202634:	d455                	beqz	s0,ffffffffc02025e0 <unmap_range+0x7a>
ffffffffc0202636:	f92469e3          	bltu	s0,s2,ffffffffc02025c8 <unmap_range+0x62>
ffffffffc020263a:	b75d                	j	ffffffffc02025e0 <unmap_range+0x7a>
ffffffffc020263c:	100027f3          	csrr	a5,sstatus
ffffffffc0202640:	8b89                	andi	a5,a5,2
ffffffffc0202642:	e799                	bnez	a5,ffffffffc0202650 <unmap_range+0xea>
ffffffffc0202644:	000d3783          	ld	a5,0(s10)
ffffffffc0202648:	4585                	li	a1,1
ffffffffc020264a:	739c                	ld	a5,32(a5)
ffffffffc020264c:	9782                	jalr	a5
ffffffffc020264e:	bfd1                	j	ffffffffc0202622 <unmap_range+0xbc>
ffffffffc0202650:	e42a                	sd	a0,8(sp)
ffffffffc0202652:	e20fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202656:	000d3783          	ld	a5,0(s10)
ffffffffc020265a:	6522                	ld	a0,8(sp)
ffffffffc020265c:	4585                	li	a1,1
ffffffffc020265e:	739c                	ld	a5,32(a5)
ffffffffc0202660:	9782                	jalr	a5
ffffffffc0202662:	e0afe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202666:	bf75                	j	ffffffffc0202622 <unmap_range+0xbc>
ffffffffc0202668:	0000a697          	auipc	a3,0xa
ffffffffc020266c:	c8068693          	addi	a3,a3,-896 # ffffffffc020c2e8 <default_pmm_manager+0x188>
ffffffffc0202670:	00009617          	auipc	a2,0x9
ffffffffc0202674:	00860613          	addi	a2,a2,8 # ffffffffc020b678 <commands+0x210>
ffffffffc0202678:	15a00593          	li	a1,346
ffffffffc020267c:	0000a517          	auipc	a0,0xa
ffffffffc0202680:	c3450513          	addi	a0,a0,-972 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0202684:	e1bfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202688:	0000a697          	auipc	a3,0xa
ffffffffc020268c:	c9068693          	addi	a3,a3,-880 # ffffffffc020c318 <default_pmm_manager+0x1b8>
ffffffffc0202690:	00009617          	auipc	a2,0x9
ffffffffc0202694:	fe860613          	addi	a2,a2,-24 # ffffffffc020b678 <commands+0x210>
ffffffffc0202698:	15b00593          	li	a1,347
ffffffffc020269c:	0000a517          	auipc	a0,0xa
ffffffffc02026a0:	c1450513          	addi	a0,a0,-1004 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02026a4:	dfbfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02026a8:	a8dff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc02026ac <exit_range>:
ffffffffc02026ac:	7119                	addi	sp,sp,-128
ffffffffc02026ae:	00c5e7b3          	or	a5,a1,a2
ffffffffc02026b2:	fc86                	sd	ra,120(sp)
ffffffffc02026b4:	f8a2                	sd	s0,112(sp)
ffffffffc02026b6:	f4a6                	sd	s1,104(sp)
ffffffffc02026b8:	f0ca                	sd	s2,96(sp)
ffffffffc02026ba:	ecce                	sd	s3,88(sp)
ffffffffc02026bc:	e8d2                	sd	s4,80(sp)
ffffffffc02026be:	e4d6                	sd	s5,72(sp)
ffffffffc02026c0:	e0da                	sd	s6,64(sp)
ffffffffc02026c2:	fc5e                	sd	s7,56(sp)
ffffffffc02026c4:	f862                	sd	s8,48(sp)
ffffffffc02026c6:	f466                	sd	s9,40(sp)
ffffffffc02026c8:	f06a                	sd	s10,32(sp)
ffffffffc02026ca:	ec6e                	sd	s11,24(sp)
ffffffffc02026cc:	17d2                	slli	a5,a5,0x34
ffffffffc02026ce:	20079a63          	bnez	a5,ffffffffc02028e2 <exit_range+0x236>
ffffffffc02026d2:	002007b7          	lui	a5,0x200
ffffffffc02026d6:	24f5e463          	bltu	a1,a5,ffffffffc020291e <exit_range+0x272>
ffffffffc02026da:	8ab2                	mv	s5,a2
ffffffffc02026dc:	24c5f163          	bgeu	a1,a2,ffffffffc020291e <exit_range+0x272>
ffffffffc02026e0:	4785                	li	a5,1
ffffffffc02026e2:	07fe                	slli	a5,a5,0x1f
ffffffffc02026e4:	22c7ed63          	bltu	a5,a2,ffffffffc020291e <exit_range+0x272>
ffffffffc02026e8:	c00009b7          	lui	s3,0xc0000
ffffffffc02026ec:	0135f9b3          	and	s3,a1,s3
ffffffffc02026f0:	ffe00937          	lui	s2,0xffe00
ffffffffc02026f4:	400007b7          	lui	a5,0x40000
ffffffffc02026f8:	5cfd                	li	s9,-1
ffffffffc02026fa:	8c2a                	mv	s8,a0
ffffffffc02026fc:	0125f933          	and	s2,a1,s2
ffffffffc0202700:	99be                	add	s3,s3,a5
ffffffffc0202702:	00094d17          	auipc	s10,0x94
ffffffffc0202706:	19ed0d13          	addi	s10,s10,414 # ffffffffc02968a0 <npage>
ffffffffc020270a:	00ccdc93          	srli	s9,s9,0xc
ffffffffc020270e:	00094717          	auipc	a4,0x94
ffffffffc0202712:	19a70713          	addi	a4,a4,410 # ffffffffc02968a8 <pages>
ffffffffc0202716:	00094d97          	auipc	s11,0x94
ffffffffc020271a:	19ad8d93          	addi	s11,s11,410 # ffffffffc02968b0 <pmm_manager>
ffffffffc020271e:	c0000437          	lui	s0,0xc0000
ffffffffc0202722:	944e                	add	s0,s0,s3
ffffffffc0202724:	8079                	srli	s0,s0,0x1e
ffffffffc0202726:	1ff47413          	andi	s0,s0,511
ffffffffc020272a:	040e                	slli	s0,s0,0x3
ffffffffc020272c:	9462                	add	s0,s0,s8
ffffffffc020272e:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202732:	001a7793          	andi	a5,s4,1
ffffffffc0202736:	eb99                	bnez	a5,ffffffffc020274c <exit_range+0xa0>
ffffffffc0202738:	12098463          	beqz	s3,ffffffffc0202860 <exit_range+0x1b4>
ffffffffc020273c:	400007b7          	lui	a5,0x40000
ffffffffc0202740:	97ce                	add	a5,a5,s3
ffffffffc0202742:	894e                	mv	s2,s3
ffffffffc0202744:	1159fe63          	bgeu	s3,s5,ffffffffc0202860 <exit_range+0x1b4>
ffffffffc0202748:	89be                	mv	s3,a5
ffffffffc020274a:	bfd1                	j	ffffffffc020271e <exit_range+0x72>
ffffffffc020274c:	000d3783          	ld	a5,0(s10)
ffffffffc0202750:	0a0a                	slli	s4,s4,0x2
ffffffffc0202752:	00ca5a13          	srli	s4,s4,0xc
ffffffffc0202756:	1cfa7263          	bgeu	s4,a5,ffffffffc020291a <exit_range+0x26e>
ffffffffc020275a:	fff80637          	lui	a2,0xfff80
ffffffffc020275e:	9652                	add	a2,a2,s4
ffffffffc0202760:	000806b7          	lui	a3,0x80
ffffffffc0202764:	96b2                	add	a3,a3,a2
ffffffffc0202766:	0196f5b3          	and	a1,a3,s9
ffffffffc020276a:	061a                	slli	a2,a2,0x6
ffffffffc020276c:	06b2                	slli	a3,a3,0xc
ffffffffc020276e:	18f5fa63          	bgeu	a1,a5,ffffffffc0202902 <exit_range+0x256>
ffffffffc0202772:	00094817          	auipc	a6,0x94
ffffffffc0202776:	14680813          	addi	a6,a6,326 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020277a:	00083b03          	ld	s6,0(a6)
ffffffffc020277e:	4b85                	li	s7,1
ffffffffc0202780:	fff80e37          	lui	t3,0xfff80
ffffffffc0202784:	9b36                	add	s6,s6,a3
ffffffffc0202786:	00080337          	lui	t1,0x80
ffffffffc020278a:	6885                	lui	a7,0x1
ffffffffc020278c:	a819                	j	ffffffffc02027a2 <exit_range+0xf6>
ffffffffc020278e:	4b81                	li	s7,0
ffffffffc0202790:	002007b7          	lui	a5,0x200
ffffffffc0202794:	993e                	add	s2,s2,a5
ffffffffc0202796:	08090c63          	beqz	s2,ffffffffc020282e <exit_range+0x182>
ffffffffc020279a:	09397a63          	bgeu	s2,s3,ffffffffc020282e <exit_range+0x182>
ffffffffc020279e:	0f597063          	bgeu	s2,s5,ffffffffc020287e <exit_range+0x1d2>
ffffffffc02027a2:	01595493          	srli	s1,s2,0x15
ffffffffc02027a6:	1ff4f493          	andi	s1,s1,511
ffffffffc02027aa:	048e                	slli	s1,s1,0x3
ffffffffc02027ac:	94da                	add	s1,s1,s6
ffffffffc02027ae:	609c                	ld	a5,0(s1)
ffffffffc02027b0:	0017f693          	andi	a3,a5,1
ffffffffc02027b4:	dee9                	beqz	a3,ffffffffc020278e <exit_range+0xe2>
ffffffffc02027b6:	000d3583          	ld	a1,0(s10)
ffffffffc02027ba:	078a                	slli	a5,a5,0x2
ffffffffc02027bc:	83b1                	srli	a5,a5,0xc
ffffffffc02027be:	14b7fe63          	bgeu	a5,a1,ffffffffc020291a <exit_range+0x26e>
ffffffffc02027c2:	97f2                	add	a5,a5,t3
ffffffffc02027c4:	006786b3          	add	a3,a5,t1
ffffffffc02027c8:	0196feb3          	and	t4,a3,s9
ffffffffc02027cc:	00679513          	slli	a0,a5,0x6
ffffffffc02027d0:	06b2                	slli	a3,a3,0xc
ffffffffc02027d2:	12bef863          	bgeu	t4,a1,ffffffffc0202902 <exit_range+0x256>
ffffffffc02027d6:	00083783          	ld	a5,0(a6)
ffffffffc02027da:	96be                	add	a3,a3,a5
ffffffffc02027dc:	011685b3          	add	a1,a3,a7
ffffffffc02027e0:	629c                	ld	a5,0(a3)
ffffffffc02027e2:	8b85                	andi	a5,a5,1
ffffffffc02027e4:	f7d5                	bnez	a5,ffffffffc0202790 <exit_range+0xe4>
ffffffffc02027e6:	06a1                	addi	a3,a3,8
ffffffffc02027e8:	fed59ce3          	bne	a1,a3,ffffffffc02027e0 <exit_range+0x134>
ffffffffc02027ec:	631c                	ld	a5,0(a4)
ffffffffc02027ee:	953e                	add	a0,a0,a5
ffffffffc02027f0:	100027f3          	csrr	a5,sstatus
ffffffffc02027f4:	8b89                	andi	a5,a5,2
ffffffffc02027f6:	e7d9                	bnez	a5,ffffffffc0202884 <exit_range+0x1d8>
ffffffffc02027f8:	000db783          	ld	a5,0(s11)
ffffffffc02027fc:	4585                	li	a1,1
ffffffffc02027fe:	e032                	sd	a2,0(sp)
ffffffffc0202800:	739c                	ld	a5,32(a5)
ffffffffc0202802:	9782                	jalr	a5
ffffffffc0202804:	6602                	ld	a2,0(sp)
ffffffffc0202806:	00094817          	auipc	a6,0x94
ffffffffc020280a:	0b280813          	addi	a6,a6,178 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020280e:	fff80e37          	lui	t3,0xfff80
ffffffffc0202812:	00080337          	lui	t1,0x80
ffffffffc0202816:	6885                	lui	a7,0x1
ffffffffc0202818:	00094717          	auipc	a4,0x94
ffffffffc020281c:	09070713          	addi	a4,a4,144 # ffffffffc02968a8 <pages>
ffffffffc0202820:	0004b023          	sd	zero,0(s1)
ffffffffc0202824:	002007b7          	lui	a5,0x200
ffffffffc0202828:	993e                	add	s2,s2,a5
ffffffffc020282a:	f60918e3          	bnez	s2,ffffffffc020279a <exit_range+0xee>
ffffffffc020282e:	f00b85e3          	beqz	s7,ffffffffc0202738 <exit_range+0x8c>
ffffffffc0202832:	000d3783          	ld	a5,0(s10)
ffffffffc0202836:	0efa7263          	bgeu	s4,a5,ffffffffc020291a <exit_range+0x26e>
ffffffffc020283a:	6308                	ld	a0,0(a4)
ffffffffc020283c:	9532                	add	a0,a0,a2
ffffffffc020283e:	100027f3          	csrr	a5,sstatus
ffffffffc0202842:	8b89                	andi	a5,a5,2
ffffffffc0202844:	efad                	bnez	a5,ffffffffc02028be <exit_range+0x212>
ffffffffc0202846:	000db783          	ld	a5,0(s11)
ffffffffc020284a:	4585                	li	a1,1
ffffffffc020284c:	739c                	ld	a5,32(a5)
ffffffffc020284e:	9782                	jalr	a5
ffffffffc0202850:	00094717          	auipc	a4,0x94
ffffffffc0202854:	05870713          	addi	a4,a4,88 # ffffffffc02968a8 <pages>
ffffffffc0202858:	00043023          	sd	zero,0(s0)
ffffffffc020285c:	ee0990e3          	bnez	s3,ffffffffc020273c <exit_range+0x90>
ffffffffc0202860:	70e6                	ld	ra,120(sp)
ffffffffc0202862:	7446                	ld	s0,112(sp)
ffffffffc0202864:	74a6                	ld	s1,104(sp)
ffffffffc0202866:	7906                	ld	s2,96(sp)
ffffffffc0202868:	69e6                	ld	s3,88(sp)
ffffffffc020286a:	6a46                	ld	s4,80(sp)
ffffffffc020286c:	6aa6                	ld	s5,72(sp)
ffffffffc020286e:	6b06                	ld	s6,64(sp)
ffffffffc0202870:	7be2                	ld	s7,56(sp)
ffffffffc0202872:	7c42                	ld	s8,48(sp)
ffffffffc0202874:	7ca2                	ld	s9,40(sp)
ffffffffc0202876:	7d02                	ld	s10,32(sp)
ffffffffc0202878:	6de2                	ld	s11,24(sp)
ffffffffc020287a:	6109                	addi	sp,sp,128
ffffffffc020287c:	8082                	ret
ffffffffc020287e:	ea0b8fe3          	beqz	s7,ffffffffc020273c <exit_range+0x90>
ffffffffc0202882:	bf45                	j	ffffffffc0202832 <exit_range+0x186>
ffffffffc0202884:	e032                	sd	a2,0(sp)
ffffffffc0202886:	e42a                	sd	a0,8(sp)
ffffffffc0202888:	beafe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020288c:	000db783          	ld	a5,0(s11)
ffffffffc0202890:	6522                	ld	a0,8(sp)
ffffffffc0202892:	4585                	li	a1,1
ffffffffc0202894:	739c                	ld	a5,32(a5)
ffffffffc0202896:	9782                	jalr	a5
ffffffffc0202898:	bd4fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020289c:	6602                	ld	a2,0(sp)
ffffffffc020289e:	00094717          	auipc	a4,0x94
ffffffffc02028a2:	00a70713          	addi	a4,a4,10 # ffffffffc02968a8 <pages>
ffffffffc02028a6:	6885                	lui	a7,0x1
ffffffffc02028a8:	00080337          	lui	t1,0x80
ffffffffc02028ac:	fff80e37          	lui	t3,0xfff80
ffffffffc02028b0:	00094817          	auipc	a6,0x94
ffffffffc02028b4:	00880813          	addi	a6,a6,8 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02028b8:	0004b023          	sd	zero,0(s1)
ffffffffc02028bc:	b7a5                	j	ffffffffc0202824 <exit_range+0x178>
ffffffffc02028be:	e02a                	sd	a0,0(sp)
ffffffffc02028c0:	bb2fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02028c4:	000db783          	ld	a5,0(s11)
ffffffffc02028c8:	6502                	ld	a0,0(sp)
ffffffffc02028ca:	4585                	li	a1,1
ffffffffc02028cc:	739c                	ld	a5,32(a5)
ffffffffc02028ce:	9782                	jalr	a5
ffffffffc02028d0:	b9cfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02028d4:	00094717          	auipc	a4,0x94
ffffffffc02028d8:	fd470713          	addi	a4,a4,-44 # ffffffffc02968a8 <pages>
ffffffffc02028dc:	00043023          	sd	zero,0(s0)
ffffffffc02028e0:	bfb5                	j	ffffffffc020285c <exit_range+0x1b0>
ffffffffc02028e2:	0000a697          	auipc	a3,0xa
ffffffffc02028e6:	a0668693          	addi	a3,a3,-1530 # ffffffffc020c2e8 <default_pmm_manager+0x188>
ffffffffc02028ea:	00009617          	auipc	a2,0x9
ffffffffc02028ee:	d8e60613          	addi	a2,a2,-626 # ffffffffc020b678 <commands+0x210>
ffffffffc02028f2:	16f00593          	li	a1,367
ffffffffc02028f6:	0000a517          	auipc	a0,0xa
ffffffffc02028fa:	9ba50513          	addi	a0,a0,-1606 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02028fe:	ba1fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202902:	0000a617          	auipc	a2,0xa
ffffffffc0202906:	89660613          	addi	a2,a2,-1898 # ffffffffc020c198 <default_pmm_manager+0x38>
ffffffffc020290a:	07100593          	li	a1,113
ffffffffc020290e:	0000a517          	auipc	a0,0xa
ffffffffc0202912:	8b250513          	addi	a0,a0,-1870 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc0202916:	b89fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020291a:	81bff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>
ffffffffc020291e:	0000a697          	auipc	a3,0xa
ffffffffc0202922:	9fa68693          	addi	a3,a3,-1542 # ffffffffc020c318 <default_pmm_manager+0x1b8>
ffffffffc0202926:	00009617          	auipc	a2,0x9
ffffffffc020292a:	d5260613          	addi	a2,a2,-686 # ffffffffc020b678 <commands+0x210>
ffffffffc020292e:	17000593          	li	a1,368
ffffffffc0202932:	0000a517          	auipc	a0,0xa
ffffffffc0202936:	97e50513          	addi	a0,a0,-1666 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc020293a:	b65fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020293e <page_remove>:
ffffffffc020293e:	7179                	addi	sp,sp,-48
ffffffffc0202940:	4601                	li	a2,0
ffffffffc0202942:	ec26                	sd	s1,24(sp)
ffffffffc0202944:	f406                	sd	ra,40(sp)
ffffffffc0202946:	f022                	sd	s0,32(sp)
ffffffffc0202948:	84ae                	mv	s1,a1
ffffffffc020294a:	8dbff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc020294e:	c511                	beqz	a0,ffffffffc020295a <page_remove+0x1c>
ffffffffc0202950:	611c                	ld	a5,0(a0)
ffffffffc0202952:	842a                	mv	s0,a0
ffffffffc0202954:	0017f713          	andi	a4,a5,1
ffffffffc0202958:	e711                	bnez	a4,ffffffffc0202964 <page_remove+0x26>
ffffffffc020295a:	70a2                	ld	ra,40(sp)
ffffffffc020295c:	7402                	ld	s0,32(sp)
ffffffffc020295e:	64e2                	ld	s1,24(sp)
ffffffffc0202960:	6145                	addi	sp,sp,48
ffffffffc0202962:	8082                	ret
ffffffffc0202964:	078a                	slli	a5,a5,0x2
ffffffffc0202966:	83b1                	srli	a5,a5,0xc
ffffffffc0202968:	00094717          	auipc	a4,0x94
ffffffffc020296c:	f3873703          	ld	a4,-200(a4) # ffffffffc02968a0 <npage>
ffffffffc0202970:	06e7f363          	bgeu	a5,a4,ffffffffc02029d6 <page_remove+0x98>
ffffffffc0202974:	fff80537          	lui	a0,0xfff80
ffffffffc0202978:	97aa                	add	a5,a5,a0
ffffffffc020297a:	079a                	slli	a5,a5,0x6
ffffffffc020297c:	00094517          	auipc	a0,0x94
ffffffffc0202980:	f2c53503          	ld	a0,-212(a0) # ffffffffc02968a8 <pages>
ffffffffc0202984:	953e                	add	a0,a0,a5
ffffffffc0202986:	411c                	lw	a5,0(a0)
ffffffffc0202988:	fff7871b          	addiw	a4,a5,-1
ffffffffc020298c:	c118                	sw	a4,0(a0)
ffffffffc020298e:	cb11                	beqz	a4,ffffffffc02029a2 <page_remove+0x64>
ffffffffc0202990:	00043023          	sd	zero,0(s0)
ffffffffc0202994:	12048073          	sfence.vma	s1
ffffffffc0202998:	70a2                	ld	ra,40(sp)
ffffffffc020299a:	7402                	ld	s0,32(sp)
ffffffffc020299c:	64e2                	ld	s1,24(sp)
ffffffffc020299e:	6145                	addi	sp,sp,48
ffffffffc02029a0:	8082                	ret
ffffffffc02029a2:	100027f3          	csrr	a5,sstatus
ffffffffc02029a6:	8b89                	andi	a5,a5,2
ffffffffc02029a8:	eb89                	bnez	a5,ffffffffc02029ba <page_remove+0x7c>
ffffffffc02029aa:	00094797          	auipc	a5,0x94
ffffffffc02029ae:	f067b783          	ld	a5,-250(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02029b2:	739c                	ld	a5,32(a5)
ffffffffc02029b4:	4585                	li	a1,1
ffffffffc02029b6:	9782                	jalr	a5
ffffffffc02029b8:	bfe1                	j	ffffffffc0202990 <page_remove+0x52>
ffffffffc02029ba:	e42a                	sd	a0,8(sp)
ffffffffc02029bc:	ab6fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02029c0:	00094797          	auipc	a5,0x94
ffffffffc02029c4:	ef07b783          	ld	a5,-272(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02029c8:	739c                	ld	a5,32(a5)
ffffffffc02029ca:	6522                	ld	a0,8(sp)
ffffffffc02029cc:	4585                	li	a1,1
ffffffffc02029ce:	9782                	jalr	a5
ffffffffc02029d0:	a9cfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02029d4:	bf75                	j	ffffffffc0202990 <page_remove+0x52>
ffffffffc02029d6:	f5eff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc02029da <page_insert>:
ffffffffc02029da:	7139                	addi	sp,sp,-64
ffffffffc02029dc:	e852                	sd	s4,16(sp)
ffffffffc02029de:	8a32                	mv	s4,a2
ffffffffc02029e0:	f822                	sd	s0,48(sp)
ffffffffc02029e2:	4605                	li	a2,1
ffffffffc02029e4:	842e                	mv	s0,a1
ffffffffc02029e6:	85d2                	mv	a1,s4
ffffffffc02029e8:	f426                	sd	s1,40(sp)
ffffffffc02029ea:	fc06                	sd	ra,56(sp)
ffffffffc02029ec:	f04a                	sd	s2,32(sp)
ffffffffc02029ee:	ec4e                	sd	s3,24(sp)
ffffffffc02029f0:	e456                	sd	s5,8(sp)
ffffffffc02029f2:	84b6                	mv	s1,a3
ffffffffc02029f4:	831ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02029f8:	c961                	beqz	a0,ffffffffc0202ac8 <page_insert+0xee>
ffffffffc02029fa:	4014                	lw	a3,0(s0)
ffffffffc02029fc:	611c                	ld	a5,0(a0)
ffffffffc02029fe:	89aa                	mv	s3,a0
ffffffffc0202a00:	0016871b          	addiw	a4,a3,1
ffffffffc0202a04:	c018                	sw	a4,0(s0)
ffffffffc0202a06:	0017f713          	andi	a4,a5,1
ffffffffc0202a0a:	ef05                	bnez	a4,ffffffffc0202a42 <page_insert+0x68>
ffffffffc0202a0c:	00094717          	auipc	a4,0x94
ffffffffc0202a10:	e9c73703          	ld	a4,-356(a4) # ffffffffc02968a8 <pages>
ffffffffc0202a14:	8c19                	sub	s0,s0,a4
ffffffffc0202a16:	000807b7          	lui	a5,0x80
ffffffffc0202a1a:	8419                	srai	s0,s0,0x6
ffffffffc0202a1c:	943e                	add	s0,s0,a5
ffffffffc0202a1e:	042a                	slli	s0,s0,0xa
ffffffffc0202a20:	8cc1                	or	s1,s1,s0
ffffffffc0202a22:	0014e493          	ori	s1,s1,1
ffffffffc0202a26:	0099b023          	sd	s1,0(s3) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202a2a:	120a0073          	sfence.vma	s4
ffffffffc0202a2e:	4501                	li	a0,0
ffffffffc0202a30:	70e2                	ld	ra,56(sp)
ffffffffc0202a32:	7442                	ld	s0,48(sp)
ffffffffc0202a34:	74a2                	ld	s1,40(sp)
ffffffffc0202a36:	7902                	ld	s2,32(sp)
ffffffffc0202a38:	69e2                	ld	s3,24(sp)
ffffffffc0202a3a:	6a42                	ld	s4,16(sp)
ffffffffc0202a3c:	6aa2                	ld	s5,8(sp)
ffffffffc0202a3e:	6121                	addi	sp,sp,64
ffffffffc0202a40:	8082                	ret
ffffffffc0202a42:	078a                	slli	a5,a5,0x2
ffffffffc0202a44:	83b1                	srli	a5,a5,0xc
ffffffffc0202a46:	00094717          	auipc	a4,0x94
ffffffffc0202a4a:	e5a73703          	ld	a4,-422(a4) # ffffffffc02968a0 <npage>
ffffffffc0202a4e:	06e7ff63          	bgeu	a5,a4,ffffffffc0202acc <page_insert+0xf2>
ffffffffc0202a52:	00094a97          	auipc	s5,0x94
ffffffffc0202a56:	e56a8a93          	addi	s5,s5,-426 # ffffffffc02968a8 <pages>
ffffffffc0202a5a:	000ab703          	ld	a4,0(s5)
ffffffffc0202a5e:	fff80937          	lui	s2,0xfff80
ffffffffc0202a62:	993e                	add	s2,s2,a5
ffffffffc0202a64:	091a                	slli	s2,s2,0x6
ffffffffc0202a66:	993a                	add	s2,s2,a4
ffffffffc0202a68:	01240c63          	beq	s0,s2,ffffffffc0202a80 <page_insert+0xa6>
ffffffffc0202a6c:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc0202a70:	fff7869b          	addiw	a3,a5,-1
ffffffffc0202a74:	00d92023          	sw	a3,0(s2)
ffffffffc0202a78:	c691                	beqz	a3,ffffffffc0202a84 <page_insert+0xaa>
ffffffffc0202a7a:	120a0073          	sfence.vma	s4
ffffffffc0202a7e:	bf59                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202a80:	c014                	sw	a3,0(s0)
ffffffffc0202a82:	bf49                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202a84:	100027f3          	csrr	a5,sstatus
ffffffffc0202a88:	8b89                	andi	a5,a5,2
ffffffffc0202a8a:	ef91                	bnez	a5,ffffffffc0202aa6 <page_insert+0xcc>
ffffffffc0202a8c:	00094797          	auipc	a5,0x94
ffffffffc0202a90:	e247b783          	ld	a5,-476(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202a94:	739c                	ld	a5,32(a5)
ffffffffc0202a96:	4585                	li	a1,1
ffffffffc0202a98:	854a                	mv	a0,s2
ffffffffc0202a9a:	9782                	jalr	a5
ffffffffc0202a9c:	000ab703          	ld	a4,0(s5)
ffffffffc0202aa0:	120a0073          	sfence.vma	s4
ffffffffc0202aa4:	bf85                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202aa6:	9ccfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202aaa:	00094797          	auipc	a5,0x94
ffffffffc0202aae:	e067b783          	ld	a5,-506(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202ab2:	739c                	ld	a5,32(a5)
ffffffffc0202ab4:	4585                	li	a1,1
ffffffffc0202ab6:	854a                	mv	a0,s2
ffffffffc0202ab8:	9782                	jalr	a5
ffffffffc0202aba:	9b2fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202abe:	000ab703          	ld	a4,0(s5)
ffffffffc0202ac2:	120a0073          	sfence.vma	s4
ffffffffc0202ac6:	b7b9                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202ac8:	5571                	li	a0,-4
ffffffffc0202aca:	b79d                	j	ffffffffc0202a30 <page_insert+0x56>
ffffffffc0202acc:	e68ff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc0202ad0 <pmm_init>:
ffffffffc0202ad0:	00009797          	auipc	a5,0x9
ffffffffc0202ad4:	69078793          	addi	a5,a5,1680 # ffffffffc020c160 <default_pmm_manager>
ffffffffc0202ad8:	638c                	ld	a1,0(a5)
ffffffffc0202ada:	7159                	addi	sp,sp,-112
ffffffffc0202adc:	f85a                	sd	s6,48(sp)
ffffffffc0202ade:	0000a517          	auipc	a0,0xa
ffffffffc0202ae2:	85250513          	addi	a0,a0,-1966 # ffffffffc020c330 <default_pmm_manager+0x1d0>
ffffffffc0202ae6:	00094b17          	auipc	s6,0x94
ffffffffc0202aea:	dcab0b13          	addi	s6,s6,-566 # ffffffffc02968b0 <pmm_manager>
ffffffffc0202aee:	f486                	sd	ra,104(sp)
ffffffffc0202af0:	e8ca                	sd	s2,80(sp)
ffffffffc0202af2:	e4ce                	sd	s3,72(sp)
ffffffffc0202af4:	f0a2                	sd	s0,96(sp)
ffffffffc0202af6:	eca6                	sd	s1,88(sp)
ffffffffc0202af8:	e0d2                	sd	s4,64(sp)
ffffffffc0202afa:	fc56                	sd	s5,56(sp)
ffffffffc0202afc:	f45e                	sd	s7,40(sp)
ffffffffc0202afe:	f062                	sd	s8,32(sp)
ffffffffc0202b00:	ec66                	sd	s9,24(sp)
ffffffffc0202b02:	00fb3023          	sd	a5,0(s6)
ffffffffc0202b06:	ea0fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b0a:	000b3783          	ld	a5,0(s6)
ffffffffc0202b0e:	00094997          	auipc	s3,0x94
ffffffffc0202b12:	daa98993          	addi	s3,s3,-598 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202b16:	679c                	ld	a5,8(a5)
ffffffffc0202b18:	9782                	jalr	a5
ffffffffc0202b1a:	57f5                	li	a5,-3
ffffffffc0202b1c:	07fa                	slli	a5,a5,0x1e
ffffffffc0202b1e:	00f9b023          	sd	a5,0(s3)
ffffffffc0202b22:	f27fd0ef          	jal	ra,ffffffffc0200a48 <get_memory_base>
ffffffffc0202b26:	892a                	mv	s2,a0
ffffffffc0202b28:	f2bfd0ef          	jal	ra,ffffffffc0200a52 <get_memory_size>
ffffffffc0202b2c:	280502e3          	beqz	a0,ffffffffc02035b0 <pmm_init+0xae0>
ffffffffc0202b30:	84aa                	mv	s1,a0
ffffffffc0202b32:	0000a517          	auipc	a0,0xa
ffffffffc0202b36:	83650513          	addi	a0,a0,-1994 # ffffffffc020c368 <default_pmm_manager+0x208>
ffffffffc0202b3a:	e6cfd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b3e:	00990433          	add	s0,s2,s1
ffffffffc0202b42:	fff40693          	addi	a3,s0,-1
ffffffffc0202b46:	864a                	mv	a2,s2
ffffffffc0202b48:	85a6                	mv	a1,s1
ffffffffc0202b4a:	0000a517          	auipc	a0,0xa
ffffffffc0202b4e:	83650513          	addi	a0,a0,-1994 # ffffffffc020c380 <default_pmm_manager+0x220>
ffffffffc0202b52:	e54fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b56:	c8000737          	lui	a4,0xc8000
ffffffffc0202b5a:	87a2                	mv	a5,s0
ffffffffc0202b5c:	5e876e63          	bltu	a4,s0,ffffffffc0203158 <pmm_init+0x688>
ffffffffc0202b60:	757d                	lui	a0,0xfffff
ffffffffc0202b62:	00095617          	auipc	a2,0x95
ffffffffc0202b66:	dad60613          	addi	a2,a2,-595 # ffffffffc029790f <end+0xfff>
ffffffffc0202b6a:	8e69                	and	a2,a2,a0
ffffffffc0202b6c:	00094497          	auipc	s1,0x94
ffffffffc0202b70:	d3448493          	addi	s1,s1,-716 # ffffffffc02968a0 <npage>
ffffffffc0202b74:	00c7d513          	srli	a0,a5,0xc
ffffffffc0202b78:	00094b97          	auipc	s7,0x94
ffffffffc0202b7c:	d30b8b93          	addi	s7,s7,-720 # ffffffffc02968a8 <pages>
ffffffffc0202b80:	e088                	sd	a0,0(s1)
ffffffffc0202b82:	00cbb023          	sd	a2,0(s7)
ffffffffc0202b86:	000807b7          	lui	a5,0x80
ffffffffc0202b8a:	86b2                	mv	a3,a2
ffffffffc0202b8c:	02f50863          	beq	a0,a5,ffffffffc0202bbc <pmm_init+0xec>
ffffffffc0202b90:	4781                	li	a5,0
ffffffffc0202b92:	4585                	li	a1,1
ffffffffc0202b94:	fff806b7          	lui	a3,0xfff80
ffffffffc0202b98:	00679513          	slli	a0,a5,0x6
ffffffffc0202b9c:	9532                	add	a0,a0,a2
ffffffffc0202b9e:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd686f8>
ffffffffc0202ba2:	40b7302f          	amoor.d	zero,a1,(a4)
ffffffffc0202ba6:	6088                	ld	a0,0(s1)
ffffffffc0202ba8:	0785                	addi	a5,a5,1
ffffffffc0202baa:	000bb603          	ld	a2,0(s7)
ffffffffc0202bae:	00d50733          	add	a4,a0,a3
ffffffffc0202bb2:	fee7e3e3          	bltu	a5,a4,ffffffffc0202b98 <pmm_init+0xc8>
ffffffffc0202bb6:	071a                	slli	a4,a4,0x6
ffffffffc0202bb8:	00e606b3          	add	a3,a2,a4
ffffffffc0202bbc:	c02007b7          	lui	a5,0xc0200
ffffffffc0202bc0:	3af6eae3          	bltu	a3,a5,ffffffffc0203774 <pmm_init+0xca4>
ffffffffc0202bc4:	0009b583          	ld	a1,0(s3)
ffffffffc0202bc8:	77fd                	lui	a5,0xfffff
ffffffffc0202bca:	8c7d                	and	s0,s0,a5
ffffffffc0202bcc:	8e8d                	sub	a3,a3,a1
ffffffffc0202bce:	5e86e363          	bltu	a3,s0,ffffffffc02031b4 <pmm_init+0x6e4>
ffffffffc0202bd2:	00009517          	auipc	a0,0x9
ffffffffc0202bd6:	7d650513          	addi	a0,a0,2006 # ffffffffc020c3a8 <default_pmm_manager+0x248>
ffffffffc0202bda:	dccfd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202bde:	000b3783          	ld	a5,0(s6)
ffffffffc0202be2:	7b9c                	ld	a5,48(a5)
ffffffffc0202be4:	9782                	jalr	a5
ffffffffc0202be6:	00009517          	auipc	a0,0x9
ffffffffc0202bea:	7da50513          	addi	a0,a0,2010 # ffffffffc020c3c0 <default_pmm_manager+0x260>
ffffffffc0202bee:	db8fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202bf2:	100027f3          	csrr	a5,sstatus
ffffffffc0202bf6:	8b89                	andi	a5,a5,2
ffffffffc0202bf8:	5a079363          	bnez	a5,ffffffffc020319e <pmm_init+0x6ce>
ffffffffc0202bfc:	000b3783          	ld	a5,0(s6)
ffffffffc0202c00:	4505                	li	a0,1
ffffffffc0202c02:	6f9c                	ld	a5,24(a5)
ffffffffc0202c04:	9782                	jalr	a5
ffffffffc0202c06:	842a                	mv	s0,a0
ffffffffc0202c08:	180408e3          	beqz	s0,ffffffffc0203598 <pmm_init+0xac8>
ffffffffc0202c0c:	000bb683          	ld	a3,0(s7)
ffffffffc0202c10:	5a7d                	li	s4,-1
ffffffffc0202c12:	6098                	ld	a4,0(s1)
ffffffffc0202c14:	40d406b3          	sub	a3,s0,a3
ffffffffc0202c18:	8699                	srai	a3,a3,0x6
ffffffffc0202c1a:	00080437          	lui	s0,0x80
ffffffffc0202c1e:	96a2                	add	a3,a3,s0
ffffffffc0202c20:	00ca5793          	srli	a5,s4,0xc
ffffffffc0202c24:	8ff5                	and	a5,a5,a3
ffffffffc0202c26:	06b2                	slli	a3,a3,0xc
ffffffffc0202c28:	30e7fde3          	bgeu	a5,a4,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0202c2c:	0009b403          	ld	s0,0(s3)
ffffffffc0202c30:	6605                	lui	a2,0x1
ffffffffc0202c32:	4581                	li	a1,0
ffffffffc0202c34:	9436                	add	s0,s0,a3
ffffffffc0202c36:	8522                	mv	a0,s0
ffffffffc0202c38:	55c080ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc0202c3c:	0009b683          	ld	a3,0(s3)
ffffffffc0202c40:	77fd                	lui	a5,0xfffff
ffffffffc0202c42:	00009917          	auipc	s2,0x9
ffffffffc0202c46:	5bb90913          	addi	s2,s2,1467 # ffffffffc020c1fd <default_pmm_manager+0x9d>
ffffffffc0202c4a:	00f97933          	and	s2,s2,a5
ffffffffc0202c4e:	c0200ab7          	lui	s5,0xc0200
ffffffffc0202c52:	3fe00637          	lui	a2,0x3fe00
ffffffffc0202c56:	964a                	add	a2,a2,s2
ffffffffc0202c58:	4729                	li	a4,10
ffffffffc0202c5a:	40da86b3          	sub	a3,s5,a3
ffffffffc0202c5e:	c02005b7          	lui	a1,0xc0200
ffffffffc0202c62:	8522                	mv	a0,s0
ffffffffc0202c64:	fe8ff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0202c68:	c8000637          	lui	a2,0xc8000
ffffffffc0202c6c:	41260633          	sub	a2,a2,s2
ffffffffc0202c70:	3f596ce3          	bltu	s2,s5,ffffffffc0203868 <pmm_init+0xd98>
ffffffffc0202c74:	0009b683          	ld	a3,0(s3)
ffffffffc0202c78:	85ca                	mv	a1,s2
ffffffffc0202c7a:	4719                	li	a4,6
ffffffffc0202c7c:	40d906b3          	sub	a3,s2,a3
ffffffffc0202c80:	8522                	mv	a0,s0
ffffffffc0202c82:	00094917          	auipc	s2,0x94
ffffffffc0202c86:	c1690913          	addi	s2,s2,-1002 # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0202c8a:	fc2ff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0202c8e:	00893023          	sd	s0,0(s2)
ffffffffc0202c92:	2d5464e3          	bltu	s0,s5,ffffffffc020375a <pmm_init+0xc8a>
ffffffffc0202c96:	0009b783          	ld	a5,0(s3)
ffffffffc0202c9a:	1a7e                	slli	s4,s4,0x3f
ffffffffc0202c9c:	8c1d                	sub	s0,s0,a5
ffffffffc0202c9e:	00c45793          	srli	a5,s0,0xc
ffffffffc0202ca2:	00094717          	auipc	a4,0x94
ffffffffc0202ca6:	be873723          	sd	s0,-1042(a4) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0202caa:	0147ea33          	or	s4,a5,s4
ffffffffc0202cae:	180a1073          	csrw	satp,s4
ffffffffc0202cb2:	12000073          	sfence.vma
ffffffffc0202cb6:	00009517          	auipc	a0,0x9
ffffffffc0202cba:	74a50513          	addi	a0,a0,1866 # ffffffffc020c400 <default_pmm_manager+0x2a0>
ffffffffc0202cbe:	ce8fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202cc2:	0000e717          	auipc	a4,0xe
ffffffffc0202cc6:	33e70713          	addi	a4,a4,830 # ffffffffc0211000 <bootstack>
ffffffffc0202cca:	0000e797          	auipc	a5,0xe
ffffffffc0202cce:	33678793          	addi	a5,a5,822 # ffffffffc0211000 <bootstack>
ffffffffc0202cd2:	5cf70d63          	beq	a4,a5,ffffffffc02032ac <pmm_init+0x7dc>
ffffffffc0202cd6:	100027f3          	csrr	a5,sstatus
ffffffffc0202cda:	8b89                	andi	a5,a5,2
ffffffffc0202cdc:	4a079763          	bnez	a5,ffffffffc020318a <pmm_init+0x6ba>
ffffffffc0202ce0:	000b3783          	ld	a5,0(s6)
ffffffffc0202ce4:	779c                	ld	a5,40(a5)
ffffffffc0202ce6:	9782                	jalr	a5
ffffffffc0202ce8:	842a                	mv	s0,a0
ffffffffc0202cea:	6098                	ld	a4,0(s1)
ffffffffc0202cec:	c80007b7          	lui	a5,0xc8000
ffffffffc0202cf0:	83b1                	srli	a5,a5,0xc
ffffffffc0202cf2:	08e7e3e3          	bltu	a5,a4,ffffffffc0203578 <pmm_init+0xaa8>
ffffffffc0202cf6:	00093503          	ld	a0,0(s2)
ffffffffc0202cfa:	04050fe3          	beqz	a0,ffffffffc0203558 <pmm_init+0xa88>
ffffffffc0202cfe:	03451793          	slli	a5,a0,0x34
ffffffffc0202d02:	04079be3          	bnez	a5,ffffffffc0203558 <pmm_init+0xa88>
ffffffffc0202d06:	4601                	li	a2,0
ffffffffc0202d08:	4581                	li	a1,0
ffffffffc0202d0a:	809ff0ef          	jal	ra,ffffffffc0202512 <get_page>
ffffffffc0202d0e:	2e0511e3          	bnez	a0,ffffffffc02037f0 <pmm_init+0xd20>
ffffffffc0202d12:	100027f3          	csrr	a5,sstatus
ffffffffc0202d16:	8b89                	andi	a5,a5,2
ffffffffc0202d18:	44079e63          	bnez	a5,ffffffffc0203174 <pmm_init+0x6a4>
ffffffffc0202d1c:	000b3783          	ld	a5,0(s6)
ffffffffc0202d20:	4505                	li	a0,1
ffffffffc0202d22:	6f9c                	ld	a5,24(a5)
ffffffffc0202d24:	9782                	jalr	a5
ffffffffc0202d26:	8a2a                	mv	s4,a0
ffffffffc0202d28:	00093503          	ld	a0,0(s2)
ffffffffc0202d2c:	4681                	li	a3,0
ffffffffc0202d2e:	4601                	li	a2,0
ffffffffc0202d30:	85d2                	mv	a1,s4
ffffffffc0202d32:	ca9ff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202d36:	26051be3          	bnez	a0,ffffffffc02037ac <pmm_init+0xcdc>
ffffffffc0202d3a:	00093503          	ld	a0,0(s2)
ffffffffc0202d3e:	4601                	li	a2,0
ffffffffc0202d40:	4581                	li	a1,0
ffffffffc0202d42:	ce2ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202d46:	280505e3          	beqz	a0,ffffffffc02037d0 <pmm_init+0xd00>
ffffffffc0202d4a:	611c                	ld	a5,0(a0)
ffffffffc0202d4c:	0017f713          	andi	a4,a5,1
ffffffffc0202d50:	26070ee3          	beqz	a4,ffffffffc02037cc <pmm_init+0xcfc>
ffffffffc0202d54:	6098                	ld	a4,0(s1)
ffffffffc0202d56:	078a                	slli	a5,a5,0x2
ffffffffc0202d58:	83b1                	srli	a5,a5,0xc
ffffffffc0202d5a:	62e7f363          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202d5e:	000bb683          	ld	a3,0(s7)
ffffffffc0202d62:	fff80637          	lui	a2,0xfff80
ffffffffc0202d66:	97b2                	add	a5,a5,a2
ffffffffc0202d68:	079a                	slli	a5,a5,0x6
ffffffffc0202d6a:	97b6                	add	a5,a5,a3
ffffffffc0202d6c:	2afa12e3          	bne	s4,a5,ffffffffc0203810 <pmm_init+0xd40>
ffffffffc0202d70:	000a2683          	lw	a3,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202d74:	4785                	li	a5,1
ffffffffc0202d76:	2cf699e3          	bne	a3,a5,ffffffffc0203848 <pmm_init+0xd78>
ffffffffc0202d7a:	00093503          	ld	a0,0(s2)
ffffffffc0202d7e:	77fd                	lui	a5,0xfffff
ffffffffc0202d80:	6114                	ld	a3,0(a0)
ffffffffc0202d82:	068a                	slli	a3,a3,0x2
ffffffffc0202d84:	8efd                	and	a3,a3,a5
ffffffffc0202d86:	00c6d613          	srli	a2,a3,0xc
ffffffffc0202d8a:	2ae673e3          	bgeu	a2,a4,ffffffffc0203830 <pmm_init+0xd60>
ffffffffc0202d8e:	0009bc03          	ld	s8,0(s3)
ffffffffc0202d92:	96e2                	add	a3,a3,s8
ffffffffc0202d94:	0006ba83          	ld	s5,0(a3) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc0202d98:	0a8a                	slli	s5,s5,0x2
ffffffffc0202d9a:	00fafab3          	and	s5,s5,a5
ffffffffc0202d9e:	00cad793          	srli	a5,s5,0xc
ffffffffc0202da2:	06e7f3e3          	bgeu	a5,a4,ffffffffc0203608 <pmm_init+0xb38>
ffffffffc0202da6:	4601                	li	a2,0
ffffffffc0202da8:	6585                	lui	a1,0x1
ffffffffc0202daa:	9ae2                	add	s5,s5,s8
ffffffffc0202dac:	c78ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202db0:	0aa1                	addi	s5,s5,8
ffffffffc0202db2:	03551be3          	bne	a0,s5,ffffffffc02035e8 <pmm_init+0xb18>
ffffffffc0202db6:	100027f3          	csrr	a5,sstatus
ffffffffc0202dba:	8b89                	andi	a5,a5,2
ffffffffc0202dbc:	3a079163          	bnez	a5,ffffffffc020315e <pmm_init+0x68e>
ffffffffc0202dc0:	000b3783          	ld	a5,0(s6)
ffffffffc0202dc4:	4505                	li	a0,1
ffffffffc0202dc6:	6f9c                	ld	a5,24(a5)
ffffffffc0202dc8:	9782                	jalr	a5
ffffffffc0202dca:	8c2a                	mv	s8,a0
ffffffffc0202dcc:	00093503          	ld	a0,0(s2)
ffffffffc0202dd0:	46d1                	li	a3,20
ffffffffc0202dd2:	6605                	lui	a2,0x1
ffffffffc0202dd4:	85e2                	mv	a1,s8
ffffffffc0202dd6:	c05ff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202dda:	1a0519e3          	bnez	a0,ffffffffc020378c <pmm_init+0xcbc>
ffffffffc0202dde:	00093503          	ld	a0,0(s2)
ffffffffc0202de2:	4601                	li	a2,0
ffffffffc0202de4:	6585                	lui	a1,0x1
ffffffffc0202de6:	c3eff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202dea:	10050ce3          	beqz	a0,ffffffffc0203702 <pmm_init+0xc32>
ffffffffc0202dee:	611c                	ld	a5,0(a0)
ffffffffc0202df0:	0107f713          	andi	a4,a5,16
ffffffffc0202df4:	0e0707e3          	beqz	a4,ffffffffc02036e2 <pmm_init+0xc12>
ffffffffc0202df8:	8b91                	andi	a5,a5,4
ffffffffc0202dfa:	0c0784e3          	beqz	a5,ffffffffc02036c2 <pmm_init+0xbf2>
ffffffffc0202dfe:	00093503          	ld	a0,0(s2)
ffffffffc0202e02:	611c                	ld	a5,0(a0)
ffffffffc0202e04:	8bc1                	andi	a5,a5,16
ffffffffc0202e06:	08078ee3          	beqz	a5,ffffffffc02036a2 <pmm_init+0xbd2>
ffffffffc0202e0a:	000c2703          	lw	a4,0(s8)
ffffffffc0202e0e:	4785                	li	a5,1
ffffffffc0202e10:	06f719e3          	bne	a4,a5,ffffffffc0203682 <pmm_init+0xbb2>
ffffffffc0202e14:	4681                	li	a3,0
ffffffffc0202e16:	6605                	lui	a2,0x1
ffffffffc0202e18:	85d2                	mv	a1,s4
ffffffffc0202e1a:	bc1ff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202e1e:	040512e3          	bnez	a0,ffffffffc0203662 <pmm_init+0xb92>
ffffffffc0202e22:	000a2703          	lw	a4,0(s4)
ffffffffc0202e26:	4789                	li	a5,2
ffffffffc0202e28:	00f71de3          	bne	a4,a5,ffffffffc0203642 <pmm_init+0xb72>
ffffffffc0202e2c:	000c2783          	lw	a5,0(s8)
ffffffffc0202e30:	7e079963          	bnez	a5,ffffffffc0203622 <pmm_init+0xb52>
ffffffffc0202e34:	00093503          	ld	a0,0(s2)
ffffffffc0202e38:	4601                	li	a2,0
ffffffffc0202e3a:	6585                	lui	a1,0x1
ffffffffc0202e3c:	be8ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202e40:	54050263          	beqz	a0,ffffffffc0203384 <pmm_init+0x8b4>
ffffffffc0202e44:	6118                	ld	a4,0(a0)
ffffffffc0202e46:	00177793          	andi	a5,a4,1
ffffffffc0202e4a:	180781e3          	beqz	a5,ffffffffc02037cc <pmm_init+0xcfc>
ffffffffc0202e4e:	6094                	ld	a3,0(s1)
ffffffffc0202e50:	00271793          	slli	a5,a4,0x2
ffffffffc0202e54:	83b1                	srli	a5,a5,0xc
ffffffffc0202e56:	52d7f563          	bgeu	a5,a3,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202e5a:	000bb683          	ld	a3,0(s7)
ffffffffc0202e5e:	fff80ab7          	lui	s5,0xfff80
ffffffffc0202e62:	97d6                	add	a5,a5,s5
ffffffffc0202e64:	079a                	slli	a5,a5,0x6
ffffffffc0202e66:	97b6                	add	a5,a5,a3
ffffffffc0202e68:	58fa1e63          	bne	s4,a5,ffffffffc0203404 <pmm_init+0x934>
ffffffffc0202e6c:	8b41                	andi	a4,a4,16
ffffffffc0202e6e:	56071b63          	bnez	a4,ffffffffc02033e4 <pmm_init+0x914>
ffffffffc0202e72:	00093503          	ld	a0,0(s2)
ffffffffc0202e76:	4581                	li	a1,0
ffffffffc0202e78:	ac7ff0ef          	jal	ra,ffffffffc020293e <page_remove>
ffffffffc0202e7c:	000a2c83          	lw	s9,0(s4)
ffffffffc0202e80:	4785                	li	a5,1
ffffffffc0202e82:	5cfc9163          	bne	s9,a5,ffffffffc0203444 <pmm_init+0x974>
ffffffffc0202e86:	000c2783          	lw	a5,0(s8)
ffffffffc0202e8a:	58079d63          	bnez	a5,ffffffffc0203424 <pmm_init+0x954>
ffffffffc0202e8e:	00093503          	ld	a0,0(s2)
ffffffffc0202e92:	6585                	lui	a1,0x1
ffffffffc0202e94:	aabff0ef          	jal	ra,ffffffffc020293e <page_remove>
ffffffffc0202e98:	000a2783          	lw	a5,0(s4)
ffffffffc0202e9c:	200793e3          	bnez	a5,ffffffffc02038a2 <pmm_init+0xdd2>
ffffffffc0202ea0:	000c2783          	lw	a5,0(s8)
ffffffffc0202ea4:	1c079fe3          	bnez	a5,ffffffffc0203882 <pmm_init+0xdb2>
ffffffffc0202ea8:	00093a03          	ld	s4,0(s2)
ffffffffc0202eac:	608c                	ld	a1,0(s1)
ffffffffc0202eae:	000a3683          	ld	a3,0(s4)
ffffffffc0202eb2:	068a                	slli	a3,a3,0x2
ffffffffc0202eb4:	82b1                	srli	a3,a3,0xc
ffffffffc0202eb6:	4cb6f563          	bgeu	a3,a1,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202eba:	000bb503          	ld	a0,0(s7)
ffffffffc0202ebe:	96d6                	add	a3,a3,s5
ffffffffc0202ec0:	069a                	slli	a3,a3,0x6
ffffffffc0202ec2:	00d507b3          	add	a5,a0,a3
ffffffffc0202ec6:	439c                	lw	a5,0(a5)
ffffffffc0202ec8:	4f979e63          	bne	a5,s9,ffffffffc02033c4 <pmm_init+0x8f4>
ffffffffc0202ecc:	8699                	srai	a3,a3,0x6
ffffffffc0202ece:	00080637          	lui	a2,0x80
ffffffffc0202ed2:	96b2                	add	a3,a3,a2
ffffffffc0202ed4:	00c69713          	slli	a4,a3,0xc
ffffffffc0202ed8:	8331                	srli	a4,a4,0xc
ffffffffc0202eda:	06b2                	slli	a3,a3,0xc
ffffffffc0202edc:	06b773e3          	bgeu	a4,a1,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0202ee0:	0009b703          	ld	a4,0(s3)
ffffffffc0202ee4:	96ba                	add	a3,a3,a4
ffffffffc0202ee6:	629c                	ld	a5,0(a3)
ffffffffc0202ee8:	078a                	slli	a5,a5,0x2
ffffffffc0202eea:	83b1                	srli	a5,a5,0xc
ffffffffc0202eec:	48b7fa63          	bgeu	a5,a1,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202ef0:	8f91                	sub	a5,a5,a2
ffffffffc0202ef2:	079a                	slli	a5,a5,0x6
ffffffffc0202ef4:	953e                	add	a0,a0,a5
ffffffffc0202ef6:	100027f3          	csrr	a5,sstatus
ffffffffc0202efa:	8b89                	andi	a5,a5,2
ffffffffc0202efc:	32079463          	bnez	a5,ffffffffc0203224 <pmm_init+0x754>
ffffffffc0202f00:	000b3783          	ld	a5,0(s6)
ffffffffc0202f04:	4585                	li	a1,1
ffffffffc0202f06:	739c                	ld	a5,32(a5)
ffffffffc0202f08:	9782                	jalr	a5
ffffffffc0202f0a:	000a3783          	ld	a5,0(s4)
ffffffffc0202f0e:	6098                	ld	a4,0(s1)
ffffffffc0202f10:	078a                	slli	a5,a5,0x2
ffffffffc0202f12:	83b1                	srli	a5,a5,0xc
ffffffffc0202f14:	46e7f663          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202f18:	000bb503          	ld	a0,0(s7)
ffffffffc0202f1c:	fff80737          	lui	a4,0xfff80
ffffffffc0202f20:	97ba                	add	a5,a5,a4
ffffffffc0202f22:	079a                	slli	a5,a5,0x6
ffffffffc0202f24:	953e                	add	a0,a0,a5
ffffffffc0202f26:	100027f3          	csrr	a5,sstatus
ffffffffc0202f2a:	8b89                	andi	a5,a5,2
ffffffffc0202f2c:	2e079063          	bnez	a5,ffffffffc020320c <pmm_init+0x73c>
ffffffffc0202f30:	000b3783          	ld	a5,0(s6)
ffffffffc0202f34:	4585                	li	a1,1
ffffffffc0202f36:	739c                	ld	a5,32(a5)
ffffffffc0202f38:	9782                	jalr	a5
ffffffffc0202f3a:	00093783          	ld	a5,0(s2)
ffffffffc0202f3e:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc0202f42:	12000073          	sfence.vma
ffffffffc0202f46:	100027f3          	csrr	a5,sstatus
ffffffffc0202f4a:	8b89                	andi	a5,a5,2
ffffffffc0202f4c:	2a079663          	bnez	a5,ffffffffc02031f8 <pmm_init+0x728>
ffffffffc0202f50:	000b3783          	ld	a5,0(s6)
ffffffffc0202f54:	779c                	ld	a5,40(a5)
ffffffffc0202f56:	9782                	jalr	a5
ffffffffc0202f58:	8a2a                	mv	s4,a0
ffffffffc0202f5a:	7d441463          	bne	s0,s4,ffffffffc0203722 <pmm_init+0xc52>
ffffffffc0202f5e:	00009517          	auipc	a0,0x9
ffffffffc0202f62:	7fa50513          	addi	a0,a0,2042 # ffffffffc020c758 <default_pmm_manager+0x5f8>
ffffffffc0202f66:	a40fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202f6a:	100027f3          	csrr	a5,sstatus
ffffffffc0202f6e:	8b89                	andi	a5,a5,2
ffffffffc0202f70:	26079a63          	bnez	a5,ffffffffc02031e4 <pmm_init+0x714>
ffffffffc0202f74:	000b3783          	ld	a5,0(s6)
ffffffffc0202f78:	779c                	ld	a5,40(a5)
ffffffffc0202f7a:	9782                	jalr	a5
ffffffffc0202f7c:	8c2a                	mv	s8,a0
ffffffffc0202f7e:	6098                	ld	a4,0(s1)
ffffffffc0202f80:	c0200437          	lui	s0,0xc0200
ffffffffc0202f84:	7afd                	lui	s5,0xfffff
ffffffffc0202f86:	00c71793          	slli	a5,a4,0xc
ffffffffc0202f8a:	6a05                	lui	s4,0x1
ffffffffc0202f8c:	02f47c63          	bgeu	s0,a5,ffffffffc0202fc4 <pmm_init+0x4f4>
ffffffffc0202f90:	00c45793          	srli	a5,s0,0xc
ffffffffc0202f94:	00093503          	ld	a0,0(s2)
ffffffffc0202f98:	3ae7f763          	bgeu	a5,a4,ffffffffc0203346 <pmm_init+0x876>
ffffffffc0202f9c:	0009b583          	ld	a1,0(s3)
ffffffffc0202fa0:	4601                	li	a2,0
ffffffffc0202fa2:	95a2                	add	a1,a1,s0
ffffffffc0202fa4:	a80ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202fa8:	36050f63          	beqz	a0,ffffffffc0203326 <pmm_init+0x856>
ffffffffc0202fac:	611c                	ld	a5,0(a0)
ffffffffc0202fae:	078a                	slli	a5,a5,0x2
ffffffffc0202fb0:	0157f7b3          	and	a5,a5,s5
ffffffffc0202fb4:	3a879663          	bne	a5,s0,ffffffffc0203360 <pmm_init+0x890>
ffffffffc0202fb8:	6098                	ld	a4,0(s1)
ffffffffc0202fba:	9452                	add	s0,s0,s4
ffffffffc0202fbc:	00c71793          	slli	a5,a4,0xc
ffffffffc0202fc0:	fcf468e3          	bltu	s0,a5,ffffffffc0202f90 <pmm_init+0x4c0>
ffffffffc0202fc4:	00093783          	ld	a5,0(s2)
ffffffffc0202fc8:	639c                	ld	a5,0(a5)
ffffffffc0202fca:	48079d63          	bnez	a5,ffffffffc0203464 <pmm_init+0x994>
ffffffffc0202fce:	100027f3          	csrr	a5,sstatus
ffffffffc0202fd2:	8b89                	andi	a5,a5,2
ffffffffc0202fd4:	26079463          	bnez	a5,ffffffffc020323c <pmm_init+0x76c>
ffffffffc0202fd8:	000b3783          	ld	a5,0(s6)
ffffffffc0202fdc:	4505                	li	a0,1
ffffffffc0202fde:	6f9c                	ld	a5,24(a5)
ffffffffc0202fe0:	9782                	jalr	a5
ffffffffc0202fe2:	8a2a                	mv	s4,a0
ffffffffc0202fe4:	00093503          	ld	a0,0(s2)
ffffffffc0202fe8:	4699                	li	a3,6
ffffffffc0202fea:	10000613          	li	a2,256
ffffffffc0202fee:	85d2                	mv	a1,s4
ffffffffc0202ff0:	9ebff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202ff4:	4a051863          	bnez	a0,ffffffffc02034a4 <pmm_init+0x9d4>
ffffffffc0202ff8:	000a2703          	lw	a4,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202ffc:	4785                	li	a5,1
ffffffffc0202ffe:	48f71363          	bne	a4,a5,ffffffffc0203484 <pmm_init+0x9b4>
ffffffffc0203002:	00093503          	ld	a0,0(s2)
ffffffffc0203006:	6405                	lui	s0,0x1
ffffffffc0203008:	4699                	li	a3,6
ffffffffc020300a:	10040613          	addi	a2,s0,256 # 1100 <_binary_bin_swap_img_size-0x6c00>
ffffffffc020300e:	85d2                	mv	a1,s4
ffffffffc0203010:	9cbff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0203014:	38051863          	bnez	a0,ffffffffc02033a4 <pmm_init+0x8d4>
ffffffffc0203018:	000a2703          	lw	a4,0(s4)
ffffffffc020301c:	4789                	li	a5,2
ffffffffc020301e:	4ef71363          	bne	a4,a5,ffffffffc0203504 <pmm_init+0xa34>
ffffffffc0203022:	0000a597          	auipc	a1,0xa
ffffffffc0203026:	87e58593          	addi	a1,a1,-1922 # ffffffffc020c8a0 <default_pmm_manager+0x740>
ffffffffc020302a:	10000513          	li	a0,256
ffffffffc020302e:	0fa080ef          	jal	ra,ffffffffc020b128 <strcpy>
ffffffffc0203032:	10040593          	addi	a1,s0,256
ffffffffc0203036:	10000513          	li	a0,256
ffffffffc020303a:	100080ef          	jal	ra,ffffffffc020b13a <strcmp>
ffffffffc020303e:	4a051363          	bnez	a0,ffffffffc02034e4 <pmm_init+0xa14>
ffffffffc0203042:	000bb683          	ld	a3,0(s7)
ffffffffc0203046:	00080737          	lui	a4,0x80
ffffffffc020304a:	547d                	li	s0,-1
ffffffffc020304c:	40da06b3          	sub	a3,s4,a3
ffffffffc0203050:	8699                	srai	a3,a3,0x6
ffffffffc0203052:	609c                	ld	a5,0(s1)
ffffffffc0203054:	96ba                	add	a3,a3,a4
ffffffffc0203056:	8031                	srli	s0,s0,0xc
ffffffffc0203058:	0086f733          	and	a4,a3,s0
ffffffffc020305c:	06b2                	slli	a3,a3,0xc
ffffffffc020305e:	6ef77263          	bgeu	a4,a5,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0203062:	0009b783          	ld	a5,0(s3)
ffffffffc0203066:	10000513          	li	a0,256
ffffffffc020306a:	96be                	add	a3,a3,a5
ffffffffc020306c:	10068023          	sb	zero,256(a3)
ffffffffc0203070:	082080ef          	jal	ra,ffffffffc020b0f2 <strlen>
ffffffffc0203074:	44051863          	bnez	a0,ffffffffc02034c4 <pmm_init+0x9f4>
ffffffffc0203078:	00093a83          	ld	s5,0(s2)
ffffffffc020307c:	609c                	ld	a5,0(s1)
ffffffffc020307e:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc0203082:	068a                	slli	a3,a3,0x2
ffffffffc0203084:	82b1                	srli	a3,a3,0xc
ffffffffc0203086:	2ef6fd63          	bgeu	a3,a5,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc020308a:	8c75                	and	s0,s0,a3
ffffffffc020308c:	06b2                	slli	a3,a3,0xc
ffffffffc020308e:	6af47a63          	bgeu	s0,a5,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0203092:	0009b403          	ld	s0,0(s3)
ffffffffc0203096:	9436                	add	s0,s0,a3
ffffffffc0203098:	100027f3          	csrr	a5,sstatus
ffffffffc020309c:	8b89                	andi	a5,a5,2
ffffffffc020309e:	1e079c63          	bnez	a5,ffffffffc0203296 <pmm_init+0x7c6>
ffffffffc02030a2:	000b3783          	ld	a5,0(s6)
ffffffffc02030a6:	4585                	li	a1,1
ffffffffc02030a8:	8552                	mv	a0,s4
ffffffffc02030aa:	739c                	ld	a5,32(a5)
ffffffffc02030ac:	9782                	jalr	a5
ffffffffc02030ae:	601c                	ld	a5,0(s0)
ffffffffc02030b0:	6098                	ld	a4,0(s1)
ffffffffc02030b2:	078a                	slli	a5,a5,0x2
ffffffffc02030b4:	83b1                	srli	a5,a5,0xc
ffffffffc02030b6:	2ce7f563          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc02030ba:	000bb503          	ld	a0,0(s7)
ffffffffc02030be:	fff80737          	lui	a4,0xfff80
ffffffffc02030c2:	97ba                	add	a5,a5,a4
ffffffffc02030c4:	079a                	slli	a5,a5,0x6
ffffffffc02030c6:	953e                	add	a0,a0,a5
ffffffffc02030c8:	100027f3          	csrr	a5,sstatus
ffffffffc02030cc:	8b89                	andi	a5,a5,2
ffffffffc02030ce:	1a079863          	bnez	a5,ffffffffc020327e <pmm_init+0x7ae>
ffffffffc02030d2:	000b3783          	ld	a5,0(s6)
ffffffffc02030d6:	4585                	li	a1,1
ffffffffc02030d8:	739c                	ld	a5,32(a5)
ffffffffc02030da:	9782                	jalr	a5
ffffffffc02030dc:	000ab783          	ld	a5,0(s5)
ffffffffc02030e0:	6098                	ld	a4,0(s1)
ffffffffc02030e2:	078a                	slli	a5,a5,0x2
ffffffffc02030e4:	83b1                	srli	a5,a5,0xc
ffffffffc02030e6:	28e7fd63          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc02030ea:	000bb503          	ld	a0,0(s7)
ffffffffc02030ee:	fff80737          	lui	a4,0xfff80
ffffffffc02030f2:	97ba                	add	a5,a5,a4
ffffffffc02030f4:	079a                	slli	a5,a5,0x6
ffffffffc02030f6:	953e                	add	a0,a0,a5
ffffffffc02030f8:	100027f3          	csrr	a5,sstatus
ffffffffc02030fc:	8b89                	andi	a5,a5,2
ffffffffc02030fe:	16079463          	bnez	a5,ffffffffc0203266 <pmm_init+0x796>
ffffffffc0203102:	000b3783          	ld	a5,0(s6)
ffffffffc0203106:	4585                	li	a1,1
ffffffffc0203108:	739c                	ld	a5,32(a5)
ffffffffc020310a:	9782                	jalr	a5
ffffffffc020310c:	00093783          	ld	a5,0(s2)
ffffffffc0203110:	0007b023          	sd	zero,0(a5)
ffffffffc0203114:	12000073          	sfence.vma
ffffffffc0203118:	100027f3          	csrr	a5,sstatus
ffffffffc020311c:	8b89                	andi	a5,a5,2
ffffffffc020311e:	12079a63          	bnez	a5,ffffffffc0203252 <pmm_init+0x782>
ffffffffc0203122:	000b3783          	ld	a5,0(s6)
ffffffffc0203126:	779c                	ld	a5,40(a5)
ffffffffc0203128:	9782                	jalr	a5
ffffffffc020312a:	842a                	mv	s0,a0
ffffffffc020312c:	488c1e63          	bne	s8,s0,ffffffffc02035c8 <pmm_init+0xaf8>
ffffffffc0203130:	00009517          	auipc	a0,0x9
ffffffffc0203134:	7e850513          	addi	a0,a0,2024 # ffffffffc020c918 <default_pmm_manager+0x7b8>
ffffffffc0203138:	86efd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020313c:	7406                	ld	s0,96(sp)
ffffffffc020313e:	70a6                	ld	ra,104(sp)
ffffffffc0203140:	64e6                	ld	s1,88(sp)
ffffffffc0203142:	6946                	ld	s2,80(sp)
ffffffffc0203144:	69a6                	ld	s3,72(sp)
ffffffffc0203146:	6a06                	ld	s4,64(sp)
ffffffffc0203148:	7ae2                	ld	s5,56(sp)
ffffffffc020314a:	7b42                	ld	s6,48(sp)
ffffffffc020314c:	7ba2                	ld	s7,40(sp)
ffffffffc020314e:	7c02                	ld	s8,32(sp)
ffffffffc0203150:	6ce2                	ld	s9,24(sp)
ffffffffc0203152:	6165                	addi	sp,sp,112
ffffffffc0203154:	e17fe06f          	j	ffffffffc0201f6a <kmalloc_init>
ffffffffc0203158:	c80007b7          	lui	a5,0xc8000
ffffffffc020315c:	b411                	j	ffffffffc0202b60 <pmm_init+0x90>
ffffffffc020315e:	b15fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203162:	000b3783          	ld	a5,0(s6)
ffffffffc0203166:	4505                	li	a0,1
ffffffffc0203168:	6f9c                	ld	a5,24(a5)
ffffffffc020316a:	9782                	jalr	a5
ffffffffc020316c:	8c2a                	mv	s8,a0
ffffffffc020316e:	afffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203172:	b9a9                	j	ffffffffc0202dcc <pmm_init+0x2fc>
ffffffffc0203174:	afffd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203178:	000b3783          	ld	a5,0(s6)
ffffffffc020317c:	4505                	li	a0,1
ffffffffc020317e:	6f9c                	ld	a5,24(a5)
ffffffffc0203180:	9782                	jalr	a5
ffffffffc0203182:	8a2a                	mv	s4,a0
ffffffffc0203184:	ae9fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203188:	b645                	j	ffffffffc0202d28 <pmm_init+0x258>
ffffffffc020318a:	ae9fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020318e:	000b3783          	ld	a5,0(s6)
ffffffffc0203192:	779c                	ld	a5,40(a5)
ffffffffc0203194:	9782                	jalr	a5
ffffffffc0203196:	842a                	mv	s0,a0
ffffffffc0203198:	ad5fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020319c:	b6b9                	j	ffffffffc0202cea <pmm_init+0x21a>
ffffffffc020319e:	ad5fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031a2:	000b3783          	ld	a5,0(s6)
ffffffffc02031a6:	4505                	li	a0,1
ffffffffc02031a8:	6f9c                	ld	a5,24(a5)
ffffffffc02031aa:	9782                	jalr	a5
ffffffffc02031ac:	842a                	mv	s0,a0
ffffffffc02031ae:	abffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02031b2:	bc99                	j	ffffffffc0202c08 <pmm_init+0x138>
ffffffffc02031b4:	6705                	lui	a4,0x1
ffffffffc02031b6:	177d                	addi	a4,a4,-1
ffffffffc02031b8:	96ba                	add	a3,a3,a4
ffffffffc02031ba:	8ff5                	and	a5,a5,a3
ffffffffc02031bc:	00c7d713          	srli	a4,a5,0xc
ffffffffc02031c0:	1ca77063          	bgeu	a4,a0,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc02031c4:	000b3683          	ld	a3,0(s6)
ffffffffc02031c8:	fff80537          	lui	a0,0xfff80
ffffffffc02031cc:	972a                	add	a4,a4,a0
ffffffffc02031ce:	6a94                	ld	a3,16(a3)
ffffffffc02031d0:	8c1d                	sub	s0,s0,a5
ffffffffc02031d2:	00671513          	slli	a0,a4,0x6
ffffffffc02031d6:	00c45593          	srli	a1,s0,0xc
ffffffffc02031da:	9532                	add	a0,a0,a2
ffffffffc02031dc:	9682                	jalr	a3
ffffffffc02031de:	0009b583          	ld	a1,0(s3)
ffffffffc02031e2:	bac5                	j	ffffffffc0202bd2 <pmm_init+0x102>
ffffffffc02031e4:	a8ffd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031e8:	000b3783          	ld	a5,0(s6)
ffffffffc02031ec:	779c                	ld	a5,40(a5)
ffffffffc02031ee:	9782                	jalr	a5
ffffffffc02031f0:	8c2a                	mv	s8,a0
ffffffffc02031f2:	a7bfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02031f6:	b361                	j	ffffffffc0202f7e <pmm_init+0x4ae>
ffffffffc02031f8:	a7bfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031fc:	000b3783          	ld	a5,0(s6)
ffffffffc0203200:	779c                	ld	a5,40(a5)
ffffffffc0203202:	9782                	jalr	a5
ffffffffc0203204:	8a2a                	mv	s4,a0
ffffffffc0203206:	a67fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020320a:	bb81                	j	ffffffffc0202f5a <pmm_init+0x48a>
ffffffffc020320c:	e42a                	sd	a0,8(sp)
ffffffffc020320e:	a65fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203212:	000b3783          	ld	a5,0(s6)
ffffffffc0203216:	6522                	ld	a0,8(sp)
ffffffffc0203218:	4585                	li	a1,1
ffffffffc020321a:	739c                	ld	a5,32(a5)
ffffffffc020321c:	9782                	jalr	a5
ffffffffc020321e:	a4ffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203222:	bb21                	j	ffffffffc0202f3a <pmm_init+0x46a>
ffffffffc0203224:	e42a                	sd	a0,8(sp)
ffffffffc0203226:	a4dfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020322a:	000b3783          	ld	a5,0(s6)
ffffffffc020322e:	6522                	ld	a0,8(sp)
ffffffffc0203230:	4585                	li	a1,1
ffffffffc0203232:	739c                	ld	a5,32(a5)
ffffffffc0203234:	9782                	jalr	a5
ffffffffc0203236:	a37fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020323a:	b9c1                	j	ffffffffc0202f0a <pmm_init+0x43a>
ffffffffc020323c:	a37fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203240:	000b3783          	ld	a5,0(s6)
ffffffffc0203244:	4505                	li	a0,1
ffffffffc0203246:	6f9c                	ld	a5,24(a5)
ffffffffc0203248:	9782                	jalr	a5
ffffffffc020324a:	8a2a                	mv	s4,a0
ffffffffc020324c:	a21fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203250:	bb51                	j	ffffffffc0202fe4 <pmm_init+0x514>
ffffffffc0203252:	a21fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203256:	000b3783          	ld	a5,0(s6)
ffffffffc020325a:	779c                	ld	a5,40(a5)
ffffffffc020325c:	9782                	jalr	a5
ffffffffc020325e:	842a                	mv	s0,a0
ffffffffc0203260:	a0dfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203264:	b5e1                	j	ffffffffc020312c <pmm_init+0x65c>
ffffffffc0203266:	e42a                	sd	a0,8(sp)
ffffffffc0203268:	a0bfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020326c:	000b3783          	ld	a5,0(s6)
ffffffffc0203270:	6522                	ld	a0,8(sp)
ffffffffc0203272:	4585                	li	a1,1
ffffffffc0203274:	739c                	ld	a5,32(a5)
ffffffffc0203276:	9782                	jalr	a5
ffffffffc0203278:	9f5fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020327c:	bd41                	j	ffffffffc020310c <pmm_init+0x63c>
ffffffffc020327e:	e42a                	sd	a0,8(sp)
ffffffffc0203280:	9f3fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203284:	000b3783          	ld	a5,0(s6)
ffffffffc0203288:	6522                	ld	a0,8(sp)
ffffffffc020328a:	4585                	li	a1,1
ffffffffc020328c:	739c                	ld	a5,32(a5)
ffffffffc020328e:	9782                	jalr	a5
ffffffffc0203290:	9ddfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203294:	b5a1                	j	ffffffffc02030dc <pmm_init+0x60c>
ffffffffc0203296:	9ddfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020329a:	000b3783          	ld	a5,0(s6)
ffffffffc020329e:	4585                	li	a1,1
ffffffffc02032a0:	8552                	mv	a0,s4
ffffffffc02032a2:	739c                	ld	a5,32(a5)
ffffffffc02032a4:	9782                	jalr	a5
ffffffffc02032a6:	9c7fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02032aa:	b511                	j	ffffffffc02030ae <pmm_init+0x5de>
ffffffffc02032ac:	00010417          	auipc	s0,0x10
ffffffffc02032b0:	d5440413          	addi	s0,s0,-684 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc02032b4:	00010797          	auipc	a5,0x10
ffffffffc02032b8:	d4c78793          	addi	a5,a5,-692 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc02032bc:	a0f41de3          	bne	s0,a5,ffffffffc0202cd6 <pmm_init+0x206>
ffffffffc02032c0:	4581                	li	a1,0
ffffffffc02032c2:	6605                	lui	a2,0x1
ffffffffc02032c4:	8522                	mv	a0,s0
ffffffffc02032c6:	6cf070ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc02032ca:	0000d597          	auipc	a1,0xd
ffffffffc02032ce:	d3658593          	addi	a1,a1,-714 # ffffffffc0210000 <bootstackguard>
ffffffffc02032d2:	0000e797          	auipc	a5,0xe
ffffffffc02032d6:	d20786a3          	sb	zero,-723(a5) # ffffffffc0210fff <bootstackguard+0xfff>
ffffffffc02032da:	0000d797          	auipc	a5,0xd
ffffffffc02032de:	d2078323          	sb	zero,-730(a5) # ffffffffc0210000 <bootstackguard>
ffffffffc02032e2:	00093503          	ld	a0,0(s2)
ffffffffc02032e6:	2555ec63          	bltu	a1,s5,ffffffffc020353e <pmm_init+0xa6e>
ffffffffc02032ea:	0009b683          	ld	a3,0(s3)
ffffffffc02032ee:	4701                	li	a4,0
ffffffffc02032f0:	6605                	lui	a2,0x1
ffffffffc02032f2:	40d586b3          	sub	a3,a1,a3
ffffffffc02032f6:	956ff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc02032fa:	00093503          	ld	a0,0(s2)
ffffffffc02032fe:	23546363          	bltu	s0,s5,ffffffffc0203524 <pmm_init+0xa54>
ffffffffc0203302:	0009b683          	ld	a3,0(s3)
ffffffffc0203306:	4701                	li	a4,0
ffffffffc0203308:	6605                	lui	a2,0x1
ffffffffc020330a:	40d406b3          	sub	a3,s0,a3
ffffffffc020330e:	85a2                	mv	a1,s0
ffffffffc0203310:	93cff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0203314:	12000073          	sfence.vma
ffffffffc0203318:	00009517          	auipc	a0,0x9
ffffffffc020331c:	11050513          	addi	a0,a0,272 # ffffffffc020c428 <default_pmm_manager+0x2c8>
ffffffffc0203320:	e87fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0203324:	ba4d                	j	ffffffffc0202cd6 <pmm_init+0x206>
ffffffffc0203326:	00009697          	auipc	a3,0x9
ffffffffc020332a:	45268693          	addi	a3,a3,1106 # ffffffffc020c778 <default_pmm_manager+0x618>
ffffffffc020332e:	00008617          	auipc	a2,0x8
ffffffffc0203332:	34a60613          	addi	a2,a2,842 # ffffffffc020b678 <commands+0x210>
ffffffffc0203336:	29000593          	li	a1,656
ffffffffc020333a:	00009517          	auipc	a0,0x9
ffffffffc020333e:	f7650513          	addi	a0,a0,-138 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203342:	95cfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203346:	86a2                	mv	a3,s0
ffffffffc0203348:	00009617          	auipc	a2,0x9
ffffffffc020334c:	e5060613          	addi	a2,a2,-432 # ffffffffc020c198 <default_pmm_manager+0x38>
ffffffffc0203350:	29000593          	li	a1,656
ffffffffc0203354:	00009517          	auipc	a0,0x9
ffffffffc0203358:	f5c50513          	addi	a0,a0,-164 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc020335c:	942fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203360:	00009697          	auipc	a3,0x9
ffffffffc0203364:	45868693          	addi	a3,a3,1112 # ffffffffc020c7b8 <default_pmm_manager+0x658>
ffffffffc0203368:	00008617          	auipc	a2,0x8
ffffffffc020336c:	31060613          	addi	a2,a2,784 # ffffffffc020b678 <commands+0x210>
ffffffffc0203370:	29100593          	li	a1,657
ffffffffc0203374:	00009517          	auipc	a0,0x9
ffffffffc0203378:	f3c50513          	addi	a0,a0,-196 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc020337c:	922fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203380:	db5fe0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>
ffffffffc0203384:	00009697          	auipc	a3,0x9
ffffffffc0203388:	25c68693          	addi	a3,a3,604 # ffffffffc020c5e0 <default_pmm_manager+0x480>
ffffffffc020338c:	00008617          	auipc	a2,0x8
ffffffffc0203390:	2ec60613          	addi	a2,a2,748 # ffffffffc020b678 <commands+0x210>
ffffffffc0203394:	26d00593          	li	a1,621
ffffffffc0203398:	00009517          	auipc	a0,0x9
ffffffffc020339c:	f1850513          	addi	a0,a0,-232 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02033a0:	8fefd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033a4:	00009697          	auipc	a3,0x9
ffffffffc02033a8:	49c68693          	addi	a3,a3,1180 # ffffffffc020c840 <default_pmm_manager+0x6e0>
ffffffffc02033ac:	00008617          	auipc	a2,0x8
ffffffffc02033b0:	2cc60613          	addi	a2,a2,716 # ffffffffc020b678 <commands+0x210>
ffffffffc02033b4:	29a00593          	li	a1,666
ffffffffc02033b8:	00009517          	auipc	a0,0x9
ffffffffc02033bc:	ef850513          	addi	a0,a0,-264 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02033c0:	8defd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033c4:	00009697          	auipc	a3,0x9
ffffffffc02033c8:	33c68693          	addi	a3,a3,828 # ffffffffc020c700 <default_pmm_manager+0x5a0>
ffffffffc02033cc:	00008617          	auipc	a2,0x8
ffffffffc02033d0:	2ac60613          	addi	a2,a2,684 # ffffffffc020b678 <commands+0x210>
ffffffffc02033d4:	27900593          	li	a1,633
ffffffffc02033d8:	00009517          	auipc	a0,0x9
ffffffffc02033dc:	ed850513          	addi	a0,a0,-296 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02033e0:	8befd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033e4:	00009697          	auipc	a3,0x9
ffffffffc02033e8:	2ec68693          	addi	a3,a3,748 # ffffffffc020c6d0 <default_pmm_manager+0x570>
ffffffffc02033ec:	00008617          	auipc	a2,0x8
ffffffffc02033f0:	28c60613          	addi	a2,a2,652 # ffffffffc020b678 <commands+0x210>
ffffffffc02033f4:	26f00593          	li	a1,623
ffffffffc02033f8:	00009517          	auipc	a0,0x9
ffffffffc02033fc:	eb850513          	addi	a0,a0,-328 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203400:	89efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203404:	00009697          	auipc	a3,0x9
ffffffffc0203408:	13c68693          	addi	a3,a3,316 # ffffffffc020c540 <default_pmm_manager+0x3e0>
ffffffffc020340c:	00008617          	auipc	a2,0x8
ffffffffc0203410:	26c60613          	addi	a2,a2,620 # ffffffffc020b678 <commands+0x210>
ffffffffc0203414:	26e00593          	li	a1,622
ffffffffc0203418:	00009517          	auipc	a0,0x9
ffffffffc020341c:	e9850513          	addi	a0,a0,-360 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203420:	87efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203424:	00009697          	auipc	a3,0x9
ffffffffc0203428:	29468693          	addi	a3,a3,660 # ffffffffc020c6b8 <default_pmm_manager+0x558>
ffffffffc020342c:	00008617          	auipc	a2,0x8
ffffffffc0203430:	24c60613          	addi	a2,a2,588 # ffffffffc020b678 <commands+0x210>
ffffffffc0203434:	27300593          	li	a1,627
ffffffffc0203438:	00009517          	auipc	a0,0x9
ffffffffc020343c:	e7850513          	addi	a0,a0,-392 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203440:	85efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203444:	00009697          	auipc	a3,0x9
ffffffffc0203448:	11468693          	addi	a3,a3,276 # ffffffffc020c558 <default_pmm_manager+0x3f8>
ffffffffc020344c:	00008617          	auipc	a2,0x8
ffffffffc0203450:	22c60613          	addi	a2,a2,556 # ffffffffc020b678 <commands+0x210>
ffffffffc0203454:	27200593          	li	a1,626
ffffffffc0203458:	00009517          	auipc	a0,0x9
ffffffffc020345c:	e5850513          	addi	a0,a0,-424 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203460:	83efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203464:	00009697          	auipc	a3,0x9
ffffffffc0203468:	36c68693          	addi	a3,a3,876 # ffffffffc020c7d0 <default_pmm_manager+0x670>
ffffffffc020346c:	00008617          	auipc	a2,0x8
ffffffffc0203470:	20c60613          	addi	a2,a2,524 # ffffffffc020b678 <commands+0x210>
ffffffffc0203474:	29400593          	li	a1,660
ffffffffc0203478:	00009517          	auipc	a0,0x9
ffffffffc020347c:	e3850513          	addi	a0,a0,-456 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203480:	81efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203484:	00009697          	auipc	a3,0x9
ffffffffc0203488:	3a468693          	addi	a3,a3,932 # ffffffffc020c828 <default_pmm_manager+0x6c8>
ffffffffc020348c:	00008617          	auipc	a2,0x8
ffffffffc0203490:	1ec60613          	addi	a2,a2,492 # ffffffffc020b678 <commands+0x210>
ffffffffc0203494:	29900593          	li	a1,665
ffffffffc0203498:	00009517          	auipc	a0,0x9
ffffffffc020349c:	e1850513          	addi	a0,a0,-488 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02034a0:	ffffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034a4:	00009697          	auipc	a3,0x9
ffffffffc02034a8:	34468693          	addi	a3,a3,836 # ffffffffc020c7e8 <default_pmm_manager+0x688>
ffffffffc02034ac:	00008617          	auipc	a2,0x8
ffffffffc02034b0:	1cc60613          	addi	a2,a2,460 # ffffffffc020b678 <commands+0x210>
ffffffffc02034b4:	29800593          	li	a1,664
ffffffffc02034b8:	00009517          	auipc	a0,0x9
ffffffffc02034bc:	df850513          	addi	a0,a0,-520 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02034c0:	fdffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034c4:	00009697          	auipc	a3,0x9
ffffffffc02034c8:	42c68693          	addi	a3,a3,1068 # ffffffffc020c8f0 <default_pmm_manager+0x790>
ffffffffc02034cc:	00008617          	auipc	a2,0x8
ffffffffc02034d0:	1ac60613          	addi	a2,a2,428 # ffffffffc020b678 <commands+0x210>
ffffffffc02034d4:	2a200593          	li	a1,674
ffffffffc02034d8:	00009517          	auipc	a0,0x9
ffffffffc02034dc:	dd850513          	addi	a0,a0,-552 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02034e0:	fbffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034e4:	00009697          	auipc	a3,0x9
ffffffffc02034e8:	3d468693          	addi	a3,a3,980 # ffffffffc020c8b8 <default_pmm_manager+0x758>
ffffffffc02034ec:	00008617          	auipc	a2,0x8
ffffffffc02034f0:	18c60613          	addi	a2,a2,396 # ffffffffc020b678 <commands+0x210>
ffffffffc02034f4:	29f00593          	li	a1,671
ffffffffc02034f8:	00009517          	auipc	a0,0x9
ffffffffc02034fc:	db850513          	addi	a0,a0,-584 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203500:	f9ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203504:	00009697          	auipc	a3,0x9
ffffffffc0203508:	38468693          	addi	a3,a3,900 # ffffffffc020c888 <default_pmm_manager+0x728>
ffffffffc020350c:	00008617          	auipc	a2,0x8
ffffffffc0203510:	16c60613          	addi	a2,a2,364 # ffffffffc020b678 <commands+0x210>
ffffffffc0203514:	29b00593          	li	a1,667
ffffffffc0203518:	00009517          	auipc	a0,0x9
ffffffffc020351c:	d9850513          	addi	a0,a0,-616 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203520:	f7ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203524:	86a2                	mv	a3,s0
ffffffffc0203526:	00009617          	auipc	a2,0x9
ffffffffc020352a:	d1a60613          	addi	a2,a2,-742 # ffffffffc020c240 <default_pmm_manager+0xe0>
ffffffffc020352e:	0dc00593          	li	a1,220
ffffffffc0203532:	00009517          	auipc	a0,0x9
ffffffffc0203536:	d7e50513          	addi	a0,a0,-642 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc020353a:	f65fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020353e:	86ae                	mv	a3,a1
ffffffffc0203540:	00009617          	auipc	a2,0x9
ffffffffc0203544:	d0060613          	addi	a2,a2,-768 # ffffffffc020c240 <default_pmm_manager+0xe0>
ffffffffc0203548:	0db00593          	li	a1,219
ffffffffc020354c:	00009517          	auipc	a0,0x9
ffffffffc0203550:	d6450513          	addi	a0,a0,-668 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203554:	f4bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203558:	00009697          	auipc	a3,0x9
ffffffffc020355c:	f1868693          	addi	a3,a3,-232 # ffffffffc020c470 <default_pmm_manager+0x310>
ffffffffc0203560:	00008617          	auipc	a2,0x8
ffffffffc0203564:	11860613          	addi	a2,a2,280 # ffffffffc020b678 <commands+0x210>
ffffffffc0203568:	25200593          	li	a1,594
ffffffffc020356c:	00009517          	auipc	a0,0x9
ffffffffc0203570:	d4450513          	addi	a0,a0,-700 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203574:	f2bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203578:	00009697          	auipc	a3,0x9
ffffffffc020357c:	ed868693          	addi	a3,a3,-296 # ffffffffc020c450 <default_pmm_manager+0x2f0>
ffffffffc0203580:	00008617          	auipc	a2,0x8
ffffffffc0203584:	0f860613          	addi	a2,a2,248 # ffffffffc020b678 <commands+0x210>
ffffffffc0203588:	25100593          	li	a1,593
ffffffffc020358c:	00009517          	auipc	a0,0x9
ffffffffc0203590:	d2450513          	addi	a0,a0,-732 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203594:	f0bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203598:	00009617          	auipc	a2,0x9
ffffffffc020359c:	e4860613          	addi	a2,a2,-440 # ffffffffc020c3e0 <default_pmm_manager+0x280>
ffffffffc02035a0:	0aa00593          	li	a1,170
ffffffffc02035a4:	00009517          	auipc	a0,0x9
ffffffffc02035a8:	d0c50513          	addi	a0,a0,-756 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02035ac:	ef3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035b0:	00009617          	auipc	a2,0x9
ffffffffc02035b4:	d9860613          	addi	a2,a2,-616 # ffffffffc020c348 <default_pmm_manager+0x1e8>
ffffffffc02035b8:	06500593          	li	a1,101
ffffffffc02035bc:	00009517          	auipc	a0,0x9
ffffffffc02035c0:	cf450513          	addi	a0,a0,-780 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02035c4:	edbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035c8:	00009697          	auipc	a3,0x9
ffffffffc02035cc:	16868693          	addi	a3,a3,360 # ffffffffc020c730 <default_pmm_manager+0x5d0>
ffffffffc02035d0:	00008617          	auipc	a2,0x8
ffffffffc02035d4:	0a860613          	addi	a2,a2,168 # ffffffffc020b678 <commands+0x210>
ffffffffc02035d8:	2ab00593          	li	a1,683
ffffffffc02035dc:	00009517          	auipc	a0,0x9
ffffffffc02035e0:	cd450513          	addi	a0,a0,-812 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02035e4:	ebbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035e8:	00009697          	auipc	a3,0x9
ffffffffc02035ec:	f8868693          	addi	a3,a3,-120 # ffffffffc020c570 <default_pmm_manager+0x410>
ffffffffc02035f0:	00008617          	auipc	a2,0x8
ffffffffc02035f4:	08860613          	addi	a2,a2,136 # ffffffffc020b678 <commands+0x210>
ffffffffc02035f8:	26000593          	li	a1,608
ffffffffc02035fc:	00009517          	auipc	a0,0x9
ffffffffc0203600:	cb450513          	addi	a0,a0,-844 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203604:	e9bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203608:	86d6                	mv	a3,s5
ffffffffc020360a:	00009617          	auipc	a2,0x9
ffffffffc020360e:	b8e60613          	addi	a2,a2,-1138 # ffffffffc020c198 <default_pmm_manager+0x38>
ffffffffc0203612:	25f00593          	li	a1,607
ffffffffc0203616:	00009517          	auipc	a0,0x9
ffffffffc020361a:	c9a50513          	addi	a0,a0,-870 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc020361e:	e81fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203622:	00009697          	auipc	a3,0x9
ffffffffc0203626:	09668693          	addi	a3,a3,150 # ffffffffc020c6b8 <default_pmm_manager+0x558>
ffffffffc020362a:	00008617          	auipc	a2,0x8
ffffffffc020362e:	04e60613          	addi	a2,a2,78 # ffffffffc020b678 <commands+0x210>
ffffffffc0203632:	26c00593          	li	a1,620
ffffffffc0203636:	00009517          	auipc	a0,0x9
ffffffffc020363a:	c7a50513          	addi	a0,a0,-902 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc020363e:	e61fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203642:	00009697          	auipc	a3,0x9
ffffffffc0203646:	05e68693          	addi	a3,a3,94 # ffffffffc020c6a0 <default_pmm_manager+0x540>
ffffffffc020364a:	00008617          	auipc	a2,0x8
ffffffffc020364e:	02e60613          	addi	a2,a2,46 # ffffffffc020b678 <commands+0x210>
ffffffffc0203652:	26b00593          	li	a1,619
ffffffffc0203656:	00009517          	auipc	a0,0x9
ffffffffc020365a:	c5a50513          	addi	a0,a0,-934 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc020365e:	e41fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203662:	00009697          	auipc	a3,0x9
ffffffffc0203666:	00e68693          	addi	a3,a3,14 # ffffffffc020c670 <default_pmm_manager+0x510>
ffffffffc020366a:	00008617          	auipc	a2,0x8
ffffffffc020366e:	00e60613          	addi	a2,a2,14 # ffffffffc020b678 <commands+0x210>
ffffffffc0203672:	26a00593          	li	a1,618
ffffffffc0203676:	00009517          	auipc	a0,0x9
ffffffffc020367a:	c3a50513          	addi	a0,a0,-966 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc020367e:	e21fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203682:	00009697          	auipc	a3,0x9
ffffffffc0203686:	fd668693          	addi	a3,a3,-42 # ffffffffc020c658 <default_pmm_manager+0x4f8>
ffffffffc020368a:	00008617          	auipc	a2,0x8
ffffffffc020368e:	fee60613          	addi	a2,a2,-18 # ffffffffc020b678 <commands+0x210>
ffffffffc0203692:	26800593          	li	a1,616
ffffffffc0203696:	00009517          	auipc	a0,0x9
ffffffffc020369a:	c1a50513          	addi	a0,a0,-998 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc020369e:	e01fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036a2:	00009697          	auipc	a3,0x9
ffffffffc02036a6:	f9668693          	addi	a3,a3,-106 # ffffffffc020c638 <default_pmm_manager+0x4d8>
ffffffffc02036aa:	00008617          	auipc	a2,0x8
ffffffffc02036ae:	fce60613          	addi	a2,a2,-50 # ffffffffc020b678 <commands+0x210>
ffffffffc02036b2:	26700593          	li	a1,615
ffffffffc02036b6:	00009517          	auipc	a0,0x9
ffffffffc02036ba:	bfa50513          	addi	a0,a0,-1030 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02036be:	de1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036c2:	00009697          	auipc	a3,0x9
ffffffffc02036c6:	f6668693          	addi	a3,a3,-154 # ffffffffc020c628 <default_pmm_manager+0x4c8>
ffffffffc02036ca:	00008617          	auipc	a2,0x8
ffffffffc02036ce:	fae60613          	addi	a2,a2,-82 # ffffffffc020b678 <commands+0x210>
ffffffffc02036d2:	26600593          	li	a1,614
ffffffffc02036d6:	00009517          	auipc	a0,0x9
ffffffffc02036da:	bda50513          	addi	a0,a0,-1062 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02036de:	dc1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036e2:	00009697          	auipc	a3,0x9
ffffffffc02036e6:	f3668693          	addi	a3,a3,-202 # ffffffffc020c618 <default_pmm_manager+0x4b8>
ffffffffc02036ea:	00008617          	auipc	a2,0x8
ffffffffc02036ee:	f8e60613          	addi	a2,a2,-114 # ffffffffc020b678 <commands+0x210>
ffffffffc02036f2:	26500593          	li	a1,613
ffffffffc02036f6:	00009517          	auipc	a0,0x9
ffffffffc02036fa:	bba50513          	addi	a0,a0,-1094 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02036fe:	da1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203702:	00009697          	auipc	a3,0x9
ffffffffc0203706:	ede68693          	addi	a3,a3,-290 # ffffffffc020c5e0 <default_pmm_manager+0x480>
ffffffffc020370a:	00008617          	auipc	a2,0x8
ffffffffc020370e:	f6e60613          	addi	a2,a2,-146 # ffffffffc020b678 <commands+0x210>
ffffffffc0203712:	26400593          	li	a1,612
ffffffffc0203716:	00009517          	auipc	a0,0x9
ffffffffc020371a:	b9a50513          	addi	a0,a0,-1126 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc020371e:	d81fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203722:	00009697          	auipc	a3,0x9
ffffffffc0203726:	00e68693          	addi	a3,a3,14 # ffffffffc020c730 <default_pmm_manager+0x5d0>
ffffffffc020372a:	00008617          	auipc	a2,0x8
ffffffffc020372e:	f4e60613          	addi	a2,a2,-178 # ffffffffc020b678 <commands+0x210>
ffffffffc0203732:	28100593          	li	a1,641
ffffffffc0203736:	00009517          	auipc	a0,0x9
ffffffffc020373a:	b7a50513          	addi	a0,a0,-1158 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc020373e:	d61fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203742:	00009617          	auipc	a2,0x9
ffffffffc0203746:	a5660613          	addi	a2,a2,-1450 # ffffffffc020c198 <default_pmm_manager+0x38>
ffffffffc020374a:	07100593          	li	a1,113
ffffffffc020374e:	00009517          	auipc	a0,0x9
ffffffffc0203752:	a7250513          	addi	a0,a0,-1422 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc0203756:	d49fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020375a:	86a2                	mv	a3,s0
ffffffffc020375c:	00009617          	auipc	a2,0x9
ffffffffc0203760:	ae460613          	addi	a2,a2,-1308 # ffffffffc020c240 <default_pmm_manager+0xe0>
ffffffffc0203764:	0ca00593          	li	a1,202
ffffffffc0203768:	00009517          	auipc	a0,0x9
ffffffffc020376c:	b4850513          	addi	a0,a0,-1208 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203770:	d2ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203774:	00009617          	auipc	a2,0x9
ffffffffc0203778:	acc60613          	addi	a2,a2,-1332 # ffffffffc020c240 <default_pmm_manager+0xe0>
ffffffffc020377c:	08100593          	li	a1,129
ffffffffc0203780:	00009517          	auipc	a0,0x9
ffffffffc0203784:	b3050513          	addi	a0,a0,-1232 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203788:	d17fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020378c:	00009697          	auipc	a3,0x9
ffffffffc0203790:	e1468693          	addi	a3,a3,-492 # ffffffffc020c5a0 <default_pmm_manager+0x440>
ffffffffc0203794:	00008617          	auipc	a2,0x8
ffffffffc0203798:	ee460613          	addi	a2,a2,-284 # ffffffffc020b678 <commands+0x210>
ffffffffc020379c:	26300593          	li	a1,611
ffffffffc02037a0:	00009517          	auipc	a0,0x9
ffffffffc02037a4:	b1050513          	addi	a0,a0,-1264 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02037a8:	cf7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037ac:	00009697          	auipc	a3,0x9
ffffffffc02037b0:	d3468693          	addi	a3,a3,-716 # ffffffffc020c4e0 <default_pmm_manager+0x380>
ffffffffc02037b4:	00008617          	auipc	a2,0x8
ffffffffc02037b8:	ec460613          	addi	a2,a2,-316 # ffffffffc020b678 <commands+0x210>
ffffffffc02037bc:	25700593          	li	a1,599
ffffffffc02037c0:	00009517          	auipc	a0,0x9
ffffffffc02037c4:	af050513          	addi	a0,a0,-1296 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02037c8:	cd7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037cc:	985fe0ef          	jal	ra,ffffffffc0202150 <pte2page.part.0>
ffffffffc02037d0:	00009697          	auipc	a3,0x9
ffffffffc02037d4:	d4068693          	addi	a3,a3,-704 # ffffffffc020c510 <default_pmm_manager+0x3b0>
ffffffffc02037d8:	00008617          	auipc	a2,0x8
ffffffffc02037dc:	ea060613          	addi	a2,a2,-352 # ffffffffc020b678 <commands+0x210>
ffffffffc02037e0:	25a00593          	li	a1,602
ffffffffc02037e4:	00009517          	auipc	a0,0x9
ffffffffc02037e8:	acc50513          	addi	a0,a0,-1332 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02037ec:	cb3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037f0:	00009697          	auipc	a3,0x9
ffffffffc02037f4:	cc068693          	addi	a3,a3,-832 # ffffffffc020c4b0 <default_pmm_manager+0x350>
ffffffffc02037f8:	00008617          	auipc	a2,0x8
ffffffffc02037fc:	e8060613          	addi	a2,a2,-384 # ffffffffc020b678 <commands+0x210>
ffffffffc0203800:	25300593          	li	a1,595
ffffffffc0203804:	00009517          	auipc	a0,0x9
ffffffffc0203808:	aac50513          	addi	a0,a0,-1364 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc020380c:	c93fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203810:	00009697          	auipc	a3,0x9
ffffffffc0203814:	d3068693          	addi	a3,a3,-720 # ffffffffc020c540 <default_pmm_manager+0x3e0>
ffffffffc0203818:	00008617          	auipc	a2,0x8
ffffffffc020381c:	e6060613          	addi	a2,a2,-416 # ffffffffc020b678 <commands+0x210>
ffffffffc0203820:	25b00593          	li	a1,603
ffffffffc0203824:	00009517          	auipc	a0,0x9
ffffffffc0203828:	a8c50513          	addi	a0,a0,-1396 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc020382c:	c73fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203830:	00009617          	auipc	a2,0x9
ffffffffc0203834:	96860613          	addi	a2,a2,-1688 # ffffffffc020c198 <default_pmm_manager+0x38>
ffffffffc0203838:	25e00593          	li	a1,606
ffffffffc020383c:	00009517          	auipc	a0,0x9
ffffffffc0203840:	a7450513          	addi	a0,a0,-1420 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203844:	c5bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203848:	00009697          	auipc	a3,0x9
ffffffffc020384c:	d1068693          	addi	a3,a3,-752 # ffffffffc020c558 <default_pmm_manager+0x3f8>
ffffffffc0203850:	00008617          	auipc	a2,0x8
ffffffffc0203854:	e2860613          	addi	a2,a2,-472 # ffffffffc020b678 <commands+0x210>
ffffffffc0203858:	25c00593          	li	a1,604
ffffffffc020385c:	00009517          	auipc	a0,0x9
ffffffffc0203860:	a5450513          	addi	a0,a0,-1452 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203864:	c3bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203868:	86ca                	mv	a3,s2
ffffffffc020386a:	00009617          	auipc	a2,0x9
ffffffffc020386e:	9d660613          	addi	a2,a2,-1578 # ffffffffc020c240 <default_pmm_manager+0xe0>
ffffffffc0203872:	0c600593          	li	a1,198
ffffffffc0203876:	00009517          	auipc	a0,0x9
ffffffffc020387a:	a3a50513          	addi	a0,a0,-1478 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc020387e:	c21fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203882:	00009697          	auipc	a3,0x9
ffffffffc0203886:	e3668693          	addi	a3,a3,-458 # ffffffffc020c6b8 <default_pmm_manager+0x558>
ffffffffc020388a:	00008617          	auipc	a2,0x8
ffffffffc020388e:	dee60613          	addi	a2,a2,-530 # ffffffffc020b678 <commands+0x210>
ffffffffc0203892:	27700593          	li	a1,631
ffffffffc0203896:	00009517          	auipc	a0,0x9
ffffffffc020389a:	a1a50513          	addi	a0,a0,-1510 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc020389e:	c01fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038a2:	00009697          	auipc	a3,0x9
ffffffffc02038a6:	e4668693          	addi	a3,a3,-442 # ffffffffc020c6e8 <default_pmm_manager+0x588>
ffffffffc02038aa:	00008617          	auipc	a2,0x8
ffffffffc02038ae:	dce60613          	addi	a2,a2,-562 # ffffffffc020b678 <commands+0x210>
ffffffffc02038b2:	27600593          	li	a1,630
ffffffffc02038b6:	00009517          	auipc	a0,0x9
ffffffffc02038ba:	9fa50513          	addi	a0,a0,-1542 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc02038be:	be1fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02038c2 <copy_range>:
ffffffffc02038c2:	7159                	addi	sp,sp,-112
ffffffffc02038c4:	00d667b3          	or	a5,a2,a3
ffffffffc02038c8:	f486                	sd	ra,104(sp)
ffffffffc02038ca:	f0a2                	sd	s0,96(sp)
ffffffffc02038cc:	eca6                	sd	s1,88(sp)
ffffffffc02038ce:	e8ca                	sd	s2,80(sp)
ffffffffc02038d0:	e4ce                	sd	s3,72(sp)
ffffffffc02038d2:	e0d2                	sd	s4,64(sp)
ffffffffc02038d4:	fc56                	sd	s5,56(sp)
ffffffffc02038d6:	f85a                	sd	s6,48(sp)
ffffffffc02038d8:	f45e                	sd	s7,40(sp)
ffffffffc02038da:	f062                	sd	s8,32(sp)
ffffffffc02038dc:	ec66                	sd	s9,24(sp)
ffffffffc02038de:	e86a                	sd	s10,16(sp)
ffffffffc02038e0:	e46e                	sd	s11,8(sp)
ffffffffc02038e2:	17d2                	slli	a5,a5,0x34
ffffffffc02038e4:	1e079e63          	bnez	a5,ffffffffc0203ae0 <copy_range+0x21e>
ffffffffc02038e8:	002007b7          	lui	a5,0x200
ffffffffc02038ec:	8432                	mv	s0,a2
ffffffffc02038ee:	1af66963          	bltu	a2,a5,ffffffffc0203aa0 <copy_range+0x1de>
ffffffffc02038f2:	8936                	mv	s2,a3
ffffffffc02038f4:	1ad67663          	bgeu	a2,a3,ffffffffc0203aa0 <copy_range+0x1de>
ffffffffc02038f8:	4785                	li	a5,1
ffffffffc02038fa:	07fe                	slli	a5,a5,0x1f
ffffffffc02038fc:	1ad7e263          	bltu	a5,a3,ffffffffc0203aa0 <copy_range+0x1de>
ffffffffc0203900:	5afd                	li	s5,-1
ffffffffc0203902:	8a2a                	mv	s4,a0
ffffffffc0203904:	89ae                	mv	s3,a1
ffffffffc0203906:	00093c17          	auipc	s8,0x93
ffffffffc020390a:	f9ac0c13          	addi	s8,s8,-102 # ffffffffc02968a0 <npage>
ffffffffc020390e:	00093b97          	auipc	s7,0x93
ffffffffc0203912:	f9ab8b93          	addi	s7,s7,-102 # ffffffffc02968a8 <pages>
ffffffffc0203916:	00080b37          	lui	s6,0x80
ffffffffc020391a:	00cada93          	srli	s5,s5,0xc
ffffffffc020391e:	00093c97          	auipc	s9,0x93
ffffffffc0203922:	f92c8c93          	addi	s9,s9,-110 # ffffffffc02968b0 <pmm_manager>
ffffffffc0203926:	4601                	li	a2,0
ffffffffc0203928:	85a2                	mv	a1,s0
ffffffffc020392a:	854e                	mv	a0,s3
ffffffffc020392c:	8f9fe0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0203930:	84aa                	mv	s1,a0
ffffffffc0203932:	c979                	beqz	a0,ffffffffc0203a08 <copy_range+0x146>
ffffffffc0203934:	611c                	ld	a5,0(a0)
ffffffffc0203936:	8b85                	andi	a5,a5,1
ffffffffc0203938:	e78d                	bnez	a5,ffffffffc0203962 <copy_range+0xa0>
ffffffffc020393a:	6785                	lui	a5,0x1
ffffffffc020393c:	943e                	add	s0,s0,a5
ffffffffc020393e:	ff2464e3          	bltu	s0,s2,ffffffffc0203926 <copy_range+0x64>
ffffffffc0203942:	4501                	li	a0,0
ffffffffc0203944:	70a6                	ld	ra,104(sp)
ffffffffc0203946:	7406                	ld	s0,96(sp)
ffffffffc0203948:	64e6                	ld	s1,88(sp)
ffffffffc020394a:	6946                	ld	s2,80(sp)
ffffffffc020394c:	69a6                	ld	s3,72(sp)
ffffffffc020394e:	6a06                	ld	s4,64(sp)
ffffffffc0203950:	7ae2                	ld	s5,56(sp)
ffffffffc0203952:	7b42                	ld	s6,48(sp)
ffffffffc0203954:	7ba2                	ld	s7,40(sp)
ffffffffc0203956:	7c02                	ld	s8,32(sp)
ffffffffc0203958:	6ce2                	ld	s9,24(sp)
ffffffffc020395a:	6d42                	ld	s10,16(sp)
ffffffffc020395c:	6da2                	ld	s11,8(sp)
ffffffffc020395e:	6165                	addi	sp,sp,112
ffffffffc0203960:	8082                	ret
ffffffffc0203962:	4605                	li	a2,1
ffffffffc0203964:	85a2                	mv	a1,s0
ffffffffc0203966:	8552                	mv	a0,s4
ffffffffc0203968:	8bdfe0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc020396c:	c179                	beqz	a0,ffffffffc0203a32 <copy_range+0x170>
ffffffffc020396e:	609c                	ld	a5,0(s1)
ffffffffc0203970:	0017f713          	andi	a4,a5,1
ffffffffc0203974:	01f7f493          	andi	s1,a5,31
ffffffffc0203978:	10070863          	beqz	a4,ffffffffc0203a88 <copy_range+0x1c6>
ffffffffc020397c:	000c3683          	ld	a3,0(s8)
ffffffffc0203980:	078a                	slli	a5,a5,0x2
ffffffffc0203982:	00c7d713          	srli	a4,a5,0xc
ffffffffc0203986:	0ed77563          	bgeu	a4,a3,ffffffffc0203a70 <copy_range+0x1ae>
ffffffffc020398a:	000bb783          	ld	a5,0(s7)
ffffffffc020398e:	fff806b7          	lui	a3,0xfff80
ffffffffc0203992:	9736                	add	a4,a4,a3
ffffffffc0203994:	071a                	slli	a4,a4,0x6
ffffffffc0203996:	00e78db3          	add	s11,a5,a4
ffffffffc020399a:	10002773          	csrr	a4,sstatus
ffffffffc020399e:	8b09                	andi	a4,a4,2
ffffffffc02039a0:	ef35                	bnez	a4,ffffffffc0203a1c <copy_range+0x15a>
ffffffffc02039a2:	000cb703          	ld	a4,0(s9)
ffffffffc02039a6:	4505                	li	a0,1
ffffffffc02039a8:	6f18                	ld	a4,24(a4)
ffffffffc02039aa:	9702                	jalr	a4
ffffffffc02039ac:	8d2a                	mv	s10,a0
ffffffffc02039ae:	0a0d8163          	beqz	s11,ffffffffc0203a50 <copy_range+0x18e>
ffffffffc02039b2:	100d0763          	beqz	s10,ffffffffc0203ac0 <copy_range+0x1fe>
ffffffffc02039b6:	000bb703          	ld	a4,0(s7)
ffffffffc02039ba:	000c3603          	ld	a2,0(s8)
ffffffffc02039be:	40ed86b3          	sub	a3,s11,a4
ffffffffc02039c2:	8699                	srai	a3,a3,0x6
ffffffffc02039c4:	96da                	add	a3,a3,s6
ffffffffc02039c6:	0156f7b3          	and	a5,a3,s5
ffffffffc02039ca:	06b2                	slli	a3,a3,0xc
ffffffffc02039cc:	06c7f663          	bgeu	a5,a2,ffffffffc0203a38 <copy_range+0x176>
ffffffffc02039d0:	40ed07b3          	sub	a5,s10,a4
ffffffffc02039d4:	00093717          	auipc	a4,0x93
ffffffffc02039d8:	ee470713          	addi	a4,a4,-284 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02039dc:	6308                	ld	a0,0(a4)
ffffffffc02039de:	8799                	srai	a5,a5,0x6
ffffffffc02039e0:	97da                	add	a5,a5,s6
ffffffffc02039e2:	0157f733          	and	a4,a5,s5
ffffffffc02039e6:	00a685b3          	add	a1,a3,a0
ffffffffc02039ea:	07b2                	slli	a5,a5,0xc
ffffffffc02039ec:	04c77563          	bgeu	a4,a2,ffffffffc0203a36 <copy_range+0x174>
ffffffffc02039f0:	6605                	lui	a2,0x1
ffffffffc02039f2:	953e                	add	a0,a0,a5
ffffffffc02039f4:	7f2070ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc02039f8:	86a6                	mv	a3,s1
ffffffffc02039fa:	8622                	mv	a2,s0
ffffffffc02039fc:	85ea                	mv	a1,s10
ffffffffc02039fe:	8552                	mv	a0,s4
ffffffffc0203a00:	fdbfe0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0203a04:	d91d                	beqz	a0,ffffffffc020393a <copy_range+0x78>
ffffffffc0203a06:	bf3d                	j	ffffffffc0203944 <copy_range+0x82>
ffffffffc0203a08:	00200637          	lui	a2,0x200
ffffffffc0203a0c:	9432                	add	s0,s0,a2
ffffffffc0203a0e:	ffe00637          	lui	a2,0xffe00
ffffffffc0203a12:	8c71                	and	s0,s0,a2
ffffffffc0203a14:	d41d                	beqz	s0,ffffffffc0203942 <copy_range+0x80>
ffffffffc0203a16:	f12468e3          	bltu	s0,s2,ffffffffc0203926 <copy_range+0x64>
ffffffffc0203a1a:	b725                	j	ffffffffc0203942 <copy_range+0x80>
ffffffffc0203a1c:	a56fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203a20:	000cb703          	ld	a4,0(s9)
ffffffffc0203a24:	4505                	li	a0,1
ffffffffc0203a26:	6f18                	ld	a4,24(a4)
ffffffffc0203a28:	9702                	jalr	a4
ffffffffc0203a2a:	8d2a                	mv	s10,a0
ffffffffc0203a2c:	a40fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203a30:	bfbd                	j	ffffffffc02039ae <copy_range+0xec>
ffffffffc0203a32:	5571                	li	a0,-4
ffffffffc0203a34:	bf01                	j	ffffffffc0203944 <copy_range+0x82>
ffffffffc0203a36:	86be                	mv	a3,a5
ffffffffc0203a38:	00008617          	auipc	a2,0x8
ffffffffc0203a3c:	76060613          	addi	a2,a2,1888 # ffffffffc020c198 <default_pmm_manager+0x38>
ffffffffc0203a40:	07100593          	li	a1,113
ffffffffc0203a44:	00008517          	auipc	a0,0x8
ffffffffc0203a48:	77c50513          	addi	a0,a0,1916 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc0203a4c:	a53fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a50:	00009697          	auipc	a3,0x9
ffffffffc0203a54:	ee868693          	addi	a3,a3,-280 # ffffffffc020c938 <default_pmm_manager+0x7d8>
ffffffffc0203a58:	00008617          	auipc	a2,0x8
ffffffffc0203a5c:	c2060613          	addi	a2,a2,-992 # ffffffffc020b678 <commands+0x210>
ffffffffc0203a60:	1ce00593          	li	a1,462
ffffffffc0203a64:	00009517          	auipc	a0,0x9
ffffffffc0203a68:	84c50513          	addi	a0,a0,-1972 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203a6c:	a33fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a70:	00008617          	auipc	a2,0x8
ffffffffc0203a74:	7f860613          	addi	a2,a2,2040 # ffffffffc020c268 <default_pmm_manager+0x108>
ffffffffc0203a78:	06900593          	li	a1,105
ffffffffc0203a7c:	00008517          	auipc	a0,0x8
ffffffffc0203a80:	74450513          	addi	a0,a0,1860 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc0203a84:	a1bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a88:	00009617          	auipc	a2,0x9
ffffffffc0203a8c:	80060613          	addi	a2,a2,-2048 # ffffffffc020c288 <default_pmm_manager+0x128>
ffffffffc0203a90:	07f00593          	li	a1,127
ffffffffc0203a94:	00008517          	auipc	a0,0x8
ffffffffc0203a98:	72c50513          	addi	a0,a0,1836 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc0203a9c:	a03fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203aa0:	00009697          	auipc	a3,0x9
ffffffffc0203aa4:	87868693          	addi	a3,a3,-1928 # ffffffffc020c318 <default_pmm_manager+0x1b8>
ffffffffc0203aa8:	00008617          	auipc	a2,0x8
ffffffffc0203aac:	bd060613          	addi	a2,a2,-1072 # ffffffffc020b678 <commands+0x210>
ffffffffc0203ab0:	1b600593          	li	a1,438
ffffffffc0203ab4:	00008517          	auipc	a0,0x8
ffffffffc0203ab8:	7fc50513          	addi	a0,a0,2044 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203abc:	9e3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203ac0:	00009697          	auipc	a3,0x9
ffffffffc0203ac4:	e8868693          	addi	a3,a3,-376 # ffffffffc020c948 <default_pmm_manager+0x7e8>
ffffffffc0203ac8:	00008617          	auipc	a2,0x8
ffffffffc0203acc:	bb060613          	addi	a2,a2,-1104 # ffffffffc020b678 <commands+0x210>
ffffffffc0203ad0:	1cf00593          	li	a1,463
ffffffffc0203ad4:	00008517          	auipc	a0,0x8
ffffffffc0203ad8:	7dc50513          	addi	a0,a0,2012 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203adc:	9c3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203ae0:	00009697          	auipc	a3,0x9
ffffffffc0203ae4:	80868693          	addi	a3,a3,-2040 # ffffffffc020c2e8 <default_pmm_manager+0x188>
ffffffffc0203ae8:	00008617          	auipc	a2,0x8
ffffffffc0203aec:	b9060613          	addi	a2,a2,-1136 # ffffffffc020b678 <commands+0x210>
ffffffffc0203af0:	1b500593          	li	a1,437
ffffffffc0203af4:	00008517          	auipc	a0,0x8
ffffffffc0203af8:	7bc50513          	addi	a0,a0,1980 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203afc:	9a3fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203b00 <pgdir_alloc_page>:
ffffffffc0203b00:	7179                	addi	sp,sp,-48
ffffffffc0203b02:	ec26                	sd	s1,24(sp)
ffffffffc0203b04:	e84a                	sd	s2,16(sp)
ffffffffc0203b06:	e052                	sd	s4,0(sp)
ffffffffc0203b08:	f406                	sd	ra,40(sp)
ffffffffc0203b0a:	f022                	sd	s0,32(sp)
ffffffffc0203b0c:	e44e                	sd	s3,8(sp)
ffffffffc0203b0e:	8a2a                	mv	s4,a0
ffffffffc0203b10:	84ae                	mv	s1,a1
ffffffffc0203b12:	8932                	mv	s2,a2
ffffffffc0203b14:	100027f3          	csrr	a5,sstatus
ffffffffc0203b18:	8b89                	andi	a5,a5,2
ffffffffc0203b1a:	00093997          	auipc	s3,0x93
ffffffffc0203b1e:	d9698993          	addi	s3,s3,-618 # ffffffffc02968b0 <pmm_manager>
ffffffffc0203b22:	ef8d                	bnez	a5,ffffffffc0203b5c <pgdir_alloc_page+0x5c>
ffffffffc0203b24:	0009b783          	ld	a5,0(s3)
ffffffffc0203b28:	4505                	li	a0,1
ffffffffc0203b2a:	6f9c                	ld	a5,24(a5)
ffffffffc0203b2c:	9782                	jalr	a5
ffffffffc0203b2e:	842a                	mv	s0,a0
ffffffffc0203b30:	cc09                	beqz	s0,ffffffffc0203b4a <pgdir_alloc_page+0x4a>
ffffffffc0203b32:	86ca                	mv	a3,s2
ffffffffc0203b34:	8626                	mv	a2,s1
ffffffffc0203b36:	85a2                	mv	a1,s0
ffffffffc0203b38:	8552                	mv	a0,s4
ffffffffc0203b3a:	ea1fe0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0203b3e:	e915                	bnez	a0,ffffffffc0203b72 <pgdir_alloc_page+0x72>
ffffffffc0203b40:	4018                	lw	a4,0(s0)
ffffffffc0203b42:	fc04                	sd	s1,56(s0)
ffffffffc0203b44:	4785                	li	a5,1
ffffffffc0203b46:	04f71e63          	bne	a4,a5,ffffffffc0203ba2 <pgdir_alloc_page+0xa2>
ffffffffc0203b4a:	70a2                	ld	ra,40(sp)
ffffffffc0203b4c:	8522                	mv	a0,s0
ffffffffc0203b4e:	7402                	ld	s0,32(sp)
ffffffffc0203b50:	64e2                	ld	s1,24(sp)
ffffffffc0203b52:	6942                	ld	s2,16(sp)
ffffffffc0203b54:	69a2                	ld	s3,8(sp)
ffffffffc0203b56:	6a02                	ld	s4,0(sp)
ffffffffc0203b58:	6145                	addi	sp,sp,48
ffffffffc0203b5a:	8082                	ret
ffffffffc0203b5c:	916fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203b60:	0009b783          	ld	a5,0(s3)
ffffffffc0203b64:	4505                	li	a0,1
ffffffffc0203b66:	6f9c                	ld	a5,24(a5)
ffffffffc0203b68:	9782                	jalr	a5
ffffffffc0203b6a:	842a                	mv	s0,a0
ffffffffc0203b6c:	900fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203b70:	b7c1                	j	ffffffffc0203b30 <pgdir_alloc_page+0x30>
ffffffffc0203b72:	100027f3          	csrr	a5,sstatus
ffffffffc0203b76:	8b89                	andi	a5,a5,2
ffffffffc0203b78:	eb89                	bnez	a5,ffffffffc0203b8a <pgdir_alloc_page+0x8a>
ffffffffc0203b7a:	0009b783          	ld	a5,0(s3)
ffffffffc0203b7e:	8522                	mv	a0,s0
ffffffffc0203b80:	4585                	li	a1,1
ffffffffc0203b82:	739c                	ld	a5,32(a5)
ffffffffc0203b84:	4401                	li	s0,0
ffffffffc0203b86:	9782                	jalr	a5
ffffffffc0203b88:	b7c9                	j	ffffffffc0203b4a <pgdir_alloc_page+0x4a>
ffffffffc0203b8a:	8e8fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203b8e:	0009b783          	ld	a5,0(s3)
ffffffffc0203b92:	8522                	mv	a0,s0
ffffffffc0203b94:	4585                	li	a1,1
ffffffffc0203b96:	739c                	ld	a5,32(a5)
ffffffffc0203b98:	4401                	li	s0,0
ffffffffc0203b9a:	9782                	jalr	a5
ffffffffc0203b9c:	8d0fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203ba0:	b76d                	j	ffffffffc0203b4a <pgdir_alloc_page+0x4a>
ffffffffc0203ba2:	00009697          	auipc	a3,0x9
ffffffffc0203ba6:	db668693          	addi	a3,a3,-586 # ffffffffc020c958 <default_pmm_manager+0x7f8>
ffffffffc0203baa:	00008617          	auipc	a2,0x8
ffffffffc0203bae:	ace60613          	addi	a2,a2,-1330 # ffffffffc020b678 <commands+0x210>
ffffffffc0203bb2:	23800593          	li	a1,568
ffffffffc0203bb6:	00008517          	auipc	a0,0x8
ffffffffc0203bba:	6fa50513          	addi	a0,a0,1786 # ffffffffc020c2b0 <default_pmm_manager+0x150>
ffffffffc0203bbe:	8e1fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203bc2 <check_vma_overlap.part.0>:
ffffffffc0203bc2:	1141                	addi	sp,sp,-16
ffffffffc0203bc4:	00009697          	auipc	a3,0x9
ffffffffc0203bc8:	dac68693          	addi	a3,a3,-596 # ffffffffc020c970 <default_pmm_manager+0x810>
ffffffffc0203bcc:	00008617          	auipc	a2,0x8
ffffffffc0203bd0:	aac60613          	addi	a2,a2,-1364 # ffffffffc020b678 <commands+0x210>
ffffffffc0203bd4:	07400593          	li	a1,116
ffffffffc0203bd8:	00009517          	auipc	a0,0x9
ffffffffc0203bdc:	db850513          	addi	a0,a0,-584 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc0203be0:	e406                	sd	ra,8(sp)
ffffffffc0203be2:	8bdfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203be6 <mm_create>:
ffffffffc0203be6:	1141                	addi	sp,sp,-16
ffffffffc0203be8:	05800513          	li	a0,88
ffffffffc0203bec:	e022                	sd	s0,0(sp)
ffffffffc0203bee:	e406                	sd	ra,8(sp)
ffffffffc0203bf0:	b9efe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203bf4:	842a                	mv	s0,a0
ffffffffc0203bf6:	c115                	beqz	a0,ffffffffc0203c1a <mm_create+0x34>
ffffffffc0203bf8:	e408                	sd	a0,8(s0)
ffffffffc0203bfa:	e008                	sd	a0,0(s0)
ffffffffc0203bfc:	00053823          	sd	zero,16(a0)
ffffffffc0203c00:	00053c23          	sd	zero,24(a0)
ffffffffc0203c04:	02052023          	sw	zero,32(a0)
ffffffffc0203c08:	02053423          	sd	zero,40(a0)
ffffffffc0203c0c:	02052823          	sw	zero,48(a0)
ffffffffc0203c10:	4585                	li	a1,1
ffffffffc0203c12:	03850513          	addi	a0,a0,56
ffffffffc0203c16:	123000ef          	jal	ra,ffffffffc0204538 <sem_init>
ffffffffc0203c1a:	60a2                	ld	ra,8(sp)
ffffffffc0203c1c:	8522                	mv	a0,s0
ffffffffc0203c1e:	6402                	ld	s0,0(sp)
ffffffffc0203c20:	0141                	addi	sp,sp,16
ffffffffc0203c22:	8082                	ret

ffffffffc0203c24 <find_vma>:
ffffffffc0203c24:	86aa                	mv	a3,a0
ffffffffc0203c26:	c505                	beqz	a0,ffffffffc0203c4e <find_vma+0x2a>
ffffffffc0203c28:	6908                	ld	a0,16(a0)
ffffffffc0203c2a:	c501                	beqz	a0,ffffffffc0203c32 <find_vma+0xe>
ffffffffc0203c2c:	651c                	ld	a5,8(a0)
ffffffffc0203c2e:	02f5f263          	bgeu	a1,a5,ffffffffc0203c52 <find_vma+0x2e>
ffffffffc0203c32:	669c                	ld	a5,8(a3)
ffffffffc0203c34:	00f68d63          	beq	a3,a5,ffffffffc0203c4e <find_vma+0x2a>
ffffffffc0203c38:	fe87b703          	ld	a4,-24(a5) # fe8 <_binary_bin_swap_img_size-0x6d18>
ffffffffc0203c3c:	00e5e663          	bltu	a1,a4,ffffffffc0203c48 <find_vma+0x24>
ffffffffc0203c40:	ff07b703          	ld	a4,-16(a5)
ffffffffc0203c44:	00e5ec63          	bltu	a1,a4,ffffffffc0203c5c <find_vma+0x38>
ffffffffc0203c48:	679c                	ld	a5,8(a5)
ffffffffc0203c4a:	fef697e3          	bne	a3,a5,ffffffffc0203c38 <find_vma+0x14>
ffffffffc0203c4e:	4501                	li	a0,0
ffffffffc0203c50:	8082                	ret
ffffffffc0203c52:	691c                	ld	a5,16(a0)
ffffffffc0203c54:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0203c32 <find_vma+0xe>
ffffffffc0203c58:	ea88                	sd	a0,16(a3)
ffffffffc0203c5a:	8082                	ret
ffffffffc0203c5c:	fe078513          	addi	a0,a5,-32
ffffffffc0203c60:	ea88                	sd	a0,16(a3)
ffffffffc0203c62:	8082                	ret

ffffffffc0203c64 <insert_vma_struct>:
ffffffffc0203c64:	6590                	ld	a2,8(a1)
ffffffffc0203c66:	0105b803          	ld	a6,16(a1)
ffffffffc0203c6a:	1141                	addi	sp,sp,-16
ffffffffc0203c6c:	e406                	sd	ra,8(sp)
ffffffffc0203c6e:	87aa                	mv	a5,a0
ffffffffc0203c70:	01066763          	bltu	a2,a6,ffffffffc0203c7e <insert_vma_struct+0x1a>
ffffffffc0203c74:	a085                	j	ffffffffc0203cd4 <insert_vma_struct+0x70>
ffffffffc0203c76:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203c7a:	04e66863          	bltu	a2,a4,ffffffffc0203cca <insert_vma_struct+0x66>
ffffffffc0203c7e:	86be                	mv	a3,a5
ffffffffc0203c80:	679c                	ld	a5,8(a5)
ffffffffc0203c82:	fef51ae3          	bne	a0,a5,ffffffffc0203c76 <insert_vma_struct+0x12>
ffffffffc0203c86:	02a68463          	beq	a3,a0,ffffffffc0203cae <insert_vma_struct+0x4a>
ffffffffc0203c8a:	ff06b703          	ld	a4,-16(a3)
ffffffffc0203c8e:	fe86b883          	ld	a7,-24(a3)
ffffffffc0203c92:	08e8f163          	bgeu	a7,a4,ffffffffc0203d14 <insert_vma_struct+0xb0>
ffffffffc0203c96:	04e66f63          	bltu	a2,a4,ffffffffc0203cf4 <insert_vma_struct+0x90>
ffffffffc0203c9a:	00f50a63          	beq	a0,a5,ffffffffc0203cae <insert_vma_struct+0x4a>
ffffffffc0203c9e:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203ca2:	05076963          	bltu	a4,a6,ffffffffc0203cf4 <insert_vma_struct+0x90>
ffffffffc0203ca6:	ff07b603          	ld	a2,-16(a5)
ffffffffc0203caa:	02c77363          	bgeu	a4,a2,ffffffffc0203cd0 <insert_vma_struct+0x6c>
ffffffffc0203cae:	5118                	lw	a4,32(a0)
ffffffffc0203cb0:	e188                	sd	a0,0(a1)
ffffffffc0203cb2:	02058613          	addi	a2,a1,32
ffffffffc0203cb6:	e390                	sd	a2,0(a5)
ffffffffc0203cb8:	e690                	sd	a2,8(a3)
ffffffffc0203cba:	60a2                	ld	ra,8(sp)
ffffffffc0203cbc:	f59c                	sd	a5,40(a1)
ffffffffc0203cbe:	f194                	sd	a3,32(a1)
ffffffffc0203cc0:	0017079b          	addiw	a5,a4,1
ffffffffc0203cc4:	d11c                	sw	a5,32(a0)
ffffffffc0203cc6:	0141                	addi	sp,sp,16
ffffffffc0203cc8:	8082                	ret
ffffffffc0203cca:	fca690e3          	bne	a3,a0,ffffffffc0203c8a <insert_vma_struct+0x26>
ffffffffc0203cce:	bfd1                	j	ffffffffc0203ca2 <insert_vma_struct+0x3e>
ffffffffc0203cd0:	ef3ff0ef          	jal	ra,ffffffffc0203bc2 <check_vma_overlap.part.0>
ffffffffc0203cd4:	00009697          	auipc	a3,0x9
ffffffffc0203cd8:	ccc68693          	addi	a3,a3,-820 # ffffffffc020c9a0 <default_pmm_manager+0x840>
ffffffffc0203cdc:	00008617          	auipc	a2,0x8
ffffffffc0203ce0:	99c60613          	addi	a2,a2,-1636 # ffffffffc020b678 <commands+0x210>
ffffffffc0203ce4:	07a00593          	li	a1,122
ffffffffc0203ce8:	00009517          	auipc	a0,0x9
ffffffffc0203cec:	ca850513          	addi	a0,a0,-856 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc0203cf0:	faefc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203cf4:	00009697          	auipc	a3,0x9
ffffffffc0203cf8:	cec68693          	addi	a3,a3,-788 # ffffffffc020c9e0 <default_pmm_manager+0x880>
ffffffffc0203cfc:	00008617          	auipc	a2,0x8
ffffffffc0203d00:	97c60613          	addi	a2,a2,-1668 # ffffffffc020b678 <commands+0x210>
ffffffffc0203d04:	07300593          	li	a1,115
ffffffffc0203d08:	00009517          	auipc	a0,0x9
ffffffffc0203d0c:	c8850513          	addi	a0,a0,-888 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc0203d10:	f8efc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203d14:	00009697          	auipc	a3,0x9
ffffffffc0203d18:	cac68693          	addi	a3,a3,-852 # ffffffffc020c9c0 <default_pmm_manager+0x860>
ffffffffc0203d1c:	00008617          	auipc	a2,0x8
ffffffffc0203d20:	95c60613          	addi	a2,a2,-1700 # ffffffffc020b678 <commands+0x210>
ffffffffc0203d24:	07200593          	li	a1,114
ffffffffc0203d28:	00009517          	auipc	a0,0x9
ffffffffc0203d2c:	c6850513          	addi	a0,a0,-920 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc0203d30:	f6efc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203d34 <mm_destroy>:
ffffffffc0203d34:	591c                	lw	a5,48(a0)
ffffffffc0203d36:	1141                	addi	sp,sp,-16
ffffffffc0203d38:	e406                	sd	ra,8(sp)
ffffffffc0203d3a:	e022                	sd	s0,0(sp)
ffffffffc0203d3c:	e78d                	bnez	a5,ffffffffc0203d66 <mm_destroy+0x32>
ffffffffc0203d3e:	842a                	mv	s0,a0
ffffffffc0203d40:	6508                	ld	a0,8(a0)
ffffffffc0203d42:	00a40c63          	beq	s0,a0,ffffffffc0203d5a <mm_destroy+0x26>
ffffffffc0203d46:	6118                	ld	a4,0(a0)
ffffffffc0203d48:	651c                	ld	a5,8(a0)
ffffffffc0203d4a:	1501                	addi	a0,a0,-32
ffffffffc0203d4c:	e71c                	sd	a5,8(a4)
ffffffffc0203d4e:	e398                	sd	a4,0(a5)
ffffffffc0203d50:	aeefe0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0203d54:	6408                	ld	a0,8(s0)
ffffffffc0203d56:	fea418e3          	bne	s0,a0,ffffffffc0203d46 <mm_destroy+0x12>
ffffffffc0203d5a:	8522                	mv	a0,s0
ffffffffc0203d5c:	6402                	ld	s0,0(sp)
ffffffffc0203d5e:	60a2                	ld	ra,8(sp)
ffffffffc0203d60:	0141                	addi	sp,sp,16
ffffffffc0203d62:	adcfe06f          	j	ffffffffc020203e <kfree>
ffffffffc0203d66:	00009697          	auipc	a3,0x9
ffffffffc0203d6a:	c9a68693          	addi	a3,a3,-870 # ffffffffc020ca00 <default_pmm_manager+0x8a0>
ffffffffc0203d6e:	00008617          	auipc	a2,0x8
ffffffffc0203d72:	90a60613          	addi	a2,a2,-1782 # ffffffffc020b678 <commands+0x210>
ffffffffc0203d76:	09e00593          	li	a1,158
ffffffffc0203d7a:	00009517          	auipc	a0,0x9
ffffffffc0203d7e:	c1650513          	addi	a0,a0,-1002 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc0203d82:	f1cfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203d86 <mm_map>:
ffffffffc0203d86:	7139                	addi	sp,sp,-64
ffffffffc0203d88:	f822                	sd	s0,48(sp)
ffffffffc0203d8a:	6405                	lui	s0,0x1
ffffffffc0203d8c:	147d                	addi	s0,s0,-1
ffffffffc0203d8e:	77fd                	lui	a5,0xfffff
ffffffffc0203d90:	9622                	add	a2,a2,s0
ffffffffc0203d92:	962e                	add	a2,a2,a1
ffffffffc0203d94:	f426                	sd	s1,40(sp)
ffffffffc0203d96:	fc06                	sd	ra,56(sp)
ffffffffc0203d98:	00f5f4b3          	and	s1,a1,a5
ffffffffc0203d9c:	f04a                	sd	s2,32(sp)
ffffffffc0203d9e:	ec4e                	sd	s3,24(sp)
ffffffffc0203da0:	e852                	sd	s4,16(sp)
ffffffffc0203da2:	e456                	sd	s5,8(sp)
ffffffffc0203da4:	002005b7          	lui	a1,0x200
ffffffffc0203da8:	00f67433          	and	s0,a2,a5
ffffffffc0203dac:	06b4e363          	bltu	s1,a1,ffffffffc0203e12 <mm_map+0x8c>
ffffffffc0203db0:	0684f163          	bgeu	s1,s0,ffffffffc0203e12 <mm_map+0x8c>
ffffffffc0203db4:	4785                	li	a5,1
ffffffffc0203db6:	07fe                	slli	a5,a5,0x1f
ffffffffc0203db8:	0487ed63          	bltu	a5,s0,ffffffffc0203e12 <mm_map+0x8c>
ffffffffc0203dbc:	89aa                	mv	s3,a0
ffffffffc0203dbe:	cd21                	beqz	a0,ffffffffc0203e16 <mm_map+0x90>
ffffffffc0203dc0:	85a6                	mv	a1,s1
ffffffffc0203dc2:	8ab6                	mv	s5,a3
ffffffffc0203dc4:	8a3a                	mv	s4,a4
ffffffffc0203dc6:	e5fff0ef          	jal	ra,ffffffffc0203c24 <find_vma>
ffffffffc0203dca:	c501                	beqz	a0,ffffffffc0203dd2 <mm_map+0x4c>
ffffffffc0203dcc:	651c                	ld	a5,8(a0)
ffffffffc0203dce:	0487e263          	bltu	a5,s0,ffffffffc0203e12 <mm_map+0x8c>
ffffffffc0203dd2:	03000513          	li	a0,48
ffffffffc0203dd6:	9b8fe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203dda:	892a                	mv	s2,a0
ffffffffc0203ddc:	5571                	li	a0,-4
ffffffffc0203dde:	02090163          	beqz	s2,ffffffffc0203e00 <mm_map+0x7a>
ffffffffc0203de2:	854e                	mv	a0,s3
ffffffffc0203de4:	00993423          	sd	s1,8(s2)
ffffffffc0203de8:	00893823          	sd	s0,16(s2)
ffffffffc0203dec:	01592c23          	sw	s5,24(s2)
ffffffffc0203df0:	85ca                	mv	a1,s2
ffffffffc0203df2:	e73ff0ef          	jal	ra,ffffffffc0203c64 <insert_vma_struct>
ffffffffc0203df6:	4501                	li	a0,0
ffffffffc0203df8:	000a0463          	beqz	s4,ffffffffc0203e00 <mm_map+0x7a>
ffffffffc0203dfc:	012a3023          	sd	s2,0(s4)
ffffffffc0203e00:	70e2                	ld	ra,56(sp)
ffffffffc0203e02:	7442                	ld	s0,48(sp)
ffffffffc0203e04:	74a2                	ld	s1,40(sp)
ffffffffc0203e06:	7902                	ld	s2,32(sp)
ffffffffc0203e08:	69e2                	ld	s3,24(sp)
ffffffffc0203e0a:	6a42                	ld	s4,16(sp)
ffffffffc0203e0c:	6aa2                	ld	s5,8(sp)
ffffffffc0203e0e:	6121                	addi	sp,sp,64
ffffffffc0203e10:	8082                	ret
ffffffffc0203e12:	5575                	li	a0,-3
ffffffffc0203e14:	b7f5                	j	ffffffffc0203e00 <mm_map+0x7a>
ffffffffc0203e16:	00009697          	auipc	a3,0x9
ffffffffc0203e1a:	c0268693          	addi	a3,a3,-1022 # ffffffffc020ca18 <default_pmm_manager+0x8b8>
ffffffffc0203e1e:	00008617          	auipc	a2,0x8
ffffffffc0203e22:	85a60613          	addi	a2,a2,-1958 # ffffffffc020b678 <commands+0x210>
ffffffffc0203e26:	0b300593          	li	a1,179
ffffffffc0203e2a:	00009517          	auipc	a0,0x9
ffffffffc0203e2e:	b6650513          	addi	a0,a0,-1178 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc0203e32:	e6cfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203e36 <dup_mmap>:
ffffffffc0203e36:	7139                	addi	sp,sp,-64
ffffffffc0203e38:	fc06                	sd	ra,56(sp)
ffffffffc0203e3a:	f822                	sd	s0,48(sp)
ffffffffc0203e3c:	f426                	sd	s1,40(sp)
ffffffffc0203e3e:	f04a                	sd	s2,32(sp)
ffffffffc0203e40:	ec4e                	sd	s3,24(sp)
ffffffffc0203e42:	e852                	sd	s4,16(sp)
ffffffffc0203e44:	e456                	sd	s5,8(sp)
ffffffffc0203e46:	c52d                	beqz	a0,ffffffffc0203eb0 <dup_mmap+0x7a>
ffffffffc0203e48:	892a                	mv	s2,a0
ffffffffc0203e4a:	84ae                	mv	s1,a1
ffffffffc0203e4c:	842e                	mv	s0,a1
ffffffffc0203e4e:	e595                	bnez	a1,ffffffffc0203e7a <dup_mmap+0x44>
ffffffffc0203e50:	a085                	j	ffffffffc0203eb0 <dup_mmap+0x7a>
ffffffffc0203e52:	854a                	mv	a0,s2
ffffffffc0203e54:	0155b423          	sd	s5,8(a1) # 200008 <_binary_bin_sfs_img_size+0x18ad08>
ffffffffc0203e58:	0145b823          	sd	s4,16(a1)
ffffffffc0203e5c:	0135ac23          	sw	s3,24(a1)
ffffffffc0203e60:	e05ff0ef          	jal	ra,ffffffffc0203c64 <insert_vma_struct>
ffffffffc0203e64:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_bin_swap_img_size-0x6d10>
ffffffffc0203e68:	fe843603          	ld	a2,-24(s0)
ffffffffc0203e6c:	6c8c                	ld	a1,24(s1)
ffffffffc0203e6e:	01893503          	ld	a0,24(s2)
ffffffffc0203e72:	4701                	li	a4,0
ffffffffc0203e74:	a4fff0ef          	jal	ra,ffffffffc02038c2 <copy_range>
ffffffffc0203e78:	e105                	bnez	a0,ffffffffc0203e98 <dup_mmap+0x62>
ffffffffc0203e7a:	6000                	ld	s0,0(s0)
ffffffffc0203e7c:	02848863          	beq	s1,s0,ffffffffc0203eac <dup_mmap+0x76>
ffffffffc0203e80:	03000513          	li	a0,48
ffffffffc0203e84:	fe843a83          	ld	s5,-24(s0)
ffffffffc0203e88:	ff043a03          	ld	s4,-16(s0)
ffffffffc0203e8c:	ff842983          	lw	s3,-8(s0)
ffffffffc0203e90:	8fefe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203e94:	85aa                	mv	a1,a0
ffffffffc0203e96:	fd55                	bnez	a0,ffffffffc0203e52 <dup_mmap+0x1c>
ffffffffc0203e98:	5571                	li	a0,-4
ffffffffc0203e9a:	70e2                	ld	ra,56(sp)
ffffffffc0203e9c:	7442                	ld	s0,48(sp)
ffffffffc0203e9e:	74a2                	ld	s1,40(sp)
ffffffffc0203ea0:	7902                	ld	s2,32(sp)
ffffffffc0203ea2:	69e2                	ld	s3,24(sp)
ffffffffc0203ea4:	6a42                	ld	s4,16(sp)
ffffffffc0203ea6:	6aa2                	ld	s5,8(sp)
ffffffffc0203ea8:	6121                	addi	sp,sp,64
ffffffffc0203eaa:	8082                	ret
ffffffffc0203eac:	4501                	li	a0,0
ffffffffc0203eae:	b7f5                	j	ffffffffc0203e9a <dup_mmap+0x64>
ffffffffc0203eb0:	00009697          	auipc	a3,0x9
ffffffffc0203eb4:	b7868693          	addi	a3,a3,-1160 # ffffffffc020ca28 <default_pmm_manager+0x8c8>
ffffffffc0203eb8:	00007617          	auipc	a2,0x7
ffffffffc0203ebc:	7c060613          	addi	a2,a2,1984 # ffffffffc020b678 <commands+0x210>
ffffffffc0203ec0:	0cf00593          	li	a1,207
ffffffffc0203ec4:	00009517          	auipc	a0,0x9
ffffffffc0203ec8:	acc50513          	addi	a0,a0,-1332 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc0203ecc:	dd2fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203ed0 <exit_mmap>:
ffffffffc0203ed0:	1101                	addi	sp,sp,-32
ffffffffc0203ed2:	ec06                	sd	ra,24(sp)
ffffffffc0203ed4:	e822                	sd	s0,16(sp)
ffffffffc0203ed6:	e426                	sd	s1,8(sp)
ffffffffc0203ed8:	e04a                	sd	s2,0(sp)
ffffffffc0203eda:	c531                	beqz	a0,ffffffffc0203f26 <exit_mmap+0x56>
ffffffffc0203edc:	591c                	lw	a5,48(a0)
ffffffffc0203ede:	84aa                	mv	s1,a0
ffffffffc0203ee0:	e3b9                	bnez	a5,ffffffffc0203f26 <exit_mmap+0x56>
ffffffffc0203ee2:	6500                	ld	s0,8(a0)
ffffffffc0203ee4:	01853903          	ld	s2,24(a0)
ffffffffc0203ee8:	02850663          	beq	a0,s0,ffffffffc0203f14 <exit_mmap+0x44>
ffffffffc0203eec:	ff043603          	ld	a2,-16(s0)
ffffffffc0203ef0:	fe843583          	ld	a1,-24(s0)
ffffffffc0203ef4:	854a                	mv	a0,s2
ffffffffc0203ef6:	e70fe0ef          	jal	ra,ffffffffc0202566 <unmap_range>
ffffffffc0203efa:	6400                	ld	s0,8(s0)
ffffffffc0203efc:	fe8498e3          	bne	s1,s0,ffffffffc0203eec <exit_mmap+0x1c>
ffffffffc0203f00:	6400                	ld	s0,8(s0)
ffffffffc0203f02:	00848c63          	beq	s1,s0,ffffffffc0203f1a <exit_mmap+0x4a>
ffffffffc0203f06:	ff043603          	ld	a2,-16(s0)
ffffffffc0203f0a:	fe843583          	ld	a1,-24(s0)
ffffffffc0203f0e:	854a                	mv	a0,s2
ffffffffc0203f10:	f9cfe0ef          	jal	ra,ffffffffc02026ac <exit_range>
ffffffffc0203f14:	6400                	ld	s0,8(s0)
ffffffffc0203f16:	fe8498e3          	bne	s1,s0,ffffffffc0203f06 <exit_mmap+0x36>
ffffffffc0203f1a:	60e2                	ld	ra,24(sp)
ffffffffc0203f1c:	6442                	ld	s0,16(sp)
ffffffffc0203f1e:	64a2                	ld	s1,8(sp)
ffffffffc0203f20:	6902                	ld	s2,0(sp)
ffffffffc0203f22:	6105                	addi	sp,sp,32
ffffffffc0203f24:	8082                	ret
ffffffffc0203f26:	00009697          	auipc	a3,0x9
ffffffffc0203f2a:	b2268693          	addi	a3,a3,-1246 # ffffffffc020ca48 <default_pmm_manager+0x8e8>
ffffffffc0203f2e:	00007617          	auipc	a2,0x7
ffffffffc0203f32:	74a60613          	addi	a2,a2,1866 # ffffffffc020b678 <commands+0x210>
ffffffffc0203f36:	0e800593          	li	a1,232
ffffffffc0203f3a:	00009517          	auipc	a0,0x9
ffffffffc0203f3e:	a5650513          	addi	a0,a0,-1450 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc0203f42:	d5cfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203f46 <vmm_init>:
ffffffffc0203f46:	7139                	addi	sp,sp,-64
ffffffffc0203f48:	05800513          	li	a0,88
ffffffffc0203f4c:	fc06                	sd	ra,56(sp)
ffffffffc0203f4e:	f822                	sd	s0,48(sp)
ffffffffc0203f50:	f426                	sd	s1,40(sp)
ffffffffc0203f52:	f04a                	sd	s2,32(sp)
ffffffffc0203f54:	ec4e                	sd	s3,24(sp)
ffffffffc0203f56:	e852                	sd	s4,16(sp)
ffffffffc0203f58:	e456                	sd	s5,8(sp)
ffffffffc0203f5a:	834fe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203f5e:	2e050963          	beqz	a0,ffffffffc0204250 <vmm_init+0x30a>
ffffffffc0203f62:	e508                	sd	a0,8(a0)
ffffffffc0203f64:	e108                	sd	a0,0(a0)
ffffffffc0203f66:	00053823          	sd	zero,16(a0)
ffffffffc0203f6a:	00053c23          	sd	zero,24(a0)
ffffffffc0203f6e:	02052023          	sw	zero,32(a0)
ffffffffc0203f72:	02053423          	sd	zero,40(a0)
ffffffffc0203f76:	02052823          	sw	zero,48(a0)
ffffffffc0203f7a:	84aa                	mv	s1,a0
ffffffffc0203f7c:	4585                	li	a1,1
ffffffffc0203f7e:	03850513          	addi	a0,a0,56
ffffffffc0203f82:	5b6000ef          	jal	ra,ffffffffc0204538 <sem_init>
ffffffffc0203f86:	03200413          	li	s0,50
ffffffffc0203f8a:	a811                	j	ffffffffc0203f9e <vmm_init+0x58>
ffffffffc0203f8c:	e500                	sd	s0,8(a0)
ffffffffc0203f8e:	e91c                	sd	a5,16(a0)
ffffffffc0203f90:	00052c23          	sw	zero,24(a0)
ffffffffc0203f94:	146d                	addi	s0,s0,-5
ffffffffc0203f96:	8526                	mv	a0,s1
ffffffffc0203f98:	ccdff0ef          	jal	ra,ffffffffc0203c64 <insert_vma_struct>
ffffffffc0203f9c:	c80d                	beqz	s0,ffffffffc0203fce <vmm_init+0x88>
ffffffffc0203f9e:	03000513          	li	a0,48
ffffffffc0203fa2:	fedfd0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203fa6:	85aa                	mv	a1,a0
ffffffffc0203fa8:	00240793          	addi	a5,s0,2
ffffffffc0203fac:	f165                	bnez	a0,ffffffffc0203f8c <vmm_init+0x46>
ffffffffc0203fae:	00009697          	auipc	a3,0x9
ffffffffc0203fb2:	c3268693          	addi	a3,a3,-974 # ffffffffc020cbe0 <default_pmm_manager+0xa80>
ffffffffc0203fb6:	00007617          	auipc	a2,0x7
ffffffffc0203fba:	6c260613          	addi	a2,a2,1730 # ffffffffc020b678 <commands+0x210>
ffffffffc0203fbe:	12c00593          	li	a1,300
ffffffffc0203fc2:	00009517          	auipc	a0,0x9
ffffffffc0203fc6:	9ce50513          	addi	a0,a0,-1586 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc0203fca:	cd4fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203fce:	03700413          	li	s0,55
ffffffffc0203fd2:	1f900913          	li	s2,505
ffffffffc0203fd6:	a819                	j	ffffffffc0203fec <vmm_init+0xa6>
ffffffffc0203fd8:	e500                	sd	s0,8(a0)
ffffffffc0203fda:	e91c                	sd	a5,16(a0)
ffffffffc0203fdc:	00052c23          	sw	zero,24(a0)
ffffffffc0203fe0:	0415                	addi	s0,s0,5
ffffffffc0203fe2:	8526                	mv	a0,s1
ffffffffc0203fe4:	c81ff0ef          	jal	ra,ffffffffc0203c64 <insert_vma_struct>
ffffffffc0203fe8:	03240a63          	beq	s0,s2,ffffffffc020401c <vmm_init+0xd6>
ffffffffc0203fec:	03000513          	li	a0,48
ffffffffc0203ff0:	f9ffd0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203ff4:	85aa                	mv	a1,a0
ffffffffc0203ff6:	00240793          	addi	a5,s0,2
ffffffffc0203ffa:	fd79                	bnez	a0,ffffffffc0203fd8 <vmm_init+0x92>
ffffffffc0203ffc:	00009697          	auipc	a3,0x9
ffffffffc0204000:	be468693          	addi	a3,a3,-1052 # ffffffffc020cbe0 <default_pmm_manager+0xa80>
ffffffffc0204004:	00007617          	auipc	a2,0x7
ffffffffc0204008:	67460613          	addi	a2,a2,1652 # ffffffffc020b678 <commands+0x210>
ffffffffc020400c:	13300593          	li	a1,307
ffffffffc0204010:	00009517          	auipc	a0,0x9
ffffffffc0204014:	98050513          	addi	a0,a0,-1664 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc0204018:	c86fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020401c:	649c                	ld	a5,8(s1)
ffffffffc020401e:	471d                	li	a4,7
ffffffffc0204020:	1fb00593          	li	a1,507
ffffffffc0204024:	16f48663          	beq	s1,a5,ffffffffc0204190 <vmm_init+0x24a>
ffffffffc0204028:	fe87b603          	ld	a2,-24(a5) # ffffffffffffefe8 <end+0x3fd686d8>
ffffffffc020402c:	ffe70693          	addi	a3,a4,-2
ffffffffc0204030:	10d61063          	bne	a2,a3,ffffffffc0204130 <vmm_init+0x1ea>
ffffffffc0204034:	ff07b683          	ld	a3,-16(a5)
ffffffffc0204038:	0ed71c63          	bne	a4,a3,ffffffffc0204130 <vmm_init+0x1ea>
ffffffffc020403c:	0715                	addi	a4,a4,5
ffffffffc020403e:	679c                	ld	a5,8(a5)
ffffffffc0204040:	feb712e3          	bne	a4,a1,ffffffffc0204024 <vmm_init+0xde>
ffffffffc0204044:	4a1d                	li	s4,7
ffffffffc0204046:	4415                	li	s0,5
ffffffffc0204048:	1f900a93          	li	s5,505
ffffffffc020404c:	85a2                	mv	a1,s0
ffffffffc020404e:	8526                	mv	a0,s1
ffffffffc0204050:	bd5ff0ef          	jal	ra,ffffffffc0203c24 <find_vma>
ffffffffc0204054:	892a                	mv	s2,a0
ffffffffc0204056:	16050d63          	beqz	a0,ffffffffc02041d0 <vmm_init+0x28a>
ffffffffc020405a:	00140593          	addi	a1,s0,1
ffffffffc020405e:	8526                	mv	a0,s1
ffffffffc0204060:	bc5ff0ef          	jal	ra,ffffffffc0203c24 <find_vma>
ffffffffc0204064:	89aa                	mv	s3,a0
ffffffffc0204066:	14050563          	beqz	a0,ffffffffc02041b0 <vmm_init+0x26a>
ffffffffc020406a:	85d2                	mv	a1,s4
ffffffffc020406c:	8526                	mv	a0,s1
ffffffffc020406e:	bb7ff0ef          	jal	ra,ffffffffc0203c24 <find_vma>
ffffffffc0204072:	16051f63          	bnez	a0,ffffffffc02041f0 <vmm_init+0x2aa>
ffffffffc0204076:	00340593          	addi	a1,s0,3
ffffffffc020407a:	8526                	mv	a0,s1
ffffffffc020407c:	ba9ff0ef          	jal	ra,ffffffffc0203c24 <find_vma>
ffffffffc0204080:	1a051863          	bnez	a0,ffffffffc0204230 <vmm_init+0x2ea>
ffffffffc0204084:	00440593          	addi	a1,s0,4
ffffffffc0204088:	8526                	mv	a0,s1
ffffffffc020408a:	b9bff0ef          	jal	ra,ffffffffc0203c24 <find_vma>
ffffffffc020408e:	18051163          	bnez	a0,ffffffffc0204210 <vmm_init+0x2ca>
ffffffffc0204092:	00893783          	ld	a5,8(s2)
ffffffffc0204096:	0a879d63          	bne	a5,s0,ffffffffc0204150 <vmm_init+0x20a>
ffffffffc020409a:	01093783          	ld	a5,16(s2)
ffffffffc020409e:	0b479963          	bne	a5,s4,ffffffffc0204150 <vmm_init+0x20a>
ffffffffc02040a2:	0089b783          	ld	a5,8(s3)
ffffffffc02040a6:	0c879563          	bne	a5,s0,ffffffffc0204170 <vmm_init+0x22a>
ffffffffc02040aa:	0109b783          	ld	a5,16(s3)
ffffffffc02040ae:	0d479163          	bne	a5,s4,ffffffffc0204170 <vmm_init+0x22a>
ffffffffc02040b2:	0415                	addi	s0,s0,5
ffffffffc02040b4:	0a15                	addi	s4,s4,5
ffffffffc02040b6:	f9541be3          	bne	s0,s5,ffffffffc020404c <vmm_init+0x106>
ffffffffc02040ba:	4411                	li	s0,4
ffffffffc02040bc:	597d                	li	s2,-1
ffffffffc02040be:	85a2                	mv	a1,s0
ffffffffc02040c0:	8526                	mv	a0,s1
ffffffffc02040c2:	b63ff0ef          	jal	ra,ffffffffc0203c24 <find_vma>
ffffffffc02040c6:	0004059b          	sext.w	a1,s0
ffffffffc02040ca:	c90d                	beqz	a0,ffffffffc02040fc <vmm_init+0x1b6>
ffffffffc02040cc:	6914                	ld	a3,16(a0)
ffffffffc02040ce:	6510                	ld	a2,8(a0)
ffffffffc02040d0:	00009517          	auipc	a0,0x9
ffffffffc02040d4:	a9850513          	addi	a0,a0,-1384 # ffffffffc020cb68 <default_pmm_manager+0xa08>
ffffffffc02040d8:	8cefc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02040dc:	00009697          	auipc	a3,0x9
ffffffffc02040e0:	ab468693          	addi	a3,a3,-1356 # ffffffffc020cb90 <default_pmm_manager+0xa30>
ffffffffc02040e4:	00007617          	auipc	a2,0x7
ffffffffc02040e8:	59460613          	addi	a2,a2,1428 # ffffffffc020b678 <commands+0x210>
ffffffffc02040ec:	15900593          	li	a1,345
ffffffffc02040f0:	00009517          	auipc	a0,0x9
ffffffffc02040f4:	8a050513          	addi	a0,a0,-1888 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc02040f8:	ba6fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02040fc:	147d                	addi	s0,s0,-1
ffffffffc02040fe:	fd2410e3          	bne	s0,s2,ffffffffc02040be <vmm_init+0x178>
ffffffffc0204102:	8526                	mv	a0,s1
ffffffffc0204104:	c31ff0ef          	jal	ra,ffffffffc0203d34 <mm_destroy>
ffffffffc0204108:	00009517          	auipc	a0,0x9
ffffffffc020410c:	aa050513          	addi	a0,a0,-1376 # ffffffffc020cba8 <default_pmm_manager+0xa48>
ffffffffc0204110:	896fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0204114:	7442                	ld	s0,48(sp)
ffffffffc0204116:	70e2                	ld	ra,56(sp)
ffffffffc0204118:	74a2                	ld	s1,40(sp)
ffffffffc020411a:	7902                	ld	s2,32(sp)
ffffffffc020411c:	69e2                	ld	s3,24(sp)
ffffffffc020411e:	6a42                	ld	s4,16(sp)
ffffffffc0204120:	6aa2                	ld	s5,8(sp)
ffffffffc0204122:	00009517          	auipc	a0,0x9
ffffffffc0204126:	aa650513          	addi	a0,a0,-1370 # ffffffffc020cbc8 <default_pmm_manager+0xa68>
ffffffffc020412a:	6121                	addi	sp,sp,64
ffffffffc020412c:	87afc06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0204130:	00009697          	auipc	a3,0x9
ffffffffc0204134:	95068693          	addi	a3,a3,-1712 # ffffffffc020ca80 <default_pmm_manager+0x920>
ffffffffc0204138:	00007617          	auipc	a2,0x7
ffffffffc020413c:	54060613          	addi	a2,a2,1344 # ffffffffc020b678 <commands+0x210>
ffffffffc0204140:	13d00593          	li	a1,317
ffffffffc0204144:	00009517          	auipc	a0,0x9
ffffffffc0204148:	84c50513          	addi	a0,a0,-1972 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc020414c:	b52fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204150:	00009697          	auipc	a3,0x9
ffffffffc0204154:	9b868693          	addi	a3,a3,-1608 # ffffffffc020cb08 <default_pmm_manager+0x9a8>
ffffffffc0204158:	00007617          	auipc	a2,0x7
ffffffffc020415c:	52060613          	addi	a2,a2,1312 # ffffffffc020b678 <commands+0x210>
ffffffffc0204160:	14e00593          	li	a1,334
ffffffffc0204164:	00009517          	auipc	a0,0x9
ffffffffc0204168:	82c50513          	addi	a0,a0,-2004 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc020416c:	b32fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204170:	00009697          	auipc	a3,0x9
ffffffffc0204174:	9c868693          	addi	a3,a3,-1592 # ffffffffc020cb38 <default_pmm_manager+0x9d8>
ffffffffc0204178:	00007617          	auipc	a2,0x7
ffffffffc020417c:	50060613          	addi	a2,a2,1280 # ffffffffc020b678 <commands+0x210>
ffffffffc0204180:	14f00593          	li	a1,335
ffffffffc0204184:	00009517          	auipc	a0,0x9
ffffffffc0204188:	80c50513          	addi	a0,a0,-2036 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc020418c:	b12fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204190:	00009697          	auipc	a3,0x9
ffffffffc0204194:	8d868693          	addi	a3,a3,-1832 # ffffffffc020ca68 <default_pmm_manager+0x908>
ffffffffc0204198:	00007617          	auipc	a2,0x7
ffffffffc020419c:	4e060613          	addi	a2,a2,1248 # ffffffffc020b678 <commands+0x210>
ffffffffc02041a0:	13b00593          	li	a1,315
ffffffffc02041a4:	00008517          	auipc	a0,0x8
ffffffffc02041a8:	7ec50513          	addi	a0,a0,2028 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc02041ac:	af2fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041b0:	00009697          	auipc	a3,0x9
ffffffffc02041b4:	91868693          	addi	a3,a3,-1768 # ffffffffc020cac8 <default_pmm_manager+0x968>
ffffffffc02041b8:	00007617          	auipc	a2,0x7
ffffffffc02041bc:	4c060613          	addi	a2,a2,1216 # ffffffffc020b678 <commands+0x210>
ffffffffc02041c0:	14600593          	li	a1,326
ffffffffc02041c4:	00008517          	auipc	a0,0x8
ffffffffc02041c8:	7cc50513          	addi	a0,a0,1996 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc02041cc:	ad2fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041d0:	00009697          	auipc	a3,0x9
ffffffffc02041d4:	8e868693          	addi	a3,a3,-1816 # ffffffffc020cab8 <default_pmm_manager+0x958>
ffffffffc02041d8:	00007617          	auipc	a2,0x7
ffffffffc02041dc:	4a060613          	addi	a2,a2,1184 # ffffffffc020b678 <commands+0x210>
ffffffffc02041e0:	14400593          	li	a1,324
ffffffffc02041e4:	00008517          	auipc	a0,0x8
ffffffffc02041e8:	7ac50513          	addi	a0,a0,1964 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc02041ec:	ab2fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041f0:	00009697          	auipc	a3,0x9
ffffffffc02041f4:	8e868693          	addi	a3,a3,-1816 # ffffffffc020cad8 <default_pmm_manager+0x978>
ffffffffc02041f8:	00007617          	auipc	a2,0x7
ffffffffc02041fc:	48060613          	addi	a2,a2,1152 # ffffffffc020b678 <commands+0x210>
ffffffffc0204200:	14800593          	li	a1,328
ffffffffc0204204:	00008517          	auipc	a0,0x8
ffffffffc0204208:	78c50513          	addi	a0,a0,1932 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc020420c:	a92fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204210:	00009697          	auipc	a3,0x9
ffffffffc0204214:	8e868693          	addi	a3,a3,-1816 # ffffffffc020caf8 <default_pmm_manager+0x998>
ffffffffc0204218:	00007617          	auipc	a2,0x7
ffffffffc020421c:	46060613          	addi	a2,a2,1120 # ffffffffc020b678 <commands+0x210>
ffffffffc0204220:	14c00593          	li	a1,332
ffffffffc0204224:	00008517          	auipc	a0,0x8
ffffffffc0204228:	76c50513          	addi	a0,a0,1900 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc020422c:	a72fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204230:	00009697          	auipc	a3,0x9
ffffffffc0204234:	8b868693          	addi	a3,a3,-1864 # ffffffffc020cae8 <default_pmm_manager+0x988>
ffffffffc0204238:	00007617          	auipc	a2,0x7
ffffffffc020423c:	44060613          	addi	a2,a2,1088 # ffffffffc020b678 <commands+0x210>
ffffffffc0204240:	14a00593          	li	a1,330
ffffffffc0204244:	00008517          	auipc	a0,0x8
ffffffffc0204248:	74c50513          	addi	a0,a0,1868 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc020424c:	a52fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204250:	00008697          	auipc	a3,0x8
ffffffffc0204254:	7c868693          	addi	a3,a3,1992 # ffffffffc020ca18 <default_pmm_manager+0x8b8>
ffffffffc0204258:	00007617          	auipc	a2,0x7
ffffffffc020425c:	42060613          	addi	a2,a2,1056 # ffffffffc020b678 <commands+0x210>
ffffffffc0204260:	12400593          	li	a1,292
ffffffffc0204264:	00008517          	auipc	a0,0x8
ffffffffc0204268:	72c50513          	addi	a0,a0,1836 # ffffffffc020c990 <default_pmm_manager+0x830>
ffffffffc020426c:	a32fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204270 <user_mem_check>:
ffffffffc0204270:	7179                	addi	sp,sp,-48
ffffffffc0204272:	f022                	sd	s0,32(sp)
ffffffffc0204274:	f406                	sd	ra,40(sp)
ffffffffc0204276:	ec26                	sd	s1,24(sp)
ffffffffc0204278:	e84a                	sd	s2,16(sp)
ffffffffc020427a:	e44e                	sd	s3,8(sp)
ffffffffc020427c:	e052                	sd	s4,0(sp)
ffffffffc020427e:	842e                	mv	s0,a1
ffffffffc0204280:	c135                	beqz	a0,ffffffffc02042e4 <user_mem_check+0x74>
ffffffffc0204282:	002007b7          	lui	a5,0x200
ffffffffc0204286:	04f5e663          	bltu	a1,a5,ffffffffc02042d2 <user_mem_check+0x62>
ffffffffc020428a:	00c584b3          	add	s1,a1,a2
ffffffffc020428e:	0495f263          	bgeu	a1,s1,ffffffffc02042d2 <user_mem_check+0x62>
ffffffffc0204292:	4785                	li	a5,1
ffffffffc0204294:	07fe                	slli	a5,a5,0x1f
ffffffffc0204296:	0297ee63          	bltu	a5,s1,ffffffffc02042d2 <user_mem_check+0x62>
ffffffffc020429a:	892a                	mv	s2,a0
ffffffffc020429c:	89b6                	mv	s3,a3
ffffffffc020429e:	6a05                	lui	s4,0x1
ffffffffc02042a0:	a821                	j	ffffffffc02042b8 <user_mem_check+0x48>
ffffffffc02042a2:	0027f693          	andi	a3,a5,2
ffffffffc02042a6:	9752                	add	a4,a4,s4
ffffffffc02042a8:	8ba1                	andi	a5,a5,8
ffffffffc02042aa:	c685                	beqz	a3,ffffffffc02042d2 <user_mem_check+0x62>
ffffffffc02042ac:	c399                	beqz	a5,ffffffffc02042b2 <user_mem_check+0x42>
ffffffffc02042ae:	02e46263          	bltu	s0,a4,ffffffffc02042d2 <user_mem_check+0x62>
ffffffffc02042b2:	6900                	ld	s0,16(a0)
ffffffffc02042b4:	04947663          	bgeu	s0,s1,ffffffffc0204300 <user_mem_check+0x90>
ffffffffc02042b8:	85a2                	mv	a1,s0
ffffffffc02042ba:	854a                	mv	a0,s2
ffffffffc02042bc:	969ff0ef          	jal	ra,ffffffffc0203c24 <find_vma>
ffffffffc02042c0:	c909                	beqz	a0,ffffffffc02042d2 <user_mem_check+0x62>
ffffffffc02042c2:	6518                	ld	a4,8(a0)
ffffffffc02042c4:	00e46763          	bltu	s0,a4,ffffffffc02042d2 <user_mem_check+0x62>
ffffffffc02042c8:	4d1c                	lw	a5,24(a0)
ffffffffc02042ca:	fc099ce3          	bnez	s3,ffffffffc02042a2 <user_mem_check+0x32>
ffffffffc02042ce:	8b85                	andi	a5,a5,1
ffffffffc02042d0:	f3ed                	bnez	a5,ffffffffc02042b2 <user_mem_check+0x42>
ffffffffc02042d2:	4501                	li	a0,0
ffffffffc02042d4:	70a2                	ld	ra,40(sp)
ffffffffc02042d6:	7402                	ld	s0,32(sp)
ffffffffc02042d8:	64e2                	ld	s1,24(sp)
ffffffffc02042da:	6942                	ld	s2,16(sp)
ffffffffc02042dc:	69a2                	ld	s3,8(sp)
ffffffffc02042de:	6a02                	ld	s4,0(sp)
ffffffffc02042e0:	6145                	addi	sp,sp,48
ffffffffc02042e2:	8082                	ret
ffffffffc02042e4:	c02007b7          	lui	a5,0xc0200
ffffffffc02042e8:	4501                	li	a0,0
ffffffffc02042ea:	fef5e5e3          	bltu	a1,a5,ffffffffc02042d4 <user_mem_check+0x64>
ffffffffc02042ee:	962e                	add	a2,a2,a1
ffffffffc02042f0:	fec5f2e3          	bgeu	a1,a2,ffffffffc02042d4 <user_mem_check+0x64>
ffffffffc02042f4:	c8000537          	lui	a0,0xc8000
ffffffffc02042f8:	0505                	addi	a0,a0,1
ffffffffc02042fa:	00a63533          	sltu	a0,a2,a0
ffffffffc02042fe:	bfd9                	j	ffffffffc02042d4 <user_mem_check+0x64>
ffffffffc0204300:	4505                	li	a0,1
ffffffffc0204302:	bfc9                	j	ffffffffc02042d4 <user_mem_check+0x64>

ffffffffc0204304 <copy_from_user>:
ffffffffc0204304:	1101                	addi	sp,sp,-32
ffffffffc0204306:	e822                	sd	s0,16(sp)
ffffffffc0204308:	e426                	sd	s1,8(sp)
ffffffffc020430a:	8432                	mv	s0,a2
ffffffffc020430c:	84b6                	mv	s1,a3
ffffffffc020430e:	e04a                	sd	s2,0(sp)
ffffffffc0204310:	86ba                	mv	a3,a4
ffffffffc0204312:	892e                	mv	s2,a1
ffffffffc0204314:	8626                	mv	a2,s1
ffffffffc0204316:	85a2                	mv	a1,s0
ffffffffc0204318:	ec06                	sd	ra,24(sp)
ffffffffc020431a:	f57ff0ef          	jal	ra,ffffffffc0204270 <user_mem_check>
ffffffffc020431e:	c519                	beqz	a0,ffffffffc020432c <copy_from_user+0x28>
ffffffffc0204320:	8626                	mv	a2,s1
ffffffffc0204322:	85a2                	mv	a1,s0
ffffffffc0204324:	854a                	mv	a0,s2
ffffffffc0204326:	6c1060ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc020432a:	4505                	li	a0,1
ffffffffc020432c:	60e2                	ld	ra,24(sp)
ffffffffc020432e:	6442                	ld	s0,16(sp)
ffffffffc0204330:	64a2                	ld	s1,8(sp)
ffffffffc0204332:	6902                	ld	s2,0(sp)
ffffffffc0204334:	6105                	addi	sp,sp,32
ffffffffc0204336:	8082                	ret

ffffffffc0204338 <copy_to_user>:
ffffffffc0204338:	1101                	addi	sp,sp,-32
ffffffffc020433a:	e822                	sd	s0,16(sp)
ffffffffc020433c:	8436                	mv	s0,a3
ffffffffc020433e:	e04a                	sd	s2,0(sp)
ffffffffc0204340:	4685                	li	a3,1
ffffffffc0204342:	8932                	mv	s2,a2
ffffffffc0204344:	8622                	mv	a2,s0
ffffffffc0204346:	e426                	sd	s1,8(sp)
ffffffffc0204348:	ec06                	sd	ra,24(sp)
ffffffffc020434a:	84ae                	mv	s1,a1
ffffffffc020434c:	f25ff0ef          	jal	ra,ffffffffc0204270 <user_mem_check>
ffffffffc0204350:	c519                	beqz	a0,ffffffffc020435e <copy_to_user+0x26>
ffffffffc0204352:	8622                	mv	a2,s0
ffffffffc0204354:	85ca                	mv	a1,s2
ffffffffc0204356:	8526                	mv	a0,s1
ffffffffc0204358:	68f060ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc020435c:	4505                	li	a0,1
ffffffffc020435e:	60e2                	ld	ra,24(sp)
ffffffffc0204360:	6442                	ld	s0,16(sp)
ffffffffc0204362:	64a2                	ld	s1,8(sp)
ffffffffc0204364:	6902                	ld	s2,0(sp)
ffffffffc0204366:	6105                	addi	sp,sp,32
ffffffffc0204368:	8082                	ret

ffffffffc020436a <copy_string>:
ffffffffc020436a:	7139                	addi	sp,sp,-64
ffffffffc020436c:	ec4e                	sd	s3,24(sp)
ffffffffc020436e:	6985                	lui	s3,0x1
ffffffffc0204370:	99b2                	add	s3,s3,a2
ffffffffc0204372:	77fd                	lui	a5,0xfffff
ffffffffc0204374:	00f9f9b3          	and	s3,s3,a5
ffffffffc0204378:	f426                	sd	s1,40(sp)
ffffffffc020437a:	f04a                	sd	s2,32(sp)
ffffffffc020437c:	e852                	sd	s4,16(sp)
ffffffffc020437e:	e456                	sd	s5,8(sp)
ffffffffc0204380:	fc06                	sd	ra,56(sp)
ffffffffc0204382:	f822                	sd	s0,48(sp)
ffffffffc0204384:	84b2                	mv	s1,a2
ffffffffc0204386:	8aaa                	mv	s5,a0
ffffffffc0204388:	8a2e                	mv	s4,a1
ffffffffc020438a:	8936                	mv	s2,a3
ffffffffc020438c:	40c989b3          	sub	s3,s3,a2
ffffffffc0204390:	a015                	j	ffffffffc02043b4 <copy_string+0x4a>
ffffffffc0204392:	57b060ef          	jal	ra,ffffffffc020b10c <strnlen>
ffffffffc0204396:	87aa                	mv	a5,a0
ffffffffc0204398:	85a6                	mv	a1,s1
ffffffffc020439a:	8552                	mv	a0,s4
ffffffffc020439c:	8622                	mv	a2,s0
ffffffffc020439e:	0487e363          	bltu	a5,s0,ffffffffc02043e4 <copy_string+0x7a>
ffffffffc02043a2:	0329f763          	bgeu	s3,s2,ffffffffc02043d0 <copy_string+0x66>
ffffffffc02043a6:	641060ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc02043aa:	9a22                	add	s4,s4,s0
ffffffffc02043ac:	94a2                	add	s1,s1,s0
ffffffffc02043ae:	40890933          	sub	s2,s2,s0
ffffffffc02043b2:	6985                	lui	s3,0x1
ffffffffc02043b4:	4681                	li	a3,0
ffffffffc02043b6:	85a6                	mv	a1,s1
ffffffffc02043b8:	8556                	mv	a0,s5
ffffffffc02043ba:	844a                	mv	s0,s2
ffffffffc02043bc:	0129f363          	bgeu	s3,s2,ffffffffc02043c2 <copy_string+0x58>
ffffffffc02043c0:	844e                	mv	s0,s3
ffffffffc02043c2:	8622                	mv	a2,s0
ffffffffc02043c4:	eadff0ef          	jal	ra,ffffffffc0204270 <user_mem_check>
ffffffffc02043c8:	87aa                	mv	a5,a0
ffffffffc02043ca:	85a2                	mv	a1,s0
ffffffffc02043cc:	8526                	mv	a0,s1
ffffffffc02043ce:	f3f1                	bnez	a5,ffffffffc0204392 <copy_string+0x28>
ffffffffc02043d0:	4501                	li	a0,0
ffffffffc02043d2:	70e2                	ld	ra,56(sp)
ffffffffc02043d4:	7442                	ld	s0,48(sp)
ffffffffc02043d6:	74a2                	ld	s1,40(sp)
ffffffffc02043d8:	7902                	ld	s2,32(sp)
ffffffffc02043da:	69e2                	ld	s3,24(sp)
ffffffffc02043dc:	6a42                	ld	s4,16(sp)
ffffffffc02043de:	6aa2                	ld	s5,8(sp)
ffffffffc02043e0:	6121                	addi	sp,sp,64
ffffffffc02043e2:	8082                	ret
ffffffffc02043e4:	00178613          	addi	a2,a5,1 # fffffffffffff001 <end+0x3fd686f1>
ffffffffc02043e8:	5ff060ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc02043ec:	4505                	li	a0,1
ffffffffc02043ee:	b7d5                	j	ffffffffc02043d2 <copy_string+0x68>

ffffffffc02043f0 <__down.constprop.0>:
ffffffffc02043f0:	715d                	addi	sp,sp,-80
ffffffffc02043f2:	e0a2                	sd	s0,64(sp)
ffffffffc02043f4:	e486                	sd	ra,72(sp)
ffffffffc02043f6:	fc26                	sd	s1,56(sp)
ffffffffc02043f8:	842a                	mv	s0,a0
ffffffffc02043fa:	100027f3          	csrr	a5,sstatus
ffffffffc02043fe:	8b89                	andi	a5,a5,2
ffffffffc0204400:	ebb1                	bnez	a5,ffffffffc0204454 <__down.constprop.0+0x64>
ffffffffc0204402:	411c                	lw	a5,0(a0)
ffffffffc0204404:	00f05a63          	blez	a5,ffffffffc0204418 <__down.constprop.0+0x28>
ffffffffc0204408:	37fd                	addiw	a5,a5,-1
ffffffffc020440a:	c11c                	sw	a5,0(a0)
ffffffffc020440c:	4501                	li	a0,0
ffffffffc020440e:	60a6                	ld	ra,72(sp)
ffffffffc0204410:	6406                	ld	s0,64(sp)
ffffffffc0204412:	74e2                	ld	s1,56(sp)
ffffffffc0204414:	6161                	addi	sp,sp,80
ffffffffc0204416:	8082                	ret
ffffffffc0204418:	00850413          	addi	s0,a0,8 # ffffffffc8000008 <end+0x7d696f8>
ffffffffc020441c:	0024                	addi	s1,sp,8
ffffffffc020441e:	10000613          	li	a2,256
ffffffffc0204422:	85a6                	mv	a1,s1
ffffffffc0204424:	8522                	mv	a0,s0
ffffffffc0204426:	2d8000ef          	jal	ra,ffffffffc02046fe <wait_current_set>
ffffffffc020442a:	52f020ef          	jal	ra,ffffffffc0207158 <schedule>
ffffffffc020442e:	100027f3          	csrr	a5,sstatus
ffffffffc0204432:	8b89                	andi	a5,a5,2
ffffffffc0204434:	efb9                	bnez	a5,ffffffffc0204492 <__down.constprop.0+0xa2>
ffffffffc0204436:	8526                	mv	a0,s1
ffffffffc0204438:	19c000ef          	jal	ra,ffffffffc02045d4 <wait_in_queue>
ffffffffc020443c:	e531                	bnez	a0,ffffffffc0204488 <__down.constprop.0+0x98>
ffffffffc020443e:	4542                	lw	a0,16(sp)
ffffffffc0204440:	10000793          	li	a5,256
ffffffffc0204444:	fcf515e3          	bne	a0,a5,ffffffffc020440e <__down.constprop.0+0x1e>
ffffffffc0204448:	60a6                	ld	ra,72(sp)
ffffffffc020444a:	6406                	ld	s0,64(sp)
ffffffffc020444c:	74e2                	ld	s1,56(sp)
ffffffffc020444e:	4501                	li	a0,0
ffffffffc0204450:	6161                	addi	sp,sp,80
ffffffffc0204452:	8082                	ret
ffffffffc0204454:	81ffc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0204458:	401c                	lw	a5,0(s0)
ffffffffc020445a:	00f05c63          	blez	a5,ffffffffc0204472 <__down.constprop.0+0x82>
ffffffffc020445e:	37fd                	addiw	a5,a5,-1
ffffffffc0204460:	c01c                	sw	a5,0(s0)
ffffffffc0204462:	80bfc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0204466:	60a6                	ld	ra,72(sp)
ffffffffc0204468:	6406                	ld	s0,64(sp)
ffffffffc020446a:	74e2                	ld	s1,56(sp)
ffffffffc020446c:	4501                	li	a0,0
ffffffffc020446e:	6161                	addi	sp,sp,80
ffffffffc0204470:	8082                	ret
ffffffffc0204472:	0421                	addi	s0,s0,8
ffffffffc0204474:	0024                	addi	s1,sp,8
ffffffffc0204476:	10000613          	li	a2,256
ffffffffc020447a:	85a6                	mv	a1,s1
ffffffffc020447c:	8522                	mv	a0,s0
ffffffffc020447e:	280000ef          	jal	ra,ffffffffc02046fe <wait_current_set>
ffffffffc0204482:	feafc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0204486:	b755                	j	ffffffffc020442a <__down.constprop.0+0x3a>
ffffffffc0204488:	85a6                	mv	a1,s1
ffffffffc020448a:	8522                	mv	a0,s0
ffffffffc020448c:	0ee000ef          	jal	ra,ffffffffc020457a <wait_queue_del>
ffffffffc0204490:	b77d                	j	ffffffffc020443e <__down.constprop.0+0x4e>
ffffffffc0204492:	fe0fc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0204496:	8526                	mv	a0,s1
ffffffffc0204498:	13c000ef          	jal	ra,ffffffffc02045d4 <wait_in_queue>
ffffffffc020449c:	e501                	bnez	a0,ffffffffc02044a4 <__down.constprop.0+0xb4>
ffffffffc020449e:	fcefc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02044a2:	bf71                	j	ffffffffc020443e <__down.constprop.0+0x4e>
ffffffffc02044a4:	85a6                	mv	a1,s1
ffffffffc02044a6:	8522                	mv	a0,s0
ffffffffc02044a8:	0d2000ef          	jal	ra,ffffffffc020457a <wait_queue_del>
ffffffffc02044ac:	bfcd                	j	ffffffffc020449e <__down.constprop.0+0xae>

ffffffffc02044ae <__up.constprop.0>:
ffffffffc02044ae:	1101                	addi	sp,sp,-32
ffffffffc02044b0:	e822                	sd	s0,16(sp)
ffffffffc02044b2:	ec06                	sd	ra,24(sp)
ffffffffc02044b4:	e426                	sd	s1,8(sp)
ffffffffc02044b6:	e04a                	sd	s2,0(sp)
ffffffffc02044b8:	842a                	mv	s0,a0
ffffffffc02044ba:	100027f3          	csrr	a5,sstatus
ffffffffc02044be:	8b89                	andi	a5,a5,2
ffffffffc02044c0:	4901                	li	s2,0
ffffffffc02044c2:	eba1                	bnez	a5,ffffffffc0204512 <__up.constprop.0+0x64>
ffffffffc02044c4:	00840493          	addi	s1,s0,8
ffffffffc02044c8:	8526                	mv	a0,s1
ffffffffc02044ca:	0ee000ef          	jal	ra,ffffffffc02045b8 <wait_queue_first>
ffffffffc02044ce:	85aa                	mv	a1,a0
ffffffffc02044d0:	cd0d                	beqz	a0,ffffffffc020450a <__up.constprop.0+0x5c>
ffffffffc02044d2:	6118                	ld	a4,0(a0)
ffffffffc02044d4:	10000793          	li	a5,256
ffffffffc02044d8:	0ec72703          	lw	a4,236(a4)
ffffffffc02044dc:	02f71f63          	bne	a4,a5,ffffffffc020451a <__up.constprop.0+0x6c>
ffffffffc02044e0:	4685                	li	a3,1
ffffffffc02044e2:	10000613          	li	a2,256
ffffffffc02044e6:	8526                	mv	a0,s1
ffffffffc02044e8:	0fa000ef          	jal	ra,ffffffffc02045e2 <wakeup_wait>
ffffffffc02044ec:	00091863          	bnez	s2,ffffffffc02044fc <__up.constprop.0+0x4e>
ffffffffc02044f0:	60e2                	ld	ra,24(sp)
ffffffffc02044f2:	6442                	ld	s0,16(sp)
ffffffffc02044f4:	64a2                	ld	s1,8(sp)
ffffffffc02044f6:	6902                	ld	s2,0(sp)
ffffffffc02044f8:	6105                	addi	sp,sp,32
ffffffffc02044fa:	8082                	ret
ffffffffc02044fc:	6442                	ld	s0,16(sp)
ffffffffc02044fe:	60e2                	ld	ra,24(sp)
ffffffffc0204500:	64a2                	ld	s1,8(sp)
ffffffffc0204502:	6902                	ld	s2,0(sp)
ffffffffc0204504:	6105                	addi	sp,sp,32
ffffffffc0204506:	f66fc06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc020450a:	401c                	lw	a5,0(s0)
ffffffffc020450c:	2785                	addiw	a5,a5,1
ffffffffc020450e:	c01c                	sw	a5,0(s0)
ffffffffc0204510:	bff1                	j	ffffffffc02044ec <__up.constprop.0+0x3e>
ffffffffc0204512:	f60fc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0204516:	4905                	li	s2,1
ffffffffc0204518:	b775                	j	ffffffffc02044c4 <__up.constprop.0+0x16>
ffffffffc020451a:	00008697          	auipc	a3,0x8
ffffffffc020451e:	6d668693          	addi	a3,a3,1750 # ffffffffc020cbf0 <default_pmm_manager+0xa90>
ffffffffc0204522:	00007617          	auipc	a2,0x7
ffffffffc0204526:	15660613          	addi	a2,a2,342 # ffffffffc020b678 <commands+0x210>
ffffffffc020452a:	45e5                	li	a1,25
ffffffffc020452c:	00008517          	auipc	a0,0x8
ffffffffc0204530:	6ec50513          	addi	a0,a0,1772 # ffffffffc020cc18 <default_pmm_manager+0xab8>
ffffffffc0204534:	f6bfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204538 <sem_init>:
ffffffffc0204538:	c10c                	sw	a1,0(a0)
ffffffffc020453a:	0521                	addi	a0,a0,8
ffffffffc020453c:	a825                	j	ffffffffc0204574 <wait_queue_init>

ffffffffc020453e <up>:
ffffffffc020453e:	f71ff06f          	j	ffffffffc02044ae <__up.constprop.0>

ffffffffc0204542 <down>:
ffffffffc0204542:	1141                	addi	sp,sp,-16
ffffffffc0204544:	e406                	sd	ra,8(sp)
ffffffffc0204546:	eabff0ef          	jal	ra,ffffffffc02043f0 <__down.constprop.0>
ffffffffc020454a:	2501                	sext.w	a0,a0
ffffffffc020454c:	e501                	bnez	a0,ffffffffc0204554 <down+0x12>
ffffffffc020454e:	60a2                	ld	ra,8(sp)
ffffffffc0204550:	0141                	addi	sp,sp,16
ffffffffc0204552:	8082                	ret
ffffffffc0204554:	00008697          	auipc	a3,0x8
ffffffffc0204558:	6d468693          	addi	a3,a3,1748 # ffffffffc020cc28 <default_pmm_manager+0xac8>
ffffffffc020455c:	00007617          	auipc	a2,0x7
ffffffffc0204560:	11c60613          	addi	a2,a2,284 # ffffffffc020b678 <commands+0x210>
ffffffffc0204564:	04000593          	li	a1,64
ffffffffc0204568:	00008517          	auipc	a0,0x8
ffffffffc020456c:	6b050513          	addi	a0,a0,1712 # ffffffffc020cc18 <default_pmm_manager+0xab8>
ffffffffc0204570:	f2ffb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204574 <wait_queue_init>:
ffffffffc0204574:	e508                	sd	a0,8(a0)
ffffffffc0204576:	e108                	sd	a0,0(a0)
ffffffffc0204578:	8082                	ret

ffffffffc020457a <wait_queue_del>:
ffffffffc020457a:	7198                	ld	a4,32(a1)
ffffffffc020457c:	01858793          	addi	a5,a1,24
ffffffffc0204580:	00e78b63          	beq	a5,a4,ffffffffc0204596 <wait_queue_del+0x1c>
ffffffffc0204584:	6994                	ld	a3,16(a1)
ffffffffc0204586:	00a69863          	bne	a3,a0,ffffffffc0204596 <wait_queue_del+0x1c>
ffffffffc020458a:	6d94                	ld	a3,24(a1)
ffffffffc020458c:	e698                	sd	a4,8(a3)
ffffffffc020458e:	e314                	sd	a3,0(a4)
ffffffffc0204590:	f19c                	sd	a5,32(a1)
ffffffffc0204592:	ed9c                	sd	a5,24(a1)
ffffffffc0204594:	8082                	ret
ffffffffc0204596:	1141                	addi	sp,sp,-16
ffffffffc0204598:	00008697          	auipc	a3,0x8
ffffffffc020459c:	6f068693          	addi	a3,a3,1776 # ffffffffc020cc88 <default_pmm_manager+0xb28>
ffffffffc02045a0:	00007617          	auipc	a2,0x7
ffffffffc02045a4:	0d860613          	addi	a2,a2,216 # ffffffffc020b678 <commands+0x210>
ffffffffc02045a8:	45f1                	li	a1,28
ffffffffc02045aa:	00008517          	auipc	a0,0x8
ffffffffc02045ae:	6c650513          	addi	a0,a0,1734 # ffffffffc020cc70 <default_pmm_manager+0xb10>
ffffffffc02045b2:	e406                	sd	ra,8(sp)
ffffffffc02045b4:	eebfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02045b8 <wait_queue_first>:
ffffffffc02045b8:	651c                	ld	a5,8(a0)
ffffffffc02045ba:	00f50563          	beq	a0,a5,ffffffffc02045c4 <wait_queue_first+0xc>
ffffffffc02045be:	fe878513          	addi	a0,a5,-24
ffffffffc02045c2:	8082                	ret
ffffffffc02045c4:	4501                	li	a0,0
ffffffffc02045c6:	8082                	ret

ffffffffc02045c8 <wait_queue_empty>:
ffffffffc02045c8:	651c                	ld	a5,8(a0)
ffffffffc02045ca:	40a78533          	sub	a0,a5,a0
ffffffffc02045ce:	00153513          	seqz	a0,a0
ffffffffc02045d2:	8082                	ret

ffffffffc02045d4 <wait_in_queue>:
ffffffffc02045d4:	711c                	ld	a5,32(a0)
ffffffffc02045d6:	0561                	addi	a0,a0,24
ffffffffc02045d8:	40a78533          	sub	a0,a5,a0
ffffffffc02045dc:	00a03533          	snez	a0,a0
ffffffffc02045e0:	8082                	ret

ffffffffc02045e2 <wakeup_wait>:
ffffffffc02045e2:	e689                	bnez	a3,ffffffffc02045ec <wakeup_wait+0xa>
ffffffffc02045e4:	6188                	ld	a0,0(a1)
ffffffffc02045e6:	c590                	sw	a2,8(a1)
ffffffffc02045e8:	2bf0206f          	j	ffffffffc02070a6 <wakeup_proc>
ffffffffc02045ec:	7198                	ld	a4,32(a1)
ffffffffc02045ee:	01858793          	addi	a5,a1,24
ffffffffc02045f2:	00e78e63          	beq	a5,a4,ffffffffc020460e <wakeup_wait+0x2c>
ffffffffc02045f6:	6994                	ld	a3,16(a1)
ffffffffc02045f8:	00d51b63          	bne	a0,a3,ffffffffc020460e <wakeup_wait+0x2c>
ffffffffc02045fc:	6d94                	ld	a3,24(a1)
ffffffffc02045fe:	6188                	ld	a0,0(a1)
ffffffffc0204600:	e698                	sd	a4,8(a3)
ffffffffc0204602:	e314                	sd	a3,0(a4)
ffffffffc0204604:	f19c                	sd	a5,32(a1)
ffffffffc0204606:	ed9c                	sd	a5,24(a1)
ffffffffc0204608:	c590                	sw	a2,8(a1)
ffffffffc020460a:	29d0206f          	j	ffffffffc02070a6 <wakeup_proc>
ffffffffc020460e:	1141                	addi	sp,sp,-16
ffffffffc0204610:	00008697          	auipc	a3,0x8
ffffffffc0204614:	67868693          	addi	a3,a3,1656 # ffffffffc020cc88 <default_pmm_manager+0xb28>
ffffffffc0204618:	00007617          	auipc	a2,0x7
ffffffffc020461c:	06060613          	addi	a2,a2,96 # ffffffffc020b678 <commands+0x210>
ffffffffc0204620:	45f1                	li	a1,28
ffffffffc0204622:	00008517          	auipc	a0,0x8
ffffffffc0204626:	64e50513          	addi	a0,a0,1614 # ffffffffc020cc70 <default_pmm_manager+0xb10>
ffffffffc020462a:	e406                	sd	ra,8(sp)
ffffffffc020462c:	e73fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204630 <wakeup_queue>:
ffffffffc0204630:	651c                	ld	a5,8(a0)
ffffffffc0204632:	0ca78563          	beq	a5,a0,ffffffffc02046fc <wakeup_queue+0xcc>
ffffffffc0204636:	1101                	addi	sp,sp,-32
ffffffffc0204638:	e822                	sd	s0,16(sp)
ffffffffc020463a:	e426                	sd	s1,8(sp)
ffffffffc020463c:	e04a                	sd	s2,0(sp)
ffffffffc020463e:	ec06                	sd	ra,24(sp)
ffffffffc0204640:	84aa                	mv	s1,a0
ffffffffc0204642:	892e                	mv	s2,a1
ffffffffc0204644:	fe878413          	addi	s0,a5,-24
ffffffffc0204648:	e23d                	bnez	a2,ffffffffc02046ae <wakeup_queue+0x7e>
ffffffffc020464a:	6008                	ld	a0,0(s0)
ffffffffc020464c:	01242423          	sw	s2,8(s0)
ffffffffc0204650:	257020ef          	jal	ra,ffffffffc02070a6 <wakeup_proc>
ffffffffc0204654:	701c                	ld	a5,32(s0)
ffffffffc0204656:	01840713          	addi	a4,s0,24
ffffffffc020465a:	02e78463          	beq	a5,a4,ffffffffc0204682 <wakeup_queue+0x52>
ffffffffc020465e:	6818                	ld	a4,16(s0)
ffffffffc0204660:	02e49163          	bne	s1,a4,ffffffffc0204682 <wakeup_queue+0x52>
ffffffffc0204664:	02f48f63          	beq	s1,a5,ffffffffc02046a2 <wakeup_queue+0x72>
ffffffffc0204668:	fe87b503          	ld	a0,-24(a5)
ffffffffc020466c:	ff27a823          	sw	s2,-16(a5)
ffffffffc0204670:	fe878413          	addi	s0,a5,-24
ffffffffc0204674:	233020ef          	jal	ra,ffffffffc02070a6 <wakeup_proc>
ffffffffc0204678:	701c                	ld	a5,32(s0)
ffffffffc020467a:	01840713          	addi	a4,s0,24
ffffffffc020467e:	fee790e3          	bne	a5,a4,ffffffffc020465e <wakeup_queue+0x2e>
ffffffffc0204682:	00008697          	auipc	a3,0x8
ffffffffc0204686:	60668693          	addi	a3,a3,1542 # ffffffffc020cc88 <default_pmm_manager+0xb28>
ffffffffc020468a:	00007617          	auipc	a2,0x7
ffffffffc020468e:	fee60613          	addi	a2,a2,-18 # ffffffffc020b678 <commands+0x210>
ffffffffc0204692:	02200593          	li	a1,34
ffffffffc0204696:	00008517          	auipc	a0,0x8
ffffffffc020469a:	5da50513          	addi	a0,a0,1498 # ffffffffc020cc70 <default_pmm_manager+0xb10>
ffffffffc020469e:	e01fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02046a2:	60e2                	ld	ra,24(sp)
ffffffffc02046a4:	6442                	ld	s0,16(sp)
ffffffffc02046a6:	64a2                	ld	s1,8(sp)
ffffffffc02046a8:	6902                	ld	s2,0(sp)
ffffffffc02046aa:	6105                	addi	sp,sp,32
ffffffffc02046ac:	8082                	ret
ffffffffc02046ae:	6798                	ld	a4,8(a5)
ffffffffc02046b0:	02f70763          	beq	a4,a5,ffffffffc02046de <wakeup_queue+0xae>
ffffffffc02046b4:	6814                	ld	a3,16(s0)
ffffffffc02046b6:	02d49463          	bne	s1,a3,ffffffffc02046de <wakeup_queue+0xae>
ffffffffc02046ba:	6c14                	ld	a3,24(s0)
ffffffffc02046bc:	6008                	ld	a0,0(s0)
ffffffffc02046be:	e698                	sd	a4,8(a3)
ffffffffc02046c0:	e314                	sd	a3,0(a4)
ffffffffc02046c2:	f01c                	sd	a5,32(s0)
ffffffffc02046c4:	ec1c                	sd	a5,24(s0)
ffffffffc02046c6:	01242423          	sw	s2,8(s0)
ffffffffc02046ca:	1dd020ef          	jal	ra,ffffffffc02070a6 <wakeup_proc>
ffffffffc02046ce:	6480                	ld	s0,8(s1)
ffffffffc02046d0:	fc8489e3          	beq	s1,s0,ffffffffc02046a2 <wakeup_queue+0x72>
ffffffffc02046d4:	6418                	ld	a4,8(s0)
ffffffffc02046d6:	87a2                	mv	a5,s0
ffffffffc02046d8:	1421                	addi	s0,s0,-24
ffffffffc02046da:	fce79de3          	bne	a5,a4,ffffffffc02046b4 <wakeup_queue+0x84>
ffffffffc02046de:	00008697          	auipc	a3,0x8
ffffffffc02046e2:	5aa68693          	addi	a3,a3,1450 # ffffffffc020cc88 <default_pmm_manager+0xb28>
ffffffffc02046e6:	00007617          	auipc	a2,0x7
ffffffffc02046ea:	f9260613          	addi	a2,a2,-110 # ffffffffc020b678 <commands+0x210>
ffffffffc02046ee:	45f1                	li	a1,28
ffffffffc02046f0:	00008517          	auipc	a0,0x8
ffffffffc02046f4:	58050513          	addi	a0,a0,1408 # ffffffffc020cc70 <default_pmm_manager+0xb10>
ffffffffc02046f8:	da7fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02046fc:	8082                	ret

ffffffffc02046fe <wait_current_set>:
ffffffffc02046fe:	00092797          	auipc	a5,0x92
ffffffffc0204702:	1c27b783          	ld	a5,450(a5) # ffffffffc02968c0 <current>
ffffffffc0204706:	c39d                	beqz	a5,ffffffffc020472c <wait_current_set+0x2e>
ffffffffc0204708:	01858713          	addi	a4,a1,24
ffffffffc020470c:	800006b7          	lui	a3,0x80000
ffffffffc0204710:	ed98                	sd	a4,24(a1)
ffffffffc0204712:	e19c                	sd	a5,0(a1)
ffffffffc0204714:	c594                	sw	a3,8(a1)
ffffffffc0204716:	4685                	li	a3,1
ffffffffc0204718:	c394                	sw	a3,0(a5)
ffffffffc020471a:	0ec7a623          	sw	a2,236(a5)
ffffffffc020471e:	611c                	ld	a5,0(a0)
ffffffffc0204720:	e988                	sd	a0,16(a1)
ffffffffc0204722:	e118                	sd	a4,0(a0)
ffffffffc0204724:	e798                	sd	a4,8(a5)
ffffffffc0204726:	f188                	sd	a0,32(a1)
ffffffffc0204728:	ed9c                	sd	a5,24(a1)
ffffffffc020472a:	8082                	ret
ffffffffc020472c:	1141                	addi	sp,sp,-16
ffffffffc020472e:	00008697          	auipc	a3,0x8
ffffffffc0204732:	59a68693          	addi	a3,a3,1434 # ffffffffc020ccc8 <default_pmm_manager+0xb68>
ffffffffc0204736:	00007617          	auipc	a2,0x7
ffffffffc020473a:	f4260613          	addi	a2,a2,-190 # ffffffffc020b678 <commands+0x210>
ffffffffc020473e:	07400593          	li	a1,116
ffffffffc0204742:	00008517          	auipc	a0,0x8
ffffffffc0204746:	52e50513          	addi	a0,a0,1326 # ffffffffc020cc70 <default_pmm_manager+0xb10>
ffffffffc020474a:	e406                	sd	ra,8(sp)
ffffffffc020474c:	d53fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204750 <get_fd_array.part.0>:
ffffffffc0204750:	1141                	addi	sp,sp,-16
ffffffffc0204752:	00008697          	auipc	a3,0x8
ffffffffc0204756:	58668693          	addi	a3,a3,1414 # ffffffffc020ccd8 <default_pmm_manager+0xb78>
ffffffffc020475a:	00007617          	auipc	a2,0x7
ffffffffc020475e:	f1e60613          	addi	a2,a2,-226 # ffffffffc020b678 <commands+0x210>
ffffffffc0204762:	45d1                	li	a1,20
ffffffffc0204764:	00008517          	auipc	a0,0x8
ffffffffc0204768:	5a450513          	addi	a0,a0,1444 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc020476c:	e406                	sd	ra,8(sp)
ffffffffc020476e:	d31fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204772 <fd_array_alloc>:
ffffffffc0204772:	00092797          	auipc	a5,0x92
ffffffffc0204776:	14e7b783          	ld	a5,334(a5) # ffffffffc02968c0 <current>
ffffffffc020477a:	1487b783          	ld	a5,328(a5)
ffffffffc020477e:	1141                	addi	sp,sp,-16
ffffffffc0204780:	e406                	sd	ra,8(sp)
ffffffffc0204782:	c3a5                	beqz	a5,ffffffffc02047e2 <fd_array_alloc+0x70>
ffffffffc0204784:	4b98                	lw	a4,16(a5)
ffffffffc0204786:	04e05e63          	blez	a4,ffffffffc02047e2 <fd_array_alloc+0x70>
ffffffffc020478a:	775d                	lui	a4,0xffff7
ffffffffc020478c:	ad970713          	addi	a4,a4,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0204790:	679c                	ld	a5,8(a5)
ffffffffc0204792:	02e50863          	beq	a0,a4,ffffffffc02047c2 <fd_array_alloc+0x50>
ffffffffc0204796:	04700713          	li	a4,71
ffffffffc020479a:	04a76263          	bltu	a4,a0,ffffffffc02047de <fd_array_alloc+0x6c>
ffffffffc020479e:	00351713          	slli	a4,a0,0x3
ffffffffc02047a2:	40a70533          	sub	a0,a4,a0
ffffffffc02047a6:	050e                	slli	a0,a0,0x3
ffffffffc02047a8:	97aa                	add	a5,a5,a0
ffffffffc02047aa:	4398                	lw	a4,0(a5)
ffffffffc02047ac:	e71d                	bnez	a4,ffffffffc02047da <fd_array_alloc+0x68>
ffffffffc02047ae:	5b88                	lw	a0,48(a5)
ffffffffc02047b0:	e91d                	bnez	a0,ffffffffc02047e6 <fd_array_alloc+0x74>
ffffffffc02047b2:	4705                	li	a4,1
ffffffffc02047b4:	c398                	sw	a4,0(a5)
ffffffffc02047b6:	0207b423          	sd	zero,40(a5)
ffffffffc02047ba:	e19c                	sd	a5,0(a1)
ffffffffc02047bc:	60a2                	ld	ra,8(sp)
ffffffffc02047be:	0141                	addi	sp,sp,16
ffffffffc02047c0:	8082                	ret
ffffffffc02047c2:	6685                	lui	a3,0x1
ffffffffc02047c4:	fc068693          	addi	a3,a3,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc02047c8:	96be                	add	a3,a3,a5
ffffffffc02047ca:	4398                	lw	a4,0(a5)
ffffffffc02047cc:	d36d                	beqz	a4,ffffffffc02047ae <fd_array_alloc+0x3c>
ffffffffc02047ce:	03878793          	addi	a5,a5,56
ffffffffc02047d2:	fef69ce3          	bne	a3,a5,ffffffffc02047ca <fd_array_alloc+0x58>
ffffffffc02047d6:	5529                	li	a0,-22
ffffffffc02047d8:	b7d5                	j	ffffffffc02047bc <fd_array_alloc+0x4a>
ffffffffc02047da:	5545                	li	a0,-15
ffffffffc02047dc:	b7c5                	j	ffffffffc02047bc <fd_array_alloc+0x4a>
ffffffffc02047de:	5575                	li	a0,-3
ffffffffc02047e0:	bff1                	j	ffffffffc02047bc <fd_array_alloc+0x4a>
ffffffffc02047e2:	f6fff0ef          	jal	ra,ffffffffc0204750 <get_fd_array.part.0>
ffffffffc02047e6:	00008697          	auipc	a3,0x8
ffffffffc02047ea:	53268693          	addi	a3,a3,1330 # ffffffffc020cd18 <default_pmm_manager+0xbb8>
ffffffffc02047ee:	00007617          	auipc	a2,0x7
ffffffffc02047f2:	e8a60613          	addi	a2,a2,-374 # ffffffffc020b678 <commands+0x210>
ffffffffc02047f6:	03b00593          	li	a1,59
ffffffffc02047fa:	00008517          	auipc	a0,0x8
ffffffffc02047fe:	50e50513          	addi	a0,a0,1294 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc0204802:	c9dfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204806 <fd_array_free>:
ffffffffc0204806:	411c                	lw	a5,0(a0)
ffffffffc0204808:	1141                	addi	sp,sp,-16
ffffffffc020480a:	e022                	sd	s0,0(sp)
ffffffffc020480c:	e406                	sd	ra,8(sp)
ffffffffc020480e:	4705                	li	a4,1
ffffffffc0204810:	842a                	mv	s0,a0
ffffffffc0204812:	04e78063          	beq	a5,a4,ffffffffc0204852 <fd_array_free+0x4c>
ffffffffc0204816:	470d                	li	a4,3
ffffffffc0204818:	04e79563          	bne	a5,a4,ffffffffc0204862 <fd_array_free+0x5c>
ffffffffc020481c:	591c                	lw	a5,48(a0)
ffffffffc020481e:	c38d                	beqz	a5,ffffffffc0204840 <fd_array_free+0x3a>
ffffffffc0204820:	00008697          	auipc	a3,0x8
ffffffffc0204824:	4f868693          	addi	a3,a3,1272 # ffffffffc020cd18 <default_pmm_manager+0xbb8>
ffffffffc0204828:	00007617          	auipc	a2,0x7
ffffffffc020482c:	e5060613          	addi	a2,a2,-432 # ffffffffc020b678 <commands+0x210>
ffffffffc0204830:	04500593          	li	a1,69
ffffffffc0204834:	00008517          	auipc	a0,0x8
ffffffffc0204838:	4d450513          	addi	a0,a0,1236 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc020483c:	c63fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204840:	7408                	ld	a0,40(s0)
ffffffffc0204842:	6da030ef          	jal	ra,ffffffffc0207f1c <vfs_close>
ffffffffc0204846:	60a2                	ld	ra,8(sp)
ffffffffc0204848:	00042023          	sw	zero,0(s0)
ffffffffc020484c:	6402                	ld	s0,0(sp)
ffffffffc020484e:	0141                	addi	sp,sp,16
ffffffffc0204850:	8082                	ret
ffffffffc0204852:	591c                	lw	a5,48(a0)
ffffffffc0204854:	f7f1                	bnez	a5,ffffffffc0204820 <fd_array_free+0x1a>
ffffffffc0204856:	60a2                	ld	ra,8(sp)
ffffffffc0204858:	00042023          	sw	zero,0(s0)
ffffffffc020485c:	6402                	ld	s0,0(sp)
ffffffffc020485e:	0141                	addi	sp,sp,16
ffffffffc0204860:	8082                	ret
ffffffffc0204862:	00008697          	auipc	a3,0x8
ffffffffc0204866:	4ee68693          	addi	a3,a3,1262 # ffffffffc020cd50 <default_pmm_manager+0xbf0>
ffffffffc020486a:	00007617          	auipc	a2,0x7
ffffffffc020486e:	e0e60613          	addi	a2,a2,-498 # ffffffffc020b678 <commands+0x210>
ffffffffc0204872:	04400593          	li	a1,68
ffffffffc0204876:	00008517          	auipc	a0,0x8
ffffffffc020487a:	49250513          	addi	a0,a0,1170 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc020487e:	c21fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204882 <fd_array_release>:
ffffffffc0204882:	4118                	lw	a4,0(a0)
ffffffffc0204884:	1141                	addi	sp,sp,-16
ffffffffc0204886:	e406                	sd	ra,8(sp)
ffffffffc0204888:	4685                	li	a3,1
ffffffffc020488a:	3779                	addiw	a4,a4,-2
ffffffffc020488c:	04e6e063          	bltu	a3,a4,ffffffffc02048cc <fd_array_release+0x4a>
ffffffffc0204890:	5918                	lw	a4,48(a0)
ffffffffc0204892:	00e05d63          	blez	a4,ffffffffc02048ac <fd_array_release+0x2a>
ffffffffc0204896:	fff7069b          	addiw	a3,a4,-1
ffffffffc020489a:	d914                	sw	a3,48(a0)
ffffffffc020489c:	c681                	beqz	a3,ffffffffc02048a4 <fd_array_release+0x22>
ffffffffc020489e:	60a2                	ld	ra,8(sp)
ffffffffc02048a0:	0141                	addi	sp,sp,16
ffffffffc02048a2:	8082                	ret
ffffffffc02048a4:	60a2                	ld	ra,8(sp)
ffffffffc02048a6:	0141                	addi	sp,sp,16
ffffffffc02048a8:	f5fff06f          	j	ffffffffc0204806 <fd_array_free>
ffffffffc02048ac:	00008697          	auipc	a3,0x8
ffffffffc02048b0:	51468693          	addi	a3,a3,1300 # ffffffffc020cdc0 <default_pmm_manager+0xc60>
ffffffffc02048b4:	00007617          	auipc	a2,0x7
ffffffffc02048b8:	dc460613          	addi	a2,a2,-572 # ffffffffc020b678 <commands+0x210>
ffffffffc02048bc:	05600593          	li	a1,86
ffffffffc02048c0:	00008517          	auipc	a0,0x8
ffffffffc02048c4:	44850513          	addi	a0,a0,1096 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc02048c8:	bd7fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02048cc:	00008697          	auipc	a3,0x8
ffffffffc02048d0:	4bc68693          	addi	a3,a3,1212 # ffffffffc020cd88 <default_pmm_manager+0xc28>
ffffffffc02048d4:	00007617          	auipc	a2,0x7
ffffffffc02048d8:	da460613          	addi	a2,a2,-604 # ffffffffc020b678 <commands+0x210>
ffffffffc02048dc:	05500593          	li	a1,85
ffffffffc02048e0:	00008517          	auipc	a0,0x8
ffffffffc02048e4:	42850513          	addi	a0,a0,1064 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc02048e8:	bb7fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02048ec <fd_array_open.part.0>:
ffffffffc02048ec:	1141                	addi	sp,sp,-16
ffffffffc02048ee:	00008697          	auipc	a3,0x8
ffffffffc02048f2:	4ea68693          	addi	a3,a3,1258 # ffffffffc020cdd8 <default_pmm_manager+0xc78>
ffffffffc02048f6:	00007617          	auipc	a2,0x7
ffffffffc02048fa:	d8260613          	addi	a2,a2,-638 # ffffffffc020b678 <commands+0x210>
ffffffffc02048fe:	05f00593          	li	a1,95
ffffffffc0204902:	00008517          	auipc	a0,0x8
ffffffffc0204906:	40650513          	addi	a0,a0,1030 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc020490a:	e406                	sd	ra,8(sp)
ffffffffc020490c:	b93fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204910 <fd_array_init>:
ffffffffc0204910:	4781                	li	a5,0
ffffffffc0204912:	04800713          	li	a4,72
ffffffffc0204916:	cd1c                	sw	a5,24(a0)
ffffffffc0204918:	02052823          	sw	zero,48(a0)
ffffffffc020491c:	00052023          	sw	zero,0(a0)
ffffffffc0204920:	2785                	addiw	a5,a5,1
ffffffffc0204922:	03850513          	addi	a0,a0,56
ffffffffc0204926:	fee798e3          	bne	a5,a4,ffffffffc0204916 <fd_array_init+0x6>
ffffffffc020492a:	8082                	ret

ffffffffc020492c <fd_array_close>:
ffffffffc020492c:	4118                	lw	a4,0(a0)
ffffffffc020492e:	1141                	addi	sp,sp,-16
ffffffffc0204930:	e406                	sd	ra,8(sp)
ffffffffc0204932:	e022                	sd	s0,0(sp)
ffffffffc0204934:	4789                	li	a5,2
ffffffffc0204936:	04f71a63          	bne	a4,a5,ffffffffc020498a <fd_array_close+0x5e>
ffffffffc020493a:	591c                	lw	a5,48(a0)
ffffffffc020493c:	842a                	mv	s0,a0
ffffffffc020493e:	02f05663          	blez	a5,ffffffffc020496a <fd_array_close+0x3e>
ffffffffc0204942:	37fd                	addiw	a5,a5,-1
ffffffffc0204944:	470d                	li	a4,3
ffffffffc0204946:	c118                	sw	a4,0(a0)
ffffffffc0204948:	d91c                	sw	a5,48(a0)
ffffffffc020494a:	0007871b          	sext.w	a4,a5
ffffffffc020494e:	c709                	beqz	a4,ffffffffc0204958 <fd_array_close+0x2c>
ffffffffc0204950:	60a2                	ld	ra,8(sp)
ffffffffc0204952:	6402                	ld	s0,0(sp)
ffffffffc0204954:	0141                	addi	sp,sp,16
ffffffffc0204956:	8082                	ret
ffffffffc0204958:	7508                	ld	a0,40(a0)
ffffffffc020495a:	5c2030ef          	jal	ra,ffffffffc0207f1c <vfs_close>
ffffffffc020495e:	60a2                	ld	ra,8(sp)
ffffffffc0204960:	00042023          	sw	zero,0(s0)
ffffffffc0204964:	6402                	ld	s0,0(sp)
ffffffffc0204966:	0141                	addi	sp,sp,16
ffffffffc0204968:	8082                	ret
ffffffffc020496a:	00008697          	auipc	a3,0x8
ffffffffc020496e:	45668693          	addi	a3,a3,1110 # ffffffffc020cdc0 <default_pmm_manager+0xc60>
ffffffffc0204972:	00007617          	auipc	a2,0x7
ffffffffc0204976:	d0660613          	addi	a2,a2,-762 # ffffffffc020b678 <commands+0x210>
ffffffffc020497a:	06800593          	li	a1,104
ffffffffc020497e:	00008517          	auipc	a0,0x8
ffffffffc0204982:	38a50513          	addi	a0,a0,906 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc0204986:	b19fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020498a:	00008697          	auipc	a3,0x8
ffffffffc020498e:	3a668693          	addi	a3,a3,934 # ffffffffc020cd30 <default_pmm_manager+0xbd0>
ffffffffc0204992:	00007617          	auipc	a2,0x7
ffffffffc0204996:	ce660613          	addi	a2,a2,-794 # ffffffffc020b678 <commands+0x210>
ffffffffc020499a:	06700593          	li	a1,103
ffffffffc020499e:	00008517          	auipc	a0,0x8
ffffffffc02049a2:	36a50513          	addi	a0,a0,874 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc02049a6:	af9fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02049aa <fd_array_dup>:
ffffffffc02049aa:	7179                	addi	sp,sp,-48
ffffffffc02049ac:	e84a                	sd	s2,16(sp)
ffffffffc02049ae:	00052903          	lw	s2,0(a0)
ffffffffc02049b2:	f406                	sd	ra,40(sp)
ffffffffc02049b4:	f022                	sd	s0,32(sp)
ffffffffc02049b6:	ec26                	sd	s1,24(sp)
ffffffffc02049b8:	e44e                	sd	s3,8(sp)
ffffffffc02049ba:	4785                	li	a5,1
ffffffffc02049bc:	04f91663          	bne	s2,a5,ffffffffc0204a08 <fd_array_dup+0x5e>
ffffffffc02049c0:	0005a983          	lw	s3,0(a1)
ffffffffc02049c4:	4789                	li	a5,2
ffffffffc02049c6:	04f99163          	bne	s3,a5,ffffffffc0204a08 <fd_array_dup+0x5e>
ffffffffc02049ca:	7584                	ld	s1,40(a1)
ffffffffc02049cc:	699c                	ld	a5,16(a1)
ffffffffc02049ce:	7194                	ld	a3,32(a1)
ffffffffc02049d0:	6598                	ld	a4,8(a1)
ffffffffc02049d2:	842a                	mv	s0,a0
ffffffffc02049d4:	e91c                	sd	a5,16(a0)
ffffffffc02049d6:	f114                	sd	a3,32(a0)
ffffffffc02049d8:	e518                	sd	a4,8(a0)
ffffffffc02049da:	8526                	mv	a0,s1
ffffffffc02049dc:	49f020ef          	jal	ra,ffffffffc020767a <inode_ref_inc>
ffffffffc02049e0:	8526                	mv	a0,s1
ffffffffc02049e2:	4a5020ef          	jal	ra,ffffffffc0207686 <inode_open_inc>
ffffffffc02049e6:	401c                	lw	a5,0(s0)
ffffffffc02049e8:	f404                	sd	s1,40(s0)
ffffffffc02049ea:	03279f63          	bne	a5,s2,ffffffffc0204a28 <fd_array_dup+0x7e>
ffffffffc02049ee:	cc8d                	beqz	s1,ffffffffc0204a28 <fd_array_dup+0x7e>
ffffffffc02049f0:	581c                	lw	a5,48(s0)
ffffffffc02049f2:	01342023          	sw	s3,0(s0)
ffffffffc02049f6:	70a2                	ld	ra,40(sp)
ffffffffc02049f8:	2785                	addiw	a5,a5,1
ffffffffc02049fa:	d81c                	sw	a5,48(s0)
ffffffffc02049fc:	7402                	ld	s0,32(sp)
ffffffffc02049fe:	64e2                	ld	s1,24(sp)
ffffffffc0204a00:	6942                	ld	s2,16(sp)
ffffffffc0204a02:	69a2                	ld	s3,8(sp)
ffffffffc0204a04:	6145                	addi	sp,sp,48
ffffffffc0204a06:	8082                	ret
ffffffffc0204a08:	00008697          	auipc	a3,0x8
ffffffffc0204a0c:	40068693          	addi	a3,a3,1024 # ffffffffc020ce08 <default_pmm_manager+0xca8>
ffffffffc0204a10:	00007617          	auipc	a2,0x7
ffffffffc0204a14:	c6860613          	addi	a2,a2,-920 # ffffffffc020b678 <commands+0x210>
ffffffffc0204a18:	07300593          	li	a1,115
ffffffffc0204a1c:	00008517          	auipc	a0,0x8
ffffffffc0204a20:	2ec50513          	addi	a0,a0,748 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc0204a24:	a7bfb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204a28:	ec5ff0ef          	jal	ra,ffffffffc02048ec <fd_array_open.part.0>

ffffffffc0204a2c <file_testfd>:
ffffffffc0204a2c:	04700793          	li	a5,71
ffffffffc0204a30:	04a7e263          	bltu	a5,a0,ffffffffc0204a74 <file_testfd+0x48>
ffffffffc0204a34:	00092797          	auipc	a5,0x92
ffffffffc0204a38:	e8c7b783          	ld	a5,-372(a5) # ffffffffc02968c0 <current>
ffffffffc0204a3c:	1487b783          	ld	a5,328(a5)
ffffffffc0204a40:	cf85                	beqz	a5,ffffffffc0204a78 <file_testfd+0x4c>
ffffffffc0204a42:	4b98                	lw	a4,16(a5)
ffffffffc0204a44:	02e05a63          	blez	a4,ffffffffc0204a78 <file_testfd+0x4c>
ffffffffc0204a48:	6798                	ld	a4,8(a5)
ffffffffc0204a4a:	00351793          	slli	a5,a0,0x3
ffffffffc0204a4e:	8f89                	sub	a5,a5,a0
ffffffffc0204a50:	078e                	slli	a5,a5,0x3
ffffffffc0204a52:	97ba                	add	a5,a5,a4
ffffffffc0204a54:	4394                	lw	a3,0(a5)
ffffffffc0204a56:	4709                	li	a4,2
ffffffffc0204a58:	00e69e63          	bne	a3,a4,ffffffffc0204a74 <file_testfd+0x48>
ffffffffc0204a5c:	4f98                	lw	a4,24(a5)
ffffffffc0204a5e:	00a71b63          	bne	a4,a0,ffffffffc0204a74 <file_testfd+0x48>
ffffffffc0204a62:	c199                	beqz	a1,ffffffffc0204a68 <file_testfd+0x3c>
ffffffffc0204a64:	6788                	ld	a0,8(a5)
ffffffffc0204a66:	c901                	beqz	a0,ffffffffc0204a76 <file_testfd+0x4a>
ffffffffc0204a68:	4505                	li	a0,1
ffffffffc0204a6a:	c611                	beqz	a2,ffffffffc0204a76 <file_testfd+0x4a>
ffffffffc0204a6c:	6b88                	ld	a0,16(a5)
ffffffffc0204a6e:	00a03533          	snez	a0,a0
ffffffffc0204a72:	8082                	ret
ffffffffc0204a74:	4501                	li	a0,0
ffffffffc0204a76:	8082                	ret
ffffffffc0204a78:	1141                	addi	sp,sp,-16
ffffffffc0204a7a:	e406                	sd	ra,8(sp)
ffffffffc0204a7c:	cd5ff0ef          	jal	ra,ffffffffc0204750 <get_fd_array.part.0>

ffffffffc0204a80 <file_open>:
ffffffffc0204a80:	711d                	addi	sp,sp,-96
ffffffffc0204a82:	ec86                	sd	ra,88(sp)
ffffffffc0204a84:	e8a2                	sd	s0,80(sp)
ffffffffc0204a86:	e4a6                	sd	s1,72(sp)
ffffffffc0204a88:	e0ca                	sd	s2,64(sp)
ffffffffc0204a8a:	fc4e                	sd	s3,56(sp)
ffffffffc0204a8c:	f852                	sd	s4,48(sp)
ffffffffc0204a8e:	0035f793          	andi	a5,a1,3
ffffffffc0204a92:	470d                	li	a4,3
ffffffffc0204a94:	0ce78163          	beq	a5,a4,ffffffffc0204b56 <file_open+0xd6>
ffffffffc0204a98:	078e                	slli	a5,a5,0x3
ffffffffc0204a9a:	00008717          	auipc	a4,0x8
ffffffffc0204a9e:	5de70713          	addi	a4,a4,1502 # ffffffffc020d078 <CSWTCH.79>
ffffffffc0204aa2:	892a                	mv	s2,a0
ffffffffc0204aa4:	00008697          	auipc	a3,0x8
ffffffffc0204aa8:	5bc68693          	addi	a3,a3,1468 # ffffffffc020d060 <CSWTCH.78>
ffffffffc0204aac:	755d                	lui	a0,0xffff7
ffffffffc0204aae:	96be                	add	a3,a3,a5
ffffffffc0204ab0:	84ae                	mv	s1,a1
ffffffffc0204ab2:	97ba                	add	a5,a5,a4
ffffffffc0204ab4:	858a                	mv	a1,sp
ffffffffc0204ab6:	ad950513          	addi	a0,a0,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0204aba:	0006ba03          	ld	s4,0(a3)
ffffffffc0204abe:	0007b983          	ld	s3,0(a5)
ffffffffc0204ac2:	cb1ff0ef          	jal	ra,ffffffffc0204772 <fd_array_alloc>
ffffffffc0204ac6:	842a                	mv	s0,a0
ffffffffc0204ac8:	c911                	beqz	a0,ffffffffc0204adc <file_open+0x5c>
ffffffffc0204aca:	60e6                	ld	ra,88(sp)
ffffffffc0204acc:	8522                	mv	a0,s0
ffffffffc0204ace:	6446                	ld	s0,80(sp)
ffffffffc0204ad0:	64a6                	ld	s1,72(sp)
ffffffffc0204ad2:	6906                	ld	s2,64(sp)
ffffffffc0204ad4:	79e2                	ld	s3,56(sp)
ffffffffc0204ad6:	7a42                	ld	s4,48(sp)
ffffffffc0204ad8:	6125                	addi	sp,sp,96
ffffffffc0204ada:	8082                	ret
ffffffffc0204adc:	0030                	addi	a2,sp,8
ffffffffc0204ade:	85a6                	mv	a1,s1
ffffffffc0204ae0:	854a                	mv	a0,s2
ffffffffc0204ae2:	294030ef          	jal	ra,ffffffffc0207d76 <vfs_open>
ffffffffc0204ae6:	842a                	mv	s0,a0
ffffffffc0204ae8:	e13d                	bnez	a0,ffffffffc0204b4e <file_open+0xce>
ffffffffc0204aea:	6782                	ld	a5,0(sp)
ffffffffc0204aec:	0204f493          	andi	s1,s1,32
ffffffffc0204af0:	6422                	ld	s0,8(sp)
ffffffffc0204af2:	0207b023          	sd	zero,32(a5)
ffffffffc0204af6:	c885                	beqz	s1,ffffffffc0204b26 <file_open+0xa6>
ffffffffc0204af8:	c03d                	beqz	s0,ffffffffc0204b5e <file_open+0xde>
ffffffffc0204afa:	783c                	ld	a5,112(s0)
ffffffffc0204afc:	c3ad                	beqz	a5,ffffffffc0204b5e <file_open+0xde>
ffffffffc0204afe:	779c                	ld	a5,40(a5)
ffffffffc0204b00:	cfb9                	beqz	a5,ffffffffc0204b5e <file_open+0xde>
ffffffffc0204b02:	8522                	mv	a0,s0
ffffffffc0204b04:	00008597          	auipc	a1,0x8
ffffffffc0204b08:	38c58593          	addi	a1,a1,908 # ffffffffc020ce90 <default_pmm_manager+0xd30>
ffffffffc0204b0c:	387020ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc0204b10:	783c                	ld	a5,112(s0)
ffffffffc0204b12:	6522                	ld	a0,8(sp)
ffffffffc0204b14:	080c                	addi	a1,sp,16
ffffffffc0204b16:	779c                	ld	a5,40(a5)
ffffffffc0204b18:	9782                	jalr	a5
ffffffffc0204b1a:	842a                	mv	s0,a0
ffffffffc0204b1c:	e515                	bnez	a0,ffffffffc0204b48 <file_open+0xc8>
ffffffffc0204b1e:	6782                	ld	a5,0(sp)
ffffffffc0204b20:	7722                	ld	a4,40(sp)
ffffffffc0204b22:	6422                	ld	s0,8(sp)
ffffffffc0204b24:	f398                	sd	a4,32(a5)
ffffffffc0204b26:	4394                	lw	a3,0(a5)
ffffffffc0204b28:	f780                	sd	s0,40(a5)
ffffffffc0204b2a:	0147b423          	sd	s4,8(a5)
ffffffffc0204b2e:	0137b823          	sd	s3,16(a5)
ffffffffc0204b32:	4705                	li	a4,1
ffffffffc0204b34:	02e69363          	bne	a3,a4,ffffffffc0204b5a <file_open+0xda>
ffffffffc0204b38:	c00d                	beqz	s0,ffffffffc0204b5a <file_open+0xda>
ffffffffc0204b3a:	5b98                	lw	a4,48(a5)
ffffffffc0204b3c:	4689                	li	a3,2
ffffffffc0204b3e:	4f80                	lw	s0,24(a5)
ffffffffc0204b40:	2705                	addiw	a4,a4,1
ffffffffc0204b42:	c394                	sw	a3,0(a5)
ffffffffc0204b44:	db98                	sw	a4,48(a5)
ffffffffc0204b46:	b751                	j	ffffffffc0204aca <file_open+0x4a>
ffffffffc0204b48:	6522                	ld	a0,8(sp)
ffffffffc0204b4a:	3d2030ef          	jal	ra,ffffffffc0207f1c <vfs_close>
ffffffffc0204b4e:	6502                	ld	a0,0(sp)
ffffffffc0204b50:	cb7ff0ef          	jal	ra,ffffffffc0204806 <fd_array_free>
ffffffffc0204b54:	bf9d                	j	ffffffffc0204aca <file_open+0x4a>
ffffffffc0204b56:	5475                	li	s0,-3
ffffffffc0204b58:	bf8d                	j	ffffffffc0204aca <file_open+0x4a>
ffffffffc0204b5a:	d93ff0ef          	jal	ra,ffffffffc02048ec <fd_array_open.part.0>
ffffffffc0204b5e:	00008697          	auipc	a3,0x8
ffffffffc0204b62:	2e268693          	addi	a3,a3,738 # ffffffffc020ce40 <default_pmm_manager+0xce0>
ffffffffc0204b66:	00007617          	auipc	a2,0x7
ffffffffc0204b6a:	b1260613          	addi	a2,a2,-1262 # ffffffffc020b678 <commands+0x210>
ffffffffc0204b6e:	0b500593          	li	a1,181
ffffffffc0204b72:	00008517          	auipc	a0,0x8
ffffffffc0204b76:	19650513          	addi	a0,a0,406 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc0204b7a:	925fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204b7e <file_close>:
ffffffffc0204b7e:	04700713          	li	a4,71
ffffffffc0204b82:	04a76563          	bltu	a4,a0,ffffffffc0204bcc <file_close+0x4e>
ffffffffc0204b86:	00092717          	auipc	a4,0x92
ffffffffc0204b8a:	d3a73703          	ld	a4,-710(a4) # ffffffffc02968c0 <current>
ffffffffc0204b8e:	14873703          	ld	a4,328(a4)
ffffffffc0204b92:	1141                	addi	sp,sp,-16
ffffffffc0204b94:	e406                	sd	ra,8(sp)
ffffffffc0204b96:	cf0d                	beqz	a4,ffffffffc0204bd0 <file_close+0x52>
ffffffffc0204b98:	4b14                	lw	a3,16(a4)
ffffffffc0204b9a:	02d05b63          	blez	a3,ffffffffc0204bd0 <file_close+0x52>
ffffffffc0204b9e:	6718                	ld	a4,8(a4)
ffffffffc0204ba0:	87aa                	mv	a5,a0
ffffffffc0204ba2:	050e                	slli	a0,a0,0x3
ffffffffc0204ba4:	8d1d                	sub	a0,a0,a5
ffffffffc0204ba6:	050e                	slli	a0,a0,0x3
ffffffffc0204ba8:	953a                	add	a0,a0,a4
ffffffffc0204baa:	4114                	lw	a3,0(a0)
ffffffffc0204bac:	4709                	li	a4,2
ffffffffc0204bae:	00e69b63          	bne	a3,a4,ffffffffc0204bc4 <file_close+0x46>
ffffffffc0204bb2:	4d18                	lw	a4,24(a0)
ffffffffc0204bb4:	00f71863          	bne	a4,a5,ffffffffc0204bc4 <file_close+0x46>
ffffffffc0204bb8:	d75ff0ef          	jal	ra,ffffffffc020492c <fd_array_close>
ffffffffc0204bbc:	60a2                	ld	ra,8(sp)
ffffffffc0204bbe:	4501                	li	a0,0
ffffffffc0204bc0:	0141                	addi	sp,sp,16
ffffffffc0204bc2:	8082                	ret
ffffffffc0204bc4:	60a2                	ld	ra,8(sp)
ffffffffc0204bc6:	5575                	li	a0,-3
ffffffffc0204bc8:	0141                	addi	sp,sp,16
ffffffffc0204bca:	8082                	ret
ffffffffc0204bcc:	5575                	li	a0,-3
ffffffffc0204bce:	8082                	ret
ffffffffc0204bd0:	b81ff0ef          	jal	ra,ffffffffc0204750 <get_fd_array.part.0>

ffffffffc0204bd4 <file_read>:
ffffffffc0204bd4:	715d                	addi	sp,sp,-80
ffffffffc0204bd6:	e486                	sd	ra,72(sp)
ffffffffc0204bd8:	e0a2                	sd	s0,64(sp)
ffffffffc0204bda:	fc26                	sd	s1,56(sp)
ffffffffc0204bdc:	f84a                	sd	s2,48(sp)
ffffffffc0204bde:	f44e                	sd	s3,40(sp)
ffffffffc0204be0:	f052                	sd	s4,32(sp)
ffffffffc0204be2:	0006b023          	sd	zero,0(a3)
ffffffffc0204be6:	04700793          	li	a5,71
ffffffffc0204bea:	0aa7e463          	bltu	a5,a0,ffffffffc0204c92 <file_read+0xbe>
ffffffffc0204bee:	00092797          	auipc	a5,0x92
ffffffffc0204bf2:	cd27b783          	ld	a5,-814(a5) # ffffffffc02968c0 <current>
ffffffffc0204bf6:	1487b783          	ld	a5,328(a5)
ffffffffc0204bfa:	cfd1                	beqz	a5,ffffffffc0204c96 <file_read+0xc2>
ffffffffc0204bfc:	4b98                	lw	a4,16(a5)
ffffffffc0204bfe:	08e05c63          	blez	a4,ffffffffc0204c96 <file_read+0xc2>
ffffffffc0204c02:	6780                	ld	s0,8(a5)
ffffffffc0204c04:	00351793          	slli	a5,a0,0x3
ffffffffc0204c08:	8f89                	sub	a5,a5,a0
ffffffffc0204c0a:	078e                	slli	a5,a5,0x3
ffffffffc0204c0c:	943e                	add	s0,s0,a5
ffffffffc0204c0e:	00042983          	lw	s3,0(s0)
ffffffffc0204c12:	4789                	li	a5,2
ffffffffc0204c14:	06f99f63          	bne	s3,a5,ffffffffc0204c92 <file_read+0xbe>
ffffffffc0204c18:	4c1c                	lw	a5,24(s0)
ffffffffc0204c1a:	06a79c63          	bne	a5,a0,ffffffffc0204c92 <file_read+0xbe>
ffffffffc0204c1e:	641c                	ld	a5,8(s0)
ffffffffc0204c20:	cbad                	beqz	a5,ffffffffc0204c92 <file_read+0xbe>
ffffffffc0204c22:	581c                	lw	a5,48(s0)
ffffffffc0204c24:	8a36                	mv	s4,a3
ffffffffc0204c26:	7014                	ld	a3,32(s0)
ffffffffc0204c28:	2785                	addiw	a5,a5,1
ffffffffc0204c2a:	850a                	mv	a0,sp
ffffffffc0204c2c:	d81c                	sw	a5,48(s0)
ffffffffc0204c2e:	792000ef          	jal	ra,ffffffffc02053c0 <iobuf_init>
ffffffffc0204c32:	02843903          	ld	s2,40(s0)
ffffffffc0204c36:	84aa                	mv	s1,a0
ffffffffc0204c38:	06090163          	beqz	s2,ffffffffc0204c9a <file_read+0xc6>
ffffffffc0204c3c:	07093783          	ld	a5,112(s2)
ffffffffc0204c40:	cfa9                	beqz	a5,ffffffffc0204c9a <file_read+0xc6>
ffffffffc0204c42:	6f9c                	ld	a5,24(a5)
ffffffffc0204c44:	cbb9                	beqz	a5,ffffffffc0204c9a <file_read+0xc6>
ffffffffc0204c46:	00008597          	auipc	a1,0x8
ffffffffc0204c4a:	2a258593          	addi	a1,a1,674 # ffffffffc020cee8 <default_pmm_manager+0xd88>
ffffffffc0204c4e:	854a                	mv	a0,s2
ffffffffc0204c50:	243020ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc0204c54:	07093783          	ld	a5,112(s2)
ffffffffc0204c58:	7408                	ld	a0,40(s0)
ffffffffc0204c5a:	85a6                	mv	a1,s1
ffffffffc0204c5c:	6f9c                	ld	a5,24(a5)
ffffffffc0204c5e:	9782                	jalr	a5
ffffffffc0204c60:	689c                	ld	a5,16(s1)
ffffffffc0204c62:	6c94                	ld	a3,24(s1)
ffffffffc0204c64:	4018                	lw	a4,0(s0)
ffffffffc0204c66:	84aa                	mv	s1,a0
ffffffffc0204c68:	8f95                	sub	a5,a5,a3
ffffffffc0204c6a:	03370063          	beq	a4,s3,ffffffffc0204c8a <file_read+0xb6>
ffffffffc0204c6e:	00fa3023          	sd	a5,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0204c72:	8522                	mv	a0,s0
ffffffffc0204c74:	c0fff0ef          	jal	ra,ffffffffc0204882 <fd_array_release>
ffffffffc0204c78:	60a6                	ld	ra,72(sp)
ffffffffc0204c7a:	6406                	ld	s0,64(sp)
ffffffffc0204c7c:	7942                	ld	s2,48(sp)
ffffffffc0204c7e:	79a2                	ld	s3,40(sp)
ffffffffc0204c80:	7a02                	ld	s4,32(sp)
ffffffffc0204c82:	8526                	mv	a0,s1
ffffffffc0204c84:	74e2                	ld	s1,56(sp)
ffffffffc0204c86:	6161                	addi	sp,sp,80
ffffffffc0204c88:	8082                	ret
ffffffffc0204c8a:	7018                	ld	a4,32(s0)
ffffffffc0204c8c:	973e                	add	a4,a4,a5
ffffffffc0204c8e:	f018                	sd	a4,32(s0)
ffffffffc0204c90:	bff9                	j	ffffffffc0204c6e <file_read+0x9a>
ffffffffc0204c92:	54f5                	li	s1,-3
ffffffffc0204c94:	b7d5                	j	ffffffffc0204c78 <file_read+0xa4>
ffffffffc0204c96:	abbff0ef          	jal	ra,ffffffffc0204750 <get_fd_array.part.0>
ffffffffc0204c9a:	00008697          	auipc	a3,0x8
ffffffffc0204c9e:	1fe68693          	addi	a3,a3,510 # ffffffffc020ce98 <default_pmm_manager+0xd38>
ffffffffc0204ca2:	00007617          	auipc	a2,0x7
ffffffffc0204ca6:	9d660613          	addi	a2,a2,-1578 # ffffffffc020b678 <commands+0x210>
ffffffffc0204caa:	0de00593          	li	a1,222
ffffffffc0204cae:	00008517          	auipc	a0,0x8
ffffffffc0204cb2:	05a50513          	addi	a0,a0,90 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc0204cb6:	fe8fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204cba <file_write>:
ffffffffc0204cba:	715d                	addi	sp,sp,-80
ffffffffc0204cbc:	e486                	sd	ra,72(sp)
ffffffffc0204cbe:	e0a2                	sd	s0,64(sp)
ffffffffc0204cc0:	fc26                	sd	s1,56(sp)
ffffffffc0204cc2:	f84a                	sd	s2,48(sp)
ffffffffc0204cc4:	f44e                	sd	s3,40(sp)
ffffffffc0204cc6:	f052                	sd	s4,32(sp)
ffffffffc0204cc8:	0006b023          	sd	zero,0(a3)
ffffffffc0204ccc:	04700793          	li	a5,71
ffffffffc0204cd0:	0aa7e463          	bltu	a5,a0,ffffffffc0204d78 <file_write+0xbe>
ffffffffc0204cd4:	00092797          	auipc	a5,0x92
ffffffffc0204cd8:	bec7b783          	ld	a5,-1044(a5) # ffffffffc02968c0 <current>
ffffffffc0204cdc:	1487b783          	ld	a5,328(a5)
ffffffffc0204ce0:	cfd1                	beqz	a5,ffffffffc0204d7c <file_write+0xc2>
ffffffffc0204ce2:	4b98                	lw	a4,16(a5)
ffffffffc0204ce4:	08e05c63          	blez	a4,ffffffffc0204d7c <file_write+0xc2>
ffffffffc0204ce8:	6780                	ld	s0,8(a5)
ffffffffc0204cea:	00351793          	slli	a5,a0,0x3
ffffffffc0204cee:	8f89                	sub	a5,a5,a0
ffffffffc0204cf0:	078e                	slli	a5,a5,0x3
ffffffffc0204cf2:	943e                	add	s0,s0,a5
ffffffffc0204cf4:	00042983          	lw	s3,0(s0)
ffffffffc0204cf8:	4789                	li	a5,2
ffffffffc0204cfa:	06f99f63          	bne	s3,a5,ffffffffc0204d78 <file_write+0xbe>
ffffffffc0204cfe:	4c1c                	lw	a5,24(s0)
ffffffffc0204d00:	06a79c63          	bne	a5,a0,ffffffffc0204d78 <file_write+0xbe>
ffffffffc0204d04:	681c                	ld	a5,16(s0)
ffffffffc0204d06:	cbad                	beqz	a5,ffffffffc0204d78 <file_write+0xbe>
ffffffffc0204d08:	581c                	lw	a5,48(s0)
ffffffffc0204d0a:	8a36                	mv	s4,a3
ffffffffc0204d0c:	7014                	ld	a3,32(s0)
ffffffffc0204d0e:	2785                	addiw	a5,a5,1
ffffffffc0204d10:	850a                	mv	a0,sp
ffffffffc0204d12:	d81c                	sw	a5,48(s0)
ffffffffc0204d14:	6ac000ef          	jal	ra,ffffffffc02053c0 <iobuf_init>
ffffffffc0204d18:	02843903          	ld	s2,40(s0)
ffffffffc0204d1c:	84aa                	mv	s1,a0
ffffffffc0204d1e:	06090163          	beqz	s2,ffffffffc0204d80 <file_write+0xc6>
ffffffffc0204d22:	07093783          	ld	a5,112(s2)
ffffffffc0204d26:	cfa9                	beqz	a5,ffffffffc0204d80 <file_write+0xc6>
ffffffffc0204d28:	739c                	ld	a5,32(a5)
ffffffffc0204d2a:	cbb9                	beqz	a5,ffffffffc0204d80 <file_write+0xc6>
ffffffffc0204d2c:	00008597          	auipc	a1,0x8
ffffffffc0204d30:	21458593          	addi	a1,a1,532 # ffffffffc020cf40 <default_pmm_manager+0xde0>
ffffffffc0204d34:	854a                	mv	a0,s2
ffffffffc0204d36:	15d020ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc0204d3a:	07093783          	ld	a5,112(s2)
ffffffffc0204d3e:	7408                	ld	a0,40(s0)
ffffffffc0204d40:	85a6                	mv	a1,s1
ffffffffc0204d42:	739c                	ld	a5,32(a5)
ffffffffc0204d44:	9782                	jalr	a5
ffffffffc0204d46:	689c                	ld	a5,16(s1)
ffffffffc0204d48:	6c94                	ld	a3,24(s1)
ffffffffc0204d4a:	4018                	lw	a4,0(s0)
ffffffffc0204d4c:	84aa                	mv	s1,a0
ffffffffc0204d4e:	8f95                	sub	a5,a5,a3
ffffffffc0204d50:	03370063          	beq	a4,s3,ffffffffc0204d70 <file_write+0xb6>
ffffffffc0204d54:	00fa3023          	sd	a5,0(s4)
ffffffffc0204d58:	8522                	mv	a0,s0
ffffffffc0204d5a:	b29ff0ef          	jal	ra,ffffffffc0204882 <fd_array_release>
ffffffffc0204d5e:	60a6                	ld	ra,72(sp)
ffffffffc0204d60:	6406                	ld	s0,64(sp)
ffffffffc0204d62:	7942                	ld	s2,48(sp)
ffffffffc0204d64:	79a2                	ld	s3,40(sp)
ffffffffc0204d66:	7a02                	ld	s4,32(sp)
ffffffffc0204d68:	8526                	mv	a0,s1
ffffffffc0204d6a:	74e2                	ld	s1,56(sp)
ffffffffc0204d6c:	6161                	addi	sp,sp,80
ffffffffc0204d6e:	8082                	ret
ffffffffc0204d70:	7018                	ld	a4,32(s0)
ffffffffc0204d72:	973e                	add	a4,a4,a5
ffffffffc0204d74:	f018                	sd	a4,32(s0)
ffffffffc0204d76:	bff9                	j	ffffffffc0204d54 <file_write+0x9a>
ffffffffc0204d78:	54f5                	li	s1,-3
ffffffffc0204d7a:	b7d5                	j	ffffffffc0204d5e <file_write+0xa4>
ffffffffc0204d7c:	9d5ff0ef          	jal	ra,ffffffffc0204750 <get_fd_array.part.0>
ffffffffc0204d80:	00008697          	auipc	a3,0x8
ffffffffc0204d84:	17068693          	addi	a3,a3,368 # ffffffffc020cef0 <default_pmm_manager+0xd90>
ffffffffc0204d88:	00007617          	auipc	a2,0x7
ffffffffc0204d8c:	8f060613          	addi	a2,a2,-1808 # ffffffffc020b678 <commands+0x210>
ffffffffc0204d90:	0f800593          	li	a1,248
ffffffffc0204d94:	00008517          	auipc	a0,0x8
ffffffffc0204d98:	f7450513          	addi	a0,a0,-140 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc0204d9c:	f02fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204da0 <file_seek>:
ffffffffc0204da0:	7139                	addi	sp,sp,-64
ffffffffc0204da2:	fc06                	sd	ra,56(sp)
ffffffffc0204da4:	f822                	sd	s0,48(sp)
ffffffffc0204da6:	f426                	sd	s1,40(sp)
ffffffffc0204da8:	f04a                	sd	s2,32(sp)
ffffffffc0204daa:	04700793          	li	a5,71
ffffffffc0204dae:	08a7e863          	bltu	a5,a0,ffffffffc0204e3e <file_seek+0x9e>
ffffffffc0204db2:	00092797          	auipc	a5,0x92
ffffffffc0204db6:	b0e7b783          	ld	a5,-1266(a5) # ffffffffc02968c0 <current>
ffffffffc0204dba:	1487b783          	ld	a5,328(a5)
ffffffffc0204dbe:	cfdd                	beqz	a5,ffffffffc0204e7c <file_seek+0xdc>
ffffffffc0204dc0:	4b98                	lw	a4,16(a5)
ffffffffc0204dc2:	0ae05d63          	blez	a4,ffffffffc0204e7c <file_seek+0xdc>
ffffffffc0204dc6:	6780                	ld	s0,8(a5)
ffffffffc0204dc8:	00351793          	slli	a5,a0,0x3
ffffffffc0204dcc:	8f89                	sub	a5,a5,a0
ffffffffc0204dce:	078e                	slli	a5,a5,0x3
ffffffffc0204dd0:	943e                	add	s0,s0,a5
ffffffffc0204dd2:	4018                	lw	a4,0(s0)
ffffffffc0204dd4:	4789                	li	a5,2
ffffffffc0204dd6:	06f71463          	bne	a4,a5,ffffffffc0204e3e <file_seek+0x9e>
ffffffffc0204dda:	4c1c                	lw	a5,24(s0)
ffffffffc0204ddc:	06a79163          	bne	a5,a0,ffffffffc0204e3e <file_seek+0x9e>
ffffffffc0204de0:	581c                	lw	a5,48(s0)
ffffffffc0204de2:	4685                	li	a3,1
ffffffffc0204de4:	892e                	mv	s2,a1
ffffffffc0204de6:	2785                	addiw	a5,a5,1
ffffffffc0204de8:	d81c                	sw	a5,48(s0)
ffffffffc0204dea:	02d60063          	beq	a2,a3,ffffffffc0204e0a <file_seek+0x6a>
ffffffffc0204dee:	06e60063          	beq	a2,a4,ffffffffc0204e4e <file_seek+0xae>
ffffffffc0204df2:	54f5                	li	s1,-3
ffffffffc0204df4:	ce11                	beqz	a2,ffffffffc0204e10 <file_seek+0x70>
ffffffffc0204df6:	8522                	mv	a0,s0
ffffffffc0204df8:	a8bff0ef          	jal	ra,ffffffffc0204882 <fd_array_release>
ffffffffc0204dfc:	70e2                	ld	ra,56(sp)
ffffffffc0204dfe:	7442                	ld	s0,48(sp)
ffffffffc0204e00:	7902                	ld	s2,32(sp)
ffffffffc0204e02:	8526                	mv	a0,s1
ffffffffc0204e04:	74a2                	ld	s1,40(sp)
ffffffffc0204e06:	6121                	addi	sp,sp,64
ffffffffc0204e08:	8082                	ret
ffffffffc0204e0a:	701c                	ld	a5,32(s0)
ffffffffc0204e0c:	00f58933          	add	s2,a1,a5
ffffffffc0204e10:	7404                	ld	s1,40(s0)
ffffffffc0204e12:	c4bd                	beqz	s1,ffffffffc0204e80 <file_seek+0xe0>
ffffffffc0204e14:	78bc                	ld	a5,112(s1)
ffffffffc0204e16:	c7ad                	beqz	a5,ffffffffc0204e80 <file_seek+0xe0>
ffffffffc0204e18:	6fbc                	ld	a5,88(a5)
ffffffffc0204e1a:	c3bd                	beqz	a5,ffffffffc0204e80 <file_seek+0xe0>
ffffffffc0204e1c:	8526                	mv	a0,s1
ffffffffc0204e1e:	00008597          	auipc	a1,0x8
ffffffffc0204e22:	17a58593          	addi	a1,a1,378 # ffffffffc020cf98 <default_pmm_manager+0xe38>
ffffffffc0204e26:	06d020ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc0204e2a:	78bc                	ld	a5,112(s1)
ffffffffc0204e2c:	7408                	ld	a0,40(s0)
ffffffffc0204e2e:	85ca                	mv	a1,s2
ffffffffc0204e30:	6fbc                	ld	a5,88(a5)
ffffffffc0204e32:	9782                	jalr	a5
ffffffffc0204e34:	84aa                	mv	s1,a0
ffffffffc0204e36:	f161                	bnez	a0,ffffffffc0204df6 <file_seek+0x56>
ffffffffc0204e38:	03243023          	sd	s2,32(s0)
ffffffffc0204e3c:	bf6d                	j	ffffffffc0204df6 <file_seek+0x56>
ffffffffc0204e3e:	70e2                	ld	ra,56(sp)
ffffffffc0204e40:	7442                	ld	s0,48(sp)
ffffffffc0204e42:	54f5                	li	s1,-3
ffffffffc0204e44:	7902                	ld	s2,32(sp)
ffffffffc0204e46:	8526                	mv	a0,s1
ffffffffc0204e48:	74a2                	ld	s1,40(sp)
ffffffffc0204e4a:	6121                	addi	sp,sp,64
ffffffffc0204e4c:	8082                	ret
ffffffffc0204e4e:	7404                	ld	s1,40(s0)
ffffffffc0204e50:	c8a1                	beqz	s1,ffffffffc0204ea0 <file_seek+0x100>
ffffffffc0204e52:	78bc                	ld	a5,112(s1)
ffffffffc0204e54:	c7b1                	beqz	a5,ffffffffc0204ea0 <file_seek+0x100>
ffffffffc0204e56:	779c                	ld	a5,40(a5)
ffffffffc0204e58:	c7a1                	beqz	a5,ffffffffc0204ea0 <file_seek+0x100>
ffffffffc0204e5a:	8526                	mv	a0,s1
ffffffffc0204e5c:	00008597          	auipc	a1,0x8
ffffffffc0204e60:	03458593          	addi	a1,a1,52 # ffffffffc020ce90 <default_pmm_manager+0xd30>
ffffffffc0204e64:	02f020ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc0204e68:	78bc                	ld	a5,112(s1)
ffffffffc0204e6a:	7408                	ld	a0,40(s0)
ffffffffc0204e6c:	858a                	mv	a1,sp
ffffffffc0204e6e:	779c                	ld	a5,40(a5)
ffffffffc0204e70:	9782                	jalr	a5
ffffffffc0204e72:	84aa                	mv	s1,a0
ffffffffc0204e74:	f149                	bnez	a0,ffffffffc0204df6 <file_seek+0x56>
ffffffffc0204e76:	67e2                	ld	a5,24(sp)
ffffffffc0204e78:	993e                	add	s2,s2,a5
ffffffffc0204e7a:	bf59                	j	ffffffffc0204e10 <file_seek+0x70>
ffffffffc0204e7c:	8d5ff0ef          	jal	ra,ffffffffc0204750 <get_fd_array.part.0>
ffffffffc0204e80:	00008697          	auipc	a3,0x8
ffffffffc0204e84:	0c868693          	addi	a3,a3,200 # ffffffffc020cf48 <default_pmm_manager+0xde8>
ffffffffc0204e88:	00006617          	auipc	a2,0x6
ffffffffc0204e8c:	7f060613          	addi	a2,a2,2032 # ffffffffc020b678 <commands+0x210>
ffffffffc0204e90:	11a00593          	li	a1,282
ffffffffc0204e94:	00008517          	auipc	a0,0x8
ffffffffc0204e98:	e7450513          	addi	a0,a0,-396 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc0204e9c:	e02fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204ea0:	00008697          	auipc	a3,0x8
ffffffffc0204ea4:	fa068693          	addi	a3,a3,-96 # ffffffffc020ce40 <default_pmm_manager+0xce0>
ffffffffc0204ea8:	00006617          	auipc	a2,0x6
ffffffffc0204eac:	7d060613          	addi	a2,a2,2000 # ffffffffc020b678 <commands+0x210>
ffffffffc0204eb0:	11200593          	li	a1,274
ffffffffc0204eb4:	00008517          	auipc	a0,0x8
ffffffffc0204eb8:	e5450513          	addi	a0,a0,-428 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc0204ebc:	de2fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204ec0 <file_fstat>:
ffffffffc0204ec0:	1101                	addi	sp,sp,-32
ffffffffc0204ec2:	ec06                	sd	ra,24(sp)
ffffffffc0204ec4:	e822                	sd	s0,16(sp)
ffffffffc0204ec6:	e426                	sd	s1,8(sp)
ffffffffc0204ec8:	e04a                	sd	s2,0(sp)
ffffffffc0204eca:	04700793          	li	a5,71
ffffffffc0204ece:	06a7ef63          	bltu	a5,a0,ffffffffc0204f4c <file_fstat+0x8c>
ffffffffc0204ed2:	00092797          	auipc	a5,0x92
ffffffffc0204ed6:	9ee7b783          	ld	a5,-1554(a5) # ffffffffc02968c0 <current>
ffffffffc0204eda:	1487b783          	ld	a5,328(a5)
ffffffffc0204ede:	cfd9                	beqz	a5,ffffffffc0204f7c <file_fstat+0xbc>
ffffffffc0204ee0:	4b98                	lw	a4,16(a5)
ffffffffc0204ee2:	08e05d63          	blez	a4,ffffffffc0204f7c <file_fstat+0xbc>
ffffffffc0204ee6:	6780                	ld	s0,8(a5)
ffffffffc0204ee8:	00351793          	slli	a5,a0,0x3
ffffffffc0204eec:	8f89                	sub	a5,a5,a0
ffffffffc0204eee:	078e                	slli	a5,a5,0x3
ffffffffc0204ef0:	943e                	add	s0,s0,a5
ffffffffc0204ef2:	4018                	lw	a4,0(s0)
ffffffffc0204ef4:	4789                	li	a5,2
ffffffffc0204ef6:	04f71b63          	bne	a4,a5,ffffffffc0204f4c <file_fstat+0x8c>
ffffffffc0204efa:	4c1c                	lw	a5,24(s0)
ffffffffc0204efc:	04a79863          	bne	a5,a0,ffffffffc0204f4c <file_fstat+0x8c>
ffffffffc0204f00:	581c                	lw	a5,48(s0)
ffffffffc0204f02:	02843903          	ld	s2,40(s0)
ffffffffc0204f06:	2785                	addiw	a5,a5,1
ffffffffc0204f08:	d81c                	sw	a5,48(s0)
ffffffffc0204f0a:	04090963          	beqz	s2,ffffffffc0204f5c <file_fstat+0x9c>
ffffffffc0204f0e:	07093783          	ld	a5,112(s2)
ffffffffc0204f12:	c7a9                	beqz	a5,ffffffffc0204f5c <file_fstat+0x9c>
ffffffffc0204f14:	779c                	ld	a5,40(a5)
ffffffffc0204f16:	c3b9                	beqz	a5,ffffffffc0204f5c <file_fstat+0x9c>
ffffffffc0204f18:	84ae                	mv	s1,a1
ffffffffc0204f1a:	854a                	mv	a0,s2
ffffffffc0204f1c:	00008597          	auipc	a1,0x8
ffffffffc0204f20:	f7458593          	addi	a1,a1,-140 # ffffffffc020ce90 <default_pmm_manager+0xd30>
ffffffffc0204f24:	76e020ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc0204f28:	07093783          	ld	a5,112(s2)
ffffffffc0204f2c:	7408                	ld	a0,40(s0)
ffffffffc0204f2e:	85a6                	mv	a1,s1
ffffffffc0204f30:	779c                	ld	a5,40(a5)
ffffffffc0204f32:	9782                	jalr	a5
ffffffffc0204f34:	87aa                	mv	a5,a0
ffffffffc0204f36:	8522                	mv	a0,s0
ffffffffc0204f38:	843e                	mv	s0,a5
ffffffffc0204f3a:	949ff0ef          	jal	ra,ffffffffc0204882 <fd_array_release>
ffffffffc0204f3e:	60e2                	ld	ra,24(sp)
ffffffffc0204f40:	8522                	mv	a0,s0
ffffffffc0204f42:	6442                	ld	s0,16(sp)
ffffffffc0204f44:	64a2                	ld	s1,8(sp)
ffffffffc0204f46:	6902                	ld	s2,0(sp)
ffffffffc0204f48:	6105                	addi	sp,sp,32
ffffffffc0204f4a:	8082                	ret
ffffffffc0204f4c:	5475                	li	s0,-3
ffffffffc0204f4e:	60e2                	ld	ra,24(sp)
ffffffffc0204f50:	8522                	mv	a0,s0
ffffffffc0204f52:	6442                	ld	s0,16(sp)
ffffffffc0204f54:	64a2                	ld	s1,8(sp)
ffffffffc0204f56:	6902                	ld	s2,0(sp)
ffffffffc0204f58:	6105                	addi	sp,sp,32
ffffffffc0204f5a:	8082                	ret
ffffffffc0204f5c:	00008697          	auipc	a3,0x8
ffffffffc0204f60:	ee468693          	addi	a3,a3,-284 # ffffffffc020ce40 <default_pmm_manager+0xce0>
ffffffffc0204f64:	00006617          	auipc	a2,0x6
ffffffffc0204f68:	71460613          	addi	a2,a2,1812 # ffffffffc020b678 <commands+0x210>
ffffffffc0204f6c:	12c00593          	li	a1,300
ffffffffc0204f70:	00008517          	auipc	a0,0x8
ffffffffc0204f74:	d9850513          	addi	a0,a0,-616 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc0204f78:	d26fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204f7c:	fd4ff0ef          	jal	ra,ffffffffc0204750 <get_fd_array.part.0>

ffffffffc0204f80 <file_fsync>:
ffffffffc0204f80:	1101                	addi	sp,sp,-32
ffffffffc0204f82:	ec06                	sd	ra,24(sp)
ffffffffc0204f84:	e822                	sd	s0,16(sp)
ffffffffc0204f86:	e426                	sd	s1,8(sp)
ffffffffc0204f88:	04700793          	li	a5,71
ffffffffc0204f8c:	06a7e863          	bltu	a5,a0,ffffffffc0204ffc <file_fsync+0x7c>
ffffffffc0204f90:	00092797          	auipc	a5,0x92
ffffffffc0204f94:	9307b783          	ld	a5,-1744(a5) # ffffffffc02968c0 <current>
ffffffffc0204f98:	1487b783          	ld	a5,328(a5)
ffffffffc0204f9c:	c7d9                	beqz	a5,ffffffffc020502a <file_fsync+0xaa>
ffffffffc0204f9e:	4b98                	lw	a4,16(a5)
ffffffffc0204fa0:	08e05563          	blez	a4,ffffffffc020502a <file_fsync+0xaa>
ffffffffc0204fa4:	6780                	ld	s0,8(a5)
ffffffffc0204fa6:	00351793          	slli	a5,a0,0x3
ffffffffc0204faa:	8f89                	sub	a5,a5,a0
ffffffffc0204fac:	078e                	slli	a5,a5,0x3
ffffffffc0204fae:	943e                	add	s0,s0,a5
ffffffffc0204fb0:	4018                	lw	a4,0(s0)
ffffffffc0204fb2:	4789                	li	a5,2
ffffffffc0204fb4:	04f71463          	bne	a4,a5,ffffffffc0204ffc <file_fsync+0x7c>
ffffffffc0204fb8:	4c1c                	lw	a5,24(s0)
ffffffffc0204fba:	04a79163          	bne	a5,a0,ffffffffc0204ffc <file_fsync+0x7c>
ffffffffc0204fbe:	581c                	lw	a5,48(s0)
ffffffffc0204fc0:	7404                	ld	s1,40(s0)
ffffffffc0204fc2:	2785                	addiw	a5,a5,1
ffffffffc0204fc4:	d81c                	sw	a5,48(s0)
ffffffffc0204fc6:	c0b1                	beqz	s1,ffffffffc020500a <file_fsync+0x8a>
ffffffffc0204fc8:	78bc                	ld	a5,112(s1)
ffffffffc0204fca:	c3a1                	beqz	a5,ffffffffc020500a <file_fsync+0x8a>
ffffffffc0204fcc:	7b9c                	ld	a5,48(a5)
ffffffffc0204fce:	cf95                	beqz	a5,ffffffffc020500a <file_fsync+0x8a>
ffffffffc0204fd0:	00008597          	auipc	a1,0x8
ffffffffc0204fd4:	02058593          	addi	a1,a1,32 # ffffffffc020cff0 <default_pmm_manager+0xe90>
ffffffffc0204fd8:	8526                	mv	a0,s1
ffffffffc0204fda:	6b8020ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc0204fde:	78bc                	ld	a5,112(s1)
ffffffffc0204fe0:	7408                	ld	a0,40(s0)
ffffffffc0204fe2:	7b9c                	ld	a5,48(a5)
ffffffffc0204fe4:	9782                	jalr	a5
ffffffffc0204fe6:	87aa                	mv	a5,a0
ffffffffc0204fe8:	8522                	mv	a0,s0
ffffffffc0204fea:	843e                	mv	s0,a5
ffffffffc0204fec:	897ff0ef          	jal	ra,ffffffffc0204882 <fd_array_release>
ffffffffc0204ff0:	60e2                	ld	ra,24(sp)
ffffffffc0204ff2:	8522                	mv	a0,s0
ffffffffc0204ff4:	6442                	ld	s0,16(sp)
ffffffffc0204ff6:	64a2                	ld	s1,8(sp)
ffffffffc0204ff8:	6105                	addi	sp,sp,32
ffffffffc0204ffa:	8082                	ret
ffffffffc0204ffc:	5475                	li	s0,-3
ffffffffc0204ffe:	60e2                	ld	ra,24(sp)
ffffffffc0205000:	8522                	mv	a0,s0
ffffffffc0205002:	6442                	ld	s0,16(sp)
ffffffffc0205004:	64a2                	ld	s1,8(sp)
ffffffffc0205006:	6105                	addi	sp,sp,32
ffffffffc0205008:	8082                	ret
ffffffffc020500a:	00008697          	auipc	a3,0x8
ffffffffc020500e:	f9668693          	addi	a3,a3,-106 # ffffffffc020cfa0 <default_pmm_manager+0xe40>
ffffffffc0205012:	00006617          	auipc	a2,0x6
ffffffffc0205016:	66660613          	addi	a2,a2,1638 # ffffffffc020b678 <commands+0x210>
ffffffffc020501a:	13a00593          	li	a1,314
ffffffffc020501e:	00008517          	auipc	a0,0x8
ffffffffc0205022:	cea50513          	addi	a0,a0,-790 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc0205026:	c78fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020502a:	f26ff0ef          	jal	ra,ffffffffc0204750 <get_fd_array.part.0>

ffffffffc020502e <file_getdirentry>:
ffffffffc020502e:	715d                	addi	sp,sp,-80
ffffffffc0205030:	e486                	sd	ra,72(sp)
ffffffffc0205032:	e0a2                	sd	s0,64(sp)
ffffffffc0205034:	fc26                	sd	s1,56(sp)
ffffffffc0205036:	f84a                	sd	s2,48(sp)
ffffffffc0205038:	f44e                	sd	s3,40(sp)
ffffffffc020503a:	04700793          	li	a5,71
ffffffffc020503e:	0aa7e063          	bltu	a5,a0,ffffffffc02050de <file_getdirentry+0xb0>
ffffffffc0205042:	00092797          	auipc	a5,0x92
ffffffffc0205046:	87e7b783          	ld	a5,-1922(a5) # ffffffffc02968c0 <current>
ffffffffc020504a:	1487b783          	ld	a5,328(a5)
ffffffffc020504e:	c3e9                	beqz	a5,ffffffffc0205110 <file_getdirentry+0xe2>
ffffffffc0205050:	4b98                	lw	a4,16(a5)
ffffffffc0205052:	0ae05f63          	blez	a4,ffffffffc0205110 <file_getdirentry+0xe2>
ffffffffc0205056:	6780                	ld	s0,8(a5)
ffffffffc0205058:	00351793          	slli	a5,a0,0x3
ffffffffc020505c:	8f89                	sub	a5,a5,a0
ffffffffc020505e:	078e                	slli	a5,a5,0x3
ffffffffc0205060:	943e                	add	s0,s0,a5
ffffffffc0205062:	4018                	lw	a4,0(s0)
ffffffffc0205064:	4789                	li	a5,2
ffffffffc0205066:	06f71c63          	bne	a4,a5,ffffffffc02050de <file_getdirentry+0xb0>
ffffffffc020506a:	4c1c                	lw	a5,24(s0)
ffffffffc020506c:	06a79963          	bne	a5,a0,ffffffffc02050de <file_getdirentry+0xb0>
ffffffffc0205070:	581c                	lw	a5,48(s0)
ffffffffc0205072:	6194                	ld	a3,0(a1)
ffffffffc0205074:	84ae                	mv	s1,a1
ffffffffc0205076:	2785                	addiw	a5,a5,1
ffffffffc0205078:	10000613          	li	a2,256
ffffffffc020507c:	d81c                	sw	a5,48(s0)
ffffffffc020507e:	05a1                	addi	a1,a1,8
ffffffffc0205080:	850a                	mv	a0,sp
ffffffffc0205082:	33e000ef          	jal	ra,ffffffffc02053c0 <iobuf_init>
ffffffffc0205086:	02843983          	ld	s3,40(s0)
ffffffffc020508a:	892a                	mv	s2,a0
ffffffffc020508c:	06098263          	beqz	s3,ffffffffc02050f0 <file_getdirentry+0xc2>
ffffffffc0205090:	0709b783          	ld	a5,112(s3) # 1070 <_binary_bin_swap_img_size-0x6c90>
ffffffffc0205094:	cfb1                	beqz	a5,ffffffffc02050f0 <file_getdirentry+0xc2>
ffffffffc0205096:	63bc                	ld	a5,64(a5)
ffffffffc0205098:	cfa1                	beqz	a5,ffffffffc02050f0 <file_getdirentry+0xc2>
ffffffffc020509a:	854e                	mv	a0,s3
ffffffffc020509c:	00008597          	auipc	a1,0x8
ffffffffc02050a0:	fb458593          	addi	a1,a1,-76 # ffffffffc020d050 <default_pmm_manager+0xef0>
ffffffffc02050a4:	5ee020ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc02050a8:	0709b783          	ld	a5,112(s3)
ffffffffc02050ac:	7408                	ld	a0,40(s0)
ffffffffc02050ae:	85ca                	mv	a1,s2
ffffffffc02050b0:	63bc                	ld	a5,64(a5)
ffffffffc02050b2:	9782                	jalr	a5
ffffffffc02050b4:	89aa                	mv	s3,a0
ffffffffc02050b6:	e909                	bnez	a0,ffffffffc02050c8 <file_getdirentry+0x9a>
ffffffffc02050b8:	609c                	ld	a5,0(s1)
ffffffffc02050ba:	01093683          	ld	a3,16(s2)
ffffffffc02050be:	01893703          	ld	a4,24(s2)
ffffffffc02050c2:	97b6                	add	a5,a5,a3
ffffffffc02050c4:	8f99                	sub	a5,a5,a4
ffffffffc02050c6:	e09c                	sd	a5,0(s1)
ffffffffc02050c8:	8522                	mv	a0,s0
ffffffffc02050ca:	fb8ff0ef          	jal	ra,ffffffffc0204882 <fd_array_release>
ffffffffc02050ce:	60a6                	ld	ra,72(sp)
ffffffffc02050d0:	6406                	ld	s0,64(sp)
ffffffffc02050d2:	74e2                	ld	s1,56(sp)
ffffffffc02050d4:	7942                	ld	s2,48(sp)
ffffffffc02050d6:	854e                	mv	a0,s3
ffffffffc02050d8:	79a2                	ld	s3,40(sp)
ffffffffc02050da:	6161                	addi	sp,sp,80
ffffffffc02050dc:	8082                	ret
ffffffffc02050de:	60a6                	ld	ra,72(sp)
ffffffffc02050e0:	6406                	ld	s0,64(sp)
ffffffffc02050e2:	59f5                	li	s3,-3
ffffffffc02050e4:	74e2                	ld	s1,56(sp)
ffffffffc02050e6:	7942                	ld	s2,48(sp)
ffffffffc02050e8:	854e                	mv	a0,s3
ffffffffc02050ea:	79a2                	ld	s3,40(sp)
ffffffffc02050ec:	6161                	addi	sp,sp,80
ffffffffc02050ee:	8082                	ret
ffffffffc02050f0:	00008697          	auipc	a3,0x8
ffffffffc02050f4:	f0868693          	addi	a3,a3,-248 # ffffffffc020cff8 <default_pmm_manager+0xe98>
ffffffffc02050f8:	00006617          	auipc	a2,0x6
ffffffffc02050fc:	58060613          	addi	a2,a2,1408 # ffffffffc020b678 <commands+0x210>
ffffffffc0205100:	14a00593          	li	a1,330
ffffffffc0205104:	00008517          	auipc	a0,0x8
ffffffffc0205108:	c0450513          	addi	a0,a0,-1020 # ffffffffc020cd08 <default_pmm_manager+0xba8>
ffffffffc020510c:	b92fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205110:	e40ff0ef          	jal	ra,ffffffffc0204750 <get_fd_array.part.0>

ffffffffc0205114 <file_dup>:
ffffffffc0205114:	04700713          	li	a4,71
ffffffffc0205118:	06a76463          	bltu	a4,a0,ffffffffc0205180 <file_dup+0x6c>
ffffffffc020511c:	00091717          	auipc	a4,0x91
ffffffffc0205120:	7a473703          	ld	a4,1956(a4) # ffffffffc02968c0 <current>
ffffffffc0205124:	14873703          	ld	a4,328(a4)
ffffffffc0205128:	1101                	addi	sp,sp,-32
ffffffffc020512a:	ec06                	sd	ra,24(sp)
ffffffffc020512c:	e822                	sd	s0,16(sp)
ffffffffc020512e:	cb39                	beqz	a4,ffffffffc0205184 <file_dup+0x70>
ffffffffc0205130:	4b14                	lw	a3,16(a4)
ffffffffc0205132:	04d05963          	blez	a3,ffffffffc0205184 <file_dup+0x70>
ffffffffc0205136:	6700                	ld	s0,8(a4)
ffffffffc0205138:	00351713          	slli	a4,a0,0x3
ffffffffc020513c:	8f09                	sub	a4,a4,a0
ffffffffc020513e:	070e                	slli	a4,a4,0x3
ffffffffc0205140:	943a                	add	s0,s0,a4
ffffffffc0205142:	4014                	lw	a3,0(s0)
ffffffffc0205144:	4709                	li	a4,2
ffffffffc0205146:	02e69863          	bne	a3,a4,ffffffffc0205176 <file_dup+0x62>
ffffffffc020514a:	4c18                	lw	a4,24(s0)
ffffffffc020514c:	02a71563          	bne	a4,a0,ffffffffc0205176 <file_dup+0x62>
ffffffffc0205150:	852e                	mv	a0,a1
ffffffffc0205152:	002c                	addi	a1,sp,8
ffffffffc0205154:	e1eff0ef          	jal	ra,ffffffffc0204772 <fd_array_alloc>
ffffffffc0205158:	c509                	beqz	a0,ffffffffc0205162 <file_dup+0x4e>
ffffffffc020515a:	60e2                	ld	ra,24(sp)
ffffffffc020515c:	6442                	ld	s0,16(sp)
ffffffffc020515e:	6105                	addi	sp,sp,32
ffffffffc0205160:	8082                	ret
ffffffffc0205162:	6522                	ld	a0,8(sp)
ffffffffc0205164:	85a2                	mv	a1,s0
ffffffffc0205166:	845ff0ef          	jal	ra,ffffffffc02049aa <fd_array_dup>
ffffffffc020516a:	67a2                	ld	a5,8(sp)
ffffffffc020516c:	60e2                	ld	ra,24(sp)
ffffffffc020516e:	6442                	ld	s0,16(sp)
ffffffffc0205170:	4f88                	lw	a0,24(a5)
ffffffffc0205172:	6105                	addi	sp,sp,32
ffffffffc0205174:	8082                	ret
ffffffffc0205176:	60e2                	ld	ra,24(sp)
ffffffffc0205178:	6442                	ld	s0,16(sp)
ffffffffc020517a:	5575                	li	a0,-3
ffffffffc020517c:	6105                	addi	sp,sp,32
ffffffffc020517e:	8082                	ret
ffffffffc0205180:	5575                	li	a0,-3
ffffffffc0205182:	8082                	ret
ffffffffc0205184:	dccff0ef          	jal	ra,ffffffffc0204750 <get_fd_array.part.0>

ffffffffc0205188 <fs_init>:
ffffffffc0205188:	1141                	addi	sp,sp,-16
ffffffffc020518a:	e406                	sd	ra,8(sp)
ffffffffc020518c:	724020ef          	jal	ra,ffffffffc02078b0 <vfs_init>
ffffffffc0205190:	3fc030ef          	jal	ra,ffffffffc020858c <dev_init>
ffffffffc0205194:	60a2                	ld	ra,8(sp)
ffffffffc0205196:	0141                	addi	sp,sp,16
ffffffffc0205198:	54d0306f          	j	ffffffffc0208ee4 <sfs_init>

ffffffffc020519c <fs_cleanup>:
ffffffffc020519c:	1670206f          	j	ffffffffc0207b02 <vfs_cleanup>

ffffffffc02051a0 <lock_files>:
ffffffffc02051a0:	0561                	addi	a0,a0,24
ffffffffc02051a2:	ba0ff06f          	j	ffffffffc0204542 <down>

ffffffffc02051a6 <unlock_files>:
ffffffffc02051a6:	0561                	addi	a0,a0,24
ffffffffc02051a8:	b96ff06f          	j	ffffffffc020453e <up>

ffffffffc02051ac <files_create>:
ffffffffc02051ac:	1141                	addi	sp,sp,-16
ffffffffc02051ae:	6505                	lui	a0,0x1
ffffffffc02051b0:	e022                	sd	s0,0(sp)
ffffffffc02051b2:	e406                	sd	ra,8(sp)
ffffffffc02051b4:	ddbfc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02051b8:	842a                	mv	s0,a0
ffffffffc02051ba:	cd19                	beqz	a0,ffffffffc02051d8 <files_create+0x2c>
ffffffffc02051bc:	03050793          	addi	a5,a0,48 # 1030 <_binary_bin_swap_img_size-0x6cd0>
ffffffffc02051c0:	00043023          	sd	zero,0(s0)
ffffffffc02051c4:	0561                	addi	a0,a0,24
ffffffffc02051c6:	e41c                	sd	a5,8(s0)
ffffffffc02051c8:	00042823          	sw	zero,16(s0)
ffffffffc02051cc:	4585                	li	a1,1
ffffffffc02051ce:	b6aff0ef          	jal	ra,ffffffffc0204538 <sem_init>
ffffffffc02051d2:	6408                	ld	a0,8(s0)
ffffffffc02051d4:	f3cff0ef          	jal	ra,ffffffffc0204910 <fd_array_init>
ffffffffc02051d8:	60a2                	ld	ra,8(sp)
ffffffffc02051da:	8522                	mv	a0,s0
ffffffffc02051dc:	6402                	ld	s0,0(sp)
ffffffffc02051de:	0141                	addi	sp,sp,16
ffffffffc02051e0:	8082                	ret

ffffffffc02051e2 <files_destroy>:
ffffffffc02051e2:	7179                	addi	sp,sp,-48
ffffffffc02051e4:	f406                	sd	ra,40(sp)
ffffffffc02051e6:	f022                	sd	s0,32(sp)
ffffffffc02051e8:	ec26                	sd	s1,24(sp)
ffffffffc02051ea:	e84a                	sd	s2,16(sp)
ffffffffc02051ec:	e44e                	sd	s3,8(sp)
ffffffffc02051ee:	c52d                	beqz	a0,ffffffffc0205258 <files_destroy+0x76>
ffffffffc02051f0:	491c                	lw	a5,16(a0)
ffffffffc02051f2:	89aa                	mv	s3,a0
ffffffffc02051f4:	e3b5                	bnez	a5,ffffffffc0205258 <files_destroy+0x76>
ffffffffc02051f6:	6108                	ld	a0,0(a0)
ffffffffc02051f8:	c119                	beqz	a0,ffffffffc02051fe <files_destroy+0x1c>
ffffffffc02051fa:	54e020ef          	jal	ra,ffffffffc0207748 <inode_ref_dec>
ffffffffc02051fe:	0089b403          	ld	s0,8(s3)
ffffffffc0205202:	6485                	lui	s1,0x1
ffffffffc0205204:	fc048493          	addi	s1,s1,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0205208:	94a2                	add	s1,s1,s0
ffffffffc020520a:	4909                	li	s2,2
ffffffffc020520c:	401c                	lw	a5,0(s0)
ffffffffc020520e:	03278063          	beq	a5,s2,ffffffffc020522e <files_destroy+0x4c>
ffffffffc0205212:	e39d                	bnez	a5,ffffffffc0205238 <files_destroy+0x56>
ffffffffc0205214:	03840413          	addi	s0,s0,56
ffffffffc0205218:	fe849ae3          	bne	s1,s0,ffffffffc020520c <files_destroy+0x2a>
ffffffffc020521c:	7402                	ld	s0,32(sp)
ffffffffc020521e:	70a2                	ld	ra,40(sp)
ffffffffc0205220:	64e2                	ld	s1,24(sp)
ffffffffc0205222:	6942                	ld	s2,16(sp)
ffffffffc0205224:	854e                	mv	a0,s3
ffffffffc0205226:	69a2                	ld	s3,8(sp)
ffffffffc0205228:	6145                	addi	sp,sp,48
ffffffffc020522a:	e15fc06f          	j	ffffffffc020203e <kfree>
ffffffffc020522e:	8522                	mv	a0,s0
ffffffffc0205230:	efcff0ef          	jal	ra,ffffffffc020492c <fd_array_close>
ffffffffc0205234:	401c                	lw	a5,0(s0)
ffffffffc0205236:	bff1                	j	ffffffffc0205212 <files_destroy+0x30>
ffffffffc0205238:	00008697          	auipc	a3,0x8
ffffffffc020523c:	e9868693          	addi	a3,a3,-360 # ffffffffc020d0d0 <CSWTCH.79+0x58>
ffffffffc0205240:	00006617          	auipc	a2,0x6
ffffffffc0205244:	43860613          	addi	a2,a2,1080 # ffffffffc020b678 <commands+0x210>
ffffffffc0205248:	03d00593          	li	a1,61
ffffffffc020524c:	00008517          	auipc	a0,0x8
ffffffffc0205250:	e7450513          	addi	a0,a0,-396 # ffffffffc020d0c0 <CSWTCH.79+0x48>
ffffffffc0205254:	a4afb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205258:	00008697          	auipc	a3,0x8
ffffffffc020525c:	e3868693          	addi	a3,a3,-456 # ffffffffc020d090 <CSWTCH.79+0x18>
ffffffffc0205260:	00006617          	auipc	a2,0x6
ffffffffc0205264:	41860613          	addi	a2,a2,1048 # ffffffffc020b678 <commands+0x210>
ffffffffc0205268:	03300593          	li	a1,51
ffffffffc020526c:	00008517          	auipc	a0,0x8
ffffffffc0205270:	e5450513          	addi	a0,a0,-428 # ffffffffc020d0c0 <CSWTCH.79+0x48>
ffffffffc0205274:	a2afb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205278 <files_closeall>:
ffffffffc0205278:	1101                	addi	sp,sp,-32
ffffffffc020527a:	ec06                	sd	ra,24(sp)
ffffffffc020527c:	e822                	sd	s0,16(sp)
ffffffffc020527e:	e426                	sd	s1,8(sp)
ffffffffc0205280:	e04a                	sd	s2,0(sp)
ffffffffc0205282:	c129                	beqz	a0,ffffffffc02052c4 <files_closeall+0x4c>
ffffffffc0205284:	491c                	lw	a5,16(a0)
ffffffffc0205286:	02f05f63          	blez	a5,ffffffffc02052c4 <files_closeall+0x4c>
ffffffffc020528a:	6504                	ld	s1,8(a0)
ffffffffc020528c:	6785                	lui	a5,0x1
ffffffffc020528e:	fc078793          	addi	a5,a5,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0205292:	07048413          	addi	s0,s1,112
ffffffffc0205296:	4909                	li	s2,2
ffffffffc0205298:	94be                	add	s1,s1,a5
ffffffffc020529a:	a029                	j	ffffffffc02052a4 <files_closeall+0x2c>
ffffffffc020529c:	03840413          	addi	s0,s0,56
ffffffffc02052a0:	00848c63          	beq	s1,s0,ffffffffc02052b8 <files_closeall+0x40>
ffffffffc02052a4:	401c                	lw	a5,0(s0)
ffffffffc02052a6:	ff279be3          	bne	a5,s2,ffffffffc020529c <files_closeall+0x24>
ffffffffc02052aa:	8522                	mv	a0,s0
ffffffffc02052ac:	03840413          	addi	s0,s0,56
ffffffffc02052b0:	e7cff0ef          	jal	ra,ffffffffc020492c <fd_array_close>
ffffffffc02052b4:	fe8498e3          	bne	s1,s0,ffffffffc02052a4 <files_closeall+0x2c>
ffffffffc02052b8:	60e2                	ld	ra,24(sp)
ffffffffc02052ba:	6442                	ld	s0,16(sp)
ffffffffc02052bc:	64a2                	ld	s1,8(sp)
ffffffffc02052be:	6902                	ld	s2,0(sp)
ffffffffc02052c0:	6105                	addi	sp,sp,32
ffffffffc02052c2:	8082                	ret
ffffffffc02052c4:	00008697          	auipc	a3,0x8
ffffffffc02052c8:	a1468693          	addi	a3,a3,-1516 # ffffffffc020ccd8 <default_pmm_manager+0xb78>
ffffffffc02052cc:	00006617          	auipc	a2,0x6
ffffffffc02052d0:	3ac60613          	addi	a2,a2,940 # ffffffffc020b678 <commands+0x210>
ffffffffc02052d4:	04500593          	li	a1,69
ffffffffc02052d8:	00008517          	auipc	a0,0x8
ffffffffc02052dc:	de850513          	addi	a0,a0,-536 # ffffffffc020d0c0 <CSWTCH.79+0x48>
ffffffffc02052e0:	9befb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02052e4 <dup_files>:
ffffffffc02052e4:	7179                	addi	sp,sp,-48
ffffffffc02052e6:	f406                	sd	ra,40(sp)
ffffffffc02052e8:	f022                	sd	s0,32(sp)
ffffffffc02052ea:	ec26                	sd	s1,24(sp)
ffffffffc02052ec:	e84a                	sd	s2,16(sp)
ffffffffc02052ee:	e44e                	sd	s3,8(sp)
ffffffffc02052f0:	e052                	sd	s4,0(sp)
ffffffffc02052f2:	c52d                	beqz	a0,ffffffffc020535c <dup_files+0x78>
ffffffffc02052f4:	842e                	mv	s0,a1
ffffffffc02052f6:	c1bd                	beqz	a1,ffffffffc020535c <dup_files+0x78>
ffffffffc02052f8:	491c                	lw	a5,16(a0)
ffffffffc02052fa:	84aa                	mv	s1,a0
ffffffffc02052fc:	e3c1                	bnez	a5,ffffffffc020537c <dup_files+0x98>
ffffffffc02052fe:	499c                	lw	a5,16(a1)
ffffffffc0205300:	06f05e63          	blez	a5,ffffffffc020537c <dup_files+0x98>
ffffffffc0205304:	6188                	ld	a0,0(a1)
ffffffffc0205306:	e088                	sd	a0,0(s1)
ffffffffc0205308:	c119                	beqz	a0,ffffffffc020530e <dup_files+0x2a>
ffffffffc020530a:	370020ef          	jal	ra,ffffffffc020767a <inode_ref_inc>
ffffffffc020530e:	6400                	ld	s0,8(s0)
ffffffffc0205310:	6905                	lui	s2,0x1
ffffffffc0205312:	fc090913          	addi	s2,s2,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0205316:	6484                	ld	s1,8(s1)
ffffffffc0205318:	9922                	add	s2,s2,s0
ffffffffc020531a:	4989                	li	s3,2
ffffffffc020531c:	4a05                	li	s4,1
ffffffffc020531e:	a039                	j	ffffffffc020532c <dup_files+0x48>
ffffffffc0205320:	03840413          	addi	s0,s0,56
ffffffffc0205324:	03848493          	addi	s1,s1,56
ffffffffc0205328:	02890163          	beq	s2,s0,ffffffffc020534a <dup_files+0x66>
ffffffffc020532c:	401c                	lw	a5,0(s0)
ffffffffc020532e:	ff3799e3          	bne	a5,s3,ffffffffc0205320 <dup_files+0x3c>
ffffffffc0205332:	0144a023          	sw	s4,0(s1)
ffffffffc0205336:	85a2                	mv	a1,s0
ffffffffc0205338:	8526                	mv	a0,s1
ffffffffc020533a:	03840413          	addi	s0,s0,56
ffffffffc020533e:	e6cff0ef          	jal	ra,ffffffffc02049aa <fd_array_dup>
ffffffffc0205342:	03848493          	addi	s1,s1,56
ffffffffc0205346:	fe8913e3          	bne	s2,s0,ffffffffc020532c <dup_files+0x48>
ffffffffc020534a:	70a2                	ld	ra,40(sp)
ffffffffc020534c:	7402                	ld	s0,32(sp)
ffffffffc020534e:	64e2                	ld	s1,24(sp)
ffffffffc0205350:	6942                	ld	s2,16(sp)
ffffffffc0205352:	69a2                	ld	s3,8(sp)
ffffffffc0205354:	6a02                	ld	s4,0(sp)
ffffffffc0205356:	4501                	li	a0,0
ffffffffc0205358:	6145                	addi	sp,sp,48
ffffffffc020535a:	8082                	ret
ffffffffc020535c:	00007697          	auipc	a3,0x7
ffffffffc0205360:	6cc68693          	addi	a3,a3,1740 # ffffffffc020ca28 <default_pmm_manager+0x8c8>
ffffffffc0205364:	00006617          	auipc	a2,0x6
ffffffffc0205368:	31460613          	addi	a2,a2,788 # ffffffffc020b678 <commands+0x210>
ffffffffc020536c:	05300593          	li	a1,83
ffffffffc0205370:	00008517          	auipc	a0,0x8
ffffffffc0205374:	d5050513          	addi	a0,a0,-688 # ffffffffc020d0c0 <CSWTCH.79+0x48>
ffffffffc0205378:	926fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020537c:	00008697          	auipc	a3,0x8
ffffffffc0205380:	d6c68693          	addi	a3,a3,-660 # ffffffffc020d0e8 <CSWTCH.79+0x70>
ffffffffc0205384:	00006617          	auipc	a2,0x6
ffffffffc0205388:	2f460613          	addi	a2,a2,756 # ffffffffc020b678 <commands+0x210>
ffffffffc020538c:	05400593          	li	a1,84
ffffffffc0205390:	00008517          	auipc	a0,0x8
ffffffffc0205394:	d3050513          	addi	a0,a0,-720 # ffffffffc020d0c0 <CSWTCH.79+0x48>
ffffffffc0205398:	906fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020539c <iobuf_skip.part.0>:
ffffffffc020539c:	1141                	addi	sp,sp,-16
ffffffffc020539e:	00008697          	auipc	a3,0x8
ffffffffc02053a2:	d7a68693          	addi	a3,a3,-646 # ffffffffc020d118 <CSWTCH.79+0xa0>
ffffffffc02053a6:	00006617          	auipc	a2,0x6
ffffffffc02053aa:	2d260613          	addi	a2,a2,722 # ffffffffc020b678 <commands+0x210>
ffffffffc02053ae:	04a00593          	li	a1,74
ffffffffc02053b2:	00008517          	auipc	a0,0x8
ffffffffc02053b6:	d7e50513          	addi	a0,a0,-642 # ffffffffc020d130 <CSWTCH.79+0xb8>
ffffffffc02053ba:	e406                	sd	ra,8(sp)
ffffffffc02053bc:	8e2fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02053c0 <iobuf_init>:
ffffffffc02053c0:	e10c                	sd	a1,0(a0)
ffffffffc02053c2:	e514                	sd	a3,8(a0)
ffffffffc02053c4:	ed10                	sd	a2,24(a0)
ffffffffc02053c6:	e910                	sd	a2,16(a0)
ffffffffc02053c8:	8082                	ret

ffffffffc02053ca <iobuf_move>:
ffffffffc02053ca:	7179                	addi	sp,sp,-48
ffffffffc02053cc:	ec26                	sd	s1,24(sp)
ffffffffc02053ce:	6d04                	ld	s1,24(a0)
ffffffffc02053d0:	f022                	sd	s0,32(sp)
ffffffffc02053d2:	e84a                	sd	s2,16(sp)
ffffffffc02053d4:	e44e                	sd	s3,8(sp)
ffffffffc02053d6:	f406                	sd	ra,40(sp)
ffffffffc02053d8:	842a                	mv	s0,a0
ffffffffc02053da:	8932                	mv	s2,a2
ffffffffc02053dc:	852e                	mv	a0,a1
ffffffffc02053de:	89ba                	mv	s3,a4
ffffffffc02053e0:	00967363          	bgeu	a2,s1,ffffffffc02053e6 <iobuf_move+0x1c>
ffffffffc02053e4:	84b2                	mv	s1,a2
ffffffffc02053e6:	c495                	beqz	s1,ffffffffc0205412 <iobuf_move+0x48>
ffffffffc02053e8:	600c                	ld	a1,0(s0)
ffffffffc02053ea:	c681                	beqz	a3,ffffffffc02053f2 <iobuf_move+0x28>
ffffffffc02053ec:	87ae                	mv	a5,a1
ffffffffc02053ee:	85aa                	mv	a1,a0
ffffffffc02053f0:	853e                	mv	a0,a5
ffffffffc02053f2:	8626                	mv	a2,s1
ffffffffc02053f4:	5b3050ef          	jal	ra,ffffffffc020b1a6 <memmove>
ffffffffc02053f8:	6c1c                	ld	a5,24(s0)
ffffffffc02053fa:	0297ea63          	bltu	a5,s1,ffffffffc020542e <iobuf_move+0x64>
ffffffffc02053fe:	6014                	ld	a3,0(s0)
ffffffffc0205400:	6418                	ld	a4,8(s0)
ffffffffc0205402:	8f85                	sub	a5,a5,s1
ffffffffc0205404:	96a6                	add	a3,a3,s1
ffffffffc0205406:	9726                	add	a4,a4,s1
ffffffffc0205408:	e014                	sd	a3,0(s0)
ffffffffc020540a:	e418                	sd	a4,8(s0)
ffffffffc020540c:	ec1c                	sd	a5,24(s0)
ffffffffc020540e:	40990933          	sub	s2,s2,s1
ffffffffc0205412:	00098463          	beqz	s3,ffffffffc020541a <iobuf_move+0x50>
ffffffffc0205416:	0099b023          	sd	s1,0(s3)
ffffffffc020541a:	4501                	li	a0,0
ffffffffc020541c:	00091b63          	bnez	s2,ffffffffc0205432 <iobuf_move+0x68>
ffffffffc0205420:	70a2                	ld	ra,40(sp)
ffffffffc0205422:	7402                	ld	s0,32(sp)
ffffffffc0205424:	64e2                	ld	s1,24(sp)
ffffffffc0205426:	6942                	ld	s2,16(sp)
ffffffffc0205428:	69a2                	ld	s3,8(sp)
ffffffffc020542a:	6145                	addi	sp,sp,48
ffffffffc020542c:	8082                	ret
ffffffffc020542e:	f6fff0ef          	jal	ra,ffffffffc020539c <iobuf_skip.part.0>
ffffffffc0205432:	5571                	li	a0,-4
ffffffffc0205434:	b7f5                	j	ffffffffc0205420 <iobuf_move+0x56>

ffffffffc0205436 <iobuf_skip>:
ffffffffc0205436:	6d1c                	ld	a5,24(a0)
ffffffffc0205438:	00b7eb63          	bltu	a5,a1,ffffffffc020544e <iobuf_skip+0x18>
ffffffffc020543c:	6114                	ld	a3,0(a0)
ffffffffc020543e:	6518                	ld	a4,8(a0)
ffffffffc0205440:	8f8d                	sub	a5,a5,a1
ffffffffc0205442:	96ae                	add	a3,a3,a1
ffffffffc0205444:	95ba                	add	a1,a1,a4
ffffffffc0205446:	e114                	sd	a3,0(a0)
ffffffffc0205448:	e50c                	sd	a1,8(a0)
ffffffffc020544a:	ed1c                	sd	a5,24(a0)
ffffffffc020544c:	8082                	ret
ffffffffc020544e:	1141                	addi	sp,sp,-16
ffffffffc0205450:	e406                	sd	ra,8(sp)
ffffffffc0205452:	f4bff0ef          	jal	ra,ffffffffc020539c <iobuf_skip.part.0>

ffffffffc0205456 <copy_path>:
ffffffffc0205456:	7139                	addi	sp,sp,-64
ffffffffc0205458:	f04a                	sd	s2,32(sp)
ffffffffc020545a:	00091917          	auipc	s2,0x91
ffffffffc020545e:	46690913          	addi	s2,s2,1126 # ffffffffc02968c0 <current>
ffffffffc0205462:	00093703          	ld	a4,0(s2)
ffffffffc0205466:	ec4e                	sd	s3,24(sp)
ffffffffc0205468:	89aa                	mv	s3,a0
ffffffffc020546a:	6505                	lui	a0,0x1
ffffffffc020546c:	f426                	sd	s1,40(sp)
ffffffffc020546e:	e852                	sd	s4,16(sp)
ffffffffc0205470:	fc06                	sd	ra,56(sp)
ffffffffc0205472:	f822                	sd	s0,48(sp)
ffffffffc0205474:	e456                	sd	s5,8(sp)
ffffffffc0205476:	02873a03          	ld	s4,40(a4)
ffffffffc020547a:	84ae                	mv	s1,a1
ffffffffc020547c:	b13fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205480:	c141                	beqz	a0,ffffffffc0205500 <copy_path+0xaa>
ffffffffc0205482:	842a                	mv	s0,a0
ffffffffc0205484:	040a0563          	beqz	s4,ffffffffc02054ce <copy_path+0x78>
ffffffffc0205488:	038a0a93          	addi	s5,s4,56
ffffffffc020548c:	8556                	mv	a0,s5
ffffffffc020548e:	8b4ff0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc0205492:	00093783          	ld	a5,0(s2)
ffffffffc0205496:	cba1                	beqz	a5,ffffffffc02054e6 <copy_path+0x90>
ffffffffc0205498:	43dc                	lw	a5,4(a5)
ffffffffc020549a:	6685                	lui	a3,0x1
ffffffffc020549c:	8626                	mv	a2,s1
ffffffffc020549e:	04fa2823          	sw	a5,80(s4)
ffffffffc02054a2:	85a2                	mv	a1,s0
ffffffffc02054a4:	8552                	mv	a0,s4
ffffffffc02054a6:	ec5fe0ef          	jal	ra,ffffffffc020436a <copy_string>
ffffffffc02054aa:	c529                	beqz	a0,ffffffffc02054f4 <copy_path+0x9e>
ffffffffc02054ac:	8556                	mv	a0,s5
ffffffffc02054ae:	890ff0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc02054b2:	040a2823          	sw	zero,80(s4)
ffffffffc02054b6:	0089b023          	sd	s0,0(s3)
ffffffffc02054ba:	4501                	li	a0,0
ffffffffc02054bc:	70e2                	ld	ra,56(sp)
ffffffffc02054be:	7442                	ld	s0,48(sp)
ffffffffc02054c0:	74a2                	ld	s1,40(sp)
ffffffffc02054c2:	7902                	ld	s2,32(sp)
ffffffffc02054c4:	69e2                	ld	s3,24(sp)
ffffffffc02054c6:	6a42                	ld	s4,16(sp)
ffffffffc02054c8:	6aa2                	ld	s5,8(sp)
ffffffffc02054ca:	6121                	addi	sp,sp,64
ffffffffc02054cc:	8082                	ret
ffffffffc02054ce:	85aa                	mv	a1,a0
ffffffffc02054d0:	6685                	lui	a3,0x1
ffffffffc02054d2:	8626                	mv	a2,s1
ffffffffc02054d4:	4501                	li	a0,0
ffffffffc02054d6:	e95fe0ef          	jal	ra,ffffffffc020436a <copy_string>
ffffffffc02054da:	fd71                	bnez	a0,ffffffffc02054b6 <copy_path+0x60>
ffffffffc02054dc:	8522                	mv	a0,s0
ffffffffc02054de:	b61fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02054e2:	5575                	li	a0,-3
ffffffffc02054e4:	bfe1                	j	ffffffffc02054bc <copy_path+0x66>
ffffffffc02054e6:	6685                	lui	a3,0x1
ffffffffc02054e8:	8626                	mv	a2,s1
ffffffffc02054ea:	85a2                	mv	a1,s0
ffffffffc02054ec:	8552                	mv	a0,s4
ffffffffc02054ee:	e7dfe0ef          	jal	ra,ffffffffc020436a <copy_string>
ffffffffc02054f2:	fd4d                	bnez	a0,ffffffffc02054ac <copy_path+0x56>
ffffffffc02054f4:	8556                	mv	a0,s5
ffffffffc02054f6:	848ff0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc02054fa:	040a2823          	sw	zero,80(s4)
ffffffffc02054fe:	bff9                	j	ffffffffc02054dc <copy_path+0x86>
ffffffffc0205500:	5571                	li	a0,-4
ffffffffc0205502:	bf6d                	j	ffffffffc02054bc <copy_path+0x66>

ffffffffc0205504 <sysfile_open>:
ffffffffc0205504:	7179                	addi	sp,sp,-48
ffffffffc0205506:	872a                	mv	a4,a0
ffffffffc0205508:	ec26                	sd	s1,24(sp)
ffffffffc020550a:	0028                	addi	a0,sp,8
ffffffffc020550c:	84ae                	mv	s1,a1
ffffffffc020550e:	85ba                	mv	a1,a4
ffffffffc0205510:	f022                	sd	s0,32(sp)
ffffffffc0205512:	f406                	sd	ra,40(sp)
ffffffffc0205514:	f43ff0ef          	jal	ra,ffffffffc0205456 <copy_path>
ffffffffc0205518:	842a                	mv	s0,a0
ffffffffc020551a:	e909                	bnez	a0,ffffffffc020552c <sysfile_open+0x28>
ffffffffc020551c:	6522                	ld	a0,8(sp)
ffffffffc020551e:	85a6                	mv	a1,s1
ffffffffc0205520:	d60ff0ef          	jal	ra,ffffffffc0204a80 <file_open>
ffffffffc0205524:	842a                	mv	s0,a0
ffffffffc0205526:	6522                	ld	a0,8(sp)
ffffffffc0205528:	b17fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020552c:	70a2                	ld	ra,40(sp)
ffffffffc020552e:	8522                	mv	a0,s0
ffffffffc0205530:	7402                	ld	s0,32(sp)
ffffffffc0205532:	64e2                	ld	s1,24(sp)
ffffffffc0205534:	6145                	addi	sp,sp,48
ffffffffc0205536:	8082                	ret

ffffffffc0205538 <sysfile_close>:
ffffffffc0205538:	e46ff06f          	j	ffffffffc0204b7e <file_close>

ffffffffc020553c <sysfile_read>:
ffffffffc020553c:	7159                	addi	sp,sp,-112
ffffffffc020553e:	f0a2                	sd	s0,96(sp)
ffffffffc0205540:	f486                	sd	ra,104(sp)
ffffffffc0205542:	eca6                	sd	s1,88(sp)
ffffffffc0205544:	e8ca                	sd	s2,80(sp)
ffffffffc0205546:	e4ce                	sd	s3,72(sp)
ffffffffc0205548:	e0d2                	sd	s4,64(sp)
ffffffffc020554a:	fc56                	sd	s5,56(sp)
ffffffffc020554c:	f85a                	sd	s6,48(sp)
ffffffffc020554e:	f45e                	sd	s7,40(sp)
ffffffffc0205550:	f062                	sd	s8,32(sp)
ffffffffc0205552:	ec66                	sd	s9,24(sp)
ffffffffc0205554:	4401                	li	s0,0
ffffffffc0205556:	ee19                	bnez	a2,ffffffffc0205574 <sysfile_read+0x38>
ffffffffc0205558:	70a6                	ld	ra,104(sp)
ffffffffc020555a:	8522                	mv	a0,s0
ffffffffc020555c:	7406                	ld	s0,96(sp)
ffffffffc020555e:	64e6                	ld	s1,88(sp)
ffffffffc0205560:	6946                	ld	s2,80(sp)
ffffffffc0205562:	69a6                	ld	s3,72(sp)
ffffffffc0205564:	6a06                	ld	s4,64(sp)
ffffffffc0205566:	7ae2                	ld	s5,56(sp)
ffffffffc0205568:	7b42                	ld	s6,48(sp)
ffffffffc020556a:	7ba2                	ld	s7,40(sp)
ffffffffc020556c:	7c02                	ld	s8,32(sp)
ffffffffc020556e:	6ce2                	ld	s9,24(sp)
ffffffffc0205570:	6165                	addi	sp,sp,112
ffffffffc0205572:	8082                	ret
ffffffffc0205574:	00091c97          	auipc	s9,0x91
ffffffffc0205578:	34cc8c93          	addi	s9,s9,844 # ffffffffc02968c0 <current>
ffffffffc020557c:	000cb783          	ld	a5,0(s9)
ffffffffc0205580:	84b2                	mv	s1,a2
ffffffffc0205582:	8b2e                	mv	s6,a1
ffffffffc0205584:	4601                	li	a2,0
ffffffffc0205586:	4585                	li	a1,1
ffffffffc0205588:	0287b903          	ld	s2,40(a5)
ffffffffc020558c:	8aaa                	mv	s5,a0
ffffffffc020558e:	c9eff0ef          	jal	ra,ffffffffc0204a2c <file_testfd>
ffffffffc0205592:	c959                	beqz	a0,ffffffffc0205628 <sysfile_read+0xec>
ffffffffc0205594:	6505                	lui	a0,0x1
ffffffffc0205596:	9f9fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020559a:	89aa                	mv	s3,a0
ffffffffc020559c:	c941                	beqz	a0,ffffffffc020562c <sysfile_read+0xf0>
ffffffffc020559e:	4b81                	li	s7,0
ffffffffc02055a0:	6a05                	lui	s4,0x1
ffffffffc02055a2:	03890c13          	addi	s8,s2,56
ffffffffc02055a6:	0744ec63          	bltu	s1,s4,ffffffffc020561e <sysfile_read+0xe2>
ffffffffc02055aa:	e452                	sd	s4,8(sp)
ffffffffc02055ac:	6605                	lui	a2,0x1
ffffffffc02055ae:	0034                	addi	a3,sp,8
ffffffffc02055b0:	85ce                	mv	a1,s3
ffffffffc02055b2:	8556                	mv	a0,s5
ffffffffc02055b4:	e20ff0ef          	jal	ra,ffffffffc0204bd4 <file_read>
ffffffffc02055b8:	66a2                	ld	a3,8(sp)
ffffffffc02055ba:	842a                	mv	s0,a0
ffffffffc02055bc:	ca9d                	beqz	a3,ffffffffc02055f2 <sysfile_read+0xb6>
ffffffffc02055be:	00090c63          	beqz	s2,ffffffffc02055d6 <sysfile_read+0x9a>
ffffffffc02055c2:	8562                	mv	a0,s8
ffffffffc02055c4:	f7ffe0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc02055c8:	000cb783          	ld	a5,0(s9)
ffffffffc02055cc:	cfa1                	beqz	a5,ffffffffc0205624 <sysfile_read+0xe8>
ffffffffc02055ce:	43dc                	lw	a5,4(a5)
ffffffffc02055d0:	66a2                	ld	a3,8(sp)
ffffffffc02055d2:	04f92823          	sw	a5,80(s2)
ffffffffc02055d6:	864e                	mv	a2,s3
ffffffffc02055d8:	85da                	mv	a1,s6
ffffffffc02055da:	854a                	mv	a0,s2
ffffffffc02055dc:	d5dfe0ef          	jal	ra,ffffffffc0204338 <copy_to_user>
ffffffffc02055e0:	c50d                	beqz	a0,ffffffffc020560a <sysfile_read+0xce>
ffffffffc02055e2:	67a2                	ld	a5,8(sp)
ffffffffc02055e4:	04f4e663          	bltu	s1,a5,ffffffffc0205630 <sysfile_read+0xf4>
ffffffffc02055e8:	9b3e                	add	s6,s6,a5
ffffffffc02055ea:	8c9d                	sub	s1,s1,a5
ffffffffc02055ec:	9bbe                	add	s7,s7,a5
ffffffffc02055ee:	02091263          	bnez	s2,ffffffffc0205612 <sysfile_read+0xd6>
ffffffffc02055f2:	e401                	bnez	s0,ffffffffc02055fa <sysfile_read+0xbe>
ffffffffc02055f4:	67a2                	ld	a5,8(sp)
ffffffffc02055f6:	c391                	beqz	a5,ffffffffc02055fa <sysfile_read+0xbe>
ffffffffc02055f8:	f4dd                	bnez	s1,ffffffffc02055a6 <sysfile_read+0x6a>
ffffffffc02055fa:	854e                	mv	a0,s3
ffffffffc02055fc:	a43fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205600:	f40b8ce3          	beqz	s7,ffffffffc0205558 <sysfile_read+0x1c>
ffffffffc0205604:	000b841b          	sext.w	s0,s7
ffffffffc0205608:	bf81                	j	ffffffffc0205558 <sysfile_read+0x1c>
ffffffffc020560a:	e011                	bnez	s0,ffffffffc020560e <sysfile_read+0xd2>
ffffffffc020560c:	5475                	li	s0,-3
ffffffffc020560e:	fe0906e3          	beqz	s2,ffffffffc02055fa <sysfile_read+0xbe>
ffffffffc0205612:	8562                	mv	a0,s8
ffffffffc0205614:	f2bfe0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc0205618:	04092823          	sw	zero,80(s2)
ffffffffc020561c:	bfd9                	j	ffffffffc02055f2 <sysfile_read+0xb6>
ffffffffc020561e:	e426                	sd	s1,8(sp)
ffffffffc0205620:	8626                	mv	a2,s1
ffffffffc0205622:	b771                	j	ffffffffc02055ae <sysfile_read+0x72>
ffffffffc0205624:	66a2                	ld	a3,8(sp)
ffffffffc0205626:	bf45                	j	ffffffffc02055d6 <sysfile_read+0x9a>
ffffffffc0205628:	5475                	li	s0,-3
ffffffffc020562a:	b73d                	j	ffffffffc0205558 <sysfile_read+0x1c>
ffffffffc020562c:	5471                	li	s0,-4
ffffffffc020562e:	b72d                	j	ffffffffc0205558 <sysfile_read+0x1c>
ffffffffc0205630:	00008697          	auipc	a3,0x8
ffffffffc0205634:	b1068693          	addi	a3,a3,-1264 # ffffffffc020d140 <CSWTCH.79+0xc8>
ffffffffc0205638:	00006617          	auipc	a2,0x6
ffffffffc020563c:	04060613          	addi	a2,a2,64 # ffffffffc020b678 <commands+0x210>
ffffffffc0205640:	05500593          	li	a1,85
ffffffffc0205644:	00008517          	auipc	a0,0x8
ffffffffc0205648:	b0c50513          	addi	a0,a0,-1268 # ffffffffc020d150 <CSWTCH.79+0xd8>
ffffffffc020564c:	e53fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205650 <sysfile_write>:
ffffffffc0205650:	7159                	addi	sp,sp,-112
ffffffffc0205652:	e8ca                	sd	s2,80(sp)
ffffffffc0205654:	f486                	sd	ra,104(sp)
ffffffffc0205656:	f0a2                	sd	s0,96(sp)
ffffffffc0205658:	eca6                	sd	s1,88(sp)
ffffffffc020565a:	e4ce                	sd	s3,72(sp)
ffffffffc020565c:	e0d2                	sd	s4,64(sp)
ffffffffc020565e:	fc56                	sd	s5,56(sp)
ffffffffc0205660:	f85a                	sd	s6,48(sp)
ffffffffc0205662:	f45e                	sd	s7,40(sp)
ffffffffc0205664:	f062                	sd	s8,32(sp)
ffffffffc0205666:	ec66                	sd	s9,24(sp)
ffffffffc0205668:	4901                	li	s2,0
ffffffffc020566a:	ee19                	bnez	a2,ffffffffc0205688 <sysfile_write+0x38>
ffffffffc020566c:	70a6                	ld	ra,104(sp)
ffffffffc020566e:	7406                	ld	s0,96(sp)
ffffffffc0205670:	64e6                	ld	s1,88(sp)
ffffffffc0205672:	69a6                	ld	s3,72(sp)
ffffffffc0205674:	6a06                	ld	s4,64(sp)
ffffffffc0205676:	7ae2                	ld	s5,56(sp)
ffffffffc0205678:	7b42                	ld	s6,48(sp)
ffffffffc020567a:	7ba2                	ld	s7,40(sp)
ffffffffc020567c:	7c02                	ld	s8,32(sp)
ffffffffc020567e:	6ce2                	ld	s9,24(sp)
ffffffffc0205680:	854a                	mv	a0,s2
ffffffffc0205682:	6946                	ld	s2,80(sp)
ffffffffc0205684:	6165                	addi	sp,sp,112
ffffffffc0205686:	8082                	ret
ffffffffc0205688:	00091c17          	auipc	s8,0x91
ffffffffc020568c:	238c0c13          	addi	s8,s8,568 # ffffffffc02968c0 <current>
ffffffffc0205690:	000c3783          	ld	a5,0(s8)
ffffffffc0205694:	8432                	mv	s0,a2
ffffffffc0205696:	89ae                	mv	s3,a1
ffffffffc0205698:	4605                	li	a2,1
ffffffffc020569a:	4581                	li	a1,0
ffffffffc020569c:	7784                	ld	s1,40(a5)
ffffffffc020569e:	8baa                	mv	s7,a0
ffffffffc02056a0:	b8cff0ef          	jal	ra,ffffffffc0204a2c <file_testfd>
ffffffffc02056a4:	cd59                	beqz	a0,ffffffffc0205742 <sysfile_write+0xf2>
ffffffffc02056a6:	6505                	lui	a0,0x1
ffffffffc02056a8:	8e7fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02056ac:	8a2a                	mv	s4,a0
ffffffffc02056ae:	cd41                	beqz	a0,ffffffffc0205746 <sysfile_write+0xf6>
ffffffffc02056b0:	4c81                	li	s9,0
ffffffffc02056b2:	6a85                	lui	s5,0x1
ffffffffc02056b4:	03848b13          	addi	s6,s1,56
ffffffffc02056b8:	05546a63          	bltu	s0,s5,ffffffffc020570c <sysfile_write+0xbc>
ffffffffc02056bc:	e456                	sd	s5,8(sp)
ffffffffc02056be:	c8a9                	beqz	s1,ffffffffc0205710 <sysfile_write+0xc0>
ffffffffc02056c0:	855a                	mv	a0,s6
ffffffffc02056c2:	e81fe0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc02056c6:	000c3783          	ld	a5,0(s8)
ffffffffc02056ca:	c399                	beqz	a5,ffffffffc02056d0 <sysfile_write+0x80>
ffffffffc02056cc:	43dc                	lw	a5,4(a5)
ffffffffc02056ce:	c8bc                	sw	a5,80(s1)
ffffffffc02056d0:	66a2                	ld	a3,8(sp)
ffffffffc02056d2:	4701                	li	a4,0
ffffffffc02056d4:	864e                	mv	a2,s3
ffffffffc02056d6:	85d2                	mv	a1,s4
ffffffffc02056d8:	8526                	mv	a0,s1
ffffffffc02056da:	c2bfe0ef          	jal	ra,ffffffffc0204304 <copy_from_user>
ffffffffc02056de:	c139                	beqz	a0,ffffffffc0205724 <sysfile_write+0xd4>
ffffffffc02056e0:	855a                	mv	a0,s6
ffffffffc02056e2:	e5dfe0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc02056e6:	0404a823          	sw	zero,80(s1)
ffffffffc02056ea:	6622                	ld	a2,8(sp)
ffffffffc02056ec:	0034                	addi	a3,sp,8
ffffffffc02056ee:	85d2                	mv	a1,s4
ffffffffc02056f0:	855e                	mv	a0,s7
ffffffffc02056f2:	dc8ff0ef          	jal	ra,ffffffffc0204cba <file_write>
ffffffffc02056f6:	67a2                	ld	a5,8(sp)
ffffffffc02056f8:	892a                	mv	s2,a0
ffffffffc02056fa:	ef85                	bnez	a5,ffffffffc0205732 <sysfile_write+0xe2>
ffffffffc02056fc:	8552                	mv	a0,s4
ffffffffc02056fe:	941fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205702:	f60c85e3          	beqz	s9,ffffffffc020566c <sysfile_write+0x1c>
ffffffffc0205706:	000c891b          	sext.w	s2,s9
ffffffffc020570a:	b78d                	j	ffffffffc020566c <sysfile_write+0x1c>
ffffffffc020570c:	e422                	sd	s0,8(sp)
ffffffffc020570e:	f8cd                	bnez	s1,ffffffffc02056c0 <sysfile_write+0x70>
ffffffffc0205710:	66a2                	ld	a3,8(sp)
ffffffffc0205712:	4701                	li	a4,0
ffffffffc0205714:	864e                	mv	a2,s3
ffffffffc0205716:	85d2                	mv	a1,s4
ffffffffc0205718:	4501                	li	a0,0
ffffffffc020571a:	bebfe0ef          	jal	ra,ffffffffc0204304 <copy_from_user>
ffffffffc020571e:	f571                	bnez	a0,ffffffffc02056ea <sysfile_write+0x9a>
ffffffffc0205720:	5975                	li	s2,-3
ffffffffc0205722:	bfe9                	j	ffffffffc02056fc <sysfile_write+0xac>
ffffffffc0205724:	855a                	mv	a0,s6
ffffffffc0205726:	e19fe0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc020572a:	5975                	li	s2,-3
ffffffffc020572c:	0404a823          	sw	zero,80(s1)
ffffffffc0205730:	b7f1                	j	ffffffffc02056fc <sysfile_write+0xac>
ffffffffc0205732:	00f46c63          	bltu	s0,a5,ffffffffc020574a <sysfile_write+0xfa>
ffffffffc0205736:	99be                	add	s3,s3,a5
ffffffffc0205738:	8c1d                	sub	s0,s0,a5
ffffffffc020573a:	9cbe                	add	s9,s9,a5
ffffffffc020573c:	f161                	bnez	a0,ffffffffc02056fc <sysfile_write+0xac>
ffffffffc020573e:	fc2d                	bnez	s0,ffffffffc02056b8 <sysfile_write+0x68>
ffffffffc0205740:	bf75                	j	ffffffffc02056fc <sysfile_write+0xac>
ffffffffc0205742:	5975                	li	s2,-3
ffffffffc0205744:	b725                	j	ffffffffc020566c <sysfile_write+0x1c>
ffffffffc0205746:	5971                	li	s2,-4
ffffffffc0205748:	b715                	j	ffffffffc020566c <sysfile_write+0x1c>
ffffffffc020574a:	00008697          	auipc	a3,0x8
ffffffffc020574e:	9f668693          	addi	a3,a3,-1546 # ffffffffc020d140 <CSWTCH.79+0xc8>
ffffffffc0205752:	00006617          	auipc	a2,0x6
ffffffffc0205756:	f2660613          	addi	a2,a2,-218 # ffffffffc020b678 <commands+0x210>
ffffffffc020575a:	08a00593          	li	a1,138
ffffffffc020575e:	00008517          	auipc	a0,0x8
ffffffffc0205762:	9f250513          	addi	a0,a0,-1550 # ffffffffc020d150 <CSWTCH.79+0xd8>
ffffffffc0205766:	d39fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020576a <sysfile_seek>:
ffffffffc020576a:	e36ff06f          	j	ffffffffc0204da0 <file_seek>

ffffffffc020576e <sysfile_fstat>:
ffffffffc020576e:	715d                	addi	sp,sp,-80
ffffffffc0205770:	f44e                	sd	s3,40(sp)
ffffffffc0205772:	00091997          	auipc	s3,0x91
ffffffffc0205776:	14e98993          	addi	s3,s3,334 # ffffffffc02968c0 <current>
ffffffffc020577a:	0009b703          	ld	a4,0(s3)
ffffffffc020577e:	fc26                	sd	s1,56(sp)
ffffffffc0205780:	84ae                	mv	s1,a1
ffffffffc0205782:	858a                	mv	a1,sp
ffffffffc0205784:	e0a2                	sd	s0,64(sp)
ffffffffc0205786:	f84a                	sd	s2,48(sp)
ffffffffc0205788:	e486                	sd	ra,72(sp)
ffffffffc020578a:	02873903          	ld	s2,40(a4)
ffffffffc020578e:	f052                	sd	s4,32(sp)
ffffffffc0205790:	f30ff0ef          	jal	ra,ffffffffc0204ec0 <file_fstat>
ffffffffc0205794:	842a                	mv	s0,a0
ffffffffc0205796:	e91d                	bnez	a0,ffffffffc02057cc <sysfile_fstat+0x5e>
ffffffffc0205798:	04090363          	beqz	s2,ffffffffc02057de <sysfile_fstat+0x70>
ffffffffc020579c:	03890a13          	addi	s4,s2,56
ffffffffc02057a0:	8552                	mv	a0,s4
ffffffffc02057a2:	da1fe0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc02057a6:	0009b783          	ld	a5,0(s3)
ffffffffc02057aa:	c3b9                	beqz	a5,ffffffffc02057f0 <sysfile_fstat+0x82>
ffffffffc02057ac:	43dc                	lw	a5,4(a5)
ffffffffc02057ae:	02000693          	li	a3,32
ffffffffc02057b2:	860a                	mv	a2,sp
ffffffffc02057b4:	04f92823          	sw	a5,80(s2)
ffffffffc02057b8:	85a6                	mv	a1,s1
ffffffffc02057ba:	854a                	mv	a0,s2
ffffffffc02057bc:	b7dfe0ef          	jal	ra,ffffffffc0204338 <copy_to_user>
ffffffffc02057c0:	c121                	beqz	a0,ffffffffc0205800 <sysfile_fstat+0x92>
ffffffffc02057c2:	8552                	mv	a0,s4
ffffffffc02057c4:	d7bfe0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc02057c8:	04092823          	sw	zero,80(s2)
ffffffffc02057cc:	60a6                	ld	ra,72(sp)
ffffffffc02057ce:	8522                	mv	a0,s0
ffffffffc02057d0:	6406                	ld	s0,64(sp)
ffffffffc02057d2:	74e2                	ld	s1,56(sp)
ffffffffc02057d4:	7942                	ld	s2,48(sp)
ffffffffc02057d6:	79a2                	ld	s3,40(sp)
ffffffffc02057d8:	7a02                	ld	s4,32(sp)
ffffffffc02057da:	6161                	addi	sp,sp,80
ffffffffc02057dc:	8082                	ret
ffffffffc02057de:	02000693          	li	a3,32
ffffffffc02057e2:	860a                	mv	a2,sp
ffffffffc02057e4:	85a6                	mv	a1,s1
ffffffffc02057e6:	b53fe0ef          	jal	ra,ffffffffc0204338 <copy_to_user>
ffffffffc02057ea:	f16d                	bnez	a0,ffffffffc02057cc <sysfile_fstat+0x5e>
ffffffffc02057ec:	5475                	li	s0,-3
ffffffffc02057ee:	bff9                	j	ffffffffc02057cc <sysfile_fstat+0x5e>
ffffffffc02057f0:	02000693          	li	a3,32
ffffffffc02057f4:	860a                	mv	a2,sp
ffffffffc02057f6:	85a6                	mv	a1,s1
ffffffffc02057f8:	854a                	mv	a0,s2
ffffffffc02057fa:	b3ffe0ef          	jal	ra,ffffffffc0204338 <copy_to_user>
ffffffffc02057fe:	f171                	bnez	a0,ffffffffc02057c2 <sysfile_fstat+0x54>
ffffffffc0205800:	8552                	mv	a0,s4
ffffffffc0205802:	d3dfe0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc0205806:	5475                	li	s0,-3
ffffffffc0205808:	04092823          	sw	zero,80(s2)
ffffffffc020580c:	b7c1                	j	ffffffffc02057cc <sysfile_fstat+0x5e>

ffffffffc020580e <sysfile_fsync>:
ffffffffc020580e:	f72ff06f          	j	ffffffffc0204f80 <file_fsync>

ffffffffc0205812 <sysfile_getcwd>:
ffffffffc0205812:	715d                	addi	sp,sp,-80
ffffffffc0205814:	f44e                	sd	s3,40(sp)
ffffffffc0205816:	00091997          	auipc	s3,0x91
ffffffffc020581a:	0aa98993          	addi	s3,s3,170 # ffffffffc02968c0 <current>
ffffffffc020581e:	0009b783          	ld	a5,0(s3)
ffffffffc0205822:	f84a                	sd	s2,48(sp)
ffffffffc0205824:	e486                	sd	ra,72(sp)
ffffffffc0205826:	e0a2                	sd	s0,64(sp)
ffffffffc0205828:	fc26                	sd	s1,56(sp)
ffffffffc020582a:	f052                	sd	s4,32(sp)
ffffffffc020582c:	0287b903          	ld	s2,40(a5)
ffffffffc0205830:	cda9                	beqz	a1,ffffffffc020588a <sysfile_getcwd+0x78>
ffffffffc0205832:	842e                	mv	s0,a1
ffffffffc0205834:	84aa                	mv	s1,a0
ffffffffc0205836:	04090363          	beqz	s2,ffffffffc020587c <sysfile_getcwd+0x6a>
ffffffffc020583a:	03890a13          	addi	s4,s2,56
ffffffffc020583e:	8552                	mv	a0,s4
ffffffffc0205840:	d03fe0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc0205844:	0009b783          	ld	a5,0(s3)
ffffffffc0205848:	c781                	beqz	a5,ffffffffc0205850 <sysfile_getcwd+0x3e>
ffffffffc020584a:	43dc                	lw	a5,4(a5)
ffffffffc020584c:	04f92823          	sw	a5,80(s2)
ffffffffc0205850:	4685                	li	a3,1
ffffffffc0205852:	8622                	mv	a2,s0
ffffffffc0205854:	85a6                	mv	a1,s1
ffffffffc0205856:	854a                	mv	a0,s2
ffffffffc0205858:	a19fe0ef          	jal	ra,ffffffffc0204270 <user_mem_check>
ffffffffc020585c:	e90d                	bnez	a0,ffffffffc020588e <sysfile_getcwd+0x7c>
ffffffffc020585e:	5475                	li	s0,-3
ffffffffc0205860:	8552                	mv	a0,s4
ffffffffc0205862:	cddfe0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc0205866:	04092823          	sw	zero,80(s2)
ffffffffc020586a:	60a6                	ld	ra,72(sp)
ffffffffc020586c:	8522                	mv	a0,s0
ffffffffc020586e:	6406                	ld	s0,64(sp)
ffffffffc0205870:	74e2                	ld	s1,56(sp)
ffffffffc0205872:	7942                	ld	s2,48(sp)
ffffffffc0205874:	79a2                	ld	s3,40(sp)
ffffffffc0205876:	7a02                	ld	s4,32(sp)
ffffffffc0205878:	6161                	addi	sp,sp,80
ffffffffc020587a:	8082                	ret
ffffffffc020587c:	862e                	mv	a2,a1
ffffffffc020587e:	4685                	li	a3,1
ffffffffc0205880:	85aa                	mv	a1,a0
ffffffffc0205882:	4501                	li	a0,0
ffffffffc0205884:	9edfe0ef          	jal	ra,ffffffffc0204270 <user_mem_check>
ffffffffc0205888:	ed09                	bnez	a0,ffffffffc02058a2 <sysfile_getcwd+0x90>
ffffffffc020588a:	5475                	li	s0,-3
ffffffffc020588c:	bff9                	j	ffffffffc020586a <sysfile_getcwd+0x58>
ffffffffc020588e:	8622                	mv	a2,s0
ffffffffc0205890:	4681                	li	a3,0
ffffffffc0205892:	85a6                	mv	a1,s1
ffffffffc0205894:	850a                	mv	a0,sp
ffffffffc0205896:	b2bff0ef          	jal	ra,ffffffffc02053c0 <iobuf_init>
ffffffffc020589a:	19f020ef          	jal	ra,ffffffffc0208238 <vfs_getcwd>
ffffffffc020589e:	842a                	mv	s0,a0
ffffffffc02058a0:	b7c1                	j	ffffffffc0205860 <sysfile_getcwd+0x4e>
ffffffffc02058a2:	8622                	mv	a2,s0
ffffffffc02058a4:	4681                	li	a3,0
ffffffffc02058a6:	85a6                	mv	a1,s1
ffffffffc02058a8:	850a                	mv	a0,sp
ffffffffc02058aa:	b17ff0ef          	jal	ra,ffffffffc02053c0 <iobuf_init>
ffffffffc02058ae:	18b020ef          	jal	ra,ffffffffc0208238 <vfs_getcwd>
ffffffffc02058b2:	842a                	mv	s0,a0
ffffffffc02058b4:	bf5d                	j	ffffffffc020586a <sysfile_getcwd+0x58>

ffffffffc02058b6 <sysfile_getdirentry>:
ffffffffc02058b6:	7139                	addi	sp,sp,-64
ffffffffc02058b8:	e852                	sd	s4,16(sp)
ffffffffc02058ba:	00091a17          	auipc	s4,0x91
ffffffffc02058be:	006a0a13          	addi	s4,s4,6 # ffffffffc02968c0 <current>
ffffffffc02058c2:	000a3703          	ld	a4,0(s4)
ffffffffc02058c6:	ec4e                	sd	s3,24(sp)
ffffffffc02058c8:	89aa                	mv	s3,a0
ffffffffc02058ca:	10800513          	li	a0,264
ffffffffc02058ce:	f426                	sd	s1,40(sp)
ffffffffc02058d0:	f04a                	sd	s2,32(sp)
ffffffffc02058d2:	fc06                	sd	ra,56(sp)
ffffffffc02058d4:	f822                	sd	s0,48(sp)
ffffffffc02058d6:	e456                	sd	s5,8(sp)
ffffffffc02058d8:	7704                	ld	s1,40(a4)
ffffffffc02058da:	892e                	mv	s2,a1
ffffffffc02058dc:	eb2fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02058e0:	c169                	beqz	a0,ffffffffc02059a2 <sysfile_getdirentry+0xec>
ffffffffc02058e2:	842a                	mv	s0,a0
ffffffffc02058e4:	c8c1                	beqz	s1,ffffffffc0205974 <sysfile_getdirentry+0xbe>
ffffffffc02058e6:	03848a93          	addi	s5,s1,56
ffffffffc02058ea:	8556                	mv	a0,s5
ffffffffc02058ec:	c57fe0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc02058f0:	000a3783          	ld	a5,0(s4)
ffffffffc02058f4:	c399                	beqz	a5,ffffffffc02058fa <sysfile_getdirentry+0x44>
ffffffffc02058f6:	43dc                	lw	a5,4(a5)
ffffffffc02058f8:	c8bc                	sw	a5,80(s1)
ffffffffc02058fa:	4705                	li	a4,1
ffffffffc02058fc:	46a1                	li	a3,8
ffffffffc02058fe:	864a                	mv	a2,s2
ffffffffc0205900:	85a2                	mv	a1,s0
ffffffffc0205902:	8526                	mv	a0,s1
ffffffffc0205904:	a01fe0ef          	jal	ra,ffffffffc0204304 <copy_from_user>
ffffffffc0205908:	e505                	bnez	a0,ffffffffc0205930 <sysfile_getdirentry+0x7a>
ffffffffc020590a:	8556                	mv	a0,s5
ffffffffc020590c:	c33fe0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc0205910:	59f5                	li	s3,-3
ffffffffc0205912:	0404a823          	sw	zero,80(s1)
ffffffffc0205916:	8522                	mv	a0,s0
ffffffffc0205918:	f26fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020591c:	70e2                	ld	ra,56(sp)
ffffffffc020591e:	7442                	ld	s0,48(sp)
ffffffffc0205920:	74a2                	ld	s1,40(sp)
ffffffffc0205922:	7902                	ld	s2,32(sp)
ffffffffc0205924:	6a42                	ld	s4,16(sp)
ffffffffc0205926:	6aa2                	ld	s5,8(sp)
ffffffffc0205928:	854e                	mv	a0,s3
ffffffffc020592a:	69e2                	ld	s3,24(sp)
ffffffffc020592c:	6121                	addi	sp,sp,64
ffffffffc020592e:	8082                	ret
ffffffffc0205930:	8556                	mv	a0,s5
ffffffffc0205932:	c0dfe0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc0205936:	854e                	mv	a0,s3
ffffffffc0205938:	85a2                	mv	a1,s0
ffffffffc020593a:	0404a823          	sw	zero,80(s1)
ffffffffc020593e:	ef0ff0ef          	jal	ra,ffffffffc020502e <file_getdirentry>
ffffffffc0205942:	89aa                	mv	s3,a0
ffffffffc0205944:	f969                	bnez	a0,ffffffffc0205916 <sysfile_getdirentry+0x60>
ffffffffc0205946:	8556                	mv	a0,s5
ffffffffc0205948:	bfbfe0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc020594c:	000a3783          	ld	a5,0(s4)
ffffffffc0205950:	c399                	beqz	a5,ffffffffc0205956 <sysfile_getdirentry+0xa0>
ffffffffc0205952:	43dc                	lw	a5,4(a5)
ffffffffc0205954:	c8bc                	sw	a5,80(s1)
ffffffffc0205956:	10800693          	li	a3,264
ffffffffc020595a:	8622                	mv	a2,s0
ffffffffc020595c:	85ca                	mv	a1,s2
ffffffffc020595e:	8526                	mv	a0,s1
ffffffffc0205960:	9d9fe0ef          	jal	ra,ffffffffc0204338 <copy_to_user>
ffffffffc0205964:	e111                	bnez	a0,ffffffffc0205968 <sysfile_getdirentry+0xb2>
ffffffffc0205966:	59f5                	li	s3,-3
ffffffffc0205968:	8556                	mv	a0,s5
ffffffffc020596a:	bd5fe0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc020596e:	0404a823          	sw	zero,80(s1)
ffffffffc0205972:	b755                	j	ffffffffc0205916 <sysfile_getdirentry+0x60>
ffffffffc0205974:	85aa                	mv	a1,a0
ffffffffc0205976:	4705                	li	a4,1
ffffffffc0205978:	46a1                	li	a3,8
ffffffffc020597a:	864a                	mv	a2,s2
ffffffffc020597c:	4501                	li	a0,0
ffffffffc020597e:	987fe0ef          	jal	ra,ffffffffc0204304 <copy_from_user>
ffffffffc0205982:	cd11                	beqz	a0,ffffffffc020599e <sysfile_getdirentry+0xe8>
ffffffffc0205984:	854e                	mv	a0,s3
ffffffffc0205986:	85a2                	mv	a1,s0
ffffffffc0205988:	ea6ff0ef          	jal	ra,ffffffffc020502e <file_getdirentry>
ffffffffc020598c:	89aa                	mv	s3,a0
ffffffffc020598e:	f541                	bnez	a0,ffffffffc0205916 <sysfile_getdirentry+0x60>
ffffffffc0205990:	10800693          	li	a3,264
ffffffffc0205994:	8622                	mv	a2,s0
ffffffffc0205996:	85ca                	mv	a1,s2
ffffffffc0205998:	9a1fe0ef          	jal	ra,ffffffffc0204338 <copy_to_user>
ffffffffc020599c:	fd2d                	bnez	a0,ffffffffc0205916 <sysfile_getdirentry+0x60>
ffffffffc020599e:	59f5                	li	s3,-3
ffffffffc02059a0:	bf9d                	j	ffffffffc0205916 <sysfile_getdirentry+0x60>
ffffffffc02059a2:	59f1                	li	s3,-4
ffffffffc02059a4:	bfa5                	j	ffffffffc020591c <sysfile_getdirentry+0x66>

ffffffffc02059a6 <sysfile_dup>:
ffffffffc02059a6:	f6eff06f          	j	ffffffffc0205114 <file_dup>

ffffffffc02059aa <kernel_thread_entry>:
ffffffffc02059aa:	8526                	mv	a0,s1
ffffffffc02059ac:	9402                	jalr	s0
ffffffffc02059ae:	64c000ef          	jal	ra,ffffffffc0205ffa <do_exit>

ffffffffc02059b2 <alloc_proc>:
ffffffffc02059b2:	1141                	addi	sp,sp,-16
ffffffffc02059b4:	15000513          	li	a0,336
ffffffffc02059b8:	e022                	sd	s0,0(sp)
ffffffffc02059ba:	e406                	sd	ra,8(sp)
ffffffffc02059bc:	dd2fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02059c0:	842a                	mv	s0,a0
ffffffffc02059c2:	c141                	beqz	a0,ffffffffc0205a42 <alloc_proc+0x90>
ffffffffc02059c4:	57fd                	li	a5,-1
ffffffffc02059c6:	1782                	slli	a5,a5,0x20
ffffffffc02059c8:	e11c                	sd	a5,0(a0)
ffffffffc02059ca:	07000613          	li	a2,112
ffffffffc02059ce:	4581                	li	a1,0
ffffffffc02059d0:	00052423          	sw	zero,8(a0)
ffffffffc02059d4:	00053823          	sd	zero,16(a0)
ffffffffc02059d8:	00053c23          	sd	zero,24(a0)
ffffffffc02059dc:	02053023          	sd	zero,32(a0)
ffffffffc02059e0:	02053423          	sd	zero,40(a0)
ffffffffc02059e4:	03050513          	addi	a0,a0,48
ffffffffc02059e8:	7ac050ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc02059ec:	00091797          	auipc	a5,0x91
ffffffffc02059f0:	ea47b783          	ld	a5,-348(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc02059f4:	f45c                	sd	a5,168(s0)
ffffffffc02059f6:	0a043023          	sd	zero,160(s0)
ffffffffc02059fa:	0a042823          	sw	zero,176(s0)
ffffffffc02059fe:	463d                	li	a2,15
ffffffffc0205a00:	4581                	li	a1,0
ffffffffc0205a02:	0b440513          	addi	a0,s0,180
ffffffffc0205a06:	78e050ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc0205a0a:	11040793          	addi	a5,s0,272
ffffffffc0205a0e:	0e042623          	sw	zero,236(s0)
ffffffffc0205a12:	0e043c23          	sd	zero,248(s0)
ffffffffc0205a16:	10043023          	sd	zero,256(s0)
ffffffffc0205a1a:	0e043823          	sd	zero,240(s0)
ffffffffc0205a1e:	10043423          	sd	zero,264(s0)
ffffffffc0205a22:	10f43c23          	sd	a5,280(s0)
ffffffffc0205a26:	10f43823          	sd	a5,272(s0)
ffffffffc0205a2a:	12042023          	sw	zero,288(s0)
ffffffffc0205a2e:	12043423          	sd	zero,296(s0)
ffffffffc0205a32:	12043823          	sd	zero,304(s0)
ffffffffc0205a36:	12043c23          	sd	zero,312(s0)
ffffffffc0205a3a:	14043023          	sd	zero,320(s0)
ffffffffc0205a3e:	14043423          	sd	zero,328(s0)
ffffffffc0205a42:	60a2                	ld	ra,8(sp)
ffffffffc0205a44:	8522                	mv	a0,s0
ffffffffc0205a46:	6402                	ld	s0,0(sp)
ffffffffc0205a48:	0141                	addi	sp,sp,16
ffffffffc0205a4a:	8082                	ret

ffffffffc0205a4c <forkret>:
ffffffffc0205a4c:	00091797          	auipc	a5,0x91
ffffffffc0205a50:	e747b783          	ld	a5,-396(a5) # ffffffffc02968c0 <current>
ffffffffc0205a54:	73c8                	ld	a0,160(a5)
ffffffffc0205a56:	855fb06f          	j	ffffffffc02012aa <forkrets>

ffffffffc0205a5a <put_pgdir.isra.0>:
ffffffffc0205a5a:	1141                	addi	sp,sp,-16
ffffffffc0205a5c:	e406                	sd	ra,8(sp)
ffffffffc0205a5e:	c02007b7          	lui	a5,0xc0200
ffffffffc0205a62:	02f56e63          	bltu	a0,a5,ffffffffc0205a9e <put_pgdir.isra.0+0x44>
ffffffffc0205a66:	00091697          	auipc	a3,0x91
ffffffffc0205a6a:	e526b683          	ld	a3,-430(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205a6e:	8d15                	sub	a0,a0,a3
ffffffffc0205a70:	8131                	srli	a0,a0,0xc
ffffffffc0205a72:	00091797          	auipc	a5,0x91
ffffffffc0205a76:	e2e7b783          	ld	a5,-466(a5) # ffffffffc02968a0 <npage>
ffffffffc0205a7a:	02f57f63          	bgeu	a0,a5,ffffffffc0205ab8 <put_pgdir.isra.0+0x5e>
ffffffffc0205a7e:	0000a697          	auipc	a3,0xa
ffffffffc0205a82:	8da6b683          	ld	a3,-1830(a3) # ffffffffc020f358 <nbase>
ffffffffc0205a86:	60a2                	ld	ra,8(sp)
ffffffffc0205a88:	8d15                	sub	a0,a0,a3
ffffffffc0205a8a:	00091797          	auipc	a5,0x91
ffffffffc0205a8e:	e1e7b783          	ld	a5,-482(a5) # ffffffffc02968a8 <pages>
ffffffffc0205a92:	051a                	slli	a0,a0,0x6
ffffffffc0205a94:	4585                	li	a1,1
ffffffffc0205a96:	953e                	add	a0,a0,a5
ffffffffc0205a98:	0141                	addi	sp,sp,16
ffffffffc0205a9a:	f10fc06f          	j	ffffffffc02021aa <free_pages>
ffffffffc0205a9e:	86aa                	mv	a3,a0
ffffffffc0205aa0:	00006617          	auipc	a2,0x6
ffffffffc0205aa4:	7a060613          	addi	a2,a2,1952 # ffffffffc020c240 <default_pmm_manager+0xe0>
ffffffffc0205aa8:	07700593          	li	a1,119
ffffffffc0205aac:	00006517          	auipc	a0,0x6
ffffffffc0205ab0:	71450513          	addi	a0,a0,1812 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc0205ab4:	9ebfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205ab8:	00006617          	auipc	a2,0x6
ffffffffc0205abc:	7b060613          	addi	a2,a2,1968 # ffffffffc020c268 <default_pmm_manager+0x108>
ffffffffc0205ac0:	06900593          	li	a1,105
ffffffffc0205ac4:	00006517          	auipc	a0,0x6
ffffffffc0205ac8:	6fc50513          	addi	a0,a0,1788 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc0205acc:	9d3fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205ad0 <setup_pgdir>:
ffffffffc0205ad0:	1101                	addi	sp,sp,-32
ffffffffc0205ad2:	e426                	sd	s1,8(sp)
ffffffffc0205ad4:	84aa                	mv	s1,a0
ffffffffc0205ad6:	4505                	li	a0,1
ffffffffc0205ad8:	ec06                	sd	ra,24(sp)
ffffffffc0205ada:	e822                	sd	s0,16(sp)
ffffffffc0205adc:	e90fc0ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0205ae0:	c939                	beqz	a0,ffffffffc0205b36 <setup_pgdir+0x66>
ffffffffc0205ae2:	00091697          	auipc	a3,0x91
ffffffffc0205ae6:	dc66b683          	ld	a3,-570(a3) # ffffffffc02968a8 <pages>
ffffffffc0205aea:	40d506b3          	sub	a3,a0,a3
ffffffffc0205aee:	8699                	srai	a3,a3,0x6
ffffffffc0205af0:	0000a417          	auipc	s0,0xa
ffffffffc0205af4:	86843403          	ld	s0,-1944(s0) # ffffffffc020f358 <nbase>
ffffffffc0205af8:	96a2                	add	a3,a3,s0
ffffffffc0205afa:	00c69793          	slli	a5,a3,0xc
ffffffffc0205afe:	83b1                	srli	a5,a5,0xc
ffffffffc0205b00:	00091717          	auipc	a4,0x91
ffffffffc0205b04:	da073703          	ld	a4,-608(a4) # ffffffffc02968a0 <npage>
ffffffffc0205b08:	06b2                	slli	a3,a3,0xc
ffffffffc0205b0a:	02e7f863          	bgeu	a5,a4,ffffffffc0205b3a <setup_pgdir+0x6a>
ffffffffc0205b0e:	00091417          	auipc	s0,0x91
ffffffffc0205b12:	daa43403          	ld	s0,-598(s0) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205b16:	9436                	add	s0,s0,a3
ffffffffc0205b18:	6605                	lui	a2,0x1
ffffffffc0205b1a:	00091597          	auipc	a1,0x91
ffffffffc0205b1e:	d7e5b583          	ld	a1,-642(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0205b22:	8522                	mv	a0,s0
ffffffffc0205b24:	6c2050ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc0205b28:	4501                	li	a0,0
ffffffffc0205b2a:	ec80                	sd	s0,24(s1)
ffffffffc0205b2c:	60e2                	ld	ra,24(sp)
ffffffffc0205b2e:	6442                	ld	s0,16(sp)
ffffffffc0205b30:	64a2                	ld	s1,8(sp)
ffffffffc0205b32:	6105                	addi	sp,sp,32
ffffffffc0205b34:	8082                	ret
ffffffffc0205b36:	5571                	li	a0,-4
ffffffffc0205b38:	bfd5                	j	ffffffffc0205b2c <setup_pgdir+0x5c>
ffffffffc0205b3a:	00006617          	auipc	a2,0x6
ffffffffc0205b3e:	65e60613          	addi	a2,a2,1630 # ffffffffc020c198 <default_pmm_manager+0x38>
ffffffffc0205b42:	07100593          	li	a1,113
ffffffffc0205b46:	00006517          	auipc	a0,0x6
ffffffffc0205b4a:	67a50513          	addi	a0,a0,1658 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc0205b4e:	951fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205b52 <proc_run>:
ffffffffc0205b52:	1101                	addi	sp,sp,-32
ffffffffc0205b54:	e822                	sd	s0,16(sp)
ffffffffc0205b56:	ec06                	sd	ra,24(sp)
ffffffffc0205b58:	e426                	sd	s1,8(sp)
ffffffffc0205b5a:	842a                	mv	s0,a0
ffffffffc0205b5c:	100027f3          	csrr	a5,sstatus
ffffffffc0205b60:	8b89                	andi	a5,a5,2
ffffffffc0205b62:	4481                	li	s1,0
ffffffffc0205b64:	e7b1                	bnez	a5,ffffffffc0205bb0 <proc_run+0x5e>
ffffffffc0205b66:	4418                	lw	a4,8(s0)
ffffffffc0205b68:	745c                	ld	a5,168(s0)
ffffffffc0205b6a:	00091697          	auipc	a3,0x91
ffffffffc0205b6e:	d5668693          	addi	a3,a3,-682 # ffffffffc02968c0 <current>
ffffffffc0205b72:	2705                	addiw	a4,a4,1
ffffffffc0205b74:	6288                	ld	a0,0(a3)
ffffffffc0205b76:	c418                	sw	a4,8(s0)
ffffffffc0205b78:	e280                	sd	s0,0(a3)
ffffffffc0205b7a:	c799                	beqz	a5,ffffffffc0205b88 <proc_run+0x36>
ffffffffc0205b7c:	577d                	li	a4,-1
ffffffffc0205b7e:	177e                	slli	a4,a4,0x3f
ffffffffc0205b80:	83b1                	srli	a5,a5,0xc
ffffffffc0205b82:	8fd9                	or	a5,a5,a4
ffffffffc0205b84:	18079073          	csrw	satp,a5
ffffffffc0205b88:	12000073          	sfence.vma
ffffffffc0205b8c:	03040593          	addi	a1,s0,48
ffffffffc0205b90:	03050513          	addi	a0,a0,48
ffffffffc0205b94:	36e010ef          	jal	ra,ffffffffc0206f02 <switch_to>
ffffffffc0205b98:	e491                	bnez	s1,ffffffffc0205ba4 <proc_run+0x52>
ffffffffc0205b9a:	60e2                	ld	ra,24(sp)
ffffffffc0205b9c:	6442                	ld	s0,16(sp)
ffffffffc0205b9e:	64a2                	ld	s1,8(sp)
ffffffffc0205ba0:	6105                	addi	sp,sp,32
ffffffffc0205ba2:	8082                	ret
ffffffffc0205ba4:	6442                	ld	s0,16(sp)
ffffffffc0205ba6:	60e2                	ld	ra,24(sp)
ffffffffc0205ba8:	64a2                	ld	s1,8(sp)
ffffffffc0205baa:	6105                	addi	sp,sp,32
ffffffffc0205bac:	8c0fb06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0205bb0:	8c2fb0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0205bb4:	4485                	li	s1,1
ffffffffc0205bb6:	bf45                	j	ffffffffc0205b66 <proc_run+0x14>

ffffffffc0205bb8 <do_fork>:
ffffffffc0205bb8:	7119                	addi	sp,sp,-128
ffffffffc0205bba:	ecce                	sd	s3,88(sp)
ffffffffc0205bbc:	00091997          	auipc	s3,0x91
ffffffffc0205bc0:	d1c98993          	addi	s3,s3,-740 # ffffffffc02968d8 <nr_process>
ffffffffc0205bc4:	0009a703          	lw	a4,0(s3)
ffffffffc0205bc8:	fc86                	sd	ra,120(sp)
ffffffffc0205bca:	f8a2                	sd	s0,112(sp)
ffffffffc0205bcc:	f4a6                	sd	s1,104(sp)
ffffffffc0205bce:	f0ca                	sd	s2,96(sp)
ffffffffc0205bd0:	e8d2                	sd	s4,80(sp)
ffffffffc0205bd2:	e4d6                	sd	s5,72(sp)
ffffffffc0205bd4:	e0da                	sd	s6,64(sp)
ffffffffc0205bd6:	fc5e                	sd	s7,56(sp)
ffffffffc0205bd8:	f862                	sd	s8,48(sp)
ffffffffc0205bda:	f466                	sd	s9,40(sp)
ffffffffc0205bdc:	f06a                	sd	s10,32(sp)
ffffffffc0205bde:	ec6e                	sd	s11,24(sp)
ffffffffc0205be0:	6785                	lui	a5,0x1
ffffffffc0205be2:	30f75963          	bge	a4,a5,ffffffffc0205ef4 <do_fork+0x33c>
ffffffffc0205be6:	892a                	mv	s2,a0
ffffffffc0205be8:	8a2e                	mv	s4,a1
ffffffffc0205bea:	84b2                	mv	s1,a2
ffffffffc0205bec:	dc7ff0ef          	jal	ra,ffffffffc02059b2 <alloc_proc>
ffffffffc0205bf0:	842a                	mv	s0,a0
ffffffffc0205bf2:	32050063          	beqz	a0,ffffffffc0205f12 <do_fork+0x35a>
ffffffffc0205bf6:	00091b97          	auipc	s7,0x91
ffffffffc0205bfa:	ccab8b93          	addi	s7,s7,-822 # ffffffffc02968c0 <current>
ffffffffc0205bfe:	000bb783          	ld	a5,0(s7)
ffffffffc0205c02:	0e052623          	sw	zero,236(a0)
ffffffffc0205c06:	4509                	li	a0,2
ffffffffc0205c08:	f01c                	sd	a5,32(s0)
ffffffffc0205c0a:	0e07a623          	sw	zero,236(a5) # 10ec <_binary_bin_swap_img_size-0x6c14>
ffffffffc0205c0e:	d5efc0ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0205c12:	2c050663          	beqz	a0,ffffffffc0205ede <do_fork+0x326>
ffffffffc0205c16:	00091d17          	auipc	s10,0x91
ffffffffc0205c1a:	c92d0d13          	addi	s10,s10,-878 # ffffffffc02968a8 <pages>
ffffffffc0205c1e:	000d3683          	ld	a3,0(s10)
ffffffffc0205c22:	00009c97          	auipc	s9,0x9
ffffffffc0205c26:	736cbc83          	ld	s9,1846(s9) # ffffffffc020f358 <nbase>
ffffffffc0205c2a:	00091d97          	auipc	s11,0x91
ffffffffc0205c2e:	c76d8d93          	addi	s11,s11,-906 # ffffffffc02968a0 <npage>
ffffffffc0205c32:	40d506b3          	sub	a3,a0,a3
ffffffffc0205c36:	8699                	srai	a3,a3,0x6
ffffffffc0205c38:	96e6                	add	a3,a3,s9
ffffffffc0205c3a:	000db703          	ld	a4,0(s11)
ffffffffc0205c3e:	00c69793          	slli	a5,a3,0xc
ffffffffc0205c42:	83b1                	srli	a5,a5,0xc
ffffffffc0205c44:	06b2                	slli	a3,a3,0xc
ffffffffc0205c46:	2ee7f263          	bgeu	a5,a4,ffffffffc0205f2a <do_fork+0x372>
ffffffffc0205c4a:	000bb703          	ld	a4,0(s7)
ffffffffc0205c4e:	00091c17          	auipc	s8,0x91
ffffffffc0205c52:	c6ac0c13          	addi	s8,s8,-918 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205c56:	000c3783          	ld	a5,0(s8)
ffffffffc0205c5a:	02873a83          	ld	s5,40(a4)
ffffffffc0205c5e:	96be                	add	a3,a3,a5
ffffffffc0205c60:	e814                	sd	a3,16(s0)
ffffffffc0205c62:	020a8963          	beqz	s5,ffffffffc0205c94 <do_fork+0xdc>
ffffffffc0205c66:	10097793          	andi	a5,s2,256
ffffffffc0205c6a:	14078c63          	beqz	a5,ffffffffc0205dc2 <do_fork+0x20a>
ffffffffc0205c6e:	030aa783          	lw	a5,48(s5) # 1030 <_binary_bin_swap_img_size-0x6cd0>
ffffffffc0205c72:	018ab683          	ld	a3,24(s5)
ffffffffc0205c76:	c0200737          	lui	a4,0xc0200
ffffffffc0205c7a:	2785                	addiw	a5,a5,1
ffffffffc0205c7c:	02faa823          	sw	a5,48(s5)
ffffffffc0205c80:	03543423          	sd	s5,40(s0)
ffffffffc0205c84:	2ee6e763          	bltu	a3,a4,ffffffffc0205f72 <do_fork+0x3ba>
ffffffffc0205c88:	000c3783          	ld	a5,0(s8)
ffffffffc0205c8c:	000bb703          	ld	a4,0(s7)
ffffffffc0205c90:	8e9d                	sub	a3,a3,a5
ffffffffc0205c92:	f454                	sd	a3,168(s0)
ffffffffc0205c94:	14873a83          	ld	s5,328(a4) # ffffffffc0200148 <readline+0x96>
ffffffffc0205c98:	2e0a8963          	beqz	s5,ffffffffc0205f8a <do_fork+0x3d2>
ffffffffc0205c9c:	00b95913          	srli	s2,s2,0xb
ffffffffc0205ca0:	00197913          	andi	s2,s2,1
ffffffffc0205ca4:	16090563          	beqz	s2,ffffffffc0205e0e <do_fork+0x256>
ffffffffc0205ca8:	010aa783          	lw	a5,16(s5)
ffffffffc0205cac:	6818                	ld	a4,16(s0)
ffffffffc0205cae:	8626                	mv	a2,s1
ffffffffc0205cb0:	2785                	addiw	a5,a5,1
ffffffffc0205cb2:	00faa823          	sw	a5,16(s5)
ffffffffc0205cb6:	6789                	lui	a5,0x2
ffffffffc0205cb8:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0205cbc:	973e                	add	a4,a4,a5
ffffffffc0205cbe:	15543423          	sd	s5,328(s0)
ffffffffc0205cc2:	f058                	sd	a4,160(s0)
ffffffffc0205cc4:	87ba                	mv	a5,a4
ffffffffc0205cc6:	12048893          	addi	a7,s1,288
ffffffffc0205cca:	00063803          	ld	a6,0(a2)
ffffffffc0205cce:	6608                	ld	a0,8(a2)
ffffffffc0205cd0:	6a0c                	ld	a1,16(a2)
ffffffffc0205cd2:	6e14                	ld	a3,24(a2)
ffffffffc0205cd4:	0107b023          	sd	a6,0(a5)
ffffffffc0205cd8:	e788                	sd	a0,8(a5)
ffffffffc0205cda:	eb8c                	sd	a1,16(a5)
ffffffffc0205cdc:	ef94                	sd	a3,24(a5)
ffffffffc0205cde:	02060613          	addi	a2,a2,32
ffffffffc0205ce2:	02078793          	addi	a5,a5,32
ffffffffc0205ce6:	ff1612e3          	bne	a2,a7,ffffffffc0205cca <do_fork+0x112>
ffffffffc0205cea:	04073823          	sd	zero,80(a4)
ffffffffc0205cee:	140a0063          	beqz	s4,ffffffffc0205e2e <do_fork+0x276>
ffffffffc0205cf2:	01473823          	sd	s4,16(a4)
ffffffffc0205cf6:	00000797          	auipc	a5,0x0
ffffffffc0205cfa:	d5678793          	addi	a5,a5,-682 # ffffffffc0205a4c <forkret>
ffffffffc0205cfe:	f81c                	sd	a5,48(s0)
ffffffffc0205d00:	fc18                	sd	a4,56(s0)
ffffffffc0205d02:	100027f3          	csrr	a5,sstatus
ffffffffc0205d06:	8b89                	andi	a5,a5,2
ffffffffc0205d08:	4901                	li	s2,0
ffffffffc0205d0a:	1e079163          	bnez	a5,ffffffffc0205eec <do_fork+0x334>
ffffffffc0205d0e:	0008b817          	auipc	a6,0x8b
ffffffffc0205d12:	34a80813          	addi	a6,a6,842 # ffffffffc0291058 <last_pid.1>
ffffffffc0205d16:	00082783          	lw	a5,0(a6)
ffffffffc0205d1a:	6709                	lui	a4,0x2
ffffffffc0205d1c:	0017851b          	addiw	a0,a5,1
ffffffffc0205d20:	00a82023          	sw	a0,0(a6)
ffffffffc0205d24:	10e55763          	bge	a0,a4,ffffffffc0205e32 <do_fork+0x27a>
ffffffffc0205d28:	0008b317          	auipc	t1,0x8b
ffffffffc0205d2c:	33430313          	addi	t1,t1,820 # ffffffffc029105c <next_safe.0>
ffffffffc0205d30:	00032783          	lw	a5,0(t1)
ffffffffc0205d34:	00090497          	auipc	s1,0x90
ffffffffc0205d38:	a8c48493          	addi	s1,s1,-1396 # ffffffffc02957c0 <proc_list>
ffffffffc0205d3c:	10f55363          	bge	a0,a5,ffffffffc0205e42 <do_fork+0x28a>
ffffffffc0205d40:	c048                	sw	a0,4(s0)
ffffffffc0205d42:	45a9                	li	a1,10
ffffffffc0205d44:	2501                	sext.w	a0,a0
ffffffffc0205d46:	71b040ef          	jal	ra,ffffffffc020ac60 <hash32>
ffffffffc0205d4a:	02051793          	slli	a5,a0,0x20
ffffffffc0205d4e:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0205d52:	0008c797          	auipc	a5,0x8c
ffffffffc0205d56:	a6e78793          	addi	a5,a5,-1426 # ffffffffc02917c0 <hash_list>
ffffffffc0205d5a:	953e                	add	a0,a0,a5
ffffffffc0205d5c:	650c                	ld	a1,8(a0)
ffffffffc0205d5e:	7014                	ld	a3,32(s0)
ffffffffc0205d60:	0d840793          	addi	a5,s0,216
ffffffffc0205d64:	e19c                	sd	a5,0(a1)
ffffffffc0205d66:	6490                	ld	a2,8(s1)
ffffffffc0205d68:	e51c                	sd	a5,8(a0)
ffffffffc0205d6a:	7af8                	ld	a4,240(a3)
ffffffffc0205d6c:	0c840793          	addi	a5,s0,200
ffffffffc0205d70:	f06c                	sd	a1,224(s0)
ffffffffc0205d72:	ec68                	sd	a0,216(s0)
ffffffffc0205d74:	e21c                	sd	a5,0(a2)
ffffffffc0205d76:	e49c                	sd	a5,8(s1)
ffffffffc0205d78:	e870                	sd	a2,208(s0)
ffffffffc0205d7a:	e464                	sd	s1,200(s0)
ffffffffc0205d7c:	0e043c23          	sd	zero,248(s0)
ffffffffc0205d80:	10e43023          	sd	a4,256(s0)
ffffffffc0205d84:	c311                	beqz	a4,ffffffffc0205d88 <do_fork+0x1d0>
ffffffffc0205d86:	ff60                	sd	s0,248(a4)
ffffffffc0205d88:	0009a783          	lw	a5,0(s3)
ffffffffc0205d8c:	fae0                	sd	s0,240(a3)
ffffffffc0205d8e:	2785                	addiw	a5,a5,1
ffffffffc0205d90:	00f9a023          	sw	a5,0(s3)
ffffffffc0205d94:	14091263          	bnez	s2,ffffffffc0205ed8 <do_fork+0x320>
ffffffffc0205d98:	8522                	mv	a0,s0
ffffffffc0205d9a:	30c010ef          	jal	ra,ffffffffc02070a6 <wakeup_proc>
ffffffffc0205d9e:	00442b03          	lw	s6,4(s0)
ffffffffc0205da2:	70e6                	ld	ra,120(sp)
ffffffffc0205da4:	7446                	ld	s0,112(sp)
ffffffffc0205da6:	74a6                	ld	s1,104(sp)
ffffffffc0205da8:	7906                	ld	s2,96(sp)
ffffffffc0205daa:	69e6                	ld	s3,88(sp)
ffffffffc0205dac:	6a46                	ld	s4,80(sp)
ffffffffc0205dae:	6aa6                	ld	s5,72(sp)
ffffffffc0205db0:	7be2                	ld	s7,56(sp)
ffffffffc0205db2:	7c42                	ld	s8,48(sp)
ffffffffc0205db4:	7ca2                	ld	s9,40(sp)
ffffffffc0205db6:	7d02                	ld	s10,32(sp)
ffffffffc0205db8:	6de2                	ld	s11,24(sp)
ffffffffc0205dba:	855a                	mv	a0,s6
ffffffffc0205dbc:	6b06                	ld	s6,64(sp)
ffffffffc0205dbe:	6109                	addi	sp,sp,128
ffffffffc0205dc0:	8082                	ret
ffffffffc0205dc2:	e25fd0ef          	jal	ra,ffffffffc0203be6 <mm_create>
ffffffffc0205dc6:	e42a                	sd	a0,8(sp)
ffffffffc0205dc8:	14050c63          	beqz	a0,ffffffffc0205f20 <do_fork+0x368>
ffffffffc0205dcc:	d05ff0ef          	jal	ra,ffffffffc0205ad0 <setup_pgdir>
ffffffffc0205dd0:	67a2                	ld	a5,8(sp)
ffffffffc0205dd2:	ed45                	bnez	a0,ffffffffc0205e8a <do_fork+0x2d2>
ffffffffc0205dd4:	038a8b13          	addi	s6,s5,56
ffffffffc0205dd8:	855a                	mv	a0,s6
ffffffffc0205dda:	f68fe0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc0205dde:	000bb703          	ld	a4,0(s7)
ffffffffc0205de2:	67a2                	ld	a5,8(sp)
ffffffffc0205de4:	c701                	beqz	a4,ffffffffc0205dec <do_fork+0x234>
ffffffffc0205de6:	4358                	lw	a4,4(a4)
ffffffffc0205de8:	04eaa823          	sw	a4,80(s5)
ffffffffc0205dec:	853e                	mv	a0,a5
ffffffffc0205dee:	85d6                	mv	a1,s5
ffffffffc0205df0:	e43e                	sd	a5,8(sp)
ffffffffc0205df2:	844fe0ef          	jal	ra,ffffffffc0203e36 <dup_mmap>
ffffffffc0205df6:	872a                	mv	a4,a0
ffffffffc0205df8:	855a                	mv	a0,s6
ffffffffc0205dfa:	8b3a                	mv	s6,a4
ffffffffc0205dfc:	f42fe0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc0205e00:	040aa823          	sw	zero,80(s5)
ffffffffc0205e04:	67a2                	ld	a5,8(sp)
ffffffffc0205e06:	0e0b1963          	bnez	s6,ffffffffc0205ef8 <do_fork+0x340>
ffffffffc0205e0a:	8abe                	mv	s5,a5
ffffffffc0205e0c:	b58d                	j	ffffffffc0205c6e <do_fork+0xb6>
ffffffffc0205e0e:	b9eff0ef          	jal	ra,ffffffffc02051ac <files_create>
ffffffffc0205e12:	892a                	mv	s2,a0
ffffffffc0205e14:	10050663          	beqz	a0,ffffffffc0205f20 <do_fork+0x368>
ffffffffc0205e18:	85d6                	mv	a1,s5
ffffffffc0205e1a:	ccaff0ef          	jal	ra,ffffffffc02052e4 <dup_files>
ffffffffc0205e1e:	8b2a                	mv	s6,a0
ffffffffc0205e20:	8aca                	mv	s5,s2
ffffffffc0205e22:	e80503e3          	beqz	a0,ffffffffc0205ca8 <do_fork+0xf0>
ffffffffc0205e26:	854a                	mv	a0,s2
ffffffffc0205e28:	bbaff0ef          	jal	ra,ffffffffc02051e2 <files_destroy>
ffffffffc0205e2c:	a09d                	j	ffffffffc0205e92 <do_fork+0x2da>
ffffffffc0205e2e:	8a3a                	mv	s4,a4
ffffffffc0205e30:	b5c9                	j	ffffffffc0205cf2 <do_fork+0x13a>
ffffffffc0205e32:	4785                	li	a5,1
ffffffffc0205e34:	00f82023          	sw	a5,0(a6)
ffffffffc0205e38:	4505                	li	a0,1
ffffffffc0205e3a:	0008b317          	auipc	t1,0x8b
ffffffffc0205e3e:	22230313          	addi	t1,t1,546 # ffffffffc029105c <next_safe.0>
ffffffffc0205e42:	00090497          	auipc	s1,0x90
ffffffffc0205e46:	97e48493          	addi	s1,s1,-1666 # ffffffffc02957c0 <proc_list>
ffffffffc0205e4a:	0084be03          	ld	t3,8(s1)
ffffffffc0205e4e:	6789                	lui	a5,0x2
ffffffffc0205e50:	00f32023          	sw	a5,0(t1)
ffffffffc0205e54:	86aa                	mv	a3,a0
ffffffffc0205e56:	4581                	li	a1,0
ffffffffc0205e58:	6e89                	lui	t4,0x2
ffffffffc0205e5a:	0a9e0e63          	beq	t3,s1,ffffffffc0205f16 <do_fork+0x35e>
ffffffffc0205e5e:	88ae                	mv	a7,a1
ffffffffc0205e60:	87f2                	mv	a5,t3
ffffffffc0205e62:	6609                	lui	a2,0x2
ffffffffc0205e64:	a811                	j	ffffffffc0205e78 <do_fork+0x2c0>
ffffffffc0205e66:	00e6d663          	bge	a3,a4,ffffffffc0205e72 <do_fork+0x2ba>
ffffffffc0205e6a:	00c75463          	bge	a4,a2,ffffffffc0205e72 <do_fork+0x2ba>
ffffffffc0205e6e:	863a                	mv	a2,a4
ffffffffc0205e70:	4885                	li	a7,1
ffffffffc0205e72:	679c                	ld	a5,8(a5)
ffffffffc0205e74:	04978963          	beq	a5,s1,ffffffffc0205ec6 <do_fork+0x30e>
ffffffffc0205e78:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_bin_swap_img_size-0x5dc4>
ffffffffc0205e7c:	fed715e3          	bne	a4,a3,ffffffffc0205e66 <do_fork+0x2ae>
ffffffffc0205e80:	2685                	addiw	a3,a3,1
ffffffffc0205e82:	06c6d063          	bge	a3,a2,ffffffffc0205ee2 <do_fork+0x32a>
ffffffffc0205e86:	4585                	li	a1,1
ffffffffc0205e88:	b7ed                	j	ffffffffc0205e72 <do_fork+0x2ba>
ffffffffc0205e8a:	853e                	mv	a0,a5
ffffffffc0205e8c:	ea9fd0ef          	jal	ra,ffffffffc0203d34 <mm_destroy>
ffffffffc0205e90:	5b71                	li	s6,-4
ffffffffc0205e92:	6814                	ld	a3,16(s0)
ffffffffc0205e94:	c02007b7          	lui	a5,0xc0200
ffffffffc0205e98:	0cf6e163          	bltu	a3,a5,ffffffffc0205f5a <do_fork+0x3a2>
ffffffffc0205e9c:	000c3503          	ld	a0,0(s8)
ffffffffc0205ea0:	000db783          	ld	a5,0(s11)
ffffffffc0205ea4:	8e89                	sub	a3,a3,a0
ffffffffc0205ea6:	82b1                	srli	a3,a3,0xc
ffffffffc0205ea8:	08f6fd63          	bgeu	a3,a5,ffffffffc0205f42 <do_fork+0x38a>
ffffffffc0205eac:	000d3503          	ld	a0,0(s10)
ffffffffc0205eb0:	419686b3          	sub	a3,a3,s9
ffffffffc0205eb4:	069a                	slli	a3,a3,0x6
ffffffffc0205eb6:	4589                	li	a1,2
ffffffffc0205eb8:	9536                	add	a0,a0,a3
ffffffffc0205eba:	af0fc0ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0205ebe:	8522                	mv	a0,s0
ffffffffc0205ec0:	97efc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205ec4:	bdf9                	j	ffffffffc0205da2 <do_fork+0x1ea>
ffffffffc0205ec6:	c581                	beqz	a1,ffffffffc0205ece <do_fork+0x316>
ffffffffc0205ec8:	00d82023          	sw	a3,0(a6)
ffffffffc0205ecc:	8536                	mv	a0,a3
ffffffffc0205ece:	e60889e3          	beqz	a7,ffffffffc0205d40 <do_fork+0x188>
ffffffffc0205ed2:	00c32023          	sw	a2,0(t1)
ffffffffc0205ed6:	b5ad                	j	ffffffffc0205d40 <do_fork+0x188>
ffffffffc0205ed8:	d95fa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0205edc:	bd75                	j	ffffffffc0205d98 <do_fork+0x1e0>
ffffffffc0205ede:	5b71                	li	s6,-4
ffffffffc0205ee0:	bff9                	j	ffffffffc0205ebe <do_fork+0x306>
ffffffffc0205ee2:	01d6c363          	blt	a3,t4,ffffffffc0205ee8 <do_fork+0x330>
ffffffffc0205ee6:	4685                	li	a3,1
ffffffffc0205ee8:	4585                	li	a1,1
ffffffffc0205eea:	bf85                	j	ffffffffc0205e5a <do_fork+0x2a2>
ffffffffc0205eec:	d87fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0205ef0:	4905                	li	s2,1
ffffffffc0205ef2:	bd31                	j	ffffffffc0205d0e <do_fork+0x156>
ffffffffc0205ef4:	5b6d                	li	s6,-5
ffffffffc0205ef6:	b575                	j	ffffffffc0205da2 <do_fork+0x1ea>
ffffffffc0205ef8:	853e                	mv	a0,a5
ffffffffc0205efa:	e43e                	sd	a5,8(sp)
ffffffffc0205efc:	fd5fd0ef          	jal	ra,ffffffffc0203ed0 <exit_mmap>
ffffffffc0205f00:	67a2                	ld	a5,8(sp)
ffffffffc0205f02:	6f88                	ld	a0,24(a5)
ffffffffc0205f04:	b57ff0ef          	jal	ra,ffffffffc0205a5a <put_pgdir.isra.0>
ffffffffc0205f08:	67a2                	ld	a5,8(sp)
ffffffffc0205f0a:	853e                	mv	a0,a5
ffffffffc0205f0c:	e29fd0ef          	jal	ra,ffffffffc0203d34 <mm_destroy>
ffffffffc0205f10:	b749                	j	ffffffffc0205e92 <do_fork+0x2da>
ffffffffc0205f12:	5b71                	li	s6,-4
ffffffffc0205f14:	b579                	j	ffffffffc0205da2 <do_fork+0x1ea>
ffffffffc0205f16:	c599                	beqz	a1,ffffffffc0205f24 <do_fork+0x36c>
ffffffffc0205f18:	00d82023          	sw	a3,0(a6)
ffffffffc0205f1c:	8536                	mv	a0,a3
ffffffffc0205f1e:	b50d                	j	ffffffffc0205d40 <do_fork+0x188>
ffffffffc0205f20:	5b71                	li	s6,-4
ffffffffc0205f22:	bf85                	j	ffffffffc0205e92 <do_fork+0x2da>
ffffffffc0205f24:	00082503          	lw	a0,0(a6)
ffffffffc0205f28:	bd21                	j	ffffffffc0205d40 <do_fork+0x188>
ffffffffc0205f2a:	00006617          	auipc	a2,0x6
ffffffffc0205f2e:	26e60613          	addi	a2,a2,622 # ffffffffc020c198 <default_pmm_manager+0x38>
ffffffffc0205f32:	07100593          	li	a1,113
ffffffffc0205f36:	00006517          	auipc	a0,0x6
ffffffffc0205f3a:	28a50513          	addi	a0,a0,650 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc0205f3e:	d60fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f42:	00006617          	auipc	a2,0x6
ffffffffc0205f46:	32660613          	addi	a2,a2,806 # ffffffffc020c268 <default_pmm_manager+0x108>
ffffffffc0205f4a:	06900593          	li	a1,105
ffffffffc0205f4e:	00006517          	auipc	a0,0x6
ffffffffc0205f52:	27250513          	addi	a0,a0,626 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc0205f56:	d48fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f5a:	00006617          	auipc	a2,0x6
ffffffffc0205f5e:	2e660613          	addi	a2,a2,742 # ffffffffc020c240 <default_pmm_manager+0xe0>
ffffffffc0205f62:	07700593          	li	a1,119
ffffffffc0205f66:	00006517          	auipc	a0,0x6
ffffffffc0205f6a:	25a50513          	addi	a0,a0,602 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc0205f6e:	d30fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f72:	00006617          	auipc	a2,0x6
ffffffffc0205f76:	2ce60613          	addi	a2,a2,718 # ffffffffc020c240 <default_pmm_manager+0xe0>
ffffffffc0205f7a:	1b900593          	li	a1,441
ffffffffc0205f7e:	00007517          	auipc	a0,0x7
ffffffffc0205f82:	1ea50513          	addi	a0,a0,490 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc0205f86:	d18fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f8a:	00007697          	auipc	a3,0x7
ffffffffc0205f8e:	1f668693          	addi	a3,a3,502 # ffffffffc020d180 <CSWTCH.79+0x108>
ffffffffc0205f92:	00005617          	auipc	a2,0x5
ffffffffc0205f96:	6e660613          	addi	a2,a2,1766 # ffffffffc020b678 <commands+0x210>
ffffffffc0205f9a:	1d900593          	li	a1,473
ffffffffc0205f9e:	00007517          	auipc	a0,0x7
ffffffffc0205fa2:	1ca50513          	addi	a0,a0,458 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc0205fa6:	cf8fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205faa <kernel_thread>:
ffffffffc0205faa:	7129                	addi	sp,sp,-320
ffffffffc0205fac:	fa22                	sd	s0,304(sp)
ffffffffc0205fae:	f626                	sd	s1,296(sp)
ffffffffc0205fb0:	f24a                	sd	s2,288(sp)
ffffffffc0205fb2:	84ae                	mv	s1,a1
ffffffffc0205fb4:	892a                	mv	s2,a0
ffffffffc0205fb6:	8432                	mv	s0,a2
ffffffffc0205fb8:	4581                	li	a1,0
ffffffffc0205fba:	12000613          	li	a2,288
ffffffffc0205fbe:	850a                	mv	a0,sp
ffffffffc0205fc0:	fe06                	sd	ra,312(sp)
ffffffffc0205fc2:	1d2050ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc0205fc6:	e0ca                	sd	s2,64(sp)
ffffffffc0205fc8:	e4a6                	sd	s1,72(sp)
ffffffffc0205fca:	100027f3          	csrr	a5,sstatus
ffffffffc0205fce:	edd7f793          	andi	a5,a5,-291
ffffffffc0205fd2:	1207e793          	ori	a5,a5,288
ffffffffc0205fd6:	e23e                	sd	a5,256(sp)
ffffffffc0205fd8:	860a                	mv	a2,sp
ffffffffc0205fda:	10046513          	ori	a0,s0,256
ffffffffc0205fde:	00000797          	auipc	a5,0x0
ffffffffc0205fe2:	9cc78793          	addi	a5,a5,-1588 # ffffffffc02059aa <kernel_thread_entry>
ffffffffc0205fe6:	4581                	li	a1,0
ffffffffc0205fe8:	e63e                	sd	a5,264(sp)
ffffffffc0205fea:	bcfff0ef          	jal	ra,ffffffffc0205bb8 <do_fork>
ffffffffc0205fee:	70f2                	ld	ra,312(sp)
ffffffffc0205ff0:	7452                	ld	s0,304(sp)
ffffffffc0205ff2:	74b2                	ld	s1,296(sp)
ffffffffc0205ff4:	7912                	ld	s2,288(sp)
ffffffffc0205ff6:	6131                	addi	sp,sp,320
ffffffffc0205ff8:	8082                	ret

ffffffffc0205ffa <do_exit>:
ffffffffc0205ffa:	7179                	addi	sp,sp,-48
ffffffffc0205ffc:	f022                	sd	s0,32(sp)
ffffffffc0205ffe:	00091417          	auipc	s0,0x91
ffffffffc0206002:	8c240413          	addi	s0,s0,-1854 # ffffffffc02968c0 <current>
ffffffffc0206006:	601c                	ld	a5,0(s0)
ffffffffc0206008:	f406                	sd	ra,40(sp)
ffffffffc020600a:	ec26                	sd	s1,24(sp)
ffffffffc020600c:	e84a                	sd	s2,16(sp)
ffffffffc020600e:	e44e                	sd	s3,8(sp)
ffffffffc0206010:	e052                	sd	s4,0(sp)
ffffffffc0206012:	00091717          	auipc	a4,0x91
ffffffffc0206016:	8b673703          	ld	a4,-1866(a4) # ffffffffc02968c8 <idleproc>
ffffffffc020601a:	0ee78763          	beq	a5,a4,ffffffffc0206108 <do_exit+0x10e>
ffffffffc020601e:	00091497          	auipc	s1,0x91
ffffffffc0206022:	8b248493          	addi	s1,s1,-1870 # ffffffffc02968d0 <initproc>
ffffffffc0206026:	6098                	ld	a4,0(s1)
ffffffffc0206028:	10e78763          	beq	a5,a4,ffffffffc0206136 <do_exit+0x13c>
ffffffffc020602c:	0287b983          	ld	s3,40(a5)
ffffffffc0206030:	892a                	mv	s2,a0
ffffffffc0206032:	02098e63          	beqz	s3,ffffffffc020606e <do_exit+0x74>
ffffffffc0206036:	00091797          	auipc	a5,0x91
ffffffffc020603a:	85a7b783          	ld	a5,-1958(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc020603e:	577d                	li	a4,-1
ffffffffc0206040:	177e                	slli	a4,a4,0x3f
ffffffffc0206042:	83b1                	srli	a5,a5,0xc
ffffffffc0206044:	8fd9                	or	a5,a5,a4
ffffffffc0206046:	18079073          	csrw	satp,a5
ffffffffc020604a:	0309a783          	lw	a5,48(s3)
ffffffffc020604e:	fff7871b          	addiw	a4,a5,-1
ffffffffc0206052:	02e9a823          	sw	a4,48(s3)
ffffffffc0206056:	c769                	beqz	a4,ffffffffc0206120 <do_exit+0x126>
ffffffffc0206058:	601c                	ld	a5,0(s0)
ffffffffc020605a:	1487b503          	ld	a0,328(a5)
ffffffffc020605e:	0207b423          	sd	zero,40(a5)
ffffffffc0206062:	c511                	beqz	a0,ffffffffc020606e <do_exit+0x74>
ffffffffc0206064:	491c                	lw	a5,16(a0)
ffffffffc0206066:	fff7871b          	addiw	a4,a5,-1
ffffffffc020606a:	c918                	sw	a4,16(a0)
ffffffffc020606c:	cb59                	beqz	a4,ffffffffc0206102 <do_exit+0x108>
ffffffffc020606e:	601c                	ld	a5,0(s0)
ffffffffc0206070:	470d                	li	a4,3
ffffffffc0206072:	c398                	sw	a4,0(a5)
ffffffffc0206074:	0f27a423          	sw	s2,232(a5)
ffffffffc0206078:	100027f3          	csrr	a5,sstatus
ffffffffc020607c:	8b89                	andi	a5,a5,2
ffffffffc020607e:	4a01                	li	s4,0
ffffffffc0206080:	e7f9                	bnez	a5,ffffffffc020614e <do_exit+0x154>
ffffffffc0206082:	6018                	ld	a4,0(s0)
ffffffffc0206084:	800007b7          	lui	a5,0x80000
ffffffffc0206088:	0785                	addi	a5,a5,1
ffffffffc020608a:	7308                	ld	a0,32(a4)
ffffffffc020608c:	0ec52703          	lw	a4,236(a0)
ffffffffc0206090:	0cf70363          	beq	a4,a5,ffffffffc0206156 <do_exit+0x15c>
ffffffffc0206094:	6018                	ld	a4,0(s0)
ffffffffc0206096:	7b7c                	ld	a5,240(a4)
ffffffffc0206098:	c3a1                	beqz	a5,ffffffffc02060d8 <do_exit+0xde>
ffffffffc020609a:	800009b7          	lui	s3,0x80000
ffffffffc020609e:	490d                	li	s2,3
ffffffffc02060a0:	0985                	addi	s3,s3,1
ffffffffc02060a2:	a021                	j	ffffffffc02060aa <do_exit+0xb0>
ffffffffc02060a4:	6018                	ld	a4,0(s0)
ffffffffc02060a6:	7b7c                	ld	a5,240(a4)
ffffffffc02060a8:	cb85                	beqz	a5,ffffffffc02060d8 <do_exit+0xde>
ffffffffc02060aa:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_bin_sfs_img_size+0xffffffff7ff8ae00>
ffffffffc02060ae:	6088                	ld	a0,0(s1)
ffffffffc02060b0:	fb74                	sd	a3,240(a4)
ffffffffc02060b2:	7978                	ld	a4,240(a0)
ffffffffc02060b4:	0e07bc23          	sd	zero,248(a5)
ffffffffc02060b8:	10e7b023          	sd	a4,256(a5)
ffffffffc02060bc:	c311                	beqz	a4,ffffffffc02060c0 <do_exit+0xc6>
ffffffffc02060be:	ff7c                	sd	a5,248(a4)
ffffffffc02060c0:	4398                	lw	a4,0(a5)
ffffffffc02060c2:	f388                	sd	a0,32(a5)
ffffffffc02060c4:	f97c                	sd	a5,240(a0)
ffffffffc02060c6:	fd271fe3          	bne	a4,s2,ffffffffc02060a4 <do_exit+0xaa>
ffffffffc02060ca:	0ec52783          	lw	a5,236(a0)
ffffffffc02060ce:	fd379be3          	bne	a5,s3,ffffffffc02060a4 <do_exit+0xaa>
ffffffffc02060d2:	7d5000ef          	jal	ra,ffffffffc02070a6 <wakeup_proc>
ffffffffc02060d6:	b7f9                	j	ffffffffc02060a4 <do_exit+0xaa>
ffffffffc02060d8:	020a1263          	bnez	s4,ffffffffc02060fc <do_exit+0x102>
ffffffffc02060dc:	07c010ef          	jal	ra,ffffffffc0207158 <schedule>
ffffffffc02060e0:	601c                	ld	a5,0(s0)
ffffffffc02060e2:	00007617          	auipc	a2,0x7
ffffffffc02060e6:	0d660613          	addi	a2,a2,214 # ffffffffc020d1b8 <CSWTCH.79+0x140>
ffffffffc02060ea:	2ae00593          	li	a1,686
ffffffffc02060ee:	43d4                	lw	a3,4(a5)
ffffffffc02060f0:	00007517          	auipc	a0,0x7
ffffffffc02060f4:	07850513          	addi	a0,a0,120 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc02060f8:	ba6fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02060fc:	b71fa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0206100:	bff1                	j	ffffffffc02060dc <do_exit+0xe2>
ffffffffc0206102:	8e0ff0ef          	jal	ra,ffffffffc02051e2 <files_destroy>
ffffffffc0206106:	b7a5                	j	ffffffffc020606e <do_exit+0x74>
ffffffffc0206108:	00007617          	auipc	a2,0x7
ffffffffc020610c:	09060613          	addi	a2,a2,144 # ffffffffc020d198 <CSWTCH.79+0x120>
ffffffffc0206110:	27900593          	li	a1,633
ffffffffc0206114:	00007517          	auipc	a0,0x7
ffffffffc0206118:	05450513          	addi	a0,a0,84 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc020611c:	b82fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206120:	854e                	mv	a0,s3
ffffffffc0206122:	daffd0ef          	jal	ra,ffffffffc0203ed0 <exit_mmap>
ffffffffc0206126:	0189b503          	ld	a0,24(s3) # ffffffff80000018 <_binary_bin_sfs_img_size+0xffffffff7ff8ad18>
ffffffffc020612a:	931ff0ef          	jal	ra,ffffffffc0205a5a <put_pgdir.isra.0>
ffffffffc020612e:	854e                	mv	a0,s3
ffffffffc0206130:	c05fd0ef          	jal	ra,ffffffffc0203d34 <mm_destroy>
ffffffffc0206134:	b715                	j	ffffffffc0206058 <do_exit+0x5e>
ffffffffc0206136:	00007617          	auipc	a2,0x7
ffffffffc020613a:	07260613          	addi	a2,a2,114 # ffffffffc020d1a8 <CSWTCH.79+0x130>
ffffffffc020613e:	27d00593          	li	a1,637
ffffffffc0206142:	00007517          	auipc	a0,0x7
ffffffffc0206146:	02650513          	addi	a0,a0,38 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc020614a:	b54fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020614e:	b25fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0206152:	4a05                	li	s4,1
ffffffffc0206154:	b73d                	j	ffffffffc0206082 <do_exit+0x88>
ffffffffc0206156:	751000ef          	jal	ra,ffffffffc02070a6 <wakeup_proc>
ffffffffc020615a:	bf2d                	j	ffffffffc0206094 <do_exit+0x9a>

ffffffffc020615c <do_wait.part.0>:
ffffffffc020615c:	715d                	addi	sp,sp,-80
ffffffffc020615e:	f84a                	sd	s2,48(sp)
ffffffffc0206160:	f44e                	sd	s3,40(sp)
ffffffffc0206162:	80000937          	lui	s2,0x80000
ffffffffc0206166:	6989                	lui	s3,0x2
ffffffffc0206168:	fc26                	sd	s1,56(sp)
ffffffffc020616a:	f052                	sd	s4,32(sp)
ffffffffc020616c:	ec56                	sd	s5,24(sp)
ffffffffc020616e:	e85a                	sd	s6,16(sp)
ffffffffc0206170:	e45e                	sd	s7,8(sp)
ffffffffc0206172:	e486                	sd	ra,72(sp)
ffffffffc0206174:	e0a2                	sd	s0,64(sp)
ffffffffc0206176:	84aa                	mv	s1,a0
ffffffffc0206178:	8a2e                	mv	s4,a1
ffffffffc020617a:	00090b97          	auipc	s7,0x90
ffffffffc020617e:	746b8b93          	addi	s7,s7,1862 # ffffffffc02968c0 <current>
ffffffffc0206182:	00050b1b          	sext.w	s6,a0
ffffffffc0206186:	fff50a9b          	addiw	s5,a0,-1
ffffffffc020618a:	19f9                	addi	s3,s3,-2
ffffffffc020618c:	0905                	addi	s2,s2,1
ffffffffc020618e:	ccbd                	beqz	s1,ffffffffc020620c <do_wait.part.0+0xb0>
ffffffffc0206190:	0359e863          	bltu	s3,s5,ffffffffc02061c0 <do_wait.part.0+0x64>
ffffffffc0206194:	45a9                	li	a1,10
ffffffffc0206196:	855a                	mv	a0,s6
ffffffffc0206198:	2c9040ef          	jal	ra,ffffffffc020ac60 <hash32>
ffffffffc020619c:	02051793          	slli	a5,a0,0x20
ffffffffc02061a0:	01c7d513          	srli	a0,a5,0x1c
ffffffffc02061a4:	0008b797          	auipc	a5,0x8b
ffffffffc02061a8:	61c78793          	addi	a5,a5,1564 # ffffffffc02917c0 <hash_list>
ffffffffc02061ac:	953e                	add	a0,a0,a5
ffffffffc02061ae:	842a                	mv	s0,a0
ffffffffc02061b0:	a029                	j	ffffffffc02061ba <do_wait.part.0+0x5e>
ffffffffc02061b2:	f2c42783          	lw	a5,-212(s0)
ffffffffc02061b6:	02978163          	beq	a5,s1,ffffffffc02061d8 <do_wait.part.0+0x7c>
ffffffffc02061ba:	6400                	ld	s0,8(s0)
ffffffffc02061bc:	fe851be3          	bne	a0,s0,ffffffffc02061b2 <do_wait.part.0+0x56>
ffffffffc02061c0:	5579                	li	a0,-2
ffffffffc02061c2:	60a6                	ld	ra,72(sp)
ffffffffc02061c4:	6406                	ld	s0,64(sp)
ffffffffc02061c6:	74e2                	ld	s1,56(sp)
ffffffffc02061c8:	7942                	ld	s2,48(sp)
ffffffffc02061ca:	79a2                	ld	s3,40(sp)
ffffffffc02061cc:	7a02                	ld	s4,32(sp)
ffffffffc02061ce:	6ae2                	ld	s5,24(sp)
ffffffffc02061d0:	6b42                	ld	s6,16(sp)
ffffffffc02061d2:	6ba2                	ld	s7,8(sp)
ffffffffc02061d4:	6161                	addi	sp,sp,80
ffffffffc02061d6:	8082                	ret
ffffffffc02061d8:	000bb683          	ld	a3,0(s7)
ffffffffc02061dc:	f4843783          	ld	a5,-184(s0)
ffffffffc02061e0:	fed790e3          	bne	a5,a3,ffffffffc02061c0 <do_wait.part.0+0x64>
ffffffffc02061e4:	f2842703          	lw	a4,-216(s0)
ffffffffc02061e8:	478d                	li	a5,3
ffffffffc02061ea:	0ef70b63          	beq	a4,a5,ffffffffc02062e0 <do_wait.part.0+0x184>
ffffffffc02061ee:	4785                	li	a5,1
ffffffffc02061f0:	c29c                	sw	a5,0(a3)
ffffffffc02061f2:	0f26a623          	sw	s2,236(a3)
ffffffffc02061f6:	763000ef          	jal	ra,ffffffffc0207158 <schedule>
ffffffffc02061fa:	000bb783          	ld	a5,0(s7)
ffffffffc02061fe:	0b07a783          	lw	a5,176(a5)
ffffffffc0206202:	8b85                	andi	a5,a5,1
ffffffffc0206204:	d7c9                	beqz	a5,ffffffffc020618e <do_wait.part.0+0x32>
ffffffffc0206206:	555d                	li	a0,-9
ffffffffc0206208:	df3ff0ef          	jal	ra,ffffffffc0205ffa <do_exit>
ffffffffc020620c:	000bb683          	ld	a3,0(s7)
ffffffffc0206210:	7ae0                	ld	s0,240(a3)
ffffffffc0206212:	d45d                	beqz	s0,ffffffffc02061c0 <do_wait.part.0+0x64>
ffffffffc0206214:	470d                	li	a4,3
ffffffffc0206216:	a021                	j	ffffffffc020621e <do_wait.part.0+0xc2>
ffffffffc0206218:	10043403          	ld	s0,256(s0)
ffffffffc020621c:	d869                	beqz	s0,ffffffffc02061ee <do_wait.part.0+0x92>
ffffffffc020621e:	401c                	lw	a5,0(s0)
ffffffffc0206220:	fee79ce3          	bne	a5,a4,ffffffffc0206218 <do_wait.part.0+0xbc>
ffffffffc0206224:	00090797          	auipc	a5,0x90
ffffffffc0206228:	6a47b783          	ld	a5,1700(a5) # ffffffffc02968c8 <idleproc>
ffffffffc020622c:	0c878963          	beq	a5,s0,ffffffffc02062fe <do_wait.part.0+0x1a2>
ffffffffc0206230:	00090797          	auipc	a5,0x90
ffffffffc0206234:	6a07b783          	ld	a5,1696(a5) # ffffffffc02968d0 <initproc>
ffffffffc0206238:	0cf40363          	beq	s0,a5,ffffffffc02062fe <do_wait.part.0+0x1a2>
ffffffffc020623c:	000a0663          	beqz	s4,ffffffffc0206248 <do_wait.part.0+0xec>
ffffffffc0206240:	0e842783          	lw	a5,232(s0)
ffffffffc0206244:	00fa2023          	sw	a5,0(s4)
ffffffffc0206248:	100027f3          	csrr	a5,sstatus
ffffffffc020624c:	8b89                	andi	a5,a5,2
ffffffffc020624e:	4581                	li	a1,0
ffffffffc0206250:	e7c1                	bnez	a5,ffffffffc02062d8 <do_wait.part.0+0x17c>
ffffffffc0206252:	6c70                	ld	a2,216(s0)
ffffffffc0206254:	7074                	ld	a3,224(s0)
ffffffffc0206256:	10043703          	ld	a4,256(s0)
ffffffffc020625a:	7c7c                	ld	a5,248(s0)
ffffffffc020625c:	e614                	sd	a3,8(a2)
ffffffffc020625e:	e290                	sd	a2,0(a3)
ffffffffc0206260:	6470                	ld	a2,200(s0)
ffffffffc0206262:	6874                	ld	a3,208(s0)
ffffffffc0206264:	e614                	sd	a3,8(a2)
ffffffffc0206266:	e290                	sd	a2,0(a3)
ffffffffc0206268:	c319                	beqz	a4,ffffffffc020626e <do_wait.part.0+0x112>
ffffffffc020626a:	ff7c                	sd	a5,248(a4)
ffffffffc020626c:	7c7c                	ld	a5,248(s0)
ffffffffc020626e:	c3b5                	beqz	a5,ffffffffc02062d2 <do_wait.part.0+0x176>
ffffffffc0206270:	10e7b023          	sd	a4,256(a5)
ffffffffc0206274:	00090717          	auipc	a4,0x90
ffffffffc0206278:	66470713          	addi	a4,a4,1636 # ffffffffc02968d8 <nr_process>
ffffffffc020627c:	431c                	lw	a5,0(a4)
ffffffffc020627e:	37fd                	addiw	a5,a5,-1
ffffffffc0206280:	c31c                	sw	a5,0(a4)
ffffffffc0206282:	e5a9                	bnez	a1,ffffffffc02062cc <do_wait.part.0+0x170>
ffffffffc0206284:	6814                	ld	a3,16(s0)
ffffffffc0206286:	c02007b7          	lui	a5,0xc0200
ffffffffc020628a:	04f6ee63          	bltu	a3,a5,ffffffffc02062e6 <do_wait.part.0+0x18a>
ffffffffc020628e:	00090797          	auipc	a5,0x90
ffffffffc0206292:	62a7b783          	ld	a5,1578(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0206296:	8e9d                	sub	a3,a3,a5
ffffffffc0206298:	82b1                	srli	a3,a3,0xc
ffffffffc020629a:	00090797          	auipc	a5,0x90
ffffffffc020629e:	6067b783          	ld	a5,1542(a5) # ffffffffc02968a0 <npage>
ffffffffc02062a2:	06f6fa63          	bgeu	a3,a5,ffffffffc0206316 <do_wait.part.0+0x1ba>
ffffffffc02062a6:	00009517          	auipc	a0,0x9
ffffffffc02062aa:	0b253503          	ld	a0,178(a0) # ffffffffc020f358 <nbase>
ffffffffc02062ae:	8e89                	sub	a3,a3,a0
ffffffffc02062b0:	069a                	slli	a3,a3,0x6
ffffffffc02062b2:	00090517          	auipc	a0,0x90
ffffffffc02062b6:	5f653503          	ld	a0,1526(a0) # ffffffffc02968a8 <pages>
ffffffffc02062ba:	9536                	add	a0,a0,a3
ffffffffc02062bc:	4589                	li	a1,2
ffffffffc02062be:	eedfb0ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02062c2:	8522                	mv	a0,s0
ffffffffc02062c4:	d7bfb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02062c8:	4501                	li	a0,0
ffffffffc02062ca:	bde5                	j	ffffffffc02061c2 <do_wait.part.0+0x66>
ffffffffc02062cc:	9a1fa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02062d0:	bf55                	j	ffffffffc0206284 <do_wait.part.0+0x128>
ffffffffc02062d2:	701c                	ld	a5,32(s0)
ffffffffc02062d4:	fbf8                	sd	a4,240(a5)
ffffffffc02062d6:	bf79                	j	ffffffffc0206274 <do_wait.part.0+0x118>
ffffffffc02062d8:	99bfa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02062dc:	4585                	li	a1,1
ffffffffc02062de:	bf95                	j	ffffffffc0206252 <do_wait.part.0+0xf6>
ffffffffc02062e0:	f2840413          	addi	s0,s0,-216
ffffffffc02062e4:	b781                	j	ffffffffc0206224 <do_wait.part.0+0xc8>
ffffffffc02062e6:	00006617          	auipc	a2,0x6
ffffffffc02062ea:	f5a60613          	addi	a2,a2,-166 # ffffffffc020c240 <default_pmm_manager+0xe0>
ffffffffc02062ee:	07700593          	li	a1,119
ffffffffc02062f2:	00006517          	auipc	a0,0x6
ffffffffc02062f6:	ece50513          	addi	a0,a0,-306 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc02062fa:	9a4fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02062fe:	00007617          	auipc	a2,0x7
ffffffffc0206302:	eda60613          	addi	a2,a2,-294 # ffffffffc020d1d8 <CSWTCH.79+0x160>
ffffffffc0206306:	44500593          	li	a1,1093
ffffffffc020630a:	00007517          	auipc	a0,0x7
ffffffffc020630e:	e5e50513          	addi	a0,a0,-418 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc0206312:	98cfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206316:	00006617          	auipc	a2,0x6
ffffffffc020631a:	f5260613          	addi	a2,a2,-174 # ffffffffc020c268 <default_pmm_manager+0x108>
ffffffffc020631e:	06900593          	li	a1,105
ffffffffc0206322:	00006517          	auipc	a0,0x6
ffffffffc0206326:	e9e50513          	addi	a0,a0,-354 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc020632a:	974fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020632e <init_main>:
ffffffffc020632e:	1141                	addi	sp,sp,-16
ffffffffc0206330:	00007517          	auipc	a0,0x7
ffffffffc0206334:	ec850513          	addi	a0,a0,-312 # ffffffffc020d1f8 <CSWTCH.79+0x180>
ffffffffc0206338:	e406                	sd	ra,8(sp)
ffffffffc020633a:	58e010ef          	jal	ra,ffffffffc02078c8 <vfs_set_bootfs>
ffffffffc020633e:	e179                	bnez	a0,ffffffffc0206404 <init_main+0xd6>
ffffffffc0206340:	eabfb0ef          	jal	ra,ffffffffc02021ea <nr_free_pages>
ffffffffc0206344:	c47fb0ef          	jal	ra,ffffffffc0201f8a <kallocated>
ffffffffc0206348:	4601                	li	a2,0
ffffffffc020634a:	4581                	li	a1,0
ffffffffc020634c:	00000517          	auipc	a0,0x0
ffffffffc0206350:	7b450513          	addi	a0,a0,1972 # ffffffffc0206b00 <user_main>
ffffffffc0206354:	c57ff0ef          	jal	ra,ffffffffc0205faa <kernel_thread>
ffffffffc0206358:	00a04563          	bgtz	a0,ffffffffc0206362 <init_main+0x34>
ffffffffc020635c:	a841                	j	ffffffffc02063ec <init_main+0xbe>
ffffffffc020635e:	5fb000ef          	jal	ra,ffffffffc0207158 <schedule>
ffffffffc0206362:	4581                	li	a1,0
ffffffffc0206364:	4501                	li	a0,0
ffffffffc0206366:	df7ff0ef          	jal	ra,ffffffffc020615c <do_wait.part.0>
ffffffffc020636a:	d975                	beqz	a0,ffffffffc020635e <init_main+0x30>
ffffffffc020636c:	e31fe0ef          	jal	ra,ffffffffc020519c <fs_cleanup>
ffffffffc0206370:	00007517          	auipc	a0,0x7
ffffffffc0206374:	ed050513          	addi	a0,a0,-304 # ffffffffc020d240 <CSWTCH.79+0x1c8>
ffffffffc0206378:	e2ff90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020637c:	00090797          	auipc	a5,0x90
ffffffffc0206380:	5547b783          	ld	a5,1364(a5) # ffffffffc02968d0 <initproc>
ffffffffc0206384:	7bf8                	ld	a4,240(a5)
ffffffffc0206386:	e339                	bnez	a4,ffffffffc02063cc <init_main+0x9e>
ffffffffc0206388:	7ff8                	ld	a4,248(a5)
ffffffffc020638a:	e329                	bnez	a4,ffffffffc02063cc <init_main+0x9e>
ffffffffc020638c:	1007b703          	ld	a4,256(a5)
ffffffffc0206390:	ef15                	bnez	a4,ffffffffc02063cc <init_main+0x9e>
ffffffffc0206392:	00090697          	auipc	a3,0x90
ffffffffc0206396:	5466a683          	lw	a3,1350(a3) # ffffffffc02968d8 <nr_process>
ffffffffc020639a:	4709                	li	a4,2
ffffffffc020639c:	0ce69163          	bne	a3,a4,ffffffffc020645e <init_main+0x130>
ffffffffc02063a0:	0008f717          	auipc	a4,0x8f
ffffffffc02063a4:	42070713          	addi	a4,a4,1056 # ffffffffc02957c0 <proc_list>
ffffffffc02063a8:	6714                	ld	a3,8(a4)
ffffffffc02063aa:	0c878793          	addi	a5,a5,200
ffffffffc02063ae:	08d79863          	bne	a5,a3,ffffffffc020643e <init_main+0x110>
ffffffffc02063b2:	6318                	ld	a4,0(a4)
ffffffffc02063b4:	06e79563          	bne	a5,a4,ffffffffc020641e <init_main+0xf0>
ffffffffc02063b8:	00007517          	auipc	a0,0x7
ffffffffc02063bc:	f7050513          	addi	a0,a0,-144 # ffffffffc020d328 <CSWTCH.79+0x2b0>
ffffffffc02063c0:	de7f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02063c4:	60a2                	ld	ra,8(sp)
ffffffffc02063c6:	4501                	li	a0,0
ffffffffc02063c8:	0141                	addi	sp,sp,16
ffffffffc02063ca:	8082                	ret
ffffffffc02063cc:	00007697          	auipc	a3,0x7
ffffffffc02063d0:	e9c68693          	addi	a3,a3,-356 # ffffffffc020d268 <CSWTCH.79+0x1f0>
ffffffffc02063d4:	00005617          	auipc	a2,0x5
ffffffffc02063d8:	2a460613          	addi	a2,a2,676 # ffffffffc020b678 <commands+0x210>
ffffffffc02063dc:	4bb00593          	li	a1,1211
ffffffffc02063e0:	00007517          	auipc	a0,0x7
ffffffffc02063e4:	d8850513          	addi	a0,a0,-632 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc02063e8:	8b6fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02063ec:	00007617          	auipc	a2,0x7
ffffffffc02063f0:	e3460613          	addi	a2,a2,-460 # ffffffffc020d220 <CSWTCH.79+0x1a8>
ffffffffc02063f4:	4ae00593          	li	a1,1198
ffffffffc02063f8:	00007517          	auipc	a0,0x7
ffffffffc02063fc:	d7050513          	addi	a0,a0,-656 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc0206400:	89efa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206404:	86aa                	mv	a3,a0
ffffffffc0206406:	00007617          	auipc	a2,0x7
ffffffffc020640a:	dfa60613          	addi	a2,a2,-518 # ffffffffc020d200 <CSWTCH.79+0x188>
ffffffffc020640e:	4a600593          	li	a1,1190
ffffffffc0206412:	00007517          	auipc	a0,0x7
ffffffffc0206416:	d5650513          	addi	a0,a0,-682 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc020641a:	884fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020641e:	00007697          	auipc	a3,0x7
ffffffffc0206422:	eda68693          	addi	a3,a3,-294 # ffffffffc020d2f8 <CSWTCH.79+0x280>
ffffffffc0206426:	00005617          	auipc	a2,0x5
ffffffffc020642a:	25260613          	addi	a2,a2,594 # ffffffffc020b678 <commands+0x210>
ffffffffc020642e:	4be00593          	li	a1,1214
ffffffffc0206432:	00007517          	auipc	a0,0x7
ffffffffc0206436:	d3650513          	addi	a0,a0,-714 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc020643a:	864fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020643e:	00007697          	auipc	a3,0x7
ffffffffc0206442:	e8a68693          	addi	a3,a3,-374 # ffffffffc020d2c8 <CSWTCH.79+0x250>
ffffffffc0206446:	00005617          	auipc	a2,0x5
ffffffffc020644a:	23260613          	addi	a2,a2,562 # ffffffffc020b678 <commands+0x210>
ffffffffc020644e:	4bd00593          	li	a1,1213
ffffffffc0206452:	00007517          	auipc	a0,0x7
ffffffffc0206456:	d1650513          	addi	a0,a0,-746 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc020645a:	844fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020645e:	00007697          	auipc	a3,0x7
ffffffffc0206462:	e5a68693          	addi	a3,a3,-422 # ffffffffc020d2b8 <CSWTCH.79+0x240>
ffffffffc0206466:	00005617          	auipc	a2,0x5
ffffffffc020646a:	21260613          	addi	a2,a2,530 # ffffffffc020b678 <commands+0x210>
ffffffffc020646e:	4bc00593          	li	a1,1212
ffffffffc0206472:	00007517          	auipc	a0,0x7
ffffffffc0206476:	cf650513          	addi	a0,a0,-778 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc020647a:	824fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020647e <do_execve>:
ffffffffc020647e:	dc010113          	addi	sp,sp,-576
ffffffffc0206482:	23213023          	sd	s2,544(sp)
ffffffffc0206486:	00090917          	auipc	s2,0x90
ffffffffc020648a:	43a90913          	addi	s2,s2,1082 # ffffffffc02968c0 <current>
ffffffffc020648e:	00093683          	ld	a3,0(s2)
ffffffffc0206492:	21613023          	sd	s6,512(sp)
ffffffffc0206496:	fff58b1b          	addiw	s6,a1,-1
ffffffffc020649a:	21413823          	sd	s4,528(sp)
ffffffffc020649e:	22113c23          	sd	ra,568(sp)
ffffffffc02064a2:	22813823          	sd	s0,560(sp)
ffffffffc02064a6:	22913423          	sd	s1,552(sp)
ffffffffc02064aa:	21313c23          	sd	s3,536(sp)
ffffffffc02064ae:	21513423          	sd	s5,520(sp)
ffffffffc02064b2:	ffde                	sd	s7,504(sp)
ffffffffc02064b4:	fbe2                	sd	s8,496(sp)
ffffffffc02064b6:	f7e6                	sd	s9,488(sp)
ffffffffc02064b8:	f3ea                	sd	s10,480(sp)
ffffffffc02064ba:	efee                	sd	s11,472(sp)
ffffffffc02064bc:	000b071b          	sext.w	a4,s6
ffffffffc02064c0:	47fd                	li	a5,31
ffffffffc02064c2:	0286ba03          	ld	s4,40(a3)
ffffffffc02064c6:	5ae7e763          	bltu	a5,a4,ffffffffc0206a74 <do_execve+0x5f6>
ffffffffc02064ca:	842e                	mv	s0,a1
ffffffffc02064cc:	84aa                	mv	s1,a0
ffffffffc02064ce:	8cb2                	mv	s9,a2
ffffffffc02064d0:	4581                	li	a1,0
ffffffffc02064d2:	4641                	li	a2,16
ffffffffc02064d4:	00a8                	addi	a0,sp,72
ffffffffc02064d6:	4bf040ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc02064da:	000a0c63          	beqz	s4,ffffffffc02064f2 <do_execve+0x74>
ffffffffc02064de:	038a0513          	addi	a0,s4,56
ffffffffc02064e2:	860fe0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc02064e6:	00093783          	ld	a5,0(s2)
ffffffffc02064ea:	c781                	beqz	a5,ffffffffc02064f2 <do_execve+0x74>
ffffffffc02064ec:	43dc                	lw	a5,4(a5)
ffffffffc02064ee:	04fa2823          	sw	a5,80(s4)
ffffffffc02064f2:	18048463          	beqz	s1,ffffffffc020667a <do_execve+0x1fc>
ffffffffc02064f6:	46c1                	li	a3,16
ffffffffc02064f8:	8626                	mv	a2,s1
ffffffffc02064fa:	00ac                	addi	a1,sp,72
ffffffffc02064fc:	8552                	mv	a0,s4
ffffffffc02064fe:	e6dfd0ef          	jal	ra,ffffffffc020436a <copy_string>
ffffffffc0206502:	56050f63          	beqz	a0,ffffffffc0206a80 <do_execve+0x602>
ffffffffc0206506:	00341a93          	slli	s5,s0,0x3
ffffffffc020650a:	4681                	li	a3,0
ffffffffc020650c:	8656                	mv	a2,s5
ffffffffc020650e:	85e6                	mv	a1,s9
ffffffffc0206510:	8552                	mv	a0,s4
ffffffffc0206512:	d5ffd0ef          	jal	ra,ffffffffc0204270 <user_mem_check>
ffffffffc0206516:	8be6                	mv	s7,s9
ffffffffc0206518:	56050063          	beqz	a0,ffffffffc0206a78 <do_execve+0x5fa>
ffffffffc020651c:	0d010c13          	addi	s8,sp,208
ffffffffc0206520:	4981                	li	s3,0
ffffffffc0206522:	6505                	lui	a0,0x1
ffffffffc0206524:	a6bfb0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0206528:	84aa                	mv	s1,a0
ffffffffc020652a:	c969                	beqz	a0,ffffffffc02065fc <do_execve+0x17e>
ffffffffc020652c:	000bb603          	ld	a2,0(s7)
ffffffffc0206530:	85aa                	mv	a1,a0
ffffffffc0206532:	6685                	lui	a3,0x1
ffffffffc0206534:	8552                	mv	a0,s4
ffffffffc0206536:	e35fd0ef          	jal	ra,ffffffffc020436a <copy_string>
ffffffffc020653a:	12050b63          	beqz	a0,ffffffffc0206670 <do_execve+0x1f2>
ffffffffc020653e:	009c3023          	sd	s1,0(s8)
ffffffffc0206542:	2985                	addiw	s3,s3,1
ffffffffc0206544:	0c21                	addi	s8,s8,8
ffffffffc0206546:	0ba1                	addi	s7,s7,8
ffffffffc0206548:	fd341de3          	bne	s0,s3,ffffffffc0206522 <do_execve+0xa4>
ffffffffc020654c:	000cb483          	ld	s1,0(s9)
ffffffffc0206550:	060a0963          	beqz	s4,ffffffffc02065c2 <do_execve+0x144>
ffffffffc0206554:	038a0513          	addi	a0,s4,56
ffffffffc0206558:	fe7fd0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc020655c:	00093783          	ld	a5,0(s2)
ffffffffc0206560:	040a2823          	sw	zero,80(s4)
ffffffffc0206564:	1487b503          	ld	a0,328(a5)
ffffffffc0206568:	d11fe0ef          	jal	ra,ffffffffc0205278 <files_closeall>
ffffffffc020656c:	4581                	li	a1,0
ffffffffc020656e:	8526                	mv	a0,s1
ffffffffc0206570:	f95fe0ef          	jal	ra,ffffffffc0205504 <sysfile_open>
ffffffffc0206574:	89aa                	mv	s3,a0
ffffffffc0206576:	30054863          	bltz	a0,ffffffffc0206886 <do_execve+0x408>
ffffffffc020657a:	00090797          	auipc	a5,0x90
ffffffffc020657e:	3167b783          	ld	a5,790(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0206582:	577d                	li	a4,-1
ffffffffc0206584:	177e                	slli	a4,a4,0x3f
ffffffffc0206586:	83b1                	srli	a5,a5,0xc
ffffffffc0206588:	8fd9                	or	a5,a5,a4
ffffffffc020658a:	18079073          	csrw	satp,a5
ffffffffc020658e:	030a2783          	lw	a5,48(s4)
ffffffffc0206592:	fff7871b          	addiw	a4,a5,-1
ffffffffc0206596:	02ea2823          	sw	a4,48(s4)
ffffffffc020659a:	30070b63          	beqz	a4,ffffffffc02068b0 <do_execve+0x432>
ffffffffc020659e:	00093783          	ld	a5,0(s2)
ffffffffc02065a2:	0207b423          	sd	zero,40(a5)
ffffffffc02065a6:	e40fd0ef          	jal	ra,ffffffffc0203be6 <mm_create>
ffffffffc02065aa:	8a2a                	mv	s4,a0
ffffffffc02065ac:	2c050c63          	beqz	a0,ffffffffc0206884 <do_execve+0x406>
ffffffffc02065b0:	d20ff0ef          	jal	ra,ffffffffc0205ad0 <setup_pgdir>
ffffffffc02065b4:	84aa                	mv	s1,a0
ffffffffc02065b6:	cd71                	beqz	a0,ffffffffc0206692 <do_execve+0x214>
ffffffffc02065b8:	8552                	mv	a0,s4
ffffffffc02065ba:	f7afd0ef          	jal	ra,ffffffffc0203d34 <mm_destroy>
ffffffffc02065be:	89a6                	mv	s3,s1
ffffffffc02065c0:	a4d9                	j	ffffffffc0206886 <do_execve+0x408>
ffffffffc02065c2:	00093783          	ld	a5,0(s2)
ffffffffc02065c6:	1487b503          	ld	a0,328(a5)
ffffffffc02065ca:	caffe0ef          	jal	ra,ffffffffc0205278 <files_closeall>
ffffffffc02065ce:	4581                	li	a1,0
ffffffffc02065d0:	8526                	mv	a0,s1
ffffffffc02065d2:	f33fe0ef          	jal	ra,ffffffffc0205504 <sysfile_open>
ffffffffc02065d6:	89aa                	mv	s3,a0
ffffffffc02065d8:	2a054763          	bltz	a0,ffffffffc0206886 <do_execve+0x408>
ffffffffc02065dc:	00093783          	ld	a5,0(s2)
ffffffffc02065e0:	779c                	ld	a5,40(a5)
ffffffffc02065e2:	d3f1                	beqz	a5,ffffffffc02065a6 <do_execve+0x128>
ffffffffc02065e4:	00007617          	auipc	a2,0x7
ffffffffc02065e8:	d7460613          	addi	a2,a2,-652 # ffffffffc020d358 <CSWTCH.79+0x2e0>
ffffffffc02065ec:	2e000593          	li	a1,736
ffffffffc02065f0:	00007517          	auipc	a0,0x7
ffffffffc02065f4:	b7850513          	addi	a0,a0,-1160 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc02065f8:	ea7f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02065fc:	54f1                	li	s1,-4
ffffffffc02065fe:	02098863          	beqz	s3,ffffffffc020662e <do_execve+0x1b0>
ffffffffc0206602:	00399713          	slli	a4,s3,0x3
ffffffffc0206606:	fff98413          	addi	s0,s3,-1 # 1fff <_binary_bin_swap_img_size-0x5d01>
ffffffffc020660a:	019c                	addi	a5,sp,192
ffffffffc020660c:	39fd                	addiw	s3,s3,-1
ffffffffc020660e:	97ba                	add	a5,a5,a4
ffffffffc0206610:	02099713          	slli	a4,s3,0x20
ffffffffc0206614:	01d75993          	srli	s3,a4,0x1d
ffffffffc0206618:	040e                	slli	s0,s0,0x3
ffffffffc020661a:	0998                	addi	a4,sp,208
ffffffffc020661c:	943a                	add	s0,s0,a4
ffffffffc020661e:	413789b3          	sub	s3,a5,s3
ffffffffc0206622:	6008                	ld	a0,0(s0)
ffffffffc0206624:	1461                	addi	s0,s0,-8
ffffffffc0206626:	a19fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020662a:	fe899ce3          	bne	s3,s0,ffffffffc0206622 <do_execve+0x1a4>
ffffffffc020662e:	000a0863          	beqz	s4,ffffffffc020663e <do_execve+0x1c0>
ffffffffc0206632:	038a0513          	addi	a0,s4,56
ffffffffc0206636:	f09fd0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc020663a:	040a2823          	sw	zero,80(s4)
ffffffffc020663e:	23813083          	ld	ra,568(sp)
ffffffffc0206642:	23013403          	ld	s0,560(sp)
ffffffffc0206646:	22013903          	ld	s2,544(sp)
ffffffffc020664a:	21813983          	ld	s3,536(sp)
ffffffffc020664e:	21013a03          	ld	s4,528(sp)
ffffffffc0206652:	20813a83          	ld	s5,520(sp)
ffffffffc0206656:	20013b03          	ld	s6,512(sp)
ffffffffc020665a:	7bfe                	ld	s7,504(sp)
ffffffffc020665c:	7c5e                	ld	s8,496(sp)
ffffffffc020665e:	7cbe                	ld	s9,488(sp)
ffffffffc0206660:	7d1e                	ld	s10,480(sp)
ffffffffc0206662:	6dfe                	ld	s11,472(sp)
ffffffffc0206664:	8526                	mv	a0,s1
ffffffffc0206666:	22813483          	ld	s1,552(sp)
ffffffffc020666a:	24010113          	addi	sp,sp,576
ffffffffc020666e:	8082                	ret
ffffffffc0206670:	8526                	mv	a0,s1
ffffffffc0206672:	9cdfb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0206676:	54f5                	li	s1,-3
ffffffffc0206678:	b759                	j	ffffffffc02065fe <do_execve+0x180>
ffffffffc020667a:	00093783          	ld	a5,0(s2)
ffffffffc020667e:	00007617          	auipc	a2,0x7
ffffffffc0206682:	cca60613          	addi	a2,a2,-822 # ffffffffc020d348 <CSWTCH.79+0x2d0>
ffffffffc0206686:	45c1                	li	a1,16
ffffffffc0206688:	43d4                	lw	a3,4(a5)
ffffffffc020668a:	00a8                	addi	a0,sp,72
ffffffffc020668c:	219040ef          	jal	ra,ffffffffc020b0a4 <snprintf>
ffffffffc0206690:	bd9d                	j	ffffffffc0206506 <do_execve+0x88>
ffffffffc0206692:	4601                	li	a2,0
ffffffffc0206694:	4581                	li	a1,0
ffffffffc0206696:	854e                	mv	a0,s3
ffffffffc0206698:	8d2ff0ef          	jal	ra,ffffffffc020576a <sysfile_seek>
ffffffffc020669c:	84aa                	mv	s1,a0
ffffffffc020669e:	c909                	beqz	a0,ffffffffc02066b0 <do_execve+0x232>
ffffffffc02066a0:	8552                	mv	a0,s4
ffffffffc02066a2:	82ffd0ef          	jal	ra,ffffffffc0203ed0 <exit_mmap>
ffffffffc02066a6:	018a3503          	ld	a0,24(s4)
ffffffffc02066aa:	bb0ff0ef          	jal	ra,ffffffffc0205a5a <put_pgdir.isra.0>
ffffffffc02066ae:	b729                	j	ffffffffc02065b8 <do_execve+0x13a>
ffffffffc02066b0:	04000613          	li	a2,64
ffffffffc02066b4:	090c                	addi	a1,sp,144
ffffffffc02066b6:	854e                	mv	a0,s3
ffffffffc02066b8:	e85fe0ef          	jal	ra,ffffffffc020553c <sysfile_read>
ffffffffc02066bc:	04000793          	li	a5,64
ffffffffc02066c0:	1af51563          	bne	a0,a5,ffffffffc020686a <do_execve+0x3ec>
ffffffffc02066c4:	474a                	lw	a4,144(sp)
ffffffffc02066c6:	464c47b7          	lui	a5,0x464c4
ffffffffc02066ca:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_bin_sfs_img_size+0x4644f27f>
ffffffffc02066ce:	30f71063          	bne	a4,a5,ffffffffc02069ce <do_execve+0x550>
ffffffffc02066d2:	774a                	ld	a4,176(sp)
ffffffffc02066d4:	0c815783          	lhu	a5,200(sp)
ffffffffc02066d8:	fc02                	sd	zero,56(sp)
ffffffffc02066da:	f83a                	sd	a4,48(sp)
ffffffffc02066dc:	c7a1                	beqz	a5,ffffffffc0206724 <do_execve+0x2a6>
ffffffffc02066de:	57fd                	li	a5,-1
ffffffffc02066e0:	83b1                	srli	a5,a5,0xc
ffffffffc02066e2:	f43e                	sd	a5,40(sp)
ffffffffc02066e4:	75c2                	ld	a1,48(sp)
ffffffffc02066e6:	4601                	li	a2,0
ffffffffc02066e8:	854e                	mv	a0,s3
ffffffffc02066ea:	880ff0ef          	jal	ra,ffffffffc020576a <sysfile_seek>
ffffffffc02066ee:	84aa                	mv	s1,a0
ffffffffc02066f0:	f945                	bnez	a0,ffffffffc02066a0 <do_execve+0x222>
ffffffffc02066f2:	03800613          	li	a2,56
ffffffffc02066f6:	08ac                	addi	a1,sp,88
ffffffffc02066f8:	854e                	mv	a0,s3
ffffffffc02066fa:	e43fe0ef          	jal	ra,ffffffffc020553c <sysfile_read>
ffffffffc02066fe:	03800793          	li	a5,56
ffffffffc0206702:	16f51463          	bne	a0,a5,ffffffffc020686a <do_execve+0x3ec>
ffffffffc0206706:	4766                	lw	a4,88(sp)
ffffffffc0206708:	4785                	li	a5,1
ffffffffc020670a:	1af70e63          	beq	a4,a5,ffffffffc02068c6 <do_execve+0x448>
ffffffffc020670e:	7762                	ld	a4,56(sp)
ffffffffc0206710:	76c2                	ld	a3,48(sp)
ffffffffc0206712:	0c815783          	lhu	a5,200(sp)
ffffffffc0206716:	2705                	addiw	a4,a4,1
ffffffffc0206718:	03868693          	addi	a3,a3,56 # 1038 <_binary_bin_swap_img_size-0x6cc8>
ffffffffc020671c:	fc3a                	sd	a4,56(sp)
ffffffffc020671e:	f836                	sd	a3,48(sp)
ffffffffc0206720:	fcf742e3          	blt	a4,a5,ffffffffc02066e4 <do_execve+0x266>
ffffffffc0206724:	4701                	li	a4,0
ffffffffc0206726:	46ad                	li	a3,11
ffffffffc0206728:	00100637          	lui	a2,0x100
ffffffffc020672c:	7ff005b7          	lui	a1,0x7ff00
ffffffffc0206730:	8552                	mv	a0,s4
ffffffffc0206732:	e54fd0ef          	jal	ra,ffffffffc0203d86 <mm_map>
ffffffffc0206736:	84aa                	mv	s1,a0
ffffffffc0206738:	f525                	bnez	a0,ffffffffc02066a0 <do_execve+0x222>
ffffffffc020673a:	7ffff9b7          	lui	s3,0x7ffff
ffffffffc020673e:	7c7d                	lui	s8,0xfffff
ffffffffc0206740:	7fffbbb7          	lui	s7,0x7fffb
ffffffffc0206744:	018a3503          	ld	a0,24(s4)
ffffffffc0206748:	465d                	li	a2,23
ffffffffc020674a:	85ce                	mv	a1,s3
ffffffffc020674c:	bb4fd0ef          	jal	ra,ffffffffc0203b00 <pgdir_alloc_page>
ffffffffc0206750:	32050063          	beqz	a0,ffffffffc0206a70 <do_execve+0x5f2>
ffffffffc0206754:	99e2                	add	s3,s3,s8
ffffffffc0206756:	ff7997e3          	bne	s3,s7,ffffffffc0206744 <do_execve+0x2c6>
ffffffffc020675a:	030a2783          	lw	a5,48(s4)
ffffffffc020675e:	00093703          	ld	a4,0(s2)
ffffffffc0206762:	018a3683          	ld	a3,24(s4)
ffffffffc0206766:	2785                	addiw	a5,a5,1
ffffffffc0206768:	02fa2823          	sw	a5,48(s4)
ffffffffc020676c:	03473423          	sd	s4,40(a4)
ffffffffc0206770:	c02007b7          	lui	a5,0xc0200
ffffffffc0206774:	34f6e163          	bltu	a3,a5,ffffffffc0206ab6 <do_execve+0x638>
ffffffffc0206778:	00090797          	auipc	a5,0x90
ffffffffc020677c:	1407b783          	ld	a5,320(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0206780:	8e9d                	sub	a3,a3,a5
ffffffffc0206782:	f754                	sd	a3,168(a4)
ffffffffc0206784:	577d                	li	a4,-1
ffffffffc0206786:	00c6d793          	srli	a5,a3,0xc
ffffffffc020678a:	177e                	slli	a4,a4,0x3f
ffffffffc020678c:	8fd9                	or	a5,a5,a4
ffffffffc020678e:	18079073          	csrw	satp,a5
ffffffffc0206792:	8556                	mv	a0,s5
ffffffffc0206794:	ffafb0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0206798:	8baa                	mv	s7,a0
ffffffffc020679a:	30050263          	beqz	a0,ffffffffc0206a9e <do_execve+0x620>
ffffffffc020679e:	020b1793          	slli	a5,s6,0x20
ffffffffc02067a2:	0c010993          	addi	s3,sp,192
ffffffffc02067a6:	01d7db13          	srli	s6,a5,0x1d
ffffffffc02067aa:	99d6                	add	s3,s3,s5
ffffffffc02067ac:	ff8a8a13          	addi	s4,s5,-8
ffffffffc02067b0:	099c                	addi	a5,sp,208
ffffffffc02067b2:	416989b3          	sub	s3,s3,s6
ffffffffc02067b6:	4b05                	li	s6,1
ffffffffc02067b8:	01478c33          	add	s8,a5,s4
ffffffffc02067bc:	0b7e                	slli	s6,s6,0x1f
ffffffffc02067be:	9a2a                	add	s4,s4,a0
ffffffffc02067c0:	000c3c83          	ld	s9,0(s8) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc02067c4:	1a61                	addi	s4,s4,-8
ffffffffc02067c6:	1c61                	addi	s8,s8,-8
ffffffffc02067c8:	8566                	mv	a0,s9
ffffffffc02067ca:	129040ef          	jal	ra,ffffffffc020b0f2 <strlen>
ffffffffc02067ce:	00150613          	addi	a2,a0,1
ffffffffc02067d2:	40cb0b33          	sub	s6,s6,a2
ffffffffc02067d6:	85e6                	mv	a1,s9
ffffffffc02067d8:	855a                	mv	a0,s6
ffffffffc02067da:	20d040ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc02067de:	016a3423          	sd	s6,8(s4)
ffffffffc02067e2:	fd899fe3          	bne	s3,s8,ffffffffc02067c0 <do_execve+0x342>
ffffffffc02067e6:	ff8b7b13          	andi	s6,s6,-8
ffffffffc02067ea:	415b0b33          	sub	s6,s6,s5
ffffffffc02067ee:	8656                	mv	a2,s5
ffffffffc02067f0:	85de                	mv	a1,s7
ffffffffc02067f2:	855a                	mv	a0,s6
ffffffffc02067f4:	1f3040ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc02067f8:	855e                	mv	a0,s7
ffffffffc02067fa:	845fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02067fe:	00093783          	ld	a5,0(s2)
ffffffffc0206802:	12000613          	li	a2,288
ffffffffc0206806:	4581                	li	a1,0
ffffffffc0206808:	0a07ba03          	ld	s4,160(a5)
ffffffffc020680c:	8552                	mv	a0,s4
ffffffffc020680e:	100a3a83          	ld	s5,256(s4)
ffffffffc0206812:	183040ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc0206816:	772a                	ld	a4,168(sp)
ffffffffc0206818:	fff40793          	addi	a5,s0,-1
ffffffffc020681c:	edfafa93          	andi	s5,s5,-289
ffffffffc0206820:	020aea93          	ori	s5,s5,32
ffffffffc0206824:	078e                	slli	a5,a5,0x3
ffffffffc0206826:	10ea3423          	sd	a4,264(s4)
ffffffffc020682a:	0998                	addi	a4,sp,208
ffffffffc020682c:	048a3823          	sd	s0,80(s4)
ffffffffc0206830:	016a3823          	sd	s6,16(s4)
ffffffffc0206834:	056a3c23          	sd	s6,88(s4)
ffffffffc0206838:	115a3023          	sd	s5,256(s4)
ffffffffc020683c:	00f70433          	add	s0,a4,a5
ffffffffc0206840:	6008                	ld	a0,0(s0)
ffffffffc0206842:	1461                	addi	s0,s0,-8
ffffffffc0206844:	ffafb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0206848:	ff341ce3          	bne	s0,s3,ffffffffc0206840 <do_execve+0x3c2>
ffffffffc020684c:	00093403          	ld	s0,0(s2)
ffffffffc0206850:	4641                	li	a2,16
ffffffffc0206852:	4581                	li	a1,0
ffffffffc0206854:	0b440413          	addi	s0,s0,180
ffffffffc0206858:	8522                	mv	a0,s0
ffffffffc020685a:	13b040ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc020685e:	463d                	li	a2,15
ffffffffc0206860:	00ac                	addi	a1,sp,72
ffffffffc0206862:	8522                	mv	a0,s0
ffffffffc0206864:	183040ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc0206868:	bbd9                	j	ffffffffc020663e <do_execve+0x1c0>
ffffffffc020686a:	0005049b          	sext.w	s1,a0
ffffffffc020686e:	e20549e3          	bltz	a0,ffffffffc02066a0 <do_execve+0x222>
ffffffffc0206872:	8552                	mv	a0,s4
ffffffffc0206874:	e5cfd0ef          	jal	ra,ffffffffc0203ed0 <exit_mmap>
ffffffffc0206878:	018a3503          	ld	a0,24(s4)
ffffffffc020687c:	54fd                	li	s1,-1
ffffffffc020687e:	9dcff0ef          	jal	ra,ffffffffc0205a5a <put_pgdir.isra.0>
ffffffffc0206882:	bb1d                	j	ffffffffc02065b8 <do_execve+0x13a>
ffffffffc0206884:	59f1                	li	s3,-4
ffffffffc0206886:	020b1793          	slli	a5,s6,0x20
ffffffffc020688a:	147d                	addi	s0,s0,-1
ffffffffc020688c:	0184                	addi	s1,sp,192
ffffffffc020688e:	01d7db13          	srli	s6,a5,0x1d
ffffffffc0206892:	040e                	slli	s0,s0,0x3
ffffffffc0206894:	94d6                	add	s1,s1,s5
ffffffffc0206896:	099c                	addi	a5,sp,208
ffffffffc0206898:	943e                	add	s0,s0,a5
ffffffffc020689a:	416484b3          	sub	s1,s1,s6
ffffffffc020689e:	6008                	ld	a0,0(s0)
ffffffffc02068a0:	1461                	addi	s0,s0,-8
ffffffffc02068a2:	f9cfb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02068a6:	fe849ce3          	bne	s1,s0,ffffffffc020689e <do_execve+0x420>
ffffffffc02068aa:	854e                	mv	a0,s3
ffffffffc02068ac:	f4eff0ef          	jal	ra,ffffffffc0205ffa <do_exit>
ffffffffc02068b0:	8552                	mv	a0,s4
ffffffffc02068b2:	e1efd0ef          	jal	ra,ffffffffc0203ed0 <exit_mmap>
ffffffffc02068b6:	018a3503          	ld	a0,24(s4)
ffffffffc02068ba:	9a0ff0ef          	jal	ra,ffffffffc0205a5a <put_pgdir.isra.0>
ffffffffc02068be:	8552                	mv	a0,s4
ffffffffc02068c0:	c74fd0ef          	jal	ra,ffffffffc0203d34 <mm_destroy>
ffffffffc02068c4:	b9e9                	j	ffffffffc020659e <do_execve+0x120>
ffffffffc02068c6:	660a                	ld	a2,128(sp)
ffffffffc02068c8:	77e6                	ld	a5,120(sp)
ffffffffc02068ca:	1cf66863          	bltu	a2,a5,ffffffffc0206a9a <do_execve+0x61c>
ffffffffc02068ce:	47f6                	lw	a5,92(sp)
ffffffffc02068d0:	4027d69b          	sraiw	a3,a5,0x2
ffffffffc02068d4:	0027f713          	andi	a4,a5,2
ffffffffc02068d8:	8a85                	andi	a3,a3,1
ffffffffc02068da:	c319                	beqz	a4,ffffffffc02068e0 <do_execve+0x462>
ffffffffc02068dc:	0026e693          	ori	a3,a3,2
ffffffffc02068e0:	8b85                	andi	a5,a5,1
ffffffffc02068e2:	c781                	beqz	a5,ffffffffc02068ea <do_execve+0x46c>
ffffffffc02068e4:	0046e693          	ori	a3,a3,4
ffffffffc02068e8:	4791                	li	a5,4
ffffffffc02068ea:	45c5                	li	a1,17
ffffffffc02068ec:	0016f713          	andi	a4,a3,1
ffffffffc02068f0:	e42e                	sd	a1,8(sp)
ffffffffc02068f2:	c319                	beqz	a4,ffffffffc02068f8 <do_execve+0x47a>
ffffffffc02068f4:	474d                	li	a4,19
ffffffffc02068f6:	e43a                	sd	a4,8(sp)
ffffffffc02068f8:	0026f713          	andi	a4,a3,2
ffffffffc02068fc:	c319                	beqz	a4,ffffffffc0206902 <do_execve+0x484>
ffffffffc02068fe:	475d                	li	a4,23
ffffffffc0206900:	e43a                	sd	a4,8(sp)
ffffffffc0206902:	0e079263          	bnez	a5,ffffffffc02069e6 <do_execve+0x568>
ffffffffc0206906:	75a6                	ld	a1,104(sp)
ffffffffc0206908:	4701                	li	a4,0
ffffffffc020690a:	8552                	mv	a0,s4
ffffffffc020690c:	c7afd0ef          	jal	ra,ffffffffc0203d86 <mm_map>
ffffffffc0206910:	84aa                	mv	s1,a0
ffffffffc0206912:	d80517e3          	bnez	a0,ffffffffc02066a0 <do_execve+0x222>
ffffffffc0206916:	7ca6                	ld	s9,104(sp)
ffffffffc0206918:	7be6                	ld	s7,120(sp)
ffffffffc020691a:	76fd                	lui	a3,0xfffff
ffffffffc020691c:	7c06                	ld	s8,96(sp)
ffffffffc020691e:	9be6                	add	s7,s7,s9
ffffffffc0206920:	00dcfdb3          	and	s11,s9,a3
ffffffffc0206924:	037ce863          	bltu	s9,s7,ffffffffc0206954 <do_execve+0x4d6>
ffffffffc0206928:	a2b5                	j	ffffffffc0206a94 <do_execve+0x616>
ffffffffc020692a:	6742                	ld	a4,16(sp)
ffffffffc020692c:	67e2                	ld	a5,24(sp)
ffffffffc020692e:	7802                	ld	a6,32(sp)
ffffffffc0206930:	41bc8db3          	sub	s11,s9,s11
ffffffffc0206934:	00f705b3          	add	a1,a4,a5
ffffffffc0206938:	8642                	mv	a2,a6
ffffffffc020693a:	95ee                	add	a1,a1,s11
ffffffffc020693c:	854e                	mv	a0,s3
ffffffffc020693e:	e842                	sd	a6,16(sp)
ffffffffc0206940:	bfdfe0ef          	jal	ra,ffffffffc020553c <sysfile_read>
ffffffffc0206944:	6842                	ld	a6,16(sp)
ffffffffc0206946:	f2a812e3          	bne	a6,a0,ffffffffc020686a <do_execve+0x3ec>
ffffffffc020694a:	9cc2                	add	s9,s9,a6
ffffffffc020694c:	9c42                	add	s8,s8,a6
ffffffffc020694e:	0b7cf163          	bgeu	s9,s7,ffffffffc02069f0 <do_execve+0x572>
ffffffffc0206952:	8dea                	mv	s11,s10
ffffffffc0206954:	018a3503          	ld	a0,24(s4)
ffffffffc0206958:	6622                	ld	a2,8(sp)
ffffffffc020695a:	85ee                	mv	a1,s11
ffffffffc020695c:	9a4fd0ef          	jal	ra,ffffffffc0203b00 <pgdir_alloc_page>
ffffffffc0206960:	10050863          	beqz	a0,ffffffffc0206a70 <do_execve+0x5f2>
ffffffffc0206964:	6785                	lui	a5,0x1
ffffffffc0206966:	00fd8d33          	add	s10,s11,a5
ffffffffc020696a:	419b8833          	sub	a6,s7,s9
ffffffffc020696e:	01abe463          	bltu	s7,s10,ffffffffc0206976 <do_execve+0x4f8>
ffffffffc0206972:	419d0833          	sub	a6,s10,s9
ffffffffc0206976:	00090797          	auipc	a5,0x90
ffffffffc020697a:	f3278793          	addi	a5,a5,-206 # ffffffffc02968a8 <pages>
ffffffffc020697e:	638c                	ld	a1,0(a5)
ffffffffc0206980:	00009797          	auipc	a5,0x9
ffffffffc0206984:	9d878793          	addi	a5,a5,-1576 # ffffffffc020f358 <nbase>
ffffffffc0206988:	0007b883          	ld	a7,0(a5)
ffffffffc020698c:	00090797          	auipc	a5,0x90
ffffffffc0206990:	f1478793          	addi	a5,a5,-236 # ffffffffc02968a0 <npage>
ffffffffc0206994:	40b505b3          	sub	a1,a0,a1
ffffffffc0206998:	6390                	ld	a2,0(a5)
ffffffffc020699a:	77a2                	ld	a5,40(sp)
ffffffffc020699c:	8599                	srai	a1,a1,0x6
ffffffffc020699e:	95c6                	add	a1,a1,a7
ffffffffc02069a0:	00f5f533          	and	a0,a1,a5
ffffffffc02069a4:	00c59793          	slli	a5,a1,0xc
ffffffffc02069a8:	e83e                	sd	a5,16(sp)
ffffffffc02069aa:	12c57263          	bgeu	a0,a2,ffffffffc0206ace <do_execve+0x650>
ffffffffc02069ae:	00090797          	auipc	a5,0x90
ffffffffc02069b2:	f0a78793          	addi	a5,a5,-246 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02069b6:	639c                	ld	a5,0(a5)
ffffffffc02069b8:	4601                	li	a2,0
ffffffffc02069ba:	85e2                	mv	a1,s8
ffffffffc02069bc:	854e                	mv	a0,s3
ffffffffc02069be:	f042                	sd	a6,32(sp)
ffffffffc02069c0:	ec3e                	sd	a5,24(sp)
ffffffffc02069c2:	da9fe0ef          	jal	ra,ffffffffc020576a <sysfile_seek>
ffffffffc02069c6:	84aa                	mv	s1,a0
ffffffffc02069c8:	cc051ce3          	bnez	a0,ffffffffc02066a0 <do_execve+0x222>
ffffffffc02069cc:	bfb9                	j	ffffffffc020692a <do_execve+0x4ac>
ffffffffc02069ce:	8552                	mv	a0,s4
ffffffffc02069d0:	d00fd0ef          	jal	ra,ffffffffc0203ed0 <exit_mmap>
ffffffffc02069d4:	018a3503          	ld	a0,24(s4)
ffffffffc02069d8:	59e1                	li	s3,-8
ffffffffc02069da:	880ff0ef          	jal	ra,ffffffffc0205a5a <put_pgdir.isra.0>
ffffffffc02069de:	8552                	mv	a0,s4
ffffffffc02069e0:	b54fd0ef          	jal	ra,ffffffffc0203d34 <mm_destroy>
ffffffffc02069e4:	b54d                	j	ffffffffc0206886 <do_execve+0x408>
ffffffffc02069e6:	67a2                	ld	a5,8(sp)
ffffffffc02069e8:	0087e793          	ori	a5,a5,8
ffffffffc02069ec:	e43e                	sd	a5,8(sp)
ffffffffc02069ee:	bf21                	j	ffffffffc0206906 <do_execve+0x488>
ffffffffc02069f0:	74a6                	ld	s1,104(sp)
ffffffffc02069f2:	668a                	ld	a3,128(sp)
ffffffffc02069f4:	94b6                	add	s1,s1,a3
ffffffffc02069f6:	d09cfce3          	bgeu	s9,s1,ffffffffc020670e <do_execve+0x290>
ffffffffc02069fa:	00090b97          	auipc	s7,0x90
ffffffffc02069fe:	ea6b8b93          	addi	s7,s7,-346 # ffffffffc02968a0 <npage>
ffffffffc0206a02:	00090c17          	auipc	s8,0x90
ffffffffc0206a06:	eb6c0c13          	addi	s8,s8,-330 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0206a0a:	a8a1                	j	ffffffffc0206a62 <do_execve+0x5e4>
ffffffffc0206a0c:	6785                	lui	a5,0x1
ffffffffc0206a0e:	41ac8833          	sub	a6,s9,s10
ffffffffc0206a12:	9d3e                	add	s10,s10,a5
ffffffffc0206a14:	41948633          	sub	a2,s1,s9
ffffffffc0206a18:	01a4e463          	bltu	s1,s10,ffffffffc0206a20 <do_execve+0x5a2>
ffffffffc0206a1c:	419d0633          	sub	a2,s10,s9
ffffffffc0206a20:	00090797          	auipc	a5,0x90
ffffffffc0206a24:	e8878793          	addi	a5,a5,-376 # ffffffffc02968a8 <pages>
ffffffffc0206a28:	6394                	ld	a3,0(a5)
ffffffffc0206a2a:	00009797          	auipc	a5,0x9
ffffffffc0206a2e:	92e78793          	addi	a5,a5,-1746 # ffffffffc020f358 <nbase>
ffffffffc0206a32:	0007b883          	ld	a7,0(a5)
ffffffffc0206a36:	40d506b3          	sub	a3,a0,a3
ffffffffc0206a3a:	77a2                	ld	a5,40(sp)
ffffffffc0206a3c:	8699                	srai	a3,a3,0x6
ffffffffc0206a3e:	000bb583          	ld	a1,0(s7)
ffffffffc0206a42:	96c6                	add	a3,a3,a7
ffffffffc0206a44:	00f6f533          	and	a0,a3,a5
ffffffffc0206a48:	06b2                	slli	a3,a3,0xc
ffffffffc0206a4a:	08b57f63          	bgeu	a0,a1,ffffffffc0206ae8 <do_execve+0x66a>
ffffffffc0206a4e:	000c3503          	ld	a0,0(s8)
ffffffffc0206a52:	9cb2                	add	s9,s9,a2
ffffffffc0206a54:	4581                	li	a1,0
ffffffffc0206a56:	9536                	add	a0,a0,a3
ffffffffc0206a58:	9542                	add	a0,a0,a6
ffffffffc0206a5a:	73a040ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc0206a5e:	ca9cf8e3          	bgeu	s9,s1,ffffffffc020670e <do_execve+0x290>
ffffffffc0206a62:	018a3503          	ld	a0,24(s4)
ffffffffc0206a66:	6622                	ld	a2,8(sp)
ffffffffc0206a68:	85ea                	mv	a1,s10
ffffffffc0206a6a:	896fd0ef          	jal	ra,ffffffffc0203b00 <pgdir_alloc_page>
ffffffffc0206a6e:	fd59                	bnez	a0,ffffffffc0206a0c <do_execve+0x58e>
ffffffffc0206a70:	54f1                	li	s1,-4
ffffffffc0206a72:	b13d                	j	ffffffffc02066a0 <do_execve+0x222>
ffffffffc0206a74:	54f5                	li	s1,-3
ffffffffc0206a76:	b6e1                	j	ffffffffc020663e <do_execve+0x1c0>
ffffffffc0206a78:	54f5                	li	s1,-3
ffffffffc0206a7a:	ba0a1ce3          	bnez	s4,ffffffffc0206632 <do_execve+0x1b4>
ffffffffc0206a7e:	b6c1                	j	ffffffffc020663e <do_execve+0x1c0>
ffffffffc0206a80:	fe0a0ae3          	beqz	s4,ffffffffc0206a74 <do_execve+0x5f6>
ffffffffc0206a84:	038a0513          	addi	a0,s4,56
ffffffffc0206a88:	ab7fd0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc0206a8c:	54f5                	li	s1,-3
ffffffffc0206a8e:	040a2823          	sw	zero,80(s4)
ffffffffc0206a92:	b675                	j	ffffffffc020663e <do_execve+0x1c0>
ffffffffc0206a94:	84e6                	mv	s1,s9
ffffffffc0206a96:	8d6e                	mv	s10,s11
ffffffffc0206a98:	bfa9                	j	ffffffffc02069f2 <do_execve+0x574>
ffffffffc0206a9a:	54e1                	li	s1,-8
ffffffffc0206a9c:	b111                	j	ffffffffc02066a0 <do_execve+0x222>
ffffffffc0206a9e:	8552                	mv	a0,s4
ffffffffc0206aa0:	c30fd0ef          	jal	ra,ffffffffc0203ed0 <exit_mmap>
ffffffffc0206aa4:	018a3503          	ld	a0,24(s4)
ffffffffc0206aa8:	59f1                	li	s3,-4
ffffffffc0206aaa:	fb1fe0ef          	jal	ra,ffffffffc0205a5a <put_pgdir.isra.0>
ffffffffc0206aae:	8552                	mv	a0,s4
ffffffffc0206ab0:	a84fd0ef          	jal	ra,ffffffffc0203d34 <mm_destroy>
ffffffffc0206ab4:	bbc9                	j	ffffffffc0206886 <do_execve+0x408>
ffffffffc0206ab6:	00005617          	auipc	a2,0x5
ffffffffc0206aba:	78a60613          	addi	a2,a2,1930 # ffffffffc020c240 <default_pmm_manager+0xe0>
ffffffffc0206abe:	36000593          	li	a1,864
ffffffffc0206ac2:	00006517          	auipc	a0,0x6
ffffffffc0206ac6:	6a650513          	addi	a0,a0,1702 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc0206aca:	9d5f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206ace:	86be                	mv	a3,a5
ffffffffc0206ad0:	00005617          	auipc	a2,0x5
ffffffffc0206ad4:	6c860613          	addi	a2,a2,1736 # ffffffffc020c198 <default_pmm_manager+0x38>
ffffffffc0206ad8:	07100593          	li	a1,113
ffffffffc0206adc:	00005517          	auipc	a0,0x5
ffffffffc0206ae0:	6e450513          	addi	a0,a0,1764 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc0206ae4:	9bbf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206ae8:	00005617          	auipc	a2,0x5
ffffffffc0206aec:	6b060613          	addi	a2,a2,1712 # ffffffffc020c198 <default_pmm_manager+0x38>
ffffffffc0206af0:	07100593          	li	a1,113
ffffffffc0206af4:	00005517          	auipc	a0,0x5
ffffffffc0206af8:	6cc50513          	addi	a0,a0,1740 # ffffffffc020c1c0 <default_pmm_manager+0x60>
ffffffffc0206afc:	9a3f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206b00 <user_main>:
ffffffffc0206b00:	7179                	addi	sp,sp,-48
ffffffffc0206b02:	e84a                	sd	s2,16(sp)
ffffffffc0206b04:	00090917          	auipc	s2,0x90
ffffffffc0206b08:	dbc90913          	addi	s2,s2,-580 # ffffffffc02968c0 <current>
ffffffffc0206b0c:	00093783          	ld	a5,0(s2)
ffffffffc0206b10:	00007617          	auipc	a2,0x7
ffffffffc0206b14:	87060613          	addi	a2,a2,-1936 # ffffffffc020d380 <CSWTCH.79+0x308>
ffffffffc0206b18:	00007517          	auipc	a0,0x7
ffffffffc0206b1c:	87050513          	addi	a0,a0,-1936 # ffffffffc020d388 <CSWTCH.79+0x310>
ffffffffc0206b20:	43cc                	lw	a1,4(a5)
ffffffffc0206b22:	f406                	sd	ra,40(sp)
ffffffffc0206b24:	f022                	sd	s0,32(sp)
ffffffffc0206b26:	ec26                	sd	s1,24(sp)
ffffffffc0206b28:	e032                	sd	a2,0(sp)
ffffffffc0206b2a:	e402                	sd	zero,8(sp)
ffffffffc0206b2c:	e7af90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206b30:	6782                	ld	a5,0(sp)
ffffffffc0206b32:	cfb9                	beqz	a5,ffffffffc0206b90 <user_main+0x90>
ffffffffc0206b34:	003c                	addi	a5,sp,8
ffffffffc0206b36:	4401                	li	s0,0
ffffffffc0206b38:	6398                	ld	a4,0(a5)
ffffffffc0206b3a:	0405                	addi	s0,s0,1
ffffffffc0206b3c:	07a1                	addi	a5,a5,8
ffffffffc0206b3e:	ff6d                	bnez	a4,ffffffffc0206b38 <user_main+0x38>
ffffffffc0206b40:	00093783          	ld	a5,0(s2)
ffffffffc0206b44:	12000613          	li	a2,288
ffffffffc0206b48:	6b84                	ld	s1,16(a5)
ffffffffc0206b4a:	73cc                	ld	a1,160(a5)
ffffffffc0206b4c:	6789                	lui	a5,0x2
ffffffffc0206b4e:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0206b52:	94be                	add	s1,s1,a5
ffffffffc0206b54:	8526                	mv	a0,s1
ffffffffc0206b56:	690040ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc0206b5a:	00093783          	ld	a5,0(s2)
ffffffffc0206b5e:	860a                	mv	a2,sp
ffffffffc0206b60:	0004059b          	sext.w	a1,s0
ffffffffc0206b64:	f3c4                	sd	s1,160(a5)
ffffffffc0206b66:	00007517          	auipc	a0,0x7
ffffffffc0206b6a:	81a50513          	addi	a0,a0,-2022 # ffffffffc020d380 <CSWTCH.79+0x308>
ffffffffc0206b6e:	911ff0ef          	jal	ra,ffffffffc020647e <do_execve>
ffffffffc0206b72:	8126                	mv	sp,s1
ffffffffc0206b74:	edcfa06f          	j	ffffffffc0201250 <__trapret>
ffffffffc0206b78:	00007617          	auipc	a2,0x7
ffffffffc0206b7c:	83860613          	addi	a2,a2,-1992 # ffffffffc020d3b0 <CSWTCH.79+0x338>
ffffffffc0206b80:	49c00593          	li	a1,1180
ffffffffc0206b84:	00006517          	auipc	a0,0x6
ffffffffc0206b88:	5e450513          	addi	a0,a0,1508 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc0206b8c:	913f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206b90:	4401                	li	s0,0
ffffffffc0206b92:	b77d                	j	ffffffffc0206b40 <user_main+0x40>

ffffffffc0206b94 <do_yield>:
ffffffffc0206b94:	00090797          	auipc	a5,0x90
ffffffffc0206b98:	d2c7b783          	ld	a5,-724(a5) # ffffffffc02968c0 <current>
ffffffffc0206b9c:	4705                	li	a4,1
ffffffffc0206b9e:	ef98                	sd	a4,24(a5)
ffffffffc0206ba0:	4501                	li	a0,0
ffffffffc0206ba2:	8082                	ret

ffffffffc0206ba4 <do_wait>:
ffffffffc0206ba4:	1101                	addi	sp,sp,-32
ffffffffc0206ba6:	e822                	sd	s0,16(sp)
ffffffffc0206ba8:	e426                	sd	s1,8(sp)
ffffffffc0206baa:	ec06                	sd	ra,24(sp)
ffffffffc0206bac:	842e                	mv	s0,a1
ffffffffc0206bae:	84aa                	mv	s1,a0
ffffffffc0206bb0:	c999                	beqz	a1,ffffffffc0206bc6 <do_wait+0x22>
ffffffffc0206bb2:	00090797          	auipc	a5,0x90
ffffffffc0206bb6:	d0e7b783          	ld	a5,-754(a5) # ffffffffc02968c0 <current>
ffffffffc0206bba:	7788                	ld	a0,40(a5)
ffffffffc0206bbc:	4685                	li	a3,1
ffffffffc0206bbe:	4611                	li	a2,4
ffffffffc0206bc0:	eb0fd0ef          	jal	ra,ffffffffc0204270 <user_mem_check>
ffffffffc0206bc4:	c909                	beqz	a0,ffffffffc0206bd6 <do_wait+0x32>
ffffffffc0206bc6:	85a2                	mv	a1,s0
ffffffffc0206bc8:	6442                	ld	s0,16(sp)
ffffffffc0206bca:	60e2                	ld	ra,24(sp)
ffffffffc0206bcc:	8526                	mv	a0,s1
ffffffffc0206bce:	64a2                	ld	s1,8(sp)
ffffffffc0206bd0:	6105                	addi	sp,sp,32
ffffffffc0206bd2:	d8aff06f          	j	ffffffffc020615c <do_wait.part.0>
ffffffffc0206bd6:	60e2                	ld	ra,24(sp)
ffffffffc0206bd8:	6442                	ld	s0,16(sp)
ffffffffc0206bda:	64a2                	ld	s1,8(sp)
ffffffffc0206bdc:	5575                	li	a0,-3
ffffffffc0206bde:	6105                	addi	sp,sp,32
ffffffffc0206be0:	8082                	ret

ffffffffc0206be2 <do_kill>:
ffffffffc0206be2:	1141                	addi	sp,sp,-16
ffffffffc0206be4:	6789                	lui	a5,0x2
ffffffffc0206be6:	e406                	sd	ra,8(sp)
ffffffffc0206be8:	e022                	sd	s0,0(sp)
ffffffffc0206bea:	fff5071b          	addiw	a4,a0,-1
ffffffffc0206bee:	17f9                	addi	a5,a5,-2
ffffffffc0206bf0:	02e7e963          	bltu	a5,a4,ffffffffc0206c22 <do_kill+0x40>
ffffffffc0206bf4:	842a                	mv	s0,a0
ffffffffc0206bf6:	45a9                	li	a1,10
ffffffffc0206bf8:	2501                	sext.w	a0,a0
ffffffffc0206bfa:	066040ef          	jal	ra,ffffffffc020ac60 <hash32>
ffffffffc0206bfe:	02051793          	slli	a5,a0,0x20
ffffffffc0206c02:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0206c06:	0008b797          	auipc	a5,0x8b
ffffffffc0206c0a:	bba78793          	addi	a5,a5,-1094 # ffffffffc02917c0 <hash_list>
ffffffffc0206c0e:	953e                	add	a0,a0,a5
ffffffffc0206c10:	87aa                	mv	a5,a0
ffffffffc0206c12:	a029                	j	ffffffffc0206c1c <do_kill+0x3a>
ffffffffc0206c14:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0206c18:	00870b63          	beq	a4,s0,ffffffffc0206c2e <do_kill+0x4c>
ffffffffc0206c1c:	679c                	ld	a5,8(a5)
ffffffffc0206c1e:	fef51be3          	bne	a0,a5,ffffffffc0206c14 <do_kill+0x32>
ffffffffc0206c22:	5475                	li	s0,-3
ffffffffc0206c24:	60a2                	ld	ra,8(sp)
ffffffffc0206c26:	8522                	mv	a0,s0
ffffffffc0206c28:	6402                	ld	s0,0(sp)
ffffffffc0206c2a:	0141                	addi	sp,sp,16
ffffffffc0206c2c:	8082                	ret
ffffffffc0206c2e:	fd87a703          	lw	a4,-40(a5)
ffffffffc0206c32:	00177693          	andi	a3,a4,1
ffffffffc0206c36:	e295                	bnez	a3,ffffffffc0206c5a <do_kill+0x78>
ffffffffc0206c38:	4bd4                	lw	a3,20(a5)
ffffffffc0206c3a:	00176713          	ori	a4,a4,1
ffffffffc0206c3e:	fce7ac23          	sw	a4,-40(a5)
ffffffffc0206c42:	4401                	li	s0,0
ffffffffc0206c44:	fe06d0e3          	bgez	a3,ffffffffc0206c24 <do_kill+0x42>
ffffffffc0206c48:	f2878513          	addi	a0,a5,-216
ffffffffc0206c4c:	45a000ef          	jal	ra,ffffffffc02070a6 <wakeup_proc>
ffffffffc0206c50:	60a2                	ld	ra,8(sp)
ffffffffc0206c52:	8522                	mv	a0,s0
ffffffffc0206c54:	6402                	ld	s0,0(sp)
ffffffffc0206c56:	0141                	addi	sp,sp,16
ffffffffc0206c58:	8082                	ret
ffffffffc0206c5a:	545d                	li	s0,-9
ffffffffc0206c5c:	b7e1                	j	ffffffffc0206c24 <do_kill+0x42>

ffffffffc0206c5e <proc_init>:
ffffffffc0206c5e:	1101                	addi	sp,sp,-32
ffffffffc0206c60:	e426                	sd	s1,8(sp)
ffffffffc0206c62:	0008f797          	auipc	a5,0x8f
ffffffffc0206c66:	b5e78793          	addi	a5,a5,-1186 # ffffffffc02957c0 <proc_list>
ffffffffc0206c6a:	ec06                	sd	ra,24(sp)
ffffffffc0206c6c:	e822                	sd	s0,16(sp)
ffffffffc0206c6e:	e04a                	sd	s2,0(sp)
ffffffffc0206c70:	0008b497          	auipc	s1,0x8b
ffffffffc0206c74:	b5048493          	addi	s1,s1,-1200 # ffffffffc02917c0 <hash_list>
ffffffffc0206c78:	e79c                	sd	a5,8(a5)
ffffffffc0206c7a:	e39c                	sd	a5,0(a5)
ffffffffc0206c7c:	0008f717          	auipc	a4,0x8f
ffffffffc0206c80:	b4470713          	addi	a4,a4,-1212 # ffffffffc02957c0 <proc_list>
ffffffffc0206c84:	87a6                	mv	a5,s1
ffffffffc0206c86:	e79c                	sd	a5,8(a5)
ffffffffc0206c88:	e39c                	sd	a5,0(a5)
ffffffffc0206c8a:	07c1                	addi	a5,a5,16
ffffffffc0206c8c:	fef71de3          	bne	a4,a5,ffffffffc0206c86 <proc_init+0x28>
ffffffffc0206c90:	d23fe0ef          	jal	ra,ffffffffc02059b2 <alloc_proc>
ffffffffc0206c94:	00090917          	auipc	s2,0x90
ffffffffc0206c98:	c3490913          	addi	s2,s2,-972 # ffffffffc02968c8 <idleproc>
ffffffffc0206c9c:	00a93023          	sd	a0,0(s2)
ffffffffc0206ca0:	842a                	mv	s0,a0
ffffffffc0206ca2:	12050863          	beqz	a0,ffffffffc0206dd2 <proc_init+0x174>
ffffffffc0206ca6:	4789                	li	a5,2
ffffffffc0206ca8:	e11c                	sd	a5,0(a0)
ffffffffc0206caa:	0000a797          	auipc	a5,0xa
ffffffffc0206cae:	35678793          	addi	a5,a5,854 # ffffffffc0211000 <bootstack>
ffffffffc0206cb2:	e91c                	sd	a5,16(a0)
ffffffffc0206cb4:	4785                	li	a5,1
ffffffffc0206cb6:	ed1c                	sd	a5,24(a0)
ffffffffc0206cb8:	cf4fe0ef          	jal	ra,ffffffffc02051ac <files_create>
ffffffffc0206cbc:	14a43423          	sd	a0,328(s0)
ffffffffc0206cc0:	0e050d63          	beqz	a0,ffffffffc0206dba <proc_init+0x15c>
ffffffffc0206cc4:	00093403          	ld	s0,0(s2)
ffffffffc0206cc8:	4641                	li	a2,16
ffffffffc0206cca:	4581                	li	a1,0
ffffffffc0206ccc:	14843703          	ld	a4,328(s0)
ffffffffc0206cd0:	0b440413          	addi	s0,s0,180
ffffffffc0206cd4:	8522                	mv	a0,s0
ffffffffc0206cd6:	4b1c                	lw	a5,16(a4)
ffffffffc0206cd8:	2785                	addiw	a5,a5,1
ffffffffc0206cda:	cb1c                	sw	a5,16(a4)
ffffffffc0206cdc:	4b8040ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc0206ce0:	463d                	li	a2,15
ffffffffc0206ce2:	00006597          	auipc	a1,0x6
ffffffffc0206ce6:	72e58593          	addi	a1,a1,1838 # ffffffffc020d410 <CSWTCH.79+0x398>
ffffffffc0206cea:	8522                	mv	a0,s0
ffffffffc0206cec:	4fa040ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc0206cf0:	00090717          	auipc	a4,0x90
ffffffffc0206cf4:	be870713          	addi	a4,a4,-1048 # ffffffffc02968d8 <nr_process>
ffffffffc0206cf8:	431c                	lw	a5,0(a4)
ffffffffc0206cfa:	00093683          	ld	a3,0(s2)
ffffffffc0206cfe:	4601                	li	a2,0
ffffffffc0206d00:	2785                	addiw	a5,a5,1
ffffffffc0206d02:	4581                	li	a1,0
ffffffffc0206d04:	fffff517          	auipc	a0,0xfffff
ffffffffc0206d08:	62a50513          	addi	a0,a0,1578 # ffffffffc020632e <init_main>
ffffffffc0206d0c:	c31c                	sw	a5,0(a4)
ffffffffc0206d0e:	00090797          	auipc	a5,0x90
ffffffffc0206d12:	bad7b923          	sd	a3,-1102(a5) # ffffffffc02968c0 <current>
ffffffffc0206d16:	a94ff0ef          	jal	ra,ffffffffc0205faa <kernel_thread>
ffffffffc0206d1a:	842a                	mv	s0,a0
ffffffffc0206d1c:	08a05363          	blez	a0,ffffffffc0206da2 <proc_init+0x144>
ffffffffc0206d20:	6789                	lui	a5,0x2
ffffffffc0206d22:	fff5071b          	addiw	a4,a0,-1
ffffffffc0206d26:	17f9                	addi	a5,a5,-2
ffffffffc0206d28:	2501                	sext.w	a0,a0
ffffffffc0206d2a:	02e7e363          	bltu	a5,a4,ffffffffc0206d50 <proc_init+0xf2>
ffffffffc0206d2e:	45a9                	li	a1,10
ffffffffc0206d30:	731030ef          	jal	ra,ffffffffc020ac60 <hash32>
ffffffffc0206d34:	02051793          	slli	a5,a0,0x20
ffffffffc0206d38:	01c7d693          	srli	a3,a5,0x1c
ffffffffc0206d3c:	96a6                	add	a3,a3,s1
ffffffffc0206d3e:	87b6                	mv	a5,a3
ffffffffc0206d40:	a029                	j	ffffffffc0206d4a <proc_init+0xec>
ffffffffc0206d42:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_bin_swap_img_size-0x5dd4>
ffffffffc0206d46:	04870b63          	beq	a4,s0,ffffffffc0206d9c <proc_init+0x13e>
ffffffffc0206d4a:	679c                	ld	a5,8(a5)
ffffffffc0206d4c:	fef69be3          	bne	a3,a5,ffffffffc0206d42 <proc_init+0xe4>
ffffffffc0206d50:	4781                	li	a5,0
ffffffffc0206d52:	0b478493          	addi	s1,a5,180
ffffffffc0206d56:	4641                	li	a2,16
ffffffffc0206d58:	4581                	li	a1,0
ffffffffc0206d5a:	00090417          	auipc	s0,0x90
ffffffffc0206d5e:	b7640413          	addi	s0,s0,-1162 # ffffffffc02968d0 <initproc>
ffffffffc0206d62:	8526                	mv	a0,s1
ffffffffc0206d64:	e01c                	sd	a5,0(s0)
ffffffffc0206d66:	42e040ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc0206d6a:	463d                	li	a2,15
ffffffffc0206d6c:	00006597          	auipc	a1,0x6
ffffffffc0206d70:	6cc58593          	addi	a1,a1,1740 # ffffffffc020d438 <CSWTCH.79+0x3c0>
ffffffffc0206d74:	8526                	mv	a0,s1
ffffffffc0206d76:	470040ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc0206d7a:	00093783          	ld	a5,0(s2)
ffffffffc0206d7e:	c7d1                	beqz	a5,ffffffffc0206e0a <proc_init+0x1ac>
ffffffffc0206d80:	43dc                	lw	a5,4(a5)
ffffffffc0206d82:	e7c1                	bnez	a5,ffffffffc0206e0a <proc_init+0x1ac>
ffffffffc0206d84:	601c                	ld	a5,0(s0)
ffffffffc0206d86:	c3b5                	beqz	a5,ffffffffc0206dea <proc_init+0x18c>
ffffffffc0206d88:	43d8                	lw	a4,4(a5)
ffffffffc0206d8a:	4785                	li	a5,1
ffffffffc0206d8c:	04f71f63          	bne	a4,a5,ffffffffc0206dea <proc_init+0x18c>
ffffffffc0206d90:	60e2                	ld	ra,24(sp)
ffffffffc0206d92:	6442                	ld	s0,16(sp)
ffffffffc0206d94:	64a2                	ld	s1,8(sp)
ffffffffc0206d96:	6902                	ld	s2,0(sp)
ffffffffc0206d98:	6105                	addi	sp,sp,32
ffffffffc0206d9a:	8082                	ret
ffffffffc0206d9c:	f2878793          	addi	a5,a5,-216
ffffffffc0206da0:	bf4d                	j	ffffffffc0206d52 <proc_init+0xf4>
ffffffffc0206da2:	00006617          	auipc	a2,0x6
ffffffffc0206da6:	67660613          	addi	a2,a2,1654 # ffffffffc020d418 <CSWTCH.79+0x3a0>
ffffffffc0206daa:	4e800593          	li	a1,1256
ffffffffc0206dae:	00006517          	auipc	a0,0x6
ffffffffc0206db2:	3ba50513          	addi	a0,a0,954 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc0206db6:	ee8f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206dba:	00006617          	auipc	a2,0x6
ffffffffc0206dbe:	62e60613          	addi	a2,a2,1582 # ffffffffc020d3e8 <CSWTCH.79+0x370>
ffffffffc0206dc2:	4dc00593          	li	a1,1244
ffffffffc0206dc6:	00006517          	auipc	a0,0x6
ffffffffc0206dca:	3a250513          	addi	a0,a0,930 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc0206dce:	ed0f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206dd2:	00006617          	auipc	a2,0x6
ffffffffc0206dd6:	5fe60613          	addi	a2,a2,1534 # ffffffffc020d3d0 <CSWTCH.79+0x358>
ffffffffc0206dda:	4d200593          	li	a1,1234
ffffffffc0206dde:	00006517          	auipc	a0,0x6
ffffffffc0206de2:	38a50513          	addi	a0,a0,906 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc0206de6:	eb8f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206dea:	00006697          	auipc	a3,0x6
ffffffffc0206dee:	67e68693          	addi	a3,a3,1662 # ffffffffc020d468 <CSWTCH.79+0x3f0>
ffffffffc0206df2:	00005617          	auipc	a2,0x5
ffffffffc0206df6:	88660613          	addi	a2,a2,-1914 # ffffffffc020b678 <commands+0x210>
ffffffffc0206dfa:	4ef00593          	li	a1,1263
ffffffffc0206dfe:	00006517          	auipc	a0,0x6
ffffffffc0206e02:	36a50513          	addi	a0,a0,874 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc0206e06:	e98f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206e0a:	00006697          	auipc	a3,0x6
ffffffffc0206e0e:	63668693          	addi	a3,a3,1590 # ffffffffc020d440 <CSWTCH.79+0x3c8>
ffffffffc0206e12:	00005617          	auipc	a2,0x5
ffffffffc0206e16:	86660613          	addi	a2,a2,-1946 # ffffffffc020b678 <commands+0x210>
ffffffffc0206e1a:	4ee00593          	li	a1,1262
ffffffffc0206e1e:	00006517          	auipc	a0,0x6
ffffffffc0206e22:	34a50513          	addi	a0,a0,842 # ffffffffc020d168 <CSWTCH.79+0xf0>
ffffffffc0206e26:	e78f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206e2a <cpu_idle>:
ffffffffc0206e2a:	1141                	addi	sp,sp,-16
ffffffffc0206e2c:	e022                	sd	s0,0(sp)
ffffffffc0206e2e:	e406                	sd	ra,8(sp)
ffffffffc0206e30:	00090417          	auipc	s0,0x90
ffffffffc0206e34:	a9040413          	addi	s0,s0,-1392 # ffffffffc02968c0 <current>
ffffffffc0206e38:	6018                	ld	a4,0(s0)
ffffffffc0206e3a:	6f1c                	ld	a5,24(a4)
ffffffffc0206e3c:	dffd                	beqz	a5,ffffffffc0206e3a <cpu_idle+0x10>
ffffffffc0206e3e:	31a000ef          	jal	ra,ffffffffc0207158 <schedule>
ffffffffc0206e42:	bfdd                	j	ffffffffc0206e38 <cpu_idle+0xe>

ffffffffc0206e44 <lab6_set_priority>:
ffffffffc0206e44:	1141                	addi	sp,sp,-16
ffffffffc0206e46:	e022                	sd	s0,0(sp)
ffffffffc0206e48:	85aa                	mv	a1,a0
ffffffffc0206e4a:	842a                	mv	s0,a0
ffffffffc0206e4c:	00006517          	auipc	a0,0x6
ffffffffc0206e50:	64450513          	addi	a0,a0,1604 # ffffffffc020d490 <CSWTCH.79+0x418>
ffffffffc0206e54:	e406                	sd	ra,8(sp)
ffffffffc0206e56:	b50f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206e5a:	00090797          	auipc	a5,0x90
ffffffffc0206e5e:	a667b783          	ld	a5,-1434(a5) # ffffffffc02968c0 <current>
ffffffffc0206e62:	e801                	bnez	s0,ffffffffc0206e72 <lab6_set_priority+0x2e>
ffffffffc0206e64:	60a2                	ld	ra,8(sp)
ffffffffc0206e66:	6402                	ld	s0,0(sp)
ffffffffc0206e68:	4705                	li	a4,1
ffffffffc0206e6a:	14e7a223          	sw	a4,324(a5)
ffffffffc0206e6e:	0141                	addi	sp,sp,16
ffffffffc0206e70:	8082                	ret
ffffffffc0206e72:	60a2                	ld	ra,8(sp)
ffffffffc0206e74:	1487a223          	sw	s0,324(a5)
ffffffffc0206e78:	6402                	ld	s0,0(sp)
ffffffffc0206e7a:	0141                	addi	sp,sp,16
ffffffffc0206e7c:	8082                	ret

ffffffffc0206e7e <do_sleep>:
ffffffffc0206e7e:	c539                	beqz	a0,ffffffffc0206ecc <do_sleep+0x4e>
ffffffffc0206e80:	7179                	addi	sp,sp,-48
ffffffffc0206e82:	f022                	sd	s0,32(sp)
ffffffffc0206e84:	f406                	sd	ra,40(sp)
ffffffffc0206e86:	842a                	mv	s0,a0
ffffffffc0206e88:	100027f3          	csrr	a5,sstatus
ffffffffc0206e8c:	8b89                	andi	a5,a5,2
ffffffffc0206e8e:	e3a9                	bnez	a5,ffffffffc0206ed0 <do_sleep+0x52>
ffffffffc0206e90:	00090797          	auipc	a5,0x90
ffffffffc0206e94:	a307b783          	ld	a5,-1488(a5) # ffffffffc02968c0 <current>
ffffffffc0206e98:	0818                	addi	a4,sp,16
ffffffffc0206e9a:	c02a                	sw	a0,0(sp)
ffffffffc0206e9c:	ec3a                	sd	a4,24(sp)
ffffffffc0206e9e:	e83a                	sd	a4,16(sp)
ffffffffc0206ea0:	e43e                	sd	a5,8(sp)
ffffffffc0206ea2:	4705                	li	a4,1
ffffffffc0206ea4:	c398                	sw	a4,0(a5)
ffffffffc0206ea6:	80000737          	lui	a4,0x80000
ffffffffc0206eaa:	840a                	mv	s0,sp
ffffffffc0206eac:	0709                	addi	a4,a4,2
ffffffffc0206eae:	0ee7a623          	sw	a4,236(a5)
ffffffffc0206eb2:	8522                	mv	a0,s0
ffffffffc0206eb4:	364000ef          	jal	ra,ffffffffc0207218 <add_timer>
ffffffffc0206eb8:	2a0000ef          	jal	ra,ffffffffc0207158 <schedule>
ffffffffc0206ebc:	8522                	mv	a0,s0
ffffffffc0206ebe:	422000ef          	jal	ra,ffffffffc02072e0 <del_timer>
ffffffffc0206ec2:	70a2                	ld	ra,40(sp)
ffffffffc0206ec4:	7402                	ld	s0,32(sp)
ffffffffc0206ec6:	4501                	li	a0,0
ffffffffc0206ec8:	6145                	addi	sp,sp,48
ffffffffc0206eca:	8082                	ret
ffffffffc0206ecc:	4501                	li	a0,0
ffffffffc0206ece:	8082                	ret
ffffffffc0206ed0:	da3f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0206ed4:	00090797          	auipc	a5,0x90
ffffffffc0206ed8:	9ec7b783          	ld	a5,-1556(a5) # ffffffffc02968c0 <current>
ffffffffc0206edc:	0818                	addi	a4,sp,16
ffffffffc0206ede:	c022                	sw	s0,0(sp)
ffffffffc0206ee0:	e43e                	sd	a5,8(sp)
ffffffffc0206ee2:	ec3a                	sd	a4,24(sp)
ffffffffc0206ee4:	e83a                	sd	a4,16(sp)
ffffffffc0206ee6:	4705                	li	a4,1
ffffffffc0206ee8:	c398                	sw	a4,0(a5)
ffffffffc0206eea:	80000737          	lui	a4,0x80000
ffffffffc0206eee:	0709                	addi	a4,a4,2
ffffffffc0206ef0:	840a                	mv	s0,sp
ffffffffc0206ef2:	8522                	mv	a0,s0
ffffffffc0206ef4:	0ee7a623          	sw	a4,236(a5)
ffffffffc0206ef8:	320000ef          	jal	ra,ffffffffc0207218 <add_timer>
ffffffffc0206efc:	d71f90ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0206f00:	bf65                	j	ffffffffc0206eb8 <do_sleep+0x3a>

ffffffffc0206f02 <switch_to>:
ffffffffc0206f02:	00153023          	sd	ra,0(a0)
ffffffffc0206f06:	00253423          	sd	sp,8(a0)
ffffffffc0206f0a:	e900                	sd	s0,16(a0)
ffffffffc0206f0c:	ed04                	sd	s1,24(a0)
ffffffffc0206f0e:	03253023          	sd	s2,32(a0)
ffffffffc0206f12:	03353423          	sd	s3,40(a0)
ffffffffc0206f16:	03453823          	sd	s4,48(a0)
ffffffffc0206f1a:	03553c23          	sd	s5,56(a0)
ffffffffc0206f1e:	05653023          	sd	s6,64(a0)
ffffffffc0206f22:	05753423          	sd	s7,72(a0)
ffffffffc0206f26:	05853823          	sd	s8,80(a0)
ffffffffc0206f2a:	05953c23          	sd	s9,88(a0)
ffffffffc0206f2e:	07a53023          	sd	s10,96(a0)
ffffffffc0206f32:	07b53423          	sd	s11,104(a0)
ffffffffc0206f36:	0005b083          	ld	ra,0(a1)
ffffffffc0206f3a:	0085b103          	ld	sp,8(a1)
ffffffffc0206f3e:	6980                	ld	s0,16(a1)
ffffffffc0206f40:	6d84                	ld	s1,24(a1)
ffffffffc0206f42:	0205b903          	ld	s2,32(a1)
ffffffffc0206f46:	0285b983          	ld	s3,40(a1)
ffffffffc0206f4a:	0305ba03          	ld	s4,48(a1)
ffffffffc0206f4e:	0385ba83          	ld	s5,56(a1)
ffffffffc0206f52:	0405bb03          	ld	s6,64(a1)
ffffffffc0206f56:	0485bb83          	ld	s7,72(a1)
ffffffffc0206f5a:	0505bc03          	ld	s8,80(a1)
ffffffffc0206f5e:	0585bc83          	ld	s9,88(a1)
ffffffffc0206f62:	0605bd03          	ld	s10,96(a1)
ffffffffc0206f66:	0685bd83          	ld	s11,104(a1)
ffffffffc0206f6a:	8082                	ret

ffffffffc0206f6c <RR_init>:
ffffffffc0206f6c:	e508                	sd	a0,8(a0)
ffffffffc0206f6e:	e108                	sd	a0,0(a0)
ffffffffc0206f70:	00052823          	sw	zero,16(a0)
ffffffffc0206f74:	8082                	ret

ffffffffc0206f76 <RR_pick_next>:
ffffffffc0206f76:	651c                	ld	a5,8(a0)
ffffffffc0206f78:	00f50563          	beq	a0,a5,ffffffffc0206f82 <RR_pick_next+0xc>
ffffffffc0206f7c:	ef078513          	addi	a0,a5,-272
ffffffffc0206f80:	8082                	ret
ffffffffc0206f82:	4501                	li	a0,0
ffffffffc0206f84:	8082                	ret

ffffffffc0206f86 <RR_proc_tick>:
ffffffffc0206f86:	1205a783          	lw	a5,288(a1)
ffffffffc0206f8a:	00f05563          	blez	a5,ffffffffc0206f94 <RR_proc_tick+0xe>
ffffffffc0206f8e:	37fd                	addiw	a5,a5,-1
ffffffffc0206f90:	12f5a023          	sw	a5,288(a1)
ffffffffc0206f94:	e399                	bnez	a5,ffffffffc0206f9a <RR_proc_tick+0x14>
ffffffffc0206f96:	4785                	li	a5,1
ffffffffc0206f98:	ed9c                	sd	a5,24(a1)
ffffffffc0206f9a:	8082                	ret

ffffffffc0206f9c <RR_dequeue>:
ffffffffc0206f9c:	1185b703          	ld	a4,280(a1)
ffffffffc0206fa0:	11058793          	addi	a5,a1,272
ffffffffc0206fa4:	02e78363          	beq	a5,a4,ffffffffc0206fca <RR_dequeue+0x2e>
ffffffffc0206fa8:	1085b683          	ld	a3,264(a1)
ffffffffc0206fac:	00a69f63          	bne	a3,a0,ffffffffc0206fca <RR_dequeue+0x2e>
ffffffffc0206fb0:	1105b503          	ld	a0,272(a1)
ffffffffc0206fb4:	4a90                	lw	a2,16(a3)
ffffffffc0206fb6:	e518                	sd	a4,8(a0)
ffffffffc0206fb8:	e308                	sd	a0,0(a4)
ffffffffc0206fba:	10f5bc23          	sd	a5,280(a1)
ffffffffc0206fbe:	10f5b823          	sd	a5,272(a1)
ffffffffc0206fc2:	fff6079b          	addiw	a5,a2,-1
ffffffffc0206fc6:	ca9c                	sw	a5,16(a3)
ffffffffc0206fc8:	8082                	ret
ffffffffc0206fca:	1141                	addi	sp,sp,-16
ffffffffc0206fcc:	00006697          	auipc	a3,0x6
ffffffffc0206fd0:	4dc68693          	addi	a3,a3,1244 # ffffffffc020d4a8 <CSWTCH.79+0x430>
ffffffffc0206fd4:	00004617          	auipc	a2,0x4
ffffffffc0206fd8:	6a460613          	addi	a2,a2,1700 # ffffffffc020b678 <commands+0x210>
ffffffffc0206fdc:	03c00593          	li	a1,60
ffffffffc0206fe0:	00006517          	auipc	a0,0x6
ffffffffc0206fe4:	50050513          	addi	a0,a0,1280 # ffffffffc020d4e0 <CSWTCH.79+0x468>
ffffffffc0206fe8:	e406                	sd	ra,8(sp)
ffffffffc0206fea:	cb4f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206fee <RR_enqueue>:
ffffffffc0206fee:	1185b703          	ld	a4,280(a1)
ffffffffc0206ff2:	11058793          	addi	a5,a1,272
ffffffffc0206ff6:	02e79d63          	bne	a5,a4,ffffffffc0207030 <RR_enqueue+0x42>
ffffffffc0206ffa:	6118                	ld	a4,0(a0)
ffffffffc0206ffc:	1205a683          	lw	a3,288(a1)
ffffffffc0207000:	e11c                	sd	a5,0(a0)
ffffffffc0207002:	e71c                	sd	a5,8(a4)
ffffffffc0207004:	10a5bc23          	sd	a0,280(a1)
ffffffffc0207008:	10e5b823          	sd	a4,272(a1)
ffffffffc020700c:	495c                	lw	a5,20(a0)
ffffffffc020700e:	ea89                	bnez	a3,ffffffffc0207020 <RR_enqueue+0x32>
ffffffffc0207010:	12f5a023          	sw	a5,288(a1)
ffffffffc0207014:	491c                	lw	a5,16(a0)
ffffffffc0207016:	10a5b423          	sd	a0,264(a1)
ffffffffc020701a:	2785                	addiw	a5,a5,1
ffffffffc020701c:	c91c                	sw	a5,16(a0)
ffffffffc020701e:	8082                	ret
ffffffffc0207020:	fed7c8e3          	blt	a5,a3,ffffffffc0207010 <RR_enqueue+0x22>
ffffffffc0207024:	491c                	lw	a5,16(a0)
ffffffffc0207026:	10a5b423          	sd	a0,264(a1)
ffffffffc020702a:	2785                	addiw	a5,a5,1
ffffffffc020702c:	c91c                	sw	a5,16(a0)
ffffffffc020702e:	8082                	ret
ffffffffc0207030:	1141                	addi	sp,sp,-16
ffffffffc0207032:	00006697          	auipc	a3,0x6
ffffffffc0207036:	4ce68693          	addi	a3,a3,1230 # ffffffffc020d500 <CSWTCH.79+0x488>
ffffffffc020703a:	00004617          	auipc	a2,0x4
ffffffffc020703e:	63e60613          	addi	a2,a2,1598 # ffffffffc020b678 <commands+0x210>
ffffffffc0207042:	02800593          	li	a1,40
ffffffffc0207046:	00006517          	auipc	a0,0x6
ffffffffc020704a:	49a50513          	addi	a0,a0,1178 # ffffffffc020d4e0 <CSWTCH.79+0x468>
ffffffffc020704e:	e406                	sd	ra,8(sp)
ffffffffc0207050:	c4ef90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207054 <sched_init>:
ffffffffc0207054:	1141                	addi	sp,sp,-16
ffffffffc0207056:	0008a717          	auipc	a4,0x8a
ffffffffc020705a:	fca70713          	addi	a4,a4,-54 # ffffffffc0291020 <default_sched_class>
ffffffffc020705e:	e022                	sd	s0,0(sp)
ffffffffc0207060:	e406                	sd	ra,8(sp)
ffffffffc0207062:	0008e797          	auipc	a5,0x8e
ffffffffc0207066:	78e78793          	addi	a5,a5,1934 # ffffffffc02957f0 <timer_list>
ffffffffc020706a:	6714                	ld	a3,8(a4)
ffffffffc020706c:	0008e517          	auipc	a0,0x8e
ffffffffc0207070:	76450513          	addi	a0,a0,1892 # ffffffffc02957d0 <__rq>
ffffffffc0207074:	e79c                	sd	a5,8(a5)
ffffffffc0207076:	e39c                	sd	a5,0(a5)
ffffffffc0207078:	4795                	li	a5,5
ffffffffc020707a:	c95c                	sw	a5,20(a0)
ffffffffc020707c:	00090417          	auipc	s0,0x90
ffffffffc0207080:	86c40413          	addi	s0,s0,-1940 # ffffffffc02968e8 <sched_class>
ffffffffc0207084:	00090797          	auipc	a5,0x90
ffffffffc0207088:	84a7be23          	sd	a0,-1956(a5) # ffffffffc02968e0 <rq>
ffffffffc020708c:	e018                	sd	a4,0(s0)
ffffffffc020708e:	9682                	jalr	a3
ffffffffc0207090:	601c                	ld	a5,0(s0)
ffffffffc0207092:	6402                	ld	s0,0(sp)
ffffffffc0207094:	60a2                	ld	ra,8(sp)
ffffffffc0207096:	638c                	ld	a1,0(a5)
ffffffffc0207098:	00006517          	auipc	a0,0x6
ffffffffc020709c:	49850513          	addi	a0,a0,1176 # ffffffffc020d530 <CSWTCH.79+0x4b8>
ffffffffc02070a0:	0141                	addi	sp,sp,16
ffffffffc02070a2:	904f906f          	j	ffffffffc02001a6 <cprintf>

ffffffffc02070a6 <wakeup_proc>:
ffffffffc02070a6:	4118                	lw	a4,0(a0)
ffffffffc02070a8:	1101                	addi	sp,sp,-32
ffffffffc02070aa:	ec06                	sd	ra,24(sp)
ffffffffc02070ac:	e822                	sd	s0,16(sp)
ffffffffc02070ae:	e426                	sd	s1,8(sp)
ffffffffc02070b0:	478d                	li	a5,3
ffffffffc02070b2:	08f70363          	beq	a4,a5,ffffffffc0207138 <wakeup_proc+0x92>
ffffffffc02070b6:	842a                	mv	s0,a0
ffffffffc02070b8:	100027f3          	csrr	a5,sstatus
ffffffffc02070bc:	8b89                	andi	a5,a5,2
ffffffffc02070be:	4481                	li	s1,0
ffffffffc02070c0:	e7bd                	bnez	a5,ffffffffc020712e <wakeup_proc+0x88>
ffffffffc02070c2:	4789                	li	a5,2
ffffffffc02070c4:	04f70863          	beq	a4,a5,ffffffffc0207114 <wakeup_proc+0x6e>
ffffffffc02070c8:	c01c                	sw	a5,0(s0)
ffffffffc02070ca:	0e042623          	sw	zero,236(s0)
ffffffffc02070ce:	0008f797          	auipc	a5,0x8f
ffffffffc02070d2:	7f27b783          	ld	a5,2034(a5) # ffffffffc02968c0 <current>
ffffffffc02070d6:	02878363          	beq	a5,s0,ffffffffc02070fc <wakeup_proc+0x56>
ffffffffc02070da:	0008f797          	auipc	a5,0x8f
ffffffffc02070de:	7ee7b783          	ld	a5,2030(a5) # ffffffffc02968c8 <idleproc>
ffffffffc02070e2:	00f40d63          	beq	s0,a5,ffffffffc02070fc <wakeup_proc+0x56>
ffffffffc02070e6:	00090797          	auipc	a5,0x90
ffffffffc02070ea:	8027b783          	ld	a5,-2046(a5) # ffffffffc02968e8 <sched_class>
ffffffffc02070ee:	6b9c                	ld	a5,16(a5)
ffffffffc02070f0:	85a2                	mv	a1,s0
ffffffffc02070f2:	0008f517          	auipc	a0,0x8f
ffffffffc02070f6:	7ee53503          	ld	a0,2030(a0) # ffffffffc02968e0 <rq>
ffffffffc02070fa:	9782                	jalr	a5
ffffffffc02070fc:	e491                	bnez	s1,ffffffffc0207108 <wakeup_proc+0x62>
ffffffffc02070fe:	60e2                	ld	ra,24(sp)
ffffffffc0207100:	6442                	ld	s0,16(sp)
ffffffffc0207102:	64a2                	ld	s1,8(sp)
ffffffffc0207104:	6105                	addi	sp,sp,32
ffffffffc0207106:	8082                	ret
ffffffffc0207108:	6442                	ld	s0,16(sp)
ffffffffc020710a:	60e2                	ld	ra,24(sp)
ffffffffc020710c:	64a2                	ld	s1,8(sp)
ffffffffc020710e:	6105                	addi	sp,sp,32
ffffffffc0207110:	b5df906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0207114:	00006617          	auipc	a2,0x6
ffffffffc0207118:	46c60613          	addi	a2,a2,1132 # ffffffffc020d580 <CSWTCH.79+0x508>
ffffffffc020711c:	05200593          	li	a1,82
ffffffffc0207120:	00006517          	auipc	a0,0x6
ffffffffc0207124:	44850513          	addi	a0,a0,1096 # ffffffffc020d568 <CSWTCH.79+0x4f0>
ffffffffc0207128:	bdef90ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc020712c:	bfc1                	j	ffffffffc02070fc <wakeup_proc+0x56>
ffffffffc020712e:	b45f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207132:	4018                	lw	a4,0(s0)
ffffffffc0207134:	4485                	li	s1,1
ffffffffc0207136:	b771                	j	ffffffffc02070c2 <wakeup_proc+0x1c>
ffffffffc0207138:	00006697          	auipc	a3,0x6
ffffffffc020713c:	41068693          	addi	a3,a3,1040 # ffffffffc020d548 <CSWTCH.79+0x4d0>
ffffffffc0207140:	00004617          	auipc	a2,0x4
ffffffffc0207144:	53860613          	addi	a2,a2,1336 # ffffffffc020b678 <commands+0x210>
ffffffffc0207148:	04300593          	li	a1,67
ffffffffc020714c:	00006517          	auipc	a0,0x6
ffffffffc0207150:	41c50513          	addi	a0,a0,1052 # ffffffffc020d568 <CSWTCH.79+0x4f0>
ffffffffc0207154:	b4af90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207158 <schedule>:
ffffffffc0207158:	7179                	addi	sp,sp,-48
ffffffffc020715a:	f406                	sd	ra,40(sp)
ffffffffc020715c:	f022                	sd	s0,32(sp)
ffffffffc020715e:	ec26                	sd	s1,24(sp)
ffffffffc0207160:	e84a                	sd	s2,16(sp)
ffffffffc0207162:	e44e                	sd	s3,8(sp)
ffffffffc0207164:	e052                	sd	s4,0(sp)
ffffffffc0207166:	100027f3          	csrr	a5,sstatus
ffffffffc020716a:	8b89                	andi	a5,a5,2
ffffffffc020716c:	4a01                	li	s4,0
ffffffffc020716e:	e3cd                	bnez	a5,ffffffffc0207210 <schedule+0xb8>
ffffffffc0207170:	0008f497          	auipc	s1,0x8f
ffffffffc0207174:	75048493          	addi	s1,s1,1872 # ffffffffc02968c0 <current>
ffffffffc0207178:	608c                	ld	a1,0(s1)
ffffffffc020717a:	0008f997          	auipc	s3,0x8f
ffffffffc020717e:	76e98993          	addi	s3,s3,1902 # ffffffffc02968e8 <sched_class>
ffffffffc0207182:	0008f917          	auipc	s2,0x8f
ffffffffc0207186:	75e90913          	addi	s2,s2,1886 # ffffffffc02968e0 <rq>
ffffffffc020718a:	4194                	lw	a3,0(a1)
ffffffffc020718c:	0005bc23          	sd	zero,24(a1)
ffffffffc0207190:	4709                	li	a4,2
ffffffffc0207192:	0009b783          	ld	a5,0(s3)
ffffffffc0207196:	00093503          	ld	a0,0(s2)
ffffffffc020719a:	04e68e63          	beq	a3,a4,ffffffffc02071f6 <schedule+0x9e>
ffffffffc020719e:	739c                	ld	a5,32(a5)
ffffffffc02071a0:	9782                	jalr	a5
ffffffffc02071a2:	842a                	mv	s0,a0
ffffffffc02071a4:	c521                	beqz	a0,ffffffffc02071ec <schedule+0x94>
ffffffffc02071a6:	0009b783          	ld	a5,0(s3)
ffffffffc02071aa:	00093503          	ld	a0,0(s2)
ffffffffc02071ae:	85a2                	mv	a1,s0
ffffffffc02071b0:	6f9c                	ld	a5,24(a5)
ffffffffc02071b2:	9782                	jalr	a5
ffffffffc02071b4:	441c                	lw	a5,8(s0)
ffffffffc02071b6:	6098                	ld	a4,0(s1)
ffffffffc02071b8:	2785                	addiw	a5,a5,1
ffffffffc02071ba:	c41c                	sw	a5,8(s0)
ffffffffc02071bc:	00870563          	beq	a4,s0,ffffffffc02071c6 <schedule+0x6e>
ffffffffc02071c0:	8522                	mv	a0,s0
ffffffffc02071c2:	991fe0ef          	jal	ra,ffffffffc0205b52 <proc_run>
ffffffffc02071c6:	000a1a63          	bnez	s4,ffffffffc02071da <schedule+0x82>
ffffffffc02071ca:	70a2                	ld	ra,40(sp)
ffffffffc02071cc:	7402                	ld	s0,32(sp)
ffffffffc02071ce:	64e2                	ld	s1,24(sp)
ffffffffc02071d0:	6942                	ld	s2,16(sp)
ffffffffc02071d2:	69a2                	ld	s3,8(sp)
ffffffffc02071d4:	6a02                	ld	s4,0(sp)
ffffffffc02071d6:	6145                	addi	sp,sp,48
ffffffffc02071d8:	8082                	ret
ffffffffc02071da:	7402                	ld	s0,32(sp)
ffffffffc02071dc:	70a2                	ld	ra,40(sp)
ffffffffc02071de:	64e2                	ld	s1,24(sp)
ffffffffc02071e0:	6942                	ld	s2,16(sp)
ffffffffc02071e2:	69a2                	ld	s3,8(sp)
ffffffffc02071e4:	6a02                	ld	s4,0(sp)
ffffffffc02071e6:	6145                	addi	sp,sp,48
ffffffffc02071e8:	a85f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc02071ec:	0008f417          	auipc	s0,0x8f
ffffffffc02071f0:	6dc43403          	ld	s0,1756(s0) # ffffffffc02968c8 <idleproc>
ffffffffc02071f4:	b7c1                	j	ffffffffc02071b4 <schedule+0x5c>
ffffffffc02071f6:	0008f717          	auipc	a4,0x8f
ffffffffc02071fa:	6d273703          	ld	a4,1746(a4) # ffffffffc02968c8 <idleproc>
ffffffffc02071fe:	fae580e3          	beq	a1,a4,ffffffffc020719e <schedule+0x46>
ffffffffc0207202:	6b9c                	ld	a5,16(a5)
ffffffffc0207204:	9782                	jalr	a5
ffffffffc0207206:	0009b783          	ld	a5,0(s3)
ffffffffc020720a:	00093503          	ld	a0,0(s2)
ffffffffc020720e:	bf41                	j	ffffffffc020719e <schedule+0x46>
ffffffffc0207210:	a63f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207214:	4a05                	li	s4,1
ffffffffc0207216:	bfa9                	j	ffffffffc0207170 <schedule+0x18>

ffffffffc0207218 <add_timer>:
ffffffffc0207218:	1141                	addi	sp,sp,-16
ffffffffc020721a:	e022                	sd	s0,0(sp)
ffffffffc020721c:	e406                	sd	ra,8(sp)
ffffffffc020721e:	842a                	mv	s0,a0
ffffffffc0207220:	100027f3          	csrr	a5,sstatus
ffffffffc0207224:	8b89                	andi	a5,a5,2
ffffffffc0207226:	4501                	li	a0,0
ffffffffc0207228:	eba5                	bnez	a5,ffffffffc0207298 <add_timer+0x80>
ffffffffc020722a:	401c                	lw	a5,0(s0)
ffffffffc020722c:	cbb5                	beqz	a5,ffffffffc02072a0 <add_timer+0x88>
ffffffffc020722e:	6418                	ld	a4,8(s0)
ffffffffc0207230:	cb25                	beqz	a4,ffffffffc02072a0 <add_timer+0x88>
ffffffffc0207232:	6c18                	ld	a4,24(s0)
ffffffffc0207234:	01040593          	addi	a1,s0,16
ffffffffc0207238:	08e59463          	bne	a1,a4,ffffffffc02072c0 <add_timer+0xa8>
ffffffffc020723c:	0008e617          	auipc	a2,0x8e
ffffffffc0207240:	5b460613          	addi	a2,a2,1460 # ffffffffc02957f0 <timer_list>
ffffffffc0207244:	6618                	ld	a4,8(a2)
ffffffffc0207246:	00c71863          	bne	a4,a2,ffffffffc0207256 <add_timer+0x3e>
ffffffffc020724a:	a80d                	j	ffffffffc020727c <add_timer+0x64>
ffffffffc020724c:	6718                	ld	a4,8(a4)
ffffffffc020724e:	9f95                	subw	a5,a5,a3
ffffffffc0207250:	c01c                	sw	a5,0(s0)
ffffffffc0207252:	02c70563          	beq	a4,a2,ffffffffc020727c <add_timer+0x64>
ffffffffc0207256:	ff072683          	lw	a3,-16(a4)
ffffffffc020725a:	fed7f9e3          	bgeu	a5,a3,ffffffffc020724c <add_timer+0x34>
ffffffffc020725e:	40f687bb          	subw	a5,a3,a5
ffffffffc0207262:	fef72823          	sw	a5,-16(a4)
ffffffffc0207266:	631c                	ld	a5,0(a4)
ffffffffc0207268:	e30c                	sd	a1,0(a4)
ffffffffc020726a:	e78c                	sd	a1,8(a5)
ffffffffc020726c:	ec18                	sd	a4,24(s0)
ffffffffc020726e:	e81c                	sd	a5,16(s0)
ffffffffc0207270:	c105                	beqz	a0,ffffffffc0207290 <add_timer+0x78>
ffffffffc0207272:	6402                	ld	s0,0(sp)
ffffffffc0207274:	60a2                	ld	ra,8(sp)
ffffffffc0207276:	0141                	addi	sp,sp,16
ffffffffc0207278:	9f5f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc020727c:	0008e717          	auipc	a4,0x8e
ffffffffc0207280:	57470713          	addi	a4,a4,1396 # ffffffffc02957f0 <timer_list>
ffffffffc0207284:	631c                	ld	a5,0(a4)
ffffffffc0207286:	e30c                	sd	a1,0(a4)
ffffffffc0207288:	e78c                	sd	a1,8(a5)
ffffffffc020728a:	ec18                	sd	a4,24(s0)
ffffffffc020728c:	e81c                	sd	a5,16(s0)
ffffffffc020728e:	f175                	bnez	a0,ffffffffc0207272 <add_timer+0x5a>
ffffffffc0207290:	60a2                	ld	ra,8(sp)
ffffffffc0207292:	6402                	ld	s0,0(sp)
ffffffffc0207294:	0141                	addi	sp,sp,16
ffffffffc0207296:	8082                	ret
ffffffffc0207298:	9dbf90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020729c:	4505                	li	a0,1
ffffffffc020729e:	b771                	j	ffffffffc020722a <add_timer+0x12>
ffffffffc02072a0:	00006697          	auipc	a3,0x6
ffffffffc02072a4:	30068693          	addi	a3,a3,768 # ffffffffc020d5a0 <CSWTCH.79+0x528>
ffffffffc02072a8:	00004617          	auipc	a2,0x4
ffffffffc02072ac:	3d060613          	addi	a2,a2,976 # ffffffffc020b678 <commands+0x210>
ffffffffc02072b0:	07a00593          	li	a1,122
ffffffffc02072b4:	00006517          	auipc	a0,0x6
ffffffffc02072b8:	2b450513          	addi	a0,a0,692 # ffffffffc020d568 <CSWTCH.79+0x4f0>
ffffffffc02072bc:	9e2f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02072c0:	00006697          	auipc	a3,0x6
ffffffffc02072c4:	31068693          	addi	a3,a3,784 # ffffffffc020d5d0 <CSWTCH.79+0x558>
ffffffffc02072c8:	00004617          	auipc	a2,0x4
ffffffffc02072cc:	3b060613          	addi	a2,a2,944 # ffffffffc020b678 <commands+0x210>
ffffffffc02072d0:	07b00593          	li	a1,123
ffffffffc02072d4:	00006517          	auipc	a0,0x6
ffffffffc02072d8:	29450513          	addi	a0,a0,660 # ffffffffc020d568 <CSWTCH.79+0x4f0>
ffffffffc02072dc:	9c2f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02072e0 <del_timer>:
ffffffffc02072e0:	1101                	addi	sp,sp,-32
ffffffffc02072e2:	e822                	sd	s0,16(sp)
ffffffffc02072e4:	ec06                	sd	ra,24(sp)
ffffffffc02072e6:	e426                	sd	s1,8(sp)
ffffffffc02072e8:	842a                	mv	s0,a0
ffffffffc02072ea:	100027f3          	csrr	a5,sstatus
ffffffffc02072ee:	8b89                	andi	a5,a5,2
ffffffffc02072f0:	01050493          	addi	s1,a0,16
ffffffffc02072f4:	eb9d                	bnez	a5,ffffffffc020732a <del_timer+0x4a>
ffffffffc02072f6:	6d1c                	ld	a5,24(a0)
ffffffffc02072f8:	02978463          	beq	a5,s1,ffffffffc0207320 <del_timer+0x40>
ffffffffc02072fc:	4114                	lw	a3,0(a0)
ffffffffc02072fe:	6918                	ld	a4,16(a0)
ffffffffc0207300:	ce81                	beqz	a3,ffffffffc0207318 <del_timer+0x38>
ffffffffc0207302:	0008e617          	auipc	a2,0x8e
ffffffffc0207306:	4ee60613          	addi	a2,a2,1262 # ffffffffc02957f0 <timer_list>
ffffffffc020730a:	00c78763          	beq	a5,a2,ffffffffc0207318 <del_timer+0x38>
ffffffffc020730e:	ff07a603          	lw	a2,-16(a5)
ffffffffc0207312:	9eb1                	addw	a3,a3,a2
ffffffffc0207314:	fed7a823          	sw	a3,-16(a5)
ffffffffc0207318:	e71c                	sd	a5,8(a4)
ffffffffc020731a:	e398                	sd	a4,0(a5)
ffffffffc020731c:	ec04                	sd	s1,24(s0)
ffffffffc020731e:	e804                	sd	s1,16(s0)
ffffffffc0207320:	60e2                	ld	ra,24(sp)
ffffffffc0207322:	6442                	ld	s0,16(sp)
ffffffffc0207324:	64a2                	ld	s1,8(sp)
ffffffffc0207326:	6105                	addi	sp,sp,32
ffffffffc0207328:	8082                	ret
ffffffffc020732a:	949f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020732e:	6c1c                	ld	a5,24(s0)
ffffffffc0207330:	02978463          	beq	a5,s1,ffffffffc0207358 <del_timer+0x78>
ffffffffc0207334:	4014                	lw	a3,0(s0)
ffffffffc0207336:	6818                	ld	a4,16(s0)
ffffffffc0207338:	ce81                	beqz	a3,ffffffffc0207350 <del_timer+0x70>
ffffffffc020733a:	0008e617          	auipc	a2,0x8e
ffffffffc020733e:	4b660613          	addi	a2,a2,1206 # ffffffffc02957f0 <timer_list>
ffffffffc0207342:	00c78763          	beq	a5,a2,ffffffffc0207350 <del_timer+0x70>
ffffffffc0207346:	ff07a603          	lw	a2,-16(a5)
ffffffffc020734a:	9eb1                	addw	a3,a3,a2
ffffffffc020734c:	fed7a823          	sw	a3,-16(a5)
ffffffffc0207350:	e71c                	sd	a5,8(a4)
ffffffffc0207352:	e398                	sd	a4,0(a5)
ffffffffc0207354:	ec04                	sd	s1,24(s0)
ffffffffc0207356:	e804                	sd	s1,16(s0)
ffffffffc0207358:	6442                	ld	s0,16(sp)
ffffffffc020735a:	60e2                	ld	ra,24(sp)
ffffffffc020735c:	64a2                	ld	s1,8(sp)
ffffffffc020735e:	6105                	addi	sp,sp,32
ffffffffc0207360:	90df906f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc0207364 <run_timer_list>:
ffffffffc0207364:	7139                	addi	sp,sp,-64
ffffffffc0207366:	fc06                	sd	ra,56(sp)
ffffffffc0207368:	f822                	sd	s0,48(sp)
ffffffffc020736a:	f426                	sd	s1,40(sp)
ffffffffc020736c:	f04a                	sd	s2,32(sp)
ffffffffc020736e:	ec4e                	sd	s3,24(sp)
ffffffffc0207370:	e852                	sd	s4,16(sp)
ffffffffc0207372:	e456                	sd	s5,8(sp)
ffffffffc0207374:	e05a                	sd	s6,0(sp)
ffffffffc0207376:	100027f3          	csrr	a5,sstatus
ffffffffc020737a:	8b89                	andi	a5,a5,2
ffffffffc020737c:	4b01                	li	s6,0
ffffffffc020737e:	efe9                	bnez	a5,ffffffffc0207458 <run_timer_list+0xf4>
ffffffffc0207380:	0008e997          	auipc	s3,0x8e
ffffffffc0207384:	47098993          	addi	s3,s3,1136 # ffffffffc02957f0 <timer_list>
ffffffffc0207388:	0089b403          	ld	s0,8(s3)
ffffffffc020738c:	07340a63          	beq	s0,s3,ffffffffc0207400 <run_timer_list+0x9c>
ffffffffc0207390:	ff042783          	lw	a5,-16(s0)
ffffffffc0207394:	ff040913          	addi	s2,s0,-16
ffffffffc0207398:	0e078763          	beqz	a5,ffffffffc0207486 <run_timer_list+0x122>
ffffffffc020739c:	fff7871b          	addiw	a4,a5,-1
ffffffffc02073a0:	fee42823          	sw	a4,-16(s0)
ffffffffc02073a4:	ef31                	bnez	a4,ffffffffc0207400 <run_timer_list+0x9c>
ffffffffc02073a6:	00006a97          	auipc	s5,0x6
ffffffffc02073aa:	292a8a93          	addi	s5,s5,658 # ffffffffc020d638 <CSWTCH.79+0x5c0>
ffffffffc02073ae:	00006a17          	auipc	s4,0x6
ffffffffc02073b2:	1baa0a13          	addi	s4,s4,442 # ffffffffc020d568 <CSWTCH.79+0x4f0>
ffffffffc02073b6:	a005                	j	ffffffffc02073d6 <run_timer_list+0x72>
ffffffffc02073b8:	0a07d763          	bgez	a5,ffffffffc0207466 <run_timer_list+0x102>
ffffffffc02073bc:	8526                	mv	a0,s1
ffffffffc02073be:	ce9ff0ef          	jal	ra,ffffffffc02070a6 <wakeup_proc>
ffffffffc02073c2:	854a                	mv	a0,s2
ffffffffc02073c4:	f1dff0ef          	jal	ra,ffffffffc02072e0 <del_timer>
ffffffffc02073c8:	03340c63          	beq	s0,s3,ffffffffc0207400 <run_timer_list+0x9c>
ffffffffc02073cc:	ff042783          	lw	a5,-16(s0)
ffffffffc02073d0:	ff040913          	addi	s2,s0,-16
ffffffffc02073d4:	e795                	bnez	a5,ffffffffc0207400 <run_timer_list+0x9c>
ffffffffc02073d6:	00893483          	ld	s1,8(s2)
ffffffffc02073da:	6400                	ld	s0,8(s0)
ffffffffc02073dc:	0ec4a783          	lw	a5,236(s1)
ffffffffc02073e0:	ffe1                	bnez	a5,ffffffffc02073b8 <run_timer_list+0x54>
ffffffffc02073e2:	40d4                	lw	a3,4(s1)
ffffffffc02073e4:	8656                	mv	a2,s5
ffffffffc02073e6:	0ba00593          	li	a1,186
ffffffffc02073ea:	8552                	mv	a0,s4
ffffffffc02073ec:	91af90ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc02073f0:	8526                	mv	a0,s1
ffffffffc02073f2:	cb5ff0ef          	jal	ra,ffffffffc02070a6 <wakeup_proc>
ffffffffc02073f6:	854a                	mv	a0,s2
ffffffffc02073f8:	ee9ff0ef          	jal	ra,ffffffffc02072e0 <del_timer>
ffffffffc02073fc:	fd3418e3          	bne	s0,s3,ffffffffc02073cc <run_timer_list+0x68>
ffffffffc0207400:	0008f597          	auipc	a1,0x8f
ffffffffc0207404:	4c05b583          	ld	a1,1216(a1) # ffffffffc02968c0 <current>
ffffffffc0207408:	c18d                	beqz	a1,ffffffffc020742a <run_timer_list+0xc6>
ffffffffc020740a:	0008f797          	auipc	a5,0x8f
ffffffffc020740e:	4be7b783          	ld	a5,1214(a5) # ffffffffc02968c8 <idleproc>
ffffffffc0207412:	04f58763          	beq	a1,a5,ffffffffc0207460 <run_timer_list+0xfc>
ffffffffc0207416:	0008f797          	auipc	a5,0x8f
ffffffffc020741a:	4d27b783          	ld	a5,1234(a5) # ffffffffc02968e8 <sched_class>
ffffffffc020741e:	779c                	ld	a5,40(a5)
ffffffffc0207420:	0008f517          	auipc	a0,0x8f
ffffffffc0207424:	4c053503          	ld	a0,1216(a0) # ffffffffc02968e0 <rq>
ffffffffc0207428:	9782                	jalr	a5
ffffffffc020742a:	000b1c63          	bnez	s6,ffffffffc0207442 <run_timer_list+0xde>
ffffffffc020742e:	70e2                	ld	ra,56(sp)
ffffffffc0207430:	7442                	ld	s0,48(sp)
ffffffffc0207432:	74a2                	ld	s1,40(sp)
ffffffffc0207434:	7902                	ld	s2,32(sp)
ffffffffc0207436:	69e2                	ld	s3,24(sp)
ffffffffc0207438:	6a42                	ld	s4,16(sp)
ffffffffc020743a:	6aa2                	ld	s5,8(sp)
ffffffffc020743c:	6b02                	ld	s6,0(sp)
ffffffffc020743e:	6121                	addi	sp,sp,64
ffffffffc0207440:	8082                	ret
ffffffffc0207442:	7442                	ld	s0,48(sp)
ffffffffc0207444:	70e2                	ld	ra,56(sp)
ffffffffc0207446:	74a2                	ld	s1,40(sp)
ffffffffc0207448:	7902                	ld	s2,32(sp)
ffffffffc020744a:	69e2                	ld	s3,24(sp)
ffffffffc020744c:	6a42                	ld	s4,16(sp)
ffffffffc020744e:	6aa2                	ld	s5,8(sp)
ffffffffc0207450:	6b02                	ld	s6,0(sp)
ffffffffc0207452:	6121                	addi	sp,sp,64
ffffffffc0207454:	819f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0207458:	81bf90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020745c:	4b05                	li	s6,1
ffffffffc020745e:	b70d                	j	ffffffffc0207380 <run_timer_list+0x1c>
ffffffffc0207460:	4785                	li	a5,1
ffffffffc0207462:	ed9c                	sd	a5,24(a1)
ffffffffc0207464:	b7d9                	j	ffffffffc020742a <run_timer_list+0xc6>
ffffffffc0207466:	00006697          	auipc	a3,0x6
ffffffffc020746a:	1aa68693          	addi	a3,a3,426 # ffffffffc020d610 <CSWTCH.79+0x598>
ffffffffc020746e:	00004617          	auipc	a2,0x4
ffffffffc0207472:	20a60613          	addi	a2,a2,522 # ffffffffc020b678 <commands+0x210>
ffffffffc0207476:	0b600593          	li	a1,182
ffffffffc020747a:	00006517          	auipc	a0,0x6
ffffffffc020747e:	0ee50513          	addi	a0,a0,238 # ffffffffc020d568 <CSWTCH.79+0x4f0>
ffffffffc0207482:	81cf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207486:	00006697          	auipc	a3,0x6
ffffffffc020748a:	17268693          	addi	a3,a3,370 # ffffffffc020d5f8 <CSWTCH.79+0x580>
ffffffffc020748e:	00004617          	auipc	a2,0x4
ffffffffc0207492:	1ea60613          	addi	a2,a2,490 # ffffffffc020b678 <commands+0x210>
ffffffffc0207496:	0ae00593          	li	a1,174
ffffffffc020749a:	00006517          	auipc	a0,0x6
ffffffffc020749e:	0ce50513          	addi	a0,a0,206 # ffffffffc020d568 <CSWTCH.79+0x4f0>
ffffffffc02074a2:	ffdf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02074a6 <sys_getpid>:
ffffffffc02074a6:	0008f797          	auipc	a5,0x8f
ffffffffc02074aa:	41a7b783          	ld	a5,1050(a5) # ffffffffc02968c0 <current>
ffffffffc02074ae:	43c8                	lw	a0,4(a5)
ffffffffc02074b0:	8082                	ret

ffffffffc02074b2 <sys_pgdir>:
ffffffffc02074b2:	4501                	li	a0,0
ffffffffc02074b4:	8082                	ret

ffffffffc02074b6 <sys_gettime>:
ffffffffc02074b6:	0008f797          	auipc	a5,0x8f
ffffffffc02074ba:	3ba7b783          	ld	a5,954(a5) # ffffffffc0296870 <ticks>
ffffffffc02074be:	0027951b          	slliw	a0,a5,0x2
ffffffffc02074c2:	9d3d                	addw	a0,a0,a5
ffffffffc02074c4:	0015151b          	slliw	a0,a0,0x1
ffffffffc02074c8:	8082                	ret

ffffffffc02074ca <sys_lab6_set_priority>:
ffffffffc02074ca:	4108                	lw	a0,0(a0)
ffffffffc02074cc:	1141                	addi	sp,sp,-16
ffffffffc02074ce:	e406                	sd	ra,8(sp)
ffffffffc02074d0:	975ff0ef          	jal	ra,ffffffffc0206e44 <lab6_set_priority>
ffffffffc02074d4:	60a2                	ld	ra,8(sp)
ffffffffc02074d6:	4501                	li	a0,0
ffffffffc02074d8:	0141                	addi	sp,sp,16
ffffffffc02074da:	8082                	ret

ffffffffc02074dc <sys_dup>:
ffffffffc02074dc:	450c                	lw	a1,8(a0)
ffffffffc02074de:	4108                	lw	a0,0(a0)
ffffffffc02074e0:	cc6fe06f          	j	ffffffffc02059a6 <sysfile_dup>

ffffffffc02074e4 <sys_getdirentry>:
ffffffffc02074e4:	650c                	ld	a1,8(a0)
ffffffffc02074e6:	4108                	lw	a0,0(a0)
ffffffffc02074e8:	bcefe06f          	j	ffffffffc02058b6 <sysfile_getdirentry>

ffffffffc02074ec <sys_getcwd>:
ffffffffc02074ec:	650c                	ld	a1,8(a0)
ffffffffc02074ee:	6108                	ld	a0,0(a0)
ffffffffc02074f0:	b22fe06f          	j	ffffffffc0205812 <sysfile_getcwd>

ffffffffc02074f4 <sys_fsync>:
ffffffffc02074f4:	4108                	lw	a0,0(a0)
ffffffffc02074f6:	b18fe06f          	j	ffffffffc020580e <sysfile_fsync>

ffffffffc02074fa <sys_fstat>:
ffffffffc02074fa:	650c                	ld	a1,8(a0)
ffffffffc02074fc:	4108                	lw	a0,0(a0)
ffffffffc02074fe:	a70fe06f          	j	ffffffffc020576e <sysfile_fstat>

ffffffffc0207502 <sys_seek>:
ffffffffc0207502:	4910                	lw	a2,16(a0)
ffffffffc0207504:	650c                	ld	a1,8(a0)
ffffffffc0207506:	4108                	lw	a0,0(a0)
ffffffffc0207508:	a62fe06f          	j	ffffffffc020576a <sysfile_seek>

ffffffffc020750c <sys_write>:
ffffffffc020750c:	6910                	ld	a2,16(a0)
ffffffffc020750e:	650c                	ld	a1,8(a0)
ffffffffc0207510:	4108                	lw	a0,0(a0)
ffffffffc0207512:	93efe06f          	j	ffffffffc0205650 <sysfile_write>

ffffffffc0207516 <sys_read>:
ffffffffc0207516:	6910                	ld	a2,16(a0)
ffffffffc0207518:	650c                	ld	a1,8(a0)
ffffffffc020751a:	4108                	lw	a0,0(a0)
ffffffffc020751c:	820fe06f          	j	ffffffffc020553c <sysfile_read>

ffffffffc0207520 <sys_close>:
ffffffffc0207520:	4108                	lw	a0,0(a0)
ffffffffc0207522:	816fe06f          	j	ffffffffc0205538 <sysfile_close>

ffffffffc0207526 <sys_open>:
ffffffffc0207526:	450c                	lw	a1,8(a0)
ffffffffc0207528:	6108                	ld	a0,0(a0)
ffffffffc020752a:	fdbfd06f          	j	ffffffffc0205504 <sysfile_open>

ffffffffc020752e <sys_putc>:
ffffffffc020752e:	4108                	lw	a0,0(a0)
ffffffffc0207530:	1141                	addi	sp,sp,-16
ffffffffc0207532:	e406                	sd	ra,8(sp)
ffffffffc0207534:	caff80ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0207538:	60a2                	ld	ra,8(sp)
ffffffffc020753a:	4501                	li	a0,0
ffffffffc020753c:	0141                	addi	sp,sp,16
ffffffffc020753e:	8082                	ret

ffffffffc0207540 <sys_kill>:
ffffffffc0207540:	4108                	lw	a0,0(a0)
ffffffffc0207542:	ea0ff06f          	j	ffffffffc0206be2 <do_kill>

ffffffffc0207546 <sys_sleep>:
ffffffffc0207546:	4108                	lw	a0,0(a0)
ffffffffc0207548:	937ff06f          	j	ffffffffc0206e7e <do_sleep>

ffffffffc020754c <sys_yield>:
ffffffffc020754c:	e48ff06f          	j	ffffffffc0206b94 <do_yield>

ffffffffc0207550 <sys_exec>:
ffffffffc0207550:	6910                	ld	a2,16(a0)
ffffffffc0207552:	450c                	lw	a1,8(a0)
ffffffffc0207554:	6108                	ld	a0,0(a0)
ffffffffc0207556:	f29fe06f          	j	ffffffffc020647e <do_execve>

ffffffffc020755a <sys_wait>:
ffffffffc020755a:	650c                	ld	a1,8(a0)
ffffffffc020755c:	4108                	lw	a0,0(a0)
ffffffffc020755e:	e46ff06f          	j	ffffffffc0206ba4 <do_wait>

ffffffffc0207562 <sys_fork>:
ffffffffc0207562:	0008f797          	auipc	a5,0x8f
ffffffffc0207566:	35e7b783          	ld	a5,862(a5) # ffffffffc02968c0 <current>
ffffffffc020756a:	73d0                	ld	a2,160(a5)
ffffffffc020756c:	4501                	li	a0,0
ffffffffc020756e:	6a0c                	ld	a1,16(a2)
ffffffffc0207570:	e48fe06f          	j	ffffffffc0205bb8 <do_fork>

ffffffffc0207574 <sys_exit>:
ffffffffc0207574:	4108                	lw	a0,0(a0)
ffffffffc0207576:	a85fe06f          	j	ffffffffc0205ffa <do_exit>

ffffffffc020757a <syscall>:
ffffffffc020757a:	715d                	addi	sp,sp,-80
ffffffffc020757c:	fc26                	sd	s1,56(sp)
ffffffffc020757e:	0008f497          	auipc	s1,0x8f
ffffffffc0207582:	34248493          	addi	s1,s1,834 # ffffffffc02968c0 <current>
ffffffffc0207586:	6098                	ld	a4,0(s1)
ffffffffc0207588:	e0a2                	sd	s0,64(sp)
ffffffffc020758a:	f84a                	sd	s2,48(sp)
ffffffffc020758c:	7340                	ld	s0,160(a4)
ffffffffc020758e:	e486                	sd	ra,72(sp)
ffffffffc0207590:	0ff00793          	li	a5,255
ffffffffc0207594:	05042903          	lw	s2,80(s0)
ffffffffc0207598:	0327ee63          	bltu	a5,s2,ffffffffc02075d4 <syscall+0x5a>
ffffffffc020759c:	00391713          	slli	a4,s2,0x3
ffffffffc02075a0:	00006797          	auipc	a5,0x6
ffffffffc02075a4:	10078793          	addi	a5,a5,256 # ffffffffc020d6a0 <syscalls>
ffffffffc02075a8:	97ba                	add	a5,a5,a4
ffffffffc02075aa:	639c                	ld	a5,0(a5)
ffffffffc02075ac:	c785                	beqz	a5,ffffffffc02075d4 <syscall+0x5a>
ffffffffc02075ae:	6c28                	ld	a0,88(s0)
ffffffffc02075b0:	702c                	ld	a1,96(s0)
ffffffffc02075b2:	7430                	ld	a2,104(s0)
ffffffffc02075b4:	7834                	ld	a3,112(s0)
ffffffffc02075b6:	7c38                	ld	a4,120(s0)
ffffffffc02075b8:	e42a                	sd	a0,8(sp)
ffffffffc02075ba:	e82e                	sd	a1,16(sp)
ffffffffc02075bc:	ec32                	sd	a2,24(sp)
ffffffffc02075be:	f036                	sd	a3,32(sp)
ffffffffc02075c0:	f43a                	sd	a4,40(sp)
ffffffffc02075c2:	0028                	addi	a0,sp,8
ffffffffc02075c4:	9782                	jalr	a5
ffffffffc02075c6:	60a6                	ld	ra,72(sp)
ffffffffc02075c8:	e828                	sd	a0,80(s0)
ffffffffc02075ca:	6406                	ld	s0,64(sp)
ffffffffc02075cc:	74e2                	ld	s1,56(sp)
ffffffffc02075ce:	7942                	ld	s2,48(sp)
ffffffffc02075d0:	6161                	addi	sp,sp,80
ffffffffc02075d2:	8082                	ret
ffffffffc02075d4:	8522                	mv	a0,s0
ffffffffc02075d6:	9b5f90ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc02075da:	609c                	ld	a5,0(s1)
ffffffffc02075dc:	86ca                	mv	a3,s2
ffffffffc02075de:	00006617          	auipc	a2,0x6
ffffffffc02075e2:	07a60613          	addi	a2,a2,122 # ffffffffc020d658 <CSWTCH.79+0x5e0>
ffffffffc02075e6:	43d8                	lw	a4,4(a5)
ffffffffc02075e8:	0d800593          	li	a1,216
ffffffffc02075ec:	0b478793          	addi	a5,a5,180
ffffffffc02075f0:	00006517          	auipc	a0,0x6
ffffffffc02075f4:	09850513          	addi	a0,a0,152 # ffffffffc020d688 <CSWTCH.79+0x610>
ffffffffc02075f8:	ea7f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02075fc <__alloc_inode>:
ffffffffc02075fc:	1141                	addi	sp,sp,-16
ffffffffc02075fe:	e022                	sd	s0,0(sp)
ffffffffc0207600:	842a                	mv	s0,a0
ffffffffc0207602:	07800513          	li	a0,120
ffffffffc0207606:	e406                	sd	ra,8(sp)
ffffffffc0207608:	987fa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020760c:	c111                	beqz	a0,ffffffffc0207610 <__alloc_inode+0x14>
ffffffffc020760e:	cd20                	sw	s0,88(a0)
ffffffffc0207610:	60a2                	ld	ra,8(sp)
ffffffffc0207612:	6402                	ld	s0,0(sp)
ffffffffc0207614:	0141                	addi	sp,sp,16
ffffffffc0207616:	8082                	ret

ffffffffc0207618 <inode_init>:
ffffffffc0207618:	4785                	li	a5,1
ffffffffc020761a:	06052023          	sw	zero,96(a0)
ffffffffc020761e:	f92c                	sd	a1,112(a0)
ffffffffc0207620:	f530                	sd	a2,104(a0)
ffffffffc0207622:	cd7c                	sw	a5,92(a0)
ffffffffc0207624:	8082                	ret

ffffffffc0207626 <inode_kill>:
ffffffffc0207626:	4d78                	lw	a4,92(a0)
ffffffffc0207628:	1141                	addi	sp,sp,-16
ffffffffc020762a:	e406                	sd	ra,8(sp)
ffffffffc020762c:	e719                	bnez	a4,ffffffffc020763a <inode_kill+0x14>
ffffffffc020762e:	513c                	lw	a5,96(a0)
ffffffffc0207630:	e78d                	bnez	a5,ffffffffc020765a <inode_kill+0x34>
ffffffffc0207632:	60a2                	ld	ra,8(sp)
ffffffffc0207634:	0141                	addi	sp,sp,16
ffffffffc0207636:	a09fa06f          	j	ffffffffc020203e <kfree>
ffffffffc020763a:	00007697          	auipc	a3,0x7
ffffffffc020763e:	86668693          	addi	a3,a3,-1946 # ffffffffc020dea0 <syscalls+0x800>
ffffffffc0207642:	00004617          	auipc	a2,0x4
ffffffffc0207646:	03660613          	addi	a2,a2,54 # ffffffffc020b678 <commands+0x210>
ffffffffc020764a:	02900593          	li	a1,41
ffffffffc020764e:	00007517          	auipc	a0,0x7
ffffffffc0207652:	87250513          	addi	a0,a0,-1934 # ffffffffc020dec0 <syscalls+0x820>
ffffffffc0207656:	e49f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020765a:	00007697          	auipc	a3,0x7
ffffffffc020765e:	87e68693          	addi	a3,a3,-1922 # ffffffffc020ded8 <syscalls+0x838>
ffffffffc0207662:	00004617          	auipc	a2,0x4
ffffffffc0207666:	01660613          	addi	a2,a2,22 # ffffffffc020b678 <commands+0x210>
ffffffffc020766a:	02a00593          	li	a1,42
ffffffffc020766e:	00007517          	auipc	a0,0x7
ffffffffc0207672:	85250513          	addi	a0,a0,-1966 # ffffffffc020dec0 <syscalls+0x820>
ffffffffc0207676:	e29f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020767a <inode_ref_inc>:
ffffffffc020767a:	4d7c                	lw	a5,92(a0)
ffffffffc020767c:	2785                	addiw	a5,a5,1
ffffffffc020767e:	cd7c                	sw	a5,92(a0)
ffffffffc0207680:	0007851b          	sext.w	a0,a5
ffffffffc0207684:	8082                	ret

ffffffffc0207686 <inode_open_inc>:
ffffffffc0207686:	513c                	lw	a5,96(a0)
ffffffffc0207688:	2785                	addiw	a5,a5,1
ffffffffc020768a:	d13c                	sw	a5,96(a0)
ffffffffc020768c:	0007851b          	sext.w	a0,a5
ffffffffc0207690:	8082                	ret

ffffffffc0207692 <inode_check>:
ffffffffc0207692:	1141                	addi	sp,sp,-16
ffffffffc0207694:	e406                	sd	ra,8(sp)
ffffffffc0207696:	c90d                	beqz	a0,ffffffffc02076c8 <inode_check+0x36>
ffffffffc0207698:	793c                	ld	a5,112(a0)
ffffffffc020769a:	c79d                	beqz	a5,ffffffffc02076c8 <inode_check+0x36>
ffffffffc020769c:	6398                	ld	a4,0(a5)
ffffffffc020769e:	4625d7b7          	lui	a5,0x4625d
ffffffffc02076a2:	0786                	slli	a5,a5,0x1
ffffffffc02076a4:	47678793          	addi	a5,a5,1142 # 4625d476 <_binary_bin_sfs_img_size+0x461e8176>
ffffffffc02076a8:	08f71063          	bne	a4,a5,ffffffffc0207728 <inode_check+0x96>
ffffffffc02076ac:	4d78                	lw	a4,92(a0)
ffffffffc02076ae:	513c                	lw	a5,96(a0)
ffffffffc02076b0:	04f74c63          	blt	a4,a5,ffffffffc0207708 <inode_check+0x76>
ffffffffc02076b4:	0407ca63          	bltz	a5,ffffffffc0207708 <inode_check+0x76>
ffffffffc02076b8:	66c1                	lui	a3,0x10
ffffffffc02076ba:	02d75763          	bge	a4,a3,ffffffffc02076e8 <inode_check+0x56>
ffffffffc02076be:	02d7d563          	bge	a5,a3,ffffffffc02076e8 <inode_check+0x56>
ffffffffc02076c2:	60a2                	ld	ra,8(sp)
ffffffffc02076c4:	0141                	addi	sp,sp,16
ffffffffc02076c6:	8082                	ret
ffffffffc02076c8:	00007697          	auipc	a3,0x7
ffffffffc02076cc:	83068693          	addi	a3,a3,-2000 # ffffffffc020def8 <syscalls+0x858>
ffffffffc02076d0:	00004617          	auipc	a2,0x4
ffffffffc02076d4:	fa860613          	addi	a2,a2,-88 # ffffffffc020b678 <commands+0x210>
ffffffffc02076d8:	06e00593          	li	a1,110
ffffffffc02076dc:	00006517          	auipc	a0,0x6
ffffffffc02076e0:	7e450513          	addi	a0,a0,2020 # ffffffffc020dec0 <syscalls+0x820>
ffffffffc02076e4:	dbbf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02076e8:	00007697          	auipc	a3,0x7
ffffffffc02076ec:	89068693          	addi	a3,a3,-1904 # ffffffffc020df78 <syscalls+0x8d8>
ffffffffc02076f0:	00004617          	auipc	a2,0x4
ffffffffc02076f4:	f8860613          	addi	a2,a2,-120 # ffffffffc020b678 <commands+0x210>
ffffffffc02076f8:	07200593          	li	a1,114
ffffffffc02076fc:	00006517          	auipc	a0,0x6
ffffffffc0207700:	7c450513          	addi	a0,a0,1988 # ffffffffc020dec0 <syscalls+0x820>
ffffffffc0207704:	d9bf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207708:	00007697          	auipc	a3,0x7
ffffffffc020770c:	84068693          	addi	a3,a3,-1984 # ffffffffc020df48 <syscalls+0x8a8>
ffffffffc0207710:	00004617          	auipc	a2,0x4
ffffffffc0207714:	f6860613          	addi	a2,a2,-152 # ffffffffc020b678 <commands+0x210>
ffffffffc0207718:	07100593          	li	a1,113
ffffffffc020771c:	00006517          	auipc	a0,0x6
ffffffffc0207720:	7a450513          	addi	a0,a0,1956 # ffffffffc020dec0 <syscalls+0x820>
ffffffffc0207724:	d7bf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207728:	00006697          	auipc	a3,0x6
ffffffffc020772c:	7f868693          	addi	a3,a3,2040 # ffffffffc020df20 <syscalls+0x880>
ffffffffc0207730:	00004617          	auipc	a2,0x4
ffffffffc0207734:	f4860613          	addi	a2,a2,-184 # ffffffffc020b678 <commands+0x210>
ffffffffc0207738:	06f00593          	li	a1,111
ffffffffc020773c:	00006517          	auipc	a0,0x6
ffffffffc0207740:	78450513          	addi	a0,a0,1924 # ffffffffc020dec0 <syscalls+0x820>
ffffffffc0207744:	d5bf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207748 <inode_ref_dec>:
ffffffffc0207748:	4d7c                	lw	a5,92(a0)
ffffffffc020774a:	1101                	addi	sp,sp,-32
ffffffffc020774c:	ec06                	sd	ra,24(sp)
ffffffffc020774e:	e822                	sd	s0,16(sp)
ffffffffc0207750:	e426                	sd	s1,8(sp)
ffffffffc0207752:	e04a                	sd	s2,0(sp)
ffffffffc0207754:	06f05e63          	blez	a5,ffffffffc02077d0 <inode_ref_dec+0x88>
ffffffffc0207758:	fff7849b          	addiw	s1,a5,-1
ffffffffc020775c:	cd64                	sw	s1,92(a0)
ffffffffc020775e:	842a                	mv	s0,a0
ffffffffc0207760:	e09d                	bnez	s1,ffffffffc0207786 <inode_ref_dec+0x3e>
ffffffffc0207762:	793c                	ld	a5,112(a0)
ffffffffc0207764:	c7b1                	beqz	a5,ffffffffc02077b0 <inode_ref_dec+0x68>
ffffffffc0207766:	0487b903          	ld	s2,72(a5)
ffffffffc020776a:	04090363          	beqz	s2,ffffffffc02077b0 <inode_ref_dec+0x68>
ffffffffc020776e:	00007597          	auipc	a1,0x7
ffffffffc0207772:	8ba58593          	addi	a1,a1,-1862 # ffffffffc020e028 <syscalls+0x988>
ffffffffc0207776:	f1dff0ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc020777a:	8522                	mv	a0,s0
ffffffffc020777c:	9902                	jalr	s2
ffffffffc020777e:	c501                	beqz	a0,ffffffffc0207786 <inode_ref_dec+0x3e>
ffffffffc0207780:	57c5                	li	a5,-15
ffffffffc0207782:	00f51963          	bne	a0,a5,ffffffffc0207794 <inode_ref_dec+0x4c>
ffffffffc0207786:	60e2                	ld	ra,24(sp)
ffffffffc0207788:	6442                	ld	s0,16(sp)
ffffffffc020778a:	6902                	ld	s2,0(sp)
ffffffffc020778c:	8526                	mv	a0,s1
ffffffffc020778e:	64a2                	ld	s1,8(sp)
ffffffffc0207790:	6105                	addi	sp,sp,32
ffffffffc0207792:	8082                	ret
ffffffffc0207794:	85aa                	mv	a1,a0
ffffffffc0207796:	00007517          	auipc	a0,0x7
ffffffffc020779a:	89a50513          	addi	a0,a0,-1894 # ffffffffc020e030 <syscalls+0x990>
ffffffffc020779e:	a09f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02077a2:	60e2                	ld	ra,24(sp)
ffffffffc02077a4:	6442                	ld	s0,16(sp)
ffffffffc02077a6:	6902                	ld	s2,0(sp)
ffffffffc02077a8:	8526                	mv	a0,s1
ffffffffc02077aa:	64a2                	ld	s1,8(sp)
ffffffffc02077ac:	6105                	addi	sp,sp,32
ffffffffc02077ae:	8082                	ret
ffffffffc02077b0:	00007697          	auipc	a3,0x7
ffffffffc02077b4:	82868693          	addi	a3,a3,-2008 # ffffffffc020dfd8 <syscalls+0x938>
ffffffffc02077b8:	00004617          	auipc	a2,0x4
ffffffffc02077bc:	ec060613          	addi	a2,a2,-320 # ffffffffc020b678 <commands+0x210>
ffffffffc02077c0:	04400593          	li	a1,68
ffffffffc02077c4:	00006517          	auipc	a0,0x6
ffffffffc02077c8:	6fc50513          	addi	a0,a0,1788 # ffffffffc020dec0 <syscalls+0x820>
ffffffffc02077cc:	cd3f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02077d0:	00006697          	auipc	a3,0x6
ffffffffc02077d4:	7e868693          	addi	a3,a3,2024 # ffffffffc020dfb8 <syscalls+0x918>
ffffffffc02077d8:	00004617          	auipc	a2,0x4
ffffffffc02077dc:	ea060613          	addi	a2,a2,-352 # ffffffffc020b678 <commands+0x210>
ffffffffc02077e0:	03f00593          	li	a1,63
ffffffffc02077e4:	00006517          	auipc	a0,0x6
ffffffffc02077e8:	6dc50513          	addi	a0,a0,1756 # ffffffffc020dec0 <syscalls+0x820>
ffffffffc02077ec:	cb3f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02077f0 <inode_open_dec>:
ffffffffc02077f0:	513c                	lw	a5,96(a0)
ffffffffc02077f2:	1101                	addi	sp,sp,-32
ffffffffc02077f4:	ec06                	sd	ra,24(sp)
ffffffffc02077f6:	e822                	sd	s0,16(sp)
ffffffffc02077f8:	e426                	sd	s1,8(sp)
ffffffffc02077fa:	e04a                	sd	s2,0(sp)
ffffffffc02077fc:	06f05b63          	blez	a5,ffffffffc0207872 <inode_open_dec+0x82>
ffffffffc0207800:	fff7849b          	addiw	s1,a5,-1
ffffffffc0207804:	d124                	sw	s1,96(a0)
ffffffffc0207806:	842a                	mv	s0,a0
ffffffffc0207808:	e085                	bnez	s1,ffffffffc0207828 <inode_open_dec+0x38>
ffffffffc020780a:	793c                	ld	a5,112(a0)
ffffffffc020780c:	c3b9                	beqz	a5,ffffffffc0207852 <inode_open_dec+0x62>
ffffffffc020780e:	0107b903          	ld	s2,16(a5)
ffffffffc0207812:	04090063          	beqz	s2,ffffffffc0207852 <inode_open_dec+0x62>
ffffffffc0207816:	00007597          	auipc	a1,0x7
ffffffffc020781a:	8aa58593          	addi	a1,a1,-1878 # ffffffffc020e0c0 <syscalls+0xa20>
ffffffffc020781e:	e75ff0ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc0207822:	8522                	mv	a0,s0
ffffffffc0207824:	9902                	jalr	s2
ffffffffc0207826:	e901                	bnez	a0,ffffffffc0207836 <inode_open_dec+0x46>
ffffffffc0207828:	60e2                	ld	ra,24(sp)
ffffffffc020782a:	6442                	ld	s0,16(sp)
ffffffffc020782c:	6902                	ld	s2,0(sp)
ffffffffc020782e:	8526                	mv	a0,s1
ffffffffc0207830:	64a2                	ld	s1,8(sp)
ffffffffc0207832:	6105                	addi	sp,sp,32
ffffffffc0207834:	8082                	ret
ffffffffc0207836:	85aa                	mv	a1,a0
ffffffffc0207838:	00007517          	auipc	a0,0x7
ffffffffc020783c:	89050513          	addi	a0,a0,-1904 # ffffffffc020e0c8 <syscalls+0xa28>
ffffffffc0207840:	967f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207844:	60e2                	ld	ra,24(sp)
ffffffffc0207846:	6442                	ld	s0,16(sp)
ffffffffc0207848:	6902                	ld	s2,0(sp)
ffffffffc020784a:	8526                	mv	a0,s1
ffffffffc020784c:	64a2                	ld	s1,8(sp)
ffffffffc020784e:	6105                	addi	sp,sp,32
ffffffffc0207850:	8082                	ret
ffffffffc0207852:	00007697          	auipc	a3,0x7
ffffffffc0207856:	81e68693          	addi	a3,a3,-2018 # ffffffffc020e070 <syscalls+0x9d0>
ffffffffc020785a:	00004617          	auipc	a2,0x4
ffffffffc020785e:	e1e60613          	addi	a2,a2,-482 # ffffffffc020b678 <commands+0x210>
ffffffffc0207862:	06100593          	li	a1,97
ffffffffc0207866:	00006517          	auipc	a0,0x6
ffffffffc020786a:	65a50513          	addi	a0,a0,1626 # ffffffffc020dec0 <syscalls+0x820>
ffffffffc020786e:	c31f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207872:	00006697          	auipc	a3,0x6
ffffffffc0207876:	7de68693          	addi	a3,a3,2014 # ffffffffc020e050 <syscalls+0x9b0>
ffffffffc020787a:	00004617          	auipc	a2,0x4
ffffffffc020787e:	dfe60613          	addi	a2,a2,-514 # ffffffffc020b678 <commands+0x210>
ffffffffc0207882:	05c00593          	li	a1,92
ffffffffc0207886:	00006517          	auipc	a0,0x6
ffffffffc020788a:	63a50513          	addi	a0,a0,1594 # ffffffffc020dec0 <syscalls+0x820>
ffffffffc020788e:	c11f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207892 <__alloc_fs>:
ffffffffc0207892:	1141                	addi	sp,sp,-16
ffffffffc0207894:	e022                	sd	s0,0(sp)
ffffffffc0207896:	842a                	mv	s0,a0
ffffffffc0207898:	0d800513          	li	a0,216
ffffffffc020789c:	e406                	sd	ra,8(sp)
ffffffffc020789e:	ef0fa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02078a2:	c119                	beqz	a0,ffffffffc02078a8 <__alloc_fs+0x16>
ffffffffc02078a4:	0a852823          	sw	s0,176(a0)
ffffffffc02078a8:	60a2                	ld	ra,8(sp)
ffffffffc02078aa:	6402                	ld	s0,0(sp)
ffffffffc02078ac:	0141                	addi	sp,sp,16
ffffffffc02078ae:	8082                	ret

ffffffffc02078b0 <vfs_init>:
ffffffffc02078b0:	1141                	addi	sp,sp,-16
ffffffffc02078b2:	4585                	li	a1,1
ffffffffc02078b4:	0008e517          	auipc	a0,0x8e
ffffffffc02078b8:	f4c50513          	addi	a0,a0,-180 # ffffffffc0295800 <bootfs_sem>
ffffffffc02078bc:	e406                	sd	ra,8(sp)
ffffffffc02078be:	c7bfc0ef          	jal	ra,ffffffffc0204538 <sem_init>
ffffffffc02078c2:	60a2                	ld	ra,8(sp)
ffffffffc02078c4:	0141                	addi	sp,sp,16
ffffffffc02078c6:	a40d                	j	ffffffffc0207ae8 <vfs_devlist_init>

ffffffffc02078c8 <vfs_set_bootfs>:
ffffffffc02078c8:	7179                	addi	sp,sp,-48
ffffffffc02078ca:	f022                	sd	s0,32(sp)
ffffffffc02078cc:	f406                	sd	ra,40(sp)
ffffffffc02078ce:	ec26                	sd	s1,24(sp)
ffffffffc02078d0:	e402                	sd	zero,8(sp)
ffffffffc02078d2:	842a                	mv	s0,a0
ffffffffc02078d4:	c915                	beqz	a0,ffffffffc0207908 <vfs_set_bootfs+0x40>
ffffffffc02078d6:	03a00593          	li	a1,58
ffffffffc02078da:	0a5030ef          	jal	ra,ffffffffc020b17e <strchr>
ffffffffc02078de:	c135                	beqz	a0,ffffffffc0207942 <vfs_set_bootfs+0x7a>
ffffffffc02078e0:	00154783          	lbu	a5,1(a0)
ffffffffc02078e4:	efb9                	bnez	a5,ffffffffc0207942 <vfs_set_bootfs+0x7a>
ffffffffc02078e6:	8522                	mv	a0,s0
ffffffffc02078e8:	11f000ef          	jal	ra,ffffffffc0208206 <vfs_chdir>
ffffffffc02078ec:	842a                	mv	s0,a0
ffffffffc02078ee:	c519                	beqz	a0,ffffffffc02078fc <vfs_set_bootfs+0x34>
ffffffffc02078f0:	70a2                	ld	ra,40(sp)
ffffffffc02078f2:	8522                	mv	a0,s0
ffffffffc02078f4:	7402                	ld	s0,32(sp)
ffffffffc02078f6:	64e2                	ld	s1,24(sp)
ffffffffc02078f8:	6145                	addi	sp,sp,48
ffffffffc02078fa:	8082                	ret
ffffffffc02078fc:	0028                	addi	a0,sp,8
ffffffffc02078fe:	013000ef          	jal	ra,ffffffffc0208110 <vfs_get_curdir>
ffffffffc0207902:	842a                	mv	s0,a0
ffffffffc0207904:	f575                	bnez	a0,ffffffffc02078f0 <vfs_set_bootfs+0x28>
ffffffffc0207906:	6422                	ld	s0,8(sp)
ffffffffc0207908:	0008e517          	auipc	a0,0x8e
ffffffffc020790c:	ef850513          	addi	a0,a0,-264 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207910:	c33fc0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc0207914:	0008f797          	auipc	a5,0x8f
ffffffffc0207918:	fdc78793          	addi	a5,a5,-36 # ffffffffc02968f0 <bootfs_node>
ffffffffc020791c:	6384                	ld	s1,0(a5)
ffffffffc020791e:	0008e517          	auipc	a0,0x8e
ffffffffc0207922:	ee250513          	addi	a0,a0,-286 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207926:	e380                	sd	s0,0(a5)
ffffffffc0207928:	4401                	li	s0,0
ffffffffc020792a:	c15fc0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc020792e:	d0e9                	beqz	s1,ffffffffc02078f0 <vfs_set_bootfs+0x28>
ffffffffc0207930:	8526                	mv	a0,s1
ffffffffc0207932:	e17ff0ef          	jal	ra,ffffffffc0207748 <inode_ref_dec>
ffffffffc0207936:	70a2                	ld	ra,40(sp)
ffffffffc0207938:	8522                	mv	a0,s0
ffffffffc020793a:	7402                	ld	s0,32(sp)
ffffffffc020793c:	64e2                	ld	s1,24(sp)
ffffffffc020793e:	6145                	addi	sp,sp,48
ffffffffc0207940:	8082                	ret
ffffffffc0207942:	5475                	li	s0,-3
ffffffffc0207944:	b775                	j	ffffffffc02078f0 <vfs_set_bootfs+0x28>

ffffffffc0207946 <vfs_get_bootfs>:
ffffffffc0207946:	1101                	addi	sp,sp,-32
ffffffffc0207948:	e426                	sd	s1,8(sp)
ffffffffc020794a:	0008f497          	auipc	s1,0x8f
ffffffffc020794e:	fa648493          	addi	s1,s1,-90 # ffffffffc02968f0 <bootfs_node>
ffffffffc0207952:	609c                	ld	a5,0(s1)
ffffffffc0207954:	ec06                	sd	ra,24(sp)
ffffffffc0207956:	e822                	sd	s0,16(sp)
ffffffffc0207958:	c3a1                	beqz	a5,ffffffffc0207998 <vfs_get_bootfs+0x52>
ffffffffc020795a:	842a                	mv	s0,a0
ffffffffc020795c:	0008e517          	auipc	a0,0x8e
ffffffffc0207960:	ea450513          	addi	a0,a0,-348 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207964:	bdffc0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc0207968:	6084                	ld	s1,0(s1)
ffffffffc020796a:	c08d                	beqz	s1,ffffffffc020798c <vfs_get_bootfs+0x46>
ffffffffc020796c:	8526                	mv	a0,s1
ffffffffc020796e:	d0dff0ef          	jal	ra,ffffffffc020767a <inode_ref_inc>
ffffffffc0207972:	0008e517          	auipc	a0,0x8e
ffffffffc0207976:	e8e50513          	addi	a0,a0,-370 # ffffffffc0295800 <bootfs_sem>
ffffffffc020797a:	bc5fc0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc020797e:	4501                	li	a0,0
ffffffffc0207980:	e004                	sd	s1,0(s0)
ffffffffc0207982:	60e2                	ld	ra,24(sp)
ffffffffc0207984:	6442                	ld	s0,16(sp)
ffffffffc0207986:	64a2                	ld	s1,8(sp)
ffffffffc0207988:	6105                	addi	sp,sp,32
ffffffffc020798a:	8082                	ret
ffffffffc020798c:	0008e517          	auipc	a0,0x8e
ffffffffc0207990:	e7450513          	addi	a0,a0,-396 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207994:	babfc0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc0207998:	5541                	li	a0,-16
ffffffffc020799a:	b7e5                	j	ffffffffc0207982 <vfs_get_bootfs+0x3c>

ffffffffc020799c <vfs_do_add>:
ffffffffc020799c:	7139                	addi	sp,sp,-64
ffffffffc020799e:	fc06                	sd	ra,56(sp)
ffffffffc02079a0:	f822                	sd	s0,48(sp)
ffffffffc02079a2:	f426                	sd	s1,40(sp)
ffffffffc02079a4:	f04a                	sd	s2,32(sp)
ffffffffc02079a6:	ec4e                	sd	s3,24(sp)
ffffffffc02079a8:	e852                	sd	s4,16(sp)
ffffffffc02079aa:	e456                	sd	s5,8(sp)
ffffffffc02079ac:	e05a                	sd	s6,0(sp)
ffffffffc02079ae:	0e050b63          	beqz	a0,ffffffffc0207aa4 <vfs_do_add+0x108>
ffffffffc02079b2:	842a                	mv	s0,a0
ffffffffc02079b4:	8a2e                	mv	s4,a1
ffffffffc02079b6:	8b32                	mv	s6,a2
ffffffffc02079b8:	8ab6                	mv	s5,a3
ffffffffc02079ba:	c5cd                	beqz	a1,ffffffffc0207a64 <vfs_do_add+0xc8>
ffffffffc02079bc:	4db8                	lw	a4,88(a1)
ffffffffc02079be:	6785                	lui	a5,0x1
ffffffffc02079c0:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02079c4:	0af71163          	bne	a4,a5,ffffffffc0207a66 <vfs_do_add+0xca>
ffffffffc02079c8:	8522                	mv	a0,s0
ffffffffc02079ca:	728030ef          	jal	ra,ffffffffc020b0f2 <strlen>
ffffffffc02079ce:	47fd                	li	a5,31
ffffffffc02079d0:	0ca7e663          	bltu	a5,a0,ffffffffc0207a9c <vfs_do_add+0x100>
ffffffffc02079d4:	8522                	mv	a0,s0
ffffffffc02079d6:	81ff80ef          	jal	ra,ffffffffc02001f4 <strdup>
ffffffffc02079da:	84aa                	mv	s1,a0
ffffffffc02079dc:	c171                	beqz	a0,ffffffffc0207aa0 <vfs_do_add+0x104>
ffffffffc02079de:	03000513          	li	a0,48
ffffffffc02079e2:	dacfa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02079e6:	89aa                	mv	s3,a0
ffffffffc02079e8:	c92d                	beqz	a0,ffffffffc0207a5a <vfs_do_add+0xbe>
ffffffffc02079ea:	0008e517          	auipc	a0,0x8e
ffffffffc02079ee:	e3e50513          	addi	a0,a0,-450 # ffffffffc0295828 <vdev_list_sem>
ffffffffc02079f2:	0008e917          	auipc	s2,0x8e
ffffffffc02079f6:	e2690913          	addi	s2,s2,-474 # ffffffffc0295818 <vdev_list>
ffffffffc02079fa:	b49fc0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc02079fe:	844a                	mv	s0,s2
ffffffffc0207a00:	a039                	j	ffffffffc0207a0e <vfs_do_add+0x72>
ffffffffc0207a02:	fe043503          	ld	a0,-32(s0)
ffffffffc0207a06:	85a6                	mv	a1,s1
ffffffffc0207a08:	732030ef          	jal	ra,ffffffffc020b13a <strcmp>
ffffffffc0207a0c:	cd2d                	beqz	a0,ffffffffc0207a86 <vfs_do_add+0xea>
ffffffffc0207a0e:	6400                	ld	s0,8(s0)
ffffffffc0207a10:	ff2419e3          	bne	s0,s2,ffffffffc0207a02 <vfs_do_add+0x66>
ffffffffc0207a14:	6418                	ld	a4,8(s0)
ffffffffc0207a16:	02098793          	addi	a5,s3,32
ffffffffc0207a1a:	0099b023          	sd	s1,0(s3)
ffffffffc0207a1e:	0149b423          	sd	s4,8(s3)
ffffffffc0207a22:	0159bc23          	sd	s5,24(s3)
ffffffffc0207a26:	0169b823          	sd	s6,16(s3)
ffffffffc0207a2a:	e31c                	sd	a5,0(a4)
ffffffffc0207a2c:	0289b023          	sd	s0,32(s3)
ffffffffc0207a30:	02e9b423          	sd	a4,40(s3)
ffffffffc0207a34:	0008e517          	auipc	a0,0x8e
ffffffffc0207a38:	df450513          	addi	a0,a0,-524 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207a3c:	e41c                	sd	a5,8(s0)
ffffffffc0207a3e:	4401                	li	s0,0
ffffffffc0207a40:	afffc0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc0207a44:	70e2                	ld	ra,56(sp)
ffffffffc0207a46:	8522                	mv	a0,s0
ffffffffc0207a48:	7442                	ld	s0,48(sp)
ffffffffc0207a4a:	74a2                	ld	s1,40(sp)
ffffffffc0207a4c:	7902                	ld	s2,32(sp)
ffffffffc0207a4e:	69e2                	ld	s3,24(sp)
ffffffffc0207a50:	6a42                	ld	s4,16(sp)
ffffffffc0207a52:	6aa2                	ld	s5,8(sp)
ffffffffc0207a54:	6b02                	ld	s6,0(sp)
ffffffffc0207a56:	6121                	addi	sp,sp,64
ffffffffc0207a58:	8082                	ret
ffffffffc0207a5a:	5471                	li	s0,-4
ffffffffc0207a5c:	8526                	mv	a0,s1
ffffffffc0207a5e:	de0fa0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0207a62:	b7cd                	j	ffffffffc0207a44 <vfs_do_add+0xa8>
ffffffffc0207a64:	d2b5                	beqz	a3,ffffffffc02079c8 <vfs_do_add+0x2c>
ffffffffc0207a66:	00006697          	auipc	a3,0x6
ffffffffc0207a6a:	6aa68693          	addi	a3,a3,1706 # ffffffffc020e110 <syscalls+0xa70>
ffffffffc0207a6e:	00004617          	auipc	a2,0x4
ffffffffc0207a72:	c0a60613          	addi	a2,a2,-1014 # ffffffffc020b678 <commands+0x210>
ffffffffc0207a76:	08f00593          	li	a1,143
ffffffffc0207a7a:	00006517          	auipc	a0,0x6
ffffffffc0207a7e:	67e50513          	addi	a0,a0,1662 # ffffffffc020e0f8 <syscalls+0xa58>
ffffffffc0207a82:	a1df80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207a86:	0008e517          	auipc	a0,0x8e
ffffffffc0207a8a:	da250513          	addi	a0,a0,-606 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207a8e:	ab1fc0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc0207a92:	854e                	mv	a0,s3
ffffffffc0207a94:	daafa0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0207a98:	5425                	li	s0,-23
ffffffffc0207a9a:	b7c9                	j	ffffffffc0207a5c <vfs_do_add+0xc0>
ffffffffc0207a9c:	5451                	li	s0,-12
ffffffffc0207a9e:	b75d                	j	ffffffffc0207a44 <vfs_do_add+0xa8>
ffffffffc0207aa0:	5471                	li	s0,-4
ffffffffc0207aa2:	b74d                	j	ffffffffc0207a44 <vfs_do_add+0xa8>
ffffffffc0207aa4:	00006697          	auipc	a3,0x6
ffffffffc0207aa8:	64468693          	addi	a3,a3,1604 # ffffffffc020e0e8 <syscalls+0xa48>
ffffffffc0207aac:	00004617          	auipc	a2,0x4
ffffffffc0207ab0:	bcc60613          	addi	a2,a2,-1076 # ffffffffc020b678 <commands+0x210>
ffffffffc0207ab4:	08e00593          	li	a1,142
ffffffffc0207ab8:	00006517          	auipc	a0,0x6
ffffffffc0207abc:	64050513          	addi	a0,a0,1600 # ffffffffc020e0f8 <syscalls+0xa58>
ffffffffc0207ac0:	9dff80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207ac4 <find_mount.part.0>:
ffffffffc0207ac4:	1141                	addi	sp,sp,-16
ffffffffc0207ac6:	00006697          	auipc	a3,0x6
ffffffffc0207aca:	62268693          	addi	a3,a3,1570 # ffffffffc020e0e8 <syscalls+0xa48>
ffffffffc0207ace:	00004617          	auipc	a2,0x4
ffffffffc0207ad2:	baa60613          	addi	a2,a2,-1110 # ffffffffc020b678 <commands+0x210>
ffffffffc0207ad6:	0cd00593          	li	a1,205
ffffffffc0207ada:	00006517          	auipc	a0,0x6
ffffffffc0207ade:	61e50513          	addi	a0,a0,1566 # ffffffffc020e0f8 <syscalls+0xa58>
ffffffffc0207ae2:	e406                	sd	ra,8(sp)
ffffffffc0207ae4:	9bbf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207ae8 <vfs_devlist_init>:
ffffffffc0207ae8:	0008e797          	auipc	a5,0x8e
ffffffffc0207aec:	d3078793          	addi	a5,a5,-720 # ffffffffc0295818 <vdev_list>
ffffffffc0207af0:	4585                	li	a1,1
ffffffffc0207af2:	0008e517          	auipc	a0,0x8e
ffffffffc0207af6:	d3650513          	addi	a0,a0,-714 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207afa:	e79c                	sd	a5,8(a5)
ffffffffc0207afc:	e39c                	sd	a5,0(a5)
ffffffffc0207afe:	a3bfc06f          	j	ffffffffc0204538 <sem_init>

ffffffffc0207b02 <vfs_cleanup>:
ffffffffc0207b02:	1101                	addi	sp,sp,-32
ffffffffc0207b04:	e426                	sd	s1,8(sp)
ffffffffc0207b06:	0008e497          	auipc	s1,0x8e
ffffffffc0207b0a:	d1248493          	addi	s1,s1,-750 # ffffffffc0295818 <vdev_list>
ffffffffc0207b0e:	649c                	ld	a5,8(s1)
ffffffffc0207b10:	ec06                	sd	ra,24(sp)
ffffffffc0207b12:	e822                	sd	s0,16(sp)
ffffffffc0207b14:	02978e63          	beq	a5,s1,ffffffffc0207b50 <vfs_cleanup+0x4e>
ffffffffc0207b18:	0008e517          	auipc	a0,0x8e
ffffffffc0207b1c:	d1050513          	addi	a0,a0,-752 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207b20:	a23fc0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc0207b24:	6480                	ld	s0,8(s1)
ffffffffc0207b26:	00940b63          	beq	s0,s1,ffffffffc0207b3c <vfs_cleanup+0x3a>
ffffffffc0207b2a:	ff043783          	ld	a5,-16(s0)
ffffffffc0207b2e:	853e                	mv	a0,a5
ffffffffc0207b30:	c399                	beqz	a5,ffffffffc0207b36 <vfs_cleanup+0x34>
ffffffffc0207b32:	6bfc                	ld	a5,208(a5)
ffffffffc0207b34:	9782                	jalr	a5
ffffffffc0207b36:	6400                	ld	s0,8(s0)
ffffffffc0207b38:	fe9419e3          	bne	s0,s1,ffffffffc0207b2a <vfs_cleanup+0x28>
ffffffffc0207b3c:	6442                	ld	s0,16(sp)
ffffffffc0207b3e:	60e2                	ld	ra,24(sp)
ffffffffc0207b40:	64a2                	ld	s1,8(sp)
ffffffffc0207b42:	0008e517          	auipc	a0,0x8e
ffffffffc0207b46:	ce650513          	addi	a0,a0,-794 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207b4a:	6105                	addi	sp,sp,32
ffffffffc0207b4c:	9f3fc06f          	j	ffffffffc020453e <up>
ffffffffc0207b50:	60e2                	ld	ra,24(sp)
ffffffffc0207b52:	6442                	ld	s0,16(sp)
ffffffffc0207b54:	64a2                	ld	s1,8(sp)
ffffffffc0207b56:	6105                	addi	sp,sp,32
ffffffffc0207b58:	8082                	ret

ffffffffc0207b5a <vfs_get_root>:
ffffffffc0207b5a:	7179                	addi	sp,sp,-48
ffffffffc0207b5c:	f406                	sd	ra,40(sp)
ffffffffc0207b5e:	f022                	sd	s0,32(sp)
ffffffffc0207b60:	ec26                	sd	s1,24(sp)
ffffffffc0207b62:	e84a                	sd	s2,16(sp)
ffffffffc0207b64:	e44e                	sd	s3,8(sp)
ffffffffc0207b66:	e052                	sd	s4,0(sp)
ffffffffc0207b68:	c541                	beqz	a0,ffffffffc0207bf0 <vfs_get_root+0x96>
ffffffffc0207b6a:	0008e917          	auipc	s2,0x8e
ffffffffc0207b6e:	cae90913          	addi	s2,s2,-850 # ffffffffc0295818 <vdev_list>
ffffffffc0207b72:	00893783          	ld	a5,8(s2)
ffffffffc0207b76:	07278b63          	beq	a5,s2,ffffffffc0207bec <vfs_get_root+0x92>
ffffffffc0207b7a:	89aa                	mv	s3,a0
ffffffffc0207b7c:	0008e517          	auipc	a0,0x8e
ffffffffc0207b80:	cac50513          	addi	a0,a0,-852 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207b84:	8a2e                	mv	s4,a1
ffffffffc0207b86:	844a                	mv	s0,s2
ffffffffc0207b88:	9bbfc0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc0207b8c:	a801                	j	ffffffffc0207b9c <vfs_get_root+0x42>
ffffffffc0207b8e:	fe043583          	ld	a1,-32(s0)
ffffffffc0207b92:	854e                	mv	a0,s3
ffffffffc0207b94:	5a6030ef          	jal	ra,ffffffffc020b13a <strcmp>
ffffffffc0207b98:	84aa                	mv	s1,a0
ffffffffc0207b9a:	c505                	beqz	a0,ffffffffc0207bc2 <vfs_get_root+0x68>
ffffffffc0207b9c:	6400                	ld	s0,8(s0)
ffffffffc0207b9e:	ff2418e3          	bne	s0,s2,ffffffffc0207b8e <vfs_get_root+0x34>
ffffffffc0207ba2:	54cd                	li	s1,-13
ffffffffc0207ba4:	0008e517          	auipc	a0,0x8e
ffffffffc0207ba8:	c8450513          	addi	a0,a0,-892 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207bac:	993fc0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc0207bb0:	70a2                	ld	ra,40(sp)
ffffffffc0207bb2:	7402                	ld	s0,32(sp)
ffffffffc0207bb4:	6942                	ld	s2,16(sp)
ffffffffc0207bb6:	69a2                	ld	s3,8(sp)
ffffffffc0207bb8:	6a02                	ld	s4,0(sp)
ffffffffc0207bba:	8526                	mv	a0,s1
ffffffffc0207bbc:	64e2                	ld	s1,24(sp)
ffffffffc0207bbe:	6145                	addi	sp,sp,48
ffffffffc0207bc0:	8082                	ret
ffffffffc0207bc2:	ff043503          	ld	a0,-16(s0)
ffffffffc0207bc6:	c519                	beqz	a0,ffffffffc0207bd4 <vfs_get_root+0x7a>
ffffffffc0207bc8:	617c                	ld	a5,192(a0)
ffffffffc0207bca:	9782                	jalr	a5
ffffffffc0207bcc:	c519                	beqz	a0,ffffffffc0207bda <vfs_get_root+0x80>
ffffffffc0207bce:	00aa3023          	sd	a0,0(s4)
ffffffffc0207bd2:	bfc9                	j	ffffffffc0207ba4 <vfs_get_root+0x4a>
ffffffffc0207bd4:	ff843783          	ld	a5,-8(s0)
ffffffffc0207bd8:	c399                	beqz	a5,ffffffffc0207bde <vfs_get_root+0x84>
ffffffffc0207bda:	54c9                	li	s1,-14
ffffffffc0207bdc:	b7e1                	j	ffffffffc0207ba4 <vfs_get_root+0x4a>
ffffffffc0207bde:	fe843503          	ld	a0,-24(s0)
ffffffffc0207be2:	a99ff0ef          	jal	ra,ffffffffc020767a <inode_ref_inc>
ffffffffc0207be6:	fe843503          	ld	a0,-24(s0)
ffffffffc0207bea:	b7cd                	j	ffffffffc0207bcc <vfs_get_root+0x72>
ffffffffc0207bec:	54cd                	li	s1,-13
ffffffffc0207bee:	b7c9                	j	ffffffffc0207bb0 <vfs_get_root+0x56>
ffffffffc0207bf0:	00006697          	auipc	a3,0x6
ffffffffc0207bf4:	4f868693          	addi	a3,a3,1272 # ffffffffc020e0e8 <syscalls+0xa48>
ffffffffc0207bf8:	00004617          	auipc	a2,0x4
ffffffffc0207bfc:	a8060613          	addi	a2,a2,-1408 # ffffffffc020b678 <commands+0x210>
ffffffffc0207c00:	04500593          	li	a1,69
ffffffffc0207c04:	00006517          	auipc	a0,0x6
ffffffffc0207c08:	4f450513          	addi	a0,a0,1268 # ffffffffc020e0f8 <syscalls+0xa58>
ffffffffc0207c0c:	893f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207c10 <vfs_get_devname>:
ffffffffc0207c10:	0008e697          	auipc	a3,0x8e
ffffffffc0207c14:	c0868693          	addi	a3,a3,-1016 # ffffffffc0295818 <vdev_list>
ffffffffc0207c18:	87b6                	mv	a5,a3
ffffffffc0207c1a:	e511                	bnez	a0,ffffffffc0207c26 <vfs_get_devname+0x16>
ffffffffc0207c1c:	a829                	j	ffffffffc0207c36 <vfs_get_devname+0x26>
ffffffffc0207c1e:	ff07b703          	ld	a4,-16(a5)
ffffffffc0207c22:	00a70763          	beq	a4,a0,ffffffffc0207c30 <vfs_get_devname+0x20>
ffffffffc0207c26:	679c                	ld	a5,8(a5)
ffffffffc0207c28:	fed79be3          	bne	a5,a3,ffffffffc0207c1e <vfs_get_devname+0xe>
ffffffffc0207c2c:	4501                	li	a0,0
ffffffffc0207c2e:	8082                	ret
ffffffffc0207c30:	fe07b503          	ld	a0,-32(a5)
ffffffffc0207c34:	8082                	ret
ffffffffc0207c36:	1141                	addi	sp,sp,-16
ffffffffc0207c38:	00006697          	auipc	a3,0x6
ffffffffc0207c3c:	53868693          	addi	a3,a3,1336 # ffffffffc020e170 <syscalls+0xad0>
ffffffffc0207c40:	00004617          	auipc	a2,0x4
ffffffffc0207c44:	a3860613          	addi	a2,a2,-1480 # ffffffffc020b678 <commands+0x210>
ffffffffc0207c48:	06a00593          	li	a1,106
ffffffffc0207c4c:	00006517          	auipc	a0,0x6
ffffffffc0207c50:	4ac50513          	addi	a0,a0,1196 # ffffffffc020e0f8 <syscalls+0xa58>
ffffffffc0207c54:	e406                	sd	ra,8(sp)
ffffffffc0207c56:	849f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207c5a <vfs_add_dev>:
ffffffffc0207c5a:	86b2                	mv	a3,a2
ffffffffc0207c5c:	4601                	li	a2,0
ffffffffc0207c5e:	d3fff06f          	j	ffffffffc020799c <vfs_do_add>

ffffffffc0207c62 <vfs_mount>:
ffffffffc0207c62:	7179                	addi	sp,sp,-48
ffffffffc0207c64:	e84a                	sd	s2,16(sp)
ffffffffc0207c66:	892a                	mv	s2,a0
ffffffffc0207c68:	0008e517          	auipc	a0,0x8e
ffffffffc0207c6c:	bc050513          	addi	a0,a0,-1088 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207c70:	e44e                	sd	s3,8(sp)
ffffffffc0207c72:	f406                	sd	ra,40(sp)
ffffffffc0207c74:	f022                	sd	s0,32(sp)
ffffffffc0207c76:	ec26                	sd	s1,24(sp)
ffffffffc0207c78:	89ae                	mv	s3,a1
ffffffffc0207c7a:	8c9fc0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc0207c7e:	08090a63          	beqz	s2,ffffffffc0207d12 <vfs_mount+0xb0>
ffffffffc0207c82:	0008e497          	auipc	s1,0x8e
ffffffffc0207c86:	b9648493          	addi	s1,s1,-1130 # ffffffffc0295818 <vdev_list>
ffffffffc0207c8a:	6480                	ld	s0,8(s1)
ffffffffc0207c8c:	00941663          	bne	s0,s1,ffffffffc0207c98 <vfs_mount+0x36>
ffffffffc0207c90:	a8ad                	j	ffffffffc0207d0a <vfs_mount+0xa8>
ffffffffc0207c92:	6400                	ld	s0,8(s0)
ffffffffc0207c94:	06940b63          	beq	s0,s1,ffffffffc0207d0a <vfs_mount+0xa8>
ffffffffc0207c98:	ff843783          	ld	a5,-8(s0)
ffffffffc0207c9c:	dbfd                	beqz	a5,ffffffffc0207c92 <vfs_mount+0x30>
ffffffffc0207c9e:	fe043503          	ld	a0,-32(s0)
ffffffffc0207ca2:	85ca                	mv	a1,s2
ffffffffc0207ca4:	496030ef          	jal	ra,ffffffffc020b13a <strcmp>
ffffffffc0207ca8:	f56d                	bnez	a0,ffffffffc0207c92 <vfs_mount+0x30>
ffffffffc0207caa:	ff043783          	ld	a5,-16(s0)
ffffffffc0207cae:	e3a5                	bnez	a5,ffffffffc0207d0e <vfs_mount+0xac>
ffffffffc0207cb0:	fe043783          	ld	a5,-32(s0)
ffffffffc0207cb4:	c3c9                	beqz	a5,ffffffffc0207d36 <vfs_mount+0xd4>
ffffffffc0207cb6:	ff843783          	ld	a5,-8(s0)
ffffffffc0207cba:	cfb5                	beqz	a5,ffffffffc0207d36 <vfs_mount+0xd4>
ffffffffc0207cbc:	fe843503          	ld	a0,-24(s0)
ffffffffc0207cc0:	c939                	beqz	a0,ffffffffc0207d16 <vfs_mount+0xb4>
ffffffffc0207cc2:	4d38                	lw	a4,88(a0)
ffffffffc0207cc4:	6785                	lui	a5,0x1
ffffffffc0207cc6:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207cca:	04f71663          	bne	a4,a5,ffffffffc0207d16 <vfs_mount+0xb4>
ffffffffc0207cce:	ff040593          	addi	a1,s0,-16
ffffffffc0207cd2:	9982                	jalr	s3
ffffffffc0207cd4:	84aa                	mv	s1,a0
ffffffffc0207cd6:	ed01                	bnez	a0,ffffffffc0207cee <vfs_mount+0x8c>
ffffffffc0207cd8:	ff043783          	ld	a5,-16(s0)
ffffffffc0207cdc:	cfad                	beqz	a5,ffffffffc0207d56 <vfs_mount+0xf4>
ffffffffc0207cde:	fe043583          	ld	a1,-32(s0)
ffffffffc0207ce2:	00006517          	auipc	a0,0x6
ffffffffc0207ce6:	51e50513          	addi	a0,a0,1310 # ffffffffc020e200 <syscalls+0xb60>
ffffffffc0207cea:	cbcf80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207cee:	0008e517          	auipc	a0,0x8e
ffffffffc0207cf2:	b3a50513          	addi	a0,a0,-1222 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207cf6:	849fc0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc0207cfa:	70a2                	ld	ra,40(sp)
ffffffffc0207cfc:	7402                	ld	s0,32(sp)
ffffffffc0207cfe:	6942                	ld	s2,16(sp)
ffffffffc0207d00:	69a2                	ld	s3,8(sp)
ffffffffc0207d02:	8526                	mv	a0,s1
ffffffffc0207d04:	64e2                	ld	s1,24(sp)
ffffffffc0207d06:	6145                	addi	sp,sp,48
ffffffffc0207d08:	8082                	ret
ffffffffc0207d0a:	54cd                	li	s1,-13
ffffffffc0207d0c:	b7cd                	j	ffffffffc0207cee <vfs_mount+0x8c>
ffffffffc0207d0e:	54c5                	li	s1,-15
ffffffffc0207d10:	bff9                	j	ffffffffc0207cee <vfs_mount+0x8c>
ffffffffc0207d12:	db3ff0ef          	jal	ra,ffffffffc0207ac4 <find_mount.part.0>
ffffffffc0207d16:	00006697          	auipc	a3,0x6
ffffffffc0207d1a:	49a68693          	addi	a3,a3,1178 # ffffffffc020e1b0 <syscalls+0xb10>
ffffffffc0207d1e:	00004617          	auipc	a2,0x4
ffffffffc0207d22:	95a60613          	addi	a2,a2,-1702 # ffffffffc020b678 <commands+0x210>
ffffffffc0207d26:	0ed00593          	li	a1,237
ffffffffc0207d2a:	00006517          	auipc	a0,0x6
ffffffffc0207d2e:	3ce50513          	addi	a0,a0,974 # ffffffffc020e0f8 <syscalls+0xa58>
ffffffffc0207d32:	f6cf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207d36:	00006697          	auipc	a3,0x6
ffffffffc0207d3a:	44a68693          	addi	a3,a3,1098 # ffffffffc020e180 <syscalls+0xae0>
ffffffffc0207d3e:	00004617          	auipc	a2,0x4
ffffffffc0207d42:	93a60613          	addi	a2,a2,-1734 # ffffffffc020b678 <commands+0x210>
ffffffffc0207d46:	0eb00593          	li	a1,235
ffffffffc0207d4a:	00006517          	auipc	a0,0x6
ffffffffc0207d4e:	3ae50513          	addi	a0,a0,942 # ffffffffc020e0f8 <syscalls+0xa58>
ffffffffc0207d52:	f4cf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207d56:	00006697          	auipc	a3,0x6
ffffffffc0207d5a:	49268693          	addi	a3,a3,1170 # ffffffffc020e1e8 <syscalls+0xb48>
ffffffffc0207d5e:	00004617          	auipc	a2,0x4
ffffffffc0207d62:	91a60613          	addi	a2,a2,-1766 # ffffffffc020b678 <commands+0x210>
ffffffffc0207d66:	0ef00593          	li	a1,239
ffffffffc0207d6a:	00006517          	auipc	a0,0x6
ffffffffc0207d6e:	38e50513          	addi	a0,a0,910 # ffffffffc020e0f8 <syscalls+0xa58>
ffffffffc0207d72:	f2cf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207d76 <vfs_open>:
ffffffffc0207d76:	711d                	addi	sp,sp,-96
ffffffffc0207d78:	e4a6                	sd	s1,72(sp)
ffffffffc0207d7a:	e0ca                	sd	s2,64(sp)
ffffffffc0207d7c:	fc4e                	sd	s3,56(sp)
ffffffffc0207d7e:	ec86                	sd	ra,88(sp)
ffffffffc0207d80:	e8a2                	sd	s0,80(sp)
ffffffffc0207d82:	f852                	sd	s4,48(sp)
ffffffffc0207d84:	f456                	sd	s5,40(sp)
ffffffffc0207d86:	0035f793          	andi	a5,a1,3
ffffffffc0207d8a:	84ae                	mv	s1,a1
ffffffffc0207d8c:	892a                	mv	s2,a0
ffffffffc0207d8e:	89b2                	mv	s3,a2
ffffffffc0207d90:	0e078663          	beqz	a5,ffffffffc0207e7c <vfs_open+0x106>
ffffffffc0207d94:	470d                	li	a4,3
ffffffffc0207d96:	0105fa93          	andi	s5,a1,16
ffffffffc0207d9a:	0ce78f63          	beq	a5,a4,ffffffffc0207e78 <vfs_open+0x102>
ffffffffc0207d9e:	002c                	addi	a1,sp,8
ffffffffc0207da0:	854a                	mv	a0,s2
ffffffffc0207da2:	2ae000ef          	jal	ra,ffffffffc0208050 <vfs_lookup>
ffffffffc0207da6:	842a                	mv	s0,a0
ffffffffc0207da8:	0044fa13          	andi	s4,s1,4
ffffffffc0207dac:	e159                	bnez	a0,ffffffffc0207e32 <vfs_open+0xbc>
ffffffffc0207dae:	00c4f793          	andi	a5,s1,12
ffffffffc0207db2:	4731                	li	a4,12
ffffffffc0207db4:	0ee78263          	beq	a5,a4,ffffffffc0207e98 <vfs_open+0x122>
ffffffffc0207db8:	6422                	ld	s0,8(sp)
ffffffffc0207dba:	12040163          	beqz	s0,ffffffffc0207edc <vfs_open+0x166>
ffffffffc0207dbe:	783c                	ld	a5,112(s0)
ffffffffc0207dc0:	cff1                	beqz	a5,ffffffffc0207e9c <vfs_open+0x126>
ffffffffc0207dc2:	679c                	ld	a5,8(a5)
ffffffffc0207dc4:	cfe1                	beqz	a5,ffffffffc0207e9c <vfs_open+0x126>
ffffffffc0207dc6:	8522                	mv	a0,s0
ffffffffc0207dc8:	00006597          	auipc	a1,0x6
ffffffffc0207dcc:	51858593          	addi	a1,a1,1304 # ffffffffc020e2e0 <syscalls+0xc40>
ffffffffc0207dd0:	8c3ff0ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc0207dd4:	783c                	ld	a5,112(s0)
ffffffffc0207dd6:	6522                	ld	a0,8(sp)
ffffffffc0207dd8:	85a6                	mv	a1,s1
ffffffffc0207dda:	679c                	ld	a5,8(a5)
ffffffffc0207ddc:	9782                	jalr	a5
ffffffffc0207dde:	842a                	mv	s0,a0
ffffffffc0207de0:	6522                	ld	a0,8(sp)
ffffffffc0207de2:	e845                	bnez	s0,ffffffffc0207e92 <vfs_open+0x11c>
ffffffffc0207de4:	015a6a33          	or	s4,s4,s5
ffffffffc0207de8:	89fff0ef          	jal	ra,ffffffffc0207686 <inode_open_inc>
ffffffffc0207dec:	020a0663          	beqz	s4,ffffffffc0207e18 <vfs_open+0xa2>
ffffffffc0207df0:	64a2                	ld	s1,8(sp)
ffffffffc0207df2:	c4e9                	beqz	s1,ffffffffc0207ebc <vfs_open+0x146>
ffffffffc0207df4:	78bc                	ld	a5,112(s1)
ffffffffc0207df6:	c3f9                	beqz	a5,ffffffffc0207ebc <vfs_open+0x146>
ffffffffc0207df8:	73bc                	ld	a5,96(a5)
ffffffffc0207dfa:	c3e9                	beqz	a5,ffffffffc0207ebc <vfs_open+0x146>
ffffffffc0207dfc:	00006597          	auipc	a1,0x6
ffffffffc0207e00:	54458593          	addi	a1,a1,1348 # ffffffffc020e340 <syscalls+0xca0>
ffffffffc0207e04:	8526                	mv	a0,s1
ffffffffc0207e06:	88dff0ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc0207e0a:	78bc                	ld	a5,112(s1)
ffffffffc0207e0c:	6522                	ld	a0,8(sp)
ffffffffc0207e0e:	4581                	li	a1,0
ffffffffc0207e10:	73bc                	ld	a5,96(a5)
ffffffffc0207e12:	9782                	jalr	a5
ffffffffc0207e14:	87aa                	mv	a5,a0
ffffffffc0207e16:	e92d                	bnez	a0,ffffffffc0207e88 <vfs_open+0x112>
ffffffffc0207e18:	67a2                	ld	a5,8(sp)
ffffffffc0207e1a:	00f9b023          	sd	a5,0(s3)
ffffffffc0207e1e:	60e6                	ld	ra,88(sp)
ffffffffc0207e20:	8522                	mv	a0,s0
ffffffffc0207e22:	6446                	ld	s0,80(sp)
ffffffffc0207e24:	64a6                	ld	s1,72(sp)
ffffffffc0207e26:	6906                	ld	s2,64(sp)
ffffffffc0207e28:	79e2                	ld	s3,56(sp)
ffffffffc0207e2a:	7a42                	ld	s4,48(sp)
ffffffffc0207e2c:	7aa2                	ld	s5,40(sp)
ffffffffc0207e2e:	6125                	addi	sp,sp,96
ffffffffc0207e30:	8082                	ret
ffffffffc0207e32:	57c1                	li	a5,-16
ffffffffc0207e34:	fef515e3          	bne	a0,a5,ffffffffc0207e1e <vfs_open+0xa8>
ffffffffc0207e38:	fe0a03e3          	beqz	s4,ffffffffc0207e1e <vfs_open+0xa8>
ffffffffc0207e3c:	0810                	addi	a2,sp,16
ffffffffc0207e3e:	082c                	addi	a1,sp,24
ffffffffc0207e40:	854a                	mv	a0,s2
ffffffffc0207e42:	2a4000ef          	jal	ra,ffffffffc02080e6 <vfs_lookup_parent>
ffffffffc0207e46:	842a                	mv	s0,a0
ffffffffc0207e48:	f979                	bnez	a0,ffffffffc0207e1e <vfs_open+0xa8>
ffffffffc0207e4a:	6462                	ld	s0,24(sp)
ffffffffc0207e4c:	c845                	beqz	s0,ffffffffc0207efc <vfs_open+0x186>
ffffffffc0207e4e:	783c                	ld	a5,112(s0)
ffffffffc0207e50:	c7d5                	beqz	a5,ffffffffc0207efc <vfs_open+0x186>
ffffffffc0207e52:	77bc                	ld	a5,104(a5)
ffffffffc0207e54:	c7c5                	beqz	a5,ffffffffc0207efc <vfs_open+0x186>
ffffffffc0207e56:	8522                	mv	a0,s0
ffffffffc0207e58:	00006597          	auipc	a1,0x6
ffffffffc0207e5c:	42058593          	addi	a1,a1,1056 # ffffffffc020e278 <syscalls+0xbd8>
ffffffffc0207e60:	833ff0ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc0207e64:	783c                	ld	a5,112(s0)
ffffffffc0207e66:	65c2                	ld	a1,16(sp)
ffffffffc0207e68:	6562                	ld	a0,24(sp)
ffffffffc0207e6a:	77bc                	ld	a5,104(a5)
ffffffffc0207e6c:	4034d613          	srai	a2,s1,0x3
ffffffffc0207e70:	0034                	addi	a3,sp,8
ffffffffc0207e72:	8a05                	andi	a2,a2,1
ffffffffc0207e74:	9782                	jalr	a5
ffffffffc0207e76:	b789                	j	ffffffffc0207db8 <vfs_open+0x42>
ffffffffc0207e78:	5475                	li	s0,-3
ffffffffc0207e7a:	b755                	j	ffffffffc0207e1e <vfs_open+0xa8>
ffffffffc0207e7c:	0105fa93          	andi	s5,a1,16
ffffffffc0207e80:	5475                	li	s0,-3
ffffffffc0207e82:	f80a9ee3          	bnez	s5,ffffffffc0207e1e <vfs_open+0xa8>
ffffffffc0207e86:	bf21                	j	ffffffffc0207d9e <vfs_open+0x28>
ffffffffc0207e88:	6522                	ld	a0,8(sp)
ffffffffc0207e8a:	843e                	mv	s0,a5
ffffffffc0207e8c:	965ff0ef          	jal	ra,ffffffffc02077f0 <inode_open_dec>
ffffffffc0207e90:	6522                	ld	a0,8(sp)
ffffffffc0207e92:	8b7ff0ef          	jal	ra,ffffffffc0207748 <inode_ref_dec>
ffffffffc0207e96:	b761                	j	ffffffffc0207e1e <vfs_open+0xa8>
ffffffffc0207e98:	5425                	li	s0,-23
ffffffffc0207e9a:	b751                	j	ffffffffc0207e1e <vfs_open+0xa8>
ffffffffc0207e9c:	00006697          	auipc	a3,0x6
ffffffffc0207ea0:	3f468693          	addi	a3,a3,1012 # ffffffffc020e290 <syscalls+0xbf0>
ffffffffc0207ea4:	00003617          	auipc	a2,0x3
ffffffffc0207ea8:	7d460613          	addi	a2,a2,2004 # ffffffffc020b678 <commands+0x210>
ffffffffc0207eac:	03300593          	li	a1,51
ffffffffc0207eb0:	00006517          	auipc	a0,0x6
ffffffffc0207eb4:	3b050513          	addi	a0,a0,944 # ffffffffc020e260 <syscalls+0xbc0>
ffffffffc0207eb8:	de6f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207ebc:	00006697          	auipc	a3,0x6
ffffffffc0207ec0:	42c68693          	addi	a3,a3,1068 # ffffffffc020e2e8 <syscalls+0xc48>
ffffffffc0207ec4:	00003617          	auipc	a2,0x3
ffffffffc0207ec8:	7b460613          	addi	a2,a2,1972 # ffffffffc020b678 <commands+0x210>
ffffffffc0207ecc:	03a00593          	li	a1,58
ffffffffc0207ed0:	00006517          	auipc	a0,0x6
ffffffffc0207ed4:	39050513          	addi	a0,a0,912 # ffffffffc020e260 <syscalls+0xbc0>
ffffffffc0207ed8:	dc6f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207edc:	00006697          	auipc	a3,0x6
ffffffffc0207ee0:	3a468693          	addi	a3,a3,932 # ffffffffc020e280 <syscalls+0xbe0>
ffffffffc0207ee4:	00003617          	auipc	a2,0x3
ffffffffc0207ee8:	79460613          	addi	a2,a2,1940 # ffffffffc020b678 <commands+0x210>
ffffffffc0207eec:	03100593          	li	a1,49
ffffffffc0207ef0:	00006517          	auipc	a0,0x6
ffffffffc0207ef4:	37050513          	addi	a0,a0,880 # ffffffffc020e260 <syscalls+0xbc0>
ffffffffc0207ef8:	da6f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207efc:	00006697          	auipc	a3,0x6
ffffffffc0207f00:	31468693          	addi	a3,a3,788 # ffffffffc020e210 <syscalls+0xb70>
ffffffffc0207f04:	00003617          	auipc	a2,0x3
ffffffffc0207f08:	77460613          	addi	a2,a2,1908 # ffffffffc020b678 <commands+0x210>
ffffffffc0207f0c:	02c00593          	li	a1,44
ffffffffc0207f10:	00006517          	auipc	a0,0x6
ffffffffc0207f14:	35050513          	addi	a0,a0,848 # ffffffffc020e260 <syscalls+0xbc0>
ffffffffc0207f18:	d86f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207f1c <vfs_close>:
ffffffffc0207f1c:	1141                	addi	sp,sp,-16
ffffffffc0207f1e:	e406                	sd	ra,8(sp)
ffffffffc0207f20:	e022                	sd	s0,0(sp)
ffffffffc0207f22:	842a                	mv	s0,a0
ffffffffc0207f24:	8cdff0ef          	jal	ra,ffffffffc02077f0 <inode_open_dec>
ffffffffc0207f28:	8522                	mv	a0,s0
ffffffffc0207f2a:	81fff0ef          	jal	ra,ffffffffc0207748 <inode_ref_dec>
ffffffffc0207f2e:	60a2                	ld	ra,8(sp)
ffffffffc0207f30:	6402                	ld	s0,0(sp)
ffffffffc0207f32:	4501                	li	a0,0
ffffffffc0207f34:	0141                	addi	sp,sp,16
ffffffffc0207f36:	8082                	ret

ffffffffc0207f38 <get_device>:
ffffffffc0207f38:	7179                	addi	sp,sp,-48
ffffffffc0207f3a:	ec26                	sd	s1,24(sp)
ffffffffc0207f3c:	e84a                	sd	s2,16(sp)
ffffffffc0207f3e:	f406                	sd	ra,40(sp)
ffffffffc0207f40:	f022                	sd	s0,32(sp)
ffffffffc0207f42:	00054303          	lbu	t1,0(a0)
ffffffffc0207f46:	892e                	mv	s2,a1
ffffffffc0207f48:	84b2                	mv	s1,a2
ffffffffc0207f4a:	02030463          	beqz	t1,ffffffffc0207f72 <get_device+0x3a>
ffffffffc0207f4e:	00150413          	addi	s0,a0,1
ffffffffc0207f52:	86a2                	mv	a3,s0
ffffffffc0207f54:	879a                	mv	a5,t1
ffffffffc0207f56:	4701                	li	a4,0
ffffffffc0207f58:	03a00813          	li	a6,58
ffffffffc0207f5c:	02f00893          	li	a7,47
ffffffffc0207f60:	03078263          	beq	a5,a6,ffffffffc0207f84 <get_device+0x4c>
ffffffffc0207f64:	05178963          	beq	a5,a7,ffffffffc0207fb6 <get_device+0x7e>
ffffffffc0207f68:	0006c783          	lbu	a5,0(a3)
ffffffffc0207f6c:	2705                	addiw	a4,a4,1
ffffffffc0207f6e:	0685                	addi	a3,a3,1
ffffffffc0207f70:	fbe5                	bnez	a5,ffffffffc0207f60 <get_device+0x28>
ffffffffc0207f72:	7402                	ld	s0,32(sp)
ffffffffc0207f74:	00a93023          	sd	a0,0(s2)
ffffffffc0207f78:	70a2                	ld	ra,40(sp)
ffffffffc0207f7a:	6942                	ld	s2,16(sp)
ffffffffc0207f7c:	8526                	mv	a0,s1
ffffffffc0207f7e:	64e2                	ld	s1,24(sp)
ffffffffc0207f80:	6145                	addi	sp,sp,48
ffffffffc0207f82:	a279                	j	ffffffffc0208110 <vfs_get_curdir>
ffffffffc0207f84:	cb15                	beqz	a4,ffffffffc0207fb8 <get_device+0x80>
ffffffffc0207f86:	00e507b3          	add	a5,a0,a4
ffffffffc0207f8a:	0705                	addi	a4,a4,1
ffffffffc0207f8c:	00078023          	sb	zero,0(a5)
ffffffffc0207f90:	972a                	add	a4,a4,a0
ffffffffc0207f92:	02f00613          	li	a2,47
ffffffffc0207f96:	00074783          	lbu	a5,0(a4)
ffffffffc0207f9a:	86ba                	mv	a3,a4
ffffffffc0207f9c:	0705                	addi	a4,a4,1
ffffffffc0207f9e:	fec78ce3          	beq	a5,a2,ffffffffc0207f96 <get_device+0x5e>
ffffffffc0207fa2:	7402                	ld	s0,32(sp)
ffffffffc0207fa4:	70a2                	ld	ra,40(sp)
ffffffffc0207fa6:	00d93023          	sd	a3,0(s2)
ffffffffc0207faa:	85a6                	mv	a1,s1
ffffffffc0207fac:	6942                	ld	s2,16(sp)
ffffffffc0207fae:	64e2                	ld	s1,24(sp)
ffffffffc0207fb0:	6145                	addi	sp,sp,48
ffffffffc0207fb2:	ba9ff06f          	j	ffffffffc0207b5a <vfs_get_root>
ffffffffc0207fb6:	ff55                	bnez	a4,ffffffffc0207f72 <get_device+0x3a>
ffffffffc0207fb8:	02f00793          	li	a5,47
ffffffffc0207fbc:	04f30563          	beq	t1,a5,ffffffffc0208006 <get_device+0xce>
ffffffffc0207fc0:	03a00793          	li	a5,58
ffffffffc0207fc4:	06f31663          	bne	t1,a5,ffffffffc0208030 <get_device+0xf8>
ffffffffc0207fc8:	0028                	addi	a0,sp,8
ffffffffc0207fca:	146000ef          	jal	ra,ffffffffc0208110 <vfs_get_curdir>
ffffffffc0207fce:	e515                	bnez	a0,ffffffffc0207ffa <get_device+0xc2>
ffffffffc0207fd0:	67a2                	ld	a5,8(sp)
ffffffffc0207fd2:	77a8                	ld	a0,104(a5)
ffffffffc0207fd4:	cd15                	beqz	a0,ffffffffc0208010 <get_device+0xd8>
ffffffffc0207fd6:	617c                	ld	a5,192(a0)
ffffffffc0207fd8:	9782                	jalr	a5
ffffffffc0207fda:	87aa                	mv	a5,a0
ffffffffc0207fdc:	6522                	ld	a0,8(sp)
ffffffffc0207fde:	e09c                	sd	a5,0(s1)
ffffffffc0207fe0:	f68ff0ef          	jal	ra,ffffffffc0207748 <inode_ref_dec>
ffffffffc0207fe4:	02f00713          	li	a4,47
ffffffffc0207fe8:	a011                	j	ffffffffc0207fec <get_device+0xb4>
ffffffffc0207fea:	0405                	addi	s0,s0,1
ffffffffc0207fec:	00044783          	lbu	a5,0(s0)
ffffffffc0207ff0:	fee78de3          	beq	a5,a4,ffffffffc0207fea <get_device+0xb2>
ffffffffc0207ff4:	00893023          	sd	s0,0(s2)
ffffffffc0207ff8:	4501                	li	a0,0
ffffffffc0207ffa:	70a2                	ld	ra,40(sp)
ffffffffc0207ffc:	7402                	ld	s0,32(sp)
ffffffffc0207ffe:	64e2                	ld	s1,24(sp)
ffffffffc0208000:	6942                	ld	s2,16(sp)
ffffffffc0208002:	6145                	addi	sp,sp,48
ffffffffc0208004:	8082                	ret
ffffffffc0208006:	8526                	mv	a0,s1
ffffffffc0208008:	93fff0ef          	jal	ra,ffffffffc0207946 <vfs_get_bootfs>
ffffffffc020800c:	dd61                	beqz	a0,ffffffffc0207fe4 <get_device+0xac>
ffffffffc020800e:	b7f5                	j	ffffffffc0207ffa <get_device+0xc2>
ffffffffc0208010:	00006697          	auipc	a3,0x6
ffffffffc0208014:	36868693          	addi	a3,a3,872 # ffffffffc020e378 <syscalls+0xcd8>
ffffffffc0208018:	00003617          	auipc	a2,0x3
ffffffffc020801c:	66060613          	addi	a2,a2,1632 # ffffffffc020b678 <commands+0x210>
ffffffffc0208020:	03900593          	li	a1,57
ffffffffc0208024:	00006517          	auipc	a0,0x6
ffffffffc0208028:	33c50513          	addi	a0,a0,828 # ffffffffc020e360 <syscalls+0xcc0>
ffffffffc020802c:	c72f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208030:	00006697          	auipc	a3,0x6
ffffffffc0208034:	32068693          	addi	a3,a3,800 # ffffffffc020e350 <syscalls+0xcb0>
ffffffffc0208038:	00003617          	auipc	a2,0x3
ffffffffc020803c:	64060613          	addi	a2,a2,1600 # ffffffffc020b678 <commands+0x210>
ffffffffc0208040:	03300593          	li	a1,51
ffffffffc0208044:	00006517          	auipc	a0,0x6
ffffffffc0208048:	31c50513          	addi	a0,a0,796 # ffffffffc020e360 <syscalls+0xcc0>
ffffffffc020804c:	c52f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208050 <vfs_lookup>:
ffffffffc0208050:	7139                	addi	sp,sp,-64
ffffffffc0208052:	f426                	sd	s1,40(sp)
ffffffffc0208054:	0830                	addi	a2,sp,24
ffffffffc0208056:	84ae                	mv	s1,a1
ffffffffc0208058:	002c                	addi	a1,sp,8
ffffffffc020805a:	f822                	sd	s0,48(sp)
ffffffffc020805c:	fc06                	sd	ra,56(sp)
ffffffffc020805e:	f04a                	sd	s2,32(sp)
ffffffffc0208060:	e42a                	sd	a0,8(sp)
ffffffffc0208062:	ed7ff0ef          	jal	ra,ffffffffc0207f38 <get_device>
ffffffffc0208066:	842a                	mv	s0,a0
ffffffffc0208068:	ed1d                	bnez	a0,ffffffffc02080a6 <vfs_lookup+0x56>
ffffffffc020806a:	67a2                	ld	a5,8(sp)
ffffffffc020806c:	6962                	ld	s2,24(sp)
ffffffffc020806e:	0007c783          	lbu	a5,0(a5)
ffffffffc0208072:	c3a9                	beqz	a5,ffffffffc02080b4 <vfs_lookup+0x64>
ffffffffc0208074:	04090963          	beqz	s2,ffffffffc02080c6 <vfs_lookup+0x76>
ffffffffc0208078:	07093783          	ld	a5,112(s2)
ffffffffc020807c:	c7a9                	beqz	a5,ffffffffc02080c6 <vfs_lookup+0x76>
ffffffffc020807e:	7bbc                	ld	a5,112(a5)
ffffffffc0208080:	c3b9                	beqz	a5,ffffffffc02080c6 <vfs_lookup+0x76>
ffffffffc0208082:	854a                	mv	a0,s2
ffffffffc0208084:	00006597          	auipc	a1,0x6
ffffffffc0208088:	35c58593          	addi	a1,a1,860 # ffffffffc020e3e0 <syscalls+0xd40>
ffffffffc020808c:	e06ff0ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc0208090:	07093783          	ld	a5,112(s2)
ffffffffc0208094:	65a2                	ld	a1,8(sp)
ffffffffc0208096:	6562                	ld	a0,24(sp)
ffffffffc0208098:	7bbc                	ld	a5,112(a5)
ffffffffc020809a:	8626                	mv	a2,s1
ffffffffc020809c:	9782                	jalr	a5
ffffffffc020809e:	842a                	mv	s0,a0
ffffffffc02080a0:	6562                	ld	a0,24(sp)
ffffffffc02080a2:	ea6ff0ef          	jal	ra,ffffffffc0207748 <inode_ref_dec>
ffffffffc02080a6:	70e2                	ld	ra,56(sp)
ffffffffc02080a8:	8522                	mv	a0,s0
ffffffffc02080aa:	7442                	ld	s0,48(sp)
ffffffffc02080ac:	74a2                	ld	s1,40(sp)
ffffffffc02080ae:	7902                	ld	s2,32(sp)
ffffffffc02080b0:	6121                	addi	sp,sp,64
ffffffffc02080b2:	8082                	ret
ffffffffc02080b4:	70e2                	ld	ra,56(sp)
ffffffffc02080b6:	8522                	mv	a0,s0
ffffffffc02080b8:	7442                	ld	s0,48(sp)
ffffffffc02080ba:	0124b023          	sd	s2,0(s1)
ffffffffc02080be:	74a2                	ld	s1,40(sp)
ffffffffc02080c0:	7902                	ld	s2,32(sp)
ffffffffc02080c2:	6121                	addi	sp,sp,64
ffffffffc02080c4:	8082                	ret
ffffffffc02080c6:	00006697          	auipc	a3,0x6
ffffffffc02080ca:	2ca68693          	addi	a3,a3,714 # ffffffffc020e390 <syscalls+0xcf0>
ffffffffc02080ce:	00003617          	auipc	a2,0x3
ffffffffc02080d2:	5aa60613          	addi	a2,a2,1450 # ffffffffc020b678 <commands+0x210>
ffffffffc02080d6:	04f00593          	li	a1,79
ffffffffc02080da:	00006517          	auipc	a0,0x6
ffffffffc02080de:	28650513          	addi	a0,a0,646 # ffffffffc020e360 <syscalls+0xcc0>
ffffffffc02080e2:	bbcf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02080e6 <vfs_lookup_parent>:
ffffffffc02080e6:	7139                	addi	sp,sp,-64
ffffffffc02080e8:	f822                	sd	s0,48(sp)
ffffffffc02080ea:	f426                	sd	s1,40(sp)
ffffffffc02080ec:	842e                	mv	s0,a1
ffffffffc02080ee:	84b2                	mv	s1,a2
ffffffffc02080f0:	002c                	addi	a1,sp,8
ffffffffc02080f2:	0830                	addi	a2,sp,24
ffffffffc02080f4:	fc06                	sd	ra,56(sp)
ffffffffc02080f6:	e42a                	sd	a0,8(sp)
ffffffffc02080f8:	e41ff0ef          	jal	ra,ffffffffc0207f38 <get_device>
ffffffffc02080fc:	e509                	bnez	a0,ffffffffc0208106 <vfs_lookup_parent+0x20>
ffffffffc02080fe:	67a2                	ld	a5,8(sp)
ffffffffc0208100:	e09c                	sd	a5,0(s1)
ffffffffc0208102:	67e2                	ld	a5,24(sp)
ffffffffc0208104:	e01c                	sd	a5,0(s0)
ffffffffc0208106:	70e2                	ld	ra,56(sp)
ffffffffc0208108:	7442                	ld	s0,48(sp)
ffffffffc020810a:	74a2                	ld	s1,40(sp)
ffffffffc020810c:	6121                	addi	sp,sp,64
ffffffffc020810e:	8082                	ret

ffffffffc0208110 <vfs_get_curdir>:
ffffffffc0208110:	0008e797          	auipc	a5,0x8e
ffffffffc0208114:	7b07b783          	ld	a5,1968(a5) # ffffffffc02968c0 <current>
ffffffffc0208118:	1487b783          	ld	a5,328(a5)
ffffffffc020811c:	1101                	addi	sp,sp,-32
ffffffffc020811e:	e426                	sd	s1,8(sp)
ffffffffc0208120:	6384                	ld	s1,0(a5)
ffffffffc0208122:	ec06                	sd	ra,24(sp)
ffffffffc0208124:	e822                	sd	s0,16(sp)
ffffffffc0208126:	cc81                	beqz	s1,ffffffffc020813e <vfs_get_curdir+0x2e>
ffffffffc0208128:	842a                	mv	s0,a0
ffffffffc020812a:	8526                	mv	a0,s1
ffffffffc020812c:	d4eff0ef          	jal	ra,ffffffffc020767a <inode_ref_inc>
ffffffffc0208130:	4501                	li	a0,0
ffffffffc0208132:	e004                	sd	s1,0(s0)
ffffffffc0208134:	60e2                	ld	ra,24(sp)
ffffffffc0208136:	6442                	ld	s0,16(sp)
ffffffffc0208138:	64a2                	ld	s1,8(sp)
ffffffffc020813a:	6105                	addi	sp,sp,32
ffffffffc020813c:	8082                	ret
ffffffffc020813e:	5541                	li	a0,-16
ffffffffc0208140:	bfd5                	j	ffffffffc0208134 <vfs_get_curdir+0x24>

ffffffffc0208142 <vfs_set_curdir>:
ffffffffc0208142:	7139                	addi	sp,sp,-64
ffffffffc0208144:	f04a                	sd	s2,32(sp)
ffffffffc0208146:	0008e917          	auipc	s2,0x8e
ffffffffc020814a:	77a90913          	addi	s2,s2,1914 # ffffffffc02968c0 <current>
ffffffffc020814e:	00093783          	ld	a5,0(s2)
ffffffffc0208152:	f822                	sd	s0,48(sp)
ffffffffc0208154:	842a                	mv	s0,a0
ffffffffc0208156:	1487b503          	ld	a0,328(a5)
ffffffffc020815a:	ec4e                	sd	s3,24(sp)
ffffffffc020815c:	fc06                	sd	ra,56(sp)
ffffffffc020815e:	f426                	sd	s1,40(sp)
ffffffffc0208160:	840fd0ef          	jal	ra,ffffffffc02051a0 <lock_files>
ffffffffc0208164:	00093783          	ld	a5,0(s2)
ffffffffc0208168:	1487b503          	ld	a0,328(a5)
ffffffffc020816c:	00053983          	ld	s3,0(a0)
ffffffffc0208170:	07340963          	beq	s0,s3,ffffffffc02081e2 <vfs_set_curdir+0xa0>
ffffffffc0208174:	cc39                	beqz	s0,ffffffffc02081d2 <vfs_set_curdir+0x90>
ffffffffc0208176:	783c                	ld	a5,112(s0)
ffffffffc0208178:	c7bd                	beqz	a5,ffffffffc02081e6 <vfs_set_curdir+0xa4>
ffffffffc020817a:	6bbc                	ld	a5,80(a5)
ffffffffc020817c:	c7ad                	beqz	a5,ffffffffc02081e6 <vfs_set_curdir+0xa4>
ffffffffc020817e:	00006597          	auipc	a1,0x6
ffffffffc0208182:	2d258593          	addi	a1,a1,722 # ffffffffc020e450 <syscalls+0xdb0>
ffffffffc0208186:	8522                	mv	a0,s0
ffffffffc0208188:	d0aff0ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc020818c:	783c                	ld	a5,112(s0)
ffffffffc020818e:	006c                	addi	a1,sp,12
ffffffffc0208190:	8522                	mv	a0,s0
ffffffffc0208192:	6bbc                	ld	a5,80(a5)
ffffffffc0208194:	9782                	jalr	a5
ffffffffc0208196:	84aa                	mv	s1,a0
ffffffffc0208198:	e901                	bnez	a0,ffffffffc02081a8 <vfs_set_curdir+0x66>
ffffffffc020819a:	47b2                	lw	a5,12(sp)
ffffffffc020819c:	669d                	lui	a3,0x7
ffffffffc020819e:	6709                	lui	a4,0x2
ffffffffc02081a0:	8ff5                	and	a5,a5,a3
ffffffffc02081a2:	54b9                	li	s1,-18
ffffffffc02081a4:	02e78063          	beq	a5,a4,ffffffffc02081c4 <vfs_set_curdir+0x82>
ffffffffc02081a8:	00093783          	ld	a5,0(s2)
ffffffffc02081ac:	1487b503          	ld	a0,328(a5)
ffffffffc02081b0:	ff7fc0ef          	jal	ra,ffffffffc02051a6 <unlock_files>
ffffffffc02081b4:	70e2                	ld	ra,56(sp)
ffffffffc02081b6:	7442                	ld	s0,48(sp)
ffffffffc02081b8:	7902                	ld	s2,32(sp)
ffffffffc02081ba:	69e2                	ld	s3,24(sp)
ffffffffc02081bc:	8526                	mv	a0,s1
ffffffffc02081be:	74a2                	ld	s1,40(sp)
ffffffffc02081c0:	6121                	addi	sp,sp,64
ffffffffc02081c2:	8082                	ret
ffffffffc02081c4:	8522                	mv	a0,s0
ffffffffc02081c6:	cb4ff0ef          	jal	ra,ffffffffc020767a <inode_ref_inc>
ffffffffc02081ca:	00093783          	ld	a5,0(s2)
ffffffffc02081ce:	1487b503          	ld	a0,328(a5)
ffffffffc02081d2:	e100                	sd	s0,0(a0)
ffffffffc02081d4:	4481                	li	s1,0
ffffffffc02081d6:	fc098de3          	beqz	s3,ffffffffc02081b0 <vfs_set_curdir+0x6e>
ffffffffc02081da:	854e                	mv	a0,s3
ffffffffc02081dc:	d6cff0ef          	jal	ra,ffffffffc0207748 <inode_ref_dec>
ffffffffc02081e0:	b7e1                	j	ffffffffc02081a8 <vfs_set_curdir+0x66>
ffffffffc02081e2:	4481                	li	s1,0
ffffffffc02081e4:	b7f1                	j	ffffffffc02081b0 <vfs_set_curdir+0x6e>
ffffffffc02081e6:	00006697          	auipc	a3,0x6
ffffffffc02081ea:	20268693          	addi	a3,a3,514 # ffffffffc020e3e8 <syscalls+0xd48>
ffffffffc02081ee:	00003617          	auipc	a2,0x3
ffffffffc02081f2:	48a60613          	addi	a2,a2,1162 # ffffffffc020b678 <commands+0x210>
ffffffffc02081f6:	04300593          	li	a1,67
ffffffffc02081fa:	00006517          	auipc	a0,0x6
ffffffffc02081fe:	23e50513          	addi	a0,a0,574 # ffffffffc020e438 <syscalls+0xd98>
ffffffffc0208202:	a9cf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208206 <vfs_chdir>:
ffffffffc0208206:	1101                	addi	sp,sp,-32
ffffffffc0208208:	002c                	addi	a1,sp,8
ffffffffc020820a:	e822                	sd	s0,16(sp)
ffffffffc020820c:	ec06                	sd	ra,24(sp)
ffffffffc020820e:	e43ff0ef          	jal	ra,ffffffffc0208050 <vfs_lookup>
ffffffffc0208212:	842a                	mv	s0,a0
ffffffffc0208214:	c511                	beqz	a0,ffffffffc0208220 <vfs_chdir+0x1a>
ffffffffc0208216:	60e2                	ld	ra,24(sp)
ffffffffc0208218:	8522                	mv	a0,s0
ffffffffc020821a:	6442                	ld	s0,16(sp)
ffffffffc020821c:	6105                	addi	sp,sp,32
ffffffffc020821e:	8082                	ret
ffffffffc0208220:	6522                	ld	a0,8(sp)
ffffffffc0208222:	f21ff0ef          	jal	ra,ffffffffc0208142 <vfs_set_curdir>
ffffffffc0208226:	842a                	mv	s0,a0
ffffffffc0208228:	6522                	ld	a0,8(sp)
ffffffffc020822a:	d1eff0ef          	jal	ra,ffffffffc0207748 <inode_ref_dec>
ffffffffc020822e:	60e2                	ld	ra,24(sp)
ffffffffc0208230:	8522                	mv	a0,s0
ffffffffc0208232:	6442                	ld	s0,16(sp)
ffffffffc0208234:	6105                	addi	sp,sp,32
ffffffffc0208236:	8082                	ret

ffffffffc0208238 <vfs_getcwd>:
ffffffffc0208238:	0008e797          	auipc	a5,0x8e
ffffffffc020823c:	6887b783          	ld	a5,1672(a5) # ffffffffc02968c0 <current>
ffffffffc0208240:	1487b783          	ld	a5,328(a5)
ffffffffc0208244:	7179                	addi	sp,sp,-48
ffffffffc0208246:	ec26                	sd	s1,24(sp)
ffffffffc0208248:	6384                	ld	s1,0(a5)
ffffffffc020824a:	f406                	sd	ra,40(sp)
ffffffffc020824c:	f022                	sd	s0,32(sp)
ffffffffc020824e:	e84a                	sd	s2,16(sp)
ffffffffc0208250:	ccbd                	beqz	s1,ffffffffc02082ce <vfs_getcwd+0x96>
ffffffffc0208252:	892a                	mv	s2,a0
ffffffffc0208254:	8526                	mv	a0,s1
ffffffffc0208256:	c24ff0ef          	jal	ra,ffffffffc020767a <inode_ref_inc>
ffffffffc020825a:	74a8                	ld	a0,104(s1)
ffffffffc020825c:	c93d                	beqz	a0,ffffffffc02082d2 <vfs_getcwd+0x9a>
ffffffffc020825e:	9b3ff0ef          	jal	ra,ffffffffc0207c10 <vfs_get_devname>
ffffffffc0208262:	842a                	mv	s0,a0
ffffffffc0208264:	68f020ef          	jal	ra,ffffffffc020b0f2 <strlen>
ffffffffc0208268:	862a                	mv	a2,a0
ffffffffc020826a:	85a2                	mv	a1,s0
ffffffffc020826c:	4701                	li	a4,0
ffffffffc020826e:	4685                	li	a3,1
ffffffffc0208270:	854a                	mv	a0,s2
ffffffffc0208272:	958fd0ef          	jal	ra,ffffffffc02053ca <iobuf_move>
ffffffffc0208276:	842a                	mv	s0,a0
ffffffffc0208278:	c919                	beqz	a0,ffffffffc020828e <vfs_getcwd+0x56>
ffffffffc020827a:	8526                	mv	a0,s1
ffffffffc020827c:	cccff0ef          	jal	ra,ffffffffc0207748 <inode_ref_dec>
ffffffffc0208280:	70a2                	ld	ra,40(sp)
ffffffffc0208282:	8522                	mv	a0,s0
ffffffffc0208284:	7402                	ld	s0,32(sp)
ffffffffc0208286:	64e2                	ld	s1,24(sp)
ffffffffc0208288:	6942                	ld	s2,16(sp)
ffffffffc020828a:	6145                	addi	sp,sp,48
ffffffffc020828c:	8082                	ret
ffffffffc020828e:	03a00793          	li	a5,58
ffffffffc0208292:	4701                	li	a4,0
ffffffffc0208294:	4685                	li	a3,1
ffffffffc0208296:	4605                	li	a2,1
ffffffffc0208298:	00f10593          	addi	a1,sp,15
ffffffffc020829c:	854a                	mv	a0,s2
ffffffffc020829e:	00f107a3          	sb	a5,15(sp)
ffffffffc02082a2:	928fd0ef          	jal	ra,ffffffffc02053ca <iobuf_move>
ffffffffc02082a6:	842a                	mv	s0,a0
ffffffffc02082a8:	f969                	bnez	a0,ffffffffc020827a <vfs_getcwd+0x42>
ffffffffc02082aa:	78bc                	ld	a5,112(s1)
ffffffffc02082ac:	c3b9                	beqz	a5,ffffffffc02082f2 <vfs_getcwd+0xba>
ffffffffc02082ae:	7f9c                	ld	a5,56(a5)
ffffffffc02082b0:	c3a9                	beqz	a5,ffffffffc02082f2 <vfs_getcwd+0xba>
ffffffffc02082b2:	00006597          	auipc	a1,0x6
ffffffffc02082b6:	1fe58593          	addi	a1,a1,510 # ffffffffc020e4b0 <syscalls+0xe10>
ffffffffc02082ba:	8526                	mv	a0,s1
ffffffffc02082bc:	bd6ff0ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc02082c0:	78bc                	ld	a5,112(s1)
ffffffffc02082c2:	85ca                	mv	a1,s2
ffffffffc02082c4:	8526                	mv	a0,s1
ffffffffc02082c6:	7f9c                	ld	a5,56(a5)
ffffffffc02082c8:	9782                	jalr	a5
ffffffffc02082ca:	842a                	mv	s0,a0
ffffffffc02082cc:	b77d                	j	ffffffffc020827a <vfs_getcwd+0x42>
ffffffffc02082ce:	5441                	li	s0,-16
ffffffffc02082d0:	bf45                	j	ffffffffc0208280 <vfs_getcwd+0x48>
ffffffffc02082d2:	00006697          	auipc	a3,0x6
ffffffffc02082d6:	0a668693          	addi	a3,a3,166 # ffffffffc020e378 <syscalls+0xcd8>
ffffffffc02082da:	00003617          	auipc	a2,0x3
ffffffffc02082de:	39e60613          	addi	a2,a2,926 # ffffffffc020b678 <commands+0x210>
ffffffffc02082e2:	06e00593          	li	a1,110
ffffffffc02082e6:	00006517          	auipc	a0,0x6
ffffffffc02082ea:	15250513          	addi	a0,a0,338 # ffffffffc020e438 <syscalls+0xd98>
ffffffffc02082ee:	9b0f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02082f2:	00006697          	auipc	a3,0x6
ffffffffc02082f6:	16668693          	addi	a3,a3,358 # ffffffffc020e458 <syscalls+0xdb8>
ffffffffc02082fa:	00003617          	auipc	a2,0x3
ffffffffc02082fe:	37e60613          	addi	a2,a2,894 # ffffffffc020b678 <commands+0x210>
ffffffffc0208302:	07800593          	li	a1,120
ffffffffc0208306:	00006517          	auipc	a0,0x6
ffffffffc020830a:	13250513          	addi	a0,a0,306 # ffffffffc020e438 <syscalls+0xd98>
ffffffffc020830e:	990f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208312 <dev_lookup>:
ffffffffc0208312:	0005c783          	lbu	a5,0(a1)
ffffffffc0208316:	e385                	bnez	a5,ffffffffc0208336 <dev_lookup+0x24>
ffffffffc0208318:	1101                	addi	sp,sp,-32
ffffffffc020831a:	e822                	sd	s0,16(sp)
ffffffffc020831c:	e426                	sd	s1,8(sp)
ffffffffc020831e:	ec06                	sd	ra,24(sp)
ffffffffc0208320:	84aa                	mv	s1,a0
ffffffffc0208322:	8432                	mv	s0,a2
ffffffffc0208324:	b56ff0ef          	jal	ra,ffffffffc020767a <inode_ref_inc>
ffffffffc0208328:	60e2                	ld	ra,24(sp)
ffffffffc020832a:	e004                	sd	s1,0(s0)
ffffffffc020832c:	6442                	ld	s0,16(sp)
ffffffffc020832e:	64a2                	ld	s1,8(sp)
ffffffffc0208330:	4501                	li	a0,0
ffffffffc0208332:	6105                	addi	sp,sp,32
ffffffffc0208334:	8082                	ret
ffffffffc0208336:	5541                	li	a0,-16
ffffffffc0208338:	8082                	ret

ffffffffc020833a <dev_fstat>:
ffffffffc020833a:	1101                	addi	sp,sp,-32
ffffffffc020833c:	e426                	sd	s1,8(sp)
ffffffffc020833e:	84ae                	mv	s1,a1
ffffffffc0208340:	e822                	sd	s0,16(sp)
ffffffffc0208342:	02000613          	li	a2,32
ffffffffc0208346:	842a                	mv	s0,a0
ffffffffc0208348:	4581                	li	a1,0
ffffffffc020834a:	8526                	mv	a0,s1
ffffffffc020834c:	ec06                	sd	ra,24(sp)
ffffffffc020834e:	647020ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc0208352:	c429                	beqz	s0,ffffffffc020839c <dev_fstat+0x62>
ffffffffc0208354:	783c                	ld	a5,112(s0)
ffffffffc0208356:	c3b9                	beqz	a5,ffffffffc020839c <dev_fstat+0x62>
ffffffffc0208358:	6bbc                	ld	a5,80(a5)
ffffffffc020835a:	c3a9                	beqz	a5,ffffffffc020839c <dev_fstat+0x62>
ffffffffc020835c:	00006597          	auipc	a1,0x6
ffffffffc0208360:	0f458593          	addi	a1,a1,244 # ffffffffc020e450 <syscalls+0xdb0>
ffffffffc0208364:	8522                	mv	a0,s0
ffffffffc0208366:	b2cff0ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc020836a:	783c                	ld	a5,112(s0)
ffffffffc020836c:	85a6                	mv	a1,s1
ffffffffc020836e:	8522                	mv	a0,s0
ffffffffc0208370:	6bbc                	ld	a5,80(a5)
ffffffffc0208372:	9782                	jalr	a5
ffffffffc0208374:	ed19                	bnez	a0,ffffffffc0208392 <dev_fstat+0x58>
ffffffffc0208376:	4c38                	lw	a4,88(s0)
ffffffffc0208378:	6785                	lui	a5,0x1
ffffffffc020837a:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020837e:	02f71f63          	bne	a4,a5,ffffffffc02083bc <dev_fstat+0x82>
ffffffffc0208382:	6018                	ld	a4,0(s0)
ffffffffc0208384:	641c                	ld	a5,8(s0)
ffffffffc0208386:	4685                	li	a3,1
ffffffffc0208388:	e494                	sd	a3,8(s1)
ffffffffc020838a:	02e787b3          	mul	a5,a5,a4
ffffffffc020838e:	e898                	sd	a4,16(s1)
ffffffffc0208390:	ec9c                	sd	a5,24(s1)
ffffffffc0208392:	60e2                	ld	ra,24(sp)
ffffffffc0208394:	6442                	ld	s0,16(sp)
ffffffffc0208396:	64a2                	ld	s1,8(sp)
ffffffffc0208398:	6105                	addi	sp,sp,32
ffffffffc020839a:	8082                	ret
ffffffffc020839c:	00006697          	auipc	a3,0x6
ffffffffc02083a0:	04c68693          	addi	a3,a3,76 # ffffffffc020e3e8 <syscalls+0xd48>
ffffffffc02083a4:	00003617          	auipc	a2,0x3
ffffffffc02083a8:	2d460613          	addi	a2,a2,724 # ffffffffc020b678 <commands+0x210>
ffffffffc02083ac:	04200593          	li	a1,66
ffffffffc02083b0:	00006517          	auipc	a0,0x6
ffffffffc02083b4:	11050513          	addi	a0,a0,272 # ffffffffc020e4c0 <syscalls+0xe20>
ffffffffc02083b8:	8e6f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02083bc:	00006697          	auipc	a3,0x6
ffffffffc02083c0:	df468693          	addi	a3,a3,-524 # ffffffffc020e1b0 <syscalls+0xb10>
ffffffffc02083c4:	00003617          	auipc	a2,0x3
ffffffffc02083c8:	2b460613          	addi	a2,a2,692 # ffffffffc020b678 <commands+0x210>
ffffffffc02083cc:	04500593          	li	a1,69
ffffffffc02083d0:	00006517          	auipc	a0,0x6
ffffffffc02083d4:	0f050513          	addi	a0,a0,240 # ffffffffc020e4c0 <syscalls+0xe20>
ffffffffc02083d8:	8c6f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02083dc <dev_ioctl>:
ffffffffc02083dc:	c909                	beqz	a0,ffffffffc02083ee <dev_ioctl+0x12>
ffffffffc02083de:	4d34                	lw	a3,88(a0)
ffffffffc02083e0:	6705                	lui	a4,0x1
ffffffffc02083e2:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02083e6:	00e69463          	bne	a3,a4,ffffffffc02083ee <dev_ioctl+0x12>
ffffffffc02083ea:	751c                	ld	a5,40(a0)
ffffffffc02083ec:	8782                	jr	a5
ffffffffc02083ee:	1141                	addi	sp,sp,-16
ffffffffc02083f0:	00006697          	auipc	a3,0x6
ffffffffc02083f4:	dc068693          	addi	a3,a3,-576 # ffffffffc020e1b0 <syscalls+0xb10>
ffffffffc02083f8:	00003617          	auipc	a2,0x3
ffffffffc02083fc:	28060613          	addi	a2,a2,640 # ffffffffc020b678 <commands+0x210>
ffffffffc0208400:	03500593          	li	a1,53
ffffffffc0208404:	00006517          	auipc	a0,0x6
ffffffffc0208408:	0bc50513          	addi	a0,a0,188 # ffffffffc020e4c0 <syscalls+0xe20>
ffffffffc020840c:	e406                	sd	ra,8(sp)
ffffffffc020840e:	890f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208412 <dev_tryseek>:
ffffffffc0208412:	c51d                	beqz	a0,ffffffffc0208440 <dev_tryseek+0x2e>
ffffffffc0208414:	4d38                	lw	a4,88(a0)
ffffffffc0208416:	6785                	lui	a5,0x1
ffffffffc0208418:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020841c:	02f71263          	bne	a4,a5,ffffffffc0208440 <dev_tryseek+0x2e>
ffffffffc0208420:	611c                	ld	a5,0(a0)
ffffffffc0208422:	cf89                	beqz	a5,ffffffffc020843c <dev_tryseek+0x2a>
ffffffffc0208424:	6518                	ld	a4,8(a0)
ffffffffc0208426:	02e5f6b3          	remu	a3,a1,a4
ffffffffc020842a:	ea89                	bnez	a3,ffffffffc020843c <dev_tryseek+0x2a>
ffffffffc020842c:	0005c863          	bltz	a1,ffffffffc020843c <dev_tryseek+0x2a>
ffffffffc0208430:	02e787b3          	mul	a5,a5,a4
ffffffffc0208434:	00f5f463          	bgeu	a1,a5,ffffffffc020843c <dev_tryseek+0x2a>
ffffffffc0208438:	4501                	li	a0,0
ffffffffc020843a:	8082                	ret
ffffffffc020843c:	5575                	li	a0,-3
ffffffffc020843e:	8082                	ret
ffffffffc0208440:	1141                	addi	sp,sp,-16
ffffffffc0208442:	00006697          	auipc	a3,0x6
ffffffffc0208446:	d6e68693          	addi	a3,a3,-658 # ffffffffc020e1b0 <syscalls+0xb10>
ffffffffc020844a:	00003617          	auipc	a2,0x3
ffffffffc020844e:	22e60613          	addi	a2,a2,558 # ffffffffc020b678 <commands+0x210>
ffffffffc0208452:	05f00593          	li	a1,95
ffffffffc0208456:	00006517          	auipc	a0,0x6
ffffffffc020845a:	06a50513          	addi	a0,a0,106 # ffffffffc020e4c0 <syscalls+0xe20>
ffffffffc020845e:	e406                	sd	ra,8(sp)
ffffffffc0208460:	83ef80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208464 <dev_gettype>:
ffffffffc0208464:	c10d                	beqz	a0,ffffffffc0208486 <dev_gettype+0x22>
ffffffffc0208466:	4d38                	lw	a4,88(a0)
ffffffffc0208468:	6785                	lui	a5,0x1
ffffffffc020846a:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020846e:	00f71c63          	bne	a4,a5,ffffffffc0208486 <dev_gettype+0x22>
ffffffffc0208472:	6118                	ld	a4,0(a0)
ffffffffc0208474:	6795                	lui	a5,0x5
ffffffffc0208476:	c701                	beqz	a4,ffffffffc020847e <dev_gettype+0x1a>
ffffffffc0208478:	c19c                	sw	a5,0(a1)
ffffffffc020847a:	4501                	li	a0,0
ffffffffc020847c:	8082                	ret
ffffffffc020847e:	6791                	lui	a5,0x4
ffffffffc0208480:	c19c                	sw	a5,0(a1)
ffffffffc0208482:	4501                	li	a0,0
ffffffffc0208484:	8082                	ret
ffffffffc0208486:	1141                	addi	sp,sp,-16
ffffffffc0208488:	00006697          	auipc	a3,0x6
ffffffffc020848c:	d2868693          	addi	a3,a3,-728 # ffffffffc020e1b0 <syscalls+0xb10>
ffffffffc0208490:	00003617          	auipc	a2,0x3
ffffffffc0208494:	1e860613          	addi	a2,a2,488 # ffffffffc020b678 <commands+0x210>
ffffffffc0208498:	05300593          	li	a1,83
ffffffffc020849c:	00006517          	auipc	a0,0x6
ffffffffc02084a0:	02450513          	addi	a0,a0,36 # ffffffffc020e4c0 <syscalls+0xe20>
ffffffffc02084a4:	e406                	sd	ra,8(sp)
ffffffffc02084a6:	ff9f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02084aa <dev_write>:
ffffffffc02084aa:	c911                	beqz	a0,ffffffffc02084be <dev_write+0x14>
ffffffffc02084ac:	4d34                	lw	a3,88(a0)
ffffffffc02084ae:	6705                	lui	a4,0x1
ffffffffc02084b0:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02084b4:	00e69563          	bne	a3,a4,ffffffffc02084be <dev_write+0x14>
ffffffffc02084b8:	711c                	ld	a5,32(a0)
ffffffffc02084ba:	4605                	li	a2,1
ffffffffc02084bc:	8782                	jr	a5
ffffffffc02084be:	1141                	addi	sp,sp,-16
ffffffffc02084c0:	00006697          	auipc	a3,0x6
ffffffffc02084c4:	cf068693          	addi	a3,a3,-784 # ffffffffc020e1b0 <syscalls+0xb10>
ffffffffc02084c8:	00003617          	auipc	a2,0x3
ffffffffc02084cc:	1b060613          	addi	a2,a2,432 # ffffffffc020b678 <commands+0x210>
ffffffffc02084d0:	02c00593          	li	a1,44
ffffffffc02084d4:	00006517          	auipc	a0,0x6
ffffffffc02084d8:	fec50513          	addi	a0,a0,-20 # ffffffffc020e4c0 <syscalls+0xe20>
ffffffffc02084dc:	e406                	sd	ra,8(sp)
ffffffffc02084de:	fc1f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02084e2 <dev_read>:
ffffffffc02084e2:	c911                	beqz	a0,ffffffffc02084f6 <dev_read+0x14>
ffffffffc02084e4:	4d34                	lw	a3,88(a0)
ffffffffc02084e6:	6705                	lui	a4,0x1
ffffffffc02084e8:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02084ec:	00e69563          	bne	a3,a4,ffffffffc02084f6 <dev_read+0x14>
ffffffffc02084f0:	711c                	ld	a5,32(a0)
ffffffffc02084f2:	4601                	li	a2,0
ffffffffc02084f4:	8782                	jr	a5
ffffffffc02084f6:	1141                	addi	sp,sp,-16
ffffffffc02084f8:	00006697          	auipc	a3,0x6
ffffffffc02084fc:	cb868693          	addi	a3,a3,-840 # ffffffffc020e1b0 <syscalls+0xb10>
ffffffffc0208500:	00003617          	auipc	a2,0x3
ffffffffc0208504:	17860613          	addi	a2,a2,376 # ffffffffc020b678 <commands+0x210>
ffffffffc0208508:	02300593          	li	a1,35
ffffffffc020850c:	00006517          	auipc	a0,0x6
ffffffffc0208510:	fb450513          	addi	a0,a0,-76 # ffffffffc020e4c0 <syscalls+0xe20>
ffffffffc0208514:	e406                	sd	ra,8(sp)
ffffffffc0208516:	f89f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020851a <dev_close>:
ffffffffc020851a:	c909                	beqz	a0,ffffffffc020852c <dev_close+0x12>
ffffffffc020851c:	4d34                	lw	a3,88(a0)
ffffffffc020851e:	6705                	lui	a4,0x1
ffffffffc0208520:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208524:	00e69463          	bne	a3,a4,ffffffffc020852c <dev_close+0x12>
ffffffffc0208528:	6d1c                	ld	a5,24(a0)
ffffffffc020852a:	8782                	jr	a5
ffffffffc020852c:	1141                	addi	sp,sp,-16
ffffffffc020852e:	00006697          	auipc	a3,0x6
ffffffffc0208532:	c8268693          	addi	a3,a3,-894 # ffffffffc020e1b0 <syscalls+0xb10>
ffffffffc0208536:	00003617          	auipc	a2,0x3
ffffffffc020853a:	14260613          	addi	a2,a2,322 # ffffffffc020b678 <commands+0x210>
ffffffffc020853e:	45e9                	li	a1,26
ffffffffc0208540:	00006517          	auipc	a0,0x6
ffffffffc0208544:	f8050513          	addi	a0,a0,-128 # ffffffffc020e4c0 <syscalls+0xe20>
ffffffffc0208548:	e406                	sd	ra,8(sp)
ffffffffc020854a:	f55f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020854e <dev_open>:
ffffffffc020854e:	03c5f713          	andi	a4,a1,60
ffffffffc0208552:	eb11                	bnez	a4,ffffffffc0208566 <dev_open+0x18>
ffffffffc0208554:	c919                	beqz	a0,ffffffffc020856a <dev_open+0x1c>
ffffffffc0208556:	4d34                	lw	a3,88(a0)
ffffffffc0208558:	6705                	lui	a4,0x1
ffffffffc020855a:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020855e:	00e69663          	bne	a3,a4,ffffffffc020856a <dev_open+0x1c>
ffffffffc0208562:	691c                	ld	a5,16(a0)
ffffffffc0208564:	8782                	jr	a5
ffffffffc0208566:	5575                	li	a0,-3
ffffffffc0208568:	8082                	ret
ffffffffc020856a:	1141                	addi	sp,sp,-16
ffffffffc020856c:	00006697          	auipc	a3,0x6
ffffffffc0208570:	c4468693          	addi	a3,a3,-956 # ffffffffc020e1b0 <syscalls+0xb10>
ffffffffc0208574:	00003617          	auipc	a2,0x3
ffffffffc0208578:	10460613          	addi	a2,a2,260 # ffffffffc020b678 <commands+0x210>
ffffffffc020857c:	45c5                	li	a1,17
ffffffffc020857e:	00006517          	auipc	a0,0x6
ffffffffc0208582:	f4250513          	addi	a0,a0,-190 # ffffffffc020e4c0 <syscalls+0xe20>
ffffffffc0208586:	e406                	sd	ra,8(sp)
ffffffffc0208588:	f17f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020858c <dev_init>:
ffffffffc020858c:	1141                	addi	sp,sp,-16
ffffffffc020858e:	e406                	sd	ra,8(sp)
ffffffffc0208590:	542000ef          	jal	ra,ffffffffc0208ad2 <dev_init_stdin>
ffffffffc0208594:	65a000ef          	jal	ra,ffffffffc0208bee <dev_init_stdout>
ffffffffc0208598:	60a2                	ld	ra,8(sp)
ffffffffc020859a:	0141                	addi	sp,sp,16
ffffffffc020859c:	a439                	j	ffffffffc02087aa <dev_init_disk0>

ffffffffc020859e <dev_create_inode>:
ffffffffc020859e:	6505                	lui	a0,0x1
ffffffffc02085a0:	1141                	addi	sp,sp,-16
ffffffffc02085a2:	23450513          	addi	a0,a0,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02085a6:	e022                	sd	s0,0(sp)
ffffffffc02085a8:	e406                	sd	ra,8(sp)
ffffffffc02085aa:	852ff0ef          	jal	ra,ffffffffc02075fc <__alloc_inode>
ffffffffc02085ae:	842a                	mv	s0,a0
ffffffffc02085b0:	c901                	beqz	a0,ffffffffc02085c0 <dev_create_inode+0x22>
ffffffffc02085b2:	4601                	li	a2,0
ffffffffc02085b4:	00006597          	auipc	a1,0x6
ffffffffc02085b8:	f2458593          	addi	a1,a1,-220 # ffffffffc020e4d8 <dev_node_ops>
ffffffffc02085bc:	85cff0ef          	jal	ra,ffffffffc0207618 <inode_init>
ffffffffc02085c0:	60a2                	ld	ra,8(sp)
ffffffffc02085c2:	8522                	mv	a0,s0
ffffffffc02085c4:	6402                	ld	s0,0(sp)
ffffffffc02085c6:	0141                	addi	sp,sp,16
ffffffffc02085c8:	8082                	ret

ffffffffc02085ca <disk0_open>:
ffffffffc02085ca:	4501                	li	a0,0
ffffffffc02085cc:	8082                	ret

ffffffffc02085ce <disk0_close>:
ffffffffc02085ce:	4501                	li	a0,0
ffffffffc02085d0:	8082                	ret

ffffffffc02085d2 <disk0_ioctl>:
ffffffffc02085d2:	5531                	li	a0,-20
ffffffffc02085d4:	8082                	ret

ffffffffc02085d6 <disk0_io>:
ffffffffc02085d6:	659c                	ld	a5,8(a1)
ffffffffc02085d8:	7159                	addi	sp,sp,-112
ffffffffc02085da:	eca6                	sd	s1,88(sp)
ffffffffc02085dc:	f45e                	sd	s7,40(sp)
ffffffffc02085de:	6d84                	ld	s1,24(a1)
ffffffffc02085e0:	6b85                	lui	s7,0x1
ffffffffc02085e2:	1bfd                	addi	s7,s7,-1
ffffffffc02085e4:	e4ce                	sd	s3,72(sp)
ffffffffc02085e6:	43f7d993          	srai	s3,a5,0x3f
ffffffffc02085ea:	0179f9b3          	and	s3,s3,s7
ffffffffc02085ee:	99be                	add	s3,s3,a5
ffffffffc02085f0:	8fc5                	or	a5,a5,s1
ffffffffc02085f2:	f486                	sd	ra,104(sp)
ffffffffc02085f4:	f0a2                	sd	s0,96(sp)
ffffffffc02085f6:	e8ca                	sd	s2,80(sp)
ffffffffc02085f8:	e0d2                	sd	s4,64(sp)
ffffffffc02085fa:	fc56                	sd	s5,56(sp)
ffffffffc02085fc:	f85a                	sd	s6,48(sp)
ffffffffc02085fe:	f062                	sd	s8,32(sp)
ffffffffc0208600:	ec66                	sd	s9,24(sp)
ffffffffc0208602:	e86a                	sd	s10,16(sp)
ffffffffc0208604:	0177f7b3          	and	a5,a5,s7
ffffffffc0208608:	10079d63          	bnez	a5,ffffffffc0208722 <disk0_io+0x14c>
ffffffffc020860c:	40c9d993          	srai	s3,s3,0xc
ffffffffc0208610:	00c4d713          	srli	a4,s1,0xc
ffffffffc0208614:	2981                	sext.w	s3,s3
ffffffffc0208616:	2701                	sext.w	a4,a4
ffffffffc0208618:	00e987bb          	addw	a5,s3,a4
ffffffffc020861c:	6114                	ld	a3,0(a0)
ffffffffc020861e:	1782                	slli	a5,a5,0x20
ffffffffc0208620:	9381                	srli	a5,a5,0x20
ffffffffc0208622:	10f6e063          	bltu	a3,a5,ffffffffc0208722 <disk0_io+0x14c>
ffffffffc0208626:	4501                	li	a0,0
ffffffffc0208628:	ef19                	bnez	a4,ffffffffc0208646 <disk0_io+0x70>
ffffffffc020862a:	70a6                	ld	ra,104(sp)
ffffffffc020862c:	7406                	ld	s0,96(sp)
ffffffffc020862e:	64e6                	ld	s1,88(sp)
ffffffffc0208630:	6946                	ld	s2,80(sp)
ffffffffc0208632:	69a6                	ld	s3,72(sp)
ffffffffc0208634:	6a06                	ld	s4,64(sp)
ffffffffc0208636:	7ae2                	ld	s5,56(sp)
ffffffffc0208638:	7b42                	ld	s6,48(sp)
ffffffffc020863a:	7ba2                	ld	s7,40(sp)
ffffffffc020863c:	7c02                	ld	s8,32(sp)
ffffffffc020863e:	6ce2                	ld	s9,24(sp)
ffffffffc0208640:	6d42                	ld	s10,16(sp)
ffffffffc0208642:	6165                	addi	sp,sp,112
ffffffffc0208644:	8082                	ret
ffffffffc0208646:	0008d517          	auipc	a0,0x8d
ffffffffc020864a:	1fa50513          	addi	a0,a0,506 # ffffffffc0295840 <disk0_sem>
ffffffffc020864e:	8b2e                	mv	s6,a1
ffffffffc0208650:	8c32                	mv	s8,a2
ffffffffc0208652:	0008ea97          	auipc	s5,0x8e
ffffffffc0208656:	2a6a8a93          	addi	s5,s5,678 # ffffffffc02968f8 <disk0_buffer>
ffffffffc020865a:	ee9fb0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc020865e:	6c91                	lui	s9,0x4
ffffffffc0208660:	e4b9                	bnez	s1,ffffffffc02086ae <disk0_io+0xd8>
ffffffffc0208662:	a845                	j	ffffffffc0208712 <disk0_io+0x13c>
ffffffffc0208664:	00c4d413          	srli	s0,s1,0xc
ffffffffc0208668:	0034169b          	slliw	a3,s0,0x3
ffffffffc020866c:	00068d1b          	sext.w	s10,a3
ffffffffc0208670:	1682                	slli	a3,a3,0x20
ffffffffc0208672:	2401                	sext.w	s0,s0
ffffffffc0208674:	9281                	srli	a3,a3,0x20
ffffffffc0208676:	8926                	mv	s2,s1
ffffffffc0208678:	00399a1b          	slliw	s4,s3,0x3
ffffffffc020867c:	862e                	mv	a2,a1
ffffffffc020867e:	4509                	li	a0,2
ffffffffc0208680:	85d2                	mv	a1,s4
ffffffffc0208682:	cbef80ef          	jal	ra,ffffffffc0200b40 <ide_read_secs>
ffffffffc0208686:	e165                	bnez	a0,ffffffffc0208766 <disk0_io+0x190>
ffffffffc0208688:	000ab583          	ld	a1,0(s5)
ffffffffc020868c:	0038                	addi	a4,sp,8
ffffffffc020868e:	4685                	li	a3,1
ffffffffc0208690:	864a                	mv	a2,s2
ffffffffc0208692:	855a                	mv	a0,s6
ffffffffc0208694:	d37fc0ef          	jal	ra,ffffffffc02053ca <iobuf_move>
ffffffffc0208698:	67a2                	ld	a5,8(sp)
ffffffffc020869a:	09279663          	bne	a5,s2,ffffffffc0208726 <disk0_io+0x150>
ffffffffc020869e:	017977b3          	and	a5,s2,s7
ffffffffc02086a2:	e3d1                	bnez	a5,ffffffffc0208726 <disk0_io+0x150>
ffffffffc02086a4:	412484b3          	sub	s1,s1,s2
ffffffffc02086a8:	013409bb          	addw	s3,s0,s3
ffffffffc02086ac:	c0bd                	beqz	s1,ffffffffc0208712 <disk0_io+0x13c>
ffffffffc02086ae:	000ab583          	ld	a1,0(s5)
ffffffffc02086b2:	000c1b63          	bnez	s8,ffffffffc02086c8 <disk0_io+0xf2>
ffffffffc02086b6:	fb94e7e3          	bltu	s1,s9,ffffffffc0208664 <disk0_io+0x8e>
ffffffffc02086ba:	02000693          	li	a3,32
ffffffffc02086be:	02000d13          	li	s10,32
ffffffffc02086c2:	4411                	li	s0,4
ffffffffc02086c4:	6911                	lui	s2,0x4
ffffffffc02086c6:	bf4d                	j	ffffffffc0208678 <disk0_io+0xa2>
ffffffffc02086c8:	0038                	addi	a4,sp,8
ffffffffc02086ca:	4681                	li	a3,0
ffffffffc02086cc:	6611                	lui	a2,0x4
ffffffffc02086ce:	855a                	mv	a0,s6
ffffffffc02086d0:	cfbfc0ef          	jal	ra,ffffffffc02053ca <iobuf_move>
ffffffffc02086d4:	6422                	ld	s0,8(sp)
ffffffffc02086d6:	c825                	beqz	s0,ffffffffc0208746 <disk0_io+0x170>
ffffffffc02086d8:	0684e763          	bltu	s1,s0,ffffffffc0208746 <disk0_io+0x170>
ffffffffc02086dc:	017477b3          	and	a5,s0,s7
ffffffffc02086e0:	e3bd                	bnez	a5,ffffffffc0208746 <disk0_io+0x170>
ffffffffc02086e2:	8031                	srli	s0,s0,0xc
ffffffffc02086e4:	0034179b          	slliw	a5,s0,0x3
ffffffffc02086e8:	000ab603          	ld	a2,0(s5)
ffffffffc02086ec:	0039991b          	slliw	s2,s3,0x3
ffffffffc02086f0:	02079693          	slli	a3,a5,0x20
ffffffffc02086f4:	9281                	srli	a3,a3,0x20
ffffffffc02086f6:	85ca                	mv	a1,s2
ffffffffc02086f8:	4509                	li	a0,2
ffffffffc02086fa:	2401                	sext.w	s0,s0
ffffffffc02086fc:	00078a1b          	sext.w	s4,a5
ffffffffc0208700:	cd6f80ef          	jal	ra,ffffffffc0200bd6 <ide_write_secs>
ffffffffc0208704:	e151                	bnez	a0,ffffffffc0208788 <disk0_io+0x1b2>
ffffffffc0208706:	6922                	ld	s2,8(sp)
ffffffffc0208708:	013409bb          	addw	s3,s0,s3
ffffffffc020870c:	412484b3          	sub	s1,s1,s2
ffffffffc0208710:	fcd9                	bnez	s1,ffffffffc02086ae <disk0_io+0xd8>
ffffffffc0208712:	0008d517          	auipc	a0,0x8d
ffffffffc0208716:	12e50513          	addi	a0,a0,302 # ffffffffc0295840 <disk0_sem>
ffffffffc020871a:	e25fb0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc020871e:	4501                	li	a0,0
ffffffffc0208720:	b729                	j	ffffffffc020862a <disk0_io+0x54>
ffffffffc0208722:	5575                	li	a0,-3
ffffffffc0208724:	b719                	j	ffffffffc020862a <disk0_io+0x54>
ffffffffc0208726:	00006697          	auipc	a3,0x6
ffffffffc020872a:	f2a68693          	addi	a3,a3,-214 # ffffffffc020e650 <dev_node_ops+0x178>
ffffffffc020872e:	00003617          	auipc	a2,0x3
ffffffffc0208732:	f4a60613          	addi	a2,a2,-182 # ffffffffc020b678 <commands+0x210>
ffffffffc0208736:	06200593          	li	a1,98
ffffffffc020873a:	00006517          	auipc	a0,0x6
ffffffffc020873e:	e5e50513          	addi	a0,a0,-418 # ffffffffc020e598 <dev_node_ops+0xc0>
ffffffffc0208742:	d5df70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208746:	00006697          	auipc	a3,0x6
ffffffffc020874a:	e1268693          	addi	a3,a3,-494 # ffffffffc020e558 <dev_node_ops+0x80>
ffffffffc020874e:	00003617          	auipc	a2,0x3
ffffffffc0208752:	f2a60613          	addi	a2,a2,-214 # ffffffffc020b678 <commands+0x210>
ffffffffc0208756:	05700593          	li	a1,87
ffffffffc020875a:	00006517          	auipc	a0,0x6
ffffffffc020875e:	e3e50513          	addi	a0,a0,-450 # ffffffffc020e598 <dev_node_ops+0xc0>
ffffffffc0208762:	d3df70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208766:	88aa                	mv	a7,a0
ffffffffc0208768:	886a                	mv	a6,s10
ffffffffc020876a:	87a2                	mv	a5,s0
ffffffffc020876c:	8752                	mv	a4,s4
ffffffffc020876e:	86ce                	mv	a3,s3
ffffffffc0208770:	00006617          	auipc	a2,0x6
ffffffffc0208774:	e9860613          	addi	a2,a2,-360 # ffffffffc020e608 <dev_node_ops+0x130>
ffffffffc0208778:	02d00593          	li	a1,45
ffffffffc020877c:	00006517          	auipc	a0,0x6
ffffffffc0208780:	e1c50513          	addi	a0,a0,-484 # ffffffffc020e598 <dev_node_ops+0xc0>
ffffffffc0208784:	d1bf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208788:	88aa                	mv	a7,a0
ffffffffc020878a:	8852                	mv	a6,s4
ffffffffc020878c:	87a2                	mv	a5,s0
ffffffffc020878e:	874a                	mv	a4,s2
ffffffffc0208790:	86ce                	mv	a3,s3
ffffffffc0208792:	00006617          	auipc	a2,0x6
ffffffffc0208796:	e2660613          	addi	a2,a2,-474 # ffffffffc020e5b8 <dev_node_ops+0xe0>
ffffffffc020879a:	03700593          	li	a1,55
ffffffffc020879e:	00006517          	auipc	a0,0x6
ffffffffc02087a2:	dfa50513          	addi	a0,a0,-518 # ffffffffc020e598 <dev_node_ops+0xc0>
ffffffffc02087a6:	cf9f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02087aa <dev_init_disk0>:
ffffffffc02087aa:	1101                	addi	sp,sp,-32
ffffffffc02087ac:	ec06                	sd	ra,24(sp)
ffffffffc02087ae:	e822                	sd	s0,16(sp)
ffffffffc02087b0:	e426                	sd	s1,8(sp)
ffffffffc02087b2:	dedff0ef          	jal	ra,ffffffffc020859e <dev_create_inode>
ffffffffc02087b6:	c541                	beqz	a0,ffffffffc020883e <dev_init_disk0+0x94>
ffffffffc02087b8:	4d38                	lw	a4,88(a0)
ffffffffc02087ba:	6485                	lui	s1,0x1
ffffffffc02087bc:	23448793          	addi	a5,s1,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02087c0:	842a                	mv	s0,a0
ffffffffc02087c2:	0cf71f63          	bne	a4,a5,ffffffffc02088a0 <dev_init_disk0+0xf6>
ffffffffc02087c6:	4509                	li	a0,2
ffffffffc02087c8:	b2cf80ef          	jal	ra,ffffffffc0200af4 <ide_device_valid>
ffffffffc02087cc:	cd55                	beqz	a0,ffffffffc0208888 <dev_init_disk0+0xde>
ffffffffc02087ce:	4509                	li	a0,2
ffffffffc02087d0:	b48f80ef          	jal	ra,ffffffffc0200b18 <ide_device_size>
ffffffffc02087d4:	00355793          	srli	a5,a0,0x3
ffffffffc02087d8:	e01c                	sd	a5,0(s0)
ffffffffc02087da:	00000797          	auipc	a5,0x0
ffffffffc02087de:	df078793          	addi	a5,a5,-528 # ffffffffc02085ca <disk0_open>
ffffffffc02087e2:	e81c                	sd	a5,16(s0)
ffffffffc02087e4:	00000797          	auipc	a5,0x0
ffffffffc02087e8:	dea78793          	addi	a5,a5,-534 # ffffffffc02085ce <disk0_close>
ffffffffc02087ec:	ec1c                	sd	a5,24(s0)
ffffffffc02087ee:	00000797          	auipc	a5,0x0
ffffffffc02087f2:	de878793          	addi	a5,a5,-536 # ffffffffc02085d6 <disk0_io>
ffffffffc02087f6:	f01c                	sd	a5,32(s0)
ffffffffc02087f8:	00000797          	auipc	a5,0x0
ffffffffc02087fc:	dda78793          	addi	a5,a5,-550 # ffffffffc02085d2 <disk0_ioctl>
ffffffffc0208800:	f41c                	sd	a5,40(s0)
ffffffffc0208802:	4585                	li	a1,1
ffffffffc0208804:	0008d517          	auipc	a0,0x8d
ffffffffc0208808:	03c50513          	addi	a0,a0,60 # ffffffffc0295840 <disk0_sem>
ffffffffc020880c:	e404                	sd	s1,8(s0)
ffffffffc020880e:	d2bfb0ef          	jal	ra,ffffffffc0204538 <sem_init>
ffffffffc0208812:	6511                	lui	a0,0x4
ffffffffc0208814:	f7af90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0208818:	0008e797          	auipc	a5,0x8e
ffffffffc020881c:	0ea7b023          	sd	a0,224(a5) # ffffffffc02968f8 <disk0_buffer>
ffffffffc0208820:	c921                	beqz	a0,ffffffffc0208870 <dev_init_disk0+0xc6>
ffffffffc0208822:	4605                	li	a2,1
ffffffffc0208824:	85a2                	mv	a1,s0
ffffffffc0208826:	00006517          	auipc	a0,0x6
ffffffffc020882a:	eba50513          	addi	a0,a0,-326 # ffffffffc020e6e0 <dev_node_ops+0x208>
ffffffffc020882e:	c2cff0ef          	jal	ra,ffffffffc0207c5a <vfs_add_dev>
ffffffffc0208832:	e115                	bnez	a0,ffffffffc0208856 <dev_init_disk0+0xac>
ffffffffc0208834:	60e2                	ld	ra,24(sp)
ffffffffc0208836:	6442                	ld	s0,16(sp)
ffffffffc0208838:	64a2                	ld	s1,8(sp)
ffffffffc020883a:	6105                	addi	sp,sp,32
ffffffffc020883c:	8082                	ret
ffffffffc020883e:	00006617          	auipc	a2,0x6
ffffffffc0208842:	e4260613          	addi	a2,a2,-446 # ffffffffc020e680 <dev_node_ops+0x1a8>
ffffffffc0208846:	08700593          	li	a1,135
ffffffffc020884a:	00006517          	auipc	a0,0x6
ffffffffc020884e:	d4e50513          	addi	a0,a0,-690 # ffffffffc020e598 <dev_node_ops+0xc0>
ffffffffc0208852:	c4df70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208856:	86aa                	mv	a3,a0
ffffffffc0208858:	00006617          	auipc	a2,0x6
ffffffffc020885c:	e9060613          	addi	a2,a2,-368 # ffffffffc020e6e8 <dev_node_ops+0x210>
ffffffffc0208860:	08d00593          	li	a1,141
ffffffffc0208864:	00006517          	auipc	a0,0x6
ffffffffc0208868:	d3450513          	addi	a0,a0,-716 # ffffffffc020e598 <dev_node_ops+0xc0>
ffffffffc020886c:	c33f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208870:	00006617          	auipc	a2,0x6
ffffffffc0208874:	e5060613          	addi	a2,a2,-432 # ffffffffc020e6c0 <dev_node_ops+0x1e8>
ffffffffc0208878:	07f00593          	li	a1,127
ffffffffc020887c:	00006517          	auipc	a0,0x6
ffffffffc0208880:	d1c50513          	addi	a0,a0,-740 # ffffffffc020e598 <dev_node_ops+0xc0>
ffffffffc0208884:	c1bf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208888:	00006617          	auipc	a2,0x6
ffffffffc020888c:	e1860613          	addi	a2,a2,-488 # ffffffffc020e6a0 <dev_node_ops+0x1c8>
ffffffffc0208890:	07300593          	li	a1,115
ffffffffc0208894:	00006517          	auipc	a0,0x6
ffffffffc0208898:	d0450513          	addi	a0,a0,-764 # ffffffffc020e598 <dev_node_ops+0xc0>
ffffffffc020889c:	c03f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02088a0:	00006697          	auipc	a3,0x6
ffffffffc02088a4:	91068693          	addi	a3,a3,-1776 # ffffffffc020e1b0 <syscalls+0xb10>
ffffffffc02088a8:	00003617          	auipc	a2,0x3
ffffffffc02088ac:	dd060613          	addi	a2,a2,-560 # ffffffffc020b678 <commands+0x210>
ffffffffc02088b0:	08900593          	li	a1,137
ffffffffc02088b4:	00006517          	auipc	a0,0x6
ffffffffc02088b8:	ce450513          	addi	a0,a0,-796 # ffffffffc020e598 <dev_node_ops+0xc0>
ffffffffc02088bc:	be3f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02088c0 <stdin_open>:
ffffffffc02088c0:	4501                	li	a0,0
ffffffffc02088c2:	e191                	bnez	a1,ffffffffc02088c6 <stdin_open+0x6>
ffffffffc02088c4:	8082                	ret
ffffffffc02088c6:	5575                	li	a0,-3
ffffffffc02088c8:	8082                	ret

ffffffffc02088ca <stdin_close>:
ffffffffc02088ca:	4501                	li	a0,0
ffffffffc02088cc:	8082                	ret

ffffffffc02088ce <stdin_ioctl>:
ffffffffc02088ce:	5575                	li	a0,-3
ffffffffc02088d0:	8082                	ret

ffffffffc02088d2 <stdin_io>:
ffffffffc02088d2:	7135                	addi	sp,sp,-160
ffffffffc02088d4:	ed06                	sd	ra,152(sp)
ffffffffc02088d6:	e922                	sd	s0,144(sp)
ffffffffc02088d8:	e526                	sd	s1,136(sp)
ffffffffc02088da:	e14a                	sd	s2,128(sp)
ffffffffc02088dc:	fcce                	sd	s3,120(sp)
ffffffffc02088de:	f8d2                	sd	s4,112(sp)
ffffffffc02088e0:	f4d6                	sd	s5,104(sp)
ffffffffc02088e2:	f0da                	sd	s6,96(sp)
ffffffffc02088e4:	ecde                	sd	s7,88(sp)
ffffffffc02088e6:	e8e2                	sd	s8,80(sp)
ffffffffc02088e8:	e4e6                	sd	s9,72(sp)
ffffffffc02088ea:	e0ea                	sd	s10,64(sp)
ffffffffc02088ec:	fc6e                	sd	s11,56(sp)
ffffffffc02088ee:	14061163          	bnez	a2,ffffffffc0208a30 <stdin_io+0x15e>
ffffffffc02088f2:	0005bd83          	ld	s11,0(a1)
ffffffffc02088f6:	0185bd03          	ld	s10,24(a1)
ffffffffc02088fa:	8b2e                	mv	s6,a1
ffffffffc02088fc:	100027f3          	csrr	a5,sstatus
ffffffffc0208900:	8b89                	andi	a5,a5,2
ffffffffc0208902:	10079e63          	bnez	a5,ffffffffc0208a1e <stdin_io+0x14c>
ffffffffc0208906:	4401                	li	s0,0
ffffffffc0208908:	100d0963          	beqz	s10,ffffffffc0208a1a <stdin_io+0x148>
ffffffffc020890c:	0008e997          	auipc	s3,0x8e
ffffffffc0208910:	ff498993          	addi	s3,s3,-12 # ffffffffc0296900 <p_rpos>
ffffffffc0208914:	0009b783          	ld	a5,0(s3)
ffffffffc0208918:	800004b7          	lui	s1,0x80000
ffffffffc020891c:	6c85                	lui	s9,0x1
ffffffffc020891e:	4a81                	li	s5,0
ffffffffc0208920:	0008ea17          	auipc	s4,0x8e
ffffffffc0208924:	fe8a0a13          	addi	s4,s4,-24 # ffffffffc0296908 <p_wpos>
ffffffffc0208928:	0491                	addi	s1,s1,4
ffffffffc020892a:	0008d917          	auipc	s2,0x8d
ffffffffc020892e:	f2e90913          	addi	s2,s2,-210 # ffffffffc0295858 <__wait_queue>
ffffffffc0208932:	1cfd                	addi	s9,s9,-1
ffffffffc0208934:	000a3703          	ld	a4,0(s4)
ffffffffc0208938:	000a8c1b          	sext.w	s8,s5
ffffffffc020893c:	8be2                	mv	s7,s8
ffffffffc020893e:	02e7d763          	bge	a5,a4,ffffffffc020896c <stdin_io+0x9a>
ffffffffc0208942:	a859                	j	ffffffffc02089d8 <stdin_io+0x106>
ffffffffc0208944:	815fe0ef          	jal	ra,ffffffffc0207158 <schedule>
ffffffffc0208948:	100027f3          	csrr	a5,sstatus
ffffffffc020894c:	8b89                	andi	a5,a5,2
ffffffffc020894e:	4401                	li	s0,0
ffffffffc0208950:	ef8d                	bnez	a5,ffffffffc020898a <stdin_io+0xb8>
ffffffffc0208952:	0028                	addi	a0,sp,8
ffffffffc0208954:	c81fb0ef          	jal	ra,ffffffffc02045d4 <wait_in_queue>
ffffffffc0208958:	e121                	bnez	a0,ffffffffc0208998 <stdin_io+0xc6>
ffffffffc020895a:	47c2                	lw	a5,16(sp)
ffffffffc020895c:	04979563          	bne	a5,s1,ffffffffc02089a6 <stdin_io+0xd4>
ffffffffc0208960:	0009b783          	ld	a5,0(s3)
ffffffffc0208964:	000a3703          	ld	a4,0(s4)
ffffffffc0208968:	06e7c863          	blt	a5,a4,ffffffffc02089d8 <stdin_io+0x106>
ffffffffc020896c:	8626                	mv	a2,s1
ffffffffc020896e:	002c                	addi	a1,sp,8
ffffffffc0208970:	854a                	mv	a0,s2
ffffffffc0208972:	d8dfb0ef          	jal	ra,ffffffffc02046fe <wait_current_set>
ffffffffc0208976:	d479                	beqz	s0,ffffffffc0208944 <stdin_io+0x72>
ffffffffc0208978:	af4f80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020897c:	fdcfe0ef          	jal	ra,ffffffffc0207158 <schedule>
ffffffffc0208980:	100027f3          	csrr	a5,sstatus
ffffffffc0208984:	8b89                	andi	a5,a5,2
ffffffffc0208986:	4401                	li	s0,0
ffffffffc0208988:	d7e9                	beqz	a5,ffffffffc0208952 <stdin_io+0x80>
ffffffffc020898a:	ae8f80ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020898e:	0028                	addi	a0,sp,8
ffffffffc0208990:	4405                	li	s0,1
ffffffffc0208992:	c43fb0ef          	jal	ra,ffffffffc02045d4 <wait_in_queue>
ffffffffc0208996:	d171                	beqz	a0,ffffffffc020895a <stdin_io+0x88>
ffffffffc0208998:	002c                	addi	a1,sp,8
ffffffffc020899a:	854a                	mv	a0,s2
ffffffffc020899c:	bdffb0ef          	jal	ra,ffffffffc020457a <wait_queue_del>
ffffffffc02089a0:	47c2                	lw	a5,16(sp)
ffffffffc02089a2:	fa978fe3          	beq	a5,s1,ffffffffc0208960 <stdin_io+0x8e>
ffffffffc02089a6:	e435                	bnez	s0,ffffffffc0208a12 <stdin_io+0x140>
ffffffffc02089a8:	060b8963          	beqz	s7,ffffffffc0208a1a <stdin_io+0x148>
ffffffffc02089ac:	018b3783          	ld	a5,24(s6) # 80018 <_binary_bin_sfs_img_size+0xad18>
ffffffffc02089b0:	41578ab3          	sub	s5,a5,s5
ffffffffc02089b4:	015b3c23          	sd	s5,24(s6)
ffffffffc02089b8:	60ea                	ld	ra,152(sp)
ffffffffc02089ba:	644a                	ld	s0,144(sp)
ffffffffc02089bc:	64aa                	ld	s1,136(sp)
ffffffffc02089be:	690a                	ld	s2,128(sp)
ffffffffc02089c0:	79e6                	ld	s3,120(sp)
ffffffffc02089c2:	7a46                	ld	s4,112(sp)
ffffffffc02089c4:	7aa6                	ld	s5,104(sp)
ffffffffc02089c6:	7b06                	ld	s6,96(sp)
ffffffffc02089c8:	6c46                	ld	s8,80(sp)
ffffffffc02089ca:	6ca6                	ld	s9,72(sp)
ffffffffc02089cc:	6d06                	ld	s10,64(sp)
ffffffffc02089ce:	7de2                	ld	s11,56(sp)
ffffffffc02089d0:	855e                	mv	a0,s7
ffffffffc02089d2:	6be6                	ld	s7,88(sp)
ffffffffc02089d4:	610d                	addi	sp,sp,160
ffffffffc02089d6:	8082                	ret
ffffffffc02089d8:	43f7d713          	srai	a4,a5,0x3f
ffffffffc02089dc:	03475693          	srli	a3,a4,0x34
ffffffffc02089e0:	00d78733          	add	a4,a5,a3
ffffffffc02089e4:	01977733          	and	a4,a4,s9
ffffffffc02089e8:	8f15                	sub	a4,a4,a3
ffffffffc02089ea:	0008d697          	auipc	a3,0x8d
ffffffffc02089ee:	e7e68693          	addi	a3,a3,-386 # ffffffffc0295868 <stdin_buffer>
ffffffffc02089f2:	9736                	add	a4,a4,a3
ffffffffc02089f4:	00074683          	lbu	a3,0(a4)
ffffffffc02089f8:	0785                	addi	a5,a5,1
ffffffffc02089fa:	015d8733          	add	a4,s11,s5
ffffffffc02089fe:	00d70023          	sb	a3,0(a4)
ffffffffc0208a02:	00f9b023          	sd	a5,0(s3)
ffffffffc0208a06:	0a85                	addi	s5,s5,1
ffffffffc0208a08:	001c0b9b          	addiw	s7,s8,1
ffffffffc0208a0c:	f3aae4e3          	bltu	s5,s10,ffffffffc0208934 <stdin_io+0x62>
ffffffffc0208a10:	dc51                	beqz	s0,ffffffffc02089ac <stdin_io+0xda>
ffffffffc0208a12:	a5af80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208a16:	f80b9be3          	bnez	s7,ffffffffc02089ac <stdin_io+0xda>
ffffffffc0208a1a:	4b81                	li	s7,0
ffffffffc0208a1c:	bf71                	j	ffffffffc02089b8 <stdin_io+0xe6>
ffffffffc0208a1e:	a54f80ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208a22:	4405                	li	s0,1
ffffffffc0208a24:	ee0d14e3          	bnez	s10,ffffffffc020890c <stdin_io+0x3a>
ffffffffc0208a28:	a44f80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208a2c:	4b81                	li	s7,0
ffffffffc0208a2e:	b769                	j	ffffffffc02089b8 <stdin_io+0xe6>
ffffffffc0208a30:	5bf5                	li	s7,-3
ffffffffc0208a32:	b759                	j	ffffffffc02089b8 <stdin_io+0xe6>

ffffffffc0208a34 <dev_stdin_write>:
ffffffffc0208a34:	e111                	bnez	a0,ffffffffc0208a38 <dev_stdin_write+0x4>
ffffffffc0208a36:	8082                	ret
ffffffffc0208a38:	1101                	addi	sp,sp,-32
ffffffffc0208a3a:	e822                	sd	s0,16(sp)
ffffffffc0208a3c:	ec06                	sd	ra,24(sp)
ffffffffc0208a3e:	e426                	sd	s1,8(sp)
ffffffffc0208a40:	842a                	mv	s0,a0
ffffffffc0208a42:	100027f3          	csrr	a5,sstatus
ffffffffc0208a46:	8b89                	andi	a5,a5,2
ffffffffc0208a48:	4481                	li	s1,0
ffffffffc0208a4a:	e3c1                	bnez	a5,ffffffffc0208aca <dev_stdin_write+0x96>
ffffffffc0208a4c:	0008e597          	auipc	a1,0x8e
ffffffffc0208a50:	ebc58593          	addi	a1,a1,-324 # ffffffffc0296908 <p_wpos>
ffffffffc0208a54:	6198                	ld	a4,0(a1)
ffffffffc0208a56:	6605                	lui	a2,0x1
ffffffffc0208a58:	fff60513          	addi	a0,a2,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0208a5c:	43f75693          	srai	a3,a4,0x3f
ffffffffc0208a60:	92d1                	srli	a3,a3,0x34
ffffffffc0208a62:	00d707b3          	add	a5,a4,a3
ffffffffc0208a66:	8fe9                	and	a5,a5,a0
ffffffffc0208a68:	8f95                	sub	a5,a5,a3
ffffffffc0208a6a:	0008d697          	auipc	a3,0x8d
ffffffffc0208a6e:	dfe68693          	addi	a3,a3,-514 # ffffffffc0295868 <stdin_buffer>
ffffffffc0208a72:	97b6                	add	a5,a5,a3
ffffffffc0208a74:	00878023          	sb	s0,0(a5)
ffffffffc0208a78:	0008e797          	auipc	a5,0x8e
ffffffffc0208a7c:	e887b783          	ld	a5,-376(a5) # ffffffffc0296900 <p_rpos>
ffffffffc0208a80:	40f707b3          	sub	a5,a4,a5
ffffffffc0208a84:	00c7d463          	bge	a5,a2,ffffffffc0208a8c <dev_stdin_write+0x58>
ffffffffc0208a88:	0705                	addi	a4,a4,1
ffffffffc0208a8a:	e198                	sd	a4,0(a1)
ffffffffc0208a8c:	0008d517          	auipc	a0,0x8d
ffffffffc0208a90:	dcc50513          	addi	a0,a0,-564 # ffffffffc0295858 <__wait_queue>
ffffffffc0208a94:	b35fb0ef          	jal	ra,ffffffffc02045c8 <wait_queue_empty>
ffffffffc0208a98:	cd09                	beqz	a0,ffffffffc0208ab2 <dev_stdin_write+0x7e>
ffffffffc0208a9a:	e491                	bnez	s1,ffffffffc0208aa6 <dev_stdin_write+0x72>
ffffffffc0208a9c:	60e2                	ld	ra,24(sp)
ffffffffc0208a9e:	6442                	ld	s0,16(sp)
ffffffffc0208aa0:	64a2                	ld	s1,8(sp)
ffffffffc0208aa2:	6105                	addi	sp,sp,32
ffffffffc0208aa4:	8082                	ret
ffffffffc0208aa6:	6442                	ld	s0,16(sp)
ffffffffc0208aa8:	60e2                	ld	ra,24(sp)
ffffffffc0208aaa:	64a2                	ld	s1,8(sp)
ffffffffc0208aac:	6105                	addi	sp,sp,32
ffffffffc0208aae:	9bef806f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0208ab2:	800005b7          	lui	a1,0x80000
ffffffffc0208ab6:	4605                	li	a2,1
ffffffffc0208ab8:	0591                	addi	a1,a1,4
ffffffffc0208aba:	0008d517          	auipc	a0,0x8d
ffffffffc0208abe:	d9e50513          	addi	a0,a0,-610 # ffffffffc0295858 <__wait_queue>
ffffffffc0208ac2:	b6ffb0ef          	jal	ra,ffffffffc0204630 <wakeup_queue>
ffffffffc0208ac6:	d8f9                	beqz	s1,ffffffffc0208a9c <dev_stdin_write+0x68>
ffffffffc0208ac8:	bff9                	j	ffffffffc0208aa6 <dev_stdin_write+0x72>
ffffffffc0208aca:	9a8f80ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208ace:	4485                	li	s1,1
ffffffffc0208ad0:	bfb5                	j	ffffffffc0208a4c <dev_stdin_write+0x18>

ffffffffc0208ad2 <dev_init_stdin>:
ffffffffc0208ad2:	1141                	addi	sp,sp,-16
ffffffffc0208ad4:	e406                	sd	ra,8(sp)
ffffffffc0208ad6:	e022                	sd	s0,0(sp)
ffffffffc0208ad8:	ac7ff0ef          	jal	ra,ffffffffc020859e <dev_create_inode>
ffffffffc0208adc:	c93d                	beqz	a0,ffffffffc0208b52 <dev_init_stdin+0x80>
ffffffffc0208ade:	4d38                	lw	a4,88(a0)
ffffffffc0208ae0:	6785                	lui	a5,0x1
ffffffffc0208ae2:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208ae6:	842a                	mv	s0,a0
ffffffffc0208ae8:	08f71e63          	bne	a4,a5,ffffffffc0208b84 <dev_init_stdin+0xb2>
ffffffffc0208aec:	4785                	li	a5,1
ffffffffc0208aee:	e41c                	sd	a5,8(s0)
ffffffffc0208af0:	00000797          	auipc	a5,0x0
ffffffffc0208af4:	dd078793          	addi	a5,a5,-560 # ffffffffc02088c0 <stdin_open>
ffffffffc0208af8:	e81c                	sd	a5,16(s0)
ffffffffc0208afa:	00000797          	auipc	a5,0x0
ffffffffc0208afe:	dd078793          	addi	a5,a5,-560 # ffffffffc02088ca <stdin_close>
ffffffffc0208b02:	ec1c                	sd	a5,24(s0)
ffffffffc0208b04:	00000797          	auipc	a5,0x0
ffffffffc0208b08:	dce78793          	addi	a5,a5,-562 # ffffffffc02088d2 <stdin_io>
ffffffffc0208b0c:	f01c                	sd	a5,32(s0)
ffffffffc0208b0e:	00000797          	auipc	a5,0x0
ffffffffc0208b12:	dc078793          	addi	a5,a5,-576 # ffffffffc02088ce <stdin_ioctl>
ffffffffc0208b16:	f41c                	sd	a5,40(s0)
ffffffffc0208b18:	0008d517          	auipc	a0,0x8d
ffffffffc0208b1c:	d4050513          	addi	a0,a0,-704 # ffffffffc0295858 <__wait_queue>
ffffffffc0208b20:	00043023          	sd	zero,0(s0)
ffffffffc0208b24:	0008e797          	auipc	a5,0x8e
ffffffffc0208b28:	de07b223          	sd	zero,-540(a5) # ffffffffc0296908 <p_wpos>
ffffffffc0208b2c:	0008e797          	auipc	a5,0x8e
ffffffffc0208b30:	dc07ba23          	sd	zero,-556(a5) # ffffffffc0296900 <p_rpos>
ffffffffc0208b34:	a41fb0ef          	jal	ra,ffffffffc0204574 <wait_queue_init>
ffffffffc0208b38:	4601                	li	a2,0
ffffffffc0208b3a:	85a2                	mv	a1,s0
ffffffffc0208b3c:	00006517          	auipc	a0,0x6
ffffffffc0208b40:	c0c50513          	addi	a0,a0,-1012 # ffffffffc020e748 <dev_node_ops+0x270>
ffffffffc0208b44:	916ff0ef          	jal	ra,ffffffffc0207c5a <vfs_add_dev>
ffffffffc0208b48:	e10d                	bnez	a0,ffffffffc0208b6a <dev_init_stdin+0x98>
ffffffffc0208b4a:	60a2                	ld	ra,8(sp)
ffffffffc0208b4c:	6402                	ld	s0,0(sp)
ffffffffc0208b4e:	0141                	addi	sp,sp,16
ffffffffc0208b50:	8082                	ret
ffffffffc0208b52:	00006617          	auipc	a2,0x6
ffffffffc0208b56:	bb660613          	addi	a2,a2,-1098 # ffffffffc020e708 <dev_node_ops+0x230>
ffffffffc0208b5a:	07500593          	li	a1,117
ffffffffc0208b5e:	00006517          	auipc	a0,0x6
ffffffffc0208b62:	bca50513          	addi	a0,a0,-1078 # ffffffffc020e728 <dev_node_ops+0x250>
ffffffffc0208b66:	939f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208b6a:	86aa                	mv	a3,a0
ffffffffc0208b6c:	00006617          	auipc	a2,0x6
ffffffffc0208b70:	be460613          	addi	a2,a2,-1052 # ffffffffc020e750 <dev_node_ops+0x278>
ffffffffc0208b74:	07b00593          	li	a1,123
ffffffffc0208b78:	00006517          	auipc	a0,0x6
ffffffffc0208b7c:	bb050513          	addi	a0,a0,-1104 # ffffffffc020e728 <dev_node_ops+0x250>
ffffffffc0208b80:	91ff70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208b84:	00005697          	auipc	a3,0x5
ffffffffc0208b88:	62c68693          	addi	a3,a3,1580 # ffffffffc020e1b0 <syscalls+0xb10>
ffffffffc0208b8c:	00003617          	auipc	a2,0x3
ffffffffc0208b90:	aec60613          	addi	a2,a2,-1300 # ffffffffc020b678 <commands+0x210>
ffffffffc0208b94:	07700593          	li	a1,119
ffffffffc0208b98:	00006517          	auipc	a0,0x6
ffffffffc0208b9c:	b9050513          	addi	a0,a0,-1136 # ffffffffc020e728 <dev_node_ops+0x250>
ffffffffc0208ba0:	8fff70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208ba4 <stdout_open>:
ffffffffc0208ba4:	4785                	li	a5,1
ffffffffc0208ba6:	4501                	li	a0,0
ffffffffc0208ba8:	00f59363          	bne	a1,a5,ffffffffc0208bae <stdout_open+0xa>
ffffffffc0208bac:	8082                	ret
ffffffffc0208bae:	5575                	li	a0,-3
ffffffffc0208bb0:	8082                	ret

ffffffffc0208bb2 <stdout_close>:
ffffffffc0208bb2:	4501                	li	a0,0
ffffffffc0208bb4:	8082                	ret

ffffffffc0208bb6 <stdout_ioctl>:
ffffffffc0208bb6:	5575                	li	a0,-3
ffffffffc0208bb8:	8082                	ret

ffffffffc0208bba <stdout_io>:
ffffffffc0208bba:	ca05                	beqz	a2,ffffffffc0208bea <stdout_io+0x30>
ffffffffc0208bbc:	6d9c                	ld	a5,24(a1)
ffffffffc0208bbe:	1101                	addi	sp,sp,-32
ffffffffc0208bc0:	e822                	sd	s0,16(sp)
ffffffffc0208bc2:	e426                	sd	s1,8(sp)
ffffffffc0208bc4:	ec06                	sd	ra,24(sp)
ffffffffc0208bc6:	6180                	ld	s0,0(a1)
ffffffffc0208bc8:	84ae                	mv	s1,a1
ffffffffc0208bca:	cb91                	beqz	a5,ffffffffc0208bde <stdout_io+0x24>
ffffffffc0208bcc:	00044503          	lbu	a0,0(s0)
ffffffffc0208bd0:	0405                	addi	s0,s0,1
ffffffffc0208bd2:	e10f70ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0208bd6:	6c9c                	ld	a5,24(s1)
ffffffffc0208bd8:	17fd                	addi	a5,a5,-1
ffffffffc0208bda:	ec9c                	sd	a5,24(s1)
ffffffffc0208bdc:	fbe5                	bnez	a5,ffffffffc0208bcc <stdout_io+0x12>
ffffffffc0208bde:	60e2                	ld	ra,24(sp)
ffffffffc0208be0:	6442                	ld	s0,16(sp)
ffffffffc0208be2:	64a2                	ld	s1,8(sp)
ffffffffc0208be4:	4501                	li	a0,0
ffffffffc0208be6:	6105                	addi	sp,sp,32
ffffffffc0208be8:	8082                	ret
ffffffffc0208bea:	5575                	li	a0,-3
ffffffffc0208bec:	8082                	ret

ffffffffc0208bee <dev_init_stdout>:
ffffffffc0208bee:	1141                	addi	sp,sp,-16
ffffffffc0208bf0:	e406                	sd	ra,8(sp)
ffffffffc0208bf2:	9adff0ef          	jal	ra,ffffffffc020859e <dev_create_inode>
ffffffffc0208bf6:	c939                	beqz	a0,ffffffffc0208c4c <dev_init_stdout+0x5e>
ffffffffc0208bf8:	4d38                	lw	a4,88(a0)
ffffffffc0208bfa:	6785                	lui	a5,0x1
ffffffffc0208bfc:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208c00:	85aa                	mv	a1,a0
ffffffffc0208c02:	06f71e63          	bne	a4,a5,ffffffffc0208c7e <dev_init_stdout+0x90>
ffffffffc0208c06:	4785                	li	a5,1
ffffffffc0208c08:	e51c                	sd	a5,8(a0)
ffffffffc0208c0a:	00000797          	auipc	a5,0x0
ffffffffc0208c0e:	f9a78793          	addi	a5,a5,-102 # ffffffffc0208ba4 <stdout_open>
ffffffffc0208c12:	e91c                	sd	a5,16(a0)
ffffffffc0208c14:	00000797          	auipc	a5,0x0
ffffffffc0208c18:	f9e78793          	addi	a5,a5,-98 # ffffffffc0208bb2 <stdout_close>
ffffffffc0208c1c:	ed1c                	sd	a5,24(a0)
ffffffffc0208c1e:	00000797          	auipc	a5,0x0
ffffffffc0208c22:	f9c78793          	addi	a5,a5,-100 # ffffffffc0208bba <stdout_io>
ffffffffc0208c26:	f11c                	sd	a5,32(a0)
ffffffffc0208c28:	00000797          	auipc	a5,0x0
ffffffffc0208c2c:	f8e78793          	addi	a5,a5,-114 # ffffffffc0208bb6 <stdout_ioctl>
ffffffffc0208c30:	00053023          	sd	zero,0(a0)
ffffffffc0208c34:	f51c                	sd	a5,40(a0)
ffffffffc0208c36:	4601                	li	a2,0
ffffffffc0208c38:	00006517          	auipc	a0,0x6
ffffffffc0208c3c:	b7850513          	addi	a0,a0,-1160 # ffffffffc020e7b0 <dev_node_ops+0x2d8>
ffffffffc0208c40:	81aff0ef          	jal	ra,ffffffffc0207c5a <vfs_add_dev>
ffffffffc0208c44:	e105                	bnez	a0,ffffffffc0208c64 <dev_init_stdout+0x76>
ffffffffc0208c46:	60a2                	ld	ra,8(sp)
ffffffffc0208c48:	0141                	addi	sp,sp,16
ffffffffc0208c4a:	8082                	ret
ffffffffc0208c4c:	00006617          	auipc	a2,0x6
ffffffffc0208c50:	b2460613          	addi	a2,a2,-1244 # ffffffffc020e770 <dev_node_ops+0x298>
ffffffffc0208c54:	03700593          	li	a1,55
ffffffffc0208c58:	00006517          	auipc	a0,0x6
ffffffffc0208c5c:	b3850513          	addi	a0,a0,-1224 # ffffffffc020e790 <dev_node_ops+0x2b8>
ffffffffc0208c60:	83ff70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208c64:	86aa                	mv	a3,a0
ffffffffc0208c66:	00006617          	auipc	a2,0x6
ffffffffc0208c6a:	b5260613          	addi	a2,a2,-1198 # ffffffffc020e7b8 <dev_node_ops+0x2e0>
ffffffffc0208c6e:	03d00593          	li	a1,61
ffffffffc0208c72:	00006517          	auipc	a0,0x6
ffffffffc0208c76:	b1e50513          	addi	a0,a0,-1250 # ffffffffc020e790 <dev_node_ops+0x2b8>
ffffffffc0208c7a:	825f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208c7e:	00005697          	auipc	a3,0x5
ffffffffc0208c82:	53268693          	addi	a3,a3,1330 # ffffffffc020e1b0 <syscalls+0xb10>
ffffffffc0208c86:	00003617          	auipc	a2,0x3
ffffffffc0208c8a:	9f260613          	addi	a2,a2,-1550 # ffffffffc020b678 <commands+0x210>
ffffffffc0208c8e:	03900593          	li	a1,57
ffffffffc0208c92:	00006517          	auipc	a0,0x6
ffffffffc0208c96:	afe50513          	addi	a0,a0,-1282 # ffffffffc020e790 <dev_node_ops+0x2b8>
ffffffffc0208c9a:	805f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208c9e <bitmap_translate.part.0>:
ffffffffc0208c9e:	1141                	addi	sp,sp,-16
ffffffffc0208ca0:	00006697          	auipc	a3,0x6
ffffffffc0208ca4:	b3868693          	addi	a3,a3,-1224 # ffffffffc020e7d8 <dev_node_ops+0x300>
ffffffffc0208ca8:	00003617          	auipc	a2,0x3
ffffffffc0208cac:	9d060613          	addi	a2,a2,-1584 # ffffffffc020b678 <commands+0x210>
ffffffffc0208cb0:	04c00593          	li	a1,76
ffffffffc0208cb4:	00006517          	auipc	a0,0x6
ffffffffc0208cb8:	b3c50513          	addi	a0,a0,-1220 # ffffffffc020e7f0 <dev_node_ops+0x318>
ffffffffc0208cbc:	e406                	sd	ra,8(sp)
ffffffffc0208cbe:	fe0f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208cc2 <bitmap_create>:
ffffffffc0208cc2:	7139                	addi	sp,sp,-64
ffffffffc0208cc4:	fc06                	sd	ra,56(sp)
ffffffffc0208cc6:	f822                	sd	s0,48(sp)
ffffffffc0208cc8:	f426                	sd	s1,40(sp)
ffffffffc0208cca:	f04a                	sd	s2,32(sp)
ffffffffc0208ccc:	ec4e                	sd	s3,24(sp)
ffffffffc0208cce:	e852                	sd	s4,16(sp)
ffffffffc0208cd0:	e456                	sd	s5,8(sp)
ffffffffc0208cd2:	c14d                	beqz	a0,ffffffffc0208d74 <bitmap_create+0xb2>
ffffffffc0208cd4:	842a                	mv	s0,a0
ffffffffc0208cd6:	4541                	li	a0,16
ffffffffc0208cd8:	ab6f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0208cdc:	84aa                	mv	s1,a0
ffffffffc0208cde:	cd25                	beqz	a0,ffffffffc0208d56 <bitmap_create+0x94>
ffffffffc0208ce0:	02041a13          	slli	s4,s0,0x20
ffffffffc0208ce4:	020a5a13          	srli	s4,s4,0x20
ffffffffc0208ce8:	01fa0793          	addi	a5,s4,31
ffffffffc0208cec:	0057d993          	srli	s3,a5,0x5
ffffffffc0208cf0:	00299a93          	slli	s5,s3,0x2
ffffffffc0208cf4:	8556                	mv	a0,s5
ffffffffc0208cf6:	894e                	mv	s2,s3
ffffffffc0208cf8:	a96f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0208cfc:	c53d                	beqz	a0,ffffffffc0208d6a <bitmap_create+0xa8>
ffffffffc0208cfe:	0134a223          	sw	s3,4(s1) # ffffffff80000004 <_binary_bin_sfs_img_size+0xffffffff7ff8ad04>
ffffffffc0208d02:	c080                	sw	s0,0(s1)
ffffffffc0208d04:	8656                	mv	a2,s5
ffffffffc0208d06:	0ff00593          	li	a1,255
ffffffffc0208d0a:	48a020ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc0208d0e:	e488                	sd	a0,8(s1)
ffffffffc0208d10:	0996                	slli	s3,s3,0x5
ffffffffc0208d12:	053a0263          	beq	s4,s3,ffffffffc0208d56 <bitmap_create+0x94>
ffffffffc0208d16:	fff9079b          	addiw	a5,s2,-1
ffffffffc0208d1a:	0057969b          	slliw	a3,a5,0x5
ffffffffc0208d1e:	0054561b          	srliw	a2,s0,0x5
ffffffffc0208d22:	40d4073b          	subw	a4,s0,a3
ffffffffc0208d26:	0054541b          	srliw	s0,s0,0x5
ffffffffc0208d2a:	08f61463          	bne	a2,a5,ffffffffc0208db2 <bitmap_create+0xf0>
ffffffffc0208d2e:	fff7069b          	addiw	a3,a4,-1
ffffffffc0208d32:	47f9                	li	a5,30
ffffffffc0208d34:	04d7ef63          	bltu	a5,a3,ffffffffc0208d92 <bitmap_create+0xd0>
ffffffffc0208d38:	1402                	slli	s0,s0,0x20
ffffffffc0208d3a:	8079                	srli	s0,s0,0x1e
ffffffffc0208d3c:	9522                	add	a0,a0,s0
ffffffffc0208d3e:	411c                	lw	a5,0(a0)
ffffffffc0208d40:	4585                	li	a1,1
ffffffffc0208d42:	02000613          	li	a2,32
ffffffffc0208d46:	00e596bb          	sllw	a3,a1,a4
ffffffffc0208d4a:	8fb5                	xor	a5,a5,a3
ffffffffc0208d4c:	2705                	addiw	a4,a4,1
ffffffffc0208d4e:	2781                	sext.w	a5,a5
ffffffffc0208d50:	fec71be3          	bne	a4,a2,ffffffffc0208d46 <bitmap_create+0x84>
ffffffffc0208d54:	c11c                	sw	a5,0(a0)
ffffffffc0208d56:	70e2                	ld	ra,56(sp)
ffffffffc0208d58:	7442                	ld	s0,48(sp)
ffffffffc0208d5a:	7902                	ld	s2,32(sp)
ffffffffc0208d5c:	69e2                	ld	s3,24(sp)
ffffffffc0208d5e:	6a42                	ld	s4,16(sp)
ffffffffc0208d60:	6aa2                	ld	s5,8(sp)
ffffffffc0208d62:	8526                	mv	a0,s1
ffffffffc0208d64:	74a2                	ld	s1,40(sp)
ffffffffc0208d66:	6121                	addi	sp,sp,64
ffffffffc0208d68:	8082                	ret
ffffffffc0208d6a:	8526                	mv	a0,s1
ffffffffc0208d6c:	ad2f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208d70:	4481                	li	s1,0
ffffffffc0208d72:	b7d5                	j	ffffffffc0208d56 <bitmap_create+0x94>
ffffffffc0208d74:	00006697          	auipc	a3,0x6
ffffffffc0208d78:	a9468693          	addi	a3,a3,-1388 # ffffffffc020e808 <dev_node_ops+0x330>
ffffffffc0208d7c:	00003617          	auipc	a2,0x3
ffffffffc0208d80:	8fc60613          	addi	a2,a2,-1796 # ffffffffc020b678 <commands+0x210>
ffffffffc0208d84:	45d5                	li	a1,21
ffffffffc0208d86:	00006517          	auipc	a0,0x6
ffffffffc0208d8a:	a6a50513          	addi	a0,a0,-1430 # ffffffffc020e7f0 <dev_node_ops+0x318>
ffffffffc0208d8e:	f10f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208d92:	00006697          	auipc	a3,0x6
ffffffffc0208d96:	ab668693          	addi	a3,a3,-1354 # ffffffffc020e848 <dev_node_ops+0x370>
ffffffffc0208d9a:	00003617          	auipc	a2,0x3
ffffffffc0208d9e:	8de60613          	addi	a2,a2,-1826 # ffffffffc020b678 <commands+0x210>
ffffffffc0208da2:	02b00593          	li	a1,43
ffffffffc0208da6:	00006517          	auipc	a0,0x6
ffffffffc0208daa:	a4a50513          	addi	a0,a0,-1462 # ffffffffc020e7f0 <dev_node_ops+0x318>
ffffffffc0208dae:	ef0f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208db2:	00006697          	auipc	a3,0x6
ffffffffc0208db6:	a7e68693          	addi	a3,a3,-1410 # ffffffffc020e830 <dev_node_ops+0x358>
ffffffffc0208dba:	00003617          	auipc	a2,0x3
ffffffffc0208dbe:	8be60613          	addi	a2,a2,-1858 # ffffffffc020b678 <commands+0x210>
ffffffffc0208dc2:	02a00593          	li	a1,42
ffffffffc0208dc6:	00006517          	auipc	a0,0x6
ffffffffc0208dca:	a2a50513          	addi	a0,a0,-1494 # ffffffffc020e7f0 <dev_node_ops+0x318>
ffffffffc0208dce:	ed0f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208dd2 <bitmap_alloc>:
ffffffffc0208dd2:	4150                	lw	a2,4(a0)
ffffffffc0208dd4:	651c                	ld	a5,8(a0)
ffffffffc0208dd6:	c231                	beqz	a2,ffffffffc0208e1a <bitmap_alloc+0x48>
ffffffffc0208dd8:	4701                	li	a4,0
ffffffffc0208dda:	a029                	j	ffffffffc0208de4 <bitmap_alloc+0x12>
ffffffffc0208ddc:	2705                	addiw	a4,a4,1
ffffffffc0208dde:	0791                	addi	a5,a5,4
ffffffffc0208de0:	02e60d63          	beq	a2,a4,ffffffffc0208e1a <bitmap_alloc+0x48>
ffffffffc0208de4:	4394                	lw	a3,0(a5)
ffffffffc0208de6:	dafd                	beqz	a3,ffffffffc0208ddc <bitmap_alloc+0xa>
ffffffffc0208de8:	4501                	li	a0,0
ffffffffc0208dea:	4885                	li	a7,1
ffffffffc0208dec:	8e36                	mv	t3,a3
ffffffffc0208dee:	02000313          	li	t1,32
ffffffffc0208df2:	a021                	j	ffffffffc0208dfa <bitmap_alloc+0x28>
ffffffffc0208df4:	2505                	addiw	a0,a0,1
ffffffffc0208df6:	02650463          	beq	a0,t1,ffffffffc0208e1e <bitmap_alloc+0x4c>
ffffffffc0208dfa:	00a8983b          	sllw	a6,a7,a0
ffffffffc0208dfe:	0106f633          	and	a2,a3,a6
ffffffffc0208e02:	2601                	sext.w	a2,a2
ffffffffc0208e04:	da65                	beqz	a2,ffffffffc0208df4 <bitmap_alloc+0x22>
ffffffffc0208e06:	010e4833          	xor	a6,t3,a6
ffffffffc0208e0a:	0057171b          	slliw	a4,a4,0x5
ffffffffc0208e0e:	9f29                	addw	a4,a4,a0
ffffffffc0208e10:	0107a023          	sw	a6,0(a5)
ffffffffc0208e14:	c198                	sw	a4,0(a1)
ffffffffc0208e16:	4501                	li	a0,0
ffffffffc0208e18:	8082                	ret
ffffffffc0208e1a:	5571                	li	a0,-4
ffffffffc0208e1c:	8082                	ret
ffffffffc0208e1e:	1141                	addi	sp,sp,-16
ffffffffc0208e20:	00004697          	auipc	a3,0x4
ffffffffc0208e24:	8d868693          	addi	a3,a3,-1832 # ffffffffc020c6f8 <default_pmm_manager+0x598>
ffffffffc0208e28:	00003617          	auipc	a2,0x3
ffffffffc0208e2c:	85060613          	addi	a2,a2,-1968 # ffffffffc020b678 <commands+0x210>
ffffffffc0208e30:	04300593          	li	a1,67
ffffffffc0208e34:	00006517          	auipc	a0,0x6
ffffffffc0208e38:	9bc50513          	addi	a0,a0,-1604 # ffffffffc020e7f0 <dev_node_ops+0x318>
ffffffffc0208e3c:	e406                	sd	ra,8(sp)
ffffffffc0208e3e:	e60f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208e42 <bitmap_test>:
ffffffffc0208e42:	411c                	lw	a5,0(a0)
ffffffffc0208e44:	00f5ff63          	bgeu	a1,a5,ffffffffc0208e62 <bitmap_test+0x20>
ffffffffc0208e48:	651c                	ld	a5,8(a0)
ffffffffc0208e4a:	0055d71b          	srliw	a4,a1,0x5
ffffffffc0208e4e:	070a                	slli	a4,a4,0x2
ffffffffc0208e50:	97ba                	add	a5,a5,a4
ffffffffc0208e52:	4388                	lw	a0,0(a5)
ffffffffc0208e54:	4785                	li	a5,1
ffffffffc0208e56:	00b795bb          	sllw	a1,a5,a1
ffffffffc0208e5a:	8d6d                	and	a0,a0,a1
ffffffffc0208e5c:	1502                	slli	a0,a0,0x20
ffffffffc0208e5e:	9101                	srli	a0,a0,0x20
ffffffffc0208e60:	8082                	ret
ffffffffc0208e62:	1141                	addi	sp,sp,-16
ffffffffc0208e64:	e406                	sd	ra,8(sp)
ffffffffc0208e66:	e39ff0ef          	jal	ra,ffffffffc0208c9e <bitmap_translate.part.0>

ffffffffc0208e6a <bitmap_free>:
ffffffffc0208e6a:	411c                	lw	a5,0(a0)
ffffffffc0208e6c:	1141                	addi	sp,sp,-16
ffffffffc0208e6e:	e406                	sd	ra,8(sp)
ffffffffc0208e70:	02f5f463          	bgeu	a1,a5,ffffffffc0208e98 <bitmap_free+0x2e>
ffffffffc0208e74:	651c                	ld	a5,8(a0)
ffffffffc0208e76:	0055d71b          	srliw	a4,a1,0x5
ffffffffc0208e7a:	070a                	slli	a4,a4,0x2
ffffffffc0208e7c:	97ba                	add	a5,a5,a4
ffffffffc0208e7e:	4398                	lw	a4,0(a5)
ffffffffc0208e80:	4685                	li	a3,1
ffffffffc0208e82:	00b695bb          	sllw	a1,a3,a1
ffffffffc0208e86:	00b776b3          	and	a3,a4,a1
ffffffffc0208e8a:	2681                	sext.w	a3,a3
ffffffffc0208e8c:	ea81                	bnez	a3,ffffffffc0208e9c <bitmap_free+0x32>
ffffffffc0208e8e:	60a2                	ld	ra,8(sp)
ffffffffc0208e90:	8f4d                	or	a4,a4,a1
ffffffffc0208e92:	c398                	sw	a4,0(a5)
ffffffffc0208e94:	0141                	addi	sp,sp,16
ffffffffc0208e96:	8082                	ret
ffffffffc0208e98:	e07ff0ef          	jal	ra,ffffffffc0208c9e <bitmap_translate.part.0>
ffffffffc0208e9c:	00006697          	auipc	a3,0x6
ffffffffc0208ea0:	9d468693          	addi	a3,a3,-1580 # ffffffffc020e870 <dev_node_ops+0x398>
ffffffffc0208ea4:	00002617          	auipc	a2,0x2
ffffffffc0208ea8:	7d460613          	addi	a2,a2,2004 # ffffffffc020b678 <commands+0x210>
ffffffffc0208eac:	05f00593          	li	a1,95
ffffffffc0208eb0:	00006517          	auipc	a0,0x6
ffffffffc0208eb4:	94050513          	addi	a0,a0,-1728 # ffffffffc020e7f0 <dev_node_ops+0x318>
ffffffffc0208eb8:	de6f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208ebc <bitmap_destroy>:
ffffffffc0208ebc:	1141                	addi	sp,sp,-16
ffffffffc0208ebe:	e022                	sd	s0,0(sp)
ffffffffc0208ec0:	842a                	mv	s0,a0
ffffffffc0208ec2:	6508                	ld	a0,8(a0)
ffffffffc0208ec4:	e406                	sd	ra,8(sp)
ffffffffc0208ec6:	978f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208eca:	8522                	mv	a0,s0
ffffffffc0208ecc:	6402                	ld	s0,0(sp)
ffffffffc0208ece:	60a2                	ld	ra,8(sp)
ffffffffc0208ed0:	0141                	addi	sp,sp,16
ffffffffc0208ed2:	96cf906f          	j	ffffffffc020203e <kfree>

ffffffffc0208ed6 <bitmap_getdata>:
ffffffffc0208ed6:	c589                	beqz	a1,ffffffffc0208ee0 <bitmap_getdata+0xa>
ffffffffc0208ed8:	00456783          	lwu	a5,4(a0)
ffffffffc0208edc:	078a                	slli	a5,a5,0x2
ffffffffc0208ede:	e19c                	sd	a5,0(a1)
ffffffffc0208ee0:	6508                	ld	a0,8(a0)
ffffffffc0208ee2:	8082                	ret

ffffffffc0208ee4 <sfs_init>:
ffffffffc0208ee4:	1141                	addi	sp,sp,-16
ffffffffc0208ee6:	00005517          	auipc	a0,0x5
ffffffffc0208eea:	7fa50513          	addi	a0,a0,2042 # ffffffffc020e6e0 <dev_node_ops+0x208>
ffffffffc0208eee:	e406                	sd	ra,8(sp)
ffffffffc0208ef0:	554000ef          	jal	ra,ffffffffc0209444 <sfs_mount>
ffffffffc0208ef4:	e501                	bnez	a0,ffffffffc0208efc <sfs_init+0x18>
ffffffffc0208ef6:	60a2                	ld	ra,8(sp)
ffffffffc0208ef8:	0141                	addi	sp,sp,16
ffffffffc0208efa:	8082                	ret
ffffffffc0208efc:	86aa                	mv	a3,a0
ffffffffc0208efe:	00006617          	auipc	a2,0x6
ffffffffc0208f02:	98260613          	addi	a2,a2,-1662 # ffffffffc020e880 <dev_node_ops+0x3a8>
ffffffffc0208f06:	45c1                	li	a1,16
ffffffffc0208f08:	00006517          	auipc	a0,0x6
ffffffffc0208f0c:	99850513          	addi	a0,a0,-1640 # ffffffffc020e8a0 <dev_node_ops+0x3c8>
ffffffffc0208f10:	d8ef70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208f14 <sfs_unmount>:
ffffffffc0208f14:	1141                	addi	sp,sp,-16
ffffffffc0208f16:	e406                	sd	ra,8(sp)
ffffffffc0208f18:	e022                	sd	s0,0(sp)
ffffffffc0208f1a:	cd1d                	beqz	a0,ffffffffc0208f58 <sfs_unmount+0x44>
ffffffffc0208f1c:	0b052783          	lw	a5,176(a0)
ffffffffc0208f20:	842a                	mv	s0,a0
ffffffffc0208f22:	eb9d                	bnez	a5,ffffffffc0208f58 <sfs_unmount+0x44>
ffffffffc0208f24:	7158                	ld	a4,160(a0)
ffffffffc0208f26:	09850793          	addi	a5,a0,152
ffffffffc0208f2a:	02f71563          	bne	a4,a5,ffffffffc0208f54 <sfs_unmount+0x40>
ffffffffc0208f2e:	613c                	ld	a5,64(a0)
ffffffffc0208f30:	e7a1                	bnez	a5,ffffffffc0208f78 <sfs_unmount+0x64>
ffffffffc0208f32:	7d08                	ld	a0,56(a0)
ffffffffc0208f34:	f89ff0ef          	jal	ra,ffffffffc0208ebc <bitmap_destroy>
ffffffffc0208f38:	6428                	ld	a0,72(s0)
ffffffffc0208f3a:	904f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208f3e:	7448                	ld	a0,168(s0)
ffffffffc0208f40:	8fef90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208f44:	8522                	mv	a0,s0
ffffffffc0208f46:	8f8f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208f4a:	4501                	li	a0,0
ffffffffc0208f4c:	60a2                	ld	ra,8(sp)
ffffffffc0208f4e:	6402                	ld	s0,0(sp)
ffffffffc0208f50:	0141                	addi	sp,sp,16
ffffffffc0208f52:	8082                	ret
ffffffffc0208f54:	5545                	li	a0,-15
ffffffffc0208f56:	bfdd                	j	ffffffffc0208f4c <sfs_unmount+0x38>
ffffffffc0208f58:	00006697          	auipc	a3,0x6
ffffffffc0208f5c:	96068693          	addi	a3,a3,-1696 # ffffffffc020e8b8 <dev_node_ops+0x3e0>
ffffffffc0208f60:	00002617          	auipc	a2,0x2
ffffffffc0208f64:	71860613          	addi	a2,a2,1816 # ffffffffc020b678 <commands+0x210>
ffffffffc0208f68:	04100593          	li	a1,65
ffffffffc0208f6c:	00006517          	auipc	a0,0x6
ffffffffc0208f70:	97c50513          	addi	a0,a0,-1668 # ffffffffc020e8e8 <dev_node_ops+0x410>
ffffffffc0208f74:	d2af70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208f78:	00006697          	auipc	a3,0x6
ffffffffc0208f7c:	98868693          	addi	a3,a3,-1656 # ffffffffc020e900 <dev_node_ops+0x428>
ffffffffc0208f80:	00002617          	auipc	a2,0x2
ffffffffc0208f84:	6f860613          	addi	a2,a2,1784 # ffffffffc020b678 <commands+0x210>
ffffffffc0208f88:	04500593          	li	a1,69
ffffffffc0208f8c:	00006517          	auipc	a0,0x6
ffffffffc0208f90:	95c50513          	addi	a0,a0,-1700 # ffffffffc020e8e8 <dev_node_ops+0x410>
ffffffffc0208f94:	d0af70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208f98 <sfs_cleanup>:
ffffffffc0208f98:	1101                	addi	sp,sp,-32
ffffffffc0208f9a:	ec06                	sd	ra,24(sp)
ffffffffc0208f9c:	e822                	sd	s0,16(sp)
ffffffffc0208f9e:	e426                	sd	s1,8(sp)
ffffffffc0208fa0:	e04a                	sd	s2,0(sp)
ffffffffc0208fa2:	c525                	beqz	a0,ffffffffc020900a <sfs_cleanup+0x72>
ffffffffc0208fa4:	0b052783          	lw	a5,176(a0)
ffffffffc0208fa8:	84aa                	mv	s1,a0
ffffffffc0208faa:	e3a5                	bnez	a5,ffffffffc020900a <sfs_cleanup+0x72>
ffffffffc0208fac:	4158                	lw	a4,4(a0)
ffffffffc0208fae:	4514                	lw	a3,8(a0)
ffffffffc0208fb0:	00c50913          	addi	s2,a0,12
ffffffffc0208fb4:	85ca                	mv	a1,s2
ffffffffc0208fb6:	40d7063b          	subw	a2,a4,a3
ffffffffc0208fba:	00006517          	auipc	a0,0x6
ffffffffc0208fbe:	95e50513          	addi	a0,a0,-1698 # ffffffffc020e918 <dev_node_ops+0x440>
ffffffffc0208fc2:	9e4f70ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0208fc6:	02000413          	li	s0,32
ffffffffc0208fca:	a019                	j	ffffffffc0208fd0 <sfs_cleanup+0x38>
ffffffffc0208fcc:	347d                	addiw	s0,s0,-1
ffffffffc0208fce:	c819                	beqz	s0,ffffffffc0208fe4 <sfs_cleanup+0x4c>
ffffffffc0208fd0:	7cdc                	ld	a5,184(s1)
ffffffffc0208fd2:	8526                	mv	a0,s1
ffffffffc0208fd4:	9782                	jalr	a5
ffffffffc0208fd6:	f97d                	bnez	a0,ffffffffc0208fcc <sfs_cleanup+0x34>
ffffffffc0208fd8:	60e2                	ld	ra,24(sp)
ffffffffc0208fda:	6442                	ld	s0,16(sp)
ffffffffc0208fdc:	64a2                	ld	s1,8(sp)
ffffffffc0208fde:	6902                	ld	s2,0(sp)
ffffffffc0208fe0:	6105                	addi	sp,sp,32
ffffffffc0208fe2:	8082                	ret
ffffffffc0208fe4:	6442                	ld	s0,16(sp)
ffffffffc0208fe6:	60e2                	ld	ra,24(sp)
ffffffffc0208fe8:	64a2                	ld	s1,8(sp)
ffffffffc0208fea:	86ca                	mv	a3,s2
ffffffffc0208fec:	6902                	ld	s2,0(sp)
ffffffffc0208fee:	872a                	mv	a4,a0
ffffffffc0208ff0:	00006617          	auipc	a2,0x6
ffffffffc0208ff4:	94860613          	addi	a2,a2,-1720 # ffffffffc020e938 <dev_node_ops+0x460>
ffffffffc0208ff8:	05f00593          	li	a1,95
ffffffffc0208ffc:	00006517          	auipc	a0,0x6
ffffffffc0209000:	8ec50513          	addi	a0,a0,-1812 # ffffffffc020e8e8 <dev_node_ops+0x410>
ffffffffc0209004:	6105                	addi	sp,sp,32
ffffffffc0209006:	d00f706f          	j	ffffffffc0200506 <__warn>
ffffffffc020900a:	00006697          	auipc	a3,0x6
ffffffffc020900e:	8ae68693          	addi	a3,a3,-1874 # ffffffffc020e8b8 <dev_node_ops+0x3e0>
ffffffffc0209012:	00002617          	auipc	a2,0x2
ffffffffc0209016:	66660613          	addi	a2,a2,1638 # ffffffffc020b678 <commands+0x210>
ffffffffc020901a:	05400593          	li	a1,84
ffffffffc020901e:	00006517          	auipc	a0,0x6
ffffffffc0209022:	8ca50513          	addi	a0,a0,-1846 # ffffffffc020e8e8 <dev_node_ops+0x410>
ffffffffc0209026:	c78f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020902a <sfs_sync>:
ffffffffc020902a:	7179                	addi	sp,sp,-48
ffffffffc020902c:	f406                	sd	ra,40(sp)
ffffffffc020902e:	f022                	sd	s0,32(sp)
ffffffffc0209030:	ec26                	sd	s1,24(sp)
ffffffffc0209032:	e84a                	sd	s2,16(sp)
ffffffffc0209034:	e44e                	sd	s3,8(sp)
ffffffffc0209036:	e052                	sd	s4,0(sp)
ffffffffc0209038:	cd4d                	beqz	a0,ffffffffc02090f2 <sfs_sync+0xc8>
ffffffffc020903a:	0b052783          	lw	a5,176(a0)
ffffffffc020903e:	8a2a                	mv	s4,a0
ffffffffc0209040:	ebcd                	bnez	a5,ffffffffc02090f2 <sfs_sync+0xc8>
ffffffffc0209042:	3ff010ef          	jal	ra,ffffffffc020ac40 <lock_sfs_fs>
ffffffffc0209046:	0a0a3403          	ld	s0,160(s4)
ffffffffc020904a:	098a0913          	addi	s2,s4,152
ffffffffc020904e:	02890763          	beq	s2,s0,ffffffffc020907c <sfs_sync+0x52>
ffffffffc0209052:	00004997          	auipc	s3,0x4
ffffffffc0209056:	f9e98993          	addi	s3,s3,-98 # ffffffffc020cff0 <default_pmm_manager+0xe90>
ffffffffc020905a:	7c1c                	ld	a5,56(s0)
ffffffffc020905c:	fc840493          	addi	s1,s0,-56
ffffffffc0209060:	cbb5                	beqz	a5,ffffffffc02090d4 <sfs_sync+0xaa>
ffffffffc0209062:	7b9c                	ld	a5,48(a5)
ffffffffc0209064:	cba5                	beqz	a5,ffffffffc02090d4 <sfs_sync+0xaa>
ffffffffc0209066:	85ce                	mv	a1,s3
ffffffffc0209068:	8526                	mv	a0,s1
ffffffffc020906a:	e28fe0ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc020906e:	7c1c                	ld	a5,56(s0)
ffffffffc0209070:	8526                	mv	a0,s1
ffffffffc0209072:	7b9c                	ld	a5,48(a5)
ffffffffc0209074:	9782                	jalr	a5
ffffffffc0209076:	6400                	ld	s0,8(s0)
ffffffffc0209078:	fe8911e3          	bne	s2,s0,ffffffffc020905a <sfs_sync+0x30>
ffffffffc020907c:	8552                	mv	a0,s4
ffffffffc020907e:	3d3010ef          	jal	ra,ffffffffc020ac50 <unlock_sfs_fs>
ffffffffc0209082:	040a3783          	ld	a5,64(s4)
ffffffffc0209086:	4501                	li	a0,0
ffffffffc0209088:	eb89                	bnez	a5,ffffffffc020909a <sfs_sync+0x70>
ffffffffc020908a:	70a2                	ld	ra,40(sp)
ffffffffc020908c:	7402                	ld	s0,32(sp)
ffffffffc020908e:	64e2                	ld	s1,24(sp)
ffffffffc0209090:	6942                	ld	s2,16(sp)
ffffffffc0209092:	69a2                	ld	s3,8(sp)
ffffffffc0209094:	6a02                	ld	s4,0(sp)
ffffffffc0209096:	6145                	addi	sp,sp,48
ffffffffc0209098:	8082                	ret
ffffffffc020909a:	040a3023          	sd	zero,64(s4)
ffffffffc020909e:	8552                	mv	a0,s4
ffffffffc02090a0:	285010ef          	jal	ra,ffffffffc020ab24 <sfs_sync_super>
ffffffffc02090a4:	cd01                	beqz	a0,ffffffffc02090bc <sfs_sync+0x92>
ffffffffc02090a6:	70a2                	ld	ra,40(sp)
ffffffffc02090a8:	7402                	ld	s0,32(sp)
ffffffffc02090aa:	4785                	li	a5,1
ffffffffc02090ac:	04fa3023          	sd	a5,64(s4)
ffffffffc02090b0:	64e2                	ld	s1,24(sp)
ffffffffc02090b2:	6942                	ld	s2,16(sp)
ffffffffc02090b4:	69a2                	ld	s3,8(sp)
ffffffffc02090b6:	6a02                	ld	s4,0(sp)
ffffffffc02090b8:	6145                	addi	sp,sp,48
ffffffffc02090ba:	8082                	ret
ffffffffc02090bc:	8552                	mv	a0,s4
ffffffffc02090be:	2ad010ef          	jal	ra,ffffffffc020ab6a <sfs_sync_freemap>
ffffffffc02090c2:	f175                	bnez	a0,ffffffffc02090a6 <sfs_sync+0x7c>
ffffffffc02090c4:	70a2                	ld	ra,40(sp)
ffffffffc02090c6:	7402                	ld	s0,32(sp)
ffffffffc02090c8:	64e2                	ld	s1,24(sp)
ffffffffc02090ca:	6942                	ld	s2,16(sp)
ffffffffc02090cc:	69a2                	ld	s3,8(sp)
ffffffffc02090ce:	6a02                	ld	s4,0(sp)
ffffffffc02090d0:	6145                	addi	sp,sp,48
ffffffffc02090d2:	8082                	ret
ffffffffc02090d4:	00004697          	auipc	a3,0x4
ffffffffc02090d8:	ecc68693          	addi	a3,a3,-308 # ffffffffc020cfa0 <default_pmm_manager+0xe40>
ffffffffc02090dc:	00002617          	auipc	a2,0x2
ffffffffc02090e0:	59c60613          	addi	a2,a2,1436 # ffffffffc020b678 <commands+0x210>
ffffffffc02090e4:	45ed                	li	a1,27
ffffffffc02090e6:	00006517          	auipc	a0,0x6
ffffffffc02090ea:	80250513          	addi	a0,a0,-2046 # ffffffffc020e8e8 <dev_node_ops+0x410>
ffffffffc02090ee:	bb0f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02090f2:	00005697          	auipc	a3,0x5
ffffffffc02090f6:	7c668693          	addi	a3,a3,1990 # ffffffffc020e8b8 <dev_node_ops+0x3e0>
ffffffffc02090fa:	00002617          	auipc	a2,0x2
ffffffffc02090fe:	57e60613          	addi	a2,a2,1406 # ffffffffc020b678 <commands+0x210>
ffffffffc0209102:	45d5                	li	a1,21
ffffffffc0209104:	00005517          	auipc	a0,0x5
ffffffffc0209108:	7e450513          	addi	a0,a0,2020 # ffffffffc020e8e8 <dev_node_ops+0x410>
ffffffffc020910c:	b92f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209110 <sfs_get_root>:
ffffffffc0209110:	1101                	addi	sp,sp,-32
ffffffffc0209112:	ec06                	sd	ra,24(sp)
ffffffffc0209114:	cd09                	beqz	a0,ffffffffc020912e <sfs_get_root+0x1e>
ffffffffc0209116:	0b052783          	lw	a5,176(a0)
ffffffffc020911a:	eb91                	bnez	a5,ffffffffc020912e <sfs_get_root+0x1e>
ffffffffc020911c:	4605                	li	a2,1
ffffffffc020911e:	002c                	addi	a1,sp,8
ffffffffc0209120:	2f6010ef          	jal	ra,ffffffffc020a416 <sfs_load_inode>
ffffffffc0209124:	e50d                	bnez	a0,ffffffffc020914e <sfs_get_root+0x3e>
ffffffffc0209126:	60e2                	ld	ra,24(sp)
ffffffffc0209128:	6522                	ld	a0,8(sp)
ffffffffc020912a:	6105                	addi	sp,sp,32
ffffffffc020912c:	8082                	ret
ffffffffc020912e:	00005697          	auipc	a3,0x5
ffffffffc0209132:	78a68693          	addi	a3,a3,1930 # ffffffffc020e8b8 <dev_node_ops+0x3e0>
ffffffffc0209136:	00002617          	auipc	a2,0x2
ffffffffc020913a:	54260613          	addi	a2,a2,1346 # ffffffffc020b678 <commands+0x210>
ffffffffc020913e:	03600593          	li	a1,54
ffffffffc0209142:	00005517          	auipc	a0,0x5
ffffffffc0209146:	7a650513          	addi	a0,a0,1958 # ffffffffc020e8e8 <dev_node_ops+0x410>
ffffffffc020914a:	b54f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020914e:	86aa                	mv	a3,a0
ffffffffc0209150:	00006617          	auipc	a2,0x6
ffffffffc0209154:	80860613          	addi	a2,a2,-2040 # ffffffffc020e958 <dev_node_ops+0x480>
ffffffffc0209158:	03700593          	li	a1,55
ffffffffc020915c:	00005517          	auipc	a0,0x5
ffffffffc0209160:	78c50513          	addi	a0,a0,1932 # ffffffffc020e8e8 <dev_node_ops+0x410>
ffffffffc0209164:	b3af70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209168 <sfs_do_mount>:
ffffffffc0209168:	6518                	ld	a4,8(a0)
ffffffffc020916a:	7171                	addi	sp,sp,-176
ffffffffc020916c:	f506                	sd	ra,168(sp)
ffffffffc020916e:	f122                	sd	s0,160(sp)
ffffffffc0209170:	ed26                	sd	s1,152(sp)
ffffffffc0209172:	e94a                	sd	s2,144(sp)
ffffffffc0209174:	e54e                	sd	s3,136(sp)
ffffffffc0209176:	e152                	sd	s4,128(sp)
ffffffffc0209178:	fcd6                	sd	s5,120(sp)
ffffffffc020917a:	f8da                	sd	s6,112(sp)
ffffffffc020917c:	f4de                	sd	s7,104(sp)
ffffffffc020917e:	f0e2                	sd	s8,96(sp)
ffffffffc0209180:	ece6                	sd	s9,88(sp)
ffffffffc0209182:	e8ea                	sd	s10,80(sp)
ffffffffc0209184:	e4ee                	sd	s11,72(sp)
ffffffffc0209186:	6785                	lui	a5,0x1
ffffffffc0209188:	24f71663          	bne	a4,a5,ffffffffc02093d4 <sfs_do_mount+0x26c>
ffffffffc020918c:	892a                	mv	s2,a0
ffffffffc020918e:	4501                	li	a0,0
ffffffffc0209190:	8aae                	mv	s5,a1
ffffffffc0209192:	f00fe0ef          	jal	ra,ffffffffc0207892 <__alloc_fs>
ffffffffc0209196:	842a                	mv	s0,a0
ffffffffc0209198:	24050463          	beqz	a0,ffffffffc02093e0 <sfs_do_mount+0x278>
ffffffffc020919c:	0b052b03          	lw	s6,176(a0)
ffffffffc02091a0:	260b1263          	bnez	s6,ffffffffc0209404 <sfs_do_mount+0x29c>
ffffffffc02091a4:	03253823          	sd	s2,48(a0)
ffffffffc02091a8:	6505                	lui	a0,0x1
ffffffffc02091aa:	de5f80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02091ae:	e428                	sd	a0,72(s0)
ffffffffc02091b0:	84aa                	mv	s1,a0
ffffffffc02091b2:	16050363          	beqz	a0,ffffffffc0209318 <sfs_do_mount+0x1b0>
ffffffffc02091b6:	85aa                	mv	a1,a0
ffffffffc02091b8:	4681                	li	a3,0
ffffffffc02091ba:	6605                	lui	a2,0x1
ffffffffc02091bc:	1008                	addi	a0,sp,32
ffffffffc02091be:	a02fc0ef          	jal	ra,ffffffffc02053c0 <iobuf_init>
ffffffffc02091c2:	02093783          	ld	a5,32(s2)
ffffffffc02091c6:	85aa                	mv	a1,a0
ffffffffc02091c8:	4601                	li	a2,0
ffffffffc02091ca:	854a                	mv	a0,s2
ffffffffc02091cc:	9782                	jalr	a5
ffffffffc02091ce:	8a2a                	mv	s4,a0
ffffffffc02091d0:	10051e63          	bnez	a0,ffffffffc02092ec <sfs_do_mount+0x184>
ffffffffc02091d4:	408c                	lw	a1,0(s1)
ffffffffc02091d6:	2f8dc637          	lui	a2,0x2f8dc
ffffffffc02091da:	e2a60613          	addi	a2,a2,-470 # 2f8dbe2a <_binary_bin_sfs_img_size+0x2f866b2a>
ffffffffc02091de:	14c59863          	bne	a1,a2,ffffffffc020932e <sfs_do_mount+0x1c6>
ffffffffc02091e2:	40dc                	lw	a5,4(s1)
ffffffffc02091e4:	00093603          	ld	a2,0(s2)
ffffffffc02091e8:	02079713          	slli	a4,a5,0x20
ffffffffc02091ec:	9301                	srli	a4,a4,0x20
ffffffffc02091ee:	12e66763          	bltu	a2,a4,ffffffffc020931c <sfs_do_mount+0x1b4>
ffffffffc02091f2:	020485a3          	sb	zero,43(s1)
ffffffffc02091f6:	0084af03          	lw	t5,8(s1)
ffffffffc02091fa:	00c4ae83          	lw	t4,12(s1)
ffffffffc02091fe:	0104ae03          	lw	t3,16(s1)
ffffffffc0209202:	0144a303          	lw	t1,20(s1)
ffffffffc0209206:	0184a883          	lw	a7,24(s1)
ffffffffc020920a:	01c4a803          	lw	a6,28(s1)
ffffffffc020920e:	5090                	lw	a2,32(s1)
ffffffffc0209210:	50d4                	lw	a3,36(s1)
ffffffffc0209212:	5498                	lw	a4,40(s1)
ffffffffc0209214:	6511                	lui	a0,0x4
ffffffffc0209216:	c00c                	sw	a1,0(s0)
ffffffffc0209218:	c05c                	sw	a5,4(s0)
ffffffffc020921a:	01e42423          	sw	t5,8(s0)
ffffffffc020921e:	01d42623          	sw	t4,12(s0)
ffffffffc0209222:	01c42823          	sw	t3,16(s0)
ffffffffc0209226:	00642a23          	sw	t1,20(s0)
ffffffffc020922a:	01142c23          	sw	a7,24(s0)
ffffffffc020922e:	01042e23          	sw	a6,28(s0)
ffffffffc0209232:	d010                	sw	a2,32(s0)
ffffffffc0209234:	d054                	sw	a3,36(s0)
ffffffffc0209236:	d418                	sw	a4,40(s0)
ffffffffc0209238:	d57f80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020923c:	f448                	sd	a0,168(s0)
ffffffffc020923e:	8c2a                	mv	s8,a0
ffffffffc0209240:	18050c63          	beqz	a0,ffffffffc02093d8 <sfs_do_mount+0x270>
ffffffffc0209244:	6711                	lui	a4,0x4
ffffffffc0209246:	87aa                	mv	a5,a0
ffffffffc0209248:	972a                	add	a4,a4,a0
ffffffffc020924a:	e79c                	sd	a5,8(a5)
ffffffffc020924c:	e39c                	sd	a5,0(a5)
ffffffffc020924e:	07c1                	addi	a5,a5,16
ffffffffc0209250:	fee79de3          	bne	a5,a4,ffffffffc020924a <sfs_do_mount+0xe2>
ffffffffc0209254:	0044eb83          	lwu	s7,4(s1)
ffffffffc0209258:	67a1                	lui	a5,0x8
ffffffffc020925a:	fff78993          	addi	s3,a5,-1 # 7fff <_binary_bin_swap_img_size+0x2ff>
ffffffffc020925e:	9bce                	add	s7,s7,s3
ffffffffc0209260:	77e1                	lui	a5,0xffff8
ffffffffc0209262:	00fbfbb3          	and	s7,s7,a5
ffffffffc0209266:	2b81                	sext.w	s7,s7
ffffffffc0209268:	855e                	mv	a0,s7
ffffffffc020926a:	a59ff0ef          	jal	ra,ffffffffc0208cc2 <bitmap_create>
ffffffffc020926e:	fc08                	sd	a0,56(s0)
ffffffffc0209270:	8d2a                	mv	s10,a0
ffffffffc0209272:	14050f63          	beqz	a0,ffffffffc02093d0 <sfs_do_mount+0x268>
ffffffffc0209276:	0044e783          	lwu	a5,4(s1)
ffffffffc020927a:	082c                	addi	a1,sp,24
ffffffffc020927c:	97ce                	add	a5,a5,s3
ffffffffc020927e:	00f7d713          	srli	a4,a5,0xf
ffffffffc0209282:	e43a                	sd	a4,8(sp)
ffffffffc0209284:	40f7d993          	srai	s3,a5,0xf
ffffffffc0209288:	c4fff0ef          	jal	ra,ffffffffc0208ed6 <bitmap_getdata>
ffffffffc020928c:	14050c63          	beqz	a0,ffffffffc02093e4 <sfs_do_mount+0x27c>
ffffffffc0209290:	00c9979b          	slliw	a5,s3,0xc
ffffffffc0209294:	66e2                	ld	a3,24(sp)
ffffffffc0209296:	1782                	slli	a5,a5,0x20
ffffffffc0209298:	9381                	srli	a5,a5,0x20
ffffffffc020929a:	14d79563          	bne	a5,a3,ffffffffc02093e4 <sfs_do_mount+0x27c>
ffffffffc020929e:	6722                	ld	a4,8(sp)
ffffffffc02092a0:	6d89                	lui	s11,0x2
ffffffffc02092a2:	89aa                	mv	s3,a0
ffffffffc02092a4:	00c71c93          	slli	s9,a4,0xc
ffffffffc02092a8:	9caa                	add	s9,s9,a0
ffffffffc02092aa:	40ad8dbb          	subw	s11,s11,a0
ffffffffc02092ae:	e711                	bnez	a4,ffffffffc02092ba <sfs_do_mount+0x152>
ffffffffc02092b0:	a079                	j	ffffffffc020933e <sfs_do_mount+0x1d6>
ffffffffc02092b2:	6785                	lui	a5,0x1
ffffffffc02092b4:	99be                	add	s3,s3,a5
ffffffffc02092b6:	093c8463          	beq	s9,s3,ffffffffc020933e <sfs_do_mount+0x1d6>
ffffffffc02092ba:	013d86bb          	addw	a3,s11,s3
ffffffffc02092be:	1682                	slli	a3,a3,0x20
ffffffffc02092c0:	6605                	lui	a2,0x1
ffffffffc02092c2:	85ce                	mv	a1,s3
ffffffffc02092c4:	9281                	srli	a3,a3,0x20
ffffffffc02092c6:	1008                	addi	a0,sp,32
ffffffffc02092c8:	8f8fc0ef          	jal	ra,ffffffffc02053c0 <iobuf_init>
ffffffffc02092cc:	02093783          	ld	a5,32(s2)
ffffffffc02092d0:	85aa                	mv	a1,a0
ffffffffc02092d2:	4601                	li	a2,0
ffffffffc02092d4:	854a                	mv	a0,s2
ffffffffc02092d6:	9782                	jalr	a5
ffffffffc02092d8:	dd69                	beqz	a0,ffffffffc02092b2 <sfs_do_mount+0x14a>
ffffffffc02092da:	e42a                	sd	a0,8(sp)
ffffffffc02092dc:	856a                	mv	a0,s10
ffffffffc02092de:	bdfff0ef          	jal	ra,ffffffffc0208ebc <bitmap_destroy>
ffffffffc02092e2:	67a2                	ld	a5,8(sp)
ffffffffc02092e4:	8a3e                	mv	s4,a5
ffffffffc02092e6:	8562                	mv	a0,s8
ffffffffc02092e8:	d57f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02092ec:	8526                	mv	a0,s1
ffffffffc02092ee:	d51f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02092f2:	8522                	mv	a0,s0
ffffffffc02092f4:	d4bf80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02092f8:	70aa                	ld	ra,168(sp)
ffffffffc02092fa:	740a                	ld	s0,160(sp)
ffffffffc02092fc:	64ea                	ld	s1,152(sp)
ffffffffc02092fe:	694a                	ld	s2,144(sp)
ffffffffc0209300:	69aa                	ld	s3,136(sp)
ffffffffc0209302:	7ae6                	ld	s5,120(sp)
ffffffffc0209304:	7b46                	ld	s6,112(sp)
ffffffffc0209306:	7ba6                	ld	s7,104(sp)
ffffffffc0209308:	7c06                	ld	s8,96(sp)
ffffffffc020930a:	6ce6                	ld	s9,88(sp)
ffffffffc020930c:	6d46                	ld	s10,80(sp)
ffffffffc020930e:	6da6                	ld	s11,72(sp)
ffffffffc0209310:	8552                	mv	a0,s4
ffffffffc0209312:	6a0a                	ld	s4,128(sp)
ffffffffc0209314:	614d                	addi	sp,sp,176
ffffffffc0209316:	8082                	ret
ffffffffc0209318:	5a71                	li	s4,-4
ffffffffc020931a:	bfe1                	j	ffffffffc02092f2 <sfs_do_mount+0x18a>
ffffffffc020931c:	85be                	mv	a1,a5
ffffffffc020931e:	00005517          	auipc	a0,0x5
ffffffffc0209322:	69250513          	addi	a0,a0,1682 # ffffffffc020e9b0 <dev_node_ops+0x4d8>
ffffffffc0209326:	e81f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020932a:	5a75                	li	s4,-3
ffffffffc020932c:	b7c1                	j	ffffffffc02092ec <sfs_do_mount+0x184>
ffffffffc020932e:	00005517          	auipc	a0,0x5
ffffffffc0209332:	64a50513          	addi	a0,a0,1610 # ffffffffc020e978 <dev_node_ops+0x4a0>
ffffffffc0209336:	e71f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020933a:	5a75                	li	s4,-3
ffffffffc020933c:	bf45                	j	ffffffffc02092ec <sfs_do_mount+0x184>
ffffffffc020933e:	00442903          	lw	s2,4(s0)
ffffffffc0209342:	4481                	li	s1,0
ffffffffc0209344:	080b8c63          	beqz	s7,ffffffffc02093dc <sfs_do_mount+0x274>
ffffffffc0209348:	85a6                	mv	a1,s1
ffffffffc020934a:	856a                	mv	a0,s10
ffffffffc020934c:	af7ff0ef          	jal	ra,ffffffffc0208e42 <bitmap_test>
ffffffffc0209350:	c111                	beqz	a0,ffffffffc0209354 <sfs_do_mount+0x1ec>
ffffffffc0209352:	2b05                	addiw	s6,s6,1
ffffffffc0209354:	2485                	addiw	s1,s1,1
ffffffffc0209356:	fe9b99e3          	bne	s7,s1,ffffffffc0209348 <sfs_do_mount+0x1e0>
ffffffffc020935a:	441c                	lw	a5,8(s0)
ffffffffc020935c:	0d679463          	bne	a5,s6,ffffffffc0209424 <sfs_do_mount+0x2bc>
ffffffffc0209360:	4585                	li	a1,1
ffffffffc0209362:	05040513          	addi	a0,s0,80
ffffffffc0209366:	04043023          	sd	zero,64(s0)
ffffffffc020936a:	9cefb0ef          	jal	ra,ffffffffc0204538 <sem_init>
ffffffffc020936e:	4585                	li	a1,1
ffffffffc0209370:	06840513          	addi	a0,s0,104
ffffffffc0209374:	9c4fb0ef          	jal	ra,ffffffffc0204538 <sem_init>
ffffffffc0209378:	4585                	li	a1,1
ffffffffc020937a:	08040513          	addi	a0,s0,128
ffffffffc020937e:	9bafb0ef          	jal	ra,ffffffffc0204538 <sem_init>
ffffffffc0209382:	09840793          	addi	a5,s0,152
ffffffffc0209386:	f05c                	sd	a5,160(s0)
ffffffffc0209388:	ec5c                	sd	a5,152(s0)
ffffffffc020938a:	874a                	mv	a4,s2
ffffffffc020938c:	86da                	mv	a3,s6
ffffffffc020938e:	4169063b          	subw	a2,s2,s6
ffffffffc0209392:	00c40593          	addi	a1,s0,12
ffffffffc0209396:	00005517          	auipc	a0,0x5
ffffffffc020939a:	6aa50513          	addi	a0,a0,1706 # ffffffffc020ea40 <dev_node_ops+0x568>
ffffffffc020939e:	e09f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02093a2:	00000797          	auipc	a5,0x0
ffffffffc02093a6:	c8878793          	addi	a5,a5,-888 # ffffffffc020902a <sfs_sync>
ffffffffc02093aa:	fc5c                	sd	a5,184(s0)
ffffffffc02093ac:	00000797          	auipc	a5,0x0
ffffffffc02093b0:	d6478793          	addi	a5,a5,-668 # ffffffffc0209110 <sfs_get_root>
ffffffffc02093b4:	e07c                	sd	a5,192(s0)
ffffffffc02093b6:	00000797          	auipc	a5,0x0
ffffffffc02093ba:	b5e78793          	addi	a5,a5,-1186 # ffffffffc0208f14 <sfs_unmount>
ffffffffc02093be:	e47c                	sd	a5,200(s0)
ffffffffc02093c0:	00000797          	auipc	a5,0x0
ffffffffc02093c4:	bd878793          	addi	a5,a5,-1064 # ffffffffc0208f98 <sfs_cleanup>
ffffffffc02093c8:	e87c                	sd	a5,208(s0)
ffffffffc02093ca:	008ab023          	sd	s0,0(s5)
ffffffffc02093ce:	b72d                	j	ffffffffc02092f8 <sfs_do_mount+0x190>
ffffffffc02093d0:	5a71                	li	s4,-4
ffffffffc02093d2:	bf11                	j	ffffffffc02092e6 <sfs_do_mount+0x17e>
ffffffffc02093d4:	5a49                	li	s4,-14
ffffffffc02093d6:	b70d                	j	ffffffffc02092f8 <sfs_do_mount+0x190>
ffffffffc02093d8:	5a71                	li	s4,-4
ffffffffc02093da:	bf09                	j	ffffffffc02092ec <sfs_do_mount+0x184>
ffffffffc02093dc:	4b01                	li	s6,0
ffffffffc02093de:	bfb5                	j	ffffffffc020935a <sfs_do_mount+0x1f2>
ffffffffc02093e0:	5a71                	li	s4,-4
ffffffffc02093e2:	bf19                	j	ffffffffc02092f8 <sfs_do_mount+0x190>
ffffffffc02093e4:	00005697          	auipc	a3,0x5
ffffffffc02093e8:	5fc68693          	addi	a3,a3,1532 # ffffffffc020e9e0 <dev_node_ops+0x508>
ffffffffc02093ec:	00002617          	auipc	a2,0x2
ffffffffc02093f0:	28c60613          	addi	a2,a2,652 # ffffffffc020b678 <commands+0x210>
ffffffffc02093f4:	08300593          	li	a1,131
ffffffffc02093f8:	00005517          	auipc	a0,0x5
ffffffffc02093fc:	4f050513          	addi	a0,a0,1264 # ffffffffc020e8e8 <dev_node_ops+0x410>
ffffffffc0209400:	89ef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209404:	00005697          	auipc	a3,0x5
ffffffffc0209408:	4b468693          	addi	a3,a3,1204 # ffffffffc020e8b8 <dev_node_ops+0x3e0>
ffffffffc020940c:	00002617          	auipc	a2,0x2
ffffffffc0209410:	26c60613          	addi	a2,a2,620 # ffffffffc020b678 <commands+0x210>
ffffffffc0209414:	0a300593          	li	a1,163
ffffffffc0209418:	00005517          	auipc	a0,0x5
ffffffffc020941c:	4d050513          	addi	a0,a0,1232 # ffffffffc020e8e8 <dev_node_ops+0x410>
ffffffffc0209420:	87ef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209424:	00005697          	auipc	a3,0x5
ffffffffc0209428:	5ec68693          	addi	a3,a3,1516 # ffffffffc020ea10 <dev_node_ops+0x538>
ffffffffc020942c:	00002617          	auipc	a2,0x2
ffffffffc0209430:	24c60613          	addi	a2,a2,588 # ffffffffc020b678 <commands+0x210>
ffffffffc0209434:	0e000593          	li	a1,224
ffffffffc0209438:	00005517          	auipc	a0,0x5
ffffffffc020943c:	4b050513          	addi	a0,a0,1200 # ffffffffc020e8e8 <dev_node_ops+0x410>
ffffffffc0209440:	85ef70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209444 <sfs_mount>:
ffffffffc0209444:	00000597          	auipc	a1,0x0
ffffffffc0209448:	d2458593          	addi	a1,a1,-732 # ffffffffc0209168 <sfs_do_mount>
ffffffffc020944c:	817fe06f          	j	ffffffffc0207c62 <vfs_mount>

ffffffffc0209450 <sfs_opendir>:
ffffffffc0209450:	0235f593          	andi	a1,a1,35
ffffffffc0209454:	4501                	li	a0,0
ffffffffc0209456:	e191                	bnez	a1,ffffffffc020945a <sfs_opendir+0xa>
ffffffffc0209458:	8082                	ret
ffffffffc020945a:	553d                	li	a0,-17
ffffffffc020945c:	8082                	ret

ffffffffc020945e <sfs_openfile>:
ffffffffc020945e:	4501                	li	a0,0
ffffffffc0209460:	8082                	ret

ffffffffc0209462 <sfs_gettype>:
ffffffffc0209462:	1141                	addi	sp,sp,-16
ffffffffc0209464:	e406                	sd	ra,8(sp)
ffffffffc0209466:	c939                	beqz	a0,ffffffffc02094bc <sfs_gettype+0x5a>
ffffffffc0209468:	4d34                	lw	a3,88(a0)
ffffffffc020946a:	6785                	lui	a5,0x1
ffffffffc020946c:	23578713          	addi	a4,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209470:	04e69663          	bne	a3,a4,ffffffffc02094bc <sfs_gettype+0x5a>
ffffffffc0209474:	6114                	ld	a3,0(a0)
ffffffffc0209476:	4709                	li	a4,2
ffffffffc0209478:	0046d683          	lhu	a3,4(a3)
ffffffffc020947c:	02e68a63          	beq	a3,a4,ffffffffc02094b0 <sfs_gettype+0x4e>
ffffffffc0209480:	470d                	li	a4,3
ffffffffc0209482:	02e68163          	beq	a3,a4,ffffffffc02094a4 <sfs_gettype+0x42>
ffffffffc0209486:	4705                	li	a4,1
ffffffffc0209488:	00e68f63          	beq	a3,a4,ffffffffc02094a6 <sfs_gettype+0x44>
ffffffffc020948c:	00005617          	auipc	a2,0x5
ffffffffc0209490:	62460613          	addi	a2,a2,1572 # ffffffffc020eab0 <dev_node_ops+0x5d8>
ffffffffc0209494:	37d00593          	li	a1,893
ffffffffc0209498:	00005517          	auipc	a0,0x5
ffffffffc020949c:	60050513          	addi	a0,a0,1536 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc02094a0:	ffff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02094a4:	678d                	lui	a5,0x3
ffffffffc02094a6:	60a2                	ld	ra,8(sp)
ffffffffc02094a8:	c19c                	sw	a5,0(a1)
ffffffffc02094aa:	4501                	li	a0,0
ffffffffc02094ac:	0141                	addi	sp,sp,16
ffffffffc02094ae:	8082                	ret
ffffffffc02094b0:	60a2                	ld	ra,8(sp)
ffffffffc02094b2:	6789                	lui	a5,0x2
ffffffffc02094b4:	c19c                	sw	a5,0(a1)
ffffffffc02094b6:	4501                	li	a0,0
ffffffffc02094b8:	0141                	addi	sp,sp,16
ffffffffc02094ba:	8082                	ret
ffffffffc02094bc:	00005697          	auipc	a3,0x5
ffffffffc02094c0:	5a468693          	addi	a3,a3,1444 # ffffffffc020ea60 <dev_node_ops+0x588>
ffffffffc02094c4:	00002617          	auipc	a2,0x2
ffffffffc02094c8:	1b460613          	addi	a2,a2,436 # ffffffffc020b678 <commands+0x210>
ffffffffc02094cc:	37100593          	li	a1,881
ffffffffc02094d0:	00005517          	auipc	a0,0x5
ffffffffc02094d4:	5c850513          	addi	a0,a0,1480 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc02094d8:	fc7f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02094dc <sfs_fsync>:
ffffffffc02094dc:	7179                	addi	sp,sp,-48
ffffffffc02094de:	ec26                	sd	s1,24(sp)
ffffffffc02094e0:	7524                	ld	s1,104(a0)
ffffffffc02094e2:	f406                	sd	ra,40(sp)
ffffffffc02094e4:	f022                	sd	s0,32(sp)
ffffffffc02094e6:	e84a                	sd	s2,16(sp)
ffffffffc02094e8:	e44e                	sd	s3,8(sp)
ffffffffc02094ea:	c4bd                	beqz	s1,ffffffffc0209558 <sfs_fsync+0x7c>
ffffffffc02094ec:	0b04a783          	lw	a5,176(s1)
ffffffffc02094f0:	e7a5                	bnez	a5,ffffffffc0209558 <sfs_fsync+0x7c>
ffffffffc02094f2:	4d38                	lw	a4,88(a0)
ffffffffc02094f4:	6785                	lui	a5,0x1
ffffffffc02094f6:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02094fa:	842a                	mv	s0,a0
ffffffffc02094fc:	06f71e63          	bne	a4,a5,ffffffffc0209578 <sfs_fsync+0x9c>
ffffffffc0209500:	691c                	ld	a5,16(a0)
ffffffffc0209502:	4901                	li	s2,0
ffffffffc0209504:	eb89                	bnez	a5,ffffffffc0209516 <sfs_fsync+0x3a>
ffffffffc0209506:	70a2                	ld	ra,40(sp)
ffffffffc0209508:	7402                	ld	s0,32(sp)
ffffffffc020950a:	64e2                	ld	s1,24(sp)
ffffffffc020950c:	69a2                	ld	s3,8(sp)
ffffffffc020950e:	854a                	mv	a0,s2
ffffffffc0209510:	6942                	ld	s2,16(sp)
ffffffffc0209512:	6145                	addi	sp,sp,48
ffffffffc0209514:	8082                	ret
ffffffffc0209516:	02050993          	addi	s3,a0,32
ffffffffc020951a:	854e                	mv	a0,s3
ffffffffc020951c:	826fb0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc0209520:	681c                	ld	a5,16(s0)
ffffffffc0209522:	ef81                	bnez	a5,ffffffffc020953a <sfs_fsync+0x5e>
ffffffffc0209524:	854e                	mv	a0,s3
ffffffffc0209526:	818fb0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc020952a:	70a2                	ld	ra,40(sp)
ffffffffc020952c:	7402                	ld	s0,32(sp)
ffffffffc020952e:	64e2                	ld	s1,24(sp)
ffffffffc0209530:	69a2                	ld	s3,8(sp)
ffffffffc0209532:	854a                	mv	a0,s2
ffffffffc0209534:	6942                	ld	s2,16(sp)
ffffffffc0209536:	6145                	addi	sp,sp,48
ffffffffc0209538:	8082                	ret
ffffffffc020953a:	4414                	lw	a3,8(s0)
ffffffffc020953c:	600c                	ld	a1,0(s0)
ffffffffc020953e:	00043823          	sd	zero,16(s0)
ffffffffc0209542:	4701                	li	a4,0
ffffffffc0209544:	04000613          	li	a2,64
ffffffffc0209548:	8526                	mv	a0,s1
ffffffffc020954a:	546010ef          	jal	ra,ffffffffc020aa90 <sfs_wbuf>
ffffffffc020954e:	892a                	mv	s2,a0
ffffffffc0209550:	d971                	beqz	a0,ffffffffc0209524 <sfs_fsync+0x48>
ffffffffc0209552:	4785                	li	a5,1
ffffffffc0209554:	e81c                	sd	a5,16(s0)
ffffffffc0209556:	b7f9                	j	ffffffffc0209524 <sfs_fsync+0x48>
ffffffffc0209558:	00005697          	auipc	a3,0x5
ffffffffc020955c:	36068693          	addi	a3,a3,864 # ffffffffc020e8b8 <dev_node_ops+0x3e0>
ffffffffc0209560:	00002617          	auipc	a2,0x2
ffffffffc0209564:	11860613          	addi	a2,a2,280 # ffffffffc020b678 <commands+0x210>
ffffffffc0209568:	2b500593          	li	a1,693
ffffffffc020956c:	00005517          	auipc	a0,0x5
ffffffffc0209570:	52c50513          	addi	a0,a0,1324 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc0209574:	f2bf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209578:	00005697          	auipc	a3,0x5
ffffffffc020957c:	4e868693          	addi	a3,a3,1256 # ffffffffc020ea60 <dev_node_ops+0x588>
ffffffffc0209580:	00002617          	auipc	a2,0x2
ffffffffc0209584:	0f860613          	addi	a2,a2,248 # ffffffffc020b678 <commands+0x210>
ffffffffc0209588:	2b600593          	li	a1,694
ffffffffc020958c:	00005517          	auipc	a0,0x5
ffffffffc0209590:	50c50513          	addi	a0,a0,1292 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc0209594:	f0bf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209598 <sfs_fstat>:
ffffffffc0209598:	1101                	addi	sp,sp,-32
ffffffffc020959a:	e426                	sd	s1,8(sp)
ffffffffc020959c:	84ae                	mv	s1,a1
ffffffffc020959e:	e822                	sd	s0,16(sp)
ffffffffc02095a0:	02000613          	li	a2,32
ffffffffc02095a4:	842a                	mv	s0,a0
ffffffffc02095a6:	4581                	li	a1,0
ffffffffc02095a8:	8526                	mv	a0,s1
ffffffffc02095aa:	ec06                	sd	ra,24(sp)
ffffffffc02095ac:	3e9010ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc02095b0:	c439                	beqz	s0,ffffffffc02095fe <sfs_fstat+0x66>
ffffffffc02095b2:	783c                	ld	a5,112(s0)
ffffffffc02095b4:	c7a9                	beqz	a5,ffffffffc02095fe <sfs_fstat+0x66>
ffffffffc02095b6:	6bbc                	ld	a5,80(a5)
ffffffffc02095b8:	c3b9                	beqz	a5,ffffffffc02095fe <sfs_fstat+0x66>
ffffffffc02095ba:	00005597          	auipc	a1,0x5
ffffffffc02095be:	e9658593          	addi	a1,a1,-362 # ffffffffc020e450 <syscalls+0xdb0>
ffffffffc02095c2:	8522                	mv	a0,s0
ffffffffc02095c4:	8cefe0ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc02095c8:	783c                	ld	a5,112(s0)
ffffffffc02095ca:	85a6                	mv	a1,s1
ffffffffc02095cc:	8522                	mv	a0,s0
ffffffffc02095ce:	6bbc                	ld	a5,80(a5)
ffffffffc02095d0:	9782                	jalr	a5
ffffffffc02095d2:	e10d                	bnez	a0,ffffffffc02095f4 <sfs_fstat+0x5c>
ffffffffc02095d4:	4c38                	lw	a4,88(s0)
ffffffffc02095d6:	6785                	lui	a5,0x1
ffffffffc02095d8:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02095dc:	04f71163          	bne	a4,a5,ffffffffc020961e <sfs_fstat+0x86>
ffffffffc02095e0:	601c                	ld	a5,0(s0)
ffffffffc02095e2:	0067d683          	lhu	a3,6(a5)
ffffffffc02095e6:	0087e703          	lwu	a4,8(a5)
ffffffffc02095ea:	0007e783          	lwu	a5,0(a5)
ffffffffc02095ee:	e494                	sd	a3,8(s1)
ffffffffc02095f0:	e898                	sd	a4,16(s1)
ffffffffc02095f2:	ec9c                	sd	a5,24(s1)
ffffffffc02095f4:	60e2                	ld	ra,24(sp)
ffffffffc02095f6:	6442                	ld	s0,16(sp)
ffffffffc02095f8:	64a2                	ld	s1,8(sp)
ffffffffc02095fa:	6105                	addi	sp,sp,32
ffffffffc02095fc:	8082                	ret
ffffffffc02095fe:	00005697          	auipc	a3,0x5
ffffffffc0209602:	dea68693          	addi	a3,a3,-534 # ffffffffc020e3e8 <syscalls+0xd48>
ffffffffc0209606:	00002617          	auipc	a2,0x2
ffffffffc020960a:	07260613          	addi	a2,a2,114 # ffffffffc020b678 <commands+0x210>
ffffffffc020960e:	2a600593          	li	a1,678
ffffffffc0209612:	00005517          	auipc	a0,0x5
ffffffffc0209616:	48650513          	addi	a0,a0,1158 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020961a:	e85f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020961e:	00005697          	auipc	a3,0x5
ffffffffc0209622:	44268693          	addi	a3,a3,1090 # ffffffffc020ea60 <dev_node_ops+0x588>
ffffffffc0209626:	00002617          	auipc	a2,0x2
ffffffffc020962a:	05260613          	addi	a2,a2,82 # ffffffffc020b678 <commands+0x210>
ffffffffc020962e:	2a900593          	li	a1,681
ffffffffc0209632:	00005517          	auipc	a0,0x5
ffffffffc0209636:	46650513          	addi	a0,a0,1126 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020963a:	e65f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020963e <sfs_tryseek>:
ffffffffc020963e:	080007b7          	lui	a5,0x8000
ffffffffc0209642:	04f5fd63          	bgeu	a1,a5,ffffffffc020969c <sfs_tryseek+0x5e>
ffffffffc0209646:	1101                	addi	sp,sp,-32
ffffffffc0209648:	e822                	sd	s0,16(sp)
ffffffffc020964a:	ec06                	sd	ra,24(sp)
ffffffffc020964c:	e426                	sd	s1,8(sp)
ffffffffc020964e:	842a                	mv	s0,a0
ffffffffc0209650:	c921                	beqz	a0,ffffffffc02096a0 <sfs_tryseek+0x62>
ffffffffc0209652:	4d38                	lw	a4,88(a0)
ffffffffc0209654:	6785                	lui	a5,0x1
ffffffffc0209656:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020965a:	04f71363          	bne	a4,a5,ffffffffc02096a0 <sfs_tryseek+0x62>
ffffffffc020965e:	611c                	ld	a5,0(a0)
ffffffffc0209660:	84ae                	mv	s1,a1
ffffffffc0209662:	0007e783          	lwu	a5,0(a5)
ffffffffc0209666:	02b7d563          	bge	a5,a1,ffffffffc0209690 <sfs_tryseek+0x52>
ffffffffc020966a:	793c                	ld	a5,112(a0)
ffffffffc020966c:	cbb1                	beqz	a5,ffffffffc02096c0 <sfs_tryseek+0x82>
ffffffffc020966e:	73bc                	ld	a5,96(a5)
ffffffffc0209670:	cba1                	beqz	a5,ffffffffc02096c0 <sfs_tryseek+0x82>
ffffffffc0209672:	00005597          	auipc	a1,0x5
ffffffffc0209676:	cce58593          	addi	a1,a1,-818 # ffffffffc020e340 <syscalls+0xca0>
ffffffffc020967a:	818fe0ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc020967e:	783c                	ld	a5,112(s0)
ffffffffc0209680:	8522                	mv	a0,s0
ffffffffc0209682:	6442                	ld	s0,16(sp)
ffffffffc0209684:	60e2                	ld	ra,24(sp)
ffffffffc0209686:	73bc                	ld	a5,96(a5)
ffffffffc0209688:	85a6                	mv	a1,s1
ffffffffc020968a:	64a2                	ld	s1,8(sp)
ffffffffc020968c:	6105                	addi	sp,sp,32
ffffffffc020968e:	8782                	jr	a5
ffffffffc0209690:	60e2                	ld	ra,24(sp)
ffffffffc0209692:	6442                	ld	s0,16(sp)
ffffffffc0209694:	64a2                	ld	s1,8(sp)
ffffffffc0209696:	4501                	li	a0,0
ffffffffc0209698:	6105                	addi	sp,sp,32
ffffffffc020969a:	8082                	ret
ffffffffc020969c:	5575                	li	a0,-3
ffffffffc020969e:	8082                	ret
ffffffffc02096a0:	00005697          	auipc	a3,0x5
ffffffffc02096a4:	3c068693          	addi	a3,a3,960 # ffffffffc020ea60 <dev_node_ops+0x588>
ffffffffc02096a8:	00002617          	auipc	a2,0x2
ffffffffc02096ac:	fd060613          	addi	a2,a2,-48 # ffffffffc020b678 <commands+0x210>
ffffffffc02096b0:	38800593          	li	a1,904
ffffffffc02096b4:	00005517          	auipc	a0,0x5
ffffffffc02096b8:	3e450513          	addi	a0,a0,996 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc02096bc:	de3f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02096c0:	00005697          	auipc	a3,0x5
ffffffffc02096c4:	c2868693          	addi	a3,a3,-984 # ffffffffc020e2e8 <syscalls+0xc48>
ffffffffc02096c8:	00002617          	auipc	a2,0x2
ffffffffc02096cc:	fb060613          	addi	a2,a2,-80 # ffffffffc020b678 <commands+0x210>
ffffffffc02096d0:	38a00593          	li	a1,906
ffffffffc02096d4:	00005517          	auipc	a0,0x5
ffffffffc02096d8:	3c450513          	addi	a0,a0,964 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc02096dc:	dc3f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02096e0 <sfs_close>:
ffffffffc02096e0:	1141                	addi	sp,sp,-16
ffffffffc02096e2:	e406                	sd	ra,8(sp)
ffffffffc02096e4:	e022                	sd	s0,0(sp)
ffffffffc02096e6:	c11d                	beqz	a0,ffffffffc020970c <sfs_close+0x2c>
ffffffffc02096e8:	793c                	ld	a5,112(a0)
ffffffffc02096ea:	842a                	mv	s0,a0
ffffffffc02096ec:	c385                	beqz	a5,ffffffffc020970c <sfs_close+0x2c>
ffffffffc02096ee:	7b9c                	ld	a5,48(a5)
ffffffffc02096f0:	cf91                	beqz	a5,ffffffffc020970c <sfs_close+0x2c>
ffffffffc02096f2:	00004597          	auipc	a1,0x4
ffffffffc02096f6:	8fe58593          	addi	a1,a1,-1794 # ffffffffc020cff0 <default_pmm_manager+0xe90>
ffffffffc02096fa:	f99fd0ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc02096fe:	783c                	ld	a5,112(s0)
ffffffffc0209700:	8522                	mv	a0,s0
ffffffffc0209702:	6402                	ld	s0,0(sp)
ffffffffc0209704:	60a2                	ld	ra,8(sp)
ffffffffc0209706:	7b9c                	ld	a5,48(a5)
ffffffffc0209708:	0141                	addi	sp,sp,16
ffffffffc020970a:	8782                	jr	a5
ffffffffc020970c:	00004697          	auipc	a3,0x4
ffffffffc0209710:	89468693          	addi	a3,a3,-1900 # ffffffffc020cfa0 <default_pmm_manager+0xe40>
ffffffffc0209714:	00002617          	auipc	a2,0x2
ffffffffc0209718:	f6460613          	addi	a2,a2,-156 # ffffffffc020b678 <commands+0x210>
ffffffffc020971c:	21c00593          	li	a1,540
ffffffffc0209720:	00005517          	auipc	a0,0x5
ffffffffc0209724:	37850513          	addi	a0,a0,888 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc0209728:	d77f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020972c <sfs_io.part.0>:
ffffffffc020972c:	1141                	addi	sp,sp,-16
ffffffffc020972e:	00005697          	auipc	a3,0x5
ffffffffc0209732:	33268693          	addi	a3,a3,818 # ffffffffc020ea60 <dev_node_ops+0x588>
ffffffffc0209736:	00002617          	auipc	a2,0x2
ffffffffc020973a:	f4260613          	addi	a2,a2,-190 # ffffffffc020b678 <commands+0x210>
ffffffffc020973e:	28500593          	li	a1,645
ffffffffc0209742:	00005517          	auipc	a0,0x5
ffffffffc0209746:	35650513          	addi	a0,a0,854 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020974a:	e406                	sd	ra,8(sp)
ffffffffc020974c:	d53f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209750 <sfs_block_free>:
ffffffffc0209750:	1101                	addi	sp,sp,-32
ffffffffc0209752:	e426                	sd	s1,8(sp)
ffffffffc0209754:	ec06                	sd	ra,24(sp)
ffffffffc0209756:	e822                	sd	s0,16(sp)
ffffffffc0209758:	4154                	lw	a3,4(a0)
ffffffffc020975a:	84ae                	mv	s1,a1
ffffffffc020975c:	c595                	beqz	a1,ffffffffc0209788 <sfs_block_free+0x38>
ffffffffc020975e:	02d5f563          	bgeu	a1,a3,ffffffffc0209788 <sfs_block_free+0x38>
ffffffffc0209762:	842a                	mv	s0,a0
ffffffffc0209764:	7d08                	ld	a0,56(a0)
ffffffffc0209766:	edcff0ef          	jal	ra,ffffffffc0208e42 <bitmap_test>
ffffffffc020976a:	ed05                	bnez	a0,ffffffffc02097a2 <sfs_block_free+0x52>
ffffffffc020976c:	7c08                	ld	a0,56(s0)
ffffffffc020976e:	85a6                	mv	a1,s1
ffffffffc0209770:	efaff0ef          	jal	ra,ffffffffc0208e6a <bitmap_free>
ffffffffc0209774:	441c                	lw	a5,8(s0)
ffffffffc0209776:	4705                	li	a4,1
ffffffffc0209778:	60e2                	ld	ra,24(sp)
ffffffffc020977a:	2785                	addiw	a5,a5,1
ffffffffc020977c:	e038                	sd	a4,64(s0)
ffffffffc020977e:	c41c                	sw	a5,8(s0)
ffffffffc0209780:	6442                	ld	s0,16(sp)
ffffffffc0209782:	64a2                	ld	s1,8(sp)
ffffffffc0209784:	6105                	addi	sp,sp,32
ffffffffc0209786:	8082                	ret
ffffffffc0209788:	8726                	mv	a4,s1
ffffffffc020978a:	00005617          	auipc	a2,0x5
ffffffffc020978e:	33e60613          	addi	a2,a2,830 # ffffffffc020eac8 <dev_node_ops+0x5f0>
ffffffffc0209792:	05300593          	li	a1,83
ffffffffc0209796:	00005517          	auipc	a0,0x5
ffffffffc020979a:	30250513          	addi	a0,a0,770 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020979e:	d01f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02097a2:	00005697          	auipc	a3,0x5
ffffffffc02097a6:	35e68693          	addi	a3,a3,862 # ffffffffc020eb00 <dev_node_ops+0x628>
ffffffffc02097aa:	00002617          	auipc	a2,0x2
ffffffffc02097ae:	ece60613          	addi	a2,a2,-306 # ffffffffc020b678 <commands+0x210>
ffffffffc02097b2:	06a00593          	li	a1,106
ffffffffc02097b6:	00005517          	auipc	a0,0x5
ffffffffc02097ba:	2e250513          	addi	a0,a0,738 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc02097be:	ce1f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02097c2 <sfs_reclaim>:
ffffffffc02097c2:	1101                	addi	sp,sp,-32
ffffffffc02097c4:	e426                	sd	s1,8(sp)
ffffffffc02097c6:	7524                	ld	s1,104(a0)
ffffffffc02097c8:	ec06                	sd	ra,24(sp)
ffffffffc02097ca:	e822                	sd	s0,16(sp)
ffffffffc02097cc:	e04a                	sd	s2,0(sp)
ffffffffc02097ce:	0e048a63          	beqz	s1,ffffffffc02098c2 <sfs_reclaim+0x100>
ffffffffc02097d2:	0b04a783          	lw	a5,176(s1)
ffffffffc02097d6:	0e079663          	bnez	a5,ffffffffc02098c2 <sfs_reclaim+0x100>
ffffffffc02097da:	4d38                	lw	a4,88(a0)
ffffffffc02097dc:	6785                	lui	a5,0x1
ffffffffc02097de:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02097e2:	842a                	mv	s0,a0
ffffffffc02097e4:	10f71f63          	bne	a4,a5,ffffffffc0209902 <sfs_reclaim+0x140>
ffffffffc02097e8:	8526                	mv	a0,s1
ffffffffc02097ea:	456010ef          	jal	ra,ffffffffc020ac40 <lock_sfs_fs>
ffffffffc02097ee:	4c1c                	lw	a5,24(s0)
ffffffffc02097f0:	0ef05963          	blez	a5,ffffffffc02098e2 <sfs_reclaim+0x120>
ffffffffc02097f4:	fff7871b          	addiw	a4,a5,-1
ffffffffc02097f8:	cc18                	sw	a4,24(s0)
ffffffffc02097fa:	eb59                	bnez	a4,ffffffffc0209890 <sfs_reclaim+0xce>
ffffffffc02097fc:	05c42903          	lw	s2,92(s0)
ffffffffc0209800:	08091863          	bnez	s2,ffffffffc0209890 <sfs_reclaim+0xce>
ffffffffc0209804:	601c                	ld	a5,0(s0)
ffffffffc0209806:	0067d783          	lhu	a5,6(a5)
ffffffffc020980a:	e785                	bnez	a5,ffffffffc0209832 <sfs_reclaim+0x70>
ffffffffc020980c:	783c                	ld	a5,112(s0)
ffffffffc020980e:	10078a63          	beqz	a5,ffffffffc0209922 <sfs_reclaim+0x160>
ffffffffc0209812:	73bc                	ld	a5,96(a5)
ffffffffc0209814:	10078763          	beqz	a5,ffffffffc0209922 <sfs_reclaim+0x160>
ffffffffc0209818:	00005597          	auipc	a1,0x5
ffffffffc020981c:	b2858593          	addi	a1,a1,-1240 # ffffffffc020e340 <syscalls+0xca0>
ffffffffc0209820:	8522                	mv	a0,s0
ffffffffc0209822:	e71fd0ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc0209826:	783c                	ld	a5,112(s0)
ffffffffc0209828:	4581                	li	a1,0
ffffffffc020982a:	8522                	mv	a0,s0
ffffffffc020982c:	73bc                	ld	a5,96(a5)
ffffffffc020982e:	9782                	jalr	a5
ffffffffc0209830:	e559                	bnez	a0,ffffffffc02098be <sfs_reclaim+0xfc>
ffffffffc0209832:	681c                	ld	a5,16(s0)
ffffffffc0209834:	c39d                	beqz	a5,ffffffffc020985a <sfs_reclaim+0x98>
ffffffffc0209836:	783c                	ld	a5,112(s0)
ffffffffc0209838:	10078563          	beqz	a5,ffffffffc0209942 <sfs_reclaim+0x180>
ffffffffc020983c:	7b9c                	ld	a5,48(a5)
ffffffffc020983e:	10078263          	beqz	a5,ffffffffc0209942 <sfs_reclaim+0x180>
ffffffffc0209842:	8522                	mv	a0,s0
ffffffffc0209844:	00003597          	auipc	a1,0x3
ffffffffc0209848:	7ac58593          	addi	a1,a1,1964 # ffffffffc020cff0 <default_pmm_manager+0xe90>
ffffffffc020984c:	e47fd0ef          	jal	ra,ffffffffc0207692 <inode_check>
ffffffffc0209850:	783c                	ld	a5,112(s0)
ffffffffc0209852:	8522                	mv	a0,s0
ffffffffc0209854:	7b9c                	ld	a5,48(a5)
ffffffffc0209856:	9782                	jalr	a5
ffffffffc0209858:	e13d                	bnez	a0,ffffffffc02098be <sfs_reclaim+0xfc>
ffffffffc020985a:	7c18                	ld	a4,56(s0)
ffffffffc020985c:	603c                	ld	a5,64(s0)
ffffffffc020985e:	8526                	mv	a0,s1
ffffffffc0209860:	e71c                	sd	a5,8(a4)
ffffffffc0209862:	e398                	sd	a4,0(a5)
ffffffffc0209864:	6438                	ld	a4,72(s0)
ffffffffc0209866:	683c                	ld	a5,80(s0)
ffffffffc0209868:	e71c                	sd	a5,8(a4)
ffffffffc020986a:	e398                	sd	a4,0(a5)
ffffffffc020986c:	3e4010ef          	jal	ra,ffffffffc020ac50 <unlock_sfs_fs>
ffffffffc0209870:	6008                	ld	a0,0(s0)
ffffffffc0209872:	00655783          	lhu	a5,6(a0)
ffffffffc0209876:	cb85                	beqz	a5,ffffffffc02098a6 <sfs_reclaim+0xe4>
ffffffffc0209878:	fc6f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020987c:	8522                	mv	a0,s0
ffffffffc020987e:	da9fd0ef          	jal	ra,ffffffffc0207626 <inode_kill>
ffffffffc0209882:	60e2                	ld	ra,24(sp)
ffffffffc0209884:	6442                	ld	s0,16(sp)
ffffffffc0209886:	64a2                	ld	s1,8(sp)
ffffffffc0209888:	854a                	mv	a0,s2
ffffffffc020988a:	6902                	ld	s2,0(sp)
ffffffffc020988c:	6105                	addi	sp,sp,32
ffffffffc020988e:	8082                	ret
ffffffffc0209890:	5945                	li	s2,-15
ffffffffc0209892:	8526                	mv	a0,s1
ffffffffc0209894:	3bc010ef          	jal	ra,ffffffffc020ac50 <unlock_sfs_fs>
ffffffffc0209898:	60e2                	ld	ra,24(sp)
ffffffffc020989a:	6442                	ld	s0,16(sp)
ffffffffc020989c:	64a2                	ld	s1,8(sp)
ffffffffc020989e:	854a                	mv	a0,s2
ffffffffc02098a0:	6902                	ld	s2,0(sp)
ffffffffc02098a2:	6105                	addi	sp,sp,32
ffffffffc02098a4:	8082                	ret
ffffffffc02098a6:	440c                	lw	a1,8(s0)
ffffffffc02098a8:	8526                	mv	a0,s1
ffffffffc02098aa:	ea7ff0ef          	jal	ra,ffffffffc0209750 <sfs_block_free>
ffffffffc02098ae:	6008                	ld	a0,0(s0)
ffffffffc02098b0:	5d4c                	lw	a1,60(a0)
ffffffffc02098b2:	d1f9                	beqz	a1,ffffffffc0209878 <sfs_reclaim+0xb6>
ffffffffc02098b4:	8526                	mv	a0,s1
ffffffffc02098b6:	e9bff0ef          	jal	ra,ffffffffc0209750 <sfs_block_free>
ffffffffc02098ba:	6008                	ld	a0,0(s0)
ffffffffc02098bc:	bf75                	j	ffffffffc0209878 <sfs_reclaim+0xb6>
ffffffffc02098be:	892a                	mv	s2,a0
ffffffffc02098c0:	bfc9                	j	ffffffffc0209892 <sfs_reclaim+0xd0>
ffffffffc02098c2:	00005697          	auipc	a3,0x5
ffffffffc02098c6:	ff668693          	addi	a3,a3,-10 # ffffffffc020e8b8 <dev_node_ops+0x3e0>
ffffffffc02098ca:	00002617          	auipc	a2,0x2
ffffffffc02098ce:	dae60613          	addi	a2,a2,-594 # ffffffffc020b678 <commands+0x210>
ffffffffc02098d2:	34600593          	li	a1,838
ffffffffc02098d6:	00005517          	auipc	a0,0x5
ffffffffc02098da:	1c250513          	addi	a0,a0,450 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc02098de:	bc1f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02098e2:	00005697          	auipc	a3,0x5
ffffffffc02098e6:	23e68693          	addi	a3,a3,574 # ffffffffc020eb20 <dev_node_ops+0x648>
ffffffffc02098ea:	00002617          	auipc	a2,0x2
ffffffffc02098ee:	d8e60613          	addi	a2,a2,-626 # ffffffffc020b678 <commands+0x210>
ffffffffc02098f2:	34c00593          	li	a1,844
ffffffffc02098f6:	00005517          	auipc	a0,0x5
ffffffffc02098fa:	1a250513          	addi	a0,a0,418 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc02098fe:	ba1f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209902:	00005697          	auipc	a3,0x5
ffffffffc0209906:	15e68693          	addi	a3,a3,350 # ffffffffc020ea60 <dev_node_ops+0x588>
ffffffffc020990a:	00002617          	auipc	a2,0x2
ffffffffc020990e:	d6e60613          	addi	a2,a2,-658 # ffffffffc020b678 <commands+0x210>
ffffffffc0209912:	34700593          	li	a1,839
ffffffffc0209916:	00005517          	auipc	a0,0x5
ffffffffc020991a:	18250513          	addi	a0,a0,386 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020991e:	b81f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209922:	00005697          	auipc	a3,0x5
ffffffffc0209926:	9c668693          	addi	a3,a3,-1594 # ffffffffc020e2e8 <syscalls+0xc48>
ffffffffc020992a:	00002617          	auipc	a2,0x2
ffffffffc020992e:	d4e60613          	addi	a2,a2,-690 # ffffffffc020b678 <commands+0x210>
ffffffffc0209932:	35100593          	li	a1,849
ffffffffc0209936:	00005517          	auipc	a0,0x5
ffffffffc020993a:	16250513          	addi	a0,a0,354 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020993e:	b61f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209942:	00003697          	auipc	a3,0x3
ffffffffc0209946:	65e68693          	addi	a3,a3,1630 # ffffffffc020cfa0 <default_pmm_manager+0xe40>
ffffffffc020994a:	00002617          	auipc	a2,0x2
ffffffffc020994e:	d2e60613          	addi	a2,a2,-722 # ffffffffc020b678 <commands+0x210>
ffffffffc0209952:	35600593          	li	a1,854
ffffffffc0209956:	00005517          	auipc	a0,0x5
ffffffffc020995a:	14250513          	addi	a0,a0,322 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020995e:	b41f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209962 <sfs_block_alloc>:
ffffffffc0209962:	1101                	addi	sp,sp,-32
ffffffffc0209964:	e822                	sd	s0,16(sp)
ffffffffc0209966:	842a                	mv	s0,a0
ffffffffc0209968:	7d08                	ld	a0,56(a0)
ffffffffc020996a:	e426                	sd	s1,8(sp)
ffffffffc020996c:	ec06                	sd	ra,24(sp)
ffffffffc020996e:	84ae                	mv	s1,a1
ffffffffc0209970:	c62ff0ef          	jal	ra,ffffffffc0208dd2 <bitmap_alloc>
ffffffffc0209974:	e90d                	bnez	a0,ffffffffc02099a6 <sfs_block_alloc+0x44>
ffffffffc0209976:	441c                	lw	a5,8(s0)
ffffffffc0209978:	cbad                	beqz	a5,ffffffffc02099ea <sfs_block_alloc+0x88>
ffffffffc020997a:	37fd                	addiw	a5,a5,-1
ffffffffc020997c:	c41c                	sw	a5,8(s0)
ffffffffc020997e:	408c                	lw	a1,0(s1)
ffffffffc0209980:	4785                	li	a5,1
ffffffffc0209982:	e03c                	sd	a5,64(s0)
ffffffffc0209984:	4054                	lw	a3,4(s0)
ffffffffc0209986:	c58d                	beqz	a1,ffffffffc02099b0 <sfs_block_alloc+0x4e>
ffffffffc0209988:	02d5f463          	bgeu	a1,a3,ffffffffc02099b0 <sfs_block_alloc+0x4e>
ffffffffc020998c:	7c08                	ld	a0,56(s0)
ffffffffc020998e:	cb4ff0ef          	jal	ra,ffffffffc0208e42 <bitmap_test>
ffffffffc0209992:	ed05                	bnez	a0,ffffffffc02099ca <sfs_block_alloc+0x68>
ffffffffc0209994:	8522                	mv	a0,s0
ffffffffc0209996:	6442                	ld	s0,16(sp)
ffffffffc0209998:	408c                	lw	a1,0(s1)
ffffffffc020999a:	60e2                	ld	ra,24(sp)
ffffffffc020999c:	64a2                	ld	s1,8(sp)
ffffffffc020999e:	4605                	li	a2,1
ffffffffc02099a0:	6105                	addi	sp,sp,32
ffffffffc02099a2:	23e0106f          	j	ffffffffc020abe0 <sfs_clear_block>
ffffffffc02099a6:	60e2                	ld	ra,24(sp)
ffffffffc02099a8:	6442                	ld	s0,16(sp)
ffffffffc02099aa:	64a2                	ld	s1,8(sp)
ffffffffc02099ac:	6105                	addi	sp,sp,32
ffffffffc02099ae:	8082                	ret
ffffffffc02099b0:	872e                	mv	a4,a1
ffffffffc02099b2:	00005617          	auipc	a2,0x5
ffffffffc02099b6:	11660613          	addi	a2,a2,278 # ffffffffc020eac8 <dev_node_ops+0x5f0>
ffffffffc02099ba:	05300593          	li	a1,83
ffffffffc02099be:	00005517          	auipc	a0,0x5
ffffffffc02099c2:	0da50513          	addi	a0,a0,218 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc02099c6:	ad9f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02099ca:	00005697          	auipc	a3,0x5
ffffffffc02099ce:	18e68693          	addi	a3,a3,398 # ffffffffc020eb58 <dev_node_ops+0x680>
ffffffffc02099d2:	00002617          	auipc	a2,0x2
ffffffffc02099d6:	ca660613          	addi	a2,a2,-858 # ffffffffc020b678 <commands+0x210>
ffffffffc02099da:	06100593          	li	a1,97
ffffffffc02099de:	00005517          	auipc	a0,0x5
ffffffffc02099e2:	0ba50513          	addi	a0,a0,186 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc02099e6:	ab9f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02099ea:	00005697          	auipc	a3,0x5
ffffffffc02099ee:	14e68693          	addi	a3,a3,334 # ffffffffc020eb38 <dev_node_ops+0x660>
ffffffffc02099f2:	00002617          	auipc	a2,0x2
ffffffffc02099f6:	c8660613          	addi	a2,a2,-890 # ffffffffc020b678 <commands+0x210>
ffffffffc02099fa:	05f00593          	li	a1,95
ffffffffc02099fe:	00005517          	auipc	a0,0x5
ffffffffc0209a02:	09a50513          	addi	a0,a0,154 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc0209a06:	a99f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209a0a <sfs_bmap_load_nolock>:
ffffffffc0209a0a:	7159                	addi	sp,sp,-112
ffffffffc0209a0c:	f85a                	sd	s6,48(sp)
ffffffffc0209a0e:	0005bb03          	ld	s6,0(a1)
ffffffffc0209a12:	f45e                	sd	s7,40(sp)
ffffffffc0209a14:	f486                	sd	ra,104(sp)
ffffffffc0209a16:	008b2b83          	lw	s7,8(s6)
ffffffffc0209a1a:	f0a2                	sd	s0,96(sp)
ffffffffc0209a1c:	eca6                	sd	s1,88(sp)
ffffffffc0209a1e:	e8ca                	sd	s2,80(sp)
ffffffffc0209a20:	e4ce                	sd	s3,72(sp)
ffffffffc0209a22:	e0d2                	sd	s4,64(sp)
ffffffffc0209a24:	fc56                	sd	s5,56(sp)
ffffffffc0209a26:	f062                	sd	s8,32(sp)
ffffffffc0209a28:	ec66                	sd	s9,24(sp)
ffffffffc0209a2a:	18cbe363          	bltu	s7,a2,ffffffffc0209bb0 <sfs_bmap_load_nolock+0x1a6>
ffffffffc0209a2e:	47ad                	li	a5,11
ffffffffc0209a30:	8aae                	mv	s5,a1
ffffffffc0209a32:	8432                	mv	s0,a2
ffffffffc0209a34:	84aa                	mv	s1,a0
ffffffffc0209a36:	89b6                	mv	s3,a3
ffffffffc0209a38:	04c7f563          	bgeu	a5,a2,ffffffffc0209a82 <sfs_bmap_load_nolock+0x78>
ffffffffc0209a3c:	ff46071b          	addiw	a4,a2,-12
ffffffffc0209a40:	0007069b          	sext.w	a3,a4
ffffffffc0209a44:	3ff00793          	li	a5,1023
ffffffffc0209a48:	1ad7e163          	bltu	a5,a3,ffffffffc0209bea <sfs_bmap_load_nolock+0x1e0>
ffffffffc0209a4c:	03cb2a03          	lw	s4,60(s6)
ffffffffc0209a50:	02071793          	slli	a5,a4,0x20
ffffffffc0209a54:	c602                	sw	zero,12(sp)
ffffffffc0209a56:	c452                	sw	s4,8(sp)
ffffffffc0209a58:	01e7dc13          	srli	s8,a5,0x1e
ffffffffc0209a5c:	0e0a1e63          	bnez	s4,ffffffffc0209b58 <sfs_bmap_load_nolock+0x14e>
ffffffffc0209a60:	0acb8663          	beq	s7,a2,ffffffffc0209b0c <sfs_bmap_load_nolock+0x102>
ffffffffc0209a64:	4a01                	li	s4,0
ffffffffc0209a66:	40d4                	lw	a3,4(s1)
ffffffffc0209a68:	8752                	mv	a4,s4
ffffffffc0209a6a:	00005617          	auipc	a2,0x5
ffffffffc0209a6e:	05e60613          	addi	a2,a2,94 # ffffffffc020eac8 <dev_node_ops+0x5f0>
ffffffffc0209a72:	05300593          	li	a1,83
ffffffffc0209a76:	00005517          	auipc	a0,0x5
ffffffffc0209a7a:	02250513          	addi	a0,a0,34 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc0209a7e:	a21f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209a82:	02061793          	slli	a5,a2,0x20
ffffffffc0209a86:	01e7da13          	srli	s4,a5,0x1e
ffffffffc0209a8a:	9a5a                	add	s4,s4,s6
ffffffffc0209a8c:	00ca2583          	lw	a1,12(s4)
ffffffffc0209a90:	c22e                	sw	a1,4(sp)
ffffffffc0209a92:	ed99                	bnez	a1,ffffffffc0209ab0 <sfs_bmap_load_nolock+0xa6>
ffffffffc0209a94:	fccb98e3          	bne	s7,a2,ffffffffc0209a64 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209a98:	004c                	addi	a1,sp,4
ffffffffc0209a9a:	ec9ff0ef          	jal	ra,ffffffffc0209962 <sfs_block_alloc>
ffffffffc0209a9e:	892a                	mv	s2,a0
ffffffffc0209aa0:	e921                	bnez	a0,ffffffffc0209af0 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209aa2:	4592                	lw	a1,4(sp)
ffffffffc0209aa4:	4705                	li	a4,1
ffffffffc0209aa6:	00ba2623          	sw	a1,12(s4)
ffffffffc0209aaa:	00eab823          	sd	a4,16(s5)
ffffffffc0209aae:	d9dd                	beqz	a1,ffffffffc0209a64 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209ab0:	40d4                	lw	a3,4(s1)
ffffffffc0209ab2:	10d5ff63          	bgeu	a1,a3,ffffffffc0209bd0 <sfs_bmap_load_nolock+0x1c6>
ffffffffc0209ab6:	7c88                	ld	a0,56(s1)
ffffffffc0209ab8:	b8aff0ef          	jal	ra,ffffffffc0208e42 <bitmap_test>
ffffffffc0209abc:	18051363          	bnez	a0,ffffffffc0209c42 <sfs_bmap_load_nolock+0x238>
ffffffffc0209ac0:	4a12                	lw	s4,4(sp)
ffffffffc0209ac2:	fa0a02e3          	beqz	s4,ffffffffc0209a66 <sfs_bmap_load_nolock+0x5c>
ffffffffc0209ac6:	40dc                	lw	a5,4(s1)
ffffffffc0209ac8:	f8fa7fe3          	bgeu	s4,a5,ffffffffc0209a66 <sfs_bmap_load_nolock+0x5c>
ffffffffc0209acc:	7c88                	ld	a0,56(s1)
ffffffffc0209ace:	85d2                	mv	a1,s4
ffffffffc0209ad0:	b72ff0ef          	jal	ra,ffffffffc0208e42 <bitmap_test>
ffffffffc0209ad4:	12051763          	bnez	a0,ffffffffc0209c02 <sfs_bmap_load_nolock+0x1f8>
ffffffffc0209ad8:	008b9763          	bne	s7,s0,ffffffffc0209ae6 <sfs_bmap_load_nolock+0xdc>
ffffffffc0209adc:	008b2783          	lw	a5,8(s6)
ffffffffc0209ae0:	2785                	addiw	a5,a5,1
ffffffffc0209ae2:	00fb2423          	sw	a5,8(s6)
ffffffffc0209ae6:	4901                	li	s2,0
ffffffffc0209ae8:	00098463          	beqz	s3,ffffffffc0209af0 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209aec:	0149a023          	sw	s4,0(s3)
ffffffffc0209af0:	70a6                	ld	ra,104(sp)
ffffffffc0209af2:	7406                	ld	s0,96(sp)
ffffffffc0209af4:	64e6                	ld	s1,88(sp)
ffffffffc0209af6:	69a6                	ld	s3,72(sp)
ffffffffc0209af8:	6a06                	ld	s4,64(sp)
ffffffffc0209afa:	7ae2                	ld	s5,56(sp)
ffffffffc0209afc:	7b42                	ld	s6,48(sp)
ffffffffc0209afe:	7ba2                	ld	s7,40(sp)
ffffffffc0209b00:	7c02                	ld	s8,32(sp)
ffffffffc0209b02:	6ce2                	ld	s9,24(sp)
ffffffffc0209b04:	854a                	mv	a0,s2
ffffffffc0209b06:	6946                	ld	s2,80(sp)
ffffffffc0209b08:	6165                	addi	sp,sp,112
ffffffffc0209b0a:	8082                	ret
ffffffffc0209b0c:	002c                	addi	a1,sp,8
ffffffffc0209b0e:	e55ff0ef          	jal	ra,ffffffffc0209962 <sfs_block_alloc>
ffffffffc0209b12:	892a                	mv	s2,a0
ffffffffc0209b14:	00c10c93          	addi	s9,sp,12
ffffffffc0209b18:	fd61                	bnez	a0,ffffffffc0209af0 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209b1a:	85e6                	mv	a1,s9
ffffffffc0209b1c:	8526                	mv	a0,s1
ffffffffc0209b1e:	e45ff0ef          	jal	ra,ffffffffc0209962 <sfs_block_alloc>
ffffffffc0209b22:	892a                	mv	s2,a0
ffffffffc0209b24:	e925                	bnez	a0,ffffffffc0209b94 <sfs_bmap_load_nolock+0x18a>
ffffffffc0209b26:	46a2                	lw	a3,8(sp)
ffffffffc0209b28:	85e6                	mv	a1,s9
ffffffffc0209b2a:	8762                	mv	a4,s8
ffffffffc0209b2c:	4611                	li	a2,4
ffffffffc0209b2e:	8526                	mv	a0,s1
ffffffffc0209b30:	761000ef          	jal	ra,ffffffffc020aa90 <sfs_wbuf>
ffffffffc0209b34:	45b2                	lw	a1,12(sp)
ffffffffc0209b36:	892a                	mv	s2,a0
ffffffffc0209b38:	e939                	bnez	a0,ffffffffc0209b8e <sfs_bmap_load_nolock+0x184>
ffffffffc0209b3a:	03cb2683          	lw	a3,60(s6)
ffffffffc0209b3e:	4722                	lw	a4,8(sp)
ffffffffc0209b40:	c22e                	sw	a1,4(sp)
ffffffffc0209b42:	f6d706e3          	beq	a4,a3,ffffffffc0209aae <sfs_bmap_load_nolock+0xa4>
ffffffffc0209b46:	eef1                	bnez	a3,ffffffffc0209c22 <sfs_bmap_load_nolock+0x218>
ffffffffc0209b48:	02eb2e23          	sw	a4,60(s6)
ffffffffc0209b4c:	4705                	li	a4,1
ffffffffc0209b4e:	00eab823          	sd	a4,16(s5)
ffffffffc0209b52:	f00589e3          	beqz	a1,ffffffffc0209a64 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209b56:	bfa9                	j	ffffffffc0209ab0 <sfs_bmap_load_nolock+0xa6>
ffffffffc0209b58:	00c10c93          	addi	s9,sp,12
ffffffffc0209b5c:	8762                	mv	a4,s8
ffffffffc0209b5e:	86d2                	mv	a3,s4
ffffffffc0209b60:	4611                	li	a2,4
ffffffffc0209b62:	85e6                	mv	a1,s9
ffffffffc0209b64:	6ad000ef          	jal	ra,ffffffffc020aa10 <sfs_rbuf>
ffffffffc0209b68:	892a                	mv	s2,a0
ffffffffc0209b6a:	f159                	bnez	a0,ffffffffc0209af0 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209b6c:	45b2                	lw	a1,12(sp)
ffffffffc0209b6e:	e995                	bnez	a1,ffffffffc0209ba2 <sfs_bmap_load_nolock+0x198>
ffffffffc0209b70:	fa8b85e3          	beq	s7,s0,ffffffffc0209b1a <sfs_bmap_load_nolock+0x110>
ffffffffc0209b74:	03cb2703          	lw	a4,60(s6)
ffffffffc0209b78:	47a2                	lw	a5,8(sp)
ffffffffc0209b7a:	c202                	sw	zero,4(sp)
ffffffffc0209b7c:	eee784e3          	beq	a5,a4,ffffffffc0209a64 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209b80:	e34d                	bnez	a4,ffffffffc0209c22 <sfs_bmap_load_nolock+0x218>
ffffffffc0209b82:	02fb2e23          	sw	a5,60(s6)
ffffffffc0209b86:	4785                	li	a5,1
ffffffffc0209b88:	00fab823          	sd	a5,16(s5)
ffffffffc0209b8c:	bde1                	j	ffffffffc0209a64 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209b8e:	8526                	mv	a0,s1
ffffffffc0209b90:	bc1ff0ef          	jal	ra,ffffffffc0209750 <sfs_block_free>
ffffffffc0209b94:	45a2                	lw	a1,8(sp)
ffffffffc0209b96:	f4ba0de3          	beq	s4,a1,ffffffffc0209af0 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209b9a:	8526                	mv	a0,s1
ffffffffc0209b9c:	bb5ff0ef          	jal	ra,ffffffffc0209750 <sfs_block_free>
ffffffffc0209ba0:	bf81                	j	ffffffffc0209af0 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209ba2:	03cb2683          	lw	a3,60(s6)
ffffffffc0209ba6:	4722                	lw	a4,8(sp)
ffffffffc0209ba8:	c22e                	sw	a1,4(sp)
ffffffffc0209baa:	f8e69ee3          	bne	a3,a4,ffffffffc0209b46 <sfs_bmap_load_nolock+0x13c>
ffffffffc0209bae:	b709                	j	ffffffffc0209ab0 <sfs_bmap_load_nolock+0xa6>
ffffffffc0209bb0:	00005697          	auipc	a3,0x5
ffffffffc0209bb4:	fd068693          	addi	a3,a3,-48 # ffffffffc020eb80 <dev_node_ops+0x6a8>
ffffffffc0209bb8:	00002617          	auipc	a2,0x2
ffffffffc0209bbc:	ac060613          	addi	a2,a2,-1344 # ffffffffc020b678 <commands+0x210>
ffffffffc0209bc0:	16400593          	li	a1,356
ffffffffc0209bc4:	00005517          	auipc	a0,0x5
ffffffffc0209bc8:	ed450513          	addi	a0,a0,-300 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc0209bcc:	8d3f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209bd0:	872e                	mv	a4,a1
ffffffffc0209bd2:	00005617          	auipc	a2,0x5
ffffffffc0209bd6:	ef660613          	addi	a2,a2,-266 # ffffffffc020eac8 <dev_node_ops+0x5f0>
ffffffffc0209bda:	05300593          	li	a1,83
ffffffffc0209bde:	00005517          	auipc	a0,0x5
ffffffffc0209be2:	eba50513          	addi	a0,a0,-326 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc0209be6:	8b9f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209bea:	00005617          	auipc	a2,0x5
ffffffffc0209bee:	fc660613          	addi	a2,a2,-58 # ffffffffc020ebb0 <dev_node_ops+0x6d8>
ffffffffc0209bf2:	11e00593          	li	a1,286
ffffffffc0209bf6:	00005517          	auipc	a0,0x5
ffffffffc0209bfa:	ea250513          	addi	a0,a0,-350 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc0209bfe:	8a1f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209c02:	00005697          	auipc	a3,0x5
ffffffffc0209c06:	efe68693          	addi	a3,a3,-258 # ffffffffc020eb00 <dev_node_ops+0x628>
ffffffffc0209c0a:	00002617          	auipc	a2,0x2
ffffffffc0209c0e:	a6e60613          	addi	a2,a2,-1426 # ffffffffc020b678 <commands+0x210>
ffffffffc0209c12:	16b00593          	li	a1,363
ffffffffc0209c16:	00005517          	auipc	a0,0x5
ffffffffc0209c1a:	e8250513          	addi	a0,a0,-382 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc0209c1e:	881f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209c22:	00005697          	auipc	a3,0x5
ffffffffc0209c26:	f7668693          	addi	a3,a3,-138 # ffffffffc020eb98 <dev_node_ops+0x6c0>
ffffffffc0209c2a:	00002617          	auipc	a2,0x2
ffffffffc0209c2e:	a4e60613          	addi	a2,a2,-1458 # ffffffffc020b678 <commands+0x210>
ffffffffc0209c32:	11800593          	li	a1,280
ffffffffc0209c36:	00005517          	auipc	a0,0x5
ffffffffc0209c3a:	e6250513          	addi	a0,a0,-414 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc0209c3e:	861f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209c42:	00005697          	auipc	a3,0x5
ffffffffc0209c46:	f9e68693          	addi	a3,a3,-98 # ffffffffc020ebe0 <dev_node_ops+0x708>
ffffffffc0209c4a:	00002617          	auipc	a2,0x2
ffffffffc0209c4e:	a2e60613          	addi	a2,a2,-1490 # ffffffffc020b678 <commands+0x210>
ffffffffc0209c52:	12100593          	li	a1,289
ffffffffc0209c56:	00005517          	auipc	a0,0x5
ffffffffc0209c5a:	e4250513          	addi	a0,a0,-446 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc0209c5e:	841f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209c62 <sfs_io_nolock>:
ffffffffc0209c62:	7175                	addi	sp,sp,-144
ffffffffc0209c64:	ecd6                	sd	s5,88(sp)
ffffffffc0209c66:	8aae                	mv	s5,a1
ffffffffc0209c68:	618c                	ld	a1,0(a1)
ffffffffc0209c6a:	e506                	sd	ra,136(sp)
ffffffffc0209c6c:	e122                	sd	s0,128(sp)
ffffffffc0209c6e:	0045d803          	lhu	a6,4(a1)
ffffffffc0209c72:	e42e                	sd	a1,8(sp)
ffffffffc0209c74:	fca6                	sd	s1,120(sp)
ffffffffc0209c76:	f8ca                	sd	s2,112(sp)
ffffffffc0209c78:	f4ce                	sd	s3,104(sp)
ffffffffc0209c7a:	f0d2                	sd	s4,96(sp)
ffffffffc0209c7c:	e8da                	sd	s6,80(sp)
ffffffffc0209c7e:	e4de                	sd	s7,72(sp)
ffffffffc0209c80:	e0e2                	sd	s8,64(sp)
ffffffffc0209c82:	fc66                	sd	s9,56(sp)
ffffffffc0209c84:	f86a                	sd	s10,48(sp)
ffffffffc0209c86:	f46e                	sd	s11,40(sp)
ffffffffc0209c88:	4589                	li	a1,2
ffffffffc0209c8a:	10b80e63          	beq	a6,a1,ffffffffc0209da6 <sfs_io_nolock+0x144>
ffffffffc0209c8e:	00073903          	ld	s2,0(a4) # 4000 <_binary_bin_swap_img_size-0x3d00>
ffffffffc0209c92:	8b3e                	mv	s6,a5
ffffffffc0209c94:	00073023          	sd	zero,0(a4)
ffffffffc0209c98:	080007b7          	lui	a5,0x8000
ffffffffc0209c9c:	8db6                	mv	s11,a3
ffffffffc0209c9e:	84ba                	mv	s1,a4
ffffffffc0209ca0:	9936                	add	s2,s2,a3
ffffffffc0209ca2:	10f6f063          	bgeu	a3,a5,ffffffffc0209da2 <sfs_io_nolock+0x140>
ffffffffc0209ca6:	0ed94e63          	blt	s2,a3,ffffffffc0209da2 <sfs_io_nolock+0x140>
ffffffffc0209caa:	0d268363          	beq	a3,s2,ffffffffc0209d70 <sfs_io_nolock+0x10e>
ffffffffc0209cae:	89aa                	mv	s3,a0
ffffffffc0209cb0:	8432                	mv	s0,a2
ffffffffc0209cb2:	0127fe63          	bgeu	a5,s2,ffffffffc0209cce <sfs_io_nolock+0x6c>
ffffffffc0209cb6:	0c0b0d63          	beqz	s6,ffffffffc0209d90 <sfs_io_nolock+0x12e>
ffffffffc0209cba:	00001797          	auipc	a5,0x1
ffffffffc0209cbe:	dd678793          	addi	a5,a5,-554 # ffffffffc020aa90 <sfs_wbuf>
ffffffffc0209cc2:	08000c37          	lui	s8,0x8000
ffffffffc0209cc6:	08000937          	lui	s2,0x8000
ffffffffc0209cca:	e03e                	sd	a5,0(sp)
ffffffffc0209ccc:	a01d                	j	ffffffffc0209cf2 <sfs_io_nolock+0x90>
ffffffffc0209cce:	0c0b1463          	bnez	s6,ffffffffc0209d96 <sfs_io_nolock+0x134>
ffffffffc0209cd2:	67a2                	ld	a5,8(sp)
ffffffffc0209cd4:	0007e783          	lwu	a5,0(a5)
ffffffffc0209cd8:	08fddc63          	bge	s11,a5,ffffffffc0209d70 <sfs_io_nolock+0x10e>
ffffffffc0209cdc:	0127d363          	bge	a5,s2,ffffffffc0209ce2 <sfs_io_nolock+0x80>
ffffffffc0209ce0:	893e                	mv	s2,a5
ffffffffc0209ce2:	00001797          	auipc	a5,0x1
ffffffffc0209ce6:	d2e78793          	addi	a5,a5,-722 # ffffffffc020aa10 <sfs_rbuf>
ffffffffc0209cea:	e03e                	sd	a5,0(sp)
ffffffffc0209cec:	092dd263          	bge	s11,s2,ffffffffc0209d70 <sfs_io_nolock+0x10e>
ffffffffc0209cf0:	8c4a                	mv	s8,s2
ffffffffc0209cf2:	6b85                	lui	s7,0x1
ffffffffc0209cf4:	fffb8a13          	addi	s4,s7,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0209cf8:	43fdd813          	srai	a6,s11,0x3f
ffffffffc0209cfc:	03485793          	srli	a5,a6,0x34
ffffffffc0209d00:	00fd8733          	add	a4,s11,a5
ffffffffc0209d04:	01477733          	and	a4,a4,s4
ffffffffc0209d08:	01487633          	and	a2,a6,s4
ffffffffc0209d0c:	40f70cb3          	sub	s9,a4,a5
ffffffffc0209d10:	966e                	add	a2,a2,s11
ffffffffc0209d12:	419b8d33          	sub	s10,s7,s9
ffffffffc0209d16:	8631                	srai	a2,a2,0xc
ffffffffc0209d18:	01ad86b3          	add	a3,s11,s10
ffffffffc0209d1c:	2601                	sext.w	a2,a2
ffffffffc0209d1e:	00dc7463          	bgeu	s8,a3,ffffffffc0209d26 <sfs_io_nolock+0xc4>
ffffffffc0209d22:	41b90d33          	sub	s10,s2,s11
ffffffffc0209d26:	000b1f63          	bnez	s6,ffffffffc0209d44 <sfs_io_nolock+0xe2>
ffffffffc0209d2a:	67a2                	ld	a5,8(sp)
ffffffffc0209d2c:	01ad85b3          	add	a1,s11,s10
ffffffffc0209d30:	0007e683          	lwu	a3,0(a5)
ffffffffc0209d34:	00b6f863          	bgeu	a3,a1,ffffffffc0209d44 <sfs_io_nolock+0xe2>
ffffffffc0209d38:	41b68d33          	sub	s10,a3,s11
ffffffffc0209d3c:	000d069b          	sext.w	a3,s10
ffffffffc0209d40:	02d05863          	blez	a3,ffffffffc0209d70 <sfs_io_nolock+0x10e>
ffffffffc0209d44:	0874                	addi	a3,sp,28
ffffffffc0209d46:	85d6                	mv	a1,s5
ffffffffc0209d48:	854e                	mv	a0,s3
ffffffffc0209d4a:	cc1ff0ef          	jal	ra,ffffffffc0209a0a <sfs_bmap_load_nolock>
ffffffffc0209d4e:	e115                	bnez	a0,ffffffffc0209d72 <sfs_io_nolock+0x110>
ffffffffc0209d50:	46f2                	lw	a3,28(sp)
ffffffffc0209d52:	6782                	ld	a5,0(sp)
ffffffffc0209d54:	8766                	mv	a4,s9
ffffffffc0209d56:	866a                	mv	a2,s10
ffffffffc0209d58:	85a2                	mv	a1,s0
ffffffffc0209d5a:	854e                	mv	a0,s3
ffffffffc0209d5c:	9782                	jalr	a5
ffffffffc0209d5e:	e911                	bnez	a0,ffffffffc0209d72 <sfs_io_nolock+0x110>
ffffffffc0209d60:	6098                	ld	a4,0(s1)
ffffffffc0209d62:	9dea                	add	s11,s11,s10
ffffffffc0209d64:	946a                	add	s0,s0,s10
ffffffffc0209d66:	01a707b3          	add	a5,a4,s10
ffffffffc0209d6a:	e09c                	sd	a5,0(s1)
ffffffffc0209d6c:	f92dc6e3          	blt	s11,s2,ffffffffc0209cf8 <sfs_io_nolock+0x96>
ffffffffc0209d70:	4501                	li	a0,0
ffffffffc0209d72:	60aa                	ld	ra,136(sp)
ffffffffc0209d74:	640a                	ld	s0,128(sp)
ffffffffc0209d76:	74e6                	ld	s1,120(sp)
ffffffffc0209d78:	7946                	ld	s2,112(sp)
ffffffffc0209d7a:	79a6                	ld	s3,104(sp)
ffffffffc0209d7c:	7a06                	ld	s4,96(sp)
ffffffffc0209d7e:	6ae6                	ld	s5,88(sp)
ffffffffc0209d80:	6b46                	ld	s6,80(sp)
ffffffffc0209d82:	6ba6                	ld	s7,72(sp)
ffffffffc0209d84:	6c06                	ld	s8,64(sp)
ffffffffc0209d86:	7ce2                	ld	s9,56(sp)
ffffffffc0209d88:	7d42                	ld	s10,48(sp)
ffffffffc0209d8a:	7da2                	ld	s11,40(sp)
ffffffffc0209d8c:	6149                	addi	sp,sp,144
ffffffffc0209d8e:	8082                	ret
ffffffffc0209d90:	08000937          	lui	s2,0x8000
ffffffffc0209d94:	bf3d                	j	ffffffffc0209cd2 <sfs_io_nolock+0x70>
ffffffffc0209d96:	00001797          	auipc	a5,0x1
ffffffffc0209d9a:	cfa78793          	addi	a5,a5,-774 # ffffffffc020aa90 <sfs_wbuf>
ffffffffc0209d9e:	e03e                	sd	a5,0(sp)
ffffffffc0209da0:	b7b1                	j	ffffffffc0209cec <sfs_io_nolock+0x8a>
ffffffffc0209da2:	5575                	li	a0,-3
ffffffffc0209da4:	b7f9                	j	ffffffffc0209d72 <sfs_io_nolock+0x110>
ffffffffc0209da6:	00005697          	auipc	a3,0x5
ffffffffc0209daa:	e6268693          	addi	a3,a3,-414 # ffffffffc020ec08 <dev_node_ops+0x730>
ffffffffc0209dae:	00002617          	auipc	a2,0x2
ffffffffc0209db2:	8ca60613          	addi	a2,a2,-1846 # ffffffffc020b678 <commands+0x210>
ffffffffc0209db6:	22b00593          	li	a1,555
ffffffffc0209dba:	00005517          	auipc	a0,0x5
ffffffffc0209dbe:	cde50513          	addi	a0,a0,-802 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc0209dc2:	edcf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209dc6 <sfs_read>:
ffffffffc0209dc6:	7139                	addi	sp,sp,-64
ffffffffc0209dc8:	f04a                	sd	s2,32(sp)
ffffffffc0209dca:	06853903          	ld	s2,104(a0)
ffffffffc0209dce:	fc06                	sd	ra,56(sp)
ffffffffc0209dd0:	f822                	sd	s0,48(sp)
ffffffffc0209dd2:	f426                	sd	s1,40(sp)
ffffffffc0209dd4:	ec4e                	sd	s3,24(sp)
ffffffffc0209dd6:	04090f63          	beqz	s2,ffffffffc0209e34 <sfs_read+0x6e>
ffffffffc0209dda:	0b092783          	lw	a5,176(s2) # 80000b0 <_binary_bin_sfs_img_size+0x7f8adb0>
ffffffffc0209dde:	ebb9                	bnez	a5,ffffffffc0209e34 <sfs_read+0x6e>
ffffffffc0209de0:	4d38                	lw	a4,88(a0)
ffffffffc0209de2:	6785                	lui	a5,0x1
ffffffffc0209de4:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209de8:	842a                	mv	s0,a0
ffffffffc0209dea:	06f71563          	bne	a4,a5,ffffffffc0209e54 <sfs_read+0x8e>
ffffffffc0209dee:	02050993          	addi	s3,a0,32
ffffffffc0209df2:	854e                	mv	a0,s3
ffffffffc0209df4:	84ae                	mv	s1,a1
ffffffffc0209df6:	f4cfa0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc0209dfa:	0184b803          	ld	a6,24(s1)
ffffffffc0209dfe:	6494                	ld	a3,8(s1)
ffffffffc0209e00:	6090                	ld	a2,0(s1)
ffffffffc0209e02:	85a2                	mv	a1,s0
ffffffffc0209e04:	4781                	li	a5,0
ffffffffc0209e06:	0038                	addi	a4,sp,8
ffffffffc0209e08:	854a                	mv	a0,s2
ffffffffc0209e0a:	e442                	sd	a6,8(sp)
ffffffffc0209e0c:	e57ff0ef          	jal	ra,ffffffffc0209c62 <sfs_io_nolock>
ffffffffc0209e10:	65a2                	ld	a1,8(sp)
ffffffffc0209e12:	842a                	mv	s0,a0
ffffffffc0209e14:	ed81                	bnez	a1,ffffffffc0209e2c <sfs_read+0x66>
ffffffffc0209e16:	854e                	mv	a0,s3
ffffffffc0209e18:	f26fa0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc0209e1c:	70e2                	ld	ra,56(sp)
ffffffffc0209e1e:	8522                	mv	a0,s0
ffffffffc0209e20:	7442                	ld	s0,48(sp)
ffffffffc0209e22:	74a2                	ld	s1,40(sp)
ffffffffc0209e24:	7902                	ld	s2,32(sp)
ffffffffc0209e26:	69e2                	ld	s3,24(sp)
ffffffffc0209e28:	6121                	addi	sp,sp,64
ffffffffc0209e2a:	8082                	ret
ffffffffc0209e2c:	8526                	mv	a0,s1
ffffffffc0209e2e:	e08fb0ef          	jal	ra,ffffffffc0205436 <iobuf_skip>
ffffffffc0209e32:	b7d5                	j	ffffffffc0209e16 <sfs_read+0x50>
ffffffffc0209e34:	00005697          	auipc	a3,0x5
ffffffffc0209e38:	a8468693          	addi	a3,a3,-1404 # ffffffffc020e8b8 <dev_node_ops+0x3e0>
ffffffffc0209e3c:	00002617          	auipc	a2,0x2
ffffffffc0209e40:	83c60613          	addi	a2,a2,-1988 # ffffffffc020b678 <commands+0x210>
ffffffffc0209e44:	28400593          	li	a1,644
ffffffffc0209e48:	00005517          	auipc	a0,0x5
ffffffffc0209e4c:	c5050513          	addi	a0,a0,-944 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc0209e50:	e4ef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209e54:	8d9ff0ef          	jal	ra,ffffffffc020972c <sfs_io.part.0>

ffffffffc0209e58 <sfs_write>:
ffffffffc0209e58:	7139                	addi	sp,sp,-64
ffffffffc0209e5a:	f04a                	sd	s2,32(sp)
ffffffffc0209e5c:	06853903          	ld	s2,104(a0)
ffffffffc0209e60:	fc06                	sd	ra,56(sp)
ffffffffc0209e62:	f822                	sd	s0,48(sp)
ffffffffc0209e64:	f426                	sd	s1,40(sp)
ffffffffc0209e66:	ec4e                	sd	s3,24(sp)
ffffffffc0209e68:	04090f63          	beqz	s2,ffffffffc0209ec6 <sfs_write+0x6e>
ffffffffc0209e6c:	0b092783          	lw	a5,176(s2)
ffffffffc0209e70:	ebb9                	bnez	a5,ffffffffc0209ec6 <sfs_write+0x6e>
ffffffffc0209e72:	4d38                	lw	a4,88(a0)
ffffffffc0209e74:	6785                	lui	a5,0x1
ffffffffc0209e76:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209e7a:	842a                	mv	s0,a0
ffffffffc0209e7c:	06f71563          	bne	a4,a5,ffffffffc0209ee6 <sfs_write+0x8e>
ffffffffc0209e80:	02050993          	addi	s3,a0,32
ffffffffc0209e84:	854e                	mv	a0,s3
ffffffffc0209e86:	84ae                	mv	s1,a1
ffffffffc0209e88:	ebafa0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc0209e8c:	0184b803          	ld	a6,24(s1)
ffffffffc0209e90:	6494                	ld	a3,8(s1)
ffffffffc0209e92:	6090                	ld	a2,0(s1)
ffffffffc0209e94:	85a2                	mv	a1,s0
ffffffffc0209e96:	4785                	li	a5,1
ffffffffc0209e98:	0038                	addi	a4,sp,8
ffffffffc0209e9a:	854a                	mv	a0,s2
ffffffffc0209e9c:	e442                	sd	a6,8(sp)
ffffffffc0209e9e:	dc5ff0ef          	jal	ra,ffffffffc0209c62 <sfs_io_nolock>
ffffffffc0209ea2:	65a2                	ld	a1,8(sp)
ffffffffc0209ea4:	842a                	mv	s0,a0
ffffffffc0209ea6:	ed81                	bnez	a1,ffffffffc0209ebe <sfs_write+0x66>
ffffffffc0209ea8:	854e                	mv	a0,s3
ffffffffc0209eaa:	e94fa0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc0209eae:	70e2                	ld	ra,56(sp)
ffffffffc0209eb0:	8522                	mv	a0,s0
ffffffffc0209eb2:	7442                	ld	s0,48(sp)
ffffffffc0209eb4:	74a2                	ld	s1,40(sp)
ffffffffc0209eb6:	7902                	ld	s2,32(sp)
ffffffffc0209eb8:	69e2                	ld	s3,24(sp)
ffffffffc0209eba:	6121                	addi	sp,sp,64
ffffffffc0209ebc:	8082                	ret
ffffffffc0209ebe:	8526                	mv	a0,s1
ffffffffc0209ec0:	d76fb0ef          	jal	ra,ffffffffc0205436 <iobuf_skip>
ffffffffc0209ec4:	b7d5                	j	ffffffffc0209ea8 <sfs_write+0x50>
ffffffffc0209ec6:	00005697          	auipc	a3,0x5
ffffffffc0209eca:	9f268693          	addi	a3,a3,-1550 # ffffffffc020e8b8 <dev_node_ops+0x3e0>
ffffffffc0209ece:	00001617          	auipc	a2,0x1
ffffffffc0209ed2:	7aa60613          	addi	a2,a2,1962 # ffffffffc020b678 <commands+0x210>
ffffffffc0209ed6:	28400593          	li	a1,644
ffffffffc0209eda:	00005517          	auipc	a0,0x5
ffffffffc0209ede:	bbe50513          	addi	a0,a0,-1090 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc0209ee2:	dbcf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209ee6:	847ff0ef          	jal	ra,ffffffffc020972c <sfs_io.part.0>

ffffffffc0209eea <sfs_dirent_read_nolock>:
ffffffffc0209eea:	6198                	ld	a4,0(a1)
ffffffffc0209eec:	7179                	addi	sp,sp,-48
ffffffffc0209eee:	f406                	sd	ra,40(sp)
ffffffffc0209ef0:	00475883          	lhu	a7,4(a4)
ffffffffc0209ef4:	f022                	sd	s0,32(sp)
ffffffffc0209ef6:	ec26                	sd	s1,24(sp)
ffffffffc0209ef8:	4809                	li	a6,2
ffffffffc0209efa:	05089b63          	bne	a7,a6,ffffffffc0209f50 <sfs_dirent_read_nolock+0x66>
ffffffffc0209efe:	4718                	lw	a4,8(a4)
ffffffffc0209f00:	87b2                	mv	a5,a2
ffffffffc0209f02:	2601                	sext.w	a2,a2
ffffffffc0209f04:	04e7f663          	bgeu	a5,a4,ffffffffc0209f50 <sfs_dirent_read_nolock+0x66>
ffffffffc0209f08:	84b6                	mv	s1,a3
ffffffffc0209f0a:	0074                	addi	a3,sp,12
ffffffffc0209f0c:	842a                	mv	s0,a0
ffffffffc0209f0e:	afdff0ef          	jal	ra,ffffffffc0209a0a <sfs_bmap_load_nolock>
ffffffffc0209f12:	c511                	beqz	a0,ffffffffc0209f1e <sfs_dirent_read_nolock+0x34>
ffffffffc0209f14:	70a2                	ld	ra,40(sp)
ffffffffc0209f16:	7402                	ld	s0,32(sp)
ffffffffc0209f18:	64e2                	ld	s1,24(sp)
ffffffffc0209f1a:	6145                	addi	sp,sp,48
ffffffffc0209f1c:	8082                	ret
ffffffffc0209f1e:	45b2                	lw	a1,12(sp)
ffffffffc0209f20:	4054                	lw	a3,4(s0)
ffffffffc0209f22:	c5b9                	beqz	a1,ffffffffc0209f70 <sfs_dirent_read_nolock+0x86>
ffffffffc0209f24:	04d5f663          	bgeu	a1,a3,ffffffffc0209f70 <sfs_dirent_read_nolock+0x86>
ffffffffc0209f28:	7c08                	ld	a0,56(s0)
ffffffffc0209f2a:	f19fe0ef          	jal	ra,ffffffffc0208e42 <bitmap_test>
ffffffffc0209f2e:	ed31                	bnez	a0,ffffffffc0209f8a <sfs_dirent_read_nolock+0xa0>
ffffffffc0209f30:	46b2                	lw	a3,12(sp)
ffffffffc0209f32:	4701                	li	a4,0
ffffffffc0209f34:	10400613          	li	a2,260
ffffffffc0209f38:	85a6                	mv	a1,s1
ffffffffc0209f3a:	8522                	mv	a0,s0
ffffffffc0209f3c:	2d5000ef          	jal	ra,ffffffffc020aa10 <sfs_rbuf>
ffffffffc0209f40:	f971                	bnez	a0,ffffffffc0209f14 <sfs_dirent_read_nolock+0x2a>
ffffffffc0209f42:	100481a3          	sb	zero,259(s1)
ffffffffc0209f46:	70a2                	ld	ra,40(sp)
ffffffffc0209f48:	7402                	ld	s0,32(sp)
ffffffffc0209f4a:	64e2                	ld	s1,24(sp)
ffffffffc0209f4c:	6145                	addi	sp,sp,48
ffffffffc0209f4e:	8082                	ret
ffffffffc0209f50:	00005697          	auipc	a3,0x5
ffffffffc0209f54:	cd868693          	addi	a3,a3,-808 # ffffffffc020ec28 <dev_node_ops+0x750>
ffffffffc0209f58:	00001617          	auipc	a2,0x1
ffffffffc0209f5c:	72060613          	addi	a2,a2,1824 # ffffffffc020b678 <commands+0x210>
ffffffffc0209f60:	18e00593          	li	a1,398
ffffffffc0209f64:	00005517          	auipc	a0,0x5
ffffffffc0209f68:	b3450513          	addi	a0,a0,-1228 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc0209f6c:	d32f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209f70:	872e                	mv	a4,a1
ffffffffc0209f72:	00005617          	auipc	a2,0x5
ffffffffc0209f76:	b5660613          	addi	a2,a2,-1194 # ffffffffc020eac8 <dev_node_ops+0x5f0>
ffffffffc0209f7a:	05300593          	li	a1,83
ffffffffc0209f7e:	00005517          	auipc	a0,0x5
ffffffffc0209f82:	b1a50513          	addi	a0,a0,-1254 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc0209f86:	d18f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209f8a:	00005697          	auipc	a3,0x5
ffffffffc0209f8e:	b7668693          	addi	a3,a3,-1162 # ffffffffc020eb00 <dev_node_ops+0x628>
ffffffffc0209f92:	00001617          	auipc	a2,0x1
ffffffffc0209f96:	6e660613          	addi	a2,a2,1766 # ffffffffc020b678 <commands+0x210>
ffffffffc0209f9a:	19500593          	li	a1,405
ffffffffc0209f9e:	00005517          	auipc	a0,0x5
ffffffffc0209fa2:	afa50513          	addi	a0,a0,-1286 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc0209fa6:	cf8f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209faa <sfs_getdirentry>:
ffffffffc0209faa:	715d                	addi	sp,sp,-80
ffffffffc0209fac:	ec56                	sd	s5,24(sp)
ffffffffc0209fae:	8aaa                	mv	s5,a0
ffffffffc0209fb0:	10400513          	li	a0,260
ffffffffc0209fb4:	e85a                	sd	s6,16(sp)
ffffffffc0209fb6:	e486                	sd	ra,72(sp)
ffffffffc0209fb8:	e0a2                	sd	s0,64(sp)
ffffffffc0209fba:	fc26                	sd	s1,56(sp)
ffffffffc0209fbc:	f84a                	sd	s2,48(sp)
ffffffffc0209fbe:	f44e                	sd	s3,40(sp)
ffffffffc0209fc0:	f052                	sd	s4,32(sp)
ffffffffc0209fc2:	e45e                	sd	s7,8(sp)
ffffffffc0209fc4:	e062                	sd	s8,0(sp)
ffffffffc0209fc6:	8b2e                	mv	s6,a1
ffffffffc0209fc8:	fc7f70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0209fcc:	cd61                	beqz	a0,ffffffffc020a0a4 <sfs_getdirentry+0xfa>
ffffffffc0209fce:	068abb83          	ld	s7,104(s5)
ffffffffc0209fd2:	0c0b8b63          	beqz	s7,ffffffffc020a0a8 <sfs_getdirentry+0xfe>
ffffffffc0209fd6:	0b0ba783          	lw	a5,176(s7)
ffffffffc0209fda:	e7f9                	bnez	a5,ffffffffc020a0a8 <sfs_getdirentry+0xfe>
ffffffffc0209fdc:	058aa703          	lw	a4,88(s5)
ffffffffc0209fe0:	6785                	lui	a5,0x1
ffffffffc0209fe2:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209fe6:	0ef71163          	bne	a4,a5,ffffffffc020a0c8 <sfs_getdirentry+0x11e>
ffffffffc0209fea:	008b3983          	ld	s3,8(s6)
ffffffffc0209fee:	892a                	mv	s2,a0
ffffffffc0209ff0:	0a09c163          	bltz	s3,ffffffffc020a092 <sfs_getdirentry+0xe8>
ffffffffc0209ff4:	0ff9f793          	zext.b	a5,s3
ffffffffc0209ff8:	efc9                	bnez	a5,ffffffffc020a092 <sfs_getdirentry+0xe8>
ffffffffc0209ffa:	000ab783          	ld	a5,0(s5)
ffffffffc0209ffe:	0089d993          	srli	s3,s3,0x8
ffffffffc020a002:	2981                	sext.w	s3,s3
ffffffffc020a004:	479c                	lw	a5,8(a5)
ffffffffc020a006:	0937eb63          	bltu	a5,s3,ffffffffc020a09c <sfs_getdirentry+0xf2>
ffffffffc020a00a:	020a8c13          	addi	s8,s5,32
ffffffffc020a00e:	8562                	mv	a0,s8
ffffffffc020a010:	d32fa0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc020a014:	000ab783          	ld	a5,0(s5)
ffffffffc020a018:	0087aa03          	lw	s4,8(a5)
ffffffffc020a01c:	07405663          	blez	s4,ffffffffc020a088 <sfs_getdirentry+0xde>
ffffffffc020a020:	4481                	li	s1,0
ffffffffc020a022:	a811                	j	ffffffffc020a036 <sfs_getdirentry+0x8c>
ffffffffc020a024:	00092783          	lw	a5,0(s2)
ffffffffc020a028:	c781                	beqz	a5,ffffffffc020a030 <sfs_getdirentry+0x86>
ffffffffc020a02a:	02098263          	beqz	s3,ffffffffc020a04e <sfs_getdirentry+0xa4>
ffffffffc020a02e:	39fd                	addiw	s3,s3,-1
ffffffffc020a030:	2485                	addiw	s1,s1,1
ffffffffc020a032:	049a0b63          	beq	s4,s1,ffffffffc020a088 <sfs_getdirentry+0xde>
ffffffffc020a036:	86ca                	mv	a3,s2
ffffffffc020a038:	8626                	mv	a2,s1
ffffffffc020a03a:	85d6                	mv	a1,s5
ffffffffc020a03c:	855e                	mv	a0,s7
ffffffffc020a03e:	eadff0ef          	jal	ra,ffffffffc0209eea <sfs_dirent_read_nolock>
ffffffffc020a042:	842a                	mv	s0,a0
ffffffffc020a044:	d165                	beqz	a0,ffffffffc020a024 <sfs_getdirentry+0x7a>
ffffffffc020a046:	8562                	mv	a0,s8
ffffffffc020a048:	cf6fa0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc020a04c:	a831                	j	ffffffffc020a068 <sfs_getdirentry+0xbe>
ffffffffc020a04e:	8562                	mv	a0,s8
ffffffffc020a050:	ceefa0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc020a054:	4701                	li	a4,0
ffffffffc020a056:	4685                	li	a3,1
ffffffffc020a058:	10000613          	li	a2,256
ffffffffc020a05c:	00490593          	addi	a1,s2,4
ffffffffc020a060:	855a                	mv	a0,s6
ffffffffc020a062:	b68fb0ef          	jal	ra,ffffffffc02053ca <iobuf_move>
ffffffffc020a066:	842a                	mv	s0,a0
ffffffffc020a068:	854a                	mv	a0,s2
ffffffffc020a06a:	fd5f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a06e:	60a6                	ld	ra,72(sp)
ffffffffc020a070:	8522                	mv	a0,s0
ffffffffc020a072:	6406                	ld	s0,64(sp)
ffffffffc020a074:	74e2                	ld	s1,56(sp)
ffffffffc020a076:	7942                	ld	s2,48(sp)
ffffffffc020a078:	79a2                	ld	s3,40(sp)
ffffffffc020a07a:	7a02                	ld	s4,32(sp)
ffffffffc020a07c:	6ae2                	ld	s5,24(sp)
ffffffffc020a07e:	6b42                	ld	s6,16(sp)
ffffffffc020a080:	6ba2                	ld	s7,8(sp)
ffffffffc020a082:	6c02                	ld	s8,0(sp)
ffffffffc020a084:	6161                	addi	sp,sp,80
ffffffffc020a086:	8082                	ret
ffffffffc020a088:	8562                	mv	a0,s8
ffffffffc020a08a:	5441                	li	s0,-16
ffffffffc020a08c:	cb2fa0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc020a090:	bfe1                	j	ffffffffc020a068 <sfs_getdirentry+0xbe>
ffffffffc020a092:	854a                	mv	a0,s2
ffffffffc020a094:	fabf70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a098:	5475                	li	s0,-3
ffffffffc020a09a:	bfd1                	j	ffffffffc020a06e <sfs_getdirentry+0xc4>
ffffffffc020a09c:	fa3f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a0a0:	5441                	li	s0,-16
ffffffffc020a0a2:	b7f1                	j	ffffffffc020a06e <sfs_getdirentry+0xc4>
ffffffffc020a0a4:	5471                	li	s0,-4
ffffffffc020a0a6:	b7e1                	j	ffffffffc020a06e <sfs_getdirentry+0xc4>
ffffffffc020a0a8:	00005697          	auipc	a3,0x5
ffffffffc020a0ac:	81068693          	addi	a3,a3,-2032 # ffffffffc020e8b8 <dev_node_ops+0x3e0>
ffffffffc020a0b0:	00001617          	auipc	a2,0x1
ffffffffc020a0b4:	5c860613          	addi	a2,a2,1480 # ffffffffc020b678 <commands+0x210>
ffffffffc020a0b8:	32800593          	li	a1,808
ffffffffc020a0bc:	00005517          	auipc	a0,0x5
ffffffffc020a0c0:	9dc50513          	addi	a0,a0,-1572 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a0c4:	bdaf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a0c8:	00005697          	auipc	a3,0x5
ffffffffc020a0cc:	99868693          	addi	a3,a3,-1640 # ffffffffc020ea60 <dev_node_ops+0x588>
ffffffffc020a0d0:	00001617          	auipc	a2,0x1
ffffffffc020a0d4:	5a860613          	addi	a2,a2,1448 # ffffffffc020b678 <commands+0x210>
ffffffffc020a0d8:	32900593          	li	a1,809
ffffffffc020a0dc:	00005517          	auipc	a0,0x5
ffffffffc020a0e0:	9bc50513          	addi	a0,a0,-1604 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a0e4:	bbaf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a0e8 <sfs_dirent_search_nolock.constprop.0>:
ffffffffc020a0e8:	715d                	addi	sp,sp,-80
ffffffffc020a0ea:	f052                	sd	s4,32(sp)
ffffffffc020a0ec:	8a2a                	mv	s4,a0
ffffffffc020a0ee:	8532                	mv	a0,a2
ffffffffc020a0f0:	f44e                	sd	s3,40(sp)
ffffffffc020a0f2:	e85a                	sd	s6,16(sp)
ffffffffc020a0f4:	e45e                	sd	s7,8(sp)
ffffffffc020a0f6:	e486                	sd	ra,72(sp)
ffffffffc020a0f8:	e0a2                	sd	s0,64(sp)
ffffffffc020a0fa:	fc26                	sd	s1,56(sp)
ffffffffc020a0fc:	f84a                	sd	s2,48(sp)
ffffffffc020a0fe:	ec56                	sd	s5,24(sp)
ffffffffc020a100:	e062                	sd	s8,0(sp)
ffffffffc020a102:	8b32                	mv	s6,a2
ffffffffc020a104:	89ae                	mv	s3,a1
ffffffffc020a106:	8bb6                	mv	s7,a3
ffffffffc020a108:	7eb000ef          	jal	ra,ffffffffc020b0f2 <strlen>
ffffffffc020a10c:	0ff00793          	li	a5,255
ffffffffc020a110:	06a7ef63          	bltu	a5,a0,ffffffffc020a18e <sfs_dirent_search_nolock.constprop.0+0xa6>
ffffffffc020a114:	10400513          	li	a0,260
ffffffffc020a118:	e77f70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020a11c:	892a                	mv	s2,a0
ffffffffc020a11e:	c535                	beqz	a0,ffffffffc020a18a <sfs_dirent_search_nolock.constprop.0+0xa2>
ffffffffc020a120:	0009b783          	ld	a5,0(s3)
ffffffffc020a124:	0087aa83          	lw	s5,8(a5)
ffffffffc020a128:	05505a63          	blez	s5,ffffffffc020a17c <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a12c:	4481                	li	s1,0
ffffffffc020a12e:	00450c13          	addi	s8,a0,4
ffffffffc020a132:	a829                	j	ffffffffc020a14c <sfs_dirent_search_nolock.constprop.0+0x64>
ffffffffc020a134:	00092783          	lw	a5,0(s2)
ffffffffc020a138:	c799                	beqz	a5,ffffffffc020a146 <sfs_dirent_search_nolock.constprop.0+0x5e>
ffffffffc020a13a:	85e2                	mv	a1,s8
ffffffffc020a13c:	855a                	mv	a0,s6
ffffffffc020a13e:	7fd000ef          	jal	ra,ffffffffc020b13a <strcmp>
ffffffffc020a142:	842a                	mv	s0,a0
ffffffffc020a144:	cd15                	beqz	a0,ffffffffc020a180 <sfs_dirent_search_nolock.constprop.0+0x98>
ffffffffc020a146:	2485                	addiw	s1,s1,1
ffffffffc020a148:	029a8a63          	beq	s5,s1,ffffffffc020a17c <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a14c:	86ca                	mv	a3,s2
ffffffffc020a14e:	8626                	mv	a2,s1
ffffffffc020a150:	85ce                	mv	a1,s3
ffffffffc020a152:	8552                	mv	a0,s4
ffffffffc020a154:	d97ff0ef          	jal	ra,ffffffffc0209eea <sfs_dirent_read_nolock>
ffffffffc020a158:	842a                	mv	s0,a0
ffffffffc020a15a:	dd69                	beqz	a0,ffffffffc020a134 <sfs_dirent_search_nolock.constprop.0+0x4c>
ffffffffc020a15c:	854a                	mv	a0,s2
ffffffffc020a15e:	ee1f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a162:	60a6                	ld	ra,72(sp)
ffffffffc020a164:	8522                	mv	a0,s0
ffffffffc020a166:	6406                	ld	s0,64(sp)
ffffffffc020a168:	74e2                	ld	s1,56(sp)
ffffffffc020a16a:	7942                	ld	s2,48(sp)
ffffffffc020a16c:	79a2                	ld	s3,40(sp)
ffffffffc020a16e:	7a02                	ld	s4,32(sp)
ffffffffc020a170:	6ae2                	ld	s5,24(sp)
ffffffffc020a172:	6b42                	ld	s6,16(sp)
ffffffffc020a174:	6ba2                	ld	s7,8(sp)
ffffffffc020a176:	6c02                	ld	s8,0(sp)
ffffffffc020a178:	6161                	addi	sp,sp,80
ffffffffc020a17a:	8082                	ret
ffffffffc020a17c:	5441                	li	s0,-16
ffffffffc020a17e:	bff9                	j	ffffffffc020a15c <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a180:	00092783          	lw	a5,0(s2)
ffffffffc020a184:	00fba023          	sw	a5,0(s7)
ffffffffc020a188:	bfd1                	j	ffffffffc020a15c <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a18a:	5471                	li	s0,-4
ffffffffc020a18c:	bfd9                	j	ffffffffc020a162 <sfs_dirent_search_nolock.constprop.0+0x7a>
ffffffffc020a18e:	00005697          	auipc	a3,0x5
ffffffffc020a192:	aea68693          	addi	a3,a3,-1302 # ffffffffc020ec78 <dev_node_ops+0x7a0>
ffffffffc020a196:	00001617          	auipc	a2,0x1
ffffffffc020a19a:	4e260613          	addi	a2,a2,1250 # ffffffffc020b678 <commands+0x210>
ffffffffc020a19e:	1ba00593          	li	a1,442
ffffffffc020a1a2:	00005517          	auipc	a0,0x5
ffffffffc020a1a6:	8f650513          	addi	a0,a0,-1802 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a1aa:	af4f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a1ae <sfs_truncfile>:
ffffffffc020a1ae:	7175                	addi	sp,sp,-144
ffffffffc020a1b0:	e506                	sd	ra,136(sp)
ffffffffc020a1b2:	e122                	sd	s0,128(sp)
ffffffffc020a1b4:	fca6                	sd	s1,120(sp)
ffffffffc020a1b6:	f8ca                	sd	s2,112(sp)
ffffffffc020a1b8:	f4ce                	sd	s3,104(sp)
ffffffffc020a1ba:	f0d2                	sd	s4,96(sp)
ffffffffc020a1bc:	ecd6                	sd	s5,88(sp)
ffffffffc020a1be:	e8da                	sd	s6,80(sp)
ffffffffc020a1c0:	e4de                	sd	s7,72(sp)
ffffffffc020a1c2:	e0e2                	sd	s8,64(sp)
ffffffffc020a1c4:	fc66                	sd	s9,56(sp)
ffffffffc020a1c6:	f86a                	sd	s10,48(sp)
ffffffffc020a1c8:	f46e                	sd	s11,40(sp)
ffffffffc020a1ca:	080007b7          	lui	a5,0x8000
ffffffffc020a1ce:	16b7e463          	bltu	a5,a1,ffffffffc020a336 <sfs_truncfile+0x188>
ffffffffc020a1d2:	06853c83          	ld	s9,104(a0)
ffffffffc020a1d6:	89aa                	mv	s3,a0
ffffffffc020a1d8:	160c8163          	beqz	s9,ffffffffc020a33a <sfs_truncfile+0x18c>
ffffffffc020a1dc:	0b0ca783          	lw	a5,176(s9) # 10b0 <_binary_bin_swap_img_size-0x6c50>
ffffffffc020a1e0:	14079d63          	bnez	a5,ffffffffc020a33a <sfs_truncfile+0x18c>
ffffffffc020a1e4:	4d38                	lw	a4,88(a0)
ffffffffc020a1e6:	6405                	lui	s0,0x1
ffffffffc020a1e8:	23540793          	addi	a5,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a1ec:	16f71763          	bne	a4,a5,ffffffffc020a35a <sfs_truncfile+0x1ac>
ffffffffc020a1f0:	00053a83          	ld	s5,0(a0)
ffffffffc020a1f4:	147d                	addi	s0,s0,-1
ffffffffc020a1f6:	942e                	add	s0,s0,a1
ffffffffc020a1f8:	000ae783          	lwu	a5,0(s5)
ffffffffc020a1fc:	8031                	srli	s0,s0,0xc
ffffffffc020a1fe:	8a2e                	mv	s4,a1
ffffffffc020a200:	2401                	sext.w	s0,s0
ffffffffc020a202:	02b79763          	bne	a5,a1,ffffffffc020a230 <sfs_truncfile+0x82>
ffffffffc020a206:	008aa783          	lw	a5,8(s5)
ffffffffc020a20a:	4901                	li	s2,0
ffffffffc020a20c:	18879763          	bne	a5,s0,ffffffffc020a39a <sfs_truncfile+0x1ec>
ffffffffc020a210:	60aa                	ld	ra,136(sp)
ffffffffc020a212:	640a                	ld	s0,128(sp)
ffffffffc020a214:	74e6                	ld	s1,120(sp)
ffffffffc020a216:	79a6                	ld	s3,104(sp)
ffffffffc020a218:	7a06                	ld	s4,96(sp)
ffffffffc020a21a:	6ae6                	ld	s5,88(sp)
ffffffffc020a21c:	6b46                	ld	s6,80(sp)
ffffffffc020a21e:	6ba6                	ld	s7,72(sp)
ffffffffc020a220:	6c06                	ld	s8,64(sp)
ffffffffc020a222:	7ce2                	ld	s9,56(sp)
ffffffffc020a224:	7d42                	ld	s10,48(sp)
ffffffffc020a226:	7da2                	ld	s11,40(sp)
ffffffffc020a228:	854a                	mv	a0,s2
ffffffffc020a22a:	7946                	ld	s2,112(sp)
ffffffffc020a22c:	6149                	addi	sp,sp,144
ffffffffc020a22e:	8082                	ret
ffffffffc020a230:	02050b13          	addi	s6,a0,32
ffffffffc020a234:	855a                	mv	a0,s6
ffffffffc020a236:	b0cfa0ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc020a23a:	008aa483          	lw	s1,8(s5)
ffffffffc020a23e:	0a84e663          	bltu	s1,s0,ffffffffc020a2ea <sfs_truncfile+0x13c>
ffffffffc020a242:	0c947163          	bgeu	s0,s1,ffffffffc020a304 <sfs_truncfile+0x156>
ffffffffc020a246:	4dad                	li	s11,11
ffffffffc020a248:	4b85                	li	s7,1
ffffffffc020a24a:	a09d                	j	ffffffffc020a2b0 <sfs_truncfile+0x102>
ffffffffc020a24c:	ff37091b          	addiw	s2,a4,-13
ffffffffc020a250:	0009079b          	sext.w	a5,s2
ffffffffc020a254:	3ff00713          	li	a4,1023
ffffffffc020a258:	04f76563          	bltu	a4,a5,ffffffffc020a2a2 <sfs_truncfile+0xf4>
ffffffffc020a25c:	03cd2c03          	lw	s8,60(s10)
ffffffffc020a260:	040c0163          	beqz	s8,ffffffffc020a2a2 <sfs_truncfile+0xf4>
ffffffffc020a264:	004ca783          	lw	a5,4(s9)
ffffffffc020a268:	18fc7963          	bgeu	s8,a5,ffffffffc020a3fa <sfs_truncfile+0x24c>
ffffffffc020a26c:	038cb503          	ld	a0,56(s9)
ffffffffc020a270:	85e2                	mv	a1,s8
ffffffffc020a272:	bd1fe0ef          	jal	ra,ffffffffc0208e42 <bitmap_test>
ffffffffc020a276:	16051263          	bnez	a0,ffffffffc020a3da <sfs_truncfile+0x22c>
ffffffffc020a27a:	02091793          	slli	a5,s2,0x20
ffffffffc020a27e:	01e7d713          	srli	a4,a5,0x1e
ffffffffc020a282:	86e2                	mv	a3,s8
ffffffffc020a284:	4611                	li	a2,4
ffffffffc020a286:	082c                	addi	a1,sp,24
ffffffffc020a288:	8566                	mv	a0,s9
ffffffffc020a28a:	e43a                	sd	a4,8(sp)
ffffffffc020a28c:	ce02                	sw	zero,28(sp)
ffffffffc020a28e:	782000ef          	jal	ra,ffffffffc020aa10 <sfs_rbuf>
ffffffffc020a292:	892a                	mv	s2,a0
ffffffffc020a294:	e141                	bnez	a0,ffffffffc020a314 <sfs_truncfile+0x166>
ffffffffc020a296:	47e2                	lw	a5,24(sp)
ffffffffc020a298:	6722                	ld	a4,8(sp)
ffffffffc020a29a:	e3c9                	bnez	a5,ffffffffc020a31c <sfs_truncfile+0x16e>
ffffffffc020a29c:	008d2603          	lw	a2,8(s10)
ffffffffc020a2a0:	367d                	addiw	a2,a2,-1
ffffffffc020a2a2:	00cd2423          	sw	a2,8(s10)
ffffffffc020a2a6:	0179b823          	sd	s7,16(s3)
ffffffffc020a2aa:	34fd                	addiw	s1,s1,-1
ffffffffc020a2ac:	04940a63          	beq	s0,s1,ffffffffc020a300 <sfs_truncfile+0x152>
ffffffffc020a2b0:	0009bd03          	ld	s10,0(s3)
ffffffffc020a2b4:	008d2703          	lw	a4,8(s10)
ffffffffc020a2b8:	c369                	beqz	a4,ffffffffc020a37a <sfs_truncfile+0x1cc>
ffffffffc020a2ba:	fff7079b          	addiw	a5,a4,-1
ffffffffc020a2be:	0007861b          	sext.w	a2,a5
ffffffffc020a2c2:	f8cde5e3          	bltu	s11,a2,ffffffffc020a24c <sfs_truncfile+0x9e>
ffffffffc020a2c6:	02079713          	slli	a4,a5,0x20
ffffffffc020a2ca:	01e75793          	srli	a5,a4,0x1e
ffffffffc020a2ce:	00fd0933          	add	s2,s10,a5
ffffffffc020a2d2:	00c92583          	lw	a1,12(s2)
ffffffffc020a2d6:	d5f1                	beqz	a1,ffffffffc020a2a2 <sfs_truncfile+0xf4>
ffffffffc020a2d8:	8566                	mv	a0,s9
ffffffffc020a2da:	c76ff0ef          	jal	ra,ffffffffc0209750 <sfs_block_free>
ffffffffc020a2de:	00092623          	sw	zero,12(s2)
ffffffffc020a2e2:	008d2603          	lw	a2,8(s10)
ffffffffc020a2e6:	367d                	addiw	a2,a2,-1
ffffffffc020a2e8:	bf6d                	j	ffffffffc020a2a2 <sfs_truncfile+0xf4>
ffffffffc020a2ea:	4681                	li	a3,0
ffffffffc020a2ec:	8626                	mv	a2,s1
ffffffffc020a2ee:	85ce                	mv	a1,s3
ffffffffc020a2f0:	8566                	mv	a0,s9
ffffffffc020a2f2:	f18ff0ef          	jal	ra,ffffffffc0209a0a <sfs_bmap_load_nolock>
ffffffffc020a2f6:	892a                	mv	s2,a0
ffffffffc020a2f8:	ed11                	bnez	a0,ffffffffc020a314 <sfs_truncfile+0x166>
ffffffffc020a2fa:	2485                	addiw	s1,s1,1
ffffffffc020a2fc:	fe9417e3          	bne	s0,s1,ffffffffc020a2ea <sfs_truncfile+0x13c>
ffffffffc020a300:	008aa483          	lw	s1,8(s5)
ffffffffc020a304:	0a941b63          	bne	s0,s1,ffffffffc020a3ba <sfs_truncfile+0x20c>
ffffffffc020a308:	014aa023          	sw	s4,0(s5)
ffffffffc020a30c:	4785                	li	a5,1
ffffffffc020a30e:	00f9b823          	sd	a5,16(s3)
ffffffffc020a312:	4901                	li	s2,0
ffffffffc020a314:	855a                	mv	a0,s6
ffffffffc020a316:	a28fa0ef          	jal	ra,ffffffffc020453e <up>
ffffffffc020a31a:	bddd                	j	ffffffffc020a210 <sfs_truncfile+0x62>
ffffffffc020a31c:	86e2                	mv	a3,s8
ffffffffc020a31e:	4611                	li	a2,4
ffffffffc020a320:	086c                	addi	a1,sp,28
ffffffffc020a322:	8566                	mv	a0,s9
ffffffffc020a324:	76c000ef          	jal	ra,ffffffffc020aa90 <sfs_wbuf>
ffffffffc020a328:	892a                	mv	s2,a0
ffffffffc020a32a:	f56d                	bnez	a0,ffffffffc020a314 <sfs_truncfile+0x166>
ffffffffc020a32c:	45e2                	lw	a1,24(sp)
ffffffffc020a32e:	8566                	mv	a0,s9
ffffffffc020a330:	c20ff0ef          	jal	ra,ffffffffc0209750 <sfs_block_free>
ffffffffc020a334:	b7a5                	j	ffffffffc020a29c <sfs_truncfile+0xee>
ffffffffc020a336:	5975                	li	s2,-3
ffffffffc020a338:	bde1                	j	ffffffffc020a210 <sfs_truncfile+0x62>
ffffffffc020a33a:	00004697          	auipc	a3,0x4
ffffffffc020a33e:	57e68693          	addi	a3,a3,1406 # ffffffffc020e8b8 <dev_node_ops+0x3e0>
ffffffffc020a342:	00001617          	auipc	a2,0x1
ffffffffc020a346:	33660613          	addi	a2,a2,822 # ffffffffc020b678 <commands+0x210>
ffffffffc020a34a:	39700593          	li	a1,919
ffffffffc020a34e:	00004517          	auipc	a0,0x4
ffffffffc020a352:	74a50513          	addi	a0,a0,1866 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a356:	948f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a35a:	00004697          	auipc	a3,0x4
ffffffffc020a35e:	70668693          	addi	a3,a3,1798 # ffffffffc020ea60 <dev_node_ops+0x588>
ffffffffc020a362:	00001617          	auipc	a2,0x1
ffffffffc020a366:	31660613          	addi	a2,a2,790 # ffffffffc020b678 <commands+0x210>
ffffffffc020a36a:	39800593          	li	a1,920
ffffffffc020a36e:	00004517          	auipc	a0,0x4
ffffffffc020a372:	72a50513          	addi	a0,a0,1834 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a376:	928f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a37a:	00005697          	auipc	a3,0x5
ffffffffc020a37e:	93e68693          	addi	a3,a3,-1730 # ffffffffc020ecb8 <dev_node_ops+0x7e0>
ffffffffc020a382:	00001617          	auipc	a2,0x1
ffffffffc020a386:	2f660613          	addi	a2,a2,758 # ffffffffc020b678 <commands+0x210>
ffffffffc020a38a:	17b00593          	li	a1,379
ffffffffc020a38e:	00004517          	auipc	a0,0x4
ffffffffc020a392:	70a50513          	addi	a0,a0,1802 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a396:	908f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a39a:	00005697          	auipc	a3,0x5
ffffffffc020a39e:	90668693          	addi	a3,a3,-1786 # ffffffffc020eca0 <dev_node_ops+0x7c8>
ffffffffc020a3a2:	00001617          	auipc	a2,0x1
ffffffffc020a3a6:	2d660613          	addi	a2,a2,726 # ffffffffc020b678 <commands+0x210>
ffffffffc020a3aa:	39f00593          	li	a1,927
ffffffffc020a3ae:	00004517          	auipc	a0,0x4
ffffffffc020a3b2:	6ea50513          	addi	a0,a0,1770 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a3b6:	8e8f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a3ba:	00005697          	auipc	a3,0x5
ffffffffc020a3be:	94e68693          	addi	a3,a3,-1714 # ffffffffc020ed08 <dev_node_ops+0x830>
ffffffffc020a3c2:	00001617          	auipc	a2,0x1
ffffffffc020a3c6:	2b660613          	addi	a2,a2,694 # ffffffffc020b678 <commands+0x210>
ffffffffc020a3ca:	3b800593          	li	a1,952
ffffffffc020a3ce:	00004517          	auipc	a0,0x4
ffffffffc020a3d2:	6ca50513          	addi	a0,a0,1738 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a3d6:	8c8f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a3da:	00005697          	auipc	a3,0x5
ffffffffc020a3de:	8f668693          	addi	a3,a3,-1802 # ffffffffc020ecd0 <dev_node_ops+0x7f8>
ffffffffc020a3e2:	00001617          	auipc	a2,0x1
ffffffffc020a3e6:	29660613          	addi	a2,a2,662 # ffffffffc020b678 <commands+0x210>
ffffffffc020a3ea:	12b00593          	li	a1,299
ffffffffc020a3ee:	00004517          	auipc	a0,0x4
ffffffffc020a3f2:	6aa50513          	addi	a0,a0,1706 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a3f6:	8a8f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a3fa:	8762                	mv	a4,s8
ffffffffc020a3fc:	86be                	mv	a3,a5
ffffffffc020a3fe:	00004617          	auipc	a2,0x4
ffffffffc020a402:	6ca60613          	addi	a2,a2,1738 # ffffffffc020eac8 <dev_node_ops+0x5f0>
ffffffffc020a406:	05300593          	li	a1,83
ffffffffc020a40a:	00004517          	auipc	a0,0x4
ffffffffc020a40e:	68e50513          	addi	a0,a0,1678 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a412:	88cf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a416 <sfs_load_inode>:
ffffffffc020a416:	7139                	addi	sp,sp,-64
ffffffffc020a418:	fc06                	sd	ra,56(sp)
ffffffffc020a41a:	f822                	sd	s0,48(sp)
ffffffffc020a41c:	f426                	sd	s1,40(sp)
ffffffffc020a41e:	f04a                	sd	s2,32(sp)
ffffffffc020a420:	84b2                	mv	s1,a2
ffffffffc020a422:	892a                	mv	s2,a0
ffffffffc020a424:	ec4e                	sd	s3,24(sp)
ffffffffc020a426:	e852                	sd	s4,16(sp)
ffffffffc020a428:	89ae                	mv	s3,a1
ffffffffc020a42a:	e456                	sd	s5,8(sp)
ffffffffc020a42c:	015000ef          	jal	ra,ffffffffc020ac40 <lock_sfs_fs>
ffffffffc020a430:	45a9                	li	a1,10
ffffffffc020a432:	8526                	mv	a0,s1
ffffffffc020a434:	0a893403          	ld	s0,168(s2)
ffffffffc020a438:	029000ef          	jal	ra,ffffffffc020ac60 <hash32>
ffffffffc020a43c:	02051793          	slli	a5,a0,0x20
ffffffffc020a440:	01c7d713          	srli	a4,a5,0x1c
ffffffffc020a444:	9722                	add	a4,a4,s0
ffffffffc020a446:	843a                	mv	s0,a4
ffffffffc020a448:	a029                	j	ffffffffc020a452 <sfs_load_inode+0x3c>
ffffffffc020a44a:	fc042783          	lw	a5,-64(s0)
ffffffffc020a44e:	10978863          	beq	a5,s1,ffffffffc020a55e <sfs_load_inode+0x148>
ffffffffc020a452:	6400                	ld	s0,8(s0)
ffffffffc020a454:	fe871be3          	bne	a4,s0,ffffffffc020a44a <sfs_load_inode+0x34>
ffffffffc020a458:	04000513          	li	a0,64
ffffffffc020a45c:	b33f70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020a460:	8aaa                	mv	s5,a0
ffffffffc020a462:	16050563          	beqz	a0,ffffffffc020a5cc <sfs_load_inode+0x1b6>
ffffffffc020a466:	00492683          	lw	a3,4(s2)
ffffffffc020a46a:	18048363          	beqz	s1,ffffffffc020a5f0 <sfs_load_inode+0x1da>
ffffffffc020a46e:	18d4f163          	bgeu	s1,a3,ffffffffc020a5f0 <sfs_load_inode+0x1da>
ffffffffc020a472:	03893503          	ld	a0,56(s2)
ffffffffc020a476:	85a6                	mv	a1,s1
ffffffffc020a478:	9cbfe0ef          	jal	ra,ffffffffc0208e42 <bitmap_test>
ffffffffc020a47c:	18051763          	bnez	a0,ffffffffc020a60a <sfs_load_inode+0x1f4>
ffffffffc020a480:	4701                	li	a4,0
ffffffffc020a482:	86a6                	mv	a3,s1
ffffffffc020a484:	04000613          	li	a2,64
ffffffffc020a488:	85d6                	mv	a1,s5
ffffffffc020a48a:	854a                	mv	a0,s2
ffffffffc020a48c:	584000ef          	jal	ra,ffffffffc020aa10 <sfs_rbuf>
ffffffffc020a490:	842a                	mv	s0,a0
ffffffffc020a492:	0e051563          	bnez	a0,ffffffffc020a57c <sfs_load_inode+0x166>
ffffffffc020a496:	006ad783          	lhu	a5,6(s5)
ffffffffc020a49a:	12078b63          	beqz	a5,ffffffffc020a5d0 <sfs_load_inode+0x1ba>
ffffffffc020a49e:	6405                	lui	s0,0x1
ffffffffc020a4a0:	23540513          	addi	a0,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a4a4:	958fd0ef          	jal	ra,ffffffffc02075fc <__alloc_inode>
ffffffffc020a4a8:	8a2a                	mv	s4,a0
ffffffffc020a4aa:	c961                	beqz	a0,ffffffffc020a57a <sfs_load_inode+0x164>
ffffffffc020a4ac:	004ad683          	lhu	a3,4(s5)
ffffffffc020a4b0:	4785                	li	a5,1
ffffffffc020a4b2:	0cf69c63          	bne	a3,a5,ffffffffc020a58a <sfs_load_inode+0x174>
ffffffffc020a4b6:	864a                	mv	a2,s2
ffffffffc020a4b8:	00005597          	auipc	a1,0x5
ffffffffc020a4bc:	96058593          	addi	a1,a1,-1696 # ffffffffc020ee18 <sfs_node_fileops>
ffffffffc020a4c0:	958fd0ef          	jal	ra,ffffffffc0207618 <inode_init>
ffffffffc020a4c4:	058a2783          	lw	a5,88(s4)
ffffffffc020a4c8:	23540413          	addi	s0,s0,565
ffffffffc020a4cc:	0e879063          	bne	a5,s0,ffffffffc020a5ac <sfs_load_inode+0x196>
ffffffffc020a4d0:	4785                	li	a5,1
ffffffffc020a4d2:	00fa2c23          	sw	a5,24(s4)
ffffffffc020a4d6:	015a3023          	sd	s5,0(s4)
ffffffffc020a4da:	009a2423          	sw	s1,8(s4)
ffffffffc020a4de:	000a3823          	sd	zero,16(s4)
ffffffffc020a4e2:	4585                	li	a1,1
ffffffffc020a4e4:	020a0513          	addi	a0,s4,32
ffffffffc020a4e8:	850fa0ef          	jal	ra,ffffffffc0204538 <sem_init>
ffffffffc020a4ec:	058a2703          	lw	a4,88(s4)
ffffffffc020a4f0:	6785                	lui	a5,0x1
ffffffffc020a4f2:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a4f6:	14f71663          	bne	a4,a5,ffffffffc020a642 <sfs_load_inode+0x22c>
ffffffffc020a4fa:	0a093703          	ld	a4,160(s2)
ffffffffc020a4fe:	038a0793          	addi	a5,s4,56
ffffffffc020a502:	008a2503          	lw	a0,8(s4)
ffffffffc020a506:	e31c                	sd	a5,0(a4)
ffffffffc020a508:	0af93023          	sd	a5,160(s2)
ffffffffc020a50c:	09890793          	addi	a5,s2,152
ffffffffc020a510:	0a893403          	ld	s0,168(s2)
ffffffffc020a514:	45a9                	li	a1,10
ffffffffc020a516:	04ea3023          	sd	a4,64(s4)
ffffffffc020a51a:	02fa3c23          	sd	a5,56(s4)
ffffffffc020a51e:	742000ef          	jal	ra,ffffffffc020ac60 <hash32>
ffffffffc020a522:	02051713          	slli	a4,a0,0x20
ffffffffc020a526:	01c75793          	srli	a5,a4,0x1c
ffffffffc020a52a:	97a2                	add	a5,a5,s0
ffffffffc020a52c:	6798                	ld	a4,8(a5)
ffffffffc020a52e:	048a0693          	addi	a3,s4,72
ffffffffc020a532:	e314                	sd	a3,0(a4)
ffffffffc020a534:	e794                	sd	a3,8(a5)
ffffffffc020a536:	04ea3823          	sd	a4,80(s4)
ffffffffc020a53a:	04fa3423          	sd	a5,72(s4)
ffffffffc020a53e:	854a                	mv	a0,s2
ffffffffc020a540:	710000ef          	jal	ra,ffffffffc020ac50 <unlock_sfs_fs>
ffffffffc020a544:	4401                	li	s0,0
ffffffffc020a546:	0149b023          	sd	s4,0(s3)
ffffffffc020a54a:	70e2                	ld	ra,56(sp)
ffffffffc020a54c:	8522                	mv	a0,s0
ffffffffc020a54e:	7442                	ld	s0,48(sp)
ffffffffc020a550:	74a2                	ld	s1,40(sp)
ffffffffc020a552:	7902                	ld	s2,32(sp)
ffffffffc020a554:	69e2                	ld	s3,24(sp)
ffffffffc020a556:	6a42                	ld	s4,16(sp)
ffffffffc020a558:	6aa2                	ld	s5,8(sp)
ffffffffc020a55a:	6121                	addi	sp,sp,64
ffffffffc020a55c:	8082                	ret
ffffffffc020a55e:	fb840a13          	addi	s4,s0,-72
ffffffffc020a562:	8552                	mv	a0,s4
ffffffffc020a564:	916fd0ef          	jal	ra,ffffffffc020767a <inode_ref_inc>
ffffffffc020a568:	4785                	li	a5,1
ffffffffc020a56a:	fcf51ae3          	bne	a0,a5,ffffffffc020a53e <sfs_load_inode+0x128>
ffffffffc020a56e:	fd042783          	lw	a5,-48(s0)
ffffffffc020a572:	2785                	addiw	a5,a5,1
ffffffffc020a574:	fcf42823          	sw	a5,-48(s0)
ffffffffc020a578:	b7d9                	j	ffffffffc020a53e <sfs_load_inode+0x128>
ffffffffc020a57a:	5471                	li	s0,-4
ffffffffc020a57c:	8556                	mv	a0,s5
ffffffffc020a57e:	ac1f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a582:	854a                	mv	a0,s2
ffffffffc020a584:	6cc000ef          	jal	ra,ffffffffc020ac50 <unlock_sfs_fs>
ffffffffc020a588:	b7c9                	j	ffffffffc020a54a <sfs_load_inode+0x134>
ffffffffc020a58a:	4789                	li	a5,2
ffffffffc020a58c:	08f69f63          	bne	a3,a5,ffffffffc020a62a <sfs_load_inode+0x214>
ffffffffc020a590:	864a                	mv	a2,s2
ffffffffc020a592:	00005597          	auipc	a1,0x5
ffffffffc020a596:	80658593          	addi	a1,a1,-2042 # ffffffffc020ed98 <sfs_node_dirops>
ffffffffc020a59a:	87efd0ef          	jal	ra,ffffffffc0207618 <inode_init>
ffffffffc020a59e:	058a2703          	lw	a4,88(s4)
ffffffffc020a5a2:	6785                	lui	a5,0x1
ffffffffc020a5a4:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a5a8:	f2f704e3          	beq	a4,a5,ffffffffc020a4d0 <sfs_load_inode+0xba>
ffffffffc020a5ac:	00004697          	auipc	a3,0x4
ffffffffc020a5b0:	4b468693          	addi	a3,a3,1204 # ffffffffc020ea60 <dev_node_ops+0x588>
ffffffffc020a5b4:	00001617          	auipc	a2,0x1
ffffffffc020a5b8:	0c460613          	addi	a2,a2,196 # ffffffffc020b678 <commands+0x210>
ffffffffc020a5bc:	07700593          	li	a1,119
ffffffffc020a5c0:	00004517          	auipc	a0,0x4
ffffffffc020a5c4:	4d850513          	addi	a0,a0,1240 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a5c8:	ed7f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a5cc:	5471                	li	s0,-4
ffffffffc020a5ce:	bf55                	j	ffffffffc020a582 <sfs_load_inode+0x16c>
ffffffffc020a5d0:	00004697          	auipc	a3,0x4
ffffffffc020a5d4:	75068693          	addi	a3,a3,1872 # ffffffffc020ed20 <dev_node_ops+0x848>
ffffffffc020a5d8:	00001617          	auipc	a2,0x1
ffffffffc020a5dc:	0a060613          	addi	a2,a2,160 # ffffffffc020b678 <commands+0x210>
ffffffffc020a5e0:	0ad00593          	li	a1,173
ffffffffc020a5e4:	00004517          	auipc	a0,0x4
ffffffffc020a5e8:	4b450513          	addi	a0,a0,1204 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a5ec:	eb3f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a5f0:	8726                	mv	a4,s1
ffffffffc020a5f2:	00004617          	auipc	a2,0x4
ffffffffc020a5f6:	4d660613          	addi	a2,a2,1238 # ffffffffc020eac8 <dev_node_ops+0x5f0>
ffffffffc020a5fa:	05300593          	li	a1,83
ffffffffc020a5fe:	00004517          	auipc	a0,0x4
ffffffffc020a602:	49a50513          	addi	a0,a0,1178 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a606:	e99f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a60a:	00004697          	auipc	a3,0x4
ffffffffc020a60e:	4f668693          	addi	a3,a3,1270 # ffffffffc020eb00 <dev_node_ops+0x628>
ffffffffc020a612:	00001617          	auipc	a2,0x1
ffffffffc020a616:	06660613          	addi	a2,a2,102 # ffffffffc020b678 <commands+0x210>
ffffffffc020a61a:	0a800593          	li	a1,168
ffffffffc020a61e:	00004517          	auipc	a0,0x4
ffffffffc020a622:	47a50513          	addi	a0,a0,1146 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a626:	e79f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a62a:	00004617          	auipc	a2,0x4
ffffffffc020a62e:	48660613          	addi	a2,a2,1158 # ffffffffc020eab0 <dev_node_ops+0x5d8>
ffffffffc020a632:	02e00593          	li	a1,46
ffffffffc020a636:	00004517          	auipc	a0,0x4
ffffffffc020a63a:	46250513          	addi	a0,a0,1122 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a63e:	e61f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a642:	00004697          	auipc	a3,0x4
ffffffffc020a646:	41e68693          	addi	a3,a3,1054 # ffffffffc020ea60 <dev_node_ops+0x588>
ffffffffc020a64a:	00001617          	auipc	a2,0x1
ffffffffc020a64e:	02e60613          	addi	a2,a2,46 # ffffffffc020b678 <commands+0x210>
ffffffffc020a652:	0b100593          	li	a1,177
ffffffffc020a656:	00004517          	auipc	a0,0x4
ffffffffc020a65a:	44250513          	addi	a0,a0,1090 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a65e:	e41f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a662 <sfs_lookup>:
ffffffffc020a662:	7139                	addi	sp,sp,-64
ffffffffc020a664:	ec4e                	sd	s3,24(sp)
ffffffffc020a666:	06853983          	ld	s3,104(a0)
ffffffffc020a66a:	fc06                	sd	ra,56(sp)
ffffffffc020a66c:	f822                	sd	s0,48(sp)
ffffffffc020a66e:	f426                	sd	s1,40(sp)
ffffffffc020a670:	f04a                	sd	s2,32(sp)
ffffffffc020a672:	e852                	sd	s4,16(sp)
ffffffffc020a674:	0a098c63          	beqz	s3,ffffffffc020a72c <sfs_lookup+0xca>
ffffffffc020a678:	0b09a783          	lw	a5,176(s3)
ffffffffc020a67c:	ebc5                	bnez	a5,ffffffffc020a72c <sfs_lookup+0xca>
ffffffffc020a67e:	0005c783          	lbu	a5,0(a1)
ffffffffc020a682:	84ae                	mv	s1,a1
ffffffffc020a684:	c7c1                	beqz	a5,ffffffffc020a70c <sfs_lookup+0xaa>
ffffffffc020a686:	02f00713          	li	a4,47
ffffffffc020a68a:	08e78163          	beq	a5,a4,ffffffffc020a70c <sfs_lookup+0xaa>
ffffffffc020a68e:	842a                	mv	s0,a0
ffffffffc020a690:	8a32                	mv	s4,a2
ffffffffc020a692:	fe9fc0ef          	jal	ra,ffffffffc020767a <inode_ref_inc>
ffffffffc020a696:	4c38                	lw	a4,88(s0)
ffffffffc020a698:	6785                	lui	a5,0x1
ffffffffc020a69a:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a69e:	0af71763          	bne	a4,a5,ffffffffc020a74c <sfs_lookup+0xea>
ffffffffc020a6a2:	6018                	ld	a4,0(s0)
ffffffffc020a6a4:	4789                	li	a5,2
ffffffffc020a6a6:	00475703          	lhu	a4,4(a4)
ffffffffc020a6aa:	04f71c63          	bne	a4,a5,ffffffffc020a702 <sfs_lookup+0xa0>
ffffffffc020a6ae:	02040913          	addi	s2,s0,32
ffffffffc020a6b2:	854a                	mv	a0,s2
ffffffffc020a6b4:	e8ff90ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc020a6b8:	8626                	mv	a2,s1
ffffffffc020a6ba:	0054                	addi	a3,sp,4
ffffffffc020a6bc:	85a2                	mv	a1,s0
ffffffffc020a6be:	854e                	mv	a0,s3
ffffffffc020a6c0:	a29ff0ef          	jal	ra,ffffffffc020a0e8 <sfs_dirent_search_nolock.constprop.0>
ffffffffc020a6c4:	84aa                	mv	s1,a0
ffffffffc020a6c6:	854a                	mv	a0,s2
ffffffffc020a6c8:	e77f90ef          	jal	ra,ffffffffc020453e <up>
ffffffffc020a6cc:	cc89                	beqz	s1,ffffffffc020a6e6 <sfs_lookup+0x84>
ffffffffc020a6ce:	8522                	mv	a0,s0
ffffffffc020a6d0:	878fd0ef          	jal	ra,ffffffffc0207748 <inode_ref_dec>
ffffffffc020a6d4:	70e2                	ld	ra,56(sp)
ffffffffc020a6d6:	7442                	ld	s0,48(sp)
ffffffffc020a6d8:	7902                	ld	s2,32(sp)
ffffffffc020a6da:	69e2                	ld	s3,24(sp)
ffffffffc020a6dc:	6a42                	ld	s4,16(sp)
ffffffffc020a6de:	8526                	mv	a0,s1
ffffffffc020a6e0:	74a2                	ld	s1,40(sp)
ffffffffc020a6e2:	6121                	addi	sp,sp,64
ffffffffc020a6e4:	8082                	ret
ffffffffc020a6e6:	4612                	lw	a2,4(sp)
ffffffffc020a6e8:	002c                	addi	a1,sp,8
ffffffffc020a6ea:	854e                	mv	a0,s3
ffffffffc020a6ec:	d2bff0ef          	jal	ra,ffffffffc020a416 <sfs_load_inode>
ffffffffc020a6f0:	84aa                	mv	s1,a0
ffffffffc020a6f2:	8522                	mv	a0,s0
ffffffffc020a6f4:	854fd0ef          	jal	ra,ffffffffc0207748 <inode_ref_dec>
ffffffffc020a6f8:	fcf1                	bnez	s1,ffffffffc020a6d4 <sfs_lookup+0x72>
ffffffffc020a6fa:	67a2                	ld	a5,8(sp)
ffffffffc020a6fc:	00fa3023          	sd	a5,0(s4)
ffffffffc020a700:	bfd1                	j	ffffffffc020a6d4 <sfs_lookup+0x72>
ffffffffc020a702:	8522                	mv	a0,s0
ffffffffc020a704:	844fd0ef          	jal	ra,ffffffffc0207748 <inode_ref_dec>
ffffffffc020a708:	54b9                	li	s1,-18
ffffffffc020a70a:	b7e9                	j	ffffffffc020a6d4 <sfs_lookup+0x72>
ffffffffc020a70c:	00004697          	auipc	a3,0x4
ffffffffc020a710:	62c68693          	addi	a3,a3,1580 # ffffffffc020ed38 <dev_node_ops+0x860>
ffffffffc020a714:	00001617          	auipc	a2,0x1
ffffffffc020a718:	f6460613          	addi	a2,a2,-156 # ffffffffc020b678 <commands+0x210>
ffffffffc020a71c:	3c900593          	li	a1,969
ffffffffc020a720:	00004517          	auipc	a0,0x4
ffffffffc020a724:	37850513          	addi	a0,a0,888 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a728:	d77f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a72c:	00004697          	auipc	a3,0x4
ffffffffc020a730:	18c68693          	addi	a3,a3,396 # ffffffffc020e8b8 <dev_node_ops+0x3e0>
ffffffffc020a734:	00001617          	auipc	a2,0x1
ffffffffc020a738:	f4460613          	addi	a2,a2,-188 # ffffffffc020b678 <commands+0x210>
ffffffffc020a73c:	3c800593          	li	a1,968
ffffffffc020a740:	00004517          	auipc	a0,0x4
ffffffffc020a744:	35850513          	addi	a0,a0,856 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a748:	d57f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a74c:	00004697          	auipc	a3,0x4
ffffffffc020a750:	31468693          	addi	a3,a3,788 # ffffffffc020ea60 <dev_node_ops+0x588>
ffffffffc020a754:	00001617          	auipc	a2,0x1
ffffffffc020a758:	f2460613          	addi	a2,a2,-220 # ffffffffc020b678 <commands+0x210>
ffffffffc020a75c:	3cb00593          	li	a1,971
ffffffffc020a760:	00004517          	auipc	a0,0x4
ffffffffc020a764:	33850513          	addi	a0,a0,824 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a768:	d37f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a76c <sfs_namefile>:
ffffffffc020a76c:	6d98                	ld	a4,24(a1)
ffffffffc020a76e:	7175                	addi	sp,sp,-144
ffffffffc020a770:	e506                	sd	ra,136(sp)
ffffffffc020a772:	e122                	sd	s0,128(sp)
ffffffffc020a774:	fca6                	sd	s1,120(sp)
ffffffffc020a776:	f8ca                	sd	s2,112(sp)
ffffffffc020a778:	f4ce                	sd	s3,104(sp)
ffffffffc020a77a:	f0d2                	sd	s4,96(sp)
ffffffffc020a77c:	ecd6                	sd	s5,88(sp)
ffffffffc020a77e:	e8da                	sd	s6,80(sp)
ffffffffc020a780:	e4de                	sd	s7,72(sp)
ffffffffc020a782:	e0e2                	sd	s8,64(sp)
ffffffffc020a784:	fc66                	sd	s9,56(sp)
ffffffffc020a786:	f86a                	sd	s10,48(sp)
ffffffffc020a788:	f46e                	sd	s11,40(sp)
ffffffffc020a78a:	e42e                	sd	a1,8(sp)
ffffffffc020a78c:	4789                	li	a5,2
ffffffffc020a78e:	1ae7f363          	bgeu	a5,a4,ffffffffc020a934 <sfs_namefile+0x1c8>
ffffffffc020a792:	89aa                	mv	s3,a0
ffffffffc020a794:	10400513          	li	a0,260
ffffffffc020a798:	ff6f70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020a79c:	842a                	mv	s0,a0
ffffffffc020a79e:	18050b63          	beqz	a0,ffffffffc020a934 <sfs_namefile+0x1c8>
ffffffffc020a7a2:	0689b483          	ld	s1,104(s3)
ffffffffc020a7a6:	1e048963          	beqz	s1,ffffffffc020a998 <sfs_namefile+0x22c>
ffffffffc020a7aa:	0b04a783          	lw	a5,176(s1)
ffffffffc020a7ae:	1e079563          	bnez	a5,ffffffffc020a998 <sfs_namefile+0x22c>
ffffffffc020a7b2:	0589ac83          	lw	s9,88(s3)
ffffffffc020a7b6:	6785                	lui	a5,0x1
ffffffffc020a7b8:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a7bc:	1afc9e63          	bne	s9,a5,ffffffffc020a978 <sfs_namefile+0x20c>
ffffffffc020a7c0:	6722                	ld	a4,8(sp)
ffffffffc020a7c2:	854e                	mv	a0,s3
ffffffffc020a7c4:	8ace                	mv	s5,s3
ffffffffc020a7c6:	6f1c                	ld	a5,24(a4)
ffffffffc020a7c8:	00073b03          	ld	s6,0(a4)
ffffffffc020a7cc:	02098a13          	addi	s4,s3,32
ffffffffc020a7d0:	ffe78b93          	addi	s7,a5,-2
ffffffffc020a7d4:	9b3e                	add	s6,s6,a5
ffffffffc020a7d6:	00004d17          	auipc	s10,0x4
ffffffffc020a7da:	582d0d13          	addi	s10,s10,1410 # ffffffffc020ed58 <dev_node_ops+0x880>
ffffffffc020a7de:	e9dfc0ef          	jal	ra,ffffffffc020767a <inode_ref_inc>
ffffffffc020a7e2:	00440c13          	addi	s8,s0,4
ffffffffc020a7e6:	e066                	sd	s9,0(sp)
ffffffffc020a7e8:	8552                	mv	a0,s4
ffffffffc020a7ea:	d59f90ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc020a7ee:	0854                	addi	a3,sp,20
ffffffffc020a7f0:	866a                	mv	a2,s10
ffffffffc020a7f2:	85d6                	mv	a1,s5
ffffffffc020a7f4:	8526                	mv	a0,s1
ffffffffc020a7f6:	8f3ff0ef          	jal	ra,ffffffffc020a0e8 <sfs_dirent_search_nolock.constprop.0>
ffffffffc020a7fa:	8daa                	mv	s11,a0
ffffffffc020a7fc:	8552                	mv	a0,s4
ffffffffc020a7fe:	d41f90ef          	jal	ra,ffffffffc020453e <up>
ffffffffc020a802:	020d8863          	beqz	s11,ffffffffc020a832 <sfs_namefile+0xc6>
ffffffffc020a806:	854e                	mv	a0,s3
ffffffffc020a808:	f41fc0ef          	jal	ra,ffffffffc0207748 <inode_ref_dec>
ffffffffc020a80c:	8522                	mv	a0,s0
ffffffffc020a80e:	831f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a812:	60aa                	ld	ra,136(sp)
ffffffffc020a814:	640a                	ld	s0,128(sp)
ffffffffc020a816:	74e6                	ld	s1,120(sp)
ffffffffc020a818:	7946                	ld	s2,112(sp)
ffffffffc020a81a:	79a6                	ld	s3,104(sp)
ffffffffc020a81c:	7a06                	ld	s4,96(sp)
ffffffffc020a81e:	6ae6                	ld	s5,88(sp)
ffffffffc020a820:	6b46                	ld	s6,80(sp)
ffffffffc020a822:	6ba6                	ld	s7,72(sp)
ffffffffc020a824:	6c06                	ld	s8,64(sp)
ffffffffc020a826:	7ce2                	ld	s9,56(sp)
ffffffffc020a828:	7d42                	ld	s10,48(sp)
ffffffffc020a82a:	856e                	mv	a0,s11
ffffffffc020a82c:	7da2                	ld	s11,40(sp)
ffffffffc020a82e:	6149                	addi	sp,sp,144
ffffffffc020a830:	8082                	ret
ffffffffc020a832:	4652                	lw	a2,20(sp)
ffffffffc020a834:	082c                	addi	a1,sp,24
ffffffffc020a836:	8526                	mv	a0,s1
ffffffffc020a838:	bdfff0ef          	jal	ra,ffffffffc020a416 <sfs_load_inode>
ffffffffc020a83c:	8daa                	mv	s11,a0
ffffffffc020a83e:	f561                	bnez	a0,ffffffffc020a806 <sfs_namefile+0x9a>
ffffffffc020a840:	854e                	mv	a0,s3
ffffffffc020a842:	008aa903          	lw	s2,8(s5)
ffffffffc020a846:	f03fc0ef          	jal	ra,ffffffffc0207748 <inode_ref_dec>
ffffffffc020a84a:	6ce2                	ld	s9,24(sp)
ffffffffc020a84c:	0b3c8463          	beq	s9,s3,ffffffffc020a8f4 <sfs_namefile+0x188>
ffffffffc020a850:	100c8463          	beqz	s9,ffffffffc020a958 <sfs_namefile+0x1ec>
ffffffffc020a854:	058ca703          	lw	a4,88(s9)
ffffffffc020a858:	6782                	ld	a5,0(sp)
ffffffffc020a85a:	0ef71f63          	bne	a4,a5,ffffffffc020a958 <sfs_namefile+0x1ec>
ffffffffc020a85e:	008ca703          	lw	a4,8(s9)
ffffffffc020a862:	8ae6                	mv	s5,s9
ffffffffc020a864:	0d270a63          	beq	a4,s2,ffffffffc020a938 <sfs_namefile+0x1cc>
ffffffffc020a868:	000cb703          	ld	a4,0(s9)
ffffffffc020a86c:	4789                	li	a5,2
ffffffffc020a86e:	00475703          	lhu	a4,4(a4)
ffffffffc020a872:	0cf71363          	bne	a4,a5,ffffffffc020a938 <sfs_namefile+0x1cc>
ffffffffc020a876:	020c8a13          	addi	s4,s9,32
ffffffffc020a87a:	8552                	mv	a0,s4
ffffffffc020a87c:	cc7f90ef          	jal	ra,ffffffffc0204542 <down>
ffffffffc020a880:	000cb703          	ld	a4,0(s9)
ffffffffc020a884:	00872983          	lw	s3,8(a4)
ffffffffc020a888:	01304963          	bgtz	s3,ffffffffc020a89a <sfs_namefile+0x12e>
ffffffffc020a88c:	a899                	j	ffffffffc020a8e2 <sfs_namefile+0x176>
ffffffffc020a88e:	4018                	lw	a4,0(s0)
ffffffffc020a890:	01270e63          	beq	a4,s2,ffffffffc020a8ac <sfs_namefile+0x140>
ffffffffc020a894:	2d85                	addiw	s11,s11,1
ffffffffc020a896:	05b98663          	beq	s3,s11,ffffffffc020a8e2 <sfs_namefile+0x176>
ffffffffc020a89a:	86a2                	mv	a3,s0
ffffffffc020a89c:	866e                	mv	a2,s11
ffffffffc020a89e:	85e6                	mv	a1,s9
ffffffffc020a8a0:	8526                	mv	a0,s1
ffffffffc020a8a2:	e48ff0ef          	jal	ra,ffffffffc0209eea <sfs_dirent_read_nolock>
ffffffffc020a8a6:	872a                	mv	a4,a0
ffffffffc020a8a8:	d17d                	beqz	a0,ffffffffc020a88e <sfs_namefile+0x122>
ffffffffc020a8aa:	a82d                	j	ffffffffc020a8e4 <sfs_namefile+0x178>
ffffffffc020a8ac:	8552                	mv	a0,s4
ffffffffc020a8ae:	c91f90ef          	jal	ra,ffffffffc020453e <up>
ffffffffc020a8b2:	8562                	mv	a0,s8
ffffffffc020a8b4:	03f000ef          	jal	ra,ffffffffc020b0f2 <strlen>
ffffffffc020a8b8:	00150793          	addi	a5,a0,1
ffffffffc020a8bc:	862a                	mv	a2,a0
ffffffffc020a8be:	06fbe863          	bltu	s7,a5,ffffffffc020a92e <sfs_namefile+0x1c2>
ffffffffc020a8c2:	fff64913          	not	s2,a2
ffffffffc020a8c6:	995a                	add	s2,s2,s6
ffffffffc020a8c8:	85e2                	mv	a1,s8
ffffffffc020a8ca:	854a                	mv	a0,s2
ffffffffc020a8cc:	40fb8bb3          	sub	s7,s7,a5
ffffffffc020a8d0:	117000ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc020a8d4:	02f00793          	li	a5,47
ffffffffc020a8d8:	fefb0fa3          	sb	a5,-1(s6)
ffffffffc020a8dc:	89e6                	mv	s3,s9
ffffffffc020a8de:	8b4a                	mv	s6,s2
ffffffffc020a8e0:	b721                	j	ffffffffc020a7e8 <sfs_namefile+0x7c>
ffffffffc020a8e2:	5741                	li	a4,-16
ffffffffc020a8e4:	8552                	mv	a0,s4
ffffffffc020a8e6:	e03a                	sd	a4,0(sp)
ffffffffc020a8e8:	c57f90ef          	jal	ra,ffffffffc020453e <up>
ffffffffc020a8ec:	6702                	ld	a4,0(sp)
ffffffffc020a8ee:	89e6                	mv	s3,s9
ffffffffc020a8f0:	8dba                	mv	s11,a4
ffffffffc020a8f2:	bf11                	j	ffffffffc020a806 <sfs_namefile+0x9a>
ffffffffc020a8f4:	854e                	mv	a0,s3
ffffffffc020a8f6:	e53fc0ef          	jal	ra,ffffffffc0207748 <inode_ref_dec>
ffffffffc020a8fa:	64a2                	ld	s1,8(sp)
ffffffffc020a8fc:	85da                	mv	a1,s6
ffffffffc020a8fe:	6c98                	ld	a4,24(s1)
ffffffffc020a900:	6088                	ld	a0,0(s1)
ffffffffc020a902:	1779                	addi	a4,a4,-2
ffffffffc020a904:	41770bb3          	sub	s7,a4,s7
ffffffffc020a908:	865e                	mv	a2,s7
ffffffffc020a90a:	0505                	addi	a0,a0,1
ffffffffc020a90c:	09b000ef          	jal	ra,ffffffffc020b1a6 <memmove>
ffffffffc020a910:	02f00713          	li	a4,47
ffffffffc020a914:	fee50fa3          	sb	a4,-1(a0)
ffffffffc020a918:	955e                	add	a0,a0,s7
ffffffffc020a91a:	00050023          	sb	zero,0(a0)
ffffffffc020a91e:	85de                	mv	a1,s7
ffffffffc020a920:	8526                	mv	a0,s1
ffffffffc020a922:	b15fa0ef          	jal	ra,ffffffffc0205436 <iobuf_skip>
ffffffffc020a926:	8522                	mv	a0,s0
ffffffffc020a928:	f16f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a92c:	b5dd                	j	ffffffffc020a812 <sfs_namefile+0xa6>
ffffffffc020a92e:	89e6                	mv	s3,s9
ffffffffc020a930:	5df1                	li	s11,-4
ffffffffc020a932:	bdd1                	j	ffffffffc020a806 <sfs_namefile+0x9a>
ffffffffc020a934:	5df1                	li	s11,-4
ffffffffc020a936:	bdf1                	j	ffffffffc020a812 <sfs_namefile+0xa6>
ffffffffc020a938:	00004697          	auipc	a3,0x4
ffffffffc020a93c:	42868693          	addi	a3,a3,1064 # ffffffffc020ed60 <dev_node_ops+0x888>
ffffffffc020a940:	00001617          	auipc	a2,0x1
ffffffffc020a944:	d3860613          	addi	a2,a2,-712 # ffffffffc020b678 <commands+0x210>
ffffffffc020a948:	2e700593          	li	a1,743
ffffffffc020a94c:	00004517          	auipc	a0,0x4
ffffffffc020a950:	14c50513          	addi	a0,a0,332 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a954:	b4bf50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a958:	00004697          	auipc	a3,0x4
ffffffffc020a95c:	10868693          	addi	a3,a3,264 # ffffffffc020ea60 <dev_node_ops+0x588>
ffffffffc020a960:	00001617          	auipc	a2,0x1
ffffffffc020a964:	d1860613          	addi	a2,a2,-744 # ffffffffc020b678 <commands+0x210>
ffffffffc020a968:	2e600593          	li	a1,742
ffffffffc020a96c:	00004517          	auipc	a0,0x4
ffffffffc020a970:	12c50513          	addi	a0,a0,300 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a974:	b2bf50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a978:	00004697          	auipc	a3,0x4
ffffffffc020a97c:	0e868693          	addi	a3,a3,232 # ffffffffc020ea60 <dev_node_ops+0x588>
ffffffffc020a980:	00001617          	auipc	a2,0x1
ffffffffc020a984:	cf860613          	addi	a2,a2,-776 # ffffffffc020b678 <commands+0x210>
ffffffffc020a988:	2d300593          	li	a1,723
ffffffffc020a98c:	00004517          	auipc	a0,0x4
ffffffffc020a990:	10c50513          	addi	a0,a0,268 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a994:	b0bf50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a998:	00004697          	auipc	a3,0x4
ffffffffc020a99c:	f2068693          	addi	a3,a3,-224 # ffffffffc020e8b8 <dev_node_ops+0x3e0>
ffffffffc020a9a0:	00001617          	auipc	a2,0x1
ffffffffc020a9a4:	cd860613          	addi	a2,a2,-808 # ffffffffc020b678 <commands+0x210>
ffffffffc020a9a8:	2d200593          	li	a1,722
ffffffffc020a9ac:	00004517          	auipc	a0,0x4
ffffffffc020a9b0:	0ec50513          	addi	a0,a0,236 # ffffffffc020ea98 <dev_node_ops+0x5c0>
ffffffffc020a9b4:	aebf50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a9b8 <sfs_rwblock_nolock>:
ffffffffc020a9b8:	7139                	addi	sp,sp,-64
ffffffffc020a9ba:	f822                	sd	s0,48(sp)
ffffffffc020a9bc:	f426                	sd	s1,40(sp)
ffffffffc020a9be:	fc06                	sd	ra,56(sp)
ffffffffc020a9c0:	842a                	mv	s0,a0
ffffffffc020a9c2:	84b6                	mv	s1,a3
ffffffffc020a9c4:	e211                	bnez	a2,ffffffffc020a9c8 <sfs_rwblock_nolock+0x10>
ffffffffc020a9c6:	e715                	bnez	a4,ffffffffc020a9f2 <sfs_rwblock_nolock+0x3a>
ffffffffc020a9c8:	405c                	lw	a5,4(s0)
ffffffffc020a9ca:	02f67463          	bgeu	a2,a5,ffffffffc020a9f2 <sfs_rwblock_nolock+0x3a>
ffffffffc020a9ce:	00c6169b          	slliw	a3,a2,0xc
ffffffffc020a9d2:	1682                	slli	a3,a3,0x20
ffffffffc020a9d4:	6605                	lui	a2,0x1
ffffffffc020a9d6:	9281                	srli	a3,a3,0x20
ffffffffc020a9d8:	850a                	mv	a0,sp
ffffffffc020a9da:	9e7fa0ef          	jal	ra,ffffffffc02053c0 <iobuf_init>
ffffffffc020a9de:	85aa                	mv	a1,a0
ffffffffc020a9e0:	7808                	ld	a0,48(s0)
ffffffffc020a9e2:	8626                	mv	a2,s1
ffffffffc020a9e4:	7118                	ld	a4,32(a0)
ffffffffc020a9e6:	9702                	jalr	a4
ffffffffc020a9e8:	70e2                	ld	ra,56(sp)
ffffffffc020a9ea:	7442                	ld	s0,48(sp)
ffffffffc020a9ec:	74a2                	ld	s1,40(sp)
ffffffffc020a9ee:	6121                	addi	sp,sp,64
ffffffffc020a9f0:	8082                	ret
ffffffffc020a9f2:	00004697          	auipc	a3,0x4
ffffffffc020a9f6:	4a668693          	addi	a3,a3,1190 # ffffffffc020ee98 <sfs_node_fileops+0x80>
ffffffffc020a9fa:	00001617          	auipc	a2,0x1
ffffffffc020a9fe:	c7e60613          	addi	a2,a2,-898 # ffffffffc020b678 <commands+0x210>
ffffffffc020aa02:	45d5                	li	a1,21
ffffffffc020aa04:	00004517          	auipc	a0,0x4
ffffffffc020aa08:	4cc50513          	addi	a0,a0,1228 # ffffffffc020eed0 <sfs_node_fileops+0xb8>
ffffffffc020aa0c:	a93f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020aa10 <sfs_rbuf>:
ffffffffc020aa10:	7179                	addi	sp,sp,-48
ffffffffc020aa12:	f406                	sd	ra,40(sp)
ffffffffc020aa14:	f022                	sd	s0,32(sp)
ffffffffc020aa16:	ec26                	sd	s1,24(sp)
ffffffffc020aa18:	e84a                	sd	s2,16(sp)
ffffffffc020aa1a:	e44e                	sd	s3,8(sp)
ffffffffc020aa1c:	e052                	sd	s4,0(sp)
ffffffffc020aa1e:	6785                	lui	a5,0x1
ffffffffc020aa20:	04f77863          	bgeu	a4,a5,ffffffffc020aa70 <sfs_rbuf+0x60>
ffffffffc020aa24:	84ba                	mv	s1,a4
ffffffffc020aa26:	9732                	add	a4,a4,a2
ffffffffc020aa28:	89b2                	mv	s3,a2
ffffffffc020aa2a:	04e7e363          	bltu	a5,a4,ffffffffc020aa70 <sfs_rbuf+0x60>
ffffffffc020aa2e:	8936                	mv	s2,a3
ffffffffc020aa30:	842a                	mv	s0,a0
ffffffffc020aa32:	8a2e                	mv	s4,a1
ffffffffc020aa34:	214000ef          	jal	ra,ffffffffc020ac48 <lock_sfs_io>
ffffffffc020aa38:	642c                	ld	a1,72(s0)
ffffffffc020aa3a:	864a                	mv	a2,s2
ffffffffc020aa3c:	4705                	li	a4,1
ffffffffc020aa3e:	4681                	li	a3,0
ffffffffc020aa40:	8522                	mv	a0,s0
ffffffffc020aa42:	f77ff0ef          	jal	ra,ffffffffc020a9b8 <sfs_rwblock_nolock>
ffffffffc020aa46:	892a                	mv	s2,a0
ffffffffc020aa48:	cd09                	beqz	a0,ffffffffc020aa62 <sfs_rbuf+0x52>
ffffffffc020aa4a:	8522                	mv	a0,s0
ffffffffc020aa4c:	20c000ef          	jal	ra,ffffffffc020ac58 <unlock_sfs_io>
ffffffffc020aa50:	70a2                	ld	ra,40(sp)
ffffffffc020aa52:	7402                	ld	s0,32(sp)
ffffffffc020aa54:	64e2                	ld	s1,24(sp)
ffffffffc020aa56:	69a2                	ld	s3,8(sp)
ffffffffc020aa58:	6a02                	ld	s4,0(sp)
ffffffffc020aa5a:	854a                	mv	a0,s2
ffffffffc020aa5c:	6942                	ld	s2,16(sp)
ffffffffc020aa5e:	6145                	addi	sp,sp,48
ffffffffc020aa60:	8082                	ret
ffffffffc020aa62:	642c                	ld	a1,72(s0)
ffffffffc020aa64:	864e                	mv	a2,s3
ffffffffc020aa66:	8552                	mv	a0,s4
ffffffffc020aa68:	95a6                	add	a1,a1,s1
ffffffffc020aa6a:	77c000ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc020aa6e:	bff1                	j	ffffffffc020aa4a <sfs_rbuf+0x3a>
ffffffffc020aa70:	00004697          	auipc	a3,0x4
ffffffffc020aa74:	47868693          	addi	a3,a3,1144 # ffffffffc020eee8 <sfs_node_fileops+0xd0>
ffffffffc020aa78:	00001617          	auipc	a2,0x1
ffffffffc020aa7c:	c0060613          	addi	a2,a2,-1024 # ffffffffc020b678 <commands+0x210>
ffffffffc020aa80:	05500593          	li	a1,85
ffffffffc020aa84:	00004517          	auipc	a0,0x4
ffffffffc020aa88:	44c50513          	addi	a0,a0,1100 # ffffffffc020eed0 <sfs_node_fileops+0xb8>
ffffffffc020aa8c:	a13f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020aa90 <sfs_wbuf>:
ffffffffc020aa90:	7139                	addi	sp,sp,-64
ffffffffc020aa92:	fc06                	sd	ra,56(sp)
ffffffffc020aa94:	f822                	sd	s0,48(sp)
ffffffffc020aa96:	f426                	sd	s1,40(sp)
ffffffffc020aa98:	f04a                	sd	s2,32(sp)
ffffffffc020aa9a:	ec4e                	sd	s3,24(sp)
ffffffffc020aa9c:	e852                	sd	s4,16(sp)
ffffffffc020aa9e:	e456                	sd	s5,8(sp)
ffffffffc020aaa0:	6785                	lui	a5,0x1
ffffffffc020aaa2:	06f77163          	bgeu	a4,a5,ffffffffc020ab04 <sfs_wbuf+0x74>
ffffffffc020aaa6:	893a                	mv	s2,a4
ffffffffc020aaa8:	9732                	add	a4,a4,a2
ffffffffc020aaaa:	8a32                	mv	s4,a2
ffffffffc020aaac:	04e7ec63          	bltu	a5,a4,ffffffffc020ab04 <sfs_wbuf+0x74>
ffffffffc020aab0:	842a                	mv	s0,a0
ffffffffc020aab2:	89b6                	mv	s3,a3
ffffffffc020aab4:	8aae                	mv	s5,a1
ffffffffc020aab6:	192000ef          	jal	ra,ffffffffc020ac48 <lock_sfs_io>
ffffffffc020aaba:	642c                	ld	a1,72(s0)
ffffffffc020aabc:	4705                	li	a4,1
ffffffffc020aabe:	4681                	li	a3,0
ffffffffc020aac0:	864e                	mv	a2,s3
ffffffffc020aac2:	8522                	mv	a0,s0
ffffffffc020aac4:	ef5ff0ef          	jal	ra,ffffffffc020a9b8 <sfs_rwblock_nolock>
ffffffffc020aac8:	84aa                	mv	s1,a0
ffffffffc020aaca:	cd11                	beqz	a0,ffffffffc020aae6 <sfs_wbuf+0x56>
ffffffffc020aacc:	8522                	mv	a0,s0
ffffffffc020aace:	18a000ef          	jal	ra,ffffffffc020ac58 <unlock_sfs_io>
ffffffffc020aad2:	70e2                	ld	ra,56(sp)
ffffffffc020aad4:	7442                	ld	s0,48(sp)
ffffffffc020aad6:	7902                	ld	s2,32(sp)
ffffffffc020aad8:	69e2                	ld	s3,24(sp)
ffffffffc020aada:	6a42                	ld	s4,16(sp)
ffffffffc020aadc:	6aa2                	ld	s5,8(sp)
ffffffffc020aade:	8526                	mv	a0,s1
ffffffffc020aae0:	74a2                	ld	s1,40(sp)
ffffffffc020aae2:	6121                	addi	sp,sp,64
ffffffffc020aae4:	8082                	ret
ffffffffc020aae6:	6428                	ld	a0,72(s0)
ffffffffc020aae8:	8652                	mv	a2,s4
ffffffffc020aaea:	85d6                	mv	a1,s5
ffffffffc020aaec:	954a                	add	a0,a0,s2
ffffffffc020aaee:	6f8000ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc020aaf2:	642c                	ld	a1,72(s0)
ffffffffc020aaf4:	4705                	li	a4,1
ffffffffc020aaf6:	4685                	li	a3,1
ffffffffc020aaf8:	864e                	mv	a2,s3
ffffffffc020aafa:	8522                	mv	a0,s0
ffffffffc020aafc:	ebdff0ef          	jal	ra,ffffffffc020a9b8 <sfs_rwblock_nolock>
ffffffffc020ab00:	84aa                	mv	s1,a0
ffffffffc020ab02:	b7e9                	j	ffffffffc020aacc <sfs_wbuf+0x3c>
ffffffffc020ab04:	00004697          	auipc	a3,0x4
ffffffffc020ab08:	3e468693          	addi	a3,a3,996 # ffffffffc020eee8 <sfs_node_fileops+0xd0>
ffffffffc020ab0c:	00001617          	auipc	a2,0x1
ffffffffc020ab10:	b6c60613          	addi	a2,a2,-1172 # ffffffffc020b678 <commands+0x210>
ffffffffc020ab14:	06b00593          	li	a1,107
ffffffffc020ab18:	00004517          	auipc	a0,0x4
ffffffffc020ab1c:	3b850513          	addi	a0,a0,952 # ffffffffc020eed0 <sfs_node_fileops+0xb8>
ffffffffc020ab20:	97ff50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ab24 <sfs_sync_super>:
ffffffffc020ab24:	1101                	addi	sp,sp,-32
ffffffffc020ab26:	ec06                	sd	ra,24(sp)
ffffffffc020ab28:	e822                	sd	s0,16(sp)
ffffffffc020ab2a:	e426                	sd	s1,8(sp)
ffffffffc020ab2c:	842a                	mv	s0,a0
ffffffffc020ab2e:	11a000ef          	jal	ra,ffffffffc020ac48 <lock_sfs_io>
ffffffffc020ab32:	6428                	ld	a0,72(s0)
ffffffffc020ab34:	6605                	lui	a2,0x1
ffffffffc020ab36:	4581                	li	a1,0
ffffffffc020ab38:	65c000ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc020ab3c:	6428                	ld	a0,72(s0)
ffffffffc020ab3e:	85a2                	mv	a1,s0
ffffffffc020ab40:	02c00613          	li	a2,44
ffffffffc020ab44:	6a2000ef          	jal	ra,ffffffffc020b1e6 <memcpy>
ffffffffc020ab48:	642c                	ld	a1,72(s0)
ffffffffc020ab4a:	4701                	li	a4,0
ffffffffc020ab4c:	4685                	li	a3,1
ffffffffc020ab4e:	4601                	li	a2,0
ffffffffc020ab50:	8522                	mv	a0,s0
ffffffffc020ab52:	e67ff0ef          	jal	ra,ffffffffc020a9b8 <sfs_rwblock_nolock>
ffffffffc020ab56:	84aa                	mv	s1,a0
ffffffffc020ab58:	8522                	mv	a0,s0
ffffffffc020ab5a:	0fe000ef          	jal	ra,ffffffffc020ac58 <unlock_sfs_io>
ffffffffc020ab5e:	60e2                	ld	ra,24(sp)
ffffffffc020ab60:	6442                	ld	s0,16(sp)
ffffffffc020ab62:	8526                	mv	a0,s1
ffffffffc020ab64:	64a2                	ld	s1,8(sp)
ffffffffc020ab66:	6105                	addi	sp,sp,32
ffffffffc020ab68:	8082                	ret

ffffffffc020ab6a <sfs_sync_freemap>:
ffffffffc020ab6a:	7139                	addi	sp,sp,-64
ffffffffc020ab6c:	ec4e                	sd	s3,24(sp)
ffffffffc020ab6e:	e852                	sd	s4,16(sp)
ffffffffc020ab70:	00456983          	lwu	s3,4(a0)
ffffffffc020ab74:	8a2a                	mv	s4,a0
ffffffffc020ab76:	7d08                	ld	a0,56(a0)
ffffffffc020ab78:	67a1                	lui	a5,0x8
ffffffffc020ab7a:	17fd                	addi	a5,a5,-1
ffffffffc020ab7c:	4581                	li	a1,0
ffffffffc020ab7e:	f822                	sd	s0,48(sp)
ffffffffc020ab80:	fc06                	sd	ra,56(sp)
ffffffffc020ab82:	f426                	sd	s1,40(sp)
ffffffffc020ab84:	f04a                	sd	s2,32(sp)
ffffffffc020ab86:	e456                	sd	s5,8(sp)
ffffffffc020ab88:	99be                	add	s3,s3,a5
ffffffffc020ab8a:	b4cfe0ef          	jal	ra,ffffffffc0208ed6 <bitmap_getdata>
ffffffffc020ab8e:	00f9d993          	srli	s3,s3,0xf
ffffffffc020ab92:	842a                	mv	s0,a0
ffffffffc020ab94:	8552                	mv	a0,s4
ffffffffc020ab96:	0b2000ef          	jal	ra,ffffffffc020ac48 <lock_sfs_io>
ffffffffc020ab9a:	04098163          	beqz	s3,ffffffffc020abdc <sfs_sync_freemap+0x72>
ffffffffc020ab9e:	09b2                	slli	s3,s3,0xc
ffffffffc020aba0:	99a2                	add	s3,s3,s0
ffffffffc020aba2:	4909                	li	s2,2
ffffffffc020aba4:	6a85                	lui	s5,0x1
ffffffffc020aba6:	a021                	j	ffffffffc020abae <sfs_sync_freemap+0x44>
ffffffffc020aba8:	2905                	addiw	s2,s2,1
ffffffffc020abaa:	02898963          	beq	s3,s0,ffffffffc020abdc <sfs_sync_freemap+0x72>
ffffffffc020abae:	85a2                	mv	a1,s0
ffffffffc020abb0:	864a                	mv	a2,s2
ffffffffc020abb2:	4705                	li	a4,1
ffffffffc020abb4:	4685                	li	a3,1
ffffffffc020abb6:	8552                	mv	a0,s4
ffffffffc020abb8:	e01ff0ef          	jal	ra,ffffffffc020a9b8 <sfs_rwblock_nolock>
ffffffffc020abbc:	84aa                	mv	s1,a0
ffffffffc020abbe:	9456                	add	s0,s0,s5
ffffffffc020abc0:	d565                	beqz	a0,ffffffffc020aba8 <sfs_sync_freemap+0x3e>
ffffffffc020abc2:	8552                	mv	a0,s4
ffffffffc020abc4:	094000ef          	jal	ra,ffffffffc020ac58 <unlock_sfs_io>
ffffffffc020abc8:	70e2                	ld	ra,56(sp)
ffffffffc020abca:	7442                	ld	s0,48(sp)
ffffffffc020abcc:	7902                	ld	s2,32(sp)
ffffffffc020abce:	69e2                	ld	s3,24(sp)
ffffffffc020abd0:	6a42                	ld	s4,16(sp)
ffffffffc020abd2:	6aa2                	ld	s5,8(sp)
ffffffffc020abd4:	8526                	mv	a0,s1
ffffffffc020abd6:	74a2                	ld	s1,40(sp)
ffffffffc020abd8:	6121                	addi	sp,sp,64
ffffffffc020abda:	8082                	ret
ffffffffc020abdc:	4481                	li	s1,0
ffffffffc020abde:	b7d5                	j	ffffffffc020abc2 <sfs_sync_freemap+0x58>

ffffffffc020abe0 <sfs_clear_block>:
ffffffffc020abe0:	7179                	addi	sp,sp,-48
ffffffffc020abe2:	f022                	sd	s0,32(sp)
ffffffffc020abe4:	e84a                	sd	s2,16(sp)
ffffffffc020abe6:	e44e                	sd	s3,8(sp)
ffffffffc020abe8:	f406                	sd	ra,40(sp)
ffffffffc020abea:	89b2                	mv	s3,a2
ffffffffc020abec:	ec26                	sd	s1,24(sp)
ffffffffc020abee:	892a                	mv	s2,a0
ffffffffc020abf0:	842e                	mv	s0,a1
ffffffffc020abf2:	056000ef          	jal	ra,ffffffffc020ac48 <lock_sfs_io>
ffffffffc020abf6:	04893503          	ld	a0,72(s2)
ffffffffc020abfa:	6605                	lui	a2,0x1
ffffffffc020abfc:	4581                	li	a1,0
ffffffffc020abfe:	596000ef          	jal	ra,ffffffffc020b194 <memset>
ffffffffc020ac02:	02098d63          	beqz	s3,ffffffffc020ac3c <sfs_clear_block+0x5c>
ffffffffc020ac06:	013409bb          	addw	s3,s0,s3
ffffffffc020ac0a:	a019                	j	ffffffffc020ac10 <sfs_clear_block+0x30>
ffffffffc020ac0c:	02898863          	beq	s3,s0,ffffffffc020ac3c <sfs_clear_block+0x5c>
ffffffffc020ac10:	04893583          	ld	a1,72(s2)
ffffffffc020ac14:	8622                	mv	a2,s0
ffffffffc020ac16:	4705                	li	a4,1
ffffffffc020ac18:	4685                	li	a3,1
ffffffffc020ac1a:	854a                	mv	a0,s2
ffffffffc020ac1c:	d9dff0ef          	jal	ra,ffffffffc020a9b8 <sfs_rwblock_nolock>
ffffffffc020ac20:	84aa                	mv	s1,a0
ffffffffc020ac22:	2405                	addiw	s0,s0,1
ffffffffc020ac24:	d565                	beqz	a0,ffffffffc020ac0c <sfs_clear_block+0x2c>
ffffffffc020ac26:	854a                	mv	a0,s2
ffffffffc020ac28:	030000ef          	jal	ra,ffffffffc020ac58 <unlock_sfs_io>
ffffffffc020ac2c:	70a2                	ld	ra,40(sp)
ffffffffc020ac2e:	7402                	ld	s0,32(sp)
ffffffffc020ac30:	6942                	ld	s2,16(sp)
ffffffffc020ac32:	69a2                	ld	s3,8(sp)
ffffffffc020ac34:	8526                	mv	a0,s1
ffffffffc020ac36:	64e2                	ld	s1,24(sp)
ffffffffc020ac38:	6145                	addi	sp,sp,48
ffffffffc020ac3a:	8082                	ret
ffffffffc020ac3c:	4481                	li	s1,0
ffffffffc020ac3e:	b7e5                	j	ffffffffc020ac26 <sfs_clear_block+0x46>

ffffffffc020ac40 <lock_sfs_fs>:
ffffffffc020ac40:	05050513          	addi	a0,a0,80
ffffffffc020ac44:	8fff906f          	j	ffffffffc0204542 <down>

ffffffffc020ac48 <lock_sfs_io>:
ffffffffc020ac48:	06850513          	addi	a0,a0,104
ffffffffc020ac4c:	8f7f906f          	j	ffffffffc0204542 <down>

ffffffffc020ac50 <unlock_sfs_fs>:
ffffffffc020ac50:	05050513          	addi	a0,a0,80
ffffffffc020ac54:	8ebf906f          	j	ffffffffc020453e <up>

ffffffffc020ac58 <unlock_sfs_io>:
ffffffffc020ac58:	06850513          	addi	a0,a0,104
ffffffffc020ac5c:	8e3f906f          	j	ffffffffc020453e <up>

ffffffffc020ac60 <hash32>:
ffffffffc020ac60:	9e3707b7          	lui	a5,0x9e370
ffffffffc020ac64:	2785                	addiw	a5,a5,1
ffffffffc020ac66:	02a7853b          	mulw	a0,a5,a0
ffffffffc020ac6a:	02000793          	li	a5,32
ffffffffc020ac6e:	9f8d                	subw	a5,a5,a1
ffffffffc020ac70:	00f5553b          	srlw	a0,a0,a5
ffffffffc020ac74:	8082                	ret

ffffffffc020ac76 <printnum>:
ffffffffc020ac76:	02071893          	slli	a7,a4,0x20
ffffffffc020ac7a:	7139                	addi	sp,sp,-64
ffffffffc020ac7c:	0208d893          	srli	a7,a7,0x20
ffffffffc020ac80:	e456                	sd	s5,8(sp)
ffffffffc020ac82:	0316fab3          	remu	s5,a3,a7
ffffffffc020ac86:	f822                	sd	s0,48(sp)
ffffffffc020ac88:	f426                	sd	s1,40(sp)
ffffffffc020ac8a:	f04a                	sd	s2,32(sp)
ffffffffc020ac8c:	ec4e                	sd	s3,24(sp)
ffffffffc020ac8e:	fc06                	sd	ra,56(sp)
ffffffffc020ac90:	e852                	sd	s4,16(sp)
ffffffffc020ac92:	84aa                	mv	s1,a0
ffffffffc020ac94:	89ae                	mv	s3,a1
ffffffffc020ac96:	8932                	mv	s2,a2
ffffffffc020ac98:	fff7841b          	addiw	s0,a5,-1
ffffffffc020ac9c:	2a81                	sext.w	s5,s5
ffffffffc020ac9e:	0516f163          	bgeu	a3,a7,ffffffffc020ace0 <printnum+0x6a>
ffffffffc020aca2:	8a42                	mv	s4,a6
ffffffffc020aca4:	00805863          	blez	s0,ffffffffc020acb4 <printnum+0x3e>
ffffffffc020aca8:	347d                	addiw	s0,s0,-1
ffffffffc020acaa:	864e                	mv	a2,s3
ffffffffc020acac:	85ca                	mv	a1,s2
ffffffffc020acae:	8552                	mv	a0,s4
ffffffffc020acb0:	9482                	jalr	s1
ffffffffc020acb2:	f87d                	bnez	s0,ffffffffc020aca8 <printnum+0x32>
ffffffffc020acb4:	1a82                	slli	s5,s5,0x20
ffffffffc020acb6:	00004797          	auipc	a5,0x4
ffffffffc020acba:	27a78793          	addi	a5,a5,634 # ffffffffc020ef30 <sfs_node_fileops+0x118>
ffffffffc020acbe:	020ada93          	srli	s5,s5,0x20
ffffffffc020acc2:	9abe                	add	s5,s5,a5
ffffffffc020acc4:	7442                	ld	s0,48(sp)
ffffffffc020acc6:	000ac503          	lbu	a0,0(s5) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc020acca:	70e2                	ld	ra,56(sp)
ffffffffc020accc:	6a42                	ld	s4,16(sp)
ffffffffc020acce:	6aa2                	ld	s5,8(sp)
ffffffffc020acd0:	864e                	mv	a2,s3
ffffffffc020acd2:	85ca                	mv	a1,s2
ffffffffc020acd4:	69e2                	ld	s3,24(sp)
ffffffffc020acd6:	7902                	ld	s2,32(sp)
ffffffffc020acd8:	87a6                	mv	a5,s1
ffffffffc020acda:	74a2                	ld	s1,40(sp)
ffffffffc020acdc:	6121                	addi	sp,sp,64
ffffffffc020acde:	8782                	jr	a5
ffffffffc020ace0:	0316d6b3          	divu	a3,a3,a7
ffffffffc020ace4:	87a2                	mv	a5,s0
ffffffffc020ace6:	f91ff0ef          	jal	ra,ffffffffc020ac76 <printnum>
ffffffffc020acea:	b7e9                	j	ffffffffc020acb4 <printnum+0x3e>

ffffffffc020acec <sprintputch>:
ffffffffc020acec:	499c                	lw	a5,16(a1)
ffffffffc020acee:	6198                	ld	a4,0(a1)
ffffffffc020acf0:	6594                	ld	a3,8(a1)
ffffffffc020acf2:	2785                	addiw	a5,a5,1
ffffffffc020acf4:	c99c                	sw	a5,16(a1)
ffffffffc020acf6:	00d77763          	bgeu	a4,a3,ffffffffc020ad04 <sprintputch+0x18>
ffffffffc020acfa:	00170793          	addi	a5,a4,1
ffffffffc020acfe:	e19c                	sd	a5,0(a1)
ffffffffc020ad00:	00a70023          	sb	a0,0(a4)
ffffffffc020ad04:	8082                	ret

ffffffffc020ad06 <vprintfmt>:
ffffffffc020ad06:	7119                	addi	sp,sp,-128
ffffffffc020ad08:	f4a6                	sd	s1,104(sp)
ffffffffc020ad0a:	f0ca                	sd	s2,96(sp)
ffffffffc020ad0c:	ecce                	sd	s3,88(sp)
ffffffffc020ad0e:	e8d2                	sd	s4,80(sp)
ffffffffc020ad10:	e4d6                	sd	s5,72(sp)
ffffffffc020ad12:	e0da                	sd	s6,64(sp)
ffffffffc020ad14:	fc5e                	sd	s7,56(sp)
ffffffffc020ad16:	ec6e                	sd	s11,24(sp)
ffffffffc020ad18:	fc86                	sd	ra,120(sp)
ffffffffc020ad1a:	f8a2                	sd	s0,112(sp)
ffffffffc020ad1c:	f862                	sd	s8,48(sp)
ffffffffc020ad1e:	f466                	sd	s9,40(sp)
ffffffffc020ad20:	f06a                	sd	s10,32(sp)
ffffffffc020ad22:	89aa                	mv	s3,a0
ffffffffc020ad24:	892e                	mv	s2,a1
ffffffffc020ad26:	84b2                	mv	s1,a2
ffffffffc020ad28:	8db6                	mv	s11,a3
ffffffffc020ad2a:	8aba                	mv	s5,a4
ffffffffc020ad2c:	02500a13          	li	s4,37
ffffffffc020ad30:	5bfd                	li	s7,-1
ffffffffc020ad32:	00004b17          	auipc	s6,0x4
ffffffffc020ad36:	22ab0b13          	addi	s6,s6,554 # ffffffffc020ef5c <sfs_node_fileops+0x144>
ffffffffc020ad3a:	000dc503          	lbu	a0,0(s11) # 2000 <_binary_bin_swap_img_size-0x5d00>
ffffffffc020ad3e:	001d8413          	addi	s0,s11,1
ffffffffc020ad42:	01450b63          	beq	a0,s4,ffffffffc020ad58 <vprintfmt+0x52>
ffffffffc020ad46:	c129                	beqz	a0,ffffffffc020ad88 <vprintfmt+0x82>
ffffffffc020ad48:	864a                	mv	a2,s2
ffffffffc020ad4a:	85a6                	mv	a1,s1
ffffffffc020ad4c:	0405                	addi	s0,s0,1
ffffffffc020ad4e:	9982                	jalr	s3
ffffffffc020ad50:	fff44503          	lbu	a0,-1(s0)
ffffffffc020ad54:	ff4519e3          	bne	a0,s4,ffffffffc020ad46 <vprintfmt+0x40>
ffffffffc020ad58:	00044583          	lbu	a1,0(s0)
ffffffffc020ad5c:	02000813          	li	a6,32
ffffffffc020ad60:	4d01                	li	s10,0
ffffffffc020ad62:	4301                	li	t1,0
ffffffffc020ad64:	5cfd                	li	s9,-1
ffffffffc020ad66:	5c7d                	li	s8,-1
ffffffffc020ad68:	05500513          	li	a0,85
ffffffffc020ad6c:	48a5                	li	a7,9
ffffffffc020ad6e:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020ad72:	0ff67613          	zext.b	a2,a2
ffffffffc020ad76:	00140d93          	addi	s11,s0,1
ffffffffc020ad7a:	04c56263          	bltu	a0,a2,ffffffffc020adbe <vprintfmt+0xb8>
ffffffffc020ad7e:	060a                	slli	a2,a2,0x2
ffffffffc020ad80:	965a                	add	a2,a2,s6
ffffffffc020ad82:	4214                	lw	a3,0(a2)
ffffffffc020ad84:	96da                	add	a3,a3,s6
ffffffffc020ad86:	8682                	jr	a3
ffffffffc020ad88:	70e6                	ld	ra,120(sp)
ffffffffc020ad8a:	7446                	ld	s0,112(sp)
ffffffffc020ad8c:	74a6                	ld	s1,104(sp)
ffffffffc020ad8e:	7906                	ld	s2,96(sp)
ffffffffc020ad90:	69e6                	ld	s3,88(sp)
ffffffffc020ad92:	6a46                	ld	s4,80(sp)
ffffffffc020ad94:	6aa6                	ld	s5,72(sp)
ffffffffc020ad96:	6b06                	ld	s6,64(sp)
ffffffffc020ad98:	7be2                	ld	s7,56(sp)
ffffffffc020ad9a:	7c42                	ld	s8,48(sp)
ffffffffc020ad9c:	7ca2                	ld	s9,40(sp)
ffffffffc020ad9e:	7d02                	ld	s10,32(sp)
ffffffffc020ada0:	6de2                	ld	s11,24(sp)
ffffffffc020ada2:	6109                	addi	sp,sp,128
ffffffffc020ada4:	8082                	ret
ffffffffc020ada6:	882e                	mv	a6,a1
ffffffffc020ada8:	00144583          	lbu	a1,1(s0)
ffffffffc020adac:	846e                	mv	s0,s11
ffffffffc020adae:	00140d93          	addi	s11,s0,1
ffffffffc020adb2:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020adb6:	0ff67613          	zext.b	a2,a2
ffffffffc020adba:	fcc572e3          	bgeu	a0,a2,ffffffffc020ad7e <vprintfmt+0x78>
ffffffffc020adbe:	864a                	mv	a2,s2
ffffffffc020adc0:	85a6                	mv	a1,s1
ffffffffc020adc2:	02500513          	li	a0,37
ffffffffc020adc6:	9982                	jalr	s3
ffffffffc020adc8:	fff44783          	lbu	a5,-1(s0)
ffffffffc020adcc:	8da2                	mv	s11,s0
ffffffffc020adce:	f74786e3          	beq	a5,s4,ffffffffc020ad3a <vprintfmt+0x34>
ffffffffc020add2:	ffedc783          	lbu	a5,-2(s11)
ffffffffc020add6:	1dfd                	addi	s11,s11,-1
ffffffffc020add8:	ff479de3          	bne	a5,s4,ffffffffc020add2 <vprintfmt+0xcc>
ffffffffc020addc:	bfb9                	j	ffffffffc020ad3a <vprintfmt+0x34>
ffffffffc020adde:	fd058c9b          	addiw	s9,a1,-48
ffffffffc020ade2:	00144583          	lbu	a1,1(s0)
ffffffffc020ade6:	846e                	mv	s0,s11
ffffffffc020ade8:	fd05869b          	addiw	a3,a1,-48
ffffffffc020adec:	0005861b          	sext.w	a2,a1
ffffffffc020adf0:	02d8e463          	bltu	a7,a3,ffffffffc020ae18 <vprintfmt+0x112>
ffffffffc020adf4:	00144583          	lbu	a1,1(s0)
ffffffffc020adf8:	002c969b          	slliw	a3,s9,0x2
ffffffffc020adfc:	0196873b          	addw	a4,a3,s9
ffffffffc020ae00:	0017171b          	slliw	a4,a4,0x1
ffffffffc020ae04:	9f31                	addw	a4,a4,a2
ffffffffc020ae06:	fd05869b          	addiw	a3,a1,-48
ffffffffc020ae0a:	0405                	addi	s0,s0,1
ffffffffc020ae0c:	fd070c9b          	addiw	s9,a4,-48
ffffffffc020ae10:	0005861b          	sext.w	a2,a1
ffffffffc020ae14:	fed8f0e3          	bgeu	a7,a3,ffffffffc020adf4 <vprintfmt+0xee>
ffffffffc020ae18:	f40c5be3          	bgez	s8,ffffffffc020ad6e <vprintfmt+0x68>
ffffffffc020ae1c:	8c66                	mv	s8,s9
ffffffffc020ae1e:	5cfd                	li	s9,-1
ffffffffc020ae20:	b7b9                	j	ffffffffc020ad6e <vprintfmt+0x68>
ffffffffc020ae22:	fffc4693          	not	a3,s8
ffffffffc020ae26:	96fd                	srai	a3,a3,0x3f
ffffffffc020ae28:	00dc77b3          	and	a5,s8,a3
ffffffffc020ae2c:	00144583          	lbu	a1,1(s0)
ffffffffc020ae30:	00078c1b          	sext.w	s8,a5
ffffffffc020ae34:	846e                	mv	s0,s11
ffffffffc020ae36:	bf25                	j	ffffffffc020ad6e <vprintfmt+0x68>
ffffffffc020ae38:	000aac83          	lw	s9,0(s5)
ffffffffc020ae3c:	00144583          	lbu	a1,1(s0)
ffffffffc020ae40:	0aa1                	addi	s5,s5,8
ffffffffc020ae42:	846e                	mv	s0,s11
ffffffffc020ae44:	bfd1                	j	ffffffffc020ae18 <vprintfmt+0x112>
ffffffffc020ae46:	4705                	li	a4,1
ffffffffc020ae48:	008a8613          	addi	a2,s5,8
ffffffffc020ae4c:	00674463          	blt	a4,t1,ffffffffc020ae54 <vprintfmt+0x14e>
ffffffffc020ae50:	1c030c63          	beqz	t1,ffffffffc020b028 <vprintfmt+0x322>
ffffffffc020ae54:	000ab683          	ld	a3,0(s5)
ffffffffc020ae58:	4741                	li	a4,16
ffffffffc020ae5a:	8ab2                	mv	s5,a2
ffffffffc020ae5c:	2801                	sext.w	a6,a6
ffffffffc020ae5e:	87e2                	mv	a5,s8
ffffffffc020ae60:	8626                	mv	a2,s1
ffffffffc020ae62:	85ca                	mv	a1,s2
ffffffffc020ae64:	854e                	mv	a0,s3
ffffffffc020ae66:	e11ff0ef          	jal	ra,ffffffffc020ac76 <printnum>
ffffffffc020ae6a:	bdc1                	j	ffffffffc020ad3a <vprintfmt+0x34>
ffffffffc020ae6c:	000aa503          	lw	a0,0(s5)
ffffffffc020ae70:	864a                	mv	a2,s2
ffffffffc020ae72:	85a6                	mv	a1,s1
ffffffffc020ae74:	0aa1                	addi	s5,s5,8
ffffffffc020ae76:	9982                	jalr	s3
ffffffffc020ae78:	b5c9                	j	ffffffffc020ad3a <vprintfmt+0x34>
ffffffffc020ae7a:	4705                	li	a4,1
ffffffffc020ae7c:	008a8613          	addi	a2,s5,8
ffffffffc020ae80:	00674463          	blt	a4,t1,ffffffffc020ae88 <vprintfmt+0x182>
ffffffffc020ae84:	18030d63          	beqz	t1,ffffffffc020b01e <vprintfmt+0x318>
ffffffffc020ae88:	000ab683          	ld	a3,0(s5)
ffffffffc020ae8c:	4729                	li	a4,10
ffffffffc020ae8e:	8ab2                	mv	s5,a2
ffffffffc020ae90:	b7f1                	j	ffffffffc020ae5c <vprintfmt+0x156>
ffffffffc020ae92:	00144583          	lbu	a1,1(s0)
ffffffffc020ae96:	4d05                	li	s10,1
ffffffffc020ae98:	846e                	mv	s0,s11
ffffffffc020ae9a:	bdd1                	j	ffffffffc020ad6e <vprintfmt+0x68>
ffffffffc020ae9c:	864a                	mv	a2,s2
ffffffffc020ae9e:	85a6                	mv	a1,s1
ffffffffc020aea0:	02500513          	li	a0,37
ffffffffc020aea4:	9982                	jalr	s3
ffffffffc020aea6:	bd51                	j	ffffffffc020ad3a <vprintfmt+0x34>
ffffffffc020aea8:	00144583          	lbu	a1,1(s0)
ffffffffc020aeac:	2305                	addiw	t1,t1,1
ffffffffc020aeae:	846e                	mv	s0,s11
ffffffffc020aeb0:	bd7d                	j	ffffffffc020ad6e <vprintfmt+0x68>
ffffffffc020aeb2:	4705                	li	a4,1
ffffffffc020aeb4:	008a8613          	addi	a2,s5,8
ffffffffc020aeb8:	00674463          	blt	a4,t1,ffffffffc020aec0 <vprintfmt+0x1ba>
ffffffffc020aebc:	14030c63          	beqz	t1,ffffffffc020b014 <vprintfmt+0x30e>
ffffffffc020aec0:	000ab683          	ld	a3,0(s5)
ffffffffc020aec4:	4721                	li	a4,8
ffffffffc020aec6:	8ab2                	mv	s5,a2
ffffffffc020aec8:	bf51                	j	ffffffffc020ae5c <vprintfmt+0x156>
ffffffffc020aeca:	03000513          	li	a0,48
ffffffffc020aece:	864a                	mv	a2,s2
ffffffffc020aed0:	85a6                	mv	a1,s1
ffffffffc020aed2:	e042                	sd	a6,0(sp)
ffffffffc020aed4:	9982                	jalr	s3
ffffffffc020aed6:	864a                	mv	a2,s2
ffffffffc020aed8:	85a6                	mv	a1,s1
ffffffffc020aeda:	07800513          	li	a0,120
ffffffffc020aede:	9982                	jalr	s3
ffffffffc020aee0:	0aa1                	addi	s5,s5,8
ffffffffc020aee2:	6802                	ld	a6,0(sp)
ffffffffc020aee4:	4741                	li	a4,16
ffffffffc020aee6:	ff8ab683          	ld	a3,-8(s5)
ffffffffc020aeea:	bf8d                	j	ffffffffc020ae5c <vprintfmt+0x156>
ffffffffc020aeec:	000ab403          	ld	s0,0(s5)
ffffffffc020aef0:	008a8793          	addi	a5,s5,8
ffffffffc020aef4:	e03e                	sd	a5,0(sp)
ffffffffc020aef6:	14040c63          	beqz	s0,ffffffffc020b04e <vprintfmt+0x348>
ffffffffc020aefa:	11805063          	blez	s8,ffffffffc020affa <vprintfmt+0x2f4>
ffffffffc020aefe:	02d00693          	li	a3,45
ffffffffc020af02:	0cd81963          	bne	a6,a3,ffffffffc020afd4 <vprintfmt+0x2ce>
ffffffffc020af06:	00044683          	lbu	a3,0(s0)
ffffffffc020af0a:	0006851b          	sext.w	a0,a3
ffffffffc020af0e:	ce8d                	beqz	a3,ffffffffc020af48 <vprintfmt+0x242>
ffffffffc020af10:	00140a93          	addi	s5,s0,1
ffffffffc020af14:	05e00413          	li	s0,94
ffffffffc020af18:	000cc563          	bltz	s9,ffffffffc020af22 <vprintfmt+0x21c>
ffffffffc020af1c:	3cfd                	addiw	s9,s9,-1
ffffffffc020af1e:	037c8363          	beq	s9,s7,ffffffffc020af44 <vprintfmt+0x23e>
ffffffffc020af22:	864a                	mv	a2,s2
ffffffffc020af24:	85a6                	mv	a1,s1
ffffffffc020af26:	100d0663          	beqz	s10,ffffffffc020b032 <vprintfmt+0x32c>
ffffffffc020af2a:	3681                	addiw	a3,a3,-32
ffffffffc020af2c:	10d47363          	bgeu	s0,a3,ffffffffc020b032 <vprintfmt+0x32c>
ffffffffc020af30:	03f00513          	li	a0,63
ffffffffc020af34:	9982                	jalr	s3
ffffffffc020af36:	000ac683          	lbu	a3,0(s5)
ffffffffc020af3a:	3c7d                	addiw	s8,s8,-1
ffffffffc020af3c:	0a85                	addi	s5,s5,1
ffffffffc020af3e:	0006851b          	sext.w	a0,a3
ffffffffc020af42:	faf9                	bnez	a3,ffffffffc020af18 <vprintfmt+0x212>
ffffffffc020af44:	01805a63          	blez	s8,ffffffffc020af58 <vprintfmt+0x252>
ffffffffc020af48:	3c7d                	addiw	s8,s8,-1
ffffffffc020af4a:	864a                	mv	a2,s2
ffffffffc020af4c:	85a6                	mv	a1,s1
ffffffffc020af4e:	02000513          	li	a0,32
ffffffffc020af52:	9982                	jalr	s3
ffffffffc020af54:	fe0c1ae3          	bnez	s8,ffffffffc020af48 <vprintfmt+0x242>
ffffffffc020af58:	6a82                	ld	s5,0(sp)
ffffffffc020af5a:	b3c5                	j	ffffffffc020ad3a <vprintfmt+0x34>
ffffffffc020af5c:	4705                	li	a4,1
ffffffffc020af5e:	008a8d13          	addi	s10,s5,8
ffffffffc020af62:	00674463          	blt	a4,t1,ffffffffc020af6a <vprintfmt+0x264>
ffffffffc020af66:	0a030463          	beqz	t1,ffffffffc020b00e <vprintfmt+0x308>
ffffffffc020af6a:	000ab403          	ld	s0,0(s5)
ffffffffc020af6e:	0c044463          	bltz	s0,ffffffffc020b036 <vprintfmt+0x330>
ffffffffc020af72:	86a2                	mv	a3,s0
ffffffffc020af74:	8aea                	mv	s5,s10
ffffffffc020af76:	4729                	li	a4,10
ffffffffc020af78:	b5d5                	j	ffffffffc020ae5c <vprintfmt+0x156>
ffffffffc020af7a:	000aa783          	lw	a5,0(s5)
ffffffffc020af7e:	46e1                	li	a3,24
ffffffffc020af80:	0aa1                	addi	s5,s5,8
ffffffffc020af82:	41f7d71b          	sraiw	a4,a5,0x1f
ffffffffc020af86:	8fb9                	xor	a5,a5,a4
ffffffffc020af88:	40e7873b          	subw	a4,a5,a4
ffffffffc020af8c:	02e6c663          	blt	a3,a4,ffffffffc020afb8 <vprintfmt+0x2b2>
ffffffffc020af90:	00371793          	slli	a5,a4,0x3
ffffffffc020af94:	00004697          	auipc	a3,0x4
ffffffffc020af98:	2fc68693          	addi	a3,a3,764 # ffffffffc020f290 <error_string>
ffffffffc020af9c:	97b6                	add	a5,a5,a3
ffffffffc020af9e:	639c                	ld	a5,0(a5)
ffffffffc020afa0:	cf81                	beqz	a5,ffffffffc020afb8 <vprintfmt+0x2b2>
ffffffffc020afa2:	873e                	mv	a4,a5
ffffffffc020afa4:	00000697          	auipc	a3,0x0
ffffffffc020afa8:	28468693          	addi	a3,a3,644 # ffffffffc020b228 <etext+0x2a>
ffffffffc020afac:	8626                	mv	a2,s1
ffffffffc020afae:	85ca                	mv	a1,s2
ffffffffc020afb0:	854e                	mv	a0,s3
ffffffffc020afb2:	0d4000ef          	jal	ra,ffffffffc020b086 <printfmt>
ffffffffc020afb6:	b351                	j	ffffffffc020ad3a <vprintfmt+0x34>
ffffffffc020afb8:	00004697          	auipc	a3,0x4
ffffffffc020afbc:	f9868693          	addi	a3,a3,-104 # ffffffffc020ef50 <sfs_node_fileops+0x138>
ffffffffc020afc0:	8626                	mv	a2,s1
ffffffffc020afc2:	85ca                	mv	a1,s2
ffffffffc020afc4:	854e                	mv	a0,s3
ffffffffc020afc6:	0c0000ef          	jal	ra,ffffffffc020b086 <printfmt>
ffffffffc020afca:	bb85                	j	ffffffffc020ad3a <vprintfmt+0x34>
ffffffffc020afcc:	00004417          	auipc	s0,0x4
ffffffffc020afd0:	f7c40413          	addi	s0,s0,-132 # ffffffffc020ef48 <sfs_node_fileops+0x130>
ffffffffc020afd4:	85e6                	mv	a1,s9
ffffffffc020afd6:	8522                	mv	a0,s0
ffffffffc020afd8:	e442                	sd	a6,8(sp)
ffffffffc020afda:	132000ef          	jal	ra,ffffffffc020b10c <strnlen>
ffffffffc020afde:	40ac0c3b          	subw	s8,s8,a0
ffffffffc020afe2:	01805c63          	blez	s8,ffffffffc020affa <vprintfmt+0x2f4>
ffffffffc020afe6:	6822                	ld	a6,8(sp)
ffffffffc020afe8:	00080a9b          	sext.w	s5,a6
ffffffffc020afec:	3c7d                	addiw	s8,s8,-1
ffffffffc020afee:	864a                	mv	a2,s2
ffffffffc020aff0:	85a6                	mv	a1,s1
ffffffffc020aff2:	8556                	mv	a0,s5
ffffffffc020aff4:	9982                	jalr	s3
ffffffffc020aff6:	fe0c1be3          	bnez	s8,ffffffffc020afec <vprintfmt+0x2e6>
ffffffffc020affa:	00044683          	lbu	a3,0(s0)
ffffffffc020affe:	00140a93          	addi	s5,s0,1
ffffffffc020b002:	0006851b          	sext.w	a0,a3
ffffffffc020b006:	daa9                	beqz	a3,ffffffffc020af58 <vprintfmt+0x252>
ffffffffc020b008:	05e00413          	li	s0,94
ffffffffc020b00c:	b731                	j	ffffffffc020af18 <vprintfmt+0x212>
ffffffffc020b00e:	000aa403          	lw	s0,0(s5)
ffffffffc020b012:	bfb1                	j	ffffffffc020af6e <vprintfmt+0x268>
ffffffffc020b014:	000ae683          	lwu	a3,0(s5)
ffffffffc020b018:	4721                	li	a4,8
ffffffffc020b01a:	8ab2                	mv	s5,a2
ffffffffc020b01c:	b581                	j	ffffffffc020ae5c <vprintfmt+0x156>
ffffffffc020b01e:	000ae683          	lwu	a3,0(s5)
ffffffffc020b022:	4729                	li	a4,10
ffffffffc020b024:	8ab2                	mv	s5,a2
ffffffffc020b026:	bd1d                	j	ffffffffc020ae5c <vprintfmt+0x156>
ffffffffc020b028:	000ae683          	lwu	a3,0(s5)
ffffffffc020b02c:	4741                	li	a4,16
ffffffffc020b02e:	8ab2                	mv	s5,a2
ffffffffc020b030:	b535                	j	ffffffffc020ae5c <vprintfmt+0x156>
ffffffffc020b032:	9982                	jalr	s3
ffffffffc020b034:	b709                	j	ffffffffc020af36 <vprintfmt+0x230>
ffffffffc020b036:	864a                	mv	a2,s2
ffffffffc020b038:	85a6                	mv	a1,s1
ffffffffc020b03a:	02d00513          	li	a0,45
ffffffffc020b03e:	e042                	sd	a6,0(sp)
ffffffffc020b040:	9982                	jalr	s3
ffffffffc020b042:	6802                	ld	a6,0(sp)
ffffffffc020b044:	8aea                	mv	s5,s10
ffffffffc020b046:	408006b3          	neg	a3,s0
ffffffffc020b04a:	4729                	li	a4,10
ffffffffc020b04c:	bd01                	j	ffffffffc020ae5c <vprintfmt+0x156>
ffffffffc020b04e:	03805163          	blez	s8,ffffffffc020b070 <vprintfmt+0x36a>
ffffffffc020b052:	02d00693          	li	a3,45
ffffffffc020b056:	f6d81be3          	bne	a6,a3,ffffffffc020afcc <vprintfmt+0x2c6>
ffffffffc020b05a:	00004417          	auipc	s0,0x4
ffffffffc020b05e:	eee40413          	addi	s0,s0,-274 # ffffffffc020ef48 <sfs_node_fileops+0x130>
ffffffffc020b062:	02800693          	li	a3,40
ffffffffc020b066:	02800513          	li	a0,40
ffffffffc020b06a:	00140a93          	addi	s5,s0,1
ffffffffc020b06e:	b55d                	j	ffffffffc020af14 <vprintfmt+0x20e>
ffffffffc020b070:	00004a97          	auipc	s5,0x4
ffffffffc020b074:	ed9a8a93          	addi	s5,s5,-295 # ffffffffc020ef49 <sfs_node_fileops+0x131>
ffffffffc020b078:	02800513          	li	a0,40
ffffffffc020b07c:	02800693          	li	a3,40
ffffffffc020b080:	05e00413          	li	s0,94
ffffffffc020b084:	bd51                	j	ffffffffc020af18 <vprintfmt+0x212>

ffffffffc020b086 <printfmt>:
ffffffffc020b086:	7139                	addi	sp,sp,-64
ffffffffc020b088:	02010313          	addi	t1,sp,32
ffffffffc020b08c:	f03a                	sd	a4,32(sp)
ffffffffc020b08e:	871a                	mv	a4,t1
ffffffffc020b090:	ec06                	sd	ra,24(sp)
ffffffffc020b092:	f43e                	sd	a5,40(sp)
ffffffffc020b094:	f842                	sd	a6,48(sp)
ffffffffc020b096:	fc46                	sd	a7,56(sp)
ffffffffc020b098:	e41a                	sd	t1,8(sp)
ffffffffc020b09a:	c6dff0ef          	jal	ra,ffffffffc020ad06 <vprintfmt>
ffffffffc020b09e:	60e2                	ld	ra,24(sp)
ffffffffc020b0a0:	6121                	addi	sp,sp,64
ffffffffc020b0a2:	8082                	ret

ffffffffc020b0a4 <snprintf>:
ffffffffc020b0a4:	711d                	addi	sp,sp,-96
ffffffffc020b0a6:	15fd                	addi	a1,a1,-1
ffffffffc020b0a8:	03810313          	addi	t1,sp,56
ffffffffc020b0ac:	95aa                	add	a1,a1,a0
ffffffffc020b0ae:	f406                	sd	ra,40(sp)
ffffffffc020b0b0:	fc36                	sd	a3,56(sp)
ffffffffc020b0b2:	e0ba                	sd	a4,64(sp)
ffffffffc020b0b4:	e4be                	sd	a5,72(sp)
ffffffffc020b0b6:	e8c2                	sd	a6,80(sp)
ffffffffc020b0b8:	ecc6                	sd	a7,88(sp)
ffffffffc020b0ba:	e01a                	sd	t1,0(sp)
ffffffffc020b0bc:	e42a                	sd	a0,8(sp)
ffffffffc020b0be:	e82e                	sd	a1,16(sp)
ffffffffc020b0c0:	cc02                	sw	zero,24(sp)
ffffffffc020b0c2:	c515                	beqz	a0,ffffffffc020b0ee <snprintf+0x4a>
ffffffffc020b0c4:	02a5e563          	bltu	a1,a0,ffffffffc020b0ee <snprintf+0x4a>
ffffffffc020b0c8:	75dd                	lui	a1,0xffff7
ffffffffc020b0ca:	86b2                	mv	a3,a2
ffffffffc020b0cc:	00000517          	auipc	a0,0x0
ffffffffc020b0d0:	c2050513          	addi	a0,a0,-992 # ffffffffc020acec <sprintputch>
ffffffffc020b0d4:	871a                	mv	a4,t1
ffffffffc020b0d6:	0030                	addi	a2,sp,8
ffffffffc020b0d8:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc020b0dc:	c2bff0ef          	jal	ra,ffffffffc020ad06 <vprintfmt>
ffffffffc020b0e0:	67a2                	ld	a5,8(sp)
ffffffffc020b0e2:	00078023          	sb	zero,0(a5)
ffffffffc020b0e6:	4562                	lw	a0,24(sp)
ffffffffc020b0e8:	70a2                	ld	ra,40(sp)
ffffffffc020b0ea:	6125                	addi	sp,sp,96
ffffffffc020b0ec:	8082                	ret
ffffffffc020b0ee:	5575                	li	a0,-3
ffffffffc020b0f0:	bfe5                	j	ffffffffc020b0e8 <snprintf+0x44>

ffffffffc020b0f2 <strlen>:
ffffffffc020b0f2:	00054783          	lbu	a5,0(a0)
ffffffffc020b0f6:	872a                	mv	a4,a0
ffffffffc020b0f8:	4501                	li	a0,0
ffffffffc020b0fa:	cb81                	beqz	a5,ffffffffc020b10a <strlen+0x18>
ffffffffc020b0fc:	0505                	addi	a0,a0,1
ffffffffc020b0fe:	00a707b3          	add	a5,a4,a0
ffffffffc020b102:	0007c783          	lbu	a5,0(a5)
ffffffffc020b106:	fbfd                	bnez	a5,ffffffffc020b0fc <strlen+0xa>
ffffffffc020b108:	8082                	ret
ffffffffc020b10a:	8082                	ret

ffffffffc020b10c <strnlen>:
ffffffffc020b10c:	4781                	li	a5,0
ffffffffc020b10e:	e589                	bnez	a1,ffffffffc020b118 <strnlen+0xc>
ffffffffc020b110:	a811                	j	ffffffffc020b124 <strnlen+0x18>
ffffffffc020b112:	0785                	addi	a5,a5,1
ffffffffc020b114:	00f58863          	beq	a1,a5,ffffffffc020b124 <strnlen+0x18>
ffffffffc020b118:	00f50733          	add	a4,a0,a5
ffffffffc020b11c:	00074703          	lbu	a4,0(a4)
ffffffffc020b120:	fb6d                	bnez	a4,ffffffffc020b112 <strnlen+0x6>
ffffffffc020b122:	85be                	mv	a1,a5
ffffffffc020b124:	852e                	mv	a0,a1
ffffffffc020b126:	8082                	ret

ffffffffc020b128 <strcpy>:
ffffffffc020b128:	87aa                	mv	a5,a0
ffffffffc020b12a:	0005c703          	lbu	a4,0(a1)
ffffffffc020b12e:	0785                	addi	a5,a5,1
ffffffffc020b130:	0585                	addi	a1,a1,1
ffffffffc020b132:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b136:	fb75                	bnez	a4,ffffffffc020b12a <strcpy+0x2>
ffffffffc020b138:	8082                	ret

ffffffffc020b13a <strcmp>:
ffffffffc020b13a:	00054783          	lbu	a5,0(a0)
ffffffffc020b13e:	0005c703          	lbu	a4,0(a1)
ffffffffc020b142:	cb89                	beqz	a5,ffffffffc020b154 <strcmp+0x1a>
ffffffffc020b144:	0505                	addi	a0,a0,1
ffffffffc020b146:	0585                	addi	a1,a1,1
ffffffffc020b148:	fee789e3          	beq	a5,a4,ffffffffc020b13a <strcmp>
ffffffffc020b14c:	0007851b          	sext.w	a0,a5
ffffffffc020b150:	9d19                	subw	a0,a0,a4
ffffffffc020b152:	8082                	ret
ffffffffc020b154:	4501                	li	a0,0
ffffffffc020b156:	bfed                	j	ffffffffc020b150 <strcmp+0x16>

ffffffffc020b158 <strncmp>:
ffffffffc020b158:	c20d                	beqz	a2,ffffffffc020b17a <strncmp+0x22>
ffffffffc020b15a:	962e                	add	a2,a2,a1
ffffffffc020b15c:	a031                	j	ffffffffc020b168 <strncmp+0x10>
ffffffffc020b15e:	0505                	addi	a0,a0,1
ffffffffc020b160:	00e79a63          	bne	a5,a4,ffffffffc020b174 <strncmp+0x1c>
ffffffffc020b164:	00b60b63          	beq	a2,a1,ffffffffc020b17a <strncmp+0x22>
ffffffffc020b168:	00054783          	lbu	a5,0(a0)
ffffffffc020b16c:	0585                	addi	a1,a1,1
ffffffffc020b16e:	fff5c703          	lbu	a4,-1(a1)
ffffffffc020b172:	f7f5                	bnez	a5,ffffffffc020b15e <strncmp+0x6>
ffffffffc020b174:	40e7853b          	subw	a0,a5,a4
ffffffffc020b178:	8082                	ret
ffffffffc020b17a:	4501                	li	a0,0
ffffffffc020b17c:	8082                	ret

ffffffffc020b17e <strchr>:
ffffffffc020b17e:	00054783          	lbu	a5,0(a0)
ffffffffc020b182:	c799                	beqz	a5,ffffffffc020b190 <strchr+0x12>
ffffffffc020b184:	00f58763          	beq	a1,a5,ffffffffc020b192 <strchr+0x14>
ffffffffc020b188:	00154783          	lbu	a5,1(a0)
ffffffffc020b18c:	0505                	addi	a0,a0,1
ffffffffc020b18e:	fbfd                	bnez	a5,ffffffffc020b184 <strchr+0x6>
ffffffffc020b190:	4501                	li	a0,0
ffffffffc020b192:	8082                	ret

ffffffffc020b194 <memset>:
ffffffffc020b194:	ca01                	beqz	a2,ffffffffc020b1a4 <memset+0x10>
ffffffffc020b196:	962a                	add	a2,a2,a0
ffffffffc020b198:	87aa                	mv	a5,a0
ffffffffc020b19a:	0785                	addi	a5,a5,1
ffffffffc020b19c:	feb78fa3          	sb	a1,-1(a5)
ffffffffc020b1a0:	fec79de3          	bne	a5,a2,ffffffffc020b19a <memset+0x6>
ffffffffc020b1a4:	8082                	ret

ffffffffc020b1a6 <memmove>:
ffffffffc020b1a6:	02a5f263          	bgeu	a1,a0,ffffffffc020b1ca <memmove+0x24>
ffffffffc020b1aa:	00c587b3          	add	a5,a1,a2
ffffffffc020b1ae:	00f57e63          	bgeu	a0,a5,ffffffffc020b1ca <memmove+0x24>
ffffffffc020b1b2:	00c50733          	add	a4,a0,a2
ffffffffc020b1b6:	c615                	beqz	a2,ffffffffc020b1e2 <memmove+0x3c>
ffffffffc020b1b8:	fff7c683          	lbu	a3,-1(a5)
ffffffffc020b1bc:	17fd                	addi	a5,a5,-1
ffffffffc020b1be:	177d                	addi	a4,a4,-1
ffffffffc020b1c0:	00d70023          	sb	a3,0(a4)
ffffffffc020b1c4:	fef59ae3          	bne	a1,a5,ffffffffc020b1b8 <memmove+0x12>
ffffffffc020b1c8:	8082                	ret
ffffffffc020b1ca:	00c586b3          	add	a3,a1,a2
ffffffffc020b1ce:	87aa                	mv	a5,a0
ffffffffc020b1d0:	ca11                	beqz	a2,ffffffffc020b1e4 <memmove+0x3e>
ffffffffc020b1d2:	0005c703          	lbu	a4,0(a1)
ffffffffc020b1d6:	0585                	addi	a1,a1,1
ffffffffc020b1d8:	0785                	addi	a5,a5,1
ffffffffc020b1da:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b1de:	fed59ae3          	bne	a1,a3,ffffffffc020b1d2 <memmove+0x2c>
ffffffffc020b1e2:	8082                	ret
ffffffffc020b1e4:	8082                	ret

ffffffffc020b1e6 <memcpy>:
ffffffffc020b1e6:	ca19                	beqz	a2,ffffffffc020b1fc <memcpy+0x16>
ffffffffc020b1e8:	962e                	add	a2,a2,a1
ffffffffc020b1ea:	87aa                	mv	a5,a0
ffffffffc020b1ec:	0005c703          	lbu	a4,0(a1)
ffffffffc020b1f0:	0585                	addi	a1,a1,1
ffffffffc020b1f2:	0785                	addi	a5,a5,1
ffffffffc020b1f4:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b1f8:	fec59ae3          	bne	a1,a2,ffffffffc020b1ec <memcpy+0x6>
ffffffffc020b1fc:	8082                	ret
