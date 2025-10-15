import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNPincodeField extends StatelessWidget {
  final String pin;
  final bool isVerifying;

  const LJNPincodeField({
    super.key,
    required this.pin,
    required this.isVerifying,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(6, (index) {
          bool isVerifyingAtThisIndex = isVerifying && index == 5;
          return Container(
            width: 80.w,
            height: 80.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: isVerifyingAtThisIndex
                ? SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    ),
                  )
                : (index < pin.length
                    ? Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      )
                    : null),
          );
        }),
      ),
    );
  }
}