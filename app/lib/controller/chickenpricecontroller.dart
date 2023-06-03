import 'dart:convert';

import 'package:app/model/chickenpricemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ChickenPriceController extends ChangeNotifier {
  List<ChickenPriceModel> _list = [];
  List<ChickenPriceModel> get list => _list;

  String _currentId = '';
  String get currentId => _currentId;

  Future<void> fetchData() async {
    _list = [];
    // try {
    //   final results = await http.get(Uri.parse(
    //       "https://www.bi.go.id/hargapangan/WebSite/TabelHarga/GetGridDataDaerah?price_type_id=4&comcat_id=com_7&province_id=16&regency_id=&market_id=&tipe_laporan=1&start_date=2023-05-26&end_date=2023-06-03&_=1685802638809"));
    //   final decodedBody = jsonDecode(results.body);
    //   print(decodedBody);
    //   for (var i in decodedBody['data'][1].entries) {
    //     if (i.key != "no" && i.key != 'name' && i.key != 'level') {
    //       _list.add(
    //         ChickenPriceModel(
    //           price: int.parse(i.value),
    //           date: DateFormat('dd/MM/yyyy').parse(i.key),
    //         ),
    //       );
    //     }
    //   }
    //   _list.reversed;
    // } catch (error) {
    //   print(error);
    // }

    final result =
        await FirebaseFirestore.instance.collection('chicken_price').get();
    for (var i in result.docs) {
      list.add(ChickenPriceModel.fromJson(i.data()));
    }

    _list.sort((a, b) => (a.date).compareTo(b.date));
    _currentId = result.docs[0].id;
  }

  String getText() {
    int index = _list.length - 1;
    String precentage = ((_list[index].price - _list[index - 1].price) /
            _list[index].price *
            100)
        .toStringAsFixed(1);
    // print(_list[index].date);
    if (_list[index].price > _list[index - 1].price) {
      return "+$precentage% daripada kemarin";
    } else if (_list[index].price < _list[index - 1].price) {
      return "-$precentage% daripada kemarin";
    } else {
      return "Sama dengan kemarin";
    }
  }
}
