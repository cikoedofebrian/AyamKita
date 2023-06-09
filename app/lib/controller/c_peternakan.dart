import 'package:app/constant/app_format.dart';
import 'package:app/constant/role.dart';
import 'package:app/model/m_peternakan.dart';
import 'package:app/model/m_akun.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CPeternakan extends ChangeNotifier {
  MPeternakan? _farmData;
  MPeternakan getDataProfile() {
    return _farmData!;
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<String> simpanRegisterPeternakan(String nama, String alamat, int luas,
      String semenjak, String pagi, String sore) async {
    try {
      final onFirestore =
          await FirebaseFirestore.instance.collection('peternakan').add({
        'nama': nama,
        'luas': luas,
        'alamat': alamat,
        'semenjak': semenjak,
      });
      await FirebaseFirestore.instance.collection('skema_jadwal').add({
        'peternakanId': onFirestore.id,
        'pagi': pagi,
        'sore': sore,
        'tanggal_dibuat': AppFormat.intDateFromDateTime(DateTime.now())
      });
      return onFirestore.id;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<void> fetchFarmData(String peternakanId) async {
    try {
      _isLoading = true;
      final data = await FirebaseFirestore.instance
          .collection('peternakan')
          .doc(peternakanId)
          .get();
      if (data.data() != null) {
        _farmData = MPeternakan.fromJson(data.data()!, peternakanId);
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<List<MAkun>> seePengelola() async {
    List<MAkun> list = [];
    final data = await FirebaseFirestore.instance
        .collection('akun')
        .where('peternakanId', isEqualTo: _farmData!.peternakanId)
        .where('role', isEqualTo: UserRole.pengelola)
        .get();
    for (var i in data.docs) {
      list.add(MAkun.fromJson(i.data(), i.id));
    }
    return list;
  }

  Future<MAkun> getDataProfilePemilik(String peternakanId) async {
    final data = await FirebaseFirestore.instance
        .collection('akun')
        .where('peternakanId', isEqualTo: peternakanId)
        .where('role', isEqualTo: UserRole.pemilik)
        .limit(1)
        .get();

    return MAkun.fromJson(
      data.docs[0].data(),
      data.docs[0].id,
    );
  }

  Future<void> updateProfilePeternakn(
      String nama, String alamat, int luas, String downloadUrl) async {
    FirebaseFirestore.instance
        .collection('peternakan')
        .doc(_farmData!.peternakanId)
        .update({
      'nama': nama,
      'alamat': alamat,
      'luas': luas,
      'downloadUrl': downloadUrl
    });
    _farmData!.nama = nama;
    _farmData!.alamat = alamat;
    _farmData!.downloadUrl = downloadUrl;
    _farmData!.luas = luas;
    notifyListeners();
  }
}
