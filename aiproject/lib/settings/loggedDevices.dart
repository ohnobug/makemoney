import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNAppBar.dart';
import 'package:jiaoyishuoflutter3/components/LJNSpecialFunctionItem.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/LJNFunctionItem.dart';

class LJNLoggedDevices extends StatefulWidget {
  const LJNLoggedDevices({super.key});

  @override
  State<LJNLoggedDevices> createState() => _LJNLoggedDevices();
}

class _LJNLoggedDevices extends State<LJNLoggedDevices> {
  @override
  void initState() {
    super.initState();

    myStore.dispatch({"type": "homescrollpixels", "payload": 0.0});
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
        appBar: LJNAppBar(title: "登录过的设备", actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/bind_new_phone_number');
            },
            child: Container(
              // color: Colors.black,
              height: 90.w,
              padding: EdgeInsets.only(right: 40.w),
              alignment: Alignment.center,
              child: Text(
                "编辑",
                // textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32.w,
                    fontWeight: FontWeight.w100),
              ),
            ),
          )
        ]),
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
                    child: Column(children: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 30.w),
                          child: Text(
                            "你的账号在以下设备中登录过，你可以删除设备，删除后在该设备登录时需进行安全验证。",
                            style: TextStyle(
                                fontSize: 27.w,
                                color:
                                    const Color.fromARGB(255, 149, 149, 149)),
                          )),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 64.w,
                        padding: EdgeInsets.only(
                            left: 30.0.w, right: 0.0.w, top: 16.w),
                        child: Text(
                          "已登录的设备",
                          style: TextStyle(
                              fontSize: 25.w,
                              height: 1.08,
                              color: const Color.fromARGB(255, 74, 74, 74)),
                        ),
                      ),
                      LJNFunctionItem(
                          // height: 150.w,
                          title: "HONOR-RNA-AN100",
                          link: '/device_detail',
                          underline: true,
                          showStyle: Expanded(
                              flex: 0,
                              child: Container(
                                  constraints: BoxConstraints(maxWidth: 375.w),
                                  child: Text(
                                    "当前设备",
                                    textAlign: TextAlign.end,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 25.w,
                                        height: 1.08,
                                        color: const Color.fromARGB(
                                            255, 180, 180, 180)),
                                  )))),
                      const LJNFunctionItem(
                        // height: 150.w,
                        title: "iphone20",
                        link: '/device_detail',
                        underline: false,
                        // showStyle: "当前设备"
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 64.w,
                        padding: const EdgeInsets.only(
                                left: 30.0, right: 0.0, top: 16)
                            .w,
                        child: Text(
                          "已退出登录的设备",
                          style: TextStyle(
                              fontSize: 25.w,
                              height: 1.08,
                              color: const Color.fromARGB(255, 74, 74, 74)),
                        ),
                      ),
                      LJNSpecialFunctionItem(
                        height: 150.w,
                        title: "HONOR-RNA-AN100",
                        link: '/device_detail',
                        underline: true,
                        subTitle: Text(
                          "11月10日 下午15:23",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 193, 193, 193),
                            fontSize: 24.w,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "AlibabaPuHuiTi",
                          ),
                        ),
                      ),
                      LJNSpecialFunctionItem(
                        height: 150.w,
                        title: "HONOR-RNA-AN100",
                        link: '/device_detail',
                        underline: true,
                        subTitle: Text(
                          "11月10日 下午15:23",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 193, 193, 193),
                            fontSize: 24.w,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "AlibabaPuHuiTi",
                          ),
                        ),
                      ),
                      LJNSpecialFunctionItem(
                        height: 150.w,
                        title: "HONOR-RNA-AN100",
                        link: '/device_detail',
                        underline: true,
                        subTitle: Text(
                          "11月10日 下午15:23",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 193, 193, 193),
                            fontSize: 24.w,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "AlibabaPuHuiTi",
                          ),
                        ),
                      ),
                      LJNSpecialFunctionItem(
                        height: 150.w,
                        title: "HONOR-RNA-AN100",
                        link: '/device_detail',
                        underline: true,
                        subTitle: Text(
                          "11月10日 下午15:23",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 193, 193, 193),
                            fontSize: 24.w,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "AlibabaPuHuiTi",
                          ),
                        ),
                      ),
                      LJNSpecialFunctionItem(
                        height: 150.w,
                        title: "HONOR-RNA-AN100",
                        link: '/device_detail',
                        underline: true,
                        subTitle: Text(
                          "11月10日 下午15:23",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 193, 193, 193),
                            fontSize: 24.w,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "AlibabaPuHuiTi",
                          ),
                        ),
                      ),
                      LJNSpecialFunctionItem(
                        height: 150.w,
                        title: "HONOR-RNA-AN100",
                        link: '/device_detail',
                        underline: true,
                        subTitle: Text(
                          "11月10日 下午15:23",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 193, 193, 193),
                            fontSize: 24.w,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "AlibabaPuHuiTi",
                          ),
                        ),
                      ),
                      LJNSpecialFunctionItem(
                        height: 150.w,
                        title: "HONOR-RNA-AN100",
                        link: '/device_detail',
                        underline: true,
                        subTitle: Text(
                          "11月10日 下午15:23",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 193, 193, 193),
                            fontSize: 24.w,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "AlibabaPuHuiTi",
                          ),
                        ),
                      ),
                    ])))));
  }
}
