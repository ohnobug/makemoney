import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import '../../widgets/ljn_function_item.dart';

class LJNUserinfo extends StatefulWidget {
  const LJNUserinfo({super.key});

  @override
  State<LJNUserinfo> createState() => _LJNUserinfo();
}

class _LJNUserinfo extends State<LJNUserinfo> {
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
                  90.w -
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
                    icon: "images/avatar/02.png",
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
                            child: Image.asset(
                              assetPath(context
                                  .read<LJNUserCubit>()
                                  .state
                                  .userinfoAvatar!),
                              cacheWidth: 240.w.toInt(),
                              cacheHeight: 240.w.toInt(),
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
                    icon: "images/avatar/02.png",
                    title: l10n.nickName,
                    // icon: "images/icon/discovery_icon2.png",
                    link: '',
                    showStyle: context.read<LJNUserCubit>().state.userinfoName!,
                    underline: true,
                  ),

                  // 拍一拍
                  LJNFunctionItem(
                    icon: "images/avatar/02.png",
                    title: l10n.pat,
                    link: '',
                    underline: true,
                  ),

                  // Vigaviga号
                  LJNFunctionItem(
                    icon: "images/avatar/02.png",
                    title: l10n.vigavigaID,
                    link: '/accountinfo',
                    showStyle:
                        context.read<LJNUserCubit>().state.userinfoAccount,
                    underline: true,
                  ),

                  // 二维码名片
                  LJNFunctionItem(
                    icon: "images/avatar/02.png",
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
                    icon: "images/avatar/02.png",
                    title: l10n.moreInfo,
                    link: '/user_more_info',
                    underline: false,
                  ),
                ]),

                // 来电铃声
                LJNFunctionList(children: [
                  // 来电铃声
                  LJNFunctionItem(
                    icon: "images/avatar/02.png",
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
                    icon: "images/avatar/02.png",
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
                      icon: "images/avatar/02.png",
                      title: l10n.myAddresses,
                      link: '',
                      underline: true,
                    ),

                    // 我的发票抬头
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
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
