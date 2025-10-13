import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @vigaviga.
  ///
  /// In en, this message translates to:
  /// **'Vigaviga'**
  String get vigaviga;

  /// No description provided for @vigavigaID.
  ///
  /// In en, this message translates to:
  /// **'Vigaviga ID'**
  String get vigavigaID;

  /// No description provided for @vigavigaPassword.
  ///
  /// In en, this message translates to:
  /// **'Vigaviga Password'**
  String get vigavigaPassword;

  /// No description provided for @vigavigaSecurityCenter.
  ///
  /// In en, this message translates to:
  /// **'Vigaviga Security Center'**
  String get vigavigaSecurityCenter;

  /// No description provided for @changeVigavigaID.
  ///
  /// In en, this message translates to:
  /// **'Change Vigaviga ID'**
  String get changeVigavigaID;

  /// No description provided for @vigavigaBeans.
  ///
  /// In en, this message translates to:
  /// **'Vigaviga Beans'**
  String get vigavigaBeans;

  /// No description provided for @vigavigaGames.
  ///
  /// In en, this message translates to:
  /// **'Vigaviga Games'**
  String get vigavigaGames;

  /// No description provided for @aboutVigaviga.
  ///
  /// In en, this message translates to:
  /// **'About Vigaviga'**
  String get aboutVigaviga;

  /// No description provided for @weRun.
  ///
  /// In en, this message translates to:
  /// **'WeRun'**
  String get weRun;

  /// No description provided for @personalInfoCollectionFullDescription.
  ///
  /// In en, this message translates to:
  /// **'    You can review the personal information collected by Vigaviga. The following statistics only include information collected by iOS 8.0.17, Android 8.0.18, and later versions of Vigaviga. Vigaviga cannot fully account for information collected while you were using older versions.'**
  String get personalInfoCollectionFullDescription;

  /// No description provided for @privacy_setting_description.
  ///
  /// In en, this message translates to:
  /// **'You will not be able to see each other\'s Moments, Status, WeRun, Top Stories, or content shared from third-party app authorizations.'**
  String get privacy_setting_description;

  /// Toast message shown after successfully copying a Vigaviga ID
  ///
  /// In en, this message translates to:
  /// **'Copied successfully! Vigaviga ID: {account}'**
  String copySuccessWithVigavigaId(String account);

  /// No description provided for @verifyIdentityWithPasswordFull.
  ///
  /// In en, this message translates to:
  /// **'Enter your current Vigaviga login password to verify your identity.'**
  String get verifyIdentityWithPasswordFull;

  /// No description provided for @autoDownloadVigavigaInstaller.
  ///
  /// In en, this message translates to:
  /// **'Automatically download Vigaviga installer'**
  String get autoDownloadVigavigaInstaller;

  /// No description provided for @vigavigaIdModificationRuleFull.
  ///
  /// In en, this message translates to:
  /// **'Your Vigaviga ID is the unique identifier for your account and can only be changed once a year.'**
  String get vigavigaIdModificationRuleFull;

  /// No description provided for @device_management_auto_extend_login_info_friendly.
  ///
  /// In en, this message translates to:
  /// **'After logging into Vigaviga, when the device is in a secure state, Vigaviga will automatically extend the login session to ensure timely message delivery. The last active time will be updated accordingly.'**
  String get device_management_auto_extend_login_info_friendly;

  /// No description provided for @loginWithVoiceprint.
  ///
  /// In en, this message translates to:
  /// **'Log in with Voiceprint'**
  String get loginWithVoiceprint;

  /// Displays the number of Vigaviga Beans
  ///
  /// In en, this message translates to:
  /// **'{count} Vigaviga Beans'**
  String vigavigaBeanCount(int count);

  /// No description provided for @vigavigaKeyboardFeatureAskAI.
  ///
  /// In en, this message translates to:
  /// **'Vigaviga Keyboard can now [Ask AI]'**
  String get vigavigaKeyboardFeatureAskAI;

  /// No description provided for @setVigavigaPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Please set a Vigaviga password. You can log in with your bound account + Vigaviga password, for example, using your phone number + Vigaviga password for a faster login experience.'**
  String get setVigavigaPasswordDescription;

  /// No description provided for @shortcutPermissionGuidanceFull.
  ///
  /// In en, this message translates to:
  /// **'If adding the shortcut fails, please go to System Settings and grant Vigaviga the permission to \'Create home screen shortcuts\'.'**
  String get shortcutPermissionGuidanceFull;

  /// Displays the Vigaviga ID
  ///
  /// In en, this message translates to:
  /// **'Vigaviga ID: {account}'**
  String vigavigaIdDisplay(String account);

  /// Displays my Vigaviga ID
  ///
  /// In en, this message translates to:
  /// **'My Vigaviga ID: {account}'**
  String myVigavigaIdDisplay(String account);

  /// No description provided for @youthModeFullDescription.
  ///
  /// In en, this message translates to:
  /// **'To protect the healthy growth of minors, Vigaviga has introduced Youth Mode. Some features will be restricted in this mode. Guardians are requested to set it up proactively.'**
  String get youthModeFullDescription;

  /// No description provided for @youthModeTermsOfServiceTitle.
  ///
  /// In en, this message translates to:
  /// **'《Vigaviga Youth Mode Terms of Service》'**
  String get youthModeTermsOfServiceTitle;

  /// No description provided for @navigateToResetPasswordGuidanceFull.
  ///
  /// In en, this message translates to:
  /// **'You need to go to \'Settings > Account & Security > Vigaviga Password\' to reset your Vigaviga password.'**
  String get navigateToResetPasswordGuidanceFull;

  /// No description provided for @douyinHotTrends.
  ///
  /// In en, this message translates to:
  /// **'Douyin Hot Trends'**
  String get douyinHotTrends;

  /// No description provided for @yuanxiangSmartChoice.
  ///
  /// In en, this message translates to:
  /// **'Yuanxiang Smart Choice'**
  String get yuanxiangSmartChoice;

  /// No description provided for @qqId.
  ///
  /// In en, this message translates to:
  /// **'QQ ID'**
  String get qqId;

  /// No description provided for @serviceProvidedByTenpayAndWeBank.
  ///
  /// In en, this message translates to:
  /// **'This service is provided by Tenpay and WeBank'**
  String get serviceProvidedByTenpayAndWeBank;

  /// No description provided for @weilidaiLoan.
  ///
  /// In en, this message translates to:
  /// **'Weilidai Loan'**
  String get weilidaiLoan;

  /// No description provided for @licaitong.
  ///
  /// In en, this message translates to:
  /// **'Licaitong'**
  String get licaitong;

  /// No description provided for @tencentCharity.
  ///
  /// In en, this message translates to:
  /// **'Tencent Charity'**
  String get tencentCharity;

  /// No description provided for @didiRideHailing.
  ///
  /// In en, this message translates to:
  /// **'DiDi'**
  String get didiRideHailing;

  /// No description provided for @jdShopping.
  ///
  /// In en, this message translates to:
  /// **'JD.com Shopping'**
  String get jdShopping;

  /// No description provided for @meituanWaimai.
  ///
  /// In en, this message translates to:
  /// **'Meituan Food Delivery'**
  String get meituanWaimai;

  /// No description provided for @meituanSpecialOffers.
  ///
  /// In en, this message translates to:
  /// **'Meituan Deals'**
  String get meituanSpecialOffers;

  /// No description provided for @pinduoduo.
  ///
  /// In en, this message translates to:
  /// **'Pinduoduo'**
  String get pinduoduo;

  /// No description provided for @vipshop.
  ///
  /// In en, this message translates to:
  /// **'Vipshop'**
  String get vipshop;

  /// No description provided for @zhuanzhuanUsedGoods.
  ///
  /// In en, this message translates to:
  /// **'Zhuan Zhuan'**
  String get zhuanzhuanUsedGoods;

  /// No description provided for @meituanGroupBuy.
  ///
  /// In en, this message translates to:
  /// **'Meituan Group Buy'**
  String get meituanGroupBuy;

  /// No description provided for @qCoinTopUp.
  ///
  /// In en, this message translates to:
  /// **'Q Coin Top-up'**
  String get qCoinTopUp;

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Vigaviga'**
  String get app_name;

  /// No description provided for @tabbar_label_arts.
  ///
  /// In en, this message translates to:
  /// **'Arts'**
  String get tabbar_label_arts;

  /// No description provided for @tabbar_label_chat.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get tabbar_label_chat;

  /// No description provided for @tabbar_label_contacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get tabbar_label_contacts;

  /// No description provided for @tabbar_label_publisher.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get tabbar_label_publisher;

  /// No description provided for @tabbar_label_discover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get tabbar_label_discover;

  /// No description provided for @tabbar_label_me.
  ///
  /// In en, this message translates to:
  /// **'Me'**
  String get tabbar_label_me;

  /// No description provided for @contacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contacts;

  /// No description provided for @me.
  ///
  /// In en, this message translates to:
  /// **'Me'**
  String get me;

  /// No description provided for @displayKeyboard.
  ///
  /// In en, this message translates to:
  /// **'Display Keyboard'**
  String get displayKeyboard;

  /// No description provided for @hideKeyboard.
  ///
  /// In en, this message translates to:
  /// **'Hide Keyboard'**
  String get hideKeyboard;

  /// No description provided for @switchToKeyboard.
  ///
  /// In en, this message translates to:
  /// **'Switch to Keyboard'**
  String get switchToKeyboard;

  /// No description provided for @switchToEmoji.
  ///
  /// In en, this message translates to:
  /// **'Switch to Emoji'**
  String get switchToEmoji;

  /// No description provided for @switchToFunctions.
  ///
  /// In en, this message translates to:
  /// **'Switch to Function Panel'**
  String get switchToFunctions;

  /// No description provided for @showEmojiPicker.
  ///
  /// In en, this message translates to:
  /// **'Show Emoji Picker'**
  String get showEmojiPicker;

  /// No description provided for @hideEmojiPicker.
  ///
  /// In en, this message translates to:
  /// **'Hide Emoji Picker'**
  String get hideEmojiPicker;

  /// No description provided for @showFunctionPanel.
  ///
  /// In en, this message translates to:
  /// **'Show Function Panel'**
  String get showFunctionPanel;

  /// No description provided for @hideFunctionPanel.
  ///
  /// In en, this message translates to:
  /// **'Hide Function Panel'**
  String get hideFunctionPanel;

  /// No description provided for @deviceNotSupportVibration.
  ///
  /// In en, this message translates to:
  /// **'Device does not support vibration'**
  String get deviceNotSupportVibration;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @album.
  ///
  /// In en, this message translates to:
  /// **'Album'**
  String get album;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @videoCall.
  ///
  /// In en, this message translates to:
  /// **'Video Call'**
  String get videoCall;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @redPacket.
  ///
  /// In en, this message translates to:
  /// **'Red Packet'**
  String get redPacket;

  /// No description provided for @gift.
  ///
  /// In en, this message translates to:
  /// **'Gift'**
  String get gift;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @voiceInput.
  ///
  /// In en, this message translates to:
  /// **'Voice Input'**
  String get voiceInput;

  /// No description provided for @releaseToSend.
  ///
  /// In en, this message translates to:
  /// **'Release to Send'**
  String get releaseToSend;

  /// No description provided for @convertToText.
  ///
  /// In en, this message translates to:
  /// **'Convert to Text'**
  String get convertToText;

  /// No description provided for @microphoneOn.
  ///
  /// In en, this message translates to:
  /// **'Microphone On'**
  String get microphoneOn;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @searchHintAccountOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Search by Account/Phone Number'**
  String get searchHintAccountOrPhone;

  /// No description provided for @accountOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Account/Phone Number'**
  String get accountOrPhone;

  /// No description provided for @speakerOff.
  ///
  /// In en, this message translates to:
  /// **'Speaker Off'**
  String get speakerOff;

  /// No description provided for @friendProfile.
  ///
  /// In en, this message translates to:
  /// **'Friend Profile'**
  String get friendProfile;

  /// No description provided for @friendPermissions.
  ///
  /// In en, this message translates to:
  /// **'Friend Permissions'**
  String get friendPermissions;

  /// No description provided for @moments.
  ///
  /// In en, this message translates to:
  /// **'Moments'**
  String get moments;

  /// Displays a timestamp in a full year-month-day-hour-minute-second format
  ///
  /// In en, this message translates to:
  /// **'{timestamp}'**
  String fullDateTime(DateTime timestamp);

  /// No description provided for @channels.
  ///
  /// In en, this message translates to:
  /// **'Channels'**
  String get channels;

  /// No description provided for @moreInfo.
  ///
  /// In en, this message translates to:
  /// **'More Info'**
  String get moreInfo;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// No description provided for @heSanqi.
  ///
  /// In en, this message translates to:
  /// **'Sanqi He'**
  String get heSanqi;

  /// No description provided for @audioVideoCall.
  ///
  /// In en, this message translates to:
  /// **'Audio/Video Call'**
  String get audioVideoCall;

  /// No description provided for @scrolling.
  ///
  /// In en, this message translates to:
  /// **'Scrolling'**
  String get scrolling;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// No description provided for @allEmojis.
  ///
  /// In en, this message translates to:
  /// **'All Emojis'**
  String get allEmojis;

  /// No description provided for @cancelClick.
  ///
  /// In en, this message translates to:
  /// **'Cancel Click'**
  String get cancelClick;

  /// No description provided for @popup.
  ///
  /// In en, this message translates to:
  /// **'Popup'**
  String get popup;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Load failed'**
  String get loadFailed;

  /// No description provided for @playRecording.
  ///
  /// In en, this message translates to:
  /// **'Play Recording'**
  String get playRecording;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @addedToDesktopAttempt.
  ///
  /// In en, this message translates to:
  /// **'Attempted to add to Home Screen'**
  String get addedToDesktopAttempt;

  /// No description provided for @createDesktopShortcut.
  ///
  /// In en, this message translates to:
  /// **'Create Home Screen Shortcut'**
  String get createDesktopShortcut;

  /// No description provided for @doNotRemindAgain.
  ///
  /// In en, this message translates to:
  /// **'Do Not Remind Again'**
  String get doNotRemindAgain;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learnMore;

  /// No description provided for @voiceCall.
  ///
  /// In en, this message translates to:
  /// **'Voice Call'**
  String get voiceCall;

  /// No description provided for @cache.
  ///
  /// In en, this message translates to:
  /// **'Cache'**
  String get cache;

  /// No description provided for @newFriends.
  ///
  /// In en, this message translates to:
  /// **'New Friends'**
  String get newFriends;

  /// No description provided for @chatOnlyFriends.
  ///
  /// In en, this message translates to:
  /// **'Chat-Only Friends'**
  String get chatOnlyFriends;

  /// No description provided for @groupChats.
  ///
  /// In en, this message translates to:
  /// **'Group Chats'**
  String get groupChats;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @officialAccounts.
  ///
  /// In en, this message translates to:
  /// **'Official Accounts'**
  String get officialAccounts;

  /// No description provided for @added.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get added;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @contactTags.
  ///
  /// In en, this message translates to:
  /// **'Contact Tags'**
  String get contactTags;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @newAction.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newAction;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @addPhoneContacts.
  ///
  /// In en, this message translates to:
  /// **'Add Phone Contacts'**
  String get addPhoneContacts;

  /// No description provided for @twoDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'Two days ago'**
  String get twoDaysAgo;

  /// No description provided for @fiveDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'Five days ago'**
  String get fiveDaysAgo;

  /// No description provided for @addFriend.
  ///
  /// In en, this message translates to:
  /// **'Add Friend'**
  String get addFriend;

  /// No description provided for @live.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get live;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @listen.
  ///
  /// In en, this message translates to:
  /// **'Listen'**
  String get listen;

  /// No description provided for @look.
  ///
  /// In en, this message translates to:
  /// **'Top Stories'**
  String get look;

  /// No description provided for @searchAction.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchAction;

  /// No description provided for @nearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby'**
  String get nearby;

  /// No description provided for @shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shopping;

  /// No description provided for @games.
  ///
  /// In en, this message translates to:
  /// **'Games'**
  String get games;

  /// No description provided for @miniPrograms.
  ///
  /// In en, this message translates to:
  /// **'Mini Programs'**
  String get miniPrograms;

  /// No description provided for @retreat.
  ///
  /// In en, this message translates to:
  /// **'Retreat'**
  String get retreat;

  /// No description provided for @recentUsed.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recentUsed;

  /// No description provided for @recentMiniPrograms.
  ///
  /// In en, this message translates to:
  /// **'Recent Mini Programs'**
  String get recentMiniPrograms;

  /// No description provided for @myMiniPrograms.
  ///
  /// In en, this message translates to:
  /// **'My Mini Programs'**
  String get myMiniPrograms;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @prompt.
  ///
  /// In en, this message translates to:
  /// **'Prompt'**
  String get prompt;

  /// No description provided for @userLiked.
  ///
  /// In en, this message translates to:
  /// **'User liked this'**
  String get userLiked;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @userShared.
  ///
  /// In en, this message translates to:
  /// **'User shared this'**
  String get userShared;

  /// No description provided for @userDownloaded.
  ///
  /// In en, this message translates to:
  /// **'User downloaded this'**
  String get userDownloaded;

  /// No description provided for @userFavorited.
  ///
  /// In en, this message translates to:
  /// **'User favorited this'**
  String get userFavorited;

  /// No description provided for @like.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get like;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @viewHomepage.
  ///
  /// In en, this message translates to:
  /// **'View Homepage'**
  String get viewHomepage;

  /// No description provided for @forwardTo.
  ///
  /// In en, this message translates to:
  /// **'Forward to'**
  String get forwardTo;

  /// No description provided for @fileTransferHelper.
  ///
  /// In en, this message translates to:
  /// **'File Transfer'**
  String get fileTransferHelper;

  /// No description provided for @forwardToFriend.
  ///
  /// In en, this message translates to:
  /// **'Forward to a friend'**
  String get forwardToFriend;

  /// No description provided for @shareToMoments.
  ///
  /// In en, this message translates to:
  /// **'Share on Moments'**
  String get shareToMoments;

  /// No description provided for @addToMyMiniPrograms.
  ///
  /// In en, this message translates to:
  /// **'Add to My Mini Programs'**
  String get addToMyMiniPrograms;

  /// No description provided for @addToDesktop.
  ///
  /// In en, this message translates to:
  /// **'Add to Home Screen'**
  String get addToDesktop;

  /// No description provided for @openOnComputer.
  ///
  /// In en, this message translates to:
  /// **'Open on computer'**
  String get openOnComputer;

  /// No description provided for @floatingWindow.
  ///
  /// In en, this message translates to:
  /// **'Floating Window'**
  String get floatingWindow;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @feedbackAndComplaints.
  ///
  /// In en, this message translates to:
  /// **'Feedback & Complaints'**
  String get feedbackAndComplaints;

  /// No description provided for @reEnterMiniProgram.
  ///
  /// In en, this message translates to:
  /// **'Re-enter Mini Program'**
  String get reEnterMiniProgram;

  /// No description provided for @copyLink.
  ///
  /// In en, this message translates to:
  /// **'Copy Link'**
  String get copyLink;

  /// No description provided for @translate.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get translate;

  /// No description provided for @growthGuardianAntiAddiction.
  ///
  /// In en, this message translates to:
  /// **'Growth Guardian Anti-Addiction'**
  String get growthGuardianAntiAddiction;

  /// No description provided for @myFavorites.
  ///
  /// In en, this message translates to:
  /// **'My Favorites'**
  String get myFavorites;

  /// No description provided for @nearbyMiniPrograms.
  ///
  /// In en, this message translates to:
  /// **'Nearby Mini Programs'**
  String get nearbyMiniPrograms;

  /// No description provided for @touchToLightUp.
  ///
  /// In en, this message translates to:
  /// **'Touch to light up'**
  String get touchToLightUp;

  /// No description provided for @myQRCode.
  ///
  /// In en, this message translates to:
  /// **'My QR Code'**
  String get myQRCode;

  /// No description provided for @cityHotTrends.
  ///
  /// In en, this message translates to:
  /// **'City Hot Trends'**
  String get cityHotTrends;

  /// No description provided for @liveHotTrends.
  ///
  /// In en, this message translates to:
  /// **'Live Hot Trends'**
  String get liveHotTrends;

  /// No description provided for @groupBuyHotTrends.
  ///
  /// In en, this message translates to:
  /// **'Group Buy Hot Trends'**
  String get groupBuyHotTrends;

  /// No description provided for @brandHotTrends.
  ///
  /// In en, this message translates to:
  /// **'Brand Hot Trends'**
  String get brandHotTrends;

  /// No description provided for @musicHotTrends.
  ///
  /// In en, this message translates to:
  /// **'Music Hot Trends'**
  String get musicHotTrends;

  /// No description provided for @techHotTrends.
  ///
  /// In en, this message translates to:
  /// **'Tech Hot Trends'**
  String get techHotTrends;

  /// No description provided for @autoHotTrends.
  ///
  /// In en, this message translates to:
  /// **'Auto Hot Trends'**
  String get autoHotTrends;

  /// No description provided for @idiotList.
  ///
  /// In en, this message translates to:
  /// **'Idiot List'**
  String get idiotList;

  /// No description provided for @richList.
  ///
  /// In en, this message translates to:
  /// **'Rich List'**
  String get richList;

  /// No description provided for @prankList.
  ///
  /// In en, this message translates to:
  /// **'Prank List'**
  String get prankList;

  /// No description provided for @horrorList.
  ///
  /// In en, this message translates to:
  /// **'Horror List'**
  String get horrorList;

  /// No description provided for @kidsList.
  ///
  /// In en, this message translates to:
  /// **'Kids List'**
  String get kidsList;

  /// No description provided for @goodPersonList.
  ///
  /// In en, this message translates to:
  /// **'Good Person List'**
  String get goodPersonList;

  /// No description provided for @badPersonList.
  ///
  /// In en, this message translates to:
  /// **'Bad Person List'**
  String get badPersonList;

  /// No description provided for @rockList.
  ///
  /// In en, this message translates to:
  /// **'Rock List'**
  String get rockList;

  /// No description provided for @movieList.
  ///
  /// In en, this message translates to:
  /// **'Movie List'**
  String get movieList;

  /// No description provided for @tvSeriesList.
  ///
  /// In en, this message translates to:
  /// **'TV Series List'**
  String get tvSeriesList;

  /// No description provided for @guessYouWantToSearch.
  ///
  /// In en, this message translates to:
  /// **'Guess you want to search'**
  String get guessYouWantToSearch;

  /// No description provided for @changeBatch.
  ///
  /// In en, this message translates to:
  /// **'Change batch'**
  String get changeBatch;

  /// No description provided for @hotListScrollingComplete.
  ///
  /// In en, this message translates to:
  /// **'Hot list scrolling complete'**
  String get hotListScrollingComplete;

  /// No description provided for @viewFullList.
  ///
  /// In en, this message translates to:
  /// **'View Full List'**
  String get viewFullList;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @friends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get friends;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @radarAddFriends.
  ///
  /// In en, this message translates to:
  /// **'Friend Radar'**
  String get radarAddFriends;

  /// No description provided for @addNearbyFriends.
  ///
  /// In en, this message translates to:
  /// **'Add nearby friends'**
  String get addNearbyFriends;

  /// No description provided for @faceToFaceGroup.
  ///
  /// In en, this message translates to:
  /// **'Face-to-Face Group'**
  String get faceToFaceGroup;

  /// No description provided for @joinGroupWithNearbyFriends.
  ///
  /// In en, this message translates to:
  /// **'Join the same group chat with friends nearby'**
  String get joinGroupWithNearbyFriends;

  /// No description provided for @scanQRCode.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code Business Card'**
  String get scanQRCode;

  /// No description provided for @phoneContacts.
  ///
  /// In en, this message translates to:
  /// **'Phone Contacts'**
  String get phoneContacts;

  /// No description provided for @addOrInviteContacts.
  ///
  /// In en, this message translates to:
  /// **'Add or invite friends from your phone contacts'**
  String get addOrInviteContacts;

  /// No description provided for @getMoreInfoAndServices.
  ///
  /// In en, this message translates to:
  /// **'Get more information and services'**
  String get getMoreInfoAndServices;

  /// No description provided for @profileSettings.
  ///
  /// In en, this message translates to:
  /// **'Profile Settings'**
  String get profileSettings;

  /// No description provided for @setRemarkAndTags.
  ///
  /// In en, this message translates to:
  /// **'Set Remark and Tags'**
  String get setRemarkAndTags;

  /// No description provided for @recommendToFriend.
  ///
  /// In en, this message translates to:
  /// **'Recommend to a friend'**
  String get recommendToFriend;

  /// No description provided for @setAsStarFriend.
  ///
  /// In en, this message translates to:
  /// **'Set as Starred Friend'**
  String get setAsStarFriend;

  /// No description provided for @addToBlocklist.
  ///
  /// In en, this message translates to:
  /// **'Add to Blocklist'**
  String get addToBlocklist;

  /// No description provided for @complain.
  ///
  /// In en, this message translates to:
  /// **'Complain'**
  String get complain;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @remark.
  ///
  /// In en, this message translates to:
  /// **'Remark'**
  String get remark;

  /// Displays the number of group chats
  ///
  /// In en, this message translates to:
  /// **'{count} group chats}'**
  String groupChatCount(int count);

  /// No description provided for @remarkName.
  ///
  /// In en, this message translates to:
  /// **'Remark Name'**
  String get remarkName;

  /// Displays the contact's remark name from the phone book
  ///
  /// In en, this message translates to:
  /// **'Their name in your phone contacts is \'{contactName}\''**
  String info_name_in_phone_contacts(String contactName);

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @relation_classmate_or_friend.
  ///
  /// In en, this message translates to:
  /// **'Classmate, Friend'**
  String get relation_classmate_or_friend;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @ourMutualGroups.
  ///
  /// In en, this message translates to:
  /// **'Our Mutual Groups'**
  String get ourMutualGroups;

  /// No description provided for @signature.
  ///
  /// In en, this message translates to:
  /// **'Signature'**
  String get signature;

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;

  /// Source: Added via a specific group chat
  ///
  /// In en, this message translates to:
  /// **'Added from group chat \'{groupName}\''**
  String source_added_from_group_chat(String groupName);

  /// A generic unit for a number of people
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 person} other{{count} people}}'**
  String personCount(int count);

  /// Displays time in a compact month-day hour:minute format
  ///
  /// In en, this message translates to:
  /// **'{timestamp}'**
  String monthDayTimeShort(DateTime timestamp);

  /// Displays time in a month-day AM/PM hour:minute format
  ///
  /// In en, this message translates to:
  /// **'{timestamp}'**
  String monthDayTime(DateTime timestamp);

  /// Displays the account balance with its formatted amount
  ///
  /// In en, this message translates to:
  /// **'Balance: {balance}'**
  String balanceDisplay(double balance);

  /// No description provided for @fromGroupChat.
  ///
  /// In en, this message translates to:
  /// **'From group chat'**
  String get fromGroupChat;

  /// No description provided for @addedTime.
  ///
  /// In en, this message translates to:
  /// **'Time Added'**
  String get addedTime;

  /// No description provided for @chatMessages.
  ///
  /// In en, this message translates to:
  /// **'Chat Messages'**
  String get chatMessages;

  /// No description provided for @findChatHistory.
  ///
  /// In en, this message translates to:
  /// **'Find Chat History'**
  String get findChatHistory;

  /// No description provided for @muteNotifications.
  ///
  /// In en, this message translates to:
  /// **'Mute Notifications'**
  String get muteNotifications;

  /// No description provided for @pinToTop.
  ///
  /// In en, this message translates to:
  /// **'Pin to Top'**
  String get pinToTop;

  /// No description provided for @alert.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get alert;

  /// No description provided for @setChatBackground.
  ///
  /// In en, this message translates to:
  /// **'Set Chat Background'**
  String get setChatBackground;

  /// No description provided for @clearChatHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear Chat History'**
  String get clearChatHistory;

  /// No description provided for @oneMinuteAgo.
  ///
  /// In en, this message translates to:
  /// **'One minute ago'**
  String get oneMinuteAgo;

  /// No description provided for @changeCover.
  ///
  /// In en, this message translates to:
  /// **'Change Cover'**
  String get changeCover;

  /// No description provided for @waitingForAcceptance.
  ///
  /// In en, this message translates to:
  /// **'Waiting for acceptance'**
  String get waitingForAcceptance;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @changeAlbumCover.
  ///
  /// In en, this message translates to:
  /// **'Change Album Cover'**
  String get changeAlbumCover;

  /// No description provided for @selectFromPhoneAlbum.
  ///
  /// In en, this message translates to:
  /// **'Select from Phone Album'**
  String get selectFromPhoneAlbum;

  /// No description provided for @selectFromChannels.
  ///
  /// In en, this message translates to:
  /// **'Select from Channels'**
  String get selectFromChannels;

  /// No description provided for @takeOne.
  ///
  /// In en, this message translates to:
  /// **'Take a Photo/Video'**
  String get takeOne;

  /// No description provided for @photographerWorks.
  ///
  /// In en, this message translates to:
  /// **'Photographer\'s Works'**
  String get photographerWorks;

  /// No description provided for @ourMutualGroupChats.
  ///
  /// In en, this message translates to:
  /// **'Our Mutual Group Chats'**
  String get ourMutualGroupChats;

  /// No description provided for @personalSignature.
  ///
  /// In en, this message translates to:
  /// **'Personal Signature'**
  String get personalSignature;

  /// No description provided for @setFriendPermissions.
  ///
  /// In en, this message translates to:
  /// **'Set Friend Permissions'**
  String get setFriendPermissions;

  /// No description provided for @privacyRestrictionFull.
  ///
  /// In en, this message translates to:
  /// **'They cannot see your Moments, Status, WeRun, etc.'**
  String get privacyRestrictionFull;

  /// No description provided for @featureListChatMomentsWeRun.
  ///
  /// In en, this message translates to:
  /// **'Chat, Moments, WeRun, etc.'**
  String get featureListChatMomentsWeRun;

  /// No description provided for @chatOnly.
  ///
  /// In en, this message translates to:
  /// **'Chat Only'**
  String get chatOnly;

  /// No description provided for @momentsAndStatus.
  ///
  /// In en, this message translates to:
  /// **'Moments and Status'**
  String get momentsAndStatus;

  /// No description provided for @hideMyPosts.
  ///
  /// In en, this message translates to:
  /// **'Hide My Posts'**
  String get hideMyPosts;

  /// No description provided for @hideTheirPosts.
  ///
  /// In en, this message translates to:
  /// **'Hide Their Posts'**
  String get hideTheirPosts;

  /// No description provided for @addFromAllTags.
  ///
  /// In en, this message translates to:
  /// **'Add from All Tags'**
  String get addFromAllTags;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @createOrSearchTags.
  ///
  /// In en, this message translates to:
  /// **'Create or Search Tags'**
  String get createOrSearchTags;

  /// No description provided for @allTags.
  ///
  /// In en, this message translates to:
  /// **'All Tags'**
  String get allTags;

  /// No description provided for @newTag.
  ///
  /// In en, this message translates to:
  /// **'New Tag'**
  String get newTag;

  /// No description provided for @enterTag.
  ///
  /// In en, this message translates to:
  /// **'Enter Tag'**
  String get enterTag;

  /// No description provided for @create_success_message.
  ///
  /// In en, this message translates to:
  /// **'Created successfully'**
  String get create_success_message;

  /// No description provided for @tagName.
  ///
  /// In en, this message translates to:
  /// **'Tag Name'**
  String get tagName;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @setAliasAndTags.
  ///
  /// In en, this message translates to:
  /// **'Set Alias and Tags'**
  String get setAliasAndTags;

  /// No description provided for @fillIn.
  ///
  /// In en, this message translates to:
  /// **'Fill In'**
  String get fillIn;

  /// No description provided for @addPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Add Phone Number'**
  String get addPhoneNumber;

  /// No description provided for @addImage.
  ///
  /// In en, this message translates to:
  /// **'Add Image'**
  String get addImage;

  /// No description provided for @plusButtonClicked.
  ///
  /// In en, this message translates to:
  /// **'Plus button clicked'**
  String get plusButtonClicked;

  /// No description provided for @groupChatName.
  ///
  /// In en, this message translates to:
  /// **'Group Chat Name'**
  String get groupChatName;

  /// No description provided for @pleaseSpeakEnglish.
  ///
  /// In en, this message translates to:
  /// **'Please speak English'**
  String get pleaseSpeakEnglish;

  /// No description provided for @groupQRCode.
  ///
  /// In en, this message translates to:
  /// **'Group QR Code'**
  String get groupQRCode;

  /// No description provided for @groupAnnouncement.
  ///
  /// In en, this message translates to:
  /// **'Group Announcement'**
  String get groupAnnouncement;

  /// No description provided for @saveToContacts.
  ///
  /// In en, this message translates to:
  /// **'Save to Contacts'**
  String get saveToContacts;

  /// No description provided for @myNicknameInGroup.
  ///
  /// In en, this message translates to:
  /// **'My Nickname in Group'**
  String get myNicknameInGroup;

  /// No description provided for @showGroupMemberNicknames.
  ///
  /// In en, this message translates to:
  /// **'Show Group Member Nicknames'**
  String get showGroupMemberNicknames;

  /// No description provided for @leaveGroup.
  ///
  /// In en, this message translates to:
  /// **'Leave Group'**
  String get leaveGroup;

  /// No description provided for @featureIntroduction.
  ///
  /// In en, this message translates to:
  /// **'Feature Introduction'**
  String get featureIntroduction;

  /// No description provided for @checkNewVersion.
  ///
  /// In en, this message translates to:
  /// **'Check for New Version'**
  String get checkNewVersion;

  /// No description provided for @accountAndSecurity.
  ///
  /// In en, this message translates to:
  /// **'Account & Security'**
  String get accountAndSecurity;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// Text for displaying a nickname with its label
  ///
  /// In en, this message translates to:
  /// **'Nickname: {nickname}'**
  String nicknameDisplay(String nickname);

  /// No description provided for @voiceprint.
  ///
  /// In en, this message translates to:
  /// **'Voiceprint'**
  String get voiceprint;

  /// No description provided for @emergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contacts'**
  String get emergencyContacts;

  /// No description provided for @loggedInDevices.
  ///
  /// In en, this message translates to:
  /// **'Logged-in Devices'**
  String get loggedInDevices;

  /// No description provided for @phoneNumberBindingDescriptionFull.
  ///
  /// In en, this message translates to:
  /// **'A phone number can only be bound to one account. After changing, you can log in to this account with the new phone number. If the phone number is already bound to another account, it will be unbound from the original account after this operation.'**
  String get phoneNumberBindingDescriptionFull;

  /// No description provided for @moreSecuritySettings.
  ///
  /// In en, this message translates to:
  /// **'More Security Settings'**
  String get moreSecuritySettings;

  /// No description provided for @bill.
  ///
  /// In en, this message translates to:
  /// **'Bill'**
  String get bill;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @allBills.
  ///
  /// In en, this message translates to:
  /// **'All Bills'**
  String get allBills;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @selectFilter.
  ///
  /// In en, this message translates to:
  /// **'Select Filter'**
  String get selectFilter;

  /// No description provided for @incomeExpenseType.
  ///
  /// In en, this message translates to:
  /// **'Transaction Type'**
  String get incomeExpenseType;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @groupSplitBill.
  ///
  /// In en, this message translates to:
  /// **'Split Bill'**
  String get groupSplitBill;

  /// No description provided for @qrCodePayment.
  ///
  /// In en, this message translates to:
  /// **'QR Code Payment'**
  String get qrCodePayment;

  /// No description provided for @merchantPayment.
  ///
  /// In en, this message translates to:
  /// **'Merchant Payment'**
  String get merchantPayment;

  /// No description provided for @topUpAndWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Top-up & Withdrawal'**
  String get topUpAndWithdrawal;

  /// No description provided for @creditCardRepayment.
  ///
  /// In en, this message translates to:
  /// **'Credit Card Repayment'**
  String get creditCardRepayment;

  /// No description provided for @withRefund.
  ///
  /// In en, this message translates to:
  /// **'With Refund'**
  String get withRefund;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get enterVerificationCode;

  /// No description provided for @pleaseEnterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter the verification code'**
  String get pleaseEnterVerificationCode;

  /// No description provided for @nextStep.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextStep;

  /// No description provided for @pleaseEnterCorrectVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter the correct verification code'**
  String get pleaseEnterCorrectVerificationCode;

  /// No description provided for @caringMode.
  ///
  /// In en, this message translates to:
  /// **'Caring Mode'**
  String get caringMode;

  /// No description provided for @enable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get enable;

  /// No description provided for @securityVerification.
  ///
  /// In en, this message translates to:
  /// **'Security Verification'**
  String get securityVerification;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enterPassword;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// No description provided for @forgotPasswordClicked.
  ///
  /// In en, this message translates to:
  /// **'Forgot password clicked'**
  String get forgotPasswordClicked;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// Indicates the playback speed of a video or audio
  ///
  /// In en, this message translates to:
  /// **'{speed}x Speed'**
  String playbackSpeed(num speed);

  /// No description provided for @balanceDetails.
  ///
  /// In en, this message translates to:
  /// **'Balance Details'**
  String get balanceDetails;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @useEarpieceToPlayVoice.
  ///
  /// In en, this message translates to:
  /// **'Use earpiece to play voice messages'**
  String get useEarpieceToPlayVoice;

  /// No description provided for @useIndependentSendButton.
  ///
  /// In en, this message translates to:
  /// **'Use separate send button'**
  String get useIndependentSendButton;

  /// No description provided for @chatBackground.
  ///
  /// In en, this message translates to:
  /// **'Chat Background'**
  String get chatBackground;

  /// No description provided for @stickerManagement.
  ///
  /// In en, this message translates to:
  /// **'Sticker Management'**
  String get stickerManagement;

  /// No description provided for @chatHistory.
  ///
  /// In en, this message translates to:
  /// **'Chat History'**
  String get chatHistory;

  /// No description provided for @chatHistoryMigrationBackup.
  ///
  /// In en, this message translates to:
  /// **'Chat History Migration & Backup'**
  String get chatHistoryMigrationBackup;

  /// No description provided for @generalSettings.
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get generalSettings;

  /// No description provided for @interfaceAndDisplay.
  ///
  /// In en, this message translates to:
  /// **'Interface & Display'**
  String get interfaceAndDisplay;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @followSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow System'**
  String get followSystem;

  /// No description provided for @enableLandscapeMode.
  ///
  /// In en, this message translates to:
  /// **'Enable Landscape Mode'**
  String get enableLandscapeMode;

  /// No description provided for @action_enable_nfc.
  ///
  /// In en, this message translates to:
  /// **'Enable NFC'**
  String get action_enable_nfc;

  /// No description provided for @network_option_wifi_only.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi Only'**
  String get network_option_wifi_only;

  /// No description provided for @multiLanguage.
  ///
  /// In en, this message translates to:
  /// **'Multi-language'**
  String get multiLanguage;

  /// No description provided for @languageSetting.
  ///
  /// In en, this message translates to:
  /// **'Language Setting'**
  String get languageSetting;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @storageSpace.
  ///
  /// In en, this message translates to:
  /// **'Storage Space'**
  String get storageSpace;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;

  /// No description provided for @musicAndAudio.
  ///
  /// In en, this message translates to:
  /// **'Music and Audio'**
  String get musicAndAudio;

  /// No description provided for @discoverPageManagement.
  ///
  /// In en, this message translates to:
  /// **'Discover Page Management'**
  String get discoverPageManagement;

  /// No description provided for @accessibility.
  ///
  /// In en, this message translates to:
  /// **'Accessibility'**
  String get accessibility;

  /// No description provided for @permission_list_items.
  ///
  /// In en, this message translates to:
  /// **'Photos, videos, files, and calls'**
  String get permission_list_items;

  /// No description provided for @deviceDetails.
  ///
  /// In en, this message translates to:
  /// **'Device Details'**
  String get deviceDetails;

  /// No description provided for @deviceName.
  ///
  /// In en, this message translates to:
  /// **'Device Name'**
  String get deviceName;

  /// No description provided for @currentDevice.
  ///
  /// In en, this message translates to:
  /// **'Current Device'**
  String get currentDevice;

  /// No description provided for @deviceType.
  ///
  /// In en, this message translates to:
  /// **'Device Type'**
  String get deviceType;

  /// No description provided for @lastActiveTime.
  ///
  /// In en, this message translates to:
  /// **'Last Active Time'**
  String get lastActiveTime;

  /// No description provided for @deleteThisDevice.
  ///
  /// In en, this message translates to:
  /// **'Delete This Device'**
  String get deleteThisDevice;

  /// No description provided for @learnHowToRecoverPassword.
  ///
  /// In en, this message translates to:
  /// **'Learn how to recover your account password via emergency contacts'**
  String get learnHowToRecoverPassword;

  /// Guidance for users to add emergency contacts, including the minimum number required.
  ///
  /// In en, this message translates to:
  /// **'Select {count} or more friends from your contacts whom you can contact by phone at any time to add as emergency contacts.'**
  String addEmergencyContactsGuidanceFull(int count);

  /// No description provided for @iKnow.
  ///
  /// In en, this message translates to:
  /// **'Got It'**
  String get iKnow;

  /// No description provided for @requireVerificationWhenAdded.
  ///
  /// In en, this message translates to:
  /// **'Require verification when added as a friend'**
  String get requireVerificationWhenAdded;

  /// No description provided for @waysToAddMe.
  ///
  /// In en, this message translates to:
  /// **'Ways to Add Me'**
  String get waysToAddMe;

  /// No description provided for @recommendContactsToMe.
  ///
  /// In en, this message translates to:
  /// **'Recommend contacts to me'**
  String get recommendContactsToMe;

  /// No description provided for @manageLoginDevicesDescriptionFull.
  ///
  /// In en, this message translates to:
  /// **'Your account has been logged in on the following devices. You can remove a device, after which security verification will be required to log in on that device again.'**
  String get manageLoginDevicesDescriptionFull;

  /// No description provided for @contactsBlocklist.
  ///
  /// In en, this message translates to:
  /// **'Contacts Blocklist'**
  String get contactsBlocklist;

  /// No description provided for @yourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Your Phone Number'**
  String get yourPhoneNumber;

  /// No description provided for @currentlyLoggedInDevices.
  ///
  /// In en, this message translates to:
  /// **'Currently Logged-in Devices'**
  String get currentlyLoggedInDevices;

  /// No description provided for @loggedOutDevices.
  ///
  /// In en, this message translates to:
  /// **'Logged-out Devices'**
  String get loggedOutDevices;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @notBound.
  ///
  /// In en, this message translates to:
  /// **'Not Bound'**
  String get notBound;

  /// No description provided for @mobileSecurityProtection.
  ///
  /// In en, this message translates to:
  /// **'Mobile Security Protection'**
  String get mobileSecurityProtection;

  /// No description provided for @newMessageNotifications.
  ///
  /// In en, this message translates to:
  /// **'New Message Notifications'**
  String get newMessageNotifications;

  /// No description provided for @notificationToggle.
  ///
  /// In en, this message translates to:
  /// **'Notification Toggle'**
  String get notificationToggle;

  /// No description provided for @receiveNewMessageNotifications.
  ///
  /// In en, this message translates to:
  /// **'Receive new message notifications'**
  String get receiveNewMessageNotifications;

  /// No description provided for @receiveVoiceVideoCallInvites.
  ///
  /// In en, this message translates to:
  /// **'Receive voice and video call invitation alerts'**
  String get receiveVoiceVideoCallInvites;

  /// No description provided for @notificationShowMessageDetails.
  ///
  /// In en, this message translates to:
  /// **'Show message details in notifications'**
  String get notificationShowMessageDetails;

  /// No description provided for @soundAndVibration.
  ///
  /// In en, this message translates to:
  /// **'Sound & Vibration'**
  String get soundAndVibration;

  /// No description provided for @newMessageSystemNotification.
  ///
  /// In en, this message translates to:
  /// **'New Message System Notification'**
  String get newMessageSystemNotification;

  /// No description provided for @goToSystemSettings.
  ///
  /// In en, this message translates to:
  /// **'Go to System Settings'**
  String get goToSystemSettings;

  /// No description provided for @voiceVideoCallAlerts.
  ///
  /// In en, this message translates to:
  /// **'Voice & Video Call Alerts'**
  String get voiceVideoCallAlerts;

  /// No description provided for @alertToneAndRingtone.
  ///
  /// In en, this message translates to:
  /// **'Alert Tone & Ringtone'**
  String get alertToneAndRingtone;

  /// No description provided for @messageTone.
  ///
  /// In en, this message translates to:
  /// **'Message Tone'**
  String get messageTone;

  /// No description provided for @callRingtone.
  ///
  /// In en, this message translates to:
  /// **'Call Ringtone'**
  String get callRingtone;

  /// No description provided for @friendCanHearMyRingtone.
  ///
  /// In en, this message translates to:
  /// **'Friends can hear my ringtone when they call me'**
  String get friendCanHearMyRingtone;

  /// No description provided for @personalInfoAndPermissions.
  ///
  /// In en, this message translates to:
  /// **'Personal Info & Permissions'**
  String get personalInfoAndPermissions;

  /// No description provided for @systemPermissionManagement.
  ///
  /// In en, this message translates to:
  /// **'System Permission Management'**
  String get systemPermissionManagement;

  /// No description provided for @authorizationManagement.
  ///
  /// In en, this message translates to:
  /// **'Authorization Management'**
  String get authorizationManagement;

  /// No description provided for @personalizedAdManagement.
  ///
  /// In en, this message translates to:
  /// **'Personalized Ad Management'**
  String get personalizedAdManagement;

  /// No description provided for @browseAndExportPersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Browse & Export Personal Info'**
  String get browseAndExportPersonalInfo;

  /// No description provided for @personalInfoCollectionList.
  ///
  /// In en, this message translates to:
  /// **'Personal Info Collection List'**
  String get personalInfoCollectionList;

  /// No description provided for @basicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic Info'**
  String get basicInfo;

  /// No description provided for @avatar.
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get avatar;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region;

  /// No description provided for @personalSignatureTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Signature'**
  String get personalSignatureTitle;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @deviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Device Info'**
  String get deviceInfo;

  /// No description provided for @userInfoDuringUse.
  ///
  /// In en, this message translates to:
  /// **'User Info During Use'**
  String get userInfoDuringUse;

  /// No description provided for @$cdnBaseAndVideos.
  ///
  /// In en, this message translates to:
  /// **'\$cdnBase & Videos'**
  String get $cdnBaseAndVideos;

  /// No description provided for @socialAndContentInfo.
  ///
  /// In en, this message translates to:
  /// **'Social & Content Info'**
  String get socialAndContentInfo;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @contactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Info'**
  String get contactInfo;

  /// No description provided for @viewPhoneContacts.
  ///
  /// In en, this message translates to:
  /// **'View Phone Contacts'**
  String get viewPhoneContacts;

  /// No description provided for @hide.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get hide;

  /// No description provided for @show.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get show;

  /// No description provided for @phoneBoundAndDiscoverPrompt.
  ///
  /// In en, this message translates to:
  /// **'Phone number is bound. Tap the button below to see which friends in your phone contacts have registered an account.'**
  String get phoneBoundAndDiscoverPrompt;

  /// The label for a button to add a new status, used in Moments or on the profile page
  ///
  /// In en, this message translates to:
  /// **'+ Status'**
  String get addStatus;

  /// No description provided for @boundPhoneNumberDisplay.
  ///
  /// In en, this message translates to:
  /// **'Bound Phone: '**
  String get boundPhoneNumberDisplay;

  /// No description provided for @changePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Change Phone Number'**
  String get changePhoneNumber;

  /// No description provided for @setPassword.
  ///
  /// In en, this message translates to:
  /// **'Set Password'**
  String get setPassword;

  /// No description provided for @originalPassword.
  ///
  /// In en, this message translates to:
  /// **'Original Password'**
  String get originalPassword;

  /// No description provided for @enterOriginalPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter original password'**
  String get enterOriginalPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get enterNewPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @enterToConfirm.
  ///
  /// In en, this message translates to:
  /// **'Enter again to confirm'**
  String get enterToConfirm;

  /// No description provided for @accountAndSecurityTitle.
  ///
  /// In en, this message translates to:
  /// **'Account & Security'**
  String get accountAndSecurityTitle;

  /// No description provided for @youthMode.
  ///
  /// In en, this message translates to:
  /// **'Youth Mode'**
  String get youthMode;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @thirdPartyInfoSharingList.
  ///
  /// In en, this message translates to:
  /// **'Third-Party Info Sharing List'**
  String get thirdPartyInfoSharingList;

  /// No description provided for @plugins.
  ///
  /// In en, this message translates to:
  /// **'Plugins'**
  String get plugins;

  /// No description provided for @helpAndFeedback.
  ///
  /// In en, this message translates to:
  /// **'Help & Feedback'**
  String get helpAndFeedback;

  /// No description provided for @switchAccount.
  ///
  /// In en, this message translates to:
  /// **'Switch Account'**
  String get switchAccount;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @resetAndRemove.
  ///
  /// In en, this message translates to:
  /// **'Reset & Remove'**
  String get resetAndRemove;

  /// No description provided for @tryToVerifyMyVoice.
  ///
  /// In en, this message translates to:
  /// **'Try to verify my voice'**
  String get tryToVerifyMyVoice;

  /// No description provided for @iHaveReadAndAgree.
  ///
  /// In en, this message translates to:
  /// **'I have read and agree'**
  String get iHaveReadAndAgree;

  /// No description provided for @verifyPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Verify Phone Number'**
  String get verifyPhoneNumber;

  /// No description provided for @mainlandChina.
  ///
  /// In en, this message translates to:
  /// **'Mainland China'**
  String get mainlandChina;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @paymentCode.
  ///
  /// In en, this message translates to:
  /// **'Payment Code'**
  String get paymentCode;

  /// No description provided for @prioritizeBalancePayment.
  ///
  /// In en, this message translates to:
  /// **'Prioritize payment with Balance'**
  String get prioritizeBalancePayment;

  /// Displays the creation time with its formatted date
  ///
  /// In en, this message translates to:
  /// **'Created: {date}'**
  String creationTimeDisplay(DateTime date);

  /// No description provided for @tagExistsError.
  ///
  /// In en, this message translates to:
  /// **'Tag Exists Error'**
  String get tagExistsError;

  /// No description provided for @priorityPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Priority Payment Method'**
  String get priorityPaymentMethod;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @digitalRMBPayment.
  ///
  /// In en, this message translates to:
  /// **'Digital RMB Payment'**
  String get digitalRMBPayment;

  /// No description provided for @qrCodeCollection.
  ///
  /// In en, this message translates to:
  /// **'QR Code Collection'**
  String get qrCodeCollection;

  /// No description provided for @rewardCode.
  ///
  /// In en, this message translates to:
  /// **'Reward Code'**
  String get rewardCode;

  /// No description provided for @faceToFaceRedPacket.
  ///
  /// In en, this message translates to:
  /// **'Face-to-Face Red Packet'**
  String get faceToFaceRedPacket;

  /// No description provided for @transferToBankCardOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Transfer to Bank Card or Phone Number'**
  String get transferToBankCardOrPhone;

  /// No description provided for @myBalance.
  ///
  /// In en, this message translates to:
  /// **'My Balance'**
  String get myBalance;

  /// No description provided for @topUp.
  ///
  /// In en, this message translates to:
  /// **'Top-up'**
  String get topUp;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @accountUpgradeService.
  ///
  /// In en, this message translates to:
  /// **'Account Upgrade Service'**
  String get accountUpgradeService;

  /// No description provided for @cta_transfer_to_balance_plus_single_line.
  ///
  /// In en, this message translates to:
  /// **'Transfer to Balance+, earn and spend >'**
  String get cta_transfer_to_balance_plus_single_line;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @financialServices.
  ///
  /// In en, this message translates to:
  /// **'Financial Services'**
  String get financialServices;

  /// No description provided for @insuranceService.
  ///
  /// In en, this message translates to:
  /// **'Insurance Service'**
  String get insuranceService;

  /// No description provided for @lifeServices.
  ///
  /// In en, this message translates to:
  /// **'Life Services'**
  String get lifeServices;

  /// No description provided for @mobileTopUp.
  ///
  /// In en, this message translates to:
  /// **'Mobile Top-up'**
  String get mobileTopUp;

  /// No description provided for @utilityPayments.
  ///
  /// In en, this message translates to:
  /// **'Utility Payments'**
  String get utilityPayments;

  /// No description provided for @cityServices.
  ///
  /// In en, this message translates to:
  /// **'City Services'**
  String get cityServices;

  /// No description provided for @healthCare.
  ///
  /// In en, this message translates to:
  /// **'Health Care'**
  String get healthCare;

  /// No description provided for @transportServices.
  ///
  /// In en, this message translates to:
  /// **'Transport Services'**
  String get transportServices;

  /// No description provided for @trainAndFlightTickets.
  ///
  /// In en, this message translates to:
  /// **'Train & Flight Tickets'**
  String get trainAndFlightTickets;

  /// No description provided for @hotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get hotel;

  /// No description provided for @shoppingAndConsumption.
  ///
  /// In en, this message translates to:
  /// **'Shopping & Consumption'**
  String get shoppingAndConsumption;

  /// No description provided for @brandDiscovery.
  ///
  /// In en, this message translates to:
  /// **'Brand Discovery'**
  String get brandDiscovery;

  /// No description provided for @movieTicketsAndEntertainment.
  ///
  /// In en, this message translates to:
  /// **'Movies, Tickets & Entertainment'**
  String get movieTicketsAndEntertainment;

  /// No description provided for @serviceManagement.
  ///
  /// In en, this message translates to:
  /// **'Service Management'**
  String get serviceManagement;

  /// No description provided for @hotelAndBAndB.
  ///
  /// In en, this message translates to:
  /// **'Hotel & B&B'**
  String get hotelAndBAndB;

  /// No description provided for @clickStatus.
  ///
  /// In en, this message translates to:
  /// **'Click Status'**
  String get clickStatus;

  /// Suffix for lists showing 'and N more friends'
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{and 1 other friend} other{and {count} other friends}}'**
  String andXMoreFriends(int count);

  /// No description provided for @storeOrdersAndCardPack.
  ///
  /// In en, this message translates to:
  /// **'Store Orders & Card Pack'**
  String get storeOrdersAndCardPack;

  /// No description provided for @stickers.
  ///
  /// In en, this message translates to:
  /// **'Stickers'**
  String get stickers;

  /// No description provided for @searchHistory.
  ///
  /// In en, this message translates to:
  /// **'Search History'**
  String get searchHistory;

  /// No description provided for @themeSetting.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeSetting;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @guangdongGuangzhou.
  ///
  /// In en, this message translates to:
  /// **'Guangdong, Guangzhou'**
  String get guangdongGuangzhou;

  /// No description provided for @registrationTime.
  ///
  /// In en, this message translates to:
  /// **'Registration Time'**
  String get registrationTime;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get personalInfo;

  /// No description provided for @nickName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nickName;

  /// No description provided for @pat.
  ///
  /// In en, this message translates to:
  /// **'Pat'**
  String get pat;

  /// No description provided for @qrCodeCard.
  ///
  /// In en, this message translates to:
  /// **'QR Code Card'**
  String get qrCodeCard;

  /// No description provided for @myAddresses.
  ///
  /// In en, this message translates to:
  /// **'My Addresses'**
  String get myAddresses;

  /// No description provided for @myInvoiceTitles.
  ///
  /// In en, this message translates to:
  /// **'My Invoice Titles'**
  String get myInvoiceTitles;

  /// No description provided for @balancePlus.
  ///
  /// In en, this message translates to:
  /// **'Balance+'**
  String get balancePlus;

  /// No description provided for @bankCards.
  ///
  /// In en, this message translates to:
  /// **'Bank Cards'**
  String get bankCards;

  /// No description provided for @familyCard.
  ///
  /// In en, this message translates to:
  /// **'Family Card'**
  String get familyCard;

  /// No description provided for @paymentScore.
  ///
  /// In en, this message translates to:
  /// **'Payment Score'**
  String get paymentScore;

  /// No description provided for @consumerProtection.
  ///
  /// In en, this message translates to:
  /// **'Consumer Protection'**
  String get consumerProtection;

  /// No description provided for @taskCompleted.
  ///
  /// In en, this message translates to:
  /// **'Task Completed'**
  String get taskCompleted;

  /// No description provided for @cancelDelayedTask.
  ///
  /// In en, this message translates to:
  /// **'Cancel Delayed Task'**
  String get cancelDelayedTask;

  /// No description provided for @startGroupChat.
  ///
  /// In en, this message translates to:
  /// **'Start a Group Chat'**
  String get startGroupChat;

  /// Label for displaying a yield rate
  ///
  /// In en, this message translates to:
  /// **'Yield: {value}'**
  String label_yield(String value);

  /// Formats year and month
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String yearAndMonth(DateTime date);

  /// No description provided for @recommendContactsMessageFull.
  ///
  /// In en, this message translates to:
  /// **'When enabled, phone contacts who have registered an account will be recommended to you in \'Contacts > New Friends\'.'**
  String get recommendContactsMessageFull;

  /// No description provided for @sendButtonReplacedMessageFull.
  ///
  /// In en, this message translates to:
  /// **'When enabled, the send button on the keyboard will be replaced with a newline button.'**
  String get sendButtonReplacedMessageFull;

  /// No description provided for @manageServicesDescription.
  ///
  /// In en, this message translates to:
  /// **'You can specify which services appear in \'Services\'. If you disable a service, its entry point will be hidden, but no historical data will be cleared.'**
  String get manageServicesDescription;

  /// No description provided for @transactionType.
  ///
  /// In en, this message translates to:
  /// **'Transaction Type'**
  String get transactionType;

  /// No description provided for @transportation.
  ///
  /// In en, this message translates to:
  /// **'Transportation'**
  String get transportation;

  /// No description provided for @careModeIntro.
  ///
  /// In en, this message translates to:
  /// **'After enabling \'Caring Mode\', you can select the following features:'**
  String get careModeIntro;

  /// No description provided for @careModeFeatureAccessibility.
  ///
  /// In en, this message translates to:
  /// **'· Larger text, stronger colors, bigger buttons;'**
  String get careModeFeatureAccessibility;

  /// No description provided for @careModeFeatureReadMessages.
  ///
  /// In en, this message translates to:
  /// **'· Listen to text messages in chats;'**
  String get careModeFeatureReadMessages;

  /// No description provided for @careModeFeatureQuietMode.
  ///
  /// In en, this message translates to:
  /// **'· Quiet mode to avoid audio playback disturbances.'**
  String get careModeFeatureQuietMode;

  /// Validation message for the password format
  ///
  /// In en, this message translates to:
  /// **'Password must be {minLength}-{maxLength} characters, combining letters, numbers, and symbols (cannot be purely numeric).'**
  String passwordValidationRule(int minLength, int maxLength);

  /// No description provided for @forgotOriginalPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot original password?'**
  String get forgotOriginalPassword;

  /// No description provided for @privacyPolicySummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'《Privacy Policy Summary》'**
  String get privacyPolicySummaryTitle;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'《Privacy Policy》'**
  String get privacyPolicyTitle;

  /// No description provided for @releaseToCancel.
  ///
  /// In en, this message translates to:
  /// **'Release to Cancel'**
  String get releaseToCancel;

  /// No description provided for @holdToTalk.
  ///
  /// In en, this message translates to:
  /// **'Hold to Talk'**
  String get holdToTalk;

  /// Displays the number of tags
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 tag} other{{count} tags}}'**
  String tagCount(int count);

  /// Displays the number of mutual groups
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 group} other{{count} groups}}'**
  String groupCount(int count);

  /// Text for displaying the number of friends
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 friend} other{{count} friends}}'**
  String friendCount(int count);

  /// No description provided for @noTransactionRating.
  ///
  /// In en, this message translates to:
  /// **'No transaction rating yet'**
  String get noTransactionRating;

  /// Displays the number of reviews
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 review} other{{count} reviews}}'**
  String commentCount(int count);

  /// Displays a featured review and its content
  ///
  /// In en, this message translates to:
  /// **'Featured Review: {comment}'**
  String featuredCommentDisplay(String comment);

  /// No description provided for @scanHintFull.
  ///
  /// In en, this message translates to:
  /// **'Identify QR codes / flowers / animals / products, etc.'**
  String get scanHintFull;

  /// No description provided for @securityGuidanceFull.
  ///
  /// In en, this message translates to:
  /// **'If you encounter issues like a hacked account or inability to log in, you can go to the Security Center.'**
  String get securityGuidanceFull;

  /// No description provided for @shortVideos.
  ///
  /// In en, this message translates to:
  /// **'Short Videos'**
  String get shortVideos;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
