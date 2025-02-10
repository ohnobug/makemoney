import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNAlphabet extends StatelessWidget {
  final String title;
  final Color? color;

  // 构造函数接收一个标题参数
  const LJNAlphabet({super.key, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.w,
      color: color ?? const Color.fromARGB(255, 237, 237, 237),
      padding: EdgeInsets.only(left: 30.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              height: 1.08,
              fontSize: fontSizeScale(22.w),
            ),
          ),
        ],
      ),
    );
  }
}
