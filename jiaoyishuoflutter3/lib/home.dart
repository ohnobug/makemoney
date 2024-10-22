import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNHomePage extends StatefulWidget {
  const LJNHomePage({super.key});

  @override
  State<LJNHomePage> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<LJNHomePage> {
  final _customScrollController = ScrollController();
  double _statusHeight = 0;
  late final List<ChatListItem> chatItems;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      myStore.dispatch({"type": "mainpage1isload", "payload": true});
    });

    _customScrollController.addListener(() {
      // logger.info("this is :{${_customScrollController.position.pixels}}");

      if (_customScrollController.position.pixels <= 0) {
        myStore.dispatch({
          "type": "homescrollpixels",
          "payload": _customScrollController.position.pixels.abs()
        });
      } else {
        double newValue = myStore.state.homescrollpixels! +
            _customScrollController.position.pixels;
        if (newValue < 0) {
          myStore.dispatch({"type": "homescrollpixels", "payload": newValue});
        } else {
          myStore.dispatch({"type": "homescrollpixels", "payload": 0.0});
        }
      }
    });

    chatItems = [
      ChatListItem(
        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
        friendName: "花重月数花重月数花重月数花重月数花重月数花重月数花重月数花重月数花重月数花重月数",
        notice: true,
        underline: true,
        message: "今天天气真好，阳光明媚，让人心情愉悦。",
        avatar: "images/avatar_webp/chat_1.webp",
        lastedTime: "16:56",
        badge: 100,
        onPressed: () {
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': "花重月数花重月数花重月数花重月数花重月数花重月数花重月数花重月数花重月数花重月数",
            'icon': "images/avatar_webp/chat_1.webp",
          });
          logger.info('花重月数被点击~');
        },
      ),
      ChatListItem(
          id: "4462b35d-e742-5011-9ed6-f10666ef8e9f",
          friendName: '文件传输助手',
          notice: false,
          underline: true,
          message: "[图片]",
          avatar: "images/avatar/webwxgeticon.jpg",
          lastedTime: "16:49",
          badge: 99,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "文件传输助手",
              'icon': "images/avatar/webwxgeticon.jpg",
            });
            logger.info('文件传输助手~');
          }),
      ChatListItem(
          id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
          friendName: "华南理工大学 软件开发群",
          notice: false,
          underline: true,
          message: "这个怎么样调试?",
          avatar: "images/avatar/webwxgetheadimg.jpg",
          lastedTime: "16:40",
          badge: 9,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "华南理工大学 软件开发群",
              'icon': "images/avatar/webwxgetheadimg.jpg",
            });
            logger.info('华南理工大学 软件开发群被点击~');
          }),
      ChatListItem(
          id: "6390e7d0-c8bd-5929-b537-76f6577c591c",
          friendName: "邓子乔",
          notice: false,
          underline: true,
          message: "你最近过得如何？工作顺利吗？有没有遇到什么有趣的事情？",
          avatar: "images/avatar_webp/chat_4.webp",
          lastedTime: "16:33",
          badge: -1,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "绿逾初夏",
              'icon': "images/avatar_webp/chat_4.webp",
            });
            logger.info('绿逾初夏被点击~');
          }),
      ChatListItem(
          id: "d87d7c11-04f1-569c-8fd3-de333397966c",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "今天上班/上学累吗？要注意休息哦。",
          avatar: "images/avatar_webp/chat_5.webp",
          lastedTime: "16:25",
          badge: -1,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "余笙南吟",
              'icon': "images/avatar_webp/chat_5.webp",
            });
            logger.info('余笙南吟被点击~');
          }),
      ChatListItem(
          id: "7c3f2f89-6eae-5658-bce9-b3d8e20e309c",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "这个周末有什么计划？有没有想好去哪里玩？",
          avatar: "images/avatar_webp/chat_6.webp",
          lastedTime: "16:18",
          badge: -1,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "陈情匿旧酒",
              'icon': "images/avatar_webp/chat_6.webp",
            });
            logger.info('陈情匿旧酒被点击~');
          }),
      ChatListItem(
          id: "6b4ac788-576a-5a7c-be38-854571564bd1",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "你喜欢看什么电影？我最近看了一部不错的电影，推荐给你！",
          avatar: "images/avatar_webp/chat_7.webp",
          lastedTime: "16:13",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "白桃乌龙",
              'icon': "images/avatar_webp/chat_7.webp",
            });
            logger.info('白桃乌龙被点击~');
          }),
      ChatListItem(
          id: "139bf645-623d-5791-ad6b-4907e5fc8309",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "你最近有没有去旅行？去了哪些地方？感觉怎么样？",
          avatar: "images/avatar_webp/chat_8.webp",
          lastedTime: "16:03",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "清浅ˋ旧时光",
              'icon': "images/avatar_webp/chat_8.webp",
            });
            logger.info('清浅ˋ旧时光被点击~');
          }),
      ChatListItem(
          id: "35fe74be-e7cb-520e-9d79-1b19b1018249",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "我听说你最近升职了，恭喜你！一定能够做得更好！",
          avatar: "images/avatar_webp/chat_9.webp",
          lastedTime: "15:54",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "荒碎梦残",
              'icon': "images/avatar_webp/chat_9.webp",
            });
            logger.info('荒碎梦残被点击~');
          }),
      ChatListItem(
          id: "18127772-a653-5ca6-ba2c-5b1b855aa236",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "你今天穿得很漂亮，看起来很有气质。",
          avatar: "images/avatar_webp/chat_10.webp",
          lastedTime: "15:49",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "无梦相赠",
              'icon': "images/avatar_webp/chat_10.webp",
            });
            logger.info('无梦相赠被点击~');
          }),
      ChatListItem(
          id: "a41401db-2dde-519d-bc9f-df6e51089c9e",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "你最喜欢的颜色是什么？是不是很时尚？",
          avatar: "images/avatar_webp/chat_11.webp",
          lastedTime: "15:43",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "离人泪",
              'icon': "images/avatar_webp/chat_11.webp",
            });
            logger.info('离人泪被点击~');
          }),
      ChatListItem(
          id: "335ebb66-9440-5a2e-9795-d1b10eaf626e",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "你最近有没有去尝试新的餐厅？有没有吃到什么特别好吃的菜？",
          avatar: "images/avatar_webp/chat_12.webp",
          lastedTime: "15:36",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "伊人在水一方",
              'icon': "images/avatar_webp/chat_12.webp",
            });
            logger.info('伊人在水一方被点击~');
          }),
      ChatListItem(
          id: "abc8c77e-924c-5ba8-94bc-36978fda42c5",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "你的生日是今天吗？生日快乐啊！有没有想好怎么庆祝？",
          avatar: "images/avatar_webp/chat_13.webp",
          lastedTime: "15:26",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "与我共梦",
              'icon': "images/avatar_webp/chat_13.webp",
            });
            logger.info('与我共梦被点击~');
          }),
      ChatListItem(
          id: "86f1db28-5c98-580d-b365-70a752fde80c",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "你平常喜欢做什么样的运动？我最近喜欢上了瑜伽。",
          avatar: "images/avatar_webp/chat_14.webp",
          lastedTime: "15:19",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "挽弦暮笙",
              'icon': "images/avatar_webp/chat_14.webp",
            });
            logger.info('挽弦暮笙被点击~');
          }),
      ChatListItem(
          id: "81fd1656-bfa0-5e12-bab4-9cbc208e3f4a",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "我觉得你很有创造力，一定能够做出很多很棒的东西。",
          avatar: "images/avatar_webp/chat_15.webp",
          lastedTime: "15:13",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "开始厌倦",
              'icon': "images/avatar_webp/chat_15.webp",
            });
            logger.info('开始厌倦被点击~');
          }),
      ChatListItem(
          id: "bbe17759-086d-51f6-871a-4fc5d7014fd3",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "你最近有没有追什么好剧？有没有推荐的电视剧？",
          avatar: "images/avatar_webp/chat_16.webp",
          lastedTime: "15:05",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "仙女收纳盒",
              'icon': "images/avatar_webp/chat_16.webp",
            });
            logger.info('仙女收纳盒被点击~');
          }),
      ChatListItem(
          id: "6e48d092-0d0e-5769-9837-96ee651c7a4b",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "我很喜欢你的发型，看起来很时尚，一定是精心打理过的。",
          avatar: "images/avatar_webp/chat_17.webp",
          lastedTime: "15:00",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "華燈初上",
              'icon': "images/avatar_webp/chat_17.webp",
            });
            logger.info('華燈初上被点击~');
          }),
      ChatListItem(
          id: "dbc2eaca-56ce-5940-b9fc-9a42583ce674",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "你是什么星座的？我最近对星座运势感兴趣了。",
          avatar: "images/avatar_webp/chat_18.webp",
          lastedTime: "14:51",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "袖手今生",
              'icon': "images/avatar_webp/chat_18.webp",
            });
            logger.info('袖手今生被点击~');
          }),
      ChatListItem(
          id: "be028228-1689-5058-903b-07b6d9380d78",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "我觉得你笑起来很好看，让人感觉很温暖。",
          avatar: "images/avatar_webp/chat_19.webp",
          lastedTime: "14:41",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "ら道不清的忧伤",
              'icon': "images/avatar_webp/chat_19.webp",
            });
            logger.info('ら道不清的忧伤被点击~');
          }),
      ChatListItem(
          id: "419adb76-6b8c-5602-a415-2d619b4fc17f",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "你愿意和我一起去旅行吗？我们可以一起去探索未知的地方。",
          avatar: "images/avatar_webp/chat_20.webp",
          lastedTime: "14:31",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "凉生",
              'icon': "images/avatar_webp/chat_20.webp",
            });
            logger.info('凉生被点击~');
          }),
      ChatListItem(
          id: "b1b6b991-5f30-5039-896e-a8f694f94c4e",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "你的梦想是什么？我最近梦想成为一名优秀的厨师。",
          avatar: "images/avatar_webp/chat_21.webp",
          lastedTime: "14:21",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "墨香九歌",
              'icon': "images/avatar_webp/chat_21.webp",
            });
            logger.info('墨香九歌被点击~');
          }),
      ChatListItem(
          id: "d70f0966-df79-530c-b18d-bcf61e402bb8",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "你最近有没有学到什么新知识？我最近在学习一门新技能。",
          avatar: "images/avatar_webp/chat_22.webp",
          lastedTime: "14:13",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "暖栀",
              'icon': "images/avatar_webp/chat_22.webp",
            });
            logger.info('暖栀被点击~');
          }),
      ChatListItem(
          id: "0d0618d4-4520-5d8c-8c3f-e9fdf7048a3c",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "我听说你要搬家了，是吗？祝贺你！新家在哪里？是不是很期待？",
          avatar: "images/avatar_webp/chat_23.webp",
          lastedTime: "14:05",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "等待许了苍老",
              'icon': "images/avatar_webp/chat_23.webp",
            });
            logger.info('等待许了苍老被点击~');
          }),
      ChatListItem(
          id: "6cdd7427-24d6-5014-a9c8-019dfbba891f",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "你喜欢什么样的音乐？我最近迷上了一种新的音乐风格。",
          avatar: "images/avatar_webp/chat_24.webp",
          lastedTime: "13:55",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "笙歌白云",
              'icon': "images/avatar_webp/chat_24.webp",
            });
            logger.info('笙歌白云被点击~');
          }),
      ChatListItem(
          id: "97937063-66d6-56db-8265-3b671f199a50",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "我觉得你非常有魅力，你的个性很吸引人。",
          avatar: "images/avatar_webp/chat_25.webp",
          lastedTime: "13:48",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "万幸得以相识",
              'icon': "images/avatar_webp/chat_25.webp",
            });
            logger.info('万幸得以相识被点击~');
          }),
      ChatListItem(
          id: "5e2a94a2-89d4-5b3f-9af2-b01d4d6aeec6",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "我很喜欢和你聊天，每次都能学到很多东西。",
          avatar: "images/avatar_webp/chat_26.webp",
          lastedTime: "13:40",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "凤鸣寂寥",
              'icon': "images/avatar_webp/chat_26.webp",
            });
            logger.info('凤鸣寂寥被点击~');
          }),
      ChatListItem(
          id: "a94752c7-3a67-5f61-bde4-6dc3a907c1d4",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "你会做饭吗？我最近学会了做一道新菜，很好吃哦。",
          avatar: "images/avatar_webp/chat_27.webp",
          lastedTime: "13:33",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "余生不过一盏茶",
              'icon': "images/avatar_webp/chat_27.webp",
            });
            logger.info('余生不过一盏茶被点击~');
          }),
      ChatListItem(
          id: "1c400b91-d94e-520f-badb-85f5299e3e41",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "你喜欢看什么类型的书？我最近在读一本很有趣的小说。",
          avatar: "images/avatar_webp/chat_28.webp",
          lastedTime: "13:25",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "丢了梦想的猎手",
              'icon': "images/avatar_webp/chat_28.webp",
            });
            logger.info('丢了梦想的猎手被点击~');
          }),
      ChatListItem(
          id: "c9e9f259-833b-5cb7-853e-511b00d38051",
          friendName: mockName(),
          notice: false,
          underline: true,
          message: "你最近有没有参加什么有趣的活动？有没有结识到新朋友？",
          avatar: "images/avatar_webp/chat_29.webp",
          lastedTime: "13:15",
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "今朝有酒今朝醉",
              'icon': "images/avatar_webp/chat_29.webp",
            });
            logger.info('今朝有酒今朝醉被点击~');
          }),
      ChatListItem(
        id: "0b4265b0-0b9a-5684-b7d2-baf26f1f6887",
        friendName: "旧事酒浓",
        notice: false,
        underline: false,
        message: "我听说你最近去旅游了，怎么样？玩得开心吗？",
        avatar: "images/avatar_webp/chat_30.webp",
        lastedTime: "13:05",
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
          return vm.mainpage1isload! ? _buildPage(vm) : const LJNPageLoading();
        });
  }

  Widget _buildPage(StoreType vm) {
    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }

    return ScrollConfiguration(
        behavior: CustomScrollBehavior().copyWith(scrollbars: false),
        child: ListView.builder(
          primary: false,
          padding: EdgeInsets.only(top: _statusHeight + 90.w),
          itemCount: chatItems.length,
          shrinkWrap: true,
          controller: _customScrollController,
          physics: const CustomScrollPhysics()
              .applyTo(const MyBouncingScrollPhysics()),
          // physics: const MyBouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return chatItems[index];
          },
        ));
  }
}

