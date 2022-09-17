import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';
import 'services/localstorage_service.dart';
import 'signup.dart';
import 'service_locator.dart';

// There are much better ways to handle this but it's outside of the scope of this tutorial
Future<void> main() async {
  try {
    setupLocator();
    runApp(MyApp());
  } catch (error) {
    print('Locator setup has failed');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _getStartupScreen());
  }

  Widget _getStartupScreen() {
    var localStorageService = locator<LocalStorageService>();
    // User variable from DB
    var mySavedUser = localStorageService.user;

    if (!localStorageService.hasSignedUp) {
      return SignUpView();
    }

    if (!localStorageService.hasLoggedIn) {
      return LoginView();
    }

    return HomeView();
  }
}
