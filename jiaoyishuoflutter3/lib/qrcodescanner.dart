import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class LJNQRCodeScanner extends StatefulWidget {
  const LJNQRCodeScanner({super.key});

  @override
  State<LJNQRCodeScanner> createState() => _LJNQRCodeScannerState();
}

class _LJNQRCodeScannerState extends State<LJNQRCodeScanner>
    with SingleTickerProviderStateMixin {
  Barcode? _barcode;

  // 音频播放器
  late AudioPlayer player = AudioPlayer();

  // 扫码控制器
  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
    returnImage: true,
  );

  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;
  double _statusHeight = 0;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 设置状态栏透明
      statusBarIconBrightness: Brightness.light, // 设置状态栏图标颜色
    ));

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

    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      logger.info("来咯");
      await player.setSource(AssetSource("sounds/scan_success.mp3"));
    });
  }

  @override
  Future<void> dispose() async {
    // 退出全屏
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 设置状态栏透明
      statusBarIconBrightness: Brightness.dark, // 设置状态栏图标颜色
    ));

    player.dispose();
    _controller.dispose();
    await controller.dispose();
    super.dispose();
  }

  Widget _buildBarcode(Barcode? value) {
    if (value == null) {
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
    }

    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: TextStyle(
          height: 1.08,
          color: Colors.white,
          fontSize: fontSizeScale(26.w),
          decoration: TextDecoration.none),
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      _statusHeight = 30.w;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }
    return Scaffold(
        primary: false,
        appBar: null,
        body: Stack(
          children: [
            MobileScanner(
              fit: BoxFit.cover,
              controller: controller,
              onDetect: _handleBarcode,
            ),

            // 扫码后暂停结果
            Positioned.fill(
                child: StreamBuilder<BarcodeCapture>(
              stream: controller.barcodes,
              builder: (context, snapshot) {
                final barcode = snapshot.data;

                if (barcode == null) return Container();
                final barcodeImage = barcode.image;
                if (barcodeImage == null) return Container();

                return Image.memory(
                  barcodeImage,
                  fit: BoxFit.cover,
                  frameBuilder: (
                    BuildContext context,
                    Widget child,
                    int? frame,
                    bool? wasSynchronouslyLoaded,
                  ) {
                    if (wasSynchronouslyLoaded == true || frame != null) {
                      // 播放音乐
                      player.resume();

                      // 停止扫码
                      controller.stop();
                      return child;
                    }

                    return const CircularProgressIndicator();
                  },
                );
              },
            )),

            Positioned.fill(
              child: Column(
                children: [
                  SizedBox(height: _statusHeight),

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

                  // SizedBox(
                  //   height: 200.w,
                  // ),

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
                    )),
                  ),

                  // 轻触照亮按钮
                  Expanded(
                    flex: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.w, // 容器宽度
                          height: 100.w, // 容器高度
                          decoration: const BoxDecoration(
                              // color: Colors.transparent, // 容器背景颜色
                              // color: Color.fromARGB(255, 255, 0, 0), // 容器背景颜色
                              ),
                          child: Center(
                            // 使图标居中
                            child: GestureDetector(
                              onTap: () {
                                controller.toggleTorch();
                              }, // 点击事件
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

                  // 两按钮

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.w, color: Colors.white),
                                  borderRadius:
                                      BorderRadius.circular(6.w), // 可以调整圆角的半径大小
                                  image: DecorationImage(
                                    image: ResizeImage(
                                        AssetImage(assetPath(
                                            'images/avatar/baolong.png')),
                                        width: 120.w.toInt(),
                                        height: 120.w.toInt()),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                width: 61.w,
                                height: 61.w,
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

                  SizedBox(
                    height: 35.w,
                  ),

                  Container(
                      color: const Color.fromARGB(162, 0, 0, 0),
                      width: 750.w,
                      height: 135.w,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          height: 135.w,
                          color: Colors.black.withOpacity(0.4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child:
                                      Center(child: _buildBarcode(_barcode))),
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            )
          ],
        ));
  }
}
