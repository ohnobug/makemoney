import 'package:flutter/material.dart';
import 'package:flutter_application_1/logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'provider.dart';
// import 'package:provider/provider.dart';

class LJNUserPage extends StatefulWidget {
  const LJNUserPage({super.key});

  @override
  State<LJNUserPage> createState() => _LJNUserPageState();
}

class _LJNUserPageState extends State<LJNUserPage> {
  bool _show = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _show = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    // final theme = Provider.of<ThemeProvider>(context).themeData;

    return Scaffold(
      appBar: null,
      body: _show ? _buildUserInfo(screenSize) : const LJNLoading(),
    );
  }

  Widget _buildUserInfo(Size screenSize) {
    return ColoredBox(
        color: const Color.fromARGB(255, 237, 237, 237),
        child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                    constraints: BoxConstraints(
                      minHeight: screenSize.height - 115.w,
                    ),
                    color: const Color.fromARGB(255, 237, 237, 237),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // 顶部功能区域
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(
                                    top: 56, left: 32, right: 32, bottom: 50)
                                .w,
                            margin: const EdgeInsets.only(bottom: 16).w,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10).w,
                                  child: Image.asset(
                                    'images/avatar/chat_4.jpg',
                                    width: 120.w,
                                    height: 120.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                SizedBox(width: 30.w),

                                // 用户信息区域
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '李俊杰',
                                          style: TextStyle(
                                            fontSize: 40.w,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),

                                        SizedBox(height: 20.w),

                                        // 微信号
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '微信号：TheMonsterClub',
                                              style: TextStyle(
                                                fontSize: 28.w,
                                                color: const Color.fromARGB(
                                                    255, 111, 111, 111),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.qr_code_2,
                                                  size: 30.w,
                                                  color: const Color.fromARGB(
                                                      255, 170, 170, 170),
                                                ),
                                                SizedBox(width: 43.w),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 28.w,
                                                  color: const Color.fromARGB(
                                                      255, 170, 170, 170),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 40.w),

                                        Row(
                                          children: [
                                            LJNStatusButton(
                                                text: '+ 状态',
                                                onPressed: () {
                                                  logger.info('点击状态');
                                                }),
                                            SizedBox(width: 14.w),
                                            LJNStatusButton(
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 60.w,
                                                      width: 70.w,
                                                      child: Stack(
                                                        children: <Widget>[
                                                          Positioned(
                                                            top: 6.w,
                                                            left: 0.w,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .white,
                                                                    width:
                                                                        2.0.w),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                            200)
                                                                        .w,
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                            1000)
                                                                        .w,
                                                                child:
                                                                    Image.asset(
                                                                  'images/avatar/chat_4.jpg',
                                                                  width: 30.w,
                                                                  height: 30.w,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 6.w,
                                                            left: 20.w,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .white,
                                                                    width:
                                                                        2.0.w),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                            200)
                                                                        .w,
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                            1000)
                                                                        .w,
                                                                child:
                                                                    Image.asset(
                                                                  'images/avatar/chat_5.jpg',
                                                                  width: 30.w,
                                                                  height: 30.w,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 6.w,
                                                            left: 40.w,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .white,
                                                                    width:
                                                                        2.0.w),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                            200)
                                                                        .w,
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                            100)
                                                                        .w,
                                                                child:
                                                                    Image.asset(
                                                                  'images/avatar/chat_6.jpg',
                                                                  width: 30.w,
                                                                  height: 30.w,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 10.w),
                                                    Text(
                                                      '等8个朋友',
                                                      style: TextStyle(
                                                        fontSize: 24.w,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 116, 116, 116),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                onPressed: () {
                                                  logger.info('等四个朋友');
                                                }),
                                          ],
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),

                          const FunctionItem(
                            id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                            title: "服务",
                            icon: "assets/images/icon/icon1.png",
                            link: '',
                            underline: false,
                          ),
                          SizedBox(
                            height: 16.w,
                          ),

                          const FunctionItem(
                            id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                            title: "收藏",
                            icon: "assets/images/icon/icon2.png",
                            link: '',
                            underline: true,
                          ),
                          const FunctionItem(
                            id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                            title: "朋友圈",
                            icon: "assets/images/icon/icon3.png",
                            link: '',
                            underline: true,
                          ),
                          const FunctionItem(
                            id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                            title: "视频号",
                            icon: "assets/images/icon/icon4.png",
                            link: '',
                            underline: true,
                          ),
                          const FunctionItem(
                            id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                            title: "订单与卡包",
                            icon: "assets/images/icon/icon5.png",
                            link: '',
                            underline: true,
                          ),
                          const FunctionItem(
                            id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                            title: "表情",
                            icon: "assets/images/icon/icon6.png",
                            link: '',
                            underline: false,
                          ),
                          SizedBox(
                            height: 16.w,
                          ),

                          const FunctionItem(
                            id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                            title: "设置",
                            icon: "assets/images/icon/icon7.png",
                            link: '',
                            underline: false,
                          ),
                        ])))));
  }
}

// 状态按钮
class LJNStatusButton extends StatefulWidget {
  final String? text;
  final Widget? child;
  final Function() onPressed;

  const LJNStatusButton({
    super.key,
    this.text,
    this.child,
    required this.onPressed,
  });

  @override
  State<LJNStatusButton> createState() => _LJNStatusButton();
}

class _LJNStatusButton extends State<LJNStatusButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onPressed,
        onTapDown: (_) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _isPressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12).w,
          height: 48.w,
          decoration: BoxDecoration(
            color: _isPressed
                ? const Color.fromARGB(255, 229, 229, 229)
                : Colors.transparent,
            border: Border.all(
              color: const Color.fromARGB(255, 231, 231, 231),
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(24).w,
          ),
          child: widget.text == null
              ? widget.child
              : Center(
                  child: Text(
                  widget.text!,
                  style: TextStyle(
                    fontSize: 24.w,
                    color: const Color.fromARGB(255, 116, 116, 116),
                  ),
                )),
        ));
  }
}

class LJNLoading extends StatelessWidget {
  const LJNLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

// 功能列表
class FunctionItem extends StatefulWidget {
  final String id;
  final String icon;
  final String title;
  final String link;
  final bool underline;

  const FunctionItem({
    super.key,
    required this.id,
    required this.icon,
    required this.title,
    required this.link,
    required this.underline,
  });

  @override
  State<FunctionItem> createState() => _FunctionItemState();
}

class _FunctionItemState extends State<FunctionItem> {
  bool isClicked = false;
  Color containerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        setState(() {
          isClicked = true;
          containerColor = const Color.fromARGB(255, 229, 229, 229);
        });
      },
      onTapCancel: () {
        setState(() {
          isClicked = false;
          containerColor = Colors.white;
          logger.info("取消点击");
        });
      },
      onTapUp: (tapDownDetails) {
        setState(() {
          isClicked = false;
          containerColor = Colors.white;

          Navigator.pushNamed(context, '/services');
        });
      },
      child: Container(
        height: 105.0.w,
        padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
        color: containerColor,
        child: Row(
          children: [
            // 头像
            Container(
              width: 43.0.w,
              height: 43.0.w,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                // borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(widget.icon),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 20.w),
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
                    Flexible(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 30.0.w,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Container(
                        margin: const EdgeInsets.only(right: 35).w,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 26.0.w,
                          color: const Color.fromARGB(255, 170, 170, 170),
                        ))
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
