import './services/analytics_service.dart';
import './ui/views/startup_view.dart';
import 'package:flutter/material.dart';
import './services/navigation_service.dart';
import './services/dialog_service.dart';
import 'managers/dialog_manager.dart';
import 'ui/router.dart';
import 'locator.dart';

void main() {
  // Register all the models and services before the app starts
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compound',
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child!)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      navigatorObservers: [locator<AnalyticsService>().getAnalyticsObserver()],
      theme: ThemeData(
        primaryColor: const Color(0xff19c7c1),
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Open Sans',
            ),
      ),
      home: const StartUpView(),
      onGenerateRoute: generateRoute,
    );
  }
}
