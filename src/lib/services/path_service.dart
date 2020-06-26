import 'dart:io';
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

/// Used in retrieving and saving files, as well as providing platform-agnostic paths to specified directories 
/// found in [AvailableDirectories]. These available directories are converted in the 
/// [convertDirectoryEnumToPath] method.
/// 
/// Currently tested on the following platforms:
/// * Windows 10
/// 
/// At some point, I need to test that the backslashes work cross-platform.
class PathService {
  final String mediaDripFolderName = 'MediaDrip';
  final String configFolderName = 'config';
  final String downloadsFolderName = 'downloads';

  /// Returns the device's documents directory.
  /// 
  /// If -- and that's a big if -- I decide to support MediaDrip for web, I may need to update this or the path  
  /// provider package will handle it for me.
  Future<String> get documents async {
    var directory = await getApplicationDocumentsDirectory();

    return directory.path.replaceAll('\\', '/');
  }

  /// Returns the application directory found within the device's documents.
  /// 
  /// Refer to [documents] and [mediaDripFolderName] for more information.
  Future<String> get mediaDripDirectory async {
    var documentsPath = await documents;
    var directory = await _createDirectoryIfNotExists('$documentsPath/$mediaDripFolderName');

    return directory.path;
  }

  /// Returns the configuration directory found within the application's root directory.
  /// 
  /// Refer to [mediaDripFolderName] for more information.
  Future<String> get configDirectory async {
    var rootPath = await mediaDripDirectory;
    var directory = await _createDirectoryIfNotExists('$rootPath/$configFolderName');

    return directory.path;
  }

  /// Returns the downloads directory found within the application's root directory.
  /// 
  /// Refer to [mediaDripFolderName] for more information.
  Future<String> get downloadsDirectory async {
    var rootPath = await mediaDripDirectory;
    var directory = await _createDirectoryIfNotExists('$rootPath/$downloadsFolderName');

    return directory.path;
  }

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

  /// Returns a boolean for the given [fileName] found within [directory].
  Future<bool> fileExistsInDirectory(String fileName, AvailableDirectories directory) async {
    var finalizedDirectory = await convertDirectoryEnumToPath(directory);

    return await File('$finalizedDirectory/$fileName').exists();
  }

  /// Creates a file with the specified [fileName] and [contents] within the given [directory].
  /// 
  /// Files are always overwritten.
  Future<void> createFileInDirectory(String fileName, String contents, AvailableDirectories directory) async {
    var finalizedDirectory = await convertDirectoryEnumToPath(directory);

    if(await Directory(finalizedDirectory).exists()) {
      var validatedFileName = validateFileName('$fileName');

      await File('$finalizedDirectory/$validatedFileName').writeAsString(contents);
    }
  }

  /// Creates a file with the specified [fileName] and [contents] within the given [directory].
  /// 
  /// Files are always overwritten.
  Future<void> createFileInDirectoryFromBytes(String fileName, List<int> contents, AvailableDirectories directory) async {
    var finalizedDirectory = await convertDirectoryEnumToPath(directory);

    if(await Directory(finalizedDirectory).exists()) {
      var validatedFileName = validateFileName('$fileName');

      await File('$finalizedDirectory/$validatedFileName').writeAsBytes(contents);
    }
  }

  /// Returns the file that corresponds to the given [fileName] and [directory].
  Future<File> getFileInDirectory(String fileName, AvailableDirectories directory) async {
    var finalizeDirectory = await convertDirectoryEnumToPath(directory);

    return File('$finalizeDirectory/$fileName');
  }

  /// Returns the path from a given [fileName] and [directory].
  Future<String> getPathOfFileInDirectory(String fileName, AvailableDirectories directory) async {
    var file = await getFileInDirectory(fileName, directory);

    return file.path;
  }

  /// Validates a [fileName] by removing invalid characters.
  /// 
  /// Returned is the valid filename.
  String validateFileName(String fileName) {
    return fileName.replaceAll(RegExp('[\\~#%&*{}/:<>?|"-]'), '');
  }

  /// Splits [fileName] and returns the last occurrence.
  String getExtensionFromFileName(String fileName) {
    return fileName.split('.').last;
  }

  /// Safely returns a directory. If the directory does not exist, it will be created first 
  /// based on the given [path].
  Future<Directory> _createDirectoryIfNotExists(String path) async {
    var directory = Directory(path);

    if(!await directory.exists())
      await directory.create();

    return directory;
  }
}