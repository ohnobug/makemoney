// lib/store/ljn_system_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:vigaviga/tools/ljn_logger.dart';

// 系统的 Cubit
class LJNSystemCubit extends Cubit<SystemState> {
  LJNSystemCubit()
      : super(
          SystemState(
            navigatorKey: GlobalKey<NavigatorState>(),
          ),
        );

  // =======================================================================
  // [新增] 用于控制主 TabBar 切换的方法
  // =======================================================================

  /// 更新当前主 TabBar 的索引到状态中
  void updateMainTabIndex(int index) {
    emit(state.copyWith(mainTabIndex: index));
  }

  /// 发出切换到上一个主 Tab 的命令
  void switchToPreviousMainTab() {
    // 只有在当前不是第一个 Tab 时才执行
    if (state.mainTabIndex > 0) {
      emit(state.copyWith(changeMainTabTo: state.mainTabIndex - 1));
    }
  }

  /// 在主 Tab 切换命令被处理后，重置该命令，防止重复触发
  void mainTabChangeHandled() {
    // 使用一个特殊的技巧来确保 copyWith 能够将值设为 null
    emit(state.copyWith(clearChangeMainTabTo: true));
  }

  // =======================================================================
  // 其他状态更新方法 (保持不变)
  // =======================================================================

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

  void updateThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

  void updateNavigatorKey(GlobalKey<NavigatorState> key) {
    emit(state.copyWith(navigatorKey: key));
  }

  void updateLanguage(String language) {
    logger.info("Updating language to: $language");
    emit(state.copyWith(currentLocale: Locale(language)));
  }

  void updateVideoProgress({double? progress, bool? show}) {
    emit(state.copyWith(videoProgress: progress, showVideoProgress: show));
  }
}

// 系统的 State
class SystemState extends Equatable {
  final double homescrollpixels;
  final bool contactazshow;
  final bool? mainpage1isload;
  final bool? mainpage2isload;
  final bool? mainpage3isload;
  final bool? mainpage4isload;
  final GlobalKey<NavigatorState> navigatorKey;
  final Size screenSize;
  final double statusHeight;
  final bool showMiniProgramDrawer;
  final ThemeMode themeMode;
  final Locale currentLocale;
  final double videoProgress;
  final bool showVideoProgress;

  // [新增] 用于控制主 TabBar 的状态
  final int mainTabIndex; // 当前主 TabBar 的索引
  final int? changeMainTabTo; // 一个命令式的事件，用于请求改变主 TabBar 的索引

  const SystemState({
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
    this.themeMode = ThemeMode.system,
    required this.navigatorKey,
    this.videoProgress = 0.0,
    this.showVideoProgress = false,
    // [新增] 初始化新字段
    this.mainTabIndex = 0,
    this.changeMainTabTo,
  });

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
    ThemeMode? themeMode,
    Locale? currentLocale,
    GlobalKey<NavigatorState>? navigatorKey,
    double? videoProgress,
    bool? showVideoProgress,
    // [新增] 添加新字段到 copyWith 方法
    int? mainTabIndex,
    int? changeMainTabTo,
    // [新增] 一个特殊标志，用于将 changeMainTabTo 清空为 null
    bool clearChangeMainTabTo = false,
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
      videoProgress: videoProgress ?? this.videoProgress,
      showVideoProgress: showVideoProgress ?? this.showVideoProgress,
      // [新增] 处理新字段的复制逻辑
      mainTabIndex: mainTabIndex ?? this.mainTabIndex,
      // 如果 clearChangeMainTabTo 为 true，则将 changeMainTabTo 设为 null，否则使用提供的值或旧值
      changeMainTabTo:
          clearChangeMainTabTo ? null : changeMainTabTo ?? this.changeMainTabTo,
    );
  }

  @override
  List<Object?> get props => [
        homescrollpixels,
        contactazshow,
        mainpage1isload,
        mainpage2isload,
        mainpage3isload,
        mainpage4isload,
        navigatorKey,
        screenSize,
        statusHeight,
        showMiniProgramDrawer,
        themeMode,
        currentLocale,
        videoProgress,
        showVideoProgress,
        // [新增] 添加新字段到 props 列表
        mainTabIndex,
        changeMainTabTo,
      ];
}
