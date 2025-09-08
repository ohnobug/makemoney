import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  late Color _bgColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(
          () => _bgColor = Theme.of(context).listTileTheme.selectedTileColor!),
      onTapCancel: () => setState(() => _bgColor = Colors.transparent),
      onTapUp: (_) {
        setState(() => _bgColor = Colors.transparent);
        Future.delayed(const Duration(milliseconds: 50), () {
          widget.onTap?.call();
        });
      },
      child: Container(
        height: 105.w,
        color: _bgColor,
        child: Row(
          children: [
            // icon
            SizedBox(
              height: 105.w,
              width: 80.w,
              child: Center(
                child: Icon(
                  IconData(widget.icon, fontFamily: 'Iconfont'),
                  color: Theme.of(context).popupMenuTheme.iconColor,
                  size: Theme.of(context).popupMenuTheme.iconSize,
                ),
              ),
            ),
            // 文字
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: (Theme.of(context).listTileTheme.shape
                            as RoundedRectangleBorder)
                        .side,
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: Theme.of(context).popupMenuTheme.textStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
