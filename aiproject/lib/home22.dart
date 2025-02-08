import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_custom_physics.dart';
import 'package:jiaoyishuoflutter3/components/ljn_page_loading.dart';
import 'package:jiaoyishuoflutter3/home_miniprogram.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import 'package:jiaoyishuoflutter3/store/user/cubit/user_cubit.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LJNHome22Page extends StatefulWidget {
  const LJNHome22Page({super.key});

  @override
  State<LJNHome22Page> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<LJNHome22Page>
    with TickerProviderStateMixin {
  final _customScrollController = ScrollController();

  late final List<ChatListItem> chatItems;
  AnimationController? _animationController;

  ScrollPhysics _physics = const MyBouncingScrollPhysics();
  late final AnimationController _lottieController;
  late final AnimationController _bglottieController;
  double initialY = 0.0;
  double deltaY = 0.0;
  double downHomescrollpixels = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SystemCubit>().updateMainpage1isload(true);

      final size = MediaQuery.of(context).size;
      context.read<SystemCubit>().updateScreenSize(size);

      if (kIsWeb) {
        context.read<SystemCubit>().updateStatusHeight(0);
      } else {
        context
            .read<SystemCubit>()
            .updateStatusHeight(MediaQuery.of(context).padding.top);
      }

      context.read<UserCubit>().updateName('李俊杰');
      context.read<UserCubit>().updateAccount('TheMonsterClub');
      context.read<UserCubit>().updatePhone('+8618825130917');
      context.read<UserCubit>().updateWalletBalance(3592.98);
      context.read<UserCubit>().updateWalletFoundationBalance(1005.85);
      context.read<UserCubit>().updateAvatar("images/avatar/my.jpg");
    });

    _lottieController = AnimationController(vsync: this);
    _bglottieController = AnimationController(vsync: this);

    _customScrollController.addListener(scrollListener);

    chatItems = [
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
          badge: 99,
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: <String, String>{
              'title': "文件传输助手",
              'icon': "images/avatar/webwxgeticon.jpg",
            });
            logger.info('文件传输助手~');
          }),
      ChatListItem(
          friendName: "华南理工大学 软件开发群",
          notice: false,
          underline: true,
          message: "这个怎么样调试?",
          avatar: "images/avatar/webwxgetheadimg.jpg",
          lastedTime: "16:40",
          badge: 9,
          onPressed: () {
            Navigator.pushNamed(context, '/group_chat',
                arguments: <String, String>{
                  'title': "华南理工大学 软件开发群",
                  'icon': "images/avatar/webwxgetheadimg.jpg",
                });
            logger.info('华南理工大学 软件开发群被点击~');
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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
          }),
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

  @override
  void dispose() {
    _lottieController.dispose();
    _bglottieController.dispose();
    super.dispose();
  }

  void scrollListener() {
    // 下拉的时候
    if (_customScrollController.position.pixels <= 0) {
      context.read<SystemCubit>().updateHomescrollpixels(
          _customScrollController.position.pixels.abs());
    } else {
      // 上拉
      double newValue = context.read<SystemCubit>().state.homescrollpixels +
          _customScrollController.position.pixels;
      if (newValue < 0) {
        context.read<SystemCubit>().updateHomescrollpixels(newValue);
      } else {
        context.read<SystemCubit>().updateHomescrollpixels(0.0);
      }
    }
  }

  // 恢复
  void reverse() {
    // 使开始位置变成下拉的位置
    _customScrollController.jumpTo(0);
    _animationController!.value =
        context.read<SystemCubit>().state.homescrollpixels;
    _physics = const NeverScrollableScrollPhysics();

    _customScrollController.removeListener(scrollListener);
    _animationController!.reverse().then((_) {
      _customScrollController.jumpTo(0);
      _physics = const MyBouncingScrollPhysics();
      _customScrollController.addListener(scrollListener);

      context.read<SystemCubit>().updateShowMiniProgramDrawer(false);
    });
  }

  double initialCoverLayerHeight = 42.w;

  Size screenSize = Size(0, 0);
  double statusHeight = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
      if (systemState.screenSize == Size.zero ||
          systemState.statusHeight == 0) {
        screenSize = MediaQuery.of(context).size;
        statusHeight = MediaQuery.of(context).padding.top;
      } else {
        screenSize = systemState.screenSize;
        statusHeight = systemState.statusHeight;
      }

      if (_animationController == null) {
        // 这里描述的是appbar的位置, listview依据这个位置进行调整
        _animationController = AnimationController(
          vsync: this,
          lowerBound: 0,
          // 这里到底部是新appbar的高度 + 原本的statusHeight, 因为一个控制器, 既给新的用, 也给旧的用
          upperBound: screenSize.height -
              (statusHeight + 90.w + initialCoverLayerHeight),
          duration: const Duration(milliseconds: 350), // 动画持续时间
        );

        _animationController!.addListener(() {
          context
              .read<SystemCubit>()
              .updateHomescrollpixels(_animationController!.value);
        });
      }

      return systemState.mainpage1isload!
          ? _buildPage(systemState)
          : const LJNPageLoading();
    });
  }

  Widget _buildPage(SystemState systemState) {
    double newAppbarHeight = 90.w + initialCoverLayerHeight;

    // 新appbar透明度
    double percent25Position = screenSize.height * 0.25;
    double coverOpacity =
        ((systemState.homescrollpixels + statusHeight) - percent25Position) /
            (screenSize.height - newAppbarHeight - percent25Position);
    if (coverOpacity < 0) {
      coverOpacity = 0;
    } else if (coverOpacity > 1) {
      coverOpacity = 1;
    }

    double percent75TargetPosition = screenSize.height * 0.75;
    double newAppbarOpacity = ((systemState.homescrollpixels + statusHeight) -
            percent75TargetPosition) /
        (screenSize.height - newAppbarHeight - percent75TargetPosition);
    if (newAppbarOpacity < 0) {
      newAppbarOpacity = 0;
    } else if (newAppbarOpacity > 1) {
      newAppbarOpacity = 1;
    }

    // 顶部动画控制器
    _lottieController.value =
        (systemState.homescrollpixels + statusHeight) / 600.w;
    if (_lottieController.value < 0) {
      _lottieController.value = 0;
    } else if (_lottieController.value > 1) {
      _lottieController.value = 1;
    }

    // 顶部动画背景
    double topLottieOpacity =
        (systemState.homescrollpixels + statusHeight - 400.w) /
            (screenSize.height - newAppbarHeight - 400.w);
    if (topLottieOpacity < 0) {
      topLottieOpacity = 0;
    } else if (topLottieOpacity > 1) {
      topLottieOpacity = 1;
    }

    logger.info(
        "topLottieOpacity: $topLottieOpacity   systemState.homescrollpixels: ${systemState.homescrollpixels}");

    return Stack(
      children: [
        if (systemState.homescrollpixels > 0)
          Image.asset(assetPath("lotties/miniprogrambg.awebp"),
              width: screenSize.width,
              height: screenSize.height,
              fit: BoxFit.cover),

        // // 背景
        // Lottie.asset(
        //   assetPath('lotties/miniprogrambg.json'),
        //   width: screenSize.width,
        //   height: screenSize.height,
        //   fit: BoxFit.fill,
        //   renderCache: RenderCache.raster,
        //   controller: _bglottieController,
        //   animate: true,
        //   backgroundLoading: true,
        //   onLoaded: (composition) {
        //     _bglottieController
        //       ..duration = const Duration(milliseconds: 10000)
        //       ..repeat(); // 使用 repeat() 使动画循环
        //   },
        // ),

        // 小程序, 需要现在在appbar下面
        if (systemState.homescrollpixels > 0)
          Positioned(
            top: 0,
            left: 0,
            // 需要增高一点, 因为Transform.scale缩小后, SingleChildScrollView的高度不能自动适配.
            height:
                systemState.homescrollpixels + (90.w + statusHeight + 200.w),
            width: screenSize.width,
            child: LJNHomeMiniProgram(reverse: reverse),
          ),

        // 列表背景
        if (systemState.homescrollpixels > 0)
          Positioned(
              top: 90.w + statusHeight + systemState.homescrollpixels,
              left: 0,
              // 需要增高一点, 因为Transform.scale缩小后, SingleChildScrollView的高度不能自动适配.
              height: screenSize.height - (90.w + statusHeight),
              width: screenSize.width,
              child: Container(
                color: Colors.white,
              )),

        // 列表
        Positioned(
            // 不能使用systemState.homescrollpixels, 需要用_animationController!.value
            top: 90.w + statusHeight + _animationController!.value,
            left: 0,
            width: screenSize.width,
            height: screenSize.height - (90.w + statusHeight),
            child: Listener(
                onPointerUp: (event) {
                  logger
                      .info("释放那一刻 ${_customScrollController.position.pixels}");
                  if (_customScrollController.position.pixels < -100) {
                    // _forwarding = true;
                    logger.info(
                        "this is systemState.homescrollpixels: ${systemState.homescrollpixels}");

                    // ???
                    _animationController!.value = systemState.homescrollpixels;
                    _customScrollController.jumpTo(0);
                    _physics = const NeverScrollableScrollPhysics();

                    context
                        .read<SystemCubit>()
                        .updateShowMiniProgramDrawer(true);

                    _customScrollController.removeListener(scrollListener);

                    _animationController!.forward().then((_) {
                      _customScrollController.jumpTo(0);
                      _physics = const MyBouncingScrollPhysics();
                      _customScrollController.addListener(scrollListener);
                    });
                  }
                },
                child: ScrollConfiguration(
                    behavior: CustomScrollBehavior().copyWith(
                      scrollbars: false,
                      physics: _physics,
                    ),
                    child: ListView.builder(
                      primary: false,
                      padding: EdgeInsets.only(bottom: 106.w),
                      // padding: EdgeInsets.all(0.w),
                      itemCount: chatItems.length,
                      shrinkWrap: true,
                      controller: _customScrollController,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return chatItems[index];
                      },
                    )))),

        // 三个点点动画
        if (topLottieOpacity != 1)
          Opacity(
              opacity: 1 - topLottieOpacity,
              child: Container(
                  color: const Color.fromARGB(255, 237, 237, 237),
                  width: screenSize.width,
                  height: systemState.homescrollpixels + (90.w + statusHeight),
                  // padding: EdgeInsets.only(top: statusHeight),
                  child: _lottieController.isCompleted
                      ? null
                      : Lottie.asset(
                          assetPath('lotties/homeminiprogramdarwing.json'),
                          width: screenSize.width,
                          height: systemState.homescrollpixels +
                              statusHeight +
                              90.w,
                          fit: BoxFit.contain,
                          renderCache: RenderCache.drawingCommands,
                          controller: _lottieController,
                          onLoaded: (composition) {
                            // _lottieController
                            //   ..duration = const Duration(milliseconds: 600)
                            //   ..forward();
                          },
                        ))),

        // 新appbar
        if ((systemState.homescrollpixels + statusHeight) > percent25Position)
          Positioned(
              height: 90.w +
                  (screenSize.height -
                      (systemState.homescrollpixels + statusHeight + 90.w)),
              width: 750.w,
              top: systemState.homescrollpixels + statusHeight,
              child: Listener(
                  onPointerDown: (event) {
                    // 记录手指按下时的 Y 轴位置
                    initialY = event.position.dy;
                    downHomescrollpixels = systemState.homescrollpixels;
                  },
                  onPointerMove: (event) {
                    logger.info('Y轴移动距离: $deltaY');

                    // 不允许下拉, 只允许上拉
                    if (initialY < event.position.dy) {
                      return;
                    }

                    // 计算手指在Y轴上移动的距离
                    deltaY = event.position.dy - initialY;

                    double newHomescrollpixels =
                        downHomescrollpixels - deltaY.abs();

                    context
                        .read<SystemCubit>()
                        .updateHomescrollpixels(newHomescrollpixels);

                    _animationController!.value = newHomescrollpixels;
                  },
                  onPointerUp: (event) {
                    // 恢复
                    reverse();
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // App标题栏
                        ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.w),
                              topRight: Radius.circular(12.w),
                            ),
                            child: AppBar(
                              primary: false,
                              title: const Text("微信"),
                              centerTitle: true,
                              titleTextStyle: TextStyle(
                                  height: 1.08,
                                  fontSize: fontSizeScale(32.w),
                                  color: Colors.white,
                                  fontFamily: "AlibabaPuHuiTi-Medium"),
                              toolbarHeight: 90.w,
                              elevation: 0,
                              scrolledUnderElevation: 0,
                              backgroundColor: Color.fromARGB(
                                  (newAppbarOpacity * 255).toInt(),
                                  121,
                                  115,
                                  149),
                              foregroundColor: Color.fromARGB(
                                  (newAppbarOpacity * 255).toInt(),
                                  121,
                                  115,
                                  149),
                              actions: [
                                Container(
                                  color: Colors.transparent,
                                  height: 90.w,
                                  padding:
                                      EdgeInsets.only(right: 33.w), // 设置右侧内边距
                                  alignment: Alignment.center,

                                  child: Icon(
                                    color: Colors.white,
                                    const IconData(
                                      0xe612,
                                      fontFamily: 'Iconfont',
                                    ),
                                    size: 40.w, // 图标大小
                                  ),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  height: 90.w,
                                  padding:
                                      EdgeInsets.only(right: 40.w), // 设置右侧内边距
                                  child: Icon(
                                    color: Colors.white,
                                    const IconData(
                                      0xe726,
                                      fontFamily: 'Iconfont',
                                    ),
                                    size: 42.w, // 图标大小
                                  ),
                                ),
                              ],
                            )),

                        // AppBar底部遮挡层
                        Opacity(
                            // opacity: 0.5,
                            opacity: coverOpacity,
                            child: Container(
                              height: screenSize.height -
                                  (systemState.homescrollpixels +
                                      statusHeight +
                                      90.w),
                              child: null,
                              color: const Color.fromARGB(255, 121, 115, 149),
                            ))
                      ]))),
      ],
    );
  }
}

