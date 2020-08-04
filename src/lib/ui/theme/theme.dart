import 'package:flutter/material.dart';

const testt = Color(0xFFFFFFFF);

class AppTheme {
  static final TextStyle headerTextStyle = TextStyle(
    fontSize: 36,
    fontFamily: 'WireOne',
  );

  static final TextStyle subHeaderTextStyle = TextStyle(
    fontSize: 12
  );

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      visualDensity: VisualDensity.comfortable,
      primarySwatch: Colors.purple,
      accentColor: Colors.purple[400],
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,

      primaryColor: Colors.purple,
      primaryColorLight: Colors.purple[300],

      buttonTheme: ButtonThemeData(
        buttonColor: Colors.purple[600],
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.purple)
        ),
      ),

      textTheme: TextTheme(
        headline5: TextStyle(
          color: Colors.purple,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
        headline6: TextStyle(
          height: 1.5,
          fontSize: 14,
        )
      ),

      iconTheme: IconThemeData(
        color: Colors.purple[200]
      )
    );
  }

  /// Not finished.
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      visualDensity: VisualDensity.comfortable,
      primarySwatch: Colors.purple,
      accentColor: Colors.purple[400],
      backgroundColor: Colors.grey[900],
      scaffoldBackgroundColor: Colors.grey[900],

      primaryColor: Colors.purple,
      primaryColorLight: Colors.grey[850],

      appBarTheme: AppBarTheme(
        color: Colors.purple
      ),

      buttonTheme: ButtonThemeData(
        buttonColor: Colors.purple[600],
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.purple)
        ),
      ),

      textTheme: TextTheme(
        headline5: TextStyle(
          color: Colors.purpleAccent,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
        headline6: TextStyle(
          height: 1.5,
          fontSize: 14,
        )
      ),

      iconTheme: IconThemeData(
        color: Colors.purple[200]
      ),
    );
  }

  static ThemeData getThemeDynamic(bool isDarkMode) {
    if(isDarkMode) {
      return dark();
    }

    return light();
  }
}