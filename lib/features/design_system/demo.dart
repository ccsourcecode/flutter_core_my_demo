import 'package:core_example/features/design_system/ui_library.dart';
import 'package:flutter/material.dart';

import 'example_view.dart';

class DesignSystemApp extends StatelessWidget {
  const DesignSystemApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kcPrimaryColor,
      ),
      home: const ExampleView(),
    );
  }
}
