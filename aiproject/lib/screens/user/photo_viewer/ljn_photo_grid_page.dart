import 'package:flutter/material.dart';
import 'ljn_photo_viewer_page.dart';

class LJNPhotoGridPage extends StatelessWidget {
  const LJNPhotoGridPage({super.key});

  // 模拟一些图片数据
  final List<String> imageSources = const [
    'https://images.unsplash.com/photo-1542385153-28565a7c234f',
    'https://images.unsplash.com/photo-1590523746242-0f04db42bde6',
    'https://images.unsplash.com/photo-1517329782434-0d8078e32f74',
    'https://images.unsplash.com/photo-1594495894542-a46cc73e081a',
    'https://images.unsplash.com/photo-1519681393784-d120267933ba',
    'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800',
    'https://images.unsplash.com/photo-1506905925346-21bda4d32df4',
    'https://images.unsplash.com/photo-1518837695005-2083093ee35b',
    'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05',
    'https://images.unsplash.com/photo-1501854140801-50d01698950b',
    'https://images.unsplash.com/photo-1447752875215-b2761acb3c5d',
    'https://images.unsplash.com/photo-1475924156734-496f6cac6ec1',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('图片查看器测试'),
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
                  opaque: false, // 必须设置为false，才能看到下面的页面
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return LJNPhotoViewerPage(
                      imageSources: imageSources,
                      initialIndex: index,
                    );
                  },
                  // 定义过渡动画
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation, // 使用渐隐渐现的动画
                      child: child,
                    );
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