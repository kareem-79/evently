import 'package:evently/core/extension/date_time_extension.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/routes_manager.dart';
import 'package:evently/firebase/firebase_services.dart';
import 'package:evently/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EventItem extends StatefulWidget {
  EventItem({super.key, required this.event, required this.isFavorite});

  final EventModel event;
  bool isFavorite;

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  late bool favEvent = widget.isFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context,RoutesManager.eventDetailsScreen,arguments: widget.event);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        width: double.infinity,
        height: 204.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: ColorsManager.blue),
          image: DecorationImage(
            image: AssetImage(widget.event.category.imagePath),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Column(
                  children: [
                    Text(
                      "${widget.event.dateTime.day}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      widget.event.dateTime.viewMonth,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        color: ColorsManager.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        widget.event.description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _markEventAsFavorite,
                    child: Padding(
                      padding: EdgeInsets.all(12.0.sp),
                      child: Icon(
                        favEvent
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: ColorsManager.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _markEventAsFavorite() async {
    if (favEvent) {
      await FirebaseServices.removeEventFromFavorite(widget.event);
      favEvent = false;
    } else {
      await FirebaseServices.addEventToFavorite(widget.event);
      favEvent = true;
    }
    setState(() {});
  }
}
