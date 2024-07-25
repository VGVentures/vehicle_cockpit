import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';
import 'package:vehicle_cockpit/demo/demo.dart';
import 'package:vehicle_cockpit/l10n/l10n.dart';

void main() {
  group('DemoPage', () {
    testWidgets('renders the Dashboard', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DemoPage(),
        ),
      );
      expect(find.byType(Dashboard), findsOneWidget);
    });
  });
}
