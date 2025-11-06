// 文件路径: lib/your_path/viga_services.dart (替换这个文件的全部内容)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/tools/viga_tools.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_function_button.dart';
import 'package:vigaviga/widgets/viga_function_buttons_section.dart';
import 'package:vigaviga/tools/viga_action_sheet.dart';

///
/// 服务页面
///
class VigaServicesPage extends StatelessWidget {
  // 2. 从 StatefulWidget 改为 StatelessWidget
  const VigaServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    // 3. 删除了 BlocBuilder, Stack, AnimationController, showSelector 等所有与弹窗相关的状态和UI
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
          String cdnBase = systemState.cdnBase;

          return Scaffold(
            primary: false,
            appBar: VigaAppBar(
              title: l10n.services,
              actions: [
                GestureDetector(
                  onTap: () {
                    showVigaActionSheet(
                      context: context,
                      // 传入一个操作列表
                      actions: [
                        VigaActionSheetAction(
                          text: Text(
                            l10n.serviceManagement,
                            style: TextStyle(
                              fontSize: 30.w,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          onPressed: () {
                            context.push('/user/services_manager');
                          },
                        ),
                      ],
                      cancelButtonText: l10n.cancel,
                    );
                  },
                  // 这个按钮的UI保持不变
                  child: Container(
                    height: 90.w,
                    color: Colors.transparent,
                    padding: EdgeInsets.only(right: 33.w),
                    alignment: Alignment.center,
                    child: Icon(
                      const IconData(
                        0xe659,
                        fontFamily: 'Iconfont',
                      ),
                      size: 37.w,
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: theme.colorScheme.surfaceContainer,
            body: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // --- 顶部核心功能卡片 ---
                    _buildHeaderCard(context),

                    // --- 服务分区 (这部分UI保持不变) ---
                    VigaFunctionButtonsSection(
                      title: l10n.financialServices,
                      buttons: [
                        VigaFunctionButton(
                            icon: "$cdnBase/icon/server_icon1.png",
                            title: l10n.services,
                            onPressed: () => logger.info('点击了信用卡还款按钮~~')),
                        VigaFunctionButton(
                            icon: "$cdnBase/icon/server_icon2.png",
                            title: l10n.moments,
                            onPressed: () => logger.info('点击了理财通按钮~~')),
                        VigaFunctionButton(
                            icon: "$cdnBase/icon/server_icon3.png",
                            title: l10n.settings,
                            onPressed: () => logger.info('点击了保险服务按钮~~')),
                      ],
                    ),
                    VigaFunctionButtonsSection(
                      title: l10n.lifeServices,
                      buttons: [
                        VigaFunctionButton(
                            icon: "$cdnBase/icon/server_icon4.png",
                            title: l10n.mobileTopUp,
                            onPressed: () => logger.info('点击了手机充值按钮~~')),
                        VigaFunctionButton(
                            icon: "$cdnBase/icon/server_icon5.png",
                            title: l10n.utilityPayments,
                            onPressed: () => logger.info('点击了生活缴费按钮~~')),
                        VigaFunctionButton(
                            icon: "$cdnBase/icon/server_icon6.png",
                            title: l10n.qCoinTopUp,
                            onPressed: () => logger.info('点击了Q币充值按钮~~')),
                        VigaFunctionButton(
                            icon: "$cdnBase/icon/server_icon7.png",
                            title: l10n.cityServices,
                            onPressed: () => logger.info('点击了城市服务按钮~~')),
                        VigaFunctionButton(
                            icon: "$cdnBase/icon/server_icon8.png",
                            title: l10n.tencentCharity,
                            onPressed: () => logger.info('点击了腾讯公益按钮~~')),
                        VigaFunctionButton(
                            icon: "$cdnBase/icon/server_icon9.png",
                            title: l10n.healthCare,
                            onPressed: () => logger.info('点击了医疗健康按钮~~')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 构建器：顶部核心功能卡片 (保持不变)
  Widget _buildHeaderCard(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final balanceTextStyle = TextStyle(
      height: 1.1,
      fontSize: fontSizeScale(30.w),
      color: AppColors.accentYellow,
      fontFamily: "Roboto",
    );

    return Container(
      height: 272.w,
      margin: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.brandGreenVibrant4,
            AppColors.brandGreenVibrant5,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0).w,
        boxShadow: [
          BoxShadow(
            color: AppColors.brandGreenDarkest.withAlpha(50),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CollectionAndPayment(
              icon: Icon(const IconData(0xe658, fontFamily: 'Iconfont'),
                  size: 72.w, color: AppColors.neutralWhite),
              title: l10n.payment,
              subTitle: Text('', style: balanceTextStyle),
              onPressed: () {
                context.push('/user/collection_and_payment');
                logger.info('点击了收付款还款按钮~~');
              },
            ),
          ),
          Container(
            width: 1,
            height: 100.w,
            color: AppColors.neutralWhite.withAlpha(50),
          ),
          Expanded(
            child: CollectionAndPayment(
              icon: Icon(const IconData(0xe6e4, fontFamily: 'Iconfont'),
                  size: 72.w, color: AppColors.neutralWhite),
              title: l10n.wallet,
              subTitle: Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                          const IconData(0xe90d, fontFamily: 'Iconfont'),
                          size: 25.w,
                          color: AppColors.accentYellow),
                      alignment: PlaceholderAlignment.middle,
                    ),
                    WidgetSpan(child: SizedBox(width: 4.w)),
                    TextSpan(
                      text: context
                          .read<VigaUserCubit>()
                          .state
                          .walletBalance
                          .toString(),
                      style: balanceTextStyle,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                context.push('/user/wallet');
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 顶部核心功能按钮 (保持不变)
class CollectionAndPayment extends StatelessWidget {
  final Icon icon;
  final String title;
  final VoidCallback onPressed;
  final Widget subTitle;

  const CollectionAndPayment({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0).w,
        onTap: onPressed,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 90.w, height: 90.w, child: Center(child: icon)),
              SizedBox(height: 10.w),
              Text(
                title,
                maxLines: 1,
                style: TextStyle(
                  height: 1.1,
                  decoration: TextDecoration.none,
                  color: AppColors.neutralWhite,
                  fontSize: fontSizeScale(32.0.w),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 10.w),
              subTitle,
            ],
          ),
        ),
      ),
    );
  }
}
