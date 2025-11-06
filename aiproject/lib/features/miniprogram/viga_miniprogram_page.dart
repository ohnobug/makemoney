import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/tools/viga_payment_launcher.dart';
import 'package:vigaviga/tools/viga_tools.dart';

const String ipfsGateway =
    'https://amaranth-quiet-perch-930.mypinata.cloud/ipfs/';
const String miniAppVirtualDomain = 'mp.vigaviga.com';

class VigaMiniProgram extends StatefulWidget {
  final String cid;
  const VigaMiniProgram({super.key, required this.cid});

  @override
  State<VigaMiniProgram> createState() => _VigaMiniProgramState();
}

class _VigaMiniProgramState extends State<VigaMiniProgram>
    with SingleTickerProviderStateMixin {
  InAppWebViewController? _webViewController;
  Directory? _miniAppDirectory;
  late final String _virtualDomainForThisApp;
  late final AnimationController _lottieController;

  bool _isResourcesReady = false;
  String? _errorMessage;
  bool get _isLoading => !_lottieController.isCompleted;
  int _flutterMessageCounter = 0;

  @override
  void initState() {
    super.initState();
    _virtualDomainForThisApp = 'https://${widget.cid}.$miniAppVirtualDomain';
    _initLotties();
    _prepareMiniAppResources();
  }

  @override
  void dispose() {
    _lottieController.dispose();
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

  Future<void> _prepareMiniAppResources() async {
    try {
      if (widget.cid.isEmpty) throw Exception("小程序链接不能为空");
      _miniAppDirectory = await _prepareMiniAppDirectory(widget.cid);
      if (mounted) {
        setState(() {
          _isResourcesReady = true;
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

  void _handleMessageFromJs(dynamic messageData) {
    logger.info('成功接收到 H5 的信号: $messageData');

    try {
      final data = messageData is String
          ? jsonDecode(messageData)
          : Map<String, dynamic>.from(messageData);
      final action = data['action'];
      if (action == 'pay') {
        _handlePaymentRequest(data['amount']);
      } else {
        logger.info('接收到未知的JSON指令: $action');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("来自小程序的信号: $messageData"),
              backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      final message = messageData.toString();
      if (message == 'close_miniprogram') {
        context.pop();
      } else if (message == 'show_info') {
        _showMiniprogramInfoModalSheet(context);
      } else {
        logger.warning('接收到未处理的字符串指令: $message');
      }
    }
  }

  void _handlePaymentRequest(dynamic amount) {
    logger.shout('接收到支付请求，金额: $amount');
    VigaPaymentLauncher.startPaymentFlow(
      context,
      amount: amount,
      merchantName: '高级会员服务',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VigaSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          appBar: null,
          backgroundColor: AppColors.neutralGrey40,
          floatingActionButton: !_isLoading && _errorMessage == null
              ? FloatingActionButton.extended(
                  onPressed: () {
                    if (!_isResourcesReady || _webViewController == null) {
                      return;
                    }
                    _flutterMessageCounter++;
                    final messageData = {
                      "from": "Flutter App",
                      "count": _flutterMessageCounter,
                      "timestamp": DateTime.now().toIso8601String()
                    };
                    final jsonString = jsonEncode(messageData);
                    _webViewController!.evaluateJavascript(
                        source: 'flutterToJsMessageReceiver($jsonString)');
                    logger.info("已向 H5 发送消息: $jsonString");
                  },
                  icon: const Icon(Icons.send_to_mobile),
                  label: const Text('发送信号给H5'),
                )
              : null,
          body: Stack(
            children: [
              if (_isResourcesReady &&
                  _errorMessage == null &&
                  _miniAppDirectory != null)
                InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri(_virtualDomainForThisApp),
                  ),
                  initialSettings: InAppWebViewSettings(
                    isInspectable: true,
                    allowUniversalAccessFromFileURLs: true,
                    allowFileAccessFromFileURLs: true,
                    cacheEnabled: false,
                    builtInZoomControls: false,
                    displayZoomControls: false,
                    horizontalScrollBarEnabled: false,
                    verticalScrollBarEnabled: false,
                  ),
                  onWebViewCreated: (controller) {
                    _webViewController = controller;
                    controller.addJavaScriptHandler(
                      handlerName: 'AppBridge',
                      callback: (args) {
                        if (args.isNotEmpty) {
                          _handleMessageFromJs(args.first);
                        }
                      },
                    );
                  },
                  onProgressChanged: (controller, progress) {
                    if (!_lottieController.isAnimating &&
                        !_lottieController.isCompleted) {
                      _lottieController.value = (progress / 100) * 0.8;
                    }
                  },
                  onLoadStop: (controller, url) {
                    logger.info("页面加载完成: $url");
                    _lottieController
                      ..duration = const Duration(milliseconds: 600)
                      ..forward();
                  },
                  shouldInterceptRequest: (controller, request) async {
                    final Uri url = request.url;
                    final Uri virtualDomainUri =
                        Uri.parse(_virtualDomainForThisApp);
                    if (url.host != virtualDomainUri.host ||
                        url.scheme != 'https') {
                      return null;
                    }
                    String requestPath = url.path;
                    if (requestPath.isEmpty || requestPath == '/') {
                      requestPath = '/index.html';
                    }
                    final localFilePath = p.join(
                        _miniAppDirectory!.path, requestPath.substring(1));
                    final file = File(localFilePath);
                    if (await file.exists()) {
                      final Uint8List data = await file.readAsBytes();
                      final String mimeType = lookupMimeType(localFilePath) ??
                          'application/octet-stream';
                      logger.info(
                          '拦截: ${url.toString()} -> 映射到本地: $localFilePath ($mimeType)');
                      return WebResourceResponse(
                        data: data,
                        contentType: mimeType,
                        contentEncoding: 'utf-8',
                        headers: {'Access-Control-Allow-Origin': '*'},
                      );
                    } else {
                      logger.severe('请求的文件未在本地找到: $localFilePath');
                      return WebResourceResponse(
                          statusCode: 404, reasonPhrase: 'Not Found');
                    }
                  },
                  onReceivedError: (controller, request, error) {
                    logger.severe("WebView 资源错误: ${error.description}");
                    // =======================================================
                    // 【FIX】The fix is applied here
                    // =======================================================
                    if (mounted && request.isForMainFrame == true) {
                      setState(() {
                        _errorMessage = "资源加载失败: ${error.description}";
                      });
                    }
                  },
                ),
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
                            onTap: () => context.pop(),
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
                  onPressed: () => context.pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
