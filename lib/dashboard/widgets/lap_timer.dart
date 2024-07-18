import 'package:flutter/material.dart';

class LapTimer extends StatelessWidget {
  const LapTimer({
    required this.stopwatch,
    super.key,
  });

  final Stopwatch stopwatch;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return StreamBuilder(
      stream: Stream<void>.periodic(const Duration(milliseconds: 10)),
      builder: (context, snapshot) {
        return Text(
          lapTime(stopwatch.elapsed),
          style: TextStyle(
            color: colorScheme.primary,
          ),
        );
      },
    );
  }

  String lapTime(Duration duration) {
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
