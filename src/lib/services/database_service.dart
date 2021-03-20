import 'dart:ffi';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/index.dart';
import 'package:mediadrip/utilities/file_helper.dart';
import 'package:path/path.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';

class DatabaseService {
  final String _databaseFileName = 'core.db';

  PathService _path = locator<PathService>();

  Database _sqliteDatabase;

  Future<void> init() async {
    if(_sqliteDatabase != null)
      return;

    switch(Platform.operatingSystem) {
      case 'windows':
        await _loadWindowsBinary();
      break;
    }

    _loadDatabase();
  }

  Future<void> _loadWindowsBinary() async {
    var exeDirectory = File(Platform.resolvedExecutable).parent;
    var sqliteLibrary = File('${exeDirectory.path}\\sqlite3.dll');
    var exists = await sqliteLibrary.exists();

    if(exists) {
      // open.overrideFor(OperatingSystem.windows, () => DynamicLibrary.open(sqliteLibrary.path));

      
      // first create database then come back here to open the file
      // we'll need to include core.db in our assets directory
      // _sqliteDatabase = sqlite3.
    } else {
      print('nope');
    }
  }

  Future<void> _loadDatabase() async {
    if(_sqliteDatabase != null)
      return;

    var databaseExists = await _path.fileExistsInDirectory(_databaseFileName, AvailableDirectories.root);

    if(databaseExists) {
      // loading
    } else {
      await _copyDatabaseAssetToDocuments();
    }
  }

  Future<void> _copyDatabaseAssetToDocuments() async {
    var byteData = await rootBundle.load('lib/assets/' + _databaseFileName);
    var bytes = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    var documentsDirectory = await _path.mediaDripDirectory;
    
    documentsDirectory = join(documentsDirectory, _databaseFileName);

    await FileHelper.writeBytesToPath(documentsDirectory, bytes);
  }
}