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
      width: 350.w,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: Theme.of(context).shadowColor,
        border: Border.all(color: ColorsManager.blue),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(
              provider.events[index].category.imagePath,
              fit: BoxFit.cover,
              width: 140.w,
              height: 80.h,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.events[index].description,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontSize: 16.sp),
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 14.sp),
                    SizedBox(width: 2.w),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        "${provider.events[index].city}, ${provider.events[index].country}",
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
