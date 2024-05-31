import 'package:intl/intl.dart';

extension DateTimeUtils on String? {
  DateTime? get yyyyMMDDtoDatetime =>
      this == null ? DateTime.now() : DateFormat('yyyy-MM-dd').parse('$this');
}

extension StringUtils on DateTime? {
  String? get dateTimeToyyyyMMDD =>
      DateFormat('yyyy-MM-dd').format(this ?? DateTime.now());
}
