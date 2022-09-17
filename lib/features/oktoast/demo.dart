import 'package:oktoast/oktoast.dart';
import 'package:flutter/material.dart';

class OKtoastApp extends StatelessWidget {
  const OKtoastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.grey[900],
          body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    child: const Text("Simple toast"),
                    onPressed: () {
                      showToast('Hello FilledStacks',
                          position: ToastPosition.bottom);
                    },
                  ),
                  TextButton(
                    child: const Text("Styled toast"),
                    onPressed: () {
                      showToast(
                        'Hello FilledStacks',
                        duration: const Duration(seconds: 2),
                        position: ToastPosition.bottom,
                        backgroundColor: Colors.white,
                        radius: 5.0,
                        textStyle: const TextStyle(
                            fontSize: 16.0, color: Colors.black),
                      );
                    },
                  ),
                  TextButton(
                    child: const Text("Custom toast"),
                    onPressed: () {
                      showToastWidget(
                          const ToastWidget(
                            title: 'FilledStacks',
                            description: 'Write Better Code',
                          ),
                          duration: const Duration(seconds: 5));
                    },
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class ToastWidget extends StatelessWidget {
  final String title;
  final String description;
  const ToastWidget(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            width: 140.0,
            height: 50.0,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w900),
                ),
                Text(
                  description,
                  style: const TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
