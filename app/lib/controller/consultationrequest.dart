import 'dart:io';

import 'package:app/constant/appformat.dart';
import 'package:app/model/consultationrequestmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ConsultationRequestController extends ChangeNotifier {
  List<ConsultationRequestModel> _list = [];
  List<ConsultationRequestModel> get list => _list;

  Future<void> fetchData(String peternakanId) async {
    _list = [];
    final result = await FirebaseFirestore.instance
        .collection('usulan_konsultasi')
        .where('peternakanId', isEqualTo: peternakanId)
        .get();
    for (var i in result.docs) {
      final mappedData = ConsultationRequestModel.fromJson(i.data(), i.id);
      _list.add(mappedData);
    }
  }

  void addData(String judul, String deskripsi, String peternakanId,
      String pengelolaId, File? photo) async {
    String downloadUrl = '';
    if (photo != null) {
      final result = await FirebaseStorage.instance
          .ref(
              'usulan_konsultasi/${peternakanId + DateTime.now().toIso8601String()}')
          .putFile(photo);
      downloadUrl = await result.ref.getDownloadURL();
    }
    final date = AppFormat.intDateFromDateTime(DateTime.now());
    await FirebaseFirestore.instance.collection('usulan_konsultasi').add({
      'peternakanId': peternakanId,
      'judul': judul,
      'deskripsi': deskripsi,
      'status': 'sent',
      'pengelolaId': pengelolaId,
      'downloadUrl': downloadUrl,
      'tanggal': date
    }).then((value) => _list.add(ConsultationRequestModel(
        usulanKonsultasiId: value.id,
        peternakanId: peternakanId,
        pengelolaId: pengelolaId,
        deskripsi: deskripsi,
        judul: judul,
        downloadUrl: downloadUrl,
        status: 'menunggu',
        tanggal: date)));
    notifyListeners();
  }

  void deleteData(String id) {
    _list.removeWhere((element) => element.usulanKonsultasiId == id);
    FirebaseFirestore.instance.collection('usulan_konsultasi').doc(id).delete();
    notifyListeners();
  }
}
