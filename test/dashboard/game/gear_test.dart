import 'package:flame_test/flame_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';
import 'package:vehicle_cockpit/l10n/l10n.dart';
import 'package:vehicle_cockpit/ui/ui.dart';
import 'package:vehicle_sim/vehicle_sim.dart';

void main() {
  group('Gear', () {
    late AppLocalizations l10n;
    late VehicleSim sim;

    setUp(() async {
      l10n = await AppLocalizations.delegate.load(const Locale('en'));
      sim = VehicleSim(vehicle: Vehicles.compactCrossoverSUV);
    });

    group('update', () {
      testWithGame<GaugeGame>(
        'initializes',
        () => GaugeGame(
          sim: sim,
          onSpeedChanged: (_) {},
          appTheme: const AppTheme().themeData,
          l10n: l10n,
        ),
        (game) async {
          expect(game.gear, isNotNull);
        },
      );
    });
  });
}
