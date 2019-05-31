import '../widgets/page/dripPageManager.dart';
import 'download.dart';
import 'home.dart';

class Pages extends DripPageManager {
  Pages() {
    addPages([
      HomePage(),
      DownloadPage()
    ]);
  }
}