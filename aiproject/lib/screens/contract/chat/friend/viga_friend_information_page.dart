import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_alphabet.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/tools/viga_tools.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';
import 'package:vigaviga/widgets/viga_special_function_item.dart';

class VigaFriendInformationPage extends StatefulWidget {
  const VigaFriendInformationPage({
    super.key,
  });

  @override
  State<VigaFriendInformationPage> createState() => _VigaFriendInformation();
}

class _VigaFriendInformation extends State<VigaFriendInformationPage> {
  @override
  void initState() {
    super.initState();
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
                VigaFunctionList(
                  title: VigaAlphabet(
                    title: l10n.remark,
                    bgColor: theme.colorScheme.surfaceContainer,
                  ),
                  children: [
                    VigaFunctionItem(
                      title: l10n.remarkName,
                      link: '/chat/set_notes_and_labels',
                      showStyle: "马化腾",
                      underline: true,
                    ),
                    VigaFunctionItem(
                      title: l10n.tags,
                      link: '/chat/set_friend_tags',
                      showStyle: l10n.relation_classmate_or_friend,
                      underline: true,
                    ),
                    VigaFunctionItem(
                      title: l10n.phone,
                      link: '/chat/set_notes_and_labels',
                      showStyle: "+86 18718988850",
                      underline: true,
                    ),
                    VigaFunctionItem(
                      title: l10n.description,
                      link: '/chat/set_notes_and_labels',
                      showStyle: "-",
                      underline: false,
                    ),
                  ],
                ),

                // 我们的共同群聊
                VigaFunctionList(
                  title: VigaAlphabet(
                    title: l10n.moreInfo,
                  ),
                  children: [
                    VigaFunctionItem(
                      title: l10n.ourMutualGroups,
                      link: '',
                      showStyle: l10n.personCount(4),
                      underline: false,
                    ),
                  ],
                ),

                // 签名、来源、添加时间
                VigaFunctionList(
                  children: [
                    // 签名
                    VigaSpecialFunctionItem(
                      title: l10n.signature,
                      tapEffect: false,
                      underline: true,
                      height: null,
                      // link: '',
                      subTitle: Text(
                        "A journey of a thousand miles begins with a single step.",
                        maxLines: 3,
                        style: TextStyle(
                          color: AppColors.neutralGrey37,
                          fontSize: 28.w,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    // 来源
                    VigaSpecialFunctionItem(
                      title: l10n.signature,
                      tapEffect: false,
                      underline: true,
                      height: null,
                      // link: '',
                      subTitle: Text(
                        l10n.source_added_from_group_chat("Shenzhen Tencent"),
                        maxLines: 3,
                        style: TextStyle(
                          color: AppColors.neutralGrey37,
                          fontSize: 28.w,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    // 添加时间
                    VigaFunctionItem(
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
