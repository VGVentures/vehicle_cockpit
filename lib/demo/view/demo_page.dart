import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';
import 'package:vehicle_cockpit/l10n/l10n.dart';
import 'package:vehicle_cockpit/theme_button/theme_button.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeModeCubit(),
      child: const ThemeSelectionDemo(),
    );
  }
}

class ThemeSelectionDemo extends StatelessWidget {
  const ThemeSelectionDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, ThemeData>(
      builder: (context, themeData) {
        return Theme(
          data: themeData,
          child: const Demo(),
        );
      },
    );
  }
}

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.titleAppBarTitle),
        elevation: 2,
        actions: const [ThemeButton()],
      ),
      body: const SafeArea(
        child: SizedBox.expand(
          child: Dashboard(),
        ),
      ),
    );
  }
}
