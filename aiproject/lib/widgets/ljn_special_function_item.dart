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

// =========================================================================
// ====================    这里是完整的、修正后的 State 类    ====================
// =========================================================================
class _LJNSpecialFunctionItemState extends State<LJNSpecialFunctionItem> {
  // 唯一的内部状态：只记录该项是否被用户按下。
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // 核心修正：在 build 方法内部获取所有依赖于外部环境（如 Theme 或 widget 属性）的值。
    ThemeData theme = Theme.of(context);

    final bool tapEffect = widget.tapEffect ?? true;
    final bool isTappable = widget.link != null && tapEffect;

    // 1. 定义不同状态下的颜色
    final Color normalColor = theme.listTileTheme.tileColor!;
    final Color pressedColor = theme.listTileTheme.selectedTileColor!;

    // 2. 根据内部状态 _isPressed，动态地计算出当前应该显示的背景颜色。
    final Color currentColor =
        (_isPressed && isTappable) ? pressedColor : normalColor;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // onTapDown 只负责更新内部状态
      onTapDown: (_) {
        if (!isTappable) return;

        setState(() => _isPressed = true);
      },
      // onTapCancel 只负责更新内部状态
      onTapCancel: () {
        if (!isTappable) return;

        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      // onTapUp 负责恢复状态并执行操作
      onTapUp: (_) {
        if (!isTappable) return;

        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });

          if (context.mounted && widget.link != null) {
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, widget.link!);
          }
        });
      },
      child: Container(
        height: widget.height,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0).w,
        decoration: BoxDecoration(
          // 使用在 build 方法开头计算出的正确颜色
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
        child: Row(
          children: [
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
                    widget.subTitle!,
                  ]
                ],
              ),
            ),
            if (widget.showStyle != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: widget.showStyle!,
              ),
            if (widget.link != null)
              Container(
                width: 30.w,
                margin:
                    EdgeInsets.only(left: 10.w), // Add left margin for spacing
                child: Icon(
                  const IconData(
                    0xed9d,
                    fontFamily: 'Iconfont',
                  ),
                  size: 30.0.w,
                  // 使用主题感知的图标颜色
                  color: theme.colorScheme.onSurface.withAlpha(100),
                ),
              )
          ],
        ),
      ),
    );
  }
}
