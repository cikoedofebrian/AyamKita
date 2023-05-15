import 'package:app/constant/requeststatus.dart';
import 'package:app/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:app/model/consultationmodel.dart';

class ConsultationController extends ChangeNotifier {
  List<ConsultationModel> _list = [];
  List<ConsultationModel> get list => _list;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _currentSelectedChat = '';
  String get currentSelectedChat => _currentSelectedChat;
  void setSelectedChat(String id) {
    _currentSelectedChat = id;
  }

  UserModel? _selectedPerson;
  UserModel? get selectedPerson => _selectedPerson;

  void setChat(UserModel model) {
    _selectedPerson = model;
  }

  Future<void> fetchDataForPemilik(String peternakanId) async {
    try {
      _list = [];
      final result = await FirebaseFirestore.instance
          .collection('konsultasi')
          .where('peternakanId', isEqualTo: peternakanId)
          .get();
      for (var i in result.docs) {
        _list.add(ConsultationModel.fromJson(i.data(), i.id));
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchDataForDokter() async {
    try {
      _list = [];
      final result = await FirebaseFirestore.instance
          .collection('konsultasi')
          .where('dokterId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      for (var i in result.docs) {
        _list.add(ConsultationModel.fromJson(i.data(), i.id));
      }
    } catch (error) {
      print(error);
    }
  }

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
    await FirebaseFirestore.instance
        .collection('usulan_konsultasi')
        .doc(usulanKonsultasiId)
        .update({'status': RequestStatus.berlangsung});

    _isLoading = false;
    notifyListeners();
  }

  Future<void> sendNewChat(String text) async {
    // final timestamp = FieldValue.serverTimestamp();
    await FirebaseFirestore.instance.collection('chat').add({
      'timestamp': FieldValue.serverTimestamp(),
      'konsultasiId': currentSelectedChat,
      'sender': FirebaseAuth.instance.currentUser!.uid,
      'pesan': text,
    });
  }
}
