import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() => runApp(MediaDrip());

class MediaDrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediaDrip',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(title: 'MediaDrip'),
    );
  }
}
