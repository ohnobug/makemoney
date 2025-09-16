import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_change_account_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';

class LJNAccountInfo extends StatefulWidget {
  const LJNAccountInfo({super.key});

  @override
  State<LJNAccountInfo> createState() => _LJNAccountInfo();
}

class _LJNAccountInfo extends State<LJNAccountInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  // 另起一个函数方便管理
  Widget _buildPage(SystemState systemState) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return Theme(
      data: theme.copyWith(
        appBarTheme: theme.appBarTheme.copyWith(
          backgroundColor: AppColors.transparent,
        ),
      ),
      child: Scaffold(
        primary: false,
        appBar: const LJNAppBar(),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    90.w -
                    systemState.statusHeight),
            color: AppColors.neutralWhite,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Container(
                width: 750.w,
                padding: EdgeInsets.only(left: 70.w, right: 70.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // color: AppColors.accentRedPure,
                      height: 300.w,
                      alignment: Alignment.bottomCenter,
                      child: Icon(
                        color: AppColors.neutralGrey32,
                        const IconData(
                          0xe883,
                          fontFamily: 'Iconfont',
                        ),
                        size: 140.w, // 图标大小
                      ),
                    ),
                    SizedBox(
                      height: 50.w,
                    ),

                    BlocBuilder<LJNUserCubit, LJNUserState>(
                      builder: (context, userState) {
                        return Text(
                          l10n.wechatIdDisplay(userState.userinfoAccount!),
                          style: TextStyle(
                              fontSize: 40.w,
                              fontWeight: FontWeight.bold,
                              fontFamily: "AlibabaPuHuiTi"),
                        );
                      },
                    ),

                    SizedBox(
                      height: 45.w,
                    ),
                    Text(
                      l10n.wechatIdModificationRuleFull,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30.w, fontFamily: "AlibabaPuHuiTi"),
                    ),

                    SizedBox(
                      height: 620.h,
                      child: null,
                    ),

                    // 修改微信号
                    Container(
                      padding: EdgeInsets.only(bottom: 180.w),
                      child: LJNChangeAccountButton(
                        title: l10n.changeWechatID,
                        link: "/change_account",
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
