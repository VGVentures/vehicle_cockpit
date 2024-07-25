import 'package:flutter/material.dart';
import 'package:vehicle_cockpit/ui/ui.dart';

class RouteMap extends StatelessWidget {
  const RouteMap({
    super.key,
    this.animationValue = 1,
  });

  final double animationValue;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CustomPaint(
      size: const Size(200, 150),
      painter: RouteMapPainter(
        animationValue: animationValue,
        trackColor: colorScheme.outline,
        progressColor: colorScheme.secondary,
        primaryColor: colorScheme.primary,
        onPrimaryColor: colorScheme.onPrimary,
      ),
    );
  }
}

class RouteMapPainter extends CustomPainter {
  const RouteMapPainter({
    required this.animationValue,
    required this.trackColor,
    required this.progressColor,
    required this.primaryColor,
    required this.onPrimaryColor,
  });

  final double animationValue;
  final Color trackColor;
  final Color progressColor;
  final Color primaryColor;
  final Color onPrimaryColor;

  @override
  void paint(Canvas canvas, Size size) {
    /// Path was generated using `https://fluttershapemaker.com/` where
    /// you can upload an SVG file and generate the code.
    final path = Path()
      ..moveTo(7.28912, 96.7113)
      ..cubicTo(8.78368, 89.9691, 9.63365, 83.3876, 10.4121, 77.1573)
      ..cubicTo(10.4491, 76.862, 10.4858, 76.5675, 10.5224, 76.2739)
      ..cubicTo(11.2625, 70.3413, 11.9582, 64.7647, 13.104, 59.5398)
      ..cubicTo(15.4888, 48.665, 19.7701, 39.557, 30.2637, 32.7405)
      ..cubicTo(34.0597, 30.2747, 36.8713, 29.2476, 40.4222, 27.9506)
      ..cubicTo(41.9799, 27.3816, 43.6798, 26.7607, 45.6675, 25.9435)
      ..cubicTo(50.9501, 23.7718, 57.7944, 20.3307, 64.8206, 16.7584)
      ..cubicTo(65.4813, 16.4225, 66.1437, 16.0854, 66.8069, 15.7478)
      ..cubicTo(73.2367, 12.4755, 79.7421, 9.16467, 85.4067, 6.5952)
      ..cubicTo(88.5298, 5.17852, 91.3569, 4.00597, 93.7446, 3.19546)
      ..cubicTo(96.1856, 2.36683, 97.9727, 1.98629, 99.0915, 2.00036)
      ..cubicTo(99.3837, 2.00404, 99.5688, 2.03466, 99.6766, 2.06152)
      ..cubicTo(99.6773, 2.25438, 99.6328, 2.62955, 99.4193, 3.24885)
      ..cubicTo(99.1639, 3.9902, 98.7128, 4.94965, 98.0065, 6.15926)
      ..cubicTo(96.4328, 8.85414, 95.2619, 11.9786, 94.2284, 15.0759)
      ..cubicTo(93.8453, 16.224, 93.4849, 17.3547, 93.13, 18.4684)
      ..cubicTo(92.5021, 20.4386, 91.8912, 22.3556, 91.201, 24.2219)
      ..cubicTo(89.0222, 30.113, 86.5084, 34.1139, 82.1222, 35.1641)
      ..lineTo(66.9882, 38.7877)
      ..cubicTo(52.6581, 42.2188, 49.7532, 61.9224, 62.1894, 69.7654)
      ..lineTo(71.3728, 75.5569)
      ..cubicTo(77.3254, 79.311, 84.9248, 78.6117, 90.1481, 73.8568)
      ..cubicTo(95.237, 69.2242, 102.98, 69.922, 107.236, 75.4491)
      ..lineTo(113.485, 83.566)
      ..cubicTo(116.517, 87.5048, 121.067, 89.805, 125.872, 90.1013)
      ..cubicTo(132.551, 90.5131, 142.623, 91.4861, 149.668, 93.7056)
      ..cubicTo(166.348, 98.9599, 174.736, 106.552, 187.499, 118.104)
      ..cubicTo(188.593, 119.094, 189.719, 120.113, 190.886, 121.163)
      ..cubicTo(192.063, 122.222, 193.289, 123.39, 194.54, 124.632)
      ..cubicTo(201.974, 132.008, 196.554, 144.559, 186.132, 144.559)
      ..lineTo(128.638, 144.559)
      ..cubicTo(126.86, 144.559, 125.511, 143.988, 123.38, 143.086)
      ..cubicTo(122.897, 142.882, 122.373, 142.66, 121.795, 142.425)
      ..cubicTo(119.692, 141.567, 118.317, 140.173, 116.698, 138.531)
      ..cubicTo(116.459, 138.289, 116.215, 138.042, 115.963, 137.79)
      ..cubicTo(114.051, 135.882, 111.721, 133.842, 107.871, 133.564)
      ..cubicTo(104.402, 133.314, 101.754, 134.191, 99.3485, 135.546)
      ..cubicTo(98.1791, 136.205, 97.0654, 136.978, 95.9748, 137.755)
      ..cubicTo(95.771, 137.9, 95.5681, 138.045, 95.3651, 138.191)
      ..cubicTo(94.4607, 138.838, 93.5543, 139.487, 92.5623, 140.135)
      ..cubicTo(90.6202, 141.404, 89.3115, 142.899, 88.2334, 144.131)
      ..cubicTo(88.073, 144.314, 87.9176, 144.492, 87.7661, 144.662)
      ..cubicTo(86.5837, 145.989, 85.5343, 147.002, 83.8019, 147.685)
      ..cubicTo(81.5411, 148.577, 79.6718, 148.902, 77.8196, 148.858)
      ..cubicTo(75.9348, 148.814, 73.9667, 148.385, 71.482, 147.632)
      ..cubicTo(67.8196, 146.521, 64.8596, 142.743, 62.3029, 136.846)
      ..cubicTo(59.8205, 131.121, 57.9649, 123.996, 56.1246, 116.931)
      ..lineTo(56.0501, 116.645)
      ..cubicTo(54.2153, 109.601, 52.3708, 102.557, 49.9016, 97.5351)
      ..cubicTo(48.6648, 95.0196, 47.1765, 92.805, 45.2783, 91.3568)
      ..cubicTo(43.2885, 89.8388, 40.922, 89.2263, 38.2536, 89.8506)
      ..cubicTo(33.7382, 90.907, 30.9673, 93.472, 28.9343, 96.6497)
      ..cubicTo(27.5819, 98.7637, 26.478, 101.306, 25.3907, 103.809)
      ..cubicTo(24.9378, 104.852, 24.4878, 105.888, 24.0239, 106.884)
      ..cubicTo(22.3196, 110.543, 22.2715, 114.246, 22.8686, 117.74)
      ..cubicTo(23.3696, 120.672, 24.3558, 123.596, 25.2584, 126.272)
      ..cubicTo(25.4135, 126.732, 25.5661, 127.185, 25.7134, 127.629)
      ..cubicTo(26.7555, 130.771, 27.5282, 133.478, 27.4961, 135.894)
      ..cubicTo(27.466, 138.156, 26.729, 140.179, 24.5379, 142.051)
      ..cubicTo(24.1548, 142.378, 23.7935, 142.69, 23.4497, 142.987)
      ..cubicTo(21.4588, 144.705, 20.0546, 145.917, 18.3875, 146.697)
      ..cubicTo(16.5883, 147.539, 14.3533, 147.909, 10.5449, 147.247)
      ..cubicTo(5.19274, 146.317, 1.51143, 141.002, 2.05172, 134.922)
      ..cubicTo(3.00961, 124.144, 4.728, 108.265, 7.28912, 96.7113)
      ..close();

    final paint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final metric = path.computeMetrics().first;
    final length = metric.length;
    final tangent = metric.getTangentForOffset(length * animationValue);
    final position = tangent?.position ?? Offset.zero;
    final progressPath = metric.extractPath(0, length * animationValue);

    canvas
      ..drawPath(path, paint)
      ..drawPath(progressPath, paint..color = progressColor)
      ..drawCircle(
        position,
        AppSpacing.md,
        Paint()..color = primaryColor.withOpacity(0.5),
      )
      ..drawCircle(
        position,
        AppSpacing.sm,
        Paint()..color = onPrimaryColor,
      )
      ..drawCircle(
        position,
        AppSpacing.xs + AppSpacing.xxs,
        Paint()..color = primaryColor,
      );
  }

  @override
  bool shouldRepaint(covariant RouteMapPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue ||
        trackColor != oldDelegate.trackColor ||
        progressColor != oldDelegate.progressColor ||
        primaryColor != oldDelegate.primaryColor ||
        onPrimaryColor != oldDelegate.onPrimaryColor;
  }
}
