import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

// 视频弹窗的Cubit
class LJNPopupCubit extends Cubit<PopupState> {
  LJNPopupCubit()
      : super(
          PopupState(),
        );

  // 更新returnButtonEvent
  void updateReturnButtonEvent(bool returnButtonEvent) {
    emit(
      state.copyWith(
        returnButtonEvent: returnButtonEvent,
      ),
    );
  }

  void updateShowFullScreenImage(bool showFullScreenImage) {
    emit(
      state.copyWith(
        showFullScreenImage: showFullScreenImage,
      ),
    );
  }

  // 更新navigatorKey
  void updateImagePopup({
    required Size openBoxSize,
    required Offset openPosition,
    required String imagePath,
    required bool showFullScreenimage,
  }) {
    emit(
      PopupState(
        openBoxSize: openBoxSize,
        openPosition: openPosition,
        sourcePath: imagePath,
        showFullScreenImage: showFullScreenimage,
      ),
    );
  }

  // 更新ShowFullScreenVideo
  void updateShowFullScreenVideo(bool showFullScreenVideo) {
    emit(
      state.copyWith(
        showFullScreenVideo: showFullScreenVideo,
      ),
    );
  }

  // 更新navigatorKey
  void updateVideoPopup({
    required Size openBoxSize,
    required Offset openPosition,
    required String sourcePath,
    required bool showFullScreenVideo,
  }) {
    emit(
      PopupState(
        openBoxSize: openBoxSize,
        openPosition: openPosition,
        sourcePath: sourcePath,
        showFullScreenVideo: showFullScreenVideo,
      ),
    );
  }
}

// 系统状态
class PopupState {
  Size openBoxSize;
  Offset openPosition;
  String sourcePath;
  bool showFullScreenVideo;
  bool showFullScreenImage;
  bool returnButtonEvent;

  // 构造函数
  PopupState({
    this.openBoxSize = const Size(0, 0),
    this.openPosition = const Offset(0, 0),
    this.sourcePath = '',
    this.showFullScreenVideo = false,
    this.showFullScreenImage = false,
    this.returnButtonEvent = false,
  });

  // 拷贝构造函数
  PopupState copyWith({
    Size? openBoxSize,
    Offset? openPosition,
    String? sourcePath,
    bool? showFullScreenVideo,
    bool? showFullScreenImage,
    bool? returnButtonEvent,
  }) {
    return PopupState(
      openBoxSize: openBoxSize ?? this.openBoxSize,
      openPosition: openPosition ?? this.openPosition,
      sourcePath: sourcePath ?? this.sourcePath,
      showFullScreenVideo: showFullScreenVideo ?? this.showFullScreenVideo,
      showFullScreenImage: showFullScreenImage ?? this.showFullScreenImage,
      returnButtonEvent: returnButtonEvent ?? this.returnButtonEvent,
    );
  }
}
