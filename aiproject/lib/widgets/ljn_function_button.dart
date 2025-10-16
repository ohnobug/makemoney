// /lib/widgets/ljn_function_button.dart

// 小程序按钮
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_app_network_image.dart';

class LJNFunctionButton extends StatefulWidget {
  final String icon;
  final String title;
  final VoidCallback onPressed;

  const LJNFunctionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  LJNFunctionButtonState createState() => LJNFunctionButtonState();
}

class LJNFunctionButtonState extends State<LJNFunctionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    // 计算单行文本的高度，为两行文本预留空间
    final textStyle = TextStyle(
      height: 1.08,
      decoration: TextDecoration.none,
      color: theme.colorScheme.onSurface,
      fontSize: fontSizeScale(26.0.w),
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
            SizedBox(height: 20.w), // 可以增加一个顶部的内边距，让图标和按钮顶部有一点距离
            LJNAppNetworkImage(
              imageUrl: widget.icon,
              width: 68.w,
              height: 68.w,
              fit: BoxFit.cover, // 让图片完全填满圆形区域
            ),
            SizedBox(height: 15.w), // 图标和标题之间的间距
            Container(
              height: twoLinesTextHeight, // 关键：为文本区域提供一个固定的、能容纳两行的高度
              alignment: Alignment.topCenter, // 使单行文本也能顶部对齐
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
