import 'dart:convert';
import 'package:app/constant/api.dart';
import 'package:app/model/weather.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherController extends ChangeNotifier {
  final List<Weather> _list = [];
  List<Weather> get list => _list;

  String _cityName = '';
  String get cityName => _cityName;
  Future<void> fetchData() async {
    try {
      final url = Uri.parse(Api.url);
      final result = await http.get(url);
      final parsedJSON = jsonDecode(result.body);
      _cityName = parsedJSON['city']['name'];
      for (var i in parsedJSON['list']) {
        _list.add(Weather.fromJson(i));
      }
      print(_list.length);
    } catch (error) {
      print(error);
    }
  }
}
