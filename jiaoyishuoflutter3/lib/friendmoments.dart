import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNFriendmomentsPage extends StatefulWidget {
  const LJNFriendmomentsPage({super.key});

  @override
  State<LJNFriendmomentsPage> createState() => _LJNFriendmomentsPage();
}

class _LJNFriendmomentsPage extends State<LJNFriendmomentsPage>
    with SingleTickerProviderStateMixin {
  double _statusHeight = 0;

  final ScrollController _scrollController = ScrollController();
  double scrollPosition = 0;

  late AnimationController _controller; // 动画控制器
  late Animation<double> _opacity; // 透明度动画

  late List<Map<String, dynamic>> tweetList;

  // 最后点击更多的位置
  late Offset lastedMoreButtonPosition = const Offset(0, 0);
  late bool likeBoxVisible = false;
  // 列表是否在滚动
  late bool _isScrolling = false;

  @override
  void initState() {
    super.initState();

    double beginPosition = _statusHeight + 450.w;

    // 添加监听器以监控滚动
    _scrollController.addListener(() {
      // logger.info("pixels:${_scrollController.position.pixels}");
      // logger.info("minScrollExtent:${_scrollController.position.minScrollExtent}");
      // logger.info("maxScrollExtent:${_scrollController.position.maxScrollExtent}");

      setState(() {
        scrollPosition = _scrollController.position.pixels;

        if (_scrollController.position.pixels - beginPosition <= 0) {
          _controller.value = 0;
        } else {
          _controller.value =
              (_scrollController.position.pixels - beginPosition) /
                  (beginPosition + 40.w - beginPosition);
        }

        // 点赞盒子隐藏
        likeBoxVisible = false;
      });
    });

    // 初始化 AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // 动画持续时间
      vsync: this,
    );

    // 定义透明度动画
    _opacity = Tween<double>(begin: 0.0, end: 255.0).animate(_controller);

    // Tweet数据
    tweetList = [
      {
        "time": "一分钟前",
        "avatarUrl": 'images/avatar_webp/chat_1.webp',
        "name": "李珣🐞",
        "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
        "imageList": const [
          'images/avatar_webp/chat_1.webp',
          'images/avatar_webp/chat_2.webp',
          'images/avatar_webp/chat_3.webp',
          'images/avatar_webp/chat_4.webp',
          'images/avatar_webp/chat_5.webp',
          'images/avatar_webp/chat_6.webp',
          'images/avatar_webp/chat_7.webp',
          'images/avatar_webp/chat_8.webp',
          'images/avatar_webp/chat_9.webp',
        ],
        "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
      },
      {
        "time": "一分钟前",
        "avatarUrl": 'images/avatar_webp/chat_2.webp',
        "name": "西宝✨",
        "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
        "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
      },
      {
        "time": "一分钟前",
        "avatarUrl": 'images/avatar_webp/chat_5.webp',
        "name": "史登达",
        "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
        "imageList": const [
          'images/avatar_webp/chat_8.webp',
          'images/avatar_webp/chat_9.webp',
          'images/avatar_webp/chat_10.webp',
          'images/avatar_webp/chat_11.webp',
          'images/avatar_webp/chat_12.webp',
          'images/avatar_webp/chat_13.webp',
        ],
        "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
      },
      {
        "time": "一分钟前",
        "avatarUrl": 'images/avatar_webp/chat_8.webp',
        "name": "平婆婆",
        "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
        "imageList": const [
          'images/avatar_webp/chat_8.webp',
          'images/avatar_webp/chat_11.webp',
          '',
          'images/avatar_webp/chat_12.webp',
          'images/avatar_webp/chat_13.webp',
        ],
        "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
      },
      {
        "time": "一分钟前",
        "avatarUrl": 'images/avatar_webp/chat_9.webp',
        "name": "哑梢公💖👉🫖",
        "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
        "imageList": const [
          'images/avatar_webp/chat_15.webp',
          'images/avatar_webp/chat_16.webp',
          'images/avatar_webp/chat_17.webp',
          'images/avatar_webp/chat_18.webp',
          'images/avatar_webp/chat_19.webp',
        ],
        "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
      },
      {
        "time": "一分钟前",
        "avatarUrl": 'images/avatar_webp/chat_60.webp',
        "name": "余兆兴",
        "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
        "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
      },
      {
        "time": "一分钟前",
        "avatarUrl": 'images/avatar_webp/chat_65.webp',
        "name": "云中鹤",
        "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
        "imageList": const [
          'images/avatar_webp/chat_20.webp',
          'images/avatar_webp/chat_21.webp',
          'images/avatar_webp/chat_22.webp',
          'images/avatar_webp/chat_23.webp',
          'images/avatar_webp/chat_24.webp',
          'images/avatar_webp/chat_25.webp',
        ],
        "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
      },
      {
        "time": "一分钟前",
        "avatarUrl": 'images/avatar_webp/chat_52.webp',
        "name": "农夫",
        "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
        "imageList": const [
          'images/avatar_webp/chat_28.webp',
          'images/avatar_webp/chat_29.webp',
          'images/avatar_webp/chat_30.webp',
          'images/avatar_webp/chat_31.webp',
          'images/avatar_webp/chat_32.webp',
          'images/avatar_webp/chat_33.webp',
          'images/avatar_webp/chat_34.webp',
        ],
        "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
      },
      {
        "time": "一分钟前",
        "avatarUrl": 'images/avatar_webp/chat_43.webp',
        "name": "贾人达",
        "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
        "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
      },
      {
        "time": "一分钟前",
        "avatarUrl": 'images/avatar_webp/chat_47.webp',
        "name": "段正明",
        "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
        "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
      },
      {
        "time": "一分钟前",
        "avatarUrl": 'images/avatar_webp/chat_35.webp',
        "name": "易堂主",
        "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
        "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
      },
      {
        "time": "一分钟前",
        "avatarUrl": 'images/avatar_webp/chat_80.webp',
        "name": "钟镇",
        "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
        "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
      },
    ];
  }

  @override
  void dispose() {
    _scrollController.dispose(); // 避免内存泄漏
    _controller.dispose(); // 释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          appBar: null,
          body: Stack(
            children: [
              Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 750.w,
                    height: 530.w,
                    color: const Color.fromARGB(255, 48, 48, 48),
                  )),

              // 使用 ListView 代替 SingleChildScrollView
              MediaQuery.removePadding(
                  context: context,
                  removeTop: true, // 移除顶部的padding
                  child: Stack(children: [
                    GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        setState(() {
                          likeBoxVisible = false;
                        });
                      },
                      child: NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification notification) {
                            if (notification is ScrollUpdateNotification) {
                              // 用户正在滚动
                              setState(() {
                                _isScrolling = true;
                              });
                            } else if (notification is ScrollEndNotification) {
                              // 用户停止滚动
                              setState(() {
                                _isScrolling = false;
                              });
                            }
                            return true; // 返回 true 表示已处理该通知
                          },
                          child: ListView.builder(
                            primary: false,
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemCount: tweetList.length + 1, // +1 是因为还包含头像部分
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                // 头像及背景信息部分
                                return Container(
                                  height: (_statusHeight + 630.w),
                                  color: Colors.white,
                                  width: 750.w,
                                  child: Stack(
                                    children: [
                                      // 背景图片
                                      Transform.translate(
                                          offset: Offset(0, -100.w),
                                          child: Image(
                                            image: ResizeImage(
                                              AssetImage(assetPath(
                                                  'images/avatar/fj.jpg')),
                                              width: 1500.w.toInt(),
                                              height: (_statusHeight + 1260.w)
                                                  .toInt(), // 新的高度
                                            ),
                                            width: 750.w,
                                            height: 730.w,
                                            fit: BoxFit.cover,
                                          )),

                                      // 头像及昵称
                                      Positioned(
                                        top: _statusHeight + 460.w,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 35.w),
                                          width: 750.w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // 昵称
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: 15.w, top: 5.w),
                                                child: Text(
                                                  vm.userinfoName!,
                                                  style: TextStyle(
                                                    height: 1.08,
                                                    fontSize:
                                                        fontSizeScale(40.w),
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              // 头像
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.w),
                                                child: Image(
                                                  image: ResizeImage(
                                                    AssetImage(assetPath(
                                                        vm.userinfoAvatar!)),
                                                    width: 240.w.toInt(),
                                                    height: 240.w.toInt(),
                                                  ),
                                                  width: 120.w,
                                                  height: 120.w,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                // Tweet列表
                                var tweet = tweetList[index - 1]; // 减去头像部分
                                return TweetWidget(
                                    time: tweet["time"]!,
                                    avatarUrl: tweet["avatarUrl"]!,
                                    name: tweet["name"]!,
                                    tweetContent: tweet["tweetContent"]!,
                                    likes: tweet["likes"],
                                    imageList: tweet["imageList"],
                                    moreOnPress: (Offset position) {
                                      // 如果列表在滚动, 则更多按钮不能被点击
                                      if (_isScrolling) return;

                                      setState(() {
                                        lastedMoreButtonPosition = position;
                                        likeBoxVisible = true;
                                      });
                                    });
                              }
                            },
                          )),
                    ),
                  ])),

              // 弹框
              Visibility(
                  visible: likeBoxVisible,
                  child: Positioned(
                      top: lastedMoreButtonPosition.dy - 22.w,
                      left: lastedMoreButtonPosition.dx - 360.w - 5.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.w, vertical: 0.w),
                        width: 360.w,
                        height: 75.w,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 76, 76, 76),
                          borderRadius: BorderRadius.all(Radius.circular(10.w)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text.rich(
                              TextSpan(children: [
                                WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    style: const TextStyle(height: 1.08),
                                    child: Icon(
                                      const IconData(
                                        0xe682,
                                        fontFamily: 'Iconfont',
                                      ), // 使用的图标
                                      color: Colors.white, // 图标颜色
                                      size: 32.w, // 图标大小
                                    )),
                                WidgetSpan(
                                    child: SizedBox(
                                  width: 8.w,
                                )),
                                TextSpan(
                                    text: "点赞",
                                    style: TextStyle(
                                        height: 1.08,
                                        fontSize: 28.w,
                                        color: Colors.white)),
                              ]),
                              // textAlign: TextAlign.center,
                            ),
                            Container(
                              // margin: EdgeInsets.only(left: 42.w, right: 42.w),
                              height: 45.w,
                              width: 2.w,
                              color: const Color.fromARGB(255, 134, 134, 134),
                            ),
                            Text.rich(
                              TextSpan(children: [
                                WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    style: const TextStyle(height: 1.08),
                                    child: Icon(
                                      const IconData(
                                        0xe605,
                                        fontFamily: 'Iconfont',
                                      ), // 使用的图标
                                      color: Colors.white, // 图标颜色
                                      size: 30.w, // 图标大小
                                    )),
                                WidgetSpan(
                                    child: SizedBox(
                                  width: 8.w,
                                )),
                                TextSpan(
                                    text: "评论",
                                    style: TextStyle(
                                        height: 1.08,
                                        fontSize: 28.w,
                                        color: Colors.white)),
                              ]),
                              // textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ))),

              // 顶部透明 AppBar
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  color: Color.fromARGB(_opacity.value.toInt(), 237, 237, 237),
                  width: 750.w,
                  height: 90.0.w + _statusHeight,
                  padding: EdgeInsets.only(top: _statusHeight),
                  child: AppBar(
                    primary: false,
                    title: const Text("朋友圈"),
                    centerTitle: true,
                    titleTextStyle: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(32.w),
                      color: Color.fromARGB(_opacity.value.toInt(), 0, 0, 0),
                      fontFamily: "AlibabaPuHuiTi-Medium",
                    ),
                    toolbarHeight: 90.w,
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.transparent,
                    leading: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        color: Colors.transparent,
                        child: Icon(
                          const IconData(0xed9e, fontFamily: 'Iconfont'),
                          color: _opacity.value.toInt() > 180
                              ? Colors.black
                              : Colors.white,
                          size: 36.w,
                        ),
                      ),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: Colors.transparent,
                          height: 90.w,
                          padding: EdgeInsets.only(right: 40.w),
                          child: Icon(
                            IconData(
                                _opacity.value.toInt() > 180 ? 0xe68a : 0xe64d,
                                fontFamily: 'Iconfont'),
                            size: _opacity.value.toInt() > 180 ? 40.w : 40.w,
                            color: _opacity.value.toInt() > 180
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class TweetWidget extends StatefulWidget {
  final String time;
  final String avatarUrl;
  final String name;
  final String tweetContent;
  final List<String>? imageList;
  final List<String>? likes;
  final Function moreOnPress;

  const TweetWidget(
      {super.key,
      required this.time,
      required this.avatarUrl,
      required this.name,
      required this.tweetContent,
      this.likes,
      this.imageList,
      required this.moreOnPress});

  @override
  State<TweetWidget> createState() => _TweetWidget();
}

// 推文
class _TweetWidget extends State<TweetWidget> {
  // 生成随机数
  int generateRandomNumber() {
    var random = Random();
    return random.nextInt(103) + 1; // 生成1到103的随机数
  }

  // 最后点击更多位置
  late Offset morePosition;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];

    for (int index = 0; index < widget.likes!.length; index++) {
      final name = widget.likes![index];

      textSpans.add(
        TextSpan(
          children: buildTextSpans(
              name,
              TextStyle(
                  height: 1.08,
                  fontSize: fontSizeScale(27.w),
                  color: const Color.fromARGB(255, 58, 81, 124),
                  fontFamily: "AlibabaPuHuiTi-Medium"),
              TextStyle(
                  height: 1.08,
                  fontSize: fontSizeScale(27.w),
                  fontFamily: "NotoColorEmoji-Regular")),
        ),
      );

      if (index != widget.likes!.length - 1) {
        // 逗号
        textSpans.add(
          TextSpan(
            text: ", ",
            style: TextStyle(
              height: 1.08,
              fontSize: fontSizeScale(28.w),
              color: const Color.fromARGB(255, 58, 81, 124),
              fontFamily: "AlibabaPuHuiTi-Medium",
            ),
          ),
        );
      }
    }

    // if (imageList != null) {
    //   if (imageList!.length == 4) {
    //     imageList?.insert(2, '1');
    //   }
    // }

    return Container(
      width: 750.w,
      padding: EdgeInsets.only(top: 22.w, bottom: 22.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: const Color.fromARGB(255, 255, 255, 255),
            width: 0.w,
          ),
          bottom: BorderSide(
            color: const Color.fromARGB(255, 242, 242, 242),
            width: 1.5.w,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 头像
          Container(
            width: 77.w,
            height: 77.w,
            margin: EdgeInsets.only(left: 37.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.w),
              child: Image(
                image: ResizeImage(
                  AssetImage(assetPath(widget.avatarUrl)),
                  width: 154.w.toInt(),
                  height: 154.w.toInt(),
                ),
                fit: BoxFit.cover,
                width: 77.w,
                height: 77.w,
              ),
            ),
          ),
          // 姓名和推文
          Expanded(
            flex: 1,
            child: Container(
                margin: EdgeInsets.only(left: 20.w, right: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // 姓名
                    RichText(
                      text: TextSpan(
                        children: buildTextSpans(
                            widget.name,
                            TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(32.w),
                              fontFamily: "AlibabaPuHuiTi-Medium",
                              // fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 58, 81, 124),
                            ),
                            TextStyle(
                                height: 1.08, fontSize: fontSizeScale(32.w))),
                      ),
                    ),
                    SizedBox(height: 15.w),

                    // 推文
                    RichText(
                      text: TextSpan(
                        children: buildTextSpans(
                            widget.tweetContent,
                            TextStyle(
                                height: 1.08, fontSize: fontSizeScale(31.w)),
                            TextStyle(
                                height: 1.08, fontSize: fontSizeScale(31.w))),
                      ),
                    ),
                    SizedBox(height: 20.w),

                    // 九宫格
                    if (widget.imageList != null) ...[
                      SizedBox(
                        // color: Colors.amber,
                        width: 570.w,
                        height:
                            (194.w * (widget.imageList!.length / 3).ceil()) -
                                6.w,
                        child: GridView.builder(
                          primary: false,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 6.w,
                            crossAxisSpacing: 6.w,
                            childAspectRatio: 1,
                          ),
                          itemCount: widget.imageList?.length,
                          itemBuilder: (context, index) {
                            if (widget.imageList![index] == '') {
                              return const SizedBox();
                            } else {
                              return Image(
                                  image: ResizeImage(
                                    AssetImage(
                                        assetPath(widget.imageList![index])),
                                    width: 380.w.toInt(),
                                    height: 380.w.toInt(),
                                  ),
                                  width: 186.w,
                                  height: 186.w,
                                  fit: BoxFit.cover);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 18.w),
                    ],

                    // 定位信息
                    Text(
                      "深圳市 · 南山区腾讯总部",
                      style: TextStyle(
                        height: 1.08,
                        fontSize: fontSizeScale(26.w),
                        color: const Color.fromARGB(255, 58, 81, 124),
                      ),
                    ),

                    SizedBox(height: 16.w),

                    // 显示时间与更多
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 时间
                        Text(
                          widget.time,
                          style: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(26.w),
                            color: const Color.fromARGB(255, 156, 156, 156),
                          ),
                        ),
                        // 更多
                        GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            // 获取点击的位置
                            Offset position =
                                details.globalPosition - details.localPosition;
                            widget.moreOnPress(position);
                          },
                          child: Container(
                            height: 38.w,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 248, 248, 248),
                              borderRadius: BorderRadius.circular(6.w),
                            ),
                            child: Center(
                              child: Icon(
                                const IconData(
                                  0xe667,
                                  fontFamily: 'Iconfont',
                                ),
                                size: 37.w,
                                color: const Color.fromARGB(255, 58, 81, 124),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 18.w),

                    // 点赞人员列表
                    Container(
                      constraints: BoxConstraints(minHeight: 51.w),
                      padding: EdgeInsets.only(
                          left: 18.w, right: 18.w, top: 15.w, bottom: 15.w),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 247, 247, 247),
                        borderRadius: BorderRadius.circular(5.w), // 设置圆角
                      ),
                      child: Column(
                        // 将 Row 改为 Column
                        crossAxisAlignment: CrossAxisAlignment.start, // 修改对齐方式
                        children: [
                          RichText(
                            maxLines: 1000,
                            overflow: TextOverflow.visible,
                            text: TextSpan(children: [
                              WidgetSpan(
                                child: Icon(
                                  const IconData(
                                    0xe70a,
                                    fontFamily: 'Iconfont',
                                  ),
                                  color: const Color.fromARGB(
                                      255, 58, 81, 124), // 图标颜色
                                  size: 30.w, // 图标大小
                                ),
                              ),
                              WidgetSpan(
                                child: SizedBox(width: 10.w), // 图标和文本之间的间距
                              ),
                              ...textSpans
                            ]),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
