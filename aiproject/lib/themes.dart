import 'package:flutter/material.dart';

/// 应用的全局颜色配置
/// (已根据“活力鲜橙”主题进行专业调整)
class AppColors {
  // ===========================================================================
  // 核心品牌色 (橙色系)
  // Core Brand Colors (Oranges) - Replaced Greens
  // ===========================================================================

  static const Color brandGreenLightest = Color(0xFFFFF4E0); // 极浅的橙色，用于高亮背景
  static const Color brandGreenLighter = Color(0xFFFFE0B2); // 较浅的橙色
  static const Color brandGreenLight = Color(0xFFFFCC80); // 明亮的橙色
  static const Color brandGreenSlightlyLighter = Color(0xFFFFB74D); // 略亮的橙色
  static const Color brandGreenVibrant1 = Color(0xFFFFA726); // 活力橙 1 (果肉)
  static const Color brandGreenVibrant2 = Color(0xFFFF9800); // 活力橙 2
  static const Color brandGreenVibrant3 = Color(0xFFFB8C00); // 活力橙 3
  static const Color brandGreenVibrant4 = Color(0xFFF57C00); // 活力橙 4
  static const Color brandGreenVibrant5 = Color(0xFFEF6C00); // 活力橙 5 (主色调)
  static const Color brandGreenVibrant6 = Color(0xFFE65100); // 活力橙 6
  static const Color brandGreenVibrant7 = Color(0xFFD84315); // 活力橙 7 (偏红)
  static const Color brandGreenVibrantDeep1 = Color(0xFFBF360C); // 深活力橙 1
  static const Color brandGreenVibrantDeep2 = Color(0xFFD84315); // 深活力橙 2
  static const Color brandGreenPrimary = Color(0xFFF57C00); // 品牌主橙色 (取自果皮)
  static const Color brandGreenSlightlyDesaturated =
      Color(0xFFE57A27); // 略微去饱和的橙
  static const Color brandGreenDarker1 = Color(0xFFE65100); // 较深的橙色 1
  static const Color brandGreenDarker2 = Color(0xFFD84315); // 较深的橙色 2
  static const Color brandGreenDarker3 = Color(0xFFBF360C); // 较深的橙色 3
  static const Color brandGreenDarker4 = Color(0xFFA9310A); // 较深的橙色 4
  static const Color brandGreenDarkest = Color(0xFF8C2807); // 最深的橙色 (用于阴影)

  // ===========================================================================
  // 品牌色 (蓝/灰色系 - 作为辅助色)
  // Brand Colors (Blues & Grays - As Accent)
  // ===========================================================================

  static const Color brandBlueGreyLight = Color(0xFFB0BEC5); // 浅灰蓝
  static const Color brandPurpleGrey = Color(0xFF78909C); // 中灰蓝
  static const Color brandBluePrimary = Color(0xFF607D8B); // 主灰蓝
  static const Color brandBlueDark1 = Color(0xFF546E7A); // 深灰蓝 1
  static const Color brandBlueDark2 = Color(0xFF455A64); // 深灰蓝 2
  static const Color brandBlueDark3 = Color(0xFF37474F); // 深灰蓝 3
  static const Color brandBlueDark4 = Color(0xFF263238); // 深灰蓝 4
  static const Color brandBlueDark5 = Color(0xFF1B2428); // 深灰蓝 5
  static const Color brandBlueDark6 = Color(0xFF263238); // (同4)
  static const Color brandBlueDark7 = Color(0xFF1E282C); // (近似5)
  static const Color brandPurpleDark1 = Color(0xFF546E7A); // (同深灰蓝1)
  static const Color brandPurpleDark2 = Color(0xFF455A64); // (同深灰蓝2)
  static const Color brandPurpleDark3 = Color(0xFF37474F); // (同深灰蓝3)
  static const Color brandPurpleDark4 = Color(0xFF263238); // (同深灰蓝4)
  static const Color brandPurpleDark5 = Color(0xFF1A2124); // (最深)

  // ===========================================================================
  // 品牌色 (大地色系)
  // Brand Colors (Earth Tones) - Replaced Teals
  // ===========================================================================

