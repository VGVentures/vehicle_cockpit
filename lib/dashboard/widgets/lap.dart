import 'package:dash_and_furious/l10n/l10n.dart';
import 'package:dash_and_furious/ui/ui.dart';
import 'package:flutter/material.dart';

class Lap extends StatelessWidget {
  const Lap({
    required this.bestLap,
    required this.number,
    required this.child,
    super.key,
  });

  final bool bestLap;
  final int number;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                bestLap ? l10n.bestLapTitle : l10n.currentLapTitle,
                style: textTheme.titleMedium,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            if (number > 0)
              Material(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppSpacing.sm),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  child: Text(
                    l10n.lapCount(number),
                    style: textTheme.labelMedium,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        DefaultTextStyle(
          style: textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
          child: child,
        ),
      ],
    );
  }
}
