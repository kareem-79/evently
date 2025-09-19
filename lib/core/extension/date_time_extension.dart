import 'package:intl/intl.dart';

extension DateTimeExti on DateTime{
  String get viewMonth{
    DateFormat format=DateFormat("MMM");
    return format.format(this);
  }
}