import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';

import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNMiniProgramPage extends StatefulWidget {
  const LJNMiniProgramPage({super.key});

  @override
  State<LJNMiniProgramPage> createState() => _LJNMiniProgramPage();
}

class _LJNMiniProgramPage extends State<LJNMiniProgramPage> {
  late final List<ChatListItem> chatItems;
  late final List<ChatListItem> chatItems2;

  @override
  void initState() {
    super.initState();

    chatItems = [
      ChatListItem(
        friendName: "粤童年",
        message: "今天天气真好，阳光明媚，让人心情愉悦。",
        avatar: "images/miniprogram_icon/yuetongnianruanjian.jpg",
        onPressed: () {
          Navigator.of(context).pushNamed(
              "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
        },
      ),
      ChatListItem(
          friendName: '起点中文',
          message: "[图片]",
          avatar: "images/miniprogram_icon/qidianzhongwen.jpg",
          onPressed: () {
            Navigator.of(context).pushNamed(
                "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
          }),
      ChatListItem(
          friendName: "野花香电视剧",
          message: "这个怎么样调试?",
          avatar: "images/miniprogram_icon/yehuaxiangdianshiju.jpg",
          onPressed: () {
            Navigator.of(context).pushNamed(
                "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
          }),
      ChatListItem(
          friendName: "韵镖侠",
          message: "你最近过得如何？工作顺利吗？有没有遇到什么有趣的事情？",
          avatar: "images/miniprogram_icon/yunbiaoxia.jpg",
          onPressed: () {
            Navigator.of(context).pushNamed(
                "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
          }),
    ];

    chatItems2 = [
      ChatListItem(
        friendName: "蘑菇云游",
        message: "今天天气真好，阳光明媚，让人心情愉悦。",
        avatar: "images/miniprogram_icon/moguyunyou.jpg",
        onPressed: () {
          Navigator.of(context).pushNamed(
              "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
        },
      ),
      ChatListItem(
          friendName: '美图秀秀',
          message: "[图片]",
          avatar: "images/miniprogram_icon/meituxiuxiu.jpg",
          onPressed: () {
            Navigator.of(context).pushNamed(
                "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
          }),
      ChatListItem(
          friendName: "百度翻译",
          message: "这个怎么样调试?",
          avatar: "images/miniprogram_icon/baidufanyi.jpg",
          onPressed: () {
            Navigator.of(context).pushNamed(
                "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
          }),
      ChatListItem(
          friendName: "淘无忧",
          message: "你最近过得如何？工作顺利吗？有没有遇到什么有趣的事情？",
          avatar: "images/miniprogram_icon/taowuyou.jpg",
          onPressed: () {
            Navigator.of(context).pushNamed(
                "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
          }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
      return Scaffold(
          primary: false,
          appBar: LJNAppBar(
            title: "小程序",
            actions: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.transparent,
                  height: 90.w,
                  padding: EdgeInsets.only(right: 33.w), // 设置右侧内边距
                  alignment: Alignment.center,
                  child: Icon(
                    const IconData(
                      0xe612,
                      fontFamily: 'Iconfont',
                    ),
                    size: 40.w, // 图标大小
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.transparent,
                  height: 90.w,
                  padding: EdgeInsets.only(right: 40.w), // 设置右侧内边距
                  alignment: Alignment.center,
                  child: Icon(
                    const IconData(
                      0xe726,
                      fontFamily: 'Iconfont',
                    ),
                    size: 42.w, // 图标大小
                  ),
                ),
              ),
            ],
          ),
          body: ColoredBox(
              color: const Color.fromARGB(255, 237, 237, 237),
              child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: systemState.screenSize.height - 205.w),
                        color: const Color.fromARGB(255, 237, 237, 237),
                        child: Column(
                          children: [
                            // 最近使用
                            FunctionButtonsSection(
                              title: '最近使用',
                              moreUrl: "/",
                              buttons: [
                                FunctionButton(
                                    icon:
                                        "images/miniprogram_icon/zhihuixiangji.jpg",
                                    title: "智慧相机",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    }),
                                // FunctionButton(
                                //     icon:
                                //         "images/miniprogram_icon/wangwangshangliao.jpg",
                                //     title: "旺旺商聊",
                                //     onPressed: () {
                                //
                                // Navigator.of(context).pushNamed("/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");}),
                                FunctionButton(
                                    icon:
                                        "images/miniprogram_icon/haimianbaobao.jpg",
                                    title: "海绵宝宝",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    }),
                                FunctionButton(
                                    icon:
                                        "images/miniprogram_icon/taowuyou.jpg",
                                    title: "淘无忧",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    }),
                                FunctionButton(
                                    icon:
                                        "images/miniprogram_icon/wangzheyingdi.jpg",
                                    title: "王者营地",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    }),
                              ],
                            ),

                            // 我的常用
                            FunctionButtonsSection(
                              title: '我的常用',
                              moreUrl: "",
                              buttons: [
                                FunctionButton(
                                    icon: "images/miniprogram_icon/duitang.jpg",
                                    title: "堆糖",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    }),
                                FunctionButton(
                                    icon:
                                        "images/miniprogram_icon/tiankongyueduqi.jpg",
                                    title: "天空阅读器",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    }),
                                FunctionButton(
                                    icon:
                                        "images/miniprogram_icon/qishuwang.jpg",
                                    title: "奇书网",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    }),
                                FunctionButton(
                                    icon:
                                        "images/miniprogram_icon/xueyouyoujiao.jpg",
                                    title: "学有优教",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    }),
                                FunctionButton(
                                    icon:
                                        "images/miniprogram_icon/haiziwang.jpg",
                                    title: "孩子王",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    }),
                                FunctionButton(
                                    icon:
                                        "images/miniprogram_icon/qianbixiaoshuo.jpg",
                                    title: "铅笔小说",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    }),
                                FunctionButton(
                                    icon:
                                        "images/miniprogram_icon/chengquanshipin.jpg",
                                    title: "成全视频",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    }),
                                FunctionButton(
                                    icon:
                                        "images/miniprogram_icon/xiaomishangcheng.jpg",
                                    title: "小米商城",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    }),
                                FunctionButton(
                                    icon:
                                        "images/miniprogram_icon/meituxiuxiu.jpg",
                                    title: "美图秀秀",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    }),
                                FunctionButton(
                                    icon:
                                        "images/miniprogram_icon/luobokuaipao.jpg",
                                    title: "萝卜快跑",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    }),
                              ],
                            ),

                            // 交通出行
                            FunctionListSection(
                              title: "交通出行",
                              moreUrl: '/',
                              chatItems: chatItems,
                            ),

                            // 附近小程序
                            FunctionListSection(
                              title: "附近小程序",
                              moreUrl: '/',
                              chatItems: chatItems2,
                            )
                          ],
                        ),
                      )))));
    });
  }
}

