import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/ljn_text_spans.dart';

// --- Data Models for clean data/UI separation ---
class _FunctionButtonData {
  final String icon;
  final String title;
  const _FunctionButtonData({required this.icon, required this.title});
}

class _ChatListItemData {
  final String avatar;
  final String friendName;
  final String message;
  const _ChatListItemData(
      {required this.avatar, required this.friendName, required this.message});
}

class LJNMiniProgramList extends StatefulWidget {
  const LJNMiniProgramList({super.key});

  @override
  State<LJNMiniProgramList> createState() => _LJNMiniProgramList();
}

class _LJNMiniProgramList extends State<LJNMiniProgramList> {
  // Store static data in data models, not widgets.
  static const String _dummyLink =
      "http://inner_list_of_third_party_information_sharing/";

  final List<_FunctionButtonData> recentUseData = const [
    _FunctionButtonData(
        icon: "images/miniprogram_icon/zhihuixiangji.jpg", title: "智慧相机"),
    _FunctionButtonData(
        icon: "images/miniprogram_icon/haimianbaobao.jpg", title: "海绵宝宝"),
    _FunctionButtonData(
        icon: "images/miniprogram_icon/taowuyou.jpg", title: "淘无忧"),
    _FunctionButtonData(
        icon: "images/miniprogram_icon/wangzheyingdi.jpg", title: "王者营地"),
  ];

  final List<_FunctionButtonData> myFavoritesData = const [
    _FunctionButtonData(
        icon: "images/miniprogram_icon/duitang.jpg", title: "堆糖"),
    _FunctionButtonData(
        icon: "images/miniprogram_icon/tiankongyueduqi.jpg", title: "天空阅读器"),
    _FunctionButtonData(
        icon: "images/miniprogram_icon/qishuwang.jpg", title: "奇书网"),
    _FunctionButtonData(
        icon: "images/miniprogram_icon/xueyouyoujiao.jpg", title: "学有优教"),
    _FunctionButtonData(
        icon: "images/miniprogram_icon/haiziwang.jpg", title: "孩子王"),
    _FunctionButtonData(
        icon: "images/miniprogram_icon/qianbixiaoshuo.jpg", title: "铅笔小说"),
    _FunctionButtonData(
        icon: "images/miniprogram_icon/chengquanshipin.jpg", title: "成全视频"),
    _FunctionButtonData(
        icon: "images/miniprogram_icon/xiaomishangcheng.jpg", title: "小米商城"),
    _FunctionButtonData(
        icon: "images/miniprogram_icon/meituxiuxiu.jpg", title: "美图秀秀"),
    _FunctionButtonData(
        icon: "images/miniprogram_icon/luobokuaipao.jpg", title: "萝卜快跑"),
  ];

  final List<_ChatListItemData> transportData = const [
    _ChatListItemData(
        friendName: "粤童年",
        message: "今天天气真好，阳光明媚，让人心情愉悦。",
        avatar: "images/miniprogram_icon/yuetongnianruanjian.jpg"),
    _ChatListItemData(
        friendName: '起点中文',
        message: "[图片]",
        avatar: "images/miniprogram_icon/qidianzhongwen.jpg"),
    _ChatListItemData(
        friendName: "野花香电视剧",
        message: "这个怎么样调试?",
        avatar: "images/miniprogram_icon/yehuaxiangdianshiju.jpg"),
    _ChatListItemData(
        friendName: "韵镖侠",
        message: "你最近过得如何？工作顺利吗？有没有遇到什么有趣的事情？",
        avatar: "images/miniprogram_icon/yunbiaoxia.jpg"),
  ];

