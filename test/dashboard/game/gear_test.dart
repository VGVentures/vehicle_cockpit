import 'package:flame_test/flame_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';
import 'package:vehicle_cockpit/l10n/l10n.dart';
import 'package:vehicle_cockpit/ui/ui.dart';

void main() {
  group('Gear', () {
    late AppLocalizations l10n;

    setUp(() async {
      l10n = await AppLocalizations.delegate.load(const Locale('en'));
    });

    group('update', () {
      testWithGame<GaugeGame>(
        'gearText updates correctly as speed increases',
        () => GaugeGame(
          onSpeedChanged: (_) {},
          appTheme: const AppTheme().themeData,
          l10n: l10n,
        ),
        (game) async {
          final values = <double, String>{
            0: 'N',
            10: '1',
            15: '2',
            35: '3',
            55: '4',
            65: '5',
            80: '6',
          };

          for (final value in values.entries) {
            game.speedometer.speed = value.key;
            game.update(0);
            expect(game.gear.gearText.text, value.value);
          }
        },
      );
    });
  });
}
