import 'package:flutter/cupertino.dart';

class DripAssets {
  static final String path = 'lib/assets/';

  static Widget image(String file, [double width, double height]) {
    return Image.asset(path + file, width: width, height: height);
  }
}