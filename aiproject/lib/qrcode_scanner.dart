import "dart:math" as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:collection/collection.dart';
import 'package:video_player/video_player.dart';

class LJNQRCodeScanner extends StatefulWidget {
  const LJNQRCodeScanner({super.key});

  @override
  State<LJNQRCodeScanner> createState() => _LJNQRCodeScannerState();
}

class _LJNQRCodeScannerState extends State<LJNQRCodeScanner> {
  // 音频播放器
  late VideoPlayerController _mediaController;

  // 扫码控制器
  final MobileScannerController _mobileScannerController =
      MobileScannerController(
          torchEnabled: false,
          returnImage: true,
          autoStart: true,
          // detectionTimeoutMs: 30,
          detectionSpeed: DetectionSpeed.noDuplicates);

  BarcodeCapture? _barcodeCapture;

  // List<CameraDescription> _cameras = <CameraDescription>[];

  // void getCameras() async {
  //   _cameras = await availableCameras();
  //   setState(() {});
  // }

  late List<Offset> _pointCenter;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 设置状态栏透明
      statusBarIconBrightness: Brightness.light, // 设置状态栏图标颜色
    ));
    // player = AudioPlayer();
    // player.setReleaseMode(ReleaseMode.stop);
    // player.setSource(AssetSource("sounds/scan_success.mp3"));

    // 创建视频控制器并初始化
    _mediaController = VideoPlayerController.asset(
      assetPath("sounds/scan_success.mp3"),
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
        allowBackgroundPlayback: false,
      ),
    );

    // 初始化视频控制器
    _mediaController.initialize().then((_) {
      setState(() {
        _mediaController.setLooping(false);
        _mediaController.setVolume(1.0);
      });
    });

    // 识别后结果
    _mobileScannerController.barcodes.listen((BarcodeCapture barcodeCapture) {
      _mobileScannerController.pause();
      _mediaController.play();

      if (mounted) {
        final List<Barcode> barcodes = barcodeCapture.barcodes;
        logger.info("qrcode 的数量: ${barcodes.length}");

        final screenSize = context.read<SystemCubit>().state.screenSize;

        List<Offset> pointCenter = [];
        for (var barcode in barcodes) {
          pointCenter.add(_getPointPosition(barcode.corners, BoxFit.cover,
                  barcodeCapture.size, screenSize) -
              Offset(33.5.w, 33.5.w));
        }

        setState(() {
          _pointCenter = pointCenter;
          _barcodeCapture = barcodeCapture;
        });

        if (barcodes.length == 1) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // 300ms后再次打开页面
            Future.delayed(Duration(milliseconds: 300), () {
              if (mounted) {
                Navigator.of(context).pushReplacementNamed(
                    "/mywebview?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/#/page2')}");
              }
            });
          });
        }
      }
    }, onError: (error) {
      logger.info('Error: $error');
    });
  }

  @override
  void dispose() {
    // 退出全屏
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 设置状态栏透明
      statusBarIconBrightness: Brightness.dark, // 设置状态栏图标颜色
    ));

    _mediaController.dispose();
    _mobileScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 二维码的位置
    final overlays = <Widget>[
      if (_barcodeCapture != null && _barcodeCapture!.barcodes.isNotEmpty)
        for (int i = 0; i < _barcodeCapture!.barcodes.length; i++)
          Positioned(
            left: _pointCenter[i].dx,
            top: _pointCenter[i].dy,
            child: BarcodePoint(
              rawValue: _barcodeCapture!.barcodes[i].rawValue!,
            ),
          ),
    ];

    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
      return Scaffold(
          primary: false,
          appBar: null,
          body: Stack(
            fit: StackFit.expand,
            children: [
              MobileScanner(
                fit: BoxFit.cover,
                controller: _mobileScannerController,
                // onDetect: _handleBarcode,
              ),

              if (_barcodeCapture != null && _barcodeCapture!.image != null)
                Stack(fit: StackFit.expand, children: [
                  // 扫码后暂停结果
                  Image.memory(
                    _barcodeCapture!.image!,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    frameBuilder: (
                      BuildContext context,
                      Widget child,
                      int? frame,
                      bool? wasSynchronouslyLoaded,
                    ) {
                      if (wasSynchronouslyLoaded == true || frame != null) {
                        return child;
                      }

                      return SizedBox();
                    },
                  ),
                  ...overlays
                ]),

              // 按钮与扫码条动画
              ButtonAndScanBarWidget(
                controller: _mobileScannerController,
                barcodeCapture: _barcodeCapture,
              )
            ],
          ));
    });
  }

  // 获取二维码中心点
  Offset _getPointPosition(List<Offset> barcodeCorners, BoxFit boxFit,
      Size cameraPreviewSize, Size size) {
    ScalingRatios ratio = calculateBoxFitRatio(boxFit, cameraPreviewSize, size);

    double horizontalPadding =
        ((cameraPreviewSize.width * ratio.widthRatio - size.width) / 2);
    double verticalPadding =
        ((cameraPreviewSize.height * ratio.heightRatio - size.height) / 2);

    final List<Offset> adjustedOffset = [
      Offset(
        (barcodeCorners[0].dx * ratio.widthRatio - horizontalPadding),
        (barcodeCorners[0].dy * ratio.heightRatio - verticalPadding),
      ),
      Offset(
        (barcodeCorners[1].dx * ratio.widthRatio - horizontalPadding),
        (barcodeCorners[1].dy * ratio.heightRatio - verticalPadding),
      ),
      Offset(
        (barcodeCorners[2].dx * ratio.widthRatio - horizontalPadding),
        (barcodeCorners[2].dy * ratio.heightRatio - verticalPadding),
      ),
      Offset(
        (barcodeCorners[3].dx * ratio.widthRatio - horizontalPadding),
        (barcodeCorners[3].dy * ratio.heightRatio - verticalPadding),
      ),
    ];

    double sumX = 0.0;
    double sumY = 0.0;

    // 累加四个角的坐标
    for (var corner in adjustedOffset) {
      sumX += corner.dx;
      sumY += corner.dy;
    }

    // 计算平均值，即为中心点
    return Offset(sumX / adjustedOffset.length, sumY / adjustedOffset.length);
  }
}

