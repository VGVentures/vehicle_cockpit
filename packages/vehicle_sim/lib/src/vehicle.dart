import 'dart:math';

import 'package:equatable/equatable.dart';

/// Gravity constant in ft/s^2.
const kGravityFtS2 = 32.174;

/// Air density at sea level in slugs/ft^3.
const kAirDensitySlugsFt3 = 0.0023769;

/// Inches per foot.
const kInchesPerFoot = 12;

/// Feet per mile.
const kFeetPerMile = 5280;

/// Seconds per hour.
const kSecondsPerHour = 3600;

/// Rolling resistance coefficient of the road.
const kRoadRollingResistanceCoefficient = 0.015;

/// {@template vehicle_sim}
/// Simplified vehicle description.
/// {@endtemplate}
final class Vehicle extends Equatable {
  /// {@macro vehicle_sim}
  Vehicle({
    required this.engineRpmRedline,
    required this.engineRpmMaximum,
    required this.engineRpmIdle,
    required this.transmissionRatios,
    required this.differentialRatio,
    required this.tireCircumference,
    required this.tireFrictionCoefficient,
    required this.dragCoefficient,
    required this.weight,
    required this.torqueCurve,
    required this.frontalArea,
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

  /// Tire radius (in feet).
  double get tireRadiusFt => tireCircumference / (2 * pi * kInchesPerFoot);

  /// Tire friction coefficient (μ) for the vehicle.
  final double tireFrictionCoefficient;

  /// Drag coefficient (Cd) for the vehicle.
  final double dragCoefficient;

  /// Weight (in lbs).
  final double weight;

  /// Torque curve in ft-lb (as a function of engine RPM). The value produced
  /// by this is always the peak torque for that RPM (as if you were holding the
  /// accelerator pedal all the way down at that RPM).
  final double Function(double engineRpm) torqueCurve;

  /// Frontal area in ft^2.
  final double frontalArea;

  /// Mass (in slugs).
  double get mass => weight / kGravityFtS2;

  @override
  List<Object?> get props => [
        engineRpmRedline,
        engineRpmMaximum,
        engineRpmIdle,
        transmissionRatios,
        differentialRatio,
        tireCircumference,
        tireFrictionCoefficient,
        dragCoefficient,
        weight,
        torqueCurve,
        frontalArea,
      ];
}
