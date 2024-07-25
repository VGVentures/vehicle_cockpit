import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';

class Speedometer extends TextComponent with HasGameRef<GaugeGame> {
  Speedometer({
    required this.speed,
    super.position,
  }) : super(
          anchor: Anchor.center,
          text: speed.clamp(0, 160).round().toString(),
        );

  double speed;
  late final colorScheme = gameRef.appTheme.colorScheme;

  late final baseStyle = TextStyle(
    fontFamily: 'Neon',
    color: colorScheme.onSurface,
    fontSize: 70,
  );

  late final normalSpeedPaint = TextPaint(
    style: baseStyle,
  );

  late final dangerSpeedPaint = TextPaint(
    style: baseStyle.copyWith(
      color: colorScheme.error,
      fontWeight: FontWeight.w700,
    ),
  );

  late final normalSpeedLabelPaint = TextPaint(
    style: baseStyle.copyWith(
      fontWeight: FontWeight.w100,
      fontSize: 20,
    ),
  );

  late final dangerSpeedLabelPaint = TextPaint(
    style: baseStyle.copyWith(
      color: colorScheme.error,
      fontWeight: FontWeight.w100,
      fontSize: 20,
    ),
  );

  late final _mph = TextComponent(text: gameRef.l10n.mphLabel);

  @override
  Future<void> onLoad() async {
    textRenderer = normalSpeedPaint;
    _mph.anchor = Anchor.topCenter;
    await add(_mph);
  }

  @override
  void update(double dt) {
    speed = speed.clamp(0, 160);
    text = speed.round().toString();
    _mph.position = Vector2(size.x / 2, size.y);
    if (speed >= 120) {
      textRenderer = dangerSpeedPaint;
      _mph.textRenderer = dangerSpeedLabelPaint;
    } else {
      textRenderer = normalSpeedPaint;
      _mph.textRenderer = normalSpeedLabelPaint;
    }
  }
}
