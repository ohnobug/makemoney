import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/pageloading.dart';
import 'package:flutter_application_1/logger.dart';
import 'package:flutter_application_1/store.dart';
import 'package:flutter_application_1/tools/tools.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNContactPage extends StatefulWidget {
  const LJNContactPage({super.key});

  @override
  State<LJNContactPage> createState() => _LJNContactPageState();
}

class _LJNContactPageState extends State<LJNContactPage> {
  double _statusHeight = 0;

  @override
  void initState() {
    super.initState();

    _statusHeight = MediaQuery.of(context).padding.top;

    logger.info('contact...............');

    myStore.dispatch({"type": "homescrollpixels", "payload": 0.0});

    Future.delayed(const Duration(milliseconds: 300), () {
      myStore.dispatch({"type": "mainpage2isload", "payload": true});
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return vm.mainpage2isload! ? _buildPage() : const LJNPageLoading();
        });
  }

  // 另起一个函数方便管理
  Widget _buildPage() {
    return Stack(children: [
      ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Column(
              children: [
                SizedBox(height: _statusHeight + 90.w),
                ContactInformation(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "新的朋友",
                    icon: "images/avatar_webp/chat_1.webp",
                    link: '',
                    underline: true,
                    onPressed: () {
                      Navigator.pushNamed(context, '/chat');
                    }),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "仅聊天的朋友",
                  icon: "images/avatar_webp/chat_2.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "群聊",
                  icon: "images/avatar_webp/chat_3.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "标签",
                  icon: "images/avatar_webp/chat_4.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                const ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "公众号",
                  icon: "images/avatar_webp/chat_5.webp",
                  link: '',
                  underline: false,
                ),
                Container(
                    height: 60.w,
                    color: const Color.fromARGB(255, 237, 237, 237),
                    padding: EdgeInsets.only(left: 30.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "A",
                          style: TextStyle(fontSize: 20.w),
                        ),
                      ],
                    )),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "天空飘来五个字那都不是事",
                  icon: "images/avatar_webp/chat_1.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "本因",
                  icon: "images/avatar_webp/chat_10.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "赵洵",
                  icon: "images/avatar_webp/chat_11.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "定静师太",
                  icon: "images/avatar_webp/chat_12.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "李秋水",
                  icon: "images/avatar_webp/chat_13.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "谭婆",
                  icon: "images/avatar_webp/chat_14.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "李傀儡",
                  icon: "images/avatar_webp/chat_15.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "貂禅",
                  icon: "images/avatar_webp/chat_16.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "何三七",
                  icon: "images/avatar_webp/chat_17.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "孔融",
                  icon: "images/avatar_webp/chat_18.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "齐堂主",
                  icon: "images/avatar_webp/chat_19.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "博尔术",
                  icon: "images/avatar_webp/chat_20.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "王语嫣",
                  icon: "images/avatar_webp/chat_21.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "秦红棉",
                  icon: "images/avatar_webp/chat_22.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                const ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "天竺僧人",
                  icon: "images/avatar_webp/chat_23.webp",
                  link: '',
                  underline: false,
                ),
                Container(
                    height: 60.w,
                    color: const Color.fromARGB(255, 237, 237, 237),
                    padding: EdgeInsets.only(left: 30.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "B",
                          style: TextStyle(fontSize: 20.w),
                        ),
                      ],
                    )),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "段延庆",
                  icon: "images/avatar_webp/chat_33.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "令狐冲",
                  icon: "images/avatar_webp/chat_34.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "英白罗",
                  icon: "images/avatar_webp/chat_35.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "黄药师",
                  icon: "images/avatar_webp/chat_36.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "李煜",
                  icon: "images/avatar_webp/chat_37.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "云中鹤",
                  icon: "images/avatar_webp/chat_38.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "劳德诺",
                  icon: "images/avatar_webp/chat_39.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "包惜弱",
                  icon: "images/avatar_webp/chat_40.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "游驹",
                  icon: "images/avatar_webp/chat_41.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "钟万仇",
                  icon: "images/avatar_webp/chat_42.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "渔人",
                  icon: "images/avatar_webp/chat_43.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "单叔山",
                  icon: "images/avatar_webp/chat_44.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "段誉",
                  icon: "images/avatar_webp/chat_45.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "林震南",
                  icon: "images/avatar_webp/chat_46.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                ContactInformation(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "商鞅",
                  icon: "images/avatar_webp/chat_47.webp",
                  link: '',
                  underline: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
                Container(
                  width: double.infinity,
                  height: 105.0.w,
                  color: Colors.white,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "2个朋友",
                          style: TextStyle(
                              fontSize: 30.w,
                              color: const Color.fromARGB(255, 125, 125, 125)),
                        ),
                      ]),
                )
              ],
            ),
          )),

      // 右边的字母表
      StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Positioned(
              right: 0,
              top: 0,
              child: Visibility(
                  visible: state.contactazshow!,
                  child: SizedBox(
                    width: 40.w,
                    height: MediaQuery.of(context).size.height - 115.w - 75.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 34.w,
                          child: Icon(Icons.arrow_upward,
                              size: 22.w,
                              color: const Color.fromARGB(255, 20, 20, 20)),
                        ),
                        SizedBox(
                          height: 34.w,
                          child: Icon(Icons.star_outline_outlined,
                              size: 22.w,
                              color: const Color.fromARGB(255, 20, 20, 20)),
                        ),
                        for (int i = 0; i < 26; i++)
                          SizedBox(
                            height: 34.w,
                            child: Text(
                              String.fromCharCode(65 + i),
                              style: TextStyle(
                                  fontSize: 22.w,
                                  color: const Color.fromARGB(255, 20, 20, 20)),
                            ),
                          ),
                        SizedBox(
                          height: 34.w,
                          child: Text(
                            "#",
                            style: TextStyle(
                                fontSize: 22.w,
                                color: const Color.fromARGB(255, 20, 20, 20)),
                          ),
                        ),
                      ],
                    ),
                  )));
        },
      ),
    ]);
  }
}

// 功能列表
class ContactInformation extends StatefulWidget {
  final String id;
  final String icon;
  final String title;
  final String link;
  final bool underline;
  final int? showStyle;
  final Function()? onPressed;

  const ContactInformation({
    super.key,
    required this.id,
    required this.icon,
    required this.title,
    required this.link,
    required this.underline,
    this.showStyle,
    this.onPressed,
  });

  @override
  State<ContactInformation> createState() => _ContactInformationState();
}

class _ContactInformationState extends State<ContactInformation> {
  // bool isClicked = false;
  Color containerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        setState(() {
          containerColor = const Color.fromARGB(255, 229, 229, 229);
        });
      },
      onTapCancel: () {
        setState(() {
          containerColor = Colors.white;
        });

        logger.info("取消点击");
      },
      onTapUp: (tapDownDetails) {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = Colors.white;
          });
          widget.onPressed!();
        });

        logger.info("弹起");
      },
      child: Container(
        height: 105.0.w,
        padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
        color: containerColor,
        child: Row(
          children: [
            // 头像
            Container(
              width: 75.0.w,
              height: 75.0.w,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(7).w,
                image: DecorationImage(
                  image: AssetImage(assetPath(widget.icon)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 30.w),
            Expanded(
              child: Container(
                height: 100.w,
                width: 400.w,
                decoration: widget.underline
                    ? BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                        color: const Color.fromARGB(255, 233, 233, 233),
                        width: 1.w,
                        style: BorderStyle.solid,
                      )))
                    : BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.transparent,
                            width: 1.w,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 标题
                    Expanded(
                      flex: 1,
                      // width: 100.w,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 30.0.w,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
