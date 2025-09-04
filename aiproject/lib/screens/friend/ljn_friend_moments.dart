import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_custom_physics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_popup_cubit.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_spans.dart';
import 'package:vigaviga/widgets/ljn_text_spans.dart';
import '../../tools/ljn_logger.dart';

late AnimationController _bgController;

class LJNFriendmoments extends StatefulWidget {
  const LJNFriendmoments({super.key});

  @override
  State<LJNFriendmoments> createState() => _LJNFriendmoments();
}

class _LJNFriendmoments extends State<LJNFriendmoments>
    with TickerProviderStateMixin {
  ScrollController? _scrollController;
  double scrollPosition = 0;

  late AnimationController _appBarcontroller; // 动画控制器
  late Animation<double> _appBarOpacity; // 透明度动画

  late List<Map<String, dynamic>> tweetList;

  // 最后点击更多的位置
  late Offset lastedMoreButtonPosition = const Offset(-1000, -1000);
  late bool likeBoxVisible = false;
  // 列表是否在滚动
  late bool _isScrolling = false;

  late AnimationController _likeController;
  late Animation<double> _likeAnimation;
  // late Animation<double> _bgAnimation;

  // 显示满屏视频
  bool showFullScreenVideo = false;
  Offset openPosition = const Offset(0, 0);
  Size openBoxSize = const Size(0, 0);
  String videoPath = "";

  @override
  void initState() {
    super.initState();

    // 初始化 AnimationController
    _appBarcontroller = AnimationController(
      duration: const Duration(seconds: 1), // 动画持续时间
      vsync: this,
    );

    // 定义透明度动画
    _appBarOpacity =
        Tween<double>(begin: 0.0, end: 255.0).animate(_appBarcontroller);

    // 点赞窗口AnimationController
    _likeController = AnimationController(
      duration: const Duration(milliseconds: 300), // 动画持续时间
      reverseDuration: const Duration(milliseconds: 100), // 动画持续时间
      vsync: this,
    );

    // 背景AnimationController
    _bgController = AnimationController(
      duration: const Duration(milliseconds: 150), // 动画持续时间
      reverseDuration: const Duration(milliseconds: 100), // 动画持续时间
      vsync: this,
    );

    // 背景动画
    // _bgAnimation =
    //     Tween<double>(begin: 360.w, end: 0.w).animate(CurvedAnimation(
    //   parent: _bgController,
    //   curve: Curves.easeInOut, // 这里设置加速曲线
    // ))
    //       ..addListener(() {
    //         setState(() {});
    //       });

    // 创建Tween来控制 left 从 360.w 到 0.w 的动画
    _likeAnimation =
        Tween<double>(begin: 360.w, end: 0.w).animate(CurvedAnimation(
      parent: _likeController,
      curve: Curves.easeInOut, // 这里设置加速曲线
    ))
          ..addListener(() {
            setState(() {});
          });

    // Tweet数据
    tweetList = [
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

  @override
  void dispose() {
    _scrollController!.dispose(); // 避免内存泄漏
    _appBarcontroller.dispose(); // 释放资源
    _likeController.dispose();
    super.dispose();
  }

  void showLikeBox(Offset position) {
    logger.info("来了吗?");

    setState(() {
      _likeController.forward();
      lastedMoreButtonPosition = position;
      likeBoxVisible = true;
    });
  }

  void hideLikeBox({required bool quick}) {
    if (quick) {
      _likeController.value = 0;
      lastedMoreButtonPosition = const Offset(-1000, -1000);
      likeBoxVisible = false;
    } else {
      setState(() {
        // _likeController.stop();
        _likeController.reverse().then((_) {
          lastedMoreButtonPosition = const Offset(-1000, -1000);
          likeBoxVisible = false;
        });
      });
    }
  }

  void _scrollListener() {
    // logger.info("pixels:${_scrollController.position.pixels}");
    // logger.info("minScrollExtent:${_scrollController.position.minScrollExtent}");
    // logger.info("maxScrollExtent:${_scrollController.position.maxScrollExtent}");
    double beginPosition =
        context.read<LJNSystemCubit>().state.statusHeight + 450.w;

    setState(() {
      scrollPosition = _scrollController!.position.pixels;

      if (_scrollController!.position.pixels - beginPosition <= 0) {
        _appBarcontroller.value = 0;
      } else {
        _appBarcontroller.value =
            (_scrollController!.position.pixels - beginPosition) /
                (beginPosition + 40.w - beginPosition);
      }
    });

    hideLikeBox(quick: true);
  }

  @override
  Widget build(BuildContext context) {
    if (_scrollController == null) {
      _scrollController = ScrollController();
      // 添加监听器以监控滚动
      _scrollController!.addListener(_scrollListener);
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        if (_bgController.isCompleted) {
          _bgController.reverse();
          return;
        }

        if (context.read<LJNPopupCubit>().state.showFullScreenVideo == true ||
            context.read<LJNPopupCubit>().state.showFullScreenImage == true) {
          context.read<LJNPopupCubit>().updateReturnButtonEvent(true);
        } else {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
          return Scaffold(
            primary: false,
            appBar: null,
            body: Stack(
              children: [
                // 背景
                _buildBackground(),

                // 使用 ListView
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true, // 移除顶部的padding
                  child: Stack(children: [
                    GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        hideLikeBox(quick: true);
                      },
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification notification) {
                          if (notification is ScrollUpdateNotification) {
                            // 用户正在滚动
                            setState(() {
                              _isScrolling = true;
                            });
                          } else if (notification is ScrollEndNotification) {
                            // 用户停止滚动
                            setState(() {
                              _isScrolling = false;
                            });
                          }
                          return true; // 返回 true 表示已处理该通知
                        },
                        child: ScrollConfiguration(
                          behavior: CustomScrollBehavior().copyWith(
                            scrollbars: false,
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            // physics: const ClampingScrollPhysics(),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            // addAutomaticKeepAlives: false,
                            primary: false,
                            controller: _scrollController,
                            itemCount: tweetList.length + 1, // +1 是因为还包含头像部分
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                // 头像及背景信息部分
                                return AnimatedBuilder(
                                  animation: _bgController,
                                  builder: (context, child) {
                                    return Container(
                                      height:
                                          (systemState.statusHeight + 630.w) +
                                              (600.w * _bgController.value),
                                      alignment: Alignment.center,
                                      color: _bgController.isAnimating ||
                                              _bgController.isCompleted
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                          : AppColors.neutralWhite,
                                      width: 750.w,
                                      child: Stack(
                                        children: [
                                          // 背景图片
                                          GestureDetector(
                                            onTap: () {
                                              if (!_bgController.isCompleted) {
                                                _bgController.forward();
                                              } else {
                                                _bgController.reverse();
                                              }
                                            },
                                            child: Transform.translate(
                                              offset: _bgController.isCompleted
                                                  ? Offset(0, 0)
                                                  : Offset(0, -100.w),
                                              child: AnimatedBuilder(
                                                animation: _bgController,
                                                builder: (context, child) {
                                                  return Image.asset(
                                                    assetPath(
                                                        'images/avatar/fj.jpg'),
                                                    cacheWidth: 1500.w.toInt(),
                                                    cacheHeight: (systemState
                                                                .statusHeight +
                                                            1260.w)
                                                        .toInt(),
                                                    width: 750.w,
                                                    height: _bgController
                                                            .isCompleted
                                                        ? (systemState
                                                                    .statusHeight +
                                                                630.w) +
                                                            (600.w *
                                                                _bgController
                                                                    .value)
                                                        : 730.w,
                                                    fit: _bgController
                                                            .isCompleted
                                                        ? BoxFit.contain
                                                        : BoxFit.cover,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),

                                          // 头像及昵称
                                          Transform.translate(
                                              offset: Offset(
                                                  0,
                                                  systemState.statusHeight +
                                                      460.w +
                                                      (_bgController.value *
                                                          300.w)),
                                              child: Opacity(
                                                opacity:
                                                    1 - _bgController.value,
                                                child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context, '/userinfo');
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 35.w,
                                                      ),
                                                      width: 750.w,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          // 昵称
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              right: 15.w,
                                                              top: 5.w,
                                                            ),
                                                            child: Text(
                                                              context
                                                                  .read<
                                                                      LJNUserCubit>()
                                                                  .state
                                                                  .userinfoName!,
                                                              style: TextStyle(
                                                                height: 1.08,
                                                                fontSize:
                                                                    fontSizeScale(
                                                                  40.w,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                        .circular(
                                                                            10)
                                                                    .w,
                                                            child: Image.asset(
                                                              assetPath(context
                                                                  .read<
                                                                      LJNUserCubit>()
                                                                  .state
                                                                  .userinfoAvatar!),
                                                              cacheWidth:
                                                                  240.w.toInt(),
                                                              cacheHeight:
                                                                  240.w.toInt(),
                                                              width: 120.w,
                                                              height: 120.w,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              )),

                                          // 更换背景按钮
                                          _bgController.isCompleted
                                              ? Positioned(
                                                  bottom: 30.w,
                                                  right: 30.w,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          "/friend_moments_cover_setting");
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          const IconData(0xe68a,
                                                              fontFamily:
                                                                  'Iconfont'),
                                                          size: 40.w,
                                                          color: AppColors
                                                              .neutralWhite,
                                                        ),
                                                        SizedBox(height: 5.w),
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .changeCover,
                                                          style: TextStyle(
                                                            fontSize: 22.w,
                                                            color: AppColors
                                                                .neutralWhite,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else {
                                // Tweet列表
                                var tweet = tweetList[index - 1]; // 减去头像部分
                                return TweetWidget(
                                    time: tweet["time"]!,
                                    avatarUrl: tweet["avatarUrl"]!,
                                    name: tweet["name"]!,
                                    tweetContent: tweet["tweetContent"]!,
                                    likes: tweet["likes"],
                                    imageList: tweet["imageList"],
                                    moreOnPress: (Offset position) {
                                      logger.info("来了咩?");

                                      // 如果列表在滚动, 则更多按钮不能被点击
                                      if (_isScrolling) return;

                                      if (likeBoxVisible) {
                                        hideLikeBox(quick: false);
                                      } else {
                                        showLikeBox(position);
                                      }
                                    });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),

                // 点赞弹框
                _buildLikeBox(),

                // 顶部透明 AppBar
                Container(
                  color: Color.fromARGB(
                      _appBarOpacity.value.toInt(), 237, 237, 237),
                  width: 750.w,
                  height: 90.0.w + systemState.statusHeight,
                  padding: EdgeInsets.only(top: systemState.statusHeight),
                  child: AppBar(
                    primary: false,
                    title: Text(AppLocalizations.of(context)!.moments),
                    centerTitle: true,
                    titleTextStyle: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(32.w),
                      color:
                          Color.fromARGB(_appBarOpacity.value.toInt(), 0, 0, 0),
                      fontFamily: "AlibabaPuHuiTi-Medium",
                    ),
                    toolbarHeight: 90.w,
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    backgroundColor: AppColors.transparent,
                    foregroundColor: AppColors.transparent,
                    leading: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        color: AppColors.transparent,
                        child: Icon(
                          const IconData(0xed9e, fontFamily: 'Iconfont'),
                          color: _appBarOpacity.value.toInt() > 180
                              ? Theme.of(context).colorScheme.onSurface
                              : AppColors.neutralWhite,
                          size: 36.w,
                        ),
                      ),
                    ),
                    actions: [
                      // 照相机
                      AnimatedBuilder(
                        animation: _bgController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _bgController.value * -300.w),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                color: AppColors.transparentRed,
                                height: 90.w,
                                padding: EdgeInsets.only(right: 40.w),
                                alignment: Alignment.center,
                                child: _appBarOpacity.value.toInt() > 180
                                    ? Icon(
                                        const IconData(0xe68a,
                                            fontFamily: 'Iconfont'),
                                        size: 40.w,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      )
                                    : Icon(
                                        const IconData(0xe64d,
                                            fontFamily: 'Iconfont'),
                                        size: 40.w,
                                        color: AppColors.neutralWhite,
                                      ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      width: 750.w,
      height: 530.w,
      color: AppColors.neutralDarkGrey18,
    );
  }

  // 点赞盒子
  Widget _buildLikeBox() {
    return Positioned(
      top: lastedMoreButtonPosition.dy,
      left: lastedMoreButtonPosition.dx,
      child: SizedBox(
        width: 360.w,
        height: 75.w,
        // color: AppColors.accentRedDark1, // 外层盒子的红色背景
        child: Stack(
          children: [
            // 红色盒子本身
            Positioned(
              top: 0,
              left: _likeAnimation.value,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 0.w),
                width: 360.w,
                height: 75.w,
                decoration: BoxDecoration(
                  color: AppColors.neutralDarkGrey12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.w),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Baseline(
                            baseline: 22.w,
                            baselineType: TextBaseline.alphabetic,
                            child: Icon(
                              const IconData(
                                0xe682,
                                fontFamily: 'Iconfont',
                              ),
                              color: AppColors.neutralWhite,
                              size: 31.w,
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: SizedBox(width: 8.w),
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.like,
                          style: TextStyle(
                            height: 1.08,
                            fontSize: 28.w,
                            color: AppColors.neutralWhite,
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      height: 45.w,
                      width: 2.w,
                      color: AppColors.neutralGrey65,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            style: const TextStyle(height: 1.08),
                            child: Icon(
                              const IconData(0xe605, fontFamily: 'Iconfont'),
                              color: AppColors.neutralWhite,
                              size: 28.w,
                            ),
                          ),
                          WidgetSpan(
                            child: SizedBox(width: 8.w),
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!.comment,
                            style: TextStyle(
                              height: 1.08,
                              fontSize: 28.w,
                              color: AppColors.neutralWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TweetWidget extends StatefulWidget {
  final String time;
  final String avatarUrl;
  final String name;
  final String tweetContent;
  final List<String>? imageList;
  final List<String>? likes;
  final Function moreOnPress;

  const TweetWidget(
      {super.key,
      required this.time,
      required this.avatarUrl,
      required this.name,
      required this.tweetContent,
      this.likes,
      this.imageList,
      required this.moreOnPress});

  @override
  State<TweetWidget> createState() => _TweetWidget();
}

// 推文
class _TweetWidget extends State<TweetWidget> {
  // 生成随机数
  int generateRandomNumber() {
    var random = Random();
    return random.nextInt(103) + 1; // 生成1到103的随机数
  }

  final List<TapGestureRecognizer> _recognizers = [];

  // 最后点击更多位置
  late Offset morePosition;

  late GlobalKey _morekey;

  @override
  void initState() {
    super.initState();

    _morekey = GlobalKey();
  }

  @override
  void dispose() {
    // 非常重要：释放所有 recognizer，防止内存泄漏
    for (var recognizer in _recognizers) {
      recognizer.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List textSpans = [];

    for (int index = 0; index < widget.likes!.length; index++) {
      final name = widget.likes![index];

      // 1. 为每个名字创建一个 TapGestureRecognizer
      final recognizer = TapGestureRecognizer()
        ..onTap = () {
          // 在这里处理点击事件
          logger.info('Tapped on: $name');
          Navigator.pushNamed(context, '/chat', arguments: <String, String>{
            'title': name,
            'icon': "images/avatar_webp/chat_17.webp",
          });
        };
      _recognizers.add(recognizer);

      var item = TextSpan(
          recognizer: recognizer,
          children: LJNBuildspan(
            context,
            name,
            TextStyle(
              // textBaseline: TextBaseline.alphabetic,
              height: 1.08,
              fontSize: fontSizeScale(28.w),
              color: AppColors.brandBlueDark4,
              fontFamily: "AlibabaPuHuiTi-Medium",
            ),
            TextStyle(
              // textBaseline: TextBaseline.alphabetic,
              height: 1.08,
              fontSize: fontSizeScale(28.w),
              fontFamily: "NotoColorEmoji-Regular",
            ),
          ));

      textSpans.add(item);

      if (index != widget.likes!.length - 1) {
        // 逗号
        textSpans.add(
          TextSpan(
            text: ", ",
            style: TextStyle(
              height: 1.08,
              fontSize: fontSizeScale(28.w),
              color: AppColors.brandBlueDark4,
              fontFamily: "AlibabaPuHuiTi-Medium",
            ),
          ),
        );
      }
    }

    return Listener(
      onPointerDown: (event) {
        if (_bgController.isCompleted) {
          _bgController.reverse();
        }
      },
      child: Container(
        width: 750.w,
        padding: EdgeInsets.only(top: 22.w, bottom: 22.w),
        decoration: BoxDecoration(
          color: AppColors.neutralWhite,
          border: Border(
            top: BorderSide(
              color: AppColors.neutralWhite,
              width: 0.w,
            ),
            bottom: BorderSide(
              color: Theme.of(context).listTileTheme.selectedTileColor!,
              width: 1.5.w,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 37.w,
            ),

            // 头像
            ClipRRect(
              borderRadius: BorderRadius.circular(10).w,
              child: Image.asset(
                assetPath(widget.avatarUrl),
                cacheWidth: 154.w.toInt(),
                cacheHeight: 154.w.toInt(),
                width: 77.w,
                height: 77.w,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(
              width: 20.w,
            ),

            // 姓名和推文
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 推文整体
                  Container(
                    margin: EdgeInsets.only(right: 25.w),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // 姓名
                          LJNTextSpans(
                            strutStyle: StrutStyle(
                                // height: 1,
                                // forceStrutHeight: true,
                                fontSize: 32.w,
                                leading: 1.w),
                            text: widget.name,
                            style: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(32.w),
                              fontFamily: "AlibabaPuHuiTi-Medium",
                              // fontWeight: FontWeight.w600,
                              color: AppColors.brandBlueDark4,
                            ),
                            emojiStyle: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(32.w),
                            ),
                          ),
                          // 推文
                          LJNTextSpans(
                            strutStyle: StrutStyle(
                                // height: 1,
                                // forceStrutHeight: true,
                                fontSize: 32.w),
                            text: widget.tweetContent,
                            style: TextStyle(
                              // textBaseline: TextBaseline.alphabetic,
                              height: 1.4,
                              fontSize: fontSizeScale(32.w),
                              fontFamily: "AlibabaPuHuiTi",
                            ),
                            emojiStyle: TextStyle(
                              // textBaseline: TextBaseline.alphabetic,
                              height: 1.08,
                              fontSize: fontSizeScale(32.w),
                              fontFamily: "NotoColorEmoji-Regular",
                            ),
                          ),

                          SizedBox(height: 10.w),

                          // 九宫格
                          if (widget.imageList != null) ...[
                            SizedBox(
                              width: 570.w,
                              child: Wrap(
                                spacing: 6.w, // 设置列间距
                                runSpacing: 6.w, // 设置行间距
                                children: widget.imageList!.map((imagePath) {
                                  if (imagePath == '') {
                                    return const SizedBox();
                                  } else {
                                    return LJNTweenImage(
                                      imagePath: imagePath,
                                      onTap: (Offset position, Size size) {},
                                    );
                                  }
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: 18.w),
                          ],

                          // 定位信息
                          Text(
                            "Tencent Headquarters, Nanshan District, Shenzhen",
                            style: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(26.w),
                              color: AppColors.brandBlueDark4,
                            ),
                          ),
                          // SizedBox(height: 5.w),
                        ]),
                  ),

                  // 显示时间与更多
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 时间
                      Text(
                        widget.time,
                        style: TextStyle(
                          height: 1.08,
                          fontSize: fontSizeScale(26.w),
                          color: AppColors.neutralGrey57,
                        ),
                      ),
                      // 更多
                      GestureDetector(
                        onTap: () {
                          // 获取点击的位置
                          final RenderBox? renderBox = _morekey.currentContext
                              ?.findRenderObject() as RenderBox?;

                          if (renderBox != null) {
                            // 获取相对于屏幕的偏移量
                            final Offset position = renderBox.localToGlobal(
                              Offset(
                                  -350.w, (renderBox.size.height - 75.w) / 2),
                            );

                            widget.moreOnPress(position);
                          }
                        },
                        child: Container(
                          key: _morekey,
                          height: 70.w,
                          width: 110.w,
                          // color: Colors.blue,
                          padding: EdgeInsets.only(left: 25.w, right: 25.w),
                          color: AppColors.transparent,
                          child: Container(
                            height: 38.w,
                            width: 60.w,
                            decoration: BoxDecoration(
                              // color: AppColors.accentRedPure,
                              color: AppColors.neutralGrey1,
                              borderRadius: BorderRadius.circular(6.w),
                            ),
                            child: Center(
                              child: Icon(
                                const IconData(
                                  0xe667,
                                  fontFamily: 'Iconfont',
                                ),
                                size: 37.w,
                                color: AppColors.brandBlueDark4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5.w),

                  // 点赞人员列表
                  Container(
                    constraints: BoxConstraints(minHeight: 51.w),
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(right: 25.w),
                    padding: EdgeInsets.only(
                        left: 13.w, right: 13.w, top: 8.w, bottom: 8.w),
                    decoration: BoxDecoration(
                      color: AppColors.neutralGrey2,
                      borderRadius: BorderRadius.circular(5.w), // 设置圆角
                    ),
                    child: RichText(
                      maxLines: 1000,
                      overflow: TextOverflow.visible,
                      strutStyle: StrutStyle(
                          fontSize: 28.w, forceStrutHeight: true, leading: 1.w),
                      text: TextSpan(children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          style: const TextStyle(height: 1.08),
                          child: Icon(
                            const IconData(
                              0xe70a,
                              fontFamily: 'Iconfont',
                            ),
                            color: AppColors.brandBlueDark4, // 图标颜色
                            size: 28.w, // 图标大小
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: SizedBox(width: 10.w), // 图标和文本之间的间距
                        ),
                        ...textSpans
                      ]),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LJNTweenImage extends StatelessWidget {
  final String imagePath;
  final GlobalKey imageContainerKey = GlobalKey();
  final Function(Offset, Size)? onTap;

  LJNTweenImage({super.key, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNPopupCubit, PopupState>(
      builder: (context, popupState) {
        return GestureDetector(
          onTap: () {
            final RenderBox renderBox = imageContainerKey.currentContext
                ?.findRenderObject() as RenderBox;

            Offset position = renderBox.localToGlobal(Offset.zero);
            Size size = renderBox.size;

            // 显示视频
            context.read<LJNPopupCubit>().updateImagePopup(
                  openBoxSize: size,
                  openPosition: position,
                  imagePath: imagePath,
                  showFullScreenimage: true,
                );
          },
          child: Image.asset(
            key: imageContainerKey,
            assetPath(imagePath),
            cacheWidth: 380.w.toInt(),
            cacheHeight: 380.w.toInt(),
            width: 186.w,
            height: 186.w,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
