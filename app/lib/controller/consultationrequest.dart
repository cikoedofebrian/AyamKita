import 'package:app/model/consultationrequestmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConsultationRequestController extends ChangeNotifier {
  List<ConsultationRequestModel> _list = [];
  List<ConsultationRequestModel> get list => _list;

  Future<void> fetchData(String peternakanId) async {
    _list = [];
    final result = await FirebaseFirestore.instance
        .collection('usulanKonsultasi')
        .where('peternakanId', isEqualTo: peternakanId)
        .get();
    for (var i in result.docs) {
      final mappedData = ConsultationRequestModel.fromJson(i.data());
      _list.add(mappedData);
    }
  }
}
