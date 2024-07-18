import 'package:dash_and_furious/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);
  group('Lap Section', () {
    Widget buildSubject({required AnimationController controller}) {
      return SizedBox(
        height: 400,
        width: 1000,
        child: LapSection(
          controller: controller,
        ),
      );
    }

    testWidgets('renders LapSection', (tester) async {
      final controller = AnimationController(
        vsync: const TestVSync(),
      );

      await tester.pumpApp(
        buildSubject(controller: controller),
      );

      await tester.pump(const Duration(milliseconds: 200));

      expect(find.byType(RouteMap), findsOneWidget);
      expect(find.byType(Lap), findsNWidgets(2));

      expect(find.textContaining('00:00.00'), findsAtLeastNWidgets(1));
      controller.dispose();
    });

    group('newLap', () {
      testWidgets('updates current lap', (tester) async {
        final controller = AnimationController(
          duration: const Duration(seconds: 1),
          vsync: const TestVSync(),
        );

        await tester.pumpApp(buildSubject(controller: controller));

        final state = tester.state<LapSectionState>(find.byType(LapSection));

        expect(state.currentLap, 1);

        controller.value = 1;
        state.newLap(controller.status);

        expect(state.currentLap, 2);

        controller.dispose();
      });
    });

    group('setLapTime', () {
      testWidgets('returns a Duration', (tester) async {
        final controller = AnimationController(
          vsync: const TestVSync(),
        );

        await tester.pumpApp(buildSubject(controller: controller));

        final state = tester.state<LapSectionState>(find.byType(LapSection));

        expect(
          state.setLapTime(),
          isA<Duration>(),
        );
      });
    });
  });
}
