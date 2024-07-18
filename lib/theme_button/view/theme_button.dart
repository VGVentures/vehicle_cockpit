import 'package:dash_and_furious/theme_button/theme_button.dart';
import 'package:dash_and_furious/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
