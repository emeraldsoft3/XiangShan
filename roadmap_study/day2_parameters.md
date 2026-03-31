# Day 2 Study: Parameterization Secrets in XiangShan
**File Studied**: `src/main/scala/xiangshan/Parameters.scala`

## Key Findings
1. **The God Class: `case class XSCoreParameters`**
   XiangShan defines practically the entire processor architecture through a single massive Scala case class (`XSCoreParameters`). This dictates everything:
   - **Feature Flags**: `HasFPU`, `HasVPU`, `HasCExtension`, `EnableBPU`, `EnableClockGate`.
   - **Metrics & Dimensions**: `FetchWidth = 8`, `DecodeWidth = 6`, `RenameWidth = 6`.
   - **Array Depths**: `RobSize = 160`, `FtqSize = 64`, `StoreQueueSize = 56`.
   - **Predictor Tuning**: `TageTableInfos`, `ITTageTableInfos`, `UbtbSize`.

2. **The `HasXSParameter` Trait**
   XiangShan handles propagating these parameters via a Scala `trait` called `HasXSParameter`.
   - Any hardware module that needs configuration simply extends this trait using `implicit val p: Parameters`.
   - The trait translates complex parameter dictionary lookups into simple `def` constants (e.g., `def RobSize = coreParams.RobSize`). 
   - This means deeply nested modules can just use `RobSize` generically instead of hardcoding `160`.

3. **Scheduler Block Injection**
   Even complex hardware sub-components such as the Integer Scheduler (`intSchdParams`), Vector Scheduler, and Execution Units are parameterized using lists/sequences of `ExeUnitParams`. The pipeline is generated functionally rather than manually wired instance-by-instance.

## Synergy with Zaqal (Recommendation)
Yes, Zaqal **absolutely** needs this. Right now, our queues (like `IBUF`), fetch widths (currently hardcoded as Vec(8)), and module boundaries are completely un-scalable and hardcoded. 

- **If we want Kunminghu parity**, we need a master `ZaqalParams.scala` containing a `case class ZaqalParameters`.
- We should create a `trait HasZaqalParams` injected via implicits (`implicit val p: Parameters`) to standard Chisel modules, allowing us to tweak widths entirely from one file.
- **Addition to Zaqal roadmap**: We already have *Day 8: Abstract common configurations into case class ZaqalParams* on the Phase 3 roadmap. Let's make sure creating `trait HasZaqalParams` and transitioning `ICache`/`Frontend` away from hardcoded widths is tackled then!
