#!/bin/bash
# =========================================================================
# build_waveform.sh
# =========================================================================
# Purpose:
# This script automates testing custom assembly files in XiangShan.
# It compiles your custom .S test file into exactly the format XiangShan 
# expects, runs the emulator on it, and exports a waveform for debugging.
#
# Usage:
#   ./build_waveform.sh asm/<your_test_file>.S
# =========================================================================

cd "$(dirname "$0")"

TEST_FILE=$1
if [ -z "$TEST_FILE" ]; then
    echo "Usage: ./build_waveform.sh asm/<assembly_file.S>"
    echo "Example: ./build_waveform.sh asm/test_addi.S"
    exit 1
fi

BASE_NAME=$(basename "$TEST_FILE" .S | sed 's/\.s$//')

echo "----------------------------------------"
echo "Building $TEST_FILE..."
echo "----------------------------------------"

# 1. Compile Assembly to ELF (uses linker script to place code at 0x80000000)
# This mimics the ROM/RAM environment of XiangShan's frontend architecture
riscv64-unknown-elf-gcc -nostdlib -nostartfiles -ffreestanding -T ld/clear_test.ld -O0 -g "$TEST_FILE" -o "elf/$BASE_NAME.elf"
if [ $? -ne 0 ]; then
    echo "Compilation failed!"
    exit 1
fi

# 2. Extract raw binary format (the memory image XiangShan reads)
riscv64-unknown-elf-objcopy -O binary "elf/$BASE_NAME.elf" "bin/$BASE_NAME.bin"

# 3. Create disassembly file (helpful for debugging your raw Hex instructions)
riscv64-unknown-elf-objdump -d "elf/$BASE_NAME.elf" > "asm/$BASE_NAME.disasm"

echo "Build successful!"
echo "ELF:          elf/$BASE_NAME.elf"
echo "Binary:       bin/$BASE_NAME.bin"
echo "Disassembly:  asm/$BASE_NAME.disasm"
echo ""
echo "----------------------------------------"
echo "Running XiangShan Emulator..."
echo "----------------------------------------"

# 4. Run emulator and output the vcd
../build/emu -i "bin/$BASE_NAME.bin" -C 10000 --no-diff --dump-wave -b 0 -e 10000 --wave-path="vcd/$BASE_NAME.vcd"

# 5. Overwrite a static "latest.vcd" file, mimicking the Zaqal GTKWave feature!
# By saving a gtkwave `.gtkw` over `vcd/latest.vcd`, you only need to press 'Shift+R'
# to reload your newest tests in GTKWave instantly.
cp "vcd/$BASE_NAME.vcd" "vcd/latest.vcd"

echo ""
echo "Simulation Finished!"
echo "Waveform saved to: vcd/$BASE_NAME.vcd"
echo "A static copy for GTKWave Reloading is available at: vcd/latest.vcd"
