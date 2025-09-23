import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_function_button.dart';
import 'package:vigaviga/widgets/ljn_function_buttons_section.dart';
import 'package:vigaviga/widgets/ljn_max_width_button.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../tools/ljn_logger.dart';

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
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return Stack(children: [
        Scaffold(
          primary: false,
          appBar: LJNAppBar(
            title: l10n.services,
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
                  color: Colors.transparent,
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
          backgroundColor: theme.colorScheme.surfaceContainer,
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              // padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding.w)
              //     .copyWith(top: 16.w, bottom: 32.w),
              child: Column(
                children: [
                  // --- 顶部核心功能卡片 (已修复对齐问题) ---
                  _buildHeaderCard(context),

                  // SizedBox(height: 10.w),

                  // --- 服务分区 ---

                  // 金融理财
                  LJNFunctionButtonsSection(
                    title: l10n.financialServices,
                    buttons: [
                      // 服务
                      LJNFunctionButton(
                        icon: "images/icon/server_icon1.png",
                        title: l10n.services,
                        onPressed: () {
                          logger.info('点击了信用卡还款按钮~~');
                        },
                      ),
                      // 朋友圈
                      LJNFunctionButton(
                        icon: "images/icon/server_icon2.png",
                        title: l10n.moments,
                        onPressed: () {
                          logger.info('点击了理财通按钮~~');
                        },
                      ),
                      // 设置
                      LJNFunctionButton(
                        icon: "images/icon/server_icon3.png",
                        title: l10n.settings,
                        onPressed: () {
                          logger.info('点击了保险服务按钮~~');
                        },
                      ),
                    ],
                  ),

                  // 生活服务
                  LJNFunctionButtonsSection(
                    title: l10n.lifeServices,
                    buttons: [
                      LJNFunctionButton(
                        icon: "images/icon/server_icon4.png",
                        title: l10n.mobileTopUp,
                        onPressed: () {
                          logger.info('点击了手机充值按钮~~');
                        },
                      ),
                      LJNFunctionButton(
                        icon: "images/icon/server_icon5.png",
                        title: l10n.utilityPayments,
                        onPressed: () {
                          logger.info('点击了生活缴费按钮~~');
                        },
                      ),
                      LJNFunctionButton(
                        icon: "images/icon/server_icon6.png",
                        title: l10n.qCoinTopUp,
                        onPressed: () {
                          logger.info('点击了Q币充值按钮~~');
                        },
                      ),
                      LJNFunctionButton(
                        icon: "images/icon/server_icon7.png",
                        title: l10n.cityServices,
                        onPressed: () {
                          logger.info('点击了城市服务按钮~~');
                        },
                      ),
                      LJNFunctionButton(
                        icon: "images/icon/server_icon8.png",
                        title: l10n.tencentCharity,
                        onPressed: () {
                          logger.info('点击了腾讯公益按钮~~');
                        },
                      ),
                      LJNFunctionButton(
                        icon: "images/icon/server_icon9.png",
                        title: l10n.healthCare,
                        onPressed: () {
                          logger.info('点击了医疗健康按钮~~');
                        },
                      ),
                    ],
                  ),

                  // // 交通出行
                  // LJNFunctionButtonsSection(
                  //   title: l10n.transportation,
                  //   buttons: [
                  //     LJNFunctionButton(
                  //       icon: "images/icon/server_icon10.png",
                  //       title: l10n.transportServices,
                  //       onPressed: () {
                  //         logger.info('点击了出行服务按钮~~');
                  //       },
                  //     ),
                  //     LJNFunctionButton(
                  //       icon: "images/icon/server_icon11.png",
                  //       title: l10n.trainAndFlightTickets,
                  //       onPressed: () {
                  //         logger.info('点击了火车票机票按钮~~');
                  //       },
                  //     ),
                  //     LJNFunctionButton(
                  //       icon: "images/icon/server_icon12.png",
                  //       title: l10n.didiRideHailing,
                  //       onPressed: () {
                  //         logger.info('点击了滴滴出行按钮~~');
                  //       },
                  //     ),
                  //     LJNFunctionButton(
                  //       icon: "images/icon/server_icon122.png",
                  //       title: l10n.hotel,
                  //       onPressed: () {
                  //         logger.info('点击了酒店按钮~~');
                  //       },
                  //     ),
                  //   ],
                  // ),

                  // // 购物与消费
                  // LJNFunctionButtonsSection(
                  //   title: l10n.shoppingAndConsumption,
                  //   buttons: [
                  //     LJNFunctionButton(
                  //       icon: "images/icon/server_icon13.png",
                  //       title: l10n.brandDiscovery,
                  //       onPressed: () {
                  //         logger.info('点击了品牌发现按钮~~');
                  //       },
                  //     ),
                  //     LJNFunctionButton(
                  //       icon: "images/icon/server_icon14.png",
                  //       title: l10n.jdShopping,
                  //       onPressed: () {
                  //         logger.info('点击了京东购物按钮~~');
                  //       },
                  //     ),
                  //     LJNFunctionButton(
                  //       icon: "images/icon/server_icon15.png",
                  //       title: l10n.meituanWaimai,
                  //       onPressed: () {
                  //         logger.info('点击了美团外卖按钮~~');
                  //       },
                  //     ),
                  //     LJNFunctionButton(
                  //       icon: "images/icon/server_icon16.png",
                  //       title: l10n.movieTicketsAndEntertainment,
                  //       onPressed: () {
                  //         logger.info('点击了电影演出玩乐按钮~~');
                  //       },
                  //     ),
                  //     LJNFunctionButton(
                  //       icon: "images/icon/server_icon17.png",
                  //       title: l10n.meituanSpecialOffers,
                  //       onPressed: () {
                  //         logger.info('点击了美团特价按钮~~');
                  //       },
                  //     ),
                  //     LJNFunctionButton(
                  //       icon: "images/icon/server_icon18.png",
                  //       title: l10n.pinduoduo,
                  //       onPressed: () {
                  //         logger.info('点击了拼多多按钮~~');
                  //       },
                  //     ),
                  //     LJNFunctionButton(
                  //       icon: "images/icon/server_icon19.png",
                  //       title: l10n.vipshop,
                  //       onPressed: () {
                  //         logger.info('点击了唯品会特卖按钮~~');
                  //       },
                  //     ),
                  //     LJNFunctionButton(
                  //       icon: "images/icon/server_icon20.png",
                  //       title: l10n.zhuanzhuanUsedGoods,
                  //       onPressed: () {
                  //         logger.info('点击了转转二手按钮~~');
                  //       },
                  //     ),
                  //   ],
                  // ),
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
                backgroundColor: Colors.transparent,
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
                                text: l10n.serviceManagement,
                                style: TextStyle(
                                  height: 1.08,
                                  fontSize: 30.w,
                                  decoration: TextDecoration.none,
                                  color: theme.colorScheme.onSurface,
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
                        title: l10n.cancel,
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
    AppLocalizations l10n = AppLocalizations.of(context)!;

    // 定义余额文本的样式，以便复用
    final balanceTextStyle = TextStyle(
      height: 1.1,
      fontSize: fontSizeScale(30.w),
      color: AppColors.accentYellow,
      fontFamily: "LJNFont",
    );

    return Container(
      height: 272.w,
      margin: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.brandGreenVibrant4,
            AppColors.brandGreenVibrant5,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0).w,
        boxShadow: [
          BoxShadow(
            color: AppColors.brandGreenDarkest.withAlpha(50),
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
                color: AppColors.neutralWhite,
              ),
              title: l10n.payment,
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
            color: AppColors.neutralWhite.withAlpha(50),
          ),
          Expanded(
            child: CollectionAndPayment(
              icon: Icon(
                const IconData(
                  0xe6e4,
                  fontFamily: 'Iconfont',
                ),
                size: 72.w,
                color: AppColors.neutralWhite,
              ),
              title: l10n.wallet,
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
                    WidgetSpan(
                      child: SizedBox(
                        width: 4.w,
                      ),
                    ),
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
        borderRadius: BorderRadius.circular(16.0).w,
        onTap: onPressed,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 90.w,
                height: 90.w,
                child: Center(
                  child: icon,
                ),
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
