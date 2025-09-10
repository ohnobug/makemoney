// 功能按钮
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

class LJNFunctionItemButton extends StatefulWidget {
  final Icon? icon;
  final String title;
  final bool underline;
  final String? link;

  const LJNFunctionItemButton({
    super.key,
    this.icon,
    required this.title,
    required this.underline,
    this.link,
  });

  @override
  State<LJNFunctionItemButton> createState() => _LJNFunctionItemButtonState();
}

class _LJNFunctionItemButtonState extends State<LJNFunctionItemButton> {
  // 唯一的内部状态：只记录该按钮是否被用户按下。
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // 核心修正：在 build 方法内部获取所有依赖于外部环境（如 Theme）的值。
    ThemeData theme = Theme.of(context);

    // 1. 定义不同状态下的颜色
    Color normalColor = theme.listTileTheme.tileColor!;
    Color pressedColor = theme.listTileTheme.selectedTileColor!;
    Color textColor =
        theme.colorScheme.primary; // Use primary color for actionable text
    Color dividerColor = theme.dividerColor; // Use divider color for borders

    // 2. 根据内部状态 _isPressed，动态地计算出当前应该显示的背景颜色。
    Color currentColor = _isPressed ? pressedColor : normalColor;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // onTapDown 只负责更新内部状态
      onTapDown: (_) {
        if (widget.link == null) return;
        setState(() => _isPressed = true);
      },
      // onTapCancel 只负责更新内部状态
      onTapCancel: () {
        if (widget.link == null) return;
        setState(() => _isPressed = false);
      },
      // onTapUp 负责恢复状态并执行操作
      onTapUp: (_) {
        if (widget.link == null) return;
        // 1. 立即恢复视觉状态
        setState(() => _isPressed = false);
        // 2. 延迟执行导航
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted && widget.link != null) {
            Navigator.pushNamed(context, widget.link!);
          }
        });
      },
      child: Container(
        height: 105.w,
        width: 750.w,
        decoration: BoxDecoration(
          // 使用在 build 方法开头计算出的正确颜色
          color: currentColor,
          border: Border(
            bottom: widget.underline
                ? BorderSide(color: dividerColor, width: 1.5.w)
                : BorderSide.none,
          ),
        ),
        child: Center(
          child: RichText(
            strutStyle:
                StrutStyle(fontSize: 35.w, forceStrutHeight: true, height: 1),
            text: TextSpan(children: [
              if (widget.icon != null)
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    widget.icon!.icon,
                    // 确保图标颜色也跟随主题
                    color: textColor,
                    size: 35.w,
                  ),
                ),
              if (widget.icon != null)
                WidgetSpan(
                  child: SizedBox(width: 10.w), // 图标和文本之间的间距
                ),
              TextSpan(
                text: widget.title,
                style: TextStyle(
                  height: 1.08,
                  fontSize: fontSizeScale(30.w),
                  // 使用主题感知的文本颜色
                  color: textColor,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
