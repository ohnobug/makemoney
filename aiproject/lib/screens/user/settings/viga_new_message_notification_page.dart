import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_alphabet.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';
import 'package:vigaviga/widgets/viga_switch.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';

class VigaNewMessageNotificationPage extends StatefulWidget {
  const VigaNewMessageNotificationPage({super.key});

  @override
  State<VigaNewMessageNotificationPage> createState() =>
      _VigaNewMessageNotificationPage();
}

class _VigaNewMessageNotificationPage
    extends State<VigaNewMessageNotificationPage> {
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
          return Scaffold(
            primary: false,
            appBar: VigaAppBar(
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
                      VigaFunctionList(
                        title: VigaAlphabet(title: l10n.notificationToggle),
                        children: [
                          // 新消息通知
                          VigaFunctionItem(
                            icon: null,
                            title: l10n.receiveNewMessageNotifications,
                            // link: '',
                            underline: true,
                            tapEffect: false,
                            showStyle: Expanded(
                              flex: 0,
                              child: Container(
                                margin: const EdgeInsets.only(right: 32).w,
                                child: VigaSwitch(
                                  initialValue: true,
                                  onChanged: (value) {
                                    logger.info(value);
                                  },
                                ),
                              ),
                            ),
                          ),

                          // 接收语音视频通话邀请
                          VigaFunctionItem(
                            icon: null,
                            title: l10n.receiveVoiceVideoCallInvites,
                            // link: '',
                            underline: false,
                            tapEffect: false,
                            showStyle: Expanded(
                              flex: 0,
                              child: Container(
                                margin: const EdgeInsets.only(right: 32).w,
                                child: VigaSwitch(
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
                      VigaFunctionList(
                        children: [
                          // 显示消息详情
                          VigaFunctionItem(
                            icon: null,
                            title: l10n.notificationShowMessageDetails,
                            // link: '',
                            underline: false,
                            tapEffect: false,
                            showStyle: Expanded(
                              flex: 0,
                              child: Container(
                                margin: const EdgeInsets.only(right: 32).w,
                                child: VigaSwitch(
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
                      VigaFunctionList(
                        title: VigaAlphabet(title: l10n.soundAndVibration),
                        children: [
                          // 新消息系统通知
                          VigaFunctionItem(
                            icon: null,
                            title: l10n.newMessageSystemNotification,
                            link: '',
                            underline: true,
                            // showStyle: l10n.goToSystemSettings,
                          ),
                          // 语音视频通话提醒
                          VigaFunctionItem(
                            icon: null, title: l10n.voiceVideoCallAlerts,
                            link: '',
                            underline: false,
                            // showStyle: l10n.goToSystemSettings,
                          ),
                        ],
                      ),

                      // 铃声与提示音
                      VigaFunctionList(
                        title: VigaAlphabet(title: l10n.alertToneAndRingtone),
                        children: [
                          // 消息铃声
                          VigaFunctionItem(
                            icon: null,
                            title: l10n.messageTone,
                            link: '',
                            underline: true,
                            showStyle: l10n.followSystem,
                          ),

                          // 通话铃声
                          VigaFunctionItem(
                            icon: null,
                            title: l10n.callRingtone,
                            link: '',
                            underline: true,
                            showStyle: "SISTER SISTER",
                          ),

                          // 好友能听到我的铃声
                          VigaFunctionItem(
                            icon: null, title: l10n.friendCanHearMyRingtone,
                            // link: '',
                            underline: false,
                            tapEffect: false,
                            showStyle: Expanded(
                              flex: 0,
                              child: Container(
                                margin: const EdgeInsets.only(right: 32).w,
                                child: VigaSwitch(
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
      ),
    );
  }
}
