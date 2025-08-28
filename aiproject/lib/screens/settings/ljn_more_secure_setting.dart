import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/l10n/app_localizations.dart';
import 'package:spicychat/screens/components/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import '../components/ljn_function_item.dart';

class LJNMoreSecureSetting extends StatefulWidget {
  const LJNMoreSecureSetting({super.key});

  @override
  State<LJNMoreSecureSetting> createState() => _LJNAaccountAndSecure();
}

class _LJNAaccountAndSecure extends State<LJNMoreSecureSetting> {
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
            title: AppLocalizations.of(context)!.moreSecuritySettings,
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
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.qqId,
                      link: '/',
                      showStyle: "2281551151",
                      underline: true,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.emailAddress,
                      link: '/',
                      showStyle: AppLocalizations.of(context)!.notBound,
                      underline: false,
                    ),
                    SizedBox(height: 16.w),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!
                          .mobileSecurityProtection,
                      link: '/',
                      underline: false,
                    ),
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
