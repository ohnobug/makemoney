import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_popup_menu_item.dart';

class LJNPopupMenu extends StatefulWidget {
  final bool showPopup;
  final Function(bool value)? setShowPopup;

  const LJNPopupMenu(
      {super.key, required this.showPopup, required this.setShowPopup});

  @override
  State<LJNPopupMenu> createState() => _LJNPopupMenuState();
}

class _LJNPopupMenuState extends State<LJNPopupMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.w,
      height: 500.w,
      child: Stack(
        children: [
          // 列表
          Positioned(
            left: 0,
            top: 28.w,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(10.0).w,
                border: BoxBorder.all(
                  width: 3.w,
                  color: Theme.of(context).listTileTheme.selectedTileColor!,
                ),
              ),
              width: 320.w,
              // height: 425.w,
              child: Column(
                children: [
                  // 开始群聊
                  LJNPopupMenuItem(
                    title: AppLocalizations.of(context)!.startGroupChat,
                    icon: 0xe676,
                    onTap: () => setState(
                      () => widget.setShowPopup!(false),
                    ),
                  ),
                  // 添加好友
                  LJNPopupMenuItem(
                    title: AppLocalizations.of(context)!.addFriend,
                    icon: 0xe61f,
                    onTap: () {
                      setState(() => widget.setShowPopup!(false));
                      Navigator.pushNamed(context, '/add_friends');
                    },
                  ),
                  // 二维码扫码
                  LJNPopupMenuItem(
                    title: AppLocalizations.of(context)!.scan,
                    icon: 0xe69a,
                    onTap: () {
                      setState(() => widget.setShowPopup!(false));
                      Navigator.pushNamed(context, '/qrcode_scanner');
                    },
                  ),
                  // 收付款
                  LJNPopupMenuItem(
                    title: AppLocalizations.of(context)!.payment,
                    icon: 0xe611,
                    onTap: () {
                      setState(() => widget.setShowPopup!(false));
                      Navigator.pushNamed(context, '/collection_and_payment');
                    },
                  ),
                ],
              ),
              // 顶部图标
            ),
          ),

          // 顶部小图标（尖头）
          Positioned(
            top: 0.w,
            right: 28.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 36.w,
                  height: 30.w,
                  child: Icon(
                    IconData(
                      0xe62c,
                      fontFamily: 'Iconfont',
                    ),
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    size: 42.0.w,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
