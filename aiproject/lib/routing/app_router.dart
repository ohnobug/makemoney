import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// --- 步骤1: 粘贴您旧文件中所有的页面 import 语句 ---
// (确保这里的路径和您的项目结构一致)
import 'package:vigaviga/features/payment/screens/viga_merchant_success_page.dart';
import 'package:vigaviga/screens/contract/chat/viga_chat_page.dart';
import 'package:vigaviga/screens/contract/viga_contact_page.dart';
import 'package:vigaviga/screens/contract/viga_contact_group_page.dart';
import 'package:vigaviga/screens/contract/viga_contact_tag_group_page.dart';
import 'package:vigaviga/screens/contract/viga_contact_tags_page.dart';
import 'package:vigaviga/screens/contract/viga_friends_who_only_chat_page.dart';
import 'package:vigaviga/screens/contract/viga_new_friends_page.dart';
import 'package:vigaviga/screens/contract/viga_official_accounts_page.dart';
import 'package:vigaviga/screens/contract/viga_search_friend_page.dart';
import 'package:vigaviga/screens/discovery/viga_ins_page.dart';
import 'package:vigaviga/screens/discovery/viga_miniprogram_page.dart';
import 'package:vigaviga/screens/discovery/viga_miniprogram_list_page.dart';
import 'package:vigaviga/features/webview/viga_webview_page.dart';
import 'package:vigaviga/screens/discovery/viga_post_detail_page.dart';
import 'package:vigaviga/screens/discovery/viga_qrcode_scanner_page.dart';
import 'package:vigaviga/screens/discovery/search/viga_search_page.dart';
import 'package:vigaviga/screens/publisher/viga_publisher_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/viga_add_friends_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/viga_friend_data_setting_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/viga_friend_information_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/viga_friend_message_record_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/viga_friend_moments_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/viga_friend_moments_cover_setting_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/viga_friend_more_info_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/viga_friend_permissions_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/viga_set_friend_tags_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/viga_set_notes_and_labels_page.dart';
import 'package:vigaviga/screens/contract/chat/group/viga_group_chat_page.dart';
import 'package:vigaviga/screens/contract/chat/group/viga_group_message_record_page.dart';
import 'package:vigaviga/screens/user/settings/viga_about_page.dart';
import 'package:vigaviga/screens/user/settings/viga_feature_introduction_page.dart';
import 'package:vigaviga/screens/user/settings/viga_complain_page.dart';
import 'package:vigaviga/screens/user/settings/viga_account_and_secure_page.dart';
import 'package:vigaviga/screens/user/settings/viga_account_info_page.dart';
import 'package:vigaviga/screens/user/settings/viga_bind_new_phone_number_page.dart';
import 'package:vigaviga/screens/user/settings/viga_care_mode_page.dart';
import 'package:vigaviga/screens/user/settings/viga_change_account_page.dart';
import 'package:vigaviga/screens/user/settings/viga_chat_setting_page.dart';
import 'package:vigaviga/screens/user/settings/viga_common_setting_page.dart';
import 'package:vigaviga/screens/user/settings/viga_device_detail_page.dart';
import 'package:vigaviga/screens/user/settings/viga_emergency_contact_page.dart';
import 'package:vigaviga/screens/user/settings/viga_friend_permission_page.dart';
import 'package:vigaviga/screens/user/settings/viga_input_verify_code_page.dart';
import 'package:vigaviga/screens/user/settings/viga_language_setting_page.dart';
import 'package:vigaviga/screens/user/settings/viga_logged_devices_page.dart';
import 'package:vigaviga/screens/user/settings/viga_more_secure_setting_page.dart';
import 'package:vigaviga/screens/user/settings/viga_new_message_notification_page.dart';
import 'package:vigaviga/screens/user/settings/viga_personal_info_and_permission_page.dart';
import 'package:vigaviga/screens/user/settings/viga_personal_info_collection_checklist_page.dart';
import 'package:vigaviga/screens/user/settings/viga_phone_contact_page.dart';
import 'package:vigaviga/screens/user/settings/viga_phone_number_page.dart';
import 'package:vigaviga/screens/user/settings/viga_set_password_page.dart';
import 'package:vigaviga/screens/user/settings/viga_setting_page.dart';
import 'package:vigaviga/screens/user/settings/viga_sound_lock_page.dart';
import 'package:vigaviga/screens/user/settings/viga_theme_setting_page.dart';
import 'package:vigaviga/screens/user/settings/viga_youth_mode_page.dart';
import 'package:vigaviga/screens/user/settings/viga_verify_phone_page.dart';
import 'package:vigaviga/screens/user/viga_camera_view_page.dart';
import 'package:vigaviga/screens/user/wallet/viga_collection_and_payment_page.dart';
import 'package:vigaviga/screens/user/wallet/viga_pocketmoney_page.dart';
import 'package:vigaviga/screens/user/services/viga_services_page.dart';
import 'package:vigaviga/screens/user/services/viga_services_manager_page.dart';
import 'package:vigaviga/screens/user/viga_user_more_info_page.dart';
import 'package:vigaviga/screens/user/viga_userinfo_page.dart';
import 'package:vigaviga/screens/arts/viga_author_detail_page.dart';
import 'package:vigaviga/screens/user/wallet/viga_wallet_page.dart';
import 'package:vigaviga/screens/user/wallet/viga_bill_details_page.dart';
import 'package:vigaviga/screens/user/wallet/viga_change_details_page.dart';
import 'package:vigaviga/screens/user/follow/viga_follow_page.dart';
import 'package:vigaviga/screens/user/like/viga_like_page.dart';
import 'package:vigaviga/screens/user/auth/viga_switch_account_page.dart';
import 'package:vigaviga/screens/user/auth/viga_sign_in_page.dart';
import 'package:vigaviga/screens/user/auth/viga_sign_up_page.dart';
import 'package:vigaviga/screens/user/auth/viga_forgot_password_page.dart';
import 'package:vigaviga/screens/user/photo_viewer/viga_photo_grid_page.dart';
import 'package:vigaviga/screens/contract/chat/viga_dial_page.dart';
import 'package:vigaviga/screens/contract/chat/viga_friend_profile_page.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/videoplayer.dart';
import 'package:vigaviga/widgets/viga_custom_tabbar.dart';
import 'package:vigaviga/screens/publisher/viga_publish_work_page.dart';
import 'package:vigaviga/screens/publisher/viga_geolocator_page.dart';
import 'package:vigaviga/screens/publisher/viga_ai_publisher_page.dart';
import 'package:vigaviga/screens/user/viga_user_info_page.dart';
import 'package:vigaviga/screens/publisher/viga_resource_publisher_page.dart';
import 'package:vigaviga/features/payment/screens/viga_alipay_success_page.dart';
import 'package:vigaviga/features/payment/screens/viga_payment_demo_page.dart';
import 'package:vigaviga/screens/user/settings/account_and_security/viga_verification_page.dart';
import 'package:vigaviga/screens/user/settings/account_and_security/viga_change_account.dart';
import 'package:vigaviga/screens/user/settings/account_and_security/viga_change_phone.dart';
import 'package:vigaviga/screens/user/settings/account_and_security/viga_select_country.dart';
import 'package:vigaviga/screens/user/settings/account_and_security/viga_change_email.dart';
import 'package:vigaviga/screens/user/settings/account_and_security/viga_verify_email_screen.dart';

