import 'package:flutter/material.dart';

/// {@template app_theme}
/// The Default App [ThemeData].
/// {@endtemplate}
class AppTheme {
  /// {@macro app_theme}
  const AppTheme();

  /// Default `ThemeData` for App UI.
  ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _colorScheme,
      canvasColor: _colorScheme.surface,
    );
  }

  ColorScheme get _colorScheme {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF424242), // Medium Gray
      onPrimary: Color(0xFFFFFFFF), // White
      primaryContainer: Color(0xFFBDBDBD), // Light Gray
      onPrimaryContainer: Color(0xFF212121), // Dark Gray
      secondary: Color(0xFF757575), // Gray
      onSecondary: Color(0xFFFFFFFF), // White
      secondaryContainer: Color(0xFFD7CCC8), // Very Light Gray
      onSecondaryContainer: Color(0xFF494949), // Medium Dark Gray
      tertiary: Color(0xFF616161), // Darker Gray
      onTertiary: Color(0xFFFFFFFF), // White
      tertiaryContainer: Color(0xFFB0BEC5), // Light Blue Gray
      onTertiaryContainer: Color(0xFF37474F), // Dark Blue Gray
      error: Color(0xFFD32F2F), // Red
      errorContainer: Color(0xFFFFCDD2), // Light Red
      onError: Color(0xFFFFFFFF), // White
      onErrorContainer: Color(0xFFC62828), // Dark Red
      surface: Color(0xFFF5F5F5), // Very Light Gray
      onSurface: Color(0xFF212121), // Almost Black
      surfaceContainerHighest: Color(0xFFEEEEEE), // Very Light Gray
      onSurfaceVariant: Color(0xFF757575), // Medium Gray
      outline: Color(0xFFBDBDBD), // Light Gray
      onInverseSurface: Color(0xFFFAFAFA), // Very Light Gray
      inverseSurface: Color(0xFF212121), // Almost Black
      inversePrimary: Color(0xFF424242), // Medium Gray
      shadow: Color(0xFF000000), // Black
      surfaceTint: Color(0xFF424242), // Medium Gray
    );
  }
}

/// {@template app_theme}
/// Dark Mode App [ThemeData].
/// {@endtemplate}
class AppDarkTheme extends AppTheme {
  /// {@macro app_theme}
  const AppDarkTheme();

  @override
  ColorScheme get _colorScheme {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFE0E0E0), // Light Gray
      onPrimary: Color(0xFF1F1F1F), // Dark Gray
      primaryContainer: Color(0xFF373737), // Medium Gray
      onPrimaryContainer: Color(0xFFE0E0E0), // Light Gray
      secondary: Color(0xFFB0BEC5), // Light Blue Gray
      onSecondary: Color(0xFF263238), // Dark Blue Gray
      secondaryContainer: Color(0xFF455A64), // Medium Blue Gray
      onSecondaryContainer: Color(0xFFB0BEC5), // Light Blue Gray
      tertiary: Color(0xFF5D737E), // Muted Blue
      onTertiary: Color(0xFFFFFFFF), // White
      tertiaryContainer: Color(0xFF455A64), // Medium Blue Gray
      onTertiaryContainer: Color(0xFFB0BEC5), // Light Blue Gray
      error: Color(0xFFCF6679), // Pink
      errorContainer: Color(0xFFB00020), // Red
      onError: Color(0xFFFFFFFF), // White
      onErrorContainer: Color(0xFF370B1E), // Dark Red
      surface: Color(0xFF121212), // Black
      onSurface: Color(0xFFE0E0E0), // Light Gray
      surfaceContainerHighest: Color(0xFF2C2C2C), // Medium Gray
      onSurfaceVariant: Color(0xFF737373), // Gray
      outline: Color(0xFF8A8A8A), // Light Gray
      onInverseSurface: Color(0xFF121212), // Black
      inverseSurface: Color(0xFFE0E0E0), // Light Gray
      inversePrimary: Color(0xFF1F1F1F), // Dark Gray
      shadow: Color(0xFF000000), // Black
      surfaceTint: Color(0xFFE0E0E0), // Light Gray
    );
  }
}
