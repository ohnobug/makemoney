import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_alphabet.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_special_function_item.dart';
import 'package:vigaviga/widgets/viga_switch.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';

class VigaFriendPermissionPage extends StatefulWidget {
  const VigaFriendPermissionPage({super.key});

  @override
  State<VigaFriendPermissionPage> createState() => _VigaFriendPermissionPage();
}

class _VigaFriendPermissionPage extends State<VigaFriendPermissionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
          return Scaffold(
            primary: false,
            appBar: VigaAppBar(
              title: l10n.friendPermissions,
            ),
            body: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        systemState.appbarHeight -
                        systemState.statusHeight),
                color: theme.colorScheme.surfaceContainer,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: Column(
                    children: [
                      // 添加好友时需要验证
                      VigaFunctionList(children: [
                        // 添加好友时需要验证
                        VigaFunctionItem(
                          icon: null,
                          title: l10n.requireVerificationWhenAdded,
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
                      ]),

                      VigaFunctionList(
                        children: [
                          // 加我的方式
                          VigaFunctionItem(
                            icon: null,
                            title: l10n.waysToAddMe,
                            link: '',
                            underline: true,
                          ),
                          // 通过手机号找到我
                          VigaSpecialFunctionItem(
                            title: l10n.recommendContactsToMe,
                            tapEffect: false,
                            underline: false,
                            height: null,
                            // link: '',
                            subTitle: Text(
                              l10n.recommendContactsMessageFull,
                              maxLines: 5,
                              style: TextStyle(
                                color: AppColors.neutralGrey37,
                                fontSize: 28.w,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            showStyle: VigaSwitch(
                              initialValue: false,
                              onChanged: (value) {
                                logger.info(value);
                              },
                            ),
                          ),
                        ],
                      ),

                      // 只聊天、朋友圈、频道、看一看、Vigaviga运动、通讯录黑名单
                      VigaFunctionList(
                        title: VigaAlphabet(title: l10n.friendPermissions),
                        children: [
                          // 只聊天
                          VigaFunctionItem(
                            icon: null,
                            title: l10n.chatOnly,
                            link: '',
                            underline: true,
                          ),

                          // 朋友圈
                          VigaFunctionItem(
                            icon: null,
                            title: l10n.moments,
                            link: '',
                            underline: true,
                          ),
                        ],
                      ),

                      // 通讯录黑名单
                      VigaFunctionList(
                        children: [
                          // 通讯录黑名单
                          VigaFunctionItem(
                            icon: null,
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
      ),
    );
  }
}
