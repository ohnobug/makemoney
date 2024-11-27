// 功能列表
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNFunctionItem extends StatefulWidget {
  final String? icon;
  final double? height;
  final Object? title;
  final String? link;
  final bool underline;
  final Object? showStyle;
  final bool? tapEffect;
  final Color? backgroundColor;

  const LJNFunctionItem(
      {super.key,
      this.icon,
      this.height,
      required this.title,
      this.link,
      required this.underline,
      this.showStyle,
      this.tapEffect,
      this.backgroundColor});

  @override
  State<LJNFunctionItem> createState() => _LJNFunctionItemState();
}

class _LJNFunctionItemState extends State<LJNFunctionItem> {
  // bool isClicked = false;
  late Color originContainerColor;
  late Color containerColor;
  late bool tapEffect;

  @override
  void initState() {
    super.initState();

    originContainerColor = widget.backgroundColor ?? Colors.white;

    setState(() {
      containerColor = originContainerColor;
      tapEffect = widget.tapEffect ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        if (tapEffect == false) return;
        setState(() {
          containerColor = darkenColor(originContainerColor, 0.1);
        });
      },
      onTapCancel: () {
        if (tapEffect == false) return;
        setState(() {
          containerColor = originContainerColor;
        });

        logger.info("取消点击");
      },
      onTapUp: (tapDownDetails) {
        if (tapEffect == false) return;
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = originContainerColor;
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
            if (widget.icon != null) ...[
              // 头像
              Container(
                width: 40.0.w,
                height: 40.0.w,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  // borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(assetPath(widget.icon!)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 25.w)
            ],
            Expanded(
              child: Container(
                height: double.infinity,
                // height: double.infinity,
                // width: 400.w,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: widget.underline
                      ? const Color.fromARGB(255, 242, 242, 242)
                      : Colors.transparent,
                  width: 1.5.w,
                  style: BorderStyle.solid,
                ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.title is String
                        ?
                        // 标题
                        Text(
                            widget.title as String,
                            style: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(32.0.w),
                              fontFamily: "AlibabaPuHuiTi",
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                          )
                        : widget.title as Widget,
                    if (widget.showStyle != null)
                      widget.showStyle is String
                          ? Expanded(
                              child: Container(
                                  padding:
                                      const EdgeInsets.only(right: 10, left: 10)
                                          .w,
                                  // color: Colors.red,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.showStyle as String,
                                          style: TextStyle(
                                            height: 1.08,
                                            fontSize: fontSizeScale(30.w),
                                            color: const Color.fromARGB(
                                                255, 83, 83, 83),
                                          ),
                                        )
                                      ])))
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
