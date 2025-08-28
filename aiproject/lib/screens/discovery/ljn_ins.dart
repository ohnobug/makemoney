import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/themes.dart';
import 'package:spicychat/l10n/app_localizations.dart';
import 'package:spicychat/screens/components/ljn_page_loading.dart';
import 'package:spicychat/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import 'package:spicychat/tools/ljn_tools.dart';
import 'package:video_player/video_player.dart';

class LJNIns extends StatefulWidget {
  const LJNIns({super.key});

  @override
  State<LJNIns> createState() => _LJNIns();
}

class ImageInfo {
  final int id; // 图片 ID
  final bool isPics; // 是否是图片
  final String source; // 图片源路径
  final String url; // 详细页面的 URL

  ImageInfo({
    required this.id,
    required this.isPics,
    required this.source,
    required this.url,
  });

  // 可以添加一个 toString 方法以便于调试
  @override
  String toString() {
    return 'ImageInfo{id: $id, isPics: $isPics, source: $source, url: $url}';
  }
}

// 生成二维数组，每个数字都是1到64之间的随机数
List<List<ImageInfo>> generateRandomImageList(int rows, int cols) {
  final random = Random();
  return List.generate(rows, (i) {
    return List.generate(cols, (j) {
      return ImageInfo(
        id: random.nextInt(1000),
        isPics: j == 0 ? false : true,
        source: 'images/ins/${random.nextInt(52)}.jpg',
        url: '/insdetail',
      );
    });
  });
}

class _LJNIns extends State<LJNIns> {
  late List<List<ImageInfo>> mylist;

  final ScrollController _scrollController = ScrollController();

  bool setStatusLight = false;
  late VideoPlayerController _bigimgcontroller;

