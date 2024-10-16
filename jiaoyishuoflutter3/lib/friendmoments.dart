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

class _LJNFriendmomentsPage extends State<LJNFriendmomentsPage> {
  double _statusHeight = 0;

  final ScrollController _scrollController = ScrollController();

  double scrollPosition = 0;

  @override
  void initState() {
    super.initState();

    // 添加监听器以监控滚动
    _scrollController.addListener(() {
      // logger.info(_scrollController.position.pixels); // 获取滚动位置
      setState(() {
        scrollPosition = _scrollController.position.pixels;
      });
    });

    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose(); // 避免内存泄漏
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
              primary: false,
              appBar: null,
              body: Stack(
                children: [
                  // 背景
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: screenSize.width,
                      height: _statusHeight + 530.w,
                      color: const Color.fromARGB(255, 48, 48, 48),
                    ),
                  ),

                  // 滚动
                  ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          child: Column(
                            children: [
                              // 背景信息
                              Container(
                                  height: _statusHeight + 630.w,
                                  color: Colors.white,
                                  width: 750.w,
                                  child: Stack(
                                    children: [
                                      // 背景
                                      Image.asset(
                                        assetPath('images/avatar/fj.jpg'),
                                        width: 750.w,
                                        height: _statusHeight + 530.w,
                                        fit: BoxFit.cover,
                                      ),

                                      // 头像以及姓名
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
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 15.w,
                                                          top: 10.w),
                                                      child: Text(
                                                        vm.userinfoName!,
                                                        style: TextStyle(
                                                            fontSize: 40.w,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                                10)
                                                            .w,
                                                    child: Image.asset(
                                                      vm.userinfoAvatar
                                                          as String,
                                                      width: 120.w,
                                                      height: 120.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              )))
                                    ],
                                  )),

                              // 样式1
                              const TweetWidget(
                                time: "一分钟前",
                                avatarUrl: 'images/avatar_webp/chat_1.webp',
                                name: "考研第一名",
                                tweetContent:
                                    "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                              ),
                              const TweetWidget(
                                time: "一分钟前",
                                avatarUrl: 'images/avatar_webp/chat_2.webp',
                                name: "考研第一名",
                                tweetContent:
                                    "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                              ),
                              const TweetWidget(
                                time: "一分钟前",
                                avatarUrl: 'images/avatar_webp/chat_3.webp',
                                name: "考研第一名",
                                tweetContent:
                                    "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                              ),
                              const TweetWidget(
                                time: "一分钟前",
                                avatarUrl: 'images/avatar_webp/chat_4.webp',
                                name: "考研第一名",
                                tweetContent:
                                    "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                              ),
                              const TweetWidget(
                                time: "一分钟前",
                                avatarUrl: 'images/avatar_webp/chat_5.webp',
                                name: "考研第一名",
                                tweetContent:
                                    "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                              ),
                              const TweetWidget(
                                time: "一分钟前",
                                avatarUrl: 'images/avatar_webp/chat_6.webp',
                                name: "考研第一名",
                                tweetContent:
                                    "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                              ),
                              const TweetWidget(
                                time: "一分钟前",
                                avatarUrl: 'images/avatar_webp/chat_7.webp',
                                name: "考研第一名",
                                tweetContent:
                                    "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                              ),
                              const TweetWidget(
                                time: "一分钟前",
                                avatarUrl: 'images/avatar_webp/chat_8.webp',
                                name: "考研第一名",
                                tweetContent:
                                    "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                              ),
                              const TweetWidget(
                                time: "一分钟前",
                                avatarUrl: 'images/avatar_webp/chat_9.webp',
                                name: "考研第一名",
                                tweetContent:
                                    "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                              ),
                              const TweetWidget(
                                time: "一分钟前",
                                avatarUrl: 'images/avatar_webp/chat_10.webp',
                                name: "考研第一名",
                                tweetContent:
                                    "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                              ),
                              const TweetWidget(
                                time: "一分钟前",
                                avatarUrl: 'images/avatar_webp/chat_11.webp',
                                name: "考研第一名",
                                tweetContent:
                                    "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                              ),
                              const TweetWidget(
                                time: "一分钟前",
                                avatarUrl: 'images/avatar_webp/chat_12.webp',
                                name: "考研第一名",
                                tweetContent:
                                    "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                              ),
                              const TweetWidget(
                                time: "一分钟前",
                                avatarUrl: 'images/avatar_webp/chat_13.webp',
                                name: "考研第一名",
                                tweetContent:
                                    "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                              ),
                              const TweetWidget(
                                time: "一分钟前",
                                avatarUrl: 'images/avatar_webp/chat_14.webp',
                                name: "考研第一名",
                                tweetContent:
                                    "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                              ),
                              const TweetWidget(
                                time: "一分钟前",
                                avatarUrl: 'images/avatar_webp/chat_15.webp',
                                name: "考研第一名",
                                tweetContent:
                                    "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                              ),
                            ],
                          ))),

                  // App标题栏
                  AppBar(
                    primary: false,
                    title: scrollPosition > (_statusHeight + 460.w)
                        ? const Text("朋友圈")
                        : null,
                    centerTitle: true,
                    titleTextStyle: TextStyle(
                        fontSize: 30.w,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "AlibabaPuHuiTi-Medium"),
                    toolbarHeight: 90.w,
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    backgroundColor: scrollPosition > (_statusHeight + 460.w)
                        ? const Color.fromARGB(255, 237, 237, 237)
                        : Colors.transparent,
                    foregroundColor: scrollPosition > (_statusHeight + 460.w)
                        ? const Color.fromARGB(255, 237, 237, 237)
                        : Colors.transparent,
                    leading: GestureDetector(
                      onTap: () => Navigator.of(context).pop(), // 点击事件
                      child: Container(
                        // 加盒子是为了扩大点击区域
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
                    actions: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: Colors.transparent,
                          height: 90.w,
                          padding: EdgeInsets.only(right: 33.w), // 设置右侧内边距
                          child: Icon(
                            const IconData(
                              0xe612,
                              fontFamily: 'Iconfont',
                            ),
                            size: 38.w, // 图标大小
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: Colors.transparent,
                          height: 90.w,
                          padding: EdgeInsets.only(right: 40.w), // 设置右侧内边距
                          child: Icon(
                            const IconData(
                              0xe64d,
                              fontFamily: 'Iconfont',
                            ),
                            size: 40.w, // 图标大小
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ));
        });
  }
}

class TweetWidget extends StatelessWidget {
  final String time;
  final String avatarUrl;
  final String name;
  final String tweetContent;

  const TweetWidget({
    super.key,
    required this.time,
    required this.avatarUrl,
    required this.name,
    required this.tweetContent,
  });

  // 生成随机数
  int generateRandomNumber() {
    var random = Random();
    return random.nextInt(103) + 1; // 生成1到103的随机数
  }

  @override
  Widget build(BuildContext context) {
    final List<String> names = [
      "刘德华💖",
      "周杰伦",
      "王菲",
      "张学友",
      "李宇春💖",
      "特朗普",
      "史泰龙",
      "阿诺舒华"
    ]; // 人名列表

    List<TextSpan> textSpans = [];

    for (int index = 0; index < names.length; index++) {
      final name = names[index];

      textSpans.add(
        TextSpan(
          children: buildTextSpans(
              name,
              TextStyle(
                  fontSize: 27.w,
                  color: const Color.fromARGB(255, 58, 81, 124),
                  fontFamily: "AlibabaPuHuiTi-Medium"),
              TextStyle(fontSize: 27.w, fontFamily: "NotoColorEmoji-Regular")),
        ),
      );

      if (index != names.length - 1) {
        // 逗号
        textSpans.add(
          TextSpan(
            text: ", ",
            style: TextStyle(
              fontSize: 27.w,
              color: const Color.fromARGB(255, 58, 81, 124),
              fontFamily: "AlibabaPuHuiTi-Medium",
            ),
          ),
        );
      }
    }

    return Container(
      width: 750.w,
      padding: EdgeInsets.only(top: 22.w, bottom: 22.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: const Color.fromARGB(255, 243, 243, 243),
            width: 2.w,
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
              child: Image.asset(
                assetPath(avatarUrl),
                width: 77.w,
                height: 77.w,
                fit: BoxFit.cover,
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
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 30.w,
                        fontFamily: "AlibabaPuHuiTi-Medium",
                        // fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 58, 81, 124),
                      ),
                    ),
                    // 推文
                    RichText(
                      text: TextSpan(
                        children: buildTextSpans(
                            tweetContent,
                            TextStyle(fontSize: 30.w),
                            TextStyle(fontSize: 30.w)),
                      ),
                    ),
                    SizedBox(height: 20.w),

                    SizedBox(
                      // color: Colors.amber,
                      width: 570.w,
                      height: 570.w,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 每行 3 列
                          mainAxisSpacing: 6.w,
                          crossAxisSpacing: 6.w,
                          childAspectRatio: 1,
                        ),
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return Image(
                            image: ResizeImage(
                              AssetImage(assetPath(
                                  'images/avatar_webp/chat_${generateRandomNumber()}.webp')),
                              width: 200,
                              height: 200,
                            ),
                            fit: BoxFit.cover, // 保持原来的 fit 方式
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 20.w),

                    // 显示时间与更多
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 时间
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 26.w,
                            color: const Color.fromARGB(255, 156, 156, 156),
                          ),
                        ),
                        // 更多
                        GestureDetector(
                          onTap: () {
                            // 点击事件
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

                    SizedBox(height: 20.w),

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
                                child: SizedBox(width: 3.w), // 图标和文本之间的间距
                              ),
                              TextSpan(
                                  text: ' ', style: TextStyle(fontSize: 27.w)),
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
