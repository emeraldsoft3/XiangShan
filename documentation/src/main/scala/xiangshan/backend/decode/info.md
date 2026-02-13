# xiangshan/backend/decode

This folder contains the logic for instruction decoding and micro-op fusion.

## Key Files
- **FusionDecoder.scala**: Implements the logic to decode instructions into micro-ops (uops). It also supports "instruction fusion," where multiple instructions are combined into a single uop for more efficient execution.
- **DecodeStage.scala**: Manages the pipeline stage for decoding, interfacing with the instruction buffer and the rename unit.
