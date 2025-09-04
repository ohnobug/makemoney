import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_alphabet.dart';
import 'package:vigaviga/widgets/ljn_chatlist_item.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';

// 关键改动 1: 创建一个数据模型来存储静态数据
class _ContactListItemData {
  final String name;
  final String avatar;
  final String message;
  final bool underline;
  final bool isSpecial; // 用来标记“天空飘来五个字”这个特殊项

  const _ContactListItemData({
    required this.name,
    required this.avatar,
    required this.message,
    this.underline = true,
    this.isSpecial = false,
  });
}

class LJNContactTagGroup extends StatefulWidget {
  const LJNContactTagGroup({super.key});

  @override
  State<LJNContactTagGroup> createState() => _LJNContactTagGroupState();
}

class _LJNContactTagGroupState extends State<LJNContactTagGroup> {
  // 关键改动 2: contactDataList 只存储不依赖 context 的静态数据模型。
  // 列表现在包含了所有原始数据，未经省略。
  final List<dynamic> contactDataList = const [
    'A', // 字母可以直接用 String
    _ContactListItemData(
        name: "天空飘来五个字那都不是事",
        avatar: "images/avatar_webp/chat_1.webp",
        message: '我是天空飘来五个字那都不是事',
        isSpecial: true),
    _ContactListItemData(
        name: "本因", avatar: "images/avatar_webp/chat_10.webp", message: '我是本因'),
    _ContactListItemData(
        name: "赵洵", avatar: "images/avatar_webp/chat_11.webp", message: '我是赵洵'),
    _ContactListItemData(
        name: "定静师太",
        avatar: "images/avatar_webp/chat_12.webp",
        message: '我是定静师太'),
    _ContactListItemData(
        name: "李秋水",
        avatar: "images/avatar_webp/chat_13.webp",
        message: '我是李秋水'),
    _ContactListItemData(
        name: "谭婆", avatar: "images/avatar_webp/chat_14.webp", message: '我是谭婆'),
    _ContactListItemData(
        name: "李傀儡",
        avatar: "images/avatar_webp/chat_15.webp",
        message: '我是李傀儡'),
    _ContactListItemData(
        name: "貂禅", avatar: "images/avatar_webp/chat_16.webp", message: '我是貂禅'),
    _ContactListItemData(
        name: "何三七",
        avatar: "images/avatar_webp/chat_17.webp",
        message: '我是何三七'),
    _ContactListItemData(
        name: "孔融", avatar: "images/avatar_webp/chat_18.webp", message: '我是孔融'),
    _ContactListItemData(
        name: "齐堂主",
        avatar: "images/avatar_webp/chat_19.webp",
        message: '我是齐堂主'),
    _ContactListItemData(
        name: "博尔术",
        avatar: "images/avatar_webp/chat_20.webp",
        message: '我是博尔术'),
    _ContactListItemData(
        name: "王语嫣",
        avatar: "images/avatar_webp/chat_21.webp",
        message: '我是王语嫣'),
    _ContactListItemData(
        name: "秦红棉",
        avatar: "images/avatar_webp/chat_22.webp",
        message: '我是秦红棉'),
    _ContactListItemData(
        name: "天竺僧人",
        avatar: "images/avatar_webp/chat_23.webp",
        message: '我是天竺僧人',
        underline: false),
    'B',
    _ContactListItemData(
        name: "段延庆",
        avatar: "images/avatar_webp/chat_33.webp",
        message: '我是段延庆'),
    _ContactListItemData(
        name: "令狐冲",
        avatar: "images/avatar_webp/chat_34.webp",
        message: '我是令狐冲'),
    _ContactListItemData(
        name: "英白罗",
        avatar: "images/avatar_webp/chat_35.webp",
        message: '我是英白罗'),
    _ContactListItemData(
        name: "黄药师",
        avatar: "images/avatar_webp/chat_36.webp",
        message: '我是黄药师'),
    _ContactListItemData(
        name: "李煜", avatar: "images/avatar_webp/chat_37.webp", message: '我是李煜'),
    _ContactListItemData(
        name: "云中鹤",
        avatar: "images/avatar_webp/chat_38.webp",
        message: '我是云中鹤'),
    _ContactListItemData(
        name: "劳德诺",
        avatar: "images/avatar_webp/chat_39.webp",
        message: '我是劳德诺'),
    _ContactListItemData(
        name: "包惜弱",
        avatar: "images/avatar_webp/chat_40.webp",
        message: '我是包惜弱'),
    _ContactListItemData(
        name: "游驹", avatar: "images/avatar_webp/chat_41.webp", message: '我是游驹'),
    _ContactListItemData(
        name: "钟万仇",
        avatar: "images/avatar_webp/chat_42.webp",
        message: '我是钟万仇'),
    _ContactListItemData(
        name: "渔人", avatar: "images/avatar_webp/chat_43.webp", message: '我是渔人'),
    _ContactListItemData(
        name: "单叔山",
        avatar: "images/avatar_webp/chat_44.webp",
        message: '我是单叔山'),
    _ContactListItemData(
        name: "段誉", avatar: "images/avatar_webp/chat_45.webp", message: '我是段誉'),
    _ContactListItemData(
        name: "林震南",
        avatar: "images/avatar_webp/chat_46.webp",
        message: '我是林震南'),
    _ContactListItemData(
        name: "商鞅", avatar: "images/avatar_webp/chat_47.webp", message: '我是商鞅'),
  ];