class ButtonAndScanBarWidget extends StatefulWidget {
  final BarcodeCapture? barcodeCapture;
  final MobileScannerController controller;
  const ButtonAndScanBarWidget(
      {super.key, required this.controller, this.barcodeCapture});

  @override
  State<ButtonAndScanBarWidget> createState() {
    return _ButtonAndScanBarWidgetState();
  }
}

class _ButtonAndScanBarWidgetState extends State<ButtonAndScanBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;

  late DateTime now;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _animation = Tween<double>(begin: 0.0, end: 690.w).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    // 使用 TweenSequence 创建分为三个阶段的透明度动画
    _opacityAnimation = TweenSequence([
      // 入场阶段: 透明度从 0.0 增加到 1.0
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 1.5, // 这里可以调整时间比例
      ),
      // 保持阶段: 透明度保持在 1.0
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0), // 保持不变
        weight: 7.0, // 这个阶段的时间
      ),
      // 退出阶段: 透明度从 1.0 减少到 0.0
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 1.5, // 退出阶段的时间比例
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear, // 整体动画的曲线
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  // 底部
  Widget _buildBarcode() {
    if (widget.barcodeCapture == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '扫一扫',
            overflow: TextOverflow.fade,
            style: TextStyle(
                height: 1.08,
                color: Colors.white,
                fontSize: fontSizeScale(32.w),
                decoration: TextDecoration.none),
          ),
          Text(
            "•",
            style: TextStyle(color: Colors.white, fontSize: 30.w),
          )
        ],
      );
    } else {
      final v = widget.barcodeCapture?.barcodes.firstOrNull?.rawValue ??
          "No barcode detected";
      now = DateTime.now();

      return Text(
        "$v : $now",
        overflow: TextOverflow.fade,
        style: TextStyle(
            height: 1.08,
            color: Colors.white,
            fontSize: fontSizeScale(26.w),
            decoration: TextDecoration.none),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
      return Positioned.fill(
        child: Column(
          children: [
            SizedBox(height: systemState.statusHeight),

            // 顶层的两按钮
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 关闭按钮
                Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.only(left: 39.w),
                  width: 50.w,
                  height: 50.w,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(), // 点击事件
                    child: Icon(
                      const IconData(
                        0xe601,
                        fontFamily: 'Iconfont',
                      ),
                      size: 50.w, // 图标的大小
                      color: Colors.white, // 图标颜色
                    ),
                  ),
                ),

                // 更多按钮
                Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.only(right: 39.w),
                  width: 50.w,
                  height: 50.w,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(), // 点击事件
                    child: Icon(
                      const IconData(
                        0xe659,
                        fontFamily: 'Iconfont',
                      ),
                      size: 50.w, // 图标的大小
                      color: Colors.white, // 图标颜色
                    ),
                  ),
                ),
              ],
            ),

            // 中间扫码框
            Visibility(
              visible: widget.barcodeCapture == null,
              child: Expanded(
                  flex: 4,
                  child: Center(
                      child: SizedBox(
                    // color: const Color.fromARGB(193, 247, 0, 0),
                    height: 690.w,
                    width: 640.w,
                    child: Stack(
                      children: [
                        AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Positioned(
                                left: 0,
                                top: _animation.value,
                                child: FadeTransition(
                                    opacity: _opacityAnimation, // 透明度动画
                                    child: Image.asset(
                                      assetPath(
                                          'images/avatar/scaner_line.png'),
                                      width: 640.w,
                                      // height: 20.w,
                                      fit: BoxFit.fitWidth,
                                    )));
                          },
                        )
                      ],
                    ),
                  ))),
            ),

            // 轻触照亮按钮
            Visibility(
              visible: widget.barcodeCapture == null,
              child: Expanded(
                flex: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 打开电筒
                    GestureDetector(
                      onTap: () {
                        widget.controller.toggleTorch();
                      }, // 点击事件
                      child: Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: const BoxDecoration(
                            // color: Colors.transparent, // 容器背景颜色
                            // color: Color.fromARGB(255, 255, 0, 0), // 容器背景颜色
                            ),
                        child: Center(
                          // 使图标居中
                          child: Icon(
                            const IconData(
                              0xe615,
                              fontFamily: 'Iconfont',
                            ),
                            size: 70.w, // 图标大小
                            color: Colors.white, // 图标颜色
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    Text(
                      "轻触照亮",
                      style: TextStyle(
                          height: 1.08,
                          fontSize: fontSizeScale(26.w),
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                    ),
                    Text(
                      "识别二维码 / 花草 / 动物 / 商品等",
                      style: TextStyle(
                          height: 1.08,
                          fontSize: fontSizeScale(28.w),
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                    ),
                    SizedBox(
                      height: 30.w,
                    ),
                  ],
                ),
              ),
            ),

            // 两按钮 与 中间商品
            Visibility(
              visible: widget.barcodeCapture == null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 我的二维码
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 90.w,
                            height: 90.w,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(80, 230, 230, 230),
                              shape: BoxShape.circle,
                            ),
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Icon(
                                const IconData(
                                  0xe64b,
                                  fontFamily: 'Iconfont',
                                ),
                                size: 35.w,
                                color: Colors.white,
                              ),
                            )),
                        SizedBox(
                          height: 5.w,
                        ),
                        Text("我的二维码",
                            style: TextStyle(
                                height: 1.08,
                                fontSize: fontSizeScale(22.w),
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                decoration: TextDecoration.none))
                      ],
                    ),
                  ),

                  // 商品
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(15.w),
                      // width: 390.w,
                      height: 90.w,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(150, 240, 240, 240),
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 61.w,
                            height: 61.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.w), // 圆角
                              border: Border.all(
                                width: 1.w, // 边框宽度
                                color: Colors.white, // 边框颜色
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                    assetPath('images/avatar/baolong.png')),
                                fit: BoxFit.cover, // 图像填充方式
                              ),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                              flex: 1,
                              child: Text(
                                "暴龙太阳眼睛",
                                style: TextStyle(
                                    height: 1.08,
                                    fontSize: fontSizeScale(27.w)),
                              )),
                          SizedBox(width: 15.w),
                          Container(
                              color: Colors.transparent,
                              width: 21.w,
                              // margin: const EdgeInsets.only(right: 15).w,
                              child: Icon(
                                const IconData(
                                  0xed9d,
                                  fontFamily: 'Iconfont',
                                ),
                                size: 21.0.w,
                                color: Colors.black,
                              ))
                        ],
                      ),
                    ),
                  ),

                  // 相册
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 90.w,
                            height: 90.w,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(80, 230, 230, 230),
                              shape: BoxShape.circle,
                            ),
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Icon(
                                const IconData(
                                  0xe6e5,
                                  fontFamily: 'Iconfont',
                                ),
                                size: 35.w,
                                color: Colors.white,
                              ),
                            )),
                        SizedBox(
                          height: 5.w,
                        ),
                        Text("相册",
                            style: TextStyle(
                                height: 1.08,
                                fontSize: fontSizeScale(22.w),
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                decoration: TextDecoration.none))
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Visibility(
                visible: widget.barcodeCapture == null,
                child: SizedBox(
                  height: 35.w,
                )),

            Visibility(
              visible: widget.barcodeCapture != null,
              child: Expanded(
                flex: 4,
                child: SizedBox(),
              ),
            ),

            // 扫码结果
            Container(
                color: const Color.fromARGB(162, 0, 0, 0),
                width: 750.w,
                height: 135.w,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: 135.w,
                    color: Colors.black.withValues(alpha: 0.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: Center(child: _buildBarcode())),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      );
    });
  }
}

