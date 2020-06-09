import 'package:flutter/material.dart';

class AppTheme {
  static final Color primarySwatch = Colors.purple;
  static final Color backgroundColor = Colors.white;

  static final TextStyle headerTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    fontFamily: 'CormorantGaramond',
    fontStyle: FontStyle.italic,
  );

  static final TextStyle subHeaderTextStyle = TextStyle(
    fontSize: 12
  );

  static Widget header(IconData icon, String data, [String subHeaderData]) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Row(
            children: [
              Icon(icon, color: Colors.black, size: 36),
              SizedBox(width: 10),
              Text(data, style: headerTextStyle)
            ],
          )
        ),
        (subHeaderData.isEmpty) ? null :
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: primarySwatch,
                ),
                SizedBox(width: 10),
                Text(subHeaderData, style: subHeaderTextStyle)
              ],
            ),
          )
      ],
    );
  }

  static ThemeData getThemeData() {
    return ThemeData(
      primarySwatch: primarySwatch,
      backgroundColor: backgroundColor
    );
  }
}