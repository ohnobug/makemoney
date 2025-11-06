import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VigaFunctionList extends StatelessWidget {
  final Widget? title;
  final List<Widget> children;

  const VigaFunctionList({
    super.key,
    this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        if (title == null)
          Container(
            width: double.infinity,
            height: 16.w,
            color: Colors.transparent,
          )
        else
          title!,
        Container(
          // height: 1.w,
          width: 710.w,
          margin: EdgeInsets.symmetric(vertical: 3.w),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.all(
              Radius.circular(15.w),
            ),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
