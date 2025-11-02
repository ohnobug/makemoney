import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/tools/viga_tools.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';

class VigaCollectionAndPaymentPage extends StatefulWidget {
  const VigaCollectionAndPaymentPage({super.key});

  @override
  State<VigaCollectionAndPaymentPage> createState() =>
      _VigaCollectionAndPaymentPageState();
}

class _VigaCollectionAndPaymentPageState
    extends State<VigaCollectionAndPaymentPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<VigaSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Theme(
          data: theme.copyWith(
            appBarTheme: theme.appBarTheme.copyWith(
              backgroundColor: AppColors.brandTealDark3,
              titleTextStyle: theme.appBarTheme.titleTextStyle!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          child: Scaffold(
            primary: false,
            appBar: VigaAppBar(
              title: l10n.payment,
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  // wallet
                }, // 点击事件
                child: Container(
                  color: Colors.transparent,
                  height: 90.w,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 35.w),
                  child: Icon(
                    const IconData(
                      0xe628,
                      fontFamily: 'Iconfont',
                    ), // 使用的图标
                    color: Colors.white, // 图标颜色
                    size: 36.w, // 图标大小
                  ),
                ),
              ),
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
                        padding: EdgeInsets.only(
                          left: 30.w,
                          right: 30.w,
                          top: 0,
                          bottom: 30.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.w),
                          ),
                        ),
                        child: Column(
                          children: [
                            // 标题
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // 支付码
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Icon(
                                          const IconData(
                                            0xe611,
                                            fontFamily: 'Iconfont',
                                          ), // 使用的图标
                                          color: AppColors
                                              .brandGreenVibrantDeep1, // 图标颜色
                                          size: 35.w, // 图标大小
                                        ),
                                      ),
                                      WidgetSpan(
                                          child: SizedBox(
                                        width: 10.w,
                                      )),
                                      TextSpan(
                                        text: l10n.paymentCode,
                                        style: TextStyle(
                                          fontSize: 32.w,
                                          height: 1.08,
                                          color:
                                              AppColors.brandGreenVibrantDeep1,
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                // 三个点
                                GestureDetector(
                                  onTap: () {
                                    // 点击事件
                                  },
                                  child: Container(
                                    height: 90.w,
                                    color: Colors.transparent,
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
                            // 分割线
                            Padding(
                              padding: EdgeInsets.only(
                                top: 0,
                                bottom: 30,
                                left: 0,
                                right: 0,
                              ).w,
                              child: Divider(
                                height: 1.w,
                                color: theme.dividerColor,
                              ),
                            ),

                            // 优先使用零钱
                            Text(
                              l10n.prioritizeBalancePayment,
                              style: TextStyle(
                                fontSize: 25.w,
                                color: AppColors.neutralGrey54,
                              ),
                            ),
                            SizedBox(
                              height: 20.w,
                            ),
                            VigaAppNetworkImage(
                              imageUrl:
                                  "${systemState.cdnBase}/avatar/linecode.png",
                              width: 630.0.w,
                              height: 90.0.w,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              height: 35.w,
                            ),
                            SizedBox(
                              height: 400.w,
                              width: 750.w,
                              child: VigaAppNetworkImage(
                                imageUrl:
                                    "${systemState.cdnBase}/avatar/qrcode.png",
                                width: 400.0.w,
                                height: 400.0.w,
                                fit: BoxFit.contain,
                              ),
                            ),
                            // 分割线
                            Padding(
                              padding: EdgeInsets.only(
                                top: 40,
                                bottom: 40,
                                left: 0,
                                right: 0,
                              ).w,
                              child: Divider(
                                height: 1.w,
                                color: theme.dividerColor,
                              ),
                            ),
                            Column(
                              children: [
                                // 优先付款方式
                                SizedBox(
                                  width: 750.w,
                                  height: 30.w,
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
                                    color: AppColors.neutralGrey5,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.w),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // 零钱
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            WidgetSpan(
                                                child: Icon(
                                              const IconData(
                                                0xe6cc,
                                                fontFamily: 'Iconfont',
                                              ), // 使用的图标
                                              color: AppColors
                                                  .accentYellow, // 图标颜色
                                              size: 38.w, // 图标大小
                                            )),
                                            WidgetSpan(
                                              child: SizedBox(
                                                width: 10.w,
                                              ),
                                            ),
                                            TextSpan(
                                              text: l10n.balance,
                                              style: TextStyle(
                                                fontSize: 25.w,
                                                height: 1.08,
                                                color: AppColors.neutralGrey74,
                                              ),
                                            ),
                                          ],
                                        ),
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
                            VigaCAPFunctionItem(
                              title: l10n.digitalRMBPayment,
                              icon: const IconData(
                                0xe6f5,
                                fontFamily: 'Iconfont',
                              ),
                              iconColor: AppColors.accentRedPure,
                              link: '',
                              color: AppColors.blackTransparent64,
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
                            VigaCAPFunctionItem(
                              title: l10n.qrCodeCollection,
                              icon: const IconData(
                                0xe623,
                                fontFamily: "Iconfont",
                              ),
                              link: '',
                              backgroundColor: AppColors.brandTealMedium,
                              underline: true,
                            ),
                            VigaCAPFunctionItem(
                              title: l10n.rewardCode,
                              icon: const IconData(
                                0xe67b,
                                fontFamily: "Iconfont",
                              ),
                              link: '',
                              backgroundColor: AppColors.brandTealMedium,
                              underline: true,
                            ),
                            VigaCAPFunctionItem(
                              title: l10n.groupSplitBill,
                              icon: const IconData(
                                0xe624,
                                fontFamily: "Iconfont",
                              ),
                              link: '',
                              backgroundColor: AppColors.brandTealMedium,
                              underline: true,
                            ),
                            VigaCAPFunctionItem(
                              title: l10n.faceToFaceRedPacket,
                              icon: const IconData(
                                0xe625,
                                fontFamily: "Iconfont",
                              ),
                              link: '',
                              backgroundColor: AppColors.brandTealMedium,
                              underline: true,
                            ),
                            VigaCAPFunctionItem(
                              title: l10n.transferToBankCardOrPhone,
                              icon: const IconData(
                                0xe661,
                                fontFamily: "Iconfont",
                              ),
                              link: '',
                              backgroundColor: AppColors.brandTealMedium,
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

class VigaCAPFunctionItem extends StatefulWidget {
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

  const VigaCAPFunctionItem({
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
  State<VigaCAPFunctionItem> createState() => _VigaCAPFunctionItemState();
}

class _VigaCAPFunctionItemState extends State<VigaCAPFunctionItem> {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              // 头像
              SizedBox(
                width: 40.0.w,
                height: 40.0.w,
                child: Icon(
                  widget.icon!, // 使用的图标
                  color: widget.iconColor ?? AppColors.neutralWhite, // 图标颜色
                  size: 40.w, // 图标大小
                ),
              ),
              SizedBox(width: 20.w)
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
                          : Colors.transparent,
                      width: 2.w,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 标题
                    SizedBox(
                      // flex: 0,
                      // color: Colors.red,
                      width: 550.w,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          height: 1.08,
                          fontSize: fontSizeScale(32.0.w),
                          color: widget.color ?? AppColors.neutralWhite,
                        ),
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
                          color: theme.listTileTheme.tileColor!,
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
