// 文件路径: lib/LJNPhotoGridPage.dart

import 'package:flutter/material.dart';
import 'ljn_photo_viewer_page.dart'; // 确保你已经创建了这个文件

class LJNPhotoGridPage extends StatefulWidget {
  const LJNPhotoGridPage({super.key});

  @override
  State<LJNPhotoGridPage> createState() => _LJNPhotoGridPageState();
}

class _LJNPhotoGridPageState extends State<LJNPhotoGridPage> {
  // 模拟一些图片数据
  final List<String> imageSources = List.generate(
      27, (i) => 'https://picsum.photos/400/400?random=${i + 500}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('图片查看器'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: imageSources.length,
        itemBuilder: (context, index) {
          final imageUrl = imageSources[index];
          return GestureDetector(
            onTap: () {
              // 点击时打开查看器页面
              Navigator.push(
                context,
                // 使用自定义的PageRouteBuilder来实现背景渐变效果
                PageRouteBuilder(
                  // 【核心】必须设置为false，才能在拖拽关闭时看到下面的页面
                  opaque: false,
                  // Barrier color 设为透明
                  barrierColor: Colors.transparent,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return LJNPhotoViewerPage(
                      imageSources: imageSources,
                      initialIndex: index,
                    );
                  },
                  // 【优化】过渡动画直接返回child，让Hero动画处理主要的转场
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // FadeTransition 也可以保留，但直接返回child能让Hero动画更纯粹
                    return child;
                  },
                ),
              );
            },
            child: Hero(
              // Hero的tag必须是唯一的，这里我们用图片URL作为tag
              tag: imageUrl,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
