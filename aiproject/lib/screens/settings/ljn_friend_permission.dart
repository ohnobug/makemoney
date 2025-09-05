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
import 'package:vigaviga/widgets/ljn_vertical_gap.dart';
import '../../widgets/ljn_function_item.dart';

class LJNFriendPermission extends StatefulWidget {
  const LJNFriendPermission({super.key});

  @override
  State<LJNFriendPermission> createState() => _LJNFriendPermission();
}

class _LJNFriendPermission extends State<LJNFriendPermission> {
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
            title: AppLocalizations.of(context)!.friendPermissions,
          ),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      90.w -
                      systemState.statusHeight),
              color: Theme.of(context).colorScheme.surfaceContainer,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!
                          .requireVerificationWhenAdded,
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
                    LJNVerticalGap(
                      height: 16.w,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.waysToAddMe,
                      link: '',
                      underline: true,
                    ),
                    LJNSpecialFunctionItem(
                      title:
                          AppLocalizations.of(context)!.recommendContactsToMe,
                      tapEffect: false,
                      underline: false,
                      height: null,
                      // link: '',
                      subTitle: Text(
                        AppLocalizations.of(context)!
                            .recommendContactsMessageFull,
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
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 64.w,
                      padding:
                          const EdgeInsets.only(left: 30.0, right: 0.0, top: 16)
                              .w,
                      child: Text(
                        AppLocalizations.of(context)!.friendPermissions,
                        style: TextStyle(fontSize: 25.w, height: 1.08),
                      ),
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.chatOnly,
                      link: '',
                      underline: true,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.moments,
                      link: '',
                      underline: true,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.channels,
                      link: '',
                      underline: true,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.look,
                      link: '',
                      underline: true,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.weRun,
                      link: '',
                      underline: true,
                    ),
                    LJNVerticalGap(
                      height: 16.w,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.contactsBlocklist,
                      link: '',
                      underline: false,
                    ),
                    SizedBox(height: 16.w),
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
