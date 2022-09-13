import 'app_theme.dart';
import 'game_route.dart';
import 'home_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleAdApp extends StatefulWidget {
  const GoogleAdApp({Key? key}) : super(key: key);

  @override
  _GoogleAdAppState createState() => _GoogleAdAppState();
}

class _GoogleAdAppState extends State<GoogleAdApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const HomeRoute(),
        '/game': (BuildContext context) => const GameRoute()
      },
      theme: ThemeData(
        primaryColor: AppTheme.primary,
        primaryColorDark: AppTheme.primaryDark,
        textTheme: GoogleFonts.acmeTextTheme().copyWith(
            button: GoogleFonts.ubuntuMono(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        )),
        buttonTheme: ButtonThemeData(
          buttonColor: AppTheme.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          textTheme: ButtonTextTheme.primary,
        ),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: AppTheme.accent),
      ),
    );
  }
}
