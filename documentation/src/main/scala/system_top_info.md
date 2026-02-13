# system and top

These folders handle the integration of the processor core into a complete SoC (System on Chip).

## system
- **SoC.scala**: Defines the base SoC structure, including the core, memory system, and peripherals. It handles the wiring of global signals like interrupts and resets.

## top
- **Top.scala**: The very top-level module created by the generator. It combines the SoC with specific physical interfaces (e.g., for FPGA or ASIC).
- **Configs.scala**: Defines various design points (e.g., Nanhu, Kunminghu) by specifying sets of parameters.
- **Generator.scala**: The entry point for the Chisel compiler (Firrtl) to emit Verilog.
- **ArgParser.scala / YamlParser.scala**: Tools for parsing command-line and configuration files during the build process.
