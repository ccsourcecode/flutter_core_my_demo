import 'package:flutter/material.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  void initState() {
    _getThingsOnStartup().then((value) {
      print('Async done');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}

// -----------------------------------------

/// Wrapper for stateful functionality to provide onInit calls in stateless widget
class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;

  const StatefulWrapper({required this.onInit, required this.child});

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

// Wrap your stateless widget's UI in a StatefulWrapper and pass on the onInit logic you would like to run

class StartupCaller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        _getThingsOnStartup().then((value) {
          print('Async done');
        });
      },
      child: Container(),
    );
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
