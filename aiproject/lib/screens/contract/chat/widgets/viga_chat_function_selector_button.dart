import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';

class VigaFunctionSelectorButton extends StatefulWidget {
  final SystemState systemState;
  final String title;
  final Function onTap;
  final Icon icon;

  const VigaFunctionSelectorButton({
    super.key,
    required this.systemState,
    required this.title,
    required this.onTap,
    required this.icon,
  });

  @override
  State<VigaFunctionSelectorButton> createState() =>
      _VigaFunctionSelectorButtonState();
}

class _VigaFunctionSelectorButtonState extends State<VigaFunctionSelectorButton> {
  Color bgColor = AppColors.neutralWhite;

  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // 核心修正：在 build 方法内部获取所有依赖于外部环境（如 Theme 或 widget 属性）的值。
    // 这样每次UI刷新（包括主题切换），都能拿到最新的正确值。
    ThemeData theme = Theme.of(context);

    // 1. 决定原始背景色（未按下时）
    // 优先使用 widget 传入的 backgroundColor，如果没有则从当前主题中获取。
    final Color originContainerColor = theme.listTileTheme.tileColor!;

    // 2. 决定按下时的背景色
    final Color pressedContainerColor = theme.listTileTheme.selectedTileColor!;

    // 3. 根据内部状态 _isPressed 和是否启用点击效果，动态地计算出当前应该显示的背景颜色。
    final Color currentContainerColor =
        _isPressed ? pressedContainerColor : originContainerColor;

    return Container(
      width: (750.w) / 4,
      alignment: Alignment.center,
      color: currentContainerColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: widget.onTap(),
            onTapDown: (_) {
              setState(() {
                _isPressed = true;
              });
            },
            onTapUp: (_) {
              Future.delayed(Duration(milliseconds: 50), () {
                setState(() {
                  _isPressed = false;
                });
              });
            },
            onTapCancel: () {
              Future.delayed(Duration(milliseconds: 50), () {
                setState(() {
                  _isPressed = false;
                });
              });
            },
            child: Column(
              children: [
                Container(
                  height: 106.w,
                  width: 106.w,
                  margin: EdgeInsets.only(bottom: 12.w),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(27.w),
                    ),
                  ),
                  child: widget.icon,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 22.w,
                    color: AppColors.neutralGrey77,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 71.w,
          ),
        ],
      ),
    );
  }
}
