// 功能列表
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/tools/ljn_logger.dart';
import 'package:spicychat/tools/ljn_tools.dart';

class LJNMaxWidthButton extends StatefulWidget {
  final double? height;
  final Object? title;
  final Color? color;
  final String? link;
  final bool underline;
  final Function? onPressed;

  const LJNMaxWidthButton(
      {super.key,
      this.height,
      required this.title,
      this.color,
      this.link,
      required this.underline,
      this.onPressed});

  @override
  State<LJNMaxWidthButton> createState() => _LJNMaxWidthButtonState();
}

class _LJNMaxWidthButtonState extends State<LJNMaxWidthButton> {
  // bool isClicked = false;
  Color containerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        setState(() {
          containerColor = const Color.fromARGB(255, 229, 229, 229);
        });
      },
      onTapCancel: () {
        setState(() {
          containerColor = Colors.white;
        });

        logger.info("取消点击");
      },
      onTapUp: (tapDownDetails) {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = Colors.white;
          });

          if (context.mounted) {
            if (widget.link != null) {
              Navigator.pushNamed(context, widget.link!);
            }

            if (widget.onPressed != null) {
              widget.onPressed!();
            }
          }
        });

        logger.info("弹起");
      },
      child: Container(
        height: widget.height ?? 105.0.w,
        width: 750.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: containerColor,
          border: Border(
            bottom: BorderSide(
              color: widget.underline
                  ? const Color.fromARGB(255, 242, 242, 242)
                  : Colors.transparent,
              width: 1.5.w,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: widget.title is String
            ? Text(
                widget.title as String,
                style: TextStyle(
                  color: widget.color ?? Colors.black,
                  height: 1.08,
                  fontSize: fontSizeScale(32.0.w),
                  decoration: TextDecoration.none,
                  fontFamily: "AlibabaPuHuiTi",
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : widget.title as Widget,
      ),
    );
  }
}