  static const Color brandTealBackground1 = Color(0xFFF5F1E9); // 极浅的暖沙色背景
  static const Color brandTealBackground2 = Color(0xFFF3EFE6); // (近似1)
  static const Color brandTealVibrant = Color(0xFFE2C5A6); // 活力的沙色
  static const Color brandTealMedium = Color(0xFFC4A98A); // 中等沙色
  static const Color brandTealDark1 = Color(0xFFA1887F); // 暖褐色 1
  static const Color brandTealDark2 = Color(0xFF8D6E63); // 暖褐色 2
  static const Color brandTealDark3 = Color(0xFF795548); // 暖褐色 3 (最深)

  // ===========================================================================
  // 功能/强调色 (红/橙/黄色系)
  // Functional/Accent Colors (Reds, Oranges, Yellows)
  // ===========================================================================

  static const Color accentRedPure =
      Color.fromARGB(255, 255, 0, 0); // 纯红保留，用于特殊场景
  static const Color accentRedVibrant1 = Color(0xFFEF5350); // 活力的红色 (警示)
  static const Color accentRedVibrant2 = Color(0xFFE53935); // (近似1)
  static const Color accentRedDark1 = Color(0xFFD32F2F); // 深红色 1
  static const Color accentRedDark2 = Color(0xFFC62828); // 深红色 2
  static const Color accentRedDark3 = Color(0xFFB71C1C); // 深红色 3
  static const Color accentRedDark4 = Color(0xFFD50000); // (近似)
  static const Color accentOrange = Color(0xFFFFB300); // 强调橙色 (取自果肉高光)
  static const Color accentOrangeDark = Color(0xFFFF8F00); // 深强调橙
  static const Color accentYellow = Color(0xFFFFCA28); // 强调黄色
  static const Color accentYellowDark1 = Color(0xFFFFC107); // 深强调黄 1
  static const Color accentYellowDark2 = Color(0xFFFFB300); // 深强调黄 2
  static const Color accentYellowDark3 = Color(0xFFFFA000); // 深强调黄 3
  static const Color accentYellowDark4 = Color(0xFFFF8F00); // 深强调黄 4

  // ===========================================================================
  // 中性色 (白色和浅灰色系)
  // Neutrals (Whites & Light Grays)
  // ===========================================================================

  static const Color neutralWhite = Color.fromARGB(255, 255, 255, 255);
  static const Color neutralOffWhiteYellow = Color(0xFFFFF8E1); // 暖调米白 (源于橙皮内侧)
  static const Color neutralOffWhitePink = Color(0xFFFFF3E0); // (近似)
  static const Color neutralGrey1 = Color.fromARGB(255, 248, 248, 248);
  static const Color neutralGrey2 = Color.fromARGB(255, 247, 247, 247);
  static const Color neutralGrey3 = Color.fromARGB(255, 246, 246, 246);
  static const Color neutralGrey4 = Color.fromARGB(255, 245, 245, 245);
  static const Color neutralGrey5 = Color.fromARGB(255, 243, 243, 243);
  static const Color neutralGrey6 = Color.fromARGB(255, 242, 242, 242);
  static const Color neutralGrey7 = Color.fromARGB(255, 241, 241, 241);
  static const Color neutralGrey8 = Color.fromARGB(255, 240, 240, 240);
  static const Color neutralGrey9 = Color.fromARGB(255, 239, 239, 239);
  static const Color neutralGrey10 = Color.fromARGB(255, 238, 236, 237);
  static const Color neutralGrey11 = Color.fromARGB(255, 237, 237, 237);
  static const Color neutralGrey12 = Color.fromARGB(255, 236, 236, 236);
  static const Color neutralGrey13 = Color.fromARGB(255, 235, 235, 235);
  static const Color neutralGrey14 = Color.fromARGB(255, 233, 234, 236);
  static const Color neutralGrey15 = Color.fromARGB(255, 232, 232, 232);
  static const Color neutralGrey16 = Color.fromARGB(255, 231, 231, 231);
  static const Color neutralGrey17 = Color.fromARGB(255, 230, 230, 230);
  static const Color neutralGrey18 = Color.fromARGB(255, 229, 229, 229);
  static const Color neutralGrey19 = Color.fromARGB(255, 228, 228, 228);
  static const Color neutralGrey20 = Color.fromARGB(255, 227, 227, 227);
  static const Color neutralGrey21 = Color.fromARGB(255, 226, 226, 226);
  static const Color neutralGrey22 = Color.fromARGB(255, 224, 220, 221);
  static const Color neutralGrey23 = Color.fromARGB(255, 223, 223, 223);
  static const Color neutralGrey24 = Color.fromARGB(255, 222, 222, 222);
  static const Color neutralGrey25 = Color.fromARGB(255, 220, 220, 220);
  static const Color neutralGrey26 = Color.fromARGB(255, 219, 219, 219);
  static const Color neutralGrey27 = Color.fromARGB(255, 218, 218, 218);
  static const Color neutralGrey28 = Color.fromARGB(255, 217, 225, 231);
  static const Color neutralGrey29 = Color.fromARGB(255, 217, 220, 224);
  static const Color neutralGrey30 = Color.fromARGB(255, 216, 214, 215);
  static const Color neutralGrey31 = Color.fromARGB(255, 215, 215, 215);
  static const Color neutralGrey32 = Color.fromARGB(255, 212, 212, 212);
  static const Color neutralGrey33 = Color.fromARGB(255, 210, 210, 210);
  static const Color neutralGrey34 = Color.fromARGB(255, 202, 202, 202);

