import 'package:dash_and_furious/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension TesterL10n on WidgetTester {
  AppLocalizations get l10n {
    final app = widget<MaterialApp>(find.byType(MaterialApp).first);

    final locale = app.locale ?? app.supportedLocales.first;

    return lookupAppLocalizations(locale);
  }
}
