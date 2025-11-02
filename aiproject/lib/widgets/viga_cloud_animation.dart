import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';

class VigaCloudAnimation extends StatefulWidget {
  const VigaCloudAnimation({super.key});

  @override
  State<VigaCloudAnimation> createState() => _VigaCloudAnimationState();
}

class CloudModel {
  Offset position;
  final Color color;
  final double size;
  final double speed;
  final List<Offset> circleOffsets;
  final double blurSigma;

  CloudModel({
    required this.position,
    required this.color,
    required this.size,
    required this.speed,
    required this.circleOffsets,
    required this.blurSigma,
  });
}

class _VigaCloudAnimationState extends State<VigaCloudAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<CloudModel> _clouds = [];
  final Random _random = Random();
  final int numberOfClouds = 30;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeClouds();
      _controller.addListener(() {
        _updateCloudPositions();
      });
    });
  }

  void _initializeClouds() {
    final Size screenSize = MediaQuery.of(context).size;
    for (int i = 0; i < numberOfClouds; i++) {
      _clouds.add(_createRandomCloud(screenSize));
    }
    setState(() {});
  }

  CloudModel _createRandomCloud(Size screenSize) {
    final double size = _random.nextDouble() * 100 + 50;
    final double speed = _random.nextDouble() * 20 + 10;
    final Color color = Color.fromRGBO(
      _random.nextInt(155) + 100,
      _random.nextInt(155) + 100,
      _random.nextInt(155) + 100,
      _random.nextDouble() * 0.4 + 0.3,
    );
    final double blurSigma = size * (_random.nextDouble() * 0.2 + 0.3);

    // 【修复】在 [-1屏, +2屏] 的广阔范围内随机生成初始位置
    // 总宽度为 3 * screenSize.width
    final Offset position = Offset(
      _random.nextDouble() * (screenSize.width * 3) - screenSize.width,
      _random.nextDouble() * screenSize.height,
    );

    final List<Offset> circleOffsets = List.generate(5, (index) {
      return Offset(
        (_random.nextDouble() - 0.5) * size * 1.2,
        (_random.nextDouble() - 0.5) * size * 0.6,
      );
    });

    return CloudModel(
      position: position,
      color: color,
      size: size,
      speed: speed,
      circleOffsets: circleOffsets,
      blurSigma: blurSigma,
    );
  }

  void _updateCloudPositions() {
    if (!mounted) return;
    final Size screenSize = MediaQuery.of(context).size;
    const double deltaTime = 16 / 1000;

    setState(() {
      for (var cloud in _clouds) {
        double newX = cloud.position.dx + cloud.speed * deltaTime;

        // 【修复】等到云彩的左边缘完全飘出“正二屏”的右边界后，才进行重置
        if (newX > screenSize.width * 2) {
          // 将云彩重置到“负一屏”的左侧外部，确保它能平滑地再次进入
          cloud.position = Offset(
            -screenSize.width - cloud.size,
            _random.nextDouble() * screenSize.height,
          );
        } else {
          cloud.position = Offset(newX, cloud.position.dy);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D1B2A),
              Color(0xFF1B263B),
            ],
          ),
        ),
        child: Stack(
          // 使用 ClipRect 可以防止在某些设备上，屏幕外的 Widget 依然占用绘制资源
          // 这是一种优化手段
          clipBehavior: Clip.hardEdge,
          children: _clouds.map((cloud) {
            return Positioned(
              left: cloud.position.dx,
              top: cloud.position.dy,
              child: CustomPaint(
                size: Size(cloud.size, cloud.size),
                painter: CloudPainter(cloud: cloud),
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}

class CloudPainter extends CustomPainter {
  final CloudModel cloud;
  CloudPainter({required this.cloud});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = cloud.color
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, cloud.blurSigma);

    for (var offset in cloud.circleOffsets) {
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2) + offset,
        cloud.size / 2,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
