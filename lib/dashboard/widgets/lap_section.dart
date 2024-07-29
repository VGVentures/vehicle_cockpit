import 'dart:math';

import 'package:dash_and_furious/dashboard/dashboard.dart';
import 'package:dash_and_furious/ui/ui.dart';
import 'package:flutter/material.dart';

class LapSection extends StatefulWidget {
  const LapSection({
    required this.controller,
    super.key,
  });

  final AnimationController controller;

  @override
  State<LapSection> createState() => LapSectionState();
}

class LapSectionState extends State<LapSection> {
  final random = Random();
  final stopwatch = Stopwatch();
  int bestLap = 0;
  Duration bestTime = Duration.zero;
  int currentLap = 1;

  Duration setLapTime() =>
      Duration(milliseconds: random.nextInt(15000) + 15000);

  @override
  void initState() {
    super.initState();
    widget.controller.addStatusListener(newLap);

    stopwatch.start();
  }

  @override
  void dispose() {
    widget.controller.removeStatusListener(newLap);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lap(
                bestLap: true,
                number: bestLap,
                child: Text(_lapTime(bestTime)),
              ),
              const SizedBox(height: AppSpacing.sm),
              Lap(
                bestLap: false,
                number: currentLap,
                child: LapTimer(stopwatch: stopwatch),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.xlg),
        Expanded(
          child: AnimatedBuilder(
            animation: widget.controller,
            builder: (_, __) => RouteMap(
              animationValue: widget.controller.value,
            ),
          ),
        ),
      ],
    );
  }

  void newLap(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        if (stopwatch.elapsed < bestTime || bestLap == 0) {
          bestTime = stopwatch.elapsed;
          bestLap = currentLap;
        }
        currentLap++;
        stopwatch.reset();
        setLapTime();
        widget.controller
          ..reset()
          ..forward();
      });
    }
  }

  String _lapTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final milliseconds = duration.inMilliseconds
        .remainder(1000)
        .toString()
        .padLeft(3, '0')
        .substring(0, 2);

    return '$minutes:$seconds.$milliseconds';
  }
}
