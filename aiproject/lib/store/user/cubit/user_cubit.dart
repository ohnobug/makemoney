import 'package:bloc/bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());

// 更新昵称
  void updateName(String name) {
    emit(state.copyWith(userinfoName: name));
  }

  // 更新账户信息
  void updateAccount(String account) {
    emit(state.copyWith(userinfoAccount: account));
  }

  // 更新手机号
  void updatePhone(String phone) {
    emit(state.copyWith(userinfoPhone: phone));
  }

  // 更新余额
  void updateWalletBalance(double balance) {
    emit(state.copyWith(walletBalance: balance));
  }

  // 更新基金余额
  void updateWalletFoundationBalance(double balance) {
    emit(state.copyWith(walletFoundationBalance: balance));
  }

  // 更新头像
  void updateAvatar(String avatar) {
    emit(state.copyWith(userinfoAvatar: avatar));
  }
}

class UserState {
  final String? userinfoName; // 昵称
  final String? userinfoAccount; // 账号
  final String? userinfoPhone; // 手机
  final double? walletBalance; // 余额
  final double? walletFoundationBalance; // 基金余额
  final String? userinfoAvatar; // 头像

  // 构造函数
  UserState({
    this.userinfoName = '', // 默认为空字符串
    this.userinfoAccount = '', // 默认为空字符串
    this.userinfoPhone = '', // 默认为空字符串
    this.walletBalance = 0.0, // 默认为 0.0
    this.walletFoundationBalance = 0.0, // 默认为 0.0
    this.userinfoAvatar = '', // 默认为空字符串
  });

  // 可以选择添加一个 `copyWith` 方法来创建新状态时修改某些字段
  UserState copyWith({
    String? userinfoName,
    String? userinfoAccount,
    String? userinfoPhone,
    double? walletBalance,
    double? walletFoundationBalance,
    String? userinfoAvatar,
  }) {
    return UserState(
      userinfoName: userinfoName ?? this.userinfoName,
      userinfoAccount: userinfoAccount ?? this.userinfoAccount,
      userinfoPhone: userinfoPhone ?? this.userinfoPhone,
      walletBalance: walletBalance ?? this.walletBalance,
      walletFoundationBalance:
          walletFoundationBalance ?? this.walletFoundationBalance,
      userinfoAvatar: userinfoAvatar ?? this.userinfoAvatar,
    );
  }
}