class BarcodePoint extends StatefulWidget {
  final String rawValue;

  const BarcodePoint({
    super.key,
    required this.rawValue,
  });

  @override
  State<StatefulWidget> createState() {
    return _BarcodePoint();
  }
}

class _BarcodePoint extends State<BarcodePoint> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            // 点击圆形时显示SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Circle Clicked!  ${widget.rawValue}')));
          },
          child: Container(
            width: 67.0.w, // 外圆直径 = 内圆直径 + 边框宽度
            height: 67.0.w, // 外圆直径 = 内圆直径 + 边框宽度
            decoration: BoxDecoration(
              color:
                  Color.fromRGBO(65, 177, 91, 0.9), // 内圆颜色 (RGB: 65, 177, 91)
              shape: BoxShape.circle, // 圆形
              border: Border.all(
                color: Color.fromRGBO(
                    255, 255, 255, 0.9), // 边框颜色 (RGB: 243, 255, 248)
                width: 6.0.w, // 边框宽度
              ),
            ),
          ),
        )
      ],
    );
  }
}

class BarcodePainter2 extends CustomPainter {
  /// Construct a new [BarcodePainter] instance.
  const BarcodePainter2({
    required this.barcodeCorners,
    required this.barcodeSize,
    required this.boxFit,
    required this.cameraPreviewSize,
    required this.color,
    required this.style,
  });

