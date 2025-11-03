#!/usr/bin/env python3
"""
批量修复 go_router 导入脚本
这个脚本会自动为所有使用 context.push 的文件添加 go_router 导入
"""

import os
import re

def fix_go_router_imports(file_path):
    """为单个文件添加 go_router 导入"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # 检查是否已经导入了 go_router
        if "import 'package:go_router/go_router.dart';" in content:
            return False

        # 检查是否使用了 context.push
        if "context.push" in content:
            # 找到第一个 import 语句之后的位置
            import_pattern = r'(import\s+.*?;\s*\n)'
            imports = re.findall(import_pattern, content)

            if imports:
                # 在最后一个 import 语句后添加 go_router 导入
                last_import = imports[-1]
                new_content = content.replace(last_import, last_import + "import 'package:go_router/go_router.dart';\n")

                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(new_content)

                print(f"Fixed: {file_path}")
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
                if fix_go_router_imports(file_path):
                    fixed_count += 1

    print(f"\nSuccess! Fixed {fixed_count} files")

if __name__ == "__main__":
    main()