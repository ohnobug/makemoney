import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

// Your AppColors class remains exactly the same...
class AppColors {
  // ===========================================================================
  // 核心品牌色 (映射为 紫/品红色系 - 源自 "VIGAVIGA" 字体和蜂鸟)
  // Core Brand Colors (Mapped to Purples/Magentas from logo text)
  // ===========================================================================

  static const Color brandGreenLightest = Color(0xFFEADCF5); // 极浅的紫罗兰
  static const Color brandGreenLighter = Color(0xFFD6BDE9); // 较浅的紫罗兰
  static const Color brandGreenLight = Color(0xFFB894D7); // 明亮的紫罗兰
  static const Color brandGreenSlightlyLighter = Color(0xFF9F7AC8); // 略亮的紫罗兰
  static const Color brandGreenVibrant1 = Color(0xFF8A5DBA); // 活力紫 1
  static const Color brandGreenVibrant2 = Color(0xFF7B4FB0); // 活力紫 2
  static const Color brandGreenVibrant3 = Color(0xFF6E3E91); // 活力紫 3 (主色调)
  static const Color brandGreenVibrant4 =
      Color(0xFF8A5DBA); // 活力紫 4 (用于深色主题，选择更亮的)
  static const Color brandGreenVibrant5 = Color(0xFF6E3E91); // 活力紫 5 (同主色调)
  static const Color brandGreenVibrant6 = Color(0xFF4B296B); // 活力紫 6
  static const Color brandGreenVibrant7 = Color(0xFF3C2055); // 活力紫 7
  static const Color brandGreenVibrantDeep1 = Color(0xFF4B296B); // 深活力紫 1
  static const Color brandGreenVibrantDeep2 = Color(0xFF3C2055); // 深活力紫 2
  static const Color brandGreenPrimary = Color(0xFF6E3E91); // 品牌主紫色
  static const Color brandGreenSlightlyDesaturated =
      Color(0xFF7A5A93); // 略微去饱和的紫
  static const Color brandGreenDarker1 = Color(0xFF5F3480); // 较深的紫色 1
  static const Color brandGreenDarker2 = Color(0xFF4B296B); // 较深的紫色 2
  static const Color brandGreenDarker3 = Color(0xFF3C2055); // 较深的紫色 3
  static const Color brandGreenDarker4 = Color(0xFF2E1942); // 较深的紫色 4
  static const Color brandGreenDarkest = Color(0xFF2E1942); // 最深的紫色

  // ===========================================================================
  // 辅助品牌色 (映射为 水晶蓝/青色系 - 源自图片顶部冰晶)
  // Brand Colors (Mapped to Crystal Blues/Cyans from crystals)
  // ===========================================================================

  static const Color brandBlueGreyLight = Color(0xFFA6E7F1); // 浅水晶蓝
  static const Color brandPurpleGrey = Color(0xFF61CFE2); // 中水晶蓝
  static const Color brandBluePrimary = Color(0xFF3EC8E0); // 主水晶蓝
  static const Color brandBlueDark1 = Color(0xFF2AB8D3); // 深水晶蓝 1
  static const Color brandBlueDark2 = Color(0xFF1DA2BB); // 深水晶蓝 2
  static const Color brandBlueDark3 = Color(0xFF009BCC); // 深水晶蓝 3
  static const Color brandBlueDark4 = Color(0xFF0083B3); // 深水晶蓝 4
  static const Color brandBlueDark5 = Color(0xFF006D99); // 深水晶蓝 5
  static const Color brandBlueDark6 = Color(0xFF0083B3); // (同4)
  static const Color brandBlueDark7 = Color(0xFF006D99); // (近似5)
  static const Color brandPurpleDark1 = Color(0xFF1DA2BB); // (同深水晶蓝2)
  static const Color brandPurpleDark2 = Color(0xFF009BCC); // (同深水晶蓝3)
  static const Color brandPurpleDark3 = Color(0xFF0083B3); // (同深水晶蓝4)
  static const Color brandPurpleDark4 = Color(0xFF006D99); // (同深水晶蓝5)
  static const Color brandPurpleDark5 = Color(0xFF005A7F); // (最深)

  // ===========================================================================
  // 第三品牌色 (映射为 生命绿系 - 源自图片顶部绿叶)
  // Brand Colors (Mapped to Nature Greens from leaves)
  // ===========================================================================

