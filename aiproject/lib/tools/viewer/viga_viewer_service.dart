// lib/tools/viewer/viga_viewer_service.dart

import 'package:flutter/material.dart';
import 'package:vigaviga/features/viewer/viga_photo_viewer_page.dart';

class VigaViewerService {
  /// 打开图片查看器
  static void openPhotoViewer({
    required BuildContext context,
    required List<String> imageSources,
    required int initialIndex,
    required Rect initialRect,
    String? heroTagPrefix,
  }) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        pageBuilder: (context, animation, secondaryAnimation) {
          return VigaPhotoViewerPage(
            imageSources: imageSources,
            initialIndex: initialIndex,
            heroTagPrefix: heroTagPrefix,
          );
        },
      ),
    );
  }

  /// 打开单张图片查看器
  static void openSinglePhoto({
    required BuildContext context,
    required String imageUrl,
    required Rect initialRect,
    String? heroTagPrefix, // *** 关键修正：恢复参数 ***
  }) {
    openPhotoViewer(
      context: context,
      imageSources: [imageUrl],
      initialIndex: 0,
      initialRect: initialRect,
      heroTagPrefix: heroTagPrefix,
    );
  }

  /// 打开多张图片查看器
  static void openMultiplePhotos({
    required BuildContext context,
    required List<String> imageUrls,
    required int initialIndex,
    required Rect initialRect,
    String? heroTagPrefix,
  }) {
    openPhotoViewer(
      context: context,
      imageSources: imageUrls,
      initialIndex: initialIndex,
      initialRect: initialRect,
      heroTagPrefix: heroTagPrefix,
    );
  }
}
