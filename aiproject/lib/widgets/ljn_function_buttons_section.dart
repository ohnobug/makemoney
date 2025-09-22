// /lib/widgets/ljn_function_buttons_section.dart

// 小程序按钮项组
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_function_button.dart';

class LJNFunctionButtonsSection extends StatelessWidget {
  final String title;
  final List<LJNFunctionButton> buttons;
  final Widget? rightWidget;

  const LJNFunctionButtonsSection({
    super.key,
    required this.title,
    required this.buttons,
    this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 16,
        bottom: 0,
        left: 18,
        right: 18,
      ).w,
      decoration: BoxDecoration(
        color: AppColors.neutralWhite,
        borderRadius: BorderRadius.circular(16.0).w,
      ),
      padding: const EdgeInsets.only(bottom: 0).w,
      // color: AppColors.accentRedPure,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 标题
          Container(
            height: 30.w,
            margin: EdgeInsets.only(
              top: 15,
              left: 20,
              bottom: 5
            ).w,
            // color: Colors.yellow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    height: 1.08,
                    fontSize: fontSizeScale(26.w),
                    color: Theme.of(context).colorScheme.onSurface.withAlpha(200),
                  ),
                ),
                if (rightWidget != null) rightWidget!,
              ],
            ),
          ),

          SizedBox(
            height: 15.w,
          ),

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
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 10.w,
                childAspectRatio: 1, // 保持宽高比为1，如果觉得太挤可以调整为例如 0.9
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
