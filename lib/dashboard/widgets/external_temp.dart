import 'package:dash_and_furious/ui/ui.dart';
import 'package:flutter/material.dart';

class ExternalTemp extends StatelessWidget {
  const ExternalTemp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.sunny_snowing),
        SizedBox(width: AppSpacing.xs),
        Text('29°F'),
      ],
    );
  }
}
