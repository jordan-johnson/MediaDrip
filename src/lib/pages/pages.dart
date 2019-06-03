import '../widgets/page/dripPageManager.dart';
import 'download.dart';
import 'home.dart';
import 'tools.dart';
import 'settings.dart';

class Pages extends DripPageManager {
  Pages() {
    addPages([
      HomePage(),
      DownloadPage(),
      ToolsPage(),
      SettingsPage()
    ]);
  }
}