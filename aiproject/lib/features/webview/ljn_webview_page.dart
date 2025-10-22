import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';

class LJNWebViewPage extends StatefulWidget {
  final String url;
  final String title;

  const LJNWebViewPage({
    super.key,
    required this.url,
    this.title = '网页',
  });

  @override
  State<LJNWebViewPage> createState() => _LJNWebViewPageState();
}

class _LJNWebViewPageState extends State<LJNWebViewPage> {
  InAppWebViewController? _webViewController;
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    // 检查URL是否为空
    if (widget.url.isEmpty) {
      return Scaffold(
          appBar: null,
          body: Stack(
            children: [
              _buildEmptyState(),

              // 右上角关闭按钮
              if (!_isLoading && !_hasError)
                Positioned(
                  right: 17,
                  top: 90,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(238), // 约等于 0.93 透明度
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        color: Colors.transparent,
                        child: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ));
    }

    // 验证URL格式
    final uri = Uri.tryParse(widget.url);
    if (uri == null ||
        !uri.hasScheme ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      return Scaffold(
        appBar: null,
        body: Stack(
          children: [
            _buildInvalidUrlState(),

            // 右上角关闭按钮
            if (!_isLoading && !_hasError)
              Positioned(
                right: 17,
                top: 90,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(238), // 约等于 0.93 透明度
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      color: Colors.transparent,
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 36,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          // WebView
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri(widget.url),
            ),
            initialSettings: InAppWebViewSettings(
              userAgent:
                  "Mozilla/5.0 (Linux; Android 10; SM-G975F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Mobile Safari/537.36 VigavigaApp/1.0.0",
              isInspectable: true,
              allowUniversalAccessFromFileURLs: true,
              allowFileAccessFromFileURLs: true,
              cacheEnabled: true,
              javaScriptEnabled: true,
              supportZoom: false,
              useShouldOverrideUrlLoading: true,
              useOnLoadResource: true,
              // 解决ORB错误的安全设置
              clearCache: true,
              domStorageEnabled: true,
              databaseEnabled: true,
              mediaPlaybackRequiresUserGesture: false,
              allowsInlineMediaPlayback: true,
              // 跨域相关设置
              allowsLinkPreview: true,
              allowsBackForwardNavigationGestures: true,
              disableVerticalScroll: false,
              disableHorizontalScroll: false,
              // 安全策略
              mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
              safeBrowsingEnabled: false,
            ),
            onWebViewCreated: (controller) {
              _webViewController = controller;

              // 注册JavaScript处理器，用于网页调用Flutter方法
              controller.addJavaScriptHandler(
                handlerName: 'openWebBrowser',
                callback: (args) {
                  // 处理从网页传来的打开网页浏览器请求
                  if (args.isNotEmpty && args[0]['url'] != null) {
                    final url = args[0]['url']!;

                    // 在当前WebView中加载新URL
                    _webViewController?.loadUrl(
                        urlRequest: URLRequest(url: WebUri(url)));
                  }
                  return {'success': true};
                },
              );

              // 注册通用导航处理器
              controller.addJavaScriptHandler(
                handlerName: 'navigateTo',
                callback: (args) {
                  // 处理从网页传来的导航请求
                  if (args.isNotEmpty) {
                    final route = args[0]['route'] ?? '/';
                    final arguments = args[0]['arguments'] ?? {};

                    // 导航到指定路由
                    Navigator.of(context)
                        .pushNamed(route, arguments: arguments);
                  }
                  return {'success': true};
                },
              );
            },
            onLoadStart: (controller, url) {
              setState(() {
                _isLoading = true;
                _hasError = false;
                _errorMessage = null;
              });
            },
            onLoadStop: (controller, url) {
              setState(() {
                _isLoading = false;
              });

              // 页面加载完成后，注入一些初始化脚本
              controller.evaluateJavascript(source: '''
                // 设置Flutter通信桥
                window.flutterChannel = {
                  openWebBrowser: function(url, title) {
                    return new Promise((resolve, reject) => {
                      window.flutter_inappwebview.callHandler('openWebBrowser', {
                        url: url,
                        title: title
                      }).then(resolve).catch(reject);
                    });
                  },
                  navigateTo: function(route, arguments = {}) {
                    return new Promise((resolve, reject) => {
                      window.flutter_inappwebview.callHandler('navigateTo', {
                        route: route,
                        arguments: arguments
                      }).then(resolve).catch(reject);
                    });
                  }
                };
              ''');
            },
            onReceivedError: (controller, request, error) {
              // setState(() {
              //   _isLoading = false;
              //   _hasError = true;
              //   _errorMessage = '页面加载失败: ${error.description}';
              // });
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              // 允许所有URL加载，解决ORB错误
              return NavigationActionPolicy.ALLOW;
            },
            onLoadResource: (controller, resource) {
              // 监控资源加载，有助于调试ORB错误
              // 资源加载监控已启用
            },
          ),

          // 加载指示器
          if (_isLoading) _buildLoadingIndicator(),

          // 错误提示
          if (_hasError) _buildErrorState(),

          // 右上角关闭按钮
          if (!_isLoading && !_hasError)
            Positioned(
              right: 17,
              top: 90,
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(238), // 约等于 0.93 透明度
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    color: Colors.transparent,
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 36,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // 构建空状态
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.public_off,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            '未提供网页地址',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '请检查URL配置',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  // 构建无效URL状态
  Widget _buildInvalidUrlState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.link_off,
            size: 64,
            color: Colors.orange.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            '无效的网页地址',
            style: TextStyle(
              fontSize: 16,
              color: Colors.orange.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'URL格式不正确，请检查地址格式',
            style: TextStyle(
              fontSize: 14,
              color: Colors.orange.shade500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '当前URL: ${widget.url}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // 构建加载指示器
  Widget _buildLoadingIndicator() {
    return Container(
      color: Colors.black.withAlpha(25),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              '加载中...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建错误状态
  Widget _buildErrorState() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage ?? '页面加载失败',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red.shade400,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _hasError = false;
                    _isLoading = true;
                  });
                  _webViewController?.reload();
                },
                child: const Text('重新加载'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
