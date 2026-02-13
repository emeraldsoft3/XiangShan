#!/usr/bin/env python3
import os
import sys

def parse_vcd_hierarchy(vcd_file):
    """
    Parse VCD file and extract full signal paths with hierarchy.
    Returns list of (full_signal_path, signal_name)
    """
    signals = []
    current_path = []
    
    with open(vcd_file, 'r') as f:
        for line in f:
            line = line.strip()
            
            if line.startswith('$scope module'):
                # Enter new scope: $scope module <name> $end
                parts = line.split()
                if len(parts) >= 3:
                    module_name = parts[2]
                    current_path.append(module_name)
                    
            elif line.startswith('$upscope'):
                # Exit scope
                if current_path:
                    current_path.pop()
                    
            elif line.startswith('$var'):
                # Found a signal: $var <type> <width> <code> <name> $end
                parts = line.split()
                if len(parts) >= 5:
                    # Signal name is everything from part[4] to before "$end"
                    signal_name = ' '.join(parts[4:-1])
                    
                    # Build full path
                    full_path = '.'.join(current_path + [signal_name])
                    signals.append(full_path)
    
    return signals

def organize_signals(vcd_file, output_dir="signals"):
    """
    Organize signals into directory tree based on their hierarchy.
    """
    print(f"Reading VCD file: {vcd_file}")
    
    # Parse signals with full hierarchy
    signals = parse_vcd_hierarchy(vcd_file)
    print(f"Found {len(signals)} signals")
    
    # Create dictionary: {module_path: [signals]}
    signal_dict = {}
    
    for signal in signals:
        # Split by dots
        parts = signal.split('.')
        
        if len(parts) < 2:
            # Top-level signal
            module_path = ''
            leaf_name = signal
        else:
            # The last part is the signal name, everything else is module path
            module_path = '/'.join(parts[:-1])
            leaf_name = parts[-1]
        
        # Store in dictionary
        if module_path not in signal_dict:
            signal_dict[module_path] = []
        
        # Store both full path and leaf name for reference
        signal_dict[module_path].append(signal)
    
    print(f"Organizing into {len(signal_dict)} modules...")
    
    # Create output directory
    os.makedirs(output_dir, exist_ok=True)
    
    # Create directory structure and files
    files_created = 0
    
    for module_path, signal_list in signal_dict.items():
        # Skip if too many signals in one module (like top level)
        if len(signal_list) > 10000:
            print(f"  Skipping {module_path or 'top'} (too many signals: {len(signal_list)})")
            continue
        
        # Create directory path
        if module_path:
            dir_path = os.path.join(output_dir, module_path)
            os.makedirs(dir_path, exist_ok=True)
            
            # Create filename from last part of module path
            module_parts = module_path.split('/')
            filename = module_parts[-1] + ".txt"
            file_path = os.path.join(dir_path, filename)
        else:
            # Top-level signals
            file_path = os.path.join(output_dir, "top_level.txt")
        
        # Write signals to file
        with open(file_path, 'w') as f:
            for signal in sorted(signal_list):
                f.write(f"{signal}\n")
        
        files_created += 1
        if files_created % 100 == 0:
            print(f"  Created {files_created} files...")
    
    # Create summary
    summary_file = os.path.join(output_dir, "summary.txt")
    with open(summary_file, 'w') as f:
        f.write(f"Total signals: {len(signals)}\n")
        f.write(f"Unique modules: {len(signal_dict)}\n")
        f.write(f"Files created: {files_created}\n\n")
        
        # List top 20 modules by signal count
        f.write("Top 20 modules by signal count:\n")
        sorted_modules = sorted(signal_dict.items(), key=lambda x: len(x[1]), reverse=True)
        
        for i, (module_path, signal_list) in enumerate(sorted_modules[:20]):
            module_name = module_path if module_path else "(top level)"
            f.write(f"{i+1:3}. {module_name}: {len(signal_list)} signals\n")
    
    print(f"\nSummary written to: {summary_file}")
    print(f"Files created: {files_created}")
    print("Done!")

def main():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <vcd_file>")
        print(f"Example: {sys.argv[0]} vcd/hydrogen.vcd")
        sys.exit(1)
    
    vcd_file = sys.argv[1]
    output_dir = "signals"
    
    if not os.path.exists(vcd_file):
        print(f"Error: VCD file not found: {vcd_file}")
        sys.exit(1)
    
    organize_signals(vcd_file, output_dir)

if __name__ == "__main__":
    main()