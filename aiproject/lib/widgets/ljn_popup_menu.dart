import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/widgets/ljn_custom_tabbar.dart';

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
      child: Column(
        children: [
          Container(
            width: 320.w,
            padding: EdgeInsets.only(right: 32.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 36.w,
                  height: 20.w,
                  child: const Icon(
                    IconData(0xe62c, fontFamily: 'Iconfont'),
                    color: AppColors.neutralDarkGrey12,
                    size: 42.0,
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0).w,
              color: AppColors.neutralDarkGrey12,
            ),
            width: 320.w,
            height: 425.w,
            child: Column(
              children: [
                LJNPopupMenuItem(
                  title: "发起群聊",
                  icon: 0xe676,
                  onTap: () => setState(() => widget.setShowPopup!(false)),
                ),
                LJNPopupMenuItem(
                  title: "添加朋友",
                  icon: 0xe61f,
                  onTap: () {
                    setState(() => widget.setShowPopup!(false));
                    Navigator.pushNamed(context, '/add_friends');
                  },
                ),
                LJNPopupMenuItem(
                  title: "扫一扫",
                  icon: 0xe69a,
                  onTap: () {
                    setState(() => widget.setShowPopup!(false));
                    Navigator.pushNamed(context, '/qrcode_scanner');
                  },
                ),
                LJNPopupMenuItem(
                  title: "收付款",
                  icon: 0xe611,
                  onTap: () {
                    setState(() => widget.setShowPopup!(false));
                    Navigator.pushNamed(context, '/collection_and_payment');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
