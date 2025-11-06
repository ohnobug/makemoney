import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// --- 所有的页面 Import 语句 (已全部保留) ---
import 'package:vigaviga/features/payment/screens/viga_merchant_success_page.dart';
import 'package:vigaviga/screens/contract/chat/viga_chat_page.dart';
import 'package:vigaviga/screens/contract/viga_contact_page.dart';
import 'package:vigaviga/screens/contract/viga_contact_group_page.dart';
import 'package:vigaviga/screens/contract/viga_contact_tag_group_page.dart';
import 'package:vigaviga/screens/contract/viga_contact_tags_page.dart';
import 'package:vigaviga/screens/contract/viga_friends_who_only_chat_page.dart';
import 'package:vigaviga/screens/contract/viga_new_friends_page.dart';
import 'package:vigaviga/screens/contract/viga_official_accounts_page.dart';
import 'package:vigaviga/screens/contract/viga_phone_contact_page.dart';
import 'package:vigaviga/screens/contract/viga_search_friend_page.dart';
import 'package:vigaviga/screens/discovery/viga_discovery_page.dart';
import 'package:vigaviga/screens/discovery/viga_ins_page.dart';
import 'package:vigaviga/screens/discovery/viga_miniprogram_page.dart';
import 'package:vigaviga/screens/discovery/viga_miniprogram_list_page.dart';
import 'package:vigaviga/features/webview/viga_webview_page.dart';
import 'package:vigaviga/screens/discovery/viga_post_detail_page.dart';
import 'package:vigaviga/screens/discovery/viga_qrcode_scanner_page.dart';
import 'package:vigaviga/features/search/viga_search_page.dart';
import 'package:vigaviga/features/search/viga_user_content_search_page.dart';
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
import 'package:vigaviga/screens/user/photo_viewer/viga_photo_grid_page.dart';
import 'package:vigaviga/screens/user/settings/viga_about_page.dart';
import 'package:vigaviga/screens/user/settings/viga_feature_introduction_page.dart';
import 'package:vigaviga/screens/user/settings/viga_complain_page.dart';
import 'package:vigaviga/screens/user/settings/viga_account_and_secure_page.dart';
import 'package:vigaviga/screens/user/settings/viga_account_info_page.dart';
import 'package:vigaviga/screens/user/settings/viga_change_account_page.dart';
import 'package:vigaviga/screens/user/settings/viga_chat_setting_page.dart';
import 'package:vigaviga/screens/user/settings/viga_common_setting_page.dart';
import 'package:vigaviga/screens/user/settings/viga_device_detail_page.dart';
import 'package:vigaviga/screens/user/settings/viga_emergency_contact_page.dart';
import 'package:vigaviga/screens/user/settings/viga_friend_permission_page.dart';
import 'package:vigaviga/screens/user/settings/viga_input_verify_code_page.dart';
import 'package:vigaviga/screens/user/settings/viga_language_setting_page.dart';
import 'package:vigaviga/screens/user/settings/viga_logged_devices_page.dart';
import 'package:vigaviga/screens/user/settings/viga_new_message_notification_page.dart';
import 'package:vigaviga/screens/user/settings/viga_personal_info_and_permission_page.dart';
import 'package:vigaviga/screens/user/settings/viga_personal_info_collection_checklist_page.dart';
import 'package:vigaviga/screens/user/settings/viga_phone_number_page.dart';
import 'package:vigaviga/screens/user/settings/viga_set_password_page.dart';
import 'package:vigaviga/screens/user/settings/viga_setting_page.dart';
import 'package:vigaviga/screens/user/settings/viga_theme_setting_page.dart';
import 'package:vigaviga/screens/user/settings/viga_verify_phone_page.dart';
import 'package:vigaviga/screens/user/viga_camera_view_page.dart';
import 'package:vigaviga/screens/user/wallet/viga_collection_and_payment_page.dart';
import 'package:vigaviga/screens/user/wallet/viga_pocketmoney_page.dart';
import 'package:vigaviga/screens/user/services/viga_services_page.dart';
import 'package:vigaviga/screens/user/services/viga_services_manager_page.dart';
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
import 'package:vigaviga/screens/contract/chat/viga_dial_page.dart';
import 'package:vigaviga/screens/contract/chat/viga_friend_profile_page.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/videoplayer.dart';
import 'package:vigaviga/widgets/viga_chatlist_item.dart';
import 'package:vigaviga/widgets/viga_custom_tabbar.dart';
import 'package:vigaviga/screens/publisher/viga_publish_work_page.dart';
import 'package:vigaviga/screens/publisher/viga_geolocator_page.dart';
import 'package:vigaviga/screens/publisher/viga_ai_publisher_page.dart';
import 'package:vigaviga/screens/user/viga_user_card_page.dart';
import 'package:vigaviga/screens/publisher/viga_resource_publisher_page.dart';
import 'package:vigaviga/features/payment/screens/viga_alipay_success_page.dart';
import 'package:vigaviga/features/payment/screens/viga_payment_demo_page.dart';
import 'package:vigaviga/screens/user/settings/account_and_security/viga_verification_page.dart';
import 'package:vigaviga/screens/user/settings/account_and_security/viga_change_account.dart';
import 'package:vigaviga/screens/user/settings/account_and_security/viga_change_phone.dart';
import 'package:vigaviga/screens/user/settings/account_and_security/viga_select_country.dart';
import 'package:vigaviga/screens/user/settings/account_and_security/viga_change_email.dart';
import 'package:vigaviga/screens/user/settings/account_and_security/viga_verify_email_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(
        'Page not found: ${state.uri}',
      ),
    ),
  ),
  routes: [
    // --- 根路由 / Top-Level Routes ---
    GoRoute(
      path: '/',
      pageBuilder: (c, s) => buildPageWithoutAnimation(
        child: const VigaCustomTabbar(),
      ),
    ),

    // --- 发布模块 (Publisher Module) ---
    GoRoute(
      path: '/publish_work',
      pageBuilder: (c, s) => buildPageWithoutAnimation(
        child: const VigaVideoPublishPageState(),
      ),
    ),
    GoRoute(
      path: '/location_page',
      pageBuilder: (c, s) => buildPageWithoutAnimation(
        child: const VigaGeolocatorPage(),
      ),
    ),
    GoRoute(
      path: '/ai_publisher',
      pageBuilder: (c, s) => buildPageWithoutAnimation(
        child: const VigaAiPublisherPage(),
      ),
    ),
    GoRoute(
      path: '/resource_publisher',
      pageBuilder: (c, s) => buildPageWithoutAnimation(
        child: const VigaResourceSearchPage(),
      ),
    ),

    // --- 认证与账户安全 (Auth & Security) ---
    GoRoute(
      path: '/verification',
      pageBuilder: (c, s) => buildPageWithoutAnimation(
        child: const VigaVerificationPage(),
      ),
    ),
    GoRoute(
      path: '/change_phone',
      pageBuilder: (c, s) => buildPageWithoutAnimation(
        child: const VigaChangePhonePage(),
      ),
    ),
    GoRoute(
      path: '/change_account',
      pageBuilder: (c, s) => buildPageWithoutAnimation(
        child: const VigaChangeAccount(),
      ),
    ),
    GoRoute(
      path: '/country',
      pageBuilder: (c, s) => buildPageWithoutAnimation(
        child: const VigaSelectCountryPage(),
      ),
    ),

    // --- 独立页面 (Standalone Pages) ---
    GoRoute(
      path: '/web_browser',
      pageBuilder: (context, state) {
        final args = state.extra as Map<String, String>? ?? {};
        return buildPageWithAnimation(
          child: VigaWebViewPage(
            url: args['url'] ?? 'https://www.baidu.com',
            title: args['title'] ?? '浏览器',
          ),
        );
      },
    ),
    GoRoute(
      path: '/webview',
      pageBuilder: (context, state) {
        final args = state.extra as Map<String, String>? ?? {};
        return buildPageWithAnimation(
          child: VigaWebViewPage(
            url: args['url'] ?? 'http://localhost:5173',
            title: args['title'] ?? '网页',
          ),
        );
      },
    ),
    GoRoute(
      path: '/video_player',
      pageBuilder: (c, s) => buildPageWithAnimation(
        child: const VigaVideoPage(),
      ),
    ),
    GoRoute(
      path: '/open_miniprogram',
      pageBuilder: (context, state) {
        final cid = state.uri.queryParameters['cid'] ?? "";
        logger.info("Navigating to miniprogram with cid: $cid");
        return buildPageWithAnimation(
          child: VigaMiniProgram(
            cid: cid,
          ),
        );
      },
    ),

    // --- 设置模块 (Settings Module) ---
    GoRoute(
      path: '/settings',
      pageBuilder: (c, s) => buildPageWithAnimation(
        child: const VigaSettingPage(),
      ),
      routes: [
        // 子路由的path是相对路径，go_router会自动拼接。例: /settings + account_and_secure -> /settings/account_and_secure
        GoRoute(
          path: 'change_email',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaChangeEmailPage(),
          ),
        ),
        GoRoute(
          path: 'verify_email_screen',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaVerifyEmailScreen(),
          ),
        ),
        GoRoute(
          path: 'account_and_secure',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaAccountAndSecurePage(),
          ),
        ),
        GoRoute(
          path: 'account_info',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaAccountInfoPage(),
          ),
        ),
        GoRoute(
          path: 'change_account',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaChangeAccountPage(),
          ),
        ),
        GoRoute(
          path: 'phone_number',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaPhoneNumberPage(),
          ),
        ),

        GoRoute(
          path: 'verify_phone',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaVerifyPhonePage(),
          ),
        ),
        GoRoute(
          path: 'input_verify_code',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaInputVerifyCodePage(),
          ),
        ),

        GoRoute(
          path: 'new_message_notification',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaNewMessageNotificationPage(),
          ),
        ),
        GoRoute(
          path: 'chat_setting',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaChatSettingPage(),
          ),
        ),
        GoRoute(
          path: 'common_setting',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaCommonSettingPage(),
          ),
        ),
        GoRoute(
          path: 'set_password',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaSetPasswordPage(),
          ),
        ),
        GoRoute(
          path: 'logged_devices',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaLoggedDevicesPage(),
          ),
        ),
        GoRoute(
          path: 'device_detail',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaDeviceDetailPage(),
          ),
        ),
        GoRoute(
          path: 'emergency_contact',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaEmergencyContactPage(),
          ),
        ),
        GoRoute(
          path: 'personinfo_and_permission',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaPersonalinfoAndPermissionPage(),
          ),
        ),
        GoRoute(
          path: 'personalinfo_collection_checklist',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaPersonalInfoCollectionChecklistPage(),
          ),
        ),
        GoRoute(
          path: 'about',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaAboutPage(),
          ),
        ),
        GoRoute(
          path: 'feature_introduction',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaFeatureIntroductionPage(),
          ),
        ),
        GoRoute(
          path: 'complain',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaComplainPage(),
          ),
        ),
        GoRoute(
          path: 'friend_permission',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaFriendPermissionPage(),
          ),
        ),
        GoRoute(
          path: 'language_setting',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaLanguageSettingPage(),
          ),
        ),
        GoRoute(
          path: 'theme_setting',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaThemeSettingPage(),
          ),
        ),
      ],
    ),

    // --- 通讯录模块 (Contact Module) ---
    GoRoute(
      path: '/contact',
      pageBuilder: (c, s) => buildPageWithAnimation(
        child: const VigaContactPage(),
      ),
      routes: [
        GoRoute(
          path: 'phone_contact',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaPhoneContactPage(),
          ),
        ),
        GoRoute(
          path: 'tags',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaContactTagsPage(),
          ),
        ),
        GoRoute(
          path: 'tag_group',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaContactTagGroupPage(),
          ),
        ),
        GoRoute(
          path: 'official_accounts',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaOfficialAccountsPage(),
          ),
        ),
        GoRoute(
          path: 'group',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaContactGroupPage(),
          ),
        ),
        GoRoute(
          path: 'friends_who_only_chat',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaFriendsWhoOnlyChatPage(),
          ),
        ),
        GoRoute(
          path: 'new_friends',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaNewFriendsPage(),
          ),
        ),
        GoRoute(
          path: 'search_friend',
          pageBuilder: (context, state) {
            final recentContacts = state.extra as List<ChatListItem>?;
            return buildPageWithAnimation(
              child: VigaSearchFriendPage(
                recentContacts: recentContacts,
              ),
            );
          },
        ),
        GoRoute(
          path: 'add_friends',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaAddFriendsPage(),
          ),
        ),
      ],
    ),

    // --- 聊天模块 (Chat Module) ---
    GoRoute(
      path: '/chat',
      pageBuilder: (context, state) {
        final args = state.extra as Map<String, String>;
        return buildPageWithAnimation(
          child: VigaChat(
            title: args['title']!,
            icon: args['icon']!,
            fromTabIndex: args['fromTabIndex'],
          ),
        );
      },
      routes: [
        GoRoute(
          path: 'friend_profile',
          pageBuilder: (context, state) {
            final args = state.extra as Map<String, String>? ?? {};
            return buildPageWithAnimation(
              child: VigaFriendProfilePage(
                name: args['name'] ?? "",
                nickname: args['nickname'] ?? "",
                account: args['account'] ?? "",
                avatar: args['avatar'] ?? "",
              ),
            );
          },
        ),
        GoRoute(
          path: 'friend_moments',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaFriendmomentsPage(),
          ),
        ),
        GoRoute(
          path: 'friend_message_record',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaFriendMessageRecordPage(),
          ),
        ),
        GoRoute(
          path: 'friend_data_setting',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaFriendDataSettingPage(),
          ),
        ),
        GoRoute(
          path: 'friend_more_info',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaFriendMoreInfoPage(),
          ),
        ),
        GoRoute(
          path: 'group_message_record',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaGroupMessageRecordPage(),
          ),
        ),
        GoRoute(
          path: 'set_notes_and_labels',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaSetNotesAndLabelsPage(),
          ),
        ),
        GoRoute(
          path: 'friend_permissions',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaFriendPermissionsPage(),
          ),
        ),
        GoRoute(
          path: 'friend_information',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaFriendInformationPage(),
          ),
        ),
        GoRoute(
          path: 'set_friend_tags',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaSetFriendTagsPage(),
          ),
        ),
        GoRoute(
          path: 'friend_moments_cover_setting',
          pageBuilder: (c, s) => buildPageWithAnimation(
            child: const VigaFriendMomentsCoverSettingPage(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/group_chat',
      pageBuilder: (context, state) {
        final args = state.extra as Map<String, String>;
        return buildPageWithAnimation(
          child: VigaGroupChat(
            title: args['title']!,
            icon: args['icon']!,
            fromTabIndex: args['fromTabIndex'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/chat/dial',
      pageBuilder: (c, s) => buildPageWithoutAnimation(
        child: const VigaDialPage(),
      ),
    ),

    GoRoute(
      path: '/search',
      pageBuilder: (c, s) => buildPageWithoutAnimation(
        child: const VigaSearchPage(),
      ),
    ),

    GoRoute(
      path: '/user_content_search',
      pageBuilder: (c, s) => buildPageWithoutAnimation(
        child: const VigaUserContentSearchPage(),
      ),
    ),

    // --- 发现模块 (Discovery Module) ---
    GoRoute(
        path: '/discovery',
        pageBuilder: (c, s) => buildPageWithAnimation(
              child: const VigaDiscoveryPage(),
            ),
        routes: [
          GoRoute(
              path: 'ins',
              pageBuilder: (context, state) {
                return buildPageWithAnimation(
                  child: VigaInsPage(),
                );
              },
              routes: [
                GoRoute(
                  path: 'post_detail_page',
                  pageBuilder: (context, state) {
                    final args = state.extra as PostDetailData?;
                    return buildPageWithAnimation(
                      child: VigaPostDetailPage(
                        postData: args ?? _createDefaultPostData(),
                      ),
                    );
                  },
                ),
              ]),
          GoRoute(
            path: 'miniprogram_list',
            pageBuilder: (c, s) => buildPageWithAnimation(
              child: const VigaMiniProgramListPage(),
            ),
          ),
          GoRoute(
            path: 'publisher',
            pageBuilder: (c, s) => buildPageWithAnimation(
              child: const VigaPublisherPage(),
            ),
          ),
          GoRoute(
            path: 'qrcode_scanner',
            pageBuilder: (c, s) => buildPageWithoutAnimation(
              child: const VigaQRCodeScanner(),
            ),
          ),
        ]),

    // --- 用户模块 (User Module) ---
    GoRoute(
        path: '/user',
        pageBuilder: (c, s) => buildPageWithAnimation(
              child: const UserCardPage(),
            ),
        routes: [
          GoRoute(
            path: 'user_card',
            pageBuilder: (c, s) => buildPageWithAnimation(
              child: const UserCardPage(),
            ),
          ),
          GoRoute(
            path: 'like',
            pageBuilder: (c, s) => buildPageWithAnimation(
              child: const LikedVideosPage(),
            ),
          ),
          GoRoute(
            path: 'follow_and_fans',
            pageBuilder: (c, s) => buildPageWithAnimation(
              child: const VigaFollowPage(),
            ),
          ),
          GoRoute(
            path: 'info',
            pageBuilder: (c, s) => buildPageWithAnimation(
              child: const VigaUserinfoPage(),
            ),
          ),
          GoRoute(
            path: 'pocketmoney',
            pageBuilder: (c, s) => buildPageWithAnimation(
              child: const VigaPocketMoneyPage(),
            ),
          ),
          GoRoute(
            path: 'services',
            pageBuilder: (c, s) => buildPageWithAnimation(
              child: const VigaServicesPage(),
            ),
          ),
          GoRoute(
            path: 'services_manager',
            pageBuilder: (c, s) => buildPageWithAnimation(
              child: const VigaServicesManagerPage(),
            ),
          ),
          GoRoute(
            path: 'camera',
            pageBuilder: (c, s) => buildPageWithAnimation(
              child: const VigaCameraViewPage(),
            ),
          ),
          GoRoute(
            path: 'collection_and_payment',
            pageBuilder: (c, s) => buildPageWithoutAnimation(
              child: const VigaCollectionAndPaymentPage(),
            ),
          ),
          GoRoute(
              path: 'auth',
              redirect: (context, state) => '/user/auth/login',
              builder: (context, state) => const SizedBox.shrink(),
              routes: [
                GoRoute(
                  path: 'login',
                  pageBuilder: (c, s) => buildPageWithAnimation(
                    child: const VigaSignInPage(),
                  ),
                ),
                GoRoute(
                  path: 'register',
                  pageBuilder: (c, s) => buildPageWithAnimation(
                    child: const VigaSignUpPage(),
                  ),
                ),
                GoRoute(
                  path: 'forgot_password',
                  pageBuilder: (c, s) => buildPageWithAnimation(
                    child: const VigaForgotPasswordPage(),
                  ),
                ),
                GoRoute(
                  path: 'switch_account',
                  pageBuilder: (c, s) => buildPageWithAnimation(
                    child: const VigaSwitchAccountPage(),
                  ),
                ),
              ]),
          GoRoute(
              path: 'wallet',
              pageBuilder: (c, s) => buildPageWithAnimation(
                    child: const VigaWalletPage(),
                  ),
              routes: [
                GoRoute(
                  path: 'change_details',
                  pageBuilder: (c, s) => buildPageWithAnimation(
                    child: const VigaChangeDetailsPage(),
                  ),
                ),
                GoRoute(
                  path: 'bill_details',
                  pageBuilder: (c, s) => buildPageWithAnimation(
                    child: const VigaBillDetailsPage(),
                  ),
                ),
              ]),
        ]),

    // --- 其他顶层模块 (Other Top-Level Modules) ---
    GoRoute(
      path: '/photo_grid',
      pageBuilder: (context, state) {
        return buildPageWithAnimation(
          child: VigaPhotoGridPage(),
        );
      },
    ),

    GoRoute(
      path: '/author/detail', // 保持原始路径，通过 extra 传递 ID
      pageBuilder: (context, state) {
        final args = state.extra as Map<String, String>? ?? {};
        return buildPageWithAnimation(
          child: VigaAuthorDetailPage(
            authorId: args['author_id'] ?? "",
            authorName: args['author_name'] ?? "",
            authorAvatar: args['author_avatar'] ?? "",
          ),
        );
      },
    ),

    // 支付相关
    GoRoute(
      path: '/payment_alipay_success',
      pageBuilder: (c, s) => buildPageWithAnimation(
        child: const VigaAliPaySuccessPage(),
      ),
    ),
    GoRoute(
      path: '/payment_merchant_success',
      pageBuilder: (c, s) => buildPageWithAnimation(
        child: const VigaMerchantSuccessPage(),
      ),
    ),
    GoRoute(
      path: '/payment_demo',
      pageBuilder: (c, s) => buildPageWithAnimation(
        child: const VigaPaymentDemoPage(),
      ),
    ),
  ],
);

// --- 页面过渡动画 ---
CustomTransitionPage buildPageWithAnimation<T>({required Widget child}) {
  return CustomTransitionPage<T>(
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(
          curve: curve,
        ),
      );
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

CustomTransitionPage buildPageWithoutAnimation<T>({required Widget child}) {
  return CustomTransitionPage<T>(
    child: child,
    transitionDuration: Duration.zero,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        child,
  );
}

// --- 创建默认数据 ---
PostDetailData _createDefaultPostData() {
  return PostDetailData(
    id: 'default_post',
    username: '默认用户',
    avatarUrl: 'https://picsum.photos/seed/default/100/100',
    imageUrls: [
      'https://picsum.photos/seed/default1/600/800',
      'https://picsum.photos/seed/default2/600/800'
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
