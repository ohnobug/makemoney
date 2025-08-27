import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/tools/ljn_tools.dart';
import 'package:spicychat/widgets/ljn_custom_tabbar.dart';

class LJNPopupMenu extends StatefulWidget {
  final bool showPopup;
  final Function(bool value)? setShowPopup;
  
  const LJNPopupMenu({
    super.key,
    required this.showPopup,
    required this.setShowPopup
  });

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
                    color: Color.fromARGB(255, 76, 76, 76),
                    size: 42.0,
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0).w,
              color: const Color.fromARGB(255, 76, 76, 76),
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

  Color _bgColor = const Color.fromARGB(255, 76, 76, 76);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) =>
          setState(() => _bgColor = const Color.fromARGB(255, 68, 68, 68)),
      onTapCancel: () =>
          setState(() => _bgColor = const Color.fromARGB(255, 76, 76, 76)),
      onTapUp: (_) {
        setState(() => _bgColor = const Color.fromARGB(255, 76, 76, 76));
        Future.delayed(const Duration(milliseconds: 50), () {
          widget.onTap?.call();
        });
      },
      child: Container(
        height: 105.w,
        color: _bgColor,
        child: Row(
          children: [
            SizedBox(
              height: 105.w,
              width: 105.w,
              child: Center(
                child: Icon(
                  IconData(widget.icon, fontFamily: 'Iconfont'),
                  color: Colors.white,
                  size: 41.w,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: const Color.fromARGB(255, 85, 85, 85),
                      width: 1.5.w,
                    ),
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    height: 1.08,
                    fontSize: fontSizeScale(33.w),
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                    color: Colors.white,
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