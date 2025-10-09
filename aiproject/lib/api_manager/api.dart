import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/store/ljn_popup_cubit.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_chatlist_item.dart';
import 'package:vigaviga/widgets/ljn_contact_item.dart';
import 'package:vigaviga/screens/contract/chat/widgets/ljn_my_message.dart';
import 'package:vigaviga/screens/contract/chat/widgets/ljn_receive_message.dart';
import 'package:vigaviga/screens/contract/chat/widgets/ljn_receive_video_message.dart';
import 'package:vigaviga/screens/contract/chat/widgets/ljn_video_message.dart';

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

// 聊天消息
List<Widget> mockMessages(BuildContext context, String icon, String title) {
  final List<Widget> mockMessages = [
    const LJNMyMessage(
      message: '今晚，我们开始吧，准备好了吗？',
      showName: false,
    ),
    LJNReceiveMessage(
      message: '嗯，准备好了。虽然有点紧张，但我知道我们已经决定了。',
      showName: false,
      friendAvatar: icon,
      name: title,
    ),
    const LJNMyMessage(
      message: '我也是。虽然我们之前谈了很多次，但真的要开始时，心里还是有些忐忑。',
      showName: false,
    ),
    LJNReceiveMessage(
      message: '我也是。突然想到，万一不能顺利怀上怎么办？',
      showName: false,
      friendAvatar: icon,
      name: title,
    ),
    const LJNMyMessage(
      message: '别担心，慢慢来。就算不顺利，我们也会一起面对，不急的。最重要的是我们愿意一起尝试，给自己一个机会。',
      showName: false,
    ),
    LJNReceiveMessage(
      message: '你说得对，我只是怕自己压力太大，万一做不到怎么办。',
      showName: false,
      friendAvatar: icon,
      name: title,
    ),
    const LJNMyMessage(
      message: '我们做不到的事很少，我相信我们能行。而且，压力大了，放轻松点，别太给自己太多负担。',
      showName: false,
    ),
    LJNReceiveMessage(
      message: '嗯，我知道。你也知道，我的身体不是那么好，可能会有点麻烦。',
      showName: false,
      friendAvatar: icon,
      name: title,
    ),
    const LJNMyMessage(
      message: '我知道，但我们一起走这条路，不管怎么样，我们都有彼此支持。我会陪着你，咱们不会有任何困难是过不去的。',
      showName: false,
    ),
    LJNReceiveMessage(
      message: '有你在我身边，我就不怕了。你觉得，如果不顺利，我们也不应该急对吧？',
      showName: false,
      friendAvatar: icon,
      name: title,
    ),
    const LJNMyMessage(
      message: '对，别急，顺其自然。如果真有问题，我们可以一起去看医生，解决的办法总有的。',
      showName: false,
    ),
    LJNReceiveMessage(
      message: '嗯，既然你这么说，我也放心了。',
      showName: false,
      friendAvatar: icon,
      name: title,
    ),
    LJNReceiveMessage(
      message: '其实，我一直很期待有个孩子，能有一个属于我们的家庭。',
      showName: false,
      friendAvatar: icon,
      name: title,
    ),
    const LJNMyMessage(
      message: '我也是。我们将来可以一起看他成长，一起陪着他做作业、玩游戏，甚至一起教他做事。',
      showName: false,
    ),
    LJNReceiveMessage(
      message: '你觉得我们的孩子会是什么样的？像你，还是像我？',
      showName: false,
      friendAvatar: icon,
      name: title,
    ),
    const LJNMyMessage(
      message: '不管像谁，都一定是最棒的。',
      showName: false,
    ),
    const LJNMyMessage(
      message: '但我想，他应该会有你的聪明和我的耐心，能很好地适应生活中的挑战。',
      showName: false,
    ),
    LJNReceiveMessage(
      message: '那也太完美了吧。希望他能继承我们的优点，少一些缺点。',
      showName: false,
      friendAvatar: icon,
      name: title,
    ),
    const LJNMyMessage(
      message: '无论如何，我们都得给他一个充满爱的家庭，这才是最重要的。',
      showName: false,
    ),
    const LJNMyMessage(
      message: '今晚，就是我们的开始了。',
      showName: false,
    ),
    LJNReceiveMessage(
      message: '是的，今晚开始。未来的路我们一起走。',
      showName: false,
      friendAvatar: icon,
      name: title,
    ),
    const LJNMyMessage(
      message: '今晚，我们做的每一步，都是为了未来的孩子，都是为了我们共同的未来。',
      showName: false,
    ),
    LJNReceiveMessage(
      message: '嗯，今晚我们就开始，未来的一切，交给时间。',
      showName: false,
      friendAvatar: icon,
      name: title,
    ),
    LJNReceiveMessage(
      message: '你准备好了吗？',
      showName: false,
      friendAvatar: icon,
      name: title,
    ),
    const LJNMyMessage(
      message: '准备好了，永远准备好。',
      showName: false,
    ),
    LJNVideoMessage(
      video: 'images/ins/test.mp4',
      width: 768,
      height: 576,
      showName: false,
      onTap: (Offset position, Size size) {
        // 关闭键盘
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        context.read<LJNPopupCubit>().updateVideoPopup(
              openBoxSize: size,
              openPosition: position,
              sourcePath: 'images/ins/test.mp4',
              showFullScreenVideo: true,
            );
      },
    ),
    LJNVideoMessage(
      video: 'images/ins/video2.mp4',
      width: 576,
      height: 1024,
      showName: false,
      onTap: (Offset position, Size size) {
        // 关闭键盘
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        context.read<LJNPopupCubit>().updateVideoPopup(
              openBoxSize: size,
              openPosition: position,
              sourcePath: 'images/ins/video2.mp4',
              showFullScreenVideo: true,
            );
      },
    ),
    LJNReceiveVideoMessage(
      video: 'images/ins/video2.mp4',
      width: 576,
      height: 1024,
      showName: false,
      friendAvatar: icon,
      name: title,
      onTap: (Offset position, Size size) {
        // 关闭键盘
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        context.read<LJNPopupCubit>().updateVideoPopup(
              openBoxSize: size,
              openPosition: position,
              sourcePath: 'images/ins/video2.mp4',
              showFullScreenVideo: true,
            );
      },
    ),
  ];

  return mockMessages;
}

