import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';

class GaugeComponent extends PositionComponent {
  GaugeComponent({
    required this.maxRpm,
    required this.dangerZone,
    required this.appTheme,
    super.size,
    super.position,
  })  : assert(dangerZone < maxRpm, ''),
        super(anchor: Anchor.center);

  final int maxRpm;
  final int dangerZone;
  final ThemeData appTheme;
  double _progress = 0;

  final _rng = math.Random();

  double get progress => _progress;

  set progress(double value) {
    if (value < 0) {
      _progress = 0;
    } else if (value >= 1) {
      _progress = 1 - _rng.nextDouble() * 0.02;
    } else {
      _progress = value;
    }
  }

  @override
  Future<void> onLoad() async {
    await add(
      GaugeRing(
        size: size.clone(),
        color: appTheme.colorScheme.error,
      ),
    );

    const offset = 16.0;
    final innerRingPosition = Vector2.all(offset / 2);
    final innerRingSize = size.clone() - Vector2.all(offset);
    await add(
      GaugeProgress(
        position: innerRingPosition,
        size: innerRingSize,
      ),
    );
    await add(
      GaugeRpmNumbers(
        position: innerRingPosition,
        size: innerRingSize,
      ),
    );
  }
}
