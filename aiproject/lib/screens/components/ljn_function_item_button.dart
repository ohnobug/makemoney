// 功能按钮
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/tools/ljn_logger.dart';
import 'package:spicychat/tools/ljn_tools.dart';

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
  Color containerColor = AppColors.neutralWhite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        setState(() {
          containerColor = AppColors.neutralGrey18;
        });
      },
      onTapCancel: () {
        setState(() {
          containerColor = AppColors.neutralWhite;
        });

        logger.info("取消点击");
      },
      onTapUp: (tapDownDetails) {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = AppColors.neutralWhite;
          });

          if (context.mounted) {
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
              color: AppColors.neutralGrey6,
              width: 1.5.w,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: Center(
          child: RichText(
            strutStyle:
                StrutStyle(fontSize: 35.w, forceStrutHeight: true, height: 1),
            // textAlign: TextAlign.center,
            text: TextSpan(children: [
              if (widget.icon != null)
                WidgetSpan(
                  // alignment: PlaceholderAlignment.bottom,
                  style: TextStyle(fontSize: fontSizeScale(35.w), height: 1),
                  child: Transform.translate(
                    offset: Offset(
                      0,
                      -(3.w),
                    ),
                    child: SizedBox(
                        width: 35.w,
                        height: 35.w,
                        // color: AppColors.accentRedPure,
                        child: widget.icon as Icon),
                  ),
                ),
              WidgetSpan(
                child: SizedBox(width: 5.w), // 图标和文本之间的间距
              ),
              TextSpan(
                text: widget.title,
                style: TextStyle(
                  // textBaseline: TextBaseline.ideographic,
                  height: 1.08,
                  fontSize: fontSizeScale(30.w),
                  color: AppColors.brandBlueDark4,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
