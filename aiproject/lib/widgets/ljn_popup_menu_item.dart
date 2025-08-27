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
  Color _bgColor = const Color.fromARGB(255, 76, 76, 76);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) =>
          setState(() => _bgColor = const Color.fromARGB(255, 68, 68, 68)),
      onTapCancel: () =>
          setState(() => _bgColor = const Color.fromARGB(255, 76, 76, 76)),
      onTapUp: (_) {
        setState(() => _bgColor = const Color.fromARGB(255, 76, 76, 76));
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
                  color: Colors.white,
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
                      color: const Color.fromARGB(255, 85, 85, 85),
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
                    color: Colors.white,
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


  Color _bgColor = const Color.fromARGB(255, 76, 76, 76);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) =>
          setState(() => _bgColor = const Color.fromARGB(255, 68, 68, 68)),
      onTapCancel: () =>
          setState(() => _bgColor = const Color.fromARGB(255, 76, 76, 76)),
      onTapUp: (_) {
        setState(() => _bgColor = const Color.fromARGB(255, 76, 76, 76));
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
                  color: Colors.white,
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
                      color: const Color.fromARGB(255, 85, 85, 85),
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
                    color: Colors.white,
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