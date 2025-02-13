import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/components/ljn_switch.dart';
import 'package:jiaoyishuoflutter3/logger.dart';


import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import 'components/ljn_function_item.dart';

class LJNFriendPermissions extends StatefulWidget {
  const LJNFriendPermissions({super.key});

  @override
  State<LJNFriendPermissions> createState() => _LJNFriendPermissions();
}

class _LJNFriendPermissions extends State<LJNFriendPermissions> {
  bool chatOnly = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  // 另起一个函数方便管理
  Widget _buildPage(SystemState systemState) {
    return Scaffold(
        primary: false,
        appBar: const LJNAppBar(
          title: "朋友权限",
        ),
        body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        90.w -
                        systemState.statusHeight),
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
                          "设置朋友权限",
                          style: TextStyle(fontSize: 25.w, height: 1.08),
                        ),
                      ),
                      LJNFunctionItem(
                        title: "聊天、朋友圈、微信运动等",
                        onPress: () {
                          setState(() {
                            chatOnly = false;
                          });
                        },
                        underline: true,
                        tapEffect: true,
                        showLinkIcon: false,
                        showStyle: chatOnly == false
                            ? Expanded(
                                flex: 0,
                                child: Container(
                                    // color: Colors.red,
                                    width: 30.w,
                                    height: 105.0.w,
                                    margin: const EdgeInsets.only(
                                            left: 10, right: 32)
                                        .w,
                                    child: Icon(
                                      const IconData(
                                        0xe60d,
                                        fontFamily: 'Iconfont',
                                      ),
                                      size: 30.0.w,
                                      color: const Color.fromARGB(
                                          255, 69, 182, 87),
                                    )))
                            : const SizedBox(),
                      ),
                      LJNFunctionItem(
                        title: "仅聊天",
                        // link: '',
                        underline: false,
                        tapEffect: true,
                        onPress: () {
                          setState(() {
                            chatOnly = true;
                          });
                        },
                        showStyle: chatOnly
                            ? Expanded(
                                flex: 0,
                                child: Container(
                                    // color: Colors.red,
                                    width: 30.w,
                                    height: 105.0.w,
                                    margin: const EdgeInsets.only(
                                            left: 10, right: 32)
                                        .w,
                                    child: Icon(
                                      const IconData(
                                        0xe60d,
                                        fontFamily: 'Iconfont',
                                      ),
                                      size: 30.0.w,
                                      color: const Color.fromARGB(
                                          255, 69, 182, 87),
                                    )))
                            : const SizedBox(),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 64.w,
                        padding: const EdgeInsets.only(
                                left: 30.0, right: 0.0, top: 16)
                            .w,
                        child: Text(
                          "朋友圈和状态",
                          style: TextStyle(fontSize: 25.w, height: 1.08),
                        ),
                      ),
                      LJNFunctionItem(
                          title: "不让她看我",
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
                                  )))),
                      LJNFunctionItem(
                          title: "不看她",
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
                    ])))));
  }
}
