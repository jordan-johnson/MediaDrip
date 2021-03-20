import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as pathlib;
import 'package:flutter/material.dart';
import 'package:mediadrip/models/file/index.dart';

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

  static Future<FolderItem> buildFolderContentsFromPath(String path) async {
    var completer = Completer<FolderItem>();
    var listing = Directory(path).list();

    var currentFolder = FolderItem(
      name: getFileNameFromPathWithoutExtension(path),
      path: path,
      type: FileSystemEntityType.directory
    );

    listing.listen((item) {
      _addItemToFolder(item, currentFolder);
    }, onDone: () => completer.complete(currentFolder));

    return completer.future;
  }

  static void _addItemToFolder(FileSystemEntity entity, FolderItem folder) {
    var entityPath = entity.path;
    var entityType = FileSystemEntity.typeSync(entityPath);

    switch(entityType) {
      case FileSystemEntityType.directory:
        var folderItem = FolderItem(
          name: getFileNameFromPathWithoutExtension(entityPath),
          path: entityPath,
          type: FileSystemEntityType.directory
        );

        folder.subFolders.add(folderItem);
      break;
      case FileSystemEntityType.file:
      default:
        var fileData = File(entityPath);
        var file = FileItem(
          name: getFileNameFromPathWithExtension(entityPath),
          path: entityPath,
          type: FileSystemEntityType.file,
          lastModified: fileData.lastModifiedSync(),
          size: fileData.lengthSync(),
          data: fileData
        );

        folder.files.add(file);
      break;
    }
  }
}