import 'package:dash_and_furious/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Dashboard', () {
    group('onSpeedChanged', () {
      testWidgets(
        'updates controller duration if speed is greather than zero',
        (tester) async {
          const distance = 0.222222;
          const timeInMilliseconds = (distance / 1) * 3600 * 1000;

          final controller = AnimationController(
            duration: const Duration(milliseconds: 5000),
            vsync: const TestVSync(),
          );

          await tester.pumpApp(
            Dashboard(animationController: controller),
          );

          tester
              .state<DashboardState>(find.byType(Dashboard))
              .onSpeedChanged(1);

          expect(
            controller.duration,
            Duration(
              milliseconds: timeInMilliseconds.round().abs(),
            ),
          );
        },
      );
    });
  });
}
