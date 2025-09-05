import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';

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
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 25.w,
              height: 25.w,
              child: CircularProgressIndicator(
                strokeWidth: 3.w,
                color: AppColors.neutralGrey49,
                // semanticsLabel: '加载中', // 提供指示器的标签描述
                // semanticsValue: '50%', // 提供当前进度值描述
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              AppLocalizations.of(context)!.loading,
              style: const TextStyle(
                height: 1.08,
                color: AppColors.neutralGrey49,
              ),
            )
          ],
        ),
      ),
    );
  }
}
