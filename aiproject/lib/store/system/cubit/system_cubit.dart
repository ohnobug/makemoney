import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

// 系统的 Cubit
class SystemCubit extends Cubit<SystemState> {
  SystemCubit() : super(SystemState());

  // 更新各种状态的方法
  void updateHomescrollpixels(double homescrollpixels) {
    emit(state.copyWith(homescrollpixels: homescrollpixels));
  }

  void updateContactazshow(bool contactazshow) {
    emit(state.copyWith(contactazshow: contactazshow));
  }

  void updateMainpage1isload(bool mainpage1isload) {
    emit(state.copyWith(mainpage1isload: mainpage1isload));
  }

  void updateMainpage2isload(bool mainpage2isload) {
    emit(state.copyWith(mainpage2isload: mainpage2isload));
  }

  void updateMainpage3isload(bool mainpage3isload) {
    emit(state.copyWith(mainpage3isload: mainpage3isload));
  }

  void updateMainpage4isload(bool mainpage4isload) {
    emit(state.copyWith(mainpage4isload: mainpage4isload));
  }

  void updateScreenSize(Size screenSize) {
    emit(state.copyWith(screenSize: screenSize));
  }

  void updateStatusHeight(double statusHeight) {
    emit(state.copyWith(statusHeight: statusHeight));
  }

  void updateShowMiniProgramDrawer(bool showMiniProgramDrawer) {
    emit(state.copyWith(showMiniProgramDrawer: showMiniProgramDrawer));
  }

  void updatethemeData(ThemeData themeData) {
    emit(state.copyWith(themeData: themeData));
  }
}

// 系统状态
class SystemState {
  final double homescrollpixels;
  final bool contactazshow; // 通信录中的 A-Z 是否显示
  final bool? mainpage1isload; // 页面 1 是否显示
  final bool? mainpage2isload; // 页面 2 是否显示
  final bool? mainpage3isload; // 页面 3 是否显示
  final bool? mainpage4isload; // 页面 4 是否显示
  final Size screenSize;
  final double statusHeight;
  final bool showMiniProgramDrawer;
  final ThemeData themeData;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // 构造函数
  SystemState({
    this.homescrollpixels = 0,
    this.contactazshow = false,
    this.mainpage1isload = false,
    this.mainpage2isload = false,
    this.mainpage3isload = false,
    this.mainpage4isload = false,
    this.screenSize = const Size(0, 0),
    this.statusHeight = 0,
    this.showMiniProgramDrawer = false,
    ThemeData? themeData,
  }) : themeData = themeData ?? lightTheme; // 如果没有传递 themeData，使用 lightTheme

  // 拷贝构造函数
  SystemState copyWith({
    double? homescrollpixels,
    bool? contactazshow,
    bool? mainpage1isload,
    bool? mainpage2isload,
    bool? mainpage3isload,
    bool? mainpage4isload,
    Size? screenSize,
    double? statusHeight,
    bool? showMiniProgramDrawer,
    ThemeData? themeData,
  }) {
    return SystemState(
      homescrollpixels: homescrollpixels ?? this.homescrollpixels,
      contactazshow: contactazshow ?? this.contactazshow,
      mainpage1isload: mainpage1isload ?? this.mainpage1isload,
      mainpage2isload: mainpage2isload ?? this.mainpage2isload,
      mainpage3isload: mainpage3isload ?? this.mainpage3isload,
      mainpage4isload: mainpage4isload ?? this.mainpage4isload,
      screenSize: screenSize ?? this.screenSize,
      statusHeight: statusHeight ?? this.statusHeight,
      showMiniProgramDrawer:
          showMiniProgramDrawer ?? this.showMiniProgramDrawer,
      themeData: themeData ?? this.themeData,
    );
  }
}

// 主题数据（可以根据需要调整）
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
  ),
  colorScheme: const ColorScheme.light(
    primaryContainer: Colors.white,
    primary: Colors.black,
    secondary: Colors.grey,
  ),
  tabBarTheme: const TabBarTheme(
    labelStyle: TextStyle(height: 1.08, fontFamily: "AlibabaPuHuiTi"),
  ),
  primaryColor: Colors.black,
  fontFamily: "AlibabaPuHuiTi",
  fontFamilyFallback: const ['Noto Sans SC'],
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
  ),
  colorScheme: const ColorScheme.dark(
    primaryContainer: Colors.black,
    primary: Colors.white,
    secondary: Colors.grey,
  ),
  tabBarTheme: const TabBarTheme(
    labelStyle: TextStyle(height: 1.08, fontFamily: "AlibabaPuHuiTi"),
  ),
  primaryColor: Colors.black,
  fontFamily: "AlibabaPuHuiTi",
  fontFamilyFallback: const ['Noto Sans SC'],
);
