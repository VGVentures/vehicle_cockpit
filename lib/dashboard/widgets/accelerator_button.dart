import 'package:flutter/material.dart';
import 'package:vehicle_cockpit/dashboard/dashboard.dart';
import 'package:vehicle_cockpit/ui/ui.dart';

class AcceleratorButton extends StatefulWidget {
  const AcceleratorButton({required this.game, super.key});

  final GaugeGame game;

  @override
  State<AcceleratorButton> createState() => _AcceleratorButtonState();
}

class _AcceleratorButtonState extends State<AcceleratorButton> {
  GaugeGame get _game => widget.game;
  bool _isPressed = false;

  void _accelerate(_) {
    _game.accelerate();
    setState(() => _isPressed = true);
  }

  void _release([_]) {
    _game.release();
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = _isPressed ? colorScheme.tertiary : colorScheme.secondary;
    final fgColor =
        _isPressed ? colorScheme.onTertiary : colorScheme.onSecondary;

    return InkWell(
      onTapDown: _accelerate,
      onTapUp: _release,
      onTapCancel: _release,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Icon(
          Icons.keyboard_double_arrow_up_rounded,
          size: 32,
          color: fgColor,
        ),
      ),
    );
  }
}
