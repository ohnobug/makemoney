import 'package:flutter/material.dart';

class LJNSendButton extends StatefulWidget {
  final VoidCallback? onAnimationCompleted;

  const LJNSendButton({super.key, this.onAnimationCompleted});

  @override
  State<LJNSendButton> createState() => _LJNSendButtonState();
}

class _LJNSendButtonState extends State<LJNSendButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  double _width = 0;


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _widthAnimation = Tween<double>(begin: 0, end: 113).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed && widget.onAnimationCompleted!= null) {
        widget.onAnimationCompleted!();
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.reverse().then((_) {
      _animationController.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _widthAnimation,
      builder: (context, child) {
        _width = _widthAnimation.value;
        return Container(
          width: _width,
          height: 60,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 76, 190, 102),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: _width >= 113
            ? const Center(
                  child: Text(
                    "发送",
                    style: TextStyle(fontSize: 27, color: Colors.white),
                  ),
                )
              : null,
        );
      },
    );
  }
}
