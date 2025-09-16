import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_alphabet.dart';
import 'package:vigaviga/widgets/ljn_chatlist_item.dart';
import 'package:vigaviga/widgets/ljn_search.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';

// 关键改动 1: 创建数据模型来存储静态数据
enum FriendStatus { added, expired }

class _FriendItemData {
  final String name;
  final String avatar;
  final String message;
  final bool underline;
  final FriendStatus status;

  const _FriendItemData({
    required this.name,
    required this.avatar,
    required this.message,
    required this.status,
    this.underline = true,
  });
}

class _TimeSeparatorData {
  final String titleKey;
  const _TimeSeparatorData(this.titleKey);
}

class LJNNewFriends extends StatefulWidget {
  const LJNNewFriends({super.key});

  @override
  State<LJNNewFriends> createState() => _LJNNewFriendsState();
}

class _LJNNewFriendsState extends State<LJNNewFriends> {
  // 关键改动 2: staticDataList 只存储不依赖 context 的静态数据模型
  final List<dynamic> staticDataList = const [
    _TimeSeparatorData('twoDaysAgo'),
    _FriendItemData(
        name: "天空飘来五个字那都不是事",
        avatar: "images/avatar_webp/chat_1.webp",
        message: '我是天空飘来五个字那都不是事',
        status: FriendStatus.added),
    _FriendItemData(
        name: "本因",
        avatar: "images/avatar_webp/chat_10.webp",
        message: '我是本因',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "赵洵",
        avatar: "images/avatar_webp/chat_11.webp",
        message: '我是赵洵',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "定静师太",
        avatar: "images/avatar_webp/chat_12.webp",
        message: '我是定静师太',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "李秋水",
        avatar: "images/avatar_webp/chat_13.webp",
        message: '我是李秋水',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "谭婆",
        avatar: "images/avatar_webp/chat_14.webp",
        message: '我是谭婆',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "李傀儡",
        avatar: "images/avatar_webp/chat_15.webp",
        message: '我是李傀儡',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "貂禅",
        avatar: "images/avatar_webp/chat_16.webp",
        message: '我是貂禅',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "何三七",
        avatar: "images/avatar_webp/chat_17.webp",
        message: '我是何三七',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "孔融",
        avatar: "images/avatar_webp/chat_18.webp",
        message: '我是孔融',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "齐堂主",
        avatar: "images/avatar_webp/chat_19.webp",
        message: '我是齐堂主',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "博尔术",
        avatar: "images/avatar_webp/chat_20.webp",
        message: '我是博尔术',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "王语嫣",
        avatar: "images/avatar_webp/chat_21.webp",
        message: '我是王语嫣',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "秦红棉",
        avatar: "images/avatar_webp/chat_22.webp",
        message: '我是秦红棉',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "天竺僧人",
        avatar: "images/avatar_webp/chat_23.webp",
        message: '我是天竺僧人',
        status: FriendStatus.expired,
        underline: false),
    _TimeSeparatorData('fiveDaysAgo'),
    _FriendItemData(
        name: "段延庆",
        avatar: "images/avatar_webp/chat_33.webp",
        message: '我是段延庆',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "令狐冲",
        avatar: "images/avatar_webp/chat_34.webp",
        message: '我是令狐冲',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "英白罗",
        avatar: "images/avatar_webp/chat_35.webp",
        message: '我是英白罗',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "黄药师",
        avatar: "images/avatar_webp/chat_36.webp",
        message: '我是黄药师',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "李煜",
        avatar: "images/avatar_webp/chat_37.webp",
        message: '我是李煜',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "云中鹤",
        avatar: "images/avatar_webp/chat_38.webp",
        message: '我是云中鹤',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "劳德诺",
        avatar: "images/avatar_webp/chat_39.webp",
        message: '我是劳德诺',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "包惜弱",
        avatar: "images/avatar_webp/chat_40.webp",
        message: '我是包惜弱',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "游驹",
        avatar: "images/avatar_webp/chat_41.webp",
        message: '我是游驹',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "钟万仇",
        avatar: "images/avatar_webp/chat_42.webp",
        message: '我是钟万仇',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "渔人",
        avatar: "images/avatar_webp/chat_43.webp",
        message: '我是渔人',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "单叔山",
        avatar: "images/avatar_webp/chat_44.webp",
        message: '我是单叔山',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "段誉",
        avatar: "images/avatar_webp/chat_45.webp",
        message: '我是段誉',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "林震南",
        avatar: "images/avatar_webp/chat_46.webp",
        message: '我是林震南',
        status: FriendStatus.expired),
    _FriendItemData(
        name: "商鞅",
        avatar: "images/avatar_webp/chat_47.webp",
        message: '我是商鞅',
        status: FriendStatus.expired),
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

  // 辅助方法，用于根据 key 获取时间分隔符的标题
  String _getTimeSeparatorTitle(AppLocalizations l10n, String key) {
    switch (key) {
      case 'twoDaysAgo':
        return l10n.twoDaysAgo;
      case 'fiveDaysAgo':
        return l10n.fiveDaysAgo;
      default:
        return '';
    }
  }

  Widget _buildPage(SystemState systemState) {
    // 关键改动 4: 在 build 方法内部获取最新的 l10n 实例
    AppLocalizations l10n = AppLocalizations.of(context)!;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: l10n.newFriends,
        actions: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/add_friends'),
            child: Container(
              height: 90.w,
              color: AppColors.transparent,
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 33.w),
              child: Text(
                l10n.addFriend,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: fontSizeScale(32.w),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        width: 750.w,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.surface, AppColors.neutralWhite],
            stops: [0.3, 0.5],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            LJNSearch(
                link: '/search_friend', title: l10n.searchHintAccountOrPhone),
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
                  // +2 for header and footer
                  itemCount: staticDataList.length + 2,
                  itemBuilder: (context, index) {
                    // 关键改动 5: 在 itemBuilder 中动态构建 UI
                    // Header Item
                    if (index == 0) {
                      return LJNFunctionItem(
                        title: l10n.addPhoneContacts,
                        icon: "images/icon/phone.png",
                        link: '/collection_and_payment',
                        underline: false,
                      );
                    }

                    // Footer Item
                    if (index == staticDataList.length + 1) {
                      return Container(
                        width: 750.w,
                        height: 105.0.w,
                        color: AppColors
                            .neutralWhite, // Assuming a white background for the footer
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              l10n.friendCount(staticDataList
                                  .whereType<_FriendItemData>()
                                  .length),
                              style: TextStyle(
                                height: 1.08,
                                fontSize: fontSizeScale(30.w),
                                color: AppColors.neutralGrey67,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // Data List Items
                    final itemData =
                        staticDataList[index - 1]; // Adjust index for data list

                    if (itemData is _TimeSeparatorData) {
                      return LJNAlphabet(
                        title: _getTimeSeparatorTitle(l10n, itemData.titleKey),
                        bgColor: theme.colorScheme.surfaceContainer,
                      );
                    }

                    if (itemData is _FriendItemData) {
                      return ChatListItem(
                        friendName: itemData.name,
                        avatar: itemData.avatar,
                        message: itemData.message,
                        notice: false,
                        lastedTime: itemData.status == FriendStatus.added
                            ? Row(
                                children: [
                                  Icon(
                                    const IconData(0xe7cc,
                                        fontFamily: 'Iconfont'),
                                    color: AppColors.neutralGrey45,
                                    size: 28.w,
                                  ),
                                  SizedBox(width: 8.0.w),
                                  Text(
                                    l10n.added,
                                    style: TextStyle(
                                      height: 1.08,
                                      fontSize: fontSizeScale(25.0.w),
                                      color: AppColors.neutralGrey45,
                                    ),
                                  ),
                                ],
                              )
                            : l10n.expired,
                        underline: itemData.underline,
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
