import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/l10n/app_localizations.dart';
import 'package:spicychat/screens/components/ljn_alphabet.dart';
import 'package:spicychat/screens/components/ljn_appbar.dart';
import 'package:spicychat/screens/components/ljn_search.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import 'package:spicychat/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 关键改动 1: 创建一个数据模型来存储静态数据
class _OfficialAccountData {
  final String title;
  final String icon;
  final bool underline;

  const _OfficialAccountData({
    required this.title,
    required this.icon,
    this.underline = true,
  });
}

class LJNOfficialAccounts extends StatefulWidget {
  const LJNOfficialAccounts({super.key});

  @override
  State<LJNOfficialAccounts> createState() => _LJNOfficialAccountsState();
}

class _LJNOfficialAccountsState extends State<LJNOfficialAccounts> {
  // 关键改动 2: staticDataList 只存储不依赖 context 的静态数据模型
  final List<dynamic> staticDataList = const [
    'A',
    _OfficialAccountData(
        title: "天空飘来五个字那都不是事", icon: "images/avatar_webp/chat_1.webp"),
    _OfficialAccountData(title: "本因", icon: "images/avatar_webp/chat_10.webp"),
    _OfficialAccountData(title: "赵洵", icon: "images/avatar_webp/chat_11.webp"),
    _OfficialAccountData(
        title: "定静师太", icon: "images/avatar_webp/chat_12.webp"),
    _OfficialAccountData(title: "李秋水", icon: "images/avatar_webp/chat_13.webp"),
    _OfficialAccountData(title: "谭婆", icon: "images/avatar_webp/chat_14.webp"),
    _OfficialAccountData(title: "李傀儡", icon: "images/avatar_webp/chat_15.webp"),
    _OfficialAccountData(title: "貂禅", icon: "images/avatar_webp/chat_16.webp"),
    _OfficialAccountData(title: "何三七", icon: "images/avatar_webp/chat_17.webp"),
    _OfficialAccountData(title: "孔融", icon: "images/avatar_webp/chat_18.webp"),
    _OfficialAccountData(title: "齐堂主", icon: "images/avatar_webp/chat_19.webp"),
    _OfficialAccountData(title: "博尔术", icon: "images/avatar_webp/chat_20.webp"),
    _OfficialAccountData(title: "王语嫣", icon: "images/avatar_webp/chat_21.webp"),
    _OfficialAccountData(title: "秦红棉", icon: "images/avatar_webp/chat_22.webp"),
    _OfficialAccountData(
        title: "天竺僧人",
        icon: "images/avatar_webp/chat_23.webp",
        underline: false),
    'B',
    _OfficialAccountData(title: "段延庆", icon: "images/avatar_webp/chat_33.webp"),
    _OfficialAccountData(title: "令狐冲", icon: "images/avatar_webp/chat_34.webp"),
    _OfficialAccountData(title: "英白罗", icon: "images/avatar_webp/chat_35.webp"),
    _OfficialAccountData(title: "黄药师", icon: "images/avatar_webp/chat_36.webp"),
    _OfficialAccountData(title: "李煜", icon: "images/avatar_webp/chat_37.webp"),
    _OfficialAccountData(title: "云中鹤", icon: "images/avatar_webp/chat_38.webp"),
    _OfficialAccountData(title: "劳德诺", icon: "images/avatar_webp/chat_39.webp"),
    _OfficialAccountData(title: "包惜弱", icon: "images/avatar_webp/chat_40.webp"),
    _OfficialAccountData(title: "游驹", icon: "images/avatar_webp/chat_41.webp"),
    _OfficialAccountData(title: "钟万仇", icon: "images/avatar_webp/chat_42.webp"),
    _OfficialAccountData(title: "渔人", icon: "images/avatar_webp/chat_43.webp"),
    _OfficialAccountData(title: "单叔山", icon: "images/avatar_webp/chat_44.webp"),
    _OfficialAccountData(title: "段誉", icon: "images/avatar_webp/chat_45.webp"),
    _OfficialAccountData(title: "林震南", icon: "images/avatar_webp/chat_46.webp"),
    _OfficialAccountData(title: "商鞅", icon: "images/avatar_webp/chat_47.webp"),
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

    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: l10n.officialAccounts, // 使用 l10n
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.neutralGrey11, AppColors.neutralWhite],
                stops: [0.3, 0.5],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
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
                        itemCount:
                            staticDataList.length + 1, // +1 for the footer
                        itemBuilder: (context, index) {
                          // 关键改动 5: 在 itemBuilder 中动态构建 UI
                          if (index < staticDataList.length) {
                            final itemData = staticDataList[index];

                            if (itemData is String) {
                              return LJNAlphabet(title: itemData);
                            }
                            if (itemData is _OfficialAccountData) {
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
                          } else {
                            // Build the footer
                            return Container(
                              width: 750.w,
                              height: 105.0.w,
                              color: AppColors.neutralWhite,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      l10n.friendCount(staticDataList
                                          .whereType<_OfficialAccountData>()
                                          .length), // Dynamic count
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
                ),
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
                    child: Icon(const IconData(0xe677, fontFamily: 'Iconfont'),
                        size: 22.w, color: AppColors.neutralNearBlack3),
                  ),
                  SizedBox(
                    height: 34.w,
                    child: Icon(const IconData(0xe6c8, fontFamily: 'Iconfont'),
                        size: 22.w, color: AppColors.neutralNearBlack3),
                  ),
                  for (int i = 0; i < 26; i++)
                    SizedBox(
                      height: 34.w,
                      child: Text(
                        String.fromCharCode(65 + i),
                        style: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(22.w),
                            color: AppColors.neutralNearBlack3),
                      ),
                    ),
                  SizedBox(
                    height: 34.w,
                    child: Text("#",
                        style: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(22.w),
                            color: AppColors.neutralNearBlack3)),
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
  Color containerColor = AppColors.neutralWhite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        if (widget.onPressed == null) return;
        setState(() => containerColor = AppColors.neutralGrey18);
      },
      onTapCancel: () {
        if (widget.onPressed == null) return;
        setState(() => containerColor = AppColors.neutralWhite);
      },
      onTapUp: (tapDownDetails) {
        if (widget.onPressed == null) return;
        Future.delayed(const Duration(milliseconds: 50), () {
          if (!mounted) return;
          setState(() => containerColor = AppColors.neutralWhite);
          widget.onPressed?.call();
        });
      },
      child: Container(
        height: 130.0.w,
        padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
        color: containerColor,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(90.0.w),
              child: Image.asset(
                assetPath(widget.icon),
                width: 90.0.w,
                height: 90.0.w,
                cacheHeight: 300,
                cacheWidth: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: Container(
                height: 125.w,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: widget.underline
                        ? BorderSide(
                            color: AppColors.neutralGrey6,
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