  // ===========================================================================
  // 中性色 (中灰色系)
  // Neutrals (Mid Grays)
  // ===========================================================================

  static const Color neutralGrey35 = Color.fromARGB(255, 193, 193, 193);
  static const Color neutralGrey36 = Color.fromARGB(255, 184, 184, 184);
  static const Color neutralGrey37 = Color.fromARGB(255, 182, 182, 182);
  static const Color neutralGrey38 = Color.fromARGB(255, 181, 181, 181);
  static const Color neutralGrey39 = Color.fromARGB(255, 180, 180, 180);
  static const Color neutralGrey40 = Color.fromARGB(255, 177, 177, 177);
  static const Color neutralGrey41 = Color.fromARGB(255, 176, 176, 176);
  static const Color neutralGrey42 = Color.fromARGB(255, 175, 175, 175);
  static const Color neutralGrey43 = Color.fromARGB(255, 173, 173, 173);
  static const Color neutralGrey44 = Color.fromARGB(255, 172, 172, 172);
  static const Color neutralGrey45 = Color.fromARGB(255, 170, 170, 170);
  static const Color neutralGrey46 = Color.fromARGB(255, 169, 169, 169);
  static const Color neutralGrey47 = Color.fromARGB(255, 166, 166, 166);
  static const Color neutralGrey48 = Color.fromARGB(255, 166, 164, 165);
  static const Color neutralGrey49 = Color.fromARGB(255, 165, 165, 165);
  static const Color neutralGrey50 = Color.fromARGB(255, 164, 164, 164);
  static const Color neutralGrey51 = Color.fromARGB(255, 162, 162, 162);
  static const Color neutralGrey52 = Color.fromARGB(255, 161, 161, 161);
  static const Color neutralGrey53 = Color.fromARGB(255, 159, 159, 159);
  static const Color neutralGrey54 = Color.fromARGB(255, 157, 161, 162);
  static const Color neutralGrey55 = Color.fromARGB(255, 157, 157, 157);
  static const Color neutralGrey56 = Color.fromARGB(255, 157, 143, 145);
  static const Color neutralGrey57 = Color.fromARGB(255, 156, 156, 156);
  static const Color neutralGrey58 = Color.fromARGB(255, 155, 155, 155);
  static const Color neutralGrey59 = Color.fromARGB(255, 150, 150, 150);
  static const Color neutralGrey60 = Color.fromARGB(255, 149, 149, 149);
  static const Color neutralGrey61 = Color.fromARGB(255, 147, 147, 147);
  static const Color neutralGrey62 = Color.fromARGB(255, 143, 143, 143);
  static const Color neutralGrey63 = Color.fromARGB(255, 141, 143, 142);
  static const Color neutralGrey64 = Color.fromARGB(255, 139, 139, 139);
  static const Color neutralGrey65 = Color.fromARGB(255, 134, 134, 134);
  static const Color neutralGrey66 = Color.fromARGB(255, 130, 130, 130);
  static const Color neutralGrey67 = Color.fromARGB(255, 125, 125, 125);
  static const Color neutralGrey68 = Color.fromARGB(255, 116, 116, 116);
  static const Color neutralGrey69 = Color.fromARGB(255, 114, 114, 114);
  static const Color neutralGrey70 = Color.fromARGB(255, 113, 113, 113);
  static const Color neutralGrey71 = Color.fromARGB(255, 111, 111, 111);
  static const Color neutralGrey72 = Color.fromARGB(255, 110, 110, 110);
  static const Color neutralGrey73 = Color.fromARGB(255, 108, 108, 108);
  static const Color neutralGrey74 = Color(0xFF6D6A5F); // 略带暖调的深灰
  static const Color neutralGrey75 = Color.fromARGB(255, 105, 105, 105);
  static const Color neutralGrey76 = Color.fromARGB(255, 103, 103, 103);
  static const Color neutralGrey77 = Color.fromARGB(255, 101, 101, 101);
  static const Color neutralGrey78 = Color.fromARGB(255, 100, 100, 100);

