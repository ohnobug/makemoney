import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/l10n/app_localizations.dart';
import 'package:spicychat/screens/components/ljn_appbar.dart';
import 'package:spicychat/screens/components/ljn_max_width_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import '../components/ljn_function_item.dart';

class LJNDeviceDetail extends StatefulWidget {
  const LJNDeviceDetail({super.key});

  @override
  State<LJNDeviceDetail> createState() => _LJNDeviceDetail();
}

class _LJNDeviceDetail extends State<LJNDeviceDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime theTimestamp = DateTime(2024, 11, 10, 15, 23);

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false,
          appBar: LJNAppBar(
            title: AppLocalizations.of(context)!.deviceDetails,
          ),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      90.w -
                      systemState.statusHeight),
              color: AppColors.neutralGrey11,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(children: [
                  LJNFunctionItem(
                    // height: 150.w,

                    title: AppLocalizations.of(context)!.deviceName,
                    link: '',
                    tapEffect: true,
                    underline: true,
                    showStyle: Expanded(
                      flex: 1,
                      child: Text(
                        AppLocalizations.of(context)!.currentDevice,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 32.w,
                          height: 1.08,
                          color: AppColors.neutralGrey39,
                        ),
                      ),
                    ),
                  ),
                  LJNFunctionItem(
                    // height: 150.w,

                    title: AppLocalizations.of(context)!.deviceType,
                    // link: '',
                    tapEffect: false,
                    underline: false,
                    showStyle: Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(right: 30.w),
                        child: Text(
                          "Windows 11 x64",
                          style: TextStyle(
                            fontSize: 32.w,
                            height: 1.08,
                            color: AppColors.neutralGrey39,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.w,
                  ),
                  LJNFunctionItem(
                    // height: 150.w,

                    title: AppLocalizations.of(context)!.lastActiveTime,
                    // link: '',
                    tapEffect: false,
                    underline: false,
                    showStyle: Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(right: 30.w),
                        child: Text(
                          AppLocalizations.of(context)!
                              .monthDayTime(theTimestamp),
                          style: TextStyle(
                            fontSize: 32.w,
                            height: 1.08,
                            color: AppColors.neutralGrey39,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 30.w, right: 30.w, top: 22.w, bottom: 22.w),
                    child: Text(
                      AppLocalizations.of(context)!
                          .device_management_auto_extend_login_info_friendly,
                      style: TextStyle(
                        fontSize: 27.w,
                        color: AppColors.neutralGrey60,
                      ),
                    ),
                  ),
                  LJNMaxWidthButton(
                    title: AppLocalizations.of(context)!.deleteThisDevice,
                    color: AppColors.accentRedPure,
                    link: '',
                    underline: false,
                  ),
                  SizedBox(height: 106.w),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
