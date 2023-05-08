import 'package:app/model/workinghours.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WorkingHoursControllers extends ChangeNotifier {
  List<WorkingHours> _list = [];
  List<WorkingHours> get list => _list;

  Future<void> fetchData(String dokterId) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('jam-kerja')
          .where('dokterId', isEqualTo: dokterId)
          .get();

      for (var i in result.docs) {
        _list.add(WorkingHours.fromJson(i.data()));
      }
    } catch (error) {
      print(error);
    }
  }
}
