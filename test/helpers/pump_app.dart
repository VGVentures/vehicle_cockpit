// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:vehicle_cockpit/l10n/l10n.dart';
import 'package:vehicle_cockpit/theme_button/theme_button.dart';

class MockThemeModeCubit extends MockCubit<ThemeData>
    implements ThemeModeCubit {
  @override
  ThemeData get state => darkTheme;
}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    MockNavigator? navigator,
    ThemeModeCubit? themeModeCubit,
  }) {
    final fittedWidget = Scaffold(
      body: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: widget,
        ),
      ),
    );

    return pumpWidget(
      BlocProvider(
        create: (_) => themeModeCubit ?? MockThemeModeCubit(),
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: navigator != null
              ? MockNavigatorProvider(navigator: navigator, child: fittedWidget)
              : fittedWidget,
        ),
      ),
    );
  }
}
