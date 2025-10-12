#!/bin/bash

# 最终页面重命名脚本
# 只重命名路由文件中引用的页面

echo "开始重命名路由文件中的页面..."

# 基于路由文件中的导入，重命名真正的页面文件

# 用户相关页面
mv lib/screens/user/course/ljn_course_detail.dart lib/screens/user/course/ljn_course_detail_page.dart
mv lib/screens/user/course/ljn_lesson_content.dart lib/screens/user/course/ljn_lesson_content_page.dart

# 认证相关页面
mv lib/screens/user/auth/ljn_login.dart lib/screens/user/auth/ljn_login_page.dart
mv lib/screens/user/auth/ljn_register.dart lib/screens/user/auth/ljn_register_page.dart
mv lib/screens/user/auth/ljn_forgot_password.dart lib/screens/user/auth/ljn_forgot_password_page.dart

# 设置相关页面
mv lib/screens/user/settings/ljn_setting.dart lib/screens/user/settings/ljn_setting_page.dart
mv lib/screens/user/settings/ljn_forgot_password.dart lib/screens/user/settings/ljn_forgot_password_page.dart
mv lib/screens/user/settings/ljn_personal_info_collection_checklist.dart lib/screens/user/settings/ljn_personal_info_collection_checklist_page.dart

# 通讯录相关页面
mv lib/screens/contract/ljn_recent_chats_list.dart lib/screens/contract/ljn_recent_chats_list_page.dart

# 聊天相关页面
mv lib/screens/contract/chat/ljn_chat.dart lib/screens/contract/chat/ljn_chat_page.dart
mv lib/screens/contract/chat/ljn_dial.dart lib/screens/contract/chat/ljn_dial_page.dart
mv lib/screens/contract/chat/group/ljn_group_chat.dart lib/screens/contract/chat/group/ljn_group_chat_page.dart

# 发现相关页面
mv lib/screens/discovery/ljn_discovery.dart lib/screens/discovery/ljn_discovery_page.dart
mv lib/screens/discovery/ljn_miniprogram.dart lib/screens/discovery/ljn_miniprogram_page.dart
mv lib/screens/discovery/ljn_qrcode_scanner.dart lib/screens/discovery/ljn_qrcode_scanner_page.dart
mv lib/screens/discovery/ljn_search.dart lib/screens/discovery/ljn_search_page.dart

# 发布相关页面
mv lib/screens/publisher/ai_publisher.dart lib/screens/publisher/ai_publisher_page.dart
mv lib/screens/publisher/geolocator.dart lib/screens/publisher/geolocator_page.dart
mv lib/screens/publisher/publish_work.dart lib/screens/publisher/publish_work_page.dart
mv lib/screens/publisher/resource_publisher.dart lib/screens/publisher/resource_publisher_page.dart

# 其他页面
mv lib/screens/user/like/ljn_like.dart lib/screens/user/like/ljn_like_page.dart
mv lib/screens/user/ljn_user.dart lib/screens/user/ljn_user_page.dart

echo "页面文件重命名完成！"