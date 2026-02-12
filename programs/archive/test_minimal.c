// Minimal program without libc dependencies
void _start() {
    // Your computations without stdlib
    int result = 0;
    
    // Simple computations
    for (int i = 0; i < 10; i++) {
        result += i * 2;
    }
    
    // Memory operations
    int array[5] = {1, 2, 3, 4, 5};
    for (int i = 0; i < 5; i++) {
        result += array[i];
    }
    
    // Infinite loop to prevent running off into invalid memory
    while(1) {
        asm volatile ("nop");
    }
}
