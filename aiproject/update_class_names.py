#!/usr/bin/env python3
"""
更新页面类名脚本
为所有页面类名添加"Page"后缀
"""

import os
import re
from pathlib import Path

# 项目根目录
PROJECT_ROOT = Path(__file__).parent

# 路由文件路径
ROUTER_FILE = PROJECT_ROOT / "lib" / "routing" / "app_router.dart"

def extract_page_classes_from_router():
    """从路由文件中提取所有页面类名"""
    with open(ROUTER_FILE, 'r', encoding='utf-8') as f:
        content = f.read()

    # 提取路由定义中的类名
    route_pattern = r"case\s+'[^']+':\s*return\s+[^(]+\(const\s+(\w+)\(\)\)"
    route_matches = re.findall(route_pattern, content)

    # 匹配带参数的路由
    param_route_pattern = r"case\s+'[^']+':\s*\w+\s+args\s*=.*?return\s+[^(]+\((\w+)\("
    param_matches = re.findall(param_route_pattern, content, re.DOTALL)

    # 合并所有类名
    all_class_names = set(route_matches + param_matches)

    return all_class_names

def update_class_in_file(file_path, old_class, new_class):
    """在文件中更新类名"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # 替换类定义
    content = re.sub(rf'class\s+{old_class}\s+extends\s+(StatefulWidget|StatelessWidget)',
                    f'class {new_class} extends \\1', content)

    # 替换State类
    content = re.sub(rf'class\s+_{old_class}\s+extends\s+State<{old_class}>',
                    f'class _{new_class} extends State<{new_class}>', content)

    # 替换createState方法
    content = re.sub(rf'State<{old_class}>\s+createState\(\)\s*=>\s*_{old_class}\(\)',
                    f'State<{new_class}> createState() => _{new_class}()', content)

    # 写回文件
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)

    return content

def find_file_for_class(class_name):
    """为类名找到对应的文件"""
    # 搜索所有页面文件
    page_files = []
    screens_dir = PROJECT_ROOT / "lib" / "screens"

    for dart_file in screens_dir.rglob("*.dart"):
        # 排除widgets目录
        if "widgets" in str(dart_file):
            continue
        page_files.append(dart_file)

    # 在文件中查找类名
    for file_path in page_files:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        if f"class {class_name}" in content:
            return file_path

    return None

def main():
    print("开始更新页面类名...")

    # 提取所有页面类名
    class_names = extract_page_classes_from_router()

    print(f"找到 {len(class_names)} 个页面类:")
    for cls in sorted(class_names):
        print(f"  - {cls}")

    # 更新每个类名
    updated_count = 0
    for old_class in class_names:
        # 如果类名已经以Page结尾，跳过
        if old_class.endswith('Page'):
            print(f"跳过 {old_class} (已包含Page后缀)")
            continue

        new_class = old_class + "Page"

        # 找到对应的文件
        file_path = find_file_for_class(old_class)
        if file_path:
            print(f"更新 {old_class} -> {new_class} 在 {file_path.name}")
            update_class_in_file(file_path, old_class, new_class)
            updated_count += 1
        else:
            print(f"警告: 未找到类 {old_class} 对应的文件")

    print(f"\n✅ 类名更新完成！共更新了 {updated_count} 个类名")

if __name__ == "__main__":
    main()