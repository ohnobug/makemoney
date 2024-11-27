import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNSpecialFunctionItem.dart';
import 'package:jiaoyishuoflutter3/components/LJNSwitch.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import '../../components/LJNFunctionItem.dart';

class LJNFriendPermission extends StatefulWidget {
  const LJNFriendPermission({super.key});

  @override
  State<LJNFriendPermission> createState() => _LJNFriendPermission();
}

class _LJNFriendPermission extends State<LJNFriendPermission> {
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
                  title: const Text('朋友权限'),
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
                                  initialValue: false,
                                  onChanged: (value) {
                                    logger.info(value);
                                  },
                                ))),
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
                        underline: false,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 64.w,
                        padding: const EdgeInsets.only(
                                left: 30.0, right: 0.0, top: 16)
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
                    ])))));
  }
}
