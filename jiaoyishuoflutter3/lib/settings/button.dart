// 功能列表
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNButton extends StatefulWidget {
  final String id;
  final String? icon;
  final double? height;
  final String title;
  final String? link;
  final bool underline;
  final Object? showStyle;

  const LJNButton({
    super.key,
    required this.id,
    this.icon,
    this.height,
    required this.title,
    this.link,
    required this.underline,
    this.showStyle,
  });

  @override
  State<LJNButton> createState() => _LJNButtonState();
}

class _LJNButtonState extends State<LJNButton> {
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

          if (mounted) {
            if (widget.link != null) {
              Navigator.pushNamed(context, widget.link!);
            }
          }
        });

        logger.info("弹起");
      },
      child: Container(
        height: widget.height ?? 105.0.w,
        width: 750.w,
        color: containerColor,
        alignment: Alignment.center,
        child: Text(
          widget.title,
          style: TextStyle(
            height: 1.08,
            fontSize: fontSizeScale(32.0.w),
            fontFamily: "AlibabaPuHuiTi",
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
