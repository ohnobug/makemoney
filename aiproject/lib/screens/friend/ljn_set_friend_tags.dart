import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

class LJNSetFriendTags extends StatefulWidget {
  const LJNSetFriendTags({
    super.key,
  });

  @override
  State<LJNSetFriendTags> createState() => _LJNSetFriendTags();
}

class _LJNSetFriendTags extends State<LJNSetFriendTags> {
  List<String> selectedTag = [];

  List<String> unselectTags = [
    "同学",
    "老婆",
    "情人",
    "矮冬瓜",
    "肥猪",
    "瘦猴",
    "歪嘴怪",
    "斗鸡眼",
    "龅牙妹",
    "邋遢鬼",
    "臭乞丐",
    "油腻男",
    "卑鄙小人",
    "阴险狡诈之徒",
    "虚伪者",
    "两面派",
    "势利眼",
    "笑面虎",
    "暴躁狂",
    "神经质",
    "小心眼",
    "醋坛子",
    "杠精",
    "喷子",
    "孤立者",
    "马屁精",
    "墙头草",
    "懒汉",
    "废物",
    "草包",
    "饭桶",
    "笨蛋",
    "傻瓜",
    "白痴",
    "脑残",
    "黑心商人",
    "无良医生",
    "贪腐官员"
  ];

  TextEditingController inputController = TextEditingController(text: "");
  FocusNode focusNode = FocusNode();
  int willBeRemoveTagofLast = 3;

