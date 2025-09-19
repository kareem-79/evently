import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/routes_manager.dart';
import 'package:evently/features/layout/profile/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(44)),
          ),
          child: SafeArea(
            bottom: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(ImageAssets.profileImg),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Kareem Mohamed",
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.white,
                          ),
                        ),
                        Text(
                          "kareemmohamed2567@gmail.com",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24.h),
        CustomDropDown(
          label: 'Theme',
          menuItems: ["Light", "Dark"],
          selectedItems: 'Light',
        ),
        SizedBox(height: 12.h),
        CustomDropDown(
          label: 'Language',
          menuItems: ["English", "عربي"],
          selectedItems: 'English',
        ),
        Spacer(flex: 7),
        Padding(
          padding: EdgeInsets.all(10.0.sp),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: ColorsManager.red,foregroundColor: ColorsManager.white),
            onPressed: () {
              Navigator.pushReplacementNamed(context, RoutesManager.login);
            },
            child: Row(
              children: [
                Icon(Icons.logout_outlined),
                SizedBox(width: 8.w),
                Text("Logout"),
              ],
            ),
          ),
        ),
        Spacer(flex: 3),
      ],
    );
  }
}
