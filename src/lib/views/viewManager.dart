import 'package:mediadrip/views/view.dart';
import 'downloadView.dart';
import 'homeView.dart';

class ViewManager {
  List<View> _views = List();

  ViewManager() {
    addViews([
      HomeView(),
      DownloadView(),
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