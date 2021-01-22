import 'dart:async';
import 'dart:io';
import 'package:mediadrip/utilities/file_helper.dart';
import 'package:path/path.dart' as pathlib;
import 'package:path_provider/path_provider.dart';

/// Used in services to restrict access to the available directories.
/// 
/// [root] is the root directory for file storage. This directory is located in the device's documents directory. 
/// Check [PathService.mediaDripFolderName] for the directory name.
/// 
/// [configuration] is a subdirectory. Check [PathService.configFolderName] for the directory name.
/// 
/// [downloads] is a subdirectory. Check [PathService.downloadsFolderName] for the directory name.
enum AvailableDirectories {
  root,
  configuration,
  downloads 
}

class PathService {
  final String mediaDripFolderName = 'MediaDrip';
  final String configFolderName = 'config';
  final String downloadsFolderName = 'downloads';

  Future<String> get documents async {
    var directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<String> get mediaDripDirectory async {
    var documentPath = await documents;

    return await _getJoinedPathFromDirectory(mediaDripFolderName, documentPath);
  }

  Future<String> get configDirectory async {
    return await _getJoinedPathFromDirectoryEnum(configFolderName, AvailableDirectories.root);
  }

  Future<String> get downloadsDirectory async {
    return await _getJoinedPathFromDirectoryEnum(downloadsFolderName, AvailableDirectories.root);
  }

  /// Used in retrieving and saving files, as well as providing platform-agnostic paths to specified directories 
  /// found in [AvailableDirectories]. These available directories are converted in the 
  /// [convertDirectoryEnumToPath] method.
  PathService();

  /// Converts a given directory from [AvailableDirectories] to String format.
  Future<String> convertDirectoryEnumToPath(AvailableDirectories directory) async {
    String finalizedDirectory;

    switch(directory) {
      case AvailableDirectories.configuration:
        finalizedDirectory = await configDirectory;
      break;
      case AvailableDirectories.downloads:
        finalizedDirectory = await downloadsDirectory;
      break;
      case AvailableDirectories.root:
      default:
        finalizedDirectory = await mediaDripDirectory;
      break;
    }

    return finalizedDirectory;
  }

  Future<bool> fileExistsInDirectory(String fileName, AvailableDirectories directory) async {
    var finalizedDirectory = await convertDirectoryEnumToPath(directory);
    var path = pathlib.join(finalizedDirectory, fileName);

    return await File(path).exists();
  }

  /// Creates a file with the specified [fileName] and [contents] within the given [directory].
  /// 
  /// Files are always overwritten.
  Future<void> createFileInDirectory(String fileName, String contents, AvailableDirectories directory) async {
    var file = await getFileFromFileName(fileName, directory);

    return await file.writeAsString(contents);
  }

  /// Creates a file with the specified [fileName] and [contents] within the given [directory].
  /// 
  /// Files are always overwritten.
  Future<void> createFileInDirectoryFromBytes(String fileName, List<int> contents, AvailableDirectories directory) async {
    var file = await getFileFromFileName(fileName, directory);

    return await file.writeAsBytes(contents);
  }

  /// Validates a [fileName] by removing invalid characters.
  /// 
  /// Returned is the valid filename.
  String validateFileName(String fileName) {
    return fileName.replaceAll(RegExp('[\\~#%&*{}/:<>?|"]'), '');
  }

  Future<File> getFileFromFileName(String fileName, AvailableDirectories directory) async {
    var finalizedDirectory = await convertDirectoryEnumToPath(directory);
    var validatedFileName = validateFileName(fileName);
    var path = pathlib.join(finalizedDirectory, validatedFileName);

    return File(path);
  }

  Future<String> _getJoinedPathFromDirectory(String path, String directory) async {
    var joinedPath = pathlib.join(directory, path);
    var getFinalizedDirectory = await FileHelper.getDirectorySafely(joinedPath);

    return getFinalizedDirectory.path;
  }

  Future<String> _getJoinedPathFromDirectoryEnum(String path, AvailableDirectories directory) async {
    var convertedDirectory = await convertDirectoryEnumToPath(directory);

    return _getJoinedPathFromDirectory(path, convertedDirectory);
  }
}