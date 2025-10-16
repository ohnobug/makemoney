import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_alphabet.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';
import 'package:vigaviga/widgets/ljn_special_function_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';

class LJNLoggedDevicesPage extends StatefulWidget {
  const LJNLoggedDevicesPage({super.key});

  @override
  State<LJNLoggedDevicesPage> createState() => _LJNLoggedDevicesPage();
}

class _LJNLoggedDevicesPage extends State<LJNLoggedDevicesPage> {
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
        String cdnBase = systemState.cdnBase;

        return Scaffold(
          primary: false,
          appBar: LJNAppBar(title: l10n.loggedInDevices, actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/settings/security/bind_phone');
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
                      systemState.appbarHeight -
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
                        l10n.manageLoginDevicesDescriptionFull,
                        style: TextStyle(
                          fontSize: 27.w,
                          color: AppColors.neutralGrey60,
                        ),
                      ),
                    ),

                    // 当前设备
                    LJNFunctionList(
                      title: LJNAlphabet(title: l10n.currentlyLoggedInDevices),
                      children: [
                        LJNFunctionItem(
                          icon: "$cdnBase/avatar/02.png",
                          // height: 150.w,
                          title: "HONOR-RNA-AN100",
                          link: '/settings/device_detail',
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
                          link: '/settings/device_detail',
                          underline: false,
                          // showStyle: "当前设备"
                        ),
                      ],
                    ),

                    // 登出设备
                    LJNFunctionList(
                      title: LJNAlphabet(title: l10n.loggedOutDevices),
                      children: [
                        LJNSpecialFunctionItem(
                          height: 150.w,
                          title: "HONOR-RNA-AN100",
                          link: '/settings/device_detail',
                          underline: true,
                          subTitle: Text(
                            formattedString,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.neutralGrey35,
                              fontSize: 24.w,
                              overflow: TextOverflow.ellipsis,
                              
                            ),
                          ),
                        ),
                        LJNSpecialFunctionItem(
                          height: 150.w,
                          title: "HONOR-RNA-AN100",
                          link: '/settings/device_detail',
                          underline: true,
                          subTitle: Text(
                            formattedString,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.neutralGrey35,
                              fontSize: 24.w,
                              overflow: TextOverflow.ellipsis,
                              
                            ),
                          ),
                        ),
                        LJNSpecialFunctionItem(
                          height: 150.w,
                          title: "HONOR-RNA-AN100",
                          link: '/settings/device_detail',
                          underline: true,
                          subTitle: Text(
                            formattedString,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.neutralGrey35,
                              fontSize: 24.w,
                              overflow: TextOverflow.ellipsis,
                              
                            ),
                          ),
                        ),
                        LJNSpecialFunctionItem(
                          height: 150.w,
                          title: "HONOR-RNA-AN100",
                          link: '/settings/device_detail',
                          underline: true,
                          subTitle: Text(
                            formattedString,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.neutralGrey35,
                              fontSize: 24.w,
                              overflow: TextOverflow.ellipsis,
                              
                            ),
                          ),
                        ),
                        LJNSpecialFunctionItem(
                          height: 150.w,
                          title: "HONOR-RNA-AN100",
                          link: '/settings/device_detail',
                          underline: true,
                          subTitle: Text(
                            formattedString,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.neutralGrey35,
                              fontSize: 24.w,
                              overflow: TextOverflow.ellipsis,
                              
                            ),
                          ),
                        ),
                        LJNSpecialFunctionItem(
                          height: 150.w,
                          title: "HONOR-RNA-AN100",
                          link: '/settings/device_detail',
                          underline: true,
                          subTitle: Text(
                            formattedString,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.neutralGrey35,
                              fontSize: 24.w,
                              overflow: TextOverflow.ellipsis,
                              
                            ),
                          ),
                        ),
                        LJNSpecialFunctionItem(
                          height: 150.w,
                          title: "HONOR-RNA-AN100",
                          link: '/settings/device_detail',
                          underline: true,
                          subTitle: Text(
                            formattedString,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.neutralGrey35,
                              fontSize: 24.w,
                              overflow: TextOverflow.ellipsis,
                              
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 100.w)
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
