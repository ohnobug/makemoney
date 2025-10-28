// lib/screens/user/ljn_user_info_page.dart

import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vigaviga/tools/viga_tools.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 关键改动 1：使用条件导入
// 如果环境支持 'dart:html' (即 Web)，则导入 'web_saver.dart'。
// 否则，导入 'mobile_saver.dart'。
import 'mobile_saver.dart' if (dart.library.html) 'web_saver.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  // 统一的保存图片入口方法
  Future<void> _saveImage() async {
    if (!mounted) return;

    final ByteData bytes = await rootBundle.load(assetPath('images/test.png'));
    if (!mounted) return;

    final Uint8List list = bytes.buffer.asUint8List();

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

  // 关键改动 3：_saveImageForWeb 方法已被移除，因为它的逻辑移到了 web_saver.dart 中

  // 移动平台：保存图片到相册 (此方法保持不变)
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
    // ... 你的 build 方法完全不需要改变
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: VigaAppBar(
        title: '',
      ),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 40.0.w),
          child: Column(
            children: [
               SizedBox(height: 100.h),
              SizedBox(
                width: 560.w,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0.r),
                      child: Image.asset(assetPath('images/test.png'), width: 140.w, height: 140.h, fit: BoxFit.cover),
                    ),
                    SizedBox(width: 32.w),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('李俊杰', style: TextStyle(fontSize: 44.w, fontWeight: FontWeight.w600, color: Colors.black)),
                        SizedBox(height: 16.h),
                        Text('广东 广州', style: TextStyle(fontSize: 32.w, color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              ),
               SizedBox(height: 40.h),
              Image.asset(assetPath('images/test.png'), width: 560.w),
               SizedBox(height: 60.h),
               Text('扫一扫上面的二维码图案，加我为朋友。', style: TextStyle(color: Color(0xFFB2B2B2), fontSize: 28.w)),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton('扫一扫', () {
                    print('点击了扫一扫');
                    Navigator.pushNamed(context, '/discovery/qrcode_scanner');
                  }),
                  _buildDivider(),
                  _buildActionButton('换个样式', () {
                    print('点击了换个样式');
                  }),
                  _buildDivider(),
                  _buildActionButton('保存图片', () {
                    print('点击了保存图片');
                    _saveImage();
                  }),
                ],
              ),
               SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 32.0.w),
        child: Text(text, style:  TextStyle(color: Color(0xFF6E7D93), fontSize: 32.w)),
      ),
    );
  }

  Widget _buildDivider() {
    return  Text('|', style: TextStyle(color: Color(0xFFE0E0E0), fontSize: 28.w));
  }
}