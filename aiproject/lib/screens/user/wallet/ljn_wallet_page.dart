import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

class LJNWalletPage extends StatefulWidget {
  const LJNWalletPage({super.key});

  @override
  State<LJNWalletPage> createState() => _LJNWalletPage();
}

class _LJNWalletPage extends State<LJNWalletPage> {
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
        title: l10n.wallet,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/user/wallet/bill_details');
            },
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(right: 40.w),
              alignment: Alignment.center,
              child: Text(
                l10n.bill,
                style: TextStyle(
                  // height: 1.08,
                  color: theme.colorScheme.onSurface,
                  fontSize: fontSizeScale(32.w),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              (90.0.w + systemState.statusHeight),
        ),
        color: theme.colorScheme.surfaceContainer,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                // 余额、余额宝、银行卡、扫一扫
                LJNFunctionList(
                  children: [
                    // 余额
                    LJNFunctionItem(
                      title: l10n.balance,
                      icon: "images/icon/discovery_icon1.png",
                      link: '/pocketmoney',
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
                                        .read<LJNUserCubit>()
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
                    LJNFunctionItem(
                      title: l10n.balancePlus,
                      icon: "images/icon/discovery_icon2.png",
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
                                        .read<LJNUserCubit>()
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
                      underline: true,
                    ),

                    // 银行卡
                    LJNFunctionItem(
                      title: l10n.bankCards,
                      icon: "images/icon/discovery_icon3.png",
                      link: '',
                      underline: true,
                    ),

                    // 扫一扫、听一听
                    LJNFunctionItem(
                      title: l10n.familyCard,
                      icon: "images/icon/discovery_icon4.png",
                      link: '',
                      underline: false,
                    ),
                  ],
                ),

                // 支付分
                LJNFunctionList(
                  children: [
                    LJNFunctionItem(
                      title: l10n.paymentScore,
                      icon: "images/icon/discovery_icon5.png",
                      link: '',
                      underline: false,
                    ),
                  ],
                ),

                // 消费者保护
                LJNFunctionList(
                  children: [
                    LJNFunctionItem(
                      title: l10n.consumerProtection,
                      icon: "images/icon/discovery_icon6.png",
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