  @override
  void initState() {
    super.initState();
    mylist = generateRandomImageList(1000, 5);
    _scrollController.addListener(_scrollListener);

    _bigimgcontroller = VideoPlayerController.asset(
      assetPath('images/ins/video.mp4'),
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: false,
        allowBackgroundPlayback: false,
      ),
    )..initialize().then((_) {
        setState(() {});
      });
    _bigimgcontroller.setLooping(true);
    _bigimgcontroller.setVolume(1.0);
    _bigimgcontroller.pause();
  }

  @override
  void dispose() {
    _bigimgcontroller.dispose();

    _scrollController.removeListener(_scrollListener);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent, // 使用白色背景确保图标变为黑色
      statusBarIconBrightness: Brightness.dark, // 确保图标颜色为黑色
    ));

    super.dispose();
  }

  late double scrollPixels = 0;

  void _scrollListener() {
    setState(() {
      scrollPixels = _scrollController.position.pixels;
    });

    if (_scrollController.position.pixels >=
        context.read<LJNSystemCubit>().state.statusHeight) {
      setState(() {
        setStatusLight = true;
      });
    } else if (_scrollController.position.pixels == 0 &&
        _scrollController.position.atEdge) {
      setState(() {
        setStatusLight = false;
      });
    }
  }

  final GlobalKey likeBtnKey = GlobalKey();
  final GlobalKey xSpeedBtnKey = GlobalKey();
  final GlobalKey downloadBtnKey = GlobalKey();
  final GlobalKey x1BtnKey = GlobalKey();
  final GlobalKey x2BtnKey = GlobalKey();
  final GlobalKey x3BtnKey = GlobalKey();
  final GlobalKey shareBtnKey = GlobalKey();
  final GlobalKey gotoHomeBtnKey = GlobalKey();
  final GlobalKey collectBtnKey = GlobalKey();

  bool isInsideCollectBtn = false;
  bool isInsideLikeBtn = false;
  bool isInsideXSpeedBtn = false;
  bool isInsideX1Btn = false;
  bool isInsideX2Btn = false;
  bool isInsideX3Btn = false;
  bool isInsideDownloadBtn = false;
  bool isInsideShareBtn = false;
  bool isInsideHomeBtn = false;

  void checkIfInsideBox(Offset position) {
    // 点赞
    {
      RenderBox? renderBox;
      if (likeBtnKey.currentContext != null) {
        renderBox = likeBtnKey.currentContext!.findRenderObject() as RenderBox?;
      }

      Rect? boxRect;
      if (renderBox != null) {
        // 获取盒子的实际边界
        boxRect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
      }

      bool isInside = false;
      if (boxRect != null) {
        // 检查鼠标位置是否在盒子内
        isInside = boxRect.contains(position);
      }

      setState(() {
        isInsideLikeBtn = isInside;
      });
    }

    // 分享
    {
      RenderBox? renderBox;
      if (shareBtnKey.currentContext != null) {
        renderBox =
            shareBtnKey.currentContext!.findRenderObject() as RenderBox?;
      }

      Rect? boxRect;
      if (renderBox != null) {
        // 获取盒子的实际边界
        boxRect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
      }

      bool isInside = false;
      if (boxRect != null) {
        // 检查鼠标位置是否在盒子内
        isInside = boxRect.contains(position);
      }

      setState(() {
        isInsideShareBtn = isInside;
      });
    }

    // 去主页
    {
      RenderBox? renderBox;
      if (gotoHomeBtnKey.currentContext != null) {
        renderBox =
            gotoHomeBtnKey.currentContext!.findRenderObject() as RenderBox?;
      }

      Rect? boxRect;
      if (renderBox != null) {
        // 获取盒子的实际边界
        boxRect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
      }

      bool isInside = false;
      if (boxRect != null) {
        // 检查鼠标位置是否在盒子内
        isInside = boxRect.contains(position);
      }

      setState(() {
        isInsideHomeBtn = isInside;
      });
    }

    // 下载
    {
      RenderBox? renderBox;
      if (downloadBtnKey.currentContext != null) {
        renderBox =
            downloadBtnKey.currentContext!.findRenderObject() as RenderBox?;
      }

      Rect? boxRect;
      if (renderBox != null) {
        // 获取盒子的实际边界
        boxRect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
      }

      bool isInside = false;
      if (boxRect != null) {
        // 检查鼠标位置是否在盒子内
        isInside = boxRect.contains(position);
      }

      setState(() {
        isInsideDownloadBtn = isInside;
      });
    }

    // 收藏
    {
      RenderBox? renderBox;
      if (collectBtnKey.currentContext != null) {
        renderBox =
            collectBtnKey.currentContext!.findRenderObject() as RenderBox?;
      }

      Rect? boxRect;
      if (renderBox != null) {
        // 获取盒子的实际边界
        boxRect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
      }

      bool isInside = false;
      if (boxRect != null) {
        // 检查鼠标位置是否在盒子内
        isInside = boxRect.contains(position);
      }

      setState(() {
        isInsideCollectBtn = isInside;
      });
    }

    // 倍速
    {
      RenderBox? renderBox;
      if (xSpeedBtnKey.currentContext != null) {
        renderBox =
            xSpeedBtnKey.currentContext!.findRenderObject() as RenderBox?;
      }

      Rect? boxRect;
      if (renderBox != null) {
        // 获取盒子的实际边界
        boxRect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
      }

      bool isInside = false;
      if (boxRect != null) {
        // 检查鼠标位置是否在盒子内
        isInside = boxRect.contains(position);
      }

      setState(() {
        isInsideXSpeedBtn = isInside;

        if (isInsideX1Btn || isInsideX2Btn || isInsideX3Btn) {
          isInsideXSpeedBtn = true;
        }

        // if (isInside == false) {
        //   _bigimgcontroller.setPlaybackSpeed(1);
        // }
      });
    }

    // 正常倍速
    {
      RenderBox? renderBox;
      if (x1BtnKey.currentContext != null) {
        renderBox = x1BtnKey.currentContext!.findRenderObject() as RenderBox?;
      }

      Rect? boxRect;
      if (renderBox != null) {
        // 获取盒子的实际边界
        boxRect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
      }

      bool isInside = false;
      if (boxRect != null) {
        // 检查鼠标位置是否在盒子内
        isInside = boxRect.contains(position);
      }

      // 正常倍速
      setState(() {
        isInsideX1Btn = isInside;

        if (isInside) {
          _bigimgcontroller.setPlaybackSpeed(1);
        }
      });
    }

    // 二倍速
    {
      RenderBox? renderBox;
      if (x2BtnKey.currentContext != null) {
        renderBox = x2BtnKey.currentContext!.findRenderObject() as RenderBox?;
      }

      Rect? boxRect;
      if (renderBox != null) {
        // 获取盒子的实际边界
        boxRect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
      }

      bool isInside = false;
      if (boxRect != null) {
        // 检查鼠标位置是否在盒子内
        isInside = boxRect.contains(position);
      }

      // 二倍速
      setState(() {
        isInsideX2Btn = isInside;

        if (isInside) {
          _bigimgcontroller.setPlaybackSpeed(2);
        }
      });
    }

    // 三倍速
    {
      RenderBox? renderBox;
      if (x3BtnKey.currentContext != null) {
        renderBox = x3BtnKey.currentContext!.findRenderObject() as RenderBox?;
      }

      Rect? boxRect;
      if (renderBox != null) {
        // 获取盒子的实际边界
        boxRect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
      }

      bool isInside = false;
      if (boxRect != null) {
        // 检查鼠标位置是否在盒子内
        isInside = boxRect.contains(position);
      }

      // 三倍速
      setState(() {
        isInsideX3Btn = isInside;

        if (isInside) {
          _bigimgcontroller.setPlaybackSpeed(3);
        }
      });
    }

    // 三个都不在
    if (!isInsideX1Btn && !isInsideX2Btn && !isInsideX3Btn) {
      _bigimgcontroller.setPlaybackSpeed(1);
    }
  }

  // 大图可视
  bool bigImgVisible = false;
  ImageInfo? bigImgInfo;

  // 显示大图窗口
  void showBigImg(BuildContext context, ImageInfo? info, bool? show) {
    // 显示盒子
    if (show != null && show == true) {
      // 播放视频
      if (!info!.isPics && _bigimgcontroller.value.isInitialized) {
        _bigimgcontroller.seekTo(const Duration(seconds: 0));
        _bigimgcontroller.play();
      }

      setState(() {
        bigImgVisible = true;
        bigImgInfo = info;
      });
    } else {
      // 关闭盒子

      // 用户触发了点赞
      if (isInsideLikeBtn) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.prompt),
              content: Text(AppLocalizations.of(context)!.userLiked),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.confirm),
                )
              ],
            );
          },
        );
      }

      // 用户触发了去首页
      if (context.mounted && isInsideHomeBtn) {
        Navigator.pushNamed(context, '/friendmoments');
      }

      // 用户触发了分享
      if (isInsideShareBtn) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.prompt),
              content: Text(AppLocalizations.of(context)!.userLiked),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.confirm),
                )
              ],
            );
          },
        );
      }

      // 下载按钮
      if (isInsideDownloadBtn) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.prompt),
              content: Text(AppLocalizations.of(context)!.userDownloaded),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.confirm),
                )
              ],
            );
          },
        );
      }

      // 收藏按钮
      if (isInsideCollectBtn) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.prompt),
              content: Text(AppLocalizations.of(context)!.userFavorited),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.confirm),
                )
              ],
            );
          },
        );
      }

      // 停止视频
      if (!info!.isPics && _bigimgcontroller.value.isInitialized) {
        _bigimgcontroller.pause();
      }

      setState(() {
        bigImgVisible = false; // 更新状态
        bigImgInfo = info; // 更新信息

        isInsideCollectBtn = false;
        isInsideLikeBtn = false;
        isInsideXSpeedBtn = false;
        isInsideX1Btn = false;
        isInsideX2Btn = false;
        isInsideX3Btn = false;
        isInsideDownloadBtn = false;
        isInsideShareBtn = false;
        isInsideHomeBtn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Offset xSpeedSelectorPosition = const Offset(0, 0);
    if (xSpeedBtnKey.currentContext != null) {
      final RenderBox renderBox =
          xSpeedBtnKey.currentContext!.findRenderObject() as RenderBox;
      xSpeedSelectorPosition = renderBox.localToGlobal(Offset.zero);
    }

    Widget statusWidget = Container();
    if (isInsideX2Btn) {
      statusWidget = Text(
        AppLocalizations.of(context)!.playbackSpeed(2),
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 26.w, color: AppColors.neutralWhite),
      );
    } else if (isInsideX3Btn) {
      statusWidget = Text(
        AppLocalizations.of(context)!.playbackSpeed(3),
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 26.w, color: AppColors.neutralWhite),
      );
    } else if (isInsideLikeBtn) {
      statusWidget = Text(
        AppLocalizations.of(context)!.like,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 26.w, color: AppColors.neutralWhite),
      );
    } else if (isInsideCollectBtn) {
      statusWidget = Text(
        AppLocalizations.of(context)!.favorite,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 26.w, color: AppColors.neutralWhite),
      );
    } else if (isInsideDownloadBtn) {
      statusWidget = Text(
        AppLocalizations.of(context)!.download,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 26.w, color: AppColors.neutralWhite),
      );
    } else if (isInsideShareBtn) {
      statusWidget = Text(
        AppLocalizations.of(context)!.share,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 26.w, color: AppColors.neutralWhite),
      );
    } else if (isInsideHomeBtn) {
      statusWidget = Text(
        AppLocalizations.of(context)!.viewHomepage,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 26.w, color: AppColors.neutralWhite),
      );
    }

    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return Scaffold(
        primary: false,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // 滚动条
            CustomScrollView(
              primary: false,
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                // SliverAppBar
                SliverAppBar(
                  primary: false,
                  leading: null,
                  automaticallyImplyLeading: false,
                  expandedHeight: systemState.statusHeight + 90.0.w,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: AppColors.transparent, // 设置状态栏透明
                      statusBarIconBrightness:
                          setStatusLight ? Brightness.light : Brightness.dark),
                  // backgroundColor: AppColors.neutralWhite,
                  // foregroundColor: AppColors.accentRedPure,
                  flexibleSpace: FlexibleSpaceBar(
                    background: PreferredSize(
                      preferredSize:
                          Size.fromHeight(90.0.w + systemState.statusHeight),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 0.w),
                        margin: EdgeInsets.only(top: systemState.statusHeight),
                        height: 90.w,
                        // color: AppColors.accentRedDark3, // 设置背景颜色
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(), // 点击事件
                              child: Container(
                                // 加盒子是为了扩大点击区域
                                color: AppColors.transparent,
                                child: Icon(
                                  const IconData(
                                    0xed9e,
                                    fontFamily: 'Iconfont',
                                  ), // 使用的图标
                                  color: AppColors.neutralBlack, // 图标颜色
                                  size: 36.w, // 图标大小
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                // color: Colors.blue,
                                margin: EdgeInsets.symmetric(horizontal: 15.w),
                                height: 65.w,
                                child: TextField(
                                  readOnly: true,
                                  onTap: () {
                                    Navigator.pushNamed(context, '/search');
                                  },
                                  onTapOutside: (event) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  cursorHeight: 35.w,
                                  cursorWidth: 3.w,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      const IconData(
                                        0xe612,
                                        fontFamily: 'Iconfont',
                                      ),
                                      color: AppColors.neutralBlack,
                                      size: 40.w,
                                    ),
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 70.w, // 控制图标与文字的最小宽度
                                      // minHeight: 36.w,
                                    ),
                                    hintText:
                                        AppLocalizations.of(context)!.search,
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 30.w,
                                        color: AppColors.neutralDarkGrey14),
                                    filled: true,
                                    fillColor: AppColors.neutralGrey29,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 8.0.w,
                                      horizontal: 20.0.w,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  floating: true,
                  pinned: false,
                ),

                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if ((index + 1) % 3 == 1) {
                        // 样式1
                        return LJNInsStyle(
                          checkIfInsideBox: checkIfInsideBox,
                          showBigImg: showBigImg,
                          scrollPixels: scrollPixels,
                          imageList: mylist[index],
                          bigImgPosition: 1,
                        );
                      } else if ((index + 1) % 3 == 2) {
                        // 样式2
                        return LJNInsStyle(
                          checkIfInsideBox: checkIfInsideBox,
                          showBigImg: showBigImg,
                          scrollPixels: scrollPixels,
                          imageList: mylist[index],
                          bigImgPosition: 2,
                        );
                      } else {
                        // 样式3
                        return LJNInsStyle(
                          checkIfInsideBox: checkIfInsideBox,
                          showBigImg: showBigImg,
                          scrollPixels: scrollPixels,
                          imageList: mylist[index],
                          bigImgPosition: 3,
                        );
                      }
                    },
                    childCount: mylist.length, // 这里替换为你的列表长度
                  ),
                ),
              ],
            ),

            // 大图
            Visibility(
              visible: bigImgVisible,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    BackdropFilter(
                      filter:
                          ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // 模糊强度
                      child: Container(
                        color: AppColors.blackTransparent28, // 带透明度的背景颜色
                      ),
                    ),
                    // 前景内容
                    Center(
                      child: Stack(
                        children: [
                          // 图片裁剪
                          ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.w),
                            ), // 圆角前景
                            child: Container(
                              width: MediaQuery.of(context).size.width - 60.w,
                              constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height -
                                    100.w * 2,
                              ),
                              decoration: const BoxDecoration(
                                color: AppColors.neutralWhite,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // 图片或者视频
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.w), // 圆角图片
                                        child: bigImgInfo?.isPics == true
                                            ? Image.asset(
                                                assetPath(bigImgInfo!.source),
                                                fit: BoxFit.cover,
                                              )
                                            : (_bigimgcontroller
                                                    .value.isInitialized
                                                ? AspectRatio(
                                                    aspectRatio:
                                                        _bigimgcontroller
                                                            .value.aspectRatio,
                                                    child: VideoPlayer(
                                                        _bigimgcontroller),
                                                  )
                                                : Container()),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 5.w,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // 点赞按钮
                                      Container(
                                        key: likeBtnKey,
                                        decoration: BoxDecoration(
                                          color: isInsideLikeBtn
                                              ? AppColors.neutralGrey8
                                              : AppColors.neutralGrey33,
                                          borderRadius:
                                              BorderRadius.circular(30.w),
                                        ),
                                        // 扩大点击区域
                                        width: 110.w,
                                        height: 110.w,
                                        child: Icon(
                                          const IconData(
                                            0xe722,
                                            fontFamily: 'Iconfont',
                                          ), // 使用的图标
                                          color: isInsideLikeBtn
                                              ? AppColors.accentRedPure
                                              : AppColors.neutralGrey72, // 图标颜色
                                          size: 80.w, // 图标大小
                                        ),
                                      ),

                                      // 倍速
                                      if (bigImgInfo != null &&
                                          bigImgInfo!.isPics == false)
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30.w),
                                          child: Container(
                                            key: xSpeedBtnKey,
                                            decoration: BoxDecoration(
                                              color: isInsideXSpeedBtn
                                                  ? AppColors.neutralGrey8
                                                  : AppColors.neutralGrey33,
                                              borderRadius:
                                                  BorderRadius.circular(30.w),
                                            ),
                                            // 扩大点击区域
                                            width: 110.w,
                                            height: 110.w,
                                            child: Icon(
                                              const IconData(
                                                0xea7c,
                                                fontFamily: 'Iconfont',
                                              ), // 使用的图标
                                              color: AppColors
                                                  .neutralGrey72, // 图标颜色
                                              size: 80.w, // 图标大小
                                            ),
                                          ),
                                        ),

                                      // 收藏按钮
                                      Container(
                                        key: collectBtnKey,
                                        decoration: BoxDecoration(
                                          color: isInsideCollectBtn
                                              ? AppColors.neutralGrey8
                                              : AppColors.neutralGrey33,
                                          borderRadius:
                                              BorderRadius.circular(30.w),
                                        ),
                                        // 扩大点击区域
                                        width: 110.w,
                                        height: 110.w,
                                        child: Icon(
                                          const IconData(
                                            0xe602,
                                            fontFamily: 'Iconfont',
                                          ), // 使用的图标
                                          color: isInsideCollectBtn
                                              ? AppColors.accentRedPure
                                              : AppColors.neutralGrey72, // 图标颜色
                                          size: 80.w, // 图标大小
                                        ),
                                      ),

                                      // 下载按钮
                                      Container(
                                        key: downloadBtnKey,
                                        decoration: BoxDecoration(
                                          color: isInsideDownloadBtn
                                              ? AppColors.neutralGrey8
                                              : AppColors.neutralGrey33,
                                          borderRadius:
                                              BorderRadius.circular(30.w),
                                        ),
                                        // 扩大点击区域
                                        width: 110.w,
                                        height: 110.w,
                                        child: Icon(
                                          const IconData(
                                            0xe683,
                                            fontFamily: 'Iconfont',
                                          ), // 使用的图标
                                          color: isInsideDownloadBtn
                                              ? AppColors.accentRedPure
                                              : AppColors.neutralGrey72, // 图标颜色
                                          size: 80.w, // 图标大小
                                        ),
                                      ),

                                      // 分享按钮
                                      Container(
                                        key: shareBtnKey,
                                        decoration: BoxDecoration(
                                          color: isInsideShareBtn
                                              ? AppColors.neutralGrey8
                                              : AppColors.neutralGrey33,
                                          borderRadius:
                                              BorderRadius.circular(30.w),
                                        ),
                                        // 扩大点击区域
                                        width: 110.w,
                                        height: 110.w,
                                        child: Icon(
                                          const IconData(
                                            0xe6c7,
                                            fontFamily: 'Iconfont',
                                          ), // 使用的图标
                                          color: isInsideShareBtn
                                              ? AppColors.accentRedPure
                                              : AppColors.neutralGrey72, // 图标颜色
                                          size: 80.w, // 图标大小
                                        ),
                                      ),

                                      // 去主页按钮
                                      Container(
                                        key: gotoHomeBtnKey,
                                        decoration: BoxDecoration(
                                          color: isInsideHomeBtn
                                              ? AppColors.neutralGrey8
                                              : AppColors.neutralGrey33,
                                          borderRadius:
                                              BorderRadius.circular(30.w),
                                        ),
                                        // 扩大点击区域
                                        width: 110.w,
                                        height: 110.w,
                                        child: Icon(
                                          const IconData(
                                            0xe62b,
                                            fontFamily: 'Iconfont',
                                          ), // 使用的图标
                                          color: isInsideHomeBtn
                                              ? AppColors.accentRedPure
                                              : AppColors.neutralGrey72, // 图标颜色
                                          size: 80.w, // 图标大小
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.w,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // 关闭按钮
                          Positioned(
                            top: 20.w,
                            right: 20.w,
                            child: Container(
                              alignment: Alignment.centerRight,
                              // color: const Color.fromARGB(183, 192, 66, 66),
                              margin: EdgeInsets.only(left: 39.w),
                              width: 400.w,
                              height: 55.w,
                              child: statusWidget,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 加速按钮
            if (isInsideXSpeedBtn)
              Positioned(
                left: xSpeedSelectorPosition.dx,
                top: xSpeedSelectorPosition.dy - (220.w / 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isInsideXSpeedBtn
                          ? AppColors.neutralGrey8
                          : AppColors.neutralGrey33,
                      borderRadius: BorderRadius.circular(30.w),
                    ),
                    // 扩大点击区域
                    width: 110.w,
                    height: 220.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            key: x3BtnKey,
                            color: isInsideX3Btn
                                ? AppColors.accentRedPure
                                : AppColors.neutralGrey33,
                            child: Center(
                              child: Text(
                                "x3",
                                style: TextStyle(
                                  color: isInsideX3Btn
                                      ? AppColors.neutralWhite
                                      : AppColors.neutralBlack,
                                  height: 1,
                                  fontFamily: "AlibabaPuHuiTi-Medium",
                                  fontSize: 30.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            key: x2BtnKey,
                            color: isInsideX2Btn
                                ? AppColors.accentRedPure
                                : AppColors.neutralGrey33,
                            child: Center(
                              child: Text(
                                "x2",
                                style: TextStyle(
                                  color: isInsideX2Btn
                                      ? AppColors.neutralWhite
                                      : AppColors.neutralBlack,
                                  height: 1,
                                  fontFamily: "AlibabaPuHuiTi-Medium",
                                  fontSize: 30.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            key: x1BtnKey,
                            color: isInsideX1Btn
                                ? AppColors.accentRedPure
                                : AppColors.neutralGrey33,
                            child: Center(
                              child: Text(
                                "x1",
                                style: TextStyle(
                                  color: isInsideX1Btn
                                      ? AppColors.neutralWhite
                                      : AppColors.neutralBlack,
                                  height: 1,
                                  fontFamily: "AlibabaPuHuiTi-Medium",
                                  fontSize: 30.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      );
    });
  }
}

class BigImageBox extends StatefulWidget {
  final String image; // 图片路径

  final Function()? onTap;
  final Function()? onTapCancel;
  final Function()? onLongPress;
  final Function()? onLongPressCancel;
  final Function(LongPressStartDetails)? onLongPressStart;
  final Function(LongPressEndDetails)? onLongPressEnd;
  final Function()? onLongPressUp;
  final Function(LongPressDownDetails)? onLongPressDown;
  final Function(LongPressMoveUpdateDetails)? onLongPressMoveUpdate;

  const BigImageBox({
    super.key,
    required this.image,
    this.onTap,
    this.onTapCancel,
    this.onLongPress,
    this.onLongPressCancel,
    this.onLongPressStart,
    this.onLongPressEnd,
    this.onLongPressUp,
    this.onLongPressDown,
    this.onLongPressMoveUpdate,
  });

  @override
  State<BigImageBox> createState() => _BigImageBox();
}

// 大图片
class _BigImageBox extends State<BigImageBox> {
  Timer? _timer;
  bool show = false;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(milliseconds: 100), () {
      if (mounted) {
        show = true;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyGestureDetector(
      onTap: widget.onTap,
      onTapCancel: widget.onTapCancel,
      onLongPress: widget.onLongPress,
      onLongPressCancel: widget.onLongPressCancel,
      onLongPressStart: (LongPressStartDetails details) {
        if (widget.onLongPressStart != null) {
          widget.onLongPressStart!(details);
        }
      },
      onLongPressEnd: (LongPressEndDetails details) {
        if (widget.onLongPressEnd != null) {
          widget.onLongPressEnd!(details);
        }
      },
      onLongPressUp: widget.onLongPressUp,
      onLongPressDown: (LongPressDownDetails details) {
        if (widget.onLongPressDown != null) {
          widget.onLongPressDown!(details);
        }
      },
      onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) {
        if (widget.onLongPressMoveUpdate != null) {
          widget.onLongPressMoveUpdate!(details);
        }
      },
      child: Stack(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width - 2.w) / 3,
            height: 500.w,
            color: AppColors.neutralGrey2,
            child: show
                ? Image.asset(
                    width: (MediaQuery.of(context).size.width - 2.w) / 3,
                    height: 500.w,
                    // cacheWidth:
                    //     (((MediaQuery.of(context).size.width - 2.w) / 3) * 2)
                    //         .toInt(),
                    cacheHeight: (500.w * 2).toInt(),
                    fit: BoxFit.cover,
                    assetPath(widget.image),
                  )
                : const LJNPageLoading(),
          ),
          Positioned(
            top: 15.w,
            left: 200.w,
            child: Icon(
              color: AppColors.neutralWhite,
              const IconData(
                0xe777,
                fontFamily: 'Iconfont',
              ),
              size: 36.w, // 图标大小
            ),
          )
        ],
      ),
    );
  }
}

class SmallImageBox extends StatefulWidget {
  final String image; // 图片路径

  final Function()? onTap;
  final Function()? onTapCancel;
  final Function()? onLongPress;
  final Function()? onLongPressCancel;
  final Function(LongPressStartDetails)? onLongPressStart;
  final Function(LongPressEndDetails)? onLongPressEnd;
  final Function()? onLongPressUp;
  final Function(LongPressDownDetails)? onLongPressDown;
  final Function(LongPressMoveUpdateDetails)? onLongPressMoveUpdate;

  const SmallImageBox({
    super.key,
    required this.image,
    this.onTap,
    this.onTapCancel,
    this.onLongPress,
    this.onLongPressCancel,
    this.onLongPressStart,
    this.onLongPressEnd,
    this.onLongPressUp,
    this.onLongPressDown,
    this.onLongPressMoveUpdate,
  });

  @override
  State<SmallImageBox> createState() => _SmallImageBox();
}

// 小图片
class _SmallImageBox extends State<SmallImageBox> {
  Timer? _timer;
  bool show = false;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(milliseconds: 100), () {
      if (mounted) {
        show = true;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyGestureDetector(
      onTap: widget.onTap,
      onTapCancel: widget.onTapCancel,
      onLongPress: widget.onLongPress,
      onLongPressCancel: widget.onLongPressCancel,
      onLongPressStart: (LongPressStartDetails details) {
        if (widget.onLongPressStart != null) {
          widget.onLongPressStart!(details);
        }
      },
      onLongPressEnd: (LongPressEndDetails details) {
        if (widget.onLongPressEnd != null) {
          widget.onLongPressEnd!(details);
        }
      },
      onLongPressUp: widget.onLongPressUp,
      onLongPressDown: (LongPressDownDetails details) {
        if (widget.onLongPressDown != null) {
          widget.onLongPressDown!(details);
        }
      },
      onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) {
        if (widget.onLongPressMoveUpdate != null) {
          widget.onLongPressMoveUpdate!(details);
        }
      },
      child: Stack(
        children: [
          Container(
              width: (MediaQuery.of(context).size.width - 2.w) / 3,
              height: (500.w - 1.w) / 2,
              color: AppColors.neutralGrey2,
              child: show
                  ? Image.asset(
                      width: (MediaQuery.of(context).size.width - 2.w) / 3,
                      height: (500.w - 1.w) / 2,
                      // cacheWidth:
                      //     (((MediaQuery.of(context).size.width - 2.w) / 3) * 2)
                      //         .toInt(),
                      cacheHeight: (500.w - 1.w).toInt(),
                      assetPath(widget.image),
                      fit: BoxFit.cover,
                    )
                  : const LJNPageLoading()),
          Positioned(
            top: 15.w,
            left: 200.w,
            child: Icon(
              color: AppColors.neutralWhite,
              const IconData(
                0xe777,
                fontFamily: 'Iconfont',
              ),
              size: 36.w, // 图标大小
            ),
          )
        ],
      ),
    );
  }
}

// 大视频
class VideoBox2 extends StatefulWidget {
  final String videoPath; // 图片路径
  final bool canPlay;

  final Function()? onTap;
  final Function()? onTapCancel;
  final Function()? onLongPress;
  final Function()? onLongPressCancel;
  final Function(LongPressStartDetails)? onLongPressStart;
  final Function(LongPressEndDetails)? onLongPressEnd;
  final Function()? onLongPressUp;
  final Function(LongPressDownDetails)? onLongPressDown;
  final Function(LongPressMoveUpdateDetails)? onLongPressMoveUpdate;

  const VideoBox2({
    super.key,
    required this.videoPath,
    required this.canPlay,
    this.onTap,
    this.onTapCancel,
    this.onLongPress,
    this.onLongPressCancel,
    this.onLongPressStart,
    this.onLongPressEnd,
    this.onLongPressUp,
    this.onLongPressDown,
    this.onLongPressMoveUpdate,
  });

  @override
  State<VideoBox2> createState() => _VideoBox2();
}

class _VideoBox2 extends State<VideoBox2> {
  VideoPlayerController? _controller;
  late bool finalCountdownFinished = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Start the countdown timer
    _timer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        _controller = VideoPlayerController.asset(
          assetPath(widget.videoPath),
          videoPlayerOptions: VideoPlayerOptions(
              mixWithOthers: true, allowBackgroundPlayback: false),
        )..initialize().then((_) {
            setState(() {
              _controller?.setVolume(0);
              _controller?.setLooping(true);
              _controller?.play();
            });
          });

        setState(() {
          finalCountdownFinished = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(VideoBox2 oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.canPlay != widget.canPlay) {
      if (_controller != null && _controller!.value.isInitialized) {
        if (widget.canPlay) {
          _controller?.play();
        } else {
          _controller?.pause();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyGestureDetector(
      onTap: widget.onTap,
      onTapCancel: widget.onTapCancel,
      onLongPress: widget.onLongPress,
      onLongPressCancel: widget.onLongPressCancel,
      onLongPressStart: (LongPressStartDetails details) {
        if (widget.onLongPressStart != null) {
          widget.onLongPressStart!(details);
        }
      },
      onLongPressEnd: (LongPressEndDetails details) {
        if (widget.onLongPressEnd != null) {
          widget.onLongPressEnd!(details);
        }
      },
      onLongPressUp: widget.onLongPressUp,
      onLongPressDown: (LongPressDownDetails details) {
        if (widget.onLongPressDown != null) {
          widget.onLongPressDown!(details);
        }
      },
      onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) {
        if (widget.onLongPressMoveUpdate != null) {
          widget.onLongPressMoveUpdate!(details);
        }
      },
      child: Stack(
        children: [
          SizedBox(
            width: (MediaQuery.of(context).size.width - 2.w) / 3,
            height: 500.w,
            child: finalCountdownFinished
                ? (_controller != null && _controller!.value.isInitialized
                    ? FittedBox(
                        clipBehavior: Clip.hardEdge,
                        fit: BoxFit.cover, // 居中裁剪
                        child: SizedBox(
                            width: _controller!.value.size.width,
                            height: _controller!.value.size.height,
                            child: AspectRatio(
                              aspectRatio: _controller!.value.aspectRatio,
                              child: VideoPlayer(_controller!),
                            )),
                      )
                    : const LJNPageLoading())
                : const LJNPageLoading(),
          ),
          Positioned(
            top: 15.w,
            left: 200.w,
            child: Icon(
              color: AppColors.neutralWhite,
              const IconData(
                0xe61d,
                fontFamily: 'Iconfont',
              ),
              size: 32.w,
            ),
          )
        ],
      ),
    );
  }
}

// 样式
class LJNInsStyle extends StatefulWidget {
  final List<ImageInfo> imageList;
  final int bigImgPosition;
  final double scrollPixels;
  final Function showBigImg;
  final Function checkIfInsideBox;

  const LJNInsStyle(
      {super.key,
      required this.imageList,
      required this.bigImgPosition,
      required this.scrollPixels,
      required this.showBigImg,
      required this.checkIfInsideBox});

  @override
  State<LJNInsStyle> createState() => _LJNInsStyle();
}

class _LJNInsStyle extends State<LJNInsStyle> {
  List<Widget> widgetList = [];
  final GlobalKey _containerKey = GlobalKey();

  // 监听 scrollPixels 的变化，类似于 useEffect 的效果
  @override
  void didUpdateWidget(LJNInsStyle oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 检查 scrollPixels 是否发生变化
    if (oldWidget.scrollPixels != widget.scrollPixels) {
      _getPosition();
    }
  }

  late bool canPlay = false;
  late Offset myPosition = const Offset(0, 0);

  // 获取位置的方法
  void _getPosition() {
    final RenderBox? renderBox =
        _containerKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox != null) {
      // 获取相对于屏幕的偏移量
      final Offset position = renderBox.localToGlobal(Offset.zero);
      // logger.info("Container 位于: ${position.dx}, ${position.dy}");

      setState(() {
        myPosition = position;

        // 当前盒子小于屏幕一半,即可播放
        if ((position.dy < (MediaQuery.of(context).size.height - 500.w * 1)) &&
            (position.dy > -(500.w * 1 / 3))) {
          canPlay = true;
        } else {
          canPlay = false;
        }
      });
    } else {
      logger.info("无法获取 RenderBox");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: 750.w,
    //   height: 500.w,
    //   color: AppColors.accentRedPure,
    //   key: _containerKey,
    //   margin: EdgeInsets.only(bottom: 4.w),
    //   child: Text("key:$_containerKey  position:$myPosition canplay: $canPlay"),
    // );

    // 大图
    var a = widget.imageList[0].isPics
        ? BigImageBox(
            image: widget.imageList[0].source,
            onLongPress: () {
              widget.showBigImg(context, widget.imageList[0], true);
            },
            onLongPressUp: () {
              widget.showBigImg(context, widget.imageList[0], false);
            },
            onLongPressMoveUpdate: (details) {
              // 更新手指位置并检查是否在盒子内
              widget.checkIfInsideBox(details.globalPosition);
              // logger.info('onLongPressMoveUpdate');
            },
          )
        : VideoBox2(
            videoPath: 'images/ins/video.mp4',
            canPlay: canPlay,
            onLongPress: () {
              widget.showBigImg(context, widget.imageList[0], true);
            },
            onLongPressUp: () {
              widget.showBigImg(context, widget.imageList[0], false);
            },
            onLongPressMoveUpdate: (details) {
              // 更新手指位置并检查是否在盒子内
              widget.checkIfInsideBox(details.globalPosition);
              // logger.info('onLongPressMoveUpdate');
            },
          );

    // 两图
    var b = Column(
      children: [
        SmallImageBox(
          image: widget.imageList[1].source,
          onLongPress: () {
            widget.showBigImg(context, widget.imageList[1], true);
          },
          onLongPressUp: () {
            widget.showBigImg(context, widget.imageList[1], false);
          },
          onLongPressMoveUpdate: (details) {
            // 更新手指位置并检查是否在盒子内
            widget.checkIfInsideBox(details.globalPosition);
            // logger.info('onLongPressMoveUpdate');
          },
        ),
        SizedBox(
          height: 1.w,
        ),
        SmallImageBox(
          image: widget.imageList[2].source,
          onLongPress: () {
            widget.showBigImg(context, widget.imageList[2], true);
          },
          onLongPressUp: () {
            widget.showBigImg(context, widget.imageList[2], false);
          },
          onLongPressMoveUpdate: (details) {
            // 更新手指位置并检查是否在盒子内
            widget.checkIfInsideBox(details.globalPosition);
            // logger.info('onLongPressMoveUpdate');
          },
        ),
      ],
    );

    // 两图
    var c = Column(
      children: [
        SmallImageBox(
          image: widget.imageList[3].source,
          onLongPress: () {
            widget.showBigImg(context, widget.imageList[3], true);
          },
          onLongPressUp: () {
            widget.showBigImg(context, widget.imageList[3], false);
          },
          onLongPressMoveUpdate: (details) {
            // 更新手指位置并检查是否在盒子内
            widget.checkIfInsideBox(details.globalPosition);
            // logger.info('onLongPressMoveUpdate');
          },
        ),
        SizedBox(
          height: 1.w,
        ),
        SmallImageBox(
          image: widget.imageList[4].source,
          onLongPress: () {
            widget.showBigImg(context, widget.imageList[4], true);
          },
          onLongPressUp: () {
            widget.showBigImg(context, widget.imageList[4], false);
          },
          onLongPressMoveUpdate: (details) {
            // 更新手指位置并检查是否在盒子内
            widget.checkIfInsideBox(details.globalPosition);
            // logger.info('onLongPressMoveUpdate');
          },
        ),
      ],
    );

    if (widget.bigImgPosition == 1) {
      widgetList = [a, b, c];
    } else if (widget.bigImgPosition == 2) {
      widgetList = [b, a, c];
    } else if (widget.bigImgPosition == 3) {
      widgetList = [b, c, a];
    }

    return Container(
        key: _containerKey,
        margin: EdgeInsets.only(bottom: 1.w),
        child: Row(
          children: [
            widgetList[0],
            SizedBox(
              width: 1.w,
            ),
            widgetList[1],
            SizedBox(
              width: 1.w,
            ),
            widgetList[2],
          ],
        ));
  }
}

// 自定义手势识别(较原来缩短了长按时间)
class MyGestureDetector extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onTapCancel;
  final VoidCallback? onLongPress;
  final VoidCallback? onLongPressCancel;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressEndCallback? onLongPressEnd;
  final VoidCallback? onLongPressUp;
  final GestureLongPressDownCallback? onLongPressDown;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  const MyGestureDetector({
    super.key,
    required this.child,
    this.onTap,
    this.onTapCancel,
    this.onLongPress,
    this.onLongPressCancel,
    this.onLongPressStart,
    this.onLongPressEnd,
    this.onLongPressUp,
    this.onLongPressDown,
    this.onLongPressMoveUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () => TapGestureRecognizer(),
          (TapGestureRecognizer instance) {
            instance.onTap = onTap;
            instance.onTapCancel = onTapCancel;
          },
        ),
        LongPressGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
          () => LongPressGestureRecognizer(
            duration: const Duration(milliseconds: 200),
          ),
          (LongPressGestureRecognizer instance) {
            instance.onLongPress = onLongPress;
            instance.onLongPressCancel = onLongPressCancel;
            instance.onLongPressStart = onLongPressStart;
            instance.onLongPressEnd = onLongPressEnd;
            instance.onLongPressUp = onLongPressUp;
            instance.onLongPressDown = onLongPressDown;
            instance.onLongPressMoveUpdate = onLongPressMoveUpdate;
          },
        ),
      },
      child: child,
    );
  }
}

// class VideoControllerProvider with ChangeNotifier {
//   final List<VideoPlayerController> _freeControllers = [];
//   int _controllerCount = 0;

//   VideoPlayerController? obtainController(String videoPath) {
//     if (videoPath == "") return null;

//     if (_freeControllers.isNotEmpty) {
//       final controller = _freeControllers.removeAt(0);
//       if (!controller.value.isInitialized) {
//         controller.initialize().then((_) {
//           notifyListeners();
//         });
//       }
//       return controller;
//     } else if (_controllerCount < 3) {
//       final controller = VideoPlayerController.asset(
//         videoPath,
//         videoPlayerOptions: VideoPlayerOptions(
//             mixWithOthers: true, allowBackgroundPlayback: false),
//       )..initialize().then((_) {
//           notifyListeners();
//         });

//       _controllerCount++;
//       return controller;
//     } else {
//       // No free controllers and reached max limit
//       return null;
//     }
//   }

//   void releaseController(VideoPlayerController controller) {
//     if (!_freeControllers.contains(controller)) {
//       _freeControllers.add(controller);
//     }
//     _controllerCount--;
//     notifyListeners();
//   }

//   void removeAllControllers() {
//     for (final controller in _freeControllers) {
//       controller.dispose();
//     }
//     _freeControllers.clear();
//     _controllerCount = 0;
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     removeAllControllers();
//     super.dispose();
//   }
// }
