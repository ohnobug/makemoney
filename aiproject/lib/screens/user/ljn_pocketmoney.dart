import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/screens/components/ljn_appbar.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

class LJNPocketMoney extends StatefulWidget {
  const LJNPocketMoney({super.key});

  @override
  State<LJNPocketMoney> createState() => _LJNPocketMoney();
}

class _LJNPocketMoney extends State<LJNPocketMoney> {
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
            title: "",
            // leading: Container(),
            // color: AppColors.transparent,
            // bgColor: AppColors.transparent,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/change_details');
                },
                child: Container(
                  color: AppColors.transparent,
                  height: 90.w,
                  padding: EdgeInsets.only(right: 40.w),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.balanceDetails,
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.neutralBlack, fontSize: 32.w),
                  ),
                ),
              )
            ],
          ),
          body: SizedBox(
            width: 750.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 90.w,
                ),
                Container(
                  height: 100.w,
                  width: 100.w,
                  decoration: const BoxDecoration(
                    color: AppColors.accentYellowDark1,
                    shape: BoxShape.circle, // 设置为圆形
                  ),
                  child: Icon(
                    const IconData(
                      0xe640,
                      fontFamily: 'Iconfont',
                    ),
                    color: AppColors.neutralWhite,
                    size: 46.w,
                  ),
                ),
                SizedBox(
                  height: 78.w,
                ),
                Text(
                  AppLocalizations.of(context)!.myBalance,
                  style: TextStyle(
                    height: 1.08,
                    fontSize: fontSizeScale(32.w),
                    fontFamily: "AlibabaPuHuiTi-Medium",
                    color: AppColors.neutralNearBlack4,
                  ),
                ),
                SizedBox(
                  height: 30.w,
                ),
                // 余额
                Text.rich(
                  TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Baseline(
                          baseline: -7.5.w, // 根据文字的 fontSize 调整基线
                          baselineType: TextBaseline.alphabetic,
                          child: Icon(
                            const IconData(
                              0xe90d,
                              fontFamily: 'Iconfont',
                            ),
                            color: AppColors.neutralNearBlack4,
                            size: 55.w,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: context
                            .read<LJNUserCubit>()
                            .state
                            .walletBalance
                            .toString(),
                        style: TextStyle(
                          height: 1.08,
                          fontSize: fontSizeScale(85.w),
                          fontWeight: FontWeight.bold,
                          fontFamily: "LJNFont",
                          color: AppColors.neutralNearBlack4,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.w,
                ),
                Text(
                  AppLocalizations.of(context)!
                      .cta_transfer_to_balance_plus_single_line,
                  style: TextStyle(
                    height: 1.08,
                    color: AppColors.accentOrange,
                    fontSize: fontSizeScale(30.w),
                    fontFamily: "AlibabaPuHuiTi",
                  ),
                ),
                const Expanded(
                  flex: 490,
                  child: SizedBox(),
                ),

                LJNChargeButton(
                  title: AppLocalizations.of(context)!.topUp,
                  color: AppColors.neutralWhite,
                  backgroundColor: AppColors.brandGreenVibrant3,
                ),

                SizedBox(
                  height: 33.w,
                ),
                // ????????
                LJNChargeButton(
                  title: AppLocalizations.of(context)!.withdraw,
                ),

                const Expanded(
                  flex: 143,
                  child: SizedBox(),
                ),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.faq,
                      style: TextStyle(
                        height: 1.08,
                        color: AppColors.brandBlueDark4,
                        fontSize: fontSizeScale(25.w),
                        fontFamily: "AlibabaPuHuiTi-Medium",
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(
                        width: 10.w,
                      ),
                    ),
                    TextSpan(
                      text: " | ",
                      style: TextStyle(
                        height: 1.08,
                        color: AppColors.neutralGrey12,
                        fontSize: fontSizeScale(25.w),
                        fontFamily: "AlibabaPuHuiTi-Medium",
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(
                        width: 10.w,
                      ),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.accountUpgradeService,
                      style: TextStyle(
                        height: 1.08,
                        color: AppColors.brandBlueDark4,
                        fontSize: fontSizeScale(25.w),
                        fontFamily: "AlibabaPuHuiTi-Medium",
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 26.w,
                ),
                Text(
                  AppLocalizations.of(context)!
                      .serviceProvidedByTenpayAndWeBank,
                  style: TextStyle(
                    height: 1.08,
                    color: AppColors.neutralGrey46,
                    fontSize: fontSizeScale(23.w),
                    fontFamily: "AlibabaPuHuiTi-Medium",
                  ),
                ),
                SizedBox(
                  height: 50.w,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LJNChargeButton extends StatefulWidget {
  final String title;
  final Color? color;
  final Color? backgroundColor;
  final String? link;
  final bool? readonly;

  const LJNChargeButton({
    super.key,
    required this.title,
    this.color,
    this.backgroundColor,
    this.readonly,
    this.link,
  });

  @override
  State<LJNChargeButton> createState() => _LJNChargeButtonState();
}

class _LJNChargeButtonState extends State<LJNChargeButton> {
  // bool isClicked = false;
  late Color originContainerColor;
  late Color containerColor;
  @override
  void initState() {
    super.initState();

    // 判断是否有 backgroundColor，若没有，则使用默认颜色
    originContainerColor = widget.backgroundColor ?? AppColors.neutralGrey6;

    setState(() {
      containerColor = originContainerColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color fontColor = AppColors.neutralDarkGrey19;
    if (widget.color is Color) {
      fontColor = widget.color!;
    }

    return GestureDetector(
      onTapDown: (tapDownDetails) {
        if (widget.readonly == true) return;

        setState(() {
          containerColor = darkenColor(originContainerColor, 0.11);
        });
      },
      onTapCancel: () {
        setState(() {
          containerColor = originContainerColor;
        });

        logger.info("取消点击");
      },
      onTapUp: (tapDownDetails) {
        if (widget.readonly == true) return;

        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = originContainerColor;
          });

          if (context.mounted) {
            if (widget.link == 'back') {
              Navigator.of(context).pop();
            } else if (widget.link != null) {
              Navigator.pushNamed(context, widget.link!);
            }
          }
        });

        logger.info("弹起");
      },
      child: Container(
        height: 95.w,
        width: 345.w,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(12.w), // 设置圆角为 12.w
        ),
        alignment: Alignment.center,
        child: Text(
          widget.title,
          style: TextStyle(
            height: 1.08,
            color: fontColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSizeScale(32.w),
            fontFamily: "AlibabaPuHuiTi",
          ),
        ),
      ),
    );
  }
}
