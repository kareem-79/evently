import 'package:evently/model/category_model.dart';
import 'package:flutter/material.dart';


class EventModel {
  String id;
  String ownerId;
  CategoryModel category;
  String title;
  String description;
  DateTime dateTime;
  double latitude;
  double longitude;
  String city;
  String country;


  EventModel({
    required this.id,
    required this.ownerId,
    required this.category,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.country,
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
        latitude: json["latitude"],
        longitude: json["longitude"],
        city: json["city"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ownerId": ownerId,
    "categoryId": category.id,
    "title": title,
    "description": description,
    "dateTime": dateTime,
    "latitude": latitude,
    "longitude": longitude,
    "city": city,
    "country": country,
  };
}