  // ===========================================================================
  // 中性色 (深灰色与黑色系)
  // Neutrals (Dark Grays & Blacks)
  // ===========================================================================

  static const Color neutralDarkGrey1 = Color.fromARGB(255, 99, 99, 99);
  static const Color neutralDarkGrey2 = Color.fromARGB(255, 96, 96, 96);
  static const Color neutralDarkGrey3 = Color.fromARGB(255, 93, 93, 93);
  static const Color neutralDarkGrey4 = Color.fromARGB(255, 92, 92, 92);
  static const Color neutralDarkGrey5 = Color.fromARGB(255, 87, 87, 87);
  static const Color neutralDarkGrey6 = Color.fromARGB(255, 85, 85, 85);
  static const Color neutralDarkGrey7 = Color.fromARGB(255, 83, 83, 83);
  static const Color neutralDarkGrey8 = Color(0xFF454B5B); // 深灰蓝
  static const Color neutralDarkGrey9 = Color.fromARGB(255, 81, 81, 81);
  static const Color neutralDarkGrey10 = Color.fromARGB(255, 80, 80, 80);
  static const Color neutralDarkGrey11 = Color.fromARGB(255, 79, 79, 79);
  static const Color neutralDarkGrey12 = Color.fromARGB(255, 76, 76, 76);
  static const Color neutralDarkGrey13 = Color.fromARGB(255, 74, 74, 74);
  static const Color neutralDarkGrey14 = Color(0xFF383F47); // 深灰蓝
  static const Color neutralDarkGrey15 = Color.fromARGB(255, 68, 68, 68);
  static const Color neutralDarkGrey16 = Color.fromARGB(255, 64, 64, 64);
  static const Color neutralDarkGrey17 = Color.fromARGB(255, 60, 60, 60);
  static const Color neutralDarkGrey18 = Color.fromARGB(255, 48, 48, 48);
  static const Color neutralDarkGrey19 = Color.fromARGB(255, 41, 41, 41);
  static const Color neutralDarkGrey20 = Color.fromARGB(255, 33, 33, 33);
  static const Color neutralNearBlack1 = Color.fromARGB(255, 25, 25, 25);
  static const Color neutralNearBlack2 = Color.fromARGB(255, 22, 22, 20);
  static const Color neutralNearBlack3 = Color.fromARGB(255, 20, 20, 20);
  static const Color neutralNearBlack4 = Color.fromARGB(255, 16, 16, 16);
  static const Color neutralNearBlack5 = Color.fromARGB(255, 13, 13, 11);
  static const Color neutralBlack = Color.fromARGB(255, 0, 0, 0);

  // ===========================================================================
  // 带透明度的颜色
  // Colors with Alpha / Transparency
  // ===========================================================================

