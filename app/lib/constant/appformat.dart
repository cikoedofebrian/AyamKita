import 'package:intl/intl.dart';

class AppFormat {
  static String date(String stringDate) {
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('d MMM yyyy', 'id_ID').format(dateTime);
  }

  static String currency(int number) {
    return NumberFormat.currency(
      decimalDigits: 2,
      locale: 'id_ID',
      symbol: 'Rp ',
    ).format(number);
  }
}
