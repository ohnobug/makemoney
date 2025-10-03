// lib/store/ljn_system_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:vigaviga/tools/ljn_logger.dart';

// 定义父级 TabBar 拖拽状态的枚举
enum ParentDragState { idle, dragging, animating }

// 系统的 Cubit
class LJNSystemCubit extends Cubit<SystemState> {
  LJNSystemCubit()
      : super(
          SystemState(
            navigatorKey: GlobalKey<NavigatorState>(),
          ),
        );

  // =======================================================================
  // 用于代理子页面拖拽事件的方法
  // =======================================================================

  /// 当子页面决定将手势移交给父级时调用此方法。
  /// 这只是一个状态标记，通知父级手势已开始。
  void onParentDragStart() {
    if (state.parentDragState == ParentDragState.idle) {
      emit(state.copyWith(
        parentDragState: ParentDragState.dragging,
      ));
    }
  }

  /// 当子页面检测到手势结束时调用。
  void onParentDragEnd(double velocity) {
    if (state.parentDragState == ParentDragState.dragging) {
      emit(state.copyWith(
        parentDragState: ParentDragState.animating,
        parentDragEndVelocity: velocity,
      ));
    }
  }

  /// 当父级 TabBar 的动画处理完毕后，重置状态。
  void onParentDragHandled() {
    emit(state.copyWith(
      parentDragState: ParentDragState.idle,
      clearParentDragEndVelocity: true,
    ));
  }

  /// 当子页面开始自己处理手势时，调用 lock(true) 来锁定父级滚动。
  /// 手势结束后，调用 lock(false) 来解锁。
  void lockParentPageView(bool lock) {
    if (state.isParentPageViewLocked != lock) {
      emit(state.copyWith(isParentPageViewLocked: lock));
    }
  }

  // =======================================================================
  // 其他状态管理方法
  // =======================================================================

  void updateMainTabIndex(int index) {
    emit(state.copyWith(mainTabIndex: index));
  }

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

  void updateMainpage5isload(bool mainpage1isload) {
    emit(state.copyWith(mainpage5isload: mainpage1isload));
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

  void updateTabbarHeight(double tabbarHeight) {
    emit(state.copyWith(tabbarHeight: tabbarHeight));
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
  final bool? mainpage5isload;
  final GlobalKey<NavigatorState> navigatorKey;
  final Size screenSize;
  final double statusHeight;
  final bool showMiniProgramDrawer;
  final ThemeMode themeMode;
  final Locale currentLocale;
  final double videoProgress;
  final bool showVideoProgress;
  final int mainTabIndex;
  final double tabbarHeight;

  // 拖拽代理状态
  final ParentDragState parentDragState;
  final double? parentDragEndVelocity;

  // 父级 PageView 滚动锁
  final bool isParentPageViewLocked;

  const SystemState({
    this.homescrollpixels = 0,
    this.contactazshow = false,
    this.mainpage1isload = false,
    this.mainpage2isload = false,
    this.mainpage3isload = false,
    this.mainpage4isload = false,
    this.mainpage5isload = false,
    this.screenSize = const Size(0, 0),
    this.statusHeight = 0,
    this.showMiniProgramDrawer = false,
    this.currentLocale = const Locale('en'),
    this.themeMode = ThemeMode.system,
    required this.navigatorKey,
    this.videoProgress = 0.0,
    this.showVideoProgress = false,
    this.mainTabIndex = 0,
    this.parentDragState = ParentDragState.idle,
    this.parentDragEndVelocity,
    this.isParentPageViewLocked = false,
    this.tabbarHeight = 100,
  });

  SystemState copyWith({
    double? homescrollpixels,
    bool? contactazshow,
    bool? mainpage1isload,
    bool? mainpage2isload,
    bool? mainpage3isload,
    bool? mainpage4isload,
    bool? mainpage5isload,
    Size? screenSize,
    double? statusHeight,
    bool? showMiniProgramDrawer,
    ThemeMode? themeMode,
    Locale? currentLocale,
    GlobalKey<NavigatorState>? navigatorKey,
    double? videoProgress,
    bool? showVideoProgress,
    int? mainTabIndex,
    ParentDragState? parentDragState,
    double? parentDragEndVelocity,
    bool clearParentDragEndVelocity = false,
    bool? isParentPageViewLocked,
    double? tabbarHeight,
  }) {
    return SystemState(
      homescrollpixels: homescrollpixels ?? this.homescrollpixels,
      contactazshow: contactazshow ?? this.contactazshow,
      mainpage1isload: mainpage1isload ?? this.mainpage1isload,
      mainpage2isload: mainpage2isload ?? this.mainpage2isload,
      mainpage3isload: mainpage3isload ?? this.mainpage3isload,
      mainpage4isload: mainpage4isload ?? this.mainpage4isload,
      mainpage5isload: mainpage5isload ?? this.mainpage5isload,
      screenSize: screenSize ?? this.screenSize,
      statusHeight: statusHeight ?? this.statusHeight,
      showMiniProgramDrawer:
          showMiniProgramDrawer ?? this.showMiniProgramDrawer,
      themeMode: themeMode ?? this.themeMode,
      navigatorKey: navigatorKey ?? this.navigatorKey,
      currentLocale: currentLocale ?? this.currentLocale,
      videoProgress: videoProgress ?? this.videoProgress,
      showVideoProgress: showVideoProgress ?? this.showVideoProgress,
      mainTabIndex: mainTabIndex ?? this.mainTabIndex,
      parentDragState: parentDragState ?? this.parentDragState,
      parentDragEndVelocity: clearParentDragEndVelocity
          ? null
          : parentDragEndVelocity ?? this.parentDragEndVelocity,
      isParentPageViewLocked:
          isParentPageViewLocked ?? this.isParentPageViewLocked,
      tabbarHeight: tabbarHeight ?? this.tabbarHeight,
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
        mainpage5isload,
        navigatorKey,
        screenSize,
        statusHeight,
        showMiniProgramDrawer,
        themeMode,
        currentLocale,
        videoProgress,
        showVideoProgress,
        mainTabIndex,
        parentDragState,
        parentDragEndVelocity,
        isParentPageViewLocked,
        statusHeight
      ];
}
