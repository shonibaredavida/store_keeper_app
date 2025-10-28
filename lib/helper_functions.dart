import 'package:intl/intl.dart';

String formatCustomDateTime(DateTime dateTime) {
  // Get the day with suffix (st, nd, rd, th)
  String day = dateTime.day.toString();
  String suffix = getDaySuffix(dateTime.day);

  // Format the rest of the date
  String month = DateFormat('MMM').format(dateTime); // June
  String year = DateFormat('y').format(dateTime); // 2025

  return '$day$suffix $month $year';
}

String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) return 'th';
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}
