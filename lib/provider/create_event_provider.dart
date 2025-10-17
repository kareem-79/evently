import 'package:evently/core/utils/ui_utils.dart';
import 'package:evently/firebase/firebase_services.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/category_model.dart';
import 'package:evently/model/event_model.dart';
import 'package:evently/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CreateEventProvider extends ChangeNotifier {
  CreateEventProvider() {
    getUserLocation();
  }

  Location location = Location();

  late TextEditingController titleController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  late TimeOfDay selectedTime = TimeOfDay.now();
  Set<Marker> markers = {};
  late GoogleMapController googleMapController;
  late CategoryModel selectedCategory;
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 17,
  );

  void getSelectedCategory(BuildContext context) {
    selectedCategory = CategoryModel.category(context)[0];
  }

  Future<void> addEvent(BuildContext context) async {
    if (formKey.currentState?.validate() == false) return;
    UiUtils.showLoadingDialog(context);
    EventModel event = EventModel(
      id: "",
      ownerId: UserModel.currentUser!.id,
      category: selectedCategory,
      title: titleController.text,
      description: descriptionController.text,
      dateTime: selectedDate,
      latitude:eventLocation?.latitude??0 ,
      longitude: eventLocation?.longitude??0,
      city: city??"unKnown",
      country:country??"unKnown"
    );
    await FirebaseServices.addEventToFireStore(event, context);
    UiUtils.hideDialog(context);
    Navigator.pop(context);
    UiUtils.showToast(AppLocalizations.of(context)!.event_added, Colors.green);
  }

  void selectEventTime(BuildContext context) async {
    selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now()) ??
        selectedTime;
    selectedDate = selectedDate.copyWith(
      hour: selectedTime.hour,
      minute: selectedTime.minute,
    );
    notifyListeners();
  }

  void selectedEventDay(BuildContext context) async {
    selectedDate =
        await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        ) ??
        selectedDate;
    selectedDate = selectedDate.copyWith(
      hour: selectedTime.hour,
      minute: selectedTime.minute,
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

  LatLng? eventLocation;
  String? city;
  String? country;

  Future<void> convertLatLngToAddress() async {
    if (eventLocation == null) return;
    List<geocoding.Placemark> placeMark = await geocoding
        .placemarkFromCoordinates(
          eventLocation!.latitude,
          eventLocation!.longitude,
        );
    if (placeMark.isNotEmpty) {
      city = placeMark.first.locality ?? "unKnown";
      country = placeMark.first.country ?? "unKnown";
    }
    notifyListeners();
  }

  void changeLocationOnMap(LatLng location) {
    eventLocation = location;
    markers.clear();
    markers.add(Marker(markerId: MarkerId("1"), position: location));
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
