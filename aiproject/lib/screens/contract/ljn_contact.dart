import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_alphabet.dart';
import 'package:vigaviga/widgets/ljn_page_loading.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 关键改动 1: 创建数据模型来存储静态数据
// 功能项的数据模型
class _FunctionItemData {
  final String icon;
  final String link;
  final bool underline;
  // title 将通过 l10n key 来动态获取
  final String titleKey;

  const _FunctionItemData({
    required this.icon,
    required this.link,
    required this.underline,
    required this.titleKey,
  });
}

// 联系人项的数据模型
class _ContactItemData {
  final String title;
  final String icon;
  final bool underline;

  const _ContactItemData({
    required this.title,
    required this.icon,
    this.underline = true,
  });
}

class LJNContact extends StatefulWidget {
  const LJNContact({super.key});

  @override
  State<LJNContact> createState() => _LJNContactState();
}

class _LJNContactState extends State<LJNContact> {
  // 关键改动 2: contactDataList 只存储不依赖 context 的静态数据模型
  final List<dynamic> contactDataList = const [
    _FunctionItemData(
        titleKey: 'newFriends',
        icon: "images/avatar/01.png",
        link: '/new_friends',
        underline: true),
    _FunctionItemData(
        titleKey: 'chatOnlyFriends',
        icon: "images/avatar/02.png",
        link: '/friends_who_only_chat',
        underline: true),
    _FunctionItemData(
        titleKey: 'groupChats',
        icon: "images/avatar/03.png",
        link: '/contact_group',
        underline: true),
    _FunctionItemData(
        titleKey: 'tags',
        icon: "images/avatar/04.png",
        link: '/contact_tags',
        underline: true),
    _FunctionItemData(
        titleKey: 'officialAccounts',
        icon: "images/avatar/05.png",
        link: '/official_accounts',
        underline: false),
    'A', // 字母
    _ContactItemData(
        title: "天空飘来五个字那都不是事", icon: "images/avatar_webp/chat_1.webp"),
    _ContactItemData(title: "本因", icon: "images/avatar_webp/chat_10.webp"),
    _ContactItemData(title: "赵洵", icon: "images/avatar_webp/chat_11.webp"),
    _ContactItemData(title: "定静师太", icon: "images/avatar_webp/chat_12.webp"),
    _ContactItemData(title: "李秋水", icon: "images/avatar_webp/chat_13.webp"),
    _ContactItemData(title: "谭婆", icon: "images/avatar_webp/chat_14.webp"),
    _ContactItemData(title: "李傀儡", icon: "images/avatar_webp/chat_15.webp"),
    _ContactItemData(title: "貂禅", icon: "images/avatar_webp/chat_16.webp"),
    _ContactItemData(title: "何三七", icon: "images/avatar_webp/chat_17.webp"),
    _ContactItemData(title: "孔融", icon: "images/avatar_webp/chat_18.webp"),
    _ContactItemData(title: "齐堂主", icon: "images/avatar_webp/chat_19.webp"),
    _ContactItemData(title: "博尔术", icon: "images/avatar_webp/chat_20.webp"),
    _ContactItemData(title: "王语嫣", icon: "images/avatar_webp/chat_21.webp"),
    _ContactItemData(title: "秦红棉", icon: "images/avatar_webp/chat_22.webp"),
    _ContactItemData(
        title: "天竺僧人",
        icon: "images/avatar_webp/chat_23.webp",
        underline: false),
    'B',
    _ContactItemData(title: "段延庆", icon: "images/avatar_webp/chat_33.webp"),
    _ContactItemData(title: "令狐冲", icon: "images/avatar_webp/chat_34.webp"),
    _ContactItemData(title: "英白罗", icon: "images/avatar_webp/chat_35.webp"),
    _ContactItemData(title: "黄药师", icon: "images/avatar_webp/chat_36.webp"),
    _ContactItemData(title: "李煜", icon: "images/avatar_webp/chat_37.webp"),
    _ContactItemData(title: "云中鹤", icon: "images/avatar_webp/chat_38.webp"),
    _ContactItemData(title: "劳德诺", icon: "images/avatar_webp/chat_39.webp"),
    _ContactItemData(title: "包惜弱", icon: "images/avatar_webp/chat_40.webp"),
    _ContactItemData(title: "游驹", icon: "images/avatar_webp/chat_41.webp"),
    _ContactItemData(title: "钟万仇", icon: "images/avatar_webp/chat_42.webp"),
    _ContactItemData(title: "渔人", icon: "images/avatar_webp/chat_43.webp"),
    _ContactItemData(title: "单叔山", icon: "images/avatar_webp/chat_44.webp"),
    _ContactItemData(title: "段誉", icon: "images/avatar_webp/chat_45.webp"),
    _ContactItemData(title: "林震南", icon: "images/avatar_webp/chat_46.webp"),
    _ContactItemData(title: "商鞅", icon: "images/avatar_webp/chat_47.webp"),
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
                AppColors.neutralWhite
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

                if (itemData is _FunctionItemData) {
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

                if (itemData is _ContactItemData) {
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
                  color: AppColors.neutralWhite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        l10n.friendCount(contactDataList
                            .whereType<_ContactItemData>()
                            .length), // 动态计算
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
  late Color containerColor = Theme.of(context).listTileTheme.tileColor!;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        setState(() => containerColor =
            Theme.of(context).listTileTheme.selectedTileColor!);
      },
      onTapCancel: () {
        setState(
            () => containerColor = Theme.of(context).listTileTheme.tileColor!);
      },
      onTapUp: (tapDownDetails) {
        Future.delayed(const Duration(milliseconds: 50), () {
          if (!mounted) return;
          setState(() =>
              containerColor = Theme.of(context).listTileTheme.tileColor!);

          if (widget.onPressed != null) {
            widget.onPressed!();
          } else if (widget.link.isNotEmpty) {
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, widget.link);
          }
        });
      },
      child: Container(
        height: 105.0.w,
        padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
        color: containerColor,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7.0.w),
              child: Image.asset(
                assetPath(widget.icon),
                width: 75.0.w,
                height: 75.0.w,
                cacheHeight: 150,
                cacheWidth: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: Container(
                height: 100.w,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: widget.underline
                        ? BorderSide(
                            color: Theme.of(context).listTileTheme.selectedTileColor!,
                            width: 1.5.w,
                            style: BorderStyle.solid,
                          )
                        : BorderSide.none,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
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
