import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_alphabet.dart';
import 'package:vigaviga/widgets/viga_chatlist_item.dart';
import 'package:vigaviga/tools/viga_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';

class VigaContactGroupPage extends StatefulWidget {
  const VigaContactGroupPage({super.key});

  @override
  State<VigaContactGroupPage> createState() => _VigaContactGroupState();
}

class _VigaContactGroupState extends State<VigaContactGroupPage> {
  late List<dynamic> contactList;

  @override
  void initState() {
    super.initState();

    AppLocalizations l10n = AppLocalizations.of(context)!;

    // 1. 你的 DateTime 对象，来自数据模型
    final DateTime creationTimestamp = DateTime(2025, 5, 16, 15, 39);

    // 2. 直接调用模板，只需传入 DateTime 对象
    final String displayText = l10n.creationTimeDisplay(creationTimestamp);

    var systemCubit = context.read<VigaSystemCubit>();
    String cdnBase = systemCubit.state.cdnBase;

    contactList = [
      VigaAlphabet(
        title: l10n.groupChats,
      ),
      ChatListItem(
        friendName: "天空飘来五个字那都不是事",
        avatar: "$cdnBase/avatar/chat_1.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "天空飘来五个字那都不是事",
                'nickname': "天空飘来五个字那都不是事",
                'account': "天空飘来五个字那都不是事",
                'avatar': "$cdnBase/avatar/chat_1.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "本因",
        avatar: "$cdnBase/avatar/chat_10.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "本因",
                'nickname': "本因",
                'account': "本因",
                'avatar': "$cdnBase/avatar/chat_10.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "赵洵",
        avatar: "$cdnBase/avatar/chat_11.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "赵洵",
                'nickname': "赵洵",
                'account': "赵洵",
                'avatar': "$cdnBase/avatar/chat_11.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "定静师太",
        avatar: "$cdnBase/avatar/chat_12.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "定静师太",
                'nickname': "定静师太",
                'account': "定静师太",
                'avatar': "$cdnBase/avatar/chat_12.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "李秋水",
        avatar: "$cdnBase/avatar/chat_13.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "李秋水",
                'nickname': "李秋水",
                'account': "李秋水",
                'avatar': "$cdnBase/avatar/chat_13.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "谭婆",
        avatar: "$cdnBase/avatar/chat_14.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "谭婆",
                'nickname': "谭婆",
                'account': "谭婆",
                'avatar': "$cdnBase/avatar/chat_14.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "李傀儡",
        avatar: "$cdnBase/avatar/chat_15.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "李傀儡",
                'nickname': "李傀儡",
                'account': "李傀儡",
                'avatar': "$cdnBase/avatar/chat_15.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "貂禅",
        avatar: "$cdnBase/avatar/chat_16.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "貂禅",
                'nickname': "貂禅",
                'account': "貂禅",
                'avatar': "$cdnBase/avatar/chat_16.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "何三七",
        avatar: "$cdnBase/avatar/chat_17.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "何三七",
                'nickname': "何三七",
                'account': "何三七",
                'avatar': "$cdnBase/avatar/chat_17.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "孔融",
        avatar: "$cdnBase/avatar/chat_18.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "孔融",
                'nickname': "孔融",
                'account': "孔融",
                'avatar': "$cdnBase/avatar/chat_18.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "齐堂主",
        avatar: "$cdnBase/avatar/chat_19.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "齐堂主",
                'nickname': "齐堂主",
                'account': "齐堂主",
                'avatar': "$cdnBase/avatar/chat_19.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "博尔术",
        avatar: "$cdnBase/avatar/chat_20.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "博尔术",
                'nickname': "博尔术",
                'account': "博尔术",
                'avatar': "$cdnBase/avatar/chat_20.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "王语嫣",
        avatar: "$cdnBase/avatar/chat_21.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "王语嫣",
                'nickname': "王语嫣",
                'account': "王语嫣",
                'avatar': "$cdnBase/avatar/chat_21.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "秦红棉",
        avatar: "$cdnBase/avatar/chat_22.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "秦红棉",
                'nickname': "秦红棉",
                'account': "秦红棉",
                'avatar': "$cdnBase/avatar/chat_22.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "天竺僧人",
        avatar: "$cdnBase/avatar/chat_23.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: false,
      ),
      VigaAlphabet(
        title: 'B',
      ),
      ChatListItem(
        friendName: "段延庆",
        avatar: "$cdnBase/avatar/chat_33.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "段延庆",
                'nickname': "段延庆",
                'account': "段延庆",
                'avatar': "$cdnBase/avatar/chat_33.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "令狐冲",
        avatar: "$cdnBase/avatar/chat_34.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "令狐冲",
                'nickname': "令狐冲",
                'account': "令狐冲",
                'avatar': "$cdnBase/avatar/chat_34.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "英白罗",
        avatar: "$cdnBase/avatar/chat_35.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "英白罗",
                'nickname': "英白罗",
                'account': "英白罗",
                'avatar': "$cdnBase/avatar/chat_35.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "黄药师",
        avatar: "$cdnBase/avatar/chat_36.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "黄药师",
                'nickname': "黄药师",
                'account': "黄药师",
                'avatar': "$cdnBase/avatar/chat_36.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "李煜",
        avatar: "$cdnBase/avatar/chat_37.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "李煜",
                'nickname': "李煜",
                'account': "李煜",
                'avatar': "$cdnBase/avatar/chat_37.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "云中鹤",
        avatar: "$cdnBase/avatar/chat_38.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "云中鹤",
                'nickname': "云中鹤",
                'account': "云中鹤",
                'avatar': "$cdnBase/avatar/chat_38.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "劳德诺",
        avatar: "$cdnBase/avatar/chat_39.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "劳德诺",
                'nickname': "劳德诺",
                'account': "劳德诺",
                'avatar': "$cdnBase/avatar/chat_39.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "包惜弱",
        avatar: "$cdnBase/avatar/chat_40.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "包惜弱",
                'nickname': "包惜弱",
                'account': "包惜弱",
                'avatar': "$cdnBase/avatar/chat_40.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "游驹",
        avatar: "$cdnBase/avatar/chat_41.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "游驹",
                'nickname': "游驹",
                'account': "游驹",
                'avatar': "$cdnBase/avatar/chat_41.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "钟万仇",
        avatar: "$cdnBase/avatar/chat_42.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "钟万仇",
                'nickname': "钟万仇",
                'account': "钟万仇",
                'avatar': "$cdnBase/avatar/chat_42.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "渔人",
        avatar: "$cdnBase/avatar/chat_43.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "渔人",
                'nickname': "渔人",
                'account': "渔人",
                'avatar': "$cdnBase/avatar/chat_43.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "单叔山",
        avatar: "$cdnBase/avatar/chat_44.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "单叔山",
                'nickname': "单叔山",
                'account': "单叔山",
                'avatar': "$cdnBase/avatar/chat_44.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "段誉",
        avatar: "$cdnBase/avatar/chat_45.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "段誉",
                'nickname': "段誉",
                'account': "段誉",
                'avatar': "$cdnBase/avatar/chat_45.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "林震南",
        avatar: "$cdnBase/avatar/chat_46.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "林震南",
                'nickname': "林震南",
                'account': "林震南",
                'avatar': "$cdnBase/avatar/chat_46.jpg",
              });
        },
      ),
      ChatListItem(
        friendName: "商鞅",
        avatar: "$cdnBase/avatar/chat_47.jpg",
        message: displayText,
        notice: false,
        lastedTime: "",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat/friend/profile',
              arguments: <String, String>{
                'name': "商鞅",
                'nickname': "商鞅",
                'account': "商鞅",
                'avatar': "$cdnBase/avatar/chat_47.jpg",
              });
        },
      ),
      Container(
        width: 750.w,
        height: 105.0.w,
        color: AppColors.neutralWhite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              l10n.groupChatCount(4),
              style: TextStyle(
                height: 1.08,
                fontSize: fontSizeScale(30.w),
                color: AppColors.neutralGrey67,
              ),
            ),
          ],
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  // 另起一个函数方便管理
  Widget _buildPage(SystemState systemState) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      primary: false,
      appBar: VigaAppBar(
        title: l10n.groupChats,
      ),
      body: Container(
        width: 750.w,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.surface,
              AppColors.neutralWhite,
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
