import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/components/ljn_special_function_item.dart';
import 'package:jiaoyishuoflutter3/components/ljn_switch.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import '../components/ljn_function_item.dart';

class LJNFriendPermission extends StatefulWidget {
  const LJNFriendPermission({super.key});

  @override
  State<LJNFriendPermission> createState() => _LJNFriendPermission();
}

class _LJNFriendPermission extends State<LJNFriendPermission> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
      builder: (context, systemState) {
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
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    LJNFunctionItem(
                      title: "加我为朋友时需要验证",
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
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.w,
                    ),
                    const LJNFunctionItem(
                      title: "添加我的方式",
                      link: '',
                      underline: true,
                    ),
                    LJNSpecialFunctionItem(
                      title: "向我推荐通讯录朋友",
                      tapEffect: false,
                      underline: false,
                      height: 137.w,
                      // link: '',
                      subTitle: Text(
                        "开启后，在「通讯录>新的朋友」为你推荐已经注册账号的手机联系人。",
                        maxLines: 3,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 193, 193, 193),
                          fontSize: 24.w,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "AlibabaPuHuiTi",
                        ),
                      ),
                      showStyle: Expanded(
                          flex: 0,
                          child: Container(
                              margin: const EdgeInsets.only(right: 32).w,
                              child: LJNSwitch(
                                initialValue: false,
                                onChanged: (value) {
                                  logger.info(value);
                                },
                              ))),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 64.w,
                      padding:
                          const EdgeInsets.only(left: 30.0, right: 0.0, top: 16)
                              .w,
                      child: Text(
                        "朋友权限",
                        style: TextStyle(fontSize: 25.w, height: 1.08),
                      ),
                    ),
                    const LJNFunctionItem(
                      title: "仅聊天",
                      link: '',
                      underline: true,
                    ),
                    const LJNFunctionItem(
                      title: "朋友圈",
                      link: '',
                      underline: true,
                    ),
                    const LJNFunctionItem(
                      title: "视频号",
                      link: '',
                      underline: true,
                    ),
                    const LJNFunctionItem(
                      title: "看一看",
                      link: '',
                      underline: true,
                    ),
                    const LJNFunctionItem(
                      title: "微信运动",
                      link: '',
                      underline: true,
                    ),
                    SizedBox(
                      height: 16.w,
                    ),
                    const LJNFunctionItem(
                      title: "通讯录黑名单",
                      link: '',
                      underline: false,
                    ),
                    SizedBox(height: 16.w),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
