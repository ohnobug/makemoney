import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/logger.dart';

// 视频弹窗的Cubit
class PopupCubit extends Cubit<PopupState> {
  PopupCubit() : super(PopupState());

  // 更新returnButtonEvent
  void updateReturnButtonEvent(bool returnButtonEvent) {
    logger.info("qqqqqqqqqqqqqqqqqq 来啦111");

    emit(state.copyWith(
      returnButtonEvent: returnButtonEvent,
    ));
  }

  // 更新ShowFullScreenVideo
  void updateShowFullScreenVideo(bool showFullScreenVideo) {
    logger.info("qqqqqqqqqqqqqqqqqq 来啦222");

    emit(state.copyWith(
      showFullScreenVideo: showFullScreenVideo,
    ));
  }

  // 更新navigatorKey
  void updateVideoPopup({
    required Size openBoxSize,
    required Offset openPosition,
    required String videoPath,
    required bool showFullScreenVideo,
  }) {
    emit(PopupState(
      openBoxSize: openBoxSize,
      openPosition: openPosition,
      videoPath: videoPath,
      showFullScreenVideo: showFullScreenVideo,
    ));
  }
}

// 系统状态
class PopupState {
  Size openBoxSize;
  Offset openPosition;
  String videoPath;
  bool showFullScreenVideo;
  bool returnButtonEvent;

  // 构造函数
  PopupState({
    this.openBoxSize = const Size(0, 0),
    this.openPosition = const Offset(0, 0),
    this.videoPath = '',
    this.showFullScreenVideo = false,
    this.returnButtonEvent = false,
  });

  // 拷贝构造函数
  PopupState copyWith({
    Size? openBoxSize,
    Offset? openPosition,
    String? videoPath,
    bool? showFullScreenVideo,
    bool? returnButtonEvent,
  }) {
    return PopupState(
      openBoxSize: openBoxSize ?? this.openBoxSize,
      openPosition: openPosition ?? this.openPosition,
      videoPath: videoPath ?? this.videoPath,
      showFullScreenVideo: showFullScreenVideo ?? this.showFullScreenVideo,
      returnButtonEvent: returnButtonEvent ?? this.returnButtonEvent,
    );
  }
}
