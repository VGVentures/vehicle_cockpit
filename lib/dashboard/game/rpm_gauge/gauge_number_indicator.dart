import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';

class GaugeNumberIndicator extends TextComponent with HasGameRef<GaugeGame> {
  GaugeNumberIndicator({
    required this.stepIndex,
    super.text,
    super.position,
  }) : super(
          anchor: Anchor.center,
        );

  final int stepIndex;

  late final inactivePaint = TextPaint(
    style: TextStyle(
      fontFamily: 'Neon',
      color: gameRef.appTheme.colorScheme.onSurface.withOpacity(.8),
      fontSize: 18,
    ),
  );

  late final activePaint = TextPaint(
    style: TextStyle(
      fontFamily: 'Neon',
      color: gameRef.appTheme.colorScheme.onSurface,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
  );

  @override
  Future<void> onLoad() async {
    textRenderer = inactivePaint;
  }

  bool lit = false;

  @override
  void update(double dt) {
    final current = gameRef.gauge.progress * gameRef.gauge.maxRpm * 5;
    if (current >= stepIndex && !lit) {
      lit = true;
      textRenderer = activePaint;
    }
    if (current <= stepIndex && lit) {
      lit = false;
      textRenderer = inactivePaint;
    }
  }
}
