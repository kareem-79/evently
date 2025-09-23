import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resources/colors_manager.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.label,
    required this.menuItems,
    required this.selectedItems,
    required this.onChange,
  });

  final String label;
  final List<String> menuItems;
  final String selectedItems;
  final void Function(String?) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsetsGeometry.all(6),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: ColorsManager.blue, width: 1.w),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedItems,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.blue,
                  ),
                ),
                DropdownButton<String>(
                  underline: Container(),
                  dropdownColor: Theme.of(context).shadowColor,
                  iconEnabledColor: ColorsManager.blue,
                  style: Theme.of(context).textTheme.displayMedium,
                  borderRadius: BorderRadius.circular(12.r),
                  items: menuItems.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: onChange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
