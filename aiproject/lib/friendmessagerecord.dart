import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNSwitch.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

import 'components/LJNFunctionItem.dart';

class LJNFriendMessageRecord extends StatefulWidget {
  const LJNFriendMessageRecord({
    super.key,
    this.name,
    this.avatar,
    this.nickname,
    this.account,
  });

  final String? name;
  final String? avatar;
  final String? nickname;
  final String? account;

  @override
  State<LJNFriendMessageRecord> createState() => _LJNFriendMessageRecord();
}

class _LJNFriendMessageRecord extends State<LJNFriendMessageRecord> {
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
          return _buildPage();
        });
  }

  // 另起一个函数方便管理
  Widget _buildPage() {
    Size screenSize = MediaQuery.of(context).size;
    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
              primary: false,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(90.0.w + _statusHeight),
                  child: Container(
                      color: Colors.white,
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
                        title: const Text('聊天消息'),
                        toolbarHeight: 90.w,
                        titleTextStyle: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(32.w),
                            color: Colors.black,
                            fontFamily: "AlibabaPuHuiTi-Medium"),
                        elevation: 0,
                        scrolledUnderElevation: 0,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.white,
                        actions: [
                          // 三个点
                          GestureDetector(
                            onTap: () {
                              // 点击事件
                            },
                            child: Container(
                              height: 90.w,
                              color: Colors.transparent,
                              padding: EdgeInsets.only(right: 33.w), // 设置右侧内边距
                              alignment: Alignment.center,
                              child: Icon(
                                const IconData(
                                  0xe659,
                                  fontFamily: 'Iconfont',
                                ),
                                size: 37.w, // 图标大小
                              ),
                            ),
                          ),
                        ],
                      ))),
              body: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: Container(
                      constraints: BoxConstraints(
                          minHeight: screenSize.height - 90.w - _statusHeight),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Color.fromARGB(255, 237, 237, 237)
                          ],
                          stops: [0.3, 0.5],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          child: Column(children: [
                            Container(
                              height: 202.w,
                              width: 750.w,
                              padding: EdgeInsets.only(left: 25.w, right: 25.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 105.w,
                                    height: 140.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8).w,
                                            child: Image.asset(
                                              assetPath(vm.userinfoAvatar!),
                                              cacheWidth: 210.w.toInt(),
                                              cacheHeight: 210.w.toInt(),
                                              width: 105.w,
                                              height: 105.w,
                                              fit: BoxFit.cover,
                                            )),
                                        SizedBox(
                                          height: 13.w,
                                        ),
                                        Text(
                                          '邓子乔',
                                          style: TextStyle(
                                              height: 1.08,
                                              fontSize: 20.w,
                                              color: const Color.fromARGB(
                                                  255, 169, 169, 169)),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 52.w,
                                  ),
                                  const IconBox()
                                ],
                              ),
                            ),
                            Container(
                                color: const Color.fromARGB(255, 237, 237, 237),
                                height: 16.w),
                            const LJNFunctionItem(
                              title: "查找聊天记录",
                              link: '',
                              underline: false,
                            ),
                            Container(
                                color: const Color.fromARGB(255, 237, 237, 237),
                                height: 16.w),
                            LJNFunctionItem(
                              title: "消息免打扰",
                              // link: '',
                              underline: true,
                              tapEffect: false,
                              showStyle: Expanded(
                                  flex: 0,
                                  child: Container(
                                      margin:
                                          const EdgeInsets.only(right: 32).w,
                                      child: LJNSwitch(
                                        initialValue: false,
                                        onChanged: (value) {
                                          logger.info(value);
                                        },
                                      ))),
                            ),
                            LJNFunctionItem(
                              title: "置顶聊天",
                              // link: '',
                              underline: true,
                              tapEffect: false,
                              showStyle: Expanded(
                                  flex: 0,
                                  child: Container(
                                      margin:
                                          const EdgeInsets.only(right: 32).w,
                                      child: LJNSwitch(
                                        initialValue: false,
                                        onChanged: (value) {
                                          logger.info(value);
                                        },
                                      ))),
                            ),
                            LJNFunctionItem(
                              title: "提醒",
                              // link: '',
                              underline: false,
                              tapEffect: false,
                              showStyle: Expanded(
                                  flex: 0,
                                  child: Container(
                                      margin:
                                          const EdgeInsets.only(right: 32).w,
                                      child: LJNSwitch(
                                        initialValue: false,
                                        onChanged: (value) {
                                          logger.info(value);
                                        },
                                      ))),
                            ),
                            const LJNFunctionItem(
                              title: "设置当前聊天背景",
                              link: '',
                              underline: false,
                            ),
                            Container(
                                color: const Color.fromARGB(255, 237, 237, 237),
                                height: 16.w),
                            const LJNFunctionItem(
                              title: "清空聊天记录",
                              link: '',
                              underline: false,
                            ),
                            Container(
                                color: const Color.fromARGB(255, 237, 237, 237),
                                height: 16.w),
                            const LJNFunctionItem(
                              title: "投诉",
                              link: '',
                              underline: false,
                            ),
                          ])))));
        });
  }
}

class IconBox extends StatelessWidget {
  const IconBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.w,
      width: 105.w,
      alignment: Alignment.topLeft,
      child: DottedBorder(
          color: const Color.fromARGB(255, 166, 166, 166),
          borderType: BorderType.RRect,
          padding: const EdgeInsets.all(0),
          borderPadding: const EdgeInsets.all(0),
          stackFit: StackFit.loose,
          strokeWidth: 3.w,
          dashPattern: [16.w, 10.w],
          strokeCap: StrokeCap.round,
          radius: Radius.circular(8.0.w),
          child: SizedBox(
            width: 105.0.w, // 设置宽度
            height: 105.0.w, // 设置高度
            // decoration: BoxDecoration(
            //   color: Colors.transparent, // 背景透明
            //   borderRadius: BorderRadius.circular(8.0.w), // 圆角 8
            //   border: Border.all(
            //     color: const Color.fromARGB(255, 166, 166, 166), // 边框颜色
            //     width: 1.0.w,
            //     style: BorderStyle.solid, // 边框样式
            //   ),
            //   shape: BoxShape.rectangle, // 矩形盒子
            // ),
            child: Center(
              child: Icon(
                const IconData(
                  0xe616,
                  fontFamily: 'Iconfont',
                ), // 使用的图标
                color: const Color.fromARGB(255, 166, 166, 166), // 图标颜色
                size: 42.0.w, // 图标大小
              ),
            ),
          )),
    );
  }
}
