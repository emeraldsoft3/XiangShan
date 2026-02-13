void _start() {
    volatile int result = 0;
    
    // Simple computation that should be visible
    for (int i = 0; i < 100; i++) {
        result += i * 2;
    }
    
    // Create a unique pattern to find in waveforms
    volatile int marker = 0x12345678;
    
    // Instead of infinite loop, use a finish sequence
    asm volatile (
        "li a0, 0\n"        // exit code 0
        "li a7, 93\n"       // exit syscall number
        "ecall\n"           // system call
    );
    
    // Fallback infinite loop
    while(1) { asm volatile ("nop"); }
}