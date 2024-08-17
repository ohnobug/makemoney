import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/pageloading.dart';
import 'package:flutter_application_1/logger.dart';
import 'package:flutter_application_1/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNHomePage extends StatefulWidget {
  const LJNHomePage({super.key});

  @override
  State<LJNHomePage> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<LJNHomePage> {
  final _customScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      myStore.dispatch({"type": "mainpage1isload", "payload": true});
    });

    _customScrollController.addListener(() {
      if (_customScrollController.position.pixels <= 0) {
        setState(() {
          myStore.dispatch({
            "type": "homescrollpixels",
            "payload": _customScrollController.position.pixels
          });
        });
      }
    });
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
    final List<ChatListItem> chatItems = [
      ChatListItem(
          id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
          friendName: "花重月数",
          notice: true,
          message: "今天天气真好，阳光明媚，让人心情愉悦。",
          avatar: "assets/images/avatar/chat_1.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('花重月数被点击~');
          }),
      ChatListItem(
          id: "4462b35d-e742-5011-9ed6-f10666ef8e9f",
          friendName: "旧梦如风°",
          notice: true,
          message: "你吃过了吗？吃的什么？有没有想我？",
          avatar: "assets/images/avatar/chat_2.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('旧梦如风°被点击~');
          }),
      ChatListItem(
          id: "c7e7c26e-aa86-5e7b-9bbd-018f46b27e7a",
          friendName: "蝶舞庄周",
          notice: true,
          message: "我很高兴见到你，今天看起来很不错。",
          avatar: "assets/images/avatar/chat_3.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('蝶舞庄周被点击~');
          }),
      ChatListItem(
          id: "6390e7d0-c8bd-5929-b537-76f6577c591c",
          friendName: "绿逾初夏",
          notice: false,
          message: "你最近过得如何？工作顺利吗？有没有遇到什么有趣的事情？",
          avatar: "assets/images/avatar/chat_4.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('绿逾初夏被点击~');
          }),
      ChatListItem(
          id: "d87d7c11-04f1-569c-8fd3-de333397966c",
          friendName: "余笙南吟",
          notice: false,
          message: "今天上班/上学累吗？要注意休息哦。",
          avatar: "assets/images/avatar/chat_5.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('余笙南吟被点击~');
          }),
      ChatListItem(
          id: "7c3f2f89-6eae-5658-bce9-b3d8e20e309c",
          friendName: "陈情匿旧酒",
          notice: false,
          message: "这个周末有什么计划？有没有想好去哪里玩？",
          avatar: "assets/images/avatar/chat_6.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('陈情匿旧酒被点击~');
          }),
      ChatListItem(
          id: "6b4ac788-576a-5a7c-be38-854571564bd1",
          friendName: "白桃乌龙",
          notice: false,
          message: "你喜欢看什么电影？我最近看了一部不错的电影，推荐给你！",
          avatar: "assets/images/avatar/chat_7.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('白桃乌龙被点击~');
          }),
      ChatListItem(
          id: "139bf645-623d-5791-ad6b-4907e5fc8309",
          friendName: "清浅ˋ旧时光",
          notice: false,
          message: "你最近有没有去旅行？去了哪些地方？感觉怎么样？",
          avatar: "assets/images/avatar/chat_8.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('清浅ˋ旧时光被点击~');
          }),
      ChatListItem(
          id: "35fe74be-e7cb-520e-9d79-1b19b1018249",
          friendName: "荒碎梦残",
          notice: false,
          message: "我听说你最近升职了，恭喜你！一定能够做得更好！",
          avatar: "assets/images/avatar/chat_9.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('荒碎梦残被点击~');
          }),
      ChatListItem(
          id: "18127772-a653-5ca6-ba2c-5b1b855aa236",
          friendName: "无梦相赠",
          notice: false,
          message: "你今天穿得很漂亮，看起来很有气质。",
          avatar: "assets/images/avatar/chat_10.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('无梦相赠被点击~');
          }),
      ChatListItem(
          id: "a41401db-2dde-519d-bc9f-df6e51089c9e",
          friendName: "离人泪",
          notice: false,
          message: "你最喜欢的颜色是什么？是不是很时尚？",
          avatar: "assets/images/avatar/chat_11.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('离人泪被点击~');
          }),
      ChatListItem(
          id: "335ebb66-9440-5a2e-9795-d1b10eaf626e",
          friendName: "伊人在水一方",
          notice: false,
          message: "你最近有没有去尝试新的餐厅？有没有吃到什么特别好吃的菜？",
          avatar: "assets/images/avatar/chat_12.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('伊人在水一方被点击~');
          }),
      ChatListItem(
          id: "abc8c77e-924c-5ba8-94bc-36978fda42c5",
          friendName: "与我共梦",
          notice: false,
          message: "你的生日是今天吗？生日快乐啊！有没有想好怎么庆祝？",
          avatar: "assets/images/avatar/chat_13.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('与我共梦被点击~');
          }),
      ChatListItem(
          id: "86f1db28-5c98-580d-b365-70a752fde80c",
          friendName: "挽弦暮笙",
          notice: false,
          message: "你平常喜欢做什么样的运动？我最近喜欢上了瑜伽。",
          avatar: "assets/images/avatar/chat_14.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('挽弦暮笙被点击~');
          }),
      ChatListItem(
          id: "81fd1656-bfa0-5e12-bab4-9cbc208e3f4a",
          friendName: "开始厌倦",
          notice: false,
          message: "我觉得你很有创造力，一定能够做出很多很棒的东西。",
          avatar: "assets/images/avatar/chat_15.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('开始厌倦被点击~');
          }),
      ChatListItem(
          id: "bbe17759-086d-51f6-871a-4fc5d7014fd3",
          friendName: "仙女收纳盒",
          notice: false,
          message: "你最近有没有追什么好剧？有没有推荐的电视剧？",
          avatar: "assets/images/avatar/chat_16.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('仙女收纳盒被点击~');
          }),
      ChatListItem(
          id: "6e48d092-0d0e-5769-9837-96ee651c7a4b",
          friendName: "華燈初上",
          notice: false,
          message: "我很喜欢你的发型，看起来很时尚，一定是精心打理过的。",
          avatar: "assets/images/avatar/chat_17.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('華燈初上被点击~');
          }),
      ChatListItem(
          id: "dbc2eaca-56ce-5940-b9fc-9a42583ce674",
          friendName: "袖手今生",
          notice: false,
          message: "你是什么星座的？我最近对星座运势感兴趣了。",
          avatar: "assets/images/avatar/chat_18.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('袖手今生被点击~');
          }),
      ChatListItem(
          id: "be028228-1689-5058-903b-07b6d9380d78",
          friendName: "ら道不清的忧伤",
          notice: false,
          message: "我觉得你笑起来很好看，让人感觉很温暖。",
          avatar: "assets/images/avatar/chat_19.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('ら道不清的忧伤被点击~');
          }),
      ChatListItem(
          id: "419adb76-6b8c-5602-a415-2d619b4fc17f",
          friendName: "凉生",
          notice: false,
          message: "你愿意和我一起去旅行吗？我们可以一起去探索未知的地方。",
          avatar: "assets/images/avatar/chat_20.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('凉生被点击~');
          }),
      ChatListItem(
          id: "b1b6b991-5f30-5039-896e-a8f694f94c4e",
          friendName: "墨香九歌",
          notice: false,
          message: "你的梦想是什么？我最近梦想成为一名优秀的厨师。",
          avatar: "assets/images/avatar/chat_21.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('墨香九歌被点击~');
          }),
      ChatListItem(
          id: "d70f0966-df79-530c-b18d-bcf61e402bb8",
          friendName: "暖栀",
          notice: false,
          message: "你最近有没有学到什么新知识？我最近在学习一门新技能。",
          avatar: "assets/images/avatar/chat_22.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('暖栀被点击~');
          }),
      ChatListItem(
          id: "0d0618d4-4520-5d8c-8c3f-e9fdf7048a3c",
          friendName: "等待许了苍老",
          notice: false,
          message: "我听说你要搬家了，是吗？祝贺你！新家在哪里？是不是很期待？",
          avatar: "assets/images/avatar/chat_23.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('等待许了苍老被点击~');
          }),
      ChatListItem(
          id: "6cdd7427-24d6-5014-a9c8-019dfbba891f",
          friendName: "笙歌白云",
          notice: false,
          message: "你喜欢什么样的音乐？我最近迷上了一种新的音乐风格。",
          avatar: "assets/images/avatar/chat_24.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('笙歌白云被点击~');
          }),
      ChatListItem(
          id: "97937063-66d6-56db-8265-3b671f199a50",
          friendName: "万幸得以相识",
          notice: false,
          message: "我觉得你非常有魅力，你的个性很吸引人。",
          avatar: "assets/images/avatar/chat_25.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('万幸得以相识被点击~');
          }),
      ChatListItem(
          id: "5e2a94a2-89d4-5b3f-9af2-b01d4d6aeec6",
          friendName: "凤鸣寂寥",
          notice: false,
          message: "我很喜欢和你聊天，每次都能学到很多东西。",
          avatar: "assets/images/avatar/chat_26.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('凤鸣寂寥被点击~');
          }),
      ChatListItem(
          id: "a94752c7-3a67-5f61-bde4-6dc3a907c1d4",
          friendName: "余生不过一盏茶",
          notice: false,
          message: "你会做饭吗？我最近学会了做一道新菜，很好吃哦。",
          avatar: "assets/images/avatar/chat_27.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('余生不过一盏茶被点击~');
          }),
      ChatListItem(
          id: "1c400b91-d94e-520f-badb-85f5299e3e41",
          friendName: "丢了梦想的猎手",
          notice: false,
          message: "你喜欢看什么类型的书？我最近在读一本很有趣的小说。",
          avatar: "assets/images/avatar/chat_28.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('丢了梦想的猎手被点击~');
          }),
      ChatListItem(
          id: "c9e9f259-833b-5cb7-853e-511b00d38051",
          friendName: "今朝有酒今朝醉",
          notice: false,
          message: "你最近有没有参加什么有趣的活动？有没有结识到新朋友？",
          avatar: "assets/images/avatar/chat_29.jpg",
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
            logger.info('今朝有酒今朝醉被点击~');
          }),
      ChatListItem(
        id: "0b4265b0-0b9a-5684-b7d2-baf26f1f6887",
        friendName: "旧事酒浓",
        notice: false,
        message: "我听说你最近去旅游了，怎么样？玩得开心吗？",
        avatar: "assets/images/avatar/chat_30.jpg",
        onPressed: () {
          Navigator.pushNamed(context, '/chat');
        },
      ),
    ];

    Size screenSize = MediaQuery.of(context).size;

    int itemCount = chatItems.length;
    if (itemCount < 10) {
      itemCount = 10;
    }

    return Container(
        height: screenSize.height - 210.w,
        color: Colors.white,
        child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Listener(
                onPointerUp: (event) {
                  myStore.dispatch({
                    "type": "homescrollverticaltapstatus",
                    "payload": "ontapup"
                  });
                },
                onPointerDown: (event) {
                  myStore.dispatch({
                    "type": "homescrollverticaltapstatus",
                    "payload": "ontapdown"
                  });
                },
                child: ListView.builder(
                  itemCount: itemCount,
                  controller: _customScrollController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return chatItems.elementAtOrNull(index) != null
                        ? chatItems[index]
                        : SizedBox(
                            height: 117.w,
                            // color: Colors.red,
                          );
                  },
                ))));
  }
}

