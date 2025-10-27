import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/tools/viga_tools.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/viga_function_list_section.dart';
import 'package:vigaviga/widgets/viga_miniprogram_button.dart';
import 'package:vigaviga/widgets/viga_miniprogram_buttons_section.dart';

class _FunctionButtonData {
  final String icon;
  final String title;
  final String cid;
  const _FunctionButtonData({
    required this.icon,
    required this.title,
    required this.cid,
  });
}

class _ChatListItemData {
  final String avatar;
  final String friendName;
  final String message;
  final String cid;
  const _ChatListItemData({
    required this.avatar,
    required this.friendName,
    required this.message,
    required this.cid,
  });
}

class VigaMiniProgramListPage extends StatefulWidget {
  const VigaMiniProgramListPage({super.key});

  @override
  State<VigaMiniProgramListPage> createState() => _VigaMiniProgramList();
}

class _VigaMiniProgramList extends State<VigaMiniProgramListPage> {
  List<_FunctionButtonData> recentUseData = [];
  List<_FunctionButtonData> myFavoritesData = [];
  List<_ChatListItemData> transportData = [];
  List<_ChatListItemData> nearbyData = [];

  @override
  void initState() {
    super.initState();
    var systemCubit = context.read<VigaSystemCubit>();
    String cdnBase = systemCubit.state.cdnBase;

    recentUseData = [
      _FunctionButtonData(
        icon: "$cdnBase/miniprogram_icon/zhihuixiangji.jpg",
        title: "智慧相机",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _FunctionButtonData(
        icon: "$cdnBase/miniprogram_icon/haimianbaobao.jpg",
        title: "海绵宝宝",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _FunctionButtonData(
        icon: "$cdnBase/miniprogram_icon/taowuyou.jpg",
        title: "淘无忧",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _FunctionButtonData(
        icon: "$cdnBase/miniprogram_icon/wangzheyingdi.jpg",
        title: "王者营地",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
    ];

    myFavoritesData = [
      _FunctionButtonData(
        icon: "$cdnBase/miniprogram_icon/duitang.jpg",
        title: "堆糖",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _FunctionButtonData(
        icon: "$cdnBase/miniprogram_icon/tiankongyueduqi.jpg",
        title: "天空阅读器",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _FunctionButtonData(
        icon: "$cdnBase/miniprogram_icon/qishuwang.jpg",
        title: "奇书网",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _FunctionButtonData(
        icon: "$cdnBase/miniprogram_icon/xueyouyoujiao.jpg",
        title: "学有优教",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _FunctionButtonData(
        icon: "$cdnBase/miniprogram_icon/haiziwang.jpg",
        title: "孩子王",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _FunctionButtonData(
        icon: "$cdnBase/miniprogram_icon/qianbixiaoshuo.jpg",
        title: "铅笔小说",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _FunctionButtonData(
        icon: "$cdnBase/miniprogram_icon/chengquanshipin.jpg",
        title: "成全视频",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _FunctionButtonData(
        icon: "$cdnBase/miniprogram_icon/xiaomishangcheng.jpg",
        title: "小米商城",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _FunctionButtonData(
        icon: "$cdnBase/miniprogram_icon/meituxiuxiu.jpg",
        title: "美图秀秀",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _FunctionButtonData(
        icon: "$cdnBase/miniprogram_icon/luobokuaipao.jpg",
        title: "萝卜快跑",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
    ];

    transportData = [
      _ChatListItemData(
        friendName: "粤童年",
        message: "今天天气真好，阳光明媚，让人心情愉悦。",
        avatar: "$cdnBase/miniprogram_icon/yuetongnianruanjian.jpg",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _ChatListItemData(
        friendName: '起点中文',
        message: "[图片]",
        avatar: "$cdnBase/miniprogram_icon/qidianzhongwen.jpg",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _ChatListItemData(
        friendName: "野花香电视剧",
        message: "这个怎么样调试?",
        avatar: "$cdnBase/miniprogram_icon/yehuaxiangdianshiju.jpg",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _ChatListItemData(
        friendName: "韵镖侠",
        message: "你最近过得如何？工作顺利吗？有没有遇到什么有趣的事情？",
        avatar: "$cdnBase/miniprogram_icon/yunbiaoxia.jpg",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
    ];

    nearbyData = [
      _ChatListItemData(
        friendName: "蘑菇云游",
        message: "今天天气真好，阳光明媚，让人心情愉悦。",
        avatar: "$cdnBase/miniprogram_icon/moguyunyou.jpg",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _ChatListItemData(
        friendName: '美图秀秀',
        message: "[图片]",
        avatar: "$cdnBase/miniprogram_icon/meituxiuxiu.jpg",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _ChatListItemData(
        friendName: "百度翻译",
        message: "这个怎么样调试?",
        avatar: "$cdnBase/miniprogram_icon/baidufanyi.jpg",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
      _ChatListItemData(
        friendName: "淘无忧",
        message: "你最近过得如何？工作顺利吗？有没有遇到什么有趣的事情？",
        avatar: "$cdnBase/miniprogram_icon/taowuyou.jpg",
        cid: "bafkreig45s42bvvnhtfnmmsspsqmqewoief3odcxykm2aio36h3y5cz7yi",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    ThemeData theme = Theme.of(context);

    return BlocBuilder<VigaSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false,
          appBar: VigaAppBar(
            title: l10n.miniPrograms,
            actions: [
              VigaAppBarActionIconButton(
                iconData: const IconData(0xe612, fontFamily: 'Iconfont'),
                onTap: () {},
              ),
              VigaAppBarActionIconButton(
                iconData: const IconData(0xe726, fontFamily: 'Iconfont'),
                onTap: () {},
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
                      VigaMiniprogramButtonsSection(
                        title: l10n.recent,
                        moreUrl: "/",
                        buttons: recentUseData
                            .map((data) => VigaMiniprogramButton(
                                  icon: data.icon,
                                  title: data.title,
                                  onPressed: () =>
                                      openMiniprogram(context, data.cid),
                                ))
                            .toList(),
                      ),
                      // 我的常用
                      VigaMiniprogramButtonsSection(
                        title: l10n.myFavorites,
                        moreUrl: "",
                        buttons: myFavoritesData
                            .map((data) => VigaMiniprogramButton(
                                  icon: data.icon,
                                  title: data.title,
                                  onPressed: () =>
                                      openMiniprogram(context, data.cid),
                                ))
                            .toList(),
                      ),
                      // 交通出行
                      VigaFunctionListSection(
                        title: "交通出行", // Assuming this is not in l10n
                        moreUrl: '/',
                        chatItems: transportData
                            .map((data) => VigaChatListItem(
                                  avatar: data.avatar,
                                  friendName: data.friendName,
                                  message: data.message,
                                  onPressed: () =>
                                      openMiniprogram(context, data.cid),
                                ))
                            .toList(),
                      ),
                      // 附近小程序
                      VigaFunctionListSection(
                        title: l10n.nearbyMiniPrograms,
                        moreUrl: '/',
                        chatItems: nearbyData
                            .map((data) => VigaChatListItem(
                                  avatar: data.avatar,
                                  friendName: data.friendName,
                                  message: data.message,
                                  onPressed: () =>
                                      openMiniprogram(context, data.cid),
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
