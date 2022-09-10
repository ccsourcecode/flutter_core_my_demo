import './auth_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class GoogleAppPage extends StatelessWidget {
  final AuthRepository _authRepository = AuthRepository();

  @override
  Future<void> initState() async {
    await Firebase.initializeApp();
  }

  GoogleAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GoogleApp")),
      body: Container(
        child: Center(
          child: TextButton(
            onPressed: () async {
              final ok = await _authRepository.signInWithGoogle();
              if (ok) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              }
            },
            child: const Text("SIGN IN"),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final AuthRepository _authRepository = AuthRepository();
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
      ),
      body: Container(
        child: Center(
          child: TextButton(
            onPressed: () async {
              await _authRepository.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => GoogleAppPage(),
                ),
              );
            },
            child: const Text("SIGN OUT"),
          ),
        ),
      ),
    );
  }
}
