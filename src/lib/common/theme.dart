import 'package:flutter/material.dart';

class AppTheme {
  static final TextStyle headerTextStyle = TextStyle(
    fontSize: 56,
    fontFamily: 'WireOne',
  );

  static final TextStyle subHeaderTextStyle = TextStyle(
    fontSize: 12
  );

  static ThemeData getThemeData() {
    return ThemeData(
      primarySwatch: Colors.purple,
      accentColor: Colors.purpleAccent,
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