  @override
  void initState() {
    super.initState();

    inputController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  // 另起一个函数方便管理
  Widget _buildPage(SystemState systemState) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      primary: false,
      appBar: LJNAppBar(
        title: AppLocalizations.of(context)!.addFromAllTags,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 60.w,
              constraints: BoxConstraints(minWidth: 98.w),
              margin: EdgeInsets.only(right: 30.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.brandGreenVibrant3,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.w),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.save,
                // textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.neutralWhite,
                  fontSize: 25.w,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          )
        ],
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Container(
          width: 750.w,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                90.w -
                systemState.statusHeight,
          ),
          color: Theme.of(context).colorScheme.surface,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                // 已选标签
                Container(
                  width: 750.w,
                  padding: EdgeInsets.only(
                    left: 30.w,
                    top: 35.w,
                    bottom: 35.w,
                    right: 10.w,
                  ),
                  color: AppColors.neutralWhite,
                  constraints: BoxConstraints(minHeight: 102.w),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 17.w,
                    runSpacing: 10.w,
                    children: [
                      ...selectedTag.asMap().map((key, value) {
                        logger
                            .info('ttttttttttttttttttt$willBeRemoveTagofLast');

                        if (key == selectedTag.length - 1 &&
                            willBeRemoveTagofLast == 2) {
                          return MapEntry(
                            key,
                            GestureDetector(
                              onTap: () {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  setState(() {
                                    willBeRemoveTagofLast = 3;
                                  });
                                });
                              },
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Container(
                                  height: 60.w,
                                  padding: EdgeInsets.only(left: 25.w),
                                  // margin: EdgeInsets.only(right: 17.w),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.brandGreenVibrant3,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.w),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        value,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          height: 1.08,
                                          fontSize: 28.w,
                                          color: AppColors.neutralWhite,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedTag.removeAt(key);
                                          });
                                        },
                                        child: Container(
                                          width: 50.w,
                                          height: 50.w,
                                          color: AppColors.transparent,
                                          alignment: Alignment.center,
                                          child: Icon(
                                            const IconData(
                                              0xe627,
                                              fontFamily: 'Iconfont',
                                            ),
                                            color: AppColors.neutralWhite,
                                            size: 35.w,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                        return MapEntry(
                          key,
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTag.remove(value);
                              });
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Container(
                                height: 60.w,
                                padding:
                                    EdgeInsets.only(left: 25.w, right: 25.w),
                                // margin: EdgeInsets.only(right: 17.w),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.brandTealBackground1,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.w),
                                  ),
                                ),
                                child: Text(
                                  value,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 28.w,
                                    color: AppColors.brandGreenDarker2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).values,

                      // 输入标签
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Container(
                          height: 60.w,
                          width: 310.w,
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          // margin: EdgeInsets.only(right: 17.w),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.brandTealBackground1,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.w),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 输入框
                              Expanded(
                                flex: 1,
                                child: Container(
                                  // width: 210.w,
                                  alignment: Alignment.center,
                                  height: 60.w,
                                  child: KeyboardListener(
                                    focusNode: FocusNode(),
                                    onKeyEvent: (KeyEvent event) {
                                      if (event is KeyDownEvent) {
                                        if (event.logicalKey.keyLabel ==
                                            "Backspace") {
                                          if (inputController.text.isEmpty &&
                                              selectedTag.isNotEmpty) {
                                            setState(() {
                                              willBeRemoveTagofLast -= 1;
                                              if (willBeRemoveTagofLast == 1) {
                                                selectedTag.removeLast();
                                                willBeRemoveTagofLast = 3;
                                              }
                                            });
                                          }
                                        }
                                        logger.info(
                                            '|||${inputController.text.isEmpty}||| 按键按下: ${event.logicalKey}');
                                      } else {
                                        logger.info(
                                            '|||${inputController.text.isEmpty}||| ttttttttttt: ${event.logicalKey}');
                                      }
                                    },
                                    child: TextField(
                                      readOnly: false,
                                      autofocus: false,
                                      showCursor: true,
                                      controller: inputController,
                                      focusNode: focusNode,
                                      onTapOutside: (event) {
                                        focusNode.unfocus();
                                      },
                                      // focusNode: inputFocusNode1,
                                      onTap: () {},
                                      onSubmitted: (value) {
                                        setState(() {
                                          selectedTag.add(value);
                                          unselectTags.add(value);
                                        });
                                      },
                                      cursorColor: const Color.fromRGBO(
                                          62, 174, 86, 1.0),
                                      // cursorHeight: 44.w,
                                      cursorWidth: 3.w,
                                      // textAlign: TextAlign.center,
                                      style: TextStyle(
                                        // height: 1.08,
                                        fontSize: fontSizeScale(28.w),
                                        color: AppColors.brandGreenDarker2,
                                      ),
                                      // strutStyle: StrutStyle(fontSize: fontSizeScale(20.w),),
                                      minLines: 1,
                                      onChanged: (newText) {
                                        inputController.value =
                                            inputController.value.copyWith(
                                          text: newText,
                                          selection: TextSelection.fromPosition(
                                            TextPosition(
                                                offset: newText.length),
                                          ),
                                        );
                                      },
                                      decoration: InputDecoration(
                                        // fillColor:
                                        //     AppColors.accentRedVibrant2,
                                        // filled: true,
                                        // focusColor: AppColors.accentRedPure,
                                        // hoverColor:
                                        //     AppColors.neutralGrey2,
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5.w,
                                          // vertical: 30.w,
                                        ),
                                        hintText: AppLocalizations.of(context)!
                                            .createOrSearchTags,
                                        hintStyle: TextStyle(
                                          fontSize: fontSizeScale(28.w),
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // 确认按钮
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTag
                                        .add(inputController.text.trim());
                                    unselectTags
                                        .add(inputController.text.trim());
                                    inputController.clear();
                                  });
                                },
                                child: Container(
                                  width: 40.w,
                                  height: 40.w,
                                  alignment: Alignment.center,
                                  // color: AppColors.accentRedPure,
                                  child: Icon(
                                    const IconData(
                                      0xe64e,
                                      fontFamily: 'Iconfont',
                                    ),
                                    color: AppColors.brandGreenVibrant3,
                                    size: 35.w,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // 标题
                Container(
                  height: 73.w,
                  width: 750.w,
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.allTags,
                        style: TextStyle(
                          fontSize: 27.w,
                          color: AppColors.neutralGrey58,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.edit,
                        style: TextStyle(
                          fontSize: 27.w,
                          color: AppColors.neutralGrey58,
                        ),
                      ),
                    ],
                  ),
                ),

                // 未选标签
                Container(
                  width: 750.w,
                  padding: EdgeInsets.only(
                    left: 30.w,
                    right: 10.w,
                    bottom: 200.w,
                  ),
                  // color: AppColors.neutralWhite,
                  constraints: BoxConstraints(minHeight: 102.w),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 17.w,
                    runSpacing: 10.w,
                    children: [
                      // 待选标签
                      ...unselectTags.map(
                        (value) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedTag.contains(value)) {
                                  selectedTag.remove(value);
                                } else {
                                  selectedTag.add(value);
                                }
                              });
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Container(
                                height: 60.w,
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: selectedTag.contains(value)
                                      ? AppColors.brandTealBackground1
                                      : AppColors.neutralGrey2,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.w),
                                  ),
                                ),
                                child: Text(
                                  value,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    height: 1.08,
                                    fontSize: 28.w,
                                    color: selectedTag.contains(value)
                                        ? AppColors.brandGreenDarker2
                                        : AppColors.neutralGrey53,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      // 输入标签
                      GestureDetector(
                        onTap: () {
                          _showPopup(context, systemState, (String text) {
                            if (unselectTags.contains(text)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    textAlign: TextAlign.center,
                                    AppLocalizations.of(context)!
                                        .create_success_message,
                                  ),
                                  duration: Duration(
                                    seconds: 3,
                                  ), // 设置 Snackbar 显示时间
                                ),
                              );

                              return;
                            }

                            setState(() {
                              unselectTags.add(text);
                            });
                          });
                        },
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            height: 60.w,
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.neutralGrey10,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.w),
                              ),
                              border: Border.all(
                                width: 1.5.w,
                                color: AppColors.neutralGrey30,
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.newTag,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 1.08,
                                fontSize: 28.w,
                                color: AppColors.neutralGrey48,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showPopup(
    BuildContext context, SystemState systemState, Function callback) {
  TextEditingController inputController2 = TextEditingController(text: "");

  final underlineInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      width: 1.5.w,
      color: AppColors.neutralGrey30,
    ),
  );

  showModalBottomSheet(
    context: context,
    barrierColor: AppColors.blackTransparent47,
    // backgroundColor: AppColors.accentRedPure,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(13.w),
      ),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            color: AppColors.neutralWhite,
            height: 600.w,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 70.w,
                ),

