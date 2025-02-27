// 功能列表
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_logger.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_tools.dart';

class LJNFunctionItem extends StatefulWidget {
  final String? icon;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Object? title;
  final String? link;
  final bool? showLinkIcon;
  final bool underline;
  final Object? showStyle;
  final bool? tapEffect;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final Function? onPress;

  const LJNFunctionItem(
      {super.key,
      this.icon,
      this.height,
      this.padding,
      required this.title,
      this.link,
      this.showLinkIcon,
      required this.underline,
      this.showStyle,
      this.tapEffect,
      this.backgroundColor,
      this.margin,
      this.onPress});

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

          if (context.mounted) {
            if (widget.link != null) {
              Navigator.pushNamed(context, widget.link!);
            }

            if (widget.onPress != null) {
              widget.onPress!();
            }
          }
        });

        logger.info("弹起");
      },
      child: Container(
        constraints: BoxConstraints(maxHeight: widget.height ?? 105.0.w),
        // height: widget.height ?? 105.0.w,
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
                margin: widget.margin ??
                    const EdgeInsets.only(left: 30.0, right: 0.0).w,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  // borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(
                      assetPath(widget.icon!),
                    ),
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
                    ),
                  ),
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 标题
                    widget.title is String
                        ? Expanded(
                            child: Container(
                              padding: widget.icon == null
                                  ? widget.padding ??
                                      const EdgeInsets.only(
                                              left: 30.0, right: 0.0)
                                          .w
                                  : const EdgeInsets.all(0),
                              child: Text(
                                widget.title as String,
                                style: TextStyle(
                                  height: 1.08,
                                  fontSize: ljnFontSizeScale(32.0.w),
                                  fontFamily: "AlibabaPuHuiTi",
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        : widget.title as Widget,
                    if (widget.showStyle != null)
                      widget.showStyle is String
                          ? Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 10).w,
                                // color: Colors.red,
                                alignment: Alignment.centerRight,
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  widget.showStyle as String,
                                  style: TextStyle(
                                    // height: 1.08,
                                    fontSize: ljnFontSizeScale(30.w),
                                    color:
                                        const Color.fromARGB(255, 83, 83, 83),
                                  ),
                                ),
                              ),
                            )
                          : widget.showStyle as Widget,
                    if ([null, true].contains(widget.showLinkIcon) &&
                        widget.link != null)
                      Container(
                          // color: Colors.red,
                          width: 30.w,
                          height: widget.height ?? 105.0.w,
                          margin: const EdgeInsets.only(left: 10, right: 32).w,
                          child: Icon(
                            const IconData(
                              0xed9d,
                              fontFamily: 'Iconfont',
                            ),
                            size: 29.0.w,
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
