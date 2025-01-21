import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:audioplayers/audioplayers.dart';

class LJNQRCodeScanner extends StatefulWidget {
  const LJNQRCodeScanner({super.key});

  @override
  State<LJNQRCodeScanner> createState() => _LJNQRCodeScannerState();
}

class _LJNQRCodeScannerState extends State<LJNQRCodeScanner> {
  // 音频播放器
  // late AudioPlayer player;

  // 扫码控制器
  final MobileScannerController controller = MobileScannerController(
      torchEnabled: false,
      returnImage: true,
      autoStart: true,
      // detectionTimeoutMs: 30,
      detectionSpeed: DetectionSpeed.noDuplicates);

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
  }

  @override
  void dispose() {
    // 退出全屏
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 设置状态栏透明
      statusBarIconBrightness: Brightness.dark, // 设置状态栏图标颜色
    ));

    // player.dispose();
    controller.dispose();
    super.dispose();
  }

  BarcodeCapture? _barcodeCapture;
  void _handleBarcode(BarcodeCapture barcodes) async {
    if (mounted) {
      if (barcodes.barcodes.isNotEmpty) {
        setState(() {
          _barcodeCapture = barcodes;
        });

        // 打印 barcode.corners 和 barcode.size
        for (final Barcode barcode in _barcodeCapture!.barcodes) {
          if (!barcode.size.isEmpty && barcode.corners.isNotEmpty) {
            logger.info('Barcode corners: ${barcode.corners}');
            logger.info('Barcode size: ${barcode.size}');
          }
        }

        await controller.stop();
        // await player.resume();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 二维码的位置
    final overlays = <Widget>[
      if (_barcodeCapture != null && _barcodeCapture!.barcodes.isNotEmpty)
        for (final Barcode barcode in _barcodeCapture!.barcodes)
          if (!barcode.size.isEmpty && barcode.corners.isNotEmpty)
            CustomPaint(
              painter: BarcodePainter(
                barcodeCorners: barcode.corners,
                barcodeSize: barcode.size,
                boxFit: BoxFit.contain,
                cameraPreviewSize: _barcodeCapture!.size,
                color: const Color.fromARGB(183, 0, 255, 34),
                style: PaintingStyle.fill,
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
                controller: controller,
                onDetect: _handleBarcode,
              ),

              if (_barcodeCapture != null)
                Stack(fit: StackFit.expand, children: [
                  // 扫码后暂停结果
                  Image.memory(
                    _barcodeCapture!.image!,
                    fit: BoxFit.cover,
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
                  ...overlays,
                ]),

              // 盖住目标
              // BarcodeOverlay(controller: controller),

              // 按钮与扫码条动画
              ButtonAndScanBarWidget(
                controller: controller,
                barcodeCapture: _barcodeCapture,
              )
            ],
          ));
    });
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
      return Text(
        v,
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

            if (widget.barcodeCapture == null)
              // 中间扫码框
              Expanded(
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

            // 轻触照亮按钮
            if (widget.barcodeCapture == null)
              Expanded(
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

            // 两按钮 与 中间商品
            if (widget.barcodeCapture == null)
              Row(
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

            if (widget.barcodeCapture == null)
              SizedBox(
                height: 35.w,
              ),

            if (widget.barcodeCapture != null)
              Expanded(
                flex: 4,
                child: SizedBox(),
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

class BarcodePainter2 extends CustomPainter {
  final List<Offset> barcodeCorners;
  final Size barcodeSize;
  final BoxFit boxFit;
  final Size cameraPreviewSize;
  final Color color;
  final PaintingStyle style;

  BarcodePainter2({
    required this.barcodeCorners,
    required this.barcodeSize,
    required this.boxFit,
    required this.cameraPreviewSize,
    required this.color,
    required this.style,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = style;

    // 绘制二维码的角点
    Path path = Path();
    path.moveTo(barcodeCorners[0].dx, barcodeCorners[0].dy);
    for (int i = 1; i < barcodeCorners.length; i++) {
      path.lineTo(barcodeCorners[i].dx, barcodeCorners[i].dy);
    }
    path.close();
    canvas.drawPath(path, paint);

    // 计算二维码的中心点
    final center = _calculateCenter(barcodeCorners);

    // 绘制二维码的中心点
    final centerPaint = Paint()
      ..color = Colors.blue // 中心点颜色
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 5.0, centerPaint); // 画一个半径为5的圆点
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  // 计算二维码的中心点
  Offset _calculateCenter(List<Offset> corners) {
    double centerX = 0.0;
    double centerY = 0.0;

    for (final corner in corners) {
      centerX += corner.dx;
      centerY += corner.dy;
    }

    return Offset(centerX / corners.length, centerY / corners.length);
  }
}
