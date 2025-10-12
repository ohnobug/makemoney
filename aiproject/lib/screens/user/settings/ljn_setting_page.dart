import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_alphabet.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';
import 'package:vigaviga/widgets/ljn_max_width_button.dart';

class LJNSettingPage extends StatefulWidget {
  const LJNSettingPage({super.key});

  @override
  State<LJNSettingPage> createState() => _LJNSettingPage();
}

class _LJNSettingPage extends State<LJNSettingPage> {
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
            title: l10n.settings,
          ),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
                    // 账户与安全
                    LJNFunctionList(children: [
                      LJNFunctionItem(
                        icon: "images/icon/settings_03.png",
                        title: l10n.accountAndSecurityTitle,
                        link: '/settings/account_and_secure',
                        underline: false,
                      ),
                    ]),

                    // // 青少年模式 与 关怀模式
                    // LJNFunctionList(children: [
                    //   LJNFunctionItem(
                    //     title: l10n.youthMode,
                    //     link: '/teenage_mode',
                    //     underline: true,
                    //   ),
                    //   LJNFunctionItem(
                    //     title: l10n.caringMode,
                    //     link: '/care_mode',
                    //     underline: false,
                    //   ),
                    // ]),

                    // 语言设置
                    LJNFunctionList(children: [
                      LJNFunctionItem(
                        icon: "images/icon/settings_01.png",
                        title: l10n.languageSetting,
                        link: '/settings/language_setting',
                        underline: true,
                      ),
                      // 主题设置
                      LJNFunctionItem(
                        icon: "images/icon/settings_02.png",
                        title: l10n.themeSetting,
                        link: '/settings/theme_setting',
                        underline: false,
                      ),
                    ]),

                    // 新消息通知 与 聊天 和 通用
                    LJNFunctionList(children: [
                      LJNFunctionItem(
                        icon: "images/icon/settings_10.png",
                        title: l10n.newMessageNotifications,
                        link: '/settings/new_message_notification',
                        underline: true,
                      ),
                      LJNFunctionItem(
                        icon: "images/icon/settings_04.png",
                        title: l10n.chat,
                        link: '/settings/chat_setting',
                        underline: true,
                      ),
                      LJNFunctionItem(
                        icon: "images/icon/settings_05.png",
                        title: l10n.general,
                        link: '/settings/common_setting',
                        underline: false,
                      ),
                    ]),

                    // 朋友权限 与 个人信息与权限 和 个人信息收集清单 和 第三方信息共享清单
                    LJNFunctionList(
                      title: LJNAlphabet(title: l10n.privacy),
                      children: [
                        LJNFunctionItem(
                          icon: "images/icon/settings_06.png",
                          title: l10n.friendPermissions,
                          link: '/settings/friend_permission',
                          underline: true,
                        ),
                        LJNFunctionItem(
                          icon: "images/icon/settings_07.png",
                          title: l10n.personalInfoAndPermissions,
                          link: '/settings/personinfo_and_permission',
                          underline: true,
                        ),
                        LJNFunctionItem(
                          icon: "images/icon/settings_11.png",
                          title: l10n.personalInfoCollectionList,
                          link: '/settings/personalinfo_collection_checklist',
                          underline: true,
                        ),
                        LJNFunctionItem(
                          icon: "images/icon/settings_09.png",
                          title: l10n.thirdPartyInfoSharingList,
                          link:
                              "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing')}",
                          underline: false,
                        ),
                      ],
                    ),

                    // // 插件
                    // LJNFunctionList(
                    //   children: [
                    //     LJNFunctionItem(
                    //       title: Row(
                    //         children: [
                    //           SizedBox(
                    //             width: 30.w,
                    //           ),
                    //           Text(
                    //             l10n.plugins,
                    //             style: TextStyle(
                    //               height: 1.08,
                    //               fontSize: fontSizeScale(32.0.w),
                    //               fontFamily: "AlibabaPuHuiTi",
                    //             ),
                    //             maxLines: 1,
                    //             overflow: TextOverflow.visible,
                    //           ),
                    //           Icon(
                    //             const IconData(
                    //               0xe610,
                    //               fontFamily: 'Iconfont',
                    //             ), // 使用的图标
                    //             color: theme.colorScheme.onSurface, // 图标颜色
                    //             size: 36.w, // 图标大小
                    //           )
                    //         ],
                    //       ),
                    //       link: '',
                    //       showStyle: l10n.vigavigaKeyboardFeatureAskAI,
                    //       underline: false,
                    //     )
                    //   ],
                    // ),

                    // 关于Vigaviga 与 帮助与反馈
                    LJNFunctionList(
                      children: [
                        LJNFunctionItem(
                          icon: "images/icon/settings_13.png",
                          title: l10n.aboutVigaviga,
                          link: '/settings/about',
                          underline: true,
                        ),
                        LJNFunctionItem(
                          icon: "images/icon/settings_12.png",
                          title: l10n.helpAndFeedback,
                          link: '/ljn_help and_feedback',
                          underline: false,
                        ),
                      ],
                    ),

                    // 切换账号
                    LJNFunctionList(children: [
                      LJNMaxWidthButton(
                        title: l10n.switchAccount,
                        link: '',
                        underline: false,
                      ),
                    ]),

                    // 退出登录
                    LJNFunctionList(
                      children: [
                        LJNMaxWidthButton(
                          title: l10n.logout,
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
