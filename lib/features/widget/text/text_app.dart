import 'package:flutter/material.dart';

import 'demo.dart';

class TextAppPage extends StatefulWidget {
  const TextAppPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TextAppPageState createState() => _TextAppPageState();
}

class _TextAppPageState extends State<TextAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: DemoTextFamily(),
      ),
    );
  }
}
