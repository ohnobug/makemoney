#!/bin/bash

# 全局类名替换脚本
# 用于替换所有指定的类名，在类名后添加Page后缀

# 项目根目录
PROJECT_ROOT="$(pwd)"

# 类名替换映射
declare -A CLASS_REPLACEMENTS=(
    ["LJNPocketMoney"]="LJNPocketMoneyPage"
    ["LJNServices"]="LJNServicesPage"
    ["LJNServicesManager"]="LJNServicesManagerPage"
    ["LJNUserMoreInfo"]="LJNUserMoreInfoPage"
    ["LJNUserinfo"]="LJNUserinfoPage"
    ["LJNWallet"]="LJNWalletPage"
    ["LJNBillDetails"]="LJNBillDetailsPage"
    ["LJNChangeDetails"]="LJNChangeDetailsPage"
    ["LJNCameraView"]="LJNCameraViewPage"
    ["LJNCollectionAndPayment"]="LJNCollectionAndPaymentPage"
    ["LJNCourseDetail"]="LJNCourseDetailPage"
    ["LJNCourseList"]="LJNCourseListPage"
    ["LJNLessonContent"]="LJNLessonContentPage"
    ["LJNLogin"]="LJNLoginPage"
    ["LJNRegister"]="LJNRegisterPage"
    ["LJNForgotPassword"]="LJNForgotPasswordPage"
    ["LJNSetting"]="LJNSettingPage"
    ["LJNAccountAndSecure"]="LJNAccountAndSecurePage"
    ["LJNAccountInfo"]="LJNAccountInfoPage"
    ["LJNChangeAccount"]="LJNChangeAccountPage"
    ["LJNPhoneNumber"]="LJNPhoneNumberPage"
    ["LJNPhoneContact"]="LJNPhoneContactPage"
    ["LJNVerifyPhone"]="LJNVerifyPhonePage"
    ["LJNBindNewPhoneNumber"]="LJNBindNewPhoneNumberPage"
    ["LJNInputVerifyCode"]="LJNInputVerifyCodePage"
    ["LJNYouthMode"]="LJNYouthModePage"
    ["LJNCareMode"]="LJNCareModePage"
    ["LJNNewMessageNotification"]="LJNNewMessageNotificationPage"
    ["LJNChatSetting"]="LJNChatSettingPage"
    ["LJNCommonSetting"]="LJNCommonSettingPage"
    ["LJNSetPassword"]="LJNSetPasswordPage"
    ["LJNLoggedDevices"]="LJNLoggedDevicesPage"
    ["LJNDeviceDetail"]="LJNDeviceDetailPage"
    ["LJNEmergencyContact"]="LJNEmergencyContactPage"
    ["LJNMoreSecureSetting"]="LJNMoreSecureSettingPage"
    ["LJNSoundLock"]="LJNSoundLockPage"
    ["LJNPersonalinfoAndPermission"]="LJNPersonalinfoAndPermissionPage"
    ["LJNPersonalInfoCollectionChecklist"]="LJNPersonalInfoCollectionChecklistPage"
    ["LJNAbout"]="LJNAboutPage"
    ["LJNFriendPermission"]="LJNFriendPermissionPage"
    ["LJNLanguageSetting"]="LJNLanguageSettingPage"
    ["LJNThemeSetting"]="LJNThemeSettingPage"
    ["LJNContact"]="LJNContactPage"
    ["LJNContactTags"]="LJNContactTagsPage"
    ["LJNContactTagGroup"]="LJNContactTagGroupPage"
    ["LJNOfficialAccounts"]="LJNOfficialAccountsPage"
    ["LJNContactGroup"]="LJNContactGroupPage"
    ["LJNFriendsWhoOnlyChat"]="LJNFriendsWhoOnlyChatPage"
    ["LJNNewFriends"]="LJNNewFriendsPage"
    ["LJNSearchFriend"]="LJNSearchFriendPage"
    ["LJNAddFriends"]="LJNAddFriendsPage"
    ["LJNFriendProfile"]="LJNFriendProfilePage"
    ["LJNFriendmoments"]="LJNFriendmomentsPage"
    ["LJNFriendMessageRecord"]="LJNFriendMessageRecordPage"
    ["LJNFriendDataSetting"]="LJNFriendDataSettingPage"
    ["LJNFriendMoreInfo"]="LJNFriendMoreInfoPage"
    ["LJNGroupMessageRecord"]="LJNGroupMessageRecordPage"
    ["LJNDial"]="LJNDialPage"
    ["LJNSetNotesAndLabels"]="LJNSetNotesAndLabelsPage"
    ["LJNFriendPermissions"]="LJNFriendPermissionsPage"
    ["LJNFriendInformation"]="LJNFriendInformationPage"
    ["LJNSetFriendTags"]="LJNSetFriendTagsPage"
    ["LJNFriendMomentsCoverSetting"]="LJNFriendMomentsCoverSettingPage"
    ["LJNSearch"]="LJNSearchPage"
    ["LJNIns"]="LJNInsPage"
    ["LJNMiniProgramList"]="LJNMiniProgramListPage"
    ["LJNPublisher"]="LJNPublisherPage"
    ["LJNTest"]="LJNTestPage"
)

echo "开始全局类名替换..."
echo "======================================"

# 统计变量
total_files=0
total_replacements=0

# 遍历所有Dart文件
for file in $(find "$PROJECT_ROOT" -name "*.dart" -type f); do
    file_changed=false
    file_replacements=0

    # 创建临时文件
    temp_file="${file}.tmp"
    cp "$file" "$temp_file"

    # 对每个类名进行替换
    for old_class in "${!CLASS_REPLACEMENTS[@]}"; do
        new_class="${CLASS_REPLACEMENTS[$old_class]}"

        # 使用sed进行替换
        sed -i "s/\b${old_class}\b/${new_class}/g" "$temp_file"

        # 检查是否有替换发生
        if grep -q "\b${old_class}\b" "$file" 2>/dev/null; then
            count=$(grep -o "\b${old_class}\b" "$file" | wc -l)
            if [ $count -gt 0 ]; then
                file_changed=true
                file_replacements=$((file_replacements + count))
                echo "  - $file: $old_class -> $new_class ($count 处)"
            fi
        fi
    done

    # 如果文件有变化，替换原文件
    if [ "$file_changed" = true ]; then
        mv "$temp_file" "$file"
        total_files=$((total_files + 1))
        total_replacements=$((total_replacements + file_replacements))
    else
        rm "$temp_file"
    fi
done

echo "======================================"
echo "✅ 全局类名替换完成！"
echo "总计: $total_files 个文件被修改，$total_replacements 处替换"

# 显示替换统计
echo ""
echo "替换统计:"
for old_class in "${!CLASS_REPLACEMENTS[@]}"; do
    new_class="${CLASS_REPLACEMENTS[$old_class]}"
    echo "  $old_class -> $new_class"
done