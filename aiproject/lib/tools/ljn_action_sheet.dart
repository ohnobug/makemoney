// lib/widgets/ljn_action_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/widgets/ljn_max_width_button.dart';

class LJNActionSheetAction {
  final Text text;
  final VoidCallback onPressed;
  final bool hasUnderline;

  LJNActionSheetAction({
    required this.text,
    required this.onPressed,
    this.hasUnderline = true,
  });
}

Future<void> showLJNActionSheet({
  required BuildContext context,
  required List<LJNActionSheetAction> actions,
  String? cancelButtonText,
}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (builderContext, animation, secondaryAnimation) {
      return _LJNActionSheetWidget(
        actions: actions,
        cancelButtonText: cancelButtonText,
      );
    },
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: AppColors.blackTransparent50,
    transitionDuration: const Duration(milliseconds: 250),
  );
}

/// 内部私有组件，负责Action Sheet的UI渲染和动画控制。
class _LJNActionSheetWidget extends StatefulWidget {
  final List<LJNActionSheetAction> actions;
  final String? cancelButtonText;

  const _LJNActionSheetWidget({
    required this.actions,
    this.cancelButtonText,
  });

  @override
  State<_LJNActionSheetWidget> createState() => __LJNActionSheetWidgetState();
}

class __LJNActionSheetWidgetState extends State<_LJNActionSheetWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 10),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _dismiss(VoidCallback afterAnimation) {
    if (_animationController.status == AnimationStatus.reverse ||
        _animationController.status == AnimationStatus.dismissed) {
      return;
    }
    _animationController.reverse().then((_) {
      if (mounted) {
        Navigator.of(context).pop();
        afterAnimation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    // 使用 PopScope 替换已废弃的 WillPopScope
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        // 逻辑保持不变：如果页面没有被成功 pop (因为canPop:false)
        // 就执行我们的自定义关闭动画。
        if (!didPop) {
          _dismiss(() {});
        }
      },
      child: GestureDetector(
        onTap: () => _dismiss(() {}),
        child: Material(
          color: Colors.transparent,
          child: SlideTransition(
            position: _slideAnimation,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {},
                child: SizedBox(
                  width: 750.w,
                  child: SafeArea(
                    top: false,
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
                          ...widget.actions.map((action) {
                            return LJNMaxWidthButton(
                              title: action.text,
                              underline: action.hasUnderline,
                              onPressed: () {
                                _dismiss(action.onPressed);
                              },
                            );
                          }),

                          // 如果提供了取消按钮文本，则显示取消部分
                          if (widget.cancelButtonText != null) ...[
                            Container(
                              height: 15.w,
                              color: AppColors.neutralGrey2,
                            ),
                            LJNMaxWidthButton(
                              title: Text(
                                widget.cancelButtonText!,
                                style: TextStyle(
                                  fontSize: 30.w,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              underline: false,
                              onPressed: () {
                                _dismiss(() {}); // 点击取消，只关闭
                              },
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
