import 'package:flutter/material.dart';
import 'service_locator.dart';
import './widgets/connected_button.dart';

/// Use RxDart to sync up UI events using Subjects as a MessageBus.
class RxDartApp extends StatefulWidget {
  const RxDartApp({Key? key}) : super(key: key);

  @override
  _RxDartAppState createState() => _RxDartAppState();
}

class _RxDartAppState extends State<RxDartApp> {
  @override
  void initState() {
    super.initState();
    setupLocator();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            backgroundColor: Colors.grey[800],
            body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                ConnectedButton(id: 0),
                ConnectedButton(id: 1),
                ConnectedButton(id: 2)
              ],
            )));
  }
}
