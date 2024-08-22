import 'package:flutter/material.dart';
import 'custom_theme/appbar_theme.dart';

///application light theme
final appLightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  appBarTheme: TAppbarTheme.lightAppBarTheme,
  scaffoldBackgroundColor: Colors.cyan,




);

///application light theme
final appDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  appBarTheme: TAppbarTheme.lightAppBarTheme,
  primarySwatch: Colors.yellow,
);