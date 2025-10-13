import 'package:flutter/material.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_alphabet.dart';
import 'package:vigaviga/widgets/ljn_add_button.dart';
import 'package:vigaviga/widgets/ljn_custom_physics.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/widgets/ljn_text_spans.dart';

class LJNPhoneContactPage extends StatefulWidget {
  const LJNPhoneContactPage({super.key});

  @override
  State<LJNPhoneContactPage> createState() => _LJNPhoneContactPage();
}

class _LJNPhoneContactPage extends State<LJNPhoneContactPage> {
  late final List<Widget> chatItems;
  // ScrollPhysics _physics = const MyBouncingScrollPhysics();
  // final _customScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    chatItems = [
      ContactListItem(
        friendName: "熊丽丽",
        underline: true,
        message: "Vigaviga:fastgrowing",
        avatar: "images/avatar/chat_1.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "花重月数花重月数花重月数花重月数花重月数花重月数花重月数花重月数花重月数花重月数",
            'icon': "images/avatar/chat_1.jpg",
          });
          logger.info('花重月数被点击~');
        },
      ),
      ContactListItem(
        friendName: "李伯侨",
        underline: true,
        message: "Vigaviga:unanticipated",
        avatar: "images/avatar/chat_4.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "邓子乔",
            'icon': "images/avatar/chat_4.jpg",
          });
          logger.info('绿逾初夏被点击~');
        },
      ),
      LJNAlphabet(title: "A"),
      ContactListItem(
        friendName: "刘航平",
        underline: true,
        message: "Vigaviga:extracurricular",
        avatar: "images/avatar/chat_5.jpg",
        alreadyFriends: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "余笙南吟",
            'icon': "images/avatar/chat_5.jpg",
          });
          logger.info('余笙南吟被点击~');
        },
      ),
      ContactListItem(
        friendName: "叶招娣",
        underline: true,
        message: "Vigaviga:nonpolitical",
        avatar: "images/avatar/chat_6.jpg",
        alreadyFriends: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "陈情匿旧酒",
            'icon': "images/avatar/chat_6.jpg",
          });
          logger.info('陈情匿旧酒被点击~');
        },
      ),
      ContactListItem(
        friendName: "赵炬",
        underline: true,
        message: "Vigaviga:accursed",
        avatar: "images/avatar/chat_7.jpg",
        alreadyFriends: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "白桃乌龙",
            'icon': "images/avatar/chat_7.jpg",
          });
          logger.info('白桃乌龙被点击~');
        },
      ),
      ContactListItem(
        friendName: "张如强",
        underline: true,
        message: "Vigaviga:undistinguished",
        avatar: "images/avatar/chat_8.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "清浅ˋ旧时光",
            'icon': "images/avatar/chat_8.jpg",
          });
          logger.info('清浅ˋ旧时光被点击~');
        },
      ),
      ContactListItem(
        friendName: "易卫清",
        underline: true,
        message: "Vigaviga:burdensome",
        avatar: "images/avatar/chat_9.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "荒碎梦残",
            'icon': "images/avatar/chat_9.jpg",
          });
          logger.info('荒碎梦残被点击~');
        },
      ),
      ContactListItem(
        friendName: "张金芬",
        underline: true,
        message: "Vigaviga:brawnyundefined",
        avatar: "images/avatar/chat_10.jpg",
        alreadyFriends: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "无梦相赠",
            'icon': "images/avatar/chat_10.jpg",
          });
          logger.info('无梦相赠被点击~');
        },
      ),
      LJNAlphabet(title: "B"),
      ContactListItem(
        friendName: "张观福",
        underline: true,
        message: "Vigaviga:mashed",
        avatar: "images/avatar/chat_11.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "离人泪",
            'icon': "images/avatar/chat_11.jpg",
          });
          logger.info('离人泪被点击~');
        },
      ),
      ContactListItem(
        friendName: "窦红莉",
        underline: true,
        message: "Vigaviga:nutty",
        avatar: "images/avatar/chat_12.jpg",
        alreadyFriends: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "伊人在水一方",
            'icon': "images/avatar/chat_12.jpg",
          });
          logger.info('伊人在水一方被点击~');
        },
      ),
      ContactListItem(
        friendName: "周剑桥",
        underline: true,
        message: "Vigaviga:acrimonious",
        avatar: "images/avatar/chat_13.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "与我共梦",
            'icon': "images/avatar/chat_13.jpg",
          });
          logger.info('与我共梦被点击~');
        },
      ),
      ContactListItem(
        friendName: "尹洪友",
        underline: true,
        message: "Vigaviga:substandard",
        avatar: "images/avatar/chat_14.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "挽弦暮笙",
            'icon': "images/avatar/chat_14.jpg",
          });
          logger.info('挽弦暮笙被点击~');
        },
      ),
      ContactListItem(
        friendName: "周桑",
        underline: true,
        message: "Vigaviga:receiving",
        avatar: "images/avatar/chat_15.jpg",
        alreadyFriends: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "开始厌倦",
            'icon': "images/avatar/chat_15.jpg",
          });
          logger.info('开始厌倦被点击~');
        },
      ),
      ContactListItem(
        friendName: "李程",
        underline: true,
        message: "Vigaviga:selfindulgent",
        avatar: "images/avatar/chat_16.jpg",
        alreadyFriends: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "仙女收纳盒",
            'icon': "images/avatar/chat_16.jpg",
          });
          logger.info('仙女收纳盒被点击~');
        },
      ),
      ContactListItem(
        friendName: "王庆营",
        underline: true,
        message: "Vigaviga:extraneous",
        avatar: "images/avatar/chat_17.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "華燈初上",
            'icon': "images/avatar/chat_17.jpg",
          });
          logger.info('華燈初上被点击~');
        },
      ),
      LJNAlphabet(title: "C"),
      ContactListItem(
        friendName: "朱金照",
        underline: true,
        message: "Vigaviga:inexhaustible",
        avatar: "images/avatar/chat_18.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "袖手今生",
            'icon': "images/avatar/chat_18.jpg",
          });
          logger.info('袖手今生被点击~');
        },
      ),
      ContactListItem(
        friendName: "周秀全",
        underline: true,
        message: "Vigaviga:kneeling",
        avatar: "images/avatar/chat_19.jpg",
        alreadyFriends: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "ら道不清的忧伤",
            'icon': "images/avatar/chat_19.jpg",
          });
          logger.info('ら道不清的忧伤被点击~');
        },
      ),
      ContactListItem(
        friendName: "朱景龙",
        underline: true,
        message: "Vigaviga:indefatigable",
        avatar: "images/avatar/chat_20.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "凉生",
            'icon': "images/avatar/chat_20.jpg",
          });
          logger.info('凉生被点击~');
        },
      ),
      ContactListItem(
        friendName: "俞金金",
        underline: true,
        message: "Vigaviga:appellate",
        avatar: "images/avatar/chat_21.jpg",
        alreadyFriends: true,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "墨香九歌",
            'icon': "images/avatar/chat_21.jpg",
          });
          logger.info('墨香九歌被点击~');
        },
      ),
      LJNAlphabet(title: "D"),
      ContactListItem(
        friendName: "赵美静",
        underline: true,
        message: "Vigaviga:wellintentioned",
        avatar: "images/avatar/chat_22.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "暖栀",
            'icon': "images/avatar/chat_22.jpg",
          });
          logger.info('暖栀被点击~');
        },
      ),
      ContactListItem(
        friendName: "张莉青",
        underline: true,
        message: "Vigaviga:abused",
        avatar: "images/avatar/chat_23.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "等待许了苍老",
            'icon': "images/avatar/chat_23.jpg",
          });
          logger.info('等待许了苍老被点击~');
        },
      ),
      ContactListItem(
        friendName: "郭文才",
        underline: true,
        message: "Vigaviga:illadvised",
        avatar: "images/avatar/chat_24.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "笙歌白云",
            'icon': "images/avatar/chat_24.jpg",
          });
          logger.info('笙歌白云被点击~');
        },
      ),
      ContactListItem(
        friendName: "余光勇",
        underline: true,
        message: "Vigaviga:unsettling",
        avatar: "images/avatar/chat_25.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "万幸得以相识",
            'icon': "images/avatar/chat_25.jpg",
          });
          logger.info('万幸得以相识被点击~');
        },
      ),
      ContactListItem(
        friendName: "张礼中",
        underline: true,
        message: "Vigaviga:inactive",
        avatar: "images/avatar/chat_26.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "凤鸣寂寥",
            'icon': "images/avatar/chat_26.jpg",
          });
          logger.info('凤鸣寂寥被点击~');
        },
      ),
      ContactListItem(
        friendName: "伊静",
        underline: true,
        message: "Vigaviga:packaged",
        avatar: "images/avatar/chat_27.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "余生不过一盏茶",
            'icon': "images/avatar/chat_27.jpg",
          });
          logger.info('余生不过一盏茶被点击~');
        },
      ),
      ContactListItem(
        friendName: "智涛",
        underline: true,
        message: "Vigaviga:fussy",
        avatar: "images/avatar/chat_28.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "丢了梦想的猎手",
            'icon': "images/avatar/chat_28.jpg",
          });
          logger.info('丢了梦想的猎手被点击~');
        },
      ),
      ContactListItem(
        friendName: "邹纪平",
        underline: true,
        message: "Vigaviga:ineffable",
        avatar: "images/avatar/chat_29.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "今朝有酒今朝醉",
            'icon': "images/avatar/chat_29.jpg",
          });
          logger.info('今朝有酒今朝醉被点击~');
        },
      ),
      LJNAlphabet(title: "E"),
      ContactListItem(
        friendName: "马自学",
        underline: false,
        message: "Vigaviga:reigning",
        avatar: "images/avatar/chat_30.jpg",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "旧事酒浓",
            'icon': "images/avatar/chat_30.jpg",
          });
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return Scaffold(
        primary: false,
        appBar: LJNAppBar(
          title: l10n.viewPhoneContacts,
        ),
        body: ScrollConfiguration(
          behavior: CustomScrollBehavior().copyWith(
            scrollbars: false,
            physics: const BouncingScrollPhysics(),
          ),
          child: ColoredBox(
            color: AppColors.neutralGrey12,
            child: ListView.builder(
              primary: false,
              padding: EdgeInsets.only(bottom: 106.w),
              // padding: EdgeInsets.all(0.w),
              itemCount: chatItems.length,
              shrinkWrap: true,
              // controller: _customScrollController,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return chatItems[index];
              },
            ),
          ),
        ),
      );
    });
  }
}

