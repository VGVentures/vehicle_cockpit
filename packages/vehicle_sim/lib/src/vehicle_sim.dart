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
  /// Note that [acceleratorPedal] is a percentage between 0 and 1, where 0
  /// represents no fuel being applied and 1 represents full throttle.
  ///
  /// When finished, the [engineRpm] will be updated based on the vehicle's
  /// acceleration or deceleration, and the [gear] may be adjusted based on the
  /// current RPM and upshift/downshift threshold.
  void simulate(double delta, double acceleratorPedal) {
    assert(
      acceleratorPedal >= 0 && acceleratorPedal <= 1,
      'Accelerator pedal value must be between 0 and 1.',
    );

    // Automatic transmission and engine RPM adjustment based on gear.

    // important: capture speed based on current gear and RPM before any
    // potential gear change. This allows us to correctly compute the new engine
    // RPM after changing gears.
    final speed = this.speed;

    if (shouldUpshift) {
      gear++;
      _engineRpm = computeEngineRpmFromSpeed(speed);
    }

    if (shouldDownshift) {
      gear--;
      _engineRpm = computeEngineRpmFromSpeed(speed);
    }

    final engineRpmChange = delta *
        (acceleratorPedal > 0
            ? vehicle.engineRpmAcceleration
            : -vehicle.engineRpmDeceleration);

    _engineRpm += engineRpmChange;

    // Clamp engine RPM between idle and maximum.
    if (_engineRpm < vehicle.engineRpmIdle) {
      _engineRpm = vehicle.engineRpmIdle;
    } else if (_engineRpm > vehicle.engineRpmMaximum) {
      _engineRpm = vehicle.engineRpmMaximum;
    }
  }

  /// Computes engine RPM based on the vehicle's speed (in mph).
  double computeEngineRpmFromSpeed(double speed) =>
      // Similar to the speed computation above, but solved for engine RPM.
      (speed * inchesPerMile * gearRatio * vehicle.differentialRatio) /
      (vehicle.tireCircumference * minutesPerHour);
}
