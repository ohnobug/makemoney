// 功能列表
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_app_network_image.dart';

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

// =========================================================================
// ====================    这里是完整的、修正后的 State 类    ====================
// =========================================================================
class _LJNChangeDetailItemState extends State<LJNChangeDetailItem> {
  // 唯一的内部状态：只记录该列表项是否被用户按下。
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // 核心修正：在 build 方法内部获取所有依赖于外部环境（如 Theme）的值。
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    // 1. 定义不同状态下的背景颜色
    final Color normalColor = theme.listTileTheme.tileColor!;
    final Color pressedColor = theme.listTileTheme.selectedTileColor!;

    // 2. 根据内部状态 _isPressed，动态地计算出当前应该显示的背景颜色。
    final Color currentColor = _isPressed ? pressedColor : normalColor;

    // 3. 定义不同数值的文本颜色
    final Color positiveChangeColor =
        AppColors.accentYellowDark4; // This can be themed as well if needed
    final Color negativeChangeColor = theme.colorScheme.onSurface;
    final Color subtitleColor =
        theme.textTheme.bodySmall?.color ?? AppColors.neutralGrey64;

    final DateTime aDate = DateTime(2024, 12, 5, 12, 7);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // onTapDown 只负责更新内部状态
      onTapDown: (_) {
        if (widget.onPressed == null) return;

        setState(() {
          _isPressed = true;
        });
      },
      // onTapCancel 只负责更新内部状态
      onTapCancel: () {
        if (widget.onPressed == null) return;

        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      // onTapUp 负责恢复状态并执行操作
      onTapUp: (_) {
        if (widget.onPressed == null) return;

        // 延迟执行回调
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });

          if (context.mounted) {
            widget.onPressed!();
          }
        });
      },
      child: Container(
        height: 150.0.w,
        padding: const EdgeInsets.symmetric(horizontal: 40.0).w,
        decoration: BoxDecoration(
          // 使用在 build 方法开头计算出的正确颜色
          color: currentColor,
          border: Border(
            bottom: widget.underline
                ? BorderSide(color: theme.dividerColor, width: 1.5.w)
                : BorderSide.none,
          ),
        ),
        child: Row(
          children: [
            // 头像
            ClipRRect(
              borderRadius: BorderRadius.circular(85.0.w),
              child: LJNAppNetworkImage(
                imageUrl: widget.icon,
                width: 86.0.w,
                height: 86.0.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 商家与支付
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: fontSizeScale(30.0.w),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.change > 0
                            ? '+${widget.change.toStringAsFixed(2)}'
                            : widget.change.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: fontSizeScale(30.0.w),
                          color: widget.change > 0
                              ? positiveChangeColor
                              : negativeChangeColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto",
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  SizedBox(height: 18.w),
                  // 时间与余额
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.monthDayTimeShort(aDate),
                        style: TextStyle(
                          color: subtitleColor,
                          fontSize: fontSizeScale(25.0.w),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        l10n.balanceDisplay(1565.06),
                        style: TextStyle(
                          color: subtitleColor,
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
