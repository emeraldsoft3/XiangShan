# XSCore.scala

`XSCore` is the top-level module of the XiangShan processor core.

## Overview
It integrates the three main components of the processor:
1.  **Frontend**: Instruction fetch and branch prediction.
2.  **Backend**: Out-of-order execution engine (Decode, Rename, Dispatch, Issue, Execute, Commit).
3.  **MemBlock**: Memory system interface, including Load/Store Queues and L1 Caches.

## Key Components
- `XSCore`: A `LazyModule` that wraps the core logic.
- `XSCoreImp`: The implementation of the core logic, containing instances of `frontend`, `backend`, and `memBlock`.

## Main Connections
- Handshake between Frontend and Backend (Instruction transfer).
- Redirect signals from Backend to Frontend.
- Memory requests from Backend to MemBlock.
- CSR and TLB control between Backend and MemBlock.
