import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

class LJNPopupMenuItem extends StatefulWidget {
  final String title;
  final int icon;
  final Function()? onTap;

  const LJNPopupMenuItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  State<LJNPopupMenuItem> createState() => _LJNPopupMenuItemState();
}

class _LJNPopupMenuItemState extends State<LJNPopupMenuItem> {
  Color _bgColor = AppColors.neutralDarkGrey12;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _bgColor = AppColors.neutralDarkGrey15),
      onTapCancel: () => setState(() => _bgColor = AppColors.neutralDarkGrey12),
      onTapUp: (_) {
        setState(() => _bgColor = AppColors.neutralDarkGrey12);
        Future.delayed(const Duration(milliseconds: 50), () {
          widget.onTap?.call();
        });
      },
      child: Container(
        height: 105.w,
        color: _bgColor,
        child: Row(
          children: [
            SizedBox(
              height: 105.w,
              width: 105.w,
              child: Center(
                child: Icon(
                  IconData(widget.icon, fontFamily: 'Iconfont'),
                  color: AppColors.neutralWhite,
                  size: 41.w,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.neutralDarkGrey6,
                      width: 1.5.w,
                    ),
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    height: 1.08,
                    fontSize: fontSizeScale(33.w),
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                    color: AppColors.neutralWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
