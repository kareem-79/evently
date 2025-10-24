import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';

class HomeProvider extends ChangeNotifier {
  Location location = Location();
  String locationMessage = "Fetching location...";
  double? latitude;
  double? longitude;

  HomeProvider() {
    getUserLocation();
  }

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
    if (!permissionGranted) {
      locationMessage = "Location permission denied";
      notifyListeners();
      return;
    }
    bool isServiceEnabled = await _checkLocationServices();
    if (!isServiceEnabled) {
      locationMessage = "Location services disabled";
      notifyListeners();
      return;
    }
    try {
      LocationData locationData = await location.getLocation();
      latitude = locationData.latitude;
      longitude = locationData.longitude;
      await convertLatLngToAddress(locationData.latitude!, locationData.longitude!);
      notifyListeners();
    } catch (e) {
      locationMessage = "Error getting location: $e";
      latitude = null;
      longitude = null;
      log("Error getting location: $e");
      notifyListeners();
    }
  }

  Future<void> convertLatLngToAddress(double lat, double lng) async {
    try {
      List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        locationMessage = "${place.locality ?? ''}, ${place.country ?? ''}";
      } else {
        locationMessage = "Unknown location";
      }
    } catch (e) {
      locationMessage = "Error getting address: $e";
      log("Error converting to address: $e");
    }
    notifyListeners();
  }
}