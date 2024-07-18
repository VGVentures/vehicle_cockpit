import 'package:dash_and_furious/dashboard/dashboard.dart';
import 'package:dash_and_furious/l10n/l10n.dart';
import 'package:dash_and_furious/ui/ui.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockKeyDownEvent extends Mock implements KeyDownEvent {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

void main() {
  group('GaugeGame', () {
    late AppLocalizations l10n;

    setUp(() async {
      l10n = await AppLocalizations.delegate.load(const Locale('en'));
    });

    group('onKeyEvent', () {
      testWithGame<GaugeGame>(
        'sets hittingGas to true when space is pressed and '
        'false if space is not pressed',
        () => GaugeGame(
          onSpeedChanged: (_) {},
          appTheme: const AppTheme().themeData,
          l10n: l10n,
        ),
        (game) async {
          game.onKeyEvent(
            _MockKeyDownEvent(),
            {LogicalKeyboardKey.space},
          );

          expect(game.hittingGas, isTrue);

          game.onKeyEvent(
            _MockKeyDownEvent(),
            {LogicalKeyboardKey.add},
          );

          expect(game.hittingGas, isFalse);
        },
      );
    });

    group('update', () {
      testWithGame<GaugeGame>(
        'updates gauge and speedometer when hittingGas is true',
        () => GaugeGame(
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
