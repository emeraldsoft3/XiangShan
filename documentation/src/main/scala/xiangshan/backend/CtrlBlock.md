# CtrlBlock.scala

The **Control Block (CtrlBlock)** is the heart of the XiangShan backend's control logic.

## Overview
It coordinates the movement of instructions through the backend pipeline, managing resources like the Reorder Buffer (ROB) and the Rename unit.

## Key Responsibilities
- **ROB Coordination**: Manages instruction allocation and retirement in the `Rob`.
- **Redirect Management**: Collects redirection requests from execution units (e.g., branch mispredictions) and generates the corresponding flush signals.
- **Top-Down Information**: Tracks performance metrics using the Top-Down methodology.
- **CSR and Exception Handling**: Manages Control and Status Registers and processes architectural exceptions.
