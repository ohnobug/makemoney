import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_alphabet.dart';
import 'package:vigaviga/widgets/ljn_contact_item.dart';
import 'package:vigaviga/widgets/ljn_page_loading.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNContact extends StatefulWidget {
  const LJNContact({super.key});

  @override
  State<LJNContact> createState() => _LJNContactState();
}

class _LJNContactState extends State<LJNContact> {
  // 关键改动 2: contactDataList 只存储不依赖 context 的静态数据模型
  final List<dynamic> contactDataList = const [
    FunctionItemData(
        titleKey: 'newFriends',
        icon: "images/avatar/01.png",
        link: '/new_friends',
        underline: true),
    FunctionItemData(
        titleKey: 'chatOnlyFriends',
        icon: "images/avatar/02.png",
        link: '/friends_who_only_chat',
        underline: true),
    FunctionItemData(
        titleKey: 'groupChats',
        icon: "images/avatar/03.png",
        link: '/contact_group',
        underline: true),
    FunctionItemData(
        titleKey: 'tags',
        icon: "images/avatar/04.png",
        link: '/contact_tags',
        underline: true),
    FunctionItemData(
        titleKey: 'officialAccounts',
        icon: "images/avatar/05.png",
        link: '/official_accounts',
        underline: false),
    'A', // 字母
    ContactItemData(
        title: "天空飘来五个字那都不是事", icon: "images/avatar_webp/chat_1.webp"),
    ContactItemData(title: "本因", icon: "images/avatar_webp/chat_10.webp"),
    ContactItemData(title: "赵洵", icon: "images/avatar_webp/chat_11.webp"),
    ContactItemData(title: "定静师太", icon: "images/avatar_webp/chat_12.webp"),
    ContactItemData(title: "李秋水", icon: "images/avatar_webp/chat_13.webp"),
    ContactItemData(title: "谭婆", icon: "images/avatar_webp/chat_14.webp"),
    ContactItemData(title: "李傀儡", icon: "images/avatar_webp/chat_15.webp"),
    ContactItemData(title: "貂禅", icon: "images/avatar_webp/chat_16.webp"),
    ContactItemData(title: "何三七", icon: "images/avatar_webp/chat_17.webp"),
    ContactItemData(title: "孔融", icon: "images/avatar_webp/chat_18.webp"),
    ContactItemData(title: "齐堂主", icon: "images/avatar_webp/chat_19.webp"),
    ContactItemData(title: "博尔术", icon: "images/avatar_webp/chat_20.webp"),
    ContactItemData(title: "王语嫣", icon: "images/avatar_webp/chat_21.webp"),
    ContactItemData(title: "秦红棉", icon: "images/avatar_webp/chat_22.webp"),
    ContactItemData(
      title: "天竺僧人",
      icon: "images/avatar_webp/chat_23.webp",
      underline: false,
    ),
    'B',
    ContactItemData(title: "段延庆", icon: "images/avatar_webp/chat_33.webp"),
    ContactItemData(title: "令狐冲", icon: "images/avatar_webp/chat_34.webp"),
    ContactItemData(title: "英白罗", icon: "images/avatar_webp/chat_35.webp"),
    ContactItemData(title: "黄药师", icon: "images/avatar_webp/chat_36.webp"),
    ContactItemData(title: "李煜", icon: "images/avatar_webp/chat_37.webp"),
    ContactItemData(title: "云中鹤", icon: "images/avatar_webp/chat_38.webp"),
    ContactItemData(title: "劳德诺", icon: "images/avatar_webp/chat_39.webp"),
    ContactItemData(title: "包惜弱", icon: "images/avatar_webp/chat_40.webp"),
    ContactItemData(title: "游驹", icon: "images/avatar_webp/chat_41.webp"),
    ContactItemData(title: "钟万仇", icon: "images/avatar_webp/chat_42.webp"),
    ContactItemData(title: "渔人", icon: "images/avatar_webp/chat_43.webp"),
    ContactItemData(title: "单叔山", icon: "images/avatar_webp/chat_44.webp"),
    ContactItemData(title: "段誉", icon: "images/avatar_webp/chat_45.webp"),
    ContactItemData(title: "林震南", icon: "images/avatar_webp/chat_46.webp"),
    ContactItemData(title: "商鞅", icon: "images/avatar_webp/chat_47.webp"),
  ];

