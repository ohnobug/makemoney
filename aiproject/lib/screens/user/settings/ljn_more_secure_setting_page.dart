import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';

class LJNMoreSecureSettingPage extends StatefulWidget {
  const LJNMoreSecureSettingPage({super.key});

  @override
  State<LJNMoreSecureSettingPage> createState() => _LJNAaccountAndSecure();
}

class _LJNAaccountAndSecure extends State<LJNMoreSecureSettingPage> {
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
                    LJNFunctionList(
                      children: [
                        // QQ号
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.qqId,
                          link: '/',
                          showStyle: "2281551151",
                          underline: true,
                        ),
                        // 邮箱地址
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.emailAddress,
                          link: '/',
                          showStyle: l10n.notBound,
                          underline: false,
                        ),
                      ],
                    ),

                    // 手机安全保护
                    LJNFunctionList(children: [
                      // 手机安全保护
                      LJNFunctionItem(
                        icon: "images/avatar/02.png",
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
