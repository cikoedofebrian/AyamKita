import 'package:app/constant/role.dart';
import 'package:app/model/m_doctor.dart';
import 'package:app/model/m_akun.dart';
import 'package:app/model/m_jam_kerja.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CDoctor extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<MDokter> _list = [];
  List<MDokter> getDataCariDokter() {
    return _list;
  }

  MDokter getDataProfile(int index) {
    return _list[index];
  }

  MDokter? _selectedModel;
  MDokter? get selectedModel => _selectedModel;
  void setSelectedModel(MDokter model) {
    _selectedModel = model;
  }

  Future<void> refreshData() async {
    _isLoading = true;
    _list = [];
    fetchData();
    notifyListeners();
  }

  Future<void> fetchData() async {
    try {
      _list.clear();
      final allDokter = await FirebaseFirestore.instance
          .collection('akun')
          .where('role', isEqualTo: UserRole.dokter)
          .get();

      for (var i in allDokter.docs) {
        final details = await FirebaseFirestore.instance
            .collection('dokter-details')
            .doc(i.data()['dokterDetailsId'])
            .get();
        final hours = await FirebaseFirestore.instance
            .collection('jam-kerja')
            .where('dokterId', isEqualTo: i.id)
            .get();
        List<MJamKerja> dlist = [];
        for (var j in hours.docs) {
          dlist.add(MJamKerja.fromJson(j.data(), j.id));
          dlist.sort(
            (a, b) => (a.day).compareTo(b.day),
          );
        }
        _list.add(MDokter.fromJson(details.data()!, i.data(), i.id, dlist));
      }

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<MDokter> getDataProfileDokter(MAkun data) async {
    final List<MJamKerja> emptylist = [];
    final hours = await FirebaseFirestore.instance
        .collection('jam-kerja')
        .where('dokterId', isEqualTo: data.id)
        .get();

    for (var i in hours.docs) {
      emptylist.add(MJamKerja.fromJson(i.data(), i.id));
    }

    final detail = await FirebaseFirestore.instance
        .collection('dokter-details')
        .doc(data.dokterDetailsId)
        .get();

    return MDokter(
        nama: data.nama,
        imageUrl: data.downloadUrl,
        dokterId: data.id,
        lokasi: data.alamat,
        hoursList: emptylist,
        deskripsi: detail['deskripsi'],
        harga: detail['harga']);
  }
}
