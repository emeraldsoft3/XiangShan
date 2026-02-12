# xiangshan/backend

The Backend of the XiangShan processor implements an out-of-order execution engine.

## Core Stages
- **Decode**: Translates instructions into micro-ops (uops).
- **Rename**: Maps architectural registers to physical registers.
- **Dispatch**: Places uops into issue queues.
- **Issue**: Selects uops for execution based on operand availability.
- **Execute**: Functional units (ALU, BJU, LSU, etc.) perform the operations.
- **Commit**: Updates the architectural state in program order.

## Major Components
- `Backend.scala`: Top-level integration of the backend.
- `Decode.scala`: Instruction decoding logic.
- `Rename.scala`: Register renaming and RAT (Register Alias Table).
- `Rob.scala`: Reorder Buffer for managing instruction commitment.
- `IssueQueues`: Various queues (Int, FP, Mem) for out-of-order issue.
- `ExecutionUnits`: Folders containing specific functional unit implementations (`fu`).
