import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workmanager/workmanager.dart';
import '../logger/logger_util.dart';
import '../telegram/telegram.dart';
import 'notification.dart' as notif;

const fetchBackground = "fetchBackground";

void callbackDispatcher() {
  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  Workmanager().executeTask((task, inputData) async {
    DartPluginRegistrant.ensureInitialized();

    await Geolocator.checkPermission();
    await Geolocator.getCurrentPosition();

    switch (task) {
      case fetchBackground:
        try {
          //add code execution
          Position userLocation = await geolocatorPlatform.getCurrentPosition(
              locationSettings:
                  const LocationSettings(accuracy: LocationAccuracy.high));
          notif.Notification notification = notif.Notification();
          notification.showNotificationWithoutSound(userLocation);
        } catch (err) {
          logger.e("Error! Something bad happened", err.toString());
          // Logger().e(err
          //     .toString()); // Logger flutter package, prints error on the debug console
          throw Exception(err);
        }

        //Geolocator geoLocator = Geolocator()..forceAndroidLocationManager = true;

        break;
    }
    return Future.value(true);
  });
}

class FetchLocationPage extends StatefulWidget {
  const FetchLocationPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _FetchLocationPageState createState() => _FetchLocationPageState();
}

class _FetchLocationPageState extends State<FetchLocationPage> {
  final TelegramApp telegram = TelegramApp();
  late Position position;

  @override
  void initState() {
    super.initState();
    telegram.init();
    _getUserPosition();

    // We don't need it anymore since it will be executed in background
    //this._getUserPosition();

    // isInDebugMode: true
    // Once this flag is enabled you will receive a notification whenever a
    // background task was triggered.
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );

    Workmanager().registerPeriodicTask(
      "1",
      fetchBackground,
      frequency: const Duration(minutes: 15),
    );
  }

  void _getUserPosition() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
    Position userLocation = await geolocatorPlatform.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high));

    logger.d("Location $userLocation.toString()");

    // telegram.sendTeleMsg(userLocation.toString());

    setState(() {
      position = userLocation;
    });
  }

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
            Text(
              position.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
