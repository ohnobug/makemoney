import 'package:flutter/material.dart';
import 'dart:math';

class VigaLoadingIndicator extends StatefulWidget {
  final double fontSize;

  const VigaLoadingIndicator({
    super.key,
    this.fontSize = 18.0, // Font size reduced
  });

  @override
  State<VigaLoadingIndicator> createState() => _VigaLoadingIndicatorState();
}

class _VigaLoadingIndicatorState extends State<VigaLoadingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _sweepController;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    _sweepController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _sweepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sweepController,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            final sweepValue = _sweepController.value;
            final slidePosition = (sweepValue * 3.0) - 1.5;

            return LinearGradient(
              colors: const [
                Color(0xFF6A11CB), // Purple
                Color(0xFFD81B60), // Magenta
                Color(0xFFF47C2E), // Orange
                Color(0xFFD81B60), // Magenta
                Color(0xFF6A11CB), // Purple
              ],
              stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
              begin: Alignment(slidePosition - 1, 0.0),
              end: Alignment(slidePosition + 1, 0.0),
              tileMode: TileMode.clamp,
            ).createShader(bounds);
          },
          child: SizedBox(
            height: widget.fontSize * 1.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _AnimatedLetter('V', 0.0, _bounceController, widget.fontSize),
                const SizedBox(width: 1),
                _AnimatedLetter('i', 0.1, _bounceController, widget.fontSize),
                const SizedBox(width: 1),
                _AnimatedLetter('g', 0.2, _bounceController, widget.fontSize),
                const SizedBox(width: 1),
                _AnimatedLetter('a', 0.3, _bounceController, widget.fontSize),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AnimatedLetter extends StatelessWidget {
  final String letter;
  final double delay;
  final Animation<double> controller;
  final double fontSize;

  const _AnimatedLetter(
    this.letter,
    this.delay,
    this.controller,
    this.fontSize,
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final double value = (controller.value - delay).abs();
        final double sineValue = sin(value * pi);
        final double yOffset = -sineValue * fontSize * 0.5;

        return Transform.translate(
          offset: Offset(0, yOffset),
          child: Text(
            letter,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              color: Colors.white, // Placeholder color
            ),
          ),
        );
      },
    );
  }
}