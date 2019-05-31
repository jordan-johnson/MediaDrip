import 'package:flutter/material.dart';
import '../widgets/page/dripPage.dart';
import 'pageWrapper.dart';

class DownloadPage extends DripPage {
  @override
  String get route => '/download';

  @override
  Widget get body =>
    PageWrapper(
      Text('this is the download page')
    );
}