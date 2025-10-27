import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/tools/viga_tools.dart';

class VigaAlphabet extends StatelessWidget {
  final String title;
  final Color? bgColor;
  final Color? color;

  // 构造函数接收一个标题参数
  const VigaAlphabet({
    super.key,
    required this.title,
    this.bgColor,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      height: 64.w,
      color: bgColor ?? theme.colorScheme.surfaceContainer,
      padding: EdgeInsets.only(
        left: 25.w,
        top: 16.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              height: 1.08,
              fontSize: fontSizeScale(25.w),
              color: color ?? theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
