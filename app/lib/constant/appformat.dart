import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AppFormat {
  static String getWeekName(int index) {
    List<String> week = const [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu'
    ];
    return week[index];
  }

  static int getCurrentDayIndex() {
    DateTime now = DateTime.now();
    int weekdayIndex = now.weekday;
    int dayIndex = weekdayIndex - 1;
    return dayIndex;
  }

  static bool isBetween(TimeOfDay startTime, TimeOfDay endTime) {
    TimeOfDay currentTime = TimeOfDay.now();
    DateTime startDate = DateTime(2023, 1, 1, startTime.hour, startTime.minute);
    DateTime endDate = DateTime(2023, 1, 1, endTime.hour, endTime.minute);
    DateTime currentTimeDate =
        DateTime(2023, 1, 1, currentTime.hour, currentTime.minute);
    return currentTimeDate.isAfter(startDate) &&
        currentTimeDate.isBefore(endDate);
  }

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

  static String intDateFromDateTime(DateTime dateTime) {
    return DateFormat("dd-MM-yyyy", 'id_ID').format(dateTime);
  }

  static String fDate(String stringDate) {
    final dateTime = DateFormat("dd-MM-yyy").parse(stringDate);
    return DateFormat('d MMMM yyyy', 'id_ID').format(dateTime);
  }

  static DateTime stringtoDateTime(String dateTime) {
    return DateFormat('dd-MM-yyyy').parse(dateTime);
  }

  static String dayTimeToString(TimeOfDay time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
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

  static TimeOfDay timeOfDayParser(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    TimeOfDay timeOfDay = TimeOfDay(hour: hour, minute: minute);
    return timeOfDay;
  }
}
