import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_alphabet.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_contact_item.dart';
import 'package:vigaviga/widgets/ljn_search.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNFriendsWhoOnlyChatPage extends StatefulWidget {
  const LJNFriendsWhoOnlyChatPage({super.key});

  @override
  State<LJNFriendsWhoOnlyChatPage> createState() => _LJNFriendsWhoOnlyChatState();
}

class _LJNFriendsWhoOnlyChatState extends State<LJNFriendsWhoOnlyChatPage> {
  // 关键改动 2: staticDataList 只存储不依赖 context 的静态数据模型
  // 它是一个 final 列表，包含了所有原始数据
  final List<dynamic> staticDataList = const [
    'A', // 字母可以直接用 String
    ContactItemData(
      title: "天空飘来五个字那都不是事",
      icon: "images/avatar_webp/chat_1.webp",
    ),
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
    ThemeData theme = Theme.of(context);
    // 关键改动 4: 在 build 方法内部获取最新的 l10n 实例
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: l10n.chatOnlyFriends, // 使用 l10n
      ),
      body: Stack(
        children: [
          Container(
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
                // 搜索栏
                LJNSearch(link: '/search', title: l10n.search), // 使用 l10n

                Expanded(
                  child: ColoredBox(
                    color: AppColors.neutralWhite,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: ListView.builder(
                        primary: false,
                        padding: EdgeInsets.zero,
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        // +2 for header and footer
                        itemCount: staticDataList.length + 2,
                        itemBuilder: (context, index) {
                          // 文本
                          // Header
                          if (index == 0) {
                            return Container(
                              // height: 80.w,
                              padding: EdgeInsets.only(
                                left: 24.w,
                                right: 24.w,
                                bottom: 20.w,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                l10n.privacy_setting_description, // 使用 l10n
                                style: TextStyle(
                                  fontSize: 24.w,
                                  color: AppColors.neutralDarkGrey9,
                                ),
                              ),
                            );
                          }
                          // Footer
                          if (index == staticDataList.length + 1) {
                            return Container(
                              width: 750.w,
                              height: 105.0.w,
                              color: theme.colorScheme.surfaceContainer,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    l10n.friendCount(staticDataList
                                        .whereType<ContactItemData>()
                                        .length), // 使用 l10n
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

                          // List Items
                          final itemData = staticDataList[
                              index - 1]; // Adjust index for data list
                          if (itemData is String) {
                            return LJNAlphabet(
                              title: itemData,
                            );
                          }
                          if (itemData is ContactItemData) {
                            return ContactInformation(
                              title: itemData.title,
                              icon: itemData.icon,
                              link: '',
                              underline: itemData.underline,
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/chat',
                                  arguments: <String, String>{
                                    'title': itemData.title,
                                    'icon': itemData.icon,
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
                ),
                Container(
                  height: 90.w,
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  decoration: BoxDecoration(
                    color: AppColors.neutralGrey2,
                    border: Border(
                      top: BorderSide(
                        color: theme.dividerColor,
                        width: 1.0.w,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        l10n.add,
                        style: TextStyle(
                          fontSize: 30.w,
                          color: theme.colorScheme.onSurface,
                        ),
                      ), // 使用 l10n
                      Text(
                        l10n.remove,
                        style: TextStyle(
                          fontSize: 30.w,
                          color: theme.colorScheme.onSurface,
                        ),
                      ), // 使用 l10n
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
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
        ],
      ),
    );
  }
}