class ChatListItem extends StatefulWidget {
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
    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                          8.0.w), // Adjust the radius as needed
                      child: Image.asset(
                        assetPath(widget.avatar),
                        width: 90.0.w,
                        height: 90.0.w,
                        cacheHeight: 180.w.toInt(),
                        cacheWidth: 180.w.toInt(),
                        fit: BoxFit.cover,
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
                                      height: 1.08,
                                      forceStrutHeight: true,
                                      fontSize: 31.w),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    children: buildTextSpans(
                                        widget.friendName,
                                        TextStyle(
                                            height: 1.08,
                                            fontSize: fontSizeScale(31.0.w),
                                            color: widget.notice
                                                ? Colors.red
                                                : Colors.black,
                                            fontFamily: "AlibabaPuHuiTi"),
                                        TextStyle(
                                            height: 1.08,
                                            fontSize: fontSizeScale(31.w),
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
                                    // fontFamily: "Roboto-Regular",
                                    fontSize: fontSizeScale(23.0.w),
                                    color: widget.notice
                                        ? Colors.red
                                        : const Color.fromARGB(
                                            255, 170, 170, 170),
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

                                // 铃铛
                                Container(
                                  width: 30.w,
                                  height: 30.w,
                                  // color: Colors.red,
                                  margin:
                                      EdgeInsets.only(left: 30.w, right: 30.w),
                                  child: widget.notice
                                      ? Icon(
                                          const IconData(
                                            0xe606,
                                            fontFamily: 'Iconfont',
                                          ),
                                          size: 28.0.w,
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
                              fontFamily: "LJNFont"),
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
    });
  }
}
