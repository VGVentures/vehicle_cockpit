import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GaugeRing extends PositionComponent {
  GaugeRing({
    required this.color,
    super.size,
  }) : assert(size?.x == size?.y, 'x and y must be equals');
  final Color color;
  late final _paint = Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  @override
  void render(Canvas canvas) {
    canvas.drawPath(
      Path()
        ..addArc(
          size.toRect(),
          math.pi / 2,
          math.pi + math.pi / 2,
        ),
      _paint,
    );
  }
}
