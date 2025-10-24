import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeProvider extends ChangeNotifier{
  Location location = Location();
   String locationMassage = "";
  HomeProvider() {
    getUserLocation();
    setLocationListener();
  }

  late final StreamSubscription<LocationData> locationStream;
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
    await convertLatLngToAddress(locationData.latitude!, locationData.longitude!);
    notifyListeners();
  }


  void setLocationListener() {
    location.changeSettings(accuracy: LocationAccuracy.high, interval: 1000);
    locationStream = location.onLocationChanged.listen((LocationData locationData) {
      convertLatLngToAddress(locationData.latitude!, locationData.longitude!);
    });
  }

   Future<void> convertLatLngToAddress(double lat, double lng) async {
    try {
      List<geocoding.Placemark> placemarks = await geocoding
          .placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        locationMassage = "${place.locality ?? ''},${place.country ?? ''}";
      } else {
        locationMassage = "Unknown location";
      }
    } catch (e) {
      locationMassage = "Error getting address";
      log("Error converting to address: $e");
    }
  }

  @override
  void dispose() {
    locationStream.cancel();
    super.dispose();
  }
}