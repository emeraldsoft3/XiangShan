# Rob.scala

The **Reorder Buffer (ROB)** is responsible for maintaining the program order in an out-of-order execution environment.

## Overview
As instructions are dispatched, they are allocated an entry in the ROB. They remain in the ROB until they have successfully executed and are ready to be committed to the architectural state.

## Key Features
- **In-order Retirement**: Ensures that instructions update the register file and memory in the original program order.
- **Exception Tracking**: RECORDS any exceptions that occur during execution and handles them during commitment.
- **Speculation Recovery**: Provides the necessary state to recover from branch mispredictions.
