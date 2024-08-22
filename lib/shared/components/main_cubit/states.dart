import 'package:flutter/material.dart';

import '../../theme/custom_theme/appbar_theme.dart';

abstract class ThemeState {
  ThemeData get themeData;
}

class LightThemeState extends ThemeState {
  @override
  ThemeData get themeData => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    appBarTheme: TAppbarTheme.lightAppBarTheme,
    scaffoldBackgroundColor: Colors.cyan,

  );
}

class DarkThemeState extends ThemeState {
  @override
  ThemeData get themeData => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    appBarTheme: TAppbarTheme.lightAppBarTheme,
    scaffoldBackgroundColor: Color(0xff0d054a),
  );
}