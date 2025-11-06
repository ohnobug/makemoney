// lib/screens/user/ljn_user_info_page.dart

import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 关键改动 1：使用条件导入
// 如果环境支持 'dart:html' (即 Web)，则导入 'web_saver.dart'。
// 否则，导入 'mobile_saver.dart'。
import 'mobile_saver.dart' if (dart.library.html) 'web_saver.dart';

class UserCardPage extends StatefulWidget {
  const UserCardPage({super.key});

  @override
  State<UserCardPage> createState() => _UserCardPageState();
}

class _UserCardPageState extends State<UserCardPage> {
  // GlobalKey for capturing QR code widget
  final GlobalKey _qrKey = GlobalKey();

  // 统一的保存图片入口方法
  Future<void> _saveImage() async {
    if (!mounted) return;

    try {
      // Capture the QR code widget as an image
      final RenderRepaintBoundary boundary =
          _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ImageByteFormat.png);

      if (!mounted) return;

      if (byteData != null) {
        final Uint8List list = byteData.buffer.asUint8List();

        if (kIsWeb) {
          // 关键改动 2：直接调用条件导入的函数
          saveImageForWeb(list);

          // 在异步操作完成后，再次检查组件是否还在树上
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('下载已开始...')),
          );
        } else {
          // 移动端的处理逻辑（保持不变）
          _saveImageToGallery(list);
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('保存失败: $e')),
      );
    }
  }

  // 保存图片到相册 (此方法保持不变)
  Future<void> _saveImageToGallery(Uint8List imageData) async {
    var status = await Permission.photos.request();
    if (!mounted) return;

    if (status.isGranted) {
      final result = await ImageGallerySaverPlus.saveImage(
        imageData,
        quality: 80,
        name: "my_qrcode_${DateTime.now().millisecondsSinceEpoch}",
      );
      if (!mounted) return;

      if (result != null && result['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('图片已成功保存到相册')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('图片保存失败')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('需要相册权限才能保存图片')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: VigaAppBar(
              title: '二维码卡片',
            ),
            body: Column(
              children: [
                SizedBox(height: 100.w),
                SizedBox(
                  width: 560.w,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0.r),
                        child: Container(
                          width: 140.w,
                          height: 140.w,
                          color: Colors.white,
                          child: BlocBuilder<VigaUserCubit, UserState>(
                            builder: (context, state) {
                              final avatar = state.userinfoAvatar;
                              return VigaAppNetworkImage(
                                imageUrl: (avatar == null || avatar.isEmpty)
                                    ? "${systemState.cdnBase}/avatar/default.png"
                                    : avatar,
                                width: 140.w,
                                height: 140.w,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 32.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '李俊杰',
                            style: TextStyle(
                              fontSize: 44.w,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            '广东 广州',
                            style: TextStyle(
                              fontSize: 32.w,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 40.w),
                RepaintBoundary(
                  key: _qrKey,
                  child: QrImageView(
                    data: 'vigaviga://user/李俊杰',
                    version: QrVersions.auto,
                    size: 560.w,
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(height: 40.w),
                Text(
                  '扫一扫上面的二维码图案，加我为朋友。',
                  style: TextStyle(
                    color: Color(0xFFB2B2B2),
                    fontSize: 28.w,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildActionButton('扫一扫', () {
                      logger.info('点击了扫一扫');
                      context.push('/discovery/qrcode_scanner');
                    }),
                    _buildDivider(),
                    _buildActionButton('换个样式', () {
                      logger.info('点击了换个样式');
                    }),
                    _buildDivider(),
                    _buildActionButton('保存图片', () {
                      logger.info('点击了保存图片');
                      _saveImage();
                    }),
                  ],
                ),
                SizedBox(height: 100.w),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0.w),
        child: Text(text,
            style: TextStyle(color: Color(0xFF6E7D93), fontSize: 28.w)),
      ),
    );
  }

  Widget _buildDivider() {
    return Text('|',
        style: TextStyle(color: Color(0xFFE0E0E0), fontSize: 28.w));
  }
}
