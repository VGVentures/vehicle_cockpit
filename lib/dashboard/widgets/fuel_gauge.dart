import 'package:flutter/material.dart';
import 'package:vehicle_cockpit/l10n/l10n.dart';
import 'package:vehicle_cockpit/ui/ui.dart';

class FuelGauge extends StatelessWidget {
  const FuelGauge({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.fuelGaugeEmpty,
                    style: textTheme.titleLarge,
                  ),
                  Text(
                    l10n.fuelGaugeFull,
                    style: textTheme.titleLarge,
                  ),
                ],
              ),
              Card(
                elevation: 8,
                clipBehavior: Clip.antiAlias,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    const spacing = AppSpacing.xxs;
                    final width = constraints.maxWidth / 8 - spacing;

                    return Row(
                      children: [
                        for (var i = 1; i < 6; i++)
                          Container(
                            color: colorScheme.primary,
                            margin: const EdgeInsets.only(right: spacing),
                            width: width,
                            height: AppSpacing.xlg,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: textTheme.titleLarge?.fontSize ?? 0,
            left: AppSpacing.sm,
          ),
          child: const Icon(Icons.local_gas_station),
        ),
        Padding(
          padding: EdgeInsets.only(top: textTheme.titleLarge?.fontSize ?? 0),
          child: const Icon(Icons.play_arrow_rounded, size: AppSpacing.lg),
        ),
      ],
    );
  }
}
