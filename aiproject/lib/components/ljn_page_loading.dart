import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNPageLoading extends StatelessWidget {
  const LJNPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        primary: false,
        appBar: null,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromARGB(255, 237, 237, 237),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 25.w,
                    height: 25.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.w,
                      color: const Color.fromARGB(255, 165, 165, 165),
                      // semanticsLabel: '加载中', // 提供指示器的标签描述
                      // semanticsValue: '50%', // 提供当前进度值描述
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  const Text(
                    "正在加载...",
                    style: TextStyle(
                        height: 1.08,
                        color: Color.fromARGB(255, 165, 165, 165)),
                  )
                ])));
  }
}
