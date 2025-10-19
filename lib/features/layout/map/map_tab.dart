import 'package:evently/features/layout/map/widget/event_card_widget.dart';
import 'package:evently/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MapProvider>().getEvents(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MapProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.getUserLocation();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        child: Icon(Icons.gps_fixed_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: provider.cameraPosition,
                  markers: provider.markers,
                  mapType: MapType.normal,
                  onMapCreated: (controller) {
                    provider.googleMapController = controller;
                  },
                ),
              ),
            ],
          ),
          Positioned.fill(
            bottom: 80.h,
            top: MediaQuery.sizeOf(context).height * .75,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(8.sp),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    provider.changeCameraPosition(
                      LatLng(
                        provider.events[index].latitude,
                        provider.events[index].longitude,
                      ),
                    );
                  },
                  child: EventCardWidget(provider: provider, index: index),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 12.w),
              itemCount: provider.events.length,
            ),
          ),
        ],
      ),
    );
  }
}
