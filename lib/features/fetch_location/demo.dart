import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user_location.dart';
import 'services/location_service.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      create: (_) {
        return LocationService().locationStream;
      },
      initialData: UserLocation(latitude: 0, longitude: 0),
      // builder: (_, __) => LocationService().locationStream,
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Scaffold(
            body: HomeView(),
          )),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Center(
      child: Text(
          'Location: Lat${userLocation.latitude}, Long: ${userLocation.longitude}'),
    );
  }
}
