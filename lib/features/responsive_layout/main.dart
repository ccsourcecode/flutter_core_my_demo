import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'ui/views/home_view.dart';

void main() =>
    runApp(DevicePreview(builder: (context) => ResponsiveLayoutApp()));

class ResponsiveLayoutApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: DevicePreview.appBuilder,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeView());
  }
}
