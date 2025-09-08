// 功能列表
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

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

  const LJNFunctionItem({
    super.key,
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
    this.onPress,
  });

  @override
  State<LJNFunctionItem> createState() => _LJNFunctionItemState();
}

class _LJNFunctionItemState extends State<LJNFunctionItem> {
  // bool isClicked = false;
  late Color containerColor;
  late bool tapEffect;
  late Color originContainerColor;

  @override
  void initState() {
    super.initState();

    tapEffect = widget.tapEffect ?? true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 在这里进行依赖于 context 的初始化
    originContainerColor =
        widget.backgroundColor ?? Theme.of(context).listTileTheme.tileColor!;
    // 直接赋值，不需要 setState
    containerColor = originContainerColor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        if (tapEffect == false) return;
        setState(() {
          containerColor = Theme.of(context).listTileTheme.selectedTileColor!;
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
                    bottom: widget.underline
                        ? (Theme.of(context).listTileTheme.shape
                                as RoundedRectangleBorder)
                            .side
                        : BorderSide.none,
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
                                  fontSize: fontSizeScale(32.0.w),
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
                                // color: AppColors.accentRedPure,
                                alignment: Alignment.centerRight,
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  widget.showStyle as String,
                                  style: TextStyle(
                                    // height: 1.08,
                                    fontSize: fontSizeScale(30.w),
                                    color: AppColors.neutralDarkGrey7,
                                  ),
                                ),
                              ),
                            )
                          : widget.showStyle as Widget,
                    if ([null, true].contains(widget.showLinkIcon) &&
                        widget.link != null)
                      Container(
                        // color: AppColors.accentRedPure,
                        width: 30.w,
                        height: widget.height ?? 105.0.w,
                        margin: const EdgeInsets.only(left: 10, right: 32).w,
                        child: Icon(
                          const IconData(
                            0xed9d,
                            fontFamily: 'Iconfont',
                          ),
                          size: 29.0.w,
                          color: AppColors.neutralGrey50,
                        ),
                      )
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
