// G:\t\detection\aiproject\lib\screens\user\photo_viewer\viga_photo_grid_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/tools/viewer/viga_viewer_service.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';

class VigaPhotoGridPage extends StatefulWidget {
  const VigaPhotoGridPage({super.key});

  @override
  State<VigaPhotoGridPage> createState() => _VigaPhotoGridPageState();
}

class _VigaPhotoGridPageState extends State<VigaPhotoGridPage> {
  List<String> imageSources = [];

  // 使用 GlobalKey 来更精确地获取每个图片的位置和大小
  final Map<int, GlobalKey> _imageKeys = {};

  final String heroTagPrefix = 'photo_grid_page';

  @override
  void initState() {
    super.initState();
    imageSources = List.generate(
        90, (i) => 'https://picsum.photos/400/400?random=${i + 50000}');
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: VigaAppBar(
          title: '图片查看器',
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
            final heroTag = '${heroTagPrefix}_$imageUrl';

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

                VigaViewerService.openMultiplePhotos(
                  context: context,
                  imageUrls: imageSources,
                  initialIndex: index,
                  initialRect: initialRect,
                  heroTagPrefix: heroTagPrefix,
                );
              },
              child: Hero(
                tag: heroTag,
                child: VigaAppNetworkImage(
                  key: _imageKeys[index],
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
