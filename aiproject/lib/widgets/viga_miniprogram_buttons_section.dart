// /lib/widgets/viga_miniprogram_buttons_section.dart

// 小程序按钮项组
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/tools/viga_tools.dart';
import 'package:vigaviga/widgets/viga_miniprogram_button.dart';

class VigaMiniprogramButtonsSection extends StatelessWidget {
  final String? title;
  final List<VigaMiniprogramButton> buttons;
  final Widget? rightWidget;
  final String? moreUrl;

  const VigaMiniprogramButtonsSection(
      {super.key,
      required this.buttons,
      this.title,
      this.rightWidget,
      this.moreUrl});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(
        top: 16,
        bottom: 0,
        left: 18,
        right: 18,
      ).w,
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16.0).w,
      ),
      padding: const EdgeInsets.only(bottom: 0).w,
      // color: AppColors.accentRedPure,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 标题
          if (title != null)
            Container(
              height: 30.w,
              margin: EdgeInsets.only(
                top: 25,
                left: 20,
                bottom: 25,
              ).w,
              // color: Colors.yellow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(26.w),
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  if (rightWidget != null) rightWidget!,
                ],
              ),
            )
          else
            SizedBox(height: 20.w),

          // 使用 SizedBox 控制 GridView 的大小
          Container(
            // color: AppColors.brandTealVibrant,
            margin: const EdgeInsets.all(0),
            padding: EdgeInsets.only(
              bottom: 16,
              left: 16.0,
              right: 16,
            ).w,
            child: GridView.builder(
              primary: false,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(), // 禁用滚动
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5.w,
                mainAxisSpacing: 5.w,
                childAspectRatio: 0.95, // 保持宽高比为1，如果觉得太挤可以调整为例如 0.9
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                return buttons[index];
              },
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
