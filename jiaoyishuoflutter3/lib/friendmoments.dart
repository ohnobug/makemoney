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

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
              primary: false,
              appBar: null,
              body: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      child: Column(
                        children: [
                          // 背景信息
                          SizedBox(
                              height: _statusHeight + 630.w,
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

                                  // 返回按钮
                                  Positioned(
                                      top: 45.w,
                                      child: Container(
                                          width: 750.w,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 34.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
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
                                                    color: const Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // 图标颜色
                                                    size: 40.w, // 图标大小
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  // wallet
                                                }, // 点击事件
                                                child: Container(
                                                  color: Colors.transparent,
                                                  child: Icon(
                                                    const IconData(
                                                      0xe64d,
                                                      fontFamily: 'Iconfont',
                                                    ), // 使用的图标
                                                    color: const Color.fromARGB(
                                                        255,
                                                        255,
                                                        255,
                                                        255), // 图标颜色
                                                    size: 45.w, // 图标大小
                                                  ),
                                                ),
                                              )
                                            ],
                                          ))),

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
                                                      right: 15.w, top: 10.w),
                                                  child: Text(
                                                    vm.userinfoName!,
                                                    style: TextStyle(
                                                        fontSize: 40.w,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10).w,
                                                child: Image.asset(
                                                  vm.userinfoAvatar as String,
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
                            tweetContent: "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                          ),
                          const TweetWidget(
                            time: "一分钟前",
                            avatarUrl: 'images/avatar_webp/chat_2.webp',
                            name: "考研第一名",
                            tweetContent: "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                          ),
                          const TweetWidget(
                            time: "一分钟前",
                            avatarUrl: 'images/avatar_webp/chat_3.webp',
                            name: "考研第一名",
                            tweetContent: "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                          ),
                          const TweetWidget(
                            time: "一分钟前",
                            avatarUrl: 'images/avatar_webp/chat_4.webp',
                            name: "考研第一名",
                            tweetContent: "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                          ),
                          const TweetWidget(
                            time: "一分钟前",
                            avatarUrl: 'images/avatar_webp/chat_5.webp',
                            name: "考研第一名",
                            tweetContent: "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                          ),
                          const TweetWidget(
                            time: "一分钟前",
                            avatarUrl: 'images/avatar_webp/chat_6.webp',
                            name: "考研第一名",
                            tweetContent: "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                          ),
                          const TweetWidget(
                            time: "一分钟前",
                            avatarUrl: 'images/avatar_webp/chat_7.webp',
                            name: "考研第一名",
                            tweetContent: "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                          ),
                          const TweetWidget(
                            time: "一分钟前",
                            avatarUrl: 'images/avatar_webp/chat_8.webp',
                            name: "考研第一名",
                            tweetContent: "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                          ),
                          const TweetWidget(
                            time: "一分钟前",
                            avatarUrl: 'images/avatar_webp/chat_9.webp',
                            name: "考研第一名",
                            tweetContent: "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                          ),
                          const TweetWidget(
                            time: "一分钟前",
                            avatarUrl: 'images/avatar_webp/chat_10.webp',
                            name: "考研第一名",
                            tweetContent: "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                          ),
                          const TweetWidget(
                            time: "一分钟前",
                            avatarUrl: 'images/avatar_webp/chat_11.webp',
                            name: "考研第一名",
                            tweetContent: "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                          ),
                          const TweetWidget(
                            time: "一分钟前",
                            avatarUrl: 'images/avatar_webp/chat_12.webp',
                            name: "考研第一名",
                            tweetContent: "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                          ),
                          const TweetWidget(
                            time: "一分钟前",
                            avatarUrl: 'images/avatar_webp/chat_13.webp',
                            name: "考研第一名",
                            tweetContent: "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                          ),
                          const TweetWidget(
                            time: "一分钟前",
                            avatarUrl: 'images/avatar_webp/chat_14.webp',
                            name: "考研第一名",
                            tweetContent: "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                          ),
                          const TweetWidget(
                            time: "一分钟前",
                            avatarUrl: 'images/avatar_webp/chat_15.webp',
                            name: "考研第一名",
                            tweetContent: "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️",
                          ),
                        ],
                      ))));
        });
  }
}

// 正则表达式匹配所有 emoji
final RegExp emojiRegex = RegExp(
  r'[\u{1F600}-\u{1F64F}]|' // 表情符号
  r'[\u{1F300}-\u{1F5FF}]|' // 符号和图形
  r'[\u{1F680}-\u{1F6FF}]|' // 交通工具和符号
  r'[\u{1F700}-\u{1F77F}]|' // 箭头、符号
  r'[\u{1F780}-\u{1F7FF}]|' // 符号
  r'[\u{1F800}-\u{1F8FF}]|' // 符号
  r'[\u{2600}-\u{26FF}]|' // 各类符号
  r'[\u{2700}-\u{27BF}]|' // 各类符号
  r'[\u{1F900}-\u{1F9FF}]|' // 各类符号
  r'[\u{1FA70}-\u{1FAFF}]|' // emoji v12.0
  r'[\u{200D}]|' // 零宽字符
  r'[\u{2640}\u{2642}]', // 性别符号
  unicode: true,
);

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

  // 解析推文内容，将emoji和文本分开处理
  List<TextSpan> _buildTextSpans(String text) {
    List<TextSpan> spans = [];
    final matches = emojiRegex.allMatches(text);
    int lastMatchEnd = 0;

    for (final match in matches) {
      // 添加前面的非emoji文本
      if (match.start > lastMatchEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastMatchEnd, match.start),
            style: TextStyle(
                fontSize: 30.w,
                color: Colors.black,
                fontFamily: "AlibabaPuHuiTi"),
          ),
        );
      }
      // 添加emoji
      spans.add(
        TextSpan(
          text: match.group(0),
          style:
              TextStyle(fontSize: 30.w, fontFamily: "NotoColorEmoji-Regular"),
        ),
      );
      lastMatchEnd = match.end;
    }

    // 添加最后的非emoji文本
    if (lastMatchEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastMatchEnd),
          style: TextStyle(
              fontSize: 30.w,
              color: Colors.black,
              fontFamily: "AlibabaPuHuiTi"),
        ),
      );
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 750.w,
      padding: EdgeInsets.only(top: 22.w, bottom: 22.w),
      decoration: BoxDecoration(
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
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 30.w,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 74, 88, 142),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: _buildTextSpans(tweetContent),
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
                                  0xe659,
                                  fontFamily: 'Iconfont',
                                ),
                                size: 37.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
