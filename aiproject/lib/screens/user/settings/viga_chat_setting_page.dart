import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_alphabet.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';
import 'package:vigaviga/widgets/viga_special_function_item.dart';
import 'package:vigaviga/widgets/viga_switch.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';

class VigaChatSettingPage extends StatefulWidget {
  const VigaChatSettingPage({super.key});

  @override
  State<VigaChatSettingPage> createState() => _VigaChatSettingPage();
}

class _VigaChatSettingPage extends State<VigaChatSettingPage> {
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
              title: l10n.chat,
            ),
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
                  child: Column(children: [
                    VigaFunctionList(
                      children: [
                        // 使用听筒播放语音
                        VigaFunctionItem(
                          icon: null, title: l10n.useEarpieceToPlayVoice,
                          // link: '',
                          underline: true,
                          tapEffect: false,
                          showStyle: Expanded(
                            flex: 0,
                            child: Container(
                              margin: const EdgeInsets.only(right: 32).w,
                              child: VigaSwitch(
                                initialValue: false,
                                onChanged: (value) {
                                  logger.info(value);
                                },
                              ),
                            ),
                          ),
                        ),

                        // 使用独立发送按钮
                        VigaSpecialFunctionItem(
                          title: l10n.useIndependentSendButton,
                          height: null,
                          // link: '',
                          subTitle: Text(
                            l10n.sendButtonReplacedMessageFull,
                            maxLines: 3,
                            style: TextStyle(
                              color: AppColors.neutralGrey37,
                              fontSize: 28.w,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          showStyle: VigaSwitch(
                            initialValue: false,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                          underline: true,
                        ),

                        // 聊天背景
                        VigaFunctionItem(
                          icon: null,
                          title: l10n.chatBackground,
                          link: '',
                          underline: true,
                        ),

                        // 表情管理
                        VigaFunctionItem(
                          icon: null,
                          title: l10n.stickerManagement,
                          link: '',
                          underline: false,
                        ),
                      ],
                    ),

                    // 聊天记录迁移备份
                    VigaFunctionList(
                      title: VigaAlphabet(title: l10n.chatHistory),
                      children: [
                        VigaFunctionItem(
                          icon: null,
                          title: l10n.chatHistoryMigrationBackup,
                          link: '',
                          underline: true,
                        ),
                        VigaFunctionItem(
                          icon: null,
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
        },
      ),
    );
  }
}
