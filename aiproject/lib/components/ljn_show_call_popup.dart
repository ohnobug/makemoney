// 通话弹出
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/components/ljn_max_width_button.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';

void showCallPopup(BuildContext context, SystemState systemState) {
  double widthHeightRatio =
      MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;

  showModalBottomSheet(
    context: context,
    barrierColor: AppColors.blackTransparent47,
    // backgroundColor: Colors.red,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: widthHeightRatio > 1 || MediaQuery.of(context).size.height < 1102.w
            ? Radius.zero
            : Radius.circular(13.w),
      ),
    ),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        width: 750.w,
        height: 330.w,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          // color: Colors.red,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.w),
            topRight: Radius.circular(20.w),
          ),
        ),
        child: Column(
          children: [
            LJNMaxWidthButton(
              title: Text.rich(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                TextSpan(
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                      ),
                      child: Baseline(
                        baseline: 31.w,
                        baselineType: TextBaseline.alphabetic,
                        child: Icon(
                          const IconData(
                            0xe64f,
                            fontFamily: 'Iconfont',
                          ),
                          color: Colors.black,
                          size: 40.w,
                        ),
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(width: 20.w),
                    ),
                    TextSpan(
                      text: "视频通话",
                      style: TextStyle(
                        height: 1.08,
                        fontSize: 30.w,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              underline: true,
              // link: '/dial',
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/video_call',
                );
              },
            ),
            LJNMaxWidthButton(
              title: Text.rich(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                TextSpan(children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                    ),
                    child: Baseline(
                      baseline: 31.w,
                      baselineType: TextBaseline.alphabetic,
                      child: Icon(
                        const IconData(
                          0xe64c,
                          fontFamily: 'Iconfont',
                        ),
                        color: Colors.black,
                        size: 40.w,
                      ),
                    ),
                  ),
                  WidgetSpan(
                    child: SizedBox(width: 20.w),
                  ),
                  TextSpan(
                    text: "语音通话",
                    style: TextStyle(
                      height: 1.08,
                      fontSize: 30.w,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                    ),
                  ),
                ]),
              ),
              underline: true,
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/dial',
                );
              },
            ),
            Container(
              height: 15.w,
              color: AppColors.neutralGrey2,
            ),
            LJNMaxWidthButton(
              title: "取消",
              underline: false,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
