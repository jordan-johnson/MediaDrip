import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as pathlib;
import 'package:flutter/material.dart';

class FileHelper {
  /// Gets [Directory] safely by creating the directory if it doesn't exist.
  static Future<Directory> getDirectorySafely(String path) async {
    var directory = Directory(path);

    if(!await directory.exists())
      await directory.create();
    
    return directory;
  }

  static String getFileExtensionFromFileName(String fileName) {
    return fileName.split('.').last;
  }

  static IconData getIconFromFileName(String fileName) {
    var fileExtension = getFileExtensionFromFileName(fileName);

    switch(fileExtension) {
      case 'webm':
      case 'mp4':
      case 'm4v':
      case 'mkv':
      case 'flv':
      case 'ogg':
      case 'ogv':
      case 'avi':
      case 'mov':
      case 'wmv':
      case 'mpg':
      case 'mpeg':
      case '3gp':
        return Icons.videocam;
      case 'jpeg':
      case 'jpg':
      case 'png':
      case 'gif':
      case 'gifv':
      case 'webp':
      case 'tiff':
      case 'bmp':
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  static String getFileNameFromPathWithExtension(String path) {
    return pathlib.basename(path);
  }

  static String getFileNameFromPathWithoutExtension(String path) {
    return pathlib.basenameWithoutExtension(path);
  }

  static String getExtensionFromFileName(String path) {
    return pathlib.extension(path);
  }

  static Future<void> writeBytesToPath(String path, List<int> bytes) async {
    await File(path).writeAsBytes(bytes);
  }
}