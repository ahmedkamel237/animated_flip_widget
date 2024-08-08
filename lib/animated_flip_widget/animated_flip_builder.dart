import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedPageFlipBuilder extends StatelessWidget {
  final Animation<double> animation;
  final bool showFrontSide;
  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;

  const AnimatedPageFlipBuilder(
      {super.key,
        required this.animation,
        required this.showFrontSide,
        required this.frontBuilder,
        required this.backBuilder,
      });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final isAnimatedFirstHalf = animation.value.abs() < 0.5;
        final child =
        isAnimatedFirstHalf ? frontBuilder(context) : backBuilder(context);
        final rotationValue = animation.value * pi;
        final rotationAngle =
        animation.value > 0.5 ? pi - rotationValue : -rotationValue;
        var tilt = (animation.value - 0.5).abs() - 0.5;
        tilt *= isAnimatedFirstHalf ? -0.003 : 0.003;
        return Transform(
          transform: Matrix4.rotationY(rotationAngle)..setEntry(3, 0, tilt),
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}
