# The XiangShan Master: 1-Year Mastery Roadmap

Welcome, Emerald. As the Lead Maintainer of XiangShan, I've seen many attempt to unravel our architecture over a weekend only to walk away overwhelmed. Taking a 1-year, 1-hour-a-day approach is the true path to mastery. This roadmap is precision-engineered to transform you from an enthusiast to a core contributor while funneling enterprise-grade design patterns directly into your Zaqal core.

> [!IMPORTANT]
> **Your daily regimen:** 1 hour max. 5 days a week. No burnout. We are training for a marathon, not a sprint. Keep your "Black Edition" GTKWave ready—you’re going to need it.

---

## 📅 Month 1: Q1 Foundations & Tooling (Daily Breakdown)
*Objective: Master the build system, Chisel syntax idioms used in XiangShan, and the Difftest co-simulation framework.*

### Week 1: Deciphering the Chisel & Mill Metaprogramming
Before touching the CPU logic, we must understand how XiangShan generates it. We use heavy metaprogramming, parameterization, and the Mill build system.

- **Day 1: The Build Hierarchy**
  - **Task:** Read through the root `build.sc` file. Understand how Mill defines modules (like `core`, `fpu`, `memu`) and their dependencies.
  - **Action:** Run `mill resolve __.compile` to see all the compile targets available in the build system.
- **Day 2: Parameterization Secrets [x]**
  - **Task:** Open `src/main/scala/xiangshan/Parameters.scala`. Look at `XSCoreParams` and see how widths, depths, and feature flags are defined.
  - **Zaqal Synergy:** Think about how you could apply a similar `case class` parameter approach in Zaqal to make it easy to scale up or down.
- **Day 3: The Generator Framework**
  - **Task:** Trace `xiangshan.Generator` in `src/main/scala/xiangshan/Generator.scala`. See how it reads parameters and invokes Chisel's stage.
  - **Action:** Run `mill -i emu.runMain xiangshan.Generator --help`.
- **Day 4: Verilog Emission**
  - **Task:** Run the generator to emit Verilog for a basic configuration.
  - **Action:** Locate the generated `.fir` and `.v` files in your build directory. Open the `.v` file and search for the top-level module signature to see what the generated ports look like.
- **Day 5: Synthesis / Review**
  - **Task:** Review the week's concepts. Read Sections 1 & 2 of the XiangShan Design Doc PDF (`xiangshan-design-doc-en.pdf`) and map the parameter concepts to the text.

### Week 2: The Difftest Framework – Our Source of Truth
Difftest guarantees XiangShan executes correctly by comparing it against NEMU instruction-by-instruction.

- **Day 6: Architecture of Difftest**
  - **Task:** Read `src/main/scala/xiangshan/Difftest.scala`. Understand how architectural state (Regs, PC, Mem) is packaged into bundles for the testing interface.
- **Day 7: The Commit Stage**
  - **Task:** Open `src/main/scala/xiangshan/backend/commit/Commit.scala`. This is where instructions graduate and Difftest triggers.
  - **Waveform Hunting:** Track `io_difftest_commit` and `rob_commit_valid` in a waveform if you have one lying around.
- **Day 8: Running NEMU Simulator**
  - **Task:** Compile the emulator.
  - **Action:** Run `make emu EMU_TRACE=1` on a very small assembly test or `hello world` C program. Save the `build/emu.log`.
- **Day 9: Log Digging**
  - **Task:** Analyze `build/emu.log`.
  - **Action:** Use `grep "DifftestInstrCommit" build/emu.log` or similar trace outputs to see what a "perfect" execution trace looks like.
- **Day 10: Difftest in Zaqal**
  - **Task:** Zaqal Synergy. Spend your hour designing a rudimentary difftest interface for Zaqal. How would you hook up your `Commit` stage to a C++ monitor or Spike?

### Week 3: Utility Libraries and Custom Decoupled Interfaces
XiangShan extends Chisel's standard `Decoupled` with our own handshaking and flow-control mechanisms.

- **Day 11: ValidIO vs DecoupledIO**
  - **Task:** Investigate `src/main/scala/utils/Bundle.scala`. Observe how we use `Valid` interfaces where backpressure is impossible or forbidden (like flush pipelines).
- **Day 12: Hold and Skid Buffers**
  - **Task:** Look at `src/main/scala/utils/Hold.scala`. Understand how we buffer data when the next stage isn't ready.
  - **Zaqal Synergy:** Design (on paper or in Zaqal) a simple valid-only pipeline with a stall mechanism using these concepts.