// 小程序按钮项组
class FunctionButtonsSection extends StatelessWidget {
  final String title;
  final List<FunctionButton> buttons;
  final String moreUrl;

  const FunctionButtonsSection(
      {super.key,
      required this.title,
      required this.buttons,
      required this.moreUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 18, left: 18, right: 18).w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0).w,
        ),
        padding: const EdgeInsets.only(bottom: 16).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 33.w, bottom: 16.w, left: 30.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(title,
                        style: TextStyle(
                          height: 1.08,
                          fontSize: fontSizeScale(28.w),
                          color: Colors.black,
                        )),
                    if (moreUrl != '')
                      // 三个点
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            moreUrl,
                          );
                        },
                        child: Container(
                          // height: 90.w,
                          color: Colors.transparent,
                          padding: EdgeInsets.only(right: 33.w), // 设置右侧内边距
                          child: Icon(
                            const IconData(
                              0xe659,
                              fontFamily: 'Iconfont',
                            ),
                            size: 37.w, // 图标大小
                          ),
                        ),
                      )
                  ]),
            ),

            // 使用 SizedBox 控制 GridView 的大小
            Container(
              padding: const EdgeInsets.all(16.0).w,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 每行显示4个子组件
                  crossAxisSpacing: 16.w, // 列间距
                  mainAxisSpacing: 50.w, // 行间距
                  childAspectRatio: (1 / 1),
                ),
                itemCount: buttons.length,
                itemBuilder: (context, index) {
                  return Center(child: buttons[index]);
                },
                shrinkWrap: true, // 根据内容调整 GridView 大小
                physics: const NeverScrollableScrollPhysics(), // 禁用滚动
              ),
            ),
          ],
        ));
  }
}

// 小程序按钮
class FunctionButton extends StatefulWidget {
  final String icon;
  final String title;
  final VoidCallback onPressed;

  const FunctionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  FunctionButtonState createState() => FunctionButtonState();
}

