import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/firebase/firebase_services.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widget/custom_event_item.dart';
import '../../../model/event_model.dart';

class FavTab extends StatelessWidget {
  const FavTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.sp),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  focusColor: ColorsManager.blue,
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: ColorsManager.blue,
                  label: Text(AppLocalizations.of(context)!.search_for_event),
                  labelStyle: Theme.of(context).textTheme.displaySmall
                ),
              ),
            ),
            FutureBuilder(
              future: FirebaseServices.getFavouriteEvents(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.hasError.toString()));
                }
                List<EventModel> favEvents = snapshot.data ?? [];
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) => EventItem(
                      event: favEvents[index], isFavorite: true,
                    ),
                    itemCount: favEvents.length,
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
