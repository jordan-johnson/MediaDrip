import 'view.dart';
import 'homeView.dart';
import 'downloadView.dart';
import 'settingsView.dart';

class ViewManager {
  List<View> _views = List();

  ViewManager() {
    addViews([
      HomeView(),
      DownloadView(),
      SettingsView()
    ]);
  }

  void addView(View view) {
    _views.add(view);
  }

  View getView(String title) {
    return _views.firstWhere((x) => x.displayTitle() == title);
  }

  void addViews(List<View> views) {
    _views.addAll(views);
  }

  List<View> getViews() {
    return _views;
  }
}