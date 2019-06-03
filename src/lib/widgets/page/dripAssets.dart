import 'package:mediadrip/widgets/page/dripPage.dart';

class DripAssets {
  static final String path = 'lib/pages/assets/';

  static Widget image(String file, [double width, double height]) {
    return Image.asset(path + file, width: width, height: height);
  }
}