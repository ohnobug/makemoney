#!/bin/bash

# 页面文件重命名脚本
# 为所有页面文件添加 _page 后缀

echo "开始重命名页面文件..."

# 重命名用户相关页面
mv lib/screens/user/wallet/ljn_pocketmoney.dart lib/screens/user/wallet/ljn_pocketmoney_page.dart
mv lib/screens/user/services/ljn_services.dart lib/screens/user/services/ljn_services_page.dart
mv lib/screens/user/services/ljn_services_manager.dart lib/screens/user/services/ljn_services_manager_page.dart
mv lib/screens/user/ljn_camera_view.dart lib/screens/user/ljn_camera_view_page.dart
mv lib/screens/user/wallet/ljn_collection_and_payment.dart lib/screens/user/wallet/ljn_collection_and_payment_page.dart
mv lib/screens/user/ljn_user_more_info.dart lib/screens/user/ljn_user_more_info_page.dart
mv lib/screens/user/course/ljn_course_list.dart lib/screens/user/course/ljn_course_list_page.dart

# 重命名设置相关页面
mv lib/screens/user/settings/ljn_account_and_secure.dart lib/screens/user/settings/ljn_account_and_secure_page.dart
mv lib/screens/user/settings/ljn_account_info.dart lib/screens/user/settings/ljn_account_info_page.dart
mv lib/screens/user/settings/ljn_change_account.dart lib/screens/user/settings/ljn_change_account_page.dart
mv lib/screens/user/settings/ljn_phone_number.dart lib/screens/user/settings/ljn_phone_number_page.dart
mv lib/screens/user/settings/ljn_phone_contact.dart lib/screens/user/settings/ljn_phone_contact_page.dart
mv lib/screens/user/settings/ljn_verify_phone.dart lib/screens/user/settings/ljn_verify_phone_page.dart
mv lib/screens/user/settings/ljn_bind_new_phone_number.dart lib/screens/user/settings/ljn_bind_new_phone_number_page.dart
mv lib/screens/user/settings/ljn_input_verify_code.dart lib/screens/user/settings/ljn_input_verify_code_page.dart
mv lib/screens/user/settings/ljn_youth_mode.dart lib/screens/user/settings/ljn_youth_mode_page.dart
mv lib/screens/user/settings/ljn_care_mode.dart lib/screens/user/settings/ljn_care_mode_page.dart
mv lib/screens/user/settings/ljn_new_message_notification.dart lib/screens/user/settings/ljn_new_message_notification_page.dart
mv lib/screens/user/settings/ljn_chat_setting.dart lib/screens/user/settings/ljn_chat_setting_page.dart
mv lib/screens/user/settings/ljn_common_setting.dart lib/screens/user/settings/ljn_common_setting_page.dart
mv lib/screens/user/settings/ljn_set_password.dart lib/screens/user/settings/ljn_set_password_page.dart
mv lib/screens/user/settings/ljn_logged_devices.dart lib/screens/user/settings/ljn_logged_devices_page.dart
mv lib/screens/user/settings/ljn_device_detail.dart lib/screens/user/settings/ljn_device_detail_page.dart
mv lib/screens/user/settings/ljn_emergency_contact.dart lib/screens/user/settings/ljn_emergency_contact_page.dart
mv lib/screens/user/settings/ljn_more_secure_setting.dart lib/screens/user/settings/ljn_more_secure_setting_page.dart
mv lib/screens/user/settings/ljn_sound_lock.dart lib/screens/user/settings/ljn_sound_lock_page.dart
mv lib/screens/user/settings/ljn_personal_info_and_permission.dart lib/screens/user/settings/ljn_personal_info_and_permission_page.dart
mv lib/screens/user/settings/ljn_about.dart lib/screens/user/settings/ljn_about_page.dart
mv lib/screens/user/settings/ljn_friend_permission.dart lib/screens/user/settings/ljn_friend_permission_page.dart
mv lib/screens/user/settings/ljn_language_setting.dart lib/screens/user/settings/ljn_language_setting_page.dart
mv lib/screens/user/settings/ljn_theme_setting.dart lib/screens/user/settings/ljn_theme_setting_page.dart

