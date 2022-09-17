import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dialog_helper.dart';

class DialogApp extends StatefulWidget {
  const DialogApp({Key? key}) : super(key: key);

  @override
  _DialogAppState createState() => _DialogAppState();
}

class _DialogAppState extends State<DialogApp> {
  var alertStyle = AlertStyle(
    overlayColor: Colors.blue[400]!,
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descStyle: const TextStyle(fontWeight: FontWeight.bold),
    animationDuration: const Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
      side: const BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: const TextStyle(
      color: Color.fromRGBO(91, 55, 185, 1.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: MaterialButton(
                color: Colors.yellow,
                child: const Text('Show Alert 1'),
                onPressed: () {
                  // Show a basic widget
                  Alert(
                    context: context,
                    style: alertStyle,
                    type: AlertType.info,
                    title: "FilledStacks",
                    desc: "FilledStacks.com has the best Flutter tutorials",
                    buttons: [
                      DialogButton(
                        onPressed: () => Navigator.pop(context),
                        color: const Color.fromRGBO(91, 55, 185, 1.0),
                        radius: BorderRadius.circular(10.0),
                        child: const Text(
                          "COOL",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ).show();
                },
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.yellow,
                child: const Text('Show Alert 2'),
                onPressed: () {
                  // Show a basic widget
                  Alert(
                      context: context,
                      title: "LOGIN",
                      content: Column(
                        children: const <Widget>[
                          TextField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.account_circle),
                              labelText: 'Username',
                            ),
                          ),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock),
                              labelText: 'Password',
                            ),
                          ),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ]).show();
                },
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.yellow,
                child: const Text('Show Alert 3'),
                onPressed: () {
                  showLoginWidget(context,
                      onLoginPressed: () {}); // <-- Much better readability
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
