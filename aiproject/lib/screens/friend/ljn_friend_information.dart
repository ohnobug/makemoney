import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/l10n/app_localizations.dart';
import 'package:spicychat/screens/components/ljn_alphabet.dart';
import 'package:spicychat/screens/components/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import 'package:spicychat/tools/ljn_tools.dart';
import '../components/ljn_function_item.dart';

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
    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: AppLocalizations.of(context)!.friendProfile,
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                90.w -
                systemState.statusHeight,
          ),
          color: AppColors.neutralGrey11,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                LJNAlphabet(
                  title: AppLocalizations.of(context)!.remark,
                  bgColor: AppColors.neutralGrey11,
                ),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.remarkName,
                  link: '/set_notes_and_labels',
                  showStyle: "马化腾",
                  underline: true,
                ),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.tags,
                  link: '/set_friend_tags',
                  showStyle: AppLocalizations.of(context)!
                      .relation_classmate_or_friend,
                  underline: true,
                ),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.phone,
                  link: '/set_notes_and_labels',
                  showStyle: "+86 18718988850",
                  underline: true,
                ),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.description,
                  link: '/set_notes_and_labels',
                  showStyle: "-",
                  underline: false,
                ),
                LJNAlphabet(
                  title: AppLocalizations.of(context)!.moreInfo,
                  bgColor: AppColors.neutralGrey11,
                ),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.ourMutualGroups,
                  link: '',
                  showStyle: AppLocalizations.of(context)!.personCount(4),
                  underline: false,
                ),
                Container(
                  color: AppColors.neutralGrey11,
                  height: 16.w,
                ),
                LJNFunctionItem(
                  height: 135.w,
                  title: AppLocalizations.of(context)!.signature,
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
                      style: TextStyle(
                        // height: 1.25,
                        fontSize: 32.w,
                        color: AppColors.neutralDarkGrey4,
                      ),
                    ),
                  ),
                ),
                LJNFunctionItem(
                  height: 135.w,
                  title: AppLocalizations.of(context)!.source,
                  underline: true,
                  // link: '',
                  link: null,
                  showStyle: Container(
                    // color: AppColors.accentRedPure,
                    margin: EdgeInsets.only(right: 40.w),
                    width: 345.w,
                    child: Text(
                      AppLocalizations.of(context)!
                          .source_added_from_group_chat("Shenzhen Tencent"),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        // height: 1.25,
                        fontSize: 32.w,
                        color: AppColors.neutralDarkGrey4,
                      ),
                    ),
                  ),
                ),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.addedTime,
                  // link: '',
                  link: null,
                  underline: false,
                  showStyle: Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 40.w),
                      alignment: Alignment.centerRight,
                      child: Text(
                        AppLocalizations.of(context)!
                            .yearAndMonth(DateTime(2024, 10)),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
