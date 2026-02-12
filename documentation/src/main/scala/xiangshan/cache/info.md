# xiangshan/cache

This folder contains the cache hierarchy of the XiangShan processor.

## Cache Levels
- **L1I (Instruction Cache)**: Fast access to instructions for the Frontend.
- **L1D (Data Cache)**: Private data cache for the core.
- **L2 Cache**: Private/Shared level 2 cache.

## Memory Management
- **MMU (Memory Management Unit)**: Handles virtual-to-physical address translation.
- **TLB (Translation Lookaside Buffer)**: Caches address translations for L1I, L1D, and L2.
- **PTW (Page Table Walker)**: Performs hardware page table walks on TLB misses.

## Structure
- `mmu`: Contains TLB and PTW implementations.
- `dcache`: Data cache specific logic.
- `icache`: Instruction cache specific logic (usually in `frontend/icache`).
