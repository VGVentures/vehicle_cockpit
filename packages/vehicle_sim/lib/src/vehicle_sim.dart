import 'dart:math';

import 'package:vehicle_sim/src/vehicle.dart';

/// {@template vehicle_sim}
/// Simplified vehicle simulation.
/// {@endtemplate}
class VehicleSim {
  /// {@macro vehicle_sim}
  VehicleSim({
    required this.vehicle,
    double engineRpm = 0,
    int gear = 1,
  })  : assert(
          gear > 0 && gear <= vehicle.transmissionRatios.length,
          'Must provide valid gear number.',
        ),
        assert(
          engineRpm >= 0 && engineRpm <= vehicle.engineRpmMaximum,
          'Engine RPM must be between 0 and the maximum.',
        ),
        _engineRpm = engineRpm,
        _gear = gear;

  /// Vehicle description.
  final Vehicle vehicle;

  /// Engine rotations per minute (RPM).
  double get engineRpm => _engineRpm;

  /// Vehicle speed in miles per hour (mph).
  /// Based on https://www.public.asu.edu/~grover/willys/speed.html
  double get speed =>
      (_engineRpm * vehicle.tireCircumference * minutesPerHour) /
      (inchesPerMile * gearRatio * vehicle.differentialRatio);

  /// Current gear number (starts at 1).
  int get gear => _gear;

  set gear(int value) {
    if (value < 1 || value > vehicle.transmissionRatios.length) {
      throw ArgumentError('Invalid gear number');
    }

    _gear = value;
  }

  /// Gear ratio of the current gear.
  double get gearRatio => vehicle.transmissionRatios[gear]!;

  /// Whether the vehicle should upshift.
  bool get shouldUpshift =>
      _engineRpm > (vehicle.engineRpmRedline * upshiftTolerance) &&
      gear < vehicle.transmissionRatios.length;

  /// Whether the vehicle should downshift.
  bool get shouldDownshift =>
      _engineRpm < (vehicle.engineRpmRedline * downshiftTolerance) && gear > 1;

  int _gear;
  double _engineRpm;

  /// Inches per mile. Naturally, this should never change.
  static const inchesPerMile = 63360.0;

  /// Minutes per hour. Naturally, this should never change.
  static const minutesPerHour = 60.0;

  /// The percentage of the redline RPM at which the vehicle should upshift.
  static const upshiftTolerance = 0.9;

  /// The percentage of the redline RPM at which the vehicle should downshift.
  static const downshiftTolerance = 0.3;

  /// Simulate the vehicle for a given time [delta] (in seconds).
  /// Note that [acceleratorPedal] is a percentage, where 0
  /// represents no fuel being applied and 1 represents full throttle.
  ///
  /// When finished, the [engineRpm] will be updated based on the vehicle's
  /// acceleration or deceleration, and the [gear] may be adjusted based on the
  /// current RPM and upshift/downshift threshold.
  void simulate(double delta, double acceleratorPedal) {
    // Figure out how much torque should be added to the engine.
    final engineTorque = vehicle.torqueCurve(_engineRpm) * acceleratorPedal;
    final wheelTorque = engineTorque * gearRatio * vehicle.differentialRatio;
    final wheelForce = wheelTorque / vehicle.tireRadiusFt;
    final maxTractionForce = vehicle.tireFrictionCoefficient * vehicle.weight;
    final appliedForce = min(wheelForce, maxTractionForce);
    final speedFtPerSecond = speed * kFeetPerMile / kSecondsPerHour;
    final dragForce = 0.5 *
        kAirDensitySlugsFt3 *
        vehicle.dragCoefficient *
        vehicle.frontalArea *
        pow(speedFtPerSecond, 2);

    final rollingResistanceForce =
        kRoadRollingResistanceCoefficient * vehicle.weight;

    final netForce = appliedForce - dragForce - rollingResistanceForce;

    final acceleration = netForce / vehicle.mass;

    final newSpeedFtPerSecond = speedFtPerSecond + acceleration * delta;
    final newSpeedMph = newSpeedFtPerSecond * kSecondsPerHour / kFeetPerMile;
    _engineRpm = computeEngineRpmFromSpeed(newSpeedMph);

    // Clamp engine RPM between idle and maximum.
    _engineRpm =
        _engineRpm.clamp(vehicle.engineRpmIdle, vehicle.engineRpmMaximum);

    // Automatic transmission and engine RPM adjustment based on gear.

    if (shouldUpshift) {
      gear++;
      _engineRpm = computeEngineRpmFromSpeed(newSpeedMph);
    }

    if (shouldDownshift) {
      gear--;
      _engineRpm = computeEngineRpmFromSpeed(newSpeedMph);
    }
  }

  /// Computes engine RPM based on the vehicle's speed (in mph).
  double computeEngineRpmFromSpeed(double speed) =>
      // Similar to the speed computation above, but solved for engine RPM.
      (speed * inchesPerMile * gearRatio * vehicle.differentialRatio) /
      (vehicle.tireCircumference * minutesPerHour);
}
