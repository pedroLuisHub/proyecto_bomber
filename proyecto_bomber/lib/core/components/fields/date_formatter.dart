import 'package:intl/intl.dart';

class DateFormatter {
  static const String defaultLocale = 'es_PY';
  // Formato: jueves, 15 noviembre 2024 13:30
  static String formatFullDate(DateTime? date) {
    if (date == null) return '';
    final dateFormatter = DateFormat('EEEE, d MMMM yyyy HH:mm', defaultLocale);
    return dateFormatter.format(date);
  }

  // Formato: 15/11/2024
  static String formatShortDate(DateTime date) {
    final dateFormatter = DateFormat('dd/MM/yyyy', defaultLocale);
    return dateFormatter.format(date);
  }

  // Formato: 15/11/2024 14:30
  static String formatDateTime(DateTime? date) {
    if (date == null) return '';

    final dateFormatter = DateFormat('dd/MM/yyyy HH:mm', defaultLocale);
    return dateFormatter.format(date);
  }

  // Formato: 14:30
  static String formatTime(DateTime date) {
    final dateFormatter = DateFormat('HH:mm', defaultLocale);
    return dateFormatter.format(date);
  }

  // Formato: 15 nov 2024
  static String formatMediumDate(DateTime date) {
    final dateFormatter = DateFormat('d MMM yyyy', defaultLocale);
    return dateFormatter.format(date);
  }

  // Formato: nov 15, 2024
  static String formatShortDateEnglish(DateTime date) {
    final dateFormatter = DateFormat('MMM d, yyyy', 'en_US');
    return dateFormatter.format(date);
  }

  // Formato: 15/11/2024
  static String formatDateWithLocal(String? date) {
    if (date == null || date.isEmpty) return '';

    final dateFormatter = DateFormat('dd/MM/yyyy', defaultLocale);
    final dtFormatedd = dateFormatter.format(DateTime.parse(date));
    return dtFormatedd;
  }

  // Formato: 15/11/2024 14:30
  static String formatDateAndTimeWithLocal(String? date) {
    if (date == null || date.isEmpty) return '';

    final dateFormatter = DateFormat('dd/MM/yyyy HH:mm', defaultLocale);
    return dateFormatter.format(DateTime.parse(date));
  }

  // Formato: noviembre.. diciembre
  static String getMonthString(String date) {
    final dateTime = DateFormat("yyyy-MM-dd").parse(date, true);
    final dateFormatter = DateFormat('MMMM', defaultLocale);
    final dtFormatedd = dateFormatter.format(dateTime);
    return dtFormatedd.toUpperCase();
  }

  // Formato "2024-11-20"
  static String formatDateSql(String? date) {
    if (date == null || date.isEmpty) return '';

    final dateTime = DateTime.parse(date);
    final dateFormatter = DateFormat('yyyy-MM-dd', defaultLocale);
    final dtFormatedd = dateFormatter.format(dateTime.toLocal());
    return dtFormatedd;
  }

  
}
