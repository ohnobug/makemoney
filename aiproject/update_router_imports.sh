#!/bin/bash

# 更新路由文件中的import语句脚本

echo "开始更新路由文件中的import语句..."

# 更新所有import语句，添加_page后缀
sed -i 's/ljn_course_detail.dart/ljn_course_detail_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_course_list.dart/ljn_course_list_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_lesson_content.dart/ljn_lesson_content_page.dart/g' lib/routing/app_router.dart
sed -i 's/test.dart/test_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_chat.dart/ljn_chat_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_contact.dart/ljn_contact_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_contact_group.dart/ljn_contact_group_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_contact_tag_group.dart/ljn_contact_tag_group_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_contact_tags.dart/ljn_contact_tags_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_friends_who_only_chat.dart/ljn_friends_who_only_chat_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_new_friends.dart/ljn_new_friends_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_official_accounts.dart/ljn_official_accounts_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_search_friend.dart/ljn_search_friend_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_ins.dart/ljn_ins_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_miniprogram.dart/ljn_miniprogram_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_miniprogram_list.dart/ljn_miniprogram_list_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_qrcode_scanner.dart/ljn_qrcode_scanner_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_search.dart/ljn_search_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_publisher.dart/ljn_publisher_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_add_friends.dart/ljn_add_friends_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_friend_data_setting.dart/ljn_friend_data_setting_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_friend_information.dart/ljn_friend_information_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_friend_message_record.dart/ljn_friend_message_record_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_friend_moments.dart/ljn_friend_moments_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_friend_moments_cover_setting.dart/ljn_friend_moments_cover_setting_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_friend_more_info.dart/ljn_friend_more_info_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_friend_permissions.dart/ljn_friend_permissions_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_set_friend_tags.dart/ljn_set_friend_tags_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_set_notes_and_labels.dart/ljn_set_notes_and_labels_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_group_chat.dart/ljn_group_chat_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_group_message_record.dart/ljn_group_message_record_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_about.dart/ljn_about_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_account_and_secure.dart/ljn_account_and_secure_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_account_info.dart/ljn_account_info_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_bind_new_phone_number.dart/ljn_bind_new_phone_number_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_care_mode.dart/ljn_care_mode_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_change_account.dart/ljn_change_account_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_chat_setting.dart/ljn_chat_setting_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_common_setting.dart/ljn_common_setting_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_device_detail.dart/ljn_device_detail_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_emergency_contact.dart/ljn_emergency_contact_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_friend_permission.dart/ljn_friend_permission_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_input_verify_code.dart/ljn_input_verify_code_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_language_setting.dart/ljn_language_setting_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_logged_devices.dart/ljn_logged_devices_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_more_secure_setting.dart/ljn_more_secure_setting_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_new_message_notification.dart/ljn_new_message_notification_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_personal_info_and_permission.dart/ljn_personal_info_and_permission_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_personal_info_collection_checklist.dart/ljn_personal_info_collection_checklist_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_phone_contact.dart/ljn_phone_contact_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_phone_number.dart/ljn_phone_number_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_set_password.dart/ljn_set_password_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_setting.dart/ljn_setting_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_sound_lock.dart/ljn_sound_lock_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_theme_setting.dart/ljn_theme_setting_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_youth_mode.dart/ljn_youth_mode_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_verify_phone.dart/ljn_verify_phone_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_camera_view.dart/ljn_camera_view_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_collection_and_payment.dart/ljn_collection_and_payment_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_dial.dart/ljn_dial_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_friend_profile.dart/ljn_friend_profile_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_pocketmoney.dart/ljn_pocketmoney_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_services.dart/ljn_services_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_services_manager.dart/ljn_services_manager_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_user_more_info.dart/ljn_user_more_info_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_userinfo.dart/ljn_userinfo_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_wallet.dart/ljn_wallet_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_bill_details.dart/ljn_bill_details_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_change_details.dart/ljn_change_details_page.dart/g' lib/routing/app_router.dart
sed -i 's/publish_work.dart/publish_work_page.dart/g' lib/routing/app_router.dart
sed -i 's/geolocator.dart/geolocator_page.dart/g' lib/routing/app_router.dart
sed -i 's/ai_publisher.dart/ai_publisher_page.dart/g' lib/routing/app_router.dart
sed -i 's/resource_publisher.dart/resource_publisher_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_like.dart/ljn_like_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_login.dart/ljn_login_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_register.dart/ljn_register_page.dart/g' lib/routing/app_router.dart
sed -i 's/ljn_forgot_password.dart/ljn_forgot_password_page.dart/g' lib/routing/app_router.dart

echo "路由文件import语句更新完成！"