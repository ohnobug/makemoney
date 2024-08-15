import 'package:flutter/material.dart';
import 'package:flutter_application_1/logger.dart';
import 'package:flutter_application_1/store.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PullDownAnimationScreen2 extends StatefulWidget {
  final StatefulWidget page;

  const PullDownAnimationScreen2({super.key, required this.page});

  @override
  State<PullDownAnimationScreen2> createState() =>
      _PullDownAnimationScreen2State();
}

class _PullDownAnimationScreen2State extends State<PullDownAnimationScreen2>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late Animation<double> _animation1;
  late Tween<double> _tween1;

  late AnimationController _controller2;
  late Animation<double> _animation2;
  late Tween<double> _tween2;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _tween1 = Tween<double>(begin: 0.0, end: 0.0);
    _animation1 = _tween1.animate(_controller1);

    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _tween2 = Tween<double>(begin: 0.0, end: 0.0);
    _animation2 = _tween2.animate(_controller2);
  }

  double offsetY1 = 0;
  double offsetY2 = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    _tween1.begin = -screenSize.height;
    _tween1.end = -screenSize.height * (1 / 5);

    _tween2.begin = 0;
    _tween2.end = screenSize.height * (4 / 5);

    double leiji1 = 0;
    // double leiji2 = 0;

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, state) {
          leiji1 += state.homeoffset!;
          _controller1.value +=
              state.homeoffset! / (screenSize.height * (4 / 5));
          _controller2.value +=
              state.homeoffset! / (screenSize.height * (4 / 5));

          if (state.homescrollverticaltapstatus == "ontapup") {
            if (leiji1 > 0 && _controller2.value > 0.3) {
              _controller1.forward();
              _controller2.forward();
            } else {
              _controller1.reverse();
              _controller2.reverse();
            }

            leiji1 = 0;
          }

          return Container(
            padding: EdgeInsets.only(top: 45.w),
            child: Stack(children: [
              AnimatedBuilder(
                  animation: _controller1,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _animation1.value),
                      child: GestureDetector(
                          onPanUpdate: (detail) {
                            leiji1 += detail.delta.dy;

                            _controller1.value +=
                                detail.delta.dy / screenSize.height;
                            _controller2.value +=
                                detail.delta.dy / screenSize.height;
                          },
                          onPanEnd: (details) {
                            logger.info(leiji1);
                            logger.info(_controller1.value);

                            // 向上滑
                            if (leiji1 < 0 && _controller1.value <= 1) {
                              _controller1.reverse();
                              _controller2.reverse();
                            } else {
                              _controller1.forward();
                              _controller2.forward();
                            }

                            // 向下滑
                            if (leiji1 > 0 && _controller1.value >= 0.05) {
                              _controller1.forward();
                              _controller2.forward();
                            } else {
                              _controller1.reverse();
                              _controller2.reverse();
                            }

                            leiji1 = 0;
                          },
                          child: Container(
                            width: screenSize.width,
                            height: screenSize.height,
                            color: Colors.green,
                          )),
                    );
                  }),
              AnimatedBuilder(
                  animation: _controller2,
                  builder: (context, child) {
                    return Transform.translate(
                        offset: Offset(0, _animation2.value), child: widget.page
                        // GestureDetector(
                        //   onPanUpdate: (detail) {
                        //     leiji2 += detail.delta.dy;

                        //     _controller1.value +=
                        //         detail.delta.dy / screenSize.height;
                        //     _controller2.value +=
                        //         detail.delta.dy / screenSize.height;
                        //   },
                        //   onPanEnd: (details) {
                        //     logger.info(_controller2.value);

                        //     if (leiji2 > 0 && _controller2.value > 0.1) {
                        //       _controller1.forward();
                        //       _controller2.forward();
                        //     } else {
                        //       _controller1.reverse();
                        //       _controller2.reverse();
                        //     }

                        //     if (leiji2 < 0 && _controller2.value <= 0.9) {
                        //       _controller1.reverse();
                        //       _controller2.reverse();
                        //     } else {
                        //       _controller1.forward();
                        //       _controller2.forward();
                        //     }

                        //     leiji2 = 0;
                        //   },
                        //   // child: Container(
                        //   //   color: Colors.red,
                        //   // )
                        //   child: widget.page,
                        // ),
                        );
                  })
            ]),
          );
        });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
}

extension on int {
  get w => null;
}
