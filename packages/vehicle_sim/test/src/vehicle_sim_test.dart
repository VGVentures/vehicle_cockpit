// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:vehicle_sim/src/vehicles.dart';
import 'package:vehicle_sim/vehicle_sim.dart';

void main() {
  final vehicle = Vehicles.compactCrossoverSUV;
  group('$VehicleSim', () {
    test('instantiates with defaults', () {
      final sim = VehicleSim(vehicle: vehicle);
      expect(sim.vehicle, vehicle);
      expect(sim.engineRpm, 0);
    });

    test('knows when to upshift', () {
      final sim = VehicleSim(vehicle: vehicle, engineRpm: 7000);
      expect(sim.shouldUpshift, isTrue);
    });

    test('knows when to downshift', () {
      final sim = VehicleSim(vehicle: vehicle, engineRpm: 1000, gear: 2);
      expect(sim.shouldDownshift, isTrue);
    });

    group('gear', () {
      test('gets current gear', () {
        final sim = VehicleSim(vehicle: vehicle);
        expect(sim.gear, 1);
      });

      test('sets current gear', () {
        final sim = VehicleSim(vehicle: vehicle)..gear = 2;
        expect(sim.gear, 2);
      });

      test('throws on invalid gear number', () {
        final sim = VehicleSim(vehicle: vehicle);
        expect(() => sim.gear = 0, throwsArgumentError);
        expect(
          () => sim.gear = vehicle.transmissionRatios.length + 1,
          throwsArgumentError,
        );
      });
    });

    group('gear ratio', () {
      test('gets current gear ratio', () {
        final sim = VehicleSim(vehicle: vehicle);
        expect(sim.gear, 1);
        expect(
          sim.gearRatio,
          vehicle.transmissionRatios[sim.gear],
        );
      });
    });

    group('speed', () {
      test('goes fast when engine rpm is high and gear is high', () {
        // High engine RPM in a high gear should result in unsafe speeds
        // (118 mph) — don't try this at home!
        final sim = VehicleSim(vehicle: vehicle, engineRpm: 5300, gear: 6);
        expect(sim.speed, closeTo(118, 1));
      });

      test('goes slow when engine rpm is normal and gear is low', () {
        // Normal engine RPM in a low gear should result in slow speeds (20 mph)
        final sim = VehicleSim(vehicle: vehicle, engineRpm: 3000, gear: 2);
        expect(sim.speed, closeTo(20, 1));
      });
    });

    group('simulate', () {
      test('upshifts', () {
        final sim = VehicleSim(vehicle: vehicle, engineRpm: 7000)
          ..simulate(1, 1);
        expect(sim.gear, 2);
      });

      test('downshifts', () {
        final sim = VehicleSim(vehicle: vehicle, engineRpm: 1000, gear: 2)
          ..simulate(1, 0);
        expect(sim.gear, 1);
      });
    });
  });
}
