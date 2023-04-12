import 'package:app/model/chickenpricemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChickenPriceController extends ChangeNotifier {
  List<ChickenPriceModel> _list = [];
  List<ChickenPriceModel> get list => _list;

  String _currentId = '';
  String get currentId => _currentId;

  Future<void> fetchData() async {
    _list = [];

    final result = await FirebaseFirestore.instance
        .collection('chicken_price')
        .orderBy('date', descending: true)
        .limit(7)
        .get();
    for (var i in result.docs) {
      list.add(ChickenPriceModel.fromJson(i.data()));
    }
    _currentId = result.docs[0].id;
    notifyListeners();
  }
}
