import 'package:get_it/get_it.dart';

import 'services/localstorage_service.dart';

// This is our global ServiceLocator
GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  var instance = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(instance);
}
