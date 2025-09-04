import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';

class LJNAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Color? color;
  final Color? bgColor;
  final Widget? leading;

  const LJNAppBar(
      {super.key,
      this.title,
      this.actions,
      this.bgColor,
      this.color,
      this.leading});

  @override
  State<LJNAppBar> createState() => _LJNAppBar();

  @override
  Size get preferredSize => Size.fromHeight(90.0);
}

class _LJNAppBar extends State<LJNAppBar> {
  late Color bgColor;

  @override
  void initState() {
    super.initState();
    bgColor = widget.bgColor ?? Theme.of(context).colorScheme.surface;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return PreferredSize(
          preferredSize: Size.fromHeight(90.0.w + systemState.statusHeight),
          child: Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            padding: EdgeInsets.only(top: systemState.statusHeight),
            height: 90.0.w + systemState.statusHeight,
            child: AppBar(
              leading: widget.leading ??
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
                        color: widget.color ??
                            Theme.of(context).colorScheme.onSurface, // 图标颜色
                        size: 36.w, // 图标大小
                      ),
                    ),
                  ),
              primary: false,
              centerTitle: Theme.of(context).appBarTheme.centerTitle,
              title: Text(widget.title ?? ""),
              toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight,
              titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
              elevation: Theme.of(context).appBarTheme.elevation,
              scrolledUnderElevation:
                  Theme.of(context).appBarTheme.scrolledUnderElevation,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
              actions: widget.actions,
            ),
          ),
        );
      },
    );
  }
}
