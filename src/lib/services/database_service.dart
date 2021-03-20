import 'dart:ffi';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:mediadrip/exceptions/sqlite_not_found_exception.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/models/database/itable.dart';
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

    try {
      switch(Platform.operatingSystem) {
        case 'windows':
          await _loadWindowsBinary();
        break;
      }
    } on SqliteNotFoundException catch(e) {
      // display an alert that sqlite library not found
    }
  }

  Future<void> openConnection() async {
    if(_sqliteDatabase != null)
      return;

    var databaseExists = await _path.fileExistsInDirectory(_databaseFileName, AvailableDirectories.root);

    if(databaseExists) {
      var documentsDirectory = await _path.mediaDripDirectory;
      var path = join(documentsDirectory, _databaseFileName);

      _sqliteDatabase = sqlite3.open(path);
    } else {
      await _copyDatabaseAssetToDocuments();
    }
  }

  // KEEP WORKING ON THIS WHEN RETURN
  // need to plan out a clean way to insert records into a table
  Future<void> insert(ITable table) async {
    var prepare = table.prepare();
  }

  void closeConnection() {
    if(_sqliteDatabase == null)
      return;

    print('closed connection');

    _sqliteDatabase.dispose();
  }

  Future<void> _loadWindowsBinary() async {
    var exeDirectory = File(Platform.resolvedExecutable).parent;
    var sqliteLibrary = File('${exeDirectory.path}\\sqlite3.dll');
    var exists = await sqliteLibrary.exists();

    if(exists) {
      open.overrideFor(OperatingSystem.windows, () => DynamicLibrary.open(sqliteLibrary.path));
    } else {
      throw new SqliteNotFoundException('Missing sqlite3.dll in application directory!');
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