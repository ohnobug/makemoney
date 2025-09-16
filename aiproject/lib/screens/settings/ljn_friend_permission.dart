import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_alphabet.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_special_function_item.dart';
import 'package:vigaviga/widgets/ljn_switch.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';

class LJNFriendPermission extends StatefulWidget {
  const LJNFriendPermission({super.key});

  @override
  State<LJNFriendPermission> createState() => _LJNFriendPermission();
}

class _LJNFriendPermission extends State<LJNFriendPermission> {
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
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      90.w -
                      systemState.statusHeight),
              color: theme.colorScheme.surfaceContainer,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    // 添加好友时需要验证
                    LJNFunctionList(children: [
                      // 添加好友时需要验证
                      LJNFunctionItem(
                        title: l10n.requireVerificationWhenAdded,
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
                    ]),

                    LJNFunctionList(
                      children: [
                        // 加我的方式
                        LJNFunctionItem(
                          title: l10n.waysToAddMe,
                          link: '',
                          underline: true,
                        ),
                        // 通过手机号找到我
                        LJNSpecialFunctionItem(
                          title: l10n.recommendContactsToMe,
                          tapEffect: false,
                          underline: false,
                          height: null,
                          // link: '',
                          subTitle: Text(
                            l10n.recommendContactsMessageFull,
                            maxLines: 3,
                            style: TextStyle(
                              color: AppColors.neutralGrey35,
                              fontSize: 24.w,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: "AlibabaPuHuiTi",
                            ),
                          ),
                          showStyle: Expanded(
                            flex: 0,
                            child: Container(
                              margin: const EdgeInsets.only(right: 32).w,
                              child: LJNSwitch(
                                initialValue: false,
                                onChanged: (value) {
                                  logger.info(value);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 只聊天、朋友圈、频道、看一看、微信运动、通讯录黑名单
                    LJNFunctionList(
                      title: LJNAlphabet(title: l10n.friendPermissions),
                      children: [
                        // 只聊天
                        LJNFunctionItem(
                          title: l10n.chatOnly,
                          link: '',
                          underline: true,
                        ),

                        // 朋友圈
                        LJNFunctionItem(
                          title: l10n.moments,
                          link: '',
                          underline: true,
                        ),

                        // 频道
                        LJNFunctionItem(
                          title: l10n.channels,
                          link: '',
                          underline: true,
                        ),

                        // 看一看
                        LJNFunctionItem(
                          title: l10n.look,
                          link: '',
                          underline: true,
                        ),

                        // 微信运动
                        LJNFunctionItem(
                          title: l10n.weRun,
                          link: '',
                          underline: false,
                        ),
                      ],
                    ),

                    // 通讯录黑名单
                    LJNFunctionList(
                      children: [
                        // 通讯录黑名单
                        LJNFunctionItem(
                          title: l10n.contactsBlocklist,
                          link: '',
                          underline: false,
                        ),
                      ],
                    ),

                    SizedBox(height: 100.w)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
