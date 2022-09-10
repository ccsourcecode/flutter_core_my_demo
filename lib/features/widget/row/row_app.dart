import 'package:flutter/material.dart';

import 'demo.dart';

class RowAppPage extends StatefulWidget {
  const RowAppPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _RowAppPageState createState() => _RowAppPageState();
}

class _RowAppPageState extends State<RowAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: DemoRow(),
      ),
    );
  }
}
