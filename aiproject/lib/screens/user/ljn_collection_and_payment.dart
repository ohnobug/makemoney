import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

class LJNCollectionAndPayment extends StatefulWidget {
  const LJNCollectionAndPayment({super.key});

  @override
  State<LJNCollectionAndPayment> createState() =>
      _LJNCollectionAndPaymentState();
}

class _LJNCollectionAndPaymentState extends State<LJNCollectionAndPayment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Theme(
          data: theme.copyWith(
            appBarTheme: theme.appBarTheme.copyWith(
              backgroundColor: AppColors.brandTealDark3,
            ),
          ),
          child: Scaffold(
            primary: false,
            appBar: LJNAppBar(
              title: l10n.payment,
            ),
            body: ColoredBox(
              color: AppColors.brandTealDark3,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 15.w,
                          left: 15.w,
                          right: 15.w,
                        ),
                        padding: EdgeInsets.all(30.w),
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.w),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 110.w,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1.w,
                                    color: theme.dividerColor,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        const IconData(
                                          0xe611,
                                          fontFamily: 'Iconfont',
                                        ), // 使用的图标
                                        color: AppColors
                                            .brandGreenVibrantDeep1, // 图标颜色
                                        size: 35.w, // 图标大小
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        l10n.paymentCode,
                                        style: TextStyle(
                                          fontSize: 32.w,
                                          height: 1.08,
                                          color:
                                              AppColors.brandGreenVibrantDeep1,
                                        ),
                                      )
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // 点击事件
                                    },
                                    child: Container(
                                      height: 90.w,
                                      color: AppColors.transparent,
                                      child: Icon(
                                        color: AppColors.neutralGrey38,
                                        const IconData(
                                          0xe659,
                                          fontFamily: 'Iconfont',
                                        ),
                                        size: 43.w, // 图标大小
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40.w,
                            ),
                            Text(
                              l10n.prioritizeBalancePayment,
                              style: TextStyle(
                                fontSize: 25.w,
                                color: AppColors.neutralGrey54,
                              ),
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            Image.asset(
                              assetPath("images/avatar/linecode.png"),
                              width: 630.0.w,
                              height: 195.0.w,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              height: 55.w,
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 60.w),
                              height: 320.w,
                              width: 750.w,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1.w,
                                    color: theme.dividerColor,
                                  ),
                                ),
                              ),
                              child: Image.asset(
                                assetPath("images/avatar/qrcode.png"),
                                width: 320.0.w,
                                height: 320.0.w,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              height: 33.w,
                            ),
                            Column(
                              children: [
                                // 优先付款方式
                                SizedBox(
                                  width: 750.w,
                                  height: 25.w,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        l10n.priorityPaymentMethod,
                                        style: TextStyle(
                                          fontSize: 25.w,
                                          height: 1.08,
                                          color: AppColors.neutralDarkGrey2,
                                        ),
                                      ),
                                      Flex(
                                        direction: Axis.horizontal,
                                        children: [
                                          Text(
                                            l10n.change,
                                            style: TextStyle(
                                              fontSize: 25.w,
                                              height: 1.08,
                                              color: AppColors.neutralDarkGrey2,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Icon(
                                            const IconData(
                                              0xe891,
                                              fontFamily: 'Iconfont',
                                            ), // 使用的图标
                                            color: AppColors
                                                .neutralDarkGrey2, // 图标颜色
                                            size: 28.w, // 图标大小
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 20.w,
                                ),

                                // 零钱
                                Container(
                                  height: 107.w,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 33.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.neutralOffWhiteYellow,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.w),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // 零钱
                                      Flex(
                                        direction: Axis.horizontal,
                                        children: [
                                          Icon(
                                            const IconData(
                                              0xe6cc,
                                              fontFamily: 'Iconfont',
                                            ), // 使用的图标
                                            color:
                                                AppColors.accentYellow, // 图标颜色
                                            size: 38.w, // 图标大小
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(
                                            l10n.balance,
                                            style: TextStyle(
                                              fontSize: 25.w,
                                              height: 1.08,
                                              color: AppColors.neutralGrey74,
                                            ),
                                          ),
                                        ],
                                      ),

                                      // 打勾
                                      Icon(
                                        const IconData(
                                          0xe60d,
                                          fontFamily: 'Iconfont',
                                        ), // 使用的图标
                                        color: AppColors
                                            .brandGreenVibrantDeep2, // 图标颜色
                                        size: 30.w, // 图标大小
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 10.w,
                      ),

                      Container(
                        margin: EdgeInsets.only(
                          top: 15.w,
                          left: 15.w,
                          right: 15.w,
                        ),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.w),
                          ),
                        ),
                        child: Column(
                          children: [
                            LJNCAPFunctionItem(
                              title: l10n.digitalRMBPayment,
                              icon: const IconData(
                                0xe6f5,
                                fontFamily: 'Iconfont',
                              ),
                              iconColor: AppColors.accentRedPure,
                              link: '',
                              color: theme.colorScheme.onSurface,
                              backgroundColor: AppColors.neutralWhite,
                              underline: false,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 10.w,
                      ),

                      // 列表
                      Container(
                        margin:
                            EdgeInsets.only(top: 15.w, left: 15.w, right: 15.w),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.w),
                          ),
                        ),
                        child: Column(
                          children: [
                            LJNCAPFunctionItem(
                              title: l10n.qrCodeCollection,
                              icon: const IconData(
                                0xe623,
                                fontFamily: "Iconfont",
                              ),
                              link: '',
                              backgroundColor: AppColors.brandTealDark2,
                              underline: true,
                            ),
                            LJNCAPFunctionItem(
                              title: l10n.rewardCode,
                              icon: const IconData(
                                0xe67b,
                                fontFamily: "Iconfont",
                              ),
                              link: '',
                              backgroundColor: AppColors.brandTealDark2,
                              underline: true,
                            ),
                            LJNCAPFunctionItem(
                              title: l10n.groupSplitBill,
                              icon: const IconData(
                                0xe624,
                                fontFamily: "Iconfont",
                              ),
                              link: '',
                              backgroundColor: AppColors.brandTealDark2,
                              underline: true,
                            ),
                            LJNCAPFunctionItem(
                              title: l10n.faceToFaceRedPacket,
                              icon: const IconData(
                                0xe625,
                                fontFamily: "Iconfont",
                              ),
                              link: '',
                              backgroundColor: AppColors.brandTealDark2,
                              underline: true,
                            ),
                            LJNCAPFunctionItem(
                              title: l10n.transferToBankCardOrPhone,
                              icon: const IconData(
                                0xe661,
                                fontFamily: "Iconfont",
                              ),
                              link: '',
                              backgroundColor: AppColors.brandTealDark2,
                              underline: false,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20.w,
                      )
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

class LJNCAPFunctionItem extends StatefulWidget {
  final IconData? icon;
  final Color? iconColor;
  final double? height;
  final String title;
  final String? link;
  final bool underline;
  final Object? showStyle;
  final bool? tapEffect;
  final Color? color;
  final Color? backgroundColor;

  const LJNCAPFunctionItem({
    super.key,
    this.icon,
    this.iconColor,
    this.height,
    required this.title,
    this.link,
    required this.underline,
    this.showStyle,
    this.tapEffect,
    this.color,
    this.backgroundColor,
  });

  @override
  State<LJNCAPFunctionItem> createState() => _LJNCAPFunctionItemState();
}

class _LJNCAPFunctionItemState extends State<LJNCAPFunctionItem> {
  // bool isClicked = false;
  late Color backgroundColor;
  late Color originBackgroundColor;
  late bool tapEffect;

  @override
  void initState() {
    super.initState();
    originBackgroundColor = widget.backgroundColor ?? AppColors.neutralWhite;

    setState(() {
      backgroundColor = originBackgroundColor;
      tapEffect = widget.tapEffect ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTapDown: (tapDownDetails) {
        if (tapEffect == false) return;
        setState(() {
          backgroundColor = darkenColor(originBackgroundColor, 0.1);
        });
      },
      onTapCancel: () {
        if (tapEffect == false) return;

        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            backgroundColor = originBackgroundColor;
          });
        });
      },
      onTapUp: (tapDownDetails) {
        if (tapEffect == false) return;

        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            backgroundColor = originBackgroundColor;
          });
        });
      },
      child: Container(
        height: widget.height ?? 125.0.w,
        color: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              // 头像
              SizedBox(
                width: 40.0.w,
                height: 40.0.w,
                child: Icon(
                  widget.icon!, // 使用的图标
                  color: widget.iconColor ?? AppColors.neutralWhite, // 图标颜色
                  size: 35.w, // 图标大小
                ),
              ),
              SizedBox(width: 10.w)
            ],
            Expanded(
              child: Container(
                height: double.infinity,
                // height: double.infinity,
                // width: 400.w,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: widget.underline
                          ? AppColors.brandTealDark1
                          : AppColors.transparent,
                      width: 2.w,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 标题
                    Expanded(
                      flex: 0,
                      // width: 100.w,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(32.0.w),
                            fontFamily: "AlibabaPuHuiTi",
                            color: widget.color ?? AppColors.neutralWhite),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    if (widget.showStyle != null)
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(right: 10, left: 10).w,
                          // color: AppColors.accentRedPure,
                          child: widget.showStyle is String
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.showStyle as String,
                                      style: TextStyle(
                                        height: 1.08,
                                        fontSize: fontSizeScale(30.w),
                                        color: AppColors.neutralDarkGrey7,
                                      ),
                                    )
                                  ],
                                )
                              : widget.showStyle as Widget,
                        ),
                      ),

                    if (widget.link != null)
                      SizedBox(
                        width: 30.w,
                        child: Icon(
                          const IconData(
                            0xed9d,
                            fontFamily: 'Iconfont',
                          ),
                          size: 30.0.w,
                          color: theme.colorScheme.onSurface.withAlpha(100),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
