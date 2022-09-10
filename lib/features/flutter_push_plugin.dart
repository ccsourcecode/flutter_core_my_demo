// import 'dart:async';

// import 'package:flutter/services.dart';

// typedef EventHandler = Future<dynamic> Function(String event);

// class FlutterPushPlugin {
//   factory FlutterPushPlugin() => _instance;

//   final MethodChannel _channel;
//   late EventHandler _onOpenNotification;

//   FlutterPushPlugin.private(MethodChannel channel) : _channel = channel {
//     _channel.setMethodCallHandler(_handleMethod);
//   }

//   setupWithAppID(String appID) {
//     _channel.invokeMethod("setup", appID);
//   }

//   setOpenNotificationHandler(EventHandler onOpenNotification) {
//     _onOpenNotification = onOpenNotification;
//   }

//   Future<void> _handleMethod(MethodCall call) async {
//     switch (call.method) {
//       case "onOpenNotification":
//         return _onOpenNotification(call.arguments);
//       default:
//         throw UnsupportedError("Unrecognized Event");
//     }
//   }

//   static final FlutterPushPlugin _instance =
//       FlutterPushPlugin.private(const MethodChannel('flutter_push_plugin'));

//   Future<String> get registrationID async {
//     final String regID = await _channel.invokeMethod('getRegistrationID');
//     return regID;
//   }
// }
