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
  return AppBar(
    leading: leading != null
        ? GestureDetector(
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
                color:
                    Theme.of(context).appBarTheme.titleTextStyle!.color, // 图标颜色
                size: 36.w, // 图标大小
              ),
            ),
          )
        : SizedBox(),
    primary: false,
    centerTitle: Theme.of(context).appBarTheme.centerTitle,
    title: Text(title),
    toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight,
    titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
    elevation: Theme.of(context).appBarTheme.elevation,
    scrolledUnderElevation:
        Theme.of(context).appBarTheme.scrolledUnderElevation,
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
    actions: actions,
  );
}
