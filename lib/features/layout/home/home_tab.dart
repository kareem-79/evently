import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/features/layout/home/custom_tab_item.dart';
import 'package:evently/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200.h,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
          ),
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
                          "Welcome Back ✨",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          "Kareem Mohamed",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on_outlined),
                            SizedBox(width: 4.w),
                            Text(
                              "Cairo,Egypt",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.light_mode_outlined),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: Text(
                          "En",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),
                  ],
                ),
                DefaultTabController(
                  length: CategoryModel.categoryWithAll.length,
                  child: TabBar(
                    indicatorColor: Colors.transparent,
                    isScrollable: true,
                    tabs: CategoryModel.categoryWithAll
                        .map(
                          (category) => CustomTabItem(
                            category: category,
                            isSelected: true,
                            selectedBgColor: ColorsManager.whiteBlue,
                            selectedFgColor: ColorsManager.blue,
                            unSelectedBgColor: Colors.transparent,
                            unSelectedFgColor: ColorsManager.white,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
