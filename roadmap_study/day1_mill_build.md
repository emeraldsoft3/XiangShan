# Day 1 Study Notes: The Build Hierarchy

## Overview of `build.sc`
XiangShan uses the **Mill** build tool, which relies on a Scala script named `build.sc`. Instead of a traditional `Makefile`, Mill leverages Scala's object-oriented nature to define modules and their dependencies. This allows for powerful metaprogramming and dynamic resolution of compilation parameters.

## How Modules are Defined
If you look closely at `build.sc`, you won't see traditional sub-modules simply listed. Instead, each module is represented as a Scala `object` that trait-mixes configurations.

### The Major Mill Modules in XiangShan
Unlike older SoC designs that had just `core`, `fpu`, and `mem`, XiangShan's component architecture is grouped into the following major modules:

1. **`rocketchip`**: XiangShan leverages the base standard interfaces, diplomacy, and CDE (Context-Dependent Environments) from the Rocket Chip generator.
2. **`utility`**: Contains custom `ValidIO` skid buffers, pipeline registers, and specific decouple logic that extends Chisel standards.
3. **`yunsuan`**: Translates to "Calculation". This forms the Integer Execution units (ALU, BRU).
4. **`fudian`**: Translates to "Floating Point". This handles Floating Point Unit operations.
5. **`huancun`**: Translates to "Cache". This handles the L1 Cache subsystem.
6. **`coupledL2` & `openLLC`**: Handle the L2 cache and Last-Level-Cache subsystems, connected via TileLink / CHI.
7. **`difftest`**: The Co-Simulation framework linking NEMU with XiangShan.
8. **`chiselAIA`**: Advanced Interrupt Architecture blocks.
9. **`xiangshan`**: The top-level wrapper module that unifies all the dependencies.

### Resolving Dependencies (`moduleDeps`)
To enforce a clean DAG (Directed Acyclic Graph) of compilation so the build doesn't break cyclically, the top-level `xiangshan` module defines its dependencies recursively:

```scala
  override def moduleDeps = super.moduleDeps ++ Seq(
    rocketModule,
    difftestModule,
    huancunModule,
    coupledL2Module,
    openLLCModule,
    yunsuanModule,
    fudianModule,
    utilityModule,
    chiselAIAModule,
    macrosModule
  )
```

## Running `mill resolve __.compile`
When you execute `mill resolve __.compile`, Mill queries its internal DAG and lists every target that can be compiled. In our run, it outputted 58 compilation targets.

It groups compilation efficiently:
- `xiangshan.compile` (Top Level)
- `xiangshan.yunsuanModule.compile`
- `xiangshan.fudianModule.compile`
- `xiangshan.huancunModule.compile`
...and so on. 

This output proves that XiangShan treats different parts of the CPU (like FPU, Caches, ALUs) as entirely separate Scala libraries that can be unit-tested and generated completely independently before being stitched together at the top level.

## Zaqal Synergy Takeaway
For your Zaqal core, you can adopt this structure. As your core grows, you can split your `Frontend`, `Backend`, and `Memory` packages into separate build modules. This allows you to compile and test the `Backend` out-of-order execution engine without waiting for the `Memory` subsystem to recompile every time!
