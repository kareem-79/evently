import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/provider/create_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PickLocationScreen extends StatelessWidget {
  final CreateEventProvider provider;

  const PickLocationScreen({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Scaffold(
        body: Column(
          children: [
            Consumer<CreateEventProvider>(
              builder: (context, provider, child) {
                return Expanded(
                  child: GoogleMap(
                    initialCameraPosition: provider.cameraPosition,
                    markers: provider.markers,
                    mapType: MapType.normal,
                    onMapCreated: (controller) {
                      provider.googleMapController = controller;
                    },
                    onTap: (location) {
                      provider.changeLocationOnMap(location);
                      provider.convertLatLngToAddress();
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
            Container(
              height: 60.h,
              width: double.infinity,
              padding: EdgeInsets.all(16.sp),
              color: ColorsManager.blue,
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.tap_on_location_to_select,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
