import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
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
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return Scaffold(
        primary: false,
        appBar: LJNAppBar(
          title: AppLocalizations.of(context)!.chat,
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    90.w -
                    systemState.statusHeight),
            color: Theme.of(context).colorScheme.surface,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(children: [
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.useEarpieceToPlayVoice,
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
                LJNSpecialFunctionItem(
                  title: AppLocalizations.of(context)!.useIndependentSendButton,
                  height: null,
                  // link: '',
                  subTitle: Text(
                    AppLocalizations.of(context)!.sendButtonReplacedMessageFull,
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
                      margin: const EdgeInsets.only(right: 32).w,
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
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.chatBackground,
                  link: '',
                  underline: true,
                ),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.stickerManagement,
                  link: '',
                  underline: false,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 64.w,
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    right: 0.0,
                    top: 16,
                  ).w,
                  child: Text(
                    AppLocalizations.of(context)!.chatHistory,
                    style: TextStyle(
                      fontSize: 25.w,
                      height: 1.08,
                    ),
                  ),
                ),
                LJNFunctionItem(
                  title:
                      AppLocalizations.of(context)!.chatHistoryMigrationBackup,
                  link: '',
                  underline: true,
                ),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.clearChatHistory,
                  link: '',
                  underline: false,
                ),
                SizedBox(height: 16.w),
              ]),
            ),
          ),
        ),
      );
    });
  }
}
