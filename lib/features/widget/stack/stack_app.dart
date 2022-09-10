import 'package:flutter/material.dart';

import 'demo.dart';

class StackAppPage extends StatefulWidget {
  const StackAppPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _StackAppPageState createState() => _StackAppPageState();
}

class _StackAppPageState extends State<StackAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: DemoStack(),
      ),
    );
  }
}
