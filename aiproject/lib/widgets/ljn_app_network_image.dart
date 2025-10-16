import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LJNAppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final Duration? fadeInDuration;
  final double? width;
  final double? height;
  final BoxFit fit;

  const LJNAppNetworkImage({
    super.key,
    required this.imageUrl,
    this.fadeInDuration,
    this.width,
    this.height,
    this.fit = BoxFit.cover, // 默认填充模式为 cover
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fadeInDuration: fadeInDuration ?? const Duration(milliseconds: 500),
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,

      // ======================================================
      // 在这里统一定义您想要的占位符和错误样式
      // ======================================================

      // 加载过程中的占位符：灰色背景
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        color: Colors.grey[200],
      ),

      // 加载失败时显示的 Widget：带错误图标的灰色背景
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: Colors.grey[200],
        child: const Icon(
          Icons.broken_image_rounded, // 换一个更适合“图片损坏”的图标
          color: Colors.grey,
        ),
      ),
    );
  }
}
