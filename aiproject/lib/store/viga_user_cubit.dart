import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class VigaUserCubit extends Cubit<UserState> {
  VigaUserCubit()
      : super(
          UserState(),
        );

// 更新昵称
  void updateName(String name) {
    emit(
      state.copyWith(userinfoName: name),
    );
  }

  // 更新账户信息
  void updateAccount(String account) {
    emit(
      state.copyWith(userinfoAccount: account),
    );
  }

  // 更新手机号
  void updatePhone(String phone) {
    emit(
      state.copyWith(userinfoPhone: phone),
    );
  }

  // 更新余额
  void updateWalletBalance(double balance) {
    emit(
      state.copyWith(walletBalance: balance),
    );
  }

  // 更新基金余额
  void updateWalletFoundationBalance(double balance) {
    emit(
      state.copyWith(walletFoundationBalance: balance),
    );
  }

  // 更新头像
  void updateAvatar(String avatar) {
    emit(
      state.copyWith(userinfoAvatar: avatar),
    );
  }

  // 用户登录
  void login({
    required String userId,
    required String authToken,
    String? phone,
    String? name,
    String? account,
    String? avatar,
  }) {
    emit(
      state.copyWith(
        isLoggedIn: true,
        userId: userId,
        authToken: authToken,
        userinfoPhone: phone ?? state.userinfoPhone,
        userinfoName: name ?? state.userinfoName,
        userinfoAccount: account ?? state.userinfoAccount,
        userinfoAvatar: avatar ?? state.userinfoAvatar,
      ),
    );
  }

  // 用户登出
  void logout() {
    emit(
      state.copyWith(
        isLoggedIn: false,
        userId: null,
        authToken: null,
        userinfoName: '',
        userinfoAccount: '',
        userinfoPhone: '',
        userinfoAvatar: '',
        walletBalance: 0.0,
        walletFoundationBalance: 0.0,
      ),
    );
  }

  // 更新认证令牌
  void updateAuthToken(String token) {
    emit(
      state.copyWith(authToken: token),
    );
  }

  // 检查是否已登录
  bool get isLoggedIn => state.isLoggedIn;

  // 获取用户ID
  String? get userId => state.userId;

  // 获取认证令牌
  String? get authToken => state.authToken;
}

class UserState extends Equatable {
  final String? userinfoName; // 昵称
  final String? userinfoAccount; // 账号
  final String? userinfoPhone; // 手机
  final double? walletBalance; // 余额
  final double? walletFoundationBalance; // 基金余额
  final String? userinfoAvatar; // 头像
  final bool isLoggedIn; // 登录状态
  final String? userId; // 用户ID
  final String? authToken; // 认证令牌

  // 构造函数
  const UserState({
    this.userinfoName = '', // 默认为空字符串
    this.userinfoAccount = '', // 默认为空字符串
    this.userinfoPhone = '', // 默认为空字符串
    this.walletBalance = 0.0, // 默认为 0.0
    this.walletFoundationBalance = 0.0, // 默认为 0.0
    this.userinfoAvatar = '', // 默认为空字符串
    this.isLoggedIn = false, // 默认未登录
    this.userId, // 用户ID默认为空
    this.authToken, // 认证令牌默认为空
  });

  @override
  List<Object?> get props => [
        userinfoName,
        userinfoAccount,
        userinfoPhone,
        walletBalance,
        walletFoundationBalance,
        userinfoAvatar,
        isLoggedIn,
        userId,
        authToken,
      ];

  // 可以选择添加一个 `copyWith` 方法来创建新状态时修改某些字段
  UserState copyWith({
    String? userinfoName,
    String? userinfoAccount,
    String? userinfoPhone,
    double? walletBalance,
    double? walletFoundationBalance,
    String? userinfoAvatar,
    bool? isLoggedIn,
    String? userId,
    String? authToken,
  }) {
    return UserState(
      userinfoName: userinfoName ?? this.userinfoName,
      userinfoAccount: userinfoAccount ?? this.userinfoAccount,
      userinfoPhone: userinfoPhone ?? this.userinfoPhone,
      walletBalance: walletBalance ?? this.walletBalance,
      walletFoundationBalance:
          walletFoundationBalance ?? this.walletFoundationBalance,
      userinfoAvatar: userinfoAvatar ?? this.userinfoAvatar,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      userId: userId ?? this.userId,
      authToken: authToken ?? this.authToken,
    );
  }
}
