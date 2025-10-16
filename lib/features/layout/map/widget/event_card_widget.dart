import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCardWidget extends StatelessWidget {
  final MapProvider provider;
  final int index;

  const EventCardWidget({
    super.key,
    required this.provider,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: Theme.of(context).shadowColor,
        border: Border.all(color: ColorsManager.blue),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        spacing: 8.w,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(16.r),
            child: Image.asset(
              provider.events[index].category.imagePath,
              fit: BoxFit.cover,
              width: 140.w,
              height: 80.h,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                provider.events[index].description,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontSize: 16.sp),
              ),
              Row(
                spacing: 4.w,
                children: [
                  Icon(Icons.location_on_outlined),
                  Text(
                    "${provider.events[index].city} , ${provider.events[index].country}",
                    style: Theme.of(context).textTheme.bodySmall
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