class ChatListItem extends StatefulWidget {
  final String id;
  final String avatar;
  final String friendName;
  final String message;
  final bool notice;
  final bool underline;
  final String lastedTime;
  final int? badge;
  final Function()? onPressed;

  const ChatListItem({
    super.key,
    required this.id,
    required this.avatar,
    required this.friendName,
    required this.message,
    required this.notice,
    required this.underline,
    required this.lastedTime,
    this.badge,
    this.onPressed,
  });

  @override
  State<ChatListItem> createState() => _ChatListItem();
}

class _ChatListItem extends State<ChatListItem> {
  Color containerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (_) {
          setState(() {
            containerColor = const Color.fromARGB(255, 229, 229, 229);
          });
        },
        onTapCancel: () {
          setState(() {
            containerColor = Colors.white;
          });

          logger.info("取消点击");
        },
        onTapUp: (tapDownDetails) {
          Future.delayed(const Duration(milliseconds: 50), () {
            setState(() {
              containerColor = Colors.white;
            });
            widget.onPressed!();
          });

          logger.info("弹起");
        },
        child: Stack(
          children: [
            // 头像以及名称日期等信息
            Container(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 好友名称和消息时间
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 好友名称
                              Expanded(
                                  child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  children: buildTextSpans(
                                      widget.friendName,
                                      TextStyle(
                                          height: 1.08,
                                          fontSize: fontSizeScale(30.0.w),
                                          color: widget.notice
                                              ? Colors.red
                                              : Colors.black,
                                          fontFamily: "AlibabaPuHuiTi"),
                                      TextStyle(
                                          height: 1.08,
                                          fontSize: fontSizeScale(30.w),
                                          fontFamily:
                                              "NotoColorEmoji-Regular")),
                                ),
                              )),
                              SizedBox(
                                width: 10.w,
                              ),
                              // 消息时间
                              Text(
                                widget.lastedTime,
                                style: TextStyle(
                                  height: 1.08,
                                  fontSize: fontSizeScale(20.0.w),
                                  color: widget.notice
                                      ? Colors.red
                                      : const Color.fromARGB(
                                          255, 193, 193, 193),
                                ),
                              ),

                              SizedBox(
                                width: 30.w,
                              )
                            ],
                          ),

                          SizedBox(height: 10.w),

                          // 好友消息
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 文本
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
                                              255, 180, 180, 180),
                                        ),
                                        TextStyle(
                                          height: 1.08,
                                          fontSize: fontSizeScale(25.w),
                                          color: const Color.fromARGB(
                                              255, 180, 180, 180),
                                        )),
                                  ),
                                ),
                              ),

                              // 铃铛
                              Container(
                                width: 30.w,
                                height: 30.w,
                                // color: Colors.red,
                                margin: EdgeInsets.only(right: 30.w),
                                child: widget.notice
                                    ? Icon(
                                        const IconData(
                                          0xe62d,
                                          fontFamily: 'Iconfont',
                                        ),
                                        size: 25.0.w,
                                        color: const Color.fromARGB(
                                            255, 180, 180, 180))
                                    : null,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 角标
            if (widget.badge != null)
              if (widget.badge! > 0)
                Positioned(
                    left: 95.w,
                    top: 16.w,
                    child: Container(
                      width: 35.w, // 盒子宽度
                      height: 35.w, // 盒子高度
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle, // 圆形
                        color: Color.fromRGBO(246, 89, 87, 1), // 盒子颜色
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.badge.toString(), // 这里可以替换成你想要显示的数字
                        maxLines: 1,
                        style: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(20.w), // 数字大小
                            color: Colors.white, // 数字颜色
                            fontWeight: FontWeight.w600,
                            fontFamily: "Rubik-Light"),
                      ),
                    ))
              else if (widget.badge! == -1)
                Positioned(
                    left: 109.w,
                    top: 20.w,
                    child: Container(
                      width: 20.w, // 盒子宽度
                      height: 20.w, // 盒子高度
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle, // 圆形
                        color: Color.fromRGBO(246, 89, 87, 1), // 盒子颜色
                      ),
                      child: null,
                    ))
          ],
        ));
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  const CustomScrollPhysics({super.parent});

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    logger.info(offset);
    // 增加用户拖动的偏移量
    return offset * 1.3; // 乘以一个大于1的系数来增加滚动距离
  }

  @override
  double get dragStartDistanceMotionThreshold => 1.0; // 将拖动开始的阈值设置为0，增加灵敏度

  double get friction => 0.05; // 调整摩擦力，以改变滚动的减速特性
}

class CustomScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const CustomScrollPhysics();
    // return const CustomScrollPhysics().applyTo(const MyBouncingScrollPhysics());
  }
}

class MyBouncingScrollPhysics extends ScrollPhysics {
  /// Creates scroll physics that bounce back from the edge.
  const MyBouncingScrollPhysics({
    this.decelerationRate = ScrollDecelerationRate.normal,
    super.parent,
  });

  /// Used to determine parameters for friction simulations.
  final ScrollDecelerationRate decelerationRate;

  @override
  BouncingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return BouncingScrollPhysics(
        parent: buildParent(ancestor), decelerationRate: decelerationRate);
  }

  /// The multiple applied to overscroll to make it appear that scrolling past
  /// the edge of the scrollable contents is harder than scrolling the list.
  /// This is done by reducing the ratio of the scroll effect output vs the
  /// scroll gesture input.
  ///
  /// This factor starts at 0.52 and progressively becomes harder to overscroll
  /// as more of the area past the edge is dragged in (represented by an increasing
  /// `overscrollFraction` which starts at 0 when there is no overscroll).
  double frictionFactor(double overscrollFraction) {
    return math.pow(1 - overscrollFraction, 2) *
        switch (decelerationRate) {
          ScrollDecelerationRate.fast => 0.26,
          ScrollDecelerationRate.normal => 0.52,
        };
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    assert(offset != 0.0);
    assert(position.minScrollExtent <= position.maxScrollExtent);

    if (!position.outOfRange) {
      return offset;
    }

    final double overscrollPastStart =
        math.max(position.minScrollExtent - position.pixels, 0.0);
    final double overscrollPastEnd =
        math.max(position.pixels - position.maxScrollExtent, 0.0);
    final double overscrollPast =
        math.max(overscrollPastStart, overscrollPastEnd);
    final bool easing = (overscrollPastStart > 0.0 && offset < 0.0) ||
        (overscrollPastEnd > 0.0 && offset > 0.0);

    final double friction = easing
        // Apply less resistance when easing the overscroll vs tensioning.
        ? frictionFactor(
            (overscrollPast - offset.abs()) / position.viewportDimension)
        : frictionFactor(overscrollPast / position.viewportDimension);
    final double direction = offset.sign;

    if (easing && decelerationRate == ScrollDecelerationRate.fast) {
      return direction * offset.abs();
    }
    return direction * _applyFriction(overscrollPast, offset.abs(), friction);
  }

  static double _applyFriction(
      double extentOutside, double absDelta, double gamma) {
    assert(absDelta > 0);
    double total = 0.0;
    if (extentOutside > 0) {
      final double deltaToLimit = extentOutside / gamma;
      if (absDelta < deltaToLimit) {
        return absDelta * gamma;
      }
      total += extentOutside;
      absDelta -= deltaToLimit;
    }
    return total + absDelta;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) => 0.0;

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    final Tolerance tolerance = toleranceFor(position);
    if (velocity.abs() >= tolerance.velocity || position.outOfRange) {
      return BouncingScrollSimulation(
        spring: spring,
        position: position.pixels,
        velocity: velocity,
        leadingExtent: position.minScrollExtent,
        trailingExtent: position.maxScrollExtent,
        tolerance: tolerance,
        constantDeceleration: switch (decelerationRate) {
          ScrollDecelerationRate.fast => 1400,
          ScrollDecelerationRate.normal => 0,
        },
      );
    }
    return null;
  }

  // The ballistic simulation here decelerates more slowly than the one for
  // ClampingScrollPhysics so we require a more deliberate input gesture
  // to trigger a fling.
  @override
  double get minFlingVelocity => kMinFlingVelocity * 2.0;

  // Methodology:
  // 1- Use https://github.com/flutter/platform_tests/tree/master/scroll_overlay to test with
  //    Flutter and platform scroll views superimposed.
  // 3- If the scrollables stopped overlapping at any moment, adjust the desired
  //    output value of this function at that input speed.
  // 4- Feed new input/output set into a power curve fitter. Change function
  //    and repeat from 2.
  // 5- Repeat from 2 with medium and slow flings.
  /// Momentum build-up function that mimics iOS's scroll speed increase with repeated flings.
  ///
  /// The velocity of the last fling is not an important factor. Existing speed
  /// and (related) time since last fling are factors for the velocity transfer
  /// calculations.
  @override
  double carriedMomentum(double existingVelocity) {
    return existingVelocity.sign *
        math.min(0.000816 * math.pow(existingVelocity.abs(), 1.967).toDouble(),
            40000.0);
  }

  // Eyeballed from observation to counter the effect of an unintended scroll
  // from the natural motion of lifting the finger after a scroll.
  @override
  double get dragStartDistanceMotionThreshold => 3.5;

  @override
  double get maxFlingVelocity {
    return switch (decelerationRate) {
      ScrollDecelerationRate.fast => kMaxFlingVelocity * 8.0,
      ScrollDecelerationRate.normal => super.maxFlingVelocity,
    };
  }

  @override
  SpringDescription get spring {
    switch (decelerationRate) {
      case ScrollDecelerationRate.fast:
        return SpringDescription.withDampingRatio(
          mass: 0.3,
          stiffness: 75.0,
          ratio: 1.3,
        );
      case ScrollDecelerationRate.normal:
        return super.spring;
    }
  }

  get math => null;
}
