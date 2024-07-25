import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';

class GaugeProgress extends PositionComponent with ParentIsA<GaugeComponent> {
  GaugeProgress({
    super.position,
    super.size,
  }) : assert(size?.x == size?.y, 'x and y must be equals');

  late final _paint = Paint()
    ..shader = ui.Gradient.sweep(
      Offset(size.x / 2, size.y / 2),
      [
        Colors.transparent,
        parent.appTheme.colorScheme.primary,
      ],
    )
    ..style = PaintingStyle.stroke
    ..strokeWidth = 18;

  final _tween = Tween<double>(
    begin: 0,
    end: math.pi + math.pi / 2,
  );

  @override
  void render(Canvas canvas) {
    canvas.drawPath(
      Path()
        ..addArc(
          size.toRect(),
          math.pi / 2,
          _tween.transform(parent.progress),
        ),
      _paint,
    );
  }

  @override
  void update(double dt) {
    final isInDanger = parent.progress * parent.maxRpm > parent.dangerZone;
    final color = isInDanger
        ? parent.appTheme.colorScheme.error
        : parent.appTheme.colorScheme.primary.withOpacity(.9);

    _paint.shader = ui.Gradient.sweep(
      Offset(size.x / 2, size.y / 2),
      [Colors.transparent, color],
      [
        (parent.progress - (1 / 4)).clamp(0, 1),
        parent.progress,
      ],
    );
  }
}
