import 'dart:math';

import 'package:dash_and_furious/dashboard/dashboard.dart';
import 'package:dash_and_furious/l10n/l10n.dart';
import 'package:dash_and_furious/ui/ui.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
    AnimationController? animationController,
  }) : _animationController = animationController;

  final AnimationController? _animationController;

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  void onSpeedChanged(double speed) {
    // Based on the max speed of 160mph, 0.222222 miles would be the distance
    // covered in 5000 milliseconds if going max speed.
    const distance = 0.222222;
    final timeInMilliseconds = (distance / speed) * 3600 * 1000;

    if (speed <= 0) _controller.stop();

    _controller
      ..duration = Duration(
        milliseconds: timeInMilliseconds.round().abs(),
      )
      ..forward();
  }

  @override
  void initState() {
    super.initState();

    _controller = widget._animationController ??
        AnimationController(
          duration: const Duration(milliseconds: 5000),
          vsync: this,
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final game = GaugeGame(
      appTheme: theme,
      l10n: l10n,
      onSpeedChanged: onSpeedChanged,
    );
    final isMobile = theme.platform == TargetPlatform.android ||
        theme.platform == TargetPlatform.iOS;

    return Stack(
      children: [
        Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xlg),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: AppSpacing.xxxlg,
                runSpacing: AppSpacing.xxxlg,
                children: [
                  SizedBox(
                    width: 400,
                    child: Column(
                      children: [
                        const _Indicators(),
                        const SizedBox(height: AppSpacing.xlg),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: SizedBox(
                            width: 450,
                            child: LapSection(
                              controller: _controller,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = min<double>(400, constraints.maxWidth);
                      return SizedBox.square(
                        dimension: width * .75,
                        child: Transform.scale(
                          scale: width / 500,
                          child: GameWidget(
                            game: game,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isMobile)
          Positioned(
            bottom: AppSpacing.xlg,
            right: AppSpacing.xlg,
            child: AcceleratorButton(game: game),
          )
        else
          Positioned(
            bottom: AppSpacing.xlg,
            right: AppSpacing.xlg,
            left: AppSpacing.xlg,
            child: Center(
              child: Text(
                l10n.instructions,
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ),
      ],
    );
  }
}

class _Indicators extends StatelessWidget {
  const _Indicators();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FuelGauge(),
              SizedBox(height: AppSpacing.lg),
              Padding(
                padding: EdgeInsets.only(
                  left: AppSpacing.xs,
                  right: AppSpacing.lg,
                ),
                child: TemperatureGauge(),
              ),
            ],
          ),
        ),
        SizedBox(width: AppSpacing.xxxlg),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Clock(),
              SizedBox(height: AppSpacing.lg),
              ExternalTemp(),
            ],
          ),
        ),
      ],
    );
  }
}
