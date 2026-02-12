// A clear test program with easy-to-spot patterns
void _start() {
    // MARKER 1: Start of program - easy to find
    asm volatile ("li a0, 0x11111111");  // MARKER VALUE 1
    asm volatile ("nop; nop; nop");
    
    // Simple loop with clear pattern
    volatile int sum = 0;
    for (int i = 0; i < 10; i++) {
        sum = sum + i;
        // MARKER 2: Each iteration - easy to spot
        asm volatile ("li t0, 0x22222222");  // MARKER VALUE 2
        asm volatile ("nop");
    }
    
    // MARKER 3: Loop complete
    asm volatile ("li a1, 0x33333333");  // MARKER VALUE 3
    
    // Store result to memory (creates memory write)
    volatile int* addr = (volatile int*)0x80001000;
    *addr = sum;
    
    // MARKER 4: Memory write done
    asm volatile ("li a2, 0x44444444");  // MARKER VALUE 4
    
    // Halt
    while(1) {
        asm volatile ("nop");
    }
}