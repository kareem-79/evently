import 'package:evently/core/extension/date_time_extension.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/features/event_details/widgets/event_location_and_date_card.dart';
import 'package:evently/features/event_details/widgets/map_card.dart';
import 'package:evently/firebase/firebase_services.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? localization = AppLocalizations.of(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(localization!.event_details),
        actions: [
          Visibility(
            visible: FirebaseAuth.instance.currentUser?.uid==event.ownerId,
            child: IconButton(
              onPressed: () {

              },
              icon: Icon(
                Icons.mode_edit_outline_outlined,
                color: ColorsManager.blue,
              ),
            ),
          ),
          Visibility(
            visible: FirebaseAuth.instance.currentUser?.uid==event.ownerId,
            child: IconButton(
              onPressed: () {
                FirebaseServices.deleteEvent(event, context);
                Navigator.pop(context);
              },
              icon: Icon(Icons.delete_outline, color: ColorsManager.red),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.sp),
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: ColorsManager.blue),
              borderRadius: BorderRadiusGeometry.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16.r),
              child: Image.asset(
                event.category.imagePath,
                fit: BoxFit.fill,
                width: 361.w,
                height: 203.h,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            textAlign: TextAlign.center,
            event.title,
            style: textTheme.headlineLarge?.copyWith(color: ColorsManager.blue),
          ),
          SizedBox(height: 16.h),
          EventLocationAndDateCard(
            icon: Icons.date_range,
            title: event.dateTime.toViewData,
            subtitle: event.dateTime.toFormatTime,
          ),
          SizedBox(height: 16.h),
          EventLocationAndDateCard(
            icon: Icons.my_location_outlined,
            title: "${event.city} , ${event.country}",
            isTrailing: true,
            isPadding: true,
          ),
          SizedBox(height: 16.h),
          MapCard(event: event,),
          SizedBox(height: 16.h),
          Text(localization.description,style: textTheme.titleSmall,),
          SizedBox(height: 16.h),
          Text(event.description,style: textTheme.titleSmall,),

        ],
      ),
    );
  }
}
