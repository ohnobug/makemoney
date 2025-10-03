import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_alphabet.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_switch.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import '../../widgets/ljn_function_item.dart';

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
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false,
          appBar: LJNAppBar(
            title: l10n.generalSettings,
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
                    // 界面与显示
                    LJNFunctionList(
                      title: LJNAlphabet(title: l10n.interfaceAndDisplay),
                      children: [
                        // 深色模式
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.darkMode,
                          link: '',
                          underline: true,
                          tapEffect: true,
                          showStyle: l10n.followSystem,
                        ),

                        // 横屏模式
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.enableLandscapeMode,
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

                        // NFC
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.action_enable_nfc,
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

                        // 自动下载Vigaviga安装包
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.autoDownloadVigavigaInstaller,
                          link: '',
                          underline: true,
                          tapEffect: true,
                          showStyle: l10n.network_option_wifi_only,
                        ),

                        // 多语言
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.multiLanguage,
                          link: '',
                          underline: true,
                          tapEffect: true,
                          showStyle: l10n.followSystem,
                        ),

                        // 转发
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.transfer,
                          link: '',
                          underline: false,
                          tapEffect: true,
                        ),
                      ],
                    ),

                    // 其他
                    LJNFunctionList(
                      title: LJNAlphabet(title: l10n.other),
                      children: [
                        // 存储空间
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.storageSpace,
                          link: '',
                          underline: true,
                        ),
                        // 字体大小
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.fontSize,
                          link: '',
                          underline: true,
                        ),
                        // 声音与音频
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.musicAndAudio,
                          link: '',
                          underline: true,
                        ),
                        // 权限管理
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.permission_list_items,
                          link: '',
                          underline: true,
                        ),
                        // 发行页面管理
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.discoverPageManagement,
                          link: '',
                          underline: true,
                        ),
                        // 辅助功能
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.accessibility,
                          link: '',
                          underline: false,
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
