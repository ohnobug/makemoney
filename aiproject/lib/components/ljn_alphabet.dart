import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_tools.dart';

class LJNAlphabet extends StatelessWidget {
  final String title;
  final Color? bgColor;
  final Color? color;

  // 构造函数接收一个标题参数
  const LJNAlphabet({super.key, required this.title, this.bgColor, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.w,
      color: bgColor ?? const Color.fromARGB(255, 237, 237, 237),
      padding: EdgeInsets.only(left: 30.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              height: 1.08,
              fontSize: ljnFontSizeScale(25.w),
              color: color ?? const Color.fromARGB(255, 103, 103, 103),
            ),
          ),
        ],
      ),
    );
  }
}
