import 'package:app/helper/customexception.dart';
import 'package:app/model/dataharianmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyController extends ChangeNotifier {
  final List<DataHarianModel> _list = [];

  List<DataHarianModel> get list => _list;

  Future<void> fetchData(String farmId) async {
    final result = await FirebaseFirestore.instance
        .collection('data_harian')
        .where('farmId', isEqualTo: farmId)
        .get();
    for (var i in result.docs) {
      final newData = DataHarianModel.fromJson(i.data());
      _list.add(newData);
    }
    notifyListeners();
  }

  Future<DataHarianModel?> checkDate(DateTime date) async {
    for (var i in _list) {
      if (DateTime(i.tanggal.year, i.tanggal.month, i.tanggal.day) ==
          DateTime(date.year, date.month, date.day)) {
        return i;
      }
    }
    return null;
  }

  Future<void> addData(
      DateTime tanggal,
      int umur,
      int datang,
      int pakai,
      int std,
      int stok,
      int kematian,
      int panen,
      String obat,
      String farmId) async {
    try {
      FirebaseFirestore.instance.collection('data_harian').add({
        'tanggal': DateFormat('dd-MM-yyyy').format(tanggal),
        'umur': umur,
        'datang': datang,
        'pakai': pakai,
        'std': std,
        'stok': stok,
        'kematian': kematian,
        'panen': panen,
        'farmId': farmId,
      });
      _list.add(DataHarianModel(
          tanggal: tanggal,
          umur: umur,
          datang: datang,
          pakai: pakai,
          std: std,
          stok: stok,
          kematian: kematian,
          panen: panen,
          obat: obat));
      notifyListeners();
    } catch (error) {
      if (error is FirebaseException) {
        throw CustomException(error.message!);
      }
    }
  }
}
