import 'package:flutter/material.dart';
import 'package:vigaviga/features/viewer/viga_video_viewer_page.dart';

class VigaVideoViewerService {
  /// 打开视频查看器
  /// 通过移除 transitionsBuilder 来启用 Hero 动画
  static void openVideoViewer({
    required BuildContext context,
    required List<String> videoSources,
    required int initialIndex,
    required Rect initialRect, // 这个参数仍需接收，以备 Hero 动画系统使用
    String? heroTagPrefix, // 同上，确保 tag 匹配
  }) {
    Navigator.push(
      context,
      PageRouteBuilder(
        // 核心：页面背景透明，让 Hero 动画的背景能够平滑过渡
        opaque: false,
        barrierColor: Colors.transparent,

        // 关键变更：
        // 我们完全移除了自定义的 `transitionsBuilder` 属性。
        // 当这个属性不存在时，Flutter 的 Navigator 会自动查找
        // 起始页面和目标页面中具有相同 tag 的 Hero Widget，并为它们创建平滑的
        // 共享元素过渡动画（即您期望的“逐渐放大”效果）。
        // 这是解决“渐变”问题的根本方法，也是 Flutter 的标准做法。

        pageBuilder: (context, animation, secondaryAnimation) {
          // 页面构建逻辑保持不变，它只负责创建目标页面
          // 我们不再需要向 VigaVideoViewerPage 传递 initialRect，
          // 因为 Hero 动画系统在外部已经处理了所有过渡细节。
          return VigaVideoViewerPage(
            videoSources: videoSources,
            initialIndex: initialIndex,
            heroTagPrefix: heroTagPrefix,
          );
        },
      ),
    );
  }

  /// 打开单个视频查看器
  /// 此方法会自动继承 openVideoViewer 的 Hero 动画行为
  static void openSingleVideo({
    required BuildContext context,
    required String videoUrl,
    required Rect initialRect,
  }) {
    openVideoViewer(
      context: context,
      videoSources: [videoUrl],
      initialIndex: 0,
      initialRect: initialRect,
    );
  }

  /// 打开多个视频查看器
  /// 此方法会自动继承 openVideoViewer 的 Hero 动画行为
  static void openMultipleVideos({
    required BuildContext context,
    required List<String> videoUrls,
    required int initialIndex,
    required Rect initialRect,
    String? heroTagPrefix, // *** 关键修正：恢复参数 ***
  }) {
    openVideoViewer(
      context: context,
      videoSources: videoUrls,
      initialIndex: initialIndex,
      initialRect: initialRect,
      heroTagPrefix: heroTagPrefix,
    );
  }
}
