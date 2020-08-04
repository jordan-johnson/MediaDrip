import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mediadrip/models/file/index.dart';
import 'package:filesize/filesize.dart';

class FileItem implements IFileEntity {
  final String name;
  final String path;
  final FileSystemEntityType type;
  final DateTime lastModified;
  
  final int size;
  String get sizeConversion => filesize(size);

  final File data;
  
  FileItem({
    @required this.name,
    @required this.path,
    @required this.type,
    @required this.lastModified,
    @required this.size,
    @required this.data
  });
}