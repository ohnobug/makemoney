import 'package:vigaviga/widgets/viga_app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';

class VigaUserinfoPage extends StatefulWidget {
  const VigaUserinfoPage({super.key});

  @override
  State<VigaUserinfoPage> createState() => _VigaUserinfoPage();
}

class _VigaUserinfoPage extends State<VigaUserinfoPage> {
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
    String cdnBase = systemState.cdnBase;

    return Scaffold(
      primary: false,
      appBar: VigaAppBar(
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
                VigaFunctionList(children: [
                  // 头像
                  VigaFunctionItem(
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
                            child: VigaAppNetworkImage(
                              imageUrl: (context
                                  .read<VigaUserCubit>()
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
                  VigaFunctionItem(
                    icon: "$cdnBase/avatar/02.png",
                    title: l10n.nickName,
                    // icon: "$cdnBase/icon/discovery_icon2.png",
                    link: '',
                    showStyle: context.read<VigaUserCubit>().state.userinfoName!,
                    underline: true,
                  ),

                  // 拍一拍
                  VigaFunctionItem(
                    icon: "$cdnBase/avatar/02.png",
                    title: l10n.pat,
                    link: '',
                    underline: true,
                  ),

                  // Vigaviga号
                  VigaFunctionItem(
                    icon: "$cdnBase/avatar/02.png",
                    title: l10n.vigavigaID,
                    link: '/settings/account_info',
                    showStyle:
                        context.read<VigaUserCubit>().state.userinfoAccount,
                    underline: true,
                  ),

                  // 二维码名片
                  VigaFunctionItem(
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
                  VigaFunctionItem(
                    icon: "$cdnBase/avatar/02.png",
                    title: l10n.moreInfo,
                    link: '/user/more_info',
                    underline: false,
                  ),
                ]),

                // 来电铃声
                VigaFunctionList(children: [
                  // 来电铃声
                  VigaFunctionItem(
                    icon: "$cdnBase/avatar/02.png",
                    title: l10n.callRingtone,
                    link: '',
                    showStyle: 'SISTER  - JAVA',
                    underline: false,
                  ),
                ]),

                // Vigaviga豆
                VigaFunctionList(children: [
                  // Vigaviga豆
                  VigaFunctionItem(
                    icon: "$cdnBase/avatar/02.png",
                    title: l10n.vigavigaBeans,
                    link: '',
                    showStyle: l10n.vigavigaBeanCount(3),
                    underline: false,
                  ),
                ]),

                // 我的地址
                VigaFunctionList(
                  children: [
                    // 我的地址
                    VigaFunctionItem(
                      icon: "$cdnBase/avatar/02.png",
                      title: l10n.myAddresses,
                      link: '',
                      underline: true,
                    ),

                    // 我的发票抬头
                    VigaFunctionItem(
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
