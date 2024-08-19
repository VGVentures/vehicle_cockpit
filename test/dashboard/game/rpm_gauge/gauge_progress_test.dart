// ignore_for_file: prefer_const_constructors

import 'package:flame_test/flame_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';
import 'package:vehicle_cockpit/l10n/l10n.dart';
import 'package:vehicle_cockpit/ui/ui.dart';
import 'package:vehicle_sim/vehicle_sim.dart';

void main() {
  group('GaugeProgress', () {
    late final AppLocalizations l10n;
    late VehicleSim sim;

    setUpAll(() async {
      l10n = await AppLocalizations.delegate.load(const Locale('en'));
      sim = VehicleSim(vehicle: Vehicles.compactCrossoverSUV);
    });

    testWithGame<GaugeGame>(
      'updates color when rpm is in danger zone',
      () => GaugeGame(
        sim: sim,
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

        gauge.setProgress(0.95, 1);
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
