import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/widget/event_item.dart';
import '../../../core/widget/event_model.dart';
import '../../../model/category_model.dart';

class FavTab extends StatelessWidget {
  const FavTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.sp),
      child: SafeArea(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                focusColor: ColorsManager.blue,
                prefixIcon: Icon(Icons.search),
                prefixIconColor: ColorsManager.blue,
                label: Text("Search for Event"),
                labelStyle: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.blue,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => EventItem(
                  event: EventModel(
                    categoryModel: CategoryModel.categoryWithAll[2],
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
