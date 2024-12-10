import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNChangeDetailItem.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNChangeDetails extends StatefulWidget {
  const LJNChangeDetails({super.key});

  @override
  State<LJNChangeDetails> createState() => _LJNChangeDetails();
}

class _LJNChangeDetails extends State<LJNChangeDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return _buildPage(vm);
        });
  }

  // 另起一个函数方便管理
  Widget _buildPage(StoreType vm) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        primary: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.0.w + vm.statusHeight!),
            child: Container(
                width: screenSize.width,
                color: const Color.fromARGB(255, 237, 237, 237),
                padding: EdgeInsets.only(top: vm.statusHeight!),
                child: AppBar(
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      // wallet
                    }, // 点击事件
                    child: Container(
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
                  title: const Text('零钱明细'),
                  toolbarHeight: 90.w,
                  titleTextStyle: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(32.w),
                      color: Colors.black,
                      fontFamily: "AlibabaPuHuiTi-Medium"),
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  backgroundColor: const Color.fromARGB(255, 237, 237, 237),
                  foregroundColor: const Color.fromARGB(255, 237, 237, 237),
                  // bottom: PreferredSize(
                  //   preferredSize: Size.fromHeight(1.w),
                  //   child: Container(
                  //     color: const Color.fromARGB(255, 220, 220, 220),
                  //     height: 1.w,
                  //   ),
                  // ),
                  actions: const [
                    // // 三个点
                    // GestureDetector(
                    //     onTap: () {
                    //       // 点击事件
                    //     },
                    //     child: Container(
                    //         color: Colors.transparent,
                    //         padding: EdgeInsets.only(right: 33.w),
                    //         child: Text("账单",
                    //             style: TextStyle(height: 1.08,
                    //                 color: Colors.black,
                    //                 fontSize: fontSizeScale(30.w),
                    //                 fontWeight: FontWeight.w500)))),
                  ],
                ))),
        body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
                constraints: BoxConstraints(
                    minHeight: screenSize.height - 90.w - vm.statusHeight!),
                color: const Color.fromARGB(255, 237, 237, 237),
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 107.w,
                              padding: EdgeInsets.only(left: 42.w),
                              alignment: Alignment.centerLeft,
                              color: const Color.fromARGB(255, 247, 247, 247),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "2024年12月",
                                      style: TextStyle(
                                        height: 1.08,
                                        fontSize: fontSizeScale(30.w),
                                        color: Colors.black,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: "AlibabaPuHuiTi",
                                      ),
                                    ),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment
                                          .middle, // 图标垂直对齐方式
                                      child: Icon(
                                        const IconData(
                                          0xe891,
                                          fontFamily: 'Iconfont',
                                        ), // 使用的图标
                                        color: Colors.black, // 图标颜色
                                        size: 30.w, // 图标大小
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          const LJNChangeDetailItem(
                            title: "原乡智选",
                            change: -32,
                            icon: "images/avatar/01.png",
                            link: '',
                            underline: true,
                          ),
                          const LJNChangeDetailItem(
                            title: "原乡智选",
                            change: -56,
                            icon: "images/avatar/01.png",
                            link: '',
                            underline: true,
                          ),
                          const LJNChangeDetailItem(
                            title: "原乡智选",
                            change: -14,
                            icon: "images/avatar/01.png",
                            link: '',
                            underline: true,
                          ),
                          const LJNChangeDetailItem(
                            title: "原乡智选",
                            change: 200,
                            icon: "images/avatar/01.png",
                            link: '',
                            underline: true,
                          ),
                          const LJNChangeDetailItem(
                            title: "原乡智选",
                            change: -49,
                            icon: "images/avatar/01.png",
                            link: '',
                            underline: true,
                          ),
                          const LJNChangeDetailItem(
                            title: "原乡智选",
                            change: -18,
                            icon: "images/avatar/01.png",
                            link: '',
                            underline: true,
                          ),
                          const LJNChangeDetailItem(
                            title: "原乡智选",
                            change: -21,
                            icon: "images/avatar/01.png",
                            link: '',
                            underline: true,
                          ),
                          const LJNChangeDetailItem(
                            title: "原乡智选",
                            change: -29,
                            icon: "images/avatar/01.png",
                            link: '',
                            underline: true,
                          ),
                          const LJNChangeDetailItem(
                            title: "原乡智选",
                            change: -91,
                            icon: "images/avatar/01.png",
                            link: '',
                            underline: true,
                          ),
                          const LJNChangeDetailItem(
                            title: "原乡智选",
                            change: -5,
                            icon: "images/avatar/01.png",
                            link: '',
                            underline: true,
                          ),
                          const LJNChangeDetailItem(
                            title: "原乡智选",
                            change: -73,
                            icon: "images/avatar/01.png",
                            link: '',
                            underline: true,
                          ),
                          const LJNChangeDetailItem(
                            title: "原乡智选",
                            change: -47,
                            icon: "images/avatar/01.png",
                            link: '',
                            underline: true,
                          ),
                          const LJNChangeDetailItem(
                            title: "原乡智选",
                            change: -15,
                            icon: "images/avatar/01.png",
                            link: '',
                            underline: true,
                          ),
                        ])))));
  }
}
