#!/bin/bash

# 更新路由文件中的类引用脚本

echo "开始更新路由文件中的类引用..."

# 更新路由文件中的类名引用
sed -i 's/const LJNPocketMoney()/const LJNPocketMoneyPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNServices()/const LJNServicesPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNServicesManager()/const LJNServicesManagerPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNCameraView()/const LJNCameraViewPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNCollectionAndPayment()/const LJNCollectionAndPaymentPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNUserMoreInfo()/const LJNUserMoreInfoPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNCourseList()/const LJNCourseListPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNAccountAndSecure()/const LJNAccountAndSecurePage()/g' lib/routing/app_router.dart
sed -i 's/const LJNAccountInfo()/const LJNAccountInfoPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNChangeAccount()/const LJNChangeAccountPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNPhoneNumber()/const LJNPhoneNumberPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNPhoneContact()/const LJNPhoneContactPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNVerifyPhone()/const LJNVerifyPhonePage()/g' lib/routing/app_router.dart
sed -i 's/const LJNBindNewPhoneNumber()/const LJNBindNewPhoneNumberPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNInputVerifyCode()/const LJNInputVerifyCodePage()/g' lib/routing/app_router.dart
sed -i 's/const LJNYouthMode()/const LJNYouthModePage()/g' lib/routing/app_router.dart
sed -i 's/const LJNCareMode()/const LJNCareModePage()/g' lib/routing/app_router.dart
sed -i 's/const LJNNewMessageNotification()/const LJNNewMessageNotificationPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNChatSetting()/const LJNChatSettingPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNCommonSetting()/const LJNCommonSettingPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNSetPassword()/const LJNSetPasswordPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNLoggedDevices()/const LJNLoggedDevicesPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNDeviceDetail()/const LJNDeviceDetailPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNEmergencyContact()/const LJNEmergencyContactPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNMoreSecureSetting()/const LJNMoreSecureSettingPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNSoundLock()/const LJNSoundLockPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNPersonalinfoAndPermission()/const LJNPersonalinfoAndPermissionPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNAbout()/const LJNAboutPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNFriendPermission()/const LJNFriendPermissionPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNLanguageSetting()/const LJNLanguageSettingPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNThemeSetting()/const LJNThemeSettingPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNChangeDetails()/const LJNChangeDetailsPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNBillDetails()/const LJNBillDetailsPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNContact()/const LJNContactPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNContactTags()/const LJNContactTagsPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNContactTagGroup()/const LJNContactTagGroupPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNOfficialAccounts()/const LJNOfficialAccountsPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNContactGroup()/const LJNContactGroupPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNFriendsWhoOnlyChat()/const LJNFriendsWhoOnlyChatPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNNewFriends()/const LJNNewFriendsPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNSearchFriend()/const LJNSearchFriendPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNAddFriends()/const LJNAddFriendsPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNFriendmoments()/const LJNFriendmomentsPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNFriendMessageRecord()/const LJNFriendMessageRecordPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNFriendDataSetting()/const LJNFriendDataSettingPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNFriendMoreInfo()/const LJNFriendMoreInfoPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNGroupMessageRecord()/const LJNGroupMessageRecordPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNSetNotesAndLabels()/const LJNSetNotesAndLabelsPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNFriendPermissions()/const LJNFriendPermissionsPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNFriendInformation()/const LJNFriendInformationPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNSetFriendTags()/const LJNSetFriendTagsPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNFriendMomentsCoverSetting()/const LJNFriendMomentsCoverSettingPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNIns()/const LJNInsPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNMiniProgramList()/const LJNMiniProgramListPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNPublisher()/const LJNPublisherPage()/g' lib/routing/app_router.dart
sed -i 's/const LJNTest()/const LJNTestPage()/g' lib/routing/app_router.dart

echo "路由文件类引用更新完成！"