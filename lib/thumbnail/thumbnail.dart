import 'package:dash_and_furious/dashboard/dashboard.dart';
import 'package:dash_and_furious/ui/ui.dart';
import 'package:flutter/material.dart';

class Thumbnail extends StatelessWidget {
  const Thumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = const AppDarkTheme().themeData;

    return Theme(
      data: theme,
      child: ColoredBox(
        color: theme.colorScheme.surface,
        child: const Center(child: LapViewer()),
      ),
    );
  }
}

class LapViewer extends StatefulWidget {
  const LapViewer({super.key});

  @override
  State<StatefulWidget> createState() => LapViewerState();
}

class LapViewerState extends State<LapViewer> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..duration = const Duration(seconds: 12)
      ..forward()
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => RouteMap(
        animationValue: _controller.value,
      ),
    );
  }
}
