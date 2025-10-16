import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_text_spans.dart';

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
  // 唯一的内部状态：只记录该列表项是否被用户按下。
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // 核心修正：在 build 方法内部获取所有依赖于外部环境（如 Theme）的值。
    ThemeData theme = Theme.of(context);

    // 1. 定义不同状态下的颜色
    Color normalColor = theme.listTileTheme.tileColor!;
    Color pressedColor = theme.listTileTheme.selectedTileColor!;
    Color subtitleColor = theme.textTheme.bodySmall?.color ?? theme.hintColor;

    // 2. 根据内部状态 _isPressed，动态地计算出当前应该显示的背景颜色。
    Color currentColor = _isPressed ? pressedColor : normalColor;
    bool isTappable = widget.link != null || widget.onPressed != null;

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
          setState(() => _isPressed = false);
          if (mounted) {
            // 安全地调用 onPressed
            widget.onPressed?.call();
            if (widget.link != null) {
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, widget.link!);
            }
          }
        });
      },
      child: Container(
        width: 750.w,
        // 使用在 build 方法开头计算出的正确颜色
        color: currentColor,
        height: 135.0.w,
        padding: const EdgeInsets.only(left: 30.0).w,
        child: Row(
          children: [
            // 头像
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0.w),
              child: CachedNetworkImage(
                imageUrl: widget.avatar,
                width: 75.0.w,
                height: 75.0.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 23.w),
            // 右边区域
            Expanded(
              child: Container(
                decoration: BoxDecoration(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 标题
                          LJNTextSpans(
                            text: widget.title,
                            style: TextStyle(
                              fontSize: fontSizeScale(31.0.w),
                              color: theme.colorScheme.onSurface,
                              
                            ),
                          ),
                          SizedBox(height: 10.w),
                          // 消息
                          LJNTextSpans(
                            text: widget.message,
                            style: TextStyle(
                              fontSize: fontSizeScale(25.w),
                              // 使用主题感知的副标题颜色
                              color: subtitleColor,
                            ),
                            emojiStyle: TextStyle(
                              fontSize: fontSizeScale(25.w),
                              color: subtitleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.link != null)
                      Container(
                        padding: EdgeInsets.only(
                          left: 10.w,
                          right: 32.w,
                        ),
                        child: Icon(
                          const IconData(
                            0xed9d,
                            fontFamily: 'Iconfont',
                          ),
                          size: 30.0.w,
                          color: theme.colorScheme.onSurface.withAlpha(100),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
