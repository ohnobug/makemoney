import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Color? bgColor;

  const LJNAppBar({super.key, this.title, this.actions, this.bgColor});

  @override
  State<LJNAppBar> createState() => _LJNAppBar();

  @override
  Size get preferredSize =>
      Size.fromHeight(90.0.w + myStore.state.statusHeight!);
}

class _LJNAppBar extends State<LJNAppBar> {
  late Color bgColor;
  @override
  void initState() {
    super.initState();

    bgColor = widget.bgColor ?? const Color.fromARGB(255, 237, 237, 237);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return PreferredSize(
              preferredSize: Size.fromHeight(90.0.w + vm.statusHeight!),
              child: Container(
                  color: bgColor,
                  padding: EdgeInsets.only(top: vm.statusHeight!),
                  child: AppBar(
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        // wallet
                      }, // 点击事件
                      child: Container(
                        color: Colors.transparent,
                        height: 90.w,
                        alignment: Alignment.center,
                        child: Icon(
                          const IconData(
                            0xed9e,
                            fontFamily: 'Iconfont',
                          ), // 使用的图标
                          color: Colors.black, // 图标颜色
                          size: 36.w, // 图标大小
                        ),
                      ),
                    ),
                    primary: false,
                    centerTitle: true,
                    title: Text(widget.title ?? ""),
                    toolbarHeight: 90.w,
                    titleTextStyle: TextStyle(
                        height: 1.08,
                        fontSize: fontSizeScale(32.w),
                        color: Colors.black,
                        fontFamily: "AlibabaPuHuiTi-Medium"),
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    backgroundColor: bgColor,
                    foregroundColor: bgColor,
                    actions: widget.actions,
                  )));
        });
  }
}
