import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_alphabet.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';
import 'package:vigaviga/widgets/ljn_switch.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';

class LJNNewMessageNotificationPage extends StatefulWidget {
  const LJNNewMessageNotificationPage({super.key});

  @override
  State<LJNNewMessageNotificationPage> createState() =>
      _LJNNewMessageNotificationPage();
}

class _LJNNewMessageNotificationPage extends State<LJNNewMessageNotificationPage> {
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
          appBar: LJNAppBar(
            title: l10n.newMessageNotifications,
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
                child: Column(
                  children: [
                    // 通知开关
                    LJNFunctionList(
                      title: LJNAlphabet(title: l10n.notificationToggle),
                      children: [
                        // 新消息通知
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.receiveNewMessageNotifications,
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

                        // 接收语音视频通话邀请
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.receiveVoiceVideoCallInvites,
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
                      ],
                    ),

                    // 显示消息详情
                    LJNFunctionList(
                      children: [
                        // 显示消息详情
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.notificationShowMessageDetails,
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
                      ],
                    ),

                    // 声音与震动
                    LJNFunctionList(
                      title: LJNAlphabet(title: l10n.soundAndVibration),
                      children: [
                        // 新消息系统通知
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.newMessageSystemNotification,
                          link: '',
                          underline: true,
                          showStyle: l10n.goToSystemSettings,
                        ),
                        // 语音视频通话提醒
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.voiceVideoCallAlerts,
                          link: '',
                          underline: false,
                          showStyle: l10n.goToSystemSettings,
                        ),
                      ],
                    ),

                    // 铃声与提示音
                    LJNFunctionList(
                      title: LJNAlphabet(title: l10n.alertToneAndRingtone),
                      children: [
                        // 消息铃声
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.messageTone,
                          link: '',
                          underline: true,
                          showStyle: l10n.followSystem,
                        ),

                        // 通话铃声
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.callRingtone,
                          link: '',
                          underline: true,
                          showStyle: "SISTER SISTER",
                        ),

                        // 好友能听到我的铃声
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.friendCanHearMyRingtone,
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
