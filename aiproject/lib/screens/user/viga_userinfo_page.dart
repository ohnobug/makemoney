import 'package:flutter/services.dart';
import 'package:vigaviga/tools/viga_tools.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';
import 'package:vigaviga/widgets/viga_special_function_item.dart';

class VigaUserinfoPage extends StatefulWidget {
  const VigaUserinfoPage({super.key});

  @override
  State<VigaUserinfoPage> createState() => _VigaUserinfoPage();
}

class _VigaUserinfoPage extends State<VigaUserinfoPage> {
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
      child: Scaffold(
        primary: false,
        appBar: VigaAppBar(
          title: l10n.personalInfo,
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
                  // 用户信息
                  VigaFunctionList(children: [
                    // 头像
                    VigaFunctionItem(
                      title: l10n.avatar,
                      height: 150.w,
                      link: '',
                      showStyle: Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10).w,
                              child: VigaAppNetworkImage(
                                imageUrl: (context
                                    .read<VigaUserCubit>()
                                    .state
                                    .userinfoAvatar!),
                                width: 120.w,
                                height: 120.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      underline: true,
                    ),

                    // 姓名
                    VigaFunctionItem(
                      title: l10n.nickName,
                      link: '',
                      showStyle:
                          context.read<VigaUserCubit>().state.userinfoName!,
                      underline: true,
                    ),

                    // 性别
                    VigaFunctionItem(
                      title: l10n.gender,
                      link: '',
                      showStyle: l10n.male,
                      underline: true,
                    ),
                    // 地区
                    if ("广东广州".length > 10)
                      VigaSpecialFunctionItem(
                        title: l10n.region,
                        tapEffect: false,
                        underline: true,
                        height: null,
                        // link: '',
                        subTitle: Text(
                          "广东广州",
                          maxLines: 3,
                          style: TextStyle(
                            color: AppColors.neutralGrey37,
                            fontSize: 28.w,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    else
                      VigaFunctionItem(
                        title: l10n.region,
                        link: '',
                        showStyle: "广东广州",
                        underline: true,
                      ),

                    // Vigaviga号
                    VigaFunctionItem(
                      title: l10n.vigavigaID,
                      link: '/settings/account_info',
                      showStyle:
                          context.read<VigaUserCubit>().state.userinfoAccount,
                      underline: true,
                    ),

                    // 二维码名片
                    VigaFunctionItem(
                      title: l10n.qrCodeCard,
                      link: '/user/user_card',
                      showStyle: Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              const IconData(
                                0xe74b,
                                fontFamily: 'Iconfont',
                              ),
                              size: 30.w,
                              color: AppColors.neutralGrey45,
                            ),
                          ],
                        ),
                      ),
                      underline: true,
                    ),
                  ]),

                  // 个人签名及注册时间
                  VigaFunctionList(
                    children: [
                      // 个人签名
                      VigaSpecialFunctionItem(
                        title: l10n.personalSignature,
                        tapEffect: true,
                        underline: true,
                        height: null,
                        link: '',
                        subTitle: Text(
                          "为者常成，行者常至。",
                          maxLines: 3,
                          style: TextStyle(
                            color: AppColors.neutralGrey37,
                            fontSize: 28.w,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),

                      // 注册时间
                      VigaFunctionItem(
                        title: l10n.registrationTime,
                        // link: '',
                        showStyle: Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 40.w),
                            alignment: Alignment.centerRight,
                            child: Text(
                              l10n.yearAndMonth(DateTime(2023, 12)),
                              style: TextStyle(
                                height: 1.08,
                                fontSize: fontSizeScale(32.0.w),
                                color: AppColors.neutralDarkGrey7,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
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
      ),
    );
  }
}