  final List<_ChatListItemData> nearbyData = const [
    _ChatListItemData(
        friendName: "蘑菇云游",
        message: "今天天气真好，阳光明媚，让人心情愉悦。",
        avatar: "images/miniprogram_icon/moguyunyou.jpg"),
    _ChatListItemData(
        friendName: '美图秀秀',
        message: "[图片]",
        avatar: "images/miniprogram_icon/meituxiuxiu.jpg"),
    _ChatListItemData(
        friendName: "百度翻译",
        message: "这个怎么样调试?",
        avatar: "images/miniprogram_icon/baidufanyi.jpg"),
    _ChatListItemData(
        friendName: "淘无忧",
        message: "你最近过得如何？工作顺利吗？有没有遇到什么有趣的事情？",
        avatar: "images/miniprogram_icon/taowuyou.jpg"),
  ];

  void _navigateToMiniProgram(BuildContext context) {
    Navigator.of(context)
        .pushNamed("/open_miniprogram?link=${Uri.encodeComponent(_dummyLink)}");
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    ThemeData theme = Theme.of(context);

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false,
          appBar: LJNAppBar(
            title: l10n.miniPrograms,
            actions: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: AppColors.transparent,
                  height: 90.w,
                  padding: EdgeInsets.only(right: 33.w),
                  alignment: Alignment.center,
                  child: Icon(
                    const IconData(0xe612, fontFamily: 'Iconfont'),
                    size: 40.w,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: AppColors.transparent,
                  height: 90.w,
                  padding: EdgeInsets.only(right: 40.w),
                  alignment: Alignment.center,
                  child: Icon(
                    const IconData(0xe726, fontFamily: 'Iconfont'),
                    size: 42.w,
                  ),
                ),
              ),
            ],
          ),
          body: ColoredBox(
            color: theme.colorScheme.surfaceContainer,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 205.w),
                  color: theme.colorScheme.surfaceContainer,
                  child: Column(
                    children: [
                      // 最近使用
                      FunctionButtonsSection(
                        title: l10n.recent,
                        moreUrl: "/",
                        buttons: recentUseData
                            .map((data) => FunctionButton(
                                  icon: data.icon,
                                  title: data.title,
                                  onPressed: () =>
                                      _navigateToMiniProgram(context),
                                ))
                            .toList(),
                      ),
                      // 我的常用
                      FunctionButtonsSection(
                        title: l10n.myFavorites,
                        moreUrl: "",
                        buttons: myFavoritesData
                            .map((data) => FunctionButton(
                                  icon: data.icon,
                                  title: data.title,
                                  onPressed: () =>
                                      _navigateToMiniProgram(context),
                                ))
                            .toList(),
                      ),
                      // 交通出行
                      FunctionListSection(
                        title: "交通出行", // Assuming this is not in l10n
                        moreUrl: '/',
                        chatItems: transportData
                            .map((data) => ChatListItem(
                                  avatar: data.avatar,
                                  friendName: data.friendName,
                                  message: data.message,
                                  onPressed: () =>
                                      _navigateToMiniProgram(context),
                                ))
                            .toList(),
                      ),
                      // 附近小程序
                      FunctionListSection(
                        title: l10n.nearbyMiniPrograms,
                        moreUrl: '/',
                        chatItems: nearbyData
                            .map((data) => ChatListItem(
                                  avatar: data.avatar,
                                  friendName: data.friendName,
                                  message: data.message,
                                  onPressed: () =>
                                      _navigateToMiniProgram(context),
                                ))
                            .toList(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// =========================================================================
// ====================       以下是页面使用的子组件        ====================
// =========================================================================

// --- 小程序按钮项组 ---
class FunctionButtonsSection extends StatelessWidget {
  final String title;
  final List<FunctionButton> buttons;
  final String moreUrl;

  const FunctionButtonsSection(
      {super.key,
      required this.title,
      required this.buttons,
      required this.moreUrl});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 18, left: 18, right: 18).w,
      decoration: BoxDecoration(
        color: AppColors.neutralWhite,
        borderRadius: BorderRadius.circular(16.0).w,
      ),
      padding: const EdgeInsets.only(bottom: 16).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 33.w, bottom: 16.w, left: 30.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    height: 1.08,
                    fontSize: fontSizeScale(28.w),
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                if (moreUrl.isNotEmpty)
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, moreUrl),
                    child: Container(
                      color: AppColors.transparent,
                      padding: EdgeInsets.only(right: 33.w),
                      child: Icon(
                        const IconData(0xe659, fontFamily: 'Iconfont'),
                        size: 37.w,
                      ),
                    ),
                  )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0).w,
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 30.w,
                childAspectRatio: 1.0,
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) => Center(child: buttons[index]),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}

