import './views/home_view.dart';
import 'package:flutter/material.dart';

class InfiniteScrollApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomeView(),
    );
  }
}