# 重命名钱包相关页面
mv lib/screens/user/wallet/ljn_change_details.dart lib/screens/user/wallet/ljn_change_details_page.dart
mv lib/screens/user/wallet/ljn_bill_details.dart lib/screens/user/wallet/ljn_bill_details_page.dart

# 重命名通讯录相关页面
mv lib/screens/contract/ljn_contact.dart lib/screens/contract/ljn_contact_page.dart
mv lib/screens/contract/ljn_contact_tags.dart lib/screens/contract/ljn_contact_tags_page.dart
mv lib/screens/contract/ljn_contact_tag_group.dart lib/screens/contract/ljn_contact_tag_group_page.dart
mv lib/screens/contract/ljn_official_accounts.dart lib/screens/contract/ljn_official_accounts_page.dart
mv lib/screens/contract/ljn_contact_group.dart lib/screens/contract/ljn_contact_group_page.dart
mv lib/screens/contract/ljn_friends_who_only_chat.dart lib/screens/contract/ljn_friends_who_only_chat_page.dart
mv lib/screens/contract/ljn_new_friends.dart lib/screens/contract/ljn_new_friends_page.dart
mv lib/screens/contract/ljn_search_friend.dart lib/screens/contract/ljn_search_friend_page.dart
mv lib/screens/contract/chat/friend/ljn_add_friends.dart lib/screens/contract/chat/friend/ljn_add_friends_page.dart

# 重命名聊天相关页面
mv lib/screens/contract/chat/friend/ljn_friend_data_setting.dart lib/screens/contract/chat/friend/ljn_friend_data_setting_page.dart
mv lib/screens/contract/chat/friend/ljn_friend_information.dart lib/screens/contract/chat/friend/ljn_friend_information_page.dart
mv lib/screens/contract/chat/friend/ljn_friend_message_record.dart lib/screens/contract/chat/friend/ljn_friend_message_record_page.dart
mv lib/screens/contract/chat/friend/ljn_friend_moments.dart lib/screens/contract/chat/friend/ljn_friend_moments_page.dart
mv lib/screens/contract/chat/friend/ljn_friend_more_info.dart lib/screens/contract/chat/friend/ljn_friend_more_info_page.dart
mv lib/screens/contract/chat/friend/ljn_friend_permissions.dart lib/screens/contract/chat/friend/ljn_friend_permissions_page.dart
mv lib/screens/contract/chat/friend/ljn_set_friend_tags.dart lib/screens/contract/chat/friend/ljn_set_friend_tags_page.dart
mv lib/screens/contract/chat/friend/ljn_set_notes_and_labels.dart lib/screens/contract/chat/friend/ljn_set_notes_and_labels_page.dart
mv lib/screens/contract/chat/group/ljn_group_message_record.dart lib/screens/contract/chat/group/ljn_group_message_record_page.dart
mv lib/screens/contract/chat/ljn_friend_profile.dart lib/screens/contract/chat/ljn_friend_profile_page.dart
mv lib/screens/contract/chat/friend/ljn_friend_moments_cover_setting.dart lib/screens/contract/chat/friend/ljn_friend_moments_cover_setting_page.dart

# 重命名发现相关页面
mv lib/screens/discovery/ljn_ins.dart lib/screens/discovery/ljn_ins_page.dart
mv lib/screens/discovery/ljn_miniprogram_list.dart lib/screens/discovery/ljn_miniprogram_list_page.dart
mv lib/screens/publisher/ljn_publisher.dart lib/screens/publisher/ljn_publisher_page.dart

# 重命名其他页面
mv lib/screens/arts/ljn_arts.dart lib/screens/arts/ljn_arts_page.dart
mv lib/test.dart lib/test_page.dart

echo "页面文件重命名完成！"