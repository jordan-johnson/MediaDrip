import 'package:flutter/material.dart';
import 'package:mediadrip/views/models/view_model.dart';
import 'package:provider/provider.dart';

class ViewModelProvider<T extends ViewModel> extends StatelessWidget {
  final ViewModel model;
  final Widget Function(T model) builder;

  ViewModelProvider({@required this.model, @required this.builder});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => model,
      child: Consumer<T>(
        builder: (_, T value, __) => builder(value),
      ),
    );
  }
}