import 'package:flutter/material.dart';
import 'package:vehicle_cockpit/ui/ui.dart';

class ExternalTemp extends StatelessWidget {
  const ExternalTemp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.sunny_snowing),
        SizedBox(width: AppSpacing.xs),
        Text('29°F'),
      ],
    );
  }
}
