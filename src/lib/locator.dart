import 'package:get_it/get_it.dart';
import 'package:mediadrip/services/download_service.dart';
import 'package:mediadrip/services/feed_service.dart';
import 'package:mediadrip/services/path_service.dart';
import 'package:mediadrip/services/settings_service.dart';
import 'package:mediadrip/services/view_manager_service.dart';

/// Locates registered services using the Get_It package.
/// 
/// Version 4.0.2
/// 
/// [Github repository](https://pub.dev/packages/get_it)
final locator = GetIt.instance;

/// Registers services using the Get_It package.
///
/// [PathService], [SettingsService], and [ViewManagerService] are registered here.
void setupLocator() {
  locator.registerLazySingleton(() => PathService());
  locator.registerLazySingleton(() => SettingsService());
  locator.registerLazySingleton(() => DownloadService());
  locator.registerLazySingleton(() => FeedService());
  locator.registerLazySingleton(() => ViewManagerService());
}