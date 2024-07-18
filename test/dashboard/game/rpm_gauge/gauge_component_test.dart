import 'package:dash_and_furious/dashboard/dashboard.dart';
import 'package:dash_and_furious/ui/ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GaugeComponent', () {
    test('updates progress if value is greater than 1', () {
      final gauge = GaugeComponent(
        maxRpm: 100,
        dangerZone: 80,
        appTheme: const AppTheme().themeData,
      )..progress = 1;

      expect(gauge.progress, lessThan(1));
    });
  });
}
