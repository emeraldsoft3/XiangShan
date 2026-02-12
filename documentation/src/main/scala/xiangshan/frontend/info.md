# xiangshan/frontend

The Frontend of the XiangShan processor is responsible for fetching instructions and predicting the control flow.

## Components
- **BPU (Branch Prediction Unit)**: Predicts the target and direction of branch instructions.
- **ICache (Instruction Cache)**: Provides low-latency access to instructions.
- **IBuffer (Instruction Buffer)**: Decouples the frontend from the backend, storing fetched instructions.
- **Predecoder**: Performs basic instruction analysis (e.g., finding branch boundaries) before passing to the backend.

## Key Files
- `Frontend.scala`: The top-level frontend module.
- `BPU.scala`: Integration of various branch predictors.
- `ICache.scala`: Instruction cache implementation.
