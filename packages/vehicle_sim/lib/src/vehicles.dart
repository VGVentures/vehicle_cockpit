import 'dart:math';

import 'package:vehicle_sim/src/vehicle.dart';

/// Vehicle models.
abstract class Vehicles {
  /// Vehicle description based on a typical, compact, crossover SUV and a lot
  /// of guesswork.
  static final compactCrossoverSUV = Vehicle(
    engineRpmRedline: 6500,
    engineRpmMaximum: 8000,
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
    tireFrictionCoefficient: 0.65,
    dragCoefficient: 0.35,
    weight: 3500,
    // See included /utils/engine_torque_curve.ipynb for how this curve was
    // determined.
    //
    //     +------------------------------------------------------------+
    //     |                      tt                                    |
    //     |                 tttttttttttttttttttttt                     |
    // 180--              ttt                      ttttttt              |
    //     |           ttt                               ttttt          |
    // 160--          t                                       ttt       |
    //     |        tt                                           tt     |
    // 140--       tt                                              tt   |
    //     |      t                                                     |
    // 120--     t                                                      |
    //     |    t                                                       |
    // 100--   t                                                        |
    //     |                                                            |
    //     +---|--------|---------|---------|---------|--------|--------+
    //      1000     2000      3000      4000      5000     6000
    torqueCurve: (engineRpm) =>
        -6.087e-13 * pow(engineRpm, 4) +
        (1.069e-08 * pow(engineRpm, 3)) -
        (7.36e-05 * pow(engineRpm, 2)) +
        (0.2249 * engineRpm) -
        63.42,
    frontalArea: 30.03131,
  );
}
