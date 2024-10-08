import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';

import '../../helpers/helpers.dart';

class _MockGaugeGame extends Mock implements GaugeGame {}

void main() {
  group('AcceleratorButton', () {
    late GaugeGame game;

    setUp(() {
      game = _MockGaugeGame();
    });

    testWidgets(
      'calls accelerate on tap down',
      (tester) async {
        await tester.pumpApp(
          AcceleratorButton(game: game),
        );
        await tester.tap(find.byType(AcceleratorButton));

        verify(() => game.acceleratorPedalPushed()).called(1);
      },
    );

    testWidgets(
      'calls release on tap up',
      (tester) async {
        await tester.pumpApp(
          AcceleratorButton(game: game),
        );
        await tester.tap(find.byType(AcceleratorButton));

        verify(() => game.acceleratorPedalReleased()).called(1);
      },
    );
  });
}
