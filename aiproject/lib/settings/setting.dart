import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNAppBar.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

import '../components/LJNFunctionItem.dart';
import '../components/LJNMaxWidthButton.dart';

class LJNSettingPage extends StatefulWidget {
  const LJNSettingPage({super.key});

  @override
  State<LJNSettingPage> createState() => _LJNSettingPage();
}

class _LJNSettingPage extends State<LJNSettingPage> {
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
        appBar: const LJNAppBar(
          title: "设置",
        ),
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
                      LJNFunctionItem(
                        title: "第三方信息共享清单",
                        link:
                            "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing')}",
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
