import 'package:vehicle_sim/src/vehicle.dart';

/// {@template vehicle_sim}
/// Simplified vehicle simulation.
/// {@endtemplate}
class VehicleSim {
  /// {@macro vehicle_sim}
  VehicleSim({
    required this.vehicle,
    this.engineRpm = 0,
    int gear = 1,
  })  : assert(
          gear > 0 && gear <= vehicle.transmissionRatios.length,
          'Must provide valid gear number.',
        ),
        _gear = gear;

  /// Vehicle description.
  final Vehicle vehicle;

  /// Engine rotations per minute (RPM).
  double engineRpm;

  /// Vehicle speed in miles per hour (mph).
  /// Based on https://www.public.asu.edu/~grover/willys/speed.html
  double get speed =>
      (engineRpm * vehicle.tireCircumference * minutesPerHour) /
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

  int _gear;

  /// Inches per mile. Naturally, this should never change.
  static const inchesPerMile = 63360.0;

  /// Minutes per hour. Naturally, this should never change.
  static const minutesPerHour = 60.0;
}
