import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_special_function_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import '../../widgets/ljn_function_item.dart';

class LJNLoggedDevices extends StatefulWidget {
  const LJNLoggedDevices({super.key});

  @override
  State<LJNLoggedDevices> createState() => _LJNLoggedDevices();
}

class _LJNLoggedDevices extends State<LJNLoggedDevices> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LJNSystemCubit>().updateHomescrollpixels(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final myDate = DateTime(2023, 11, 10, 15, 23);
    final locale = Localizations.localeOf(context).toString();
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    final formatter = DateFormat('M月d日 ahh:mm', locale);
    final formattedString = formatter.format(myDate);

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false,
          appBar: LJNAppBar(
              title: l10n.loggedInDevices,
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/bind_new_phone_number');
                  },
                  child: Container(
                    // color: theme.colorScheme.onSurface,
                    height: 90.w,
                    padding: EdgeInsets.only(right: 40.w),
                    alignment: Alignment.center,
                    child: Text(
                      l10n.edit,
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                          color: theme.colorScheme.onSurface,
                          fontSize: 32.w,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                )
              ]),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      90.w -
                      systemState.statusHeight),
              color: theme.colorScheme.surfaceContainer,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Text(
                        AppLocalizations.of(context)!
                            .manageLoginDevicesDescriptionFull,
                        style: TextStyle(
                          fontSize: 27.w,
                          color: AppColors.neutralGrey60,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 64.w,
                      padding: EdgeInsets.only(
                          left: 30.0.w, right: 0.0.w, top: 16.w),
                      child: Text(
                        l10n.currentlyLoggedInDevices,
                        style: TextStyle(
                          fontSize: 25.w,
                          height: 1.08,
                          color: AppColors.neutralDarkGrey13,
                        ),
                      ),
                    ),
                    LJNFunctionItem(
                      // height: 150.w,
                      title: "HONOR-RNA-AN100",
                      link: '/device_detail',
                      underline: true,
                      showStyle: Expanded(
                        flex: 0,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 375.w),
                          child: Text(
                            l10n.currentDevice,
                            textAlign: TextAlign.end,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 25.w,
                              height: 1.08,
                              color: AppColors.neutralGrey39,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const LJNFunctionItem(
                      // height: 150.w,
                      title: "iphone20",
                      link: '/device_detail',
                      underline: false,
                      // showStyle: "当前设备"
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 64.w,
                      padding:
                          const EdgeInsets.only(left: 30.0, right: 0.0, top: 16)
                              .w,
                      child: Text(
                        l10n.loggedOutDevices,
                        style: TextStyle(
                          fontSize: 25.w,
                          height: 1.08,
                          color: AppColors.neutralDarkGrey13,
                        ),
                      ),
                    ),
                    LJNSpecialFunctionItem(
                      height: 150.w,
                      title: "HONOR-RNA-AN100",
                      link: '/device_detail',
                      underline: true,
                      subTitle: Text(
                        formattedString,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.neutralGrey35,
                          fontSize: 24.w,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "AlibabaPuHuiTi",
                        ),
                      ),
                    ),
                    LJNSpecialFunctionItem(
                      height: 150.w,
                      title: "HONOR-RNA-AN100",
                      link: '/device_detail',
                      underline: true,
                      subTitle: Text(
                        formattedString,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.neutralGrey35,
                          fontSize: 24.w,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "AlibabaPuHuiTi",
                        ),
                      ),
                    ),
                    LJNSpecialFunctionItem(
                      height: 150.w,
                      title: "HONOR-RNA-AN100",
                      link: '/device_detail',
                      underline: true,
                      subTitle: Text(
                        formattedString,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.neutralGrey35,
                          fontSize: 24.w,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "AlibabaPuHuiTi",
                        ),
                      ),
                    ),
                    LJNSpecialFunctionItem(
                      height: 150.w,
                      title: "HONOR-RNA-AN100",
                      link: '/device_detail',
                      underline: true,
                      subTitle: Text(
                        formattedString,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.neutralGrey35,
                          fontSize: 24.w,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "AlibabaPuHuiTi",
                        ),
                      ),
                    ),
                    LJNSpecialFunctionItem(
                      height: 150.w,
                      title: "HONOR-RNA-AN100",
                      link: '/device_detail',
                      underline: true,
                      subTitle: Text(
                        formattedString,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.neutralGrey35,
                          fontSize: 24.w,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "AlibabaPuHuiTi",
                        ),
                      ),
                    ),
                    LJNSpecialFunctionItem(
                      height: 150.w,
                      title: "HONOR-RNA-AN100",
                      link: '/device_detail',
                      underline: true,
                      subTitle: Text(
                        formattedString,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.neutralGrey35,
                          fontSize: 24.w,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "AlibabaPuHuiTi",
                        ),
                      ),
                    ),
                    LJNSpecialFunctionItem(
                      height: 150.w,
                      title: "HONOR-RNA-AN100",
                      link: '/device_detail',
                      underline: true,
                      subTitle: Text(
                        formattedString,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.neutralGrey35,
                          fontSize: 24.w,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "AlibabaPuHuiTi",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
