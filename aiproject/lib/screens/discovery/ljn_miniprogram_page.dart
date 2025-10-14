import 'dart:convert';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_static/shelf_static.dart' as shelf_static;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

// 定义IPFS网关和本地服务器端口
const String ipfsGateway = 'https://yellow-capable-snipe-8.mypinata.cloud/ipfs/';
const int serverPort = 9413; // 使用一个固定的、不常用的端口

class LJNMiniProgram extends StatefulWidget {
  final String cid;

  const LJNMiniProgram({
    super.key,
    required this.cid,
  });

  @override
  State<LJNMiniProgram> createState() => _LJNMiniProgramState();
}

class _LJNMiniProgramState extends State<LJNMiniProgram>
    with SingleTickerProviderStateMixin {
  // 使用 shelf 包来管理 HttpServer
  HttpServer? _server;
  late final WebViewController _webViewController;

  // Lottie 动画控制器
  late final AnimationController _lottieController;

  // 状态管理
  bool _isWebViewReady = false;
  String? _errorMessage;
  bool get _isLoading => !_lottieController.isCompleted;
  int _flutterMessageCounter = 0;

  @override
  void initState() {
    super.initState();
    _initLotties();
    _initializeAndStartServer();
  }

  @override
  void dispose() {
    _lottieController.dispose();
    _stopServer();
    super.dispose();
  }

  void _initLotties() {
    _lottieController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 10000));
    _lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) setState(() {});
      }
    });
  }

  /// 统一的初始化流程: 下载/准备文件 -> 启动服务器 -> 初始化WebView
  Future<void> _initializeAndStartServer() async {
    try {
      if (widget.cid.isEmpty) throw Exception("小程序链接不能为空");

      // 1. 准备小程序文件目录（下载或使用缓存）
      final miniAppDir = await _prepareMiniAppDirectory(widget.cid);

      // 2. 启动本地服务器，为准备好的文件提供服务
      await _startServer(miniAppDir.path);

      // 3. 初始化 WebView 控制器并设置通信桥梁
      _initializeWebViewController();

      // 4. 更新UI，让WebView加载服务器地址
      if (mounted) {
        setState(() {
          _isWebViewReady = true;
        });
        _webViewController
            .loadRequest(Uri.parse('http://localhost:$serverPort'));
      }
    } catch (e) {
      logger.severe('初始化小程序失败: $e');
      if (mounted) {
        setState(() {
          _errorMessage = '加载失败: \n$e';
        });
      }
    }
  }

  /// 准备小程序目录
  Future<Directory> _prepareMiniAppDirectory(String cid) async {
    final appDir = await getApplicationDocumentsDirectory();
    final miniAppDir = Directory(p.join(appDir.path, 'mini_programs', cid));
    final entryFile = File(p.join(miniAppDir.path, 'index.html'));

    if (await entryFile.exists()) {
      logger.info('发现本地缓存，直接使用: ${miniAppDir.path}');
    } else {
      logger.info('本地缓存不存在，准备从 IPFS 网关下载...');
      final gatewayUrl = '$ipfsGateway$cid';
      logger.info("gatewayUrl: $gatewayUrl");
      await _downloadAndUnzip(gatewayUrl, miniAppDir);
      if (!await entryFile.exists()) {
        throw Exception("资源包下载成功，但未找到入口文件 index.html");
      }
    }
    return miniAppDir;
  }

  /// 启动 Shelf 静态文件服务器
  Future<void> _startServer(String documentRoot) async {
    await _stopServer(); // 先确保旧的服务器已关闭
    final handler = shelf_static.createStaticHandler(
      documentRoot,
      defaultDocument: 'index.html',
    );
    final pipeline = const shelf.Pipeline().addHandler(handler);
    _server = await shelf_io.serve(pipeline, 'localhost', serverPort);
    logger.shout('Shelf server running on http://localhost:$serverPort');
  }

  /// 停止服务器
  Future<void> _stopServer() async {
    await _server?.close(force: true);
    _server = null;
    logger.info("Server stopped.");
  }

  /// 初始化 WebView 控制器，并设置双向通信
  void _initializeWebViewController() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'AppBridge',
        onMessageReceived: (JavaScriptMessage message) {
          logger.info('成功接收到 H5 的信号: ${message.message}');
          // 【核心修改】将所有消息分发到中央处理器
          _handleMessageFromJs(message.message);
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (!_lottieController.isAnimating &&
                !_lottieController.isCompleted) {
              _lottieController.value = (progress / 100) * 0.8;
            }
          },
          onPageFinished: (String url) {
            logger.info("页面加载完成: $url");
            _lottieController
              ..duration = const Duration(milliseconds: 600)
              ..forward();
          },
          onWebResourceError: (WebResourceError error) {
            logger.severe("WebView 资源错误: ${error.description}");
            if (mounted) {
              setState(() {
                _errorMessage = "资源加载失败: ${error.description}";
              });
            }
          },
        ),
      );
  }

  // ==========================================================
  // START: 新增的核心消息处理逻辑
  // ==========================================================
  void _handleMessageFromJs(String message) {
    // 首先展示一个 SnackBar 作为即时反馈
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text("来自小程序的信号: $message"), backgroundColor: Colors.green),
    );

    try {
      // 尝试将消息解析为 JSON 对象
      final data = jsonDecode(message) as Map<String, dynamic>;
      final action = data['action'];

      // 判断 JSON 对象中的 action 字段
      if (action == 'pay') {
        final amount = data['amount'];
        _handlePaymentRequest(amount);
      } else {
        // 可以处理其他基于JSON的复杂指令
        logger.info('接收到未知的JSON指令: $action');
      }
    } catch (e) {
      // 如果解析失败，说明是简单的字符串指令
      if (message == 'close_miniprogram') {
        Navigator.of(context).pop();
      } else if (message == 'show_info') {
        _showMiniprogramInfoModalSheet(context);
      } else {
        logger.warning('接收到未处理的字符串指令: $message');
      }
    }
  }

  /// 处理支付请求的函数
  void _handlePaymentRequest(dynamic amount) {
    logger.shout('接收到支付请求，金额: $amount');

    // 弹出一个原生对话框，模拟支付确认流程
    showDialog(
      context: context,
      barrierDismissible: false, // 用户必须点击按钮才能关闭
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('支付确认'),
          content: Text('您确定要支付 ¥$amount 元吗？'),
          actions: <Widget>[
            TextButton(
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(context).pop(); // 关闭对话框
                logger.info('用户取消了支付');
                // 可选：通知H5支付已取消
                _webViewController.runJavaScript('alert("支付已取消")');
              },
            ),
            TextButton(
              child: const Text('确认支付'),
              onPressed: () {
                Navigator.of(context).pop(); // 关闭对话框
                // TODO: 在这里集成您真实的支付SDK
                logger.shout('用户确认支付: $amount. 这里应该调用支付SDK...');

                // 模拟支付成功后，通知H5
                final result = {'status': 'success', 'amount': amount};
                _webViewController.runJavaScript('alert("支付成功！金额: ¥$amount")');
                _webViewController.runJavaScript(
                    'flutterToJsMessageReceiver(${jsonEncode(result)})');
              },
            ),
          ],
        );
      },
    );
  }
  // ==========================================================
  // END: 新增的核心消息处理逻辑
  // ==========================================================

  /// 下载并解压的逻辑 (不变)
  Future<void> _downloadAndUnzip(String url, Directory targetDir) async {
    if (!await targetDir.exists()) {
      await targetDir.create(recursive: true);
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final archive = ZipDecoder().decodeBytes(response.bodyBytes);
      for (final file in archive) {
        final filePath = p.join(targetDir.path, file.name);
        if (file.isFile) {
          final outFile = File(filePath);
          await outFile.parent.create(recursive: true);
          await outFile.writeAsBytes(file.content as List<int>);
        } else {
          await Directory(filePath).create(recursive: true);
        }
      }
    } else {
      throw Exception('从 IPFS 网关下载失败, 状态码: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          appBar: null,
          backgroundColor: AppColors.neutralGrey40,
          // 【通信】: 添加按钮用于演示 Flutter -> H5
          floatingActionButton: !_isLoading && _errorMessage == null
              ? FloatingActionButton.extended(
                  onPressed: () {
                    if (!_isWebViewReady) return;
                    _flutterMessageCounter++;
                    final messageData = {
                      "from": "Flutter App",
                      "count": _flutterMessageCounter,
                      "timestamp": DateTime.now().toIso8601String()
                    };
                    final jsonString = jsonEncode(messageData);

                    // 使用 runJavaScript 调用 H5 中的全局函数
                    _webViewController.runJavaScript(
                        'flutterToJsMessageReceiver($jsonString)');
                    logger.info("已向 H5 发送消息: $jsonString");
                  },
                  icon: const Icon(Icons.send_to_mobile),
                  label: const Text('发送信号给H5'),
                )
              : null,
          body: Stack(
            children: [
              if (_isWebViewReady && _errorMessage == null)
                WebViewWidget(controller: _webViewController),
              if (_errorMessage != null)
                Center(
                  child: Container(
                    padding: EdgeInsets.all(32.w),
                    child: Text(
                      _errorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red.shade400, fontSize: 32.sp),
                    ),
                  ),
                ),
              Visibility(
                visible: _isLoading && _errorMessage == null,
                child: Container(
                  color: AppColors.neutralGrey40,
                  width: 750.w,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Lottie.asset(
                      assetPath('lotties/miniprogramloading.json'),
                      width: 750.w * 0.4,
                      fit: BoxFit.contain,
                      renderCache: RenderCache.drawingCommands,
                      controller: _lottieController,
                    ),
                  ),
                ),
              ),
              if (!_isLoading || _errorMessage != null)
                Positioned(
                  right: 17.w,
                  top: 90.w,
                  child: Container(
                    width: 192.w,
                    height: 64.w,
                    decoration: BoxDecoration(
                      color: AppColors.whiteTransparent93,
                      borderRadius: BorderRadius.circular(20.w),
                      border: Border.all(
                        color: AppColors.neutralGrey28,
                        width: 1.w,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _showMiniprogramInfoModalSheet(context);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Icon(
                                const IconData(0xe620, fontFamily: 'Iconfont'),
                                color: Theme.of(context).colorScheme.onSurface,
                                size: 36.w,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 2.w,
                          height: 40.w,
                          color: AppColors.neutralGrey22,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              color: Colors.transparent,
                              child: Icon(
                                const IconData(0xe617, fontFamily: 'Iconfont'),
                                color: Theme.of(context).colorScheme.onSurface,
                                size: 36.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  /// 更多小程序信息 (您的代码)
  void _showMiniprogramInfoModalSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('更多作品信息'),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('关闭'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
