import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_alphabet.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNFriendsWhoOnlyChat extends StatefulWidget {
  const LJNFriendsWhoOnlyChat({super.key});

  @override
  State<LJNFriendsWhoOnlyChat> createState() => _LJNFriendsWhoOnlyChatState();
}

class _LJNFriendsWhoOnlyChatState extends State<LJNFriendsWhoOnlyChat> {
  late List<dynamic> contactList;

  @override
  void initState() {
    super.initState();

    contactList = [
      // 提示
      Container(
          height: 80.w,
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          alignment: Alignment.center,
          child: Text(
            "你们将互相看不到对方的朋友圈、状态、微信运动、看一看以及第三方登录授权分享的内容。",
            style: TextStyle(
                fontSize: 24.w, color: Color.fromARGB(255, 81, 81, 81)),
          )),

      LJNAlphabet(title: 'A'),
      ContactInformation(
        title: "天空飘来五个字那都不是事",
        icon: "images/avatar_webp/chat_1.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "天空飘来五个字那都不是事",
            'icon': "images/avatar_webp/chat_1.webp",
          });
        },
      ),
      ContactInformation(
        title: "本因",
        icon: "images/avatar_webp/chat_10.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "本因",
            'icon': "images/avatar_webp/chat_10.webp",
          });
        },
      ),
      ContactInformation(
        title: "赵洵",
        icon: "images/avatar_webp/chat_11.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "赵洵",
            'icon': "images/avatar_webp/chat_11.webp",
          });
        },
      ),
      ContactInformation(
        title: "定静师太",
        icon: "images/avatar_webp/chat_12.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "定静师太",
            'icon': "images/avatar_webp/chat_12.webp",
          });
        },
      ),
      ContactInformation(
        title: "李秋水",
        icon: "images/avatar_webp/chat_13.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "李秋水",
            'icon': "images/avatar_webp/chat_13.webp",
          });
        },
      ),
      ContactInformation(
        title: "谭婆",
        icon: "images/avatar_webp/chat_14.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "谭婆",
            'icon': "images/avatar_webp/chat_14.webp",
          });
        },
      ),
      ContactInformation(
        title: "李傀儡",
        icon: "images/avatar_webp/chat_15.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "李傀儡",
            'icon': "images/avatar_webp/chat_15.webp",
          });
        },
      ),
      ContactInformation(
        title: "貂禅",
        icon: "images/avatar_webp/chat_16.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "貂禅",
            'icon': "images/avatar_webp/chat_16.webp",
          });
        },
      ),
      ContactInformation(
        title: "何三七",
        icon: "images/avatar_webp/chat_17.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "何三七",
            'icon': "images/avatar_webp/chat_17.webp",
          });
        },
      ),
      ContactInformation(
        title: "孔融",
        icon: "images/avatar_webp/chat_18.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "孔融",
            'icon': "images/avatar_webp/chat_18.webp",
          });
        },
      ),
      ContactInformation(
        title: "齐堂主",
        icon: "images/avatar_webp/chat_19.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "齐堂主",
            'icon': "images/avatar_webp/chat_19.webp",
          });
        },
      ),
      ContactInformation(
        title: "博尔术",
        icon: "images/avatar_webp/chat_20.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "博尔术",
            'icon': "images/avatar_webp/chat_20.webp",
          });
        },
      ),
      ContactInformation(
        title: "王语嫣",
        icon: "images/avatar_webp/chat_21.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "王语嫣",
            'icon': "images/avatar_webp/chat_21.webp",
          });
        },
      ),
      ContactInformation(
        title: "秦红棉",
        icon: "images/avatar_webp/chat_22.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "秦红棉",
            'icon': "images/avatar_webp/chat_22.webp",
          });
        },
      ),
      const ContactInformation(
        title: "天竺僧人",
        icon: "images/avatar_webp/chat_23.webp",
        link: '',
        underline: false,
      ),
      LJNAlphabet(title: 'B'),
      ContactInformation(
        title: "段延庆",
        icon: "images/avatar_webp/chat_33.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "段延庆",
            'icon': "images/avatar_webp/chat_33.webp",
          });
        },
      ),
      ContactInformation(
        title: "令狐冲",
        icon: "images/avatar_webp/chat_34.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "令狐冲",
            'icon': "images/avatar_webp/chat_34.webp",
          });
        },
      ),
      ContactInformation(
        title: "英白罗",
        icon: "images/avatar_webp/chat_35.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "英白罗",
            'icon': "images/avatar_webp/chat_35.webp",
          });
        },
      ),
      ContactInformation(
        title: "黄药师",
        icon: "images/avatar_webp/chat_36.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "黄药师",
            'icon': "images/avatar_webp/chat_36.webp",
          });
        },
      ),
      ContactInformation(
        title: "李煜",
        icon: "images/avatar_webp/chat_37.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "李煜",
            'icon': "images/avatar_webp/chat_37.webp",
          });
        },
      ),
      ContactInformation(
        title: "云中鹤",
        icon: "images/avatar_webp/chat_38.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "云中鹤",
            'icon': "images/avatar_webp/chat_38.webp",
          });
        },
      ),
      ContactInformation(
        title: "劳德诺",
        icon: "images/avatar_webp/chat_39.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "劳德诺",
            'icon': "images/avatar_webp/chat_39.webp",
          });
        },
      ),
      ContactInformation(
        title: "包惜弱",
        icon: "images/avatar_webp/chat_40.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "包惜弱",
            'icon': "images/avatar_webp/chat_40.webp",
          });
        },
      ),
      ContactInformation(
        title: "游驹",
        icon: "images/avatar_webp/chat_41.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "游驹",
            'icon': "images/avatar_webp/chat_41.webp",
          });
        },
      ),
      ContactInformation(
        title: "钟万仇",
        icon: "images/avatar_webp/chat_42.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "钟万仇",
            'icon': "images/avatar_webp/chat_42.webp",
          });
        },
      ),
      ContactInformation(
        title: "渔人",
        icon: "images/avatar_webp/chat_43.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "渔人",
            'icon': "images/avatar_webp/chat_43.webp",
          });
        },
      ),
      ContactInformation(
        title: "单叔山",
        icon: "images/avatar_webp/chat_44.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "单叔山",
            'icon': "images/avatar_webp/chat_44.webp",
          });
        },
      ),
      ContactInformation(
        title: "段誉",
        icon: "images/avatar_webp/chat_45.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "段誉",
            'icon': "images/avatar_webp/chat_45.webp",
          });
        },
      ),
      ContactInformation(
        title: "林震南",
        icon: "images/avatar_webp/chat_46.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "林震南",
            'icon': "images/avatar_webp/chat_46.webp",
          });
        },
      ),
      ContactInformation(
        title: "商鞅",
        icon: "images/avatar_webp/chat_47.webp",
        link: '',
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "商鞅",
            'icon': "images/avatar_webp/chat_47.webp",
          });
        },
      ),
      Container(
        width: 750.w,
        height: 105.0.w,
        color: Colors.white,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "10个朋友",
                style: TextStyle(
                    height: 1.08,
                    fontSize: fontSizeScale(30.w),
                    color: const Color.fromARGB(255, 125, 125, 125)),
              ),
            ]),
      )
    ];
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
      appBar: const LJNAppBar(
        title: "仅聊天的朋友",
      ),
      body: Stack(
        children: [
          Container(
              width: systemState.screenSize.width,
              height: systemState.screenSize.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 237, 237, 237),
                    Colors.white,
                  ],
                  stops: [0.3, 0.5],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(children: [
                // 搜索框
                Container(
                    padding:
                        EdgeInsets.only(bottom: 15.w, left: 15.w, right: 15.w),
                    height: 75.w,
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 8.0.w, horizontal: 20.0.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.w),
                        border: Border.all(
                            color: Color.fromRGBO(158, 158, 158, 0.3)),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/search');
                        },
                        child: Center(
                          // 保证整体内容居中
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    const IconData(
                                      0xe612,
                                      fontFamily: 'Iconfont',
                                    ),
                                    color: Colors.black,
                                    size: 40.w,
                                  ),
                                ),
                                TextSpan(
                                  text: " 搜索",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 30.w,
                                    color: Color.fromARGB(255, 69, 75, 83),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),

                // 列表
                Expanded(
                    child: ColoredBox(
                  color: Colors.white,
                  child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: ListView.builder(
                        primary: false,
                        padding: EdgeInsets.zero,
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        itemCount: contactList.length, // contactList 是你的联系人数据列表
                        itemBuilder: (context, index) {
                          return contactList[index];
                        },
                      )),
                )),

                // 底部按钮
                Container(
                  height: 90.w,
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 247, 247),
                      border: Border(
                          top: BorderSide(
                        color: const Color.fromARGB(255, 227, 227, 227),
                        width: 1.5.w,
                        style: BorderStyle.solid,
                      ))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "添加",
                        style: TextStyle(fontSize: 30.w, color: Colors.black),
                      ),
                      Text(
                        "移出",
                        style: TextStyle(fontSize: 30.w, color: Colors.black),
                      ),
                    ],
                  ),
                )
              ])),

          // 右边的字母表
          Positioned(
              right: 0,
              top: ((MediaQuery.of(context).size.height - 986.w) / 2) + 40.w,
              child: SizedBox(
                width: 40.w,
                // height: MediaQuery.of(context).size.height - 115.w - 75.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 34.w,
                      child: Icon(
                          const IconData(
                            0xe677,
                            fontFamily: 'Iconfont',
                          ),
                          size: 22.w,
                          color: const Color.fromARGB(255, 20, 20, 20)),
                    ),
                    SizedBox(
                      height: 34.w,
                      child: Icon(
                          const IconData(
                            0xe6c8,
                            fontFamily: 'Iconfont',
                          ),
                          size: 22.w,
                          color: const Color.fromARGB(255, 20, 20, 20)),
                    ),
                    for (int i = 0; i < 26; i++)
                      SizedBox(
                        height: 34.w,
                        child: Text(
                          String.fromCharCode(65 + i),
                          style: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(22.w),
                              color: const Color.fromARGB(255, 20, 20, 20)),
                        ),
                      ),
                    SizedBox(
                      height: 34.w,
                      child: Text(
                        "#",
                        style: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(22.w),
                            color: const Color.fromARGB(255, 20, 20, 20)),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// 功能列表
class ContactInformation extends StatefulWidget {
  final String icon;
  final String title;
  final String link;
  final bool underline;
  final int? showStyle;
  final Function()? onPressed;

  const ContactInformation({
    super.key,
    required this.icon,
    required this.title,
    required this.link,
    required this.underline,
    this.showStyle,
    this.onPressed,
  });

  @override
  State<ContactInformation> createState() => _ContactInformationState();
}

class _ContactInformationState extends State<ContactInformation> {
  // bool isClicked = false;
  Color containerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
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
      child: Container(
        height: 105.0.w,
        padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
        color: containerColor,
        child: Row(
          children: [
            // 头像
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(7.0.w), // Adjust the radius as needed
              child: Image.asset(
                assetPath(widget.icon),
                width: 75.0.w,
                height: 75.0.w,
                cacheHeight: 150.w.toInt(),
                cacheWidth: 150.w.toInt(),
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 25.w),
            Expanded(
              child: Container(
                height: 100.w,
                width: 400.w,
                decoration: widget.underline
                    ? BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                        color: const Color.fromARGB(255, 242, 242, 242),
                        width: 1.5.w,
                        style: BorderStyle.solid,
                      )))
                    : BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.transparent,
                            width: 1.5.w,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 标题
                    Expanded(
                      flex: 1,
                      // width: 100.w,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          height: 1.08,
                          fontSize: fontSizeScale(33.0.w),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
