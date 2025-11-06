import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';

class VigaVerifyPhonePage extends StatefulWidget {
  const VigaVerifyPhonePage({super.key});

  @override
  State<VigaVerifyPhonePage> createState() => _VigaVerifyPhonePage();
}

class _VigaVerifyPhonePage extends State<VigaVerifyPhonePage> {
  bool isHide = true;

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
          return BlocBuilder<VigaUserCubit, UserState>(
            builder: (context, userState) {
              String phone = userState.userinfoPhone is String
                  ? userState.userinfoPhone!
                  : "";

              if (isHide) {
                phone =
                    '${phone.substring(0, 6)}${'*' * (phone.length - 10)}${phone.substring(phone.length - 4, phone.length)}';
              }

              return Scaffold(
                primary: false,
                resizeToAvoidBottomInset: false,
                appBar: VigaAppBar(
                  title: l10n.verifyPhoneNumber,
                  actions: [
                    VigaAppBarActionTextButton(
                      onTap: () {
                        context.push('/settings/security/bind_phone');
                      },
                      title: l10n.nextStep,
                    ),
                  ],
                ),
                body: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height -
                            systemState.appbarHeight -
                            systemState.statusHeight),
                    color: theme.colorScheme.surfaceContainer,
                    child: SingleChildScrollView(
                      primary: false,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: 70.w,
                              left: 40.w,
                              right: 40.w,
                            ),
                            child: Text(
                              l10n.phoneNumberBindingDescriptionFull,
                              style: TextStyle(
                                fontSize: 26.0.w,
                                color: AppColors.neutralGrey58,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45.w,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 50.w,
                              right: 50.w,
                            ),
                            height: 95.w,
                            width: 750.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 95.w,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: theme.dividerColor,
                                        width: 1.0.w,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "+86",
                                        style: TextStyle(
                                          fontSize: 24.w,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      ),
                                      Text(
                                        l10n.mainlandChina,
                                        style: TextStyle(
                                          fontSize: 15.w,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    style: TextStyle(
                                      fontSize: 30.w,
                                    ),
                                    autofocus: true,
                                    cursorColor: AppColors.brandGreenDarker4,
                                    cursorWidth: 1.w,
                                    onTapOutside: (event) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    decoration: InputDecoration(
                                      hintText: l10n.yourPhoneNumber,
                                      hintStyle: TextStyle(
                                        fontSize: 30.w,
                                        color: AppColors.neutralGrey61,
                                      ),
                                      labelText: '',
                                      isDense: true,
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1.0.w,
                                          color: theme.dividerColor,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1.0.w,
                                          color: theme.dividerColor,
                                        ),
                                      ),
                                      // 获取焦点时的底线样式
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1.0.w,
                                          color: theme.dividerColor,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.only(
                                        bottom: 20.w,
                                      ), // 也可调小内边距
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
