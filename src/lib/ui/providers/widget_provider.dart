import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class WidgetModel extends ChangeNotifier {
  final BuildContext context;

  WidgetModel({@required this.context}) {
    initialize();
  }

  Future<void> initialize() async {}
}

class WidgetProvider<T extends WidgetModel> extends StatelessWidget {
  final WidgetModel model;
  final Widget Function(T model) builder;

  WidgetProvider({
    @required this.model,
    @required this.builder
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => model,
      child: Consumer<T>(
        builder: (_, T value, __) => builder(value),
      )
    );
  }
}