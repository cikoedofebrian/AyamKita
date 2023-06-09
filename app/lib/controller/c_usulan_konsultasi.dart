import 'dart:io';

import 'package:app/constant/app_format.dart';
import 'package:app/constant/request_status.dart';
import 'package:app/model/m_usulan_konsultasi.dart';
import 'package:app/model/m_periode.dart';
import 'package:app/widget/custom_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class CUsulanKonsultasi extends ChangeNotifier {
  List<MUsulanKonsultasi> _list = [];

  bool isOnProgress = false;
  void changesProgress(bool value) {
    isOnProgress = value;
    notifyListeners();
  }

  List<MUsulanKonsultasi> getDataUsulan() {
    if (isOnProgress) {
      return _list
          .where((element) => element.status == RequestStatus.selesai)
          .toList();
    } else {
      return _list
          .where((element) => element.status == RequestStatus.berlangsung)
          .toList();
    }
  }

  Future<bool> validasiForm(
      GlobalKey<FormState> formKey, BuildContext context) async {
    bool isConfirm = false;
    if (formKey.currentState!.validate()) {
      await NDialog(
        title: const Text(
          'Konfirmasi',
          textAlign: TextAlign.center,
        ),
        content: const Text("Yakin ingin menyimpan data?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              isConfirm = true;
              Navigator.of(context).pop();
            },
            child: const Text('Iya'),
          )
        ],
      ).show(context);
    } else {
      customDialog(context, 'Gagal!', 'Data tidak boleh kosong');
    }
    return isConfirm;
  }

  List<MUsulanKonsultasi> get acceptedList => _list
      .where((element) => element.status == RequestStatus.disetujui)
      .toList();

  List<MUsulanKonsultasi> get doneList => _list
      .where((element) =>
          element.status == RequestStatus.selesai ||
          element.status == RequestStatus.ditolak)
      .toList();
  List<MUsulanKonsultasi> get progressList => _list
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
        final mappedData = MUsulanKonsultasi.fromJson(i.data(), i.id);
        _list.add(mappedData);
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void simpanUsulan(
    String judul,
    String deskripsi,
    String peternakanId,
    String pengelolaId,
    File? photo,
    List<MPeriode> musim,
    int indexActive,
    BuildContext context,
  ) async {
    if (indexActive == -1) {
      // ignore: use_build_context_synchronously
      customDialog(context, 'Ajuan gagal!', 'Tidak ada periode yang aktif');
      return;
    }
    try {
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
        'musimId': musim[indexActive].musimId,
      }).then(
        (value) => _list.add(
          MUsulanKonsultasi(
            usulanKonsultasiId: value.id,
            peternakanId: peternakanId,
            pengelolaId: pengelolaId,
            deskripsi: deskripsi,
            judul: judul,
            downloadUrl: downloadUrl,
            status: 'menunggu',
            tanggal: date,
            musimId: musim[indexActive].musimId,
          ),
        ),
      );

      // ignore: use_build_context_synchronously
      customDialog(context, 'Ajuan berhasil!',
              'Usulan konsultasi telah berhasil dibuat')
          .then((value) => Navigator.pop(context));
      notifyListeners();
    } catch (err) {
      customDialog(context, 'Gagal', 'Konsultasi gagal dibuat!');
    }
  }

  void hapusUsulan(String id) {
    _list.removeWhere((element) => element.usulanKonsultasiId == id);
    FirebaseFirestore.instance.collection('usulan_konsultasi').doc(id).delete();
    notifyListeners();
  }

  void changeStatus(String newStatus, String id) async {
    try {
      final selectedIndex =
          _list.indexWhere((element) => element.usulanKonsultasiId == id);
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
