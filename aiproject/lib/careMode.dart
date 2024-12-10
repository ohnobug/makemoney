import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jiaoyishuoflutter3/components/LJNChangeAccountButton.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNCareMode extends StatefulWidget {
  const LJNCareMode({super.key});

  @override
  State<LJNCareMode> createState() => _LJNCareMode();
}

class _LJNCareMode extends State<LJNCareMode> {
  bool selectedValue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
              primary: false,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(90.0.w + vm.statusHeight!),
                  child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(top: vm.statusHeight!),
                      child: AppBar(
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          }, // 点击事件
                          child: Container(
                            // 加盒子是为了扩大点击区域
                            color: Colors.transparent,
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
                        title: const Text(''),
                        toolbarHeight: 90.w,
                        titleTextStyle: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(32.w),
                            color: Colors.black,
                            fontFamily: "AlibabaPuHuiTi-Medium"),
                        elevation: 0,
                        scrolledUnderElevation: 0,
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.transparent,
                        // bottom: PreferredSize(
                        //   preferredSize: Size.fromHeight(1.w),
                        //   child: Container(
                        //     color: const Color.fromARGB(255, 220, 220, 220),
                        //     height: 1.w,
                        //   ),
                        // ),
                        actions: const [],
                      ))),
              body: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      child: Container(
                        width: screenSize.width,
                        // padding: EdgeInsets.only(left: 90.w, right: 90.w),
                        constraints: BoxConstraints(
                            minHeight:
                                screenSize.height - (vm.statusHeight! + 90.w)),
                        // color: const Color.fromARGB(255, 231, 15, 15),
                        child: Column(
                          children: [
                            Container(
                              height: 290.w,
                              alignment: Alignment.center,
                              child: Icon(
                                const IconData(
                                  0xe622,
                                  fontFamily: 'Iconfont',
                                ), // 使用的图标
                                color: const Color.fromARGB(
                                    255, 244, 197, 58), // 图标颜色
                                size: 110.w, // 图标大小
                              ),
                            ),
                            Text(
                              "关怀模式",
                              style: TextStyle(
                                  height: 1.08,
                                  fontSize: 40.w,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "AlibabaPuHuiTi"),
                            ),
                            SizedBox(
                              height: 60.w,
                            ),
                            Container(
                                alignment: Alignment.topLeft,
                                margin:
                                    EdgeInsets.only(left: 70.w, right: 70.w),
                                child: Text(
                                  "开启「关怀模式」后，可选择以下功能:",
                                  style: TextStyle(
                                      fontSize: 32.w,
                                      fontFamily: "AlibabaPuHuiTi-Medium"),
                                )),
                            SizedBox(
                              height: 40.w,
                            ),
                            Container(
                                alignment: Alignment.topLeft,
                                margin:
                                    EdgeInsets.only(left: 70.w, right: 70.w),
                                child: Text(
                                  "· 文字更大，色彩更强，按钮更大;",
                                  style: TextStyle(
                                      fontSize: 30.w,
                                      color: const Color.fromARGB(
                                          255, 76, 76, 76)),
                                )),
                            SizedBox(
                              height: 25.w,
                            ),
                            Container(
                                alignment: Alignment.topLeft,
                                margin:
                                    EdgeInsets.only(left: 70.w, right: 70.w),
                                child: Text(
                                  "· 听聊天中的文字消息;",
                                  style: TextStyle(
                                      fontSize: 30.w,
                                      color: const Color.fromARGB(
                                          255, 76, 76, 76)),
                                )),
                            SizedBox(
                              height: 25.w,
                            ),
                            Container(
                                alignment: Alignment.topLeft,
                                padding:
                                    EdgeInsets.only(left: 70.w, right: 70.w),
                                child: Text(
                                  "· 安静模式，避免声音外放打扰。",
                                  style: TextStyle(
                                      fontSize: 30.w,
                                      color: const Color.fromARGB(
                                          255, 76, 76, 76)),
                                )),
                            SizedBox(
                              height: 580.w,
                            ),
                            const LJNChangeAccountButton(
                              title: '开启',
                              link: "back",
                              readonly: false,
                              color: Colors.white,
                              backgroundColor: Color.fromARGB(255, 5, 190, 94),
                            )
                          ],
                        ),
                      ))));
        });
  }
}
