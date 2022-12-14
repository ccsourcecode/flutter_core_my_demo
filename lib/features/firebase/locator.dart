import './services/analytics_service.dart';
import './services/authentication_service.dart';
import './services/cloud_storage_service.dart';
import './services/firestore_service.dart';
import './services/push_notification_service.dart';
import './utils/image_selector.dart';
import 'package:get_it/get_it.dart';
import './services/navigation_service.dart';
import './services/dialog_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => CloudStorageService());
  locator.registerLazySingleton(() => ImageSelector());
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => AnalyticsService());
}
