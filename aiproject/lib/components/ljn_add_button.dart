import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/tools/ljn_logger.dart';
import 'package:spicychat/tools/ljn_tools.dart';

class LJNAddButton extends StatefulWidget {
  final String title;
  final Color? color;
  final Color? backgroundColor;
  final String? link;
  final bool? readonly;
  final Function? onTap;

  const LJNAddButton(
      {super.key,
      required this.title,
      this.color,
      this.backgroundColor,
      this.readonly,
      this.link,
      this.onTap});

  @override
  State<LJNAddButton> createState() => _LJNAddButtonState();
}

class _LJNAddButtonState extends State<LJNAddButton> {
  // bool isClicked = false;
  late Color originContainerColor;
  late Color containerColor;
  @override
  void initState() {
    super.initState();

    // 判断是否有 backgroundColor，若没有，则使用默认颜色
    originContainerColor =
        widget.backgroundColor ?? AppColors.neutralGrey6;

    setState(() {
      containerColor = originContainerColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color fontColor = Colors.white;
    if (widget.color is Color) {
      fontColor = widget.color!;
    }

    return GestureDetector(
      onTapDown: (tapDownDetails) {
        if (widget.readonly == true) return;

        setState(() {
          containerColor = darkenColor(originContainerColor, 0.11);
        });
      },
      onTapCancel: () {
        setState(() {
          containerColor = originContainerColor;
        });

        logger.info("取消点击");
      },
      onTapUp: (tapDownDetails) {
        if (widget.readonly == true) return;

        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = originContainerColor;
          });

          if (context.mounted) {
            if (widget.link == 'back') {
              Navigator.of(context).pop();
            } else if (widget.link != null) {
              Navigator.pushNamed(context, widget.link!);
            }
          }
        });

        logger.info("弹起");
        if (widget.onTap is Function) {
          widget.onTap!();
        }
      },
      child: Container(
        width: 142.w,
        height: 57.w,
        alignment: Alignment.center,
        // margin: EdgeInsets.only(right: 25.w),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10.w),
          ),
        ),
        child: Text(
          widget.title,
          style: TextStyle(color: fontColor, fontSize: 25.w),
        ),
      ),
    );
  }
}
