#!/usr/bin/env python3
"""
批量修复 arguments 到 extra 的脚本
这个脚本会自动将 context.push 中的 arguments 参数改为 extra
"""

import os
import re

def fix_arguments_to_extra(file_path):
    """将单个文件中的 arguments 改为 extra"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # 查找并替换 context.push 中的 arguments 为 extra
        pattern = r'context\.push\([^)]*?arguments:\s*'
        replacement = 'context.push( extra: '

        new_content = re.sub(pattern, replacement, content)

        if new_content != content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"Fixed arguments in: {file_path}")
            return True

        return False

    except Exception as e:
        print(f"Error fixing: {file_path} - {e}")
        return False

def main():
    lib_dir = "lib"
    fixed_count = 0

    for root, dirs, files in os.walk(lib_dir):
        for file in files:
            if file.endswith('.dart'):
                file_path = os.path.join(root, file)
                if fix_arguments_to_extra(file_path):
                    fixed_count += 1

    print(f"\nSuccess! Fixed {fixed_count} files")

if __name__ == "__main__":
    main()