                // 标题
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        margin: EdgeInsets.only(left: 50.w),
                        alignment: Alignment.center,
                        child: Icon(
                          const IconData(
                            0xe628,
                            fontFamily: 'Iconfont',
                          ),
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 33.w,
                        ),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.enterTag,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35.w,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontFamily: "AlibabaPuHuiTi-Medium",
                      ),
                    ),
                    SizedBox(
                      width: 90.w,
                    )
                  ],
                ),

                SizedBox(
                  height: 95.w,
                ),

                // 输入框
                Container(
                  color: AppColors.transparent,
                  height: 70.w,
                  width: 750.w,
                  padding: EdgeInsets.only(left: 90.w, right: 90.w),
                  alignment: Alignment.center,
                  child: TextField(
                    readOnly: false,
                    autofocus: false,
                    showCursor: true,
                    maxLines: 1,
                    controller: inputController2,
                    onTap: () {},
                    cursorColor: AppColors.brandGreenDarker4,
                    cursorWidth: 3.w,
                    style: TextStyle(
                      fontSize: fontSizeScale(28.w),
                      color: AppColors.brandGreenDarker2,
                    ),
                    minLines: 1,
                    onChanged: (newText) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 15.w,
                      ),
                      hintText: AppLocalizations.of(context)!.tagName,
                      hintStyle: TextStyle(
                        fontSize: fontSizeScale(35.w),
                        color: Colors.grey,
                      ),
                      border: underlineInputBorder,
                      focusedBorder: underlineInputBorder,
                      enabledBorder: underlineInputBorder,
                      disabledBorder: underlineInputBorder,
                      focusedErrorBorder: underlineInputBorder,
                      errorBorder: underlineInputBorder,
                    ),
                  ),
                ),

                SizedBox(
                  height: 130.w,
                ),

                // 确认按钮
                GestureDetector(
                  onTap: () {
                    var text = inputController2.text.trim();
                    if (text.isEmpty) return;

                    callback(text);

                    inputController2.clear();

                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          textAlign: TextAlign.center,
                          AppLocalizations.of(context)!.create_success_message,
                        ),
                        duration: Duration(
                          seconds: 3,
                        ), // 设置 Snackbar 显示时间
                      ),
                    );
                  },
                  child: Container(
                    width: 345.w,
                    height: 90.w,
                    decoration: BoxDecoration(
                      color: inputController2.text.isEmpty
                          ? Theme.of(context).listTileTheme.selectedTileColor!
                          : AppColors.brandGreenVibrant3,
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.confirm,
                      style: TextStyle(
                        color: inputController2.text.isEmpty
                            ? AppColors.neutralGrey37
                            : AppColors.neutralWhite,
                        fontSize: 32.w,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
    },
  );
}
