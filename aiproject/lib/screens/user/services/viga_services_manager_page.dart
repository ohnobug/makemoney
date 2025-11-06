import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_switch.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';

class VigaServicesManagerPage extends StatefulWidget {
  const VigaServicesManagerPage({super.key});

  @override
  State<VigaServicesManagerPage> createState() =>
      _VigaServicesManagerPageState();
}

class _VigaServicesManagerPageState extends State<VigaServicesManagerPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
          String cdnBase = systemState.cdnBase;

          return Scaffold(
            primary: false,
            appBar: const VigaAppBar(
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
                              VigaFunctionList(children: [
                                // 信用卡还款
                                VigaFunctionItem(
                                  title: l10n.creditCardRepayment,
                                  icon: "$cdnBase/icon/server_icon1.png",
                                  link: '',
                                  // margin: EdgeInsets.symmetric(horizontal: 5.w),
                                  underline: true,
                                  showLinkIcon: false,
                                  showStyle: Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: [
                                        VigaSwitch(
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
                                VigaFunctionItem(
                                  title: l10n.weilidaiLoan,
                                  icon: "$cdnBase/icon/discovery_icon4.png",
                                  link: '',
                                  // margin: const EdgeInsets.all(0),
                                  underline: true,
                                  showLinkIcon: false,
                                  showStyle: Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: [
                                        VigaSwitch(
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
                                VigaFunctionItem(
                                  title: l10n.licaitong,
                                  icon: "$cdnBase/icon/server_icon2.png",
                                  link: '',
                                  // margin: const EdgeInsets.all(0),
                                  underline: true,
                                  showLinkIcon: false,
                                  showStyle: Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: [
                                        VigaSwitch(
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
                                VigaFunctionItem(
                                  title: l10n.insuranceService,
                                  icon: "$cdnBase/icon/server_icon3.png",
                                  link: '',
                                  // margin: const EdgeInsets.all(0),
                                  underline: false,
                                  showLinkIcon: false,
                                  showStyle: Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: [
                                        VigaSwitch(
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
                              VigaFunctionList(children: [
                                // 交通出行
                                VigaFunctionItem(
                                  title: l10n.transportServices,
                                  icon: "$cdnBase/icon/server_icon10.png",
                                  link: '',
                                  // margin: const EdgeInsets.all(0),
                                  underline: true,
                                  showLinkIcon: false,
                                  showStyle: Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: [
                                        VigaSwitch(
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
                                VigaFunctionItem(
                                  title: l10n.trainAndFlightTickets,
                                  icon: "$cdnBase/icon/server_icon11.png",
                                  link: '',
                                  // margin: const EdgeInsets.all(0),
                                  underline: true,
                                  showLinkIcon: false,
                                  showStyle: Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: [
                                        VigaSwitch(
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
                                VigaFunctionItem(
                                  title: l10n.didiRideHailing,
                                  icon: "$cdnBase/icon/server_icon12.png",
                                  link: '',
                                  // margin: const EdgeInsets.all(0),
                                  underline: true,
                                  showLinkIcon: false,
                                  showStyle: Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: [
                                        VigaSwitch(
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
                                VigaFunctionItem(
                                  title: l10n.hotelAndBAndB,
                                  icon: "$cdnBase/icon/server_icon122.png",
                                  link: '',
                                  // margin: const EdgeInsets.all(0),
                                  underline: false,
                                  showLinkIcon: false,
                                  showStyle: Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: [
                                        VigaSwitch(
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
                              VigaFunctionList(
                                children: [
                                  // 品牌发现
                                  VigaFunctionItem(
                                    title: l10n.brandDiscovery,
                                    icon: "$cdnBase/icon/server_icon13.png",
                                    link: '',
                                    // margin: const EdgeInsets.all(0),
                                    underline: true,
                                    showLinkIcon: false,
                                    showStyle: Expanded(
                                      flex: 0,
                                      child: Row(
                                        children: [
                                          VigaSwitch(
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
                                  VigaFunctionItem(
                                    title: l10n.jdShopping,
                                    icon: "$cdnBase/icon/server_icon14.png",
                                    link: '',
                                    // margin: const EdgeInsets.all(0),
                                    underline: true,
                                    showLinkIcon: false,
                                    showStyle: Expanded(
                                      flex: 0,
                                      child: Row(
                                        children: [
                                          VigaSwitch(
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
                                  VigaFunctionItem(
                                    title: l10n.meituanWaimai,
                                    icon: "$cdnBase/icon/server_icon15.png",
                                    link: '',
                                    // margin: const EdgeInsets.all(0),
                                    underline: true,
                                    showLinkIcon: false,
                                    showStyle: Expanded(
                                      flex: 0,
                                      child: Row(
                                        children: [
                                          VigaSwitch(
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
                                  VigaFunctionItem(
                                    title: l10n.movieTicketsAndEntertainment,
                                    icon: "$cdnBase/icon/server_icon16.png",
                                    link: '',
                                    // margin: const EdgeInsets.all(0),
                                    underline: true,
                                    showLinkIcon: false,
                                    showStyle: Expanded(
                                      flex: 0,
                                      child: Row(
                                        children: [
                                          VigaSwitch(
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
                                  VigaFunctionItem(
                                    title: l10n.meituanSpecialOffers,
                                    icon: "$cdnBase/icon/server_icon15.png",
                                    link: '',
                                    // margin: const EdgeInsets.all(0),
                                    underline: true,
                                    showLinkIcon: false,
                                    showStyle: Expanded(
                                      flex: 0,
                                      child: Row(
                                        children: [
                                          VigaSwitch(
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
                                  VigaFunctionItem(
                                    title: l10n.pinduoduo,
                                    icon: "$cdnBase/icon/server_icon18.png",
                                    link: '',
                                    // margin: const EdgeInsets.all(0),
                                    underline: true,
                                    showLinkIcon: false,
                                    showStyle: Expanded(
                                      flex: 0,
                                      child: Row(
                                        children: [
                                          VigaSwitch(
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
                                  VigaFunctionItem(
                                    title: l10n.vipshop,
                                    icon: "$cdnBase/icon/server_icon19.png",
                                    link: '',
                                    // margin: const EdgeInsets.all(0),
                                    underline: true,
                                    showLinkIcon: false,
                                    showStyle: Expanded(
                                      flex: 0,
                                      child: Row(
                                        children: [
                                          VigaSwitch(
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
                                  VigaFunctionItem(
                                    title: l10n.zhuanzhuanUsedGoods,
                                    icon: "$cdnBase/icon/server_icon20.png",
                                    link: '',
                                    // margin: const EdgeInsets.all(0),
                                    underline: false,
                                    showLinkIcon: false,
                                    showStyle: Expanded(
                                      flex: 0,
                                      child: Row(
                                        children: [
                                          VigaSwitch(
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
      ),
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
