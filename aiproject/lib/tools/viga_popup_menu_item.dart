import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VigaPopupMenuItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;

  const VigaPopupMenuItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  State<VigaPopupMenuItem> createState() => _VigaPopupMenuItemState();
}

class _VigaPopupMenuItemState extends State<VigaPopupMenuItem> {
  // 唯一的内部状态：只记录该菜单项是否被用户按下。
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // 核心修正：在 build 方法内部获取所有依赖于外部环境（如此处的 Theme）的值。
    ThemeData theme = Theme.of(context);

    // 1. 定义未按下时的背景色
    const Color normalColor = Colors.transparent;

    // 2. 从当前主题获取按下时的背景色
    Color pressedColor = theme.listTileTheme.selectedTileColor!;

    // 3. 根据内部状态 _isPressed，动态地计算出当前应该显示的背景颜色。
    Color currentColor = _isPressed ? pressedColor : normalColor;

    return GestureDetector(
      // onTapDown 只负责更新内部状态
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      // onTapCancel 只负责更新内部状态
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      // onTapUp 负责恢复状态并执行操作
      onTapUp: (_) {
        // 延迟执行回调，让用户能看到颜色恢复的动画效果
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
          // 检查 widget 是否还在树上
          if (context.mounted) {
            widget.onTap?.call();
          }
        });
      },
      // 使用一个透明的容器来增大点击区域，并避免 GestureDetector 的一些默认行为
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 105.w,
        // 使用在 build 方法开头计算出的正确颜色
        color: currentColor,
        child: Row(
          children: [
            SizedBox(width: 10.w),
            // icon
            SizedBox(
              height: 105.w,
              width: 80.w,
              child: Center(
                child: Icon(
                  widget.icon,
                  color: theme.popupMenuTheme.iconColor,
                  size: theme.popupMenuTheme.iconSize,
                ),
              ),
            ),
            // 文字
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    // 从当前主题获取边框样式
                    bottom:
                        (theme.listTileTheme.shape as RoundedRectangleBorder)
                            .side,
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  // 从当前主题获取文本样式
                  style: theme.popupMenuTheme.textStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
