# IFU.scala

The **Instruction Fetch Unit (IFU)** is responsible for requesting and receiving instruction data from the memory system.

## Fetch Pipeline
The IFU implements a multi-stage fetch pipeline:
- **F0**: PC generation and ICache/ITLB request.
- **F1**: ITLB response and ICache tag check.
- **F2**: ICache data response and pre-decode.
- **F3**: Instruction expansion (RVC) and buffering.

## Key Features
- Supports Fetch-Directed Instruction Prefetching (FDIP).
- Handles MMIO instruction fetches.
- Integrates a `PreDecode` module to identify branches early in the pipeline.
- Manages pipeline stalls and flushes due to redirects.
