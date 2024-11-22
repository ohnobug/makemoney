import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNCollectionAndPayment extends StatefulWidget {
  const LJNCollectionAndPayment({super.key});

  @override
  State<LJNCollectionAndPayment> createState() =>
      _LJNCollectionAndPaymentState();
}

class _LJNCollectionAndPaymentState extends State<LJNCollectionAndPayment> {
  double _statusHeight = 0;

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

    return Scaffold(
        primary: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.0.w + _statusHeight),
            child: Container(
              color: const Color.fromARGB(255, 77, 174, 107),
              padding: EdgeInsets.only(top: _statusHeight),
              child: AppBar(
                leading: GestureDetector(
                  onTap: () => Navigator.of(context).pop(), // 点击事件
                  child: Container(
                    // 加盒子是为了扩大点击区域
                    color: Colors.transparent,
                    child: Icon(
                      const IconData(
                        0xed9e,
                        fontFamily: 'Iconfont',
                      ), // 使用的图标
                      color: Colors.white, // 图标颜色
                      size: 36.w, // 图标大小
                    ),
                  ),
                ),
                primary: false,
                centerTitle: true,
                elevation: 0,
                scrolledUnderElevation: 0,
                toolbarHeight: 90.w,
                title: Text("收付款"),
                titleTextStyle: TextStyle(
                  height: 1.08,
                  fontSize: fontSizeScale(32.w),
                  color: Colors.white,
                  fontFamily: "AlibabaPuHuiTi-Medium",
                ),
                backgroundColor: const Color.fromARGB(255, 77, 174, 107),
                foregroundColor: const Color.fromARGB(255, 77, 174, 107),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(1.w),
                  child: Container(
                    color: const Color.fromARGB(255, 77, 174, 107),
                    height: 0.5.w,
                  ),
                ),
                actions: [],
              ),
            )),
        body: StoreConnector<StoreType, StoreType>(
            converter: (store) => store.state,
            builder: (context, vm) {
              return Container(
                  color: const Color.fromARGB(255, 77, 174, 107),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              top: 15.w, left: 15.w, right: 15.w),
                          padding: EdgeInsets.all(15.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.w)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                  height: 110.w,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 0.5.w,
                                              color: const Color.fromARGB(
                                                  255, 207, 211, 212)))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            const IconData(
                                              0xed9e,
                                              fontFamily: 'Iconfont',
                                            ), // 使用的图标
                                            color: const Color.fromARGB(
                                                255, 59, 143, 65), // 图标颜色
                                            size: 30.w, // 图标大小
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(
                                            "付款码",
                                            style: TextStyle(
                                                fontSize: 30.w,
                                                height: 1.08,
                                                color: const Color.fromARGB(
                                                    255, 59, 143, 65)),
                                          )
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // 点击事件
                                        },
                                        child: Container(
                                          height: 90.w,
                                          color: Colors.transparent,
                                          padding: EdgeInsets.only(
                                              right: 33.w), // 设置右侧内边距
                                          child: Icon(
                                            const IconData(
                                              0xe659,
                                              fontFamily: 'Iconfont',
                                            ),
                                            size: 37.w, // 图标大小
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 40.w,
                              ),
                              Container(
                                child: Text(
                                  "优先使用零钱付款",
                                  style: TextStyle(
                                      fontSize: 25.w,
                                      color: const Color.fromARGB(
                                          255, 157, 161, 162)),
                                ),
                              ),
                              SizedBox(
                                height: 10.w,
                              ),
                              Container(
                                child: Image.asset(
                                  assetPath("images/avatar/linecode.png"),
                                  width: 650.0.w,
                                  height: 200.0.w,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                height: 55.w,
                              ),
                              Container(
                                child: Image.asset(
                                  assetPath("images/avatar/qrcode.png"),
                                  width: 280.0.w,
                                  height: 280.0.w,
                                  fit: BoxFit.contain,
                                ),
                              ),


                            ],
                          )),
                    ],
                  ));
            }));
  }
}