  // -- 透明白色 --
  static const Color whiteTransparent93 = Color.fromARGB(237, 255, 255, 255);
  static const Color whiteTransparent63 = Color.fromARGB(160, 255, 255, 255);

  // -- 透明灰色 --
  static const Color greyTransparent59 = Color.fromARGB(150, 240, 240, 240);
  static const Color greyTransparent33 = Color.fromARGB(83, 238, 238, 238);
  static const Color greyTransparent31 = Color.fromARGB(80, 230, 230, 230);
  static const Color greyTransparent15 = Color.fromARGB(38, 134, 134, 134);

  // -- 透明黑色 --
  static const Color blackTransparent87 = Color.fromARGB(222, 0, 0, 0);
  static const Color blackTransparent73 = Color.fromARGB(185, 0, 0, 0);
  static const Color blackTransparent64 = Color.fromARGB(162, 0, 0, 0);
  static const Color blackTransparent50 = Color.fromARGB(127, 0, 0, 0);
  static const Color blackTransparent47 = Color.fromARGB(120, 0, 0, 0);
  static const Color blackTransparent45 = Color.fromARGB(115, 0, 0, 0);
  static const Color blackTransparent41 = Color.fromARGB(105, 0, 0, 0);
  static const Color blackTransparent40 = Color.fromARGB(102, 0, 0, 0);
  static const Color blackTransparent28 = Color.fromARGB(71, 0, 0, 0);

  // -- 透明彩色 --
  static const Color redTransparent76 = Color.fromARGB(193, 239, 83, 80);
  static const Color redTransparent72 = Color.fromARGB(183, 211, 47, 47);
  static const Color greenTransparent70 =
      Color.fromARGB(179, 245, 124, 0); // (现在是透明橙色)
  static const Color navyBlueTransparent76 =
      Color.fromARGB(193, 38, 50, 56); // (透明灰蓝)
  static const Color navyBlueTransparent64 =
      Color.fromARGB(164, 26, 35, 39); // (更深的透明灰蓝)

  // -- 完全透明 --
  static const Color transparent = Color.fromARGB(0, 0, 0, 0);
  static const Color transparentRed =
      Color.fromARGB(0, 255, 0, 0); // 与 transparent 效果相同
}

// -----------------------------------------------------------------------------
//                          LIGHT THEME (活力鲜橙 - 日间模式)
// -----------------------------------------------------------------------------
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light, // 明确指定为浅色主题
  fontFamily: "AlibabaPuHuiTi",
  fontFamilyFallback: const ['Noto Sans SC'],

  // 核心颜色方案 (ColorScheme)
  colorScheme: const ColorScheme.light(
    // -- 品牌色 --
    primary: AppColors.brandGreenVibrant5, // 主品牌色 (主色调橙)，用于按钮、FAB、活动状态等
    onPrimary: AppColors.neutralWhite, // 在主品牌色之上的文本/图标颜色 (白色)

    primaryContainer: AppColors.brandGreenLightest, // 主色的浅色容器背景，如高亮区域
    onPrimaryContainer: AppColors.brandGreenDarkest, // 在上述容器之上的文本颜色

    secondary: AppColors.brandBluePrimary, // 辅助品牌色 (灰蓝色)，用于次要按钮、筛选器等
    onSecondary: AppColors.neutralWhite, // 在辅助品牌色之上的文本/图标颜色

    secondaryContainer: AppColors.brandBlueDark4,
    onSecondaryContainer: AppColors.neutralGrey15,

    surface: AppColors.neutralWhite, // 卡片、对话框、底部菜单的背景色 (白色)
    onSurface: AppColors.neutralNearBlack1, // 表面之上的主要文本颜色

    // -- 功能色 --
    error: AppColors.accentRedDark1, // 错误状态颜色 (深红色)
    onError: AppColors.neutralWhite, // 错误颜色之上的文本/图标颜色
  ),

  // --- 特定组件的主题微调 ---

  // AppBar 主题
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.neutralWhite, // AppBar 背景色
    foregroundColor: AppColors.neutralNearBlack1, // AppBar 标题和图标颜色
    elevation: 0.5, // 添加轻微的阴影以示区分
    iconTheme: IconThemeData(color: AppColors.neutralNearBlack1),
    titleTextStyle: TextStyle(
      fontFamily: "AlibabaPuHuiTi",
      color: AppColors.neutralNearBlack1,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),

  // TabBar 主题
  tabBarTheme: const TabBarThemeData(
    labelColor: AppColors.brandGreenVibrant5, // 选中的标签颜色
    unselectedLabelColor: AppColors.neutralGrey62, // 未选中的标签颜色
    indicatorColor: AppColors.brandGreenVibrant5, // 指示器颜色
    labelStyle: TextStyle(
        height: 1.08,
        fontFamily: "AlibabaPuHuiTi",
        fontWeight: FontWeight.bold),
  ),

  // 悬浮按钮主题
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.brandGreenVibrant5, // FAB 背景色
    foregroundColor: AppColors.neutralWhite, // FAB 图标颜色
  ),

  // 普通按钮主题
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.brandGreenVibrant5, // 按钮背景色
      foregroundColor: AppColors.neutralWhite, // 按钮文字颜色
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),

  // 卡片主题
  cardTheme: CardThemeData(
    elevation: 1,
    color: AppColors.neutralWhite,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  ),
);

