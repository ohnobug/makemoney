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
import 'package:vigaviga/screens/arts/ljn_arts.dart';
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
import 'package:vigaviga/screens/user/settings/ljn_bill_details.dart';
import 'package:vigaviga/screens/user/settings/ljn_bind_new_phone_number.dart';
import 'package:vigaviga/screens/user/settings/ljn_care_mode.dart';
import 'package:vigaviga/screens/user/settings/ljn_change_account.dart';
import 'package:vigaviga/screens/user/settings/ljn_change_details.dart';
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
import 'package:vigaviga/screens/user/ljn_collection_and_payment.dart';
import 'package:vigaviga/screens/contract/chat/ljn_dial.dart';
import 'package:vigaviga/screens/contract/chat/ljn_friend_profile.dart';
import 'package:vigaviga/screens/user/ljn_pocketmoney.dart';
import 'package:vigaviga/screens/user/ljn_services.dart';
import 'package:vigaviga/screens/user/ljn_services_manager.dart';
import 'package:vigaviga/screens/user/ljn_user_more_info.dart';
import 'package:vigaviga/screens/user/ljn_userinfo.dart';
import 'package:vigaviga/screens/user/ljn_wallet.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/videoplayer.dart';
import 'package:vigaviga/widgets/ljn_custom_tabbar.dart';
import 'package:vigaviga/screens/publisher/publish_work.dart';
import 'package:vigaviga/screens/publisher/geolocator.dart';
import 'package:vigaviga/screens/publisher/ai_publisher.dart';
import 'package:vigaviga/screens/publisher/resource_publisher.dart';
import 'package:vigaviga/screens/user/follow/ljn_follow_page.dart';
import 'package:vigaviga/screens/user/ljn_like.dart';

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
      case '/':
        return _pageRouteBuilderNotAnimation(const LJNCustomTabbar());
      case '/publish_work':
        return _pageRouteBuilderNotAnimation(const VideoPublishPageState());
      case '/locationPage':
        return _pageRouteBuilderNotAnimation(const AddLocationPage());
      case '/ai_publisher':
        return _pageRouteBuilderNotAnimation(const LoRASettingsPage());
      case '/resource_publisher':
        return _pageRouteBuilderNotAnimation(const ResourceSearchPage());
      case '/ljn_like':
        return _pageRouteBuilderNotAnimation(const LikedVideosPage());
      case '/follow_and_fans':
        return _pageRouteBuilderAnimation(const LJNFollowPage());
      case '/miniprogram_list':
        return _pageRouteBuilderAnimation(const LJNMiniProgramList());
      case '/services':
        return _pageRouteBuilderAnimation(const LJNServices());
      case '/tiktik':
        return _pageRouteBuilderAnimation(const LJNArts());
      case '/chat':
        final args = settings.arguments as Map<String, String>;
        return _pageRouteBuilderAnimation(
            LJNChat(title: args['title']!, icon: args['icon']!));
      case '/group_chat':
        final args = settings.arguments as Map<String, String>;
        return _pageRouteBuilderAnimation(
            LJNGroupChat(title: args['title']!, icon: args['icon']!));
      case '/qrcode_scanner':
        return _pageRouteBuilderNotAnimation(const LJNQRCodeScanner());
      case '/video_player':
        return _pageRouteBuilderAnimation(const LJNVideoPage());
      case '/wallet':
        return _pageRouteBuilderAnimation(const LJNWallet());
      case '/userinfo':
        return _pageRouteBuilderAnimation(const LJNUserinfo());
      case '/friendmoments':
        return _pageRouteBuilderAnimation(const LJNFriendmoments());
      case '/pocketmoney':
        return _pageRouteBuilderAnimation(const LJNPocketMoney());
      case '/friendprofile':
        final args = settings.arguments as Map<String, String>? ?? {};
        return _pageRouteBuilderAnimation(LJNFriendProfile(
          name: args['name'] ?? "",
          nickname: args['nickname'] ?? "",
          account: args['account'] ?? "",
          avatar: args['avatar'] ?? "",
        ));
      case '/ins':
        return _pageRouteBuilderAnimation(const LJNIns());
      case '/search':
        return _pageRouteBuilderNotAnimation(const LJNSearch());
      case '/setting':
        return _pageRouteBuilderAnimation(const LJNSettingPage());
      case '/account_and_secure':
        return _pageRouteBuilderAnimation(const LJNAccountAndSecure());
      case '/accountinfo':
        return _pageRouteBuilderAnimation(const LJNAccountInfo());
      case '/change_account':
        return _pageRouteBuilderAnimation(const LJNChangeAccount());
      case '/forgot_password':
        return _pageRouteBuilderAnimation(const LJNForgotPassword());
      case '/phone_number':
        return _pageRouteBuilderAnimation(const LJNPhoneNumber());
      case '/phone_contact':
        return _pageRouteBuilderAnimation(const LJNPhoneContact());
      case '/verify_phone':
        return _pageRouteBuilderAnimation(const LJNVerifyPhone());
      case '/bind_new_phone_number':
        return _pageRouteBuilderAnimation(const LJNBindNewPhoneNumber());
      case '/input_verify_code':
        return _pageRouteBuilderAnimation(const LJNInputVerifyCode());
      case '/teenage_mode':
        return _pageRouteBuilderAnimation(const LJNYouthMode());
      case '/care_mode':
        return _pageRouteBuilderAnimation(const LJNCareMode());
      case '/new_message_notification':
        return _pageRouteBuilderAnimation(const LJNNewMessageNotification());
      case '/collection_and_payment':
        return _pageRouteBuilderAnimation(const LJNCollectionAndPayment());
      case '/chat_setting':
        return _pageRouteBuilderAnimation(const LJNChatSetting());
      case '/common_setting':
        return _pageRouteBuilderAnimation(const LJNCommonSetting());
      case '/set_password':
        return _pageRouteBuilderAnimation(const LJNSetPassword());
      case '/logged_devices':
        return _pageRouteBuilderAnimation(const LJNLoggedDevices());
      case '/device_detail':
        return _pageRouteBuilderAnimation(const LJNDeviceDetail());
      case '/emergency_contact':
        return _pageRouteBuilderAnimation(const LJNEmergencyContact());
      case '/more_secure_setting':
        return _pageRouteBuilderAnimation(const LJNMoreSecureSetting());
      case '/sound_lock':
        return _pageRouteBuilderAnimation(const LJNSoundLock());
      case '/personinfo_and_permission':
        return _pageRouteBuilderAnimation(const LJNPersonalinfoAndPermission());
      case '/personalinfo_collection_checklist':
        return _pageRouteBuilderAnimation(
            const LJNPersonalInfoCollectionChecklist());
      case '/about':
        return _pageRouteBuilderAnimation(const LJNAbout());
      case '/friend_permission':
        return _pageRouteBuilderAnimation(const LJNFriendPermission());
      case '/change_details':
        return _pageRouteBuilderAnimation(const LJNChangeDetails());
      case '/bill_details':
        return _pageRouteBuilderAnimation(const LJNBillDetails());
      case '/friend_message_record':
        return _pageRouteBuilderAnimation(const LJNFriendMessageRecord());
      case '/friend_data_setting':
        return _pageRouteBuilderAnimation(const LJNFriendDataSetting());
      case '/user_more_info':
        return _pageRouteBuilderAnimation(const LJNUserMoreInfo());
      case '/friend_more_info':
        return _pageRouteBuilderAnimation(const LJNFriendMoreInfo());
      case '/add_friends':
        return _pageRouteBuilderAnimation(const LJNAddFriends());
      case '/search_friend':
        return _pageRouteBuilderAnimation(const LJNSearchFriend());
      case '/group_message_record':
        return _pageRouteBuilderAnimation(const LJNGroupMessageRecord());
      case '/dial':
        return _pageRouteBuilderNotAnimation(const LJNDial());
      case '/services_manager':
        return _pageRouteBuilderAnimation(const LJNServicesManager());
      case '/set_notes_and_labels':
        return _pageRouteBuilderAnimation(const LJNSetNotesAndLabels());
      case '/friend_permissions':
        return _pageRouteBuilderAnimation(const LJNFriendPermissions());
      case '/test':
        return _pageRouteBuilderAnimation(const LJNTest());
      case '/friends_who_only_chat':
        return _pageRouteBuilderAnimation(const LJNFriendsWhoOnlyChat());
      case '/new_friends':
        return _pageRouteBuilderAnimation(const LJNNewFriends());
      case '/camera':
        return _pageRouteBuilderAnimation(const LJNCameraView());
      case '/friend_information':
        return _pageRouteBuilderAnimation(const LJNFriendInformation());
      case '/set_friend_tags':
        return _pageRouteBuilderAnimation(const LJNSetFriendTags());
      case '/publisher':
        return _pageRouteBuilderAnimation(const LJNPublisher());
      case '/contact':
        return _pageRouteBuilderAnimation(const LJNContact());
      case '/contact_tags':
        return _pageRouteBuilderAnimation(const LJNContactTags());
      case '/contact_tag_group':
        return _pageRouteBuilderAnimation(const LJNContactTagGroup());
      case '/official_accounts':
        return _pageRouteBuilderAnimation(const LJNOfficialAccounts());
      case '/contact_group':
        return _pageRouteBuilderAnimation(const LJNContactGroup());
      case '/friend_moments_cover_setting':
        return _pageRouteBuilderAnimation(const LJNFriendMomentsCoverSetting());
      case '/language_setting':
        return _pageRouteBuilderAnimation(const LJNLanguageSetting());
      case '/theme_setting':
        return _pageRouteBuilderAnimation(const LJNThemeSetting());
      case '/course_list':
        return _pageRouteBuilderAnimation(const LJNCourseList());
      case '/course_detail':
        final args = settings.arguments as Map<String, String>? ?? {};
        return _pageRouteBuilderAnimation(LJNCourseDetail(
          courseId: args['course_id'] ?? "",
        ));
      case '/lesson_content':
        final args = settings.arguments as Map<String, String>? ?? {};
        return _pageRouteBuilderAnimation(LJNLessonContent(
          lessonId: args['lesson_id'] ?? "",
        ));

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
