import 'package:app/constant/appformat.dart';
import 'package:app/constant/role.dart';
import 'package:app/model/farmmodel.dart';
import 'package:app/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PeternakanController extends ChangeNotifier {
  PeternakanModel? farmData;

  Future<void> fetchFarmData(String peternakanId) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection('peternakan')
          .doc(peternakanId)
          .get();
      if (data.data() != null) {
        farmData = PeternakanModel.fromJson(data.data()!, peternakanId);
      }
    } catch (error) {
      print(error);
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
      list.add(UserModel.fromJson(i.data()));
    }
    return list;
  }

  Future<UserModel> seePemilik() async {
    final data = await FirebaseFirestore.instance
        .collection('akun')
        .where('peternakanId', isEqualTo: farmData!.peternakanId)
        .where('role', isEqualTo: UserRole.pemilik)
        .limit(1)
        .get();

    return UserModel.fromJson(
      data.docs[0].data(),
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
