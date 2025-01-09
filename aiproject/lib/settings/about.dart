import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/components/ljn_function_item.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNAbout extends StatefulWidget {
  const LJNAbout({super.key});

  @override
  State<LJNAbout> createState() => _LJNAbout();
}

class _LJNAbout extends State<LJNAbout> {
  bool selectedValue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
              primary: false,
              appBar: const LJNAppBar(
                bgColor: Colors.transparent,
              ),
              body: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      child: Container(
                        width: vm.screenSize!.width,
                        // padding: EdgeInsets.only(left: 90.w, right: 90.w),
                        constraints: BoxConstraints(
                            minHeight: vm.screenSize!.height -
                                (vm.statusHeight! + 90.w)),
                        // color: const Color.fromARGB(255, 231, 15, 15),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 470.w,
                              width: vm.screenSize!.width,
                              // color: Colors.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Icon(
                                  //   const IconData(
                                  //     0xe6b8,
                                  //     fontFamily: 'Iconfont',
                                  //   ), // 使用的图标
                                  //   color: const Color.fromARGB(
                                  //       255, 75, 190, 97), // 图标颜色
                                  //   size: 110.w, // 图标大小
                                  // ),
                                  Image.asset(
                                    assetPath("images/icon/logo.png"),
                                    width: 122.0.w,
                                    height: 122.0.w,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    height: 70.w,
                                  ),
                                  Text(
                                    "微信",
                                    style: TextStyle(
                                        height: 1.08,
                                        fontSize: 43.w,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: "AlibabaPuHuiTi-Medium"),
                                  ),
                                  SizedBox(
                                    height: 18.w,
                                  ),
                                  Text(
                                    "Version 8.0.53",
                                    style: TextStyle(
                                        height: 1.08,
                                        fontSize: 27.w,
                                        fontFamily: "AlibabaPuHuiTi"),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                width: 630.w,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  // borderRadius:
                                  //     BorderRadius.all(Radius.circular(12.w)),
                                  border: Border(
                                      top: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 242, 242, 242),
                                        width: 1.5.w,
                                        style: BorderStyle.solid,
                                      ),
                                      bottom: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 242, 242, 242),
                                        width: 1.5.w,
                                        style: BorderStyle.solid,
                                      )),
                                ),
                                child: const Column(children: [
                                  LJNFunctionItem(
                                    title: "功能介绍",
                                    link: '',
                                    backgroundColor: Colors.white,
                                    underline: true,
                                  ),
                                  LJNFunctionItem(
                                    title: "投诉",
                                    link: '',
                                    backgroundColor: Colors.white,
                                    underline: true,
                                  ),
                                  LJNFunctionItem(
                                    title: "检测新版本",
                                    link: '',
                                    backgroundColor: Colors.white,
                                    underline: false,
                                  )
                                ]))
                          ],
                        ),
                      ))));
        });
  }
}
