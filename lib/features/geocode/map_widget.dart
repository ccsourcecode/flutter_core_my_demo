import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  LatLng? markerLocation, userLocation;
  final void Function(LatLng)? onTap;

  MyMap({Key? key, this.markerLocation, this.userLocation, this.onTap})
      : super(key: key);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  List<Marker> markers = [];
  LatLng center = const LatLng(22.284226, 114.172945);

  void _onMapCreated(GoogleMapController controller) {
    final currentMarker = Marker(
        markerId: const MarkerId('currentMarker'),
        position: widget.userLocation ??= center);

    final movedMarker = Marker(
        markerId: const MarkerId('movedMarker'),
        position: widget.markerLocation ??= center);

    setState(() {
      markers.add(currentMarker);
      markers.add(movedMarker);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('google map build1');
    print(widget.userLocation);
    print('google map build2');
    return GoogleMap(
      initialCameraPosition:
          const CameraPosition(target: LatLng(22.284226, 114.172945), zoom: 15),
      myLocationEnabled: true,
      onMapCreated: _onMapCreated,
      markers: Set.from(markers),
      onTap: (latlang) {
        if (markers.isNotEmpty) {
          markers.clear();
        }

        _onAddMarkerButtonPressed(latlang);
      },
    );
  }

  void _onAddMarkerButtonPressed(LatLng latlong) {
    print('_onAddMarkerButtonPressed');
    widget.markerLocation = latlong;
    final movedMarker = Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(latlong.toString()),
      position: latlong,
      infoWindow: const InfoWindow(
        title: 'moved Marker',
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    setState(() {
      markers = [];
      markers.add(movedMarker);
    });
  }
}
