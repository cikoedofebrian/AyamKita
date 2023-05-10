import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConsultationController extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> fetchDataForPemilik() async {}
  Future<void> fetchDataForDokter() async {}

  void createNewConsultation(
    String method,
    String peternakanId,
    String dokterId,
    String usulanKonsultasiId,
    int price,
  ) async {
    _isLoading = true;
    notifyListeners();
    await FirebaseFirestore.instance.collection('konsultasi').add({
      'metode_pembayaran': method,
      'peternakanId': peternakanId,
      'usulanKonsultasiId': usulanKonsultasiId,
      'dokterId': dokterId,
      'harga': price,
      'date': DateFormat('dd-MM-yyyy').format(DateTime.now()),
      'status': 'berlangsung',
      'hasilId': '',
    });

    _isLoading = false;
    notifyListeners();
  }
}
