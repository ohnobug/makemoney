import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/ljn_vertical_gap.dart';

class LJNFunctionList extends StatelessWidget {
  final List<Widget> children;

  const LJNFunctionList({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        LJNVerticalGap(
          height: 16.w,
        ),
        Container(
          // height: 1.w,
          width: 750.w,
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.all(
              Radius.circular(10.w),
            ),
          ),
          child: Column(
            children: children,
          ),
        ),
        // LJNVerticalGap(
        //   height: 8.w,
        // ),
      ],
    );
  }
}
