import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static final ThemeData light = ThemeData(
    primaryColor: ColorsManager.blue,
    shadowColor: ColorsManager.whiteBlue,
    secondaryHeaderColor: ColorsManager.blue,
    focusColor: ColorsManager.black,
    useMaterial3: false,
    iconTheme: IconThemeData(color: ColorsManager.black),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: ColorsManager.whiteBlue,
      foregroundColor: ColorsManager.blue,
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 22.sp,
        color: ColorsManager.blue,
      ),
      centerTitle: true,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: ColorsManager.white,
      headerBackgroundColor: ColorsManager.blue,
      headerForegroundColor: ColorsManager.white,
      surfaceTintColor: Colors.transparent,
      dayStyle: TextStyle(color: ColorsManager.black),
      weekdayStyle: TextStyle(color: ColorsManager.gray),
      yearStyle: TextStyle(color: ColorsManager.black),
      dayForegroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorsManager.white;
        }
        if (states.contains(WidgetState.disabled)) {
          return ColorsManager.gray;
        }
        return ColorsManager.black;
      }),
      dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorsManager.blue;
        }
        if (states.contains(WidgetState.selected)) {
          return ColorsManager.blue.withOpacity(0.15);
        }
        return Colors.transparent;
      }),
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: ColorsManager.whiteBlue,
      hourMinuteTextColor: ColorsManager.blue,
      hourMinuteShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      dayPeriodColor: ColorsManager.whiteBlue,
      dayPeriodTextColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return ColorsManager.blue;
        }
        return ColorsManager.black;
      }),
      dayPeriodShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        side: BorderSide(color: ColorsManager.blue),
      ),
      dialBackgroundColor: ColorsManager.whiteBlue,
      dialHandColor: ColorsManager.blue,
      dialTextColor: ColorsManager.black,
      entryModeIconColor: ColorsManager.blue,
      helpTextStyle: TextStyle(color: ColorsManager.blue),
      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: ColorsManager.blue,
      ),
      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: ColorsManager.gray,
      ),
    ),



    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.blue,
      shape: StadiumBorder(
        side: BorderSide(color: ColorsManager.white, width: 4.w),
      ),
    ),
    scaffoldBackgroundColor: ColorsManager.whiteBlue,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsetsGeometry.all(14.sp),
        backgroundColor: ColorsManager.blue,
        foregroundColor: ColorsManager.whiteBlue,
        textStyle: GoogleFonts.inter(
          fontSize: 20.sp,
          color: ColorsManager.white,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12.r),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.inter(
        fontSize: 16.sp,
        color: ColorsManager.gray,
        fontWeight: FontWeight.w400,
      ),

      prefixIconColor: ColorsManager.gray,
      suffixIconColor: ColorsManager.gray,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorsManager.gray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorsManager.blue),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorsManager.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorsManager.red),
      ),
    ),
    textTheme: TextTheme(
      bodySmall: GoogleFonts.inter(
        fontSize: 14.sp,
        color: ColorsManager.black,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 16.sp,
        color: ColorsManager.black,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 14.sp,
        color: ColorsManager.white,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 16.sp,
        color: ColorsManager.blue,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 24.sp,
        color: ColorsManager.white,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 20.sp,
        color: ColorsManager.blue,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.black,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ColorsManager.black,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 18.sp,
        color: ColorsManager.blue,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: ColorsManager.blue,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorsManager.white,
      unselectedItemColor: ColorsManager.white,
      showUnselectedLabels: false,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: ColorsManager.blue,
      shape: const CircularNotchedRectangle(),
    ),
    cardTheme: CardThemeData(color: Colors.white),
    dialogTheme: DialogThemeData(backgroundColor: ColorsManager.whiteBlue),
  );
  static final ThemeData dark = ThemeData(
    primaryColor: ColorsManager.darkBlue,
    shadowColor: ColorsManager.darkBlue,
    secondaryHeaderColor: ColorsManager.blue,
    focusColor: ColorsManager.blue,
    useMaterial3: false,
    iconTheme: IconThemeData(color: ColorsManager.ofWhite),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: ColorsManager.darkBlue,
      foregroundColor: ColorsManager.blue,
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 22.sp,
        color: ColorsManager.blue,
      ),
      centerTitle: true,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: ColorsManager.darkBlue,
      headerBackgroundColor: ColorsManager.darkBlue,
      headerForegroundColor: ColorsManager.ofWhite,
      surfaceTintColor: Colors.transparent,
      dayStyle: TextStyle(color: ColorsManager.ofWhite),
      weekdayStyle: TextStyle(color: ColorsManager.ofWhite.withOpacity(0.8)),
      yearStyle: TextStyle(color: ColorsManager.ofWhite),
      dayForegroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorsManager.ofWhite;
        }
        if (states.contains(WidgetState.disabled)) {
          return ColorsManager.gray;
        }
        return ColorsManager.ofWhite;
      }),
      dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorsManager.blue;
        }
        if (states.contains(WidgetState.selected)) {
          return ColorsManager.darkBlue.withOpacity(0.4);
        }
        return Colors.transparent;
      }),
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: ColorsManager.darkBlue,
      hourMinuteTextColor: ColorsManager.white,
      hourMinuteShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      dayPeriodColor: ColorsManager.darkBlue,
      dayPeriodTextColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return ColorsManager.blue;
        }
        return ColorsManager.ofWhite;
      }),
      dayPeriodShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        side: BorderSide(color: Colors.white24),
      ),
      dialBackgroundColor: ColorsManager.black,
      dialHandColor: ColorsManager.blue,
      dialTextColor: ColorsManager.ofWhite,
      entryModeIconColor: ColorsManager.blue,
      helpTextStyle: TextStyle(color: ColorsManager.ofWhite),
      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: ColorsManager.blue,
      ),
      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: ColorsManager.gray,
      ),
    ),



    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.darkBlue,
      foregroundColor: ColorsManager.ofWhite,
      shape: StadiumBorder(
        side: BorderSide(color: ColorsManager.ofWhite, width: 4.w),
      ),
    ),
    scaffoldBackgroundColor: ColorsManager.darkBlue,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsetsGeometry.all(14.sp),
        backgroundColor: ColorsManager.blue,
        foregroundColor: ColorsManager.whiteBlue,
        textStyle: GoogleFonts.inter(
          fontSize: 20.sp,
          color: ColorsManager.white,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12.r),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.inter(
        fontSize: 16.sp,
        color: ColorsManager.ofWhite,
        fontWeight: FontWeight.w400,
      ),
      prefixIconColor: ColorsManager.ofWhite,
      suffixIconColor: ColorsManager.ofWhite,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorsManager.blue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorsManager.blue),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorsManager.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorsManager.red),
      ),
    ),
    textTheme: TextTheme(
      bodySmall: GoogleFonts.inter(
        fontSize: 14.sp,
        color: ColorsManager.ofWhite,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 16.sp,
        color: ColorsManager.ofWhite,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 14.sp,
        color: ColorsManager.ofWhite,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 24.sp,
        color: ColorsManager.ofWhite,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 16.sp,
        color: ColorsManager.ofWhite,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 20.sp,
        color: ColorsManager.blue,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.ofWhite,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ColorsManager.ofWhite,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 18.sp,
        color: ColorsManager.ofWhite,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: ColorsManager.ofWhite,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorsManager.ofWhite,
      unselectedItemColor: ColorsManager.ofWhite,
      showUnselectedLabels: false,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: ColorsManager.darkBlue,
      shape: const CircularNotchedRectangle(),
    ),
    cardTheme: CardThemeData(color: ColorsManager.darkBlue),
    dialogTheme: DialogThemeData(backgroundColor: ColorsManager.darkBlue),
  );
}
