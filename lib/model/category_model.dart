import 'package:evently/core/resources/assets_manager.dart';
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
      imagePath: ImageAssets.football,
    ),
    CategoryModel(
      id: "2",
      name: "Birthday",
      iconData: Icons.cake_rounded,
      imagePath: ImageAssets.birthday,
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
      imagePath: ImageAssets.gaming,
    ),
    CategoryModel(
      id: "5",
      name: "Eating",
      iconData: Icons.fastfood_rounded,
      imagePath: ImageAssets.eating,
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
      imagePath: ImageAssets.holiday,
    ),
    CategoryModel(
      id: "8",
      name: "Workshop",
      iconData: Icons.work_rounded,
      imagePath: ImageAssets.workshop,
    ),
    CategoryModel(
      id: "9",
      name: "BookClub",
      iconData: Icons.menu_book_rounded,
      imagePath: ImageAssets.bookclub,
    ),
  ];
  static List<CategoryModel> category = [
    CategoryModel(
      id: "0",
      name: "Sports",
      iconData: Icons.sports_baseball_rounded,
      imagePath: ImageAssets.football,
    ),
    CategoryModel(
      id: "1",
      name: "Birthday",
      iconData: Icons.cake_rounded,
      imagePath: ImageAssets.birthday,
    ),
    CategoryModel(
      id: "2",
      name: "Meeting",
      iconData: Icons.laptop_chromebook_rounded,
      imagePath: ImageAssets.meeting,
    ),
    CategoryModel(
      id: "3",
      name: "Gaming",
      iconData: Icons.gamepad_rounded,
      imagePath: ImageAssets.gaming,
    ),
    CategoryModel(
      id: "4",
      name: "Eating",
      iconData: Icons.fastfood_rounded,
      imagePath: ImageAssets.eating,
    ),
    CategoryModel(
      id: "5",
      name: "Holiday",
      iconData: Icons.holiday_village_rounded,
      imagePath: ImageAssets.meeting,
    ),
    CategoryModel(
      id: "6",
      name: "Exhibition",
      iconData: Icons.water_damage_rounded,
      imagePath: ImageAssets.holiday,
    ),
    CategoryModel(
      id: "7",
      name: "Workshop",
      iconData: Icons.work_rounded,
      imagePath: ImageAssets.workshop,
    ),
    CategoryModel(
      id: "8",
      name: "BookClub",
      iconData: Icons.menu_book_rounded,
      imagePath: ImageAssets.bookclub,
    ),
  ];
}
