import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_icon_function_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';
import 'package:vigaviga/widgets/viga_search.dart';

class VigaAddFriendsPage extends StatefulWidget {
  const VigaAddFriendsPage({
    super.key,
  });

  @override
  State<VigaAddFriendsPage> createState() => _VigaAddFriends();
}

class _VigaAddFriends extends State<VigaAddFriendsPage> {
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
    String cdnBase = systemState.cdnBase;

    return Scaffold(
      primary: false,
      appBar: VigaAppBar(
        title: l10n.addFriend,
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
                SizedBox(
                  height: 20.w,
                ),
                // 搜索框
                VigaSearch(
                  link: '/search',
                  title: l10n.accountOrPhone,
                  extra: {
                    'initialTab': 1, // 用户tab
                    'searchMode': 'user_search',
                    'autoFocus': true, // 自动聚焦输入框
                  },
                ),

                SizedBox(
                  height: 44.w,
                ),

                // 我的Vigaviga号
                GestureDetector(
                  onTap: () {
                    context.push('/user/user_card');
                  },
                  child: Container(
                    height: 37.w,
                    width: 750.w,
                    alignment: Alignment.center,
                    // color: AppColors.neutralGrey13,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: l10n.myVigavigaIdDisplay(context
                                .read<VigaUserCubit>()
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
                ),

                SizedBox(
                  height: 70.w,
                ),

                // VigaIconFunctionItem(
                //   title: l10n.radarAddFriends,
                //   link: '',
                //   underline: true,
                //   avatar: "$cdnBase/icon/add_friend_icon1.png",
                //   message: l10n.addNearbyFriends,
                // ),

                // VigaIconFunctionItem(
                //   title: l10n.faceToFaceGroup,
                //   link: '',
                //   underline: true,
                //   avatar: "$cdnBase/icon/add_friend_icon2.png",
                //   message: l10n.joinGroupWithNearbyFriends,
                // ),

                VigaIconFunctionItem(
                  title: l10n.scan,
                  link: '/discovery/qrcode_scanner',
                  underline: true,
                  avatar: "$cdnBase/icon/add_friend_icon3.png",
                  message: l10n.scanQRCode,
                ),

                VigaIconFunctionItem(
                  title: l10n.phoneContacts,
                  link: '/contact/phone_contact',
                  underline: true,
                  avatar: "$cdnBase/icon/add_friend_icon4.png",
                  message: l10n.addOrInviteContacts,
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
          //   color: Colors.transparent, // 背景透明
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
