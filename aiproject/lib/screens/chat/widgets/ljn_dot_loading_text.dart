import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/l10n/app_localizations.dart';

class LJNDotLoadingText extends StatefulWidget {
  const LJNDotLoadingText({super.key});

  @override
  State<LJNDotLoadingText> createState() => _LJNDotLoadingTextState();
}

class _LJNDotLoadingTextState extends State<LJNDotLoadingText> {
  int dotCount = 0; // 当前显示的点数
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // 启动定时器，每隔 500 毫秒更新一次点数
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        dotCount = (dotCount + 1) % 4; // 循环显示 0 到 3 个点
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // 销毁定时器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.waitingForAcceptance + '.' * dotCount,
      style: TextStyle(
        fontSize: 30.w,
        color: AppColors.neutralGrey63,
      ),
    );
  }
}
