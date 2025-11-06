import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';
import 'package:vigaviga/widgets/viga_alphabet.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';
import 'package:vigaviga/widgets/viga_max_width_button.dart';

class VigaSettingPage extends StatefulWidget {
  const VigaSettingPage({super.key});

  @override
  State<VigaSettingPage> createState() => _VigaSettingPage();
}

class _VigaSettingPage extends State<VigaSettingPage> {
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
        // String cdnBase = systemState.cdnBase;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            primary: false,
            appBar: VigaAppBar(
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
                      VigaFunctionList(children: [
                        VigaFunctionItem(
                          icon: const IconData(
                            0xe69d,
                            fontFamily: 'Iconfont',
                          ),
                          backgroundColor: Colors.white,
                          iconBackgroundColor:
                              const Color(0xFF4DB6AC), // 充满活力的青色
                          title: l10n.accountAndSecurityTitle,
                          link: '/settings/account_and_secure',
                          underline: false,
                        ),
                      ]),

                      // 语言设置
                      VigaFunctionList(children: [
                        VigaFunctionItem(
                          icon: const IconData(
                            0xe651,
                            fontFamily: 'Iconfont',
                          ),
                          iconBackgroundColor: const Color(0xFF42A5F5), // 清晰的蓝色
                          title: l10n.languageSetting,
                          link: '/settings/language_setting',
                          underline: true,
                        ),
                        // 主题设置
                        VigaFunctionItem(
                          icon: const IconData(
                            0xe65c,
                            fontFamily: 'Iconfont',
                          ),
                          iconBackgroundColor:
                              const Color(0xFFEC407A), // 鲜艳的玫瑰粉
                          title: l10n.themeSetting,
                          link: '/settings/theme_setting',
                          underline: false,
                        ),
                      ]),

                      // 新消息通知 与 聊天 和 通用
                      VigaFunctionList(children: [
                        VigaFunctionItem(
                          icon: const IconData(
                            0xe8c0,
                            fontFamily: 'Iconfont',
                          ),
                          iconBackgroundColor: const Color(0xFFFFA726), // 醒目的橙色
                          title: l10n.newMessageNotifications,
                          link: '/settings/new_message_notification',
                          underline: true,
                        ),
                        VigaFunctionItem(
                          icon: const IconData(
                            0xe970,
                            fontFamily: 'Iconfont',
                          ),
                          iconBackgroundColor:
                              const Color(0xFF26C6DA), // 明快的青蓝色
                          title: l10n.chat,
                          link: '/settings/chat_setting',
                          underline: true,
                        ),
                        VigaFunctionItem(
                          icon: const IconData(
                            0xe63d,
                            fontFamily: 'Iconfont',
                          ),
                          iconBackgroundColor: const Color(0xFF7E57C2), // 深邃的紫色
                          title: l10n.general,
                          link: '/settings/common_setting',
                          underline: false,
                        ),
                      ]),

                      // 朋友权限 与 个人信息与权限 和 个人信息收集清单 和 第三方信息共享清单
                      VigaFunctionList(
                        title: VigaAlphabet(title: l10n.privacy),
                        children: [
                          VigaFunctionItem(
                            icon: const IconData(
                              0xe650,
                              fontFamily: 'Iconfont',
                            ),
                            iconBackgroundColor:
                                const Color(0xFFFFCA28), // 温暖的琥珀色
                            title: l10n.friendPermissions,
                            link: '/settings/friend_permission',
                            underline: true,
                          ),
                          VigaFunctionItem(
                            icon: const IconData(
                              0xe653,
                              fontFamily: 'Iconfont',
                            ),
                            iconBackgroundColor:
                                const Color(0xFF7986CB), // 沉稳的靛蓝色
                            title: l10n.personalInfoAndPermissions,
                            link: '/settings/personinfo_and_permission',
                            underline: true,
                          ),
                          VigaFunctionItem(
                            icon: const IconData(
                              0xe64a,
                              fontFamily: 'Iconfont',
                            ),
                            iconBackgroundColor:
                                const Color(0xFF66BB6A), // 友好的绿色
                            title: l10n.personalInfoCollectionList,
                            link: '/settings/personalinfo_collection_checklist',
                            underline: true,
                          ),
                          VigaFunctionItem(
                            icon: const IconData(
                              0xe73a,
                              fontFamily: 'Iconfont',
                            ),
                            iconBackgroundColor:
                                const Color(0xFFFF7043), // 活泼的深橙色
                            title: l10n.thirdPartyInfoSharingList,
                            link:
                                "/open_miniprogram?cid=bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
                            underline: false,
                          ),
                        ],
                      ),

                      // 关于Vigaviga 与 帮助与反馈
                      VigaFunctionList(
                        children: [
                          VigaFunctionItem(
                            icon: const IconData(
                              0xe647,
                              fontFamily: 'Iconfont',
                            ),
                            iconBackgroundColor:
                                const Color(0xFF78909C), // 专业的中性蓝灰色
                            title: l10n.aboutVigaviga,
                            link: '/settings/about',
                            underline: true,
                          ),
                          VigaFunctionItem(
                            icon: const IconData(
                              0xe646,
                              fontFamily: 'Iconfont',
                            ),
                            iconBackgroundColor:
                                const Color(0xFF26A69A), // 沉静的蓝绿色
                            title: l10n.helpAndFeedback,
                            link: null,
                            onPress: () {
                              context.push(
                                '/webview',
                                extra: {
                                  'url':
                                      'https://help.vigaviga.com', // Vue开发服务器地址
                                  'title': l10n.helpAndFeedback,
                                },
                              );
                            },
                            underline: false,
                          ),
                        ],
                      ),

                      // 根据登录状态显示不同的按钮
                      BlocBuilder<VigaUserCubit, UserState>(
                        builder: (context, userState) {
                          if (userState.isLoggedIn) {
                            // 已登录状态：显示切换账号和退出登录
                            return Column(
                              children: [
                                // 切换账号
                                VigaFunctionList(children: [
                                  VigaMaxWidthButton(
                                    title: l10n.switchAccount,
                                    link: '/user/auth/switch_account',
                                    underline: false,
                                  ),
                                ]),

                                // 退出登录
                                VigaFunctionList(
                                  children: [
                                    VigaMaxWidthButton(
                                      title: l10n.logout,
                                      link: null,
                                      underline: false,
                                      onPressed: () {
                                        context.read<VigaUserCubit>().logout();
                                        context
                                            .read<VigaSystemCubit>()
                                            .updateMainTabIndex(4);
                                        context.go('/');
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            // 未登录状态：显示登录按钮
                            return VigaFunctionList(
                              children: [
                                VigaMaxWidthButton(
                                  title: '登录/注册',
                                  link: null,
                                  underline: false,
                                  onPressed: () {
                                    context.push('/user/auth/login');
                                  },
                                ),
                              ],
                            );
                          }
                        },
                      ),

                      SizedBox(height: 100.w)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
