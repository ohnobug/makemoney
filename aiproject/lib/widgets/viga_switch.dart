import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';

class VigaSwitch extends StatefulWidget {
  final bool initialValue; // 初始开关状态
  final ValueChanged<bool>? onChanged; // 状态改变时的回调

  const VigaSwitch({
    super.key,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  State<VigaSwitch> createState() => _VigaSwitchState();
}

class _VigaSwitchState extends State<VigaSwitch>
    with SingleTickerProviderStateMixin {
  late bool isOn;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialValue;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // 初始化动画进度
    _controller.value = isOn ? 1.0 : 0.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleSwitch() {
    setState(() {
      isOn = !isOn;
      if (isOn) {
        _controller.forward();
      } else {
        _controller.reverse();
      }

      // 回调通知状态改变
      widget.onChanged?.call(isOn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleSwitch, // 点击切换
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: 100.0.w,
            height: 60.0.w,
            // padding: EdgeInsets.symmetric(horizontal: 4.0.w),
            decoration: BoxDecoration(
              color:
                  isOn ? AppColors.brandGreenVibrant3 : AppColors.neutralGrey18,
              borderRadius: BorderRadius.circular(30.0.w),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 4.w,
                  left: 4.w + _controller.value * 40.w, // 根据动画进度调整位置
                  child: Container(
                    width: 52.0.w,
                    height: 52.0.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.neutralWhite,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