class ChatListItem extends StatefulWidget {
  final String id;
  final String avatar;
  final String friendName;
  final String message;
  final bool notice;
  final Function() onPressed;

  const ChatListItem({
    super.key,
    required this.id,
    required this.avatar,
    required this.friendName,
    required this.message,
    required this.notice,
    required this.onPressed,
  });

  @override
  State<ChatListItem> createState() => _ChatListItem();
}

class _ChatListItem extends State<ChatListItem> {
  bool _isPressed = false;

  onPressed() {}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onPressed,
        onTapDown: (_) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _isPressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        child: Container(
          color: _isPressed
              ? const Color.fromARGB(255, 229, 229, 229)
              : Colors.transparent,
          height: 117.0.w,
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
                    image: NetworkImage(widget.avatar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 23.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 好友名称和日期
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 好友名称
                        Expanded(
                          child: Text(
                            widget.friendName,
                            style: TextStyle(
                              fontSize: 30.0.w,
                              color: widget.notice ? Colors.red : Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // 日期
                        Text(
                          '17:25',
                          style: TextStyle(
                            fontSize: 21.0.w,
                            color: widget.notice
                                ? Colors.red
                                : const Color.fromARGB(255, 175, 175, 175),
                          ),
                        ),
                        SizedBox(
                          width: 30.w,
                        )
                      ],
                    ),

                    SizedBox(height: 15.w),

                    // 好友消息
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 460.w,
                          child: Text(
                            widget.message,
                            style: TextStyle(
                              fontSize: 23.w,
                              color: const Color.fromARGB(255, 175, 175, 175),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (widget.notice) ...[
                          Container(
                            padding: EdgeInsets.only(right: 30.w),
                            child: Icon(
                              Icons.notifications_off_outlined,
                              size: 26.0.w,
                              color: const Color.fromARGB(255, 175, 175, 175),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
