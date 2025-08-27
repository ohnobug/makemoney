import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import 'package:spicychat/tools/ljn_tools.dart';

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
    bgColor = widget.bgColor ?? AppColors.neutralGrey11;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return PreferredSize(
          preferredSize: Size.fromHeight(90.0.w + systemState.statusHeight),
          child: Container(
            color: bgColor,
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
                        color: widget.color ?? Colors.black, // 图标颜色
                        size: 36.w, // 图标大小
                      ),
                    ),
                  ),
              primary: false,
              centerTitle: true,
              title: Text(widget.title ?? ""),
              toolbarHeight: 90.w,
              titleTextStyle: TextStyle(
                  height: 1.08,
                  fontSize: fontSizeScale(32.w),
                  color: widget.color ?? Colors.black,
                  fontFamily: "AlibabaPuHuiTi-Medium"),
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: bgColor,
              foregroundColor: bgColor,
              actions: widget.actions,
            ),
          ),
        );
      },
    );
  }
}
