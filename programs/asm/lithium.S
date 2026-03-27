.section .text
.global _start
_start:
    # Set stack pointer (optional but safe)
    li sp, 0x80010000

    # User's test instructions
    .word 0x00100093 /* addi x1, x0, 1 */
    

    # Halt loop
halt:
    j halt