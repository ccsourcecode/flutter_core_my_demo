import 'package:flutter/material.dart';
import 'services/connectivity_service.dart';
import 'ui/home.dart';
import 'package:provider/provider.dart';

import 'enums/connectivity_status.dart';

class NetworkSensitivityApp extends StatelessWidget {
  const NetworkSensitivityApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // allows us to access any value from that stream using Provider.of<ConnectivityStatus>(context) anywhere
    // in our app. When a new value is emitted this value automatically updates and the widget using it
    // is rebuilt.
    return StreamProvider<ConnectivityStatus>(
      initialData: ConnectivityStatus.Startup,
      create: (context) =>
          ConnectivityService().connectionStatusController.stream,
      child: MaterialApp(
        title: 'Connectivity Aware UI',
        theme: ThemeData(
            textTheme: Theme.of(context)
                .textTheme
                .apply(bodyColor: Colors.white, displayColor: Colors.white)),
        home: HomeView(),
      ),
    );
  }
}
