// 功能按钮
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNFunctionItemButton extends StatefulWidget {
  final Icon? icon;
  final String title;
  final bool underline;
  final String? link;

  const LJNFunctionItemButton({
    super.key,
    this.icon,
    required this.title,
    required this.underline,
    this.link,
  });

  @override
  State<LJNFunctionItemButton> createState() => _LJNFunctionItemButtonState();
}

class _LJNFunctionItemButtonState extends State<LJNFunctionItemButton> {
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
        height: 105.w,
        width: 750.w,
        decoration: BoxDecoration(
            color: containerColor,
            border: Border(
                bottom: BorderSide(
              color: const Color.fromARGB(255, 242, 242, 242),
              width: 1.5.w,
              style: BorderStyle.solid,
            ))),
        child: Center(
            child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            if (widget.icon != null)
              WidgetSpan(
                style: TextStyle(fontSize: fontSizeScale(35.w), height: 0.8),
                child: widget.icon as Icon,
              ),
            WidgetSpan(
              child: SizedBox(width: 10.w), // 图标和文本之间的间距
            ),
            TextSpan(
              text: widget.title,
              style: TextStyle(
                  height: 1.08,
                  fontSize: fontSizeScale(30.w),
                  color: const Color.fromARGB(255, 58, 81, 124)),
            )
          ]),
        )),
      ),
    );
  }
}
