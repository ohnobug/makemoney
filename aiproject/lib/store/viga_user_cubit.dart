import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'viga_storage_service.dart';
import 'package:vigaviga/tools/viga_logger.dart';

class VigaUserCubit extends Cubit<UserState> {
  VigaUserCubit() : super(UserState()) {
    _loadSavedUserState();
  }

  // 加载保存的用户状态
  Future<void> _loadSavedUserState() async {
    try {
      final savedState = await VigaStorageService.loadUserState();

      if (savedState != null) {
        final loadedState = UserState.fromJson(savedState);
        emit(loadedState);
      }
    } catch (e) {
      // 如果加载失败，保持默认状态
      logger.warning('加载用户状态失败: $e');
    }
  }

  // 保存用户状态到本地存储
  Future<void> _saveUserState() async {
    try {
      final stateMap = state.toJson();
      await VigaStorageService.saveUserState(stateMap);
    } catch (e) {
      logger.warning('保存用户状态失败: $e');
    }
  }

// 更新昵称
  void updateName(String name) {
    final newState = state.copyWith(userinfoName: name);
    emit(newState);
    _saveUserState();
  }

  // 更新账户信息
  void updateAccount(String account) {
    final newState = state.copyWith(userinfoAccount: account);
    emit(newState);
    _saveUserState();
  }

  // 更新手机号
  void updatePhone(String phone) {
    final newState = state.copyWith(userinfoPhone: phone);
    emit(newState);
    _saveUserState();
  }

  // 更新余额
  void updateWalletBalance(double balance) {
    final newState = state.copyWith(walletBalance: balance);
    emit(newState);
    _saveUserState();
  }

  // 更新基金余额
  void updateWalletFoundationBalance(double balance) {
    final newState = state.copyWith(walletFoundationBalance: balance);
    emit(newState);
    _saveUserState();
  }

  // 更新头像
  void updateAvatar(String avatar) {
    final newState = state.copyWith(userinfoAvatar: avatar);
    emit(newState);
    _saveUserState();
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
    final newState = state.copyWith(
      isLoggedIn: true,
      userId: userId,
      authToken: authToken,
      userinfoPhone: phone ?? state.userinfoPhone,
      userinfoName: name ?? state.userinfoName,
      userinfoAccount: account ?? state.userinfoAccount,
      userinfoAvatar: avatar ?? state.userinfoAvatar,
    );
    emit(newState);
    _saveUserState();
  }

  // 用户登出
  void logout() {
    final newState = state.copyWith(
      isLoggedIn: false,
      userId: null,
      authToken: null,
      userinfoName: '',
      userinfoAccount: '',
      userinfoPhone: '',
      userinfoAvatar: '',
      walletBalance: 0.0,
      walletFoundationBalance: 0.0,
    );
    emit(newState);
    _saveUserState();
    // 同时清除存储
    VigaStorageService.clearUserState();
  }

  // 更新认证令牌
  void updateAuthToken(String token) {
    final newState = state.copyWith(authToken: token);
    emit(newState);
    _saveUserState();
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

  // 从JSON创建UserState
  factory UserState.fromJson(Map<String, dynamic> json) {
    return UserState(
      userinfoName: json['userinfoName'] ?? '',
      userinfoAccount: json['userinfoAccount'] ?? '',
      userinfoPhone: json['userinfoPhone'] ?? '',
      walletBalance: json['walletBalance']?.toDouble() ?? 0.0,
      walletFoundationBalance: json['walletFoundationBalance']?.toDouble() ?? 0.0,
      userinfoAvatar: json['userinfoAvatar'] ?? '',
      isLoggedIn: json['isLoggedIn'] ?? false,
      userId: json['userId'],
      authToken: json['authToken'],
    );
  }

  // 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'userinfoName': userinfoName,
      'userinfoAccount': userinfoAccount,
      'userinfoPhone': userinfoPhone,
      'walletBalance': walletBalance,
      'walletFoundationBalance': walletFoundationBalance,
      'userinfoAvatar': userinfoAvatar,
      'isLoggedIn': isLoggedIn,
      'userId': userId,
      'authToken': authToken,
    };
  }
}
