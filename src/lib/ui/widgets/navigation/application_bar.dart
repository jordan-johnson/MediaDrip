import 'package:flutter/material.dart';

class ApplicationBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String route;
  final List<Widget> actions;

  bool get _isRoot => route == '/';

  @override
  final Size preferredSize;

  ApplicationBar({
    Key key,
    @required this.title,
    @required this.route,
    this.actions
  }) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.title),
      automaticallyImplyLeading: this._isRoot,
      leading: !this._isRoot ? IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ) : null,
      actions: actions,
    );
  }
}