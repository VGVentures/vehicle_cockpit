import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vehicle_cockpit/theme_button/theme_button.dart';

void main() {
  group('ThemeModeCubit', () {
    test('initial state is darkTheme', () {
      expect(ThemeModeCubit().state, darkTheme);
    });

    group('toggle', () {
      blocTest<ThemeModeCubit, ThemeData>(
        'sets ThemeMode correctly',
        build: ThemeModeCubit.new,
        act: (cubit) => cubit.toggle(),
        expect: () => [lightTheme],
      );
    });
  });
}
