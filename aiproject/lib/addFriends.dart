import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNAppBar.dart';
import 'package:jiaoyishuoflutter3/components/LJNIconFunctionItem.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNAddFriends extends StatefulWidget {
  const LJNAddFriends({
    super.key,
  });

  @override
  State<LJNAddFriends> createState() => _LJNAddFriends();
}

class _LJNAddFriends extends State<LJNAddFriends> {
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

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
              primary: false,
              appBar: const LJNAppBar(
                title: "添加朋友",
              ),
              body: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: Container(
                      constraints: BoxConstraints(
                          minHeight:
                              screenSize.height - 90.w - vm.statusHeight!),
                      color: const Color.fromARGB(255, 237, 237, 237),
                      child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          child: Column(children: [
                            // 搜索框
                            Container(
                                // color: Colors.blue,
                                margin: EdgeInsets.symmetric(horizontal: 15.w),
                                height: 65.w,
                                child: TextField(
                                  onTapOutside: (event) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  cursorHeight: 35.w,
                                  cursorWidth: 3.w,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      const IconData(
                                        0xe612,
                                        fontFamily: 'Iconfont',
                                      ),
                                      color: Colors.black,
                                      size: 40.w,
                                    ),
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 70.w, // 控制图标与文字的最小宽度
                                      // minHeight: 36.w,
                                    ),
                                    hintText: "搜索",
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 30.w,
                                        color: const Color.fromARGB(
                                            255, 69, 75, 83)),
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8.0.w, horizontal: 20.0.w),
                                  ),
                                )),

                            SizedBox(
                              height: 44.w,
                            ),

                            // 我的微信号
                            Container(
                              height: 37.w,
                              alignment: Alignment.center,
                              child: Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text: "我的微信号: ${vm.userinfoAccount}",
                                    style: TextStyle(
                                      height: 1.08,
                                      fontSize: 25.w,
                                      color: const Color.fromARGB(
                                          255, 105, 105, 105),
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: SizedBox(width: 8.w),
                                  ),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    style: const TextStyle(height: 1.08),
                                    child: Icon(
                                      const IconData(0xe74b,
                                          fontFamily: 'Iconfont'),
                                      color: const Color.fromARGB(
                                          255, 105, 105, 105),
                                      size: 37.w,
                                    ),
                                  ),
                                ]),
                              ),
                            ),

                            SizedBox(
                              height: 135.w,
                            ),

                            const LJNIconFunctionItem(
                              title: "雷达加朋友",
                              link: '',
                              underline: true,
                              avatar: "images/icon/add_friend_icon1.png",
                              message: '添加身边的朋友',
                            ),

                            const LJNIconFunctionItem(
                              title: "面对面建群",
                              link: '',
                              underline: true,
                              avatar: "images/icon/add_friend_icon2.png",
                              message: '与身边的朋友进入同一个群聊',
                            ),

                            const LJNIconFunctionItem(
                              title: "扫一扫",
                              link: '/qrcode_scanner',
                              underline: true,
                              avatar: "images/icon/add_friend_icon3.png",
                              message: '扫描二维码名片',
                            ),

                            const LJNIconFunctionItem(
                              title: "手机联系人",
                              link: '/phone_contact',
                              underline: true,
                              avatar: "images/icon/add_friend_icon4.png",
                              message: '添加或邀请通讯录中的朋友',
                            ),

                            const LJNIconFunctionItem(
                              title: "公众号",
                              link: '',
                              underline: true,
                              avatar: "images/icon/add_friend_icon5.png",
                              message: '获取更多资讯和服务',
                            ),

                            const LJNIconFunctionItem(
                              title: "企业微信联系人",
                              link: '',
                              underline: false,
                              avatar: "images/icon/add_friend_icon6.png",
                              message: '通过手机号搜索企业微信用户',
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
