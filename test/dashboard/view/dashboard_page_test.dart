import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Dashboard', () {
    group('onSpeedChanged', () {
      testWidgets(
        'updates controller duration if speed is greater than zero',
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

    testWidgets(
      'shows an accelerator button if platform is mobile',
      (tester) async {
        await tester.pumpApp(
          Theme(
            data: ThemeData().copyWith(platform: TargetPlatform.iOS),
            child: const Dashboard(),
          ),
        );

        expect(find.byType(AcceleratorButton), findsOneWidget);
        expect(find.text(tester.l10n.instructions), findsNothing);
      },
    );

    testWidgets(
      'shows instructions if platform is not mobile',
      (tester) async {
        await tester.pumpApp(
          Theme(
            data: ThemeData().copyWith(platform: TargetPlatform.macOS),
            child: const Dashboard(),
          ),
        );

        expect(find.byType(AcceleratorButton), findsNothing);
        expect(find.text(tester.l10n.instructions), findsOneWidget);
      },
    );

    testWidgets(
      'pressing and releasing space key updates the game',
      (tester) async {
        await tester.pumpApp(
          Theme(
            data: ThemeData().copyWith(platform: TargetPlatform.macOS),
            child: const Dashboard(),
          ),
        );
        await tester.pump();

        final game = tester
            .widget<GameWidget<GaugeGame>>(find.byType(GameWidget<GaugeGame>))
            .game!;

        await tester.sendKeyDownEvent(LogicalKeyboardKey.space);
        await tester.pump();
        expect(game.hittingGas, isTrue);

        // Allows the game to run for a while
        for (var i = 0; i < 120; i++) {
          await tester.pump();
        }

        await tester.sendKeyUpEvent(LogicalKeyboardKey.space);
        await tester.pump();

        expect(game.hittingGas, isFalse);
      },
    );
  });
}
