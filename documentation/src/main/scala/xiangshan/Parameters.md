# Parameters.scala

This file defines the configuration system for XiangShan.

## Overview
XiangShan uses a parameter-based configuration system (inspired by Rocket Chip) to allow for flexible architectural exploration.

## Key Classes
- `XSCoreParameters`: The main case class containing all architectural knobs:
    - **Fetch/Decode/Commit Widths**: (e.g., 6-wide decode, 8-wide commit).
    - **Queue Sizes**: ROB size, Issue Queue size, LSQ size.
    - **Functional Units**: Configuration of ALU, BJU, LSU, etc.
    - **Branch Predictor**: Configuration for BPU, FTB, Tage, etc.
    - **Caches**: ICache and DCache parameters.
    - **ISA Extensions**: RV64IMAFDCV support toggles.

- `XSCoreParamsKey`: A Field used to look up these parameters in the global `Parameters` context.
