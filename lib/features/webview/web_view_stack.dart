import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, super.key});

  final Completer<WebViewController> controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // During the WebView page load cycle there are three different page load events that are fired:
        // onPageStarted, onProgress, and onPageFinished
        WebView(
          initialUrl: 'https://flutter.dev',
          onWebViewCreated: (webViewController) {
            widget.controller.complete(webViewController);
          },
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          // register a NavigationDelegate callback to block navigation to YouTube.com.
          navigationDelegate: (navigation) {
            final host = Uri.parse(navigation.url).host;
            if (host.contains('youtube.com')) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Blocking navigation to $host',
                  ),
                ),
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          javascriptMode: JavascriptMode.unrestricted, // To enable JavaScript
          // For each JavascriptChannel in the Set, a channel object is made available in the JavaScript
          // context as a window property named with the same name as the JavascriptChannel.name
          javascriptChannels: _createJavascriptChannels(context),
        ),
        // conditionally overlaying the WebView with a LinearProgressIndicator
        // when the page load percentage is less than 100%
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
          ),
      ],
    );
  }

// JavascriptChannels enable your app to register callback handlers in the WebView's JavaScript
// context that can be invoked to convey values back to the App's Dart code
// register a SnackBar channel that will be called with the result of a XMLHttpRequest.
  Set<JavascriptChannel> _createJavascriptChannels(BuildContext context) {
    return {
      JavascriptChannel(
        name: 'SnackBar',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        },
      ),
    };
  }
}
