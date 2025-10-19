import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/model/event_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCard extends StatelessWidget {
  final EventModel event;

  const MapCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: ColorsManager.blue),
        ),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(16.r),
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(event.latitude, event.longitude),
              zoom: 14
            ),
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
            markers: {Marker(
              markerId: MarkerId("1"),
              position: LatLng(event.latitude, event.longitude),
              infoWindow: InfoWindow(
                title: event.title,
                snippet: "${event.city} , ${event.country}",
              )
            ),}
        ),
      ),
    ));
  }
}
