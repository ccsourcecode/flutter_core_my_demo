import 'dart:async';

import 'package:location/location.dart';

import '../models/user_location.dart';

class LocationService {
  UserLocation? _currentLocation;

  LocationService() {
    // Request permission to use location
    location.requestPermission().then((granted) {
      location.onLocationChanged.listen((locationData) {
        if (locationData != null) {
          _locationController.add(UserLocation(
            latitude: locationData.latitude!,
            longitude: locationData.longitude!,
          ));
        }
      });
    });
  }

  var location = Location();

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude!,
        longitude: userLocation.longitude!,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }

    return _currentLocation!;
  }

  final StreamController<UserLocation> _locationController =
      StreamController<UserLocation>();

  Stream<UserLocation> get locationStream => _locationController.stream;
}
