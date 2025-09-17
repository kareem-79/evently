import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_tap_item.dart';
import '../../model/category_model.dart';

class CustomTapBar extends StatefulWidget {
  const CustomTapBar({
    super.key,
    required this.categories,
    required this.selectedBgColor,
    required this.selectedFgColor,
    required this.unSelectedBgColor,
    required this.unSelectedFgColor,
  });

  final List<CategoryModel> categories;
  final Color selectedBgColor;
  final Color selectedFgColor;
  final Color unSelectedBgColor;
  final Color unSelectedFgColor;

  @override
  State<CustomTapBar> createState() => _CustomTapBarState();
}

class _CustomTapBarState extends State<CustomTapBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        labelPadding: EdgeInsets.all(5.sp),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        indicatorColor: Colors.transparent,
        isScrollable: true,
        tabs: widget.categories
            .map(
              (category) => CustomTabItem(
                category: category,
                isSelected:
                    selectedIndex ==
                    widget.categories.indexOf(category),
                selectedBgColor: widget.selectedBgColor,
                selectedFgColor: widget.selectedFgColor,
                unSelectedBgColor: widget.unSelectedBgColor,
                unSelectedFgColor: widget.unSelectedFgColor,
              ),
            )
            .toList(),
      ),
    );
  }
}
