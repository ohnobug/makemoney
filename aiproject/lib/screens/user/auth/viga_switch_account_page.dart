import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/models/viga_account_model.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/viga_tools.dart';

class VigaSwitchAccountPage extends StatefulWidget {
  const VigaSwitchAccountPage({super.key});

  @override
  State<VigaSwitchAccountPage> createState() => _VigaSwitchAccountPageState();
}

class _VigaSwitchAccountPageState extends State<VigaSwitchAccountPage> {
  // 模拟历史账号数据
  final List<Account> _accounts = [
    Account(
      id: '1',
      avatar: 'https://cdn.vigaviga.com/avatar/my.jpg',
      account: 'TheMonsterClub',
      nickname: '李俊杰',
      lastLoginTime: DateTime.now().subtract(const Duration(hours: 2)),
      status: AccountStatus.active,
    ),
    Account(
      id: '2',
      avatar: 'https://cdn.vigaviga.com/avatar/default_avatar.png',
      account: 'user123',
      nickname: '用户123',
      lastLoginTime: DateTime.now().subtract(const Duration(days: 30)),
      status: AccountStatus.expired,
    ),
    Account(
      id: '3',
      avatar: 'https://cdn.vigaviga.com/avatar/default_avatar.png',
      account: 'test456',
      nickname: '测试用户',
      lastLoginTime: DateTime.now().subtract(const Duration(days: 15)),
      status: AccountStatus.active,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<VigaSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          backgroundColor: AppColors.darkBackground,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 110.w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // 标题
                        Text(
                          l10n.switchAccount,
                          style: TextStyle(
                            color: AppColors.fontPrimary,
                            fontSize: 68.w, // 对应 34.sp
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // 关闭按钮
                        Positioned(
                          left: 30.w,
                          child: GestureDetector(
                            onTap: () {
                              context.pop();
                            },
                            child: Container(
                              width: 80.w,
                              height: 80.w,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.close,
                                size: 40.w,
                                color: AppColors.fontSecondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 48.w),
                        children: [
                          ...List.generate(_accounts.length, (index) {
                            final account = _accounts[index];
                            return _buildAccountItem(account, theme);
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAccountItem(Account account, ThemeData theme) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.w),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(28.w),
        border: Border.all(
          color: account.statusColor,
          width: 2.w,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28.w),
          onTap: () => _handleAccountTap(account),
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 头像
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.w),
                    border: Border.all(
                      color: account.statusColor,
                      width: 2.w,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(38.w),
                    child: Image.network(
                      account.avatar,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.inputBackground,
                          child: Icon(
                            Icons.person,
                            size: 40.w,
                            color: AppColors.fontSecondary,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                // 账号信息
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 昵称和状态
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              account.nickname,
                              style: TextStyle(
                                fontSize: fontSizeScale(32.w),
                                fontWeight: FontWeight.bold,
                                color: AppColors.fontPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 4.w,
                            ),
                            decoration: BoxDecoration(
                              color: account.statusColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(20.w),
                              border: Border.all(
                                color: account.statusColor,
                                width: 1.w,
                              ),
                            ),
                            child: Text(
                              account.statusText,
                              style: TextStyle(
                                fontSize: fontSizeScale(20.w),
                                color: account.statusColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.w),
                      // 账号
                      Text(
                        '@${account.account}',
                        style: TextStyle(
                          fontSize: fontSizeScale(26.w),
                          color: AppColors.fontSecondary,
                        ),
                      ),
                      SizedBox(height: 8.w),
                      // 最后登录时间
                      Text(
                        '最后登录：${account.formattedLastLoginTime}',
                        style: TextStyle(
                          fontSize: fontSizeScale(22.w),
                          color: AppColors.fontSecondary.withAlpha(179),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleAccountTap(Account account) {
    switch (account.status) {
      case AccountStatus.active:
        _switchToAccount(account);
        break;
      case AccountStatus.expired:
        _navigateToLogin(account);
        break;
    }
  }

  void _switchToAccount(Account account) {
    // 更新用户信息 - 使用 login 方法
    final userCubit = context.read<VigaUserCubit>();
    userCubit.login(
      userId: account.id,
      authToken: 'token_${DateTime.now().millisecondsSinceEpoch}',
      phone: account.account,
      name: account.nickname,
    );

    // 显示成功提示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('已切换到账号：${account.nickname}'),
        duration: const Duration(seconds: 2),
      ),
    );

    // 切换到用户中心的tab（第4个tab）
    context.read<VigaSystemCubit>().updateMainTabIndex(4);
    context.go('/');
  }

  void _navigateToLogin(Account account) {
    // 跳转到登录页面，传递账号信息
    context.push(
      '/user/auth/login',
      extra: {
        'account': account.account,
      },
    );
  }
}
