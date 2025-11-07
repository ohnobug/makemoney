import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';
import 'package:vigaviga/tools/viga_tools.dart';

class VigaWalletPage extends StatefulWidget {
  const VigaWalletPage({super.key});

  @override
  State<VigaWalletPage> createState() => _VigaWalletPage();
}

class _VigaWalletPage extends State<VigaWalletPage> {
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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        primary: false,
        appBar: VigaAppBar(
          title: l10n.wallet,
          actions: [
            VigaAppBarActionTextButton(
              onTap: () {
                context.push('/user/wallet/bill_details');
              },
              title: l10n.bill,
            ),
          ],
        ),
        body: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                (90.0.w + systemState.statusHeight),
          ),
          color: theme.colorScheme.surfaceContainer,
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                children: [
                  // 余额、余额宝、银行卡、扫一扫
                  VigaFunctionList(
                    children: [
                      // 余额
                      VigaFunctionItem(
                        title: l10n.balance,
                        icon: "$cdnBase/icon/discovery_icon1.png",
                        link: '/user/pocketmoney',
                        showStyle: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 22.w,
                                        child: Icon(
                                          const IconData(
                                            0xe90d,
                                            fontFamily: 'Iconfont',
                                          ),
                                          size: 25.w, // 图标大小
                                        ),
                                      ),
                                      alignment: PlaceholderAlignment
                                          .middle, // 使图标与文本垂直居中对齐
                                    ),
                                    TextSpan(
                                      text: context
                                          .read<VigaUserCubit>()
                                          .state
                                          .walletBalance
                                          .toString(),
                                      style: TextStyle(
                                        height: 1.08,
                                        fontSize: fontSizeScale(29.w),
                                        color: theme.colorScheme.onSurface,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        underline: true,
                      ),

                      // 余额宝
                      VigaFunctionItem(
                        title: l10n.balancePlus,
                        icon: "$cdnBase/icon/discovery_icon2.png",
                        link: '',
                        showStyle: SizedBox(
                          width: 380.w,
                          // color: AppColors.accentRedPure,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: l10n.label_yield("1.64%"),
                                      style: TextStyle(
                                        height: 1.08,
                                        fontSize: fontSizeScale(23.w),
                                        color: AppColors.accentOrangeDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 22.w,
                                        child: Icon(
                                          const IconData(
                                            0xe90d,
                                            fontFamily: 'Iconfont',
                                          ),
                                          size: 25.w, // 图标大小
                                        ),
                                      ),
                                      alignment: PlaceholderAlignment
                                          .middle, // 使图标与文本垂直居中对齐
                                    ),
                                    TextSpan(
                                      text: context
                                          .read<VigaUserCubit>()
                                          .state
                                          .walletFoundationBalance
                                          .toString(),
                                      style: TextStyle(
                                        height: 1.08,
                                        fontSize: fontSizeScale(29.w),
                                        color: theme.colorScheme.onSurface,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        underline: false,
                      ),
                    ],
                  ),

                  VigaFunctionList(
                    children: [
                      // 银行卡
                      VigaFunctionItem(
                        title: l10n.bankCards,
                        icon: "$cdnBase/icon/discovery_icon3.png",
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
      ),
    );
  }
}
