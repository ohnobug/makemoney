import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

import '../components/LJNFunctionItem.dart';
import '../components/maxWidthButton.dart';

class LJNSettingPage extends StatefulWidget {
  const LJNSettingPage({super.key});

  @override
  State<LJNSettingPage> createState() => _LJNSettingPage();
}

class _LJNSettingPage extends State<LJNSettingPage> {
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
                  title: const Text('设置'),
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
                    minHeight: screenSize.height - 90.w - _statusHeight),
                color: const Color.fromARGB(255, 237, 237, 237),
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Column(children: [
                      // 账户与安全
                      const LJNFunctionItem(
                        title: "账户与安全",
                        link: '/account_and_secure',
                        underline: false,
                      ),

                      SizedBox(height: 16.w),

                      // 青少年模式 与 关怀模式
                      const LJNFunctionItem(
                        title: "青少年模式",
                        link: '/teenage_mode',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        title: "关怀模式",
                        link: '/care_mode',
                        underline: false,
                      ),
                      SizedBox(height: 16.w),

                      // 新消息通知 与 聊天 和 通用
                      const LJNFunctionItem(
                        title: "新消息通知",
                        link: '/new_message_notification',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        title: "聊天",
                        link: '/chat_setting',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        title: "通用",
                        link: '/common_setting',
                        underline: false,
                      ),
                      // SizedBox(height: 16.w),
                      SizedBox(height: 16.w),

                      Container(
                        alignment: Alignment.centerLeft,
                        height: 64.w,
                        padding:
                            const EdgeInsets.only(left: 30.0, right: 0.0).w,
                        child: Text(
                          "隐私",
                          style: TextStyle(fontSize: 25.w, height: 1.08),
                        ),
                      ),

                      // 朋友权限 与 个人信息与权限 和 个人信息收集清单 和 第三方信息共享清单
                      const LJNFunctionItem(
                        title: "朋友权限",
                        link: '/friend_permission',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        title: "个人信息与权限",
                        link: '/personinfo_and_permission',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        title: "个人信息收集清单",
                        link: '/personalinfo_collection_checklist',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        title: "第三方信息共享清单",
                        link:
                            '/mywebview?link=list_of_third_party_information_sharing',
                        underline: false,
                      ),
                      SizedBox(height: 16.w),

                      LJNFunctionItem(
                        title: Row(
                          children: [
                            Text(
                              "插件",
                              style: TextStyle(
                                height: 1.08,
                                fontSize: fontSizeScale(32.0.w),
                                fontFamily: "AlibabaPuHuiTi",
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                            ),
                            Icon(
                              const IconData(
                                0xe610,
                                fontFamily: 'Iconfont',
                              ), // 使用的图标
                              color: Colors.black, // 图标颜色
                              size: 36.w, // 图标大小
                            )
                          ],
                        ),
                        link: '',
                        showStyle: "微信输入法可以【问AI】了",
                        underline: false,
                      ),
                      SizedBox(height: 16.w),

                      const LJNFunctionItem(
                        title: "关于微信",
                        link: '/about',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        title: "帮助与反馈",
                        link: '',
                        underline: false,
                      ),
                      SizedBox(height: 16.w),

                      const LJNMaxWidthButton(
                        title: "切换账号",
                        link: '',
                        underline: false,
                      ),
                      SizedBox(height: 16.w),

                      const LJNMaxWidthButton(
                        title: "退出",
                        link: '',
                        underline: false,
                      ),
                      SizedBox(height: 106.w),
                    ])))));
  }
}
