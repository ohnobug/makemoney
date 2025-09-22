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

  // 更新视频进度状态的方法
  void updateVideoProgress({double? progress, bool? show}) {
    emit(state.copyWith(videoProgress: progress, showVideoProgress: show));
  }
}

class SystemState extends Equatable {
  final double homescrollpixels;
  final bool contactazshow;
  final bool mainpage1isload;
  final bool mainpage2isload;
  final bool mainpage3isload;
  final bool mainpage4isload;
  final GlobalKey<NavigatorState> navigatorKey;
  final Size screenSize;
  final double statusHeight;
  final bool showMiniProgramDrawer;
  final ThemeMode themeMode;
  final Locale currentLocale;
  final double videoProgress;
  final bool showVideoProgress;

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
      ];
}
