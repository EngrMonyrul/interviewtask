import 'package:flutter/material.dart';

ThemeData appThemeData() {
  return ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
  );
}
