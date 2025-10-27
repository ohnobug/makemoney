import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/l10n/app_localizations.dart';

class VigaTimeMessage extends StatefulWidget {
  const VigaTimeMessage({super.key});

  @override
  State<VigaTimeMessage> createState() => _VigaTimeMessage();
}

class _VigaTimeMessage extends State<VigaTimeMessage> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;

    // 1. 你的 DateTime 对象，这应该从你的 API 或数据库中获取
    final DateTime theTimestamp = DateTime(2024, 9, 29, 0, 48, 46);

    // 对方发的消息
    return Container(
      padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 22.w),
      child: Text(l10n.fullDateTime(theTimestamp)),
    );
  }
}
