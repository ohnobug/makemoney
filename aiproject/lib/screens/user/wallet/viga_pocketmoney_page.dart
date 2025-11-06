import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';
import 'package:vigaviga/tools/viga_tools.dart';

class VigaPocketMoneyPage extends StatefulWidget {
  const VigaPocketMoneyPage({super.key});

  @override
  State<VigaPocketMoneyPage> createState() => _VigaPocketMoneyPage();
}

class _VigaPocketMoneyPage extends State<VigaPocketMoneyPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
          return Scaffold(
            primary: false,
            appBar: VigaAppBar(
              title: "",
              // leading: Container(),
              // color: Colors.transparent,
              // bgColor: Colors.transparent,
              actions: [
                VigaAppBarActionTextButton(
                  onTap: () {
                    context.push('/user/wallet/change_details');
                  },
                  title: l10n.balanceDetails,
                ),
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
                    l10n.myBalance,
                    style: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(32.w),
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
                              .read<VigaUserCubit>()
                              .state
                              .walletBalance
                              .toString(),
                          style: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(85.w),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
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
                    l10n.cta_transfer_to_balance_plus_single_line,
                    style: TextStyle(
                      height: 1.08,
                      color: AppColors.accentOrange,
                      fontSize: fontSizeScale(30.w),
                    ),
                  ),
                  const Expanded(
                    flex: 490,
                    child: SizedBox(),
                  ),

                  VigaChargeButton(
                    title: l10n.topUp,
                    color: AppColors.neutralWhite,
                    backgroundColor: AppColors.brandGreenVibrant3,
                  ),

                  SizedBox(
                    height: 33.w,
                  ),
                  // ????????
                  VigaChargeButton(
                    title: l10n.withdraw,
                  ),

                  const Expanded(
                    flex: 143,
                    child: SizedBox(),
                  ),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: l10n.faq,
                        style: TextStyle(
                          height: 1.08,
                          color: AppColors.brandBlueDark4,
                          fontSize: fontSizeScale(25.w),
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
                        ),
                      ),
                      WidgetSpan(
                        child: SizedBox(
                          width: 10.w,
                        ),
                      ),
                      TextSpan(
                        text: l10n.accountUpgradeService,
                        style: TextStyle(
                          height: 1.08,
                          color: AppColors.brandBlueDark4,
                          fontSize: fontSizeScale(25.w),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 26.w,
                  ),
                  Text(
                    l10n.serviceProvidedByTenpayAndWeBank,
                    style: TextStyle(
                      height: 1.08,
                      color: AppColors.neutralGrey46,
                      fontSize: fontSizeScale(23.w),
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
      ),
    );
  }
}

class VigaChargeButton extends StatefulWidget {
  final String title;
  final Color? color;
  final Color? backgroundColor;
  final String? link;
  final bool? readonly;

  const VigaChargeButton({
    super.key,
    required this.title,
    this.color,
    this.backgroundColor,
    this.readonly,
    this.link,
  });

  @override
  State<VigaChargeButton> createState() => _VigaChargeButtonState();
}

class _VigaChargeButtonState extends State<VigaChargeButton> {
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
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = originContainerColor;
          });
          logger.info("取消点击");
        });
      },
      onTapUp: (tapDownDetails) {
        if (widget.readonly == true) return;

        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = originContainerColor;
          });

          if (context.mounted) {
            if (widget.link == 'back') {
              context.pop();
            } else if (widget.link != null) {
              context.push(widget.link!);
            }
          }
          logger.info("弹起");
        });
      },
      child: Container(
        height: 95.w,
        width: 345.w,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(12.w),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.title,
          style: TextStyle(
            height: 1.08,
            color: fontColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSizeScale(32.w),
          ),
        ),
      ),
    );
  }
}
