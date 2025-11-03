import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/tools/viga_tools.dart';

class VigaChangeAccountButton extends StatefulWidget {
  final String title;
  final Color? color;
  final Color? backgroundColor;
  final String? link;
  final bool? readonly;
  final Function? ontap;

  const VigaChangeAccountButton({
    super.key,
    required this.title,
    this.color,
    this.backgroundColor,
    this.readonly,
    this.link,
    this.ontap,
  });

  @override
  State<VigaChangeAccountButton> createState() =>
      _VigaChangeAccountButtonState();
}

class _VigaChangeAccountButtonState extends State<VigaChangeAccountButton> {
  // bool isClicked = false;
  late Color originContainerColor;
  late Color containerColor;
  @override
  void initState() {
    super.initState();

    // 判断是否有 backgroundColor，若没有，则使用默认颜色
    originContainerColor = widget.backgroundColor ?? AppColors.neutralGrey7;

    setState(() {
      containerColor = originContainerColor;
    });
  }

  @override
  void didUpdateWidget(VigaChangeAccountButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.backgroundColor != widget.backgroundColor) {
      originContainerColor = widget.backgroundColor!;

      setState(() {
        containerColor = originContainerColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color fontColor = AppColors.neutralDarkGrey19;
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
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = originContainerColor;
          });
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
            if (widget.ontap != null) {
              widget.ontap!();
            } else {
              if (widget.link == 'back') {
                context.pop();
              } else if (widget.link != null) {
                context.push(widget.link!);
              }
            }
          }
        });

        logger.info("弹起");
      },
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10.w),
          ),
        ),
        alignment: Alignment.center,
        width: 500.w,
        height: 90.w,
        child: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32.w,
            height: 1.08,
            color:
                widget.readonly == true ? AppColors.neutralGrey36 : fontColor,
          ),
        ),
      ),
    );
  }
}
