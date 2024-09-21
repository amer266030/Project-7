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
    // Parse the string in 'dd/MM/yyyy' format
    DateTime date = DateFormat('yyyy-MM-dd').parse(this);
    // Format the date to 'yyyy-MM-dd'
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
