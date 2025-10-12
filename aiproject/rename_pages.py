#!/usr/bin/env python3
"""
页面重命名脚本
用于为Flutter项目中的所有页面类名添加"Page"后缀，文件名添加"_page"后缀
基于路由文件中的导入来确定哪些是页面
"""

import os
import re
from pathlib import Path

# 项目根目录
PROJECT_ROOT = Path(__file__).parent

# 路由文件路径
ROUTER_FILE = PROJECT_ROOT / "lib" / "routing" / "app_router.dart"

def extract_page_info_from_router():
    """从路由文件中提取所有页面信息和类名"""
    with open(ROUTER_FILE, 'r', encoding='utf-8') as f:
        content = f.read()

    page_info = []

    # 1. 提取所有import语句
    import_pattern = r"import\s+'package:vigaviga/([^']+)\.dart'"
    imports = re.findall(import_pattern, content)

    # 2. 提取路由定义中的类名
    # 匹配路由定义中的类实例化
    route_pattern = r"case\s+'[^']+':\s*return\s+[^(]+\(const\s+(\w+)\(\)\)"
    route_matches = re.findall(route_pattern, content)

    # 3. 匹配带参数的路由
    param_route_pattern = r"case\s+'[^']+':\s*\w+\s+args\s*=.*?return\s+[^(]+\((\w+)\("
    param_matches = re.findall(param_route_pattern, content, re.DOTALL)

    # 合并所有类名
    all_class_names = set(route_matches + param_matches)

    # 4. 为每个类名找到对应的文件路径
    for class_name in all_class_names:
        # 如果类名已经以Page结尾，跳过
        if class_name.endswith('Page'):
            continue

        # 在imports中查找对应的文件
        for imp in imports:
            # 从文件路径中提取文件名（去掉路径，只取文件名部分）
            file_name = imp.split('/')[-1]

            # 检查这个文件是否包含这个类名
            file_path = PROJECT_ROOT / "lib" / f"{imp}.dart"
            if file_path.exists():
                with open(file_path, 'r', encoding='utf-8') as f:
                    file_content = f.read()

                # 检查文件中是否包含这个类定义
                if f"class {class_name}" in file_content:
                    page_info.append({
                        'class_name': class_name,
                        'file_path': file_path,
                        'file_name': file_name
                    })
                    break

    return page_info

def generate_rename_plan():
    """生成重命名计划"""
    page_info = extract_page_info_from_router()
    rename_plan = []

    for info in page_info:
        class_name = info['class_name']
        file_path = info['file_path']
        file_name = info['file_name']

        # 如果类名已经以Page结尾，跳过
        if class_name.endswith('Page'):
            continue

        # 生成新的类名和文件名
        new_class_name = class_name + "Page"

        # 如果文件名已经以_page结尾，保持原样，否则添加_page
        if file_name.endswith('_page.dart'):
            new_file_name = file_name
            new_file_path = file_path
        else:
            new_file_name = file_name.replace('.dart', '_page.dart')
            new_file_path = file_path.parent / new_file_name

        rename_plan.append({
            'old_file': file_path,
            'new_file': new_file_path,
            'old_class': class_name,
            'new_class': new_class_name
        })

    return rename_plan

def print_rename_plan(rename_plan):
    """打印重命名计划"""
    print("重命名计划:")
    print("=" * 80)
    for i, plan in enumerate(rename_plan, 1):
        print(f"{i}. {plan['old_file'].name} -> {plan['new_file'].name}")
        print(f"   类名: {plan['old_class']} -> {plan['new_class']}")
        print()

def execute_rename(rename_plan):
    """执行重命名操作"""
    for plan in rename_plan:
        old_file = plan['old_file']
        new_file = plan['new_file']
        old_class = plan['old_class']
        new_class = plan['new_class']

        # 读取文件内容
        with open(old_file, 'r', encoding='utf-8') as f:
            content = f.read()

        # 替换类名
        # 替换类定义
        content = re.sub(rf'class\s+{old_class}\s+extends\s+(StatefulWidget|StatelessWidget)',
                        f'class {new_class} extends \\1', content)

        # 替换State类
        content = re.sub(rf'class\s+_{old_class}\s+extends\s+State<{old_class}>',
                        f'class _{new_class} extends State<{new_class}>', content)

        # 替换createState方法
        content = re.sub(rf'State<{old_class}>\s+createState\(\)\s*=>\s*_{old_class}\(\)',
                        f'State<{new_class}> createState() => _{new_class}()', content)

        # 如果文件名需要改变，写入新文件并删除旧文件
        if old_file != new_file:
            # 写入新文件
            with open(new_file, 'w', encoding='utf-8') as f:
                f.write(content)

            # 删除旧文件
            old_file.unlink()
            print(f"✓ 重命名完成: {old_file.name} -> {new_file.name}")
        else:
            # 只更新文件内容
            with open(old_file, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"✓ 类名更新完成: {old_file.name} ({old_class} -> {new_class})")

def update_router_file(rename_plan):
    """更新路由文件中的引用"""
    with open(ROUTER_FILE, 'r', encoding='utf-8') as f:
        content = f.read()

    for plan in rename_plan:
        old_class = plan['old_class']
        new_class = plan['new_class']

        # 替换路由文件中的类引用
        content = re.sub(rf'\b{old_class}\b\(\)', f'{new_class}()', content)

        # 如果文件名改变了，更新import语句
        if plan['old_file'] != plan['new_file']:
            old_file_name = plan['old_file'].name
            new_file_name = plan['new_file'].name
            content = content.replace(old_file_name, new_file_name)

    # 写回文件
    with open(ROUTER_FILE, 'w', encoding='utf-8') as f:
        f.write(content)

    print("✓ 路由文件更新完成")

def main():
    print("开始分析页面重命名...")

    # 生成重命名计划
    rename_plan = generate_rename_plan()

    if not rename_plan:
        print("没有需要重命名的页面")
        return

    # 显示重命名计划
    print_rename_plan(rename_plan)

    # 确认执行
    confirm = input("\n确认执行重命名？(y/N): ").strip().lower()
    if confirm != 'y':
        print("取消重命名")
        return

    # 执行重命名
    print("\n开始执行重命名...")
    execute_rename(rename_plan)

    # 更新路由文件
    print("\n更新路由文件...")
    update_router_file(rename_plan)

    print("\n✅ 所有页面重命名完成！")

if __name__ == "__main__":
    main()