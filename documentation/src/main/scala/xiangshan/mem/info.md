# xiangshan/mem

The **Memory System** manages all data memory accesses and provides the interface between the ooO backend and the cache hierarchy.

## Key Components
- **MemBlock.scala**: The central hub of the memory system. It integrates the LSU, D-Cache, and TLBs.
- **LSQueue (Load/Store Queue)**: Manages in-flight memory operations, ensuring correct ordering and handling data forwarding (Store-to-Load Forwarding).
- **Prefetcher**: Implements various hardware prefetching algorithms (e.g., SMS, BOP) to bring data into caches before it's needed.
- **Store Buffer (SBuffer)**: Holds committed store data until it can be written to the L1D cache or the outer memory system.

## Major Functions
- Memory dependency checking.
- Virtual-to-physical address translation for loads and stores.
- Handling cache misses and refills.
- Interfacing with the Backend for instruction retirement (SQ deq) and exception reporting.
