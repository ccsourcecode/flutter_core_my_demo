import 'package:flutter/material.dart';

import 'demo.dart';

class TextFiledAppPage extends StatefulWidget {
  const TextFiledAppPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TextFiledAppPageState createState() => _TextFiledAppPageState();
}

class _TextFiledAppPageState extends State<TextFiledAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: DeomBaseTextField(),
      ),
    );
  }
}
