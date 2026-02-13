# xiangshan/backend/fu

This folder contains the implementations of the various functional units (FUs) in the execution engine.

## Functional Units
- **ALU (Arithmetic Logic Unit)**: Basic integer arithmetic and logic operations.
- **BJU (Branch Jump Unit)**: Handles control-flow instructions and calculates branch targets.
- **MUL/DIV**: Hardware multiplier and divider.
- **LSU (Load Store Unit)**: Manages memory access operations.
- **FPU (Floating Point Unit)**: Handles floating-point arithmetic.
- **Vector Unit**: Implements RISC-V Vector extension operations.

## Structure
Each FU typically has its own subfolder containing its specific logic and pipeline stages.
