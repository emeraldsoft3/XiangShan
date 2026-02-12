# Backend.scala

`Backend` is the top-level module for the execute-and-commit portion of the XiangShan processor.

## Overview
It integrates the control logic (`CtrlBlock`) and the datapath logic. It receives instructions from the Frontend, executes them out-of-order, and commits them in-order.

## Key Components
- `CtrlBlock`: Manages instruction lifecycle (ROB, Renaming, Dispatch).
- `DataPath`: Contains the execution units and register files.
- Interfaces with the `MemBlock` for memory operations.
