// /lib/screens/user/widgets/viga_user_function_button.dart

// 用户中心专用
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/viga_tools.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';

class VigaUserFunctionButton extends StatefulWidget {
  final String icon;
  final String title;
  final VoidCallback onPressed;

  const VigaUserFunctionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  VigaUserFunctionButtonState createState() => VigaUserFunctionButtonState();
}

class VigaUserFunctionButtonState extends State<VigaUserFunctionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);

    // 计算单行文本的高度，为两行文本预留空间
    final textStyle = TextStyle(
      height: 1.08,
      decoration: TextDecoration.none,
      color: Colors.white,
      fontSize: fontSizeScale(22.0.w),
      overflow: TextOverflow.ellipsis,
    );
    final double twoLinesTextHeight =
        (textStyle.fontSize! * textStyle.height!) * 2;

    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) {
            setState(() {
              _isPressed = false;
            });
          }
        });
      },
      onTapUp: (_) {
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) {
            setState(() {
              _isPressed = false;
            });
          }
        });
      },
      child: Container(
        // GestureDetector已经处理了点击，这里的color仅用于背景
        decoration: BoxDecoration(
          color: _isPressed
              ? AppColors.greyTransparent33
              : Colors.transparent, // 按下时背景色
          borderRadius: BorderRadius.circular(10.0).w, // 圆角半径
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // 关键：使图标顶部对齐
          crossAxisAlignment: CrossAxisAlignment.center, // 水平居中
          children: [
            SizedBox(height: 15.w),
            // 图标
            VigaAppNetworkImage(
              imageUrl: widget.icon,
              width: 65.w,
              height: 65.w,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 15.w), // 图标和标题之间的间距
            // 标题
            Container(
              height: twoLinesTextHeight,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
