import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';
import 'package:vehicle_cockpit/l10n/l10n.dart';
import 'package:vehicle_sim/vehicle_sim.dart';

class GaugeGame extends FlameGame with KeyboardEvents {
  GaugeGame({
    required this.sim,
    required this.onSpeedChanged,
    required this.appTheme,
    required this.l10n,
  });

  final VehicleSim sim;
  final ThemeData appTheme;
  final AppLocalizations l10n;
  final ValueChanged<double> onSpeedChanged;
  late final GaugeComponent gauge;
  late final Gear gear;
  late final Speedometer speedometer;

  bool hittingGas = false;

  @override
  Color backgroundColor() => Colors.transparent;

  void acceleratorPedalPushed() => hittingGas = true;

  void acceleratorPedalReleased() => hittingGas = false;

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isPressed = event is KeyDownEvent || event is KeyRepeatEvent;
    final wasReleased = event is KeyUpEvent;

    if (event.logicalKey != LogicalKeyboardKey.space ||
        (!isPressed && !wasReleased)) {
      return KeyEventResult.ignored;
    }

    if (isPressed) {
      acceleratorPedalPushed();
    } else {
      acceleratorPedalReleased();
    }

    return KeyEventResult.handled;
  }

  @override
  Future<void> onLoad() async {
    await add(
      gauge = GaugeComponent(
        size: Vector2.all(340),
        position: size / 2,
        maxRpm: (sim.vehicle.engineRpmMaximum / 1000).round(),
        dangerZone: (sim.vehicle.engineRpmRedline / 1000).round(),
        appTheme: appTheme,
      ),
    );

    await add(
      speedometer = Speedometer(
        speed: 0,
        position: size / 2 - Vector2(0, 40),
      ),
    );

    await add(
      gear = Gear(
        position: size / 2 + Vector2(0, 30),
        triangleSize: 60,
      ),
    );
  }

  @override
  void update(double dt) {
    sim.simulate(dt, hittingGas ? 1.0 : 0.0);

    gauge.progress = sim.engineRpm / sim.vehicle.engineRpmMaximum;
    speedometer.speed = sim.speed;
    gear.gearText.text = sim.gear.toString();

    print('gear: ${sim.gear} - speed: ${sim.speed} - rpm: ${sim.engineRpm}');

    onSpeedChanged(sim.speed);

    super.update(dt);
  }
}
