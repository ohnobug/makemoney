import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
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
            _lottieController.value = (progress / 100) * 0.5;
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            // 页面加载完, 需要有个动画的过程
            _lottieController
              ..duration = const Duration(milliseconds: 1000)
              ..forward();
          },
          onHttpError: (HttpResponseError error) {
            logger.info("qqqqqqqqqqqqq onHttpError");
          },
          onWebResourceError: (WebResourceError error) async {
            // 清空错误的信息
            // webViewController.loadHtmlString("");

            String? requestUrl = await webViewController.currentUrl();
            if (requestUrl!.startsWith('http://inner')) {
              Uri uri = Uri.parse(requestUrl);
              // logger
              //     .info("aaaaaaaaaaaaaa host: ${uri.host}  port: ${uri.port}");

              // 请求页面
              final response = await http.get(
                  Uri.parse('http://127.0.0.1:9413'),
                  headers: {'Host': uri.host, 'Content-Type': 'text/html'});

              if (response.statusCode == 200) {
                webViewController.loadHtmlString(response.body,
                    baseUrl: "http://${uri.host}:${uri.port}");
              } else {
                webViewController.loadHtmlString(
                    "<h1 style='margin-top: 100px'>页面挂了</h1><a href='/qq'>qqq</a>",
                    baseUrl: "http://${uri.host}:${uri.port}");
              }
            }
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
      // 打开页面
      webViewController.loadRequest(Uri.parse(widget.link));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // if (kIsWeb) {
    //   _statusHeight = 0;
    // } else {
    //   _statusHeight = MediaQuery.of(context).padding.top;
    // }

    return Stack(
      children: [
        // 页面本身
        WebViewWidget(controller: webViewController),

        // 加载动画
        Visibility(
            visible: !pageVisible,
            child: Container(
                color: const Color.fromARGB(255, 177, 177, 177),
                width: screenSize.width,
                height: screenSize.height,
                child: Center(
                    child: Lottie.asset(
                  assetPath('lotties/miniprogramloading.json'),
                  width: screenSize.width * 0.4,
                  // height: screenSize.height,
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
                    onTap: () => Navigator.of(context).pop(), // 点击事件
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
        )
      ],
    );
  }
}
