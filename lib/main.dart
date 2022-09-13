import 'package:core_example/features/custom_UI.dart';
import 'package:core_example/features/fetch_location/fetch_location.dart';
import 'package:core_example/features/gesture.dart';
import 'package:core_example/features/google_sheet/google_sheet.dart';
import 'package:core_example/features/multi_screen.dart';
import 'package:core_example/widget_demo.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../features/page2.dart';
import 'features/admob/google_ad.dart';
import 'features/animation.dart';
import 'features/background_location/background_location.dart';
import 'features/background_locator/background_locator.dart';
import 'features/data_persist.dart';
import 'features/flutter_map/flutter_map.dart';
import 'features/google_map/google_map.dart';
import 'features/list_view.dart';
import 'features/logger/logger_flutter.dart';
import 'features/logger/logger_util.dart';
import 'features/network.dart';
import 'features/performance.dart';
import 'features/provider.dart';
import 'features/lifecycle/life_cycle_page.dart';
import 'features/provider/counter_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'features/webview/webview_app.dart';
import 'l10n/generated/l10n.dart';
import 'dart:async';

// void main() {
//   runApp(const MyApp());
// }

Future<void> main() async {
  log();

  FlutterError.onError = (FlutterErrorDetails details) async {
    //將異常轉發至Zone
    Zone.current.handleUncaughtError(details.exception, details.stack!);
  };

  await runZonedGuarded(() async {
    runApp(const MyApp());
    // orginalCallback = window.onReportTimings;
    // window.onReportTimings = onReportTimings;

    // // * This code will present some error UI if any uncaught exception happens
    // FlutterError.onError = (FlutterErrorDetails details) {
    //   FlutterError.presentError(details);
    // };

    // ErrorWidget.builder = (FlutterErrorDetails details) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: Colors.red,
    //       title: const Text('An error occurred'),
    //     ),
    //     body: Center(child: Text(details.toString())),
    //   );
    // };
  }, (Object error, StackTrace stack) {
    // errorLogger.logError(error, stack);
    print(error);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider.value(value: 30.0),
          ChangeNotifierProvider.value(value: CounterModel())
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            L10n.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: L10n.supportedLocales,
          onGenerateTitle: (context) {
            return L10n.of(context)!.main_title;
          },
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TextButton(
                child: const Text("Switch to Page 2"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page2()),
                ),
              ),
              TextButton(
                child: const Text("Google Map"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GoogleMapApp()),
                ),
              ),
              TextButton(
                child: const Text("List View"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ListViewPage(title: 'List View')),
                ),
              ),
              TextButton(
                child: const Text("Custom UI"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const CustomUIPage(title: 'Custom UI')),
                ),
              ),
              TextButton(
                child: const Text("Gesture"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GesturePage(
                            title: 'Gesture',
                          )),
                ),
              ),
              TextButton(
                child: const Text("Animation"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const AnimationPage(title: 'Animation')),
                ),
              ),
              TextButton(
                child: const Text("Network"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const NetworkPage(title: 'Network')),
                ),
              ),
              TextButton(
                child: const Text("Data Persist"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const DataPersistPage(title: 'Data Persist')),
                ),
              ),
              TextButton(
                child: const Text("Provider"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProviderPage()),
                ),
              ),
              TextButton(
                child: const Text("Flutter Push"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const DataPersistPage(title: 'Flutter Push')),
                ),
              ),
              TextButton(
                child: const Text("Multi Screen"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MultiScreenPage(title: 'Multi Screen')),
                ),
              ),
              TextButton(
                child: const Text("Performance"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PerformancePage(title: 'Performance')),
                ),
              ),
              TextButton(
                child: const Text("Flutter Map"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FlutterMapApp()),
                ),
              ),
              TextButton(
                child: const Text("Google sheet"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GoogleSheetsApp()),
                ),
              ),
              TextButton(
                child: const Text("Fetch location using geolocator"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FetchLocationPage(
                            title: 'Fetch location',
                          )),
                ),
              ),
              TextButton(
                child: const Text("Background location *"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BackgroundLocationApp()),
                ),
              ),
              TextButton(
                child: const Text("Background locator #"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BackgroundLocatorApp()),
                ),
              ),
              TextButton(
                child: const Text("Google Ad"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GoogleAdApp()),
                ),
              ),
              TextButton(
                child: const Text("Web view"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WebViewApp()),
                ),
              ),
              TextButton(
                child: const Text("Widget Demo Page"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WidgetDemoPage(
                            title: 'Widget Demo Page',
                          )),
                ),
              ),
              TextButton(
                child: const Text("Life cycle"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LifeCyclePage()),
                ),
              ),
              TextButton(
                child: const Text("Open debug console"),
                onPressed: () => LogConsole.open(context),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
