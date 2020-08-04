import 'dart:io';

import 'package:flutter/material.dart';

class IFileEntity {
  final String name;
  final String path;
  final FileSystemEntityType type;

  IFileEntity({
    @required this.name,
    @required this.path,
    @required this.type
  });
}