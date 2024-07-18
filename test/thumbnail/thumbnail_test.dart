import 'package:dash_and_furious/dashboard/dashboard.dart';
import 'package:dash_and_furious/thumbnail/thumbnail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  group('Thumbnail', () {
    testWidgets('renders the LapViewer with RouteMap', (tester) async {
      await tester.pumpApp(const Thumbnail());
      expect(find.byType(LapViewer), findsOneWidget);
      expect(find.byType(RouteMap), findsOneWidget);
    });
  });
}
