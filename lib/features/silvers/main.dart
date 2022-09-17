import 'package:flutter/material.dart';
import './home_page.dart';

class SilverListApp extends StatelessWidget {
  @override
  const SilverListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(),
    );
  }
}
