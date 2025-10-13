import 'package:evently/model/category_model.dart';
import 'package:flutter/cupertino.dart';

class EventModel {
  String id;
  String ownerId;
  CategoryModel category;
  String title;
  String description;
  DateTime dateTime;

  EventModel({
    required this.id,
    required this.ownerId,
    required this.category,
    required this.title,
    required this.description,
    required this.dateTime,

  });
  EventModel.fromJson(Map<String, dynamic> json, BuildContext context)
    : this(
        id: json["id"],
        ownerId: json["ownerId"],
        category: CategoryModel.categoryWithAll(
          context,
        ).firstWhere((category) => category.id == json["categoryId"]),
        title: json["title"],
        description: json["description"],
        dateTime: json["dateTime"].toDate(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ownerId": ownerId,
    "categoryId": category.id,
    "title": title,
    "description": description,
    "dateTime": dateTime,
  };
}
