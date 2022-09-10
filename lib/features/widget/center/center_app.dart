import 'package:flutter/material.dart';

import 'demo.dart';

class CenterAppPage extends StatefulWidget {
  const CenterAppPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CenterAppPageState createState() => _CenterAppPageState();
}

class _CenterAppPageState extends State<CenterAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: DemoCenter(),
      ),
    );
  }
}
