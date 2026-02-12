# FTB.scala

The **Fetch Target Buffer (FTB)** is a core component of the branch prediction system.

## Overview
Unlike a traditional BTB that stores single branches, the FTB stores information about an entire fetch packet (multiple instructions).

## Key Information Stored
- **Target Address**: The address to fetch next if a branch/jump is taken.
- **Branch Locations**: Which instructions in the packet are branches.
- **Branch Type**: Conditional, Jump, Call, Return, etc.
- **Fall-through Address**: The next sequential address if no branch is taken.

## Features
- Optimized for high-width fetch (multispeculative prediction).
- Supports compressed instructions (RVC).
- Used by the IFU to determine the next PC.
