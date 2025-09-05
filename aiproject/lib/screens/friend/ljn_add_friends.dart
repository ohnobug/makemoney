import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_icon_function_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/ljn_search.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';

class LJNAddFriends extends StatefulWidget {
  const LJNAddFriends({
    super.key,
  });

  @override
  State<LJNAddFriends> createState() => _LJNAddFriends();
}

class _LJNAddFriends extends State<LJNAddFriends> {
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
    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: AppLocalizations.of(context)!.addFriend,
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
                // 搜索框
                LJNSearch(
                    link: '/search_friend',
                    title: AppLocalizations.of(context)!.accountOrPhone),

                SizedBox(
                  height: 44.w,
                ),

                // 我的微信号
                Container(
                  height: 37.w,
                  width: 750.w,
                  alignment: Alignment.center,
                  // color: AppColors.neutralGrey13,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!.myWechatIdDisplay(
                              context
                                  .read<LJNUserCubit>()
                                  .state
                                  .userinfoAccount!),
                          style: TextStyle(
                            height: 1.08,
                            fontSize: 25.w,
                            color: AppColors.neutralGrey75,
                          ),
                        ),
                        WidgetSpan(
                          child: SizedBox(width: 14.w),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          style: const TextStyle(height: 1.08),
                          child: Icon(
                            const IconData(0xe74b, fontFamily: 'Iconfont'),
                            color: AppColors.neutralGrey75,
                            size: 32.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 70.w,
                ),

                LJNIconFunctionItem(
                  title: AppLocalizations.of(context)!.radarAddFriends,
                  link: '',
                  underline: true,
                  avatar: "images/icon/add_friend_icon1.png",
                  message: AppLocalizations.of(context)!.addNearbyFriends,
                ),

                LJNIconFunctionItem(
                  title: AppLocalizations.of(context)!.faceToFaceGroup,
                  link: '',
                  underline: true,
                  avatar: "images/icon/add_friend_icon2.png",
                  message:
                      AppLocalizations.of(context)!.joinGroupWithNearbyFriends,
                ),

                LJNIconFunctionItem(
                  title: AppLocalizations.of(context)!.scan,
                  link: '/qrcode_scanner',
                  underline: true,
                  avatar: "images/icon/add_friend_icon3.png",
                  message: AppLocalizations.of(context)!.scanQRCode,
                ),

                LJNIconFunctionItem(
                  title: AppLocalizations.of(context)!.phoneContacts,
                  link: '/phone_contact',
                  underline: true,
                  avatar: "images/icon/add_friend_icon4.png",
                  message: AppLocalizations.of(context)!.addOrInviteContacts,
                ),

                LJNIconFunctionItem(
                  title: AppLocalizations.of(context)!.officialAccounts,
                  link: '',
                  underline: true,
                  avatar: "images/icon/add_friend_icon5.png",
                  message: AppLocalizations.of(context)!.getMoreInfoAndServices,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconBox extends StatelessWidget {
  const IconBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.w,
      width: 105.w,
      alignment: Alignment.topLeft,
      child: DottedBorder(
        // color: AppColors.neutralGrey47,
        // borderType: BorderType.RRect,
        // padding: const EdgeInsets.all(0),
        // borderPadding: const EdgeInsets.all(0),
        // stackFit: StackFit.loose,
        // strokeWidth: 3.w,
        // dashPattern: [16.w, 10.w],
        // strokeCap: StrokeCap.round,
        // radius: Radius.circular(8.0.w),
        child: SizedBox(
          width: 105.0.w, // 设置宽度
          height: 105.0.w, // 设置高度
          // decoration: BoxDecoration(
          //   color: AppColors.transparent, // 背景透明
          //   borderRadius: BorderRadius.circular(8.0.w), // 圆角 8
          //   border: Border.all(
          //     color: AppColors.neutralGrey47, // 边框颜色
          //     width: 1.0.w,
          //     style: BorderStyle.solid, // 边框样式
          //   ),
          //   shape: BoxShape.rectangle, // 矩形盒子
          // ),
          child: Center(
            child: Icon(
              const IconData(
                0xe616,
                fontFamily: 'Iconfont',
              ), // 使用的图标
              color: AppColors.neutralGrey47, // 图标颜色
              size: 42.0.w, // 图标大小
            ),
          ),
        ),
      ),
    );
  }
}
