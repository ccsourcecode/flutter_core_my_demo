import 'dart:developer';

import './api_manager.dart';
import './api_model.dart';
import 'package:flutter/material.dart';

class DartzAppPage extends StatefulWidget {
  const DartzAppPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DartzAppPageState createState() => _DartzAppPageState();
}

class _DartzAppPageState extends State<DartzAppPage> {
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
              onPressed: () async {
                final getUser = await userRepository.getUser(1);
                getUser.fold(
                  (failure) => log("$failure"),
                  (get) => log("$get"),
                );
              },
            ),
            TextButton(
              child: const Text(
                "POST",
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () async {
                final createUser = await userRepository.createUser(
                  User(
                    username: "username",
                    password: "password",
                  ),
                );
                createUser.fold(
                  (failure) => log("$failure"),
                  (get) => log("$get"),
                );
              },
            ),
            TextButton(
              child: const Text(
                "PULL",
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () async {
                final updateUser = await userRepository.updateUser(
                  1,
                  User(
                    username: "username",
                    password: "xdrcftvgybhunijcftvgbh",
                  ),
                );

                updateUser.fold(
                  (failure) => log("$failure"),
                  (get) => log("$get"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
