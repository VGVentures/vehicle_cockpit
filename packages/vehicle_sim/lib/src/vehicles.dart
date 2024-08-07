import 'package:vehicle_sim/src/vehicle.dart';

/// Vehicle models.
abstract class Vehicles {
  /// Vehicle model based on a typical, compact, crossover SUV.
  static final compactCrossoverSUV = Vehicle(
    engineRpmRedline: 6500,
    engineRpmMaximum: 8000,
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
  );
}
