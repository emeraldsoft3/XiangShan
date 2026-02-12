# IBuffer.scala

The **Instruction Buffer (IBuffer)** decouples the instruction fetch process from the execution backend.

## Overview
It stores instructions fetched by the frontend until the backend is ready to decode them. This helps hide the latency of cache misses and branch mispredictions.

## Key Features
- **Queue-like Structure**: Buffers instructions in program order.
- **Width Conversion**: Can handle different fetch and decode widths.
- **Flush Support**: Synchronizes with backend redirects to clear stale instructions.
