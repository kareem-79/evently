import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/widget/custom_tap_bar.dart';
import 'package:evently/core/widget/event_item.dart';
import 'package:evently/core/widget/event_model.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.welcome,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            "Kareem Mohamed",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: ColorsManager.white,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "Cairo,Egypt",
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.light_mode_outlined,
                        color: ColorsManager.white,
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: Text(
                            AppLocalizations.of(context)!.en,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  CustomTapBar(
                    categories: CategoryModel.categoryWithAll(context),
                    selectedBgColor: ColorsManager.whiteBlue,
                    selectedFgColor: ColorsManager.blue,
                    unSelectedBgColor: Colors.transparent,
                    unSelectedFgColor: ColorsManager.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => EventItem(
              event: EventModel(
                categoryModel: CategoryModel.categoryWithAll(context)[2],
                title: "meeting",
                description: "Meeting for Updating The Development Method ",
                dateTime: DateTime.now(),
                timeOfDay: TimeOfDay.now(),
              ),
            ),
            itemCount: 20,
          ),
        ),
      ],
    );
  }
}
