import 'dart:io';
import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

// 定义IPFS网关。您可以替换成任何您信任的公共网关。
const String ipfsGateway = 'https://amaranth-quiet-perch-930.mypinata.cloud/ipfs/';

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
  // WebView 控制器
  late WebViewController webViewController;

  // Lottie 动画控制器
  late final AnimationController _lottieController;

  // 状态管理
  bool _isWebViewInitialized = false; // WebView是否已初始化
  String? _errorMessage; // 用于显示错误信息
  bool get _isLoading => !_lottieController.isCompleted; // 通过动画状态判断是否在加载

  @override
  void initState() {
    super.initState();
    // 1. 初始化Lottie动画控制器
    _initLotties();
    // 2. 开始执行小程序加载流程
    _initMiniProgram();
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  void _initLotties() {
    _lottieController = AnimationController(
      vsync: this,
      // 初始时长，后面在 onPageFinished 会被覆盖
      duration: const Duration(milliseconds: 10000),
    );

    // 监听动画完成事件，用于控制UI元素的显示
    _lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) setState(() {});
      }
    });
  }

  /// 主入口函数：负责调度整个加载流程
  Future<void> _initMiniProgram() async {
    try {
      if (widget.cid.isEmpty) {
        throw Exception("小程序链接不能为空");
      }

      // 1. 从 "http://<CID>" 或 "ipfs://<CID>" 中解析出 CID
      final cid = widget.cid;
      logger.info('解析到的小程序 CID: $cid');

      // 2. 构建本地缓存路径
      final appDir = await getApplicationDocumentsDirectory();
      final miniAppDir = Directory(p.join(appDir.path, 'mini_programs', cid));
      final entryFile = File(p.join(miniAppDir.path, 'index.html'));

      // 3. 检查本地缓存是否存在
      if (await entryFile.exists()) {
        logger.info('发现本地缓存，直接加载: ${entryFile.path}');
        _loadFromLocalFile(entryFile);
      } else {
        logger.info('本地缓存不存在，准备从 IPFS 网关下载...');
        final gatewayUrl = '$ipfsGateway$cid';
        await _downloadAndUnzip(gatewayUrl, miniAppDir);

        if (await entryFile.exists()) {
          logger.info('下载解压完成，加载小程序: ${entryFile.path}');
          _loadFromLocalFile(entryFile);
        } else {
          throw Exception("资源包下载成功，但未找到入口文件 index.html");
        }
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

  /// 下载并解压的逻辑
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

  /// 初始化 WebView 并从本地文件加载
  void _loadFromLocalFile(File entryFile) {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // 将网页加载进度映射到Lottie动画的前半部分
            if (!_lottieController.isAnimating &&
                !_lottieController.isCompleted) {
              _lottieController.value = (progress / 100) * 0.8; // 让进度条感觉更灵敏
            }
          },
          onPageStarted: (String url) {
            logger.info("页面开始加载: $url");
          },
          onPageFinished: (String url) {
            logger.info("页面加载完成: $url");
            // 页面加载完, 播放Lottie动画的后半部分并结束
            _lottieController
              ..duration = const Duration(milliseconds: 600) // 设置一个较短的完成动画时长
              ..forward(); // 从当前进度播放到结束
          },
          onWebResourceError: (WebResourceError error) {
            logger.severe("WebView 资源错误: ${error.description}");
            // 可以选择性地向用户展示错误
            // setState(() {
            //   _errorMessage = "资源加载失败: ${error.description}";
            // });
          },
          // 保留您的跳转劫持逻辑
          onNavigationRequest: (NavigationRequest request) {
            logger.info("页面跳转请求: ${request.url}");
            if (request.url.startsWith('http://helloworld.com')) {
              webViewController.loadHtmlString(
                  "<h1 style='margin-top: 100px'>你来到了被劫持的页面，哈哈哈</h1>");
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    // 更新UI状态，准备显示WebView
    if (mounted) {
      setState(() {
        _isWebViewInitialized = true;
      });
    }

    // 使用 loadFile 加载本地 HTML 文件
    webViewController.loadFile(entryFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          appBar: null,
          backgroundColor: AppColors.neutralGrey40, // 设置背景色避免闪烁
          body: Stack(
            children: [
              // 1. WebView 页面本身
              if (_isWebViewInitialized && _errorMessage == null)
                WebViewWidget(controller: webViewController),

              // 2. 错误信息页面
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

              // 3. 加载动画 (使用 _isLoading getter 控制)
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

              // 4. 关闭按钮等UI (仅在加载完成后显示)
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

  // 更多小程序信息 (您的代码)
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