// 数据模型，用于存储不依赖 context 的静态数据
class TagInfoData {
  final String title;
  final String icon;
  final bool underline;

  const TagInfoData({
    required this.title,
    required this.icon,
    this.underline = true,
  });
}

List<TagInfoData> getTagInfoData() {
  return [
    TagInfoData(title: "天空飘来五个字那都不是事", icon: "images/avatar_webp/chat_1.webp"),
    TagInfoData(title: "本因", icon: "images/avatar_webp/chat_10.webp"),
    TagInfoData(title: "赵洵", icon: "images/avatar_webp/chat_11.webp"),
    TagInfoData(title: "定静师太", icon: "images/avatar_webp/chat_12.webp"),
    TagInfoData(title: "李秋水", icon: "images/avatar_webp/chat_13.webp"),
    TagInfoData(title: "谭婆", icon: "images/avatar_webp/chat_14.webp"),
    TagInfoData(title: "李傀儡", icon: "images/avatar_webp/chat_15.webp"),
    TagInfoData(title: "貂禅", icon: "images/avatar_webp/chat_16.webp"),
    TagInfoData(title: "何三七", icon: "images/avatar_webp/chat_17.webp"),
    TagInfoData(title: "孔融", icon: "images/avatar_webp/chat_18.webp"),
    TagInfoData(title: "齐堂主", icon: "images/avatar_webp/chat_19.webp"),
    TagInfoData(title: "博尔术", icon: "images/avatar_webp/chat_20.webp"),
    TagInfoData(title: "王语嫣", icon: "images/avatar_webp/chat_21.webp"),
    TagInfoData(title: "秦红棉", icon: "images/avatar_webp/chat_22.webp"),
    TagInfoData(
        title: "天竺僧人",
        icon: "images/avatar_webp/chat_23.webp",
        underline: false),
    TagInfoData(title: "段延庆", icon: "images/avatar_webp/chat_33.webp"),
    TagInfoData(title: "令狐冲", icon: "images/avatar_webp/chat_34.webp"),
    TagInfoData(title: "英白罗", icon: "images/avatar_webp/chat_35.webp"),
    TagInfoData(title: "黄药师", icon: "images/avatar_webp/chat_36.webp"),
    TagInfoData(title: "李煜", icon: "images/avatar_webp/chat_37.webp"),
    TagInfoData(title: "云中鹤", icon: "images/avatar_webp/chat_38.webp"),
    TagInfoData(title: "劳德诺", icon: "images/avatar_webp/chat_39.webp"),
    TagInfoData(title: "包惜弱", icon: "images/avatar_webp/chat_40.webp"),
    TagInfoData(title: "游驹", icon: "images/avatar_webp/chat_41.webp"),
    TagInfoData(title: "钟万仇", icon: "images/avatar_webp/chat_42.webp"),
    TagInfoData(title: "渔人", icon: "images/avatar_webp/chat_43.webp"),
    TagInfoData(title: "单叔山", icon: "images/avatar_webp/chat_44.webp"),
    TagInfoData(title: "段誉", icon: "images/avatar_webp/chat_45.webp"),
    TagInfoData(title: "林震南", icon: "images/avatar_webp/chat_46.webp"),
    TagInfoData(title: "商鞅", icon: "images/avatar_webp/chat_47.webp"),
  ];
}