  @override
  void initState() {
    super.initState();
  }

  // 关键改动 3: 移除整个 didChangeDependencies 方法

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  Widget _buildPage(SystemState systemState) {
    // 关键改动 4: 在 build 方法内部获取最新的 l10n 实例
    final l10n = AppLocalizations.of(context)!;

    // 辅助函数，用于根据静态数据构建列表项 Widget
    Widget buildListItem(dynamic itemData) {
      if (itemData is String) {
        return LJNAlphabet(
            title: itemData, bgColor: Theme.of(context).colorScheme.surface);
      }

      if (itemData is _ContactListItemData) {
        return ChatListItem(
          friendName: itemData.name,
          avatar: itemData.avatar,
          message: itemData.message,
          notice: false,
          underline: itemData.underline,
          lastedTime: itemData.isSpecial
              ? Row(
                  children: [
                    Icon(
                      const IconData(0xe7cc, fontFamily: 'Iconfont'),
                      color: AppColors.neutralGrey45,
                      size: 28.w,
                    ),
                    SizedBox(width: 8.0.w),
                    Text(
                      l10n.added, // <-- 从最新的 l10n 获取文本
                      style: TextStyle(
                        height: 1.08,
                        fontSize: fontSizeScale(25.0.w),
                        color: AppColors.neutralGrey45,
                      ),
                    ),
                  ],
                )
              : l10n.expired, // <-- 从最新的 l10n 获取文本
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/friendprofile',
              arguments: <String, String>{
                'name': itemData.name,
                'nickname': itemData.name,
                'account': itemData.name,
                'avatar': itemData.avatar,
              },
            );
          },
        );
      }
      return const SizedBox.shrink();
    }

    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: "苦命人", // 注意：这里的标题是硬编码的
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface,
              AppColors.neutralWhite,
            ],
            stops: [0.3, 0.5],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
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
                  itemCount: contactDataList.length + 1,
                  itemBuilder: (context, index) {
                    // 关键改动 5: 在 itemBuilder 中动态构建 UI
                    if (index < contactDataList.length) {
                      return buildListItem(contactDataList[index]);
                    } else {
                      // 构建底部的统计行
                      return Container(
                        width: 750.w,
                        height: 105.0.w,
                        color: AppColors.neutralWhite,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                l10n.friendCount(contactDataList
                                    .whereType<_ContactListItemData>()
                                    .length), // 动态计算好友数量
                                style: TextStyle(
                                  height: 1.08,
                                  fontSize: fontSizeScale(30.w),
                                  color: AppColors.neutralGrey67,
                                ),
                              ),
                            ]),
                      );
                    }
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