  static const Color brandTealBackground1 = Color(0xFFE1F5E2); // 极浅的薄荷绿背景
  static const Color brandTealBackground2 = Color(0xFFD2EDD4); // (近似1)
  static const Color brandTealVibrant = Color(0xFF6BBF59); // 活力的生命绿
  static const Color brandTealMedium = Color(0xFF57A94A); // 中等生命绿
  static const Color brandTealDark1 = Color(0xFF46913C); // 暖绿色 1
  static const Color brandTealDark2 = Color(0xFF3E8B43); // 暖绿色 2
  static const Color brandTealDark3 = Color(0xFF317534); // 暖绿色 3 (最深)

  // ===========================================================================
  // 功能/强调色 (映射为 狮王橙/红色系 - 源自狮子和鹿)
  // Functional/Accent Colors (Mapped to Lion's Oranges/Reds)
  // ===========================================================================

  static const Color accentRedPure = Color(0xFFD94A3D); // 纯红替换为狮子的活力红
  static const Color accentRedVibrant1 = Color(0xFFE55B4F); // 活力的红色 (警示)
  static const Color accentRedVibrant2 = Color(0xFFD94A3D); // (近似1)
  static const Color accentRedDark1 = Color(0xFFC33C2E); // 深红色 1
  static const Color accentRedDark2 = Color(0xFFB02F21); // 深红色 2
  static const Color accentRedDark3 = Color(0xFF8C2519); // 深红色 3
  static const Color accentRedDark4 = Color(0xFFD94A3D); // (近似)
  static const Color accentOrange = Color(0xFFF37A23); // 强调橙色 (狮子主色)
  static const Color accentOrangeDark = Color(0xFFDD681E); // 深强调橙
  static const Color accentYellow = Color(0xFFF9B82C); // 强调黄色 (鹿的金色)
  static const Color accentYellowDark1 = Color(0xFFF7AB1A); // 深强调黄 1
  static const Color accentYellowDark2 = Color(0xFFF5A10F); // 深强调黄 2
  static const Color accentYellowDark3 = Color(0xFFE9960B); // 深强调黄 3
  static const Color accentYellowDark4 = Color(0xFFD68909); // 深强调黄 4

  // ===========================================================================
  // 中性色 (白色和浅灰色系 - 仅微调主题中使用的部分)
  // Neutrals (Whites & Light Grays - only adjusted used ones)
  // ===========================================================================

  static const Color neutralWhite = Color.fromARGB(255, 255, 255, 255);
  static const Color neutralOffWhiteYellow = Color(0xFFFEFBFB); // 调整为更纯净的米白
  static const Color neutralOffWhitePink = Color(0xFFFFFBFB); // (近似)
  static const Color neutralGrey1 = Color.fromARGB(255, 248, 248, 248);
  static const Color neutralGrey2 = Color.fromARGB(255, 247, 247, 247);
  static const Color neutralGrey3 = Color.fromARGB(255, 246, 246, 246);
  static const Color neutralGrey4 = Color.fromARGB(255, 245, 245, 245);
  static const Color neutralGrey5 = Color(0xFFF1F3F5); // 用于深色模式前景
  static const Color neutralGrey6 = Color.fromARGB(255, 242, 242, 242);
  static const Color neutralGrey7 = Color.fromARGB(255, 241, 241, 241);
  static const Color neutralGrey8 = Color.fromARGB(255, 240, 240, 240);
  static const Color neutralGrey9 = Color.fromARGB(255, 239, 239, 239);
  static const Color neutralGrey10 = Color(0xFFDEE2E6);
  static const Color neutralGrey11 = Color.fromARGB(255, 237, 237, 237);
  static const Color neutralGrey12 = Color.fromARGB(255, 236, 236, 236);
  static const Color neutralGrey13 = Color.fromARGB(255, 235, 235, 235);
  static const Color neutralGrey14 = Color.fromARGB(255, 233, 234, 236);
  static const Color neutralGrey15 = Color(0xFFCED4DA);
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
  static const Color neutralGrey62 = Color(0xFF6C757D); // 用于亮色主题未选中标签
  static const Color neutralGrey63 = Color.fromARGB(255, 141, 143, 142);
  static const Color neutralGrey64 = Color.fromARGB(255, 139, 139, 139);
  static const Color neutralGrey65 = Color.fromARGB(255, 134, 134, 134);
  static const Color neutralGrey66 = Color.fromARGB(255, 130, 130, 130);
  static const Color neutralGrey67 = Color.fromARGB(255, 125, 125, 125);
  static const Color neutralGrey68 = Color(0xFF495057); // 用于深色主题未选中标签
  static const Color neutralGrey69 = Color.fromARGB(255, 114, 114, 114);
  static const Color neutralGrey70 = Color.fromARGB(255, 113, 113, 113);
  static const Color neutralGrey71 = Color.fromARGB(255, 111, 111, 111);
  static const Color neutralGrey72 = Color.fromARGB(255, 110, 110, 110);
  static const Color neutralGrey73 = Color.fromARGB(255, 108, 108, 108);
  static const Color neutralGrey74 = Color(0xFF6D6A5F);
  static const Color neutralGrey75 = Color.fromARGB(255, 105, 105, 105);
  static const Color neutralGrey76 = Color.fromARGB(255, 103, 103, 103);
  static const Color neutralGrey77 = Color.fromARGB(255, 101, 101, 101);
  static const Color neutralGrey78 = Color.fromARGB(255, 100, 100, 100);