- **Day 13: Pipeline Registers**
  - **Task:** Find `PipelineReg` or equivalent util in `utils/`. See how we cleanly break combinatorial paths.
- **Day 14: Flush / Redirect Logic**
  - **Task:** Search `src/main/scala/utils/` for `flush` logic. Notice how valid bits are cleared immediately while data might remain but be ignored.
  - **Waveform Hunting:** Start a test simulation and observe `valid`, `ready`, and `flush` intersecting in any utility module.
- **Day 15: Utility Review**
  - **Task:** Review the utility folder. These utilities are the lego-bricks of the massive OoO machine. Skim the PDF documentation for any mention of timing constraints or pipeline staging.

### Week 4: The Core Top-Level & Clock Domains
Understanding how the Front-End, Back-End, and Memory subsystems are glued together.

- **Day 16: Top-Level Modules**
  - **Task:** Open `src/main/scala/xiangshan/XiangShan.scala` and `src/main/scala/xiangshan/CoreDomain.scala`.
  - **Action:** Trace the huge bundles connecting Frontend (IFU) to Backend (Ctrl/Decode).
- **Day 17: Clock and Reset Domains**
  - **Task:** Analyze how resets are staggered. Look for `withClockAndReset` blocks.
  - **Zaqal Synergy:** Think about splitting Zaqal into `Frontend`, `Backend`, and `Memory` domains for cleaner organization, even if they share a clock for now.
- **Day 18: The Graph Generator**
  - **Task:** If available, run `mill -i emu.runMain xiangshan.GraphGenerator` to visually map the top-level block connections.
- **Day 19: Boot Sequence**
  - **Task:** Search for the reset vector and boot ROM initialization in the top-level parameters or modules. See what PC the core starts at.
- **Day 20: Month 1 Retrospective**
  - **Task:** You've mapped the shell of the processor. Review your notes, sync Zaqal's architecture plans, and prepare for diving into the TAGE Predictor and Frontend in Quarter 2!

---

## 🚀 High-Level Summary: Months 2-12

### Quarter 1: Foundations & Tooling (Continued)
- **Month 2 (Weeks 5-8): Core Utilities & SRAMs:** deeply analyzing our wrapper classes for SRAMs (`SRAMTemplate.scala`), dual-port memory models, and logging infrastructure.
- **Month 3 (Weeks 9-13): Microarchitecture Deep-dive:** studying the XiangShan documentation (`xiangshan-design-doc-en.pdf`) against the code. Mapping documented pipeline stages to actual Chisel modules.

### Quarter 2: The Frontend (Weeks 14-26)
- **Weeks 14-17 (IFU & I-Cache):** Navigating the Instruction Fetch Unit. How we fetch 32 bytes at a time, align instructions, and manage I-Cache coherence using TileLink.
- **Weeks 18-22 (BPU - Branch Prediction Unit):** The crown jewel: our TAGE predictor. Analyzing BTB, Bimodal predictors, RAS, and the TAGE tables.
- **Weeks 23-26 (Decode & Rename):** Breaking down RISC-V instructions into macro-ops. Introduction to the physical tag renaming process to break false dependencies.

### Quarter 3: The Engine (OoO Core) (Weeks 27-39)
- **Weeks 27-30 (Dispatch & Issue Queues):** How instructions mapped to Physical Registers are slotted into reservation stations. Wakeup and Select logic.
- **Weeks 31-35 (Execution Units & Bypass Network):** Deep dive into the integer ALUs, FPU, and the massive bypass (forwarding) network that prevents Pipeline stalls.
- **Weeks 36-39 (ROB & Physical Register File):** The Reorder Buffer. Tracking instructions from dispatch to commit. Handling exceptions, flushes, and precise states.

### Quarter 4: The Memory Subsystem & Integration (Weeks 40-52)
- **Weeks 40-44 (L1 D-Cache & Non-blocking semantics):** MSHRs (Miss Status Holding Registers) allowing the processor to continue execution while waiting for memory.
- **Weeks 45-48 (Load-Store Queue - LSQ):** The hardest part of any OoO core. Handling memory dependence prediction, forwarding stores to loads, and memory ordering violations.
- **Weeks 49-51 (TLB & Virtual Memory):** Page table walkers, SV39/SV48 constraints, and TLB hierarchies.
- **Week 52 (TileLink / CHI bus protocols):** How the L2 cache interfaces with the broader SoC and DRAM controllers.
