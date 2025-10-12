import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_switch.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';

class LJNServicesManagerPage extends StatefulWidget {
  const LJNServicesManagerPage({super.key});

  @override
  State<LJNServicesManagerPage> createState() => _LJNServicesManagerPageState();
}

class _LJNServicesManagerPageState extends State<LJNServicesManagerPage> {
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
        return Scaffold(
          primary: false,
          appBar: const LJNAppBar(
            title: "",
          ),
          body: ColoredBox(
            color: theme.colorScheme.surfaceContainer,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 205.w,
                  ),
                  child: Column(
                    children: [
                      // 描述
                      Container(
                        color: theme.colorScheme.surface,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100.w,
                            ),

                            // 服务管理
                            Text(
                              l10n.serviceManagement,
                              style: TextStyle(
                                fontSize: 40.w,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(
                              height: 35.w,
                            ),

                            // 管理服务描述
                            Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: 30.w,
                              ),
                              child: Text(
                                textAlign: TextAlign.start,
                                l10n.manageServicesDescription,
                                style: TextStyle(
                                  fontSize: 31.w,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 105.w,
                            ),
                          ],
                        ),
                      ),

                      // 功能列表
                      Container(
                        color: theme.colorScheme.surfaceContainer,
                        // padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Column(
                          children: [
                            _buildFirstTitle(l10n.financialServices),

                            // 金融服务列表
                            LJNFunctionList(children: [
                              // 信用卡还款
                              LJNFunctionItem(
                                title: l10n.creditCardRepayment,
                                icon: "images/icon/server_icon1.png",
                                link: '/qrcode_scanner',
                                // margin: EdgeInsets.symmetric(horizontal: 5.w),
                                underline: true,
                                showLinkIcon: false,
                                showStyle: Expanded(
                                  flex: 0,
                                  child: Row(
                                    children: [
                                      LJNSwitch(
                                        initialValue: true,
                                        onChanged: (value) {
                                          logger.info(value);
                                        },
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              // 微粒贷
                              LJNFunctionItem(
                                title: l10n.weilidaiLoan,
                                icon: "images/icon/discovery_icon4.png",
                                link: '/qrcode_scanner',
                                // margin: const EdgeInsets.all(0),
                                underline: true,
                                showLinkIcon: false,
                                showStyle: Expanded(
                                  flex: 0,
                                  child: Row(
                                    children: [
                                      LJNSwitch(
                                        initialValue: true,
                                        onChanged: (value) {
                                          logger.info(value);
                                        },
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              // 理财通
                              LJNFunctionItem(
                                title: l10n.licaitong,
                                icon: "images/icon/server_icon2.png",
                                link: '/qrcode_scanner',
                                // margin: const EdgeInsets.all(0),
                                underline: true,
                                showLinkIcon: false,
                                showStyle: Expanded(
                                  flex: 0,
                                  child: Row(
                                    children: [
                                      LJNSwitch(
                                        initialValue: true,
                                        onChanged: (value) {
                                          logger.info(value);
                                        },
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              // 保险服务
                              LJNFunctionItem(
                                title: l10n.insuranceService,
                                icon: "images/icon/server_icon3.png",
                                link: '/qrcode_scanner',
                                // margin: const EdgeInsets.all(0),
                                underline: false,
                                showLinkIcon: false,
                                showStyle: Expanded(
                                  flex: 0,
                                  child: Row(
                                    children: [
                                      LJNSwitch(
                                        initialValue: true,
                                        onChanged: (value) {
                                          logger.info(value);
                                        },
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),

                            _buildTitle(l10n.transportation),

                            // 交通出行、酒店及旅游
                            LJNFunctionList(children: [
                              // 交通出行
                              LJNFunctionItem(
                                title: l10n.transportServices,
                                icon: "images/icon/server_icon10.png",
                                link: '/qrcode_scanner',
                                // margin: const EdgeInsets.all(0),
                                underline: true,
                                showLinkIcon: false,
                                showStyle: Expanded(
                                  flex: 0,
                                  child: Row(
                                    children: [
                                      LJNSwitch(
                                        initialValue: true,
                                        onChanged: (value) {
                                          logger.info(value);
                                        },
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              // 火车机票
                              LJNFunctionItem(
                                title: l10n.trainAndFlightTickets,
                                icon: "images/icon/server_icon11.png",
                                link: '/qrcode_scanner',
                                // margin: const EdgeInsets.all(0),
                                underline: true,
                                showLinkIcon: false,
                                showStyle: Expanded(
                                  flex: 0,
                                  child: Row(
                                    children: [
                                      LJNSwitch(
                                        initialValue: true,
                                        onChanged: (value) {
                                          logger.info(value);
                                        },
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              // 滴滴打车
                              LJNFunctionItem(
                                title: l10n.didiRideHailing,
                                icon: "images/icon/server_icon12.png",
                                link: '/qrcode_scanner',
                                // margin: const EdgeInsets.all(0),
                                underline: true,
                                showLinkIcon: false,
                                showStyle: Expanded(
                                  flex: 0,
                                  child: Row(
                                    children: [
                                      LJNSwitch(
                                        initialValue: true,
                                        onChanged: (value) {
                                          logger.info(value);
                                        },
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              // 酒店及民宿
                              LJNFunctionItem(
                                title: l10n.hotelAndBAndB,
                                icon: "images/icon/server_icon122.png",
                                link: '/qrcode_scanner',
                                // margin: const EdgeInsets.all(0),
                                underline: false,
                                showLinkIcon: false,
                                showStyle: Expanded(
                                  flex: 0,
                                  child: Row(
                                    children: [
                                      LJNSwitch(
                                        initialValue: true,
                                        onChanged: (value) {
                                          logger.info(value);
                                        },
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),

                            _buildTitle(l10n.shoppingAndConsumption),

                            // 购物及消费
                            LJNFunctionList(
                              children: [
                                // 品牌发现
                                LJNFunctionItem(
                                  title: l10n.brandDiscovery,
                                  icon: "images/icon/server_icon13.png",
                                  link: '/qrcode_scanner',
                                  // margin: const EdgeInsets.all(0),
                                  underline: true,
                                  showLinkIcon: false,
                                  showStyle: Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: [
                                        LJNSwitch(
                                          initialValue: true,
                                          onChanged: (value) {
                                            logger.info(value);
                                          },
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // 京东购物
                                LJNFunctionItem(
                                  title: l10n.jdShopping,
                                  icon: "images/icon/server_icon14.png",
                                  link: '/qrcode_scanner',
                                  // margin: const EdgeInsets.all(0),
                                  underline: true,
                                  showLinkIcon: false,
                                  showStyle: Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: [
                                        LJNSwitch(
                                          initialValue: true,
                                          onChanged: (value) {
                                            logger.info(value);
                                          },
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // 美团外卖
                                LJNFunctionItem(
                                  title: l10n.meituanWaimai,
                                  icon: "images/icon/server_icon15.png",
                                  link: '/qrcode_scanner',
                                  // margin: const EdgeInsets.all(0),
                                  underline: true,
                                  showLinkIcon: false,
                                  showStyle: Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: [
                                        LJNSwitch(
                                          initialValue: true,
                                          onChanged: (value) {
                                            logger.info(value);
                                          },
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // 电影票及娱乐
                                LJNFunctionItem(
                                  title: l10n.movieTicketsAndEntertainment,
                                  icon: "images/icon/server_icon16.png",
                                  link: '/qrcode_scanner',
                                  // margin: const EdgeInsets.all(0),
                                  underline: true,
                                  showLinkIcon: false,
                                  showStyle: Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: [
                                        LJNSwitch(
                                          initialValue: true,
                                          onChanged: (value) {
                                            logger.info(value);
                                          },
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // 美团特惠
                                LJNFunctionItem(
                                  title: l10n.meituanSpecialOffers,
                                  icon: "images/icon/server_icon15.png",
                                  link: '/qrcode_scanner',
                                  // margin: const EdgeInsets.all(0),
                                  underline: true,
                                  showLinkIcon: false,
                                  showStyle: Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: [
                                        LJNSwitch(
                                          initialValue: true,
                                          onChanged: (value) {
                                            logger.info(value);
                                          },
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // 拼多多
                                LJNFunctionItem(
                                  title: l10n.pinduoduo,
                                  icon: "images/icon/server_icon18.png",
                                  link: '/qrcode_scanner',
                                  // margin: const EdgeInsets.all(0),
                                  underline: true,
                                  showLinkIcon: false,
                                  showStyle: Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: [
                                        LJNSwitch(
                                          initialValue: true,
                                          onChanged: (value) {
                                            logger.info(value);
                                          },
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // 唯品会
                                LJNFunctionItem(
                                  title: l10n.vipshop,
                                  icon: "images/icon/server_icon19.png",
                                  link: '/qrcode_scanner',
                                  // margin: const EdgeInsets.all(0),
                                  underline: true,
                                  showLinkIcon: false,
                                  showStyle: Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: [
                                        LJNSwitch(
                                          initialValue: true,
                                          onChanged: (value) {
                                            logger.info(value);
                                          },
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // 转转二手
                                LJNFunctionItem(
                                  title: l10n.zhuanzhuanUsedGoods,
                                  icon: "images/icon/server_icon20.png",
                                  link: '/qrcode_scanner',
                                  // margin: const EdgeInsets.all(0),
                                  underline: false,
                                  showLinkIcon: false,
                                  showStyle: Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: [
                                        LJNSwitch(
                                          initialValue: true,
                                          onChanged: (value) {
                                            logger.info(value);
                                          },
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 150.w)
                          ],
                        ),
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

  Widget _buildTitle(String title) {
    ThemeData theme = Theme.of(context);

    return Container(
      height: 30.w,
      margin: EdgeInsets.only(left: 15.w, top: 55.w),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          color: theme.colorScheme.onSurface.withAlpha(150),
        ),
      ),
    );
  }

  Widget _buildFirstTitle(String title) {
    ThemeData theme = Theme.of(context);

    return Container(
      height: 30.w,
      margin: EdgeInsets.only(left: 25.w, top: 35.w),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          color: theme.colorScheme.onSurface.withAlpha(150),
        ),
      ),
    );
  }
}
