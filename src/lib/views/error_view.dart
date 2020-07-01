import 'package:flutter/cupertino.dart';
import 'package:mediadrip/common/widgets/drip_wrapper.dart';

class ErrorView extends StatelessWidget {
  Widget build(BuildContext context) {
    return DripWrapper(
      title: 'Error',
      route: '',
      child: Text('Page not found.'),
    );
  }
}