// ignore_for_file: prefer_const_constructors

import 'package:flame_test/flame_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';
import 'package:vehicle_cockpit/l10n/l10n.dart';
import 'package:vehicle_cockpit/ui/ui.dart';

void main() {
  group('GaugeProgress', () {
    late final AppLocalizations l10n;

    setUpAll(() async {
      l10n = await AppLocalizations.delegate.load(const Locale('en'));
    });

    testWithGame<GaugeGame>(
      'updates color when rpm is in danger zone',
      () => GaugeGame(
        onSpeedChanged: (_) {},
        appTheme: AppTheme().themeData,
        l10n: l10n,
      ),
      (game) async {
        final gauge = GaugeComponent(
          maxRpm: 100,
          dangerZone: 0,
          appTheme: AppTheme().themeData,
        );

        await game.ready();
        await game.add(gauge);

        gauge.progress = 95;
        game.update(1 / 60);

        final gaugeProgress = gauge.firstChild<GaugeProgress>();

        expect(
          gaugeProgress?.color,
          equals(AppTheme().themeData.colorScheme.error),
        );
      },
    );
  });
}
