// lib/widgets/viga_action_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/widgets/viga_max_width_button.dart';

class VigaActionSheetAction {
  final Text text;
  final VoidCallback onPressed;
  final bool hasUnderline;

  VigaActionSheetAction({
    required this.text,
    required this.onPressed,
    this.hasUnderline = true,
  });
}

Future<void> showVigaActionSheet({
  required BuildContext context,
  required List<VigaActionSheetAction> actions,
  String? cancelButtonText,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: false,
    enableDrag: true,
    isDismissible: true,
    builder: (context) {
      return _VigaActionSheetWidget(
        actions: actions,
        cancelButtonText: cancelButtonText,
      );
    },
  );
}

/// 内部私有组件，负责Action Sheet的UI渲染。
class _VigaActionSheetWidget extends StatelessWidget {
  final List<VigaActionSheetAction> actions;
  final String? cancelButtonText;

  const _VigaActionSheetWidget({
    required this.actions,
    this.cancelButtonText,
  });

  void _handleAction(BuildContext context, VoidCallback onPressed) {
    context.pop();
    onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      width: 750.w,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.neutralWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.w),
            topRight: Radius.circular(20.w),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...actions.map((action) {
              return VigaMaxWidthButton(
                title: action.text,
                underline: action.hasUnderline,
                onPressed: () {
                  _handleAction(context, action.onPressed);
                },
              );
            }),

            // 如果提供了取消按钮文本，则显示取消部分
            if (cancelButtonText != null) ...[
              Container(
                height: 15.w,
                color: AppColors.neutralGrey2,
              ),
              VigaMaxWidthButton(
                title: Text(
                  cancelButtonText!,
                  style: TextStyle(
                    fontSize: 30.w,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                underline: false,
                onPressed: () {
                  context.pop(); // 点击取消，只关闭
                },
              ),
            ],
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }
}
