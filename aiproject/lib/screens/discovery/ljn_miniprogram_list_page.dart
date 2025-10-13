import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/ljn_function_list_section.dart';
import 'package:vigaviga/widgets/ljn_miniprogram_button.dart';
import 'package:vigaviga/widgets/ljn_miniprogram_buttons_section.dart';

class _FunctionButtonData {
  final String icon;
  final String title;
  const _FunctionButtonData({required this.icon, required this.title});
}

class _ChatListItemData {
  final String avatar;
  final String friendName;
  final String message;
  const _ChatListItemData({
    required this.avatar,
    required this.friendName,
    required this.message,
  });
}

class LJNMiniProgramListPage extends StatefulWidget {
  const LJNMiniProgramListPage({super.key});

  @override
  State<LJNMiniProgramListPage> createState() => _LJNMiniProgramList();
}

class _LJNMiniProgramList extends State<LJNMiniProgramListPage> {
  // Store static data in data models, not widgets.
  static const String _dummyLink =
      "http://inner_list_of_third_party_information_sharing/";

  List<_FunctionButtonData> recentUseData = [];
  List<_FunctionButtonData> myFavoritesData = [];
  List<_ChatListItemData> transportData = [];
  List<_ChatListItemData> nearbyData = [];

  @override
  void initState() {
    super.initState();
    var systemCubit = context.read<LJNSystemCubit>();
    String cdnBase = systemCubit.state.cdnBase;

    recentUseData = [
      _FunctionButtonData(
          icon: "$cdnBase/miniprogram_icon/zhihuixiangji.jpg", title: "智慧相机"),
      _FunctionButtonData(
          icon: "$cdnBase/miniprogram_icon/haimianbaobao.jpg", title: "海绵宝宝"),
      _FunctionButtonData(
          icon: "$cdnBase/miniprogram_icon/taowuyou.jpg", title: "淘无忧"),
      _FunctionButtonData(
          icon: "$cdnBase/miniprogram_icon/wangzheyingdi.jpg", title: "王者营地"),
    ];

    myFavoritesData = [
      _FunctionButtonData(
          icon: "$cdnBase/miniprogram_icon/duitang.jpg", title: "堆糖"),
      _FunctionButtonData(
          icon: "$cdnBase/miniprogram_icon/tiankongyueduqi.jpg",
          title: "天空阅读器"),
      _FunctionButtonData(
          icon: "$cdnBase/miniprogram_icon/qishuwang.jpg", title: "奇书网"),
      _FunctionButtonData(
          icon: "$cdnBase/miniprogram_icon/xueyouyoujiao.jpg", title: "学有优教"),
      _FunctionButtonData(
          icon: "$cdnBase/miniprogram_icon/haiziwang.jpg", title: "孩子王"),
      _FunctionButtonData(
          icon: "$cdnBase/miniprogram_icon/qianbixiaoshuo.jpg", title: "铅笔小说"),
      _FunctionButtonData(
          icon: "$cdnBase/miniprogram_icon/chengquanshipin.jpg", title: "成全视频"),
      _FunctionButtonData(
          icon: "$cdnBase/miniprogram_icon/xiaomishangcheng.jpg",
          title: "小米商城"),
      _FunctionButtonData(
          icon: "$cdnBase/miniprogram_icon/meituxiuxiu.jpg", title: "美图秀秀"),
      _FunctionButtonData(
          icon: "$cdnBase/miniprogram_icon/luobokuaipao.jpg", title: "萝卜快跑"),
    ];

    transportData = [
      _ChatListItemData(
          friendName: "粤童年",
          message: "今天天气真好，阳光明媚，让人心情愉悦。",
          avatar: "$cdnBase/miniprogram_icon/yuetongnianruanjian.jpg"),
      _ChatListItemData(
          friendName: '起点中文',
          message: "[图片]",
          avatar: "$cdnBase/miniprogram_icon/qidianzhongwen.jpg"),
      _ChatListItemData(
          friendName: "野花香电视剧",
          message: "这个怎么样调试?",
          avatar: "$cdnBase/miniprogram_icon/yehuaxiangdianshiju.jpg"),
      _ChatListItemData(
          friendName: "韵镖侠",
          message: "你最近过得如何？工作顺利吗？有没有遇到什么有趣的事情？",
          avatar: "$cdnBase/miniprogram_icon/yunbiaoxia.jpg"),
    ];

    nearbyData = [
      _ChatListItemData(
          friendName: "蘑菇云游",
          message: "今天天气真好，阳光明媚，让人心情愉悦。",
          avatar: "$cdnBase/miniprogram_icon/moguyunyou.jpg"),
      _ChatListItemData(
          friendName: '美图秀秀',
          message: "[图片]",
          avatar: "$cdnBase/miniprogram_icon/meituxiuxiu.jpg"),
      _ChatListItemData(
          friendName: "百度翻译",
          message: "这个怎么样调试?",
          avatar: "$cdnBase/miniprogram_icon/baidufanyi.jpg"),
      _ChatListItemData(
          friendName: "淘无忧",
          message: "你最近过得如何？工作顺利吗？有没有遇到什么有趣的事情？",
          avatar: "$cdnBase/miniprogram_icon/taowuyou.jpg"),
    ];
  }

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
                  color: Colors.transparent,
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
                  color: Colors.transparent,
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
                    minHeight: MediaQuery.of(context).size.height - 205.w,
                  ),
                  color: theme.colorScheme.surfaceContainer,
                  child: Column(
                    children: [
                      // 最近使用
                      LJNMiniprogramButtonsSection(
                        title: l10n.recent,
                        moreUrl: "/",
                        buttons: recentUseData
                            .map((data) => LJNMiniprogramButton(
                                  icon: data.icon,
                                  title: data.title,
                                  onPressed: () =>
                                      _navigateToMiniProgram(context),
                                ))
                            .toList(),
                      ),
                      // 我的常用
                      LJNMiniprogramButtonsSection(
                        title: l10n.myFavorites,
                        moreUrl: "",
                        buttons: myFavoritesData
                            .map((data) => LJNMiniprogramButton(
                                  icon: data.icon,
                                  title: data.title,
                                  onPressed: () =>
                                      _navigateToMiniProgram(context),
                                ))
                            .toList(),
                      ),
                      // 交通出行
                      LJNFunctionListSection(
                        title: "交通出行", // Assuming this is not in l10n
                        moreUrl: '/',
                        chatItems: transportData
                            .map((data) => LJNChatListItem(
                                  avatar: data.avatar,
                                  friendName: data.friendName,
                                  message: data.message,
                                  onPressed: () =>
                                      _navigateToMiniProgram(context),
                                ))
                            .toList(),
                      ),
                      // 附近小程序
                      LJNFunctionListSection(
                        title: l10n.nearbyMiniPrograms,
                        moreUrl: '/',
                        chatItems: nearbyData
                            .map((data) => LJNChatListItem(
                                  avatar: data.avatar,
                                  friendName: data.friendName,
                                  message: data.message,
                                  onPressed: () =>
                                      _navigateToMiniProgram(context),
                                ))
                            .toList(),
                      ),
                      SizedBox(
                        height: 100.w,
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
