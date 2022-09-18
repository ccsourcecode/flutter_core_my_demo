import 'package:flutter/material.dart';
import '../responsive-uilder.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 150,
                  margin: const EdgeInsets.all(50),
                  color: Colors.blue,
                  child: ResponsiveBuilder(
                    builder: (context, sizingInfo) =>
                        Text(sizingInfo.toString()),
                  ),
                ),
                Text(sizingInformation.toString()),
              ],
            ),
          ),
        );
      },
    );
  }
}
