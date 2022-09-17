import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[400],
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: Center(
          child: Text(
        runtimeType.toString(),
        style: const TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
      )),
    );
  }
}
