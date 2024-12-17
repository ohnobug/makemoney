import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/components/LJNAppBar.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNSetNotesAndLabels extends StatefulWidget {
  const LJNSetNotesAndLabels({super.key});

  @override
  State<LJNSetNotesAndLabels> createState() => _LJNSetNotesAndLabelsState();
}

class _LJNSetNotesAndLabelsState extends State<LJNSetNotesAndLabels> {
  TextEditingController inputController = TextEditingController();
  FocusNode inputFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        primary: false,
        appBar: const LJNAppBar(
          title: "",
          bgColor: Colors.white,
        ),
        body: ColoredBox(
            color: Colors.white,
            child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Container(
                      constraints:
                          BoxConstraints(minHeight: screenSize.height - 205.w),
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 45.w, right: 45.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100.w,
                          ),
                          Text(
                            "设置标注和标签",
                            style: TextStyle(
                                fontSize: 40.w,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 95.w,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 30.w),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '备注',
                              style: TextStyle(
                                  fontSize: 25.w, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 15.w,
                          ),
                          Container(
                              height: 106.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 247, 247, 247),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.w)),
                              ),
                              child: TextField(
                                readOnly: false,
                                autofocus: false,
                                showCursor: true,
                                controller: inputController,
                                focusNode: inputFocusNode,
                                onTap: () {},
                                cursorColor:
                                    const Color.fromRGBO(62, 174, 86, 1.0),
                                // cursorHeight: 44.w,
                                cursorWidth: 3.w,
                                style: TextStyle(
                                    // height: 1.08,
                                    fontSize: fontSizeScale(30.w),
                                    color: Colors.black),
                                // strutStyle: StrutStyle(fontSize: fontSizeScale(20.w)),
                                maxLines: 5,
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
                                  //     const Color.fromARGB(255, 247, 247, 247),
                                  // filled: true,
                                  // focusColor: Colors.red,
                                  // hoverColor:
                                  //     const Color.fromARGB(255, 247, 247, 247),
                                  isCollapsed: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 16)
                                      .w,
                                  border: const OutlineInputBorder(
                                      gapPadding: 0,
                                      borderSide: BorderSide.none),
                                  // focusedBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                                  // enabledBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                                  // disabledBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                                  // focusedErrorBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                                  // errorBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                                ),
                              ))
                        ],
                      ),
                    )))));
  }
}
