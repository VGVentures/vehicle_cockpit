import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vehicle_cockpit/theme_button/theme_button.dart';

import '../../helpers/helpers.dart';

class MockThemeModeCubit extends MockCubit<ThemeData>
    implements ThemeModeCubit {}

void main() {
  group('ThemeButton', () {
    late ThemeModeCubit themeModeCubit;

    setUp(() {
      themeModeCubit = MockThemeModeCubit();
      when(() => themeModeCubit.state).thenReturn(darkTheme);
    });

    testWidgets('sets the new ThemeMode on tap', (tester) async {
      await tester.pumpApp(
        const ThemeButton(),
        themeModeCubit: themeModeCubit,
      );
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();
      verify(() => themeModeCubit.toggle()).called(1);
    });
  });
}
