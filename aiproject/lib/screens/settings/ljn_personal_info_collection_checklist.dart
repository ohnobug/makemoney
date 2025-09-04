import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

class LJNPersonalInfoCollectionChecklist extends StatefulWidget {
  const LJNPersonalInfoCollectionChecklist({super.key});

  @override
  State<LJNPersonalInfoCollectionChecklist> createState() =>
      _LJPpersonalInfoCollectionChecklist();
}

class _LJPpersonalInfoCollectionChecklist
    extends State<LJNPersonalInfoCollectionChecklist> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false,
          appBar: const LJNAppBar(
            bgColor: AppColors.neutralWhite,
          ),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      90.w -
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
                      AppLocalizations.of(context)!.personalInfoCollectionList,
                      style: TextStyle(
                          fontSize: 41.w, fontFamily: "AlibabaPuHuiTi-Medium"),
                    ),
                    SizedBox(
                      height: 45.w,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 68.w, right: 68.w),
                      child: Text(
                        textAlign: TextAlign.center,
                        AppLocalizations.of(context)!
                            .personalInfoCollectionFullDescription,
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
                                  color: Theme.of(context).listTileTheme.selectedTileColor!,
                                  width: 1.5.w,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.basicInfo,
                              style: TextStyle(
                                fontSize: 25.w,
                                color: AppColors.neutralDarkGrey13,
                              ),
                            ),
                          ),
                          LJNPCCFunctionItem(
                            title: AppLocalizations.of(context)!.avatar,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          LJNPCCFunctionItem(
                            title: AppLocalizations.of(context)!.name,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          LJNPCCFunctionItem(
                            title: AppLocalizations.of(context)!.phoneNumber,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          LJNPCCFunctionItem(
                            title: AppLocalizations.of(context)!.gender,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          LJNPCCFunctionItem(
                            title: AppLocalizations.of(context)!.region,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          LJNPCCFunctionItem(
                            title: AppLocalizations.of(context)!
                                .personalSignatureTitle,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          LJNPCCFunctionItem(
                            title: AppLocalizations.of(context)!.address,
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
                                  color: Theme.of(context).listTileTheme.selectedTileColor!,
                                  width: 1.5.w,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.deviceInfo,
                              style: TextStyle(
                                fontSize: 25.w,
                                color: AppColors.neutralDarkGrey13,
                              ),
                            ),
                          ),
                          LJNPCCFunctionItem(
                            title:
                                AppLocalizations.of(context)!.loggedInDevices,
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
                                  color: Theme.of(context).listTileTheme.selectedTileColor!,
                                  width: 1.5.w,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.userInfoDuringUse,
                              style: TextStyle(
                                fontSize: 25.w,
                                color: AppColors.neutralDarkGrey13,
                              ),
                            ),
                          ),
                          LJNPCCFunctionItem(
                            title: AppLocalizations.of(context)!.location,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          LJNPCCFunctionItem(
                            title:
                                AppLocalizations.of(context)!.imagesAndVideos,
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
                                  color: Theme.of(context).listTileTheme.selectedTileColor!,
                                  width: 1.5.w,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .socialAndContentInfo,
                              style: TextStyle(
                                fontSize: 25.w,
                                color: AppColors.neutralDarkGrey13,
                              ),
                            ),
                          ),
                          LJNPCCFunctionItem(
                            title: AppLocalizations.of(context)!.moments,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          LJNPCCFunctionItem(
                            title: AppLocalizations.of(context)!.status,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          LJNPCCFunctionItem(
                            title: AppLocalizations.of(context)!.wechatBeans,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          LJNPCCFunctionItem(
                            title: AppLocalizations.of(context)!.weRun,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          LJNPCCFunctionItem(
                            title: Text(
                              AppLocalizations.of(context)!.look,
                              style: TextStyle(
                                height: 1.08,
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeScale(32.0.w),
                                fontFamily: "AlibabaPuHuiTi",
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                            ),
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          LJNPCCFunctionItem(
                            title:
                                AppLocalizations.of(context)!.officialAccounts,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          LJNPCCFunctionItem(
                            title: AppLocalizations.of(context)!.miniPrograms,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          LJNPCCFunctionItem(
                            title: AppLocalizations.of(context)!.channels,
                            link: '',
                            underline: true,
                            tapEffect: true,
                          ),
                          LJNPCCFunctionItem(
                            title: AppLocalizations.of(context)!.wechatGames,
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
                                  color: Theme.of(context).listTileTheme.selectedTileColor!,
                                  width: 1.5.w,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.contactInfo,
                              style: TextStyle(
                                fontSize: 25.w,
                                color: AppColors.neutralDarkGrey13,
                              ),
                            ),
                          ),
                          LJNPCCFunctionItem(
                            title: AppLocalizations.of(context)!.phoneContacts,
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
class LJNPCCFunctionItem extends StatefulWidget {
  final String? icon;
  final double? height;
  final Object? title;
  final String? link;
  final bool underline;
  final Object? showStyle;
  final bool? tapEffect;
  final Color? backgroundColor;

  const LJNPCCFunctionItem(
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
  State<LJNPCCFunctionItem> createState() => _LJNPCCFunctionItemState();
}

class _LJNPCCFunctionItemState extends State<LJNPCCFunctionItem> {
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
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        if (tapEffect == false) return;
        setState(() {
          containerColor = AppColors.neutralGrey17;
        });
      },
      onTapCancel: () {
        if (tapEffect == false) return;
        setState(() {
          containerColor = originContainerColor;
        });

        logger.info("取消点击");
      },
      onTapUp: (tapDownDetails) {
        if (tapEffect == false) return;
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = originContainerColor;
          });

          if (context.mounted && widget.link != null) {
            Navigator.pushNamed(context, widget.link!);
          }
        });

        logger.info("弹起");
      },
      child: Container(
        height: widget.height ?? 105.0.w,
        padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
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
                    bottom: BorderSide(
                      color: widget.underline
                          ? Theme.of(context).listTileTheme.selectedTileColor!
                          : AppColors.transparent,
                      width: 1.5.w,
                      style: BorderStyle.solid,
                    ),
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
                              fontFamily: "AlibabaPuHuiTi",
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                          )
                        : widget.title as Widget,
                    if (widget.showStyle != null)
                      widget.showStyle is String
                          ? Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10)
                                        .w,
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
                          color: AppColors.neutralGrey50,
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
