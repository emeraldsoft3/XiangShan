	.file	"clear_test.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	_start
	.type	_start, @function
_start:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
 #APP
# 4 "c/clear_test.c" 1
	li a0, 0x11111111
# 0 "" 2
# 5 "c/clear_test.c" 1
	nop; nop; nop
# 0 "" 2
 #NO_APP
	sw	zero,-36(s0)
	sw	zero,-20(s0)
	j	.L2
.L3:
	lw	a5,-36(s0)
	sext.w	a5,a5
	lw	a4,-20(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	sw	a5,-36(s0)
 #APP
# 12 "c/clear_test.c" 1
	li t0, 0x22222222
# 0 "" 2
# 13 "c/clear_test.c" 1
	nop
# 0 "" 2
 #NO_APP
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,9
	ble	a4,a5,.L3
 #APP
# 17 "c/clear_test.c" 1
	li a1, 0x33333333
# 0 "" 2
 #NO_APP
	li	a5,524288
	addi	a5,a5,1
	slli	a5,a5,12
	sd	a5,-32(s0)
	lw	a5,-36(s0)
	sext.w	a4,a5
	ld	a5,-32(s0)
	sw	a4,0(a5)
 #APP
# 24 "c/clear_test.c" 1
	li a2, 0x44444444
# 0 "" 2
 #NO_APP
.L4:
 #APP
# 28 "c/clear_test.c" 1
	nop
# 0 "" 2
 #NO_APP
	j	.L4
	.size	_start, .-_start
	.ident	"GCC: () 10.2.0"
