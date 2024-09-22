import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toFormattedString() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}

extension StringToDateTime on String {
  DateTime toDateTime() {
    return DateFormat('dd/MM/yyyy').parse(this);
  }

  String toDashDate() {
    // Parse the string in 'dd/MM/yyyy' format
    DateTime date = DateFormat('dd/MM/yyyy').parse(this);
    // Format the date to 'yyyy-MM-dd'
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String toSlashDate() {
    final RegExp dateFormatRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    // Check if the string matches the 'yyyy-MM-dd' format
    if (dateFormatRegex.hasMatch(this)) {
      try {
        DateTime date = DateFormat('yyyy-MM-dd').parse(this);
        return DateFormat('dd/MM/yyyy').format(date);
      } catch (e) {
        return this;
      }
    } else {
      return this;
    }
  }
}
