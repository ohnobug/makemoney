import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jiaoyishuoflutter3/components/LJNFunctionItem.dart';
import 'package:jiaoyishuoflutter3/components/LJNSwitch.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNSoundLock extends StatefulWidget {
  const LJNSoundLock({super.key});

  @override
  State<LJNSoundLock> createState() => _LJNSoundLock();
}

class _LJNSoundLock extends State<LJNSoundLock> {
  double _statusHeight = 0;
  bool selectedValue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
              primary: false,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(90.0.w + _statusHeight),
                  child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(top: _statusHeight),
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
                        actions: [],
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
                                screenSize.height - (_statusHeight + 90.w)),
                        // color: const Color.fromARGB(255, 231, 15, 15),
                        child: Column(
                          children: [
                            Container(
                              height: 290.w,
                              alignment: Alignment.center,
                              child: Icon(
                                const IconData(
                                  0xe6b8,
                                  fontFamily: 'Iconfont',
                                ), // 使用的图标
                                color: const Color.fromARGB(
                                    255, 75, 190, 97), // 图标颜色
                                size: 200.w, // 图标大小
                              ),
                            ),
                            Text(
                              "声音锁",
                              style: TextStyle(
                                  height: 1.08,
                                  fontSize: 40.w,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: "AlibabaPuHuiTi-Medium"
                                  ),
                            ),
                            SizedBox(
                              height: 60.w,
                            ),
                            Container(
                                width: 630.w,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  // color:
                                  //     const Color.fromARGB(255, 247, 247, 247),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.w)),
                                ),
                                child: Column(children: [
                                  LJNFunctionItem(
                                    title: "用声音锁登录微信",
                                    tapEffect: false,
                                    underline: true,
                                    backgroundColor: const Color.fromARGB(
                                        255, 247, 247, 247),
                                    showStyle: Expanded(
                                        flex: 0,
                                        child: Container(
                                            margin:
                                                const EdgeInsets.only(right: 32)
                                                    .w,
                                            child: LJNSwitch(
                                              initialValue: false,
                                              onChanged: (value) {
                                                logger.info(value);
                                              },
                                            ))),
                                  ),
                                  const LJNFunctionItem(
                                    title: "重设与删除",
                                    link: '',
                                    backgroundColor:
                                        Color.fromARGB(255, 247, 247, 247),
                                    underline: true,
                                  ),
                                  const LJNFunctionItem(
                                    title: "尝试验证我的声音",
                                    link: '',
                                    backgroundColor:
                                        Color.fromARGB(255, 247, 247, 247),
                                    underline: false,
                                  ),
                                ]))
                          ],
                        ),
                      ))));
        });
  }
}
