import 'package:test/test.dart';
import 'package:vehicle_sim/src/vehicle.dart';
import 'package:vehicle_sim/src/vehicles.dart';

void main() {
  group('$Vehicle', () {
    test('equality', () {
      expect(
        Vehicle(
          engineRpmRedline: 6500,
          engineRpmMaximum: 8000,
          engineRpmAcceleration: 2000,
          engineRpmDeceleration: 1500,
          engineRpmIdle: 800,
          transmissionRatios: const {
            1: 4.69,
            2: 3.31,
            3: 3.01,
            4: 1.92,
            5: 1.45,
            6: 1,
            7: 0.75,
            8: 0.62,
          },
          differentialRatio: 3.81,
          tireCircumference: 90,
        ),
        equals(Vehicles.compactCrossoverSUV),
      );
    });
  });
}
