import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_logger.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_tools.dart';

class LJNSpecialFunctionItem extends StatefulWidget {
  final double? height;
  final String title;
  final String? link;
  final bool underline;
  final Widget? showStyle;
  final Widget? subTitle;
  final bool? tapEffect;

  const LJNSpecialFunctionItem(
      {super.key,
      this.height,
      required this.title,
      this.link,
      required this.underline,
      this.showStyle,
      this.subTitle,
      this.tapEffect});

  @override
  State<LJNSpecialFunctionItem> createState() => _LJNSpecialFunctionItemState();
}

class _LJNSpecialFunctionItemState extends State<LJNSpecialFunctionItem> {
  // bool isClicked = false;
  Color containerColor = Colors.white;
  late bool tapEffect;

  @override
  void initState() {
    super.initState();

    setState(() {
      tapEffect = widget.tapEffect ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        if (tapEffect == false) return;

        setState(() {
          containerColor = const Color.fromARGB(255, 229, 229, 229);
        });
      },
      onTapCancel: () {
        if (tapEffect == false) return;

        setState(() {
          containerColor = Colors.white;
        });

        logger.info("取消点击");
      },
      onTapUp: (tapDownDetails) {
        if (tapEffect == false) return;

        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = Colors.white;
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
        height: widget.height ?? 105.0.w,
        padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 标题
                  SizedBox(
                    // flex: 1,
                    // color: Colors.red,
                    width: 500.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            height: 1.08,
                            fontSize: ljnFontSizeScale(32.0.w),
                            fontFamily: "AlibabaPuHuiTi",
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 14.w,
                        ),
                        Container(
                          padding: const EdgeInsets.all(0),
                          // color: Colors.red,
                          child: widget.subTitle,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (widget.showStyle != null)
              widget.showStyle is String
                  ? Container(
                      padding: const EdgeInsets.only(right: 10, left: 10).w,
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.showStyle as String,
                            style: TextStyle(
                              height: 1.08,
                              fontSize: ljnFontSizeScale(30.w),
                              color: const Color.fromARGB(255, 83, 83, 83),
                            ),
                          )
                        ],
                      ),
                    )
                  : widget.showStyle as Widget,
            if (widget.link != null)
              Container(
                width: 30.w,
                margin: const EdgeInsets.only(right: 32).w,
                child: Icon(
                  const IconData(
                    0xed9d,
                    fontFamily: 'Iconfont',
                  ),
                  size: 30.0.w,
                  color: const Color.fromARGB(255, 164, 164, 164),
                ),
              )
          ],
        ),
      ),
    );
  }
}
