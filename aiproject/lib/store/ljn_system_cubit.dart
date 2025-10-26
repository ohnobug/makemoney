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

  void updateTabbarHeight(double tabbarHeight) {
    emit(state.copyWith(tabbarHeight: tabbarHeight));
  }

  void updateAppbarHeight(double appbarHeight) {
    emit(state.copyWith(appbarHeight: appbarHeight));
  }

  void updateShowHomeTabbar(bool showHomeTabbar) {
    emit(state.copyWith(showHomeTabbar: showHomeTabbar));
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

  void updateVideoProgressBottomOffset(double offset) {
    emit(state.copyWith(videoProgressBottomOffset: offset));
  }

  void updateCdnBase(String s) {
    emit(state.copyWith(
      cdnBase: s,
    ));
  }

  void updateMainTabIndex(int index) {
    emit(state.copyWith(mainTabIndex: index));
  }
}

// 系统的 State
class SystemState extends Equatable {
  final bool contactazshow;
  final bool? mainpage1isload;
  final bool? mainpage2isload;
  final bool? mainpage3isload;
  final bool? mainpage4isload;
  final bool? mainpage5isload;
  final GlobalKey<NavigatorState> navigatorKey;
  final Size screenSize;
  final double appbarHeight;
  final double statusHeight;
  final double tabbarHeight;
  final bool showHomeTabbar;
  final ThemeMode themeMode;
  final Locale currentLocale;
  final double videoProgress;
  final bool showVideoProgress;
  final double videoProgressBottomOffset;
  final int mainTabIndex;
  final String cdnBase;

  const SystemState({
    this.contactazshow = false,
    this.mainpage1isload = false,
    this.mainpage2isload = false,
    this.mainpage3isload = false,
    this.mainpage4isload = false,
    this.mainpage5isload = false,
    this.screenSize = const Size(0, 0),
    this.appbarHeight = 0,
    this.statusHeight = 0,
    this.tabbarHeight = 100,
    this.showHomeTabbar = true,
    this.currentLocale = const Locale('en'),
    this.themeMode = ThemeMode.system,
    required this.navigatorKey,
    this.videoProgress = 0.0,
    this.showVideoProgress = false,
    this.videoProgressBottomOffset = 0.0,
    this.mainTabIndex = 0,
    this.cdnBase = "",
  });

  SystemState copyWith({
    bool? contactazshow,
    bool? mainpage1isload,
    bool? mainpage2isload,
    bool? mainpage3isload,
    bool? mainpage4isload,
    bool? mainpage5isload,
    Size? screenSize,
    double? statusHeight,
    double? tabbarHeight,
    double? appbarHeight,
    bool? showHomeTabbar,
    ThemeMode? themeMode,
    Locale? currentLocale,
    GlobalKey<NavigatorState>? navigatorKey,
    double? videoProgress,
    bool? showVideoProgress,
    double? videoProgressBottomOffset,
    int? mainTabIndex,
    double? parentDragEndVelocity,
    bool clearParentDragEndVelocity = false,
    bool? isParentPageViewLocked,
    String? cdnBase,
  }) {
    return SystemState(
      contactazshow: contactazshow ?? this.contactazshow,
      mainpage1isload: mainpage1isload ?? this.mainpage1isload,
      mainpage2isload: mainpage2isload ?? this.mainpage2isload,
      mainpage3isload: mainpage3isload ?? this.mainpage3isload,
      mainpage4isload: mainpage4isload ?? this.mainpage4isload,
      mainpage5isload: mainpage5isload ?? this.mainpage5isload,
      screenSize: screenSize ?? this.screenSize,
      statusHeight: statusHeight ?? this.statusHeight,
      tabbarHeight: tabbarHeight ?? this.tabbarHeight,
      appbarHeight: appbarHeight ?? this.appbarHeight,
      showHomeTabbar: showHomeTabbar ?? this.showHomeTabbar,
      themeMode: themeMode ?? this.themeMode,
      navigatorKey: navigatorKey ?? this.navigatorKey,
      currentLocale: currentLocale ?? this.currentLocale,
      videoProgress: videoProgress ?? this.videoProgress,
      showVideoProgress: showVideoProgress ?? this.showVideoProgress,
      videoProgressBottomOffset:
          videoProgressBottomOffset ?? this.videoProgressBottomOffset,
      mainTabIndex: mainTabIndex ?? this.mainTabIndex,
      cdnBase: cdnBase ?? this.cdnBase,
    );
  }

  @override
  List<Object?> get props => [
        contactazshow,
        mainpage1isload,
        mainpage2isload,
        mainpage3isload,
        mainpage4isload,
        mainpage5isload,
        navigatorKey,
        screenSize,
        statusHeight,
        appbarHeight,
        tabbarHeight,
        showHomeTabbar,
        themeMode,
        currentLocale,
        videoProgress,
        showVideoProgress,
        videoProgressBottomOffset,
        mainTabIndex,
        cdnBase
      ];
}
