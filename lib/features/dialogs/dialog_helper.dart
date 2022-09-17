import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// creating a dialog helper file where you can store all your styles and predefined widgets.
void showLoginWidget(BuildContext context,
    {TextEditingController? usernameController,
    TextEditingController? loginController,
    Function? onLoginPressed}) {
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
          onPressed: () => onLoginPressed,
          child: const Text(
            "LOGIN",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
