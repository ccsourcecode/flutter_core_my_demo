import 'package:flutter/material.dart';

import 'demo.dart';

class ColumnAppPage extends StatefulWidget {
  const ColumnAppPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ColumnAppPageState createState() => _ColumnAppPageState();
}

class _ColumnAppPageState extends State<ColumnAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: DemoColumn(),
      ),
    );
  }
}
