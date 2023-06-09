import 'package:app/model/m_harga_pasar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CHargaPasar extends ChangeNotifier {
  List<MHargaPasar> _list = [];
  List<MHargaPasar> get list => _list;

  String _currentId = '';
  String get currentId => _currentId;

  Future<void> fetchData() async {
    _list = [];
    final result =
        await FirebaseFirestore.instance.collection('chicken_price').get();
    for (var i in result.docs) {
      list.add(MHargaPasar.fromJson(i.data()));
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
    if (_list[index].price > _list[index - 1].price) {
      return "+$precentage% daripada kemarin";
    } else if (_list[index].price < _list[index - 1].price) {
      return "-$precentage% daripada kemarin";
    } else {
      return "Sama dengan kemarin";
    }
  }
}
