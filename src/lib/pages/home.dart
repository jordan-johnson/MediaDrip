import 'package:flutter/material.dart';
import '../widgets/page/dripPage.dart';
import 'pageWrapper.dart';

class HomePage extends DripPage {
  @override
  String get route => '/';

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      Text(
        'home page!',
        style: Theme.of(context).textTheme.display1
      )
    );
  }
}