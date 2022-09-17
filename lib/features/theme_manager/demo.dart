import 'dart:async';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider.value(value: ThemeManager()),
          StreamProvider<ThemeData>(
            create: (_) {
              return Provider.of<ThemeManager>(context, listen: false).theme;
            },
            initialData: ThemeData(),
            // builder: (context, __) {},
          ),
        ],
        child: MaterialApp(
          title: 'Theme Manager Demo',
          home: HomeView(),
        ));
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ThemeManager>(context).changeTheme();
        },
      ),
    );
  }
}

class ThemeManager {
  int _currentTheme = 0;

  final StreamController<ThemeData> _themeController =
      StreamController<ThemeData>();

  final List<ThemeData> _availableThemes = [
    ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.blue,
      background: Colors.red,
    )),
    ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Colors.yellow, background: Colors.green)),
    ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Colors.pink, background: Colors.purple)),
    ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Colors.red, background: Colors.blue)),
  ];

  Stream<ThemeData> get theme => _themeController.stream;

  Future _updateStatusBarColor(ThemeData themeToApply) async {
    // Set status bar color
    await FlutterStatusbarcolor.setStatusBarColor(
        themeToApply.colorScheme.secondary);

    // Check the constrast between the colors and set the status bar icons colors to white or dark
    if (useWhiteForeground(themeToApply.colorScheme.secondary)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }
  }

  Future changeTheme() async {
    _currentTheme++;
    if (_currentTheme >= _availableThemes.length) {
      _currentTheme = 0;
    }

    // Get the theme to apply
    var themeToApply = _availableThemes[_currentTheme];

    // Update status bar color
    await _updateStatusBarColor(themeToApply);
    // Broadcast new theme
    _themeController.add(themeToApply);
  }
}