// -----------------------------------------------------------------------------
//                           DARK THEME (活力鲜橙 - 夜间模式)
// -----------------------------------------------------------------------------
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark, // 明确指定为深色主题
  fontFamily: "AlibabaPuHuiTi",
  fontFamilyFallback: const ['Noto Sans SC'],

  // 核心颜色方案 (ColorScheme)
  colorScheme: const ColorScheme.dark(
    // -- 品牌色 --
    primary: AppColors.brandGreenVibrant4, // 主品牌色 (选择一个在深色背景上更柔和的橙色)
    onPrimary: AppColors.neutralNearBlack1, // 在主品牌色之上的文本/图标颜色

    primaryContainer: AppColors.brandGreenDarker3,
    onPrimaryContainer: AppColors.brandGreenLighter,

    secondary: AppColors.brandBlueGreyLight, // 辅助品牌色 (选择一个更亮的灰蓝色以保证对比度)
    onSecondary: AppColors.neutralNearBlack3, // 在辅助品牌色之上的文本/图标颜色

    secondaryContainer: AppColors.brandBlueDark1,
    onSecondaryContainer: AppColors.neutralGrey10,

    surface: AppColors.neutralNearBlack2, // 卡片、对话框等的背景色 (比背景略浅)
    onSurface: AppColors.neutralGrey5, // 表面之上的主要文本颜色

    // -- 功能色 --
    error: AppColors.accentRedVibrant1, // 错误状态颜色 (选择一个更亮的红色以保证可见性)
    onError: AppColors.neutralBlack, // 错误颜色之上的文本/图标颜色
  ),

  // --- 特定组件的主题微调 ---

  // AppBar 主题
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.neutralNearBlack2, // AppBar 背景色 (与表面一致)
    foregroundColor: AppColors.neutralGrey5, // AppBar 标题和图标颜色
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.neutralGrey5),
    titleTextStyle: TextStyle(
      fontFamily: "AlibabaPuHuiTi",
      color: AppColors.neutralGrey5,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),

  // TabBar 主题
  tabBarTheme: const TabBarThemeData(
    labelColor: AppColors.brandGreenVibrant4,
    unselectedLabelColor: AppColors.neutralGrey68,
    indicatorColor: AppColors.brandGreenVibrant4,
    labelStyle: TextStyle(
        height: 1.08,
        fontFamily: "AlibabaPuHuiTi",
        fontWeight: FontWeight.bold),
  ),

  // 悬浮按钮主题
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.brandGreenVibrant4,
    foregroundColor: AppColors.neutralNearBlack1,
  ),

  // 普通按钮主题
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.brandGreenVibrant4,
      foregroundColor: AppColors.neutralNearBlack1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),

  // 卡片主题
  cardTheme: CardThemeData(
    elevation: 1,
    color: AppColors.neutralNearBlack2, // 卡片颜色与表面一致
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  ),
);
