import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class LJNQRCodeScanner extends StatefulWidget {
  const LJNQRCodeScanner({super.key});

  @override
  State<LJNQRCodeScanner> createState() => _LJNQRCodeScannerState();
}

class _LJNQRCodeScannerState extends State<LJNQRCodeScanner> {
  Barcode? _barcode;

  // 音频播放器
  late AudioPlayer player = AudioPlayer();

  // 扫码控制器
  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
    returnImage: true,
  );

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 设置状态栏透明
      statusBarIconBrightness: Brightness.light, // 设置状态栏图标颜色
    ));

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
    await controller.dispose();
    super.dispose();
  }

  Widget _buildBarcode(Barcode? value) {
    if (value == null) {
      return const Text(
        'Scan something!',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white, fontSize: 26),
      );
    }

    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white, fontSize: 26),
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
    return Stack(
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
              SizedBox(
                height: 25.w,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 38.w),
                    width: 45.w,
                    height: 45.w,
                    child: IconButton(
                      icon: Icon(
                          size: 45.w,
                          const IconData(
                            0xe601,
                            fontFamily: 'Iconfont',
                          )),
                      color: Colors.white,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      disabledColor: Colors.transparent,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 38.w),
                    width: 45.w,
                    height: 45.w,
                    child: IconButton(
                      icon: Icon(
                          size: 45.w,
                          const IconData(
                            0xe659,
                            fontFamily: 'Iconfont',
                          )),
                      color: Colors.white,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      disabledColor: Colors.transparent,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
              // 中间扫码框
              Expanded(
                  flex: 919,
                  child: Center(
                    child: Container(
                      height: 690.w,
                      width: 640.w,
                      // margin: EdgeInsets.only(top: 235.w),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(160, 168, 168, 168),
                          border: Border.all(
                            color: const Color.fromARGB(255, 231, 231, 231),
                            width: 2.w,
                            style: BorderStyle.solid,
                          )),
                      child: null,
                    ),
                  )),
              // 轻触照亮按钮
              Expanded(
                flex: 295,
                child: Container(
                  color: const Color.fromARGB(159, 72, 255, 0),
                  // height: 295.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                            size: 80.w,
                            const IconData(
                              0xe601,
                              fontFamily: 'Iconfont',
                            )),
                        color: Colors.white,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        disabledColor: Colors.transparent,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(
                        "轻触照亮",
                        style: TextStyle(fontSize: 25.w),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                            size: 92.w,
                            const IconData(
                              0xe601,
                              fontFamily: 'Iconfont',
                            )),
                        color: Colors.white,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        disabledColor: Colors.transparent,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(
                        "我的二维码",
                        style: TextStyle(fontSize: 23.w),
                      )
                    ],
                  ),
                  SizedBox(width: 25.w),
                  Container(
                    width: 390.w,
                    height: 90.w,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 247, 247, 247),
                        border: Border(
                            top: BorderSide(
                          color: const Color.fromARGB(255, 231, 231, 231),
                          width: 2.w,
                          style: BorderStyle.solid,
                        ))),
                  ),
                  SizedBox(width: 25.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                            size: 92.w,
                            const IconData(
                              0xe601,
                              fontFamily: 'Iconfont',
                            )),
                        color: Colors.white,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        disabledColor: Colors.transparent,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text("相册", style: TextStyle(fontSize: 23.w))
                    ],
                  ),
                ],
              ),
            ],
          ),

          // Positioned(
          //     left: 0,
          //     right: 0,
          //     bottom: 0,
          //     height: 100,
          //     child: Align(
          //       alignment: Alignment.bottomCenter,
          //       child: Container(
          //         alignment: Alignment.bottomCenter,
          //         height: 100,
          //         color: Colors.black.withOpacity(0.4),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: [
          //             Expanded(child: Center(child: _buildBarcode(_barcode))),
          //           ],
          //         ),
          //       ),
          //     ))
        )
      ],
    );
  }
}
