import 'package:flutter/material.dart';
import 'ui/views/home_view.dart';
import './service_locator.dart';

void main() {
  // Register all the models and services before the app starts
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Skeleton Watcher',
        theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 9, 202, 172),
            textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Open Sans',
                bodyColor: Colors.white,
                displayColor: Colors.white),
            colorScheme: const ColorScheme(
              background: Color.fromARGB(255, 26, 27, 30),
              brightness: Brightness.light,
              onBackground: Color.fromARGB(253, 118, 147, 205),
              primary: Color.fromARGB(253, 118, 147, 205),
              onPrimary: Color.fromARGB(253, 118, 147, 205),
              secondary: Color.fromARGB(253, 118, 147, 205),
              onSecondary: Color.fromARGB(253, 118, 147, 205),
              error: Color.fromARGB(253, 118, 147, 205),
              onError: Color.fromARGB(253, 118, 147, 205),
              surface: Color.fromARGB(253, 118, 147, 205),
              onSurface: Color.fromARGB(253, 118, 147, 205),
            )),
        home: HomeView());
  }
}
