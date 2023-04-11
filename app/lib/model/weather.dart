// class Weather {
//   Weather({
//     required this.dt,
//     required this.main,
//     required this.weather,
//   });

//   final int dt;
//   final Main main;
//   final List<WeatherElement> weather;

//   factory Weather.fromJson(Map<String, dynamic> json) => Weather(
//         dt: json["dt"],
//         main: Main.fromJson(json["main"]),
//         weather: List<WeatherElement>.from(
//             json["weather"].map((x) => WeatherElement.fromJson(x))),
//       );
// }

import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:intl/intl.dart';

class Weather {
  Weather({
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
      return Icons.wb_cloudy;
    } else {
      return Icons.wb_cloudy;
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

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
      dt: json["dt"],
      main: json['main']['temp'],
      weather: json['weather'][0]['id']);
}

// class Main {
//   Main({
//     required this.temp,
//   });

//   final double temp;

//   factory Main.fromJson(Map<String, dynamic> json) => Main(
//         temp: json["temp"]?.toDouble(),
//       );
// }

// class WeatherElement {
//   WeatherElement({
//     required this.id,
//   });

//   final int id;

//   factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
//         id: json["id"],
//       );
// }
