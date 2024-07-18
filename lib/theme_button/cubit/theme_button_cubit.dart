import 'package:dash_and_furious/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final darkTheme = const AppDarkTheme().themeData;
final lightTheme = const AppTheme().themeData;

class ThemeModeCubit extends Cubit<ThemeData> {
  ThemeModeCubit() : super(darkTheme);

  void toggle() => emit(state == darkTheme ? lightTheme : darkTheme);
}

extension ThemeDataX on ThemeData {
  bool get isLightTheme => this == lightTheme;
}
