import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/screens/components/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import '../components/ljn_function_item.dart';
import '../components/ljn_max_width_button.dart';

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
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false,
          appBar: LJNAppBar(
            title: AppLocalizations.of(context)!.settings,
          ),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      90.w -
                      systemState.statusHeight),
              color: Theme.of(context).colorScheme.surface,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    // 账户与安全
                    LJNFunctionItem(
                      title:
                          AppLocalizations.of(context)!.accountAndSecurityTitle,
                      link: '/account_and_secure',
                      underline: false,
                    ),

                    SizedBox(height: 16.w),

                    // 青少年模式 与 关怀模式
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.youthMode,
                      link: '/teenage_mode',
                      underline: true,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.caringMode,
                      link: '/care_mode',
                      underline: false,
                    ),
                    SizedBox(height: 16.w),

                    // 语言设置
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.languageSetting,
                      link: '/language_setting',
                      underline: true,
                    ),
                    // 主题设置
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.themeSetting,
                      link: '/theme_setting',
                      underline: false,
                    ),

                    SizedBox(height: 16.w),

                    // 新消息通知 与 聊天 和 通用
                    LJNFunctionItem(
                      title:
                          AppLocalizations.of(context)!.newMessageNotifications,
                      link: '/new_message_notification',
                      underline: true,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.chat,
                      link: '/chat_setting',
                      underline: true,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.general,
                      link: '/common_setting',
                      underline: false,
                    ),
                    // SizedBox(height: 16.w),
                    SizedBox(height: 16.w),

                    Container(
                      alignment: Alignment.centerLeft,
                      height: 64.w,
                      padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
                      child: Text(
                        AppLocalizations.of(context)!.privacy,
                        style: TextStyle(fontSize: 25.w, height: 1.08),
                      ),
                    ),

                    // 朋友权限 与 个人信息与权限 和 个人信息收集清单 和 第三方信息共享清单
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.friendPermissions,
                      link: '/friend_permission',
                      underline: true,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!
                          .personalInfoAndPermissions,
                      link: '/personinfo_and_permission',
                      underline: true,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!
                          .personalInfoCollectionList,
                      link: '/personalinfo_collection_checklist',
                      underline: true,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!
                          .thirdPartyInfoSharingList,
                      link:
                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing')}",
                      underline: false,
                    ),

                    SizedBox(height: 16.w),

                    LJNFunctionItem(
                      title: Row(
                        children: [
                          SizedBox(
                            width: 30.w,
                          ),
                          Text(
                            AppLocalizations.of(context)!.plugins,
                            style: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(32.0.w),
                              fontFamily: "AlibabaPuHuiTi",
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                          ),
                          Icon(
                            const IconData(
                              0xe610,
                              fontFamily: 'Iconfont',
                            ), // 使用的图标
                            color: AppColors.neutralBlack, // 图标颜色
                            size: 36.w, // 图标大小
                          )
                        ],
                      ),
                      link: '',
                      showStyle: AppLocalizations.of(context)!
                          .wechatKeyboardFeatureAskAI,
                      underline: false,
                    ),

                    SizedBox(height: 16.w),

                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.aboutWeChat,
                      link: '/about',
                      underline: true,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.helpAndFeedback,
                      link: '',
                      underline: false,
                    ),
                    SizedBox(height: 16.w),

                    LJNMaxWidthButton(
                      title: AppLocalizations.of(context)!.switchAccount,
                      link: '',
                      underline: false,
                    ),
                    SizedBox(height: 16.w),

                    LJNMaxWidthButton(
                      title: AppLocalizations.of(context)!.logout,
                      link: '',
                      underline: false,
                    ),
                    SizedBox(height: 106.w),
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
