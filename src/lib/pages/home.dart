import 'package:flutter/material.dart';
import '../widgets/page/dripPage.dart';
import 'pageWrapper.dart';

class HomePage extends DripPage {
  @override
  String get route => '/';

  @override
  Widget get body =>
    PageWrapper(
      Text('k')
    );
}