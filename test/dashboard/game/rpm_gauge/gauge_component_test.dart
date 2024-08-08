import 'package:flutter_test/flutter_test.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';
import 'package:vehicle_cockpit/ui/ui.dart';

void main() {
  group('GaugeComponent', () {
    test('updates progress if value is greater than 1', () {
      final gauge = GaugeComponent(
        maxRpm: 100,
        dangerZone: 80,
        appTheme: const AppTheme().themeData,
      )..setProgress(1, 1);

      expect(gauge.progress, lessThan(1));
    });
  });
}
