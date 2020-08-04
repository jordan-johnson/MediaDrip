import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mediadrip/models/file/index.dart';

class FolderItem implements IFileEntity {
  final String name;
  final String path;
  final FileSystemEntityType type;

  final List<FolderItem> subFolders = List<FolderItem>();
  final List<FileItem> files = List<FileItem>();

  FolderItem({
    @required this.name,
    @required this.path,
    @required this.type,
  });
}