  // ===========================================================================
  // 中性色 (深灰色与黑色系 - 微调)
  // Neutrals (Dark Grays & Blacks - Adjusted)
  // ===========================================================================

  static const Color neutralDarkGrey1 = Color.fromARGB(255, 99, 99, 99);
  static const Color neutralDarkGrey2 = Color.fromARGB(255, 96, 96, 96);
  static const Color neutralDarkGrey3 = Color.fromARGB(255, 93, 93, 93);
  static const Color neutralDarkGrey4 = Color.fromARGB(255, 92, 92, 92);
  static const Color neutralDarkGrey5 = Color.fromARGB(255, 87, 87, 87);
  static const Color neutralDarkGrey6 = Color.fromARGB(255, 85, 85, 85);
  static const Color neutralDarkGrey7 = Color.fromARGB(255, 83, 83, 83);
  static const Color neutralDarkGrey8 = Color(0xFF454B5B);
  static const Color neutralDarkGrey9 = Color.fromARGB(255, 81, 81, 81);
  static const Color neutralDarkGrey10 = Color.fromARGB(255, 80, 80, 80);
  static const Color neutralDarkGrey11 = Color.fromARGB(255, 79, 79, 79);
  static const Color neutralDarkGrey12 = Color.fromARGB(255, 76, 76, 76);
  static const Color neutralDarkGrey13 = Color.fromARGB(255, 74, 74, 74);
  static const Color neutralDarkGrey14 = Color(0xFF383F47);
  static const Color neutralDarkGrey15 = Color.fromARGB(255, 68, 68, 68);
  static const Color neutralDarkGrey16 = Color.fromARGB(255, 64, 64, 64);
  static const Color neutralDarkGrey17 = Color.fromARGB(255, 60, 60, 60);
  static const Color neutralDarkGrey18 = Color.fromARGB(255, 48, 48, 48);
  static const Color neutralDarkGrey19 = Color.fromARGB(255, 41, 41, 41);
  static const Color neutralDarkGrey20 = Color.fromARGB(255, 33, 33, 33);
  static const Color neutralNearBlack1 = Color(0xFF212529); // 用于亮色主题文本
  static const Color neutralNearBlack2 = Color(0xFF1A1423); // 用于深色主题背景 (带紫色调)
  static const Color neutralNearBlack3 = Color(0xFF14101C);
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
  static const Color redTransparent76 = Color.fromARGB(193, 229, 91, 79);
  static const Color redTransparent72 = Color.fromARGB(183, 217, 74, 61);
  static const Color greenTransparent70 = Color(0xB36E3E91); // (现在是透明紫色)
  static const Color navyBlueTransparent76 = Color(0xC1009BCC); // (透明水晶蓝)
  static const Color navyBlueTransparent64 = Color(0xA40083B3); // (更深的透明水晶蓝)

  // -- 完全透明 --
  static const Color transparent = Color.fromARGB(0, 0, 0, 0);
  static const Color transparentRed = Color.fromARGB(0, 255, 0, 0);
}

