import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNSwitch.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import '../components/LJNFunctionItem.dart';

class LJNNewMessageNotification extends StatefulWidget {
  const LJNNewMessageNotification({super.key});

  @override
  State<LJNNewMessageNotification> createState() =>
      _LJNNewMessageNotification();
}

class _LJNNewMessageNotification extends State<LJNNewMessageNotification> {
  double _statusHeight = 0;

  @override
  void initState() {
    super.initState();

    myStore.dispatch({"type": "homescrollpixels", "payload": 0.0});

    Future.delayed(const Duration(milliseconds: 300), () {
      myStore.dispatch({"type": "mainpage3isload", "payload": true});
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return vm.mainpage3isload! ? _buildPage(vm) : const LJNPageLoading();
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
                  title: const Text('新消息通知'),
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
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 64.w,
                        padding: const EdgeInsets.only(
                                left: 30.0, right: 0.0, top: 16)
                            .w,
                        child: Text(
                          "通知开关",
                          style: TextStyle(fontSize: 25.w, height: 1.08),
                        ),
                      ),

                      LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "接收新消息通知",
                        // link: '',
                        underline: true,
                        showStyle: Container(
                            margin: const EdgeInsets.only(right: 20).w,
                            child: LJNSwitch(
                              onChanged: (value) {
                                logger.info(value);
                              },
                            )),
                      ),
                      LJNFunctionItem(
                          id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                          title: "接收语音和视频通话邀请提醒",
                          // link: '',
                          underline: false,
                          showStyle: Container(
                              margin: const EdgeInsets.only(right: 20).w,
                              child: LJNSwitch(
                                onChanged: (value) {
                                  logger.info(value);
                                },
                              ))),
                      SizedBox(height: 16.w),

                      LJNFunctionItem(
                          id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                          title: "通知显示消息详情",
                          // link: '',
                          underline: false,
                          showStyle: Container(
                              margin: const EdgeInsets.only(right: 20).w,
                              child: LJNSwitch(
                                onChanged: (value) {
                                  logger.info(value);
                                },
                              ))),

                      Container(
                        alignment: Alignment.centerLeft,
                        height: 64.w,
                        padding: const EdgeInsets.only(
                                left: 30.0, right: 0.0, top: 16)
                            .w,
                        child: Text(
                          "声音与震动",
                          style: TextStyle(fontSize: 25.w, height: 1.08),
                        ),
                      ),

                      // 声音与震动
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "新消息系统通知",
                        link: '',
                        underline: true,
                        showStyle: '前往系统设置',
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "语音与视频通话提醒",
                        link: '',
                        underline: false,
                        showStyle: "前往系统设置",
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        height: 64.w,
                        padding: const EdgeInsets.only(
                                left: 30.0, right: 0.0, top: 16)
                            .w,
                        child: Text(
                          "提示音与铃声",
                          style: TextStyle(fontSize: 25.w, height: 1.08),
                        ),
                      ),

                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "消息提示音",
                        link: '',
                        underline: true,
                        showStyle: "跟随系统",
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "来电铃声",
                        link: '',
                        underline: true,
                        showStyle: "SISTER SISTER",
                      ),
                      LJNFunctionItem(
                          id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                          title: "呼叫我时朋友也可以听见我的来电铃声",
                          // link: '',
                          underline: false,
                          showStyle: Container(
                              margin: const EdgeInsets.only(right: 20).w,
                              child: LJNSwitch(
                                onChanged: (value) {
                                  logger.info(value);
                                },
                              ))),
                      SizedBox(height: 16.w),
                    ])))));
  }
}
