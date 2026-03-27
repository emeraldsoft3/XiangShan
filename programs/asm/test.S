.option norvc
.section .text
.globl _start
_start:
    addi x1, x0, 1
    addi x1, x0, 1
end:
    j end
.balign 64
