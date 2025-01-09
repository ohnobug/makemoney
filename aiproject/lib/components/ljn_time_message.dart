import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNTimeMessage extends StatefulWidget {
  const LJNTimeMessage({super.key});

  @override
  State<LJNTimeMessage> createState() => _LJNTimeMessage();
}

class _LJNTimeMessage extends State<LJNTimeMessage> {
  @override
  Widget build(BuildContext context) {
    // 对方发的消息
    return Container(
      padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 22.w),
      child: const Text("2024年9月29日00:48:46"),
    );
  }
}
