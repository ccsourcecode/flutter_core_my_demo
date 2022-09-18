// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoder2/geocoder2.dart';
import 'map_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeocodeApp extends StatefulWidget {
  const GeocodeApp({Key? key}) : super(key: key);

  @override
  _GeocodeAppState createState() => _GeocodeAppState();
}

class _GeocodeAppState extends State<GeocodeApp> {
  LatLng? _markerLocation, _userLocation, _onTap;
  String? _resultAddress;

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: FutureBuilder<LatLng?>(
                future: getUserLocation(),
                initialData: const LatLng(0, 0),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Text('Show your app logo here'),
                          CircularProgressIndicator()
                        ],
                      ),
                    );
                  }
                  // when success
                  return MyMap(userLocation: snapshot.data!);
                },
              ),
            ),
            Text(_resultAddress ??= 'set address'),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Get My Location Address"),
                onPressed: () async {
                  print('clicked button');
                  if (_userLocation != null) {
                    getSetAddress(
                        _userLocation!.latitude, _userLocation!.longitude);
                  }
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Get Marker Address"),
                onPressed: () async {
                  print('clicked button1');
                  if (_markerLocation != null) {
                    print('clicked button2');
                    getSetAddress(
                        _markerLocation!.latitude, _markerLocation!.longitude);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<LatLng?> getUserLocation() async {
    Location location = Location();
    print('get user location method');
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    final result = await location.getLocation();
    _userLocation = LatLng(result.latitude!, result.longitude!);
    print(_userLocation);
    return _userLocation;
  }

  getSetAddress(double latitude, double longitude) async {
    print('get address1');
    final addresses = await Geocoder2.getDataFromCoordinates(
        latitude: latitude,
        longitude: longitude,
        googleMapApiKey: 'AIzaSyCKs323xdBm-nCEvixahzKCUF-Om56X8wRq5Ew-c');
    print(addresses.address);
    setState(() {
      _resultAddress = addresses.address;
    });
  }
}
