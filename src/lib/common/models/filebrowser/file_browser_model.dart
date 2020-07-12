import 'package:flutter/cupertino.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/index.dart';

class FileBrowserModel extends ChangeNotifier {
  final PathService _pathService = locator<PathService>();

  Future<List<FileEntity>> getFiles() async {
    var files = await _pathService.getAllFilesInDirectory(AvailableDirectories.downloads);

    return files;
  }
}