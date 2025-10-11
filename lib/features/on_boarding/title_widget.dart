import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageAssets.eventlyLogo,width: 48.w,height: 50.h,),
            Text("Evently",style: GoogleFonts.jockeyOne(fontSize: 36.sp,fontWeight: FontWeight.bold,color: ColorsManager.blue),)
          ],
        ),
      ],
    );
  }
}
