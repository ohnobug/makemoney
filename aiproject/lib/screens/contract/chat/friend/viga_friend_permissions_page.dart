import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_alphabet.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_switch.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';

class VigaFriendPermissionsPage extends StatefulWidget {
  const VigaFriendPermissionsPage({super.key});

  @override
  State<VigaFriendPermissionsPage> createState() => _VigaFriendPermissions();
}

class _VigaFriendPermissions extends State<VigaFriendPermissionsPage> {
  bool chatOnly = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
      String cdnBase = systemState.cdnBase;

      return Scaffold(
        primary: false,
        appBar: VigaAppBar(
          title: l10n.friendPermissions,
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
                  // 聊天、朋友圈、Vigaviga运动等
                  VigaFunctionList(
                    title: VigaAlphabet(title: l10n.setFriendPermissions),
                    children: [
                      // Vigaviga运动
                      VigaFunctionItem(
                        icon: "$cdnBase/avatar/02.png",
                        title: l10n.featureListChatMomentsWeRun,
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
                                      const EdgeInsets.only(left: 10, right: 32)
                                          .w,
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
                      VigaFunctionItem(
                        icon: "$cdnBase/avatar/02.png",
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
                                      const EdgeInsets.only(left: 10, right: 32)
                                          .w,
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
                    ],
                  ),

                  // 提示语
                  if (chatOnly)
                    VigaAlphabet(
                      title: l10n.privacyRestrictionFull,
                    ),

                  // 不让他看我
                  if (chatOnly == false) ...[
                    // 隐藏我的朋友圈、状态
                    VigaFunctionList(
                      title: VigaAlphabet(
                        title: l10n.momentsAndStatus,
                      ),
                      children: [
                        VigaFunctionItem(
                          icon: "$cdnBase/avatar/02.png",
                          title: l10n.hideMyPosts,
                          // link: '',
                          underline: true,
                          tapEffect: false,
                          showStyle: Expanded(
                            flex: 0,
                            child: Container(
                              margin: const EdgeInsets.only(right: 32).w,
                              child: VigaSwitch(
                                initialValue: true,
                                onChanged: (value) {
                                  logger.info(value);
                                },
                              ),
                            ),
                          ),
                        ),
                        VigaFunctionItem(
                          icon: "$cdnBase/avatar/02.png",
                          title: l10n.hideTheirPosts,
                          // link: '',
                          underline: false,
                          tapEffect: false,
                          showStyle: Expanded(
                            flex: 0,
                            child: Container(
                              margin: const EdgeInsets.only(right: 32).w,
                              child: VigaSwitch(
                                initialValue: true,
                                onChanged: (value) {
                                  logger.info(value);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 100.w)
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
