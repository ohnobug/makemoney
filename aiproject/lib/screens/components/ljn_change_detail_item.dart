// 功能列表
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/tools/ljn_logger.dart';
import 'package:spicychat/tools/ljn_tools.dart';

class LJNChangeDetailItem extends StatefulWidget {
  final String icon;
  final String title;
  final String link;
  final double change;
  final bool underline;
  final int? showStyle;
  final Function()? onPressed;

  const LJNChangeDetailItem({
    super.key,
    required this.icon,
    required this.title,
    required this.link,
    required this.change,
    required this.underline,
    this.showStyle,
    this.onPressed,
  });

  @override
  State<LJNChangeDetailItem> createState() => _LJNChangeDetailItemState();
}

class _LJNChangeDetailItemState extends State<LJNChangeDetailItem> {
  // bool isClicked = false;
  Color containerColor = AppColors.neutralWhite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
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
          widget.onPressed!();
        });

        logger.info("弹起");
      },
      child: Container(
        height: 150.0.w,
        padding: const EdgeInsets.only(left: 40.0, right: 40.0).w,
        decoration: widget.underline
            ? BoxDecoration(
                color: containerColor,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.neutralGrey6,
                    width: 1.5.w,
                    style: BorderStyle.solid,
                  ),
                ),
              )
            : BoxDecoration(
                color: containerColor,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.transparent,
                    width: 1.5.w,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
        child: Row(
          children: [
            // 头像
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(85.0.w), // Adjust the radius as needed
              child: Image.asset(
                assetPath(widget.icon),
                width: 86.0.w,
                height: 86.0.w,
                cacheHeight: 170.w.toInt(),
                cacheWidth: 170.w.toInt(),
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 25.w),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 35.w,
                  ),
                  // 商家与支付
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          height: 1.08,
                          fontSize: fontSizeScale(30.0.w),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      widget.change > 0
                          ? Text(
                              '+${widget.change}',
                              style: TextStyle(
                                  height: 1.08,
                                  fontSize: fontSizeScale(30.0.w),
                                  color: AppColors.accentYellowDark4,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "LJNFont"),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : Text(
                              '${widget.change}',
                              style: TextStyle(
                                  height: 1.08,
                                  fontSize: fontSizeScale(30.0.w),
                                  color: AppColors.neutralBlack,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "LJNFont"),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                    ],
                  ),
                  SizedBox(
                    height: 18.w,
                  ),
                  // 时间与余额
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "12月5日 12:07",
                        style: TextStyle(
                          height: 1.08,
                          color: AppColors.neutralGrey64,
                          fontSize: fontSizeScale(25.0.w),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "零钱余额 1565.06",
                        style: TextStyle(
                          height: 1.08,
                          color: AppColors.neutralGrey64,
                          fontSize: fontSizeScale(25.0.w),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
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
