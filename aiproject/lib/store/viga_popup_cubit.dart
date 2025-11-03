import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

// 视频弹窗的Cubit
class VigaPopupCubit extends Cubit<PopupState> {
  VigaPopupCubit()
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
  final Size openBoxSize;
  final Offset openPosition;
  final String? sourcePath; // <--- 修改 1: 字段类型变为可空
  final bool showFullScreenVideo;
  final bool showFullScreenImage;
  final bool returnButtonEvent;

  // 构造函数
  PopupState({
    this.openBoxSize = const Size(0, 0),
    this.openPosition = const Offset(0, 0),
    this.sourcePath, // <--- 修改 2: 移除默认值, 它会自动默认为 null
    this.showFullScreenVideo = false,
    this.showFullScreenImage = false,
    this.returnButtonEvent = false,
  });

  // 拷贝构造函数
  PopupState copyWith({
    Size? openBoxSize,
    Offset? openPosition,
    String? sourcePath, // <--- 修改 3: 这里的类型已经是 String?，保持一致即可
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
