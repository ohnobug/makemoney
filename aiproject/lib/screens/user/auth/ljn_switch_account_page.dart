import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/models/ljn_account_model.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';

class LJNSwitchAccountPage extends StatefulWidget {
  const LJNSwitchAccountPage({super.key});

  @override
  State<LJNSwitchAccountPage> createState() => _LJNSwitchAccountPageState();
}

class _LJNSwitchAccountPageState extends State<LJNSwitchAccountPage> {
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

    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: l10n.switchAccount,
      ),
      body: Container(
        color: theme.colorScheme.surfaceContainer,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 20.w),
          itemCount: _accounts.length,
          itemBuilder: (context, index) {
            final account = _accounts[index];
            return _buildAccountItem(account, theme);
          },
        ),
      ),
    );
  }

  Widget _buildAccountItem(Account account, ThemeData theme) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.w),
        border: Border.all(
          color: account.statusColor,
          width: 2.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 8.w,
            offset: Offset(0, 2.w),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.w),
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
                          color: theme.colorScheme.primaryContainer,
                          child: Icon(
                            Icons.person,
                            size: 40.w,
                            color: theme.colorScheme.onPrimaryContainer,
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
                                color: theme.colorScheme.onSurface,
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
                          color: theme.colorScheme.onSurface.withAlpha(179),
                        ),
                      ),
                      SizedBox(height: 8.w),
                      // 最后登录时间
                      Text(
                        '最后登录：${account.formattedLastLoginTime}',
                        style: TextStyle(
                          fontSize: fontSizeScale(22.w),
                          color: theme.colorScheme.onSurface.withAlpha(128),
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
    final userCubit = context.read<LJNUserCubit>();
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
    context.read<LJNSystemCubit>().updateMainTabIndex(4);
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _navigateToLogin(Account account) {
    // 跳转到登录页面，传递账号信息
    Navigator.pushNamed(
      context,
      '/user/auth/login',
      arguments: {
        'account': account.account,
      },
    );
  }

  // 字体大小缩放函数
  double fontSizeScale(double size) {
    return size;
  }
}
