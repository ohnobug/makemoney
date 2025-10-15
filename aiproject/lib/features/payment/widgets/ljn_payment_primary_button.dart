import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNPaymentPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double? borderRadius;

  const LJNPaymentPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    this.textColor = Colors.white,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(double.infinity, 90.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 45.h),
        ),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 32.sp,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}