import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapProvider extends ChangeNotifier {
  Location location = Location();
  static String locationMassage = "";
  Set<Marker> markers = {};

  MapProvider() {
    getUserLocation();
    setLocationListener();
  }

  late GoogleMapController googleMapController;
  late final StreamSubscription<LocationData>locationStream;
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 17,
  );

  Future<bool> _getLocationPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _checkLocationServices() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }

  Future<void> getUserLocation() async {
    bool permissionGranted = await _getLocationPermission();
    if (!permissionGranted) return;
    bool isServiceEnabled = await _checkLocationServices();
    if (!isServiceEnabled) return;
    LocationData locationData = await location.getLocation();
    _changeLocationOnMap(locationData);
    notifyListeners();
  }
  void setLocationListener(){
    location.changeSettings(accuracy: LocationAccuracy.high,interval: 1000);
    locationStream=location.onLocationChanged.listen((LocationData locationData) {
      _changeLocationOnMap(locationData);
      notifyListeners();
    });
  }

  void _changeLocationOnMap(LocationData locationData) {
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 17,
    );
    markers.add(
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(
          locationData.latitude ?? 0,
          locationData.longitude ?? 0,
        ),
        infoWindow: InfoWindow(title: "Your Location"),
      ),
    );
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }
  @override
  void dispose() {
    googleMapController.dispose();
    locationStream.cancel();
    super.dispose();
  }
}
