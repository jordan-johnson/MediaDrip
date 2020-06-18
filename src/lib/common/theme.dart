import 'package:flutter/material.dart';

class AppTheme {
  static final TextStyle headerTextStyle = TextStyle(
    fontSize: 36,
    fontFamily: 'WireOne',
  );

  static final TextStyle subHeaderTextStyle = TextStyle(
    fontSize: 12
  );

  static ThemeData getThemeData() {
    return ThemeData(
      visualDensity: VisualDensity.comfortable,
      primarySwatch: Colors.purple,
      accentColor: Colors.purple[400],
      backgroundColor: Colors.white,

      buttonTheme: ButtonThemeData(
        buttonColor: Colors.purple[600],
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.purple)
        ),
      )
    );
  }
}