  @override
  void initState() {
    super.initState();
    logger.info('contact...............');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LJNSystemCubit>().updateHomescrollpixels(0);
      context.read<LJNSystemCubit>().updateShowMiniProgramDrawer(false);
      context.read<LJNSystemCubit>().updateMainpage2isload(true);
    });
  }

  // 关键改动 3: 移除整个 didChangeDependencies 方法

  // 辅助方法，用于根据 titleKey 获取本地化字符串
  String _getTitleFromKey(AppLocalizations l10n, String key) {
    switch (key) {
      case 'newFriends':
        return l10n.newFriends;
      case 'chatOnlyFriends':
        return l10n.chatOnlyFriends;
      case 'groupChats':
        return l10n.groupChats;
      case 'tags':
        return l10n.tags;
      case 'officialAccounts':
        return l10n.officialAccounts;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return systemState.mainpage2isload!
          ? _buildPage(context, systemState)
          : const LJNPageLoading();
    });
  }

  Widget _buildPage(BuildContext context, SystemState systemState) {
    // 关键改动 4: 在 build 方法内部获取最新的 l10n 实例
    final l10n = AppLocalizations.of(context)!;

    return Stack(children: [
      ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  90.w -
                  systemState.statusHeight),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.surfaceContainer
              ],
              stops: [0.3, 0.5],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView.builder(
            primary: false,
            padding: EdgeInsets.only(top: systemState.statusHeight + 90.w),
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            itemCount: contactDataList.length + 1, // +1 for the footer
            itemBuilder: (context, index) {
              // 关键改动 5: 在 itemBuilder 中动态构建 UI
              if (index < contactDataList.length) {
                final itemData = contactDataList[index];

                if (itemData is String) {
                  return LJNAlphabet(title: itemData);
                }

                if (itemData is FunctionItemData) {
                  return ContactInformation(
                    icon: itemData.icon,
                    title: _getTitleFromKey(l10n, itemData.titleKey), // 动态获取标题
                    link: itemData.link,
                    underline: itemData.underline,
                    onPressed: itemData.link.isEmpty
                        ? () =>
                            Navigator.pushNamed(context, '/new_friends') // 特殊处理
                        : null,
                  );
                }

                if (itemData is ContactItemData) {
                  return ContactInformation(
                    icon: itemData.icon,
                    title: itemData.title,
                    link: '',
                    underline: itemData.underline,
                    onPressed: () {
                      Navigator.pushNamed(context, '/chat',
                          arguments: <String, String>{
                            'title': itemData.title,
                            'icon': itemData.icon,
                          });
                    },
                  );
                }

                return const SizedBox.shrink();
              } else {
                // 构建底部的统计行
                return Container(
                  width: 750.w,
                  height: 105.0.w,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        l10n.friendCount(
                          contactDataList.whereType<ContactItemData>().length,
                        ), // 动态计算
                        style: TextStyle(
                          height: 1.08,
                          fontSize: fontSizeScale(30.w),
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
      Visibility(
        visible: systemState.contactazshow,
        child: Positioned(
          right: 0,
          top: ((MediaQuery.of(context).size.height - 986.w) / 2) + 40.w,
          child: SizedBox(
            width: 40.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 34.w,
                  child: Icon(
                    const IconData(0xe677, fontFamily: 'Iconfont'),
                    size: 22.w,
                    color: AppColors.neutralNearBlack3,
                  ),
                ),
                SizedBox(
                  height: 34.w,
                  child: Icon(
                    const IconData(0xe6c8, fontFamily: 'Iconfont'),
                    size: 22.w,
                    color: AppColors.neutralNearBlack3,
                  ),
                ),
                for (int i = 0; i < 26; i++)
                  SizedBox(
                    height: 34.w,
                    child: Text(
                      String.fromCharCode(65 + i),
                      style: TextStyle(
                        height: 1.08,
                        fontSize: fontSizeScale(22.w),
                        color: AppColors.neutralNearBlack3,
                      ),
                    ),
                  ),
                SizedBox(
                  height: 34.w,
                  child: Text(
                    "#",
                    style: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(22.w),
                      color: AppColors.neutralNearBlack3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
