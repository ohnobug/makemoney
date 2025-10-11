import 'package:flutter/material.dart';
import 'package:vigaviga/screens/user/course/ljn_course_detail.dart';
import 'package:vigaviga/screens/user/course/ljn_course_list.dart';
import 'package:vigaviga/screens/user/course/ljn_lesson_content.dart';
import 'package:vigaviga/test.dart';
import 'package:vigaviga/screens/contract/chat/ljn_chat.dart';
import 'package:vigaviga/screens/contract/ljn_contact.dart';
import 'package:vigaviga/screens/contract/ljn_contact_group.dart';
import 'package:vigaviga/screens/contract/ljn_contact_tag_group.dart';
import 'package:vigaviga/screens/contract/ljn_contact_tags.dart';
import 'package:vigaviga/screens/contract/ljn_friends_who_only_chat.dart';
import 'package:vigaviga/screens/contract/ljn_new_friends.dart';
import 'package:vigaviga/screens/contract/ljn_official_accounts.dart';
import 'package:vigaviga/screens/contract/ljn_search_friend.dart';
import 'package:vigaviga/screens/discovery/ljn_ins.dart';
import 'package:vigaviga/screens/discovery/ljn_miniprogram.dart';
import 'package:vigaviga/screens/discovery/ljn_miniprogram_list.dart';
import 'package:vigaviga/screens/discovery/ljn_qrcode_scanner.dart';
import 'package:vigaviga/screens/discovery/ljn_search.dart';
import 'package:vigaviga/screens/publisher/ljn_publisher.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_add_friends.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_friend_data_setting.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_friend_information.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_friend_message_record.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_friend_moments.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_friend_moments_cover_setting.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_friend_more_info.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_friend_permissions.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_set_friend_tags.dart';
import 'package:vigaviga/screens/contract/chat/friend/ljn_set_notes_and_labels.dart';
import 'package:vigaviga/screens/contract/chat/group/ljn_group_chat.dart';
import 'package:vigaviga/screens/contract/chat/group/ljn_group_message_record.dart';
import 'package:vigaviga/screens/user/settings/ljn_about.dart';
import 'package:vigaviga/screens/user/settings/ljn_account_and_secure.dart';
import 'package:vigaviga/screens/user/settings/ljn_account_info.dart';
import 'package:vigaviga/screens/user/settings/ljn_bind_new_phone_number.dart';
import 'package:vigaviga/screens/user/settings/ljn_care_mode.dart';
import 'package:vigaviga/screens/user/settings/ljn_change_account.dart';
import 'package:vigaviga/screens/user/settings/ljn_chat_setting.dart';
import 'package:vigaviga/screens/user/settings/ljn_common_setting.dart';
import 'package:vigaviga/screens/user/settings/ljn_device_detail.dart';
import 'package:vigaviga/screens/user/settings/ljn_emergency_contact.dart';
import 'package:vigaviga/screens/user/settings/ljn_forgot_password.dart';
import 'package:vigaviga/screens/user/settings/ljn_friend_permission.dart';
import 'package:vigaviga/screens/user/settings/ljn_input_verify_code.dart';
import 'package:vigaviga/screens/user/settings/ljn_language_setting.dart';
import 'package:vigaviga/screens/user/settings/ljn_logged_devices.dart';
import 'package:vigaviga/screens/user/settings/ljn_more_secure_setting.dart';
import 'package:vigaviga/screens/user/settings/ljn_new_message_notification.dart';
import 'package:vigaviga/screens/user/settings/ljn_personal_info_and_permission.dart';
import 'package:vigaviga/screens/user/settings/ljn_personal_info_collection_checklist.dart';
import 'package:vigaviga/screens/user/settings/ljn_phone_contact.dart';
import 'package:vigaviga/screens/user/settings/ljn_phone_number.dart';
import 'package:vigaviga/screens/user/settings/ljn_set_password.dart';
import 'package:vigaviga/screens/user/settings/ljn_setting.dart';
import 'package:vigaviga/screens/user/settings/ljn_sound_lock.dart';
import 'package:vigaviga/screens/user/settings/ljn_theme_setting.dart';
import 'package:vigaviga/screens/user/settings/ljn_youth_mode.dart';
import 'package:vigaviga/screens/user/settings/ljn_verify_phone.dart';
import 'package:vigaviga/screens/user/ljn_camera_view.dart';
import 'package:vigaviga/screens/user/wallet/ljn_collection_and_payment.dart';
import 'package:vigaviga/screens/contract/chat/ljn_dial.dart';
import 'package:vigaviga/screens/contract/chat/ljn_friend_profile.dart';
import 'package:vigaviga/screens/user/wallet/ljn_pocketmoney.dart';
import 'package:vigaviga/screens/user/services/ljn_services.dart';
import 'package:vigaviga/screens/user/services/ljn_services_manager.dart';
import 'package:vigaviga/screens/user/ljn_user_more_info.dart';
import 'package:vigaviga/screens/user/ljn_userinfo.dart';
import 'package:vigaviga/screens/user/wallet/ljn_wallet.dart';
import 'package:vigaviga/screens/user/wallet/ljn_bill_details.dart';
import 'package:vigaviga/screens/user/wallet/ljn_change_details.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/videoplayer.dart';
import 'package:vigaviga/widgets/ljn_custom_tabbar.dart';
import 'package:vigaviga/screens/publisher/publish_work.dart';
import 'package:vigaviga/screens/publisher/geolocator.dart';
import 'package:vigaviga/screens/publisher/ai_publisher.dart';
import 'package:vigaviga/screens/publisher/resource_publisher.dart';
import 'package:vigaviga/screens/user/follow/ljn_follow_page.dart';
import 'package:vigaviga/screens/user/like/ljn_like.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // 特殊处理带参数的动态路由
    if (settings.name != null &&
        settings.name!.startsWith('/open_miniprogram')) {
      final uri = Uri.parse(settings.name!);
      final linkValue = uri.queryParameters['link'] ?? "";

      logger.info("bbbbbbbbbbbb: $linkValue");

      return _pageRouteBuilderAnimation(LJNMiniProgram(link: linkValue));
    }

    switch (settings.name) {
      // 主页面和通用路由
      case '/':
        return _pageRouteBuilderNotAnimation(const LJNCustomTabbar()); // 主页面 - 底部导航栏
      case '/publish_work':
        return _pageRouteBuilderNotAnimation(const VideoPublishPageState()); // 发布作品页面
      case '/locationPage':
        return _pageRouteBuilderNotAnimation(const AddLocationPage()); // 添加位置页面
      case '/ai_publisher':
        return _pageRouteBuilderNotAnimation(const LoRASettingsPage()); // AI发布设置页面
      case '/resource_publisher':
        return _pageRouteBuilderNotAnimation(const ResourceSearchPage()); // 资源发布搜索页面
      case '/user/like':
        return _pageRouteBuilderNotAnimation(const LikedVideosPage()); // 用户喜欢页面
      case '/user/follow_and_fans':
        return _pageRouteBuilderAnimation(const LJNFollowPage()); // 用户关注和粉丝页面
      case '/chat':
        final args = settings.arguments as Map<String, String>;
        return _pageRouteBuilderAnimation(
            LJNChat(title: args['title']!, icon: args['icon']!)); // 聊天页面
      case '/group_chat':
        final args = settings.arguments as Map<String, String>;
        return _pageRouteBuilderAnimation(
            LJNGroupChat(title: args['title']!, icon: args['icon']!)); // 群聊页面
      case '/qrcode_scanner':
        return _pageRouteBuilderNotAnimation(const LJNQRCodeScanner()); // 二维码扫描页面
      case '/video_player':
        return _pageRouteBuilderAnimation(const LJNVideoPage()); // 视频播放页面

      // 用户相关路由
      case '/user/wallet':
        return _pageRouteBuilderAnimation(const LJNWallet()); // 用户钱包页面
      case '/user/info':
        return _pageRouteBuilderAnimation(const LJNUserinfo()); // 用户信息页面
      case '/user/pocketmoney':
        return _pageRouteBuilderAnimation(const LJNPocketMoney()); // 零钱页面
      case '/user/services':
        return _pageRouteBuilderAnimation(const LJNServices()); // 用户服务页面
      case '/user/services_manager':
        return _pageRouteBuilderAnimation(const LJNServicesManager()); // 服务管理页面
      case '/user/camera':
        return _pageRouteBuilderAnimation(const LJNCameraView()); // 相机页面
      case '/user/collection_and_payment':
        return _pageRouteBuilderAnimation(const LJNCollectionAndPayment()); // 收藏和支付页面
      case '/user/more_info':
        return _pageRouteBuilderAnimation(const LJNUserMoreInfo()); // 用户更多信息页面
      case '/user/course_list':
        return _pageRouteBuilderAnimation(const LJNCourseList()); // 课程列表页面
      case '/user/course_detail':
        final args = settings.arguments as Map<String, String>? ?? {};
        return _pageRouteBuilderAnimation(LJNCourseDetail(
          courseId: args['course_id'] ?? "",
        )); // 课程详情页面
      case '/user/lesson_content':
        final args = settings.arguments as Map<String, String>? ?? {};
        return _pageRouteBuilderAnimation(LJNLessonContent(
          lessonId: args['lesson_id'] ?? "",
        )); // 课程内容页面

      // 设置相关路由
      case '/settings':
        return _pageRouteBuilderAnimation(const LJNSettingPage()); // 设置主页面
      case '/settings/account_and_secure':
        return _pageRouteBuilderAnimation(const LJNAccountAndSecure()); // 账号与安全页面
      case '/settings/account_info':
        return _pageRouteBuilderAnimation(const LJNAccountInfo()); // 账号信息页面
      case '/settings/change_account':
        return _pageRouteBuilderAnimation(const LJNChangeAccount()); // 切换账号页面
      case '/settings/forgot_password':
        return _pageRouteBuilderAnimation(const LJNForgotPassword()); // 忘记密码页面
      case '/settings/phone_number':
        return _pageRouteBuilderAnimation(const LJNPhoneNumber()); // 手机号码页面
      case '/settings/phone_contact':
        return _pageRouteBuilderAnimation(const LJNPhoneContact()); // 手机联系人页面
      case '/settings/verify_phone':
        return _pageRouteBuilderAnimation(const LJNVerifyPhone()); // 验证手机页面
      case '/settings/bind_new_phone_number':
        return _pageRouteBuilderAnimation(const LJNBindNewPhoneNumber()); // 绑定新手机号码页面
      case '/settings/input_verify_code':
        return _pageRouteBuilderAnimation(const LJNInputVerifyCode()); // 输入验证码页面
      case '/settings/teenage_mode':
        return _pageRouteBuilderAnimation(const LJNYouthMode()); // 青少年模式页面
      case '/settings/care_mode':
        return _pageRouteBuilderAnimation(const LJNCareMode()); // 关怀模式页面
      case '/settings/new_message_notification':
        return _pageRouteBuilderAnimation(const LJNNewMessageNotification()); // 新消息通知页面
      case '/settings/chat_setting':
        return _pageRouteBuilderAnimation(const LJNChatSetting()); // 聊天设置页面
      case '/settings/common_setting':
        return _pageRouteBuilderAnimation(const LJNCommonSetting()); // 通用设置页面
      case '/settings/set_password':
        return _pageRouteBuilderAnimation(const LJNSetPassword()); // 设置密码页面
      case '/settings/logged_devices':
        return _pageRouteBuilderAnimation(const LJNLoggedDevices()); // 已登录设备页面
      case '/settings/device_detail':
        return _pageRouteBuilderAnimation(const LJNDeviceDetail()); // 设备详情页面
      case '/settings/emergency_contact':
        return _pageRouteBuilderAnimation(const LJNEmergencyContact()); // 紧急联系人页面
      case '/settings/more_secure_setting':
        return _pageRouteBuilderAnimation(const LJNMoreSecureSetting()); // 更多安全设置页面
      case '/settings/sound_lock':
        return _pageRouteBuilderAnimation(const LJNSoundLock()); // 声音锁页面
      case '/settings/personinfo_and_permission':
        return _pageRouteBuilderAnimation(const LJNPersonalinfoAndPermission()); // 个人信息与权限页面
      case '/settings/personalinfo_collection_checklist':
        return _pageRouteBuilderAnimation(
            const LJNPersonalInfoCollectionChecklist()); // 个人信息收集清单页面
      case '/settings/about':
        return _pageRouteBuilderAnimation(const LJNAbout()); // 关于页面
      case '/settings/friend_permission':
        return _pageRouteBuilderAnimation(const LJNFriendPermission()); // 朋友权限页面
      case '/settings/language_setting':
        return _pageRouteBuilderAnimation(const LJNLanguageSetting()); // 语言设置页面
      case '/settings/theme_setting':
        return _pageRouteBuilderAnimation(const LJNThemeSetting()); // 主题设置页面
      case '/user/wallet/change_details':
        return _pageRouteBuilderAnimation(const LJNChangeDetails()); // 零钱明细页面
      case '/user/wallet/bill_details':
        return _pageRouteBuilderAnimation(const LJNBillDetails()); // 账单详情页面

      // 通讯录相关路由
      case '/contact':
        return _pageRouteBuilderAnimation(const LJNContact()); // 通讯录主页面
      case '/contact/tags':
        return _pageRouteBuilderAnimation(const LJNContactTags()); // 标签管理页面
      case '/contact/tag_group':
        return _pageRouteBuilderAnimation(const LJNContactTagGroup()); // 标签分组页面
      case '/contact/official_accounts':
        return _pageRouteBuilderAnimation(const LJNOfficialAccounts()); // 公众号页面
      case '/contact/group':
        return _pageRouteBuilderAnimation(const LJNContactGroup()); // 群组页面
      case '/contact/friends_who_only_chat':
        return _pageRouteBuilderAnimation(const LJNFriendsWhoOnlyChat()); // 仅聊天朋友页面
      case '/contact/new_friends':
        return _pageRouteBuilderAnimation(const LJNNewFriends()); // 新朋友页面
      case '/contact/search_friend':
        return _pageRouteBuilderAnimation(const LJNSearchFriend()); // 搜索朋友页面
      case '/contact/add_friends':
        return _pageRouteBuilderAnimation(const LJNAddFriends()); // 添加朋友页面

      // 聊天相关路由
      case '/chat/friend_profile':
        final args = settings.arguments as Map<String, String>? ?? {};
        return _pageRouteBuilderAnimation(LJNFriendProfile(
          name: args['name'] ?? "",
          nickname: args['nickname'] ?? "",
          account: args['account'] ?? "",
          avatar: args['avatar'] ?? "",
        )); // 朋友资料页面
      case '/chat/friend_moments':
        return _pageRouteBuilderAnimation(const LJNFriendmoments()); // 朋友动态页面
      case '/chat/friend_message_record':
        return _pageRouteBuilderAnimation(const LJNFriendMessageRecord()); // 朋友消息记录页面
      case '/chat/friend_data_setting':
        return _pageRouteBuilderAnimation(const LJNFriendDataSetting()); // 朋友资料设置页面
      case '/chat/friend_more_info':
        return _pageRouteBuilderAnimation(const LJNFriendMoreInfo()); // 朋友更多信息页面
      case '/chat/group_message_record':
        return _pageRouteBuilderAnimation(const LJNGroupMessageRecord()); // 群消息记录页面
      case '/chat/dial':
        return _pageRouteBuilderNotAnimation(const LJNDial()); // 拨号页面
      case '/chat/set_notes_and_labels':
        return _pageRouteBuilderAnimation(const LJNSetNotesAndLabels()); // 设置备注和标签页面
      case '/chat/friend_permissions':
        return _pageRouteBuilderAnimation(const LJNFriendPermissions()); // 朋友权限设置页面
      case '/chat/friend_information':
        return _pageRouteBuilderAnimation(const LJNFriendInformation()); // 朋友信息页面
      case '/chat/set_friend_tags':
        return _pageRouteBuilderAnimation(const LJNSetFriendTags()); // 设置朋友标签页面
      case '/chat/friend_moments_cover_setting':
        return _pageRouteBuilderAnimation(const LJNFriendMomentsCoverSetting()); // 朋友动态封面设置页面

      // 发现相关路由
      case '/discovery/search':
        return _pageRouteBuilderNotAnimation(const LJNSearch()); // 发现搜索页面
      case '/discovery/ins':
        return _pageRouteBuilderAnimation(const LJNIns()); // 朋友圈页面
      case '/discovery/miniprogram_list':
        return _pageRouteBuilderAnimation(const LJNMiniProgramList()); // 小程序列表页面
      case '/discovery/publisher':
        return _pageRouteBuilderAnimation(const LJNPublisher()); // 发布页面

      // 测试和其他路由
      case '/test':
        return _pageRouteBuilderAnimation(const LJNTest()); // 测试页面

      default:
        // 可以返回一个统一的404页面
        return _pageRouteBuilderAnimation(
          Scaffold(
            body: Center(
              child: Text('页面未找到: ${settings.name}'),
            ),
          ),
        );
    }
  }

  // 带动效进入页面
  static PageRouteBuilder _pageRouteBuilderAnimation(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  // 不带动效进入页面
  static PageRouteBuilder _pageRouteBuilderNotAnimation(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          child,
    );
  }
}
