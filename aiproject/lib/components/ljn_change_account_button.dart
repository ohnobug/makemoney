import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNChangeAccountButton extends StatefulWidget {
  final String title;
  final Color? color;
  final Color? backgroundColor;
  final String? link;
  final bool? readonly;

  const LJNChangeAccountButton({
    super.key,
    required this.title,
    this.color,
    this.backgroundColor,
    this.readonly,
    this.link,
  });

  @override
  State<LJNChangeAccountButton> createState() => _LJNChangeAccountButtonState();
}

class _LJNChangeAccountButtonState extends State<LJNChangeAccountButton> {
  // bool isClicked = false;
  late Color originContainerColor;
  late Color containerColor;
  @override
  void initState() {
    super.initState();

    // 判断是否有 backgroundColor，若没有，则使用默认颜色
    originContainerColor =
        widget.backgroundColor ?? const Color.fromARGB(255, 241, 241, 241);

    setState(() {
      containerColor = originContainerColor;
    });
  }

  @override
  void didUpdateWidget(LJNChangeAccountButton oldWidget) {
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
    Color fontColor = const Color.fromARGB(255, 41, 41, 41);
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
      },
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
        ),
        alignment: Alignment.center,
        width: 350.w,
        height: 90.w,
        child: Text(
          widget.title,
          style: TextStyle(
              fontSize: 32.w,
              height: 1.08,
              color: widget.readonly == true
                  ? const Color.fromARGB(255, 184, 184, 184)
                  : fontColor),
        ),
      ),
    );
  }
}
