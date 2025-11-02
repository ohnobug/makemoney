import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_change_account_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';

class VigaPhoneNumberPage extends StatefulWidget {
  const VigaPhoneNumberPage({super.key});

  @override
  State<VigaPhoneNumberPage> createState() => _VigaPhoneNumberPage();
}

class _VigaPhoneNumberPage extends State<VigaPhoneNumberPage> {
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
                appBar: VigaAppBar(
                  title: l10n.phoneNumber,
                ),
                body: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
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
                      child: SizedBox(
                        width: 750.w,
                        // padding: EdgeInsets.only(left: 70.w, right: 70.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 160.w,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  l10n.boundPhoneNumberDisplay,
                                  strutStyle: StrutStyle(
                                    fontSize: 37.w,
                                    height: 1.08,
                                  ),
                                  style: TextStyle(
                                    height: 1.08,
                                    fontSize: 37.w,
                                  ),
                                ),

                                // 手机号
                                Text(
                                  phone,
                                  strutStyle: StrutStyle(
                                    fontSize: 37.w,
                                    height: 1.08,
                                  ),
                                  style: TextStyle(
                                    height: 1.08,
                                    fontSize: 37.w,
                                  ),
                                ),
                                SizedBox(width: 13.w), // 间隔

                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isHide = !isHide;
                                    });
                                  },
                                  child: Text(
                                    isHide ? l10n.hide : l10n.show,
                                    strutStyle: StrutStyle(
                                      fontSize: 37.w,
                                      height: 1.08,
                                    ),
                                    style: TextStyle(
                                      height: 1.08,
                                      fontSize: 25.w,
                                      color: AppColors.brandPurpleDark3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.w,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 70.w,
                                right: 70.w,
                              ),
                              child: Text(
                                l10n.phoneBoundAndDiscoverPrompt,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 27.0.w,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 720.w,
                              child: null,
                            ),

                            // 查看电话联系人
                            VigaChangeAccountButton(
                              title: l10n.viewPhoneContacts,
                              color: AppColors.neutralWhite,
                              backgroundColor: AppColors.brandGreenVibrant5,
                              link: "/settings/phone_contact",
                              readonly: false,
                            ),

                            SizedBox(
                              height: 33.w,
                            ),

                            // 修改电话毫秒
                            VigaChangeAccountButton(
                              title: l10n.changePhoneNumber,
                              // color: AppColors.neutralWhite,
                              // backgroundColor: AppColors.brandGreenVibrant5,
                              link: "/change_phone",
                              readonly: false,
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
