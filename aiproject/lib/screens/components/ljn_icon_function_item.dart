import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/tools/ljn_logger.dart';
import 'package:spicychat/tools/ljn_tools.dart';

class LJNIconFunctionItem extends StatefulWidget {
  final String avatar;
  final String title;
  final String message;
  final bool underline;
  final String? link;
  final Function()? onPressed;

  const LJNIconFunctionItem({
    super.key,
    required this.avatar,
    required this.title,
    required this.message,
    required this.underline,
    this.link,
    this.onPressed,
  });

  @override
  State<LJNIconFunctionItem> createState() => _LJNIconFunctionItem();
}

class _LJNIconFunctionItem extends State<LJNIconFunctionItem> {
  Color containerColor = AppColors.neutralWhite;
  // Color containerColor = AppColors.transparent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          containerColor = AppColors.neutralGrey18;
        });
      },
      onTapCancel: () {
        setState(() {
          containerColor = AppColors.neutralWhite;
        });

        logger.info("取消点击");
      },
      onTapUp: (tapDownDetails) {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = AppColors.neutralWhite;
          });

          if (context.mounted) {
            if (widget.link != null) {
              Navigator.pushNamed(context, widget.link!);
            }
          }
          widget.onPressed!();
        });

        logger.info("弹起");
      },
      child: Container(
        width: 750.w,
        color: containerColor,
        height: 135.0.w,
        padding: const EdgeInsets.only(left: 30.0).w,
        child: Row(
          children: [
            // 头像
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(8.0.w), // Adjust the radius as needed
              child: Image.asset(
                assetPath(widget.avatar),
                width: 75.0.w,
                height: 75.0.w,
                cacheHeight: 150.w.toInt(),
                cacheWidth: 150.w.toInt(),
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 23.w),

            // 右边区域
            Container(
              width: 622.w,
              // alignment: Alignment.center,
              decoration: BoxDecoration(
                // color: AppColors.accentRedPure,
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
                children: [
                  SizedBox(
                    width: 560.w,
                    // color: AppColors.accentRedPure,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 8.w,
                        ),

                        // 标题
                        RichText(
                          strutStyle: StrutStyle(
                            height: 1.08,
                            forceStrutHeight: true,
                            fontSize: 31.w,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: buildTextSpans(
                              widget.title,
                              TextStyle(
                                height: 1.08,
                                fontSize: fontSizeScale(31.0.w),
                                color: AppColors.neutralBlack,
                                fontFamily: "AlibabaPuHuiTi",
                              ),
                              TextStyle(
                                height: 1.08,
                                fontSize: fontSizeScale(31.w),
                                fontFamily: "NotoColorEmoji-Regular",
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10.w),

                        // 好友消息
                        RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: buildTextSpans(
                              widget.message,
                              TextStyle(
                                height: 1.08,
                                fontSize: fontSizeScale(25.w),
                                color: AppColors.neutralGrey45,
                              ),
                              TextStyle(
                                height: 1.08,
                                fontSize: fontSizeScale(25.w),
                                color: AppColors.neutralGrey45,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.link != null)
                    Container(
                      // color: AppColors.accentRedPure,
                      width: 30.w,
                      height: 135.0.w,
                      margin: const EdgeInsets.only(right: 32).w,
                      alignment: Alignment.center,
                      child: Baseline(
                        baseline: 33.w,
                        baselineType: TextBaseline.alphabetic,
                        child: Icon(
                          const IconData(
                            0xed9d,
                            fontFamily: 'Iconfont',
                          ),
                          size: 30.0.w,
                          color: AppColors.neutralGrey50,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
