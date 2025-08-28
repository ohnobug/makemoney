import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/l10n/app_localizations.dart';
import 'package:spicychat/screens/components/ljn_appbar.dart';
import 'package:spicychat/screens/components/ljn_search.dart';
import 'package:spicychat/tools/ljn_logger.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import 'package:spicychat/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNContactTags extends StatefulWidget {
  const LJNContactTags({super.key});

  @override
  State<LJNContactTags> createState() => _LJNContactTags();
}

class _LJNContactTags extends State<LJNContactTags> {
  late List<dynamic> contactList;
  bool _dependenciesInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    contactList = [
      TagInformation(
        title: "天空飘来五个字那都不是事",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "天空飘来五个字那都不是事",
              'icon': "images/avatar_webp/chat_1.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "本因",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "本因",
              'icon': "images/avatar_webp/chat_10.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "赵洵",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "赵洵",
              'icon': "images/avatar_webp/chat_11.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "定静师太",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "定静师太",
              'icon': "images/avatar_webp/chat_12.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "李秋水",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "李秋水",
              'icon': "images/avatar_webp/chat_13.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "谭婆",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "谭婆",
              'icon': "images/avatar_webp/chat_14.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "李傀儡",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "李傀儡",
              'icon': "images/avatar_webp/chat_15.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "貂禅",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "貂禅",
              'icon': "images/avatar_webp/chat_16.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "何三七",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "何三七",
              'icon': "images/avatar_webp/chat_17.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "孔融",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "孔融",
              'icon': "images/avatar_webp/chat_18.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "齐堂主",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "齐堂主",
              'icon': "images/avatar_webp/chat_19.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "博尔术",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "博尔术",
              'icon': "images/avatar_webp/chat_20.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "王语嫣",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "王语嫣",
              'icon': "images/avatar_webp/chat_21.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "秦红棉",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "秦红棉",
              'icon': "images/avatar_webp/chat_22.webp",
            },
          );
        },
      ),
      const TagInformation(
        title: "天竺僧人",
        underline: false,
      ),
      TagInformation(
        title: "段延庆",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "段延庆",
              'icon': "images/avatar_webp/chat_33.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "令狐冲",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "令狐冲",
              'icon': "images/avatar_webp/chat_34.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "英白罗",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "英白罗",
              'icon': "images/avatar_webp/chat_35.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "黄药师",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "黄药师",
              'icon': "images/avatar_webp/chat_36.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "李煜",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "李煜",
              'icon': "images/avatar_webp/chat_37.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "云中鹤",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "云中鹤",
              'icon': "images/avatar_webp/chat_38.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "劳德诺",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "劳德诺",
              'icon': "images/avatar_webp/chat_39.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "包惜弱",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "包惜弱",
              'icon': "images/avatar_webp/chat_40.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "游驹",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "游驹",
              'icon': "images/avatar_webp/chat_41.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "钟万仇",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "钟万仇",
              'icon': "images/avatar_webp/chat_42.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "渔人",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "渔人",
              'icon': "images/avatar_webp/chat_43.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "单叔山",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "单叔山",
              'icon': "images/avatar_webp/chat_44.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "段誉",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "段誉",
              'icon': "images/avatar_webp/chat_45.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "林震南",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "林震南",
              'icon': "images/avatar_webp/chat_46.webp",
            },
          );
        },
      ),
      TagInformation(
        title: "商鞅",
        underline: true,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/contact_tag_group',
            arguments: <String, String>{
              'title': "商鞅",
              'icon': "images/avatar_webp/chat_47.webp",
            },
          );
        },
      ),
      Container(
        width: 750.w,
        height: 105.0.w,
        color: AppColors.neutralWhite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.tagCount(10),
              style: TextStyle(
                height: 1.08,
                fontSize: fontSizeScale(30.w),
                color: AppColors.neutralGrey67,
              ),
            ),
          ],
        ),
      )
    ];

    // 更新标志位
    _dependenciesInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    // didChangeDependencies 可能会在 build 之前未被调用，
    // 这里加一个检查确保 controller 已经被初始化。
    if (!_dependenciesInitialized) {
      // 在 build 第一次运行时，依赖肯定已经准备好了，
      // 如果还没初始化，就调用一下。
      // 这是一种备用安全措施，正常情况下不会执行。
      didChangeDependencies();
    }

    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  // 另起一个函数方便管理
  Widget _buildPage(SystemState systemState) {
    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: AppLocalizations.of(context)!.contactTags,
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.neutralGrey11,
                  AppColors.neutralWhite,
                ],
                stops: [0.3, 0.5],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                LJNSearch(
                  link: '/search_friend',
                  title: AppLocalizations.of(context)!.search,
                ),

                // 列表
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: ListView.builder(
                      primary: false,
                      padding: EdgeInsets.zero,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemCount: contactList.length, // contactList 是你的联系人数据列表
                      itemBuilder: (context, index) {
                        return contactList[index];
                      },
                    ),
                  ),
                ),

                // 底部按钮
                Container(
                  height: 90.w,
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  decoration: BoxDecoration(
                    color: AppColors.neutralGrey2,
                    border: Border(
                      top: BorderSide(
                        color: AppColors.neutralGrey20,
                        width: 1.5.w,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.newAction,
                        style: TextStyle(
                            fontSize: 30.w, color: AppColors.neutralBlack),
                      ),
                      Text(
                        AppLocalizations.of(context)!.edit,
                        style: TextStyle(
                            fontSize: 30.w, color: AppColors.neutralBlack),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 功能列表
class TagInformation extends StatefulWidget {
  final String title;

  final bool underline;
  final int? showStyle;
  final Function()? onPressed;

  const TagInformation({
    super.key,
    required this.title,
    required this.underline,
    this.showStyle,
    this.onPressed,
  });

  @override
  State<TagInformation> createState() => _TagInformationState();
}

class _TagInformationState extends State<TagInformation> {
  // bool isClicked = false;
  Color containerColor = AppColors.neutralWhite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        setState(
          () {
            containerColor = AppColors.neutralGrey18;
          },
        );
      },
      onTapCancel: () {
        setState(
          () {
            containerColor = AppColors.neutralWhite;
          },
        );

        logger.info("取消点击");
      },
      onTapUp: (tapDownDetails) {
        Future.delayed(
          const Duration(milliseconds: 50),
          () {
            setState(() {
              containerColor = AppColors.neutralWhite;
            });
            widget.onPressed!();
          },
        );

        logger.info("弹起");
      },
      child: Container(
        height: 120.0.w,
        padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
        color: containerColor,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 115.w,
                width: 400.w,
                decoration: widget.underline
                    ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.neutralGrey6,
                            width: 1.5.w,
                            style: BorderStyle.solid,
                          ),
                        ),
                      )
                    : BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.transparent,
                            width: 1.5.w,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 标题
                    Row(
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(33.0.w),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: 8.0.w),
                        Text(
                          '(10)',
                          style: TextStyle(
                            fontSize: fontSizeScale(24.0.w),
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0.w),
                    // 子标题
                    Text(
                      '刘浩，牛人',
                      style: TextStyle(
                        fontSize: fontSizeScale(24.0.w),
                        color: Colors.grey,
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
