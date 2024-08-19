import 'package:test/test.dart';
import 'package:vehicle_sim/src/vehicle.dart';
import 'package:vehicle_sim/src/vehicles.dart';

void main() {
  group('$Vehicle', () {
    test('equality', () {
      expect(
        Vehicle(
          engineRpmRedline: Vehicles.compactCrossoverSUV.engineRpmRedline,
          engineRpmMaximum: Vehicles.compactCrossoverSUV.engineRpmMaximum,
          engineRpmIdle: Vehicles.compactCrossoverSUV.engineRpmIdle,
          transmissionRatios: Vehicles.compactCrossoverSUV.transmissionRatios,
          differentialRatio: Vehicles.compactCrossoverSUV.differentialRatio,
          tireCircumference: Vehicles.compactCrossoverSUV.tireCircumference,
          tireFrictionCoefficient:
              Vehicles.compactCrossoverSUV.tireFrictionCoefficient,
          dragCoefficient: Vehicles.compactCrossoverSUV.dragCoefficient,
          weight: Vehicles.compactCrossoverSUV.weight,
          torqueCurve: Vehicles.compactCrossoverSUV.torqueCurve,
          frontalArea: Vehicles.compactCrossoverSUV.frontalArea,
        ),
        equals(Vehicles.compactCrossoverSUV),
      );
    });
  });
}
