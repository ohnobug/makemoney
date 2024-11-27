// 功能列表
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNVideoFunctionItem extends StatefulWidget {
  final String id;
  final String? icon;
  final double? height;
  final String title;
  final String? link;
  final bool underline;
  final Widget? showStyle;

  const LJNVideoFunctionItem({
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
  State<LJNVideoFunctionItem> createState() => _LJNVideoFunctionItemState();
}

class _LJNVideoFunctionItemState extends State<LJNVideoFunctionItem> {
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
        padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
        color: containerColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    // color: Colors.red,
                    border: Border(
                        bottom: BorderSide(
                  color: widget.underline
                      ? const Color.fromARGB(255, 242, 242, 242)
                      : Colors.transparent,
                  width: 1.5.w,
                  style: BorderStyle.solid,
                ))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 标题
                    Container(
                        // color: Colors.red,
                        padding: EdgeInsets.only(top: 38.w),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(30.0.w),
                            // fontFamily: "AlibabaPuHuiTi",
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),

                    widget.showStyle!,

                    Container(
                        width: 27.w,
                        margin: const EdgeInsets.only(right: 32, top: 133).w,
                        child: Icon(
                          const IconData(
                            0xed9d,
                            fontFamily: 'Iconfont',
                          ),
                          size: 27.0.w,
                          color: const Color.fromARGB(255, 175, 175, 175),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
