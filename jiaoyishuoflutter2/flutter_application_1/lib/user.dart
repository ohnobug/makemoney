import 'package:flutter/material.dart';
// import 'package:flutter_application_1/logger.dart';
import 'provider.dart';
import 'package:provider/provider.dart';


class LJNUserInfo extends StatefulWidget {
  const LJNUserInfo({super.key});

  @override
  LJNUserInfoState createState() => LJNUserInfoState();
}

class LJNUserInfoState extends State<LJNUserInfo> {
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

    final theme = Provider.of<ThemeProvider>(context).themeData;

    return Scaffold(
      appBar: null,
      body: _show ? _buildUserInfo(theme, screenSize) : const LJNLoading(),
    );
  }

  Widget _buildUserInfo(ThemeData theme, Size screenSize) {

    return SingleChildScrollView(
        child: Column(children: [
      Container(
          constraints: BoxConstraints(minHeight: screenSize.height - 60),
          color: const Color.fromARGB(255, 246, 246, 246),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // 顶部功能区域
              Container(
                color: Colors.white, // 设置姓名部分的背景颜色
                // height: 200.w,
                padding: const EdgeInsets.only(
                    top: 28, left: 16, right: 16, bottom: 25),
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5), // 设置圆角半径
                      child: Image.asset(
                        'images/avatar/chat_4.jpg',
                        width: 60, // 设置宽度
                        height: 60, // 设置高度
                        fit: BoxFit.cover, // 确保图片覆盖整个容器
                      ),
                    ),

                    const SizedBox(width: 16),

                    // 用户信息区域
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '李俊杰',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '微信号：TheMonsterClub',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 103, 103, 103),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.qr_code, // 示例图标
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 16),
                                  Icon(
                                    Icons.add, // 示例图标
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              _buildStatusButton(theme, '+ 状态'),
                              const SizedBox(width: 5),
                              _buildStatusButton(theme, '+ 等四个朋友'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const FunctionView(chatItems: [
                FunctionItem(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "服务",
                  icon: "assets/images/icon/icon1.png",
                  link: '',
                  underline: false,
                )
              ]),

              const FunctionView(chatItems: [
                FunctionItem(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "收藏",
                  icon: "assets/images/icon/icon2.png",
                  link: '',
                  underline: true,
                ),
                FunctionItem(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "朋友圈",
                  icon: "assets/images/icon/icon3.png",
                  link: '',
                  underline: true,
                ),
                FunctionItem(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "视频号",
                  icon: "assets/images/icon/icon4.png",
                  link: '',
                  underline: true,
                ),
                FunctionItem(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "订单与卡包",
                  icon: "assets/images/icon/icon5.png",
                  link: '',
                  underline: true,
                ),
                FunctionItem(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "表情",
                  icon: "assets/images/icon/icon6.png",
                  link: '',
                  underline: false,
                ),
              ]),

              const FunctionView(chatItems: [
                FunctionItem(
                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                  title: "设置",
                  icon: "assets/images/icon/icon7.png",
                  link: '',
                  underline: false,
                )
              ])
            ],
          ))
    ]));
  }

  Widget _buildStatusButton(ThemeData theme, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 24,
      decoration: BoxDecoration(
        border: Border.all(
            // color: theme.accentColor, // 修改为你的边框颜色
            // width: 1.2,
            ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: theme.primaryColor,
          ),
        ),
      ),
    );
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

class FunctionView extends StatefulWidget {
  final List<FunctionItem> chatItems;

  const FunctionView({super.key, required this.chatItems});

  @override
  FunctionViewState createState() => FunctionViewState(chatItems);
}

class FunctionItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      padding: const EdgeInsets.only(left: 15.0, right: 0.0),
      child: Row(
        children: [
          // 头像
          Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              // borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(icon),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Container(
            height: 50,
            decoration: underline
                ? const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                    color: Color.fromARGB(255, 233, 233, 233),
                    width: 0.5,
                    style: BorderStyle.solid,
                  )))
                : const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.transparent,
                        width: 0.5,
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
                    title,
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const Icon(
                      Icons.notifications_active,
                      size: 15.0,
                      color: Color.fromARGB(255, 193, 193, 193),
                    ))
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class FunctionViewState extends State<FunctionView> {
  final List<FunctionItem> chatItems;

  FunctionViewState(this.chatItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: chatItems.length * 45.0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        itemCount: chatItems.length,
        itemBuilder: (context, index) {
          return chatItems[index];
        },
      ),
    );
  }
}
