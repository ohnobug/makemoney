import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/logger.dart';
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
      statusBarIconBrightness: Brightness.dark, // 设置状态栏图标颜色
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
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

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
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 100,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                color: Colors.black.withOpacity(0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: Center(child: _buildBarcode(_barcode))),
                  ],
                ),
              ),
            ))
      ],
    );
  }


}
