import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/l10n/app_localizations.dart';
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

  static List<CategoryModel> categoryWithAll(BuildContext context) {
    return [
      CategoryModel(
        id: "0",
        name: AppLocalizations.of(context)!.all,
        iconData: Icons.all_inclusive_rounded,
        imagePath: "",
      ),
      CategoryModel(
        id: "1",
        name: AppLocalizations.of(context)!.sports,
        iconData: Icons.sports_baseball_rounded,
        imagePath: ImageAssets.football,
      ),
      CategoryModel(
        id: "2",
        name: AppLocalizations.of(context)!.birthday,
        iconData: Icons.cake_rounded,
        imagePath: ImageAssets.birthday,
      ),
      CategoryModel(
        id: "3",
        name: AppLocalizations.of(context)!.meeting,
        iconData: Icons.laptop_chromebook_rounded,
        imagePath: ImageAssets.meeting,
      ),
      CategoryModel(
        id: "4",
        name: AppLocalizations.of(context)!.gaming,
        iconData: Icons.gamepad_rounded,
        imagePath: ImageAssets.gaming,
      ),
      CategoryModel(
        id: "5",
        name: AppLocalizations.of(context)!.eating,
        iconData: Icons.fastfood_rounded,
        imagePath: ImageAssets.eating,
      ),
      CategoryModel(
        id: "6",
        name: AppLocalizations.of(context)!.holiday,
        iconData: Icons.holiday_village_rounded,
        imagePath: ImageAssets.meeting,
      ),
      CategoryModel(
        id: "7",
        name: AppLocalizations.of(context)!.exhibition,
        iconData: Icons.water_damage_rounded,
        imagePath: ImageAssets.holiday,
      ),
      CategoryModel(
        id: "8",
        name: AppLocalizations.of(context)!.work_shop,
        iconData: Icons.work_rounded,
        imagePath: ImageAssets.workshop,
      ),
      CategoryModel(
        id: "9",
        name: AppLocalizations.of(context)!.book_club,
        iconData: Icons.menu_book_rounded,
        imagePath: ImageAssets.bookclub,
      ),
    ];
  }

  // الصور اللي بتظهر في صفحة إنشاء الحدث (Create Event)
  static List<CategoryModel> category(BuildContext context) {
    return [
      CategoryModel(
        id: "1",
        name: AppLocalizations.of(context)!.sports,
        iconData: Icons.sports_baseball_rounded,
        imagePath: CreateEventAssets.football,
      ),
      CategoryModel(
        id: "2",
        name: AppLocalizations.of(context)!.birthday,
        iconData: Icons.cake_rounded,
        imagePath: CreateEventAssets.birthday,
      ),
      CategoryModel(
        id: "3",
        name: AppLocalizations.of(context)!.meeting,
        iconData: Icons.laptop_chromebook_rounded,
        imagePath: CreateEventAssets.meeting,
      ),
      CategoryModel(
        id: "4",
        name: AppLocalizations.of(context)!.gaming,
        iconData: Icons.gamepad_rounded,
        imagePath: CreateEventAssets.gaming,
      ),
      CategoryModel(
        id: "5",
        name: AppLocalizations.of(context)!.eating,
        iconData: Icons.fastfood_rounded,
        imagePath: CreateEventAssets.eating,
      ),
      CategoryModel(
        id: "6",
        name: AppLocalizations.of(context)!.holiday,
        iconData: Icons.holiday_village_rounded,
        imagePath: CreateEventAssets.meeting,
      ),
      CategoryModel(
        id: "7",
        name: AppLocalizations.of(context)!.exhibition,
        iconData: Icons.water_damage_rounded,
        imagePath: CreateEventAssets.holiday,
      ),
      CategoryModel(
        id: "8",
        name: AppLocalizations.of(context)!.work_shop,
        iconData: Icons.work_rounded,
        imagePath: CreateEventAssets.workshop,
      ),
      CategoryModel(
        id: "9",
        name: AppLocalizations.of(context)!.book_club,
        iconData: Icons.menu_book_rounded,
        imagePath: CreateEventAssets.bookclub,
      ),
    ];
  }
}
