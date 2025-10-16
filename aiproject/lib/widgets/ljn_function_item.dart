// 功能列表
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_app_network_image.dart';

class LJNFunctionItem extends StatefulWidget {
  final String? icon;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Object? title;
  final String? link;
  final bool? showLinkIcon;
  final bool underline;
  final Object? showStyle;
  final bool? tapEffect;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final Function? onPress;

  const LJNFunctionItem({
    super.key,
    this.icon,
    this.height,
    this.padding,
    required this.title,
    this.link,
    this.showLinkIcon,
    required this.underline,
    this.showStyle,
    this.tapEffect,
    this.backgroundColor,
    this.margin,
    this.onPress,
  });

  @override
  State<LJNFunctionItem> createState() => _LJNFunctionItemState();
}

class _LJNFunctionItemState extends State<LJNFunctionItem> {
  // 唯一的内部状态：只用来记录该组件是否被用户按下。
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // 核心修正：在 build 方法内部获取所有依赖于外部环境（如 Theme 或 widget 属性）的值。
    // 这样每次UI刷新（包括主题切换），都能拿到最新的正确值。
    ThemeData theme = Theme.of(context);

    final bool tapEffect = widget.tapEffect ?? true;

    // 1. 决定原始背景色（未按下时）
    // 优先使用 widget 传入的 backgroundColor，如果没有则从当前主题中获取。
    final Color originContainerColor =
        widget.backgroundColor ?? theme.listTileTheme.tileColor!;

    // 2. 决定按下时的背景色
    final Color pressedContainerColor = theme.listTileTheme.selectedTileColor!;

    // 3. 根据内部状态 _isPressed 和是否启用点击效果，动态地计算出当前应该显示的背景颜色。
    final Color currentContainerColor = (_isPressed && tapEffect)
        ? pressedContainerColor
        : originContainerColor;

    return GestureDetector(
      // onTapDown 只负责更新内部状态
      onTapDown: (tapDownDetails) {
        if (!tapEffect) return;
        setState(() {
          _isPressed = true;
        });
      },
      // onTapCancel 只负责更新内部状态
      onTapCancel: () {
        if (!tapEffect) return;

        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });

          logger.info("取消点击");
        });
      },
      // onTapUp 负责恢复状态并执行操作
      onTapUp: (tapDownDetails) {
        // 如果没有点击效果，则直接执行操作
        if (!tapEffect) {
          if (widget.link != null) {
            Navigator.pushNamed(context, widget.link!);
          }
          if (widget.onPress != null) {
            widget.onPress!();
          }
          return;
        }

        // 延迟一小段时间再执行回调，让用户能看到颜色恢复的动画效果
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });

          // 检查 widget 是否还在树上
          if (context.mounted) {
            if (widget.link != null) {
              Navigator.pushNamed(context, widget.link!);
            }
            if (widget.onPress != null) {
              widget.onPress!();
            }
          }
        });
        logger.info("弹起");
      },
      child: Container(
        constraints: BoxConstraints(maxHeight: widget.height ?? 105.0.w),
        // 使用在 build 方法开头计算出的正确颜色
        color: currentContainerColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              // 头像
              Container(
                width: 50.0.w,
                height: 50.0.w,
                margin: widget.margin ??
                    const EdgeInsets.only(
                      left: 30.0,
                      right: 0.0,
                    ).w,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(25.w),
                  child: LJNAppNetworkImage(
                    imageUrl: widget.icon!,
                    width: 50.w,
                    height: 50.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(width: 15.w)
            ],
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: widget.underline
                        ? (theme.listTileTheme.shape as RoundedRectangleBorder)
                            .side
                        : BorderSide.none,
                  ),
                ),
                child: Row(
                  children: [
                    // 标题
                    widget.title is String
                        ? Expanded(
                            child: Container(
                              padding: widget.icon == null
                                  ? widget.padding ??
                                      const EdgeInsets.only(
                                        left: 30.0,
                                        right: 0.0,
                                      ).w
                                  : const EdgeInsets.all(0),
                              child: Text(
                                widget.title as String,
                                style: TextStyle(
                                  height: 1.08,
                                  fontSize: fontSizeScale(32.0.w),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        : widget.title as Widget,
                    if (widget.showStyle != null)
                      widget.showStyle is String
                          ? Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 10).w,
                                alignment: Alignment.centerRight,
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  widget.showStyle as String,
                                  style: TextStyle(
                                    fontSize: fontSizeScale(30.w),
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            )
                          : widget.showStyle as Widget,

                    // 显示右侧箭头
                    if ([null, true].contains(widget.showLinkIcon) &&
                        widget.link != null)
                      Container(
                        width: 30.w,
                        height: widget.height ?? 105.0.w,
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 32,
                        ).w,
                        child: Icon(
                          const IconData(
                            0xed9d,
                            fontFamily: 'Iconfont',
                          ),
                          size: 29.0.w,
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
