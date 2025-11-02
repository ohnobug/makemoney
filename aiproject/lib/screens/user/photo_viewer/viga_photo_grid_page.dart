// G:\t\detection\aiproject\lib\screens\user\photo_viewer\viga_photo_grid_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../features/viewer/viga_photo_viewer_page.dart';

class VigaPhotoGridPage extends StatefulWidget {
  const VigaPhotoGridPage({super.key});

  @override
  State<VigaPhotoGridPage> createState() => _VigaPhotoGridPageState();
}

class _VigaPhotoGridPageState extends State<VigaPhotoGridPage> {
  final List<String> imageSources = List.generate(
      90, (i) => 'https://picsum.photos/400/400?random=${i + 50000}');

  // 使用 GlobalKey 来更精确地获取每个图片的位置和大小
  final Map<int, GlobalKey> _imageKeys = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('图片查看器'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(2.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2.w,
          mainAxisSpacing: 2.w,
        ),
        itemCount: imageSources.length,
        itemBuilder: (context, index) {
          // 为每个图片生成一个唯一的 key
          _imageKeys.putIfAbsent(index, () => GlobalKey());
          final imageUrl = imageSources[index];

          return GestureDetector(
            onTap: () {
              // 通过 key 获取图片在屏幕中的精确位置和大小
              final RenderBox? renderBox = _imageKeys[index]
                  ?.currentContext
                  ?.findRenderObject() as RenderBox?;
              if (renderBox == null) return;
              final position = renderBox.localToGlobal(Offset.zero);
              final size = renderBox.size;
              final initialRect = Rect.fromLTWH(
                  position.dx, position.dy, size.width, size.height);

              Navigator.push(
                context,
                PageRouteBuilder(
                  // 核心：页面本身不绘制背景，让路由的过渡动画处理
                  opaque: false,
                  barrierColor: Colors.transparent,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return VigaPhotoViewerPage(
                      imageSources: imageSources,
                      initialIndex: index,
                      initialRect: initialRect, // 传递精确的初始位置
                    );
                  },
                  // 使用路由自带的动画来实现背景的淡入淡出，这是最稳定可靠的方式
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // animation 由路由管理, push时 0->1, pop时 1->0
                    // 我们用它来包裹整个查看器页面，实现完美的淡入淡出
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Hero(
              tag: imageUrl,
              child: Image.network(
                // 将 key 绑定到 Image 组件上
                key: _imageKeys[index],
                imageUrl,
                fit: BoxFit.cover, // 网格中用 cover 填充
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
