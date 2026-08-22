import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final NumberFormat _formatter = NumberFormat('#,###', 'uz_UZ');

  static String format(num amount) {
    final formatted = _formatter.format(amount).replaceAll(',', ' ');
    return '$formatted so‘m';
  }
}