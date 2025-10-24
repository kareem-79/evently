import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/resources/assets_manager.dart';

class PageWidget extends StatelessWidget {
  const PageWidget({super.key, required this.text1, required this.text2, required this.image});
  final String text1;
  final String text2;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20.h),
        Image.asset(image),
        SizedBox(height: 20.h),

        Text(
          text1,
          style: Theme.of(context).textTheme.titleMedium,
        ),

        SizedBox(height: 20.h),
        Text(
          text2,
          style: Theme.of(context).textTheme.labelSmall,
        ),

        SizedBox(height: 20.h),]);
  }
}
