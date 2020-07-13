import 'package:flutter/material.dart';

class DripDialog extends Dialog {
  final double width, height;
  final List<Widget> children;

  DripDialog({
    @required this.width,
    @required this.height,
    @required this.children
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          width: this.width,
          height: this.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: this.children,
          ),
        ),
      )
    );
  }
}