import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LJNWebview extends StatefulWidget {
  const LJNWebview({super.key});

  @override
  State<LJNWebview> createState() => _LJNWebviewState();
}

class _LJNWebviewState extends State<LJNWebview>
    with SingleTickerProviderStateMixin {
  late WebViewController controller;
  late final AnimationController _lottieController;
  double _statusHeight = 0;

  @override
  void initState() {
    super.initState();

    _lottieController = AnimationController(vsync: this);

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('http://127.0.0.1:9413')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('http://127.0.0.1:9413'));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }

    return Stack(
      children: [
        SizedBox(
          width: screenSize.width,
          child: Lottie.asset(
            assetPath('lotties/homeminiprogramdarwing.json'),
            width: screenSize.width,
            height: screenSize.height,
            fit: BoxFit.contain,
            renderCache: RenderCache.drawingCommands,
            controller: _lottieController,
            onLoaded: (composition) {
              // _lottieController
              //   ..duration = const Duration(milliseconds: 600)
              //   ..forward();
            },
          ),
        ),
        WebViewWidget(controller: controller),

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
