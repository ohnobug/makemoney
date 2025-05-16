import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_alphabet.dart';
import 'package:jiaoyishuoflutter3/components/ljn_chatlist_item.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/store/ljn_system_cubit.dart';

class LJNContactTagGroup extends StatefulWidget {
  const LJNContactTagGroup({super.key});

  @override
  State<LJNContactTagGroup> createState() => _LJNContactTagGroupState();
}

class _LJNContactTagGroupState extends State<LJNContactTagGroup> {
  late List<dynamic> contactList;

  @override
  void initState() {
    super.initState();

    contactList = [
      LJNAlphabet(
        title: 'A',
        bgColor: Color.fromARGB(255, 237, 237, 237),
      ),
      ChatListItem(
        friendName: "天空飘来五个字那都不是事",
        avatar: "images/avatar_webp/chat_1.webp",
        message: '我是天空飘来五个字那都不是事',
        notice: false,
        lastedTime: Row(
          children: [
            Icon(
              const IconData(
                0xe7cc,
                fontFamily: 'Iconfont',
              ),
              color: const Color.fromARGB(255, 170, 170, 170),
              size: 28.w,
            ),
            SizedBox(width: 8.0.w),
            Text(
              '已添加',
              style: TextStyle(
                height: 1.08,
                fontSize: fontSizeScale(25.0.w),
                color: const Color.fromARGB(255, 170, 170, 170),
              ),
            ),
          ],
        ),
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "天空飘来五个字那都不是事",
                'nickname': "天空飘来五个字那都不是事",
                'account': "天空飘来五个字那都不是事",
                'avatar': "images/avatar_webp/chat_1.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "本因",
        avatar: "images/avatar_webp/chat_10.webp",
        message: '我是本因',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "本因",
                'nickname': "本因",
                'account': "本因",
                'avatar': "images/avatar_webp/chat_10.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "赵洵",
        avatar: "images/avatar_webp/chat_11.webp",
        message: '我是赵洵',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "赵洵",
                'nickname': "赵洵",
                'account': "赵洵",
                'avatar': "images/avatar_webp/chat_11.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "定静师太",
        avatar: "images/avatar_webp/chat_12.webp",
        message: '我是定静师太',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "定静师太",
                'nickname': "定静师太",
                'account': "定静师太",
                'avatar': "images/avatar_webp/chat_12.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "李秋水",
        avatar: "images/avatar_webp/chat_13.webp",
        message: '我是李秋水',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "李秋水",
                'nickname': "李秋水",
                'account': "李秋水",
                'avatar': "images/avatar_webp/chat_13.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "谭婆",
        avatar: "images/avatar_webp/chat_14.webp",
        message: '我是谭婆',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "谭婆",
                'nickname': "谭婆",
                'account': "谭婆",
                'avatar': "images/avatar_webp/chat_14.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "李傀儡",
        avatar: "images/avatar_webp/chat_15.webp",
        message: '我是李傀儡',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "李傀儡",
                'nickname': "李傀儡",
                'account': "李傀儡",
                'avatar': "images/avatar_webp/chat_15.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "貂禅",
        avatar: "images/avatar_webp/chat_16.webp",
        message: '我是貂禅',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "貂禅",
                'nickname': "貂禅",
                'account': "貂禅",
                'avatar': "images/avatar_webp/chat_16.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "何三七",
        avatar: "images/avatar_webp/chat_17.webp",
        message: '我是何三七',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "何三七",
                'nickname': "何三七",
                'account': "何三七",
                'avatar': "images/avatar_webp/chat_17.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "孔融",
        avatar: "images/avatar_webp/chat_18.webp",
        message: '我是孔融',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "孔融",
                'nickname': "孔融",
                'account': "孔融",
                'avatar': "images/avatar_webp/chat_18.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "齐堂主",
        avatar: "images/avatar_webp/chat_19.webp",
        message: '我是齐堂主',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "齐堂主",
                'nickname': "齐堂主",
                'account': "齐堂主",
                'avatar': "images/avatar_webp/chat_19.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "博尔术",
        avatar: "images/avatar_webp/chat_20.webp",
        message: '我是博尔术',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "博尔术",
                'nickname': "博尔术",
                'account': "博尔术",
                'avatar': "images/avatar_webp/chat_20.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "王语嫣",
        avatar: "images/avatar_webp/chat_21.webp",
        message: '我是王语嫣',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "王语嫣",
                'nickname': "王语嫣",
                'account': "王语嫣",
                'avatar': "images/avatar_webp/chat_21.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "秦红棉",
        avatar: "images/avatar_webp/chat_22.webp",
        message: '我是秦红棉',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "秦红棉",
                'nickname': "秦红棉",
                'account': "秦红棉",
                'avatar': "images/avatar_webp/chat_22.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "天竺僧人",
        avatar: "images/avatar_webp/chat_23.webp",
        message: '我是天竺僧人',
        notice: false,
        lastedTime: "已过期",
        underline: false,
      ),
      LJNAlphabet(
        title: 'B',
        bgColor: Color.fromARGB(255, 237, 237, 237),
      ),
      ChatListItem(
        friendName: "段延庆",
        avatar: "images/avatar_webp/chat_33.webp",
        message: '我是段延庆',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "段延庆",
                'nickname': "段延庆",
                'account': "段延庆",
                'avatar': "images/avatar_webp/chat_33.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "令狐冲",
        avatar: "images/avatar_webp/chat_34.webp",
        message: '我是令狐冲',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "令狐冲",
                'nickname': "令狐冲",
                'account': "令狐冲",
                'avatar': "images/avatar_webp/chat_34.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "英白罗",
        avatar: "images/avatar_webp/chat_35.webp",
        message: '我是英白罗',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "英白罗",
                'nickname': "英白罗",
                'account': "英白罗",
                'avatar': "images/avatar_webp/chat_35.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "黄药师",
        avatar: "images/avatar_webp/chat_36.webp",
        message: '我是黄药师',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "黄药师",
                'nickname': "黄药师",
                'account': "黄药师",
                'avatar': "images/avatar_webp/chat_36.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "李煜",
        avatar: "images/avatar_webp/chat_37.webp",
        message: '我是李煜',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "李煜",
                'nickname': "李煜",
                'account': "李煜",
                'avatar': "images/avatar_webp/chat_37.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "云中鹤",
        avatar: "images/avatar_webp/chat_38.webp",
        message: '我是云中鹤',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "云中鹤",
                'nickname': "云中鹤",
                'account': "云中鹤",
                'avatar': "images/avatar_webp/chat_38.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "劳德诺",
        avatar: "images/avatar_webp/chat_39.webp",
        message: '我是劳德诺',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "劳德诺",
                'nickname': "劳德诺",
                'account': "劳德诺",
                'avatar': "images/avatar_webp/chat_39.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "包惜弱",
        avatar: "images/avatar_webp/chat_40.webp",
        message: '我是包惜弱',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "包惜弱",
                'nickname': "包惜弱",
                'account': "包惜弱",
                'avatar': "images/avatar_webp/chat_40.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "游驹",
        avatar: "images/avatar_webp/chat_41.webp",
        message: '我是游驹',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "游驹",
                'nickname': "游驹",
                'account': "游驹",
                'avatar': "images/avatar_webp/chat_41.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "钟万仇",
        avatar: "images/avatar_webp/chat_42.webp",
        message: '我是钟万仇',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "钟万仇",
                'nickname': "钟万仇",
                'account': "钟万仇",
                'avatar': "images/avatar_webp/chat_42.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "渔人",
        avatar: "images/avatar_webp/chat_43.webp",
        message: '我是渔人',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "渔人",
                'nickname': "渔人",
                'account': "渔人",
                'avatar': "images/avatar_webp/chat_43.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "单叔山",
        avatar: "images/avatar_webp/chat_44.webp",
        message: '我是单叔山',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "单叔山",
                'nickname': "单叔山",
                'account': "单叔山",
                'avatar': "images/avatar_webp/chat_44.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "段誉",
        avatar: "images/avatar_webp/chat_45.webp",
        message: '我是段誉',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "段誉",
                'nickname': "段誉",
                'account': "段誉",
                'avatar': "images/avatar_webp/chat_45.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "林震南",
        avatar: "images/avatar_webp/chat_46.webp",
        message: '我是林震南',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "林震南",
                'nickname': "林震南",
                'account': "林震南",
                'avatar': "images/avatar_webp/chat_46.webp",
              });
        },
      ),
      ChatListItem(
        friendName: "商鞅",
        avatar: "images/avatar_webp/chat_47.webp",
        message: '我是商鞅',
        notice: false,
        lastedTime: "已过期",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/friendprofile',
              arguments: <String, String>{
                'name': "商鞅",
                'nickname': "商鞅",
                'account': "商鞅",
                'avatar': "images/avatar_webp/chat_47.webp",
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
                  color: const Color.fromARGB(255, 125, 125, 125),
                ),
              ),
            ]),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  // 另起一个函数方便管理
  Widget _buildPage(SystemState systemState) {
    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: "苦命人",
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
        child: Column(
          children: [
            // 列表
            Expanded(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView.builder(
                  primary: false,
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  itemCount: contactList.length, // contactList 是你的联系人数据列表
                  itemBuilder: (context, index) {
                    return contactList[index];
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
