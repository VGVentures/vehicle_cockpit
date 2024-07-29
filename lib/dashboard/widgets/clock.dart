import 'package:dash_and_furious/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Clock extends StatelessWidget {
  const Clock({super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.Hm();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.schedule),
        const SizedBox(width: AppSpacing.xs),
        StreamBuilder(
          stream: Stream<void>.periodic(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            return Center(
              child: Text(
                formatter.format(DateTime.now()),
              ),
            );
          },
        ),
      ],
    );
  }
}
