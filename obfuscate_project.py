import os
import random
import string
import re

def generate_random_string(length=10):
    letters = string.ascii_lowercase
    return ''.join(random.choice(letters) for i in range(length))

def generate_junk_func():
    junk_funcs = [
        f'\n    private func {generate_random_string()}() {{\n        print("{generate_random_string()}")\n    }}\n',
        f'\n    private func {generate_random_string()}(_ input: String) -> Bool {{\n        return input.count > {random.randint(0, 10)}\n    }}\n'
    ]
    return random.choice(junk_funcs)

def generate_junk_code():
    junk_vars = [
        f'private let {generate_random_string()} = "{generate_random_string()}"',
        f'private let {generate_random_string()} = {random.randint(0, 100)}',
        f'private var {generate_random_string()}: String? = nil'
    ]
    return random.choice(junk_vars) if random.random() > 0.5 else generate_junk_func()

def generate_junk_comment():
    comments = [
        f"// MARK: - {generate_random_string().upper()}",
        f"// TODO: check {generate_random_string()}",
        f"// optimized by {generate_random_string()}",
        f"// {generate_random_string()} logic here"
    ]
    return random.choice(comments)

def generate_junk_class():
    class_name = generate_random_string().capitalize()
    content = f"\n// MARK: - Junk Class {class_name}\n"
    content += f"class {class_name} {{\n"
    
    properties = []
    # Add properties
    for _ in range(random.randint(2, 5)):
        prop_name = generate_random_string()
        val = random.randint(0, 1000)
        content += f"    private var {prop_name}: Int = {val}\n"
        properties.append(prop_name)
        
    # Add methods
    for _ in range(random.randint(2, 4)):
        func_name = generate_random_string()
        content += f"\n    func {func_name}() {{\n"
        content += f"        print(\"{generate_random_string()}\")\n"
        if properties and random.random() > 0.5:
            target_prop = random.choice(properties)
            content += f"        self.{target_prop} = {random.randint(0, 100)}\n"
        content += f"    }}\n"
        
    content += "}\n"
    return content

def obfuscate_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    new_lines = []
    
    for line in lines:
        # Add junk comments randomly
        if random.random() < 0.1:
            new_lines.append(generate_junk_comment() + '\n')
        new_lines.append(line)

    content = "".join(lines)
    
    # 1. Add Extension for existing class (Method injection)
    class_match = re.search(r'class\s+(?!func\b|var\b)([a-zA-Z_][a-zA-Z0-9_]*)', content)
    if class_match:
        class_name = class_match.group(1)
        new_lines.append(f"\n// MARK: - Obfuscation Extension\n")
        new_lines.append(f"extension {class_name} {{\n")
        for _ in range(random.randint(2, 4)):
            new_lines.append(generate_junk_func())
        new_lines.append("}\n")

    # 2. Add completely new Junk Classes (safe noise)
    if random.random() < 0.5: # 50% chance to add a junk class per file
        new_lines.append(generate_junk_class())


    with open(file_path, 'w', encoding='utf-8') as f:
        f.writelines(new_lines)
    print(f"Obfuscated: {file_path}")

def main(target_dir):
    print(f"Starting obfuscation for directory: {target_dir}")
    if not os.path.exists(target_dir):
        print(f"Directory not found: {target_dir}")
        return

    swift_files = []
    for root, dirs, files in os.walk(target_dir):
        for file in files:
            if file.endswith(".swift"):
                swift_files.append(os.path.join(root, file))
    
    if not swift_files:
        print("No Swift files found.")
        return

    print(f"Found {len(swift_files)} Swift files. Processing...")
    
    for file_path in swift_files:
        try:
            obfuscate_file(file_path)
        except Exception as e:
            print(f"Failed to obfuscate {file_path}: {e}")

    print("Obfuscation complete.")

if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        target_directory = sys.argv[1]
    else:
        # Default to current directory if not specified, or prompt user
        target_directory = input("Enter the path to the directory (e.g. ./zippy/o): ")
    
    main(target_directory)
