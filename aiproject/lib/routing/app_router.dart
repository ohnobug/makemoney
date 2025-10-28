import 'package:flutter/material.dart';
import 'package:vigaviga/features/payment/screens/ljn_merchant_success_page.dart';
import 'package:vigaviga/ljn_test_page.dart';
import 'package:vigaviga/screens/contract/chat/ljn_chat_page.dart';
import 'package:vigaviga/screens/contract/ljn_contact_page.dart';
import 'package:vigaviga/screens/contract/ljn_contact_group_page.dart';
import 'package:vigaviga/screens/contract/ljn_contact_tag_group_page.dart';
import 'package:vigaviga/screens/contract/ljn_contact_tags_page.dart';
import 'package:vigaviga/screens/contract/ljn_friends_who_only_chat_page.dart';
import 'package:vigaviga/screens/contract/ljn_new_friends_page.dart';
import 'package:vigaviga/screens/contract/ljn_official_accounts_page.dart';
import 'package:vigaviga/screens/contract/ljn_search_friend_page.dart';
import 'package:vigaviga/screens/discovery/ljn_ins_page.dart';
import 'package:vigaviga/screens/discovery/ljn_miniprogram_page.dart';
import 'package:vigaviga/screens/discovery/ljn_miniprogram_list_page.dart';
import 'package:vigaviga/features/webview/ljn_webview_page.dart';
import 'package:vigaviga/screens/discovery/ljn_post_detail_page.dart';
import 'package:vigaviga/screens/discovery/ljn_qrcode_scanner_page.dart';
import 'package:vigaviga/screens/discovery/ljn_search_page.dart';
import 'package:vigaviga/screens/publisher/ljn_publisher_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_add_friends_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_friend_data_setting_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_friend_information_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_friend_message_record_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_friend_moments_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_friend_moments_cover_setting_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_friend_more_info_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_friend_permissions_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_set_friend_tags_page.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_set_notes_and_labels_page.dart';
import 'package:vigaviga/screens/contract/chat/group/ljn_group_chat_page.dart';
import 'package:vigaviga/screens/contract/chat/group/ljn_group_message_record_page.dart';
import 'package:vigaviga/screens/user/course/ljn_course_detail_page.dart';
import 'package:vigaviga/screens/user/course/ljn_course_list_page.dart';
import 'package:vigaviga/screens/user/course/ljn_lesson_content_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_about_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_feature_introduction_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_complain_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_account_and_secure_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_account_info_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_bind_new_phone_number_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_care_mode_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_change_account_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_chat_setting_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_common_setting_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_device_detail_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_emergency_contact_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_friend_permission_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_input_verify_code_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_language_setting_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_logged_devices_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_more_secure_setting_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_new_message_notification_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_personal_info_and_permission_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_personal_info_collection_checklist_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_phone_contact_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_phone_number_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_set_password_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_setting_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_sound_lock_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_theme_setting_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_youth_mode_page.dart';
import 'package:vigaviga/screens/user/settings/ljn_verify_phone_page.dart';
import 'package:vigaviga/screens/user/ljn_camera_view_page.dart';
import 'package:vigaviga/screens/user/wallet/ljn_collection_and_payment_page.dart';
import 'package:vigaviga/screens/user/wallet/ljn_pocketmoney_page.dart';
import 'package:vigaviga/screens/user/services/ljn_services_page.dart';
import 'package:vigaviga/screens/user/services/ljn_services_manager_page.dart';
import 'package:vigaviga/screens/user/ljn_user_more_info_page.dart';
import 'package:vigaviga/screens/user/ljn_userinfo_page.dart';
import 'package:vigaviga/screens/arts/ljn_author_detail_page.dart';
import 'package:vigaviga/screens/user/wallet/ljn_wallet_page.dart';
import 'package:vigaviga/screens/user/wallet/ljn_bill_details_page.dart';
import 'package:vigaviga/screens/user/wallet/ljn_change_details_page.dart';
import 'package:vigaviga/screens/user/follow/ljn_follow_page.dart';
import 'package:vigaviga/screens/user/like/ljn_like_page.dart';
import 'package:vigaviga/screens/user/auth/ljn_switch_account_page.dart';
import 'package:vigaviga/screens/user/auth/ljn_login_page.dart';
import 'package:vigaviga/screens/user/auth/ljn_register_page.dart';
import 'package:vigaviga/screens/user/auth/ljn_forgot_password_page.dart';
import 'package:vigaviga/screens/user/photo_viewer/ljn_photo_grid_page.dart';
import 'package:vigaviga/screens/contract/chat/ljn_dial_page.dart';
import 'package:vigaviga/screens/contract/chat/ljn_friend_profile_page.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/videoplayer.dart';
import 'package:vigaviga/widgets/ljn_custom_tabbar.dart';
import 'package:vigaviga/screens/publisher/ljn_publish_work_page.dart';
import 'package:vigaviga/screens/publisher/geolocator_page.dart';
import 'package:vigaviga/screens/publisher/ai_publisher_page.dart';
import 'package:vigaviga/screens/publisher/ljn_resource_publisher_page.dart';
import 'package:vigaviga/features/payment/screens/ljn_alipay_success_page.dart';
import 'package:vigaviga/features/payment/screens/ljn_payment_demo_page.dart';
import 'package:vigaviga/screens/user/settings/account_and_security/ljn_verification_page.dart';
import 'package:vigaviga/screens/user/settings/account_and_security/ljn_change_account.dart';
import 'package:vigaviga/screens/user/settings/account_and_security/ljn_change_phone.dart';
import 'package:vigaviga/screens/user/settings/account_and_security/ljn_country.dart';
import 'package:vigaviga/screens/user/ljn_user_info_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // 特殊处理带参数的动态路由
    if (settings.name != null &&
        settings.name!.startsWith('/open_miniprogram')) {
      final uri = Uri.parse(settings.name!);
      final cid = uri.queryParameters['cid'] ?? "";

      logger.info("bbbbbbbbbbbb: $cid");

      return pageRouteBuilderAnimation(LJNMiniProgram(cid: cid));
    }

    switch (settings.name) {
      // 主页面和通用路由
      case '/':
        return pageRouteBuilderNotAnimation(
            const LJNCustomTabbar()); // 主页面 - 底部导航栏
      case '/publish_work':
        return pageRouteBuilderNotAnimation(
            const LJNVideoPublishPageState()); // 发布作品页面
      case '/locationPage':
        return pageRouteBuilderNotAnimation(const AddLocationPage()); // 添加位置页面
      case '/ai_publisher':
        return pageRouteBuilderNotAnimation(
            const LoRASettingsPage()); // AI发布设置页面
      case '/resource_publisher':
        return pageRouteBuilderNotAnimation(
            const LJNResourceSearchPage()); // 资源发布搜索页面
      case '/verification':
        return pageRouteBuilderNotAnimation(
            const VerificationPage());
      case '/change_phone':
        return pageRouteBuilderNotAnimation(
            const ChangePhoneNumberScreen());
      case '/change_account':
        return pageRouteBuilderNotAnimation(
            const ChangeAccount());
      case '/country':
        return pageRouteBuilderNotAnimation(
            const SelectCountryPage());
      case '/user/user_info':
        return pageRouteBuilderNotAnimation(
            const UserInfoPage());
      case '/discovery/qrcode_scanner':
        return pageRouteBuilderNotAnimation(
            const LJNQRCodeScanner()); // 二维码扫描页面
      case '/video_player':
        return pageRouteBuilderAnimation(const LJNVideoPage()); // 视频播放页面
      // 设置相关路由
      case '/settings':
        return pageRouteBuilderAnimation(const LJNSettingPage()); // 设置主页面
      case '/settings/account_and_secure':
        return pageRouteBuilderAnimation(
            const LJNAccountAndSecurePage()); // 账号与安全页面
      case '/settings/account_info':
        return pageRouteBuilderAnimation(const LJNAccountInfoPage()); // 账号信息页面
      case '/settings/change_account':
        return pageRouteBuilderAnimation(
            const LJNChangeAccountPage()); // 切换账号验证页面
      case '/user/auth/switch_account':
        return pageRouteBuilderAnimation(
            const LJNSwitchAccountPage()); // 切换账号列表页面
      case '/settings/phone_number':
        return pageRouteBuilderAnimation(const LJNPhoneNumberPage()); // 手机号码页面
      case '/settings/phone_contact':
        return pageRouteBuilderAnimation(
            const LJNPhoneContactPage()); // 手机联系人页面
      case '/settings/verify_phone':
        return pageRouteBuilderAnimation(const LJNVerifyPhonePage()); // 验证手机页面
      case '/settings/security/bind_phone':
        return pageRouteBuilderAnimation(
            const LJNBindNewPhoneNumberPage()); // 绑定新手机号码页面
      case '/settings/input_verify_code':
        return pageRouteBuilderAnimation(
            const LJNInputVerifyCodePage()); // 输入验证码页面
      case '/settings/teenage_mode':
        return pageRouteBuilderAnimation(const LJNYouthModePage()); // 青少年模式页面
      case '/settings/care_mode':
        return pageRouteBuilderAnimation(const LJNCareModePage()); // 关怀模式页面
      case '/settings/new_message_notification':
        return pageRouteBuilderAnimation(
            const LJNNewMessageNotificationPage()); // 新消息通知页面
      case '/settings/chat_setting':
        return pageRouteBuilderAnimation(const LJNChatSettingPage()); // 聊天设置页面
      case '/settings/common_setting':
        return pageRouteBuilderAnimation(
            const LJNCommonSettingPage()); // 通用设置页面
      case '/settings/set_password':
        return pageRouteBuilderAnimation(const LJNSetPasswordPage()); // 设置密码页面
      case '/settings/logged_devices':
        return pageRouteBuilderAnimation(
            const LJNLoggedDevicesPage()); // 已登录设备页面
      case '/settings/device_detail':
        return pageRouteBuilderAnimation(const LJNDeviceDetailPage()); // 设备详情页面
      case '/settings/emergency_contact':
        return pageRouteBuilderAnimation(
            const LJNEmergencyContactPage()); // 紧急联系人页面
      case '/settings/more_secure_setting':
        return pageRouteBuilderAnimation(
            const LJNMoreSecureSettingPage()); // 更多安全设置页面
      case '/settings/sound_lock':
        return pageRouteBuilderAnimation(const LJNSoundLockPage()); // 声音锁页面
      case '/settings/personinfo_and_permission':
        return pageRouteBuilderAnimation(
            const LJNPersonalinfoAndPermissionPage()); // 个人信息与权限页面
      case '/settings/personalinfo_collection_checklist':
        return pageRouteBuilderAnimation(
            const LJNPersonalInfoCollectionChecklistPage()); // 个人信息收集清单页面
      case '/settings/about':
        return pageRouteBuilderAnimation(const LJNAboutPage()); // 关于页面
      case '/settings/feature_introduction':
        return pageRouteBuilderAnimation(
            const LJNFeatureIntroductionPage()); // 功能介绍页面
      case '/settings/complain':
        return pageRouteBuilderAnimation(const LJNComplainPage()); // 投诉反馈页面
      case '/settings/friend_permission':
        return pageRouteBuilderAnimation(
            const LJNFriendPermissionPage()); // 朋友权限页面
      case '/settings/language_setting':
        return pageRouteBuilderAnimation(
            const LJNLanguageSettingPage()); // 语言设置页面
      case '/settings/theme_setting':
        return pageRouteBuilderAnimation(const LJNThemeSettingPage()); // 主题设置页面

      // 通讯录相关路由
      case '/contact':
        return pageRouteBuilderAnimation(const LJNContactPage()); // 通讯录主页面
      case '/contact/tags':
        return pageRouteBuilderAnimation(const LJNContactTagsPage()); // 标签管理页面
      case '/contact/tag_group':
        return pageRouteBuilderAnimation(
            const LJNContactTagGroupPage()); // 标签分组页面
      case '/contact/official_accounts':
        return pageRouteBuilderAnimation(
            const LJNOfficialAccountsPage()); // 公众号页面
      case '/contact/group':
        return pageRouteBuilderAnimation(const LJNContactGroupPage()); // 群组页面
      case '/contact/friends_who_only_chat':
        return pageRouteBuilderAnimation(
            const LJNFriendsWhoOnlyChatPage()); // 仅聊天朋友页面
      case '/contact/new_friends':
        return pageRouteBuilderAnimation(const LJNNewFriendsPage()); // 新朋友页面
      case '/contact/search_friend':
        return pageRouteBuilderAnimation(const LJNSearchFriendPage()); // 搜索朋友页面
      case '/contact/add_friends':
        return pageRouteBuilderAnimation(const LJNAddFriendsPage()); // 添加朋友页面

      // 聊天相关路由
      case '/chat':
        final args = settings.arguments as Map<String, String>;
        return pageRouteBuilderAnimation(
            LJNChat(title: args['title']!, icon: args['icon']!)); // 聊天页面
      case '/group_chat':
        final args = settings.arguments as Map<String, String>;
        return pageRouteBuilderAnimation(
            LJNGroupChat(title: args['title']!, icon: args['icon']!)); // 群聊页面
      case '/chat/friend_profile':
        final args = settings.arguments as Map<String, String>? ?? {};
        return pageRouteBuilderAnimation(LJNFriendProfilePage(
          name: args['name'] ?? "",
          nickname: args['nickname'] ?? "",
          account: args['account'] ?? "",
          avatar: args['avatar'] ?? "",
        )); // 朋友资料页面
      case '/chat/friend_moments':
        return pageRouteBuilderAnimation(
            const LJNFriendmomentsPage()); // 朋友动态页面
      case '/chat/friend_message_record':
        return pageRouteBuilderAnimation(
            const LJNFriendMessageRecordPage()); // 朋友消息记录页面
      case '/chat/friend_data_setting':
        return pageRouteBuilderAnimation(
            const LJNFriendDataSettingPage()); // 朋友资料设置页面
      case '/chat/friend_more_info':
        return pageRouteBuilderAnimation(
            const LJNFriendMoreInfoPage()); // 朋友更多信息页面
      case '/chat/group_message_record':
        return pageRouteBuilderAnimation(
            const LJNGroupMessageRecordPage()); // 群消息记录页面
      case '/chat/dial':
        return pageRouteBuilderNotAnimation(const LJNDialPage()); // 拨号页面
      case '/chat/set_notes_and_labels':
        return pageRouteBuilderAnimation(
            const LJNSetNotesAndLabelsPage()); // 设置备注和标签页面
      case '/chat/friend_permissions':
        return pageRouteBuilderAnimation(
            const LJNFriendPermissionsPage()); // 朋友权限设置页面
      case '/chat/friend_information':
        return pageRouteBuilderAnimation(
            const LJNFriendInformationPage()); // 朋友信息页面
      case '/chat/set_friend_tags':
        return pageRouteBuilderAnimation(
            const LJNSetFriendTagsPage()); // 设置朋友标签页面
      case '/chat/friend_moments_cover_setting':
        return pageRouteBuilderAnimation(
            const LJNFriendMomentsCoverSettingPage()); // 朋友动态封面设置页面

      // 发现相关路由
      case '/discovery/search':
        return pageRouteBuilderNotAnimation(const LJNSearchPage()); // 发现搜索页面
      case '/discovery/ins':
        return pageRouteBuilderAnimation(const LJNInsPage()); // 朋友圈页面
      case '/discovery/miniprogram_list':
        return pageRouteBuilderAnimation(
            const LJNMiniProgramListPage()); // 小程序列表页面
      case '/web_browser':
        final args = settings.arguments as Map<String, String>? ?? {};
        return pageRouteBuilderAnimation(LJNWebViewPage(
          url: args['url'] ?? 'https://www.baidu.com',
          title: args['title'] ?? '浏览器',
        )); // 通用网页浏览器页面
      case '/webview':
        final args = settings.arguments as Map<String, String>? ?? {};
        return pageRouteBuilderAnimation(LJNWebViewPage(
          url: args['url'] ?? 'http://localhost:5173',
          title: args['title'] ?? '网页',
        )); // 通用WebView页面
      case '/discovery/publisher':
        return pageRouteBuilderAnimation(const LJNPublisherPage()); // 发布页面
      case '/discovery/ins/post_detail_page':
        final args = settings.arguments as PostDetailData?;
        return pageRouteBuilderAnimation(LJNPostDetailPage(
            postData: args ?? _createDefaultPostData())); // 帖子详情页面

      // 用户相关路由
      case '/user/like':
        return pageRouteBuilderNotAnimation(const LikedVideosPage()); // 用户喜欢页面
      case '/user/follow_and_fans':
        return pageRouteBuilderAnimation(const LJNFollowPage()); // 用户关注和粉丝页面
      case '/user/wallet':
        return pageRouteBuilderAnimation(const LJNWalletPage()); // 用户钱包页面
      case '/user/info':
        return pageRouteBuilderAnimation(const LJNUserinfoPage()); // 用户信息页面
      case '/user/photo_viewer':
        return pageRouteBuilderAnimation(const LJNPhotoGridPage()); // 图片查看器测试页面
      case '/user/pocketmoney':
        return pageRouteBuilderAnimation(const LJNPocketMoneyPage()); // 零钱页面
      case '/user/services':
        return pageRouteBuilderAnimation(const LJNServicesPage()); // 用户服务页面
      case '/user/services_manager':
        return pageRouteBuilderAnimation(
            const LJNServicesManagerPage()); // 服务管理页面
      case '/user/camera':
        return pageRouteBuilderAnimation(const LJNCameraViewPage()); // 相机页面
      case '/user/collection_and_payment':
        return pageRouteBuilderNotAnimation(
          const LJNCollectionAndPaymentPage(),
        ); // 收藏和支付页面
      case '/user/more_info':
        return pageRouteBuilderAnimation(
            const LJNUserMoreInfoPage()); // 用户更多信息页面
      case '/user/course_list':
        return pageRouteBuilderAnimation(const LJNCourseListPage()); // 课程列表页面
      case '/user/course_detail':
        final args = settings.arguments as Map<String, String>? ?? {};
        return pageRouteBuilderAnimation(LJNCourseDetailPage(
          courseId: args['course_id'] ?? "",
        )); // 课程详情页面
      case '/user/lesson_content':
        final args = settings.arguments as Map<String, String>? ?? {};
        return pageRouteBuilderAnimation(LJNLessonContentPage(
          lessonId: args['lesson_id'] ?? "",
        )); // 课程内容页面

      // 作者详情页面
      case '/author/detail':
        final args = settings.arguments as Map<String, String>? ?? {};
        return pageRouteBuilderAnimation(LJNAuthorDetailPage(
          authorId: args['author_id'] ?? "",
          authorName: args['author_name'] ?? "",
          authorAvatar: args['author_avatar'] ?? "",
        )); // 作者详情页面

      // 用户认证相关路由
      case '/user/auth/login':
        return pageRouteBuilderNotAnimation(const LJNLoginPage()); // 用户登录页面
      case '/user/auth/register':
        return pageRouteBuilderAnimation(const LJNRegisterPage()); // 用户注册页面
      case '/user/auth/forgot_password':
        return pageRouteBuilderAnimation(
            const LJNForgotPasswordPage()); // 忘记密码页面
      case '/user/wallet/change_details':
        return pageRouteBuilderAnimation(
            const LJNChangeDetailsPage()); // 零钱明细页面
      case '/user/wallet/bill_details':
        return pageRouteBuilderAnimation(const LJNBillDetailsPage()); // 账单详情页面

      // 支付模块相关路由
      case '/payment_alipay_success':
        return pageRouteBuilderAnimation(const LJNAliPaySuccessPage());
      case '/payment_merchant_success':
        return pageRouteBuilderAnimation(const LJNMerchantSuccessPage());
      case '/payment_demo':
        return pageRouteBuilderAnimation(const LJNPaymentDemoPage());

      case '/test':
        return pageRouteBuilderAnimation(const LJNTestPage());

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
