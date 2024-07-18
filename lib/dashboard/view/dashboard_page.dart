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

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 400,
          width: 1000,
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xlg),
              child: Row(
                children: [
                  const Flexible(
                    child: _LeftContent(),
                  ),
                  Expanded(
                    child: GameWidget(
                      game: GaugeGame(
                        appTheme: theme,
                        l10n: l10n,
                        onSpeedChanged: onSpeedChanged,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: AppSpacing.xxxlg,
                      ),
                      child: LapSection(
                        controller: _controller,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          bottom: -AppSpacing.xxlg,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              l10n.instructions,
              style: theme.textTheme.titleLarge,
            ),
          ),
        ),
      ],
    );
  }
}

class _LeftContent extends StatelessWidget {
  const _LeftContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Clock(),
            SizedBox(width: AppSpacing.lg),
            ExternalTemp(),
          ],
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(
            right: AppSpacing.xxxlg,
          ),
          child: FuelGauge(),
        ),
        SizedBox(height: AppSpacing.lg),
        Padding(
          padding: EdgeInsets.only(
            right: AppSpacing.xxlg,
            left: AppSpacing.xxlg,
          ),
          child: TemperatureGauge(),
        ),
        Spacer(),
      ],
    );
  }
}
