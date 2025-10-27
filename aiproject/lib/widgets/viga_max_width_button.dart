// 功能列表
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/tools/viga_tools.dart';

class VigaMaxWidthButton extends StatefulWidget {
  final double? height;
  final Object? title;
  final Color? color;
  final String? link;
  final bool underline;
  final Function? onPressed;

  const VigaMaxWidthButton({
    super.key,
    this.height,
    required this.title,
    this.color,
    this.link,
    required this.underline,
    this.onPressed,
  });

  @override
  State<VigaMaxWidthButton> createState() => _VigaMaxWidthButtonState();
}

class _VigaMaxWidthButtonState extends State<VigaMaxWidthButton> {
  // 只用一个状态来记录是否被按下
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // 在 build 方法中根据当前主题和按压状态决定颜色
    ThemeData theme = Theme.of(context);

    final Color normalColor = theme.listTileTheme.tileColor!;
    final Color pressedColor = theme.listTileTheme.selectedTileColor!;

    // 根据 _isPressed 状态动态选择颜色
    final Color currentColor = _isPressed ? pressedColor : normalColor;

    return BlocBuilder<VigaSystemCubit, SystemState>(
      builder: (context, systemState) {
        return GestureDetector(
          onTapDown: (tapDownDetails) {
            setState(() {
              _isPressed = true;
            });
          },
          onTapCancel: () {
            Future.delayed(const Duration(milliseconds: 50), () {
              setState(() {
                _isPressed = false;
              });
              logger.info("取消点击");
            });
          },
          onTapUp: (tapDownDetails) {
            // 延迟一点点时间，让用户能看到颜色恢复的效果
            Future.delayed(const Duration(milliseconds: 50), () {
              setState(() {
                _isPressed = false;
              });

              if (context.mounted) {
                if (widget.link != null) {
                  Navigator.pushNamed(context, widget.link!);
                }

                if (widget.onPressed != null) {
                  widget.onPressed!();
                }
              }
              logger.info("弹起");
            });
          },
          child: Container(
            height: widget.height ?? 105.0.w,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // 直接使用在 build 方法中计算出的颜色
              color: currentColor,
              border: Border(
                bottom: widget.underline
                    ? (theme.listTileTheme.shape as RoundedRectangleBorder).side
                    : BorderSide.none,
              ),
            ),
            child: widget.title is String
                ? Text(
                    widget.title as String,
                    style: TextStyle(
                      color: widget.color ?? theme.colorScheme.onSurface,
                      height: 1.08,
                      fontSize: fontSizeScale(32.0.w),
                      decoration: TextDecoration.none,
                      
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : widget.title as Widget,
          ),
        );
      },
    );
  }
}
