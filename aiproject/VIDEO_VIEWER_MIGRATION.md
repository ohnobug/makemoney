# 视频查看器迁移指南

## 从 VigaVideoViewerService 迁移到 GoRouter

原来的 `VigaVideoViewerService` 已经被集成到 `app_router.dart` 中。以下是迁移方法：

### 1. 直接从视频列表打开

**原来的代码：**
```dart
VigaVideoViewerService.openVideoViewerFromList(
  context: context,
  videoSources: videoUrls,
  initialIndex: index,
);
```

**新的代码：**
```dart
context.go('/video_viewer', extra: {
  'videoSources': videoUrls,
  'initialIndex': index,
});
```

### 2. 导入说明

确保在文件中导入：
```dart
import 'package:vigaviga/routing/app_router.dart';
```

### 3. 过渡效果

新的实现保持了原来的淡入淡出过渡效果，使用 `buildPageWithFadeAnimation` 方法。

### 4. 注意事项

- 当前视频查看器页面不支持从特定位置打开的过渡效果
- 所有视频查看器打开方式都使用统一的淡入淡出动画

## 优势

- 统一的路由管理
- 更好的导航历史管理
- 支持深链接
- 保持原有的过渡动画效果