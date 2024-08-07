import 'package:equatable/equatable.dart';

/// {@template vehicle_sim}
/// Simplified vehicle description.
/// {@endtemplate}
final class Vehicle extends Equatable {
  /// {@macro vehicle_sim}
  Vehicle({
    required this.engineRpmRedline,
    required this.engineRpmMaximum,
    required this.engineRpmAcceleration,
    required this.engineRpmDeceleration,
    required this.engineRpmIdle,
    required this.transmissionRatios,
    required this.differentialRatio,
    required this.tireCircumference,
  })  : assert(
          transmissionRatios.isNotEmpty,
          'Must provide at least one gear ratio.',
        ),
        assert(
          transmissionRatios.keys.every((key) => key > 0),
          'Gear numbers must be positive.',
        ),
        assert(
          transmissionRatios.values.every((value) => value > 0),
          'Gear ratios must be positive.',
        ),
        assert(
          transmissionRatios.keys.fold(
                0,
                (previousElement, element) =>
                    (element == (previousElement + 1)) ? element : -1,
              ) ==
              transmissionRatios.length,
          'Keys must be consecutive starting from 1.',
        ),
        assert(differentialRatio > 0, 'Differential ratio must be positive.'),
        assert(tireCircumference > 0, 'Tire circumference must be positive.'),
        assert(
          engineRpmMaximum % 1000 == 0,
          'Engine RPM maximum must be a multiple of 1000.',
        );

  /// Maximum safe engine RPM. Engines can experience damage when they exceed
  /// their redline RPM limit and each engine model's redline RPM is different.
  final double engineRpmRedline;

  /// The highest RPM that the engine might reach that should be displayed
  /// on the tachometer. The RPM between [engineRpmRedline] and this value is
  /// the redline range that can result in engine damage.
  final double engineRpmMaximum;

  /// Approximate acceleration for how many RPM would be gained per second if
  /// the gas pedal was held all the way down.
  final double engineRpmAcceleration;

  /// Approximate deceleration for how many RPM would be lost per second if
  /// the gas pedal was released. Assumes the vehicle is in gear (not in
  /// neutral).
  final double engineRpmDeceleration;

  /// The RPM at which the engine idles when the vehicle is not moving.
  final double engineRpmIdle;

  /// Map of gear number to gear ratio.
  final Map<int, double> transmissionRatios;

  /// Differential ratio. The vehicle's differential acts as a multiplier
  /// which takes rotational speed from the transmission and multiplies it
  /// to the wheels.
  final double differentialRatio;

  /// Tire circumference in inches (in).
  final double tireCircumference;

  @override
  List<Object?> get props => [
        engineRpmRedline,
        engineRpmMaximum,
        engineRpmAcceleration,
        engineRpmDeceleration,
        engineRpmIdle,
        transmissionRatios,
        differentialRatio,
        tireCircumference,
      ];
}
