import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

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
  Color containerColor = AppColors.neutralWhite;
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
          containerColor = AppColors.neutralGrey18;
        });
      },
      onTapCancel: () {
        if (tapEffect == false) return;

        setState(() {
          containerColor = AppColors.neutralWhite;
        });

        logger.info("取消点击");
      },
      onTapUp: (tapDownDetails) {
        if (tapEffect == false) return;

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
        //  ?? 105.0.w
        // height: 105.0.w,
        height: widget.height,
        padding: const EdgeInsets.only(left: 30.0, right: 0.0, top: 20, bottom: 20).w,
        decoration: BoxDecoration(
          color: containerColor,
          border: Border(
            bottom: BorderSide(
              color: widget.underline
                  ? AppColors.neutralGrey6
                  : AppColors.transparent,
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
                    // color: AppColors.accentRedPure,
                    width: 500.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(32.0.w),
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
                          // color: AppColors.accentRedPure,
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
                      color: AppColors.accentRedPure,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.showStyle as String,
                            style: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(30.w),
                              color: AppColors.neutralDarkGrey7,
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
                  color: AppColors.neutralGrey50,
                ),
              )
          ],
        ),
      ),
    );
  }
}
