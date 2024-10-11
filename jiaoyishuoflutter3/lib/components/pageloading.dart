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
                    width: 40.w,
                    height: 40.w,
                    child: CircularProgressIndicator(
                        strokeWidth: 3.w,
                        color: const Color.fromARGB(255, 165, 165, 165)),
                  ),
                  SizedBox(
                    width: 26.w,
                  ),
                  const Text(
                    "正在加载...",
                    style: TextStyle(color: Color.fromARGB(255, 165, 165, 165)),
                  )
                ])));
  }
}
