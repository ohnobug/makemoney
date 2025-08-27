import os
import re
import sys

# ==============================================================================
# 颜色映射表
# KEY: (A, R, G, B) 元组
# VALUE: "AppColors.常量名" 字符串
# ==============================================================================
COLOR_MAP = {
    (255, 160, 236, 112): "AppColors.brandGreenLightest",
    (255, 158, 236, 114): "AppColors.brandGreenLighter",
    (255, 110, 216, 163): "AppColors.brandGreenLight",
    (255, 104, 199, 145): "AppColors.brandGreenSlightlyLighter",
    (255, 76, 190, 102): "AppColors.brandGreenVibrant1",
    (255, 75, 190, 97): "AppColors.brandGreenVibrant2",
    (255, 74, 193, 99): "AppColors.brandGreenVibrant3",
    (255, 63, 198, 94): "AppColors.brandGreenVibrant4",
    (255, 52, 192, 95): "AppColors.brandGreenVibrant5",
    (255, 7, 192, 103): "AppColors.brandGreenVibrant6",
    (255, 5, 190, 94): "AppColors.brandGreenVibrant7",
    (255, 0, 213, 106): "AppColors.brandGreenVibrantDeep1",
    (255, 0, 198, 106): "AppColors.brandGreenVibrantDeep2",
    (255, 83, 175, 105): "AppColors.brandGreenPrimary",
    (255, 77, 174, 107): "AppColors.brandGreenSlightlyDesaturated",
    (255, 69, 182, 87): "AppColors.brandGreenDarker1",
    (255, 65, 183, 88): "AppColors.brandGreenDarker2",
    (255, 49, 176, 78): "AppColors.brandGreenDarker3",
    (255, 67, 157, 95): "AppColors.brandGreenDarkest",
    (255, 178, 176, 200): "AppColors.brandBlueGreyLight",
    (255, 121, 115, 149): "AppColors.brandPurpleGrey",
    (255, 89, 108, 140): "AppColors.brandBluePrimary",
    (255, 81, 94, 132): "AppColors.brandBlueDark1",
    (255, 78, 96, 146): "AppColors.brandBlueDark2",
    (255, 65, 82, 120): "AppColors.brandBlueDark3",
    (255, 58, 81, 124): "AppColors.brandBlueDark4",
    (255, 53, 76, 111): "AppColors.brandBlueDark5",
    (255, 53, 74, 113): "AppColors.brandBlueDark6",
    (255, 48, 61, 88): "AppColors.brandBlueDark7",
    (255, 81, 88, 135): "AppColors.brandPurpleDark1",
    (255, 65, 73, 117): "AppColors.brandPurpleDark2",
    (255, 64, 69, 118): "AppColors.brandPurpleDark3",
    (255, 64, 67, 101): "AppColors.brandPurpleDark4",
    (255, 50, 48, 70): "AppColors.brandPurpleDark5",
    (255, 233, 248, 243): "AppColors.brandTealBackground1",
    (255, 232, 249, 241): "AppColors.brandTealBackground2",
    (255, 24, 237, 201): "AppColors.brandTealVibrant",
    (255, 156, 215, 179): "AppColors.brandTealMedium",
    (255, 60, 182, 118): "AppColors.brandTealDark1",
    (255, 56, 179, 114): "AppColors.brandTealDark2",
    (255, 42, 172, 102): "AppColors.brandTealDark3",
    (255, 255, 0, 0): "AppColors.accentRedPure",
    (255, 254, 61, 83): "AppColors.accentRedVibrant1",
    (255, 252, 0, 0): "AppColors.accentRedVibrant2",
    (255, 247, 19, 19): "AppColors.accentRedDark1",
    (255, 231, 15, 15): "AppColors.accentRedDark2",
    (255, 221, 76, 76): "AppColors.accentRedDark3",
    (255, 217, 79, 77): "AppColors.accentRedDark4",
    (255, 255, 161, 79): "AppColors.accentOrange",
    (255, 249, 136, 39): "AppColors.accentOrangeDark",
    (255, 251, 193, 30): "AppColors.accentYellow",
    (255, 248, 195, 57): "AppColors.accentYellowDark1",
    (255, 247, 171, 66): "AppColors.accentYellowDark2",
    (255, 244, 197, 58): "AppColors.accentYellowDark3",
    (255, 242, 191, 46): "AppColors.accentYellowDark4",
    (255, 255, 255, 255): "AppColors.neutralWhite",
    (255, 255, 250, 231): "AppColors.neutralOffWhiteYellow",
    (255, 253, 245, 242): "AppColors.neutralOffWhitePink",
    (255, 248, 248, 248): "AppColors.neutralGrey1",
    (255, 247, 247, 247): "AppColors.neutralGrey2",
    (255, 246, 246, 246): "AppColors.neutralGrey3",
    (255, 245, 245, 245): "AppColors.neutralGrey4",
    (255, 243, 243, 243): "AppColors.neutralGrey5",
    (255, 242, 242, 242): "AppColors.neutralGrey6",
    (255, 241, 241, 241): "AppColors.neutralGrey7",
    (255, 240, 240, 240): "AppColors.neutralGrey8",
    (255, 239, 239, 239): "AppColors.neutralGrey9",
    (255, 238, 236, 237): "AppColors.neutralGrey10",
    (255, 237, 237, 237): "AppColors.neutralGrey11",
    (255, 236, 236, 236): "AppColors.neutralGrey12",
    (255, 235, 235, 235): "AppColors.neutralGrey13",
    (255, 233, 234, 236): "AppColors.neutralGrey14",
    (255, 232, 232, 232): "AppColors.neutralGrey15",
    (255, 231, 231, 231): "AppColors.neutralGrey16",
    (255, 230, 230, 230): "AppColors.neutralGrey17",
    (255, 229, 229, 229): "AppColors.neutralGrey18",
    (255, 228, 228, 228): "AppColors.neutralGrey19",
    (255, 227, 227, 227): "AppColors.neutralGrey20",
    (255, 226, 226, 226): "AppColors.neutralGrey21",
    (255, 224, 220, 221): "AppColors.neutralGrey22",
    (255, 223, 223, 23): "AppColors.neutralGrey23",
    (255, 222, 222, 222): "AppColors.neutralGrey24",
    (255, 220, 220, 220): "AppColors.neutralGrey25",
    (255, 219, 219, 219): "AppColors.neutralGrey26",
    (255, 218, 218, 218): "AppColors.neutralGrey27",
    (255, 217, 225, 231): "AppColors.neutralGrey28",
    (255, 217, 220, 224): "AppColors.neutralGrey29",
    (255, 216, 214, 215): "AppColors.neutralGrey30",
    (255, 215, 215, 215): "AppColors.neutralGrey31",
    (255, 212, 212, 212): "AppColors.neutralGrey32",
    (255, 210, 210, 210): "AppColors.neutralGrey33",
    (255, 202, 202, 202): "AppColors.neutralGrey34",
    (255, 193, 193, 193): "AppColors.neutralGrey35",
    (255, 184, 184, 184): "AppColors.neutralGrey36",
    (255, 182, 182, 182): "AppColors.neutralGrey37",
    (255, 181, 181, 181): "AppColors.neutralGrey38",
    (255, 180, 180, 180): "AppColors.neutralGrey39",
    (255, 177, 177, 177): "AppColors.neutralGrey40",
    (255, 176, 176, 176): "AppColors.neutralGrey41",
    (255, 175, 175, 175): "AppColors.neutralGrey42",
    (255, 173, 173, 173): "AppColors.neutralGrey43",
    (255, 172, 172, 172): "AppColors.neutralGrey44",
    (255, 170, 170, 170): "AppColors.neutralGrey45",
    (255, 169, 169, 169): "AppColors.neutralGrey46",
    (255, 166, 166, 166): "AppColors.neutralGrey47",
    (255, 166, 164, 165): "AppColors.neutralGrey48",
    (255, 165, 165, 165): "AppColors.neutralGrey49",
    (255, 164, 164, 164): "AppColors.neutralGrey50",
    (255, 162, 162, 162): "AppColors.neutralGrey51",
    (255, 161, 161, 161): "AppColors.neutralGrey52",
    (255, 159, 159, 159): "AppColors.neutralGrey53",
    (255, 157, 161, 162): "AppColors.neutralGrey54",
    (255, 157, 157, 157): "AppColors.neutralGrey55",
    (255, 157, 143, 145): "AppColors.neutralGrey56",
    (255, 156, 156, 156): "AppColors.neutralGrey57",
    (255, 155, 155, 155): "AppColors.neutralGrey58",
    (255, 150, 150, 150): "AppColors.neutralGrey59",
    (255, 149, 149, 149): "AppColors.neutralGrey60",
    (255, 147, 147, 147): "AppColors.neutralGrey61",
    (255, 143, 143, 143): "AppColors.neutralGrey62",
    (255, 141, 143, 142): "AppColors.neutralGrey63",
    (255, 139, 139, 139): "AppColors.neutralGrey64",
    (255, 134, 134, 134): "AppColors.neutralGrey65",
    (255, 130, 130, 130): "AppColors.neutralGrey66",
    (255, 125, 125, 125): "AppColors.neutralGrey67",
    (255, 116, 116, 116): "AppColors.neutralGrey68",
    (255, 114, 114, 114): "AppColors.neutralGrey69",
    (255, 113, 113, 113): "AppColors.neutralGrey70",
    (255, 111, 111, 111): "AppColors.neutralGrey71",
    (255, 110, 110, 110): "AppColors.neutralGrey72",
    (255, 108, 108, 108): "AppColors.neutralGrey73",
    (255, 106, 102, 83): "AppColors.neutralGrey74",
    (255, 105, 105, 105): "AppColors.neutralGrey75",
    (255, 103, 103, 103): "AppColors.neutralGrey76",
    (255, 101, 101, 101): "AppColors.neutralGrey77",
    (255, 100, 100, 100): "AppColors.neutralGrey78",
    (255, 99, 99, 99): "AppColors.neutralDarkGrey1",
    (255, 96, 96, 96): "AppColors.neutralDarkGrey2",
    (255, 93, 93, 93): "AppColors.neutralDarkGrey3",
    (255, 92, 92, 92): "AppColors.neutralDarkGrey4",
    (255, 87, 87, 87): "AppColors.neutralDarkGrey5",
    (255, 85, 85, 85): "AppColors.neutralDarkGrey6",
    (255, 83, 83, 83): "AppColors.neutralDarkGrey7",
    (255, 82, 83, 108): "AppColors.neutralDarkGrey8",
    (255, 81, 81, 81): "AppColors.neutralDarkGrey9",
    (255, 80, 80, 80): "AppColors.neutralDarkGrey10",
    (255, 79, 79, 79): "AppColors.neutralDarkGrey11",
    (255, 76, 76, 76): "AppColors.neutralDarkGrey12",
    (255, 74, 74, 74): "AppColors.neutralDarkGrey13",
    (255, 69, 75, 83): "AppColors.neutralDarkGrey14",
    (255, 68, 68, 68): "AppColors.neutralDarkGrey15",
    (255, 64, 64, 64): "AppColors.neutralDarkGrey16",
    (255, 60, 60, 60): "AppColors.neutralDarkGrey17",
    (255, 48, 48, 48): "AppColors.neutralDarkGrey18",
    (255, 41, 41, 41): "AppColors.neutralDarkGrey19",
    (255, 33, 33, 33): "AppColors.neutralDarkGrey20",
    (255, 25, 25, 25): "AppColors.neutralNearBlack1",
    (255, 22, 22, 20): "AppColors.neutralNearBlack2",
    (255, 20, 20, 20): "AppColors.neutralNearBlack3",
    (255, 16, 16, 16): "AppColors.neutralNearBlack4",
    (255, 13, 13, 11): "AppColors.neutralNearBlack5",
    (255, 0, 0, 0): "AppColors.neutralBlack",
    (237, 255, 255, 255): "AppColors.whiteTransparent93",
    (160, 255, 255, 255): "AppColors.whiteTransparent63",
    (150, 240, 240, 240): "AppColors.greyTransparent59",
    (83, 238, 238, 238): "AppColors.greyTransparent33",
    (80, 230, 230, 230): "AppColors.greyTransparent31",
    (38, 134, 134, 134): "AppColors.greyTransparent15",
    (222, 0, 0, 0): "AppColors.blackTransparent87",
    (185, 0, 0, 0): "AppColors.blackTransparent73",
    (162, 0, 0, 0): "AppColors.blackTransparent64",
    (127, 0, 0, 0): "AppColors.blackTransparent50",
    (120, 0, 0, 0): "AppColors.blackTransparent47",
    (115, 0, 0, 0): "AppColors.blackTransparent45",
    (105, 0, 0, 0): "AppColors.blackTransparent41",
    (102, 0, 0, 0): "AppColors.blackTransparent40",
    (71, 0, 0, 0): "AppColors.blackTransparent28",
    (193, 247, 0, 0): "AppColors.redTransparent76",
    (183, 192, 66, 66): "AppColors.redTransparent72",
    (179, 76, 190, 103): "AppColors.greenTransparent70",
    (193, 0, 1, 63): "AppColors.navyBlueTransparent76",
    (164, 0, 15, 44): "AppColors.navyBlueTransparent64",
    (0, 0, 0, 0): "AppColors.transparent",
    (0, 255, 0, 0): "AppColors.transparentRed"
}

