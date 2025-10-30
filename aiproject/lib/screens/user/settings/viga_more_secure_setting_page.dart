import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';

class VigaMoreSecureSettingPage extends StatefulWidget {
  const VigaMoreSecureSettingPage({super.key});

  @override
  State<VigaMoreSecureSettingPage> createState() => _VigaAaccountAndSecure();
}

class _VigaAaccountAndSecure extends State<VigaMoreSecureSettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<VigaSystemCubit, SystemState>(
      builder: (context, systemState) {
        String cdnBase = systemState.cdnBase;

        return Scaffold(
          primary: false,
          appBar: VigaAppBar(
            title: l10n.moreSecuritySettings,
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
                child: Column(
                  children: [
                    // QQ号、邮箱地址
                    VigaFunctionList(
                      children: [
                        // QQ号
                        VigaFunctionItem(
                          icon: "$cdnBase/avatar/02.png",
                          title: l10n.qqId,
                          link: '/',
                          showStyle: "2281551151",
                          underline: true,
                        ),
                        // 邮箱地址
                        VigaFunctionItem(
                          icon: "$cdnBase/avatar/02.png",
                          title: l10n.emailAddress,
                          link: '/',
                          showStyle: l10n.notBound,
                          underline: false,
                        ),
                      ],
                    ),

                    // 手机安全保护
                    VigaFunctionList(children: [
                      // 手机安全保护
                      VigaFunctionItem(
                        icon: "$cdnBase/avatar/02.png",
                        title: l10n.mobileSecurityProtection,
                        link: '/',
                        underline: false,
                      ),
                    ]),

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
