import 'package:get_it/get_it.dart';

import 'services/button_message_bus.dart';

// This is our global ServiceLocator
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(ButtonMessagebus());
}
