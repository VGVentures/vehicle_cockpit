import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';
import 'package:vehicle_cockpit/l10n/l10n.dart';
import 'package:vehicle_cockpit/ui/ui.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GaugeGame', () {
    late AppLocalizations l10n;
    late MockVehicleSim sim;

    setUp(() async {
      sim = MockVehicleSim();
      l10n = await AppLocalizations.delegate.load(const Locale('en'));
    });

    group('accelerate', () {
      testWithGame<GaugeGame>(
        'sets hittingGas to true',
        () => GaugeGame(
          sim: sim,
          onSpeedChanged: (_) {},
          appTheme: const AppTheme().themeData,
          l10n: l10n,
        ),
        (game) async {
          game.acceleratorPedalPushed();

          expect(game.hittingGas, isTrue);
        },
      );
    });

    group('release', () {
      testWithGame<GaugeGame>(
        'sets hittingGas to false',
        () => GaugeGame(
          sim: sim,
          onSpeedChanged: (_) {},
          appTheme: const AppTheme().themeData,
          l10n: l10n,
        ),
        (game) async {
          game.acceleratorPedalReleased();

          expect(game.hittingGas, isFalse);
        },
      );
    });

    group('onKeyEvent', () {
      testWithGame<GaugeGame>(
        'sets hittingGas to true when space is pressed and '
        'false if space is not pressed',
        () => GaugeGame(
          sim: sim,
          onSpeedChanged: (_) {},
          appTheme: const AppTheme().themeData,
          l10n: l10n,
        ),
        (game) async {
          game.onKeyEvent(
            FakeInput.keyDown(LogicalKeyboardKey.space),
            {LogicalKeyboardKey.space},
          );

          expect(game.hittingGas, isTrue);

          game.onKeyEvent(
            FakeInput.keyUp(LogicalKeyboardKey.space),
            {},
          );

          expect(game.hittingGas, isFalse);
        },
      );
    });

    group('update', () {
      testWithGame<GaugeGame>(
        'updates gauge and speedometer when hittingGas is true',
        () => GaugeGame(
          sim: sim,
          onSpeedChanged: (_) {},
          appTheme: const AppTheme().themeData,
          l10n: l10n,
        ),
        (game) async {
          game
            ..hittingGas = true
            ..update(1);

          expect(game.gauge.progress, isPositive);
          expect(game.speedometer.speed, isPositive);
        },
      );
    });
  });
}
