import './api_manager.dart';
import './api_model.dart';
import 'package:flutter/material.dart';

class HttpAppPage extends StatefulWidget {
  const HttpAppPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HttpAppPageState createState() => _HttpAppPageState();
}

class _HttpAppPageState extends State<HttpAppPage> {
  final UserRepository userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: const Text(
                "GET",
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                userRepository.getUser(1);
              },
            ),
            TextButton(
              child: const Text(
                "POST",
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                userRepository.createUser(
                  User(
                    username: "username",
                    password: "password",
                  ),
                );
              },
            ),
            TextButton(
              child: const Text(
                "PULL",
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                userRepository.updateUser(
                  1,
                  User(
                    username: "username",
                    password: "xdrcftvgybhunijcftvgbh",
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
