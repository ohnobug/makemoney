import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/tools/viga_tools.dart';

class VigaPersonalInfoCollectionChecklistPage extends StatefulWidget {
  const VigaPersonalInfoCollectionChecklistPage({super.key});

  @override
  State<VigaPersonalInfoCollectionChecklistPage> createState() =>
      _LJPpersonalInfoCollectionChecklist();
}

class _LJPpersonalInfoCollectionChecklist
    extends State<VigaPersonalInfoCollectionChecklistPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<VigaSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false,
          appBar: const VigaAppBar(),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      systemState.appbarHeight -
                      systemState.statusHeight),
              color: AppColors.neutralWhite,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 130.w,
                    ),
                    Text(
                      l10n.personalInfoCollectionList,
                      style: TextStyle(
                        fontSize: 41.w,
                      ),
                    ),
                    SizedBox(
                      height: 45.w,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 68.w, right: 68.w),
                      child: Text(
                        textAlign: TextAlign.center,
                        l10n.personalInfoCollectionFullDescription,
                        style: TextStyle(fontSize: 32.w),
                      ),
                    ),
                    SizedBox(
                      height: 100.0.w,
                    ),

                    // 基本信息
                    SizedBox(
                      width: 690.w,
                      child: Column(
                        children: [
                          Container(
                            height: 105.w,
                            margin: EdgeInsets.only(left: 30.w),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: theme.dividerColor,
                                  width: 1.0.w,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            child: Text(
                              l10n.basicInfo,
                              style: TextStyle(
                                fontSize: 25.w,
                                color:
                                    theme.listTileTheme.titleTextStyle!.color,
                              ),
                            ),
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.avatar,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.name,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.phoneNumber,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.gender,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.region,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.personalSignatureTitle,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.address,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.w,
                    ),
                    // 设备信息
                    SizedBox(
                      width: 690.w,
                      child: Column(
                        children: [
                          Container(
                            height: 105.w,
                            margin: EdgeInsets.only(left: 30.w),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: theme.dividerColor,
                                  width: 1.0.w,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            child: Text(
                              l10n.deviceInfo,
                              style: TextStyle(
                                fontSize: 25.w,
                                color: AppColors.neutralDarkGrey13,
                              ),
                            ),
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.loggedInDevices,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.w,
                    ),
                    // 用户使用过程信息
                    SizedBox(
                      width: 690.w,
                      child: Column(
                        children: [
                          Container(
                            height: 105.w,
                            margin: EdgeInsets.only(left: 30.w),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: theme.dividerColor,
                                  width: 1.0.w,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            child: Text(
                              l10n.userInfoDuringUse,
                              style: TextStyle(
                                fontSize: 25.w,
                                color: AppColors.neutralDarkGrey13,
                              ),
                            ),
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.location,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          VigaPCCFunctionItem(
                            title: "图片与视频",
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.w,
                    ),
                    // 社交与内容信息
                    SizedBox(
                      width: 690.w,
                      child: Column(
                        children: [
                          Container(
                            height: 105.w,
                            margin: EdgeInsets.only(left: 30.w),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: theme.dividerColor,
                                  width: 1.0.w,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            child: Text(
                              l10n.socialAndContentInfo,
                              style: TextStyle(
                                fontSize: 25.w,
                                color: AppColors.neutralDarkGrey13,
                              ),
                            ),
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.moments,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.status,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.vigavigaBeans,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.weRun,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          VigaPCCFunctionItem(
                            title: Text(
                              l10n.look,
                              style: TextStyle(
                                height: 1.08,
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeScale(32.0.w),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                            ),
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.officialAccounts,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.miniPrograms,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.channels,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.vigavigaGames,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.w,
                    ),
                    // 联系人信息
                    SizedBox(
                      width: 690.w,
                      child: Column(
                        children: [
                          Container(
                            height: 105.w,
                            margin: EdgeInsets.only(left: 30.w),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: theme.dividerColor,
                                  width: 1.0.w,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            child: Text(
                              l10n.contactInfo,
                              style: TextStyle(
                                fontSize: 25.w,
                                color: AppColors.neutralDarkGrey13,
                              ),
                            ),
                          ),
                          VigaPCCFunctionItem(
                            title: l10n.phoneContacts,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100.w,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// 功能列表
class VigaPCCFunctionItem extends StatefulWidget {
  final String? icon;
  final double? height;
  final Object? title;
  final String? link;
  final bool underline;
  final Object? showStyle;
  final bool? tapEffect;
  final Color? backgroundColor;

  const VigaPCCFunctionItem(
      {super.key,
      this.icon,
      this.height,
      required this.title,
      this.link,
      required this.underline,
      this.showStyle,
      this.tapEffect,
      this.backgroundColor});

  @override
  State<VigaPCCFunctionItem> createState() => _VigaPCCFunctionItemState();
}

class _VigaPCCFunctionItemState extends State<VigaPCCFunctionItem> {
  // bool isClicked = false;
  late Color originContainerColor;
  late Color containerColor;
  late bool tapEffect;

  @override
  void initState() {
    super.initState();

    originContainerColor = widget.backgroundColor ?? AppColors.neutralWhite;

    setState(() {
      containerColor = originContainerColor;
      tapEffect = widget.tapEffect ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTapDown: (tapDownDetails) {
        if (tapEffect == false) return;
        setState(() {
          containerColor = AppColors.neutralGrey17;
        });
      },
      onTapCancel: () {
        if (tapEffect == false) return;

        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = originContainerColor;
          });
          logger.info("取消点击");
        });
      },
      onTapUp: (tapDownDetails) {
        if (tapEffect == false) return;

        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = originContainerColor;
          });

          if (context.mounted && widget.link != null) {
            context.push(widget.link!);
          }

          logger.info("弹起");
        });
      },
      child: Container(
        height: widget.height ?? 105.0.w,
        padding: const EdgeInsets.only(
          left: 30.0,
          right: 0.0,
        ).w,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10.w),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              // 头像
              Container(
                width: 40.0.w,
                height: 40.0.w,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  // borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(
                      assetPath(widget.icon!),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 25.w)
            ],
            Expanded(
              child: Container(
                height: double.infinity,
                // height: double.infinity,
                // width: 400.w,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: widget.underline
                        ? (theme.listTileTheme.shape as RoundedRectangleBorder)
                            .side
                        : BorderSide.none,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.title is String
                        ?
                        // 标题
                        Text(
                            widget.title as String,
                            style: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(32.0.w),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                          )
                        : widget.title as Widget,
                    if (widget.showStyle != null)
                      widget.showStyle is String
                          ? Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                  left: 10,
                                ).w,
                                // color: AppColors.accentRedPure,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.showStyle as String,
                                      style: TextStyle(
                                        height: 1.08,
                                        fontSize: fontSizeScale(30.w),
                                        color: AppColors.neutralDarkGrey7,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : widget.showStyle as Widget,
                    if (widget.link != null)
                      Container(
                        width: 30.w,
                        margin: const EdgeInsets.only(right: 32).w,
                        child: Icon(
                          const IconData(
                            0xed9d,
                            fontFamily: 'Iconfont',
                          ),
                          size: 30.0.w,
                          color: theme.colorScheme.onSurface.withAlpha(100),
                        ),
                      )
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
