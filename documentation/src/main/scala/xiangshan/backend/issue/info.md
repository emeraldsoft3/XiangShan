# xiangshan/backend/issue

This folder contains the logic for the out-of-order issue queues.

## Overview
Issue queues store micro-ops (uops) and "issue" them to functional units when their data operands are ready and the unit is available.

## Key Components
- **IssueQueue.scala**: The base implementation of an issue queue.
- **Queue Types**: XiangShan uses different queues for different types of instructions:
    - **Int Issue Queue**: For integer operations (ALU, BJU).
    - **FP Issue Queue**: For floating-point operations.
    - **Mem Issue Queue**: For memory operations (LSU).
- **Wakeup Logic**: Handles the signaling from completing instructions to waiting uops in the queue.
- **Select Logic**: Chooses which ready uop to issue to a functional unit based on priority.
