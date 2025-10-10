// lib/widgets/ljn_action_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/widgets/ljn_max_width_button.dart';

/// 一个数据类，用于封装 Action Sheet 中每个可点击选项的配置。
///
/// [text] 按钮上显示的文本。
/// [onPressed] 点击按钮后（在关闭动画完成后）执行的回调。
/// [hasUnderline] 是否在按钮下方显示分割线，默认为 true。
class LJNActionSheetAction {
  final String text;
  final VoidCallback onPressed;
  final bool hasUnderline;

  LJNActionSheetAction({
    required this.text,
    required this.onPressed,
    this.hasUnderline = true,
  });
}

/// 全局函数，用于显示一个高度可定制的底部操作表(Action Sheet)。
///
/// [context] 是调用处的 `BuildContext`。
/// [actions] 是一个 `LJNActionSheetAction` 列表，定义了弹窗中的所有可点击选项。
/// [cancelButtonText] 是可选的取消按钮文本，如果不提供，则不显示取消按钮。
Future<void> showLJNActionSheet({
  required BuildContext context,
  required List<LJNActionSheetAction> actions,
  String? cancelButtonText,
}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (builderContext, animation, secondaryAnimation) {
      return _LjnActionSheetWidget(
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
class _LjnActionSheetWidget extends StatefulWidget {
  final List<LJNActionSheetAction> actions;
  final String? cancelButtonText;

  const _LjnActionSheetWidget({
    required this.actions,
    this.cancelButtonText,
  });

  @override
  State<_LjnActionSheetWidget> createState() => __LjnActionSheetWidgetState();
}

class __LjnActionSheetWidgetState extends State<_LjnActionSheetWidget>
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
                          // 【核心改动】使用 map 动态构建操作按钮列表
                          ...widget.actions.map((action) {
                            return LJNMaxWidthButton(
                              title: Text(
                                action.text,
                                style: TextStyle(
                                  fontSize: 30.w,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              underline: action.hasUnderline,
                              onPressed: () {
                                // 点击后，先执行关闭动画，动画结束后再执行按钮本身的操作
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
