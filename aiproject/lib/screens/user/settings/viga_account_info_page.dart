import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_change_account_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';

class VigaAccountInfoPage extends StatefulWidget {
  const VigaAccountInfoPage({super.key});

  @override
  State<VigaAccountInfoPage> createState() => _VigaAccountInfoPage();
}

class _VigaAccountInfoPage extends State<VigaAccountInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  // 另起一个函数方便管理
  Widget _buildPage(SystemState systemState) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Theme(
        data: theme.copyWith(
          appBarTheme: theme.appBarTheme.copyWith(
            backgroundColor: Colors.transparent,
          ),
        ),
        child: Scaffold(
          primary: false,
          appBar: const VigaAppBar(),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      systemState.appbarHeight -
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

                      BlocBuilder<VigaUserCubit, UserState>(
                        builder: (context, userState) {
                          return Text(
                            l10n.vigavigaIdDisplay(userState.userinfoAccount!),
                            style: TextStyle(
                              fontSize: 40.w,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),

                      SizedBox(
                        height: 45.w,
                      ),
                      Text(
                        l10n.vigavigaIdModificationRuleFull,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.w,
                        ),
                      ),

                      SizedBox(
                        height: 620.h,
                        child: null,
                      ),

                      // 修改Vigaviga号
                      Container(
                        padding: EdgeInsets.only(bottom: 180.w),
                        child: VigaChangeAccountButton(
                          title: l10n.changeVigavigaID,
                          link: "/verification",
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
