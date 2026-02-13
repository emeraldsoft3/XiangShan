// Bare-metal style C (no stdlib)

volatile unsigned int *RESULT_ADDR = (unsigned int *)0x80010000;

void _start(void) {
    // stack pointer setup happens in assembly, not C

    unsigned int t0 = 0;    // loop counter
    unsigned int t1 = 10;   // loop limit
    unsigned int t2 = 0;    // accumulator

    // loop:
    while (t0 < t1) {
        t2 = t2 + t0;
        t0 = t0 + 1;
    }

    // store result to memory-mapped location
    *RESULT_ADDR = t2;

    // halt
    while (1) {
        // infinite loop
    }
}
