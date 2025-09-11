import 'package:evently/core/resources/assets_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  IconData iconData;
  String imagePath;

  CategoryModel({
    required this.id,
    required this.name,
    required this.iconData,
    required this.imagePath,
  });

  static List<CategoryModel> categoryWithAll = [
    CategoryModel(
      id: "0",
      name: "All",
      iconData: Icons.all_inclusive_rounded,
      imagePath: ImageAssets.meeting,
    ),
    CategoryModel(
      id: "1",
      name: "Sports",
      iconData: Icons.sports_baseball_rounded,
      imagePath: ImageAssets.meeting,
    ),
    CategoryModel(
      id: "2",
      name: "Birthday",
      iconData: Icons.cake_rounded,
      imagePath: ImageAssets.meeting,
    ),
    CategoryModel(
      id: "3",
      name: "Meeting",
      iconData: Icons.laptop_chromebook_rounded,
      imagePath: ImageAssets.meeting,
    ),
    CategoryModel(
      id: "4",
      name: "Gaming",
      iconData: Icons.gamepad_rounded,
      imagePath: ImageAssets.meeting,
    ),
    CategoryModel(
      id: "5",
      name: "Eating",
      iconData: Icons.fastfood_rounded,
      imagePath: ImageAssets.meeting,
    ),
    CategoryModel(
      id: "6",
      name: "Holiday",
      iconData: Icons.holiday_village_rounded,
      imagePath: ImageAssets.meeting,
    ),
    CategoryModel(
      id: "7",
      name: "Exhibition",
      iconData: Icons.water_damage_rounded,
      imagePath: ImageAssets.meeting,
    ),
    CategoryModel(
      id: "8",
      name: "Workshop",
      iconData: Icons.work_rounded,
      imagePath: ImageAssets.meeting,
    ),
    CategoryModel(
      id: "9",
      name: "BookClub",
      iconData: Icons.menu_book_rounded,
      imagePath: ImageAssets.meeting,
    ),
  ];
}
