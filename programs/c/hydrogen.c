void _start() {
    // ENTIRELY in assembly to control every instruction
    asm volatile (
        // 1. SET STACK POINTER FIRST (CRITICAL)
        "li sp, 0x80010000\n"

        // 2. MARKER 1 in a0
        "li a0, 0x11111111\n"
        "nop\n nop\n nop\n"

        // 3. REGISTER-ONLY LOOP: sum of 0..9
        "li t0, 0\n"          // i = 0
        "li t1, 10\n"         // limit = 10
        "li t2, 0\n"          // sum = 0
        "1:\n"
        "add t2, t2, t0\n"    // sum += i
        "addi t0, t0, 1\n"    // i++
        "blt t0, t1, 1b\n"    // loop if i < 10

        // 4. STORE RESULT to 0x80001000
        "li t3, 0x80001000\n"
        "sw t2, 0(t3)\n"

        // 5. MARKER 3 in a1 (loop done)
        "li a1, 0x33333333\n"

        // 6. SAFE HALT: infinite jump to self
        "2:\n"
        "j 2b\n"
    );
}