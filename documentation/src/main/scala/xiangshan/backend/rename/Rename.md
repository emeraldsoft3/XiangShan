# Rename.scala

The **Rename** unit is responsible for resolving false data dependencies (WAW and WAR) by mapping architectural registers to a larger pool of physical registers.

## Overview
It uses a Register Alias Table (RAT) to keep track of the current mappings and a Free List to manage available physical registers.

## Key Components
- **RAT (Register Alias Table)**: Stores the mapping from architectural to physical registers.
- **Free List**: Tracks which physical registers are currently not in use.
- **Checkpointing**: Saves the RAT state to allow for rapid recovery from branch mispredictions.
