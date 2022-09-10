import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'menu.dart';
import 'navigation_controls.dart';
import 'web_view_stack.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  // Instantiate the controller
  final controller = Completer<WebViewController>();

//! Don't forget to change the minSdkVersion in the build.gradle to 19
//! when you want to use the Hybrid composition Platform View.
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView'),
        actions: [
          NavigationControls(controller: controller),
          Menu(
              controller:
                  controller), // To add the menu to the WebViewApp's screen
        ],
      ),
      body: WebViewStack(controller: controller), // Add the controller argument
      // const WebView( initialUrl: 'https://flutter.dev',),
    );
  }
}
