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
}
