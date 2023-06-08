import 'package:app/constant/role.dart';
import 'package:app/model/finddoctormodel.dart';
import 'package:app/model/usermodel.dart';
import 'package:app/model/workinghours.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FindDoctorController extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<FindDoctorModel> _list = [];
  List<FindDoctorModel> get list => _list;

  FindDoctorModel? _selectedModel;
  FindDoctorModel? get selectedModel => _selectedModel;
  void setSelectedModel(FindDoctorModel model) {
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
        List<WorkingHours> dlist = [];
        for (var j in hours.docs) {
          dlist.add(WorkingHours.fromJson(j.data(), j.id));
          dlist.sort(
            (a, b) => (a.day).compareTo(b.day),
          );
        }
        _list.add(
            FindDoctorModel.fromJson(details.data()!, i.data(), i.id, dlist));
      }

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<FindDoctorModel> getSpecificDokter(UserModel data) async {
    final List<WorkingHours> emptylist = [];
    final hours = await FirebaseFirestore.instance
        .collection('jam-kerja')
        .where('dokterId', isEqualTo: data.id)
        .get();

    for (var i in hours.docs) {
      emptylist.add(WorkingHours.fromJson(i.data(), i.id));
    }

    final detail = await FirebaseFirestore.instance
        .collection('dokter-details')
        .doc(data.dokterDetailsId)
        .get();

    return FindDoctorModel(
        nama: data.nama,
        imageUrl: data.downloadUrl,
        dokterId: data.id,
        lokasi: data.alamat,
        hoursList: emptylist,
        deskripsi: detail['deskripsi'],
        harga: detail['harga']);
  }
}
