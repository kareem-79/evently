import 'package:intl/intl.dart';

extension DateTimeExtendion on DateTime{
  String get viewMonth{
    DateFormat format=DateFormat("MMM");
    return format.format(this);
  }
  String get toFormatDate{
    DateFormat pattern=DateFormat("dd/MM/yyyy");
    return pattern.format(this);
  }
  String get toViewData{
    DateFormat pattern=DateFormat("dd MMMM yyyy");
    return pattern.format(this);
  }
  String get toFormatTime{
    DateFormat pattern=DateFormat("jm");
    return pattern.format(this);
  }
}