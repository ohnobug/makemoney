import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';
import 'package:vigaviga/widgets/ljn_switch.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';

class LJNServicesManager extends StatefulWidget {
  const LJNServicesManager({super.key});

  @override
  State<LJNServicesManager> createState() => _LJNServicesManagerState();
}

class _LJNServicesManagerState extends State<LJNServicesManager> {
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
          appBar: const LJNAppBar(
            title: "",
          ),
          body: ColoredBox(
            color: AppColors.neutralWhite,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 205.w),
                  color: AppColors.neutralWhite,
                  padding: EdgeInsets.only(left: 60.w, right: 60.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100.w,
                      ),
                      Text(
                        AppLocalizations.of(context)!.serviceManagement,
                        style: TextStyle(
                            fontSize: 40.w,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      SizedBox(
                        height: 35.w,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        AppLocalizations.of(context)!.manageServicesDescription,
                        style: TextStyle(
                            fontSize: 31.w,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      SizedBox(
                        height: 103.w,
                      ),
                      Container(
                        height: 50.w,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1.5.w,
                              color: AppColors.neutralGrey7,
                            ),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.financialServices,
                          style: const TextStyle(
                            color: AppColors.neutralGrey77,
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title:
                            AppLocalizations.of(context)!.creditCardRepayment,
                        icon: "images/icon/server_icon1.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!.weilidaiLoan,
                        icon: "images/icon/discovery_icon4.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!.licaitong,
                        icon: "images/icon/server_icon2.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!.insuranceService,
                        icon: "images/icon/server_icon3.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 55.w,
                      ),
                      Container(
                        height: 50.w,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1.5.w,
                              color: AppColors.neutralGrey7,
                            ),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.transportation,
                          style: const TextStyle(
                            color: AppColors.neutralGrey77,
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!.transportServices,
                        icon: "images/icon/server_icon10.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title:
                            AppLocalizations.of(context)!.trainAndFlightTickets,
                        icon: "images/icon/server_icon11.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!.didiRideHailing,
                        icon: "images/icon/server_icon12.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!.hotelAndBAndB,
                        icon: "images/icon/server_icon122.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 55.w,
                      ),
                      Container(
                        height: 50.w,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1.5.w,
                              color: AppColors.neutralGrey7,
                            ),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.shoppingAndConsumption,
                          style: const TextStyle(
                            color: AppColors.neutralGrey77,
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!.brandDiscovery,
                        icon: "images/icon/server_icon13.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!.jdShopping,
                        icon: "images/icon/server_icon14.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!.meituanWaimai,
                        icon: "images/icon/server_icon15.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!
                            .movieTicketsAndEntertainment,
                        icon: "images/icon/server_icon16.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title:
                            AppLocalizations.of(context)!.meituanSpecialOffers,
                        icon: "images/icon/server_icon15.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!.pinduoduo,
                        icon: "images/icon/server_icon18.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!.vipshop,
                        icon: "images/icon/server_icon19.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title:
                            AppLocalizations.of(context)!.zhuanzhuanUsedGoods,
                        icon: "images/icon/server_icon20.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 150.w)
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
