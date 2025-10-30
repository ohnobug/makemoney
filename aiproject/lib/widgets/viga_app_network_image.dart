import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VigaAppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final Duration? fadeInDuration;
  final double? width;
  final double? height;
  final BoxFit fit;

  const VigaAppNetworkImage({
    super.key,
    required this.imageUrl,
    this.fadeInDuration,
    this.width,
    this.height,
    this.fit = BoxFit.cover, // 默认填充模式为 cover
  });

  @override
  Widget build(BuildContext context) {
    // 【核心修复】使用一个 Stack 来将图片叠加在深色背景之上
    return CachedNetworkImage(
      fadeInDuration: fadeInDuration ?? const Duration(milliseconds: 500),
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        color: Colors.grey[200],
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: Colors.grey[200],
        child: const Icon(
          Icons.broken_image_rounded,
          color: Colors.grey,
        ),
      ),
    );
  }
}
