import 'package:vigaviga/widgets/ljn_app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';

class LJNUserinfoPage extends StatefulWidget {
  const LJNUserinfoPage({super.key});

  @override
  State<LJNUserinfoPage> createState() => _LJNUserinfoPage();
}

class _LJNUserinfoPage extends State<LJNUserinfoPage> {
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
    String cdnBase = systemState.cdnBase;

    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: l10n.personalInfo,
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
                // 用户信息
                LJNFunctionList(children: [
                  // 头像
                  LJNFunctionItem(
                    icon: "$cdnBase/avatar/02.png",
                    title: l10n.avatar,
                    height: 150.w,
                    link: '',
                    showStyle: Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10).w,
                            child: LJNAppNetworkImage(
                              imageUrl: (context
                                  .read<LJNUserCubit>()
                                  .state
                                  .userinfoAvatar!),
                              width: 120.w,
                              height: 120.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    underline: true,
                  ),

                  // 姓名
                  LJNFunctionItem(
                    icon: "$cdnBase/avatar/02.png",
                    title: l10n.nickName,
                    // icon: "$cdnBase/icon/discovery_icon2.png",
                    link: '',
                    showStyle: context.read<LJNUserCubit>().state.userinfoName!,
                    underline: true,
                  ),

                  // 拍一拍
                  LJNFunctionItem(
                    icon: "$cdnBase/avatar/02.png",
                    title: l10n.pat,
                    link: '',
                    underline: true,
                  ),

                  // Vigaviga号
                  LJNFunctionItem(
                    icon: "$cdnBase/avatar/02.png",
                    title: l10n.vigavigaID,
                    link: '/settings/account_info',
                    showStyle:
                        context.read<LJNUserCubit>().state.userinfoAccount,
                    underline: true,
                  ),

                  // 二维码名片
                  LJNFunctionItem(
                    icon: "$cdnBase/avatar/02.png",
                    title: l10n.qrCodeCard,
                    link: '',
                    showStyle: Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            const IconData(
                              0xe74b,
                              fontFamily: 'Iconfont',
                            ),
                            size: 30.w,
                            color: AppColors.neutralGrey45,
                          ),
                        ],
                      ),
                    ),
                    underline: true,
                  ),

                  // 更多信息
                  LJNFunctionItem(
                    icon: "$cdnBase/avatar/02.png",
                    title: l10n.moreInfo,
                    link: '/user/more_info',
                    underline: false,
                  ),
                ]),

                // 来电铃声
                LJNFunctionList(children: [
                  // 来电铃声
                  LJNFunctionItem(
                    icon: "$cdnBase/avatar/02.png",
                    title: l10n.callRingtone,
                    link: '',
                    showStyle: 'SISTER  - JAVA',
                    underline: false,
                  ),
                ]),

                // Vigaviga豆
                LJNFunctionList(children: [
                  // Vigaviga豆
                  LJNFunctionItem(
                    icon: "$cdnBase/avatar/02.png",
                    title: l10n.vigavigaBeans,
                    link: '',
                    showStyle: l10n.vigavigaBeanCount(3),
                    underline: false,
                  ),
                ]),

                // 我的地址
                LJNFunctionList(
                  children: [
                    // 我的地址
                    LJNFunctionItem(
                      icon: "$cdnBase/avatar/02.png",
                      title: l10n.myAddresses,
                      link: '',
                      underline: true,
                    ),

                    // 我的发票抬头
                    LJNFunctionItem(
                      icon: "$cdnBase/avatar/02.png",
                      title: l10n.myInvoiceTitles,
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
  }
}
