import 'package:app/constant/appformat.dart';
import 'package:app/helper/customexception.dart';
import 'package:app/model/feedmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedController extends ChangeNotifier {
  String date = '';
  String schedule = '';

  List<FeedModel> _list = [];
  List<FeedModel> get list => _list;

  Future<void> fetchData(String peternakanId) async {
    try {
      _list = [];

      final date = DateFormat('dd-MM-yyyy').format(DateTime.now());
      final chickens = await FirebaseFirestore.instance
          .collection('data_pakan')
          .where('tanggal', isEqualTo: date)
          .where('peternakanId', isEqualTo: peternakanId)
          .get();
      // print(chickens.docs[0].data());
      if (chickens.docs.isEmpty) {
        final latestSchema = await FirebaseFirestore.instance
            .collection('skema_jadwal')
            .where('peternakanId', isEqualTo: peternakanId)
            .orderBy('tanggal_dibuat', descending: true)
            .limit(1)
            .get();
        await FirebaseFirestore.instance.collection('data_pakan').add({
          "tanggal": date,
          "pagi": false,
          "sore": false,
          "skemaJadwalId": latestSchema.docs.first.id,
          'peternakanId': peternakanId,
        });
      }
      final rawData = await FirebaseFirestore.instance
          .collection('data_pakan')
          .where('peternakanId', isEqualTo: peternakanId)
          .get();

      var schemaId = '';
      Map<String, dynamic> schemaData = {};
      for (var i in rawData.docs) {
        if (i['skemaJadwalId'] != schemaId) {
          schemaId = i['skemaJadwalId'];
          final data = await FirebaseFirestore.instance
              .collection('skema_jadwal')
              .doc(schemaId)
              .get();
          schemaData = data.data()!;
        }
        _list.add(FeedModel.fromJson(i.data(), schemaData, i.id));
      }
      _list.sort((a, b) => b.tanggal.compareTo(a.tanggal));
    } catch (error) {
      rethrow;
    }
  }

  void fillAbsence() {
    final date = DateTime.now();
    final parsedFirst = AppFormat.currentDate(_list[0].jamPagi);
    final parsedSecond = AppFormat.currentDate(_list[0].jamSore);

    if (date.isAfter(parsedFirst) &&
        date.isBefore(
          parsedFirst.add(
            const Duration(hours: 1),
          ),
        )) {
      if (_list[0].pagi == true) {
        throw CustomException("Presensi pakan pertama telah terisi!");
      }
      absenceTrigger("pagi");
    } else if (date.isAfter(parsedSecond) &&
        date.isBefore(
          parsedSecond.add(
            const Duration(hours: 1),
          ),
        )) {
      if (_list[0].sore == true) {
        throw CustomException("Presensi pakan kedua telah terisi!");
      }
      absenceTrigger("sore");
    } else {
      throw CustomException("Kamu sudah melewatkan jam presensi pakan!");
    }
  }

  void absenceTrigger(String jam) async {
    if (jam == "pagi") {
      _list[0].pagi = true;
    } else {
      _list[0].sore = true;
    }

    await FirebaseFirestore.instance
        .collection('data_pakan')
        .doc(_list[0].dataPakanId)
        .update({jam: true});

    notifyListeners();
  }
}
