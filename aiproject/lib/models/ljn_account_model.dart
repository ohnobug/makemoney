import 'package:flutter/material.dart';

/// 账号状态枚举
enum AccountStatus {
  active,    // 活跃状态（绿色边框）
  expired,   // 已过期状态（灰色边框）
}

/// 账号数据模型
class Account {
  final String id;
  final String avatar;      // 头像URL
  final String account;     // 账号
  final String nickname;    // 昵称
  final DateTime lastLoginTime; // 最后登录时间
  final AccountStatus status;   // 账号状态

  Account({
    required this.id,
    required this.avatar,
    required this.account,
    required this.nickname,
    required this.lastLoginTime,
    required this.status,
  });

  /// 格式化最后登录时间
  String get formattedLastLoginTime {
    final now = DateTime.now();
    final difference = now.difference(lastLoginTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }

  /// 获取状态对应的颜色
  Color get statusColor {
    switch (status) {
      case AccountStatus.active:
        return Colors.green;
      case AccountStatus.expired:
        return Colors.grey;
    }
  }

  /// 获取状态文本
  String get statusText {
    switch (status) {
      case AccountStatus.active:
        return '活跃';
      case AccountStatus.expired:
        return '已过期';
    }
  }

  /// 从JSON创建Account对象
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] ?? '',
      avatar: json['avatar'] ?? '',
      account: json['account'] ?? '',
      nickname: json['nickname'] ?? '',
      lastLoginTime: DateTime.parse(json['lastLoginTime']),
      status: AccountStatus.values[json['status'] ?? 0],
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'avatar': avatar,
      'account': account,
      'nickname': nickname,
      'lastLoginTime': lastLoginTime.toIso8601String(),
      'status': status.index,
    };
  }
}