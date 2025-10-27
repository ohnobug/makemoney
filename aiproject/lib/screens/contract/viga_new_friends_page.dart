import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_alphabet.dart';
import 'package:vigaviga/widgets/viga_chatlist_item.dart';
import 'package:vigaviga/widgets/viga_search.dart';
import 'package:vigaviga/tools/viga_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';

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

class VigaNewFriendsPage extends StatefulWidget {
  const VigaNewFriendsPage({super.key});

  @override
  State<VigaNewFriendsPage> createState() => _VigaNewFriendsState();
}

class _VigaNewFriendsState extends State<VigaNewFriendsPage> {
  // 关键改动 2: staticDataList 只存储不依赖 context 的静态数据模型
  List<dynamic> staticDataList = [];
  @override
  void initState() {
    super.initState();
    var systemCubit = context.read<VigaSystemCubit>();
    String cdnBase = systemCubit.state.cdnBase;

    staticDataList = [
      _TimeSeparatorData('twoDaysAgo'),
      _FriendItemData(
        name: "天空飘来五个字那都不是事",
        avatar: "$cdnBase/avatar/chat_1.jpg",
        message: '我是天空飘来五个字那都不是事',
        status: FriendStatus.added,
      ),
      _FriendItemData(
        name: "本因",
        avatar: "$cdnBase/avatar/chat_10.jpg",
        message: '我是本因',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "赵洵",
        avatar: "$cdnBase/avatar/chat_11.jpg",
        message: '我是赵洵',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "定静师太",
        avatar: "$cdnBase/avatar/chat_12.jpg",
        message: '我是定静师太',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "李秋水",
        avatar: "$cdnBase/avatar/chat_13.jpg",
        message: '我是李秋水',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "谭婆",
        avatar: "$cdnBase/avatar/chat_14.jpg",
        message: '我是谭婆',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "李傀儡",
        avatar: "$cdnBase/avatar/chat_15.jpg",
        message: '我是李傀儡',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "貂禅",
        avatar: "$cdnBase/avatar/chat_16.jpg",
        message: '我是貂禅',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "何三七",
        avatar: "$cdnBase/avatar/chat_17.jpg",
        message: '我是何三七',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "孔融",
        avatar: "$cdnBase/avatar/chat_18.jpg",
        message: '我是孔融',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "齐堂主",
        avatar: "$cdnBase/avatar/chat_19.jpg",
        message: '我是齐堂主',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "博尔术",
        avatar: "$cdnBase/avatar/chat_20.jpg",
        message: '我是博尔术',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "王语嫣",
        avatar: "$cdnBase/avatar/chat_21.jpg",
        message: '我是王语嫣',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "秦红棉",
        avatar: "$cdnBase/avatar/chat_22.jpg",
        message: '我是秦红棉',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "天竺僧人",
        avatar: "$cdnBase/avatar/chat_23.jpg",
        message: '我是天竺僧人',
        status: FriendStatus.expired,
        underline: false,
      ),
      _TimeSeparatorData('fiveDaysAgo'),
      _FriendItemData(
        name: "段延庆",
        avatar: "$cdnBase/avatar/chat_33.jpg",
        message: '我是段延庆',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "令狐冲",
        avatar: "$cdnBase/avatar/chat_34.jpg",
        message: '我是令狐冲',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "英白罗",
        avatar: "$cdnBase/avatar/chat_35.jpg",
        message: '我是英白罗',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "黄药师",
        avatar: "$cdnBase/avatar/chat_36.jpg",
        message: '我是黄药师',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "李煜",
        avatar: "$cdnBase/avatar/chat_37.jpg",
        message: '我是李煜',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "云中鹤",
        avatar: "$cdnBase/avatar/chat_38.jpg",
        message: '我是云中鹤',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "劳德诺",
        avatar: "$cdnBase/avatar/chat_39.jpg",
        message: '我是劳德诺',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "包惜弱",
        avatar: "$cdnBase/avatar/chat_40.jpg",
        message: '我是包惜弱',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "游驹",
        avatar: "$cdnBase/avatar/chat_41.jpg",
        message: '我是游驹',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "钟万仇",
        avatar: "$cdnBase/avatar/chat_42.jpg",
        message: '我是钟万仇',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "渔人",
        avatar: "$cdnBase/avatar/chat_43.jpg",
        message: '我是渔人',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "单叔山",
        avatar: "$cdnBase/avatar/chat_44.jpg",
        message: '我是单叔山',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "段誉",
        avatar: "$cdnBase/avatar/chat_45.jpg",
        message: '我是段誉',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "林震南",
        avatar: "$cdnBase/avatar/chat_46.jpg",
        message: '我是林震南',
        status: FriendStatus.expired,
      ),
      _FriendItemData(
        name: "商鞅",
        avatar: "$cdnBase/avatar/chat_47.jpg",
        message: '我是商鞅',
        status: FriendStatus.expired,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VigaSystemCubit, SystemState>(
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

    String cdnBase = systemState.cdnBase;

    return Scaffold(
      primary: false,
      appBar: VigaAppBar(
        title: l10n.newFriends,
        actions: [
          VigaAppBarActionTextButton(
            onTap: () {
              Navigator.pushNamed(context, '/contact/add_friends');
            },
            title: l10n.addFriend,
          ),
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
            VigaSearch(
              link: '/contact/search_friend',
              title: l10n.searchHintAccountOrPhone,
            ),
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
                      return VigaFunctionItem(
                        title: l10n.addPhoneContacts,
                        icon: "$cdnBase/icon/phone.png",
                        link: '/user/collection_and_payment',
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
                      return VigaAlphabet(
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
                            '/chat/friend_profile',
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
