import 'package:mediadrip/exceptions/data_source_exception.dart';

abstract class DataSource<T> {
  Future<void> init() async => throw DataSourceException('Not implemented.');
  Future<void> openConnection() async => throw DataSourceException('Not implemented.');
  Future<void> closeConnection() async => throw DataSourceException('Not implemented.');
  Future<void> execute(void Function(T source) action) async => throw DataSourceException('Not implemented.');
  Future<R> retrieve<R>(R Function(T source) action) async => throw DataSourceException('Not implemented.');
  T getDatabase() => throw DataSourceException('Not implemented.');
}