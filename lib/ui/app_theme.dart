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
      primary: Color(0xFF015AC1),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFD8E2FF),
      onPrimaryContainer: Color(0xFF001A41),
      secondary: Color(0xFF345CA8),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFD9E2FF),
      onSecondaryContainer: Color(0xFF001A43),
      tertiary: Color(0xFF84468E),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFFFD6FF),
      onTertiaryContainer: Color(0xFF350040),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
      onError: Color(0xFFFFFFFF),
      onErrorContainer: Color(0xFF410002),
      surface: Color(0xFFFEFBFF),
      onSurface: Color(0xFF001945),
      surfaceContainerHighest: Color(0xFFE1E2EC),
      onSurfaceVariant: Color(0xFF44474F),
      outline: Color(0xFF75777F),
      onInverseSurface: Color(0xFFEEF0FF),
      inverseSurface: Color(0xFF002C6F),
      inversePrimary: Color(0xFFADC6FF),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFF015AC1),
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
      primary: Color(0xFFADC6FF),
      onPrimary: Color(0xFF002E69),
      primaryContainer: Color(0xFF004494),
      onPrimaryContainer: Color(0xFFD8E2FF),
      secondary: Color(0xFFAFC6FF),
      onSecondary: Color(0xFF002D6C),
      secondaryContainer: Color(0xFF15448F),
      onSecondaryContainer: Color(0xFFD9E2FF),
      tertiary: Color(0xFFF6ADFE),
      onTertiary: Color(0xFF50155C),
      tertiaryContainer: Color(0xFF692E74),
      onTertiaryContainer: Color(0xFFFFD6FF),
      error: Colors.pink,
      errorContainer: Color(0xFF93000A),
      onError: Color(0xFF690005),
      onErrorContainer: Color(0xFFFFDAD6),
      surface: Color(0xFF001945),
      onSurface: Color(0xFFD9E2FF),
      surfaceContainerHighest: Color(0xFF44474F),
      onSurfaceVariant: Color(0xFFC4C6D0),
      outline: Color(0xFF8E9099),
      onInverseSurface: Color(0xFF001945),
      inverseSurface: Color(0xFFD9E2FF),
      inversePrimary: Color(0xFF015AC1),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFFADC6FF),
    );
  }
}
