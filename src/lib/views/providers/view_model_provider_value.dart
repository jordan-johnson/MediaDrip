import 'package:flutter/material.dart';
import 'package:mediadrip/views/models/view_model.dart';
import 'package:provider/provider.dart';

class ViewModelProviderValue<T extends ViewModel> extends StatelessWidget {
  final ViewModel model;
  final Widget Function(T model) builder;

  ViewModelProviderValue({@required this.model, @required this.builder});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        builder: (_, T value, __) => builder(value),
      ),
    );
  }
}