class ContactListItem extends StatefulWidget {
  final String avatar;
  final String friendName;
  final String message;
  final bool alreadyFriends;
  final bool underline;

  final Function()? onPressed;

  const ContactListItem({
    super.key,
    required this.avatar,
    required this.friendName,
    required this.message,
    required this.underline,
    required this.alreadyFriends,
    this.onPressed,
  });

  @override
  State<ContactListItem> createState() => _ContactListItem();
}

class _ContactListItem extends State<ContactListItem> {
  // Color containerColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;
    Color containerColor = theme.colorScheme.surface;

    return Container(
      color: containerColor,
      height: 135.0.w,
      padding: const EdgeInsets.only(left: 30.0).w,
      child: Row(
        children: [
          // 头像
          ClipRRect(
            borderRadius: BorderRadius.circular(8).w,
            child: Image.asset(
              assetPath(widget.avatar),
              cacheWidth: 180.w.toInt(),
              cacheHeight: 180.w.toInt(),
              width: 90.w,
              height: 90.w,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 23.w),

          // 右边区域
          Expanded(
            child: Container(
              // alignment: Alignment.center,
              decoration: BoxDecoration(
                // color: AppColors.accentRedPure,
                border: Border(
                  bottom: widget.underline
                      ? (theme.listTileTheme.shape as RoundedRectangleBorder)
                          .side
                      : BorderSide.none,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 8.w,
                        ),

                        // 好友名称和消息时间
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 好友名称
                            Expanded(
                              child: LJNTextSpans(
                                text: widget.friendName,
                                strutStyle: StrutStyle(
                                  height: 1,
                                  forceStrutHeight: true,
                                  fontSize: 32.w,
                                ),
                                style: TextStyle(
                                  height: 1.08,
                                  fontSize: fontSizeScale(32.0.w),
                                  color: theme.colorScheme.onSurface,
                                  fontFamily: "AlibabaPuHuiTi",
                                ),
                                emojiStyle: TextStyle(
                                  height: 1.08,
                                  fontSize: fontSizeScale(32.w),
                                  fontFamily: "NotoColorEmoji-Regular",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                          ],
                        ),

                        SizedBox(height: 10.w),

                        // 好友消息
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              // color: Colors.amber,
                              // width: 400.w,
                              // margin: EdgeInsets.only(right: 65.w),
                              child: LJNTextSpans(
                                text: widget.message,
                                style: TextStyle(
                                  height: 1.08,
                                  fontSize: fontSizeScale(25.w),
                                  color: AppColors.neutralGrey45,
                                ),
                                emojiStyle: TextStyle(
                                  height: 1.08,
                                  fontSize: fontSizeScale(25.w),
                                  color: AppColors.neutralGrey45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // 右边按钮
                  if (widget.alreadyFriends)
                    LJNAddButton(
                      title: l10n.add,
                      backgroundColor: AppColors.brandGreenVibrant3,
                    )
                  else
                    LJNAddButton(
                      title: l10n.added,
                      // readonly: true,
                      backgroundColor: Colors.transparent,
                      color: AppColors.neutralDarkGrey3,
                    ),
                  SizedBox(
                    width: 25.w,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
