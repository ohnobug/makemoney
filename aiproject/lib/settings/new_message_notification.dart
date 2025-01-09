import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/components/ljn_switch.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/ljn_function_item.dart';

class LJNNewMessageNotification extends StatefulWidget {
  const LJNNewMessageNotification({super.key});

  @override
  State<LJNNewMessageNotification> createState() =>
      _LJNNewMessageNotification();
}

class _LJNNewMessageNotification extends State<LJNNewMessageNotification> {
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
    return Scaffold(
        primary: false,
        appBar: const LJNAppBar(
          title: "新消息通知",
        ),
        body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
                constraints: BoxConstraints(
                    minHeight: vm.screenSize!.height - 90.w - vm.statusHeight!),
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
                        title: "接收新消息通知",
                        // link: '',
                        underline: true,
                        tapEffect: false,
                        showStyle: Expanded(
                            flex: 0,
                            child: Container(
                                margin: const EdgeInsets.only(right: 32).w,
                                child: LJNSwitch(
                                  initialValue: true,
                                  onChanged: (value) {
                                    logger.info(value);
                                  },
                                ))),
                      ),
                      LJNFunctionItem(
                          title: "接收语音和视频通话邀请提醒",
                          // link: '',
                          underline: false,
                          tapEffect: false,
                          showStyle: Expanded(
                              flex: 0,
                              child: Container(
                                  margin: const EdgeInsets.only(right: 32).w,
                                  child: LJNSwitch(
                                    initialValue: true,
                                    onChanged: (value) {
                                      logger.info(value);
                                    },
                                  )))),
                      SizedBox(height: 16.w),

                      LJNFunctionItem(
                          title: "通知显示消息详情",
                          // link: '',
                          underline: false,
                          tapEffect: false,
                          showStyle: Expanded(
                              flex: 0,
                              child: Container(
                                  margin: const EdgeInsets.only(right: 32).w,
                                  child: LJNSwitch(
                                    initialValue: true,
                                    onChanged: (value) {
                                      logger.info(value);
                                    },
                                  )))),

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
                        title: "新消息系统通知",
                        link: '',
                        underline: true,
                        showStyle: '前往系统设置',
                      ),
                      const LJNFunctionItem(
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
                        title: "消息提示音",
                        link: '',
                        underline: true,
                        showStyle: "跟随系统",
                      ),
                      const LJNFunctionItem(
                        title: "来电铃声",
                        link: '',
                        underline: true,
                        showStyle: "SISTER SISTER",
                      ),
                      LJNFunctionItem(
                          title: "呼叫我时朋友也可以听见我的来电铃声",
                          // link: '',
                          underline: false,
                          tapEffect: false,
                          showStyle: Expanded(
                              flex: 0,
                              child: Container(
                                  margin: const EdgeInsets.only(right: 32).w,
                                  child: LJNSwitch(
                                    initialValue: true,
                                    onChanged: (value) {
                                      logger.info(value);
                                    },
                                  )))),
                      SizedBox(height: 16.w),
                    ])))));
  }
}
