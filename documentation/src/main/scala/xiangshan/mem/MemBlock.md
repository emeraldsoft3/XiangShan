# MemBlock.scala

`MemBlock` is the top-level module of the memory subsystem within the XiangShan core.

## Overview
It coordinates the interaction between the Out-of-Order (OoO) execution engine and the memory hierarchy (caches and bus).

## Key Responsibilities
- **Backend Interface**: Connects to the Backend's dispatch and issue stages for memory micro-ops.
- **LSQ Integration**: Instantiates and manages the Load/Store Queues.
- **Cache/MMU Management**: Interfaces with the L1D cache and the TLBs for address translation and data access.
- **Consistency and Ordering**: Ensures that memory operations follow the RISC-V memory model (RVWMO).
- **Page Table Walk**: Hosts or interfaces with the Page Table Walker (PTW).
