import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/screens/components/ljn_appbar.dart';
import 'package:vigaviga/screens/components/ljn_switch.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import '../components/ljn_function_item.dart';

class LJNCommonSetting extends StatefulWidget {
  const LJNCommonSetting({super.key});

  @override
  State<LJNCommonSetting> createState() => _LJNCommonSetting();
}

class _LJNCommonSetting extends State<LJNCommonSetting> {
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
            title: AppLocalizations.of(context)!.generalSettings,
          ),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 64.w,
                    padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
                    child: Text(
                      AppLocalizations.of(context)!.interfaceAndDisplay,
                      style: TextStyle(fontSize: 25.w, height: 1.08),
                    ),
                  ),
                  LJNFunctionItem(
                    title: AppLocalizations.of(context)!.darkMode,
                    link: '',
                    underline: true,
                    tapEffect: true,
                    showStyle: AppLocalizations.of(context)!.followSystem,
                  ),
                  LJNFunctionItem(
                    title: AppLocalizations.of(context)!.enableLandscapeMode,
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
                  LJNFunctionItem(
                    title: AppLocalizations.of(context)!.action_enable_nfc,
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
                        .autoDownloadWeChatInstaller,
                    link: '',
                    underline: true,
                    tapEffect: true,
                    showStyle:
                        AppLocalizations.of(context)!.network_option_wifi_only,
                  ),
                  LJNFunctionItem(
                    title: AppLocalizations.of(context)!.multiLanguage,
                    link: '',
                    underline: true,
                    tapEffect: true,
                    showStyle: AppLocalizations.of(context)!.followSystem,
                  ),
                  LJNFunctionItem(
                    title: AppLocalizations.of(context)!.transfer,
                    link: '',
                    underline: false,
                    tapEffect: true,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 64.w,
                    padding:
                        const EdgeInsets.only(left: 30.0, right: 0.0, top: 16)
                            .w,
                    child: Text(
                      AppLocalizations.of(context)!.other,
                      style: TextStyle(fontSize: 25.w, height: 1.08),
                    ),
                  ),
                  LJNFunctionItem(
                    title: AppLocalizations.of(context)!.storageSpace,
                    link: '',
                    underline: true,
                  ),
                  LJNFunctionItem(
                    title: AppLocalizations.of(context)!.fontSize,
                    link: '',
                    underline: true,
                  ),
                  LJNFunctionItem(
                    title: AppLocalizations.of(context)!.musicAndAudio,
                    link: '',
                    underline: true,
                  ),
                  LJNFunctionItem(
                    title: AppLocalizations.of(context)!.permission_list_items,
                    link: '',
                    underline: true,
                  ),
                  LJNFunctionItem(
                    title: AppLocalizations.of(context)!.discoverPageManagement,
                    link: '',
                    underline: true,
                  ),
                  LJNFunctionItem(
                    title: AppLocalizations.of(context)!.accessibility,
                    link: '',
                    underline: false,
                  ),
                  SizedBox(height: 16.w),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
