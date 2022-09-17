import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class InAppNotificationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
        child: MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
          body: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                onPressed: () {
                  showSimpleNotification(
                    const Text("Subscribe to FilledStacks"),
                    background: Colors.purple,
                  );
                },
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: () {
                  showOverlayNotification((context) {
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: SafeArea(
                        child: ListTile(
                          leading: SizedBox.fromSize(
                              size: const Size(40, 40),
                              child: ClipOval(
                                  child: Container(
                                color: Colors.black,
                              ))),
                          title: const Text('FilledStacks'),
                          subtitle:
                              const Text('Thanks for checking out my tutorial'),
                          trailing: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                OverlaySupportEntry.of(context)!.dismiss();
                              }),
                        ),
                      ),
                    );
                  }, duration: const Duration(milliseconds: 4000));
                },
              )),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                showSimpleNotification(
                  const Text("Subscribe to FilledStacks"),
                  background: Colors.purple,
                  autoDismiss: false,
                  trailing: Builder(builder: (context) {
                    return TextButton(
                        // textColor: Colors.yellow,
                        onPressed: () {
                          OverlaySupportEntry.of(context)!.dismiss();
                        },
                        child: const Text('Dismiss'));
                  }),
                );
              },
            ),
          ),
        ],
      )),
    ));
  }
}