List getTweetList() {
  return [
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_1.webp',
      "name": "李珣🐞",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "imageList": const [
        'images/avatar_webp/chat_1.webp',
        'images/avatar_webp/chat_2.webp',
        'images/avatar_webp/chat_3.webp',
        'images/avatar_webp/chat_4.webp',
        'images/avatar_webp/chat_5.webp',
        'images/avatar_webp/chat_6.webp',
        'images/avatar_webp/chat_7.webp',
        'images/avatar_webp/chat_8.webp',
        'images/avatar_webp/chat_9.webp',
      ],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_2.webp',
      "name": "西宝✨",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_5.webp',
      "name": "史登达",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "imageList": const [
        'images/avatar_webp/chat_8.webp',
        'images/avatar_webp/chat_9.webp',
        'images/avatar_webp/chat_10.webp',
        'images/avatar_webp/chat_11.webp',
        'images/avatar_webp/chat_12.webp',
        'images/avatar_webp/chat_13.webp',
      ],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_8.webp',
      "name": "平婆婆",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "imageList": const [
        'images/avatar_webp/chat_8.webp',
        'images/avatar_webp/chat_11.webp',
        '',
        'images/avatar_webp/chat_12.webp',
        'images/avatar_webp/chat_13.webp',
      ],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_9.webp',
      "name": "哑梢公💖👉🫖",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "imageList": const [
        'images/avatar_webp/chat_15.webp',
        'images/avatar_webp/chat_16.webp',
        'images/avatar_webp/chat_17.webp',
        'images/avatar_webp/chat_18.webp',
        'images/avatar_webp/chat_19.webp',
      ],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_60.webp',
      "name": "余兆兴",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_65.webp',
      "name": "云中鹤",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "imageList": const [
        'images/avatar_webp/chat_20.webp',
        'images/avatar_webp/chat_21.webp',
        'images/avatar_webp/chat_22.webp',
        'images/avatar_webp/chat_23.webp',
        'images/avatar_webp/chat_24.webp',
        'images/avatar_webp/chat_25.webp',
      ],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_52.webp',
      "name": "农夫",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "imageList": const [
        'images/avatar_webp/chat_28.webp',
        'images/avatar_webp/chat_29.webp',
        'images/avatar_webp/chat_30.webp',
        'images/avatar_webp/chat_31.webp',
        'images/avatar_webp/chat_32.webp',
        'images/avatar_webp/chat_33.webp',
        'images/avatar_webp/chat_34.webp',
      ],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_43.webp',
      "name": "贾人达",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_47.webp',
      "name": "段正明",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_35.webp',
      "name": "易堂主",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
    {
      "time": "一分钟前",
      "avatarUrl": 'images/avatar_webp/chat_80.webp',
      "name": "钟镇",
      "likes": ["刘德华💖", "周杰伦", "王菲", "张学友", "李宇春💖", "特朗普", "史泰龙", "阿诺舒华"],
      "tweetContent": "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。早安☀️"
    },
  ];
}
