import os
import re

def clean_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    clean_lines = []
    skip_lines = 0
    
    # Regex patterns for junk code
    junk_comment_pattern = re.compile(r'^\s*//\s*(MARK:\s*-\s*[A-Z]{10}|TODO:\s*check\s*[a-z]{10}|optimized\s*by\s*[a-z]{10}|[a-z]{10}\s*logic\s*here)\s*$')
    junk_var_pattern = re.compile(r'^\s*private\s+(let|var)\s+[a-z]{10}\s*[=:]')
    junk_func_pattern = re.compile(r'^\s*private\s+func\s+[a-z]{10}\(')

    first_extension_line = -1
    first_extension_line = -1
    for i, line in enumerate(lines):
        if "// MARK: - Obfuscation Extension" in line or "// MARK: - Junk Class" in line:
            first_extension_line = i
            break
            
    # If we found the extension or class marker, discard everything from there onwards
    if first_extension_line != -1:
        lines = lines[:first_extension_line]

    # Now clean the remaining lines (inner junk from first attempt)
    for i, line in enumerate(lines):
        if skip_lines > 0:
            skip_lines -= 1
            continue
            
        # Check for junk comments
        if junk_comment_pattern.match(line):
            continue
            
        # Check for junk vars
        if junk_var_pattern.match(line):
            continue
            
        # Check for junk functions
        if junk_func_pattern.match(line):
            skip_lines = 2
            continue
            
        clean_lines.append(line)

    with open(file_path, 'w', encoding='utf-8') as f:
        f.writelines(clean_lines)
    print(f"Cleaned: {file_path}")

def main(target_dir):
    print(f"Starting cleanup for directory: {target_dir}")
    if not os.path.exists(target_dir):
        print(f"Directory not found: {target_dir}")
        return

    for root, dirs, files in os.walk(target_dir):
        for file in files:
            if file.endswith(".swift"):
                clean_file(os.path.join(root, file))

if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        target_directory = sys.argv[1]
    else:
        target_directory = "zippy/o"
    
    main(target_directory)
