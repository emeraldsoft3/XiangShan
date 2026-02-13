# XSTile.scala

`XSTile` is the tile-level wrapper for the XiangShan processor.

## Overview
It integrates the `XSCore` with the `L2Top` (L2 Cache system). A tile represents a single "core" in a multi-core system, including its private caches.

## Key Components
- `XSTile`: A `LazyModule` that instantiates `XSCore` and `L2Top`.
- `XSTileImp`: Handles the IO connections between the core and the L2 cache, as well as external interfaces like TileLink or CHI.

## External Interfaces
- **Memory Interface**: Can be configured for TileLink (TL) or Coherent Hub Interface (CHI).
- **Control/Status Ports**: HartId, MSI (Message Signaled Interrupt), Reset Vector, etc.
