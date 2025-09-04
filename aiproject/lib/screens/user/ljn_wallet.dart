import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import '../../widgets/ljn_function_item.dart';
import '../../tools/ljn_tools.dart';

class LJNWallet extends StatefulWidget {
  const LJNWallet({super.key});

  @override
  State<LJNWallet> createState() => _LJNWallet();
}

class _LJNWallet extends State<LJNWallet> {
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
    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: AppLocalizations.of(context)!.wallet,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/bill_details');
            },
            child: Container(
              color: AppColors.transparent,
              padding: EdgeInsets.only(right: 40.w),
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.bill,
                style: TextStyle(
                  // height: 1.08,
                  color: Theme.of(context).colorScheme.onSurface,
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
        color: Theme.of(context).colorScheme.surface,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                // 余额
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.balance,
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
                                alignment:
                                    PlaceholderAlignment.middle, // 使图标与文本垂直居中对齐
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
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "LJNFont",
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

                // 视频号、直播
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.balancePlus,
                  icon: "images/icon/discovery_icon2.png",
                  link: '',
                  showStyle: SizedBox(
                    width: 480.w,
                    // color: AppColors.accentRedPure,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .label_yield("1.64%"),
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
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "LJNFont",
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          )
                        ]),
                  ),
                  underline: true,
                ),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.bankCards,
                  icon: "images/icon/discovery_icon3.png",
                  link: '',
                  underline: true,
                ),

                // 扫一扫、听一听
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.familyCard,
                  icon: "images/icon/discovery_icon4.png",
                  link: '',
                  underline: false,
                ),

                SizedBox(height: 16.w),

                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.paymentScore,
                  icon: "images/icon/discovery_icon5.png",
                  link: '',
                  underline: false,
                ),
                SizedBox(height: 16.w),

                // 消费者保护
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.consumerProtection,
                  icon: "images/icon/discovery_icon6.png",
                  link: '',
                  underline: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
