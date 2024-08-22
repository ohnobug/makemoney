import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNChatPage extends StatefulWidget {
  const LJNChatPage({super.key});

  @override
  State<LJNChatPage> createState() => _LJNChatPage();
}

class _LJNChatPage extends State<LJNChatPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Scaffold(
            primary: false,
            appBar: AppBar(
              primary: true,
              centerTitle: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              toolbarHeight: MediaQuery.of(context).padding.top + 90.w,
              title: const Text("请说英语"),
              titleTextStyle: TextStyle(fontSize: 32.w, color: Colors.black),
              backgroundColor: const Color.fromARGB(255, 237, 237, 237),
              foregroundColor: const Color.fromARGB(255, 237, 237, 237),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(1.w),
                child: Container(
                  color: const Color.fromARGB(255, 220, 220, 220),
                  height: 0.5.w,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                      size: 37.w,
                      const IconData(
                        0xe726,
                        fontFamily: 'Iconfont',
                      )),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  padding: const EdgeInsets.only(right: 33.0).w,
                  onPressed: () {},
                ),
              ],
            ),
            body: Container(
                height: screenSize.height -
                    MediaQuery.of(context).padding.top +
                    90.w,
                color: const Color.fromARGB(255, 237, 237, 237),
                child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child:
                        // 由于SingleChildScrollView的子元素达不到高度不能滚动，所以在子元素需要设置一个比父元素更高的盒子。
                        SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Container(
                                constraints: BoxConstraints(
                                  minHeight: screenSize.height - 205.w,
                                ),
                                // color: const Color.fromARGB(255, 0, 152, 246),
                                child: Column(
                                  children: [
                                    // 对方发的消息
                                    Container(
                                      padding: const EdgeInsets.all(22).w,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding:
                                                  EdgeInsets.only(left: 22.w),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(5).w,
                                              ),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 1.0.w),
                                                    borderRadius:
                                                        BorderRadius.circular(5)
                                                            .w,
                                                  ),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                                  5)
                                                              .w,
                                                      child: Image.asset(
                                                        "assets/images/avatar_webp/chat_5.webp",
                                                        width: 78.w,
                                                        height: 78.w,
                                                      )))),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                              left: 23,
                                                              top: 3,
                                                              bottom: 10)
                                                          .w,
                                                  // height: 33.w,
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "许信将",
                                                          style: TextStyle(
                                                              fontSize: 20.w,
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  130,
                                                                  130,
                                                                  130)),
                                                        )
                                                      ]),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // 箭头
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                                  top: 25,
                                                                  left: 9)
                                                              .w,
                                                      child: Image.asset(
                                                        // fit: BoxFit.fitWidth,
                                                        "assets/images/icon_webp/left.png",
                                                        width: 9.w,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    // 消息
                                                    Flexible(
                                                        child: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              maxWidth: 258),
                                                      // width: 640.w,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 1.0.w),
                                                          borderRadius:
                                                              BorderRadius
                                                                      .circular(
                                                                          8)
                                                                  .w),
                                                      padding: EdgeInsets.only(
                                                          top: 24.w,
                                                          bottom: 24.w,
                                                          left: 22.w,
                                                          right: 22.w),
                                                      child: Text(
                                                        softWrap: true,
                                                        maxLines: 1000,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        "你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？",
                                                        style: TextStyle(
                                                            fontSize: 30.w,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )))))));
  }
}
