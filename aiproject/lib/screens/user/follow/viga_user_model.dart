// lib/follow/user_model.dart

/// 定义关注状态的枚举
enum FollowStatus {
  mutual,      // 互相关注
  following,   // 已关注 (你关注了对方)
  followedBy,  // 被关注 (对方关注了你，你没关注)
  notFollowing // 未关注 (用于关注列表中的推荐用户)
}

/// 用户数据模型
class User {
  final String id;
  final String avatarUrl;
  final String name;
  final String? description;
  final String? extraInfo;
  FollowStatus status;

  User({
    required this.id,
    required this.avatarUrl,
    required this.name,
    this.description,
    this.extraInfo,
    required this.status,
  });
}