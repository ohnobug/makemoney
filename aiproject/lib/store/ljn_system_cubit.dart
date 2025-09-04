import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:vigaviga/tools/ljn_logger.dart';

// 系统的 Cubit
class LJNSystemCubit extends Cubit<SystemState> {
  LJNSystemCubit()
      : super(
          SystemState(
            navigatorKey: GlobalKey<NavigatorState>(),
          ),
        );

  // 更新各种状态的方法
  void updateHomescrollpixels(double homescrollpixels) {
    emit(
      state.copyWith(homescrollpixels: homescrollpixels),
    );
  }

  void updateContactazshow(bool contactazshow) {
    emit(
      state.copyWith(contactazshow: contactazshow),
    );
  }

  void updateMainpage1isload(bool mainpage1isload) {
    emit(
      state.copyWith(mainpage1isload: mainpage1isload),
    );
  }

  void updateMainpage2isload(bool mainpage2isload) {
    emit(
      state.copyWith(mainpage2isload: mainpage2isload),
    );
  }

  void updateMainpage3isload(bool mainpage3isload) {
    emit(
      state.copyWith(mainpage3isload: mainpage3isload),
    );
  }

  void updateMainpage4isload(bool mainpage4isload) {
    emit(
      state.copyWith(mainpage4isload: mainpage4isload),
    );
  }

  void updateScreenSize(Size screenSize) {
    emit(
      state.copyWith(screenSize: screenSize),
    );
  }

  void updateStatusHeight(double statusHeight) {
    emit(
      state.copyWith(statusHeight: statusHeight),
    );
  }

  void updateShowMiniProgramDrawer(bool showMiniProgramDrawer) {
    emit(
      state.copyWith(showMiniProgramDrawer: showMiniProgramDrawer),
    );
  }

  // [修复 1] 方法名和参数类型已更正，以匹配状态
  void updateThemeMode(ThemeMode themeMode) {
    emit(
      state.copyWith(themeMode: themeMode),
    );
  }

  // [修复 2] 此方法现在使用 copyWith，以防止丢失其他状态
  void updateNavigatorKey(GlobalKey<NavigatorState> key) {
    emit(
      state.copyWith(navigatorKey: key),
    );
  }

  void updateLanguage(String language) {
    logger.info("Updating language to: $language");
    emit(
      state.copyWith(currentLocale: Locale(language)),
    );
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
  final GlobalKey<NavigatorState> navigatorKey;
  final Size screenSize;
  final double statusHeight;
  final bool showMiniProgramDrawer;
  final ThemeMode themeMode; // 状态中应存储 ThemeMode
  final Locale currentLocale;

  // [修复 3] 构造函数语法已更正
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
    this.currentLocale = const Locale('en'),
    this.themeMode = ThemeMode.system, // 正确的参数和默认值
    required this.navigatorKey,
  });

  // [修复 4] copyWith 方法中的逻辑和命名已更正
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
    ThemeMode? themeMode, // 参数名与类型匹配
    Locale? currentLocale,
    GlobalKey<NavigatorState>? navigatorKey,
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
      themeMode: themeMode ?? this.themeMode,
      navigatorKey: navigatorKey ?? this.navigatorKey,
      currentLocale: currentLocale ?? this.currentLocale,
    );
  }
}