  /// The corners of the barcode.
  final List<Offset> barcodeCorners;

  /// The size of the barcode.
  final Size barcodeSize;

  /// The [BoxFit] to use when painting the barcode box.
  final BoxFit boxFit;

  /// The size of the camera preview,
  /// relative to which the [barcodeSize] and [barcodeCorners] are positioned.
  final Size cameraPreviewSize;

  /// The color to use when painting the barcode box.
  final Color color;

  /// The style to use when painting the barcode box.
  final PaintingStyle style;

  @override
  void paint(Canvas canvas, Size size) {
    if (barcodeCorners.isEmpty ||
        barcodeSize.isEmpty ||
        cameraPreviewSize.isEmpty) {
      return;
    }

    ScalingRatios ratio = calculateBoxFitRatio(boxFit, cameraPreviewSize, size);
    // final adjustedSize = applyBoxFit(boxFit, cameraPreviewSize, size);

    double horizontalPadding =
        ((cameraPreviewSize.width * ratio.widthRatio - size.width) / 2);
    double verticalPadding =
        ((cameraPreviewSize.height * ratio.heightRatio - size.height) / 2);

    final List<Offset> adjustedOffset = [
      Offset(
        (barcodeCorners[0].dx * ratio.widthRatio - horizontalPadding),
        (barcodeCorners[0].dy * ratio.heightRatio - verticalPadding),
      ),
      Offset(
        (barcodeCorners[1].dx * ratio.widthRatio - horizontalPadding),
        (barcodeCorners[1].dy * ratio.heightRatio - verticalPadding),
      ),
      Offset(
        (barcodeCorners[2].dx * ratio.widthRatio - horizontalPadding),
        (barcodeCorners[2].dy * ratio.heightRatio - verticalPadding),
      ),
      Offset(
        (barcodeCorners[3].dx * ratio.widthRatio - horizontalPadding),
        (barcodeCorners[3].dy * ratio.heightRatio - verticalPadding),
      ),
    ];

    final cutoutPath = Path()..addPolygon(adjustedOffset, true);

    final backgroundPaint = Paint()
      ..color = color
      ..style = style;

    canvas.drawPath(cutoutPath, backgroundPaint);
  }

