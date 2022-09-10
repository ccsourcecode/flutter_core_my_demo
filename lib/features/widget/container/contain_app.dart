import 'package:flutter/material.dart';

import 'demo.dart';

class ContainerAppPage extends StatefulWidget {
  const ContainerAppPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ContainerAppPageState createState() => _ContainerAppPageState();
}

class _ContainerAppPageState extends State<ContainerAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: DemoDecorationContainer(),
      ),
    );
  }
}
