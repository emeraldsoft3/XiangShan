.section .text
.global _start
_start:
    # 1. SET STACK POINTER FIRST (CRITICAL)
    li sp, 0x80010000

    # 2. MARKER 1 in a0
    li a0, 0x11111111
    nop
    nop
    nop

    # 3. REGISTER-ONLY LOOP: sum of 0..9
    li t0, 0          # i = 0
    li t1, 10         # limit = 10
    li t2, 0          # sum = 0
loop:
    add t2, t2, t0    # sum += i
    addi t0, t0, 1    # i++
    blt t0, t1, loop  # loop if i < 10

    # 4. STORE RESULT to 0x80001000
    li t3, 0x80001000
    sw t2, 0(t3)

    # 5. MARKER 3 in a1 (loop done)
    li a1, 0x33333333

    # 6. SAFE HALT: infinite jump to self
halt:
    j halt
