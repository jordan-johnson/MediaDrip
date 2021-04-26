import 'dart:ffi';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:mediadrip/exceptions/data_source_exception.dart';
import 'package:mediadrip/exceptions/sqlite_not_found_exception.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/logging.dart';
import 'package:mediadrip/services/database/data_source.dart';
import 'package:mediadrip/services/index.dart';
import 'package:mediadrip/utilities/file_helper.dart';
import 'package:path/path.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';

class SqliteDatabase implements DataSource<Database> {
  final PathService _pathService = locator<PathService>();
  final Logger _log = getLogger('SqliteDatabase');
  final String _databaseFileName = 'core.db';

  Database _sqliteDatabase;
  String _databasePath;

  @override
  Future<void> init() async {
    if(_sqliteDatabase != null)
      return;

    _log.i('Initializing database...');

    await _checkIfLocalDatabaseExists();

    try {
      switch(Platform.operatingSystem) {
        case 'windows':
          await _loadWindowsBinary();
        break;
      }
    } on SqliteNotFoundException catch(e) {
      _log.e(e.message);
    }
  }

  @override
  Future<void> openConnection() async {
    if(_sqliteDatabase != null)
      return;

    _log.i('Opened database connection...');

    _sqliteDatabase = sqlite3.open(_databasePath);
  }

  @override
  Future<void> closeConnection() async {
    if(_sqliteDatabase == null)
      return;
    
    _log.i('Closing database connection...');

    _sqliteDatabase.dispose();
  }

  @override
  Database getDatabase() {
    if(_sqliteDatabase == null) {
      final error = 'Cannot get database; returned null. Please initialize.';

      _log.e(error);

      throw DataSourceException(error);
    }
    
    return _sqliteDatabase;
  }

  @override
  Future<void> execute(void Function(Database source) action) async {
    // if a connection already exists, don't open a new one
    if(_sqliteDatabase == null)
      await this.openConnection();

    final Database source = getDatabase();

    action(source);
  }

  @override
  Future<R> retrieve<R>(R Function(Database source) action) async {
    // if a connection already exists, don't open a new one
    if(_sqliteDatabase == null)
      await this.openConnection();

    final Database source = getDatabase();
    final returnValue = action(source);

    return returnValue;
  }

  Future<void> _checkIfLocalDatabaseExists() async {
    try {
      var databaseExists = await _pathService.fileExistsInDirectory(_databaseFileName, AvailableDirectories.root);
      var documentsDirectory = await _pathService.mediaDripDirectory;
      
      this._databasePath = join(documentsDirectory, _databaseFileName);

      if(!databaseExists) {
        await _copyDatabaseAssetToDocuments();
      }
    } catch(e, s) {
      _log.e(e.toString(), 'Database Asset Failure', s);
    }
  }

  Future<void> _loadWindowsBinary() async {
    var exeDirectory = File(Platform.resolvedExecutable).parent;
    var sqliteLibrary = File('${exeDirectory.path}\\sqlite3.dll');
    var exists = await sqliteLibrary.exists();

    if(exists) {
      open.overrideFor(OperatingSystem.windows, () => DynamicLibrary.open(sqliteLibrary.path));
    } else {
      throw SqliteNotFoundException('Missing sqlite3.dll in application directory!');
    }
  }

  Future<void> _copyDatabaseAssetToDocuments() async {
    var byteData = await rootBundle.load('lib/assets/' + _databaseFileName);
    var bytes = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    var documentsDirectory = await _pathService.mediaDripDirectory;
    
    documentsDirectory = join(documentsDirectory, _databaseFileName);

    await FileHelper.writeBytesToPath(documentsDirectory, bytes);
  }
}