// --- 步骤2: 定义全局的 GoRouter 实例 ---
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // 主页面和通用路由
    GoRoute(
        path: '/',
        pageBuilder: (c, s) =>
            buildPageWithoutAnimation(child: const VigaCustomTabbar())),
    GoRoute(
        path: '/publish_work',
        pageBuilder: (c, s) => buildPageWithoutAnimation(
            child: const VigaVideoPublishPageState())),
    GoRoute(
        path: '/locationPage',
        pageBuilder: (c, s) =>
            buildPageWithoutAnimation(child: const VigaGeolocatorPage())),
    GoRoute(
        path: '/ai_publisher',
        pageBuilder: (c, s) =>
            buildPageWithoutAnimation(child: const VigaAiPublisherPage())),
    GoRoute(
        path: '/resource_publisher',
        pageBuilder: (c, s) =>
            buildPageWithoutAnimation(child: const VigaResourceSearchPage())),
    GoRoute(
        path: '/verification',
        pageBuilder: (c, s) =>
            buildPageWithoutAnimation(child: const VigaVerificationPage())),
    GoRoute(
        path: '/change_phone',
        pageBuilder: (c, s) => buildPageWithoutAnimation(
            child: const VigaChangePhoneNumberScreen())),
    GoRoute(
        path: '/change_account',
        pageBuilder: (c, s) =>
            buildPageWithoutAnimation(child: const VigaChangeAccount())),
    GoRoute(
        path: '/country',
        pageBuilder: (c, s) =>
            buildPageWithoutAnimation(child: const VigaSelectCountryPage())),
    GoRoute(
        path: '/user/user_info',
        pageBuilder: (c, s) =>
            buildPageWithoutAnimation(child: const UserInfoPage())),
    GoRoute(
        path: '/discovery/qrcode_scanner',
        pageBuilder: (c, s) =>
            buildPageWithoutAnimation(child: const VigaQRCodeScanner())),
    GoRoute(
        path: '/video_player',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaVideoPage())),

    // 带参数的动态路由
    GoRoute(
      path: '/open_miniprogram',
      pageBuilder: (context, state) {
        final cid = state.uri.queryParameters['cid'] ?? "";
        logger.info("Navigating to miniprogram with cid: $cid");
        return buildPageWithAnimation(child: VigaMiniProgram(cid: cid));
      },
    ),

    // 设置相关路由
    GoRoute(
        path: '/settings',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaSettingPage())),
    GoRoute(
        path: '/settings/change_email',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaModifyEmailPage())),
    GoRoute(
        path: '/settings/verify_email_screen',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaVerifyEmailScreen())),
    GoRoute(
        path: '/settings/account_and_secure',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaAccountAndSecurePage())),
    GoRoute(
        path: '/settings/account_info',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaAccountInfoPage())),
    GoRoute(
        path: '/settings/change_account',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaChangeAccountPage())),
    GoRoute(
        path: '/user/auth/switch_account',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaSwitchAccountPage())),
    GoRoute(
        path: '/settings/phone_number',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaPhoneNumberPage())),
    GoRoute(
        path: '/settings/phone_contact',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaPhoneContactPage())),
    GoRoute(
        path: '/settings/verify_phone',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaVerifyPhonePage())),
    GoRoute(
        path: '/settings/security/bind_phone',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaBindNewPhoneNumberPage())),
    GoRoute(
        path: '/settings/input_verify_code',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaInputVerifyCodePage())),
    GoRoute(
        path: '/settings/teenage_mode',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaYouthModePage())),
    GoRoute(
        path: '/settings/care_mode',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaCareModePage())),
    GoRoute(
        path: '/settings/new_message_notification',
        pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaNewMessageNotificationPage())),
    GoRoute(
        path: '/settings/chat_setting',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaChatSettingPage())),
    GoRoute(
        path: '/settings/common_setting',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaCommonSettingPage())),
    GoRoute(
        path: '/settings/set_password',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaSetPasswordPage())),
    GoRoute(
        path: '/settings/logged_devices',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaLoggedDevicesPage())),
    GoRoute(
        path: '/settings/device_detail',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaDeviceDetailPage())),
    GoRoute(
        path: '/settings/emergency_contact',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaEmergencyContactPage())),
    GoRoute(
        path: '/settings/more_secure_setting',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaMoreSecureSettingPage())),
    GoRoute(
        path: '/settings/sound_lock',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaSoundLockPage())),
    GoRoute(
        path: '/settings/personinfo_and_permission',
        pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaPersonalinfoAndPermissionPage())),
    GoRoute(
        path: '/settings/personalinfo_collection_checklist',
        pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaPersonalInfoCollectionChecklistPage())),
    GoRoute(
        path: '/settings/about',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaAboutPage())),
    GoRoute(
        path: '/settings/feature_introduction',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaFeatureIntroductionPage())),
    GoRoute(
        path: '/settings/complain',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaComplainPage())),
    GoRoute(
        path: '/settings/friend_permission',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaFriendPermissionPage())),
    GoRoute(
        path: '/settings/language_setting',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaLanguageSettingPage())),
    GoRoute(
        path: '/settings/theme_setting',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaThemeSettingPage())),

    // 通讯录相关路由
    GoRoute(
        path: '/contact',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaContactPage())),
    GoRoute(
        path: '/contact/tags',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaContactTagsPage())),
    GoRoute(
        path: '/contact/tag_group',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaContactTagGroupPage())),
    GoRoute(
        path: '/contact/official_accounts',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaOfficialAccountsPage())),
    GoRoute(
        path: '/contact/group',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaContactGroupPage())),
    GoRoute(
        path: '/contact/friends_who_only_chat',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaFriendsWhoOnlyChatPage())),
    GoRoute(
        path: '/contact/new_friends',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaNewFriendsPage())),
    GoRoute(
        path: '/contact/search_friend',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaSearchFriendPage())),
    GoRoute(
        path: '/contact/add_friends',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaAddFriendsPage())),

    // 聊天相关路由
    GoRoute(
        path: '/chat',
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, String>;
          return buildPageWithAnimation(
              child: VigaChat(
            title: args['title']!,
            icon: args['icon']!,
            fromTabIndex: args['fromTabIndex'],
          ));
        }),
    GoRoute(
        path: '/group_chat',
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, String>;
          return buildPageWithAnimation(
              child: VigaGroupChat(
            title: args['title']!,
            icon: args['icon']!,
            fromTabIndex: args['fromTabIndex'],
          ));
        }),
    GoRoute(
        path: '/chat/friend_profile',
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, String>? ?? {};
          return buildPageWithAnimation(
              child: VigaFriendProfilePage(
            name: args['name'] ?? "",
            nickname: args['nickname'] ?? "",
            account: args['account'] ?? "",
            avatar: args['avatar'] ?? "",
          ));
        }),
    GoRoute(
        path: '/chat/friend_moments',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaFriendmomentsPage())),
    GoRoute(
        path: '/chat/friend_message_record',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaFriendMessageRecordPage())),
    GoRoute(
        path: '/chat/friend_data_setting',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaFriendDataSettingPage())),
    GoRoute(
        path: '/chat/friend_more_info',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaFriendMoreInfoPage())),
    GoRoute(
        path: '/chat/group_message_record',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaGroupMessageRecordPage())),
    GoRoute(
        path: '/chat/dial',
        pageBuilder: (c, s) =>
            buildPageWithoutAnimation(child: const VigaDialPage())),
    GoRoute(
        path: '/chat/set_notes_and_labels',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaSetNotesAndLabelsPage())),
    GoRoute(
        path: '/chat/friend_permissions',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaFriendPermissionsPage())),
    GoRoute(
        path: '/chat/friend_information',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaFriendInformationPage())),
    GoRoute(
        path: '/chat/set_friend_tags',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaSetFriendTagsPage())),
    GoRoute(
        path: '/chat/friend_moments_cover_setting',
        pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaFriendMomentsCoverSettingPage())),

    // 发现相关路由
    GoRoute(
        path: '/discovery/search',
        pageBuilder: (c, s) =>
            buildPageWithoutAnimation(child: const VigaSearchPage())),
    GoRoute(
        path: '/discovery/ins',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaInsPage())),
    GoRoute(
        path: '/discovery/miniprogram_list',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaMiniProgramListPage())),
    GoRoute(
        path: '/web_browser',
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, String>? ?? {};
          return buildPageWithAnimation(
              child: VigaWebViewPage(
            url: args['url'] ?? 'https://www.baidu.com',
            title: args['title'] ?? '浏览器',
          ));
        }),
    GoRoute(
        path: '/webview',
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, String>? ?? {};
          return buildPageWithAnimation(
              child: VigaWebViewPage(
            url: args['url'] ?? 'http://localhost:5173',
            title: args['title'] ?? '网页',
          ));
        }),
    GoRoute(
        path: '/discovery/publisher',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaPublisherPage())),
    GoRoute(
        path: '/discovery/ins/post_detail_page',
        pageBuilder: (context, state) {
          final args = state.extra as PostDetailData?;
          return buildPageWithAnimation(
              child: VigaPostDetailPage(
                  postData: args ?? _createDefaultPostData()));
        }),

    // 用户相关路由
    GoRoute(
        path: '/user/like',
        pageBuilder: (c, s) =>
            buildPageWithoutAnimation(child: const LikedVideosPage())),
    GoRoute(
        path: '/user/follow_and_fans',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaFollowPage())),
    GoRoute(
        path: '/user/wallet',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaWalletPage())),
    GoRoute(
        path: '/user/info',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaUserinfoPage())),
    GoRoute(
        path: '/user/photo_viewer',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaPhotoGridPage())),
    GoRoute(
        path: '/user/pocketmoney',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaPocketMoneyPage())),
    GoRoute(
        path: '/user/services',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaServicesPage())),
    GoRoute(
        path: '/user/services_manager',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaServicesManagerPage())),
    GoRoute(
        path: '/user/camera',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaCameraViewPage())),
    GoRoute(
        path: '/user/collection_and_payment',
        pageBuilder: (c, s) => buildPageWithoutAnimation(
            child: const VigaCollectionAndPaymentPage())),
    GoRoute(
        path: '/user/more_info',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaUserMoreInfoPage())),

    // 作者详情页面
    GoRoute(
        path: '/author/detail',
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, String>? ?? {};
          return buildPageWithAnimation(
              child: VigaAuthorDetailPage(
            authorId: args['author_id'] ?? "",
            authorName: args['author_name'] ?? "",
            authorAvatar: args['author_avatar'] ?? "",
          ));
        }),

    // 用户认证相关路由
    GoRoute(
        path: '/user/auth/login',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaSignInPage())),
    GoRoute(
        path: '/user/auth/register',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaSignUpPage())),
    GoRoute(
        path: '/user/auth/forgot_password',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaForgotPasswordPage())),
    GoRoute(
        path: '/user/wallet/change_details',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaChangeDetailsPage())),
    GoRoute(
        path: '/user/wallet/bill_details',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaBillDetailsPage())),

    // 支付模块相关路由
    GoRoute(
        path: '/payment_alipay_success',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaAliPaySuccessPage())),
    GoRoute(
        path: '/payment_merchant_success',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaMerchantSuccessPage())),
    GoRoute(
        path: '/payment_demo',
        pageBuilder: (c, s) =>
            buildPageWithAnimation(child: const VigaPaymentDemoPage())),
  ],
  // 统一的错误/404页面处理
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('页面未找到: ${state.uri}'),
    ),
  ),
);

// --- 步骤3: 定义统一的页面构建方法，用于处理动画 ---

// 带动画的页面
CustomTransitionPage buildPageWithAnimation<T>({required Widget child}) {
  return CustomTransitionPage<T>(
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

// 无动画的页面
CustomTransitionPage buildPageWithoutAnimation<T>({required Widget child}) {
  return CustomTransitionPage<T>(
    child: child,
    transitionDuration: Duration.zero,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        child,
  );
}

// --- 步骤4: 保留您的辅助函数 ---

// 创建默认的帖子详情数据
PostDetailData _createDefaultPostData() {
  return PostDetailData(
    id: 'default_post',
    username: '默认用户',
    avatarUrl: 'https://picsum.photos/seed/default/100/100',
    imageUrls: [
      'https://picsum.photos/seed/default1/600/800',
      'https://picsum.photos/seed/default2/600/800',
    ],
    title: '这是一个默认的帖子标题',
    tags: ['默认标签1', '默认标签2'],
    timestamp: '刚刚',
    location: '未知地点',
    likes: 0,
    favorites: 0,
    comments: 0,
    isFollowed: false,
  );
}
