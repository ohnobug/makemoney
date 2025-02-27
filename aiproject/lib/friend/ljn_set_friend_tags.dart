import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/ljn_system_cubit.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_tools.dart';

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

  @override
  void initState() {
    super.initState();
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
      primary: false,
      appBar: LJNAppBar(
        title: "从全部标签中添加",
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 60.w,
              constraints: BoxConstraints(minWidth: 98.w),
              margin: EdgeInsets.only(right: 30.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 74, 193, 99),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.w),
                ),
              ),
              child: Text(
                "保存",
                // textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
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
          width: systemState.screenSize.width,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                90.w -
                systemState.statusHeight,
          ),
          color: const Color.fromARGB(255, 237, 237, 237),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                // 已选标签
                Container(
                  width: systemState.screenSize.width,
                  padding: EdgeInsets.only(
                    left: 30.w,
                    top: 35.w,
                    bottom: 35.w,
                    right: 10.w,
                  ),
                  color: Colors.white,
                  constraints: BoxConstraints(minHeight: 102.w),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 17.w,
                    runSpacing: 10.w,
                    children: [
                      ...selectedTag.map(
                        (value) {
                          return GestureDetector(
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
                                  color: Color.fromARGB(255, 233, 248, 243),
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
                                    color: Color.fromARGB(255, 65, 183, 88),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      // 输入标签
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Container(
                          height: 60.w,
                          width: 330.w,
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          // margin: EdgeInsets.only(right: 17.w),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 233, 248, 243),
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
                                  child: TextField(
                                    readOnly: false,
                                    autofocus: false,
                                    showCursor: true,
                                    controller: inputController,
                                    // focusNode: inputFocusNode1,
                                    onTap: () {},
                                    onSubmitted: (value) {
                                      setState(() {
                                        selectedTag.add(value);
                                        unselectTags.add(value);
                                      });
                                    },
                                    cursorColor:
                                        const Color.fromRGBO(62, 174, 86, 1.0),
                                    // cursorHeight: 44.w,
                                    cursorWidth: 3.w,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      // height: 1.08,
                                      fontSize: fontSizeScale(30.w),
                                      color: Color.fromARGB(255, 65, 183, 88),
                                    ),
                                    // strutStyle: StrutStyle(fontSize: fontSizeScale(20.w),),
                                    minLines: 1,
                                    onChanged: (newText) {
                                      inputController.value =
                                          inputController.value.copyWith(
                                        text: newText,
                                        selection: TextSelection.fromPosition(
                                          TextPosition(offset: newText.length),
                                        ),
                                      );
                                    },
                                    decoration: InputDecoration(
                                      // fillColor:
                                      //     const Color.fromARGB(255, 252, 0, 0),
                                      // filled: true,
                                      // focusColor: Colors.red,
                                      // hoverColor:
                                      //     const Color.fromARGB(255, 247, 247, 247),
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        // vertical: 30.w,
                                      ),

                                      hintText: '选择或者搜索标签',
                                      hintStyle: TextStyle(
                                        fontSize: fontSizeScale(28.w),
                                        color: Colors.grey,
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2.w,
                                          color: const Color.fromARGB(
                                              255, 85, 85, 85),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2.w,
                                          color: const Color.fromARGB(
                                              255, 85, 85, 85),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2.w,
                                          color: const Color.fromARGB(
                                              255, 85, 85, 85),
                                        ),
                                      ),
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2.w,
                                          color: const Color.fromARGB(
                                              255, 85, 85, 85),
                                        ),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2.w,
                                          color: const Color.fromARGB(
                                              255, 85, 85, 85),
                                        ),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2.w,
                                          color: const Color.fromARGB(
                                              255, 85, 85, 85),
                                        ),
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
                                  // color: Colors.red,
                                  child: Icon(
                                    const IconData(
                                      0xe64e,
                                      fontFamily: 'Iconfont',
                                    ),
                                    color:
                                        const Color.fromARGB(255, 74, 193, 99),
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
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "全部标签",
                        style: TextStyle(
                          fontSize: 27.w,
                          color: Color.fromARGB(255, 155, 155, 155),
                        ),
                      ),
                      Text(
                        "编辑",
                        style: TextStyle(
                          fontSize: 27.w,
                          color: Color.fromARGB(255, 155, 155, 155),
                        ),
                      ),
                    ],
                  ),
                ),

                // 未选标签
                Container(
                  width: systemState.screenSize.width,
                  padding: EdgeInsets.only(
                    left: 30.w,
                    right: 10.w,
                  ),
                  // color: Colors.white,
                  constraints: BoxConstraints(minHeight: 102.w),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 17.w,
                    runSpacing: 10.w,
                    children: [
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
                                      ? Color.fromARGB(255, 233, 248, 243)
                                      : const Color.fromARGB(
                                          255, 247, 247, 247),
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
                                    color: selectedTag.contains(value)
                                        ? Color.fromARGB(255, 65, 183, 88)
                                        : const Color.fromARGB(
                                            255, 159, 159, 159),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
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