# 用于查找 Color.fromARGB(...) 的正则表达式
COLOR_REGEX = re.compile(r"Color\.fromARGB\((\d+),\s*(\d+),\s*(\d+),\s*(\d+)\)")

def replacer_func(match):
    """
    这是一个 re.sub 的替换函数。
    它会接收一个匹配对象，并返回 AppColors 常量或原始字符串。
    """
    try:
        a, r, g, b = map(int, match.groups())
        color_tuple = (a, r, g, b)
        
        # 在映射表中查找颜色
        if color_tuple in COLOR_MAP:
            return COLOR_MAP[color_tuple]
        else:
            # 如果找不到，保持原样，并打印一个警告
            print(f"  [!] 未找到映射: {match.group(0)}")
            return match.group(0)
    except (ValueError, IndexError):
        # 如果解析失败，保持原样
        return match.group(0)

def process_file(file_path):
    """
    读取文件，执行替换，并写回文件（如果内容有变）。
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"  [Error] 无法读取文件 {file_path}: {e}")
        return False

    new_content = COLOR_REGEX.sub(replacer_func, content)
    
    if new_content != content:
        print(f"  [*] 正在重构: {file_path}")
        try:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(new_content)
            return True
        except Exception as e:
            print(f"  [Error] 无法写入文件 {file_path}: {e}")
            return False
    return False

def main():
    """
    主函数，遍历 'lib' 目录并处理所有 .dart 文件。
    """
    script_dir = os.path.dirname(os.path.realpath(__file__))
    lib_directory = os.path.join(script_dir, 'lib')
    
    if not os.path.isdir(lib_directory):
        print(f"错误: 'lib' 目录未在 {script_dir} 中找到。")
        print("请将此脚本放在 Flutter 项目的根目录下运行。")
        sys.exit(1)
        
    print("="*50)
    print("开始扫描 'lib' 目录下的 .dart 文件...")
    print("="*50)

    processed_files = 0
    modified_files = 0

    for dirpath, _, filenames in os.walk(lib_directory):
        for filename in filenames:
            if filename.endswith('.dart'):
                file_path = os.path.join(dirpath, filename)
                processed_files += 1
                if process_file(file_path):
                    modified_files += 1

    print("\n" + "="*50)
    print("扫描完成！")
    print(f"总共处理文件: {processed_files}")
    print(f"成功修改文件: {modified_files}")
    print("="*50)
    print("\n建议现在运行 'flutter analyze' 和检查您的应用，确保一切正常。")

if __name__ == "__main__":
    main()