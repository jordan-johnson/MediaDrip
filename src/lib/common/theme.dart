import 'package:flutter/material.dart';

class AppTheme {
  static final Color primarySwatch = Colors.purple;
  static final Color backgroundColor = Colors.white;

  static final TextStyle headerTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  static final TextStyle subHeaderTextStyle = TextStyle(
    fontSize: 12
  );

  static ThemeData getThemeData() {
    return ThemeData(
      primarySwatch: primarySwatch,
      backgroundColor: backgroundColor
    );
  }
}