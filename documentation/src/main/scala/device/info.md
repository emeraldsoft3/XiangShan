# device

The `device` folder contains implementations of various system peripherals.

## Peripherals
- **Timer**: RISC-V compatible timer.
- **UART**: Universal Asynchronous Receiver-Transmitter for serial communication.
- **PLIC (Platform-Level Interrupt Controller)**: Manages external interrupts.
- **IMSIC**: Incoming Message-Signaled Interrupt Controller for RISC-V AIA.
- **Memory/RAM**: AXI4/TileLink compatible memory models for simulation.

## Overview
Many of these devices are designed to be compatible with standard RISC-V platform specifications, allowing XiangShan to boot standard operating systems like Linux.
