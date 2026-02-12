# xiangshan

The core logic of the XiangShan processor.

This folder contains the main architectural modules:
- `frontend`: Fetch, Branch Prediction, and Instruction Buffer.
- `backend`: Decode, Rename, Dispatch, Issue, Execute, and Commit.
- `cache`: L1i, L1d, and L2 cache implementations.
- `mem`: Memory system and bus interfaces.
- `transforms`: FIRRTL transforms used in the build process.

Core Files:
- `XSCore.scala`: The top-level core module.
- `XSTile.scala`: Tile-level integration (Core + Caches).
- `Parameters.scala`: Global configuration parameters.
