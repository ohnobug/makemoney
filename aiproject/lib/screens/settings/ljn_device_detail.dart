import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_max_width_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';

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
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    final DateTime theTimestamp = DateTime(2024, 11, 10, 15, 23);

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false,
          appBar: LJNAppBar(
            title: l10n.deviceDetails,
          ),
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
                child: Column(children: [
                  // 设备详情
                  LJNFunctionList(children: [
                    // 设备名称
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
                      // height: 150.w,
                      title: l10n.deviceName,
                      link: '',
                      tapEffect: true,
                      underline: true,
                      showStyle: Expanded(
                        flex: 1,
                        child: Text(
                          l10n.currentDevice,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 32.w,
                            height: 1.08,
                            color: AppColors.neutralGrey39,
                          ),
                        ),
                      ),
                    ),

                    // 设备类型
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
                      // height: 150.w,
                      title: l10n.deviceType,
                      // link: '',
                      tapEffect: false,
                      underline: false,
                      showStyle: Expanded(
                        flex: 1,
                        child: Container(
                          // color: Colors.red,
                          margin: EdgeInsets.only(right: 30.w),
                          child: Text(
                            "Windows 11 x64",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 32.w,
                              height: 1.08,
                              color: AppColors.neutralGrey39,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),

                  // 最后活跃时间
                  LJNFunctionList(children: [
                    // 最后活跃时间
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
                      // height: 150.w,
                      title: l10n.lastActiveTime,
                      // link: '',
                      tapEffect: false,
                      underline: false,
                      showStyle: Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(right: 30.w),
                          child: Text(
                            l10n.monthDayTime(theTimestamp),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 32.w,
                              height: 1.08,
                              color: AppColors.neutralGrey39,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),

                  Container(
                    margin: EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 22,
                      bottom: 22,
                    ).w,
                    child: Text(
                      l10n.device_management_auto_extend_login_info_friendly,
                      style: TextStyle(
                        fontSize: 27.w,
                        color: AppColors.neutralGrey60,
                      ),
                    ),
                  ),

                  // 删除设备
                  LJNFunctionList(
                    children: [
                      LJNMaxWidthButton(
                        title: l10n.deleteThisDevice,
                        color: AppColors.accentRedPure,
                        link: '',
                        underline: false,
                      ),
                    ],
                  ),

                  SizedBox(height: 100.w),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
