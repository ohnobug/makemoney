import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/screens/components/ljn_appbar.dart';
import 'package:vigaviga/screens/components/ljn_max_width_button.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../tools/ljn_logger.dart';

// --- UI优化常量 ---
const double kCardBorderRadius = 16.0;
const double kHorizontalPadding = 16.0;
const double kVerticalCardMargin = 18.0;

class LJNServices extends StatefulWidget {
  const LJNServices({super.key});

  @override
  State<LJNServices> createState() => _LJNServices();
}

class _LJNServices extends State<LJNServices>
    with SingleTickerProviderStateMixin {
  bool showSelector = false;
  late AnimationController _animationController;
  late Animation<double> _upAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 50),
      vsync: this,
    );
    _upAnimation = Tween<double>(begin: -330.w, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return Stack(children: [
        Scaffold(
          primary: false,
          appBar: LJNAppBar(
            title: AppLocalizations.of(context)!.services,
            actions: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showSelector = true;
                  });

                  _animationController.forward();
                },
                child: Container(
                  height: 90.w,
                  color: AppColors.transparent,
                  padding: EdgeInsets.only(right: 33.w),
                  alignment: Alignment.center,
                  child: Icon(
                    const IconData(
                      0xe659,
                      fontFamily: 'Iconfont',
                    ),
                    size: 37.w,
                  ),
                ),
              )
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding.w)
                  .copyWith(top: 16.w, bottom: 32.w),
              child: Column(
                children: [
                  // --- 顶部核心功能卡片 (已修复对齐问题) ---
                  _buildHeaderCard(context),

                  SizedBox(height: kVerticalCardMargin.w),

                  // --- 服务分区 ---
                  FunctionButtonsSection(
                    title: AppLocalizations.of(context)!.financialServices,
                    buttons: [
                      FunctionButton(
                        icon: "images/icon/server_icon1.png",
                        title:
                            AppLocalizations.of(context)!.creditCardRepayment,
                        onPressed: () {
                          logger.info('点击了信用卡还款按钮~~');
                        },
                      ),
                      FunctionButton(
                        icon: "images/icon/server_icon2.png",
                        title: AppLocalizations.of(context)!.licaitong,
                        onPressed: () {
                          logger.info('点击了理财通按钮~~');
                        },
                      ),
                      FunctionButton(
                        icon: "images/icon/server_icon3.png",
                        title: AppLocalizations.of(context)!.insuranceService,
                        onPressed: () {
                          logger.info('点击了保险服务按钮~~');
                        },
                      ),
                    ],
                  ),

                  FunctionButtonsSection(
                    title: AppLocalizations.of(context)!.lifeServices,
                    buttons: [
                      FunctionButton(
                        icon: "images/icon/server_icon4.png",
                        title: AppLocalizations.of(context)!.mobileTopUp,
                        onPressed: () {
                          logger.info('点击了手机充值按钮~~');
                        },
                      ),
                      FunctionButton(
                        icon: "images/icon/server_icon5.png",
                        title: AppLocalizations.of(context)!.utilityPayments,
                        onPressed: () {
                          logger.info('点击了生活缴费按钮~~');
                        },
                      ),
                      FunctionButton(
                        icon: "images/icon/server_icon6.png",
                        title: AppLocalizations.of(context)!.qCoinTopUp,
                        onPressed: () {
                          logger.info('点击了Q币充值按钮~~');
                        },
                      ),
                      FunctionButton(
                        icon: "images/icon/server_icon7.png",
                        title: AppLocalizations.of(context)!.cityServices,
                        onPressed: () {
                          logger.info('点击了城市服务按钮~~');
                        },
                      ),
                      FunctionButton(
                        icon: "images/icon/server_icon8.png",
                        title: AppLocalizations.of(context)!.tencentCharity,
                        onPressed: () {
                          logger.info('点击了腾讯公益按钮~~');
                        },
                      ),
                      FunctionButton(
                        icon: "images/icon/server_icon9.png",
                        title: AppLocalizations.of(context)!.healthCare,
                        onPressed: () {
                          logger.info('点击了医疗健康按钮~~');
                        },
                      ),
                    ],
                  ),

                  FunctionButtonsSection(
                    title: AppLocalizations.of(context)!.transportation,
                    buttons: [
                      FunctionButton(
                        icon: "images/icon/server_icon10.png",
                        title: AppLocalizations.of(context)!.transportServices,
                        onPressed: () {
                          logger.info('点击了出行服务按钮~~');
                        },
                      ),
                      FunctionButton(
                        icon: "images/icon/server_icon11.png",
                        title:
                            AppLocalizations.of(context)!.trainAndFlightTickets,
                        onPressed: () {
                          logger.info('点击了火车票机票按钮~~');
                        },
                      ),
                      FunctionButton(
                        icon: "images/icon/server_icon12.png",
                        title: AppLocalizations.of(context)!.didiRideHailing,
                        onPressed: () {
                          logger.info('点击了滴滴出行按钮~~');
                        },
                      ),
                      FunctionButton(
                        icon: "images/icon/server_icon122.png",
                        title: AppLocalizations.of(context)!.hotel,
                        onPressed: () {
                          logger.info('点击了酒店按钮~~');
                        },
                      ),
                    ],
                  ),

                  FunctionButtonsSection(
                    title: AppLocalizations.of(context)!.shoppingAndConsumption,
                    buttons: [
                      FunctionButton(
                        icon: "images/icon/server_icon13.png",
                        title: AppLocalizations.of(context)!.brandDiscovery,
                        onPressed: () {
                          logger.info('点击了品牌发现按钮~~');
                        },
                      ),
                      FunctionButton(
                        icon: "images/icon/server_icon14.png",
                        title: AppLocalizations.of(context)!.jdShopping,
                        onPressed: () {
                          logger.info('点击了京东购物按钮~~');
                        },
                      ),
                      FunctionButton(
                        icon: "images/icon/server_icon15.png",
                        title: AppLocalizations.of(context)!.meituanWaimai,
                        onPressed: () {
                          logger.info('点击了美团外卖按钮~~');
                        },
                      ),
                      FunctionButton(
                        icon: "images/icon/server_icon16.png",
                        title: AppLocalizations.of(context)!
                            .movieTicketsAndEntertainment,
                        onPressed: () {
                          logger.info('点击了电影演出玩乐按钮~~');
                        },
                      ),
                      FunctionButton(
                        icon: "images/icon/server_icon17.png",
                        title:
                            AppLocalizations.of(context)!.meituanSpecialOffers,
                        onPressed: () {
                          logger.info('点击了美团特价按钮~~');
                        },
                      ),
                      FunctionButton(
                        icon: "images/icon/server_icon18.png",
                        title: AppLocalizations.of(context)!.pinduoduo,
                        onPressed: () {
                          logger.info('点击了拼多多按钮~~');
                        },
                      ),
                      FunctionButton(
                        icon: "images/icon/server_icon19.png",
                        title: AppLocalizations.of(context)!.vipshop,
                        onPressed: () {
                          logger.info('点击了唯品会特卖按钮~~');
                        },
                      ),
                      FunctionButton(
                        icon: "images/icon/server_icon20.png",
                        title:
                            AppLocalizations.of(context)!.zhuanzhuanUsedGoods,
                        onPressed: () {
                          logger.info('点击了转转二手按钮~~');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // --- 底部弹出菜单 (保持不变) ---
        if (showSelector)
          GestureDetector(
            onTap: () {
              _animationController.reverse().then((_) {
                setState(() {
                  showSelector = false;
                });
              });
            },
            child: Container(
              color: AppColors.blackTransparent50,
              width: 750.w,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Positioned(
              left: 0,
              bottom: _upAnimation.value,
              width: 750.w,
              height: 225.w,
              child: Scaffold(
                backgroundColor: AppColors.transparent,
                primary: false,
                body: Container(
                  width: 750.w,
                  height: 225.w,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppColors.neutralWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.w),
                      topRight: Radius.circular(20.w),
                    ),
                  ),
                  child: Column(
                    children: [
                      LJNMaxWidthButton(
                        title: Text.rich(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: AppLocalizations.of(context)!
                                    .serviceManagement,
                                style: TextStyle(
                                  height: 1.08,
                                  fontSize: 30.w,
                                  decoration: TextDecoration.none,
                                  color: AppColors.neutralBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                        underline: true,
                        onPressed: () {
                          _animationController.reverse().then((_) {
                            setState(() {
                              showSelector = false;
                            });
                            Navigator.pushNamed(
                              context,
                              '/services_manager',
                            );
                          });
                        },
                      ),
                      Container(
                        height: 15.w,
                        color: AppColors.neutralGrey2,
                      ),
                      LJNMaxWidthButton(
                        title: AppLocalizations.of(context)!.cancel,
                        underline: false,
                        onPressed: () {
                          _animationController.reverse().then(
                            (_) {
                              setState(() {
                                showSelector = false;
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ]);
    });
  }

  /// 构建器：顶部核心功能卡片
  Widget _buildHeaderCard(BuildContext context) {
    // 定义余额文本的样式，以便复用
    final balanceTextStyle = TextStyle(
      height: 1.1,
      fontSize: fontSizeScale(30.w),
      color: AppColors.accentYellow,
      fontFamily: "LJNFont",
    );

    return Container(
      height: 272.w,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.brandGreenVibrant4,
            AppColors.brandGreenVibrant5,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(kCardBorderRadius).w,
        boxShadow: [
          BoxShadow(
            color: AppColors.brandGreenDarkest.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CollectionAndPayment(
              icon: Icon(
                  const IconData(
                    0xe658,
                    fontFamily: 'Iconfont',
                  ),
                  size: 72.w,
                  color: AppColors.neutralWhite),
              title: AppLocalizations.of(context)!.payment,
              // 优化点：传入一个隐形的占位符，其样式与余额完全相同
              subTitle: Text('', style: balanceTextStyle),
              onPressed: () {
                Navigator.pushNamed(context, '/collection_and_payment');
                logger.info('点击了收付款还款按钮~~');
              },
            ),
          ),
          Container(
            width: 1,
            height: 100.w,
            color: AppColors.neutralWhite.withOpacity(0.2),
          ),
          Expanded(
            child: CollectionAndPayment(
              icon: Icon(
                  const IconData(
                    0xe6e4,
                    fontFamily: 'Iconfont',
                  ),
                  size: 72.w,
                  color: AppColors.neutralWhite),
              title: AppLocalizations.of(context)!.wallet,
              // 正常传入余额组件
              subTitle: Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        const IconData(
                          0xe90d,
                          fontFamily: 'Iconfont',
                        ),
                        size: 25.w,
                        color: AppColors.accentYellow,
                      ),
                      alignment: PlaceholderAlignment.middle,
                    ),
                    const WidgetSpan(child: SizedBox(width: 4)),
                    TextSpan(
                      text: context
                          .read<LJNUserCubit>()
                          .state
                          .walletBalance
                          .toString(),
                      style: balanceTextStyle,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/wallet');
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 顶部核心功能按钮 (已修改为必须接收subTitle)
class CollectionAndPayment extends StatelessWidget {
  final Icon icon;
  final String title;
  final VoidCallback onPressed;
  final Widget subTitle; // 优化点：从 Widget? 变为 Widget

  const CollectionAndPayment({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
    required this.subTitle, // 优化点：变为必传参数
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(kCardBorderRadius).w,
        onTap: onPressed,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 90.w,
                height: 90.w,
                child: Center(child: icon),
              ),
              SizedBox(height: 10.w),
              Text(
                title,
                maxLines: 1,
                style: TextStyle(
                  height: 1.1,
                  decoration: TextDecoration.none,
                  color: AppColors.neutralWhite,
                  fontSize: fontSizeScale(32.0.w),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 10.w),
              // 现在直接使用subTitle，无需判断是否为null
              subTitle,
            ],
          ),
        ),
      ),
    );
  }
}

/// 网格功能按钮 (保持对齐修复后的版本)
class FunctionButton extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onPressed;

  const FunctionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double fontHeight = fontSizeScale(25.0.w);
    final double lineHeight = 1.2;
    final double textContainerHeight = fontHeight * lineHeight * 2 + 4.w;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0).w,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                assetPath(icon),
                width: 57.w,
                height: 57.w,
              ),
              SizedBox(height: 16.w),
              Container(
                height: textContainerHeight,
                alignment: Alignment.topCenter,
                child: Text(
                  title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: lineHeight,
                    decoration: TextDecoration.none,
                    color: AppColors.neutralDarkGrey20,
                    fontSize: fontHeight,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 功能分区组件 (保持优化后的版本)
class FunctionButtonsSection extends StatelessWidget {
  final String title;
  final List<FunctionButton> buttons;

  const FunctionButtonsSection({
    super.key,
    required this.title,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kVerticalCardMargin.w),
      decoration: BoxDecoration(
        color: AppColors.neutralWhite,
        borderRadius: BorderRadius.circular(kCardBorderRadius).w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 33.w, left: 30.w, right: 30.w, bottom: 16.w),
            child: Text(
              title,
              style: TextStyle(
                height: 1.1,
                fontSize: fontSizeScale(29.w),
                fontWeight: FontWeight.w600,
                color: AppColors.neutralDarkGrey5,
              ),
            ),
          ),
          GridView.builder(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 24.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 12.w,
              childAspectRatio: 0.85,
            ),
            itemCount: buttons.length,
            itemBuilder: (context, index) {
              return buttons[index];
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }
}
