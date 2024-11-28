import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/maxWidthButton.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import '../components/LJNFunctionItem.dart';

class LJNDeviceDetail extends StatefulWidget {
  const LJNDeviceDetail({super.key});

  @override
  State<LJNDeviceDetail> createState() => _LJNDeviceDetail();
}

class _LJNDeviceDetail extends State<LJNDeviceDetail> {
  double _statusHeight = 0;

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
    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        primary: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.0.w + _statusHeight),
            child: Container(
                width: screenSize.width,
                color: const Color.fromARGB(255, 237, 237, 237),
                padding: EdgeInsets.only(top: _statusHeight),
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
                  title: const Text('设备详情'),
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
                  actions: const [],
                ))),
        body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
                constraints: BoxConstraints(
                    minHeight: screenSize.height - 90.w - _statusHeight),
                color: const Color.fromARGB(255, 237, 237, 237),
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Column(children: [
                      LJNFunctionItem(
                          // height: 150.w,
                          
                          title: "设备名称",
                          link: '',
                          tapEffect: true,
                          underline: true,
                          showStyle: Expanded(
                              flex: 1,
                              child: Text(
                                "当前设备",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 32.w,
                                    height: 1.08,
                                    color: const Color.fromARGB(
                                        255, 180, 180, 180)),
                              ))),
                      LJNFunctionItem(
                          // height: 150.w,
                          
                          title: "设备类型",
                          // link: '',
                          tapEffect: false,
                          underline: false,
                          showStyle: Expanded(
                              flex: 1,
                              child: Container(
                                  margin: EdgeInsets.only(right: 30.w),
                                  child: Text(
                                    "Windows 11 x64",
                                    style: TextStyle(
                                        fontSize: 32.w,
                                        height: 1.08,
                                        color: const Color.fromARGB(
                                            255, 180, 180, 180)),
                                  )))),
                      SizedBox(
                        height: 16.w,
                      ),
                      LJNFunctionItem(
                          // height: 150.w,
                          
                          title: "最近活跃时间",
                          // link: '',
                          tapEffect: false,
                          underline: false,
                          showStyle: Expanded(
                              flex: 1,
                              child: Container(
                                  margin: EdgeInsets.only(right: 30.w),
                                  child: Text(
                                    "11月10日 下午15:23",
                                    style: TextStyle(
                                        fontSize: 32.w,
                                        height: 1.08,
                                        color: const Color.fromARGB(
                                            255, 180, 180, 180)),
                                  )))),
                      Container(
                          margin: EdgeInsets.only(
                              left: 30.w, right: 30.w, top: 22.w, bottom: 22.w),
                          child: Text(
                            "登录微信后，当设备处于安全状态时，微信会自动延长登录时间以保持朋友消息的及时收发，此时会更新最近活跃时间。",
                            style: TextStyle(
                                fontSize: 27.w,
                                color:
                                    const Color.fromARGB(255, 149, 149, 149)),
                          )),
                      const LJNMaxWidthButton(
                        
                        title: "删除该设备",
                        color: Colors.red,
                        link: '',
                        underline: false,
                      ),
                      SizedBox(height: 106.w),
                    ])))));
  }
}