  @override
  bool shouldRepaint(BarcodePainter2 oldDelegate) {
    const ListEquality<Offset> listEquality = ListEquality<Offset>();

    return listEquality.equals(oldDelegate.barcodeCorners, barcodeCorners) ||
        oldDelegate.barcodeSize != barcodeSize ||
        oldDelegate.boxFit != boxFit ||
        oldDelegate.cameraPreviewSize != cameraPreviewSize ||
        oldDelegate.color != color ||
        oldDelegate.style != style;
  }
}

class ScalingRatios {
  final double widthRatio;
  final double heightRatio;

  ScalingRatios(this.widthRatio, this.heightRatio);

  @override
  String toString() =>
      'ScalingRatios(widthRatio: $widthRatio, heightRatio: $heightRatio)';
}

/// Calculate the scaling ratios for width and height to fit the small box (cameraPreviewSize)
/// into the large box (size) based on the specified BoxFit mode.
/// Returns a ScalingRatios object containing the width and height scaling ratios.
ScalingRatios calculateBoxFitRatio(
    BoxFit boxFit, Size cameraPreviewSize, Size size) {
  // If the width or height of cameraPreviewSize or size is 0, return (1.0, 1.0) (no scaling)
  if (cameraPreviewSize.width <= 0 ||
      cameraPreviewSize.height <= 0 ||
      size.width <= 0 ||
      size.height <= 0) {
    return ScalingRatios(1.0, 1.0);
  }

  // Calculate the scaling ratios for width and height
  final widthRatio = size.width / cameraPreviewSize.width;
  final heightRatio = size.height / cameraPreviewSize.height;

  switch (boxFit) {
    case BoxFit.fill:
      // Stretch to fill the large box without maintaining aspect ratio
      return ScalingRatios(widthRatio, heightRatio);

    case BoxFit.contain:
      // Maintain aspect ratio, ensure the content fits entirely within the large box
      final ratio = math.min(widthRatio, heightRatio);
      return ScalingRatios(ratio, ratio);

    case BoxFit.cover:
      // Maintain aspect ratio, ensure the content fully covers the large box
      final ratio = math.max(widthRatio, heightRatio);
      return ScalingRatios(ratio, ratio);

    case BoxFit.fitWidth:
      // Maintain aspect ratio, ensure the width matches the large box
      return ScalingRatios(widthRatio, widthRatio);

    case BoxFit.fitHeight:
      // Maintain aspect ratio, ensure the height matches the large box
      return ScalingRatios(heightRatio, heightRatio);

    case BoxFit.none:
      // No scaling
      return ScalingRatios(1.0, 1.0);

    case BoxFit.scaleDown:
      // If the content is larger than the large box, scale down to fit; otherwise, no scaling
      final ratio = math.min(1.0, math.min(widthRatio, heightRatio));
      return ScalingRatios(ratio, ratio);
  }
}
