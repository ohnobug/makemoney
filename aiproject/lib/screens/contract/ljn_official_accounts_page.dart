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

class LJNOfficialAccountsPage extends StatefulWidget {
  const LJNOfficialAccountsPage({super.key});

  @override
  State<LJNOfficialAccountsPage> createState() => _LJNOfficialAccountsState();
}

class _LJNOfficialAccountsState extends State<LJNOfficialAccountsPage> {
  // 关键改动 2: staticDataList 只存储不依赖 context 的静态数据模型
  List<dynamic> staticDataList = [];
  @override
  void initState() {
    super.initState();

    var systemCubit = context.read<LJNSystemCubit>();
    String cdnBase = systemCubit.state.cdnBase;

    staticDataList = [
      'A',
      _OfficialAccountData(
          title: "天空飘来五个字那都不是事", icon: "$cdnBase/avatar/chat_1.jpg"),
      _OfficialAccountData(title: "本因", icon: "$cdnBase/avatar/chat_10.jpg"),
      _OfficialAccountData(title: "赵洵", icon: "$cdnBase/avatar/chat_11.jpg"),
      _OfficialAccountData(title: "定静师太", icon: "$cdnBase/avatar/chat_12.jpg"),
      _OfficialAccountData(title: "李秋水", icon: "$cdnBase/avatar/chat_13.jpg"),
      _OfficialAccountData(title: "谭婆", icon: "$cdnBase/avatar/chat_14.jpg"),
      _OfficialAccountData(title: "李傀儡", icon: "$cdnBase/avatar/chat_15.jpg"),
      _OfficialAccountData(title: "貂禅", icon: "$cdnBase/avatar/chat_16.jpg"),
      _OfficialAccountData(title: "何三七", icon: "$cdnBase/avatar/chat_17.jpg"),
      _OfficialAccountData(title: "孔融", icon: "$cdnBase/avatar/chat_18.jpg"),
      _OfficialAccountData(title: "齐堂主", icon: "$cdnBase/avatar/chat_19.jpg"),
      _OfficialAccountData(title: "博尔术", icon: "$cdnBase/avatar/chat_20.jpg"),
      _OfficialAccountData(title: "王语嫣", icon: "$cdnBase/avatar/chat_21.jpg"),
      _OfficialAccountData(title: "秦红棉", icon: "$cdnBase/avatar/chat_22.jpg"),
      _OfficialAccountData(
          title: "天竺僧人", icon: "$cdnBase/avatar/chat_23.jpg", underline: false),
      'B',
      _OfficialAccountData(title: "段延庆", icon: "$cdnBase/avatar/chat_33.jpg"),
      _OfficialAccountData(title: "令狐冲", icon: "$cdnBase/avatar/chat_34.jpg"),
      _OfficialAccountData(title: "英白罗", icon: "$cdnBase/avatar/chat_35.jpg"),
      _OfficialAccountData(title: "黄药师", icon: "$cdnBase/avatar/chat_36.jpg"),
      _OfficialAccountData(title: "李煜", icon: "$cdnBase/avatar/chat_37.jpg"),
      _OfficialAccountData(title: "云中鹤", icon: "$cdnBase/avatar/chat_38.jpg"),
      _OfficialAccountData(title: "劳德诺", icon: "$cdnBase/avatar/chat_39.jpg"),
      _OfficialAccountData(title: "包惜弱", icon: "$cdnBase/avatar/chat_40.jpg"),
      _OfficialAccountData(title: "游驹", icon: "$cdnBase/avatar/chat_41.jpg"),
      _OfficialAccountData(title: "钟万仇", icon: "$cdnBase/avatar/chat_42.jpg"),
      _OfficialAccountData(title: "渔人", icon: "$cdnBase/avatar/chat_43.jpg"),
      _OfficialAccountData(title: "单叔山", icon: "$cdnBase/avatar/chat_44.jpg"),
      _OfficialAccountData(title: "段誉", icon: "$cdnBase/avatar/chat_45.jpg"),
      _OfficialAccountData(title: "林震南", icon: "$cdnBase/avatar/chat_46.jpg"),
      _OfficialAccountData(title: "商鞅", icon: "$cdnBase/avatar/chat_47.jpg"),
    ];
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
    AppLocalizations l10n = AppLocalizations.of(context)!;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: l10n.officialAccounts, // 使用 l10n
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
                LJNSearch(
                  link: '/discovery/search',
                  title: l10n.search,
                ), // 使用 l10n
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
                                ],
                              ),
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
