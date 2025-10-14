import 'dart:convert';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

// 定义IPFS网关
const String ipfsGateway = 'http://192.168.1.227:8080/ipfs/';

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
  // 将服务器声明为 late 变量，因为它依赖于动态路径
  late InAppLocalhostServer _localhostServer;
  InAppWebViewController? _webViewController;

  // Lottie 动画控制器
  late final AnimationController _lottieController;

  // 状态管理
  bool _isWebViewReadyToLoad = false;
  String? _errorMessage;
  bool get _isLoading => !_lottieController.isCompleted;
  int _flutterMessageCounter = 0;

  @override
  void initState() {
    super.initState();
    _initLotties();
    _initMiniProgram();
  }

  @override
  void dispose() {
    _lottieController.dispose();
    // 确保服务器在页面销毁时已停止
    if (_localhostServer.isRunning()) {
      _localhostServer.close();
    }
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

  /// 主入口函数：负责下载资源并启动本地服务器
  Future<void> _initMiniProgram() async {
    try {
      if (widget.cid.isEmpty) throw Exception("小程序链接不能为空");

      final cid = widget.cid;
      final appDir = await getApplicationDocumentsDirectory();
      final miniAppDir = Directory(p.join(appDir.path, 'mini_programs', cid));

      if (!await miniAppDir.exists() || await miniAppDir.list().isEmpty) {
        logger.info('本地缓存不存在或为空，准备从 IPFS 网关下载...');
        final gatewayUrl = '$ipfsGateway$cid';
        await _downloadAndUnzip(gatewayUrl, miniAppDir);
      } else {
        logger.info('发现本地缓存，直接使用: ${miniAppDir.path}');
      }

      // 在构造函数中传递 documentRoot
      _localhostServer =
          InAppLocalhostServer(port: 8080, documentRoot: miniAppDir.path);

      // start() 方法不带任何参数
      await _localhostServer.start();

      logger.shout('本地服务器已在 http://localhost:8080 启动');

      if (mounted) {
        setState(() {
          _isWebViewReadyToLoad = true;
        });
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
          floatingActionButton: !_isLoading && _errorMessage == null
              ? FloatingActionButton.extended(
                  onPressed: () {
                    if (_webViewController == null) return;
                    _flutterMessageCounter++;
                    final messageData = {
                      "from": "Flutter App",
                      "count": _flutterMessageCounter,
                      "timestamp": DateTime.now().toIso8601String()
                    };

                    _webViewController?.evaluateJavascript(
                        source:
                            'window.flutterToJsMessageReceiver(${jsonEncode(messageData)})');

                    logger.info("已向 H5 发送消息: ${jsonEncode(messageData)}");
                  },
                  icon: const Icon(Icons.send_to_mobile),
                  label: const Text('发送信号给H5'),
                )
              : null,
          body: Stack(
            children: [
              if (_isWebViewReadyToLoad && _errorMessage == null)
                InAppWebView(
                  initialUrlRequest:
                      URLRequest(url: WebUri('http://localhost:8080')),
                  initialSettings: InAppWebViewSettings(
                    javaScriptCanOpenWindowsAutomatically: true,
                    cacheMode: CacheMode.LOAD_NO_CACHE,
                    // =======================================================
                    // 修正这里的错误
                    mixedContentMode:
                        MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
                    // =======================================================
                    mediaPlaybackRequiresUserGesture: false,
                  ),
                  onWebViewCreated: (controller) {
                    _webViewController = controller;

                    controller.addJavaScriptHandler(
                      handlerName: 'AppBridge',
                      callback: (args) {
                        final message = args.isNotEmpty ? args[0] : null;
                        logger.info('成功接收到 H5 的信号: $message');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("来自小程序的信号: $message"),
                              backgroundColor: Colors.green),
                        );

                        if (message == 'close_miniprogram') {
                          Navigator.of(context).pop();
                        }
                        if (message is Map &&
                            message['action'] == 'show_info') {
                          _showMiniprogramInfoModalSheet(context);
                        }
                      },
                    );
                  },
                  onLoadStop: (controller, url) {
                    logger.info("页面加载完成: $url");
                    _lottieController
                      ..duration = const Duration(milliseconds: 600)
                      ..forward();
                  },
                  onProgressChanged: (controller, progress) {
                    if (!_lottieController.isAnimating &&
                        !_lottieController.isCompleted) {
                      _lottieController.value = (progress / 100) * 0.8;
                    }
                  },
                  onLoadError: (controller, url, code, message) {
                    logger
                        .severe("WebView 加载错误, Code: $code, Message: $message");
                    if (mounted) {
                      setState(() {
                        _errorMessage = "小程序资源加载失败: $message";
                      });
                    }
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    logger.info("来自 H5 Console: ${consoleMessage.message}");
                  },
                ),

              // --- 以下 UI 部分保持不变 ---
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
                      onPressed: () => Navigator.pop(context))
                ],
              )));
        });
  }
}
