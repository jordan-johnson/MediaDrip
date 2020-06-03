import 'package:flutter/material.dart';

class AppTheme {
  static final Color primarySwatch = Colors.purple;
  static final Color backgroundColor = Colors.white;

  static ThemeData getThemeData() {
    return ThemeData(
      primarySwatch: primarySwatch,
      backgroundColor: backgroundColor
    );
  }
}