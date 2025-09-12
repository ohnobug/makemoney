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

// Moved to be accessible by child widgets if needed, or can be kept inside the main state.
late AnimationController _bgController;

class LJNFriendmoments extends StatefulWidget {
  const LJNFriendmoments({super.key});

  @override
  State<LJNFriendmoments> createState() => _LJNFriendmoments();
}

class _LJNFriendmoments extends State<LJNFriendmoments>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  double scrollPosition = 0;

  late AnimationController _appBarcontroller;
  late Animation<double> _appBarOpacity;

  late List tweetList;

  Offset lastedMoreButtonPosition = const Offset(-1000, -1000);
  bool likeBoxVisible = false;
  bool _isScrolling = false;

  late AnimationController _likeController;
  late Animation<double> _likeAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    _appBarcontroller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _appBarOpacity =
        Tween<double>(begin: 0.0, end: 1.0).animate(_appBarcontroller);

    _likeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _bgController = AnimationController(
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _likeAnimation =
        Tween<double>(begin: 360.w, end: 0.w).animate(CurvedAnimation(
      parent: _likeController,
      curve: Curves.easeInOut,
    ));

    // Data initialization
    _initializeTweetData();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _appBarcontroller.dispose();
    _likeController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (!mounted) return;
    double beginPosition =
        context.read<LJNSystemCubit>().state.statusHeight + 450.w;

    setState(() {
      scrollPosition = _scrollController.position.pixels;
      double progress =
          (_scrollController.position.pixels - beginPosition).clamp(0.0, 40.w);
      _appBarcontroller.value = progress / 40.w;
    });

    hideLikeBox(quick: true);
  }

  void showLikeBox(Offset position) {
    if (!mounted) return;
    setState(() {
      lastedMoreButtonPosition = position;
      likeBoxVisible = true;
      _likeController.forward();
    });
  }

  void hideLikeBox({required bool quick}) {
    if (!mounted || !likeBoxVisible) return;
    if (quick) {
      _likeController.value = 0;
      setState(() {
        lastedMoreButtonPosition = const Offset(-1000, -1000);
        likeBoxVisible = false;
      });
    } else {
      _likeController.reverse().then((_) {
        if (mounted) {
          setState(() {
            lastedMoreButtonPosition = const Offset(-1000, -1000);
            likeBoxVisible = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ThemeData theme = Theme.of(context);

    // Corrected: Calculate AppBar colors based on the current theme.
    final Color appBarBgColor =
        theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor;
    final Color appBarTitleColor =
        theme.appBarTheme.titleTextStyle?.color ?? theme.colorScheme.onSurface;

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
                _buildBackground(),
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GestureDetector(
                    onTap: () => hideLikeBox(quick: true),
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollStartNotification) {
                          _isScrolling = true;
                        } else if (notification is ScrollEndNotification) {
                          _isScrolling = false;
                        }
                        return false;
                      },
                      child: ScrollConfiguration(
                        behavior: CustomScrollBehavior().copyWith(
                          scrollbars: false,
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                        ),
                        child: ListView.builder(
                          primary: false,
                          controller: _scrollController,
                          itemCount: tweetList.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return _buildHeader(systemState);
                            } else {
                              var tweet = tweetList[index - 1];
                              return TweetWidget(
                                time: tweet["time"]!,
                                avatarUrl: tweet["avatarUrl"]!,
                                name: tweet["name"]!,
                                tweetContent: tweet["tweetContent"]!,
                                likes: tweet["likes"],
                                imageList: tweet["imageList"],
                                moreOnPress: (Offset position) {
                                  if (_isScrolling) return;
                                  likeBoxVisible
                                      ? hideLikeBox(quick: false)
                                      : showLikeBox(position);
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                if (likeBoxVisible) _buildLikeBox(),
                // Corrected: Use calculated theme-aware colors for the AppBar.
                AnimatedBuilder(
                  animation: _appBarOpacity,
                  builder: (context, child) {
                    final Color currentBgColor =
                        appBarBgColor.withOpacity(_appBarOpacity.value);
                    final Color currentTitleColor =
                        appBarTitleColor.withOpacity(_appBarOpacity.value);
                    final Color currentIconColor = _appBarOpacity.value > 0.7
                        ? theme.colorScheme.onSurface
                        : AppColors.neutralWhite;

                    return Container(
                      color: currentBgColor,
                      width: double.infinity,
                      height: 90.0.w + systemState.statusHeight,
                      padding: EdgeInsets.only(top: systemState.statusHeight),
                      child: AppBar(
                        primary: false,
                        title: Text(l10n.moments),
                        centerTitle: true,
                        titleTextStyle: TextStyle(
                          height: 1.08,
                          fontSize: fontSizeScale(32.w),
                          color: currentTitleColor,
                          fontFamily: "AlibabaPuHuiTi-Medium",
                        ),
                        toolbarHeight: 90.w,
                        elevation: 0,
                        scrolledUnderElevation: 0,
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.transparent,
                        leading: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            color: Colors.transparent,
                            child: Icon(
                              const IconData(0xed9e, fontFamily: 'Iconfont'),
                              color: currentIconColor,
                              size: 36.w,
                            ),
                          ),
                        ),
                        actions: [
                          AnimatedBuilder(
                            animation: _bgController,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, _bgController.value * -300.w),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    color: Colors.transparent,
                                    height: 90.w,
                                    padding: EdgeInsets.only(right: 40.w),
                                    alignment: Alignment.center,
                                    child: Icon(
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

  Widget _buildHeader(SystemState systemState) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return AnimatedBuilder(
      animation: _bgController,
      builder: (context, child) {
        return Container(
          height: (systemState.statusHeight + 630.w) +
              (600.w * _bgController.value),
          alignment: Alignment.center,
          color: _bgController.isAnimating || _bgController.isCompleted
              ? theme.colorScheme.onSurface
              : AppColors.neutralWhite,
          width: 750.w,
          child: Stack(
            children: [
              // ... The rest of your header implementation remains the same ...
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
                        height: _bgController.isCompleted
                            ? (systemState.statusHeight + 630.w) +
                                (600.w * _bgController.value)
                            : 730.w,
                        fit: _bgController.isCompleted
                            ? BoxFit.contain
                            : BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(
                    0,
                    systemState.statusHeight +
                        460.w +
                        (_bgController.value * 300.w)),
                child: Opacity(
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

  Widget _buildBackground() {
    return Container(
      width: 750.w,
      height: 530.w,
      color: AppColors.neutralDarkGrey18,
    );
  }

  Widget _buildLikeBox() {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    // Corrected: Use a theme-aware color for the popup box.
    final Color boxColor = theme.colorScheme.inverseSurface;
    final Color textColor = theme.colorScheme.onInverseSurface;
    final Color dividerColor = textColor.withOpacity(0.5);

    return Positioned(
      top: lastedMoreButtonPosition.dy,
      left: lastedMoreButtonPosition.dx - _likeAnimation.value,
      child: AnimatedBuilder(
        animation: _likeAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _likeController.value,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              width: 360.w,
              height: 75.w,
              decoration: BoxDecoration(
                color: boxColor,
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
              ),
              child: child,
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ... (The like/comment buttons can be stateless now) ...
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

  void _initializeTweetData() {
    tweetList = getTweetList();
  }
}

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

class TweetWidget extends StatefulWidget {
  final String time;
  final String avatarUrl;
  final String name;
  final String tweetContent;
  final List<String>? imageList;
  final List<String>? likes;
  final Function(Offset) moreOnPress;

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
  final GlobalKey _moreKey = GlobalKey();
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    for (var recognizer in _recognizers) {
      recognizer.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    // Corrected: Use theme-aware colors for UI elements.
    final Color linkColor = theme.colorScheme.primary;
    final Color moreButtonBgColor = theme.colorScheme.surfaceContainerHighest;
    final Color likesContainerBgColor =
        theme.colorScheme.surfaceContainerHighest;
    final Color borderColor = theme.dividerColor;

    return Listener(
      onPointerDown: (_) {
        if (_bgController.isCompleted) {
          _bgController.reverse();
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 22.w),
        decoration: BoxDecoration(
          color: AppColors.neutralWhite, // Assuming this is intentional
          border: Border(bottom: BorderSide(color: borderColor, width: 1.5.w)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 37.w),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LJNTextSpans(
                          text: widget.name,
                          style: TextStyle(
                            fontSize: fontSizeScale(32.w),
                            fontFamily: "AlibabaPuHuiTi-Medium",
                            color: linkColor, // Use theme color
                          ),
                        ),
                        LJNTextSpans(
                          text: widget.tweetContent,
                          style: TextStyle(
                            height: 1.4,
                            fontSize: fontSizeScale(32.w),
                            fontFamily: "AlibabaPuHuiTi",
                          ),
                        ),
                        if (widget.imageList != null) ...[
                          SizedBox(height: 10.w),
                          SizedBox(
                            width: 570.w,
                            child: Wrap(
                              spacing: 6.w,
                              runSpacing: 6.w,
                              children: widget.imageList!
                                  .map((path) => path.isEmpty
                                      ? const SizedBox.shrink()
                                      : LJNTweenImage(imagePath: path))
                                  .toList(),
                            ),
                          ),
                          SizedBox(height: 18.w),
                        ],
                        Text(
                          "Tencent Headquarters", // Example location
                          style: TextStyle(
                            fontSize: fontSizeScale(26.w),
                            color: linkColor, // Use theme color
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.time,
                        style: TextStyle(
                          fontSize: fontSizeScale(26.w),
                          color: AppColors.neutralGrey57, // Can also be themed
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final RenderBox? renderBox = _moreKey.currentContext
                              ?.findRenderObject() as RenderBox?;
                          if (renderBox != null) {
                            final Offset position = renderBox.localToGlobal(
                                Offset(-350.w,
                                    (renderBox.size.height - 75.w) / 2));
                            widget.moreOnPress(position);
                          }
                        },
                        child: Container(
                          key: _moreKey,
                          height: 70.w,
                          width: 110.w,
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          color: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                              color: moreButtonBgColor, // Use theme color
                              borderRadius: BorderRadius.circular(6.w),
                            ),
                            child: Icon(
                              const IconData(0xe667, fontFamily: 'Iconfont'),
                              size: 37.w,
                              color: linkColor, // Use theme color
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (widget.likes != null && widget.likes!.isNotEmpty) ...[
                    SizedBox(height: 5.w),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(right: 25.w),
                      padding: EdgeInsets.all(13.w),
                      decoration: BoxDecoration(
                        color: likesContainerBgColor, // Use theme color
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                      child: RichText(
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

  List<InlineSpan> _buildLikeSpans(
      BuildContext context, List<String> likes, Color linkColor) {
    // Clear old recognizers before creating new ones
    for (var recognizer in _recognizers) {
      recognizer.dispose();
    }
    _recognizers.clear();

    List<InlineSpan> spans = [];
    for (int i = 0; i < likes.length; i++) {
      final name = likes[i];
      final recognizer = TapGestureRecognizer()
        ..onTap = () {
          logger.info('Tapped on: $name');
          // Your navigation logic here
        };
      _recognizers.add(recognizer);

      spans.addAll(LJNBuildspan(
        context,
        name,
        TextStyle(fontSize: fontSizeScale(28.w), color: linkColor),
        TextStyle(fontSize: fontSizeScale(28.w)),
      ));

      if (i < likes.length - 1) {
        spans.add(TextSpan(text: ", ", style: TextStyle(color: linkColor)));
      }
    }
    return spans;
  }
}

// --- Tween Image Widget ---
class LJNTweenImage extends StatelessWidget {
  final String imagePath;
  const LJNTweenImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final imageContainerKey = GlobalKey();
    return BlocBuilder<LJNPopupCubit, PopupState>(
      builder: (context, popupState) {
        return GestureDetector(
          onTap: () {
            final RenderBox? renderBox = imageContainerKey.currentContext
                ?.findRenderObject() as RenderBox?;
            if (renderBox == null) return;

            Offset position = renderBox.localToGlobal(Offset.zero);
            Size size = renderBox.size;

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
            width: 186.w,
            height: 186.w,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
