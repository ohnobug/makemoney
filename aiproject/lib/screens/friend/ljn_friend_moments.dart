import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/api_manager/api.dart';
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

// 将背景动画控制器提升为全局变量，以便子组件在需要时可以访问。
// 注意：虽然这样做可以解决问题，但在大型应用中通常建议通过更优雅的状态管理方式（如Provider或Bloc）来传递控制器。
late AnimationController _bgController;

// 朋友圈页面的主组件 (StatefulWidget)
class LJNFriendmoments extends StatefulWidget {
  const LJNFriendmoments({super.key});

  @override
  State<LJNFriendmoments> createState() => _LJNFriendmoments();
}

// 朋友圈页面的状态管理类
// with TickerProviderStateMixin 是为了让 State 类能够提供 Ticker，这是驱动动画所必需的。
class _LJNFriendmoments extends State<LJNFriendmoments>
    with TickerProviderStateMixin {
  // --- 控制器和状态变量 ---

  final ScrollController _scrollController =
      ScrollController(); // 列表滚动控制器，用于监听滚动事件
  double scrollPosition = 0; // 当前的滚动位置

  late AnimationController _appBarcontroller; // 顶部导航栏的动画控制器
  late Animation<double> _appBarOpacity; // 顶部导航栏透明度的动画

  late List tweetList; // 存储朋友圈动态数据的列表

  // “点赞/评论”弹出框的状态
  Offset lastedMoreButtonPosition =
      const Offset(-1000, -1000); // 记录上次点击"..."按钮的位置，-1000是为了在屏幕外初始化
  bool likeBoxVisible = false; // “点赞/评论”框是否可见
  bool _isScrolling = false; // 标记当前是否正在滚动

  // “点赞/评论”弹出框的动画控制器和动画
  late AnimationController _likeController; // “点赞/评论”框的动画控制器
  late Animation<double> _likeAnimation; // “点赞/评论”框的动画（控制其水平位置，实现滑出效果）

  // --- 生命周期函数 ---

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener); // 为滚动控制器添加监听器

    // 初始化顶部导航栏的动画控制器
    _appBarcontroller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    // 定义一个从0到1的透明度动画
    _appBarOpacity =
        Tween<double>(begin: 0.0, end: 1.0).animate(_appBarcontroller);

    // 初始化“点赞/评论”框的动画控制器
    _likeController = AnimationController(
      duration: const Duration(milliseconds: 300), // 出现动画时长
      reverseDuration: const Duration(milliseconds: 100), // 消失动画时长
      vsync: this,
    );

    // 初始化头部背景图的动画控制器
    _bgController = AnimationController(
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 100),
      vsync: this,
    );

    // 定义“点赞/评论”框的动画：从左侧 360.w 的位置滑动到 0
    _likeAnimation =
        Tween<double>(begin: 360.w, end: 0.w).animate(CurvedAnimation(
      parent: _likeController,
      curve: Curves.easeInOut, // 使用缓动曲线，效果更自然
    ));

    // 初始化朋友圈的模拟数据
    _initializeTweetData();
  }

  @override
  void dispose() {
    // 在组件销毁时，释放所有控制器资源，防止内存泄漏
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _appBarcontroller.dispose();
    _likeController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  // --- 监听与事件处理 ---

  // 滚动监听器方法
  void _scrollListener() {
    if (!mounted) return; // 如果组件已销毁，则不执行任何操作

    // 计算导航栏开始渐变的滚动位置
    double beginPosition =
        context.read<LJNSystemCubit>().state.statusHeight + 450.w;

    setState(() {
      scrollPosition = _scrollController.position.pixels; // 更新当前滚动位置
      // 计算滚动进度，范围在 0.0 到 40.w 之间
      double progress =
          (_scrollController.position.pixels - beginPosition).clamp(0.0, 40.w);
      // 将滚动进度映射为动画控制器的值（0.0 到 1.0），从而驱动导航栏透明度动画
      _appBarcontroller.value = progress / 40.w;
    });

    // 只要开始滚动，就立即隐藏“点赞/评论”框
    hideLikeBox(quick: true);
  }

  // 显示“点赞/评论”框的方法
  void showLikeBox(Offset position) {
    if (!mounted) return;
    setState(() {
      lastedMoreButtonPosition = position; // 更新位置
      likeBoxVisible = true; // 设为可见
      _likeController.forward(); // 播放出现动画
    });
  }

  // 隐藏“点赞/评论”框的方法
  void hideLikeBox({required bool quick}) {
    if (!mounted || !likeBoxVisible) return; // 如果组件已销毁或框已隐藏，则不执行
    if (quick) {
      // 快速隐藏：直接重置状态，不播放动画
      _likeController.value = 0; // 直接把动画重置到初始状态
      setState(() {
        lastedMoreButtonPosition = const Offset(-1000, -1000); // 移出屏幕
        likeBoxVisible = false; // 设为不可见
      });
    } else {
      // 慢速隐藏：播放消失动画
      _likeController.reverse().then((_) {
        // `then` 会在动画播放完毕后执行
        if (mounted) {
          setState(() {
            lastedMoreButtonPosition = const Offset(-1000, -1000); // 移出屏幕
            likeBoxVisible = false; // 设为不可见
          });
        }
      });
    }
  }

  // --- UI 构建方法 ---
  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    ThemeData theme = Theme.of(context);

    // 根据当前主题计算导航栏的背景色和标题颜色，以适配深色/浅色模式
    final Color appBarBgColor =
        theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor;
    final Color appBarTitleColor =
        theme.appBarTheme.titleTextStyle?.color ?? theme.colorScheme.onSurface;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return; // 如果已经 pop 了，就什么都不做

        // 如果头部背景是放大状态，则返回时先缩小背景
        if (_bgController.isCompleted) {
          _bgController.reverse();
          return;
        }

        // 如果当前有全屏的图片或视频正在显示
        if (context.read<LJNPopupCubit>().state.showFullScreenVideo == true ||
            context.read<LJNPopupCubit>().state.showFullScreenImage == true) {
          // 通知 PopupCubit 处理返回事件（通常是播放缩小动画）
          context.read<LJNPopupCubit>().updateReturnButtonEvent(true);
        } else {
          // 否则，执行默认的页面返回操作
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
          return Scaffold(
            primary: false, // 主要内容是否延伸到 AppBar 后面，这里我们自定义 AppBar，设为 false
            appBar: null, // 不使用 Scaffold 自带的 AppBar
            body: Stack(
              // 使用 Stack 堆叠布局，将多个层叠在一起
              children: [
                // 第一层：顶部的深色背景，防止列表向上滚动时露出白色
                _buildBackground(),

                // 第二层：可滚动的朋友圈列表
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true, // 移除顶部的安全区域 padding，因为我们自己处理
                  child: GestureDetector(
                    onTap: () => hideLikeBox(quick: true), // 点击列表空白处，隐藏点赞框
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        // 监听滚动开始和结束的通知
                        if (notification is ScrollStartNotification) {
                          _isScrolling = true;
                        } else if (notification is ScrollEndNotification) {
                          _isScrolling = false;
                        }
                        return false;
                      },
                      child: ScrollConfiguration(
                        // 自定义滚动行为
                        behavior: CustomScrollBehavior().copyWith(
                          scrollbars: false, // 不显示滚动条
                          physics: const BouncingScrollPhysics(
                            // 使用 iOS 的弹性滚动效果
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                        ),
                        child: ListView.builder(
                          primary: false,
                          controller: _scrollController,
                          itemCount:
                              tweetList.length + 1, // +1 是因为包含了顶部的 header
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              // 列表的第一个 item 是头部
                              return _buildHeader(systemState);
                            } else {
                              // 其他 item 是朋友圈动态
                              var tweet = tweetList[index - 1];
                              return TweetWidget(
                                time: tweet["time"]!,
                                avatarUrl: tweet["avatarUrl"]!,
                                name: tweet["name"]!,
                                tweetContent: tweet["tweetContent"]!,
                                likes: tweet["likes"],
                                imageList: tweet["imageList"],
                                moreOnPress: (Offset position) {
                                  // "..." 按钮的回调函数
                                  if (_isScrolling) return; // 滚动时不响应
                                  likeBoxVisible
                                      ? hideLikeBox(quick: false) // 如果已显示，则隐藏
                                      : showLikeBox(position); // 如果已隐藏，则显示
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                // 第三层：点赞/评论弹出框 (如果可见)
                if (likeBoxVisible) _buildLikeBox(),

                // 第四层：渐变显示的顶部导航栏
                AnimatedBuilder(
                  animation: _appBarOpacity, // 监听透明度动画
                  builder: (context, child) {
                    // 根据动画值计算当前的背景色、标题色和图标颜色
                    final Color currentBgColor = appBarBgColor
                        .withAlpha((_appBarOpacity.value * 255).toInt());
                    final Color currentTitleColor = appBarTitleColor
                        .withAlpha((_appBarOpacity.value * 255).toInt());
                    // 图标颜色在透明度超过 0.7 时变为主题色，否则为白色
                    final Color currentIconColor = _appBarOpacity.value > 0.7
                        ? theme.colorScheme.onSurface
                        : AppColors.neutralWhite;

                    return Container(
                      color: currentBgColor, // 应用渐变的背景色
                      width: double.infinity,
                      height: 90.0.w + systemState.statusHeight,
                      padding: EdgeInsets.only(
                          top: systemState.statusHeight), // 适配状态栏高度
                      child: AppBar(
                        primary: false,
                        title: Text(l10n.moments),
                        centerTitle: true,
                        titleTextStyle: TextStyle(
                          height: 1.08,
                          fontSize: fontSizeScale(32.w),
                          color: currentTitleColor, // 应用渐变的标题颜色
                          fontFamily: "AlibabaPuHuiTi-Medium",
                        ),
                        toolbarHeight: 90.w,
                        elevation: 0,
                        scrolledUnderElevation: 0,
                        backgroundColor: Colors.transparent, // AppBar 本身背景透明
                        foregroundColor: Colors.transparent,
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            color: Colors.transparent, // 增大点击区域
                            child: Icon(
                              const IconData(0xed9e, fontFamily: 'Iconfont'),
                              color: currentIconColor, // 应用渐变的图标颜色
                              size: 36.w,
                            ),
                          ),
                        ),
                        actions: [
                          AnimatedBuilder(
                            animation: _bgController, // 监听头部背景动画
                            builder: (context, child) {
                              return Transform.translate(
                                // 当头部背景放大时，这个相机图标向上移出屏幕
                                offset: Offset(0, _bgController.value * -300.w),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    color: Colors.transparent,
                                    height: 90.w,
                                    padding: EdgeInsets.only(right: 40.w),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      // 根据导航栏透明度切换不同颜色的相机图标
                                      _appBarOpacity.value > 0.7
                                          ? const IconData(0xe68a,
                                              fontFamily: 'Iconfont')
                                          : const IconData(0xe64d,
                                              fontFamily: 'Iconfont'),
                                      size: 40.w,
                                      color: currentIconColor,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // 构建列表头部的私有方法
  Widget _buildHeader(SystemState systemState) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return AnimatedBuilder(
      animation: _bgController, // 监听背景放大动画
      builder: (context, child) {
        return Container(
          // 根据动画值动态计算头部的高度，实现放大效果
          height: (systemState.statusHeight + 630.w) +
              (600.w * _bgController.value),
          alignment: Alignment.center,
          color: _bgController.isAnimating || _bgController.isCompleted
              ? theme.colorScheme.onSurface // 放大时背景变暗
              : AppColors.neutralWhite,
          width: 750.w,
          child: Stack(
            children: [
              // 封面背景图
              GestureDetector(
                onTap: () {
                  // 点击背景图，播放放大或缩小动画
                  if (!_bgController.isCompleted) {
                    _bgController.forward();
                  } else {
                    _bgController.reverse();
                  }
                },
                child: Transform.translate(
                  // 放大时，图片稍微向上移动一点，视觉效果更好
                  offset: _bgController.isCompleted
                      ? Offset.zero
                      : Offset(0, -100.w),
                  child: AnimatedBuilder(
                    animation: _bgController,
                    builder: (context, child) {
                      return Image.asset(
                        assetPath('images/avatar/fj.jpg'),
                        cacheWidth: 1500.w.toInt(),
                        cacheHeight:
                            (systemState.statusHeight + 1260.w).toInt(),
                        width: 750.w,
                        // 动态计算图片高度
                        height: _bgController.isCompleted
                            ? (systemState.statusHeight + 630.w) +
                                (600.w * _bgController.value)
                            : 730.w,
                        // 放大时，图片填充方式变为 contain，完整显示
                        fit: _bgController.isCompleted
                            ? BoxFit.contain
                            : BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              // 用户名和头像
              Transform.translate(
                // 放大时，头像和名字向上移出屏幕
                offset: Offset(
                    0,
                    systemState.statusHeight +
                        460.w +
                        (_bgController.value * 300.w)),
                child: Opacity(
                  // 放大时，头像和名字渐变消失
                  opacity: 1 - _bgController.value,
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/userinfo'),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 35.w),
                      width: 750.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 15.w, top: 5.w),
                            child: Text(
                              context.read<LJNUserCubit>().state.userinfoName!,
                              style: TextStyle(
                                height: 1.08,
                                fontSize: fontSizeScale(40.w),
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10).w,
                            child: Image.asset(
                              assetPath(context
                                  .read<LJNUserCubit>()
                                  .state
                                  .userinfoAvatar!),
                              cacheWidth: 240.w.toInt(),
                              cacheHeight: 240.w.toInt(),
                              width: 120.w,
                              height: 120.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // "更换封面" 按钮，只在背景放大后显示
              if (_bgController.isCompleted)
                Positioned(
                  bottom: 30.w,
                  right: 30.w,
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, "/friend_moments_cover_setting"),
                    child: Column(
                      children: [
                        Icon(
                          const IconData(0xe68a, fontFamily: 'Iconfont'),
                          size: 40.w,
                          color: AppColors.neutralWhite,
                        ),
                        SizedBox(height: 5.w),
                        Text(
                          l10n.changeCover,
                          style: TextStyle(
                            fontSize: 22.w,
                            color: AppColors.neutralWhite,
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  // 构建顶部背景的私有方法
  Widget _buildBackground() {
    return Container(
      width: 750.w,
      height: 530.w,
      color: AppColors.neutralDarkGrey18,
    );
  }

  // 构建“点赞/评论”弹出框的私有方法
  Widget _buildLikeBox() {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    // 使用主题颜色，适配深色/浅色模式
    final Color boxColor = theme.colorScheme.inverseSurface;
    final Color textColor = theme.colorScheme.onInverseSurface;
    final Color dividerColor = textColor.withAlpha(128);

    return Positioned(
      // 使用 `Positioned` 定位弹出框
      top: lastedMoreButtonPosition.dy,
      left: lastedMoreButtonPosition.dx - _likeAnimation.value, // left 值由动画驱动
      child: AnimatedBuilder(
        animation: _likeAnimation,
        builder: (context, child) {
          return Opacity(
            // 使用 Opacity 实现渐变效果
            opacity: _likeController.value,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              width: 360.w,
              height: 75.w,
              decoration: BoxDecoration(
                color: boxColor,
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
              ),
              child: child, // child 是下面的 Row，这样可以避免重复构建
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _LikeCommentButton(
              icon: const IconData(0xe682, fontFamily: 'Iconfont'),
              text: l10n.like,
              color: textColor,
            ),
            Container(height: 45.w, width: 2.w, color: dividerColor),
            _LikeCommentButton(
              icon: const IconData(0xe605, fontFamily: 'Iconfont'),
              text: l10n.comment,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }

  // 初始化朋友圈数据的私有方法
  void _initializeTweetData() {
    tweetList = getTweetList(); // 从某个地方获取模拟数据
  }
}

// “点赞”和“评论”按钮的无状态组件
class _LikeCommentButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _LikeCommentButton({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 31.w,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 28.w,
            color: color,
          ),
        ),
      ],
    );
  }
}

// 代表朋友圈中的单条动态的组件 (StatefulWidget)
class TweetWidget extends StatefulWidget {
  final String time;
  final String avatarUrl;
  final String name;
  final String tweetContent;
  final List<String>? imageList;
  final List<String>? likes;
  final Function(Offset) moreOnPress; // "..." 按钮的点击回调

  const TweetWidget({
    super.key,
    required this.time,
    required this.avatarUrl,
    required this.name,
    required this.tweetContent,
    this.likes,
    this.imageList,
    required this.moreOnPress,
  });

  @override
  State<TweetWidget> createState() => _TweetWidgetState();
}

class _TweetWidgetState extends State<TweetWidget> {
  final GlobalKey _moreKey = GlobalKey(); // 用于获取 "..." 按钮在屏幕上的位置
  final List<TapGestureRecognizer> _recognizers = []; // 存储点赞列表中每个名字的点击手势

  @override
  void dispose() {
    // 必须释放所有手势识别器，否则会造成内存泄漏
    for (var recognizer in _recognizers) {
      recognizer.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    // 使用主题颜色
    final Color linkColor = theme.colorScheme.primary;
    final Color moreButtonBgColor = theme.colorScheme.surfaceContainerHighest;
    final Color likesContainerBgColor =
        theme.colorScheme.surfaceContainerHighest;

    return Listener(
      // 监听指针按下事件
      onPointerDown: (_) {
        // 如果用户在点击动态时，头部背景是放大的，则将其缩小
        if (_bgController.isCompleted) {
          _bgController.reverse();
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 22.w),
        decoration: BoxDecoration(
          color: AppColors
              .neutralWhite, // 注意：这里使用了硬编码颜色，也可以改为 theme.cardColor 或 theme.scaffoldBackgroundColor
          border: Border(
            bottom: BorderSide(
              color: theme.dividerColor, // 使用主题的分隔线颜色
              width: 1.0.w,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 37.w),
            // 头像
            ClipRRect(
              borderRadius: BorderRadius.circular(10).w,
              child: Image.asset(
                assetPath(widget.avatarUrl),
                width: 77.w,
                height: 77.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20.w),
            // 右侧内容区域
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 名字 (可点击)
                        LJNTextSpans(
                          text: widget.name,
                          style: TextStyle(
                            fontSize: fontSizeScale(32.w),
                            fontFamily: "AlibabaPuHuiTi-Medium",
                            color: linkColor,
                          ),
                        ),

                        // 朋友圈文本内容
                        LJNTextSpans(
                          maxLines: 15,
                          text: widget.tweetContent,
                          style: TextStyle(
                            height: 1.4,
                            fontSize: fontSizeScale(32.w),
                            fontFamily: "AlibabaPuHuiTi",
                          ),
                        ),

                        // 九宫格图片
                        if (widget.imageList != null) ...[
                          SizedBox(height: 10.w),
                          SizedBox(
                            width: 570.w,
                            child: Wrap(
                              // 使用 Wrap 自动换行布局
                              spacing: 6.w, // 水平间距
                              runSpacing: 6.w, // 垂直间距
                              children: widget.imageList!
                                  .map((path) => path.isEmpty
                                      ? const SizedBox.shrink()
                                      : LJNTweenImage(imagePath: path))
                                  .toList(),
                            ),
                          ),
                          SizedBox(height: 18.w),
                        ],

                        // 位置信息
                        Text(
                          "Tencent Headquarters", // 示例位置
                          style: TextStyle(
                            fontSize: fontSizeScale(26.w),
                            color: linkColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 时间和 "..." 按钮
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.time,
                        style: TextStyle(
                          fontSize: fontSizeScale(26.w),
                          color: AppColors.neutralGrey57,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // 点击 "..." 按钮
                          // 通过 GlobalKey 获取按钮的 RenderBox 对象
                          final RenderBox? renderBox = _moreKey.currentContext
                              ?.findRenderObject() as RenderBox?;
                          if (renderBox != null) {
                            // 将按钮的局部坐标转换为全局坐标
                            final Offset position = renderBox.localToGlobal(
                                Offset(
                                    -350.w, // X 轴偏移，让弹出框出现在按钮左边
                                    (renderBox.size.height - 75.w) /
                                        2)); // Y 轴居中
                            // 调用父组件的回调函数，并传递计算好的位置
                            widget.moreOnPress(position);
                          }
                        },
                        child: Container(
                          key: _moreKey, // 绑定 GlobalKey
                          height: 70.w,
                          width: 110.w,
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          color: Colors.transparent, // 透明背景增大点击区域
                          child: Container(
                            decoration: BoxDecoration(
                              color: moreButtonBgColor,
                              borderRadius: BorderRadius.circular(6.w),
                            ),
                            child: Icon(
                              const IconData(0xe667, fontFamily: 'Iconfont'),
                              size: 37.w,
                              color: linkColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // 点赞列表
                  if (widget.likes != null && widget.likes!.isNotEmpty) ...[
                    SizedBox(height: 5.w),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(right: 25.w),
                      padding: EdgeInsets.all(13.w),
                      decoration: BoxDecoration(
                        color: likesContainerBgColor,
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                      child: RichText(
                        // 使用 RichText 来组合图标和可点击的文本
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                const IconData(0xe70a, fontFamily: 'Iconfont'),
                                color: linkColor,
                                size: 28.w,
                              ),
                            ),
                            WidgetSpan(child: SizedBox(width: 10.w)),
                            // 动态构建点赞人名列表
                            ..._buildLikeSpans(
                                context, widget.likes!, linkColor),
                          ],
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建可点击的点赞人名列表的私有方法
  List<InlineSpan> _buildLikeSpans(
      BuildContext context, List<String> likes, Color linkColor) {
    // 每次重建前，先清理并释放旧的手势识别器
    for (var recognizer in _recognizers) {
      recognizer.dispose();
    }
    _recognizers.clear();

    List<InlineSpan> spans = [];
    for (int i = 0; i < likes.length; i++) {
      final name = likes[i];
      // 为每个人名创建一个点击手势
      final recognizer = TapGestureRecognizer()
        ..onTap = () {
          logger.info('Tapped on: $name');
          // 在这里可以添加跳转到用户详情页的逻辑
        };
      _recognizers.add(recognizer); // 将手势添加到列表中以便后续释放

      // 使用 LJNBuildspan 来创建可点击的文本片段
      spans.addAll(LJNBuildspan(
        context,
        name,
        TextStyle(fontSize: fontSizeScale(28.w), color: linkColor),
        TextStyle(fontSize: fontSizeScale(28.w)),
      ));

      // 如果不是最后一个名字，则在后面添加一个逗号
      if (i < likes.length - 1) {
        spans.add(TextSpan(text: ", ", style: TextStyle(color: linkColor)));
      }
    }
    return spans;
  }
}

// --- 九宫格中的单个图片组件 ---
class LJNTweenImage extends StatelessWidget {
  final String imagePath;
  const LJNTweenImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final imageContainerKey = GlobalKey(); // 用于获取图片的位置和大小
    return BlocBuilder<LJNPopupCubit, PopupState>(
      builder: (context, popupState) {
        return GestureDetector(
          onTap: () {
            // 点击图片
            final RenderBox? renderBox = imageContainerKey.currentContext
                ?.findRenderObject() as RenderBox?;
            if (renderBox == null) return;

            // 获取图片在屏幕上的绝对位置和大小
            Offset position = renderBox.localToGlobal(Offset.zero);
            Size size = renderBox.size;

            // 通知 LJNPopupCubit 更新状态，显示全屏图片
            // 传递图片的初始位置、大小和路径，用于实现平滑的放大动画
            context.read<LJNPopupCubit>().updateImagePopup(
                  openBoxSize: size,
                  openPosition: position,
                  imagePath: imagePath,
                  showFullScreenimage: true,
                );
          },
          child: Image.asset(
            key: imageContainerKey, // 绑定 GlobalKey
            assetPath(imagePath),
            width: 186.w,
            height: 186.w,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
