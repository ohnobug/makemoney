import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/ljn_function_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:jiaoyishuoflutter3/components/popup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/components/ljn_max_width_button.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';

class LJNFriendProfilePage extends StatefulWidget {
  const LJNFriendProfilePage({
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
  State<LJNFriendProfilePage> createState() => _LJNFriendProfilePage();
}

class _LJNFriendProfilePage extends State<LJNFriendProfilePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    SystemChannels.textInput.invokeMethod('TextInput.hide');
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
      appBar: null,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            LJNAppBar(
              title: "",
              bgColor: Colors.white,
              actions: [
                GestureDetector(
                  onTap: () {
                    // 点击事件
                    Navigator.pushNamed(
                      context,
                      '/friend_data_setting',
                    );
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
                      size: 42.w, // 图标大小
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              top: 90.w + systemState.statusHeight,
              left: 0,
              right: 0,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          90.w -
                          systemState.statusHeight),
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
                    child: Column(
                      children: [
                        Container(
                            width: 750.w,
                            height: 260.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 242, 242, 242),
                                  width: 1.5.w,
                                  style: BorderStyle.solid,
                                ))),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40.w,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.w),
                                      child: Image.asset(
                                        assetPath(widget.avatar!),
                                        width: 120.w,
                                        height: 120.w,
                                        cacheWidth: 240.w.toInt(),
                                        cacheHeight: 240.w.toInt(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 45.w,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // 姓名
                                          RichText(
                                            text: TextSpan(
                                              children: buildTextSpans(
                                                  widget.name!,
                                                  TextStyle(
                                                    height: 1.08,
                                                    fontSize:
                                                        fontSizeScale(40.w),
                                                    color: Colors.black,
                                                    fontFamily:
                                                        "AlibabaPuHuiTi-Medium",
                                                  ),
                                                  TextStyle(
                                                    height: 1.08,
                                                    fontSize:
                                                        fontSizeScale(40.w),
                                                  )),
                                            ),
                                          ),

                                          SizedBox(
                                            height: 20.w,
                                          ),

                                          // 昵称
                                          RichText(
                                            text: TextSpan(
                                              children: buildTextSpans(
                                                  '昵称: ${widget.nickname!}',
                                                  TextStyle(
                                                    height: 1.08,
                                                    fontSize:
                                                        fontSizeScale(27.w),
                                                    color: const Color.fromARGB(
                                                        255, 99, 99, 99),
                                                    fontFamily:
                                                        "AlibabaPuHuiTi-Medium",
                                                  ),
                                                  TextStyle(
                                                    height: 1.08,
                                                    fontSize:
                                                        fontSizeScale(27.w),
                                                  )),
                                            ),
                                          ),

                                          SizedBox(
                                            height: 20.w,
                                          ),

                                          // 微信号
                                          Text('微信号: ${widget.account!}',
                                              style: TextStyle(
                                                height: 1.08,
                                                fontSize: fontSizeScale(27.w),
                                                color: const Color.fromARGB(
                                                    255, 99, 99, 99),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),

                        // 设置备注与标签
                        const LJNFunctionItem(
                          title: "设置备注与标签",
                          link: '/friend_information',
                          underline: true,
                        ),

                        // 朋友权限
                        const LJNFunctionItem(
                          title: "朋友权限",
                          link: '/friend_permissions',
                          underline: true,
                        ),

                        Container(
                          color: const Color.fromARGB(255, 237, 237, 237),
                          height: 16.w,
                        ),

                        // 朋友圈
                        LJNFunctionItem(
                          title: Container(
                            width: 190.w,
                            padding: EdgeInsets.only(left: 30.w),
                            height: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "朋友圈",
                              style: TextStyle(
                                height: 1.08,
                                fontSize: fontSizeScale(32.0.w),
                                fontFamily: "AlibabaPuHuiTi",
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          link: '/friendmoments',
                          height: 151.w,
                          showStyle: SizedBox(
                              width: 470.w,
                              height: double.infinity,
                              // margin: EdgeInsets.only(left: 68.w),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      assetPath(
                                          'images/avatar_webp/chat_81.webp'),
                                      cacheWidth: 180.w.toInt(),
                                      cacheHeight: 180.w.toInt(),
                                      width: 90.w,
                                      height: 90.w,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Image.asset(
                                      assetPath(
                                          'images/avatar_webp/chat_92.webp'),
                                      cacheWidth: 180.w.toInt(),
                                      cacheHeight: 180.w.toInt(),
                                      width: 90.w,
                                      height: 90.w,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Image.asset(
                                      assetPath(
                                          'images/avatar_webp/chat_93.webp'),
                                      cacheWidth: 180.w.toInt(),
                                      cacheHeight: 180.w.toInt(),
                                      width: 90.w,
                                      height: 90.w,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Image.asset(
                                      assetPath(
                                          'images/avatar_webp/chat_86.webp'),
                                      cacheWidth: 180.w.toInt(),
                                      cacheHeight: 180.w.toInt(),
                                      width: 90.w,
                                      height: 90.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ])),
                          underline: true,
                        ),

                        // 视频号
                        LJNFunctionItem(
                          title: Container(
                            width: 190.w,
                            padding: EdgeInsets.only(left: 30.w, top: 38.w),
                            height: double.infinity,
                            alignment: Alignment.topLeft,
                            child: Text(
                              "视频号",
                              style: TextStyle(
                                height: 1.08,
                                fontSize: fontSizeScale(32.0.w),
                                fontFamily: "AlibabaPuHuiTi",
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          link: '/ins',
                          showLinkIcon: false,
                          height: 216.w,
                          showStyle: SizedBox(
                              width: 490.w + 62.w,
                              height: 215.w,
                              // margin: EdgeInsets.only(left: 68.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 38.w,
                                      ),
                                      Text(
                                        widget.name as String,
                                        style: TextStyle(
                                          height: 1.08,
                                          fontSize: fontSizeScale(32.0.w),
                                          fontFamily: "AlibabaPuHuiTi",
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 28.w,
                                      ),
                                      // 视频
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              assetPath(
                                                  'images/avatar_webp/chat_55.webp'),
                                              cacheWidth: 180.w.toInt(),
                                              cacheHeight: 180.w.toInt(),
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Image.asset(
                                              assetPath(
                                                  'images/avatar_webp/chat_43.webp'),
                                              cacheWidth: 180.w.toInt(),
                                              cacheHeight: 180.w.toInt(),
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Image.asset(
                                              assetPath(
                                                  'images/avatar_webp/chat_96.webp'),
                                              cacheWidth: 180.w.toInt(),
                                              cacheHeight: 180.w.toInt(),
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Image.asset(
                                              assetPath(
                                                  'images/avatar_webp/chat_97.webp'),
                                              cacheWidth: 180.w.toInt(),
                                              cacheHeight: 180.w.toInt(),
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ])
                                    ],
                                  ),
                                  Container(
                                      width: 30.w,
                                      margin: EdgeInsets.only(
                                          right: 32.w, top: 75.w),
                                      child: Icon(
                                        const IconData(
                                          0xed9d,
                                          fontFamily: 'Iconfont',
                                        ),
                                        size: 30.0.w,
                                        color: const Color.fromARGB(
                                            255, 164, 164, 164),
                                      ))
                                ],
                              )),
                          underline: true,
                        ),

                        // 更多信息
                        const LJNFunctionItem(
                          title: "更多信息",
                          link: '/friend_more_info',
                          underline: false,
                        ),

                        Container(
                          color: const Color.fromARGB(255, 237, 237, 237),
                          height: 16.w,
                        ),

                        LJNMaxWidthButton(
                          title: Text.rich(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            TextSpan(children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Baseline(
                                  baseline: 29.5.w,
                                  baselineType: TextBaseline.alphabetic,
                                  child: Icon(
                                    const IconData(
                                      0xe7b3,
                                      fontFamily: 'Iconfont',
                                    ),
                                    color:
                                        const Color.fromARGB(255, 58, 81, 124),
                                    size: 38.w,
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                child: SizedBox(width: 12.w),
                              ),
                              TextSpan(
                                text: "发信息",
                                style: TextStyle(
                                  height: 1.08,
                                  fontSize: 30.w,
                                  color: const Color.fromARGB(255, 58, 81, 124),
                                ),
                              ),
                            ]),
                          ),
                          underline: true,
                          onPressed: () {
                            Navigator.pushNamed(context, '/chat',
                                arguments: <String, String>{
                                  'title': "何三七",
                                  'icon': "images/avatar_webp/chat_17.webp",
                                });
                          },
                        ),

                        LJNMaxWidthButton(
                          title: Text.rich(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            TextSpan(
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Baseline(
                                    baseline: 31.w,
                                    baselineType: TextBaseline.alphabetic,
                                    child: Icon(
                                      const IconData(
                                        0xe88d,
                                        fontFamily: 'Iconfont',
                                      ),
                                      color: const Color.fromARGB(
                                          255, 58, 81, 124),
                                      size: 42.w,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: SizedBox(width: 12.w),
                                ),
                                TextSpan(
                                  text: "音视频通话",
                                  style: TextStyle(
                                    height: 1.08,
                                    fontSize: 30.w,
                                    color:
                                        const Color.fromARGB(255, 58, 81, 124),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          underline: false,
                          onPressed: () {
                            showPopup(context, systemState);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
