import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CircularArchProgressBarWidget extends HookConsumerWidget {
  final double value;
  final double strokeWidth;
  final Color fillColor;
  final Color backgroundColor;

  const CircularArchProgressBarWidget({
    required this.value,
    super.key,
    this.strokeWidth = 20.0,
    this.fillColor = Colors.blue,
    this.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController(
      duration: const Duration(seconds: 2),
    )..forward();
    final Animation<double> animation =
        Tween<double>(begin: 0.0, end: (value / 2)).animate(controller);

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 162.w,
          height: 162.w,
          child: CustomPaint(
            painter: CircularArchProgressBarPainter(
              strokeWidth: strokeWidth,
              color: backgroundColor,
              value: 50,
            ),
          ),
        ),
        SizedBox(
          width: 162.w,
          height: 162.w,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return CustomPaint(
                painter: CircularArchProgressBarPainter(
                  strokeWidth: strokeWidth,
                  color: fillColor,
                  value: animation.value,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CircularArchProgressBarPainter extends CustomPainter {
  final double strokeWidth;
  final double value;
  final Color color;

  CircularArchProgressBarPainter({
    required this.strokeWidth,
    required this.value,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    const double startAngle = math.pi / 1.24;
    final double sweepAngle = 2.8 * math.pi * (value / 100);

    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
