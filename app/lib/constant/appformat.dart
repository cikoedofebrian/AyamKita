import 'package:intl/intl.dart';

class AppFormat {
  static String date(String stringDate) {
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('d MMM yyyy', 'id_ID').format(dateTime);
  }

  static String dDate(String stringDate) {
    final dateTime = DateFormat("dd-MM-yyy").parse(stringDate);
    return DateFormat('d MMMM yyyy', 'id_ID').format(dateTime);
  }

  static String dateFromDateTime(DateTime dateTime) {
    return DateFormat("d MMMM yyyy", 'id_ID').format(dateTime);
  }

  static String fDate(String stringDate) {
    final dateTime = DateFormat("dd-MM-yyy").parse(stringDate);
    return DateFormat('d MMMM yyyy', 'id_ID').format(dateTime);
  }

  static String currency(int number) {
    return NumberFormat.currency(
      decimalDigits: 2,
      locale: 'id_ID',
      symbol: 'Rp ',
    ).format(number);
  }

  static DateTime currentDate(String stringDate) {
    final date = DateTime.now();
    final first = DateFormat("HH:mm").parse(stringDate);
    final parsedFirst =
        DateTime(date.year, date.month, date.day, first.hour, first.minute);
    return parsedFirst;
  }

  static String feedDate(String stringDate, int index) {
    final date = AppFormat.currentDate(stringDate);
    final deadline = date.add(const Duration(hours: 1));
    final formattedDate = DateFormat("HH:mm").format(date);
    final formattedDeadline = DateFormat("HH:mm").format(deadline);
    final daytime = index == 0 ? "Pagi" : "Sore";
    return "$daytime, $formattedDate - $formattedDeadline";
  }
}
