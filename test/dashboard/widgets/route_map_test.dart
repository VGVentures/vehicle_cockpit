import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';

void main() {
  group('RouteMapPainter', () {
    group('shouldRepaint', () {
      const color = Colors.white;

      test('returns false when nothing changes', () {
        const newDelegate = RouteMapPainter(
          animationValue: 0,
          trackColor: color,
          progressColor: color,
          primaryColor: color,
          onPrimaryColor: color,
        );
        const oldDelegate = RouteMapPainter(
          animationValue: 0,
          trackColor: color,
          progressColor: color,
          primaryColor: color,
          onPrimaryColor: color,
        );

        expect(newDelegate.shouldRepaint(oldDelegate), isFalse);
      });

      test('returns true when the animationValue changes', () {
        const newDelegate = RouteMapPainter(
          animationValue: 0,
          trackColor: color,
          progressColor: color,
          primaryColor: color,
          onPrimaryColor: color,
        );
        const oldDelegate = RouteMapPainter(
          animationValue: 0.5,
          trackColor: color,
          progressColor: color,
          primaryColor: color,
          onPrimaryColor: color,
        );

        expect(newDelegate.shouldRepaint(oldDelegate), isTrue);
      });

      test('returns true when a color changes', () {
        const otherColor = Colors.blue;

        const newDelegate = RouteMapPainter(
          animationValue: 0,
          trackColor: color,
          progressColor: color,
          primaryColor: color,
          onPrimaryColor: color,
        );
        const oldDelegate = RouteMapPainter(
          animationValue: 0,
          trackColor: otherColor,
          progressColor: otherColor,
          primaryColor: otherColor,
          onPrimaryColor: otherColor,
        );

        expect(newDelegate.shouldRepaint(oldDelegate), isTrue);
      });
    });
  });
}
