import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/tools/dialog/ljn_popup_menu_item.dart';

void showPopupMenu(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "",
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) {
      return _PopupMenuDialog(
        animation: animation,
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.linear,
        )),
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  );
}

class _PopupMenuDialog extends StatelessWidget {
  final Animation<double> animation;

  const _PopupMenuDialog({
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    final Color popupBackgroundColor = theme.colorScheme.surfaceContainer;
    final Color popupBorderColor = theme.dividerColor;

    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // 弹窗内容
            Positioned(
              right: 15.w,
              top: MediaQuery.of(context).padding.top + 80.w,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutBack,
                ),
                child: SizedBox(
                  width: 320.w,
                  height: 500.w,
                  child: Stack(
                    children: [
                      // 弹窗主体
                      Positioned(
                        left: 0,
                        top: 28.w,
                        child: Container(
                          decoration: BoxDecoration(
                            color: popupBackgroundColor,
                            borderRadius: BorderRadius.circular(10.0).w,
                            border: Border.all(
                              width: 3.w,
                              color: popupBorderColor,
                            ),
                          ),
                          width: 320.w,
                          child: Column(
                            children: [
                              // 发起群聊
                              LJNPopupMenuItem(
                                title: l10n.startGroupChat,
                                icon: const IconData(
                                  0xe676,
                                  fontFamily: "iconfont",
                                ),
                                onTap: () => Navigator.of(context).pop(),
                              ),
                              // 添加好友
                              LJNPopupMenuItem(
                                title: l10n.addFriend,
                                icon: const IconData(0xe61f,
                                    fontFamily: "iconfont"),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushNamed(
                                    context,
                                    '/contact/add_friends',
                                  );
                                },
                              ),
                              // 扫一扫
                              LJNPopupMenuItem(
                                title: l10n.scan,
                                icon: const IconData(0xe69a,
                                    fontFamily: "iconfont"),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushNamed(
                                    context,
                                    '/discovery/qrcode_scanner',
                                  );
                                },
                              ),
                              // 收付款
                              LJNPopupMenuItem(
                                title: l10n.payment,
                                icon: const IconData(
                                  0xe611,
                                  fontFamily: "iconfont",
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushNamed(
                                    context,
                                    '/user/collection_and_payment',
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      // 顶部箭头图标
                      Positioned(
                        top: 0.w,
                        right: 28.w,
                        child: SizedBox(
                          width: 36.w,
                          height: 30.w,
                          child: Icon(
                            const IconData(
                              0xe62c,
                              fontFamily: 'Iconfont',
                            ),
                            color: popupBackgroundColor,
                            size: 42.0.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