// -----------------------------------------------------------------------------
//                          LIGHT THEME (活力自然 - 日间模式)
// -----------------------------------------------------------------------------
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: "AlibabaPuHuiTi",
  fontFamilyFallback: const ['Noto Sans SC'],
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.brandGreenVibrant5,
    brightness: Brightness.light,
  ).copyWith(
    primary: AppColors.brandGreenVibrant5,
    onPrimary: AppColors.neutralWhite,
    primaryContainer: AppColors.brandGreenLightest,
    onPrimaryContainer: AppColors.brandGreenDarkest,
    secondary: AppColors.brandBluePrimary,
    onSecondary: AppColors.neutralWhite,
    secondaryContainer: AppColors.brandBlueDark4,
    onSecondaryContainer: AppColors.neutralGrey15,
    surface: AppColors.neutralWhite,
    surfaceContainer: AppColors.neutralGrey11,
    onSurface: AppColors.neutralNearBlack1,
    error: AppColors.accentRedDark1,
    onError: AppColors.neutralWhite,
  ),
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    centerTitle: true,
    toolbarHeight: 90.w,
    backgroundColor: AppColors.neutralGrey11,
    foregroundColor: AppColors.neutralNearBlack1,
    elevation: 0,
    iconTheme: const IconThemeData(color: AppColors.neutralNearBlack1),
    titleTextStyle: TextStyle(
      height: 1.08,
      fontSize: fontSizeScale(32.w),
      color: AppColors.neutralNearBlack1,
      fontFamily: "AlibabaPuHuiTi-Medium",
    ),
  ),
  tabBarTheme: TabBarThemeData(
    labelColor: AppColors.brandGreenPrimary,
    unselectedLabelColor: AppColors.neutralBlack,
    indicatorColor: AppColors.brandGreenPrimary,
    dividerColor: AppColors.neutralGrey25,
    labelStyle: TextStyle(
      height: 1.08,
      fontSize: fontSizeScale(22.w),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.brandGreenVibrant5,
    foregroundColor: AppColors.neutralWhite,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(AppColors.brandGreenVibrant5),
      foregroundColor: WidgetStateProperty.all(AppColors.neutralWhite),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0.w),
          side: BorderSide(
            color: AppColors.brandGreenLightest,
            width: 1.5.w,
            style: BorderStyle.solid,
          ),
        ),
      ),
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.whiteTransparent63.withAlpha(50);
          }
          if (states.contains(WidgetState.hovered)) {
            return AppColors.whiteTransparent63.withAlpha(25);
          }
          return null;
        },
      ),
    ),
  ),

  // =======================================================================
  // ====================    新添加的 OutlinedButton 主题    ====================
  // =======================================================================
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      // 设置按钮的最小尺寸来控制高度
      minimumSize: WidgetStateProperty.all<Size>(Size(0, 48.w)),
      // 设置内边距
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: 12.w),
      ),
      // 设置形状和圆角
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.w),
        ),
      ),
      // 设置边框颜色和宽度
      side: WidgetStateProperty.all<BorderSide>(
        const BorderSide(
          color: AppColors.neutralGrey16, // 亮色模式下的边框颜色
          width: 1.0,
        ),
      ),
      // **核心**：处理不同状态下的颜色
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          // 当按钮被按下时，返回高亮颜色
          if (states.contains(WidgetState.pressed)) {
            return AppColors.neutralGrey18; // 亮色模式下的按下颜色
          }
          // 其他所有状态下，背景都是透明的
          return Colors.transparent;
        },
      ),
      // 设置文字和图标的颜色
      foregroundColor: WidgetStateProperty.all<Color>(
        AppColors.neutralGrey68, // 亮色模式下的文字颜色
      ),
      // 移除阴影
      elevation: WidgetStateProperty.all(0),
    ),
  ),
  // =======================================================================

  cardTheme: CardThemeData(
    elevation: 1,
    color: AppColors.neutralWhite,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0.w),
      side: BorderSide(
        color: AppColors.brandGreenLightest,
        width: 1.5.w,
        style: BorderStyle.solid,
      ),
    ),
  ),
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: AppColors.brandGreenLightest,
        width: 1.5.w,
        style: BorderStyle.solid,
      ),
    ),
    tileColor: AppColors.neutralWhite,
    selectedTileColor: AppColors.brandGreenLightest,
    iconColor: AppColors.neutralDarkGrey1,
    textColor: AppColors.neutralNearBlack1,
    subtitleTextStyle: const TextStyle(color: AppColors.neutralGrey62),
  ),
  popupMenuTheme: PopupMenuThemeData(
    iconColor: AppColors.neutralDarkGrey1,
    iconSize: 41.w,
    textStyle: TextStyle(
      height: 1.08,
      fontSize: fontSizeScale(30.w),
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none,
      color: AppColors.neutralNearBlack1,
    ),
  ),
);

