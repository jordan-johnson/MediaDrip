import 'package:get_it/get_it.dart';
import 'package:mediadrip/services/index.dart';

/// Locates registered services using the Get_It package.
/// 
/// Version 4.0.2
/// 
/// [Github repository](https://pub.dev/packages/get_it)
final locator = GetIt.instance;

/// Registers services using the Get_It package.
///
/// [PathService], [SettingsService], [DownloadService], and [FeedService] are registered here.
void setupLocator() {
  locator.registerLazySingleton(() => PathService());
  locator.registerLazySingleton(() => DatabaseService());
  locator.registerLazySingleton(() => SettingsService());
  locator.registerLazySingleton(() => DownloadService());
  locator.registerLazySingleton(() => FeedService());
}