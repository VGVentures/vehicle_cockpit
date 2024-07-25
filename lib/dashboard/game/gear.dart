import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';

class Gear extends PositionComponent with HasGameRef<GaugeGame> {
  Gear({
    required this.triangleSize,
    super.position,
  }) : super(size: Vector2(triangleSize, triangleSize * sqrt(3) / 2));

  final double triangleSize;

  late final _colorScheme = gameRef.appTheme.colorScheme;

  late final TextComponent gearText;

  final _path = Path();

  final _paint = Paint();

  double difference(double segmentLength) => segmentLength * sqrt(3) / 2;

  @override
  void render(Canvas canvas) {
    canvas.drawPath(
      _path,
      _paint,
    );
  }

  @override
  Future<void> onLoad() async {
    anchor = Anchor.topCenter;
    _paint.color = _colorScheme.primary;

    gearText = TextComponent(
      text: 'N',
      textRenderer: TextPaint(
        style: TextStyle(
          fontFamily: 'Neon',
          color: _colorScheme.onPrimary,
          fontSize: 20,
        ),
      ),
    );

    gearText
      ..anchor = Anchor.center
      ..position = Vector2(size.x / 2, 11 * size.y / 18);
    await add(gearText);

    _buildPath();
    size.addListener(_buildPath);
  }

  @override
  void update(double dt) {
    final speed = gameRef.speedometer.speed;
    if (speed <= 0) {
      gearText.text = 'N';
    } else if (speed <= 10) {
      gearText.text = '1';
    } else if (speed <= 15) {
      gearText.text = '2';
    } else if (speed <= 35) {
      gearText.text = '3';
    } else if (speed <= 55) {
      gearText.text = '4';
    } else if (speed <= 65) {
      gearText.text = '5';
    } else {
      gearText.text = '6';
    }
  }

  void _buildPath() {
    final dimensions = size.toRect();
    const curveOffset = 15.0;
    _path
      ..moveTo(
        0 + curveOffset / 2,
        dimensions.height - difference(curveOffset),
      )
      ..lineTo(
        (dimensions.width / 2) - curveOffset / 2,
        0 + difference(curveOffset),
      )
      ..quadraticBezierTo(
        (dimensions.width / 2),
        0,
        (dimensions.width / 2) + curveOffset / 2,
        0 + difference(curveOffset),
      )
      ..lineTo(
        dimensions.width - curveOffset / 2,
        dimensions.height - difference(curveOffset),
      )
      ..quadraticBezierTo(
        dimensions.width,
        dimensions.height,
        dimensions.width - curveOffset,
        dimensions.height,
      )
      ..lineTo(0 + curveOffset, dimensions.height)
      ..quadraticBezierTo(
        0,
        dimensions.height,
        0 + curveOffset / 2,
        dimensions.height - difference(curveOffset),
      );
  }
}
