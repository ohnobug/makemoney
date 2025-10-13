import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

class LJNSpecialFunctionItem extends StatefulWidget {
  final double? height;
  final String title;
  final String? link;
  final bool underline;
  final Widget? showStyle;
  final Widget? subTitle;
  final bool? tapEffect;

  const LJNSpecialFunctionItem({
    super.key,
    this.height,
    required this.title,
    this.link,
    required this.underline,
    this.showStyle,
    this.subTitle,
    this.tapEffect,
  });

  @override
  State<LJNSpecialFunctionItem> createState() => _LJNSpecialFunctionItemState();
}

class _LJNSpecialFunctionItemState extends State<LJNSpecialFunctionItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final bool tapEffect = widget.tapEffect ?? true;
    final bool isTappable = widget.link != null && tapEffect;

    final Color normalColor = theme.listTileTheme.tileColor!;
    final Color pressedColor = theme.listTileTheme.selectedTileColor!;
    final Color currentColor =
        (_isPressed && isTappable) ? pressedColor : normalColor;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        if (!isTappable) return;
        setState(() => _isPressed = true);
      },
      onTapCancel: () {
        if (!isTappable) return;
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) setState(() => _isPressed = false);
        });
      },
      onTapUp: (_) {
        if (!isTappable) return;
        Future.delayed(const Duration(milliseconds: 50), () {
          if (context.mounted) {
            setState(() => _isPressed = false);
            if (widget.link != null) {
              Navigator.pushNamed(context, widget.link!);
            }
          }
        });
      },
      child: Container(
        height: widget.height,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0).w,
        decoration: BoxDecoration(
          color: currentColor,
          border: Border(
            bottom: widget.underline
                ? BorderSide(
                    color: theme.dividerColor,
                    width: 1.0.w,
                  )
                : BorderSide.none,
          ),
        ),
        // ======================= 核心修改在这里 =======================
        child: Row(
          children: [
            // 1. 【核心】将左侧的 Column 用 Expanded 包裹
            //    这会给 Column 提供一个有限的垂直约束，解决无限高度问题。
            //    同时，它也会让标题部分占据所有可用的水平空间，直到遇到 Spacer。
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: fontSizeScale(32.0.w),
                      fontFamily: "AlibabaPuHuiTi",
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.subTitle != null) ...[
                    SizedBox(height: 14.w),
                    // 副标题不需要再用 Flexible，因为 Column 已经有了有限高度
                    widget.subTitle!,
                  ]
                ],
              ),
            ),

            // 2. Spacer 保持不变，用于推开右侧组件
            // const Spacer(), // 注意：当左侧使用 Expanded 时，我们不再需要 Spacer

            // 3. 右侧的自定义组件（例如 Switch）
            if (widget.showStyle != null) widget.showStyle!,

            // 4. 右侧的箭头图标
            if (widget.link != null)
              Container(
                margin: EdgeInsets.only(left: 10.w),
                child: Icon(
                  const IconData(0xed9d, fontFamily: 'Iconfont'),
                  size: 30.0.w,
                  color: theme.colorScheme.onSurface.withAlpha(100),
                ),
              )
          ],
        ),
        // ======================= 修改结束 =======================
      ),
    );
  }
}
