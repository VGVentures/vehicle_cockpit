import 'package:dash_and_furious/dashboard/dashboard.dart';
import 'package:dash_and_furious/demo/demo.dart';
import 'package:dash_and_furious/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
