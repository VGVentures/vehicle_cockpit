import 'dart:ui' as ui;

import 'package:dash_and_furious/dashboard/dashboard.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GaugeRpmPoint extends RectangleComponent with HasGameRef<GaugeGame> {
  GaugeRpmPoint({
    required this.stepIndex,
    required this.dangerZone,
    super.position,
    super.size,
    super.angle,
  });

  final int stepIndex;
  final bool dangerZone;

  bool lit = false;

  late final colorScheme = gameRef.appTheme.colorScheme;

  @override
  Future<void> onLoad() async {
    final currentColor = _currentColor();
    paint.shader = ui.Gradient.radial(
      Offset.zero,
      size.x,
      [
        currentColor.withOpacity(.1),
        currentColor.withOpacity(.6),
      ],
    );
  }

  @override
  void update(double dt) {
    final current = gameRef.gauge.progress * gameRef.gauge.maxRpm * 5;

    if (current >= stepIndex && !lit) {
      lit = true;
      paint.shader = ui.Gradient.radial(
        Offset.zero,
        size.x,
        [
          _currentColor().withOpacity(.4),
          _currentColor().withOpacity(1),
        ],
      );
    }
    if (current <= stepIndex && lit) {
      lit = false;
      paint.shader = ui.Gradient.radial(
        Offset.zero,
        size.x,
        [
          _currentColor().withOpacity(.1),
          _currentColor().withOpacity(.4),
        ],
      );
    }
  }

  Color _currentColor() {
    if (dangerZone) {
      return colorScheme.error;
    } else if (lit) {
      return colorScheme.primary;
    } else {
      return colorScheme.outline;
    }
  }
}
