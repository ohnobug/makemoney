import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNVerticalGap extends StatelessWidget {
  final double? height;
  final Color? color;

  const LJNVerticalGap({
    super.key,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 16.w,
      color: color ?? Theme.of(context).colorScheme.surfaceContainer,
    );
  }
}