// --- 小程序按钮 (已修正) ---
class FunctionButton extends StatefulWidget {
  final String icon;
  final String title;
  final VoidCallback onPressed;

  const FunctionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  FunctionButtonState createState() => FunctionButtonState();
}

class FunctionButtonState extends State<FunctionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    // 修正：从当前主题获取颜色，而不是硬编码
    final Color pressedColor = theme.highlightColor;

    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: _isPressed ? pressedColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10.0).w,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: Image.asset(
                  assetPath(widget.icon),
                  width: 95.w,
                  height: 95.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 22.w),
              Text(
                widget.title,
                maxLines: 1,
                style: TextStyle(
                  height: 1.08,
                  decoration: TextDecoration.none,
                  color: theme.colorScheme.onSurface.withAlpha(123),
                  fontSize: fontSizeScale(25.0.w),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 小程序列表项组 ---
class FunctionListSection extends StatelessWidget {
  final String title;
  final String moreUrl;
  final List<ChatListItem> chatItems;

  const FunctionListSection({
    super.key,
    required this.title,
    required this.chatItems,
    required this.moreUrl,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 18, left: 18, right: 18).w,
      decoration: BoxDecoration(
        color: AppColors.neutralWhite,
        borderRadius: BorderRadius.circular(16.0).w,
      ),
      padding: const EdgeInsets.only(bottom: 16).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 33.w, bottom: 16.w, left: 30.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    height: 1.08,
                    fontSize: fontSizeScale(28.w),
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                if (moreUrl.isNotEmpty)
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, moreUrl),
                    child: Container(
                      color: AppColors.transparent,
                      padding: EdgeInsets.only(right: 33.w),
                      child: Icon(
                        const IconData(0xe659, fontFamily: 'Iconfont'),
                        size: 37.w,
                      ),
                    ),
                  )
              ],
            ),
          ),
          ListView.builder(
            primary: false,
            itemCount: chatItems.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => chatItems[index],
          ),
        ],
      ),
    );
  }
}

// --- 小程序列表项 (已修正) ---
class ChatListItem extends StatefulWidget {
  final String avatar;
  final String friendName;
  final String message;
  final Function()? onPressed;

  const ChatListItem({
    super.key,
    required this.avatar,
    required this.friendName,
    required this.message,
    this.onPressed,
  });

  @override
  State<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final Color normalColor = theme.listTileTheme.tileColor!;
    final Color pressedColor = theme.listTileTheme.selectedTileColor!;
    final Color currentColor = _isPressed ? pressedColor : normalColor;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onPressed,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      onTapUp: (_) {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      child: Container(
        color: currentColor,
        height: 135.0.w,
        padding: const EdgeInsets.only(left: 30.0).w,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(95).w,
              child: Image.asset(
                assetPath(widget.avatar),
                cacheWidth: 190.w.toInt(),
                cacheHeight: 190.w.toInt(),
                width: 95.w,
                height: 95.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 23.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 12.w),
                  LJNTextSpans(
                    text: widget.friendName,
                    style: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(28.0.w),
                      color: theme.colorScheme.onSurface,
                      fontFamily: "AlibabaPuHuiTi",
                    ),
                    emojiStyle: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(28.w),
                      fontFamily: "NotoColorEmoji-Regular",
                    ),
                  ),
                  SizedBox(height: 10.w),
                  LJNTextSpans(
                    text: widget.message,
                    style: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(25.w),
                      color: AppColors.neutralGrey45,
                    ),
                    emojiStyle: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(25.w),
                      color: AppColors.neutralGrey45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
