import 'package:flutter/material.dart';

String getFileExtensionFromFileName(String fileName) {
  return fileName.split('.').last;
}

IconData getIconFromFileName(String fileName) {
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