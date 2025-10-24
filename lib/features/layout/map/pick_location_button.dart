import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/routes_manager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/provider/create_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickLocationButton extends StatelessWidget {
  final CreateEventProvider provider;

  const PickLocationButton({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutesManager.pickLocationScreen,
          arguments: provider,
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.sp),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorsManager.blue),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: ColorsManager.blue,
              ),
              child: Icon(
                Icons.my_location_outlined,
                color: ColorsManager.whiteBlue,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                provider.eventLocation == null
                    ? AppLocalizations.of(context)!.choose_event_location
                    : "${provider.city} , ${provider.country}",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined, color: ColorsManager.blue),
          ],
        ),
      ),
    );
  }
}
