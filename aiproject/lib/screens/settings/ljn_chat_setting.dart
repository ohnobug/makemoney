import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_alphabet.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_special_function_item.dart';
import 'package:vigaviga/widgets/ljn_switch.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import '../../widgets/ljn_function_item.dart';

class LJNChatSetting extends StatefulWidget {
  const LJNChatSetting({super.key});

  @override
  State<LJNChatSetting> createState() => _LJNChatSetting();
}

class _LJNChatSetting extends State<LJNChatSetting> {
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
          title: l10n.chat,
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
                LJNFunctionList(
                  children: [
                    // 使用听筒播放语音
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
                      title: l10n.useEarpieceToPlayVoice,
                      // link: '',
                      underline: true,
                      tapEffect: false,
                      showStyle: Expanded(
                        flex: 0,
                        child: Container(
                          margin: const EdgeInsets.only(right: 32).w,
                          child: LJNSwitch(
                            initialValue: false,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                    ),

                    // 使用独立发送按钮
                    LJNSpecialFunctionItem(
                      title: l10n.useIndependentSendButton,
                      height: null,
                      // link: '',
                      subTitle: Text(
                        l10n.sendButtonReplacedMessageFull,
                        maxLines: 3,
                        style: TextStyle(
                          color: AppColors.neutralGrey35,
                          fontSize: 24.w,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "AlibabaPuHuiTi",
                        ),
                      ),
                      showStyle: Expanded(
                        flex: 0,
                        child: Container(
                          margin: const EdgeInsets.only(right: 0).w,
                          child: LJNSwitch(
                            initialValue: false,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      underline: true,
                    ),

                    // 聊天背景
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
                      title: l10n.chatBackground,
                      link: '',
                      underline: true,
                    ),

                    // 表情管理
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
                      title: l10n.stickerManagement,
                      link: '',
                      underline: false,
                    ),
                  ],
                ),

                // 聊天记录迁移备份
                LJNFunctionList(
                  title: LJNAlphabet(title: l10n.chatHistory),
                  children: [
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
                      title: l10n.chatHistoryMigrationBackup,
                      link: '',
                      underline: true,
                    ),
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
                      title: l10n.clearChatHistory,
                      link: '',
                      underline: false,
                    ),
                  ],
                ),

                SizedBox(height: 100.w)
              ]),
            ),
          ),
        ),
      );
    });
  }
}
