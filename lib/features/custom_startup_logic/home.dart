import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: Center(
          child: Text(
        runtimeType.toString(),
        style: const TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
      )),
    );
  }
}
