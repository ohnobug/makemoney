import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

// 视频弹窗的Cubit
class PopupCubit extends Cubit<PopupState> {
  PopupCubit() : super(PopupState());

  // 更新ShowFullScreenVideo
  void updateShowFullScreenVideo(bool showFullScreenVideo) {
    emit(PopupState(
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

  // 构造函数
  PopupState({
    this.openBoxSize = const Size(0, 0),
    this.openPosition = const Offset(0, 0),
    this.videoPath = '',
    this.showFullScreenVideo = false,
  });

  // 拷贝构造函数
  PopupState copyWith({
    Size? openBoxSize,
    Offset? openPosition,
    String? videoPath,
    bool? showFullScreenVideo,
  }) {
    return PopupState(
      openBoxSize: openBoxSize ?? this.openBoxSize,
      openPosition: openPosition ?? this.openPosition,
      videoPath: videoPath ?? this.videoPath,
      showFullScreenVideo: showFullScreenVideo ?? this.showFullScreenVideo,
    );
  }
}
