import 'package:evently/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTabItem extends StatelessWidget {
  CustomTabItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.selectedBgColor,
    required this.selectedFgColor,
    required this.unSelectedBgColor,
    required this.unSelectedFgColor,
  });

  final CategoryModel category;
  final Color selectedBgColor;
  final Color selectedFgColor;
  final Color unSelectedBgColor;
  final Color unSelectedFgColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(vertical: 10,horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? selectedBgColor : unSelectedBgColor,
        borderRadius: BorderRadius.circular(60.r),
        border: Border.all(color: selectedBgColor, width: 1),
      ),
      child: Row(
        children: [
          Icon(category.iconData,color: isSelected ? selectedFgColor : unSelectedFgColor,),
          SizedBox(width: 8.w,),
          Text(
            category.name,
            style: GoogleFonts.inter(
              color: isSelected ? selectedFgColor : unSelectedFgColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