// -----------------------------------------------------------------------------
//                           DARK THEME (奇幻森林 - 夜间模式)
// -----------------------------------------------------------------------------
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: "AlibabaPuHuiTi",
  fontFamilyFallback: const ['Noto Sans SC'],
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.brandGreenVibrant4,
    brightness: Brightness.dark,
  ).copyWith(
    primary: AppColors.brandGreenVibrant4,
    onPrimary: AppColors.neutralWhite,
    primaryContainer: AppColors.brandGreenDarker3,
    onPrimaryContainer: AppColors.brandGreenLighter,
    secondary: AppColors.brandBlueGreyLight,
    onSecondary: AppColors.brandBlueDark5,
    secondaryContainer: AppColors.brandBlueDark1,
    onSecondaryContainer: AppColors.neutralGrey10,
    surface: AppColors.brandGreenDarker2,
    surfaceContainer: AppColors.brandGreenDarkest,
    onSurface: AppColors.neutralGrey5,
    error: AppColors.accentRedVibrant1,
    onError: AppColors.neutralWhite,
  ),
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    centerTitle: true,
    toolbarHeight: 90.w,
    backgroundColor: AppColors.brandGreenDarkest,
    foregroundColor: AppColors.neutralGrey5,
    elevation: 0,
    iconTheme: const IconThemeData(color: AppColors.neutralGrey5),
    titleTextStyle: TextStyle(
      height: 1.08,
      fontSize: fontSizeScale(32.w),
      color: AppColors.neutralGrey5,
      fontFamily: "AlibabaPuHuiTi-Medium",
    ),
  ),
  tabBarTheme: TabBarThemeData(
    labelColor: AppColors.brandGreenVibrant4,
    unselectedLabelColor: AppColors.brandGreenLightest,
    indicatorColor: AppColors.brandGreenVibrant4,
    dividerColor: AppColors.neutralGrey75,
    labelStyle: TextStyle(
      height: 1.08,
      fontSize: fontSizeScale(22.w),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.brandGreenVibrant4,
    foregroundColor: AppColors.neutralWhite,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(AppColors.brandGreenVibrant4),
      foregroundColor: WidgetStateProperty.all(AppColors.neutralWhite),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0.w),
          side: BorderSide(
            color: AppColors.brandGreenDarker3,
            width: 1.5.w,
            style: BorderStyle.solid,
          ),
        ),
      ),
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.whiteTransparent63.withAlpha(50);
          }
          if (states.contains(WidgetState.hovered)) {
            return AppColors.whiteTransparent63.withAlpha(25);
          }
          return null;
        },
      ),
    ),
  ),

  // =======================================================================
  // ====================    新添加的 OutlinedButton 主题    ====================
  // =======================================================================
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      // 设置按钮的最小尺寸来控制高度
      minimumSize: WidgetStateProperty.all<Size>(Size(0, 48.w)),
      // 设置内边距
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: 12.w),
      ),
      // 设置形状和圆角
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.w),
        ),
      ),
      // 设置边框颜色和宽度
      side: WidgetStateProperty.all<BorderSide>(
        const BorderSide(
          color: AppColors.neutralDarkGrey15, // 暗色模式下的边框颜色
          width: 1.0,
        ),
      ),
      // **核心**：处理不同状态下的颜色
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          // 当按钮被按下时，返回高亮颜色
          if (states.contains(WidgetState.pressed)) {
            return AppColors.neutralDarkGrey18; // 暗色模式下的按下颜色
          }
          // 其他所有状态下，背景都是透明的
          return Colors.transparent;
        },
      ),
      // 设置文字和图标的颜色
      foregroundColor: WidgetStateProperty.all<Color>(
        AppColors.neutralGrey5, // 暗色模式下的文字颜色
      ),
      // 移除阴影
      elevation: WidgetStateProperty.all(0),
    ),
  ),
  // =======================================================================

  cardTheme: CardThemeData(
    elevation: 1,
    color: AppColors.brandGreenDarkest,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: BorderSide(
        color: AppColors.brandGreenDarker3,
        width: 1.5.w,
        style: BorderStyle.solid,
      ),
    ),
  ),
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: AppColors.brandGreenDarker3,
        width: 1.5.w,
        style: BorderStyle.solid,
      ),
    ),
    tileColor: AppColors.brandGreenDarker2,
    selectedTileColor: AppColors.brandGreenDarker3,
    iconColor: AppColors.neutralGrey5,
    textColor: AppColors.neutralGrey5,
    subtitleTextStyle: const TextStyle(color: AppColors.neutralGrey68),
  ),
  popupMenuTheme: PopupMenuThemeData(
    iconColor: AppColors.neutralGrey5,
    iconSize: 41.w,
    textStyle: TextStyle(
      height: 1.08,
      fontSize: fontSizeScale(30.w),
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none,
      color: AppColors.neutralGrey5,
    ),
  ),
);
