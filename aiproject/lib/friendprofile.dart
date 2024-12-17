import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNAppBar.dart';
import 'package:jiaoyishuoflutter3/components/LJNMaxWidthButton.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'components/LJNFunctionItem.dart';

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
  bool showDialSelector = false;
  late AnimationController _animationController;
  late Animation<double> _upAnimation;

  @override
  void initState() {
    super.initState();
    // 初始化 _animationContentController
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 50),
      vsync: this,
    );

    _upAnimation = Tween<double>(begin: -330.w, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
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
          return Stack(
            children: [
              Scaffold(
                  primary: false,
                  appBar: LJNAppBar(
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
                  body: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: Container(
                          constraints: BoxConstraints(
                              minHeight:
                                  screenSize.height - 90.w - vm.statusHeight!),
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
                                    width: 750.w,
                                    height: 260.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            bottom: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 242, 242, 242),
                                          width: 1.5.w,
                                          style: BorderStyle.solid,
                                        ))),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 40.w,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 30.w,
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.w),
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
                                                                fontSizeScale(
                                                                    40.w),
                                                            color: Colors.black,
                                                            fontFamily:
                                                                "AlibabaPuHuiTi-Medium",
                                                          ),
                                                          TextStyle(
                                                            height: 1.08,
                                                            fontSize:
                                                                fontSizeScale(
                                                                    40.w),
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
                                                                fontSizeScale(
                                                                    27.w),
                                                            color: const Color
                                                                .fromARGB(255,
                                                                99, 99, 99),
                                                            fontFamily:
                                                                "AlibabaPuHuiTi-Medium",
                                                          ),
                                                          TextStyle(
                                                            height: 1.08,
                                                            fontSize:
                                                                fontSizeScale(
                                                                    27.w),
                                                          )),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: 20.w,
                                                  ),

                                                  // 微信号
                                                  Text(
                                                      '微信号: ${widget.account!}',
                                                      style: TextStyle(
                                                        height: 1.08,
                                                        fontSize:
                                                            fontSizeScale(27.w),
                                                        color: const Color
                                                            .fromARGB(
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
                                  link: '',
                                  underline: true,
                                ),

                                // 朋友权限
                                const LJNFunctionItem(
                                  title: "朋友权限",
                                  link: '',
                                  underline: true,
                                ),

                                Container(
                                    color: const Color.fromARGB(
                                        255, 237, 237, 237),
                                    height: 16.w),

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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                    padding:
                                        EdgeInsets.only(left: 30.w, top: 38.w),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 38.w,
                                              ),
                                              Text(
                                                widget.name as String,
                                                style: TextStyle(
                                                  height: 1.08,
                                                  fontSize:
                                                      fontSizeScale(32.0.w),
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
                                                      cacheHeight:
                                                          180.w.toInt(),
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
                                                      cacheHeight:
                                                          180.w.toInt(),
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
                                                      cacheHeight:
                                                          180.w.toInt(),
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
                                                      cacheHeight:
                                                          180.w.toInt(),
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
                                    color: const Color.fromARGB(
                                        255, 237, 237, 237),
                                    height: 16.w),

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
                                            color: const Color.fromARGB(
                                                255, 58, 81, 124),
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
                                          color: const Color.fromARGB(
                                              255, 58, 81, 124),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  underline: true,
                                  link: '/chat',
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/chat',
                                        arguments: <String, String>{
                                          'title': "何三七",
                                          'icon':
                                              "images/avatar_webp/chat_17.webp",
                                        });
                                  },
                                ),

                                LJNMaxWidthButton(
                                  title: Text.rich(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    TextSpan(children: [
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
                                          color: const Color.fromARGB(
                                              255, 58, 81, 124),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  underline: false,
                                  // link: '/dial',
                                  onPressed: () {
                                    setState(() {
                                      showDialSelector = true;
                                    });
                                    _animationController.forward();
                                  },
                                ),
                              ]))))),

              // 背景色
              if (showDialSelector)
                GestureDetector(
                    onTap: () {
                      _animationController.reverse().then((_) {
                        setState(() {
                          showDialSelector = false;
                        });
                      });
                    },
                    child: Container(
                      color: const Color.fromARGB(167, 0, 0, 0),
                      width: 750.w,
                      height: screenSize.height,
                    )),

              AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Positioned(
                        left: 0,
                        bottom: _upAnimation.value,
                        width: 750.w,
                        height: 330.w,
                        child: Scaffold(
                            body: Column(
                          children: [
                            LJNMaxWidthButton(
                              title: Text.rich(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                TextSpan(children: [
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    style: const TextStyle(
                                      decoration: TextDecoration.none,
                                    ),
                                    child: Baseline(
                                      baseline: 31.w,
                                      baselineType: TextBaseline.alphabetic,
                                      child: Icon(
                                        const IconData(
                                          0xe64f,
                                          fontFamily: 'Iconfont',
                                        ),
                                        color: Colors.black,
                                        size: 42.w,
                                      ),
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: SizedBox(width: 50.w),
                                  ),
                                  TextSpan(
                                    text: "视频通话",
                                    style: TextStyle(
                                      height: 1.08,
                                      fontSize: 30.w,
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                    ),
                                  ),
                                ]),
                              ),
                              underline: false,
                              link: '/dial',
                            ),
                            LJNMaxWidthButton(
                              title: Text.rich(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                TextSpan(children: [
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    style: const TextStyle(
                                      decoration: TextDecoration.none,
                                    ),
                                    child: Baseline(
                                      baseline: 31.w,
                                      baselineType: TextBaseline.alphabetic,
                                      child: Icon(
                                        const IconData(
                                          0xe64c,
                                          fontFamily: 'Iconfont',
                                        ),
                                        color: Colors.black,
                                        size: 42.w,
                                      ),
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: SizedBox(width: 50.w),
                                  ),
                                  TextSpan(
                                    text: "语音通话",
                                    style: TextStyle(
                                      height: 1.08,
                                      fontSize: 30.w,
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                    ),
                                  ),
                                ]),
                              ),
                              underline: false,
                              link: '/dial',
                            ),
                            SizedBox(
                              height: 15.w,
                            ),
                            const LJNMaxWidthButton(
                                title: "取消", underline: true),
                          ],
                        )));
                  })
            ],
          );
        });
  }
}
