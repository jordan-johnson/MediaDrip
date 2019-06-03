import 'package:flutter/material.dart';
import 'dripPage.dart';
export 'dripPage.dart';

abstract class DripPageManager {
  List<DripPage> _pages = List();

  @protected
  void addPage(DripPage page) {
    _pages.add(page);
  }

  @protected
  void addPages(List<DripPage> pages) {
    _pages.addAll(pages);
  }

  @protected
  void setPages(List<DripPage> pages) {
    _pages = pages;
  }

  DripPage getRootPage() {
    for(var page in _pages) {
      if(page.route == '/')
        return page;
    }

    return null;
  }

  DripPage getPage(String route) {
    return _pages.firstWhere((x) => x.route == route);
  }
}