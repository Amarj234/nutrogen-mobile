import 'package:intl/intl.dart';

extension Format on String {
  String get priceFormat {
    try {
      return NumberFormat.currency(
        decimalDigits: 0,
        locale: 'en_US',
        symbol: '\$',
      ).format(double.parse(this));
    } catch (e) {
      return this;
    }
  }
}

extension WhereExt<T> on List<T> {
  /// The first element satisfying [test], or `null` if there are none.
  List<T>? whereOrEmpty(bool Function(T element) test) {
    final list = <T>[];
    for (final element in this) {
      if (test(element)) {
        list.add(element);
      }
    }
    return list;
  }
}
