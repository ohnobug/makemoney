import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_alphabet.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_switch.dart';
import 'package:vigaviga/tools/ljn_logger.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import '../../widgets/ljn_function_item.dart';

class LJNFriendPermissions extends StatefulWidget {
  const LJNFriendPermissions({super.key});

  @override
  State<LJNFriendPermissions> createState() => _LJNFriendPermissions();
}

class _LJNFriendPermissions extends State<LJNFriendPermissions> {
  bool chatOnly = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return Scaffold(
        primary: false,
        appBar: LJNAppBar(
          title: l10n.friendPermissions,
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  90.w -
                  systemState.statusHeight,
            ),
            color: theme.colorScheme.surfaceContainer,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                children: [
                  // 设置朋友权限
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 64.w,
                    padding:
                        const EdgeInsets.only(left: 30.0, right: 0.0, top: 16)
                            .w,
                    child: Text(
                      l10n.setFriendPermissions,
                      style: TextStyle(
                        fontSize: 25.w,
                        height: 1.08,
                        color: AppColors.neutralGrey76,
                      ),
                    ),
                  ),

                  // 聊天、朋友圈、微信运动等
                  LJNFunctionItem(
                    title: AppLocalizations.of(context)!
                        .featureListChatMomentsWeRun,
                    onPress: () {
                      setState(() {
                        chatOnly = false;
                      });
                    },
                    underline: true,
                    tapEffect: true,
                    showLinkIcon: false,
                    showStyle: chatOnly == false
                        ? Expanded(
                            flex: 0,
                            child: Container(
                              // color: AppColors.accentRedPure,
                              width: 30.w,
                              height: 105.0.w,
                              margin:
                                  const EdgeInsets.only(left: 10, right: 32).w,
                              child: Icon(
                                const IconData(
                                  0xe60d,
                                  fontFamily: 'Iconfont',
                                ),
                                size: 30.0.w,
                                color: AppColors.brandGreenDarker1,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),

                  // 仅聊天
                  LJNFunctionItem(
                    title: l10n.chatOnly,
                    // link: '',
                    underline: false,
                    tapEffect: true,
                    onPress: () {
                      setState(() {
                        chatOnly = true;
                      });
                    },
                    showStyle: chatOnly == true
                        ? Expanded(
                            flex: 0,
                            child: Container(
                              // color: AppColors.accentRedPure,
                              width: 30.w,
                              height: 105.0.w,
                              margin:
                                  const EdgeInsets.only(left: 10, right: 32).w,
                              child: Icon(
                                const IconData(
                                  0xe60d,
                                  fontFamily: 'Iconfont',
                                ),
                                size: 30.0.w,
                                color: AppColors.brandGreenDarker1,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),

                  // 提示语
                  if (chatOnly)
                    LJNAlphabet(
                      title: l10n.privacyRestrictionFull,
                      color: AppColors.neutralGrey76,
                    ),

                  // 不让他看我
                  if (chatOnly == false) ...[
                    LJNAlphabet(
                      title: l10n.momentsAndStatus,
                      color: AppColors.neutralGrey76,
                    ),
                    LJNFunctionItem(
                      title: l10n.hideMyPosts,
                      // link: '',
                      underline: true,
                      tapEffect: false,
                      showStyle: Expanded(
                        flex: 0,
                        child: Container(
                          margin: const EdgeInsets.only(right: 32).w,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                    ),
                    LJNFunctionItem(
                      title: l10n.hideTheirPosts,
                      // link: '',
                      underline: false,
                      tapEffect: false,
                      showStyle: Expanded(
                        flex: 0,
                        child: Container(
                          margin: const EdgeInsets.only(right: 32).w,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
