import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_cockpit/theme_button/theme_button.dart';
import 'package:vehicle_cockpit/ui/ui.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeModeCubit>().state;
    return Align(
      child: InkWell(
        onTap: () => context.read<ThemeModeCubit>().toggle(),
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Icon(
            theme.isLightTheme
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
          ),
        ),
      ),
    );
  }
}
