import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/components/ljn_popup.dart';
import 'package:jiaoyishuoflutter3/components/ljn_switch.dart';
import 'package:jiaoyishuoflutter3/components/ljn_max_width_button.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/ljn_function_item.dart';

class LJNFriendDataSetting extends StatefulWidget {
  const LJNFriendDataSetting({
    super.key,
  });

  @override
  State<LJNFriendDataSetting> createState() => _LJNFriendDataSetting();
}

class _LJNFriendDataSetting extends State<LJNFriendDataSetting> {
  bool showPopup = false;

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
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Stack(
            children: [
              Positioned(
                child: Scaffold(
                    primary: false,
                    appBar: const LJNAppBar(
                      title: "资料设置",
                    ),
                    body: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: Container(
                            constraints: BoxConstraints(
                                minHeight: vm.screenSize!.height -
                                    90.w -
                                    vm.statusHeight!),
                            color: const Color.fromARGB(255, 237, 237, 237),
                            child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                child: Column(children: [
                                  const LJNFunctionItem(
                                    title: "设置备注和标签",
                                    link: '/set_notes_and_labels',
                                    showStyle: "邓子乔",
                                    underline: true,
                                  ),
                                  const LJNFunctionItem(
                                    title: "朋友权限",
                                    link: '/friend_permissions',
                                    underline: false,
                                  ),
                                  Container(
                                      color: const Color.fromARGB(
                                          255, 237, 237, 237),
                                      height: 16.w),
                                  const LJNFunctionItem(
                                    title: "把她推荐给朋友",
                                    link: '',
                                    underline: true,
                                  ),
                                  LJNFunctionItem(
                                    title: "添加到桌面",
                                    // link: '',
                                    underline: false,
                                    onPress: () {
                                      setState(() {
                                        showPopup = true;
                                      });
                                    },
                                  ),
                                  Container(
                                      color: const Color.fromARGB(
                                          255, 237, 237, 237),
                                      height: 16.w),
                                  LJNFunctionItem(
                                    title: "设为星标朋友",
                                    // link: '',
                                    underline: false,
                                    tapEffect: false,
                                    showStyle: Expanded(
                                        flex: 0,
                                        child: Container(
                                            margin:
                                                const EdgeInsets.only(right: 32)
                                                    .w,
                                            child: LJNSwitch(
                                              initialValue: false,
                                              onChanged: (value) {
                                                logger.info(value);
                                              },
                                            ))),
                                  ),
                                  Container(
                                      color: const Color.fromARGB(
                                          255, 237, 237, 237),
                                      height: 16.w),
                                  LJNFunctionItem(
                                    title: "加入黑名单",
                                    tapEffect: false,
                                    underline: true,
                                    showStyle: Expanded(
                                        flex: 0,
                                        child: Container(
                                            margin:
                                                const EdgeInsets.only(right: 32)
                                                    .w,
                                            child: LJNSwitch(
                                              initialValue: false,
                                              onChanged: (value) {
                                                logger.info(value);
                                              },
                                            ))),
                                  ),
                                  const LJNFunctionItem(
                                    title: "投诉",
                                    link: '',
                                    underline: false,
                                  ),
                                  Container(
                                      color: const Color.fromARGB(
                                          255, 237, 237, 237),
                                      height: 16.w),
                                  const LJNMaxWidthButton(
                                    title: '删除',
                                    color: Colors.red,
                                    underline: false,
                                  ),
                                ]))))),
              ),
              if (showPopup)
                LJNPopup(
                  onReturn: () {
                    setState(() {
                      showPopup = false;
                    });
                  },
                )
            ],
          );
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
