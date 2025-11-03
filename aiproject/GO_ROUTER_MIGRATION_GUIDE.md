# Go Router 迁移指南

## 概述
本项目已从传统的 Flutter Navigator 迁移到 go_router。go_router 提供了更强大的路由管理功能，包括类型安全的参数传递、深层链接支持等。

## 主要变化

### 1. 路由配置
- **之前**: `AppRouter.onGenerateRoute`
- **现在**: `appRouter` (GoRouter 实例)

### 2. 应用配置
- **之前**: `MaterialApp(onGenerateRoute: AppRouter.onGenerateRoute)`
- **现在**: `MaterialApp.router(routerConfig: appRouter)`

## 如何更新导航调用

### 基础导航（无参数）

**之前**:
```dart
Navigator.pushNamed(context, '/settings');
```

**现在**:
```dart
context.push('/settings');
```

### 带参数导航

**之前**:
```dart
Navigator.pushNamed(
  context,
  '/chat',
  arguments: {
    'title': '朋友聊天',
    'icon': 'chat_icon',
    'fromTabIndex': '1',
  },
);
```

**现在**:
```dart
context.push('/chat', extra: ChatParams(
  title: '朋友聊天',
  icon: 'chat_icon',
  fromTabIndex: '1',
));
```

### 替换当前路由

**之前**:
```dart
Navigator.pushReplacementNamed(context, '/home');
```

**现在**:
```dart
context.go('/home');
```

### 返回

**之前**:
```dart
Navigator.pop(context);
```

**现在**:
```dart
context.pop();
```

## 参数类定义

项目中已定义以下参数类，用于类型安全的参数传递：

### ChatParams
用于聊天页面参数
```dart
class ChatParams {
  final String title;
  final String icon;
  final String? fromTabIndex;

  ChatParams({
    required this.title,
    required this.icon,
    this.fromTabIndex,
  });
}
```

### FriendProfileParams
用于朋友资料页面参数
```dart
class FriendProfileParams {
  final String name;
  final String nickname;
  final String account;
  final String avatar;

  FriendProfileParams({
    required this.name,
    required this.nickname,
    required this.account,
    required this.avatar,
  });
}
```

### WebViewParams
用于网页浏览页面参数
```dart
class WebViewParams {
  final String url;
  final String title;

  WebViewParams({
    required this.url,
    required this.title,
  });
}
```

### AuthorDetailParams
用于作者详情页面参数
```dart
class AuthorDetailParams {
  final String authorId;
  final String authorName;
  final String authorAvatar;

  AuthorDetailParams({
    required this.authorId,
    required this.authorName,
    required this.authorAvatar,
  });
}
```

## 常用路由路径

### 主页面
- `/` - 主页面（底部导航栏）

### 设置相关
- `/settings` - 设置主页面
- `/settings/account_and_secure` - 账号与安全
- `/settings/account_info` - 账号信息
- `/settings/change_account` - 切换账号验证

### 通讯录相关
- `/contact` - 通讯录主页面
- `/contact/tags` - 标签管理
- `/contact/new_friends` - 新朋友
- `/contact/add_friends` - 添加朋友

### 聊天相关
- `/chat` - 聊天页面（需要 ChatParams）
- `/group_chat` - 群聊页面（需要 ChatParams）
- `/chat/friend_profile` - 朋友资料（需要 FriendProfileParams）

### 发现相关
- `/discovery/search` - 发现搜索
- `/discovery/ins` - 朋友圈
- `/web_browser` - 网页浏览器（需要 WebViewParams）
- `/webview` - WebView页面（需要 WebViewParams）

### 用户相关
- `/user/info` - 用户信息
- `/user/wallet` - 钱包
- `/user/auth/login` - 登录
- `/user/auth/register` - 注册

## 页面过渡动画

项目保留了原有的页面过渡动画系统：

- **带动画过渡**: 大多数页面使用从右向左滑入的动画效果
- **无动画过渡**: 某些特殊页面（如发布页面、定位页面）使用无动画过渡

动画配置在 `CustomTransitionPage` 类中定义，与原来的 `pageRouteBuilderAnimation` 和 `pageRouteBuilderNotAnimation` 功能一致。

## 注意事项

1. **参数类型安全**: 所有带参数的页面现在都使用类型安全的参数类
2. **导航方法**: 使用 `context.push()` 进行导航，`context.go()` 进行替换
3. **导入**: 确保在需要导航的文件中导入 `package:go_router/go_router.dart`
4. **错误处理**: go_router 会自动处理未找到的路由，显示错误页面
5. **过渡动画**: 页面过渡动画已保留，与原有体验一致

## 迁移状态

- [x] 路由配置已迁移
- [x] 应用配置已更新
- [ ] 所有 Navigator.pushNamed 调用需要更新
- [ ] 测试所有路由功能

## 下一步

请根据此指南更新项目中所有使用 `Navigator.pushNamed` 的地方。可以使用搜索功能查找所有需要更新的文件。