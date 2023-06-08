import 'dart:io';

import 'package:app/constant/appformat.dart';
import 'package:app/constant/requeststatus.dart';
import 'package:app/model/consultationrequestmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CUsulanKonsultasi extends ChangeNotifier {
  List<ConsultationRequestModel> _list = [];
  List<ConsultationRequestModel> get list => _list;
  List<ConsultationRequestModel> get acceptedList => _list
      .where((element) => element.status == RequestStatus.disetujui)
      .toList();

  List<ConsultationRequestModel> get doneList => _list
      .where((element) =>
          element.status == RequestStatus.selesai ||
          element.status == RequestStatus.ditolak)
      .toList();
  List<ConsultationRequestModel> get progressList => _list
      .where((element) =>
          element.status != RequestStatus.ditolak &&
          element.status != RequestStatus.selesai)
      .toList();
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  String _isSelected = '';
  String get isSelected => _isSelected;

  void selectRequest(String requestId) {
    _isSelected = requestId;
    notifyListeners();
  }

  Future<void> fetchData(String peternakanId) async {
    try {
      _list = [];
      final result = await FirebaseFirestore.instance
          .collection('usulan_konsultasi')
          .where('peternakanId', isEqualTo: peternakanId)
          .get();
      for (var i in result.docs) {
        final mappedData = ConsultationRequestModel.fromJson(i.data(), i.id);
        _list.add(mappedData);
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void addData(
    String judul,
    String deskripsi,
    String peternakanId,
    String pengelolaId,
    File? photo,
    String musimId,
  ) async {
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
      'status': 'menunggu',
      'pengelolaId': pengelolaId,
      'downloadUrl': downloadUrl,
      'tanggal': date,
      'musimId': musimId,
    }).then((value) => _list.add(
          ConsultationRequestModel(
            usulanKonsultasiId: value.id,
            peternakanId: peternakanId,
            pengelolaId: pengelolaId,
            deskripsi: deskripsi,
            judul: judul,
            downloadUrl: downloadUrl,
            status: 'menunggu',
            tanggal: date,
            musimId: musimId,
          ),
        ));
    notifyListeners();
  }

  void deleteData(String id) {
    _list.removeWhere((element) => element.usulanKonsultasiId == id);
    FirebaseFirestore.instance.collection('usulan_konsultasi').doc(id).delete();
    notifyListeners();
  }

  void changeStatus(String newStatus, String id) async {
    try {
      final selectedIndex =
          list.indexWhere((element) => element.usulanKonsultasiId == id);
      _list[selectedIndex].status = newStatus;
      await FirebaseFirestore.instance
          .collection('usulan_konsultasi')
          .doc(id)
          .update({'status': newStatus});
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
