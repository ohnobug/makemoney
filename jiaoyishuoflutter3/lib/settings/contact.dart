import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/CustomPhysics.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNPhoneContact extends StatefulWidget {
  const LJNPhoneContact({super.key});

  @override
  State<LJNPhoneContact> createState() => _LJNPhoneContact();
}

class _LJNPhoneContact extends State<LJNPhoneContact> {
  double _statusHeight = 0;
  late final List<Widget> chatItems;
  // ScrollPhysics _physics = const MyBouncingScrollPhysics();
  // final _customScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    chatItems = [
      ContactListItem(
        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
        friendName: "熊丽丽",
        underline: true,
        message: "微信:fastgrowing",
        avatar: "images/avatar_webp/chat_1.webp",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "花重月数花重月数花重月数花重月数花重月数花重月数花重月数花重月数花重月数花重月数",
            'icon': "images/avatar_webp/chat_1.webp",
          });
          logger.info('花重月数被点击~');
        },
      ),
      ContactListItem(
          id: "6390e7d0-c8bd-5929-b537-76f6577c591c",
          friendName: "李伯侨",
          underline: true,
          message: "微信:unanticipated",
          avatar: "images/avatar_webp/chat_4.webp",
          alreadyFriends: false,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "邓子乔",
              'icon': "images/avatar_webp/chat_4.webp",
            });
            logger.info('绿逾初夏被点击~');
          }),
      alphabet("A"),
      ContactListItem(
          id: "d87d7c11-04f1-569c-8fd3-de333397966c",
          friendName: "刘航平",
          underline: true,
          message: "微信:extracurricular",
          avatar: "images/avatar_webp/chat_5.webp",
          alreadyFriends: true,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "余笙南吟",
              'icon': "images/avatar_webp/chat_5.webp",
            });
            logger.info('余笙南吟被点击~');
          }),
      ContactListItem(
          id: "7c3f2f89-6eae-5658-bce9-b3d8e20e309c",
          friendName: "叶招娣",
          underline: true,
          message: "微信:nonpolitical",
          avatar: "images/avatar_webp/chat_6.webp",
          alreadyFriends: true,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "陈情匿旧酒",
              'icon': "images/avatar_webp/chat_6.webp",
            });
            logger.info('陈情匿旧酒被点击~');
          }),
      ContactListItem(
          id: "6b4ac788-576a-5a7c-be38-854571564bd1",
          friendName: "赵炬",
          underline: true,
          message: "微信:accursed",
          avatar: "images/avatar_webp/chat_7.webp",
          alreadyFriends: true,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "白桃乌龙",
              'icon': "images/avatar_webp/chat_7.webp",
            });
            logger.info('白桃乌龙被点击~');
          }),
      ContactListItem(
          id: "139bf645-623d-5791-ad6b-4907e5fc8309",
          friendName: "张如强",
          underline: true,
          message: "微信:undistinguished",
          avatar: "images/avatar_webp/chat_8.webp",
          alreadyFriends: false,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "清浅ˋ旧时光",
              'icon': "images/avatar_webp/chat_8.webp",
            });
            logger.info('清浅ˋ旧时光被点击~');
          }),
      ContactListItem(
          id: "35fe74be-e7cb-520e-9d79-1b19b1018249",
          friendName: "易卫清",
          underline: true,
          message: "微信:burdensome",
          avatar: "images/avatar_webp/chat_9.webp",
          alreadyFriends: false,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "荒碎梦残",
              'icon': "images/avatar_webp/chat_9.webp",
            });
            logger.info('荒碎梦残被点击~');
          }),
      ContactListItem(
          id: "18127772-a653-5ca6-ba2c-5b1b855aa236",
          friendName: "张金芬",
          underline: true,
          message: "微信:brawnyundefined",
          avatar: "images/avatar_webp/chat_10.webp",
          alreadyFriends: true,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "无梦相赠",
              'icon': "images/avatar_webp/chat_10.webp",
            });
            logger.info('无梦相赠被点击~');
          }),
      alphabet("B"),
      ContactListItem(
          id: "a41401db-2dde-519d-bc9f-df6e51089c9e",
          friendName: "张观福",
          underline: true,
          message: "微信:mashed",
          avatar: "images/avatar_webp/chat_11.webp",
          alreadyFriends: false,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "离人泪",
              'icon': "images/avatar_webp/chat_11.webp",
            });
            logger.info('离人泪被点击~');
          }),
      ContactListItem(
          id: "335ebb66-9440-5a2e-9795-d1b10eaf626e",
          friendName: "窦红莉",
          underline: true,
          message: "微信:nutty",
          avatar: "images/avatar_webp/chat_12.webp",
          alreadyFriends: true,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "伊人在水一方",
              'icon': "images/avatar_webp/chat_12.webp",
            });
            logger.info('伊人在水一方被点击~');
          }),
      ContactListItem(
          id: "abc8c77e-924c-5ba8-94bc-36978fda42c5",
          friendName: "周剑桥",
          underline: true,
          message: "微信:acrimonious",
          avatar: "images/avatar_webp/chat_13.webp",
          alreadyFriends: false,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "与我共梦",
              'icon': "images/avatar_webp/chat_13.webp",
            });
            logger.info('与我共梦被点击~');
          }),
      ContactListItem(
          id: "86f1db28-5c98-580d-b365-70a752fde80c",
          friendName: "尹洪友",
          underline: true,
          message: "微信:substandard",
          avatar: "images/avatar_webp/chat_14.webp",
          alreadyFriends: false,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "挽弦暮笙",
              'icon': "images/avatar_webp/chat_14.webp",
            });
            logger.info('挽弦暮笙被点击~');
          }),
      ContactListItem(
          id: "81fd1656-bfa0-5e12-bab4-9cbc208e3f4a",
          friendName: "周桑",
          underline: true,
          message: "微信:receiving",
          avatar: "images/avatar_webp/chat_15.webp",
          alreadyFriends: true,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "开始厌倦",
              'icon': "images/avatar_webp/chat_15.webp",
            });
            logger.info('开始厌倦被点击~');
          }),
      ContactListItem(
          id: "bbe17759-086d-51f6-871a-4fc5d7014fd3",
          friendName: "李程",
          underline: true,
          message: "微信:selfindulgent",
          avatar: "images/avatar_webp/chat_16.webp",
          alreadyFriends: true,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "仙女收纳盒",
              'icon': "images/avatar_webp/chat_16.webp",
            });
            logger.info('仙女收纳盒被点击~');
          }),
      ContactListItem(
          id: "6e48d092-0d0e-5769-9837-96ee651c7a4b",
          friendName: "王庆营",
          underline: true,
          message: "微信:extraneous",
          avatar: "images/avatar_webp/chat_17.webp",
          alreadyFriends: false,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "華燈初上",
              'icon': "images/avatar_webp/chat_17.webp",
            });
            logger.info('華燈初上被点击~');
          }),
      alphabet("C"),
      ContactListItem(
          id: "dbc2eaca-56ce-5940-b9fc-9a42583ce674",
          friendName: "朱金照",
          underline: true,
          message: "微信:inexhaustible",
          avatar: "images/avatar_webp/chat_18.webp",
          alreadyFriends: false,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "袖手今生",
              'icon': "images/avatar_webp/chat_18.webp",
            });
            logger.info('袖手今生被点击~');
          }),
      ContactListItem(
          id: "be028228-1689-5058-903b-07b6d9380d78",
          friendName: "周秀全",
          underline: true,
          message: "微信:kneeling",
          avatar: "images/avatar_webp/chat_19.webp",
          alreadyFriends: true,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "ら道不清的忧伤",
              'icon': "images/avatar_webp/chat_19.webp",
            });
            logger.info('ら道不清的忧伤被点击~');
          }),
      ContactListItem(
          id: "419adb76-6b8c-5602-a415-2d619b4fc17f",
          friendName: "朱景龙",
          underline: true,
          message: "微信:indefatigable",
          avatar: "images/avatar_webp/chat_20.webp",
          alreadyFriends: false,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "凉生",
              'icon': "images/avatar_webp/chat_20.webp",
            });
            logger.info('凉生被点击~');
          }),
      ContactListItem(
          id: "b1b6b991-5f30-5039-896e-a8f694f94c4e",
          friendName: "俞金金",
          underline: true,
          message: "微信:appellate",
          avatar: "images/avatar_webp/chat_21.webp",
          alreadyFriends: true,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "墨香九歌",
              'icon': "images/avatar_webp/chat_21.webp",
            });
            logger.info('墨香九歌被点击~');
          }),
      alphabet("D"),
      ContactListItem(
          id: "d70f0966-df79-530c-b18d-bcf61e402bb8",
          friendName: "赵美静",
          underline: true,
          message: "微信:wellintentioned",
          avatar: "images/avatar_webp/chat_22.webp",
          alreadyFriends: false,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "暖栀",
              'icon': "images/avatar_webp/chat_22.webp",
            });
            logger.info('暖栀被点击~');
          }),
      ContactListItem(
          id: "0d0618d4-4520-5d8c-8c3f-e9fdf7048a3c",
          friendName: "张莉青",
          underline: true,
          message: "微信:abused",
          avatar: "images/avatar_webp/chat_23.webp",
          alreadyFriends: false,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "等待许了苍老",
              'icon': "images/avatar_webp/chat_23.webp",
            });
            logger.info('等待许了苍老被点击~');
          }),
      ContactListItem(
          id: "6cdd7427-24d6-5014-a9c8-019dfbba891f",
          friendName: "郭文才",
          underline: true,
          message: "微信:illadvised",
          avatar: "images/avatar_webp/chat_24.webp",
          alreadyFriends: false,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "笙歌白云",
              'icon': "images/avatar_webp/chat_24.webp",
            });
            logger.info('笙歌白云被点击~');
          }),
      ContactListItem(
          id: "97937063-66d6-56db-8265-3b671f199a50",
          friendName: "余光勇",
          underline: true,
          message: "微信:unsettling",
          avatar: "images/avatar_webp/chat_25.webp",
          alreadyFriends: false,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "万幸得以相识",
              'icon': "images/avatar_webp/chat_25.webp",
            });
            logger.info('万幸得以相识被点击~');
          }),
      ContactListItem(
          id: "5e2a94a2-89d4-5b3f-9af2-b01d4d6aeec6",
          friendName: "张礼中",
          underline: true,
          message: "微信:inactive",
          avatar: "images/avatar_webp/chat_26.webp",
          alreadyFriends: false,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "凤鸣寂寥",
              'icon': "images/avatar_webp/chat_26.webp",
            });
            logger.info('凤鸣寂寥被点击~');
          }),
      ContactListItem(
          id: "a94752c7-3a67-5f61-bde4-6dc3a907c1d4",
          friendName: "伊静",
          underline: true,
          message: "微信:packaged",
          avatar: "images/avatar_webp/chat_27.webp",
          alreadyFriends: false,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "余生不过一盏茶",
              'icon': "images/avatar_webp/chat_27.webp",
            });
            logger.info('余生不过一盏茶被点击~');
          }),
      ContactListItem(
          id: "1c400b91-d94e-520f-badb-85f5299e3e41",
          friendName: "智涛",
          underline: true,
          message: "微信:fussy",
          avatar: "images/avatar_webp/chat_28.webp",
          alreadyFriends: false,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "丢了梦想的猎手",
              'icon': "images/avatar_webp/chat_28.webp",
            });
            logger.info('丢了梦想的猎手被点击~');
          }),
      ContactListItem(
          id: "c9e9f259-833b-5cb7-853e-511b00d38051",
          friendName: "邹纪平",
          underline: true,
          message: "微信:ineffable",
          avatar: "images/avatar_webp/chat_29.webp",
          alreadyFriends: false,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "今朝有酒今朝醉",
              'icon': "images/avatar_webp/chat_29.webp",
            });
            logger.info('今朝有酒今朝醉被点击~');
          }),
      alphabet("E"),
      ContactListItem(
        id: "0b4265b0-0b9a-5684-b7d2-baf26f1f6887",
        friendName: "马自学",
        underline: false,
        message: "微信:reigning",
        avatar: "images/avatar_webp/chat_30.webp",
        alreadyFriends: false,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "旧事酒浓",
            'icon': "images/avatar_webp/chat_30.webp",
          });
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return vm.mainpage3isload! ? _buildPage(vm) : const LJNPageLoading();
        });
  }

  // 另起一个函数方便管理
  Widget _buildPage(StoreType vm) {
    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }
    // Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        primary: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.0.w + _statusHeight),
            child: Container(
                color: const Color.fromARGB(255, 237, 237, 237),
                padding: EdgeInsets.only(top: _statusHeight),
                child: AppBar(
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      // wallet
                    }, // 点击事件
                    child: Container(
                      color: Colors.transparent,
                      child: Icon(
                        const IconData(
                          0xed9e,
                          fontFamily: 'Iconfont',
                        ), // 使用的图标
                        color: Colors.black, // 图标颜色
                        size: 36.w, // 图标大小
                      ),
                    ),
                  ),
                  primary: false,
                  centerTitle: true,
                  title: const Text('查看手机通讯录'),
                  toolbarHeight: 90.w,
                  titleTextStyle: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(32.w),
                      color: Colors.black,
                      fontFamily: "AlibabaPuHuiTi-Medium"),
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  backgroundColor: const Color.fromARGB(255, 237, 237, 237),
                  foregroundColor: const Color.fromARGB(255, 237, 237, 237),
                  // bottom: PreferredSize(
                  //   preferredSize: Size.fromHeight(1.w),
                  //   child: Container(
                  //     color: const Color.fromARGB(255, 220, 220, 220),
                  //     height: 1.w,
                  //   ),
                  // ),
                  actions: const [
                    // // 三个点
                    // GestureDetector(
                    //     onTap: () {
                    //       // 点击事件
                    //     },
                    //     child: Container(
                    //         color: Colors.transparent,
                    //         padding: EdgeInsets.only(right: 33.w),
                    //         child: Text("账单",
                    //             style: TextStyle(height: 1.08,
                    //                 color: Colors.black,
                    //                 fontSize: fontSizeScale(30.w),
                    //                 fontWeight: FontWeight.w500)))),
                  ],
                ))),
        body: ScrollConfiguration(
            behavior: CustomScrollBehavior().copyWith(
              scrollbars: false,
              physics: const BouncingScrollPhysics(),
            ),
            child: ColoredBox(
                color: const Color.fromARGB(255, 236, 236, 236),
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
                ))));
  }

  // 字母
  Widget alphabet(String title) {
    return Container(
      height: 60.w,
      color: const Color.fromARGB(255, 237, 237, 237),
      padding: EdgeInsets.only(left: 30.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              height: 1.08,
              fontSize: fontSizeScale(20.w),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactListItem extends StatefulWidget {
  final String id;
  final String avatar;
  final String friendName;
  final String message;
  final bool alreadyFriends;
  final bool underline;

  final Function()? onPressed;

  const ContactListItem({
    super.key,
    required this.id,
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
  Color containerColor = Colors.white;
  // Color containerColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: containerColor,
      height: 135.0.w,
      padding: const EdgeInsets.only(left: 30.0).w,
      child: Row(
        children: [
          // 头像
          Container(
            width: 90.0.w,
            height: 90.0.w,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10).w,
              image: DecorationImage(
                image: ResizeImage(AssetImage(assetPath(widget.avatar)),
                    width: 180.w.toInt(), height: 180.w.toInt()),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: 23.w),

          // 右边区域
          Expanded(
            child: Container(
              // alignment: Alignment.center,
              decoration: BoxDecoration(
                  // color: Colors.red,
                  border: Border(
                      bottom: BorderSide(
                color: widget.underline
                    ? const Color.fromARGB(255, 242, 242, 242)
                    : Colors.transparent,
                width: 1.5.w,
                style: BorderStyle.solid,
              ))),
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
                              child: RichText(
                            strutStyle: StrutStyle(
                                height: 1,
                                forceStrutHeight: true,
                                fontSize: 32.w),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: buildTextSpans(
                                  widget.friendName,
                                  TextStyle(
                                      height: 1.08,
                                      fontSize: fontSizeScale(32.0.w),
                                      color: Colors.black,
                                      fontFamily: "AlibabaPuHuiTi"),
                                  TextStyle(
                                      height: 1.08,
                                      fontSize: fontSizeScale(32.w),
                                      fontFamily: "NotoColorEmoji-Regular")),
                            ),
                          )),
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
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: buildTextSpans(
                                    widget.message,
                                    TextStyle(
                                      height: 1.08,
                                      fontSize: fontSizeScale(25.w),
                                      color: const Color.fromARGB(
                                          255, 170, 170, 170),
                                    ),
                                    TextStyle(
                                      height: 1.08,
                                      fontSize: fontSizeScale(25.w),
                                      color: const Color.fromARGB(
                                          255, 170, 170, 170),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),

                  // 右边按钮
                  if (widget.alreadyFriends)
                    const LJNAddButton(
                        title: "添加",
                        backgroundColor: Color.fromARGB(255, 74, 193, 99))
                  else
                    const LJNAddButton(
                      title: "已添加",
                      // readonly: true,
                      backgroundColor: Colors.transparent,
                      color: Color.fromARGB(255, 93, 93, 93),
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

class LJNAddButton extends StatefulWidget {
  final String title;
  final Color? color;
  final Color? backgroundColor;
  final String? link;
  final bool? readonly;

  const LJNAddButton({
    super.key,
    required this.title,
    this.color,
    this.backgroundColor,
    this.readonly,
    this.link,
  });

  @override
  State<LJNAddButton> createState() => _LJNAddButtonState();
}

class _LJNAddButtonState extends State<LJNAddButton> {
  // bool isClicked = false;
  late Color originContainerColor;
  late Color containerColor;
  @override
  void initState() {
    super.initState();

    // 判断是否有 backgroundColor，若没有，则使用默认颜色
    originContainerColor =
        widget.backgroundColor ?? const Color.fromARGB(255, 242, 242, 242);

    setState(() {
      containerColor = originContainerColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color fontColor = Colors.white;
    if (widget.color is Color) {
      fontColor = widget.color!;
    }

    return GestureDetector(
      onTapDown: (tapDownDetails) {
        if (widget.readonly == true) return;

        setState(() {
          containerColor = darkenColor(originContainerColor, 0.11);
        });
      },
      onTapCancel: () {
        setState(() {
          containerColor = originContainerColor;
        });

        logger.info("取消点击");
      },
      onTapUp: (tapDownDetails) {
        if (widget.readonly == true) return;

        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = originContainerColor;
          });

          if (mounted) {
            if (widget.link == 'back') {
              Navigator.of(context).pop();
            } else if (widget.link != null) {
              Navigator.pushNamed(context, widget.link!);
            }
          }
        });

        logger.info("弹起");
      },
      child: Container(
        width: 142.w,
        height: 57.w,
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 25.w),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
        ),
        child: Text(
          widget.title,
          style: TextStyle(color: fontColor, fontSize: 25.w),
        ),
      ),
    );
  }
}
