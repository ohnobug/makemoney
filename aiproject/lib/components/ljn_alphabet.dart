import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/tools/ljn_tools.dart';

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
      color: bgColor ?? AppColors.neutralGrey11,
      padding: EdgeInsets.only(left: 30.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              height: 1.08,
              fontSize: fontSizeScale(25.w),
              color: color ?? AppColors.neutralGrey76,
            ),
          ),
        ],
      ),
    );
  }
}
