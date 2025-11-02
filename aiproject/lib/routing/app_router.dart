import 'package:flutter/material.dart';
import 'package:vigaviga/features/payment/screens/viga_merchant_success_page.dart';
import 'package:vigaviga/viga_test_page.dart';
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


class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // 特殊处理带参数的动态路由
    if (settings.name != null &&
        settings.name!.startsWith('/open_miniprogram')) {
      final uri = Uri.parse(settings.name!);
      final cid = uri.queryParameters['cid'] ?? "";

      logger.info("bbbbbbbbbbbb: $cid");

      return pageRouteBuilderAnimation(VigaMiniProgram(cid: cid));
    }

    switch (settings.name) {
      // 主页面和通用路由
      case '/':
        return pageRouteBuilderNotAnimation(
            const VigaCustomTabbar()); // 主页面 - 底部导航栏
      case '/publish_work':
        return pageRouteBuilderNotAnimation(
            const VigaVideoPublishPageState()); // 发布作品页面
      case '/locationPage':
        return pageRouteBuilderNotAnimation(
            const VigaGeolocatorPage()); // 添加位置页面
      case '/ai_publisher':
        return pageRouteBuilderNotAnimation(
            const VigaAiPublisherPage()); // AI发布设置页面
      case '/resource_publisher':
        return pageRouteBuilderNotAnimation(
            const VigaResourceSearchPage()); // 资源发布搜索页面
      case '/verification':
        return pageRouteBuilderNotAnimation(const VigaVerificationPage());
      case '/change_phone':
        return pageRouteBuilderNotAnimation(
            const VigaChangePhoneNumberScreen());
      case '/change_account':
        return pageRouteBuilderNotAnimation(const VigaChangeAccount());
      case '/country':
            return pageRouteBuilderNotAnimation(const VigaSelectCountryPage());
      case '/user/user_info':
        return pageRouteBuilderNotAnimation(
            const UserInfoPage());
      case '/discovery/qrcode_scanner':
        return pageRouteBuilderNotAnimation(
            const VigaQRCodeScanner()); // 二维码扫描页面
      case '/video_player':
        return pageRouteBuilderAnimation(const VigaVideoPage()); // 视频播放页面
      // 设置相关路由
      case '/settings':
        return pageRouteBuilderAnimation(const VigaSettingPage()); // 设置主页面
      case '/settings/change_email':
        return pageRouteBuilderAnimation(
            const VigaModifyEmailPage());
      case '/settings/verify_email_screen':
        return pageRouteBuilderAnimation(
            const VigaVerifyEmailScreen());
      case '/settings/account_and_secure':
        return pageRouteBuilderAnimation(
            const VigaAccountAndSecurePage()); // 账号与安全页面
      case '/settings/account_info':
        return pageRouteBuilderAnimation(const VigaAccountInfoPage()); // 账号信息页面
      case '/settings/change_account':
        return pageRouteBuilderAnimation(
            const VigaChangeAccountPage()); // 切换账号验证页面
      case '/user/auth/switch_account':
        return pageRouteBuilderAnimation(
            const VigaSwitchAccountPage()); // 切换账号列表页面
      case '/settings/phone_number':
        return pageRouteBuilderAnimation(const VigaPhoneNumberPage()); // 手机号码页面
      case '/settings/phone_contact':
        return pageRouteBuilderAnimation(
            const VigaPhoneContactPage()); // 手机联系人页面
      case '/settings/verify_phone':
        return pageRouteBuilderAnimation(const VigaVerifyPhonePage()); // 验证手机页面
      case '/settings/security/bind_phone':
        return pageRouteBuilderAnimation(
            const VigaBindNewPhoneNumberPage()); // 绑定新手机号码页面
      case '/settings/input_verify_code':
        return pageRouteBuilderAnimation(
            const VigaInputVerifyCodePage()); // 输入验证码页面
      case '/settings/teenage_mode':
        return pageRouteBuilderAnimation(const VigaYouthModePage()); // 青少年模式页面
      case '/settings/care_mode':
        return pageRouteBuilderAnimation(const VigaCareModePage()); // 关怀模式页面
      case '/settings/new_message_notification':
        return pageRouteBuilderAnimation(
            const VigaNewMessageNotificationPage()); // 新消息通知页面
      case '/settings/chat_setting':
        return pageRouteBuilderAnimation(const VigaChatSettingPage()); // 聊天设置页面
      case '/settings/common_setting':
        return pageRouteBuilderAnimation(
            const VigaCommonSettingPage()); // 通用设置页面
      case '/settings/set_password':
        return pageRouteBuilderAnimation(const VigaSetPasswordPage()); // 设置密码页面
      case '/settings/logged_devices':
        return pageRouteBuilderAnimation(
            const VigaLoggedDevicesPage()); // 已登录设备页面
      case '/settings/device_detail':
        return pageRouteBuilderAnimation(
            const VigaDeviceDetailPage()); // 设备详情页面
      case '/settings/emergency_contact':
        return pageRouteBuilderAnimation(
            const VigaEmergencyContactPage()); // 紧急联系人页面
      case '/settings/more_secure_setting':
        return pageRouteBuilderAnimation(
            const VigaMoreSecureSettingPage()); // 更多安全设置页面
      case '/settings/sound_lock':
        return pageRouteBuilderAnimation(const VigaSoundLockPage()); // 声音锁页面
      case '/settings/personinfo_and_permission':
        return pageRouteBuilderAnimation(
            const VigaPersonalinfoAndPermissionPage()); // 个人信息与权限页面
      case '/settings/personalinfo_collection_checklist':
        return pageRouteBuilderAnimation(
            const VigaPersonalInfoCollectionChecklistPage()); // 个人信息收集清单页面
      case '/settings/about':
        return pageRouteBuilderAnimation(const VigaAboutPage()); // 关于页面
      case '/settings/feature_introduction':
        return pageRouteBuilderAnimation(
            const VigaFeatureIntroductionPage()); // 功能介绍页面
      case '/settings/complain':
        return pageRouteBuilderAnimation(const VigaComplainPage()); // 投诉反馈页面
      case '/settings/friend_permission':
        return pageRouteBuilderAnimation(
            const VigaFriendPermissionPage()); // 朋友权限页面
      case '/settings/language_setting':
        return pageRouteBuilderAnimation(
            const VigaLanguageSettingPage()); // 语言设置页面
      case '/settings/theme_setting':
        return pageRouteBuilderAnimation(
            const VigaThemeSettingPage()); // 主题设置页面

      // 通讯录相关路由
      case '/contact':
        return pageRouteBuilderAnimation(const VigaContactPage()); // 通讯录主页面
      case '/contact/tags':
        return pageRouteBuilderAnimation(const VigaContactTagsPage()); // 标签管理页面
      case '/contact/tag_group':
        return pageRouteBuilderAnimation(
            const VigaContactTagGroupPage()); // 标签分组页面
      case '/contact/official_accounts':
        return pageRouteBuilderAnimation(
            const VigaOfficialAccountsPage()); // 公众号页面
      case '/contact/group':
        return pageRouteBuilderAnimation(const VigaContactGroupPage()); // 群组页面
      case '/contact/friends_who_only_chat':
        return pageRouteBuilderAnimation(
            const VigaFriendsWhoOnlyChatPage()); // 仅聊天朋友页面
      case '/contact/new_friends':
        return pageRouteBuilderAnimation(const VigaNewFriendsPage()); // 新朋友页面
      case '/contact/search_friend':
        return pageRouteBuilderAnimation(
            const VigaSearchFriendPage()); // 搜索朋友页面
      case '/contact/add_friends':
        return pageRouteBuilderAnimation(const VigaAddFriendsPage()); // 添加朋友页面

      // 聊天相关路由
      case '/chat':
        final args = settings.arguments as Map<String, String>;
        return pageRouteBuilderAnimation(
            VigaChat(
              title: args['title']!,
              icon: args['icon']!,
              fromTabIndex: args['fromTabIndex'],
            )); // 聊天页面
      case '/group_chat':
        final args = settings.arguments as Map<String, String>;
        return pageRouteBuilderAnimation(
            VigaGroupChat(
              title: args['title']!,
              icon: args['icon']!,
              fromTabIndex: args['fromTabIndex'],
            )); // 群聊页面
      case '/chat/friend_profile':
        final args = settings.arguments as Map<String, String>? ?? {};
        return pageRouteBuilderAnimation(VigaFriendProfilePage(
          name: args['name'] ?? "",
          nickname: args['nickname'] ?? "",
          account: args['account'] ?? "",
          avatar: args['avatar'] ?? "",
        )); // 朋友资料页面
      case '/chat/friend_moments':
        return pageRouteBuilderAnimation(
            const VigaFriendmomentsPage()); // 朋友动态页面
      case '/chat/friend_message_record':
        return pageRouteBuilderAnimation(
            const VigaFriendMessageRecordPage()); // 朋友消息记录页面
      case '/chat/friend_data_setting':
        return pageRouteBuilderAnimation(
            const VigaFriendDataSettingPage()); // 朋友资料设置页面
      case '/chat/friend_more_info':
        return pageRouteBuilderAnimation(
            const VigaFriendMoreInfoPage()); // 朋友更多信息页面
      case '/chat/group_message_record':
        return pageRouteBuilderAnimation(
            const VigaGroupMessageRecordPage()); // 群消息记录页面
      case '/chat/dial':
        return pageRouteBuilderNotAnimation(const VigaDialPage()); // 拨号页面
      case '/chat/set_notes_and_labels':
        return pageRouteBuilderAnimation(
            const VigaSetNotesAndLabelsPage()); // 设置备注和标签页面
      case '/chat/friend_permissions':
        return pageRouteBuilderAnimation(
            const VigaFriendPermissionsPage()); // 朋友权限设置页面
      case '/chat/friend_information':
        return pageRouteBuilderAnimation(
            const VigaFriendInformationPage()); // 朋友信息页面
      case '/chat/set_friend_tags':
        return pageRouteBuilderAnimation(
            const VigaSetFriendTagsPage()); // 设置朋友标签页面
      case '/chat/friend_moments_cover_setting':
        return pageRouteBuilderAnimation(
            const VigaFriendMomentsCoverSettingPage()); // 朋友动态封面设置页面

      // 发现相关路由
      case '/discovery/search':
        return pageRouteBuilderNotAnimation(const VigaSearchPage()); // 发现搜索页面
      case '/discovery/ins':
        return pageRouteBuilderAnimation(const VigaInsPage()); // 朋友圈页面
      case '/discovery/miniprogram_list':
        return pageRouteBuilderAnimation(
            const VigaMiniProgramListPage()); // 小程序列表页面
      case '/web_browser':
        final args = settings.arguments as Map<String, String>? ?? {};
        return pageRouteBuilderAnimation(VigaWebViewPage(
          url: args['url'] ?? 'https://www.baidu.com',
          title: args['title'] ?? '浏览器',
        )); // 通用网页浏览器页面
      case '/webview':
        final args = settings.arguments as Map<String, String>? ?? {};
        return pageRouteBuilderAnimation(VigaWebViewPage(
          url: args['url'] ?? 'http://localhost:5173',
          title: args['title'] ?? '网页',
        )); // 通用WebView页面
      case '/discovery/publisher':
        return pageRouteBuilderAnimation(const VigaPublisherPage()); // 发布页面
      case '/discovery/ins/post_detail_page':
        final args = settings.arguments as PostDetailData?;
        return pageRouteBuilderAnimation(VigaPostDetailPage(
            postData: args ?? _createDefaultPostData())); // 帖子详情页面

      // 用户相关路由
      case '/user/like':
        return pageRouteBuilderNotAnimation(const LikedVideosPage()); // 用户喜欢页面
      case '/user/follow_and_fans':
        return pageRouteBuilderAnimation(const VigaFollowPage()); // 用户关注和粉丝页面
      case '/user/wallet':
        return pageRouteBuilderAnimation(const VigaWalletPage()); // 用户钱包页面
      case '/user/info':
        return pageRouteBuilderAnimation(const VigaUserinfoPage()); // 用户信息页面
      case '/user/photo_viewer':
        return pageRouteBuilderAnimation(
            const VigaPhotoGridPage()); // 图片查看器测试页面
      case '/user/pocketmoney':
        return pageRouteBuilderAnimation(const VigaPocketMoneyPage()); // 零钱页面
      case '/user/services':
        return pageRouteBuilderAnimation(const VigaServicesPage()); // 用户服务页面
      case '/user/services_manager':
        return pageRouteBuilderAnimation(
            const VigaServicesManagerPage()); // 服务管理页面
      case '/user/camera':
        return pageRouteBuilderAnimation(const VigaCameraViewPage()); // 相机页面
      case '/user/collection_and_payment':
        return pageRouteBuilderNotAnimation(
          const VigaCollectionAndPaymentPage(),
        ); // 收藏和支付页面
      case '/user/more_info':
        return pageRouteBuilderAnimation(
            const VigaUserMoreInfoPage()); // 用户更多信息页面
  
      // 作者详情页面
      case '/author/detail':
        final args = settings.arguments as Map<String, String>? ?? {};
        return pageRouteBuilderAnimation(VigaAuthorDetailPage(
          authorId: args['author_id'] ?? "",
          authorName: args['author_name'] ?? "",
          authorAvatar: args['author_avatar'] ?? "",
        )); // 作者详情页面

      // 用户认证相关路由
      case '/user/auth/login':
        return pageRouteBuilderAnimation(const VigaSignInPage()); // 用户登录页面
      case '/user/auth/register':
        return pageRouteBuilderAnimation(const VigaSignUpPage()); // 用户注册页面
      case '/user/auth/forgot_password':
        return pageRouteBuilderAnimation(
            const VigaForgotPasswordPage()); // 忘记密码页面
      case '/user/wallet/change_details':
        return pageRouteBuilderAnimation(
            const VigaChangeDetailsPage()); // 零钱明细页面
      case '/user/wallet/bill_details':
        return pageRouteBuilderAnimation(const VigaBillDetailsPage()); // 账单详情页面

      // 支付模块相关路由
      case '/payment_alipay_success':
        return pageRouteBuilderAnimation(const VigaAliPaySuccessPage());
      case '/payment_merchant_success':
        return pageRouteBuilderAnimation(const VigaMerchantSuccessPage());
      case '/payment_demo':
        return pageRouteBuilderAnimation(const VigaPaymentDemoPage());

      case '/test':
        return pageRouteBuilderAnimation(const VigaTestPage());

      default:
        // 可以返回一个统一的404页面
        return pageRouteBuilderAnimation(
          Scaffold(
            body: Center(
              child: Text('页面未找到: ${settings.name}'),
            ),
          ),
        );
    }
  }

  // 创建默认的帖子详情数据
  static PostDetailData _createDefaultPostData() {
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
}

// 带动效进入页面
PageRouteBuilder pageRouteBuilderAnimation(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
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
    transitionDuration: const Duration(milliseconds: 300),
  );
}

// 不带动效进入页面
PageRouteBuilder pageRouteBuilderNotAnimation(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        child,
  );
}

// --- 第一步：將無動畫路由類複製到這裡 ---
class NoAnimationPageRoute<T> extends PageRouteBuilder<T> {
  final Widget Function(BuildContext) builder;
  @override
  final RouteSettings settings;

  NoAnimationPageRoute({
    required this.builder,
    RouteSettings? settings,
  })  : settings = settings ?? const RouteSettings(),
        super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );
}
