import 'dart:math' as math;

extension DoubleExtensions on double {
  /// Exponential decay function. Use this instead of linear interpolation since
  /// it is framerate-independent!
  ///
  /// e.g., `myValue.expDecay(toValue, decay, delta);`
  ///
  /// Note that useful [decay] values are typically between 1 (slow) to 25
  /// (fast).
  ///
  /// Thanks, Freya! https://youtu.be/LSNQuFEDOyQ?t=2981
  double expDecay(double b, double decay, double delta) =>
      b + (this - b) * math.exp(-decay * delta);
}
