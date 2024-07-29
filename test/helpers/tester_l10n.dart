import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vehicle_cockpit/l10n/l10n.dart';

extension TesterL10n on WidgetTester {
  AppLocalizations get l10n {
    final app = widget<MaterialApp>(find.byType(MaterialApp).first);

    final locale = app.locale ?? app.supportedLocales.first;

    return lookupAppLocalizations(locale);
  }
}
