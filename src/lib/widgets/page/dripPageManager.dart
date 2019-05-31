import 'dripPage.dart';
export 'dripPage.dart';

abstract class DripPageManager {
  List<DripPage> _pages = List();

  void addPage(DripPage page) {
    _pages.add(page);
  }

  void addPages(List<DripPage> pages) {
    _pages.addAll(pages);
  }

  void setPages(List<DripPage> pages) {
    _pages = pages;
  }

  DripPage getPage(String route) {
    return _pages.firstWhere((x) => x.route == route);
  }
}