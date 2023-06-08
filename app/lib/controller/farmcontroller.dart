import 'package:app/constant/role.dart';
import 'package:app/model/farmmodel.dart';
import 'package:app/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PeternakanController extends ChangeNotifier {
  PeternakanModel? farmData;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> fetchFarmData(String peternakanId) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection('peternakan')
          .doc(peternakanId)
          .get();
      if (data.data() != null) {
        farmData = PeternakanModel.fromJson(data.data()!, peternakanId);
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<List<UserModel>> seePengelola() async {
    List<UserModel> list = [];
    final data = await FirebaseFirestore.instance
        .collection('akun')
        .where('peternakanId', isEqualTo: farmData!.peternakanId)
        .where('role', isEqualTo: UserRole.pengelola)
        .get();
    for (var i in data.docs) {
      list.add(UserModel.fromJson(i.data(), i.id));
    }
    return list;
  }

  Future<UserModel> seePemilik(String peternakanId) async {
    final data = await FirebaseFirestore.instance
        .collection('akun')
        .where('peternakanId', isEqualTo: peternakanId)
        .where('role', isEqualTo: UserRole.pemilik)
        .limit(1)
        .get();

    return UserModel.fromJson(
      data.docs[0].data(),
      data.docs[0].id,
    );
  }

  Future<void> updateData(
      String nama, String alamat, int luas, String downloadUrl) async {
    FirebaseFirestore.instance
        .collection('peternakan')
        .doc(farmData!.peternakanId)
        .update({
      'nama': nama,
      'alamat': alamat,
      'luas': luas,
      'downloadUrl': downloadUrl
    });
    farmData!.nama = nama;
    farmData!.alamat = alamat;
    farmData!.downloadUrl = downloadUrl;
    farmData!.luas = luas;
    notifyListeners();
  }
}
