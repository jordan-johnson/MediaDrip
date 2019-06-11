import 'package:flutter/material.dart';
export 'package:flutter/material.dart';
export 'dripAssets.dart';

/// Defines basic information of a page.
mixin DripPage on Widget {
  /// Title to be displayed on screen.
  final String title = '';

  /// Expected route. (i.e. '/example')
  final String route = '';

  /// Sub-pages.
  final List<DripPage> children = List();

  /// Any data that needs to be passed via route.
  final Object routeArguments = null;
}

/// A StatelessDripPage is used for static pages.
/// 
/// Use StatefulDripPage for pages that need to be updated
/// (i.e. get data from text field)
abstract class StatelessDripPage extends StatelessWidget with DripPage {
  @protected
  Widget build(BuildContext context);
}

/// A StatefulDripPage is used for dynamic pages where you 
/// need to manipulate objects on screen (i.e. text fields).
/// 
/// Use StatelessDripPage for static pages.
abstract class StatefulDripPage extends StatefulWidget with DripPage {
  @protected
  void dispose() {}

  @protected
  Widget build(BuildContext context);

  @override
  _DripPageState createState() => _DripPageState();
}

class _DripPageState extends State<StatefulDripPage> {
  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context);
}