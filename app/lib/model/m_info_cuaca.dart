import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:intl/intl.dart';

class MInfoCuaca {
  MInfoCuaca({
    required this.dt,
    required this.main,
    required this.weather,
  });

  final int dt;
  final double main;
  final int weather;

  String getDateTime() {
    return DateFormat('HH:mm').format(
        DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true).toLocal());
  }

  String getDays() {
    return DateFormat('EEEE', 'id_ID').format(
        DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true).toLocal());
  }

  IconData getConditionIcon() {
    if (weather >= 200 && weather <= 232) {
      // return "cloud.bolt";
      return Icons.thunderstorm;
    } else if (weather >= 300 && weather <= 321) {
      // return "cloud.drizzle";
      return MaterialSymbols.rainy;
    } else if (weather >= 500 && weather <= 531) {
      // return "cloud.rain";
      return MaterialSymbols.rainy;
    } else if (weather >= 600 && weather <= 622) {
      // return "cloud.snow";
      return Icons.cloudy_snowing;
    } else if (weather >= 701 && weather <= 781) {
      return Icons.foggy;
      // return "cloud.fog";
    } else if (weather == 800) {
      return Icons.sunny;
      // return "sun.max";
    } else if (weather >= 801 && weather <= 804) {
      // return "cloud.bolt";
      return Icons.wb_cloudy_outlined;
    } else {
      return Icons.wb_cloudy_outlined;
    }
  }

  String getConditionName() {
    if (weather >= 200 && weather <= 232) {
      return "Hujan Petir";
    } else if (weather >= 300 && weather <= 321) {
      return "Gerimis";
    } else if (weather >= 500 && weather <= 531) {
      return "Hujan";
    } else if (weather >= 600 && weather <= 622) {
      return "Bersalju";
    } else if (weather >= 701 && weather <= 781) {
      return "Berkabut";
    } else if (weather == 800) {
      return "Cerah";
    } else if (weather >= 801 && weather <= 804) {
      return "Berawan";
    } else {
      return "Berawan";
    }
  }

  factory MInfoCuaca.fromJson(Map<String, dynamic> json) => MInfoCuaca(
      dt: json["dt"],
      main: json['main']['temp'].toDouble(),
      weather: json['weather'][0]['id']);
}
