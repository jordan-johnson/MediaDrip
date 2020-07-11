import 'package:flutter/cupertino.dart';

class WidgetModel extends ChangeNotifier {
  final BuildContext context;

  WidgetModel({@required this.context}) {
    initialize();
  }

  Future<void> initialize() async {}
}