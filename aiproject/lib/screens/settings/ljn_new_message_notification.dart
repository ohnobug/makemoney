import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/themes.dart';
import 'package:spicychat/l10n/app_localizations.dart';
import 'package:spicychat/screens/components/ljn_appbar.dart';
import 'package:spicychat/screens/components/ljn_switch.dart';
import 'package:spicychat/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import '../components/ljn_function_item.dart';

class LJNNewMessageNotification extends StatefulWidget {
  const LJNNewMessageNotification({super.key});

  @override
  State<LJNNewMessageNotification> createState() =>
      _LJNNewMessageNotification();
}

class _LJNNewMessageNotification extends State<LJNNewMessageNotification> {
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
          appBar: LJNAppBar(
            title: AppLocalizations.of(context)!.newMessageNotifications,
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
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 64.w,
                      padding:
                          const EdgeInsets.only(left: 30.0, right: 0.0, top: 16)
                              .w,
                      child: Text(
                        AppLocalizations.of(context)!.notificationToggle,
                        style: TextStyle(fontSize: 25.w, height: 1.08),
                      ),
                    ),

                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!
                          .receiveNewMessageNotifications,
                      // link: '',
                      underline: true,
                      tapEffect: false,
                      showStyle: Expanded(
                        flex: 0,
                        child: Container(
                          margin: const EdgeInsets.only(right: 32).w,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!
                          .receiveVoiceVideoCallInvites,
                      // link: '',
                      underline: false,
                      tapEffect: false,
                      showStyle: Expanded(
                        flex: 0,
                        child: Container(
                          margin: const EdgeInsets.only(right: 32).w,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.w),

                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!
                          .notificationShowMessageDetails,
                      // link: '',
                      underline: false,
                      tapEffect: false,
                      showStyle: Expanded(
                        flex: 0,
                        child: Container(
                          margin: const EdgeInsets.only(right: 32).w,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      height: 64.w,
                      padding:
                          const EdgeInsets.only(left: 30.0, right: 0.0, top: 16)
                              .w,
                      child: Text(
                        AppLocalizations.of(context)!.soundAndVibration,
                        style: TextStyle(fontSize: 25.w, height: 1.08),
                      ),
                    ),

                    // 声音与震动
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!
                          .newMessageSystemNotification,
                      link: '',
                      underline: true,
                      showStyle:
                          AppLocalizations.of(context)!.goToSystemSettings,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.voiceVideoCallAlerts,
                      link: '',
                      underline: false,
                      showStyle:
                          AppLocalizations.of(context)!.goToSystemSettings,
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      height: 64.w,
                      padding:
                          const EdgeInsets.only(left: 30.0, right: 0.0, top: 16)
                              .w,
                      child: Text(
                        AppLocalizations.of(context)!.alertToneAndRingtone,
                        style: TextStyle(fontSize: 25.w, height: 1.08),
                      ),
                    ),

                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.messageTone,
                      link: '',
                      underline: true,
                      showStyle: AppLocalizations.of(context)!.followSystem,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.callRingtone,
                      link: '',
                      underline: true,
                      showStyle: "SISTER SISTER",
                    ),
                    LJNFunctionItem(
                      title:
                          AppLocalizations.of(context)!.friendCanHearMyRingtone,
                      // link: '',
                      underline: false,
                      tapEffect: false,
                      showStyle: Expanded(
                        flex: 0,
                        child: Container(
                          margin: const EdgeInsets.only(right: 32).w,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.w),
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
