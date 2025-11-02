import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';

class VigaInputVerifyCodePage extends StatefulWidget {
  const VigaInputVerifyCodePage({super.key});

  @override
  State<VigaInputVerifyCodePage> createState() => _VigaInputVerifyCodePage();
}

class _VigaInputVerifyCodePage extends State<VigaInputVerifyCodePage> {
  bool isHide = true;

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
        return BlocBuilder<VigaUserCubit, UserState>(
          builder: (context, userState) {
            String phone = userState.userinfoPhone is String
                ? userState.userinfoPhone!
                : "";

            if (isHide) {
              phone =
                  '${phone.substring(0, 6)}${'*' * (phone.length - 10)}${phone.substring(phone.length - 4, phone.length)}';
            }

            return Theme(
              data: theme.copyWith(
                appBarTheme: theme.appBarTheme.copyWith(
                  backgroundColor: Colors.transparent,
                ),
              ),
              child: Scaffold(
                primary: false,
                resizeToAvoidBottomInset: false,
                appBar: VigaAppBar(
                  title: l10n.enterVerificationCode,
                ),
                body: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          systemState.appbarHeight -
                          systemState.statusHeight,
                    ),
                    color: AppColors.neutralWhite,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(left: 50.w, right: 50.w),
                        height: 95.w,
                        width: 750.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
