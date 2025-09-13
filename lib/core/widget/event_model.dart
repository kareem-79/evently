import 'package:evently/model/category_model.dart';
import 'package:flutter/material.dart';

class EventModel{
  CategoryModel categoryModel;
  String title;
  String description;
  DateTime dateTime;
  TimeOfDay timeOfDay;

  EventModel({required this.categoryModel, required this.title, required this.description, required this.dateTime,
    required this.timeOfDay});

}