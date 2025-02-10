import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_alphabet.dart';
import 'package:jiaoyishuoflutter3/components/ljn_chatlist_item.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/components/ljn_function_item.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';

class LJNNewFriends extends StatefulWidget {
  const LJNNewFriends({super.key});

  @override
  State<LJNNewFriends> createState() => _LJNNewFriendsState();
}

class _LJNNewFriendsState extends State<LJNNewFriends> {
  late List<dynamic> contactList;

  @override
  void initState() {
    super.initState();

    contactList = [
      // 提示
      const LJNFunctionItem(
        title: "添加手机联系人",
        icon: "images/icon/phone.png",
        link: '/collection_and_payment',
        underline: false,
      ),

      LJNAlphabet(title: '两天前'),
      ChatListItem(
        friendName: "天空飘来五个字那都不是事",
        avatar: "images/avatar_webp/chat_1.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: Row(
          children: [
            Icon(
              const IconData(
                0xe7cc,
                fontFamily: 'Iconfont',
              ),
              color: const Color.fromARGB(255, 170, 170, 170),
              size: 23.w,
            ),
            SizedBox(width: 8.0.w),
            Text(
              '已添加',
              style: TextStyle(
                height: 1.08,
                fontSize: fontSizeScale(23.0.w),
                color: const Color.fromARGB(255, 170, 170, 170),
              ),
            ),
          ],
        ),
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "天空飘来五个字那都不是事",
            'icon': "images/avatar_webp/chat_1.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "本因",
        avatar: "images/avatar_webp/chat_10.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "本因",
            'icon': "images/avatar_webp/chat_10.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "赵洵",
        avatar: "images/avatar_webp/chat_11.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "赵洵",
            'icon': "images/avatar_webp/chat_11.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "定静师太",
        avatar: "images/avatar_webp/chat_12.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "定静师太",
            'icon': "images/avatar_webp/chat_12.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "李秋水",
        avatar: "images/avatar_webp/chat_13.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "李秋水",
            'icon': "images/avatar_webp/chat_13.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "谭婆",
        avatar: "images/avatar_webp/chat_14.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "谭婆",
            'icon': "images/avatar_webp/chat_14.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "李傀儡",
        avatar: "images/avatar_webp/chat_15.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "李傀儡",
            'icon': "images/avatar_webp/chat_15.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "貂禅",
        avatar: "images/avatar_webp/chat_16.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "貂禅",
            'icon': "images/avatar_webp/chat_16.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "何三七",
        avatar: "images/avatar_webp/chat_17.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "何三七",
            'icon': "images/avatar_webp/chat_17.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "孔融",
        avatar: "images/avatar_webp/chat_18.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "孔融",
            'icon': "images/avatar_webp/chat_18.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "齐堂主",
        avatar: "images/avatar_webp/chat_19.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "齐堂主",
            'icon': "images/avatar_webp/chat_19.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "博尔术",
        avatar: "images/avatar_webp/chat_20.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "博尔术",
            'icon': "images/avatar_webp/chat_20.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "王语嫣",
        avatar: "images/avatar_webp/chat_21.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "王语嫣",
            'icon': "images/avatar_webp/chat_21.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "秦红棉",
        avatar: "images/avatar_webp/chat_22.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "秦红棉",
            'icon': "images/avatar_webp/chat_22.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "天竺僧人",
        avatar: "images/avatar_webp/chat_23.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: false,
      ),
      LJNAlphabet(title: '五天前'),
      ChatListItem(
        friendName: "段延庆",
        avatar: "images/avatar_webp/chat_33.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "段延庆",
            'icon': "images/avatar_webp/chat_33.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "令狐冲",
        avatar: "images/avatar_webp/chat_34.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "令狐冲",
            'icon': "images/avatar_webp/chat_34.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "英白罗",
        avatar: "images/avatar_webp/chat_35.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "英白罗",
            'icon': "images/avatar_webp/chat_35.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "黄药师",
        avatar: "images/avatar_webp/chat_36.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "黄药师",
            'icon': "images/avatar_webp/chat_36.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "李煜",
        avatar: "images/avatar_webp/chat_37.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "李煜",
            'icon': "images/avatar_webp/chat_37.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "云中鹤",
        avatar: "images/avatar_webp/chat_38.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "云中鹤",
            'icon': "images/avatar_webp/chat_38.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "劳德诺",
        avatar: "images/avatar_webp/chat_39.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "劳德诺",
            'icon': "images/avatar_webp/chat_39.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "包惜弱",
        avatar: "images/avatar_webp/chat_40.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "包惜弱",
            'icon': "images/avatar_webp/chat_40.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "游驹",
        avatar: "images/avatar_webp/chat_41.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "游驹",
            'icon': "images/avatar_webp/chat_41.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "钟万仇",
        avatar: "images/avatar_webp/chat_42.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "钟万仇",
            'icon': "images/avatar_webp/chat_42.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "渔人",
        avatar: "images/avatar_webp/chat_43.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "渔人",
            'icon': "images/avatar_webp/chat_43.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "单叔山",
        avatar: "images/avatar_webp/chat_44.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "单叔山",
            'icon': "images/avatar_webp/chat_44.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "段誉",
        avatar: "images/avatar_webp/chat_45.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "段誉",
            'icon': "images/avatar_webp/chat_45.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "林震南",
        avatar: "images/avatar_webp/chat_46.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "林震南",
            'icon': "images/avatar_webp/chat_46.webp",
          });
        },
      ),
      ChatListItem(
        friendName: "商鞅",
        avatar: "images/avatar_webp/chat_47.webp",
        message: '我是Xtransfer彭英研',
        notice: false,
        lastedTime: "已过期",
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
      appBar: LJNAppBar(
        title: "新的朋友",
        actions: [
          GestureDetector(
              onTap: () {
                // 点击事件
              },
              child: Container(
                  // color: Colors.transparent,
                  height: 90.w,
                  color: Colors.transparent,
                  // color: Colors.amber,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(right: 33.w),
                  child: Text("添加朋友",
                      style: TextStyle(
                          // height: 1.08,
                          color: Colors.black,
                          fontSize: fontSizeScale(32.w),
                          fontWeight: FontWeight.w500))))
        ],
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
                                  text: " 搜索 账号/手机号",
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
                    child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: ListView.builder(
                          primary: false,
                          padding: EdgeInsets.zero,
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          itemCount:
                              contactList.length, // contactList 是你的联系人数据列表
                          itemBuilder: (context, index) {
                            return contactList[index];
                          },
                        ))),
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
