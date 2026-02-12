// research_stack.c
// Purpose: Demonstrate stack pointer usage via function calls

// Prevent compiler from optimizing things away
volatile int sink;

void bar(void) {
    // Local variable → lives on the stack
    int x = 10;

    // Prevent optimization
    sink = x;
}

void foo(void) {
    // Local variables → stack
    int a = 5;
    int b = 6;
    int c;

    c = a + b;

    // Prevent optimization
    sink = c;

    // Function call → uses stack (ra saved)
    bar();
}

void _start(void) {
    // Stack pointer is already set by boot code in real systems
    // Here we assume it is initialized manually in assembly

    foo();

    // Infinite halt loop
    while (1) {
        // do nothing
    }
}
