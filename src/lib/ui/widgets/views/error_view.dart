import 'package:flutter/material.dart';
import 'package:mediadrip/ui/widgets/drip_wrapper.dart';

class ErrorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DripWrapper(
      title: 'Error',
      route: '',
      child: Text('Page not found'),
    );
  }
}