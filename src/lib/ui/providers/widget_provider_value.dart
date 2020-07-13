import 'package:flutter/cupertino.dart';
import 'package:mediadrip/ui/providers/widget_provider.dart';
import 'package:provider/provider.dart';

class WidgetProviderValue<T extends WidgetModel> extends StatelessWidget {
  final WidgetModel model;
  final Widget Function(T model) builder;

  WidgetProviderValue({
    @required this.model,
    @required this.builder
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: this.model,
      child: Consumer<T>(
        builder: (_, T value, __) => this.builder(value)
      )
    );
  }
}