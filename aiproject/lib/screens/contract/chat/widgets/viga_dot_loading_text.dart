import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';

class VigaDotLoadingText extends StatefulWidget {
  const VigaDotLoadingText({super.key});

  @override
  State<VigaDotLoadingText> createState() => _VigaDotLoadingTextState();
}

class _VigaDotLoadingTextState extends State<VigaDotLoadingText> {
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
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return Text(
      l10n.waitingForAcceptance + '.' * dotCount,
      style: TextStyle(
        fontSize: 30.w,
        color: AppColors.neutralGrey63,
      ),
    );
  }
}
