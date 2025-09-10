import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';

// ignore: non_constant_identifier_names
AppBar LJNAppBarInner({
  required BuildContext context,
  required String title,
  List<Widget>? actions,
  Widget? leading,
}) {
  ThemeData theme = Theme.of(context);

  return AppBar(
    leading: leading ??
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            // wallet
          }, // 点击事件
          child: Container(
            color: AppColors.transparent,
            height: 90.w,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 35.w),
            child: Icon(
              const IconData(
                0xed9e,
                fontFamily: 'Iconfont',
              ), // 使用的图标
              color: theme.appBarTheme.titleTextStyle!.color, // 图标颜色
              size: 36.w, // 图标大小
            ),
          ),
        ),
    primary: false,
    centerTitle: theme.appBarTheme.centerTitle,
    title: Text(title),
    toolbarHeight: theme.appBarTheme.toolbarHeight,
    titleTextStyle: theme.appBarTheme.titleTextStyle,
    elevation: theme.appBarTheme.elevation,
    scrolledUnderElevation: theme.appBarTheme.scrolledUnderElevation,
    backgroundColor: theme.appBarTheme.backgroundColor,
    foregroundColor: theme.appBarTheme.foregroundColor,
    actions: actions,
  );
}
