import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/LJNReceiveMessage.dart';
import 'package:flutter_application_1/tools/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/LJNMyMessage.dart';

class LJNChatPage extends StatefulWidget {
  const LJNChatPage({super.key});

  @override
  State<LJNChatPage> createState() => _LJNChatPage();
}

class _LJNChatPage extends State<LJNChatPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        primary: false,
        appBar: AppBar(
          primary: true,
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          toolbarHeight: MediaQuery.of(context).padding.top + 90.w,
          title: const Text("请说英语"),
          titleTextStyle: TextStyle(fontSize: 32.w, color: Colors.black),
          backgroundColor: const Color.fromARGB(255, 237, 237, 237),
          foregroundColor: const Color.fromARGB(255, 237, 237, 237),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.w),
            child: Container(
              color: const Color.fromARGB(255, 220, 220, 220),
              height: 0.5.w,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                  size: 37.w,
                  const IconData(
                    0xe659,
                    fontFamily: 'Iconfont',
                  )),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              padding: const EdgeInsets.only(right: 33.0).w,
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: const SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            LJNReceiveMessage(),
                            LJNMyMessage(),
                            LJNReceiveMessage(),
                            LJNMyMessage(),
                            LJNReceiveMessage(),
                            LJNReceiveMessage(),
                            LJNReceiveMessage(),
                            LJNReceiveMessage(),
                            LJNReceiveMessage(),
                            LJNMyMessage(),
                            LJNMyMessage(),
                            LJNMyMessage(),
                            LJNMyMessage(),
                          ],
                        )))),
            Container(
              height: 107.w,
              width: screenSize.width,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 0, 0),
                  border: Border(
                      top: BorderSide(
                    color: const Color.fromARGB(255, 230, 230, 230),
                    width: 2.w,
                    style: BorderStyle.solid,
                  ))),
              child: Text(
                "bbbbbb",
                style: TextStyle(fontSize: 10.w),
              ),
            )
          ],
        ));
  }
}
