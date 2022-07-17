import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:location_web/location_web.dart';
// import 'package:flutter_google_map/screens/google_map_screen.dart';
// import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

class GoogleMapScreen extends StatefulWidget {
  final List<double> pos;
  GoogleMapScreen({@required this.pos});
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  // My Initial Project
  // 0 = lat_parent
  // 1 = long_parent
  // 2 = lat_child
  // 3 = long_child
  double lat_parent = 0;
  double long_parent = 0;
  double lat_child = 0;
  double long_child = 0;
  Position _currentPosition;
  String _currentAddress;
  List<double> locations;
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  final databaseRef =
      FirebaseDatabase.instance.reference(); //database reference object

  void printFirebase() {
    databaseRef.once().then((DataSnapshot snapshot) async {
      final values = snapshot.value;
      //print('${Map<String, Map>.from(values) is Map<String, Map>}');

      final v = Map<String, Map>.from(values);
      //Map<String, dynamic> v = Map<String, dynamic>.from(values.);
      double lat_present = values[v.keys.first]["latitude"];
      double long_present = values[v.keys.first]["longitude"];
      lat_child = lat_present;
      long_child = long_present;
      // print(v["-MY8PTvCglKZMf1gzLAA"]["latitude"]);
      // print(v["-MY8PTvCglKZMf1gzLAA"]["longitude"]);

      // values.forEach((key, values) {
      //   i++;
      //   lat_present = values["latitude"];
      //   long_present = values["longitude"];

      //   print('Lat : ${values["latitude"]}');
      //   print('Long : ${values["longitude"]}');
      // });
      lat_parent = _currentPosition.latitude;
      long_parent = _currentPosition.longitude;
      // double distance = calculateDistance(lat_present, long_present, lat, long);
      // print('Distance : $distance');

      print("In screen section ");
      print('$lat_parent');
      print('$long_parent');
      print('$lat_child');
      print('$long_child');
    });
  }

  GoogleMapController mapController;

  // declaring it as null
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    // Setting Markers
    setState(() {
      // print(locations[0]);
      _markers.add(
        Marker(
          markerId: MarkerId('id-1'),
          // position: LatLng(27.961535992423318, 76.40154864168439),
          position: LatLng(28.6150346424803, 77.3121091225802),
          infoWindow: InfoWindow(
            title: 'John Doe',
            snippet: 'Live location',
          ),
        ),
      );
    });
  }

  void _getCurrentLocation() {
    print('In Get Current Location');
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: false)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        lat_parent = _currentPosition.latitude;
        long_parent = _currentPosition.longitude;
        printFirebase();
        // addData(lat, long);
        // itemRef.push().set(item.toJson());
        // _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    locations = widget.pos;
    // print('LAT child : ${locations[2]}');
    // print('LONG child : ${locations[3]}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        myLocationEnabled: false,
        markers: _markers,
        initialCameraPosition: CameraPosition(
          target: LatLng(28.6150346424803, 77.3121091225802),
          zoom: 16,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.pin_drop_outlined),
          tooltip: 'Google Map',
          onPressed: () {
            _getCurrentLocation();
            // values of coordinate variables changed
            setState(() {
              _markers.add(
                Marker(
                  markerId: MarkerId('id-1'),
                  // position: LatLng(27.961535992423318, 76.40154864168439),
                  position: LatLng(lat_child, long_child),
                  infoWindow: InfoWindow(
                    title: 'John Doe',
                    snippet: 'Live location',
                  ),
                ),
              );
            });

            mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(lat_child, long_child), zoom: 16),
              ),
            );
          }),
    );
  }
}
