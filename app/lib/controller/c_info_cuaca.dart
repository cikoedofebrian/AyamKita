import 'dart:convert';
import 'package:app/constant/api.dart';
import 'package:app/model/m_info_cuaca.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CInfoCuaca extends ChangeNotifier {
  final List<MInfoCuaca> _list = [];
  List<MInfoCuaca> getInfoCuaca() {
    return _list;
  }

  String _cityName = '';
  String get cityName => _cityName;
  Future<void> fetchData() async {
    try {
      final url = Uri.parse(Api.url);
      final result = await http.get(url);
      final parsedJSON = jsonDecode(result.body);
      _cityName = parsedJSON['city']['name'];
      for (var i in parsedJSON['list']) {
        _list.add(MInfoCuaca.fromJson(i));
      }
    } catch (error) {
      rethrow;
    }
  }
}
