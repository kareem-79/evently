import 'dart:async';
import 'dart:developer';
import 'package:evently/firebase/firebase_services.dart';
import 'package:evently/model/category_model.dart';
import 'package:evently/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapProvider extends ChangeNotifier {
  Location location = Location();
  static String locationMassage = "";
  Set<Marker> markers = {};
  List<EventModel> events = [];

  MapProvider() {
    getUserLocation();
  }

  late GoogleMapController googleMapController;
  late final StreamSubscription<LocationData> locationStream;
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 17,
  );

  Future<void> getEvents(BuildContext context) async {
    events = await FirebaseServices.getEvents(
      context,
      CategoryModel.categoryWithAll(context)[0],
    );
    notifyListeners();
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
    if (!permissionGranted) return;
    bool isServiceEnabled = await _checkLocationServices();
    if (!isServiceEnabled) return;
    LocationData locationData = await location.getLocation();
    _changeLocationOnMap(locationData);
    notifyListeners();
  }


  void setLocationListener() {
    location.changeSettings(accuracy: LocationAccuracy.high, interval: 1000);
    locationStream = location.onLocationChanged.listen((
      LocationData locationData,
    ) {
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
    notifyListeners();
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
    notifyListeners();
  }

  void changeCameraPosition(LatLng location) {
    cameraPosition = CameraPosition(target: location, zoom: 17);
    markers.add(
      Marker(
        markerId: MarkerId(UniqueKey().toString()),
        position: location,
        infoWindow: InfoWindow(title: "Event Location"),
      ),
    );
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
    notifyListeners();
  }
  @override
  void dispose() {
    googleMapController.dispose();
    locationStream.cancel();
    super.dispose();
  }
}
