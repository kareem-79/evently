import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventLocationAndDateCard extends StatelessWidget {
  final IconData icon;
  final String? title;
  final String? subtitle;
  final bool isTrailing;
  final bool isPadding;

  const EventLocationAndDateCard({
    super.key,
    required this.icon,
    this.title,
    this.subtitle,
    this.isTrailing = false,  this.isPadding=false,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding:isPadding?EdgeInsets.all(8.sp):EdgeInsets.zero ,
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.blue),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            color: ColorsManager.blue,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: ColorsManager.white),
        ),
        title: title != null ? Text(title!) : null,
        titleTextStyle: textTheme.headlineMedium?.copyWith(
          color: ColorsManager.blue,
        ),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        subtitleTextStyle: textTheme.bodySmall,
        trailing: isTrailing
            ? Icon(Icons.arrow_forward_ios_outlined, color: ColorsManager.blue)
            : null,
      ),
    );
  }
}
