# 目录： #


1、[怎么写裸板程序](#jump1)



2、[第一个点灯程序](#jump2)

- 2.1：[start.s代码分析](#jump2.1)

- 2.2：[makefile代码分析](#jump2.2)


<h2 id="1">1. <span id="jump1">怎么写裸板程序</span></h2>、

分为两步：写启动代码和写c函数。其中写启动代码包括写硬件初始化程序和调用c函数的程序


<h2 id="2">2. <span id="jump2">第一个点灯程序</span></h2>


<h3 id="2.1">2.1 <span id="jump2.1">start.s代码分析：</span></h3>



.globl _start

_start:


/* 硬件相关的设置 */

    /* Peri port setup */
    ldr r0, =0x70000000  //设置外设起始地址
    orr r0, r0, #0x13    //看arm11的手册知道0x13的对应大小为256M
    mcr p15,0,r0,c15,c2,4       @ 256M(0x70000000-0x7fffffff)
    
/* 关看门狗 */
/* 往WTCON(0x7E004000)写0 */
	
	ldr r0, =0x7E004000
	mov r1, #0
	str r1, [r0]

/* 设置GPMCON让GPM3作为输出引脚 */

	ldr r1, =0x7F008820
	mov r0, #0x1000
	str r0, [r1]

/* 设置GPMDAT让GPM3输出0 */

	ldr r1, =0x7F008824
	mov r0, #0
	str r0, [r1]

halt:

	b halt	


<h3 id="2.2">2.2 <span id="jump2.2">makefile代码分析：</span></h3>


led.bin: start.o

	arm-linux-ld -Ttext 0 -o led.elf start.o
	arm-linux-objcopy -O binary led.elf led.bin
	arm-linux-objdump -D led.elf > led.dis

start.o : start.S

	arm-linux-gcc -o start.o start.S -c

clean:

	rm *.o led.elf led.bin led.dis
