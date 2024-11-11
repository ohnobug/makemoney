import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/logger.dart';

class LJNChangeAccountButton extends StatefulWidget {
  final String title;
  final String? link;
  final bool? readonly;

  const LJNChangeAccountButton({
    super.key,
    required this.title,
    this.readonly,
    this.link,
  });

  @override
  State<LJNChangeAccountButton> createState() => _LJNChangeAccountButtonState();
}

class _LJNChangeAccountButtonState extends State<LJNChangeAccountButton> {
  // bool isClicked = false;
  Color containerColor = const Color.fromARGB(255, 241, 241, 241);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        if (widget.readonly == true) return;

        setState(() {
          containerColor = const Color.fromARGB(255, 206, 206, 206);
        });
      },
      onTapCancel: () {
        setState(() {
          containerColor = Colors.white;
        });

        logger.info("取消点击");
      },
      onTapUp: (tapDownDetails) {
        if (widget.readonly == true) return;

        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = const Color.fromARGB(255, 241, 241, 241);
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
              fontSize: 30.w,
              height: 1.08,
              color: widget.readonly == true
                  ? const Color.fromARGB(255, 184, 184, 184)
                  : const Color.fromARGB(255, 41, 41, 41)),
        ),
      ),
    );
  }
}
