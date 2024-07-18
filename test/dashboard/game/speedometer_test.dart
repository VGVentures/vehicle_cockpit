import 'package:dash_and_furious/dashboard/dashboard.dart';
import 'package:dash_and_furious/l10n/l10n.dart';
import 'package:dash_and_furious/ui/ui.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Speedometer', () {
    late AppLocalizations l10n;

    setUp(() async {
      l10n = await AppLocalizations.delegate.load(const Locale('en'));
    });

    group('update', () {
      testWithGame<GaugeGame>(
        'renders dangerSpeedPainter when speed is greater than or equal to 120',
        () => GaugeGame(
          onSpeedChanged: (_) {},
          appTheme: const AppTheme().themeData,
          l10n: l10n,
        ),
        (game) async {
          game.speedometer.speed = 120;
          game.speedometer.update(1);

          expect(
            game.speedometer.textRenderer,
            game.speedometer.dangerSpeedPaint,
          );
        },
      );
    });
  });
}
