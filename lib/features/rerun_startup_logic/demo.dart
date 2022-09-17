import 'dart:async';

import 'package:flutter/material.dart';

enum StartupState { Busy, Success, Error }

class RerunStartupApp extends StatelessWidget {
  // the StreamController that will emit our state and future
  final StreamController<StartupState> _startupStatus =
      StreamController<StartupState>();

  RerunStartupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StatefulWrapper(
          onInit: () => getImportantData(isError: true),
          child: StreamBuilder<StartupState>(
            stream: _startupStatus.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == StartupState.Busy) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Text('Show your app logo here'),
                      CircularProgressIndicator()
                    ],
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('${snapshot.error} Retry?'),
                    IconButton(
                      icon: const Icon(
                        Icons.refresh,
                        size: 55,
                      ),
                      onPressed: () {
                        getImportantData();
                      },
                    )
                  ],
                ));
              }

              // when success
              return Container(color: Colors.yellow);
            },
          ),
        ),
      ),
    );
  }

  Future getImportantData({bool isError = false}) async {
    // the StreamController that will emit our state and the future that will do the important work
    // and add states onto the stream.
    _startupStatus.add(StartupState.Busy);
    await Future.delayed(const Duration(seconds: 2));

    if (isError) {
      _startupStatus.add(StartupState.Error);
    } else {
      _startupStatus.add(StartupState.Success);
    }
  }
}

class StatefulWrapper extends StatefulWidget {
  // We want the future to be called when the view is initialised
  // so we'll use our StatefulWrapper and pass an onInit function.
  // the child of that wrapper will be a StreamBuilder that takes the startupStatus stream.
  final Function onInit;
  final Widget child;
  const StatefulWrapper({Key? key, required this.onInit, required this.child})
      : super(key: key);

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
