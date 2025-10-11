import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_alphabet.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';

class LJNFriendInformation extends StatefulWidget {
  const LJNFriendInformation({
    super.key,
  });

  @override
  State<LJNFriendInformation> createState() => _LJNFriendInformation();
}

class _LJNFriendInformation extends State<LJNFriendInformation> {
  @override
  void initState() {
    super.initState();
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
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: l10n.friendProfile,
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                systemState.appbarHeight -
                systemState.statusHeight,
          ),
          color: theme.colorScheme.surfaceContainer,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                LJNFunctionList(
                  title: LJNAlphabet(
                    title: l10n.remark,
                    bgColor: theme.colorScheme.surfaceContainer,
                  ),
                  children: [
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
                      title: l10n.remarkName,
                      link: '/set_notes_and_labels',
                      showStyle: "马化腾",
                      underline: true,
                    ),
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
                      title: l10n.tags,
                      link: '/set_friend_tags',
                      showStyle: l10n.relation_classmate_or_friend,
                      underline: true,
                    ),
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
                      title: l10n.phone,
                      link: '/set_notes_and_labels',
                      showStyle: "+86 18718988850",
                      underline: true,
                    ),
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
                      title: l10n.description,
                      link: '/set_notes_and_labels',
                      showStyle: "-",
                      underline: false,
                    ),
                  ],
                ),

                // 我们的共同群聊
                LJNFunctionList(
                  title: LJNAlphabet(
                    title: l10n.moreInfo,
                  ),
                  children: [
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
                      title: l10n.ourMutualGroups,
                      link: '',
                      showStyle: l10n.personCount(4),
                      underline: false,
                    ),
                  ],
                ),

                // 签名、来源、添加时间
                LJNFunctionList(
                  children: [
                    // 签名
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
                      height: 135.w,
                      title: l10n.signature,
                      underline: true,
                      link: null,
                      showStyle: Container(
                        // color: AppColors.accentRedPure,
                        margin: EdgeInsets.only(right: 40.w),
                        width: 345.w,
                        child: Text(
                          "A journey of a thousand miles begins with a single step.",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            // height: 1.25,
                            fontSize: 32.w,
                            color: theme.colorScheme.onSurface.withAlpha(123),
                          ),
                        ),
                      ),
                    ),

                    // 来源
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
                      height: 135.w,
                      title: l10n.source,
                      underline: true,
                      // link: '',
                      link: null,
                      showStyle: Container(
                        // color: AppColors.accentRedPure,
                        margin: EdgeInsets.only(right: 40.w),
                        width: 345.w,
                        child: Text(
                          l10n.source_added_from_group_chat("Shenzhen Tencent"),
                          textAlign: TextAlign.end,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            // height: 1.25,
                            fontSize: 32.w,
                            color: theme.colorScheme.onSurface.withAlpha(123),
                          ),
                        ),
                      ),
                    ),

                    // 添加时间
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
                      title: l10n.addedTime,
                      // link: '',
                      link: null,
                      underline: false,
                      showStyle: Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 40.w),
                          alignment: Alignment.centerRight,
                          child: Text(
                            l10n.yearAndMonth(DateTime(2024, 10)),
                            style: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(32.0.w),
                              fontFamily: "AlibabaPuHuiTi",
                              color: AppColors.neutralDarkGrey7,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 100.w)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