class FunctionButtonState extends State<FunctionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: _isPressed ? Colors.grey[200] : Colors.transparent, // 按下时背景色
          borderRadius: BorderRadius.circular(10.0).w, // 圆角半径
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // 使按钮大小适应内容
            children: [
              ClipOval(
                child: Image.asset(
                  assetPath(widget.icon),
                  width: 95.w,
                  height: 95.w,
                  fit: BoxFit.cover, // 让图片完全填满圆形区域
                ),
              ),
              SizedBox(height: 22.w), // 图标和标题之间的间距
              Text(
                widget.title,
                maxLines: 1,
                style: TextStyle(
                    height: 1.08,
                    decoration: TextDecoration.none,
                    color: const Color.fromARGB(255, 92, 92, 92),
                    fontSize: fontSizeScale(25.0.w),
                    overflow: TextOverflow.ellipsis), // 标题颜色
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 小程序列表项组
class FunctionListSection extends StatefulWidget {
  final String title;
  final String moreUrl;
  final List<ChatListItem> chatItems;

  const FunctionListSection(
      {super.key,
      required this.title,
      required this.chatItems,
      required this.moreUrl});

  @override
  State<FunctionListSection> createState() => _FunctionListSection();
}

class _FunctionListSection extends State<FunctionListSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 18, left: 18, right: 18).w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0).w,
        ),
        padding: const EdgeInsets.only(bottom: 16).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 33.w, bottom: 16.w, left: 30.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.title,
                        style: TextStyle(
                          height: 1.08,
                          fontSize: fontSizeScale(28.w),
                          color: Colors.black,
                        )),
                    if (widget.moreUrl != '')
                      // 三个点
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            widget.moreUrl,
                          );
                        },
                        child: Container(
                          // height: 90.w,
                          color: const Color.fromARGB(0, 0, 0, 0),
                          padding: EdgeInsets.only(right: 33.w), // 设置右侧内边距
                          child: Icon(
                            const IconData(
                              0xe659,
                              fontFamily: 'Iconfont',
                            ),
                            size: 37.w, // 图标大小
                          ),
                        ),
                      )
                  ]),
            ),

            // 使用 SizedBox 控制 GridView 的大小
            ListView.builder(
              primary: false,
              itemCount: widget.chatItems.length,
              shrinkWrap: true,
              // controller: _customScrollController,
              // physics: const CustomScrollPhysics()
              //     .applyTo(const MyBouncingScrollPhysics()),
              // physics: const MyBouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return widget.chatItems[index];
              },
            ),
          ],
        ));
  }
}

// 小程序列表项
class ChatListItem extends StatefulWidget {
  final String avatar;
  final String friendName;
  final String message;
  final Function()? onPressed;

  const ChatListItem({
    super.key,
    required this.avatar,
    required this.friendName,
    required this.message,
    this.onPressed,
  });

  @override
  State<ChatListItem> createState() => _ChatListItem();
}

class _ChatListItem extends State<ChatListItem> {
  Color containerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (_) {
          setState(() {
            containerColor = const Color.fromARGB(255, 229, 229, 229);
          });
        },
        onTapCancel: () {
          setState(() {
            containerColor = Colors.white;
          });

          logger.info("取消点击");
        },
        onTapUp: (tapDownDetails) {
          Future.delayed(const Duration(milliseconds: 50), () {
            setState(() {
              containerColor = Colors.white;
            });
            widget.onPressed!();
          });

          logger.info("弹起");
        },
        child: Stack(
          children: [
            // 头像以及名称日期等信息
            Container(
              color: containerColor,
              height: 135.0.w,
              padding: const EdgeInsets.only(left: 30.0).w,
              child: Row(
                children: [
                  // 头像
                  ClipRRect(
                      borderRadius: BorderRadius.circular(95).w,
                      child: Image.asset(
                        assetPath(widget.avatar),
                        cacheWidth: 190.w.toInt(),
                        cacheHeight: 190.w.toInt(),
                        width: 95.w,
                        height: 95.w,
                        fit: BoxFit.cover,
                      )),

                  SizedBox(width: 23.w),

                  // 右边区域
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 12.w,
                        ),

                        // 好友名称和消息时间
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 好友名称
                            Expanded(
                                child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: buildTextSpans(
                                    widget.friendName,
                                    TextStyle(
                                        height: 1.08,
                                        fontSize: fontSizeScale(28.0.w),
                                        color: Colors.black,
                                        fontFamily: "AlibabaPuHuiTi"),
                                    TextStyle(
                                        height: 1.08,
                                        fontSize: fontSizeScale(28.w),
                                        fontFamily: "NotoColorEmoji-Regular")),
                              ),
                            )),
                            SizedBox(
                              width: 10.w,
                            ),
                          ],
                        ),

                        SizedBox(height: 10.w),

                        // 好友消息
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              // color: Colors.amber,
                              // width: 400.w,
                              // margin: EdgeInsets.only(right: 65.w),
                              child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  children: buildTextSpans(
                                      widget.message,
                                      TextStyle(
                                        height: 1.08,
                                        fontSize: fontSizeScale(25.w),
                                        color: const Color.fromARGB(
                                            255, 170, 170, 170),
                                      ),
                                      TextStyle(
                                        height: 1.08,
                                        fontSize: fontSizeScale(25.w),
                                        color: const Color.fromARGB(
                                            255, 170, 170, 170),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
