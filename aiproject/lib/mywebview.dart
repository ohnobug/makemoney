import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';

import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:lottie/lottie.dart';
// import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class LJNWebview extends StatefulWidget {
  final String link;
  const LJNWebview({super.key, required this.link});

  @override
  State<LJNWebview> createState() => _LJNWebviewState();
}

class _LJNWebviewState extends State<LJNWebview>
    with SingleTickerProviderStateMixin {
  late WebViewController webViewController;
  late final AnimationController _lottieController;

  bool pageVisible = false;

  @override
  void initState() {
    super.initState();

    _lottieController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _lottieController.addListener(() {
      if (_lottieController.isCompleted) {
        setState(() {
          pageVisible = true;
        });
      }
    });

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            logger.info("qqqqqqqqqqqqq onProgress");

            _lottieController.value = (progress / 100) * 0.5;
          },
          onPageStarted: (String url) {
            logger.info("qqqqqqqqqqqqq onPageStarted");
          },
          onPageFinished: (String url) {
            logger.info("qqqqqqqqqqqqq onPageFinished: $url");

            // _lottieController.value = 1;

            // 页面加载完, 需要有个动画的过程
            _lottieController
              ..duration = const Duration(milliseconds: 1000)
              ..forward();
          },
          onUrlChange: (UrlChange change) {
            logger.info("qqqqqqqqqqqqq onUrlChange ${change.url}");
          },
          onHttpError: (HttpResponseError error) {
            logger.info("qqqqqqqqqqqqq onHttpError");
          },
          onWebResourceError: (WebResourceError error) async {
            // 清空错误的信息
            // webViewController.loadHtmlString("");
            // _lottieController.reset();
          },
          // 跳转劫持
          onNavigationRequest: (NavigationRequest request) async {
            logger.info("qqqqqqqqqqqqq onNavigationRequest");

            if (request.url.startsWith('http://helloworld.com')) {
              webViewController.loadHtmlString(
                  "<h1 style='margin-top: 100px'>你来到了被劫持的页面，哈哈哈</h1>");

              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      );

    if (widget.link == "") {
      webViewController
          .loadHtmlString("<h1 style='margin-top: 100px'>404 Not Found</h1>");
    } else {
      logger.info("当前打开的link: ${widget.link}");
      loadPage(widget.link);
    }
  }

  void loadPage(String requestUrl) async {
    if (requestUrl.startsWith('http://inner')) {
      Uri uri = Uri.parse(requestUrl);

      // 请求页面
      final response = await http.get(Uri.parse('http://127.0.0.1:9413'),
          headers: {'Host': uri.host, 'Content-Type': 'text/html'});

      if (response.statusCode == 200) {
        webViewController.loadHtmlString(response.body, baseUrl: requestUrl);
      } else {
        webViewController.loadHtmlString(
            "<h1 style='margin-top: 100px'>页面挂了</h1><a href='/qq'>qqq</a>",
            baseUrl: requestUrl);
      }
    } else {
      webViewController.loadRequest(Uri.parse(requestUrl));

      // webViewController.loadHtmlString(
      //     "<h1 style='margin-top: 100px'>不符合规则的链接：${widget.link}</h1>",
      //     baseUrl: requestUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
      return Scaffold(
          appBar: null,
          body: Stack(
            children: [
              // 页面本身
              WebViewWidget(controller: webViewController),

              // 加载动画
              Visibility(
                  visible: !pageVisible,
                  child: Container(
                      color: const Color.fromARGB(255, 177, 177, 177),
                      width: systemState.screenSize.width,
                      height: systemState.screenSize.height,
                      child: Center(
                          child: Lottie.asset(
                        assetPath('lotties/miniprogramloading.json'),
                        width: systemState.screenSize.width * 0.4,
                        // height: systemState.screenSize.height,
                        fit: BoxFit.contain,
                        renderCache: RenderCache.drawingCommands,
                        controller: _lottieController,
                        onLoaded: (composition) {
                          // _lottieController
                          //   ..duration = const Duration(milliseconds: 600)
                          //   ..forward();
                        },
                      )))),

              // 关闭按钮
              Positioned(
                right: 17.w,
                top: 90.w,
                child: Container(
                  width: 192.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(237, 255, 255, 255), // 背景颜色
                    borderRadius: BorderRadius.circular(35.w), // 圆角
                    border: Border.all(
                      color: const Color.fromARGB(255, 217, 225, 231), // 边框颜色
                      width: 1.w, // 边框宽度
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _showPopup(context, systemState);
                          },
                          child: Container(
                            // 加盒子是为了扩大点击区域
                            color: Colors.transparent,
                            child: Icon(
                              const IconData(
                                0xe620,
                                fontFamily: 'Iconfont',
                              ), // 使用的图标
                              color: Colors.black, // 图标颜色
                              size: 36.w, // 图标大小
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 2.w,
                        height: 40.w,
                        color: const Color.fromARGB(255, 224, 220, 221),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(), // 点击事件
                          child: Container(
                            // 加盒子是为了扩大点击区域
                            color: Colors.transparent,
                            child: Icon(
                              const IconData(
                                0xe617,
                                fontFamily: 'Iconfont',
                              ), // 使用的图标
                              color: Colors.black, // 图标颜色
                              size: 36.w, // 图标大小
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Container(
              //   width: systemState.screenSize.height,
              //   height: systemState.screenSize.width,
              //   color: Color.fromARGB(102, 0, 0, 0),
              // ),
            ],
          ));
    });
  }
}

void _showPopup(BuildContext context, SystemState systemState) {
  showModalBottomSheet(
      context: context,
      barrierColor: Color.fromARGB(120, 0, 0, 0),
      // backgroundColor: Colors.red,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 1145.w,
          width: systemState.screenSize.width,
          // padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13.w),
              topRight: Radius.circular(13.w),
            ),
          ),
          child: Column(
            children: [
              // 小程序信息
              Container(
                // color: Colors.amber,
                height: 120.w,
                padding: EdgeInsets.only(
                  left: 24.w,
                  right: 24.w,
                  top: 25.w,
                  bottom: 25.w,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      assetPath(
                          "images/miniprogram_icon/chengzixiaoshuodaziban.jpg"),
                      width: 70.0.w,
                      height: 70.0.w,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "积贝生活",
                          style: TextStyle(
                            height: 1.08,
                            color: Colors.black,
                            fontSize: 32.w,
                            fontFamily: 'AlibabaPuHuiTi-Medium',
                          ),
                        ),
                        // SizedBox(
                        //   height: 10.w,
                        // ),
                        Text(
                          '东城共赢(南海)信息科技有限公司',
                          style: TextStyle(
                            height: 1.08,
                            color: Color.fromARGB(255, 193, 193, 193),
                            fontSize: 24.w,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

              // 评论
              Container(
                width: systemState.screenSize.width,
                padding: EdgeInsets.only(
                  left: 24.w,
                  right: 24.w,
                  top: 36.w,
                  bottom: 36.w,
                ),
                height: 135.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "暂无交易评分 1条评价",
                      style: TextStyle(
                        fontSize: 26.w,
                        color: Colors.black,
                        height: 1.08,
                      ),
                    ),
                    Text(
                      "精选评价: 很满意，产品质量好",
                      style: TextStyle(
                        fontSize: 26.w,
                        color: Color.fromARGB(255, 113, 113, 113),
                        height: 1.08,
                      ),
                    )
                  ],
                ),
              ),

              // 转发
              Container(
                color: Color.fromARGB(255, 247, 247, 247),
                width: systemState.screenSize.width,
                height: 300.w,
                padding: EdgeInsets.only(
                  top: 40.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 24.w),
                        child: Text(
                          '转发给',
                          style: TextStyle(
                            fontSize: 25.w,
                            // fontWeight: FontWeight.bold,
                            fontFamily: 'AlibabaPuHuiTi-Medium',
                          ),
                        )),
                    SizedBox(
                      height: 25.w,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 24.w,
                          ),
                          LJNPopupFunctionButton(
                            icon: "images/miniprogram_icon/uitartuna.jpg",
                            title: "随身尺子",
                            onPressed: () {},
                          ),
                          LJNPopupFunctionButton(
                            icon: "images/miniprogram_icon/chuangzuomao.jpg",
                            title: "文件传输助手",
                            onPressed: () {},
                          ),
                          LJNPopupFunctionButton(
                            icon: "images/miniprogram_icon/upaotui.jpg",
                            title: "飞常准查航班",
                            onPressed: () {},
                          ),
                          LJNPopupFunctionButton(
                            icon:
                                "images/miniprogram_icon/ciweimaoappjiuban.jpg",
                            title: "花式昵称",
                            onPressed: () {},
                          ),
                          LJNPopupFunctionButton(
                            icon:
                                "images/miniprogram_icon/wangwangshangliao.jpg",
                            title: "腾讯体育+",
                            onPressed: () {},
                          ),
                          LJNPopupFunctionButton(
                            icon:
                                "images/miniprogram_icon/daimengPS2moniqi.jpg",
                            title: "邮政信使",
                            onPressed: () {},
                          ),
                          LJNPopupFunctionButton(
                            icon: "images/miniprogram_icon/wangyiyunyinyue.jpg",
                            title: "壁纸精选",
                            onPressed: () {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // 功能按钮
              Container(
                  width: systemState.screenSize.width,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 247, 247, 247),
                    border: Border(
                      top: BorderSide(
                        color: const Color.fromARGB(255, 231, 231, 231),
                        width: 1.0.w,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  height: 470.w,
                  padding: EdgeInsets.only(top: 40.w, bottom: 20.w),
                  child: Column(
                    children: [
                      SizedBox(
                        width: systemState.screenSize.width,
                        height: 200.w,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              SizedBox(width: 24.w),
                              LJNPopupFunctionButton(
                                icon:
                                    "images/miniprogram_icon/dawenmianfeixiaoshuo.jpg",
                                title: "秘塔写作猫",
                                onPressed: () {},
                              ),
                              LJNPopupFunctionButton(
                                icon:
                                    "images/miniprogram_icon/wangzheyingdi.jpg",
                                title: "色卡生成器",
                                onPressed: () {},
                              ),
                              LJNPopupFunctionButton(
                                icon: "images/miniprogram_icon/duitang.jpg",
                                title: "换碎屏",
                                onPressed: () {},
                              ),
                              LJNPopupFunctionButton(
                                icon:
                                    "images/miniprogram_icon/wanwuxinxuan.jpg",
                                title: "报告查一查",
                                onPressed: () {},
                              ),
                              LJNPopupFunctionButton(
                                icon:
                                    "images/miniprogram_icon/fanqiebiaoqiandayinruanjian.jpg",
                                title: "智能翻译官APP",
                                onPressed: () {},
                              ),
                              LJNPopupFunctionButton(
                                icon:
                                    "images/miniprogram_icon/wanwuzxaixian.jpg",
                                title: "倒数记日",
                                onPressed: () {},
                              ),
                              LJNPopupFunctionButton(
                                icon:
                                    "images/miniprogram_icon/feiwenwangapp2021.jpg",
                                title: "文字转换语音",
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: systemState.screenSize.width,
                        height: 200.w,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              SizedBox(width: 24.w),
                              LJNPopupFunctionButton(
                                icon:
                                    "images/miniprogram_icon/wasaifmguangbojuruanjian.jpg",
                                title: "多元调解",
                                onPressed: () {},
                              ),
                              LJNPopupFunctionButton(
                                icon:
                                    "images/miniprogram_icon/gaodeditu12.12.2.jpg",
                                title: "百科知识词典",
                                onPressed: () {},
                              ),
                              LJNPopupFunctionButton(
                                icon:
                                    "images/miniprogram_icon/weibodongmanlishi.jpg",
                                title: "证照拍",
                                onPressed: () {},
                              ),
                              LJNPopupFunctionButton(
                                icon:
                                    "images/miniprogram_icon/haimianbaobao.jpg",
                                title: "习惯杂货铺",
                                onPressed: () {},
                              ),
                              LJNPopupFunctionButton(
                                icon:
                                    "images/miniprogram_icon/weizhiweizhuangdashi2021.jpg",
                                title: "美图秀秀",
                                onPressed: () {},
                              ),
                              LJNPopupFunctionButton(
                                icon: "images/miniprogram_icon/haiziwang.jpg",
                                title: "暴风影音",
                                onPressed: () {},
                              ),
                              LJNPopupFunctionButton(
                                icon:
                                    "images/miniprogram_icon/woyaozuojihua.jpg",
                                title: "酷狗音乐",
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),

              // 取消
              LJNPopupButtonMaxWidthButton(
                color: Color.fromARGB(255, 65, 82, 120),
                title: "取消",
                underline: false,
              )
            ],
          ),
        );
      });
}

// 底部弹出取消按钮
class LJNPopupButtonMaxWidthButton extends StatefulWidget {
  final double? height;
  final Object? title;
  final Color? color;
  final String? link;
  final bool underline;
  final Function? onPressed;

  const LJNPopupButtonMaxWidthButton(
      {super.key,
      this.height,
      required this.title,
      this.color,
      this.link,
      required this.underline,
      this.onPressed});

  @override
  State<LJNPopupButtonMaxWidthButton> createState() =>
      _LJNPopupButtonMaxWidthButtonState();
}

class _LJNPopupButtonMaxWidthButtonState
    extends State<LJNPopupButtonMaxWidthButton> {
  // bool isClicked = false;
  Color containerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
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

            if (context.mounted) {
              if (widget.link != null) {
                Navigator.pushNamed(context, widget.link!);
              }

              if (widget.onPressed != null) {
                widget.onPressed!();
              }
            }
          });

          logger.info("弹起");
        },
        child: Container(
          height: 112.w,
          width: systemState.screenSize.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: containerColor,
              border: Border(
                  top: BorderSide(
                width: 1.0.w,
                color: Color.fromARGB(255, 228, 228, 228),
              ))),
          child: widget.title is String
              ? Text(
                  widget.title as String,
                  style: TextStyle(
                    color: widget.color ?? Colors.black,
                    height: 1.08,
                    fontSize: fontSizeScale(32.0.w),
                    decoration: TextDecoration.none,
                    fontFamily: "AlibabaPuHuiTi",
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              : widget.title as Widget,
        ),
      );
    });
  }
}

// 小程序按钮
class LJNPopupFunctionButton extends StatefulWidget {
  final String icon;
  final String title;
  final VoidCallback onPressed;

  const LJNPopupFunctionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  LJNPopupFunctionButtonState createState() => LJNPopupFunctionButtonState();
}

class LJNPopupFunctionButtonState extends State<LJNPopupFunctionButton> {
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
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      child: Container(
        width: 110.w,
        // height: 225.w,
        margin: EdgeInsets.only(right: 25.w),
        decoration: BoxDecoration(
          // color: Colors.orange,
          color: _isPressed ? Colors.grey[200] : Colors.transparent, // 按下时背景色
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              assetPath(widget.icon),
              width: 112.w,
              height: 112.w,
              cacheHeight: 224.w.toInt(),
              cacheWidth: 224.w.toInt(),
              fit: BoxFit.cover, // 让图片完全填满圆形区域
            ),
            SizedBox(height: 10.w), // 图标和标题之间的间距
            Text(
              widget.title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.08,
                decoration: TextDecoration.none,
                color: Color.fromARGB(255, 108, 108, 108),
                fontSize: fontSizeScale(22.0.w),
                overflow: TextOverflow.ellipsis,
              ), // 标题颜色
            ),
          ],
        ),
      ),
    );
  }
}
