import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:video_player/video_player.dart';

/// Camera example home widget.
class LJNCameraViewPage extends StatefulWidget {
  /// Default Constructor
  const LJNCameraViewPage({super.key});

  @override
  State<LJNCameraViewPage> createState() {
    return _LJNCameraViewPageState();
  }
}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  // This enum is from a different package, so a new value could be added at
  // any time. The example should keep working if that happens.
  // ignore: dead_code
  return Icons.camera;
}

class _LJNCameraViewPageState extends State<LJNCameraViewPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  XFile? imageFile;
  XFile? videoFile;
  VideoPlayerController? videoController;
  VoidCallback? videoPlayerListener;
  bool enableAudio = false;

  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;

  double minAvailableExposureOffset = 0;
  double maxAvailableExposureOffset = 0;

  // Counting pointers (number of user fingers on screen)
  int _pointers = 0;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _initCamera();
  }

  Future<void> _initCamera() async {
    cameras = await availableCameras();
    onNewCameraSelected(cameras[0]);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // #docregion AppLifecycle
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController(cameraController.description);
    }
  }
  // #enddocregion AppLifecycle

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return Container(
        // margin: EdgeInsets.all(10),
        // color: Colors.yellow,
        child: _cameraPreviewWidget(),
      );
    });
  }

  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: AppColors.neutralWhite,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Listener(
        onPointerDown: (_) => _pointers++,
        onPointerUp: (_) => _pointers--,
        child: OrientationBuilder(
          builder: (context, orientation) {
            final turn = orientation == Orientation.landscape ? 2 : 1;

            return ClipRect(
              child: Transform.scale(
                scale: 1,
                child: Center(
                  child: RotatedBox(
                    quarterTurns: turn,
                    child: AspectRatio(
                      aspectRatio: cameraController.value.aspectRatio,
                      child: CameraPreview(
                        controller!,
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onScaleStart: _handleScaleStart,
                              onScaleUpdate: _handleScaleUpdate,
                              // 点击对焦
                              onTapDown: (TapDownDetails details) =>
                                  onViewFinderTap(details, constraints),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (controller == null || _pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await controller!.setZoomLevel(_currentScale);
  }

  // 底部提示
  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // 点击对焦
  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final CameraController cameraController = controller!;

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      return controller!.setDescription(cameraDescription);
    } else {
      return _initializeCameraController(cameraDescription);
    }
  }

  Future<void> _initializeCameraController(
      CameraDescription cameraDescription) async {
    final CameraController cameraController = CameraController(
      cameraDescription,
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.high,
      enableAudio: enableAudio,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        showInSnackBar(
            'Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
      await Future.wait(<Future<Object?>>[
        // The exposure mode is currently not supported on the web.
        ...!kIsWeb
            ? <Future<Object?>>[
                cameraController
                    .getMinExposureOffset()
                    .then((double value) => minAvailableExposureOffset = value),
                cameraController
                    .getMaxExposureOffset()
                    .then((double value) => maxAvailableExposureOffset = value)
              ]
            : <Future<Object?>>[],
        cameraController
            .getMaxZoomLevel()
            .then((double value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((double value) => _minAvailableZoom = value),
      ]);

      // 自动曝光度
      cameraController.setExposureMode(ExposureMode.auto);

      // 自动对焦
      cameraController.setFocusMode(FocusMode.auto);

      // 默认放大等级
      cameraController.setZoomLevel(_minAvailableZoom);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          logger.info('You have denied camera access.');
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          logger.info('Please go to Settings app to enable camera access.');
        case 'CameraAccessRestricted':
          // iOS only
          logger.info('Camera access is restricted.');
        case 'AudioAccessDenied':
          logger.info('You have denied audio access.');
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          logger.info('Please go to Settings app to enable audio access.');
        case 'AudioAccessRestricted':
          // iOS only
          logger.info('Audio access is restricted.');
        default:
          logger.info(
            e.toString(),
          );
          break;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }
}
