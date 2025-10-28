import 'package:intl/intl.dart';

String AppCustomDateTime(DateTime dateTime) {
  String day = dateTime.day.toString();
  String suffix = daySuffix(dateTime.day);

  // Format the rest of the date
  String month = DateFormat('MMM').format(dateTime); // June
  String year = DateFormat('y').format(dateTime); // 2025

  return '$day$suffix $month $year';
}

String daySuffix(int day) {
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

String formatCompactCurrency(num value, {String symbol = 'N'}) {
  if (value >= 1000000000) {
    return '$symbol${(value / 1000000000).toStringAsPrecision(4)}B';
  } else if (value >= 10000000) {
    return '$symbol${(value / 1000000).toStringAsPrecision(4)}M';
  } else {
    final formatter = NumberFormat.currency(locale: 'en_NG', symbol: symbol);
    return formatter.format(value);
  }
}

String appCompactQuantity(num value) {
  if (value < 99999) {
    return NumberFormat('#,##0').format(value);
  } else if (value > 99999 && value < 999999) {
    return '>100K';
  } else {
    return '>1M';
  }
}

String capitalizeFirst(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}
