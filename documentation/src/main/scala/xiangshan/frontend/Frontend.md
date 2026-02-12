# Frontend.scala

`Frontend` is the top-level module for the instruction fetch and branch prediction subsystem.

## Overview
It coordinates the activities of the Instruction Fetch Unit (IFU) and the Branch Prediction Unit (BPU). It interfaces with the backend to deliver fetch packets and handle redirection (e.g., branch mispredictions, flushes).

## Key Components
- Integrates `IFU` and `BPU`.
- Manages the interaction with the ICache.
- Handles the transfer of fetch packets to the Instruction Buffer.
