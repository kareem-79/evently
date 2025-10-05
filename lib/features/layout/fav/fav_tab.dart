import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widget/event_item.dart';
import '../../../model/event_model.dart';
import '../../../model/category_model.dart';

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
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => EventItem(
                  event: EventModel(
                    categoryModel: CategoryModel.categoryWithAll(context)[2],
                    title: "meeting",
                    description: "Meeting for Updating The Development Method ",
                    dateTime: DateTime.now(),
                    timeOfDay: TimeOfDay.now(),
                  ),
                ),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
