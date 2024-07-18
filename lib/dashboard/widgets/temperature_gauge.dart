import 'package:dash_and_furious/l10n/l10n.dart';
import 'package:dash_and_furious/ui/ui.dart';
import 'package:flutter/material.dart';

class TemperatureGauge extends StatelessWidget {
  const TemperatureGauge({
    super.key,
    this.value = .7,
  });

  final double value;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme.titleLarge;
    final colorScheme = theme.colorScheme;
    final progress = (value.clamp(0, 1) * 100).toInt();

    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.engineCool, style: textTheme),
                  Text(l10n.engineHot, style: textTheme),
                ],
              ),
              SizedBox(
                height: AppSpacing.xlg,
                child: Card(
                  elevation: 8,
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    children: [
                      Flexible(
                        flex: progress,
                        // ignore: use_decorated_box
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              stops: const [0.4, 1],
                              colors: [
                                colorScheme.secondary,
                                colorScheme.error,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 100 - progress,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: textTheme?.fontSize ?? 0),
          child: const Icon(
            Icons.device_thermostat,
            size: AppSpacing.xlg,
          ),
        ),
      ],
    );
  }
}
