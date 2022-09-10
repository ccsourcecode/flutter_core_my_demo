import 'package:flutter/material.dart';

import 'demo.dart';

class ButtonAppPage extends StatefulWidget {
  const ButtonAppPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ButtonAppPageState createState() => _ButtonAppPageState();
}

class _ButtonAppPageState extends State<ButtonAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: DemoElevatedButton(),
      ),
    );
  }
}
