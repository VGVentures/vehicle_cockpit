import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';

class GaugeRpmNumbers extends PositionComponent with ParentIsA<GaugeComponent> {
  GaugeRpmNumbers({
    super.position,
    super.size,
  }) : assert(size?.x == size?.y, 'x and y must be equals');

  @override
  Future<void> onLoad() async {
    const totalAngle = math.pi + math.pi / 2;

    final points = parent.maxRpm * 5;
    final step = totalAngle / points;

    for (var i = 0; i <= points; i++) {
      final stepAngle = math.pi - (i * step);
      final isMajor = i % 5 == 0;

      final pointVector = Vector2(
        math.cos(stepAngle),
        math.sin(stepAngle),
      );

      final pointPosition =
          (size / 2) - (pointVector.clone()..multiply(size / 2));

      final invertedIndex = points - i;

      await add(
        GaugeRpmPoint(
          angle: stepAngle,
          position: pointPosition,
          size: Vector2(isMajor ? 20 : 10, 4),
          stepIndex: invertedIndex,
          dangerZone: i <= parent.dangerZone - 1,
        ),
      );

      if (isMajor) {
        await add(
          GaugeNumberIndicator(
            position: (size / 2) -
                (pointVector.clone()
                  ..multiply(
                    (size / 2) - Vector2(50, 50),
                  )),
            text: (invertedIndex ~/ 5).toString(),
            stepIndex: invertedIndex,
          ),
        );
      }
    }
  }
}
