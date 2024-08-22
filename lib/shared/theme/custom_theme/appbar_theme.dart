import 'package:flutter/material.dart';

class TAppbarTheme {
  const TAppbarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    color: Colors.white,
    scrolledUnderElevation: 0,
    actionsIconTheme: IconThemeData(color: Colors.black, size: 24),
    titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
    shape: StadiumBorder(),

  );

}