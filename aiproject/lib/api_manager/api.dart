import 'package:flutter/material.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_chatlist_item.dart';
import 'package:vigaviga/widgets/ljn_contact_item.dart';

// 得到最近聊天的列表
List<ChatListItem> getChatItems(BuildContext context) {
  return [
    ChatListItem(
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
      friendName: '文件传输助手',
      notice: false,
      underline: true,
      message: "[图片]",
      avatar: "images/avatar/webwxgeticon.jpg",
      lastedTime: "16:49",
      badge: -1,
      onPressed: () {
        Navigator.pushNamed(context, '/chat', arguments: <String, String>{
          'title': AppLocalizations.of(context)!.fileTransferHelper,
          'icon': "images/avatar/webwxgeticon.jpg",
        });
        logger.info('文件传输助手~');
      },
    ),
    ChatListItem(
      friendName: "华南理工大学 软件开发群",
      notice: false,
      underline: true,
      message: "这个怎么样调试?",
      avatar: "images/avatar/webwxgetheadimg.jpg",
      lastedTime: "16:40",
      badge: 9,
      onPressed: () {
        Navigator.pushNamed(context, '/group_chat', arguments: <String, String>{
          'title': "华南理工大学 软件开发群",
          'icon': "images/avatar/webwxgetheadimg.jpg",
        });
        logger.info('华南理工大学 软件开发群被点击~');
      },
    ),
    ChatListItem(
      friendName: "邓子乔",
      notice: false,
      underline: true,
      message: "你最近过得如何？工作顺利吗？有没有遇到什么有趣的事情？",
      avatar: "images/avatar_webp/chat_4.webp",
      lastedTime: "16:33",
      badge: -1,
      onPressed: () {
        Navigator.pushNamed(context, '/chat', arguments: <String, String>{
          'title': "邓子乔",
          'icon': "images/avatar_webp/chat_4.webp",
        });
        logger.info('绿逾初夏被点击~');
      },
    ),
    ChatListItem(
      friendName: "邻小虎",
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
      friendName: mockName(),
      notice: false,
      underline: true,
      message: "💖我很喜欢和你聊天，每次都能学到很多东西。",
      avatar: "images/avatar_webp/chat_26.webp",
      lastedTime: "13:40",
      onPressed: () {
        Navigator.pushNamed(context, '/chat', arguments: <String, String>{
          'title': "凤鸣寂寥",
          'icon': "images/avatar_webp/chat_26.webp",
        });
        logger.info('凤鸣寂寥被点击~');
      },
    ),
    ChatListItem(
      friendName: mockName(),
      notice: false,
      underline: true,
      message: "你会做饭吗？🤗我最近学会了做一道新菜，很好吃哦。",
      avatar: "images/avatar_webp/chat_27.webp",
      lastedTime: "13:33",
      onPressed: () {
        Navigator.pushNamed(context, '/chat', arguments: <String, String>{
          'title': "余生不过一盏茶",
          'icon': "images/avatar_webp/chat_27.webp",
        });
        logger.info('余生不过一盏茶被点击~');
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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
      },
    ),
    ChatListItem(
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

// 返回联系人信息
List<dynamic> getContactDataList() {
  return [
    FunctionItemData(
        titleKey: 'newFriends',
        icon: "images/avatar/01.png",
        link: '/new_friends',
        underline: true),
    FunctionItemData(
        titleKey: 'chatOnlyFriends',
        icon: "images/avatar/02.png",
        link: '/friends_who_only_chat',
        underline: true),
    FunctionItemData(
        titleKey: 'groupChats',
        icon: "images/avatar/03.png",
        link: '/contact_group',
        underline: true),
    FunctionItemData(
        titleKey: 'tags',
        icon: "images/avatar/04.png",
        link: '/contact_tags',
        underline: true),
    FunctionItemData(
        titleKey: 'officialAccounts',
        icon: "images/avatar/05.png",
        link: '/official_accounts',
        underline: false),
    'A', // 字母
    ContactItemData(
        title: "天空飘来五个字那都不是事", icon: "images/avatar_webp/chat_1.webp"),
    ContactItemData(title: "本因", icon: "images/avatar_webp/chat_10.webp"),
    ContactItemData(title: "赵洵", icon: "images/avatar_webp/chat_11.webp"),
    ContactItemData(title: "定静师太", icon: "images/avatar_webp/chat_12.webp"),
    ContactItemData(title: "李秋水", icon: "images/avatar_webp/chat_13.webp"),
    ContactItemData(title: "谭婆", icon: "images/avatar_webp/chat_14.webp"),
    ContactItemData(title: "李傀儡", icon: "images/avatar_webp/chat_15.webp"),
    ContactItemData(title: "貂禅", icon: "images/avatar_webp/chat_16.webp"),
    ContactItemData(title: "何三七", icon: "images/avatar_webp/chat_17.webp"),
    ContactItemData(title: "孔融", icon: "images/avatar_webp/chat_18.webp"),
    ContactItemData(title: "齐堂主", icon: "images/avatar_webp/chat_19.webp"),
    ContactItemData(title: "博尔术", icon: "images/avatar_webp/chat_20.webp"),
    ContactItemData(title: "王语嫣", icon: "images/avatar_webp/chat_21.webp"),
    ContactItemData(title: "秦红棉", icon: "images/avatar_webp/chat_22.webp"),
    ContactItemData(
      title: "天竺僧人",
      icon: "images/avatar_webp/chat_23.webp",
      underline: false,
    ),
    'B',
    ContactItemData(title: "段延庆", icon: "images/avatar_webp/chat_33.webp"),
    ContactItemData(title: "令狐冲", icon: "images/avatar_webp/chat_34.webp"),
    ContactItemData(title: "英白罗", icon: "images/avatar_webp/chat_35.webp"),
    ContactItemData(title: "黄药师", icon: "images/avatar_webp/chat_36.webp"),
    ContactItemData(title: "李煜", icon: "images/avatar_webp/chat_37.webp"),
    ContactItemData(title: "云中鹤", icon: "images/avatar_webp/chat_38.webp"),
    ContactItemData(title: "劳德诺", icon: "images/avatar_webp/chat_39.webp"),
    ContactItemData(title: "包惜弱", icon: "images/avatar_webp/chat_40.webp"),
    ContactItemData(title: "游驹", icon: "images/avatar_webp/chat_41.webp"),
    ContactItemData(title: "钟万仇", icon: "images/avatar_webp/chat_42.webp"),
    ContactItemData(title: "渔人", icon: "images/avatar_webp/chat_43.webp"),
    ContactItemData(title: "单叔山", icon: "images/avatar_webp/chat_44.webp"),
    ContactItemData(title: "段誉", icon: "images/avatar_webp/chat_45.webp"),
    ContactItemData(title: "林震南", icon: "images/avatar_webp/chat_46.webp"),
    ContactItemData(title: "商鞅", icon: "images/avatar_webp/chat_47.webp"),
